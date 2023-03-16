unit Canctrans;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel, ExtCtrls,
  SQLGrid, SqlSis;

type
  TFCanctransacao = class(TForm)
    PRel: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    baplicar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    EdTransacao: TSQLEd;
    PIns: TSQLPanelGrid;
    Texto: TMemo;
    EdDatavazia: TSQLEd;
    EdUsua_codigo: TSQLEd;
    EdUsua_nome: TSQLEd;
    EdMotivo: TSQLEd;
    EdDataMov: TSQLEd;
    brelauditoriafiscal: TSQLBtn;
    procedure FormActivate(Sender: TObject);
    procedure baplicarClick(Sender: TObject);
    procedure EdTransacaoExitEdit(Sender: TObject);
    procedure EdTransacaoValidae(Sender: TObject);
    procedure brelauditoriafiscalClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(xtransacao:string='';xmotivo:string='');
  end;

var
  FCanctransacao: TFCanctransacao;
  Tiposmov,UnidadedaTransacao,Transacaoaux,wtransacao:string;
  campo:TDicionario;

implementation

uses Geral, SqlFun, SqlExpr , plano, RelGerenciais;

{$R *.dfm}

procedure TFCanctransacao.Execute(xtransacao:string='';xmotivo:string='');
///////////////////////////////////////////////////////////////////////////////
begin

  if FCanctransacao=nil then FGeral.CreateForm(TFCanctransacao, FCanctransacao);
  wtransacao:=xtransacao;
  FCanctransacao.Show;
  if trim(wtransacao)<>'' then begin
    EdTransacao.text:=wtransacao;
    EdTransacao.Next;
    Edusua_codigo.text:=inttostr(Global.Usuario.Codigo);
    Edusua_codigo.Next;
    Edmotivo.text:=xmotivo;
    Edmotivo.next;
    Close;
  end;

end;

procedure TFCanctransacao.FormActivate(Sender: TObject);
begin
  EdTransacao.text:=Global.UltimaTransacao;
  Texto.clear;
  EdTransacao.setfocus;
end;

procedure TFCanctransacao.baplicarClick(Sender: TObject);
//////////////////////////////////////////////////////////////////////////////////
var QMovestoque,QQtdeEstoque,QCancela,QRemessas,QDevolucoes,QMovfin,QPendencia,QtdeEstoqueGrade,QPendencia1,
    QPendencia2,QMovObra,QPedido,Qb:TSqlquery;
    Mov,Remessas,TipoVenda,podecancelar,Registralivro,TipoEntradaAbate,TipoSaidaAbate,
    statuscancfiscal,transacao,transacaocontax,romaneios:string;
    ListaRemessas,ListaRem,ListaPedidos:TStringlist;
    Cliente,sqlclientem,sqlcliented,rp,sqldatacont,codrepr,sqlcor,sqltamanho,sqlcopa,xsqlcor,xsqltamanho,xsqlcopa,
    xListaPedidos,nrodoc:string;
    p,tipo_codigo,xcodcor,xcodtamanho,xcodcopa,numerodoc,pedido,codigomov,embalagem,qualparcela,
    Plan_contasai,x:integer;

    vlrbxparcial,vlrjuros,vlrdescontos,vlrparcela,qtdeenviada:currency;
    datavcto,datacont:TDatetime;

begin
//////////////////////////////////////////////////////

  if not EdTransacao.ValidEdiAll(FCanctransacao,99) then exit;
  podecancelar:='N';
  TipoEntradaAbate:='EA';
  TipoSaidaAbate:='SA';
  statuscancfiscal:='X';

  if confirma('Confirma o cancelamento da transa��o '+EdTransacao.Text+' ?') then begin

// 09.09.05
//    if copy(EdTransacao.text,1,6)='989999' then begin
// 22.09.05
//    if copy(EdTransacao.text,1,1)='9' then begin
// 15.02.06
    if copy(EdTransacao.text,1,1)='I' then begin
      Avisoerro('Transa��o de Importa��o n�o pode ser cancelada');
      exit;
    end;
    Sistema.BeginTransaction('Cancelando transa��o');
//    QMovestoque:=sqltoquery(FGeral.BuscaTransacao(EdTransacao.text,'movestoque','move_transacao'));
    QMovestoque:=sqltoquery('select * from movestoque'+
                            ' left join estoque on ( esto_codigo=move_esto_codigo )'+ // 29.02.12
                            ' inner join movesto on ( moes_transacao=move_transacao and moes_status=move_status )'+
                            ' where move_transacao='+EdTransacao.assql+
                            ' and '+FGeral.Getin('move_status','N;D;E','C')+
//                            ' order by move_status,move_numerodoc,move_tipomov');
// 14.06.06
                            ' order by move_status,move_numerodoc,move_tipomov');
//    if QMovestoque.fieldbyname('move_status').asstring='C' then begin
//    if not QMovestoque.eof then begin
//      EdTransacao.invalid('Transa��o inexistente ou j� est� cancelada');
//      Sistema.EndTransaction('');
//      exit;
//    end;
    Cliente:='';
    pedido:=0;
    codigomov:=0;
    UnidadedaTransacao:='';
    transacaocontax:='';
    Romaneios:='';
// aqui em 20.11.20
    Registralivro:='N';

    if not QMovestoque.eof then begin

// 27.05.10 - Novicarnes
      if (Global.UsaNfe='S') then begin

         if ( DAtetoano(QMovestoque.fieldbyname('moes_dtnfeauto').asdatetime,true)>=1900 )
             and  // 23.01.23 - para os 'caso' vida nova de autorizada no sac e denegada na receita
             ( Ansipos('DENEGA',Uppercase(QMovestoque.fieldbyname('moes_retornonfe').AsString))  = 0 )
           then begin

           if DAtetoano(QMovestoque.fieldbyname('moes_dtnfecanc').asdatetime,true)>1900 then begin
//             if Confirma('Confirma que a NFe com retorno '+QMovestoque.fieldbyname('moes_retornonfe').asstring+' foi DENEGADA pela Sefa') then
// 06.08.10 - novi - vava - feito 'direito' em 05.10.10
             if Confirma('NFe com retorno '+QMovestoque.fieldbyname('moes_retornonfe').asstring+' :Informe <S> se N�O foi DENEGADA ou <N> caso FOI DENEGADA pela Sefa') then begin

                statuscancfiscal:='X';
// 20.11.20
                Registralivro := 'S';


             end else
               statuscancfiscal:='Y';
           end;
// 09.09.19
         end else if Ansipos('DENEGA',Uppercase(QMovestoque.fieldbyname('moes_retornonfe').AsString))  > 0 then

               statuscancfiscal:='Y';

      end;
// 20.06.16
      transacaocontax:=QMovestoque.fieldbyname('moes_transacerto').asstring;
      Romaneios:=QMovestoque.fieldbyname('moes_remessas').asstring;

      if (QMovestoque.fieldbyname('move_status').asstring='D') then begin
        while not QMovestoque.eof do begin
          if (QMovestoque.fieldbyname('move_tipomov').asstring=Global.CodVendaConsig ) then begin
            podecancelar:='S';
            break;
          end;
          QMovestoque.next;
        end;
        if podecancelar<>'S' then begin
          EdTransacao.invalid('Transa��o est� marcada como consigna��o encerrada ( status=D )');
          Sistema.EndTransaction('');
          exit;
        end else
          QMovestoque.first;
      end;
      if (QMovestoque.fieldbyname('move_status').asstring='E') then begin
  //    and (QMovestoque.fieldbyname('move_tipomov').asstring<>Global.CodVendaProntaEntrega )
        EdTransacao.invalid('Transa��o est� marcada como encerrada ( status=E )');
        Sistema.EndTransaction('');
        exit;
      end;

      cliente:=QMovestoque.fieldbyname('move_tipo_codigo').asstring;
      codrepr:=QMovestoque.fieldbyname('move_repr_codigo').asstring;
      Remessas:=QMovestoque.fieldbyname('move_remessas').asstring;
      TipoVenda:=QMovestoque.fieldbyname('move_tipomov').asstring;
// 26.09.07
      Numerodoc:=QMovestoque.fieldbyname('move_numerodoc').asinteger;
// 17.05.06
      if TipoVenda=Global.CodVendaProntaEntregaFecha then
//        Remessas:=QMovestoque.fieldbyname('moes_remessas').asstring;
// 31.05.06
//        Remessas:=QMovestoque.fieldbyname('move_remessas').asstring;
// 28.08.06 - senao nao retorna direito pois no fechamento na VF so fica marcado os produtos com saldo>0
        Remessas:=QMovestoque.fieldbyname('moes_remessas').asstring;

// 08.03.05 - caso estiver posicionado em outra unidade nao retornava as remessas
      UnidadedaTransacao:=QMovestoque.fieldbyname('move_unid_codigo').asstring;
      Registralivro:='N';
// 01.07.08
      pedido:=QMovestoque.fieldbyname('moes_pedido').asinteger;
      codigomov:=QMovestoque.fieldbyname('moes_comv_codigo').asinteger;
  ///    if pos(QMOvestoque.fieldbyname('move_tipomov').asstring,Global.TiposMovMovEstoque) > 0 then begin

      Sistema.beginprocess('Ajustando saldos em estoque');
      ListaRem:=tstringlist.create;
      while not QMovestoque.eof do begin

          if (QMovestoque.fieldbyname('moes_datacont').asdatetime>1)
             and (QMovestoque.fieldbyname('moes_natf_codigo').asstring<>'') and
            ( pos(QMovestoque.fieldbyname('move_tipomov').asstring,global.TiposSaida+';'+
                 Global.CodDevolucaoSerie5+';'+Global.CodCompraProdutor+';'+
                 Global.CodDevolucaoIgualVenda+';'+ // 24.09.19
                 Global.CodDrawBackEnt) > 0 ) // 24.11.20
            and
            (  QMovestoque.fieldbyname('move_tipomov').asstring<>Global.CodBaixaMatSai ) and
            (  QMovestoque.fieldbyname('move_tipomov').asstring<>Global.CodRequisicaoalmox ) and
            (  QMovestoque.fieldbyname('move_tipomov').asstring<>Global.CodContrato )   // 01.12.07
            then Registralivro:='S';

          if QQtdeEstoque=nil then
               QQtdeEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(QMOvestoque.fieldbyname('move_esto_codigo').asstring)+
            ' and esqt_unid_codigo='+Stringtosql(QMOvestoque.fieldbyname('move_unid_codigo').asstring))
          else begin
            QQtdeEstoque.Close;
            QQtdeEstoque.sql.text:='select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(QMOvestoque.fieldbyname('move_esto_codigo').asstring)+
            ' and esqt_unid_codigo='+Stringtosql(QMOvestoque.fieldbyname('move_unid_codigo').asstring);
            QQtdeEstoque.open;
          end;
////////////////  21.08.06
          xcodcor:=QMOvestoque.fieldbyname('move_core_codigo').asinteger;
          xcodtamanho:=QMOvestoque.fieldbyname('move_tama_codigo').asinteger;
          xcodcopa:=QMOvestoque.fieldbyname('move_copa_codigo').asinteger;
          xsqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
          xsqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
          xsqlcopa:=' and ( esgr_copa_codigo=0 or esgr_copa_codigo is null )';
          if (xcodcor>0) and (xcodtamanho>0) and (xcodcopa>0) then begin
              xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
              xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
              xsqlcopa:=' and esgr_copa_codigo='+inttostr(xcodcopa);
          end else if (xcodcor>0) and (xcodtamanho>0) then begin
              xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
              xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
          end else if (xcodcor>0) then begin
              xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
          end else if (xcodtamanho>0) then begin
              xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
          end;
          if QtdeEstoqueGrade=nil then
            QtdeEstoqueGrade:=sqltoquery('select * from Estgrades where esgr_status=''N'' and esgr_esto_codigo='+StringtoSql(QMOvestoque.fieldbyname('move_esto_codigo').asstring)+
            ' and esgr_unid_codigo='+Stringtosql(QMOvestoque.fieldbyname('move_unid_codigo').asstring)+
            xsqlcor+xsqltamanho+xsqlcopa )
//            ' and esgr_core_codigo='+Stringtosql(QMOvestoque.fieldbyname('move_core_codigo').asinteger)+
//            ' and esgr_tama_codigo='+Stringtosql(QMOvestoque.fieldbyname('move_tama_codigo').asinteger)+
//            ' and ( esgr_copa_codigo='+Stringtosql(QMOvestoque.fieldbyname('move_copa_codigo').asinteger)+' or esgr_copa_codigo is null )' )
          else begin
            QtdeEstoqueGrade.Close;
            QtdeEstoqueGrade.sql.text:='select * from Estgrades where esgr_status=''N'' and esgr_esto_codigo='+StringtoSql(QMOvestoque.fieldbyname('move_esto_codigo').asstring)+
            ' and esgr_unid_codigo='+Stringtosql(QMOvestoque.fieldbyname('move_unid_codigo').asstring)+
            xsqlcor+xsqltamanho+xsqlcopa ;
//            ' and esgr_core_codigo='+Stringtosql(QMOvestoque.fieldbyname('move_core_codigo').asstring)+
//            ' and esgr_tama_codigo='+Stringtosql(QMOvestoque.fieldbyname('move_tama_codigo').asstring)+
//            ' and ( esgr_copa_codigo='+Stringtosql(QMOvestoque.fieldbyname('move_copa_codigo').asstring)+' or esgr_copa_codigo is null )' ;
            QtdeEstoqueGrade.open;
          end;
////////////////
          if pos(QMOvestoque.fieldbyname('move_tipomov').asstring,Global.TiposMovMovEntrada) > 0 then
            Mov:='S'
          else
            Mov:='E';
// 29.02.12
          embalagem:=QMOvestoque.fieldbyname('esto_embalagem').asinteger;
          if embalagem=0 then embalagem:=1;
          FGeral.MovimentaQtdeEstoque(QMOvestoque.fieldbyname('move_esto_codigo').asstring,
                QMOvestoque.fieldbyname('move_unid_codigo').asstring,Mov,QMOvestoque.fieldbyname('move_tipomov').asstring,
                QMOvestoque.fieldbyname('move_qtde').ascurrency*embalagem,QQtdeEstoque );
// 21.08.06
          FGeral.MovimentaQtdeEstoqueGrade(QMOvestoque.fieldbyname('move_esto_codigo').asstring,
                QMOvestoque.fieldbyname('move_unid_codigo').asstring,Mov,QMOvestoque.fieldbyname('move_tipomov').asstring,
                QMOvestoque.fieldbyname('move_core_codigo').asinteger,QMOvestoque.fieldbyname('move_tama_codigo').asinteger,
                QMOvestoque.fieldbyname('move_copa_codigo').asinteger,
                QMOvestoque.fieldbyname('move_qtde').ascurrency,QtdeEstoqueGrade );


// fazer aqui o 'recalculo do custo medio' caso cancele transacao de nf de entrada q mexe no custo
//          if pos(QMovestoque.fieldbyname('move_tipomov').asstring,Global.CodVendaconsig+';'+Global.CodVendaProntaEntrega+';'+Global.CodVendaSerie4)>0 then begin
// 29.11.05
//          if pos(QMovestoque.fieldbyname('move_tipomov').asstring,Global.CodVendaconsig+';'+Global.CodVendaProntaEntrega+';'+Global.CodVendaSerie4+';'+Global.CodVendaProntaEntregaFecha+';'+Global.CodVendaREFinal)>0 then begin
// 17.05.06 - retirado a VF
          if pos(QMovestoque.fieldbyname('move_tipomov').asstring,Global.CodVendaconsig+';'+Global.CodVendaProntaEntrega+';'+Global.CodVendaSerie4+';'+Global.CodVendaREFinal)>0 then begin
            Remessas:=QMovestoque.fieldbyname('move_remessas').asstring;
            TipoVenda:=QMovestoque.fieldbyname('move_tipomov').asstring;
          end;
/////////// - 05.04.06 - 'desbaixa' o pedido de venda usado na nf de transferencia
          if QMovestoque.fieldbyname('move_tipomov').asstring=Global.CodTransfSaida then begin
             if (QMOvestoque.fieldbyname('move_core_codigo').asinteger>0) and
                (QMOvestoque.fieldbyname('move_tama_codigo').asinteger>0) then begin
                Sistema.Edit('movpeddet');
                Sistema.Setfield('mpdd_nftrans',0);
                Sistema.Setfield('mpdd_datanftrans',EdDatavazia.asdate );
                Sistema.Setfield('mpdd_transacaonftrans','');
                Sistema.post('mpdd_nftrans='+QMovestoque.fieldbyname('move_numerodoc').asstring+
                             ' and mpdd_status=''N'' and mpdd_datanftrans='+Datetosql(QMovestoque.fieldbyname('moes_dataemissao').asdatetime)+
                             ' and mpdd_transacaonftrans='+stringtosql(QMovestoque.fieldbyname('move_transacao').asstring)+
                             ' and mpdd_situacao=''E''' );
             end;
          end;
////////////
/////////// - 12.06.06 - 'desbaixa' o pedido de compra usado na nf de compra  - mov � usado para retornar a qtde no est.
          if (QMovestoque.fieldbyname('moes_pedido').asinteger>0 ) and (Mov='S') then begin
                if QMOvestoque.fieldbyname('move_core_codigo').asinteger>0 then
                  sqlcor:=' and moco_core_codigo='+QMOvestoque.fieldbyname('move_core_codigo').asstring
                else
                  sqlcor:=' and moco_core_codigo=0';
                if QMOvestoque.fieldbyname('move_tama_codigo').asinteger>0 then
                  sqltamanho:=' and moco_tama_codigo='+QMOvestoque.fieldbyname('move_tama_codigo').asstring
                else
                  sqltamanho:=' and moco_tama_codigo=0';
                if QMOvestoque.fieldbyname('move_copa_codigo').asinteger>0 then
                  sqlcopa:=' and moco_copa_codigo='+QMOvestoque.fieldbyname('move_copa_codigo').asstring
                else
                  sqlcopa:=' and moco_copa_codigo=0';
                Sistema.Edit('movcompras');
                Sistema.Setfield('moco_qtderecebida',0);
                Sistema.post('moco_numerodoc='+QMovestoque.fieldbyname('moes_pedido').asstring+
                             ' and moco_status=''N'' and moco_tipo_codigo='+QMOvestoque.fieldbyname('move_tipo_codigo').asstring+
                             ' and moco_esto_codigo='+stringtosql(QMOvestoque.fieldbyname('move_esto_codigo').asstring)+
                             sqlcor+
                             sqltamanho+
                             sqlcopa );

          end;
//
/////////// - 18.09.09- 'desbaixa' o pedido de venda usado na nf de venda  - mov � usado para retornar a qtde no est.   // 19.03.20
          if (QMovestoque.fieldbyname('moes_pedido').asinteger>0 ) and (Mov='E')  and  ( length(trim(QMovestoque.fieldbyname('move_remessas').asstring))=7 )
             then begin

             xListaPedidos:=strzero(QMovestoque.fieldbyname('moes_pedido').asinteger,7);
             ListaPedidos:=TStringList.create;
             strtolista(ListaPedidos,xListaPedidos,';',true);
             for x:=0 to ListaPedidos.Count-1 do begin

                if QMOvestoque.fieldbyname('move_core_codigo').asinteger>0 then
                  sqlcor:=' and mpdd_core_codigo='+QMOvestoque.fieldbyname('move_core_codigo').asstring
                else
                  sqlcor:=' and ( mpdd_core_codigo=0 or mpdd_core_codigo is null )';
                if QMOvestoque.fieldbyname('move_tama_codigo').asinteger>0 then
                  sqltamanho:=' and mpdd_tama_codigo='+QMOvestoque.fieldbyname('move_tama_codigo').asstring
                else
                  sqltamanho:=' and ( mpdd_tama_codigo=0 or mpdd_tama_codigo is null )';
                if QMOvestoque.fieldbyname('move_copa_codigo').asinteger>0 then
                  sqlcopa:=' and mpdd_copa_codigo='+QMOvestoque.fieldbyname('move_copa_codigo').asstring
                else
                  sqlcopa:=' and ( mpdd_copa_codigo=0 or mpdd_copa_codigo is null )';
// 19.03.20 - retirado - devereda - 'retornos'
{
// 22.04.13 - Abra cuiaba
                if Global.Usuario.OutrosAcessos[0335] then begin
//                  QPedido:=sqltoquery('select mpdd_qtdeenviada from movpeddet where mpdd_numerodoc='+QMovestoque.fieldbyname('moes_pedido').asstring+
// 12.12.15
                  QPedido:=sqltoquery('select mpdd_qtdeenviada from movpeddet where mpdd_numerodoc='+ListaPedidos[x]+
                               ' and mpdd_status=''N'' and mpdd_tipo_codigo='+QMOvestoque.fieldbyname('move_tipo_codigo').asstring+
                               ' and mpdd_esto_codigo='+stringtosql(QMOvestoque.fieldbyname('move_esto_codigo').asstring)+
                               sqlcor+
                               sqltamanho+
                               sqlcopa );

                  if not QPedido.eof then
                    qtdeenviada:= QPedido.fieldbyname('mpdd_qtdeenviada').ascurrency
                  else qtdeenviada:=0;

                  Sistema.Edit('movpeddet');
                  Sistema.setfield('mpdd_qtdeenviada',qtdeenviada-QMovestoque.fieldbyname('move_qtde').ascurrency);
//                  Sistema.post('mpdd_numerodoc='+QMovestoque.fieldbyname('moes_pedido').asstring+
                  Sistema.post('mpdd_numerodoc='+inttostr(strtoint(ListaPedidos[x]))+
                               ' and mpdd_status=''N'' and mpdd_tipo_codigo='+QMOvestoque.fieldbyname('move_tipo_codigo').asstring+
                               ' and mpdd_esto_codigo='+stringtosql(QMOvestoque.fieldbyname('move_esto_codigo').asstring)+
                               sqlcor+
                               sqltamanho+
                               sqlcopa );
                  FGeral.FechaQuery(QPedido);

                end else begin
}
                  Sistema.Edit('movpeddet');
                  Sistema.setfield('mpdd_situacao','P');
                  Sistema.setfield('mpdd_qtdeenviada',0);
                  Sistema.setfield('mpdd_dataenviada',EdDAtavazia.AsDate);
                  Sistema.setfield('mpdd_nfvenda',0);
                  Sistema.setfield('mpdd_datanfvenda',EdDAtavazia.AsDate);
//                  Sistema.post('mpdd_numerodoc='+QMovestoque.fieldbyname('moes_pedido').asstring+
                  Sistema.post('mpdd_numerodoc='+inttostr(strtoint(ListaPedidos[x]))+
                               ' and mpdd_status=''N'' and mpdd_tipo_codigo='+QMOvestoque.fieldbyname('move_tipo_codigo').asstring+
                               ' and mpdd_esto_codigo='+stringtosql(QMOvestoque.fieldbyname('move_esto_codigo').asstring)+
                               sqlcor+
                               sqltamanho+
                               sqlcopa );
////////                end;  // 19.03.20

             end; // lista pedidos
             ListaPedidos.free;

          end;
/////////////////////////////////////////
/////////// - 13.10.09- 'desbaixa' a producao informada no movobrasdet ref. entrada de produtos acabados
          if (QMovestoque.fieldbyname('move_tipomov').asstring=Global.CodEntradaAcabado )  then begin

                if QMOvestoque.fieldbyname('move_core_codigo').asinteger>0 then
                  sqlcor:=' and movo_core_codigo='+QMOvestoque.fieldbyname('move_core_codigo').asstring
                else
                  sqlcor:=' and ( movo_core_codigo=0 or movo_core_codigo is null )';
                if QMOvestoque.fieldbyname('move_tama_codigo').asinteger>0 then
                  sqltamanho:=' and movo_tama_codigo='+QMOvestoque.fieldbyname('move_tama_codigo').asstring
                else
                  sqltamanho:=' and ( movo_tama_codigo=0 or movo_tama_codigo is null )';
//              if QMOvestoque.fieldbyname('move_copa_codigo').asinteger>0 then
//                sqlcopa:=' and mpdd_copa_codigo='+QMOvestoque.fieldbyname('move_copa_codigo').asstring
//              else
//                sqlcopa:=' and ( mpdd_copa_codigo=0 or mpdd_copa_codigo is null )';
                sqlcopa:='';
                QMovObra:=sqltoquery('select movo_qtdeprod from movobrasdet'+
                             ' where movo_numerodoc='+QMovestoque.fieldbyname('moes_numerodoc').asstring+
                             ' and movo_status=''N'' and movo_tipo_codigo='+QMOvestoque.fieldbyname('move_tipo_codigo').asstring+
                             ' and movo_esto_codigo='+stringtosql(QMOvestoque.fieldbyname('move_esto_codigo').asstring)+
                             ' and movo_unid_codigo='+stringtosql(QMOvestoque.fieldbyname('move_unid_codigo').asstring)+
                             ' and movo_tipomov='+Stringtosql(Global.CodItemObra)+
                             ' and movo_operacao='+stringtosql(QMOvestoque.fieldbyname('move_devolucoes').asstring)+
                             sqlcor+
                             sqltamanho+
                             sqlcopa );
                if not QMovobra.eof then begin
                  Sistema.Edit('movobrasdet');
                  Sistema.setfield('movo_qtdeprod',QMovObra.fieldbyname('movo_qtdeprod').ascurrency-QMovestoque.fieldbyname('move_qtde').ascurrency);
                  Sistema.post('movo_numerodoc='+QMovestoque.fieldbyname('moes_numerodoc').asstring+
                               ' and movo_status=''N'' and movo_tipo_codigo='+QMOvestoque.fieldbyname('move_tipo_codigo').asstring+
                               ' and movo_esto_codigo='+stringtosql(QMOvestoque.fieldbyname('move_esto_codigo').asstring)+
                               ' and movo_unid_codigo='+stringtosql(QMOvestoque.fieldbyname('move_unid_codigo').asstring)+
                               ' and movo_tipomov='+Stringtosql(Global.CodItemObra)+
                               ' and movo_operacao='+stringtosql(QMOvestoque.fieldbyname('move_devolucoes').asstring)+
                               sqlcor+
                               sqltamanho+
                               sqlcopa );
               end;
               FGeral.FechaQuery(QMovObra);

          end;
/////////////////////////////////////////-13.10.09

////////////
// 11.10.07 - saida do estoque a entrada data pela 'decomposi��o' da nf de produtor
// creio q nao precisao pois na propria transacao ja retorna..
//          if (TipoVenda=Global.CodCompraProdutor)  and (Global.Topicos[1203]) then begin
//          end;


          QQtdeEstoque.Close;
          QtdeEstoqueGrade.Close;
          if ListaREm.indexof(remessas)=-1 then  // 29.11.05
            Listarem.add(remessas);
// 29.01.16
          if ( pos(QMovestoque.fieldbyname('move_tipomov').asstring,Global.TiposSaida)>0 )
// 19.03.20
//             and  ( QMovestoque.fieldbyname('moes_pedido').asinteger=0 )
            then
// 14.12.15
             xListaPedidos:=QMovestoque.fieldbyname('move_remessas').asstring;

          QMovestoque.Next;
      end;
      Sistema.endprocess('');

    end;  // qmovestoque.eof

// 14.12.15
    if trim(xListaPedidos)<>'' then begin
      ListaPedidos:=TStringList.create;
      strtolista(ListaPedidos,xListaPedidos,';',true);
// 19.03.20 - Devereda - para baixa aqui somente quando for mais de um pedido de uma vez...
//      if ListaPedidos.Count > 1 then begin

        for x:=0 to ListaPedidos.Count-1 do begin

          if (trim(ListaPedidos[x])<>'') and (trim(ListaPedidos[x])<>';') then begin // 01.03.16
            Sistema.Edit('movpeddet');
            Sistema.setfield('mpdd_situacao','P');
            Sistema.setfield('mpdd_qtdeenviada',0);
            Sistema.setfield('mpdd_dataenviada',EdDAtavazia.AsDate);
            Sistema.setfield('mpdd_nfvenda',0);
            Sistema.setfield('mpdd_datanfvenda',EdDAtavazia.AsDate);
            Sistema.post('mpdd_numerodoc='+inttostr(strtoint(ListaPedidos[x]))+
                         ' and mpdd_status=''N'''+
                         ' and mpdd_tipo_codigo='+(cliente)+
                         ' and mpdd_unid_codigo='+Stringtosql(Global.codigounidade));

            Sistema.Edit('movped');
            Sistema.setfield('mped_situacao','P');
            Sistema.setfield('mped_nfvenda',0);
            Sistema.setfield('mped_datanfvenda',EdDAtavazia.AsDate);
            Sistema.setfield('mped_transacaovenda','');
            Sistema.post('mped_numerodoc='+inttostr(strtoint(ListaPedidos[x]))+
                         ' and mped_status=''N'''+
                         ' and mped_tipo_codigo='+(cliente)+
                         ' and mped_unid_codigo='+Stringtosql(Global.codigounidade));
          end;
        end;

//      end;
    end;
/////////////////////////////////////
// 09.09.08
    if (pos(tipovenda,Global.TiposEntrada)>0) and (pedido>0) then begin
        Sistema.Edit('movcomp');
        Sistema.Setfield('mocm_datarecebido',texttodate(''));
        Sistema.post('mocm_numerodoc='+inttostr(pedido)+
                     ' and mocm_status=''N'''+
                     ' and mocm_tipo_codigo='+cliente );
    end;

    if QQtdeEstoque<>nil then begin
      QQtdeEstoque.Close;
      Freeandnil(QQtdeEstoque);
    end;
    if QtdeEstoqueGrade<>nil then begin
      QtdeEstoqueGrade.Close;
      Freeandnil(QtdeEstoqueGrade);
    end;

    QCancela:=sqltoquery(FGeral.BuscaTransacao(EdTransacao.text,'movbase','movb_transacao','movb_status','N'));
    if QCancela.eof then begin
//      Executesql('update movesto set moes_status=''C'' where moes_transacao='+EdTransacao.AsSql);
       Sistema.Edit('movesto');
       Sistema.Setfield('moes_status','C');
       Sistema.post('moes_transacao='+EdTransacao.Assql);
       Sistema.Edit('movestoque');
       Sistema.Setfield('move_status','C');
       Sistema.post('move_transacao='+EdTransacao.Assql);

    end else if Registralivro='S' then begin

      if confirma('Registrar o cancelamento da nota '+Qcancela.fieldbyname('movb_numerodoc').asstring+' no livro fiscal ?') then begin
        Sistema.Edit('movesto');
        Sistema.Setfield('moes_status',statuscancfiscal);
        Sistema.Setfield('moes_valortotal',0);
        Sistema.Setfield('moes_vlrtotal',0);
        Sistema.Setfield('moes_baseicms',0);
        Sistema.Setfield('moes_valoricms',0);
        Sistema.post('moes_transacao='+EdTransacao.Assql);

        Sistema.Edit('movestoque');
        Sistema.Setfield('move_status',statuscancfiscal);
/////        Sistema.Setfield('move_qtde',0); // 11.04.06 - somente caso precise 'descancelar' e ajustar o estoque...
        Sistema.Setfield('move_venda',0);
        Sistema.post('move_transacao='+EdTransacao.Assql);

        Sistema.Edit('movbase');
        Sistema.Setfield('movb_status',statuscancfiscal);
        Sistema.Setfield('movb_basecalculo',0);
        Sistema.Setfield('movb_imposto',0);
        Sistema.Setfield('movb_isentas',0);
        Sistema.Setfield('movb_outras',0);
        Sistema.post('movb_transacao='+EdTransacao.Assql);
      end else begin
//        Executesql('update movesto set moes_status=''C'' where moes_transacao='+EdTransacao.AsSql);
        Sistema.Edit('movesto');
        Sistema.Setfield('moes_status','C');
        Sistema.post('moes_transacao='+EdTransacao.Assql);
////11.06.08 - aqui
        Sistema.Edit('movbase');
        Sistema.Setfield('movb_status','C');
        Sistema.post('movb_transacao='+EdTransacao.Assql);
        Sistema.Edit('movestoque');
        Sistema.Setfield('move_status','C');
        Sistema.post('move_transacao='+EdTransacao.Assql);
/////////////
      end;
//      Executesql('update movbase set movb_status=''C'' where movb_transacao='+EdTransacao.AsSql);

//      Executesql('update movestoque set move_status=''C'' where move_transacao='+EdTransacao.AsSql);


    end else begin  // 06.05.05  - se for uma entrada

      Sistema.Edit('movesto');
      Sistema.Setfield('moes_status','C');
      Sistema.post('moes_transacao='+EdTransacao.Assql);
      Sistema.Edit('movestoque');
      Sistema.Setfield('move_status','C');
      Sistema.post('move_transacao='+EdTransacao.Assql);
// 03.05.06
      Sistema.Edit('movbase');
      Sistema.Setfield('movb_status','C');
      Sistema.post('movb_transacao='+EdTransacao.Assql);
///
    end; // cancelamento no livro fiscal

// qualquer merda q poe aqui q use o sistema.edit da pau na transacao.....
// vai saber porque acontece isto...--t
///////////////////////////////////////////////////////////////////////
// "desbaixa" a pendencia caso tiver sido baixada
{
    Sistema.Edit('Pendencias');
    Sistema.SetField('pend_status','N');
    Sistema.SetField('pend_mora',0);
    Sistema.SetField('pend_descontos',0);
    Sistema.SetField('pend_transbaixa','');
    Sistema.SetField('pend_contabaixa',0);
    Sistema.SetField('pend_databaixa',TextToDate(''));
    Sistema.SetField('pend_usubaixa',0);
    Sistema.Post('pend_status=''B'' and pend_transbaixa='+EdTransacao.AsSql);
}
// 26.07.04 - voltou a dar o erro podre de "erro na transa��o'...vamos ver o q d� com este commit aqui...
//            parece q funcionou....vamos ver o comportamento

    Sistema.Commit;

// 30.05.05
//////////////////////////////////
    QPendencia:=sqltoquery('select * from pendencias where pend_transbaixa='+EdTransacao.AsSql+' and '+FGeral.getin('pend_status','B','C') );
    vlrbxparcial:=0;vlrjuros:=0;vlrdescontos:=0;
    nrodoc:=''; datacont:=0;
    rp:='';vlrparcela:=0;
    Plan_contasai:=0;
    while not QPendencia.eof do begin
      nrodoc:=QPendencia.fieldbyname('pend_numerodcto').asString;
      datavcto:=QPendencia.fieldbyname('pend_datavcto').asdatetime;
      rp:=QPendencia.fieldbyname('pend_rp').asstring;
      tipo_codigo:=QPendencia.fieldbyname('pend_tipo_codigo').asinteger;
      datacont:=QPendencia.fieldbyname('pend_datacont').asdatetime;
// 11.06.10 - Abra -
      UnidadedaTransacao:=QPendencia.fieldbyname('pend_unid_codigo').asstring;
// 12.04.12 - Abra - paulo
      qualparcela:=QPendencia.fieldbyname('pend_parcela').asinteger;
// 06.09.13 - Metalforte
      vlrparcela:=QPendencia.fieldbyname('pend_valor').asinteger;
      Plan_contasai:=QPendencia.fieldbyname('pend_contabaixa').asinteger;
// aqui em 15.09.06
            if trim(nrodoc)<>'' then begin
        // 12.08.05
        //      if datacont>0 then
        // 26.09.05 - corrigido a cagada
              if datacont=0 then
                sqldatacont:=' and pend_datacont is null'
              else
                sqldatacont:=' and pend_datacont > '+DatetoSql( Global.DataMenorBanco );
              QPendencia1:=sqltoquery('select * from pendencias where pend_tipo_codigo='+inttostr(tipo_codigo)+
                         ' and pend_datavcto='+Datetosql(datavcto)+
                         ' and pend_rp='+stringtosql(rp)+
                         sqldatacont+
                         ' and pend_unid_codigo='+Stringtosql(UnidadedaTransacao)+
//                         ' and pend_numerodcto='+inttostr(nrodoc)+
// 01.10.12 - Banco 9.0 - SM
//                         ' and pend_numerodcto='+Stringtosql(inttostr(nrodoc))+
// 18.09.17
                         ' and pend_numerodcto='+Stringtosql(nrodoc)+
// 12.04.12
                         ' and pend_parcela='+inttostr(qualparcela)+
                         ' and '+FGeral.getin('pend_status','B;P','C') );
              vlrparcela:=0;
              while not QPendencia1.eof do begin
                if QPendencia1.fieldbyname('pend_status').asstring='B' then begin
                  vlrjuros:=vlrjuros+QPendencia1.fieldbyname('pend_mora').ascurrency;
                  vlrdescontos:=vlrdescontos+QPendencia1.fieldbyname('pend_descontos').ascurrency;
                  vlrparcela:=vlrparcela+QPendencia1.fieldbyname('pend_valor').ascurrency
                end else
                  vlrbxparcial:=vlrbxparcial+QPendencia1.fieldbyname('pend_valor').ascurrency;
                QPendencia1.next;
              end;
              if vlrparcela>0 then begin
                ExecuteSql('Update pendencias set pend_valor= '+Valortosql(vlrparcela+vlrbxparcial,2)+
                          ' where '+FGeral.getin('pend_status','B','C')+' and pend_transbaixa='+EdTransacao.AsSql+
//                          ' and pend_numerodcto='+inttostr(nrodoc)+  // 15.09.06 - baixa de bloquete de cobranca
//                          ' and pend_numerodcto='+Stringtosql(inttostr(nrodoc))+  // 01.10.12 - Banco 9.0 - SM
                          ' and pend_numerodcto='+Stringtosql(nrodoc)+  // 18.09.17
// 04.06.10 - cancelamento de baixa parcial com 'mesmo numero'
                          ' and pend_unid_codigo='+Stringtosql(UnidadedaTransacao)+
// 12.04.12
                          ' and pend_parcela='+inttostr(qualparcela)+
                          ' and pend_datavcto='+Datetosql(datavcto) );
              end;
              QPendencia1.close;
              Freeandnil(QPendencia1);
            end;
      QPendencia.Next;

    end; // transacao da baixa
// 06.09.13 - Metalforte - gera lan�amento de saida do caixa/bancos quando exclui uma transacao
//    de baixa de recebimentos
    if ( global.topicos[1286] ) and ( rp='R' ) then begin
       transacao:=FGeral.GetTransacao;
       Sistema.Insert('movfin');
       FGeral.GravaMovfin(Transacao,UnidadedaTransacao,'S','Estorno Baixa '+FGeral.GetNomeRazaoSocialEntidade(tipo_codigo,'C','N')+' '+nrodoc,Sistema.hoje,Sistema.hoje,
          Sistema.hoje,strtointdef(nrodoc,0),0,0,Plan_contasai,Vlrparcela,0,Global.CodLanCaixabancos,
          0,tipo_codigo,'C');

       Sistema.Post();
    end;
////////////
    QPendencia.close;
    Freeandnil(QPendencia);
// 24.05.07 - cancelamento de baixa parcial com a nova forma usando status K
/////////////////////////////////////////////////////////////////////////////
    QPendencia:=sqltoquery('select * from pendencias where pend_transacao='+EdTransacao.AsSql+' and '+FGeral.getin('pend_status','P','C') );
    if not QPendencia.eof then begin
       QPendencia1:=sqltoquery('select * from pendencias where pend_transbaixa='+stringtosql(qPendencia.fieldbyname('pend_transacao').asstring)+
                   ' and pend_unid_codigo='+stringtosql(qPendencia.fieldbyname('pend_unid_codigo').asstring)+
                   ' and pend_status=''K''');
       if not QPendencia1.eof then begin
         Sistema.Edit('Pendencias');
         Sistema.setfield('pend_status','N');
         Sistema.setfield('pend_mora',0);
         Sistema.setfield('pend_descontos',0);
         Sistema.setfield('pend_transbaixa','');
         Sistema.setfield('pend_contabaixa',0);
         Sistema.setfield('pend_databaixa',TextToDate(''));
         Sistema.setfield('pend_usubaixa',0);
         Sistema.Post('pend_transacao='+stringtosql(qPendencia1.fieldbyname('pend_transacao').asstring)+
                   ' and pend_unid_codigo='+stringtosql(qPendencia1.fieldbyname('pend_unid_codigo').asstring)+
                   ' and pend_numerodcto='+stringtosql(qPendencia1.fieldbyname('pend_numerodcto').asstring)+
                   ' and pend_status=''K''' );
       end else begin  //caso nao for a ultima parcial q 'fechou  o titulo' mas sim umas das baixas parciais feitas..
         QPendencia1:=sqltoquery('select * from pendencias where pend_numerodcto='+stringtosql(qPendencia.fieldbyname('pend_numerodcto').asstring)+
                   ' and pend_unid_codigo='+stringtosql(qPendencia.fieldbyname('pend_unid_codigo').asstring)+
                   ' and pend_dataemissao='+Datetosql(qPendencia.fieldbyname('pend_dataemissao').asdatetime)+
                   ' and pend_tipo_codigo='+stringtosql(qPendencia.fieldbyname('pend_tipo_codigo').asstring)+
                   ' and pend_status=''K''');
         if not QPendencia1.eof then begin
           Sistema.Edit('Pendencias');
           Sistema.setfield('pend_status','N');
           Sistema.setfield('pend_mora',0);
           Sistema.setfield('pend_descontos',0);
           Sistema.setfield('pend_transbaixa','');
           Sistema.setfield('pend_contabaixa',0);
           Sistema.setfield('pend_databaixa',TextToDate(''));
           Sistema.setfield('pend_usubaixa',0);
           Sistema.Post('pend_numerodcto='+stringtosql(qPendencia1.fieldbyname('pend_numerodcto').asstring)+
                   ' and pend_unid_codigo='+stringtosql(qPendencia1.fieldbyname('pend_unid_codigo').asstring)+
                   ' and pend_dataemissao='+Datetosql(qPendencia1.fieldbyname('pend_dataemissao').asdatetime)+
                   ' and pend_tipo_codigo='+stringtosql(qPendencia1.fieldbyname('pend_tipo_codigo').asstring)+
                   ' and pend_status=''K''');
         end;
       end;
// 06.10.10 - apaga o lan�amento do pagamento de comissao se ainda estiver em aberto
       if (Global.Topicos[1278]) and (FGeral.GetConfig1AsFloat('Contacomissao')>0) and
          (QPendencia1.fieldbyname('pend_rp').asstring='R') and
          (QPendencia1.fieldbyname('pend_tipomov').asstring=Global.CodContrato)
          then begin
         Sistema.Edit('Pendencias');
         Sistema.setfield('pend_status','C');
         Sistema.Post('pend_transacao='+stringtosql(qPendencia1.fieldbyname('pend_transacao').asstring)+
                   ' and pend_unid_codigo='+stringtosql(qPendencia1.fieldbyname('pend_unid_codigo').asstring)+
                   ' and pend_tipomov='+stringtosql(qPendencia1.fieldbyname('pend_tipomov').asstring)+
                   ' and pend_transbaixa is null and pend_rp=''P'''+
                   ' and pend_status=''N''');
       end;
/////////////////////
       FGeral.FechaQuery(qPendencia1);

       Sistema.Edit('Pendencias');
       Sistema.setfield('pend_status','C');
       Sistema.Post('pend_transacao='+stringtosql(qPendencia.fieldbyname('pend_transacao').asstring)+
                   ' and pend_unid_codigo='+stringtosql(qPendencia.fieldbyname('pend_unid_codigo').asstring)+
                   ' and pend_numerodcto='+stringtosql(qPendencia.fieldbyname('pend_numerodcto').asstring)+
                   ' and pend_status=''P''');
       FGeral.FechaQuery(qPendencia);

    end;
//////////////////////////////////

    ExecuteSql('Update pendencias set pend_status=''N'',pend_mora=0,pend_descontos=0,pend_transbaixa='''',pend_contabaixa=0,'+
               'pend_databaixa=CAST(NULL AS DATE),pend_usubaixa=0'+
               ' where '+FGeral.getin('pend_status','B','C')+' and pend_transbaixa='+EdTransacao.AsSql);
//               ' where '+FGeral.getin('pend_status','B;P','C')+' and pend_transbaixa='+EdTransacao.AsSql);
// 30.05.05
    ExecuteSql('Update pendencias set pend_status=''D'',pend_mora=0,pend_descontos=0,pend_transbaixa='''',pend_contabaixa=0,'+
               'pend_databaixa=CAST(NULL AS DATE),pend_usubaixa=0'+
               ' where '+FGeral.getin('pend_status','E','C')+' and pend_transbaixa='+EdTransacao.AsSql);
// 28.07.05
    ExecuteSql('Update pendencias set pend_status=''A'',pend_mora=0,pend_descontos=0,pend_transbaixa='''',pend_contabaixa=0,'+
               'pend_databaixa=CAST(NULL AS DATE),pend_usubaixa=0'+
               ' where '+FGeral.getin('pend_status','F','C')+' and pend_transbaixa='+EdTransacao.AsSql);
    ExecuteSql('Update pendencias set pend_status=''C'',pend_mora=0,pend_descontos=0,pend_transbaixa='''',pend_contabaixa=0,'+
               'pend_databaixa=CAST(NULL AS DATE),pend_usubaixa=0'+
               ' where '+FGeral.getin('pend_status','A','C')+' and pend_transbaixa='+EdTransacao.AsSql);


    Executesql('update pendencias set pend_status=''C'' where pend_transacao='+EdTransacao.AsSql);
//    Sistema.Edit('pendencias');
//    Sistema.Setfield('pend_status','C');
//    Sistema.post('pend_transacao='+EdTransacao.Assql);

//
// 11.05.05 - recalculo do saldo da conta se for o caso
    QMovfin:=sqltoquery('select * from movfin where movf_status=''N'' and movf_transacao='+EdTransacao.AsSql);
    if not QMovfin.eof then begin
 // 19.10.16
      if (transacaocontax='') and  ( (Global.topicos[1043]) or (Global.topicos[1045]) ) then
        transacaocontax:=QMovFin.fieldbyname('movf_transacaocontax').asstring;

//////////// 29.06.13 - 'desemite' o cheque caso foi informado na baixa de Pagamento
      if (QMovfin.fieldbyname('movf_numerocheque').asinteger>0) and (QMovfin.fieldbyname('movf_es').asstring='S') then begin
             Qb:=Sqltoquery('select plan_contacorrente,plan_codigobanco from plano where plan_ctachequescomp='+inttostr(QMovfin.fieldbyname('movf_plan_conta').asinteger));
             if not Qb.eof then begin
               if ( trim(Qb.fieldbyname('plan_codigobanco').asstring)<>'' ) and
                  ( trim(Qb.fieldbyname('Plan_contacorrente').Asstring)<>'' )
                  then begin
                 Sistema.edit('cheques');
                 Sistema.SetField('cheq_valor',0);
                 Sistema.Setfield('cheq_rc',' ');
                 Sistema.Setfield('cheq_obs','');
                 Sistema.SetField('cheq_emissao',Texttodate(''));
                 Sistema.Post('cheq_status=''N'' and cheq_emirec=''E'''+
                        ' and cheq_cheque='+stringtosql(QMovfin.fieldbyname('movf_numerocheque').asstring)+
                        ' and Cheq_emit_conta='+stringtosql(Qb.fieldbyname('Plan_contacorrente').AsString)+
                       ' and Cheq_emit_banco='+stringtosql(Qb.fieldbyname('Plan_codigobanco').AsString) );
// 19.09.13 - retirado pois nao 'desemitia' o cheque
//                        ' and Cheq_deposito is null' );
               end;
             end;
             FGeral.FechaQuery(Qb);
      end;
/////////////

      Executesql('update movfin set movf_status=''C'' where movf_transacao='+EdTransacao.AsSql);
// 26.11.09 - Abra 'desdeposito de cheques recebidos
      campo:=Sistema.GetDicionario('cheques','cheq_transbaixa');
      if campo.Tipo<>'' then begin
        Sistema.edit('cheques');
        Sistema.SetField('cheq_deposito',TexttoDate(''));
        Sistema.SetField('cheq_plan_contadep',0);
        Sistema.SetField('cheq_dtremessa',TexttoDate(''));
        Sistema.SetField('cheq_valorrec',0);
        Sistema.SetField('cheq_transbaixa','');
        Sistema.post('cheq_transbaixa='+EdTransacao.AsSql+' and cheq_plan_contadep>0');
// 02.01.15 - elimina cheques emitidos gerados na baixa do pagamento do leite
        Sistema.edit('cheques');
        Sistema.SetField('cheq_status','C');
        Sistema.post('cheq_cmc7='+EdTransacao.AsSql+' and cheq_emirec='+stringtosql('E'));

      end;
    end;
    while not QMovfin.eof do begin
//      if FGeral.RefazSaldofin(QMovfin.fieldbyname('movf_datamvto').asdatetime,QMovfin.fieldbyname('movf_plan_conta').asinteger ) then
//        Fgeral.FazSaldofin(QMovfin.fieldbyname('movf_datamvto').asdatetime,QMovfin.fieldbyname('movf_plan_conta').asinteger,QMovfin.fieldbyname('movf_unid_codigo').asstring);
// 06.08.07
//      if (QMovfin.fieldbyname('movf_tipomov').AsString=Global.CodChequeDevolvido) and (Qmovfin.fieldbyname('movf_plan_conta').asinteger=fGeral.Getconfig1asinteger('Ctachedevolvido')) then
      if (QMovfin.fieldbyname('movf_tipomov').AsString=Global.CodChequeDevolvido) then
        Executesql('update cheques set cheq_status=''C'' where cheq_cheque='+stringtosql(QMovfin.fieldbyname('movf_numerodcto').asstring)+
                   ' and cheq_lancto='+Datetosql(QMovfin.fieldbyname('movf_datamvto').asdatetime)+
                   ' and cheq_devolvido=''S'''+
                   ' and Cheq_emit_banco='+stringtosql('998') );
      QMovfin.Next;
    end;
    QMovfin.close;
    Freeandnil(QMovfin);

//    Sistema.Edit('movfin');
//    Sistema.Setfield('movf_status','C');
//    Sistema.post('movf_transacao='+EdTransacao.Assql);
///////////////////////////////////////////////////////////////////////


// deixa as remessas de consiga��o novamente dispon�veis
    if (TipoVenda=Global.CodVendaConsig) and (trim(remessas)<>'') then begin
      Executesql('update movesto set moes_status=''N'' where '+FGeral.GetIN('moes_numerodoc',Remessas,'N')+
                 ' and moes_unid_codigo='+stringtosql(Unidadedatransacao)+' and moes_status=''D'' and '+FGeral.Getin('moes_tipomov',Global.CodRemessaConsig,'C') );
//      Sistema.Edit('movesto');
//      Sistema.Setfield('moes_status','N');
//      Sistema.post(FGeral.GetIN('moes_numerodoc',Remessas,'N')+' and moes_status=''D''');
      Executesql('update movestoque set move_status=''N'' where '+FGeral.GetIN('move_numerodoc',Remessas,'N')+
//                 ' and move_unid_codigo='+stringtosql(Global.codigounidade)+' and move_status=''D'' and '+FGeral.Getin('move_tipomov',Global.CodRemessaConsig,'C') );
                 ' and move_unid_codigo='+stringtosql(Unidadedatransacao)+' and move_status=''D'' and '+FGeral.Getin('move_tipomov',Global.CodRemessaConsig,'C') );

// retorna as devolu�oes de remessa para ficarem dispon�veis
{
      Executesql('update movesto set moes_status=''N'' where moes_remessas='+stringtosql(Remessas)+
                 ' and moes_status=''D'' and '+FGeral.GEtin('moes_tipomov',Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C')+
                 ' and moes_transacao<>'+EdTransacao.assql );
      Executesql('update movestoque set move_status=''N'' where move_remessas='+stringtosql(Remessas)+
                 ' and move_status=''D'' and '+FGeral.GEtin('move_tipomov',Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C')+
                 ' and move_transacao<>'+EdTransacao.assql );
}
//////////////////////////////////////////////////////////////////////////////
// 21.01.05
       ListaRemessas:=tstringlist.create;
       strtolista(Listaremessas,Remessas,';',true);
       Sistema.beginprocess('Retornando as devolu��es');
       if trim(cliente)='' then begin
         sqlclientem:='';
         sqlcliented:='';
       end else begin
         sqlclientem:='moes_tipo_codigo='+stringtosql(Cliente);
         sqlcliented:='move_tipo_codigo='+stringtosql(Cliente);
       end;
       for p:=0 to Listaremessas.count-1 do begin
         if trim(listaremessas[p])<>'' then begin
           Sistema.Edit('Movesto');
           Sistema.Setfield('moes_status','N');
           Sistema.post(sqlclientem+
                       ' and moes_unid_codigo='+stringtosql(Unidadedatransacao)+
                       ' and '+FGeral.SimilarTo('moes_remessas',strzero(strtoint(listaremessas[p]),8))+
                       ' and moes_status=''D'' and '+FGeral.Getin('moes_tipomov',Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C') );
           Sistema.Edit('Movestoque');
           Sistema.Setfield('move_status','N');
           Sistema.post(sqlcliented+
                       ' and move_unid_codigo='+stringtosql(Unidadedatransacao)+
                       ' and '+FGeral.SimilarTo('move_remessas',strzero(strtoint(listaremessas[p]),8))+
                       ' and move_status=''D'' and '+FGeral.Getin('move_tipomov',Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C') );
         end;
       end;
       if Listaremessas.count>=1 then
         Sistema.commit;
       Listaremessas.free;
    end;

// 25.02.05 - retorna as remessas de pronta entrega...
//////////////////////
    if (TipoVenda=Global.CodVendaProntaEntregaFecha) and (trim(remessas)<>'') then begin
      if ListaRem.count>0 then begin
        remessas:='';
        for p:= 0 to ListaRem.count-1 do begin
          if trim(listarem[p])<>'' then begin
            remessas:=remessas+listarem[p]+';';   // 17.05.06 colocado o ;
          end;
        end;
      end;
      Executesql('update movesto set moes_status=''N'' where '+FGeral.GetIN('moes_numerodoc',Remessas,'N')+
                 ' and moes_repr_codigo='+codrepr+  // 31.05.06
                 ' and moes_unid_codigo='+stringtosql(Unidadedatransacao)+' and moes_status=''E'' and '+FGeral.Getin('moes_tipomov',Global.CodRemessaProntaEntrega,'C') );
//      Sistema.Edit('movesto');
//      Sistema.Setfield('moes_status','N');
//      Sistema.post(FGeral.GetIN('moes_numerodoc',Remessas,'N')+' and moes_status=''D''');
      Executesql('update movestoque set move_status=''N'' where '+FGeral.GetIN('move_numerodoc',Remessas,'N')+
                 ' and move_repr_codigo='+codrepr+  // 31.05.06
                 ' and move_unid_codigo='+stringtosql(Unidadedatransacao)+' and move_status=''E'' and '+FGeral.Getin('move_tipomov',Global.CodRemessaProntaEntrega,'C') );
// retorna as devolu�oes de remessa para ficarem dispon�veis
{
      Executesql('update movesto set moes_status=''N'' where moes_remessas='+stringtosql(Remessas)+
                 ' and moes_status=''D'' and '+FGeral.GEtin('moes_tipomov',Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C')+
                 ' and moes_transacao<>'+EdTransacao.assql );
      Executesql('update movestoque set move_status=''N'' where move_remessas='+stringtosql(Remessas)+
                 ' and move_status=''D'' and '+FGeral.GEtin('move_tipomov',Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C')+
                 ' and move_transacao<>'+EdTransacao.assql );
}
//////////////////////////////////////////////////////////////////////////////
// 21.01.05
       ListaRemessas:=tstringlist.create;
       strtolista(Listaremessas,Remessas,';',true);
       Sistema.beginprocess('Retornando as devolu��es');

       if trim(cliente)='' then begin
         sqlclientem:='';
         sqlcliented:='';
       end else begin
//         sqlclientem:='moes_tipo_codigo='+stringtosql(Cliente);
//         sqlcliented:='move_tipo_codigo='+stringtosql(Cliente);
         sqlclientem:='and moes_repr_codigo='+Cliente;
         sqlcliented:='and move_repr_codigo='+Cliente;
       end;
       for p:=0 to Listaremessas.count-1 do begin
         if trim(listaremessas[p])<>'' then begin
           Sistema.Edit('Movesto');
           Sistema.Setfield('moes_status','N');
           Sistema.post('moes_unid_codigo='+stringtosql(Unidadedatransacao)+
                       sqlclientem+
                       ' and '+FGeral.SimilarTo('moes_remessas',strzero(strtoint(listaremessas[p]),8))+
                       ' and moes_status=''E'' and '+FGeral.Getin('moes_tipomov',Global.CodVendaProntaEntrega+';'+Global.CodVendaBrinde+';'+Global.CodDevolucaoProntaEntrega,'C') );
           Sistema.Edit('Movestoque');
           Sistema.Setfield('move_status','N');
           Sistema.post('move_unid_codigo='+stringtosql(Unidadedatransacao)+
                       sqlcliented+
                       ' and '+FGeral.SimilarTo('move_remessas',strzero(strtoint(listaremessas[p]),8))+
                       ' and move_status=''E'' and '+FGeral.Getin('move_tipomov',Global.CodVendaProntaEntrega+';'+Global.CodVendaBrinde+';'+Global.CodDevolucaoProntaEntrega,'C') );
         end;
       end;
       if Listaremessas.count>=1 then
         Sistema.commit;
       Listaremessas.free;
    end;

///////////////////////

// 22.07.05 - retorna as notas VN do regime especial
//////////////////////
    if (TipoVenda=Global.CodVendaREFinal) and (trim(remessas)<>'') then begin
////////// - 07.07.06
      if ListaRem.count>0 then begin
        remessas:='';
        for p:= 0 to ListaRem.count-1 do begin
          if trim(listarem[p])<>'' then begin
            remessas:=remessas+listarem[p]+';';   // 17.05.06 colocado o ;
          end;
        end;
      end;
//////////
      cliente:=QMovestoque.fieldbyname('move_clie_codigo').asstring;
      Executesql('update movesto set moes_status=''N'' where '+FGeral.GetIN('moes_numerodoc',Remessas,'N')+
                 ' and moes_unid_codigo='+stringtosql(Unidadedatransacao)+' and moes_status=''E'' and '+FGeral.Getin('moes_tipomov',Global.CodVendaSerie4,'C') );
//      Sistema.Edit('movesto');
//      Sistema.Setfield('moes_status','N');
//      Sistema.post(FGeral.GetIN('moes_numerodoc',Remessas,'N')+' and moes_status=''D''');
      Executesql('update movestoque set move_status=''N'' where '+FGeral.GetIN('move_numerodoc',Remessas,'N')+
                 ' and move_unid_codigo='+stringtosql(Unidadedatransacao)+' and move_status=''E'' and '+FGeral.Getin('move_tipomov',Global.CodVendaSerie4,'C') );
       ListaRemessas:=tstringlist.create;
       strtolista(Listaremessas,Remessas,';',true);
       Sistema.beginprocess('Retornando as devolu��es do regime especial');

       if trim(cliente)='' then begin
         sqlclientem:='';
         sqlcliented:='';
       end else begin
         sqlclientem:='and moes_clie_codigo='+stringtosql(Cliente);
         sqlcliented:='and move_clie_codigo='+stringtosql(Cliente);
       end;
       for p:=0 to Listaremessas.count-1 do begin
         if trim(listaremessas[p])<>'' then begin
           Sistema.Edit('Movesto');
           Sistema.Setfield('moes_status','N');
           Sistema.post('moes_unid_codigo='+stringtosql(Unidadedatransacao)+
                       sqlclientem+
                       ' and '+FGeral.SimilarTo('moes_remessas',strzero(strtoint(listaremessas[p]),8))+
                       ' and moes_status=''E'' and '+FGeral.Getin('moes_tipomov',Global.CodVendaRE+';'+Global.CodVendaREBrinde+';'+Global.CodDevolucaoSerie5,'C') );
           Sistema.Edit('Movestoque');
           Sistema.Setfield('move_status','N');
           Sistema.post('move_unid_codigo='+stringtosql(Unidadedatransacao)+
                       sqlcliented+
                       ' and '+FGeral.SimilarTo('move_remessas',strzero(strtoint(listaremessas[p]),8))+
                       ' and move_status=''E'' and '+FGeral.Getin('move_tipomov',Global.CodVendaRE+';'+Global.CodVendaREBrinde+';'+Global.CodDevolucaoSerie5,'C') );
         end;
       end;
       if Listaremessas.count>=1 then
         Sistema.commit;
       Listaremessas.free;
    end;

///////////////////////
// 04.05.06
    if (TipoVenda=Global.CodDevolucaoInd)  then begin
      Transacaoaux:=EdTransacao.text+'9';
      Sistema.Edit('movesto');
      Sistema.Setfield('moes_status','C');
      Sistema.post('moes_transacao='+stringtosql(Transacaoaux));
      Sistema.Edit('movestoque');
      Sistema.Setfield('move_status','C');
      Sistema.post('move_transacao='+stringtosql(Transacaoaux));
      Sistema.Edit('movbase');
      Sistema.Setfield('movb_status','C');
      Sistema.post('movb_transacao='+stringtosql(Transacaoaux));
      Sistema.Edit('pendencias');
      Sistema.Setfield('pend_status','C');
      Sistema.post('pend_transacao='+stringtosql(Transacaoaux));
// 02.04.08 - voltar o status das notas de compra usada na devolucao
      Sistema.Edit('movesto');
      Sistema.Setfield('moes_status','N');
      Sistema.post('moes_remessas='+stringtosql(EdTransacao.text)+' and moes_status=''D''');

    end;
///////////////////////
// 26.09.06
    if pos(TipoVenda,Global.CodCompraProdutor+';'+Global.CodEntradaProdutor)>0  then begin
      Sistema.Edit('movabate');
      Sistema.Setfield('mova_notagerada',0);
      Sistema.Setfield('mova_transacaogerada','');
      Sistema.post('mova_notagerada='+inttostr(numerodoc)+' and mova_unid_codigo='+stringtosql(UnidadedaTransacao)+
                   ' and mova_tipo_codigo='+stringtosql(cliente)+
                   ' and mova_tipomov='+stringtosql(TipoEntradaAbate)+
                   ' and mova_status=''N'' and mova_situacao=''N''');
// 05.10.16
    end else if pos(TipoVenda,Global.CodTransfEntrada)>0  then begin
      if (trim(romaneios)<>'') and (trim(romaneios)<>';') then begin
        Sistema.Edit('movabate');
        Sistema.Setfield('mova_notagerada',0);
        Sistema.Setfield('mova_transacaogerada','');
        Sistema.post('mova_notagerada='+inttostr(numerodoc)+
//                     ' and mova_unid_codigo='+stringtosql(UnidadedaTransacao)+
// 05.10.16 - pois tem q buscar na unidade origem
                     ' and mova_tipomov='+stringtosql(TipoEntradaAbate)+
                     ' and mova_transacaogerada = '+EdTransacao.assql+
                     ' and '+FGeral.GetIN('mova_numerodoc',Romaneios,'N')+
                     ' and mova_status=''N''');
      end;
    end;
/////////////////////////
// 01.07.08
    if (pedido>0) and (codigomov=FGeral.GetConfig1AsInteger('ConfMovAbate')) then begin
      Sistema.Edit('movabate');
      Sistema.Setfield('mova_notagerada',0);
      Sistema.Setfield('mova_transacaogerada','');
      Sistema.post('mova_notagerada='+inttostr(numerodoc)+' and mova_unid_codigo='+stringtosql(UnidadedaTransacao)+
                   ' and mova_tipo_codigo='+stringtosql(cliente)+
                   ' and mova_tipomov='+stringtosql(TipoSaidaAbate)+
                   ' and mova_status=''N'' and mova_situacao=''P''');
// 09.05.17
      QMOvfin:=Sqltoquery('select movd_oprastreamento from movabatedet where movd_numerodoc='+inttostr(pedido)+
                   ' and movd_unid_codigo='+stringtosql(UnidadedaTransacao)+
                   ' and movd_tipo_codigo='+stringtosql(cliente)+
                   ' and movd_tipomov='+stringtosql(TipoSaidaAbate)+
                   ' and movd_status=''N''');
      if not QMovfin.Eof then begin
        Sistema.Edit('movabatedet');
        Sistema.Setfield('movd_pesobalanca',0);
        Sistema.post('movd_operacao = '+Stringtosql(QMovfin.FieldByName('movd_oprastreamento').AsString)+
                     ' and movd_unid_codigo='+stringtosql(UnidadedaTransacao)+
                     ' and movd_tipomov='+stringtosql('PC')+
                     ' and movd_status=''N''');
      end;
      FGeral.FechaQuery(QMovfin);
    end;
/////////////////////////////////////////
// 15.01.08 - ordem de producao
    if (TipoVenda=Global.CodContrato)  then begin
      Sistema.edit('Movproducao');
      Sistema.SetField('movp_status','C');
      Sistema.post('movp_transacao='+EdTransacao.AsSql);
      Sistema.edit('Movobrasdet');
      Sistema.SetField('movo_status','C');
      Sistema.post('movo_transacao='+EdTransacao.AsSql);
    end;
////////////////
// 02.04.08 - cobran�a da industrializacao
    if (TipoVenda=Global.CodRetornocomServicos)  then begin
      Sistema.Edit('movesto');
      Sistema.Setfield('moes_status','D');
      Sistema.post('moes_remessas='+stringtosql(EdTransacao.text)+' and moes_status=''E''');
    end;
////////////////
/////////////////////////////////////////
// 28.01.16 - ordem de servi�o
    if (pos(TipoVenda,Global.tiposentrada)>0)  and (Global.Topicos[1385]) then begin
      Sistema.edit('Movestoque');
      Sistema.SetField('move_status','C');
      Sistema.post('move_transacao='+stringtosql(EdTransacao.text)+' and move_status='+Stringtosql('R'));
    end;
////////////////
// 20.06.16
    if ( (Global.topicos[1043]) or (Global.topicos[1045])  ) and ( transacaocontax<>'' )  then begin
       FGeral.SistemaContax.ExecuteDirect('update movcon set mcon_status = ''C'' where mcon_transacao = '+Stringtosql(transacaocontax) );
    end;
// 28.01.16 - ordem de servi�o
// 22.07.20 - apropriacoes - entradas
    campo:=Sistema.GetDicionario('apropriacoes','apro_comv_codigo');
    if (pos(TipoVenda,Global.tiposentrada)>0) and ( campo.Tipo<>'' )  then begin

      Sistema.edit('Apropriacoes');
      Sistema.SetField('apro_status','C');
      Sistema.post('apro_transacao='+stringtosql(EdTransacao.text) );

    end;

    FGeral.Gravalog(3,'numero '+EdTransacao.text,true,edtransacao.text,Edusua_codigo.asinteger,EdMotivo.text );

    if statuscancfiscal = 'Y' then

       Sistema.Endtransaction('Transa��o '+EdTransacao.text+' DENEGADA')

    else

       Sistema.Endtransaction('Transa��o '+EdTransacao.text+' cancelada');

    QMovestoque.Close;
    QCancela.Close;
    Freeandnil(QMovestoque);
    Freeandnil(QCancela);
    EdTransacao.clearall(FCanctransacao,99);
    EdTransacao.setfocus;

  end;
end;

procedure TFCanctransacao.EdTransacaoExitEdit(Sender: TObject);
begin
   baplicarclick(FCanctransacao);
end;

procedure TFCanctransacao.EdTransacaoValidae(Sender: TObject);
////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    csenha:string;

   procedure QuerytoGrid(tabela,status:string);
   /////////////////////////////////////////////
   begin
     if tabela='movesto' then begin
       Texto.lines.add('MOV.ESTOQUE_____________________________________________');
       Texto.lines.add('Unidade       : '+Q.fieldbyname('moes_unid_codigo').asstring);
       Texto.lines.add('Documento     : '+Q.fieldbyname('moes_numerodoc').asstring);
       Texto.lines.add('Tipo          : '+Q.fieldbyname('moes_tipomov').asstring+' - '+FGeral.GetTipoMovto(Q.fieldbyname('moes_tipomov').asstring));
       Texto.lines.add('Data          : '+FGeral.formatadata(Q.fieldbyname('moes_datamvto').asdatetime));
       Texto.lines.add('Valor         : '+floattostr(Q.fieldbyname('moes_vlrtotal').ascurrency));
       Texto.lines.add('Cliente       : '+Q.fieldbyname('moes_tipo_codigo').asstring+' - '+FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asstring,'N'));
       Texto.lines.add('Representante : '+Q.fieldbyname('moes_repr_codigo').asstring+' - '+FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('moes_repr_codigo').asinteger,'R','N'));
     end else if tabela='pendencias' then begin
       Texto.lines.add('FINANCEIRO______________________________________________');
       Texto.lines.add('Unidade       : '+Q.fieldbyname('pend_unid_codigo').asstring);
       Texto.lines.add('Documento     : '+Q.fieldbyname('pend_numerodcto').asstring);
//       Texto.lines.add('Tipo          : '+Q.fieldbyname('pend_tipomov').asstring+' - '+FGeral.GetTipoMovto(Q.fieldbyname('pend_tipomov').asstring));
       Texto.lines.add('Status        : '+Q.fieldbyname('pend_status').asstring);
       Texto.lines.add('Data          : '+FGeral.formatadata(Q.fieldbyname('pend_datamvto').asdatetime));
       Texto.lines.add('Valor         : '+floattostr(Q.fieldbyname('pend_valor').ascurrency));
       Texto.lines.add('Cliente       : '+Q.fieldbyname('pend_tipo_codigo').asstring+' - '+FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('pend_tipo_codigo').asinteger,Q.fieldbyname('pend_tipocad').asstring,'N'));
       Texto.lines.add('Representante : '+Q.fieldbyname('pend_repr_codigo').asstring+' - '+FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('pend_repr_codigo').asinteger,'R','N'));
     end else begin
       Texto.lines.add('CAIXA/BANCOS____________________________________________');
       Texto.lines.add('Unidade       : '+Q.fieldbyname('movf_unid_codigo').asstring);
       Texto.lines.add('Documento     : '+Q.fieldbyname('movf_numerodcto').asstring);
       Texto.lines.add('Tipo          : '+Q.fieldbyname('movf_tipomov').asstring+' - '+FGeral.GetTipoMovto(Q.fieldbyname('movf_tipomov').asstring,false,'S'));
       Texto.lines.add('Data          : '+FGeral.formatadata(Q.fieldbyname('movf_datamvto').asdatetime));
       Texto.lines.add('Valor         : '+floattostr(Q.fieldbyname('movf_valorger').ascurrency));
       Texto.lines.add('Conta         : '+Q.fieldbyname('movf_plan_conta').asstring+' - '+FPlano.GetDescricao(Q.fieldbyname('movf_plan_conta').asinteger));
     end;
   end;

begin
/////////////////////////////////////////////
   Texto.clear;
   Sistema.beginprocess('Pesquisando transa��o');
   Q:=sqltoquery('select * from movesto where moes_transacao='+EdTransacao.assql+' order by moes_numerodoc');
   if not Q.eof then begin
// 30.04.18
      if Global.Usuario.OutrosAcessos[0346] then begin
         if  (
             (  AnsiPos(Q.FieldByName('moes_tipomov').AsString,Global.CodCompraProdutor)>0 )
             )
            or
            ( AnsiPos(copy(Q.FieldByName('moes_natf_codigo').AsString,1,1),'5/6/7')>0 )
            then begin
              EdTransacao.invalid('Usu�rio sem permiss�o de cancelar ESTA NOTA FISCAL');
              Sistema.EndProcess('');
              exit;
            end;

      end else begin // 12.06.07

          if not Global.Usuario.OutrosAcessos[0303] then begin
            EdTransacao.invalid('Usu�rio sem permiss�o de cancelar nota fiscal');
            Sistema.EndProcess('');
            exit;
          end;

      end;
// 07.07.09
     EdDataMov.setdate(Q.fieldbyname('moes_datamvto').asdatetime);
     Querytogrid('movesto',Q.fieldbyname('moes_status').asstring);

     if Q.fieldbyname('moes_status').asstring='C' then begin

       EdTransacao.invalid('Transa��o j� cancelada(exclu�da)');
       Sistema.endprocess('');
       exit;

     end;
// 22.07.20 - Novicarnes
     if AnsiPos( Q.fieldbyname('moes_status').asstring,'I/X/Y' ) > 0 then begin

       EdTransacao.invalid('Transa��o j� inutilizada/cancelada/denegada');
       Sistema.endprocess('');
       exit;

     end;
// 07.07.09
     if not FGeral.ValidaMvto(EddataMov) then begin
       EdTransacao.invalid('');
       Sistema.endprocess('');
       exit;
     end;
////////////
// 08.02.10
     if (Global.UsaNfe='S') then begin

       if ( DAtetoano(Q.fieldbyname('moes_dtnfeauto').asdatetime,true)>=1900 )
           and   // 23.01.23 - para os 'causos' da vida nota de autorizada no sac e denegada na receita...
           ( Ansipos('DENEGA',Uppercase(Q.fieldbyname('moes_retornonfe').AsString))  = 0 )
         then begin

         if (DAtetoano(Q.fieldbyname('moes_dtnfecanc').asdatetime,true)<=1900)
           then begin
           Avisoerro('NFe '+Q.fieldbyname('moes_numerodoc').asstring+' ainda n�o foi cancelada na Sefa');
           EdTransacao.invalid('');
           Sistema.endprocess('');
           exit;
         end;

// 27.04.20 - Novicarnes - cancela no sac ao inves de inutilizar na receita
// 13.05.20 - FAma - dai nao deixar 's� apagar' a transacao de uma remessa RC...colocado especie
       end else if (Q.fieldbyname('moes_chavenfe').AsString = '')
                and ( Q.fieldbyname('moes_status').AsString='N')
                and ( Datetoano(Q.fieldbyname('moes_datacont').AsDatetime,true) > 1901 )
                and ( Uppercase(Q.fieldbyname('moes_especie').AsString)='NFE'  )
                and ( AnsiPos( Q.fieldbyname('moes_tipomov').asstring,Global.TiposSaida ) > 0 )
                and ( not Global.topicos[1301] )
           then begin

           Avisoerro('Numero de NFe '+Q.fieldbyname('moes_numerodoc').asstring+' tem que ser INUTILIZADO na receita');
           EdTransacao.invalid('');
           Sistema.endprocess('');
           exit;

       // 09.09.19
       end else if Q.fieldbyname('moes_status').AsString = 'Y' then  begin

           Avisoerro('NFe '+Q.fieldbyname('moes_numerodoc').asstring+' j� denegada no sistema');
           EdTransacao.invalid('');
           Sistema.endprocess('');
           exit;

       // 09.09.19
       end else if Ansipos('DENEGA',Uppercase(Q.fieldbyname('moes_retornonfe').AsString))  > 0 then

          EdMotivo.Text:='NFE DENEGADA';

// 07.11.13 - Vivan
     end else if ( Q.fieldbyname('moes_envio').asstring='E' ) and (Q.fieldbyname('moes_especie').asstring='CF') then begin

           Aviso('CF '+Q.fieldbyname('moes_numerodoc').asstring+' emitido n�o pode ser cancelado');
           if not Input('Autoriza��o','Senha',csenha,15,false) then begin
             EdTransacao.invalid('Senha n�o informada');
             Sistema.endprocess('');
             exit;
           end;
           if csenha<>'eterno' then begin
             EdTransacao.invalid('Senha incorreta');
             Sistema.endprocess('');
             exit;
           end;
     end;
////////////


   end else begin
//     EdTransacao.Invalid('Transa��o n�o encontrada !!!');
//     Sistema.endprocess('');
//     exit;
   end;


     Q.close;Freeandnil(Q);
     Q:=sqltoquery('select * from pendencias where pend_transacao='+EdTransacao.assql);
     if not Q.eof then begin
       Querytogrid('pendencias',Q.fieldbyname('pend_status').asstring);
       if Q.fieldbyname('pend_status').asstring='C' then
         EdTransacao.invalid('Transa��o j� cancelada')
       else if Q.fieldbyname('pend_status').asstring='B' then
         EdTransacao.invalid('Transa��o baixada.  Cancelar transa��o da baixa primeiro')
       else begin
         Q.close;Freeandnil(Q);
         Q:=sqltoquery('select * from movfin where movf_transacao='+EdTransacao.assql);
         Querytogrid('movfin',Q.fieldbyname('movf_status').asstring);
       end;

     end else begin

       Q.close;Freeandnil(Q);
       Q:=sqltoquery('select * from movfin where movf_transacao='+EdTransacao.assql);
       if not Q.eof then begin
         Querytogrid('movfin',Q.fieldbyname('movf_status').asstring);
         if Q.fieldbyname('movf_status').asstring='C' then
           EdTransacao.invalid('Transa��o j� cancelada')
       end else begin
         Q:=sqltoquery('select * from pendencias where pend_transbaixa='+EdTransacao.assql);
         if not Q.eof then begin
           Querytogrid('pendencias',Q.fieldbyname('pend_status').asstring);
           if Q.fieldbyname('pend_status').asstring='C' then
             EdTransacao.invalid('Transa��o j� cancelada')
         end else  if texto.Lines.Count=0 then
//           EdTransacao.Invalid('Transa��o  n�o encontrada no caixa bancos');
           EdTransacao.Invalid('Transa��o  n�o encontrada.');
       end;
       Q.close;Freeandnil(Q);
     end;

   Sistema.endprocess('');
end;

procedure TFCanctransacao.brelauditoriafiscalClick(Sender: TObject);
begin
  if not Sistema.Processando then FRelGerenciais_AuditoriaFiscal;

end;

end.


unit BaixaPen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel, ExtCtrls,
  SQLGrid, Grids, SqlDtg, Sqlexpr, SqlSis, SqlFun, Vcl.ActnMan,
  Vcl.ActnColorMaps ;

type
  TFBaixaPendencia = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    PRemessa: TSQLPanelGrid;
    EdCodtipo: TSQLEd;
    SetEdFavorecido: TSQLEd;
    EdDtBaixa: TSQLEd;
    EdDtMovimento: TSQLEd;
    EdTipocad: TSQLEd;
    EdRecpag: TSQLEd;
    PGrid: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PContaBaixa: TSQLPanelGrid;
    EdPlan_conta: TSQLEd;
    EdPlan_descricao: TSQLEd;
    EdHist_codigo: TSQLEd;
    EdHist_descricaos: TSQLEd;
    EdHist_complemento: TSQLEd;
    EdValor: TSQLEd;
    EdJuroMora: TSQLEd;
    EdDescontos: TSQLEd;
    SetEdJuroMora: TSQLEd;
    SetEdDesconto: TSQLEd;
    EdOperacao: TSQLEd;
    EdCheque: TSQLEd;
    bImprecibo: TSQLBtn;
    Edantecipa: TSQLEd;
    EdBaixaparcial: TSQLEd;
    EdContaDesrec: TSQLEd;
    SQLEd3: TSQLEd;
    breimiprime: TSQLBtn;
    EdOprecibo: TSQLEd;
    EdVlrantecipa: TSQLEd;
    EdTarifa: TSQLEd;
    EdQuempagou: TSQLEd;
    ptotais: TSQLPanelGrid;
    Edtotalvalor: TSQLEd;
    Edtotalparcial: TSQLEd;
    Edtotaldctos: TSQLEd;
    pjurosdesc: TSQLPanelGrid;
    EdContajuros: TSQLEd;
    SetEdplan_descricao: TSQLEd;
    EdContadescontos: TSQLEd;
    SQLEd2: TSQLEd;
    bcheques: TSQLBtn;
    brecibo: TSQLBtn;
    EdValorparcial: TSQLEd;
    bmarcatodos: TSQLBtn;
    bboleto: TSQLBtn;
    EdPort_codigo: TSQLEd;
    EdPort_descricao: TSQLEd;
    Edvlratualizado: TSQLEd;
    EdVencimento: TSQLEd;
    bdescontodup: TSQLBtn;
    EdValorparcela: TSQLEd;
    PConta: TSQLPanelGrid;
    EdLiquido: TSQLEd;
    Edchequerec: TSQLEd;
    EdBompara: TSQLEd;
    EdChequesmar: TSQLEd;
    EdUnid_codigo: TSQLEd;
    balteravalor: TSQLBtn;
    EdValornota: TSQLEd;
    StandardColorMap1: TStandardColorMap;
    EdDesc_setor: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure EdRecpagValidate(Sender: TObject);
    procedure EdDtBaixaValidate(Sender: TObject);
    procedure EdDescontosValidate(Sender: TObject);
    procedure EdTipocadValidate(Sender: TObject);
    procedure EdCodtipoValidate(Sender: TObject);
    procedure GridClick(Sender: TObject);
    procedure EdValorValidate(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure EdPlan_contaValidate(Sender: TObject);
    procedure bImpreciboClick(Sender: TObject);
    procedure EdantecipaValidate(Sender: TObject);
    procedure GridAntecipaDblClick(Sender: TObject);
    procedure EdHist_complementoExitEdit(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure breimiprimeClick(Sender: TObject);
    procedure EdOpreciboValidate(Sender: TObject);
    procedure EdContaDesrecValidate(Sender: TObject);
    procedure APHeadLabel1DblClick(Sender: TObject);
    procedure EdQuempagouValidate(Sender: TObject);
    procedure EdContadescontosExitEdit(Sender: TObject);
    procedure EdContajurosValidate(Sender: TObject);
    procedure EdContadescontosValidate(Sender: TObject);
    procedure EdJuroMoraValidate(Sender: TObject);
    procedure bchequesClick(Sender: TObject);
    procedure breciboClick(Sender: TObject);
    procedure EdValorparcialExitEdit(Sender: TObject);
    procedure EdValorparcialValidate(Sender: TObject);
    procedure bmarcatodosClick(Sender: TObject);
    procedure bboletoClick(Sender: TObject);
    procedure EdChequeValidate(Sender: TObject);
    procedure EdPlan_contaExit(Sender: TObject);
    procedure EdVencimentoExitEdit(Sender: TObject);
    procedure bdescontodupClick(Sender: TObject);
    procedure EdValorparcelaExitEdit(Sender: TObject);
    procedure EdChequesmarValidate(Sender: TObject);
    procedure balteravalorClick(Sender: TObject);
    procedure EdValornotaExitEdit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(xtipoportador:string='');
    procedure GridtoEdits;
    function QuemPagou(cr:string):string;
    function ValidaConta( Ed:TSqled ):boolean;
    procedure GravaPendenciaComissao(codrepr:integer;transacao,numero:string;valor:currency);
// 20.10.10
    function GetCampo(tabela,campostatus,status,campopesquisar,campoabuscar,variavelabuscar:string):string;
// 14.05.13
    procedure SetaItemsChequesEmitidos(Ed:TSqled );
// 18.10.19
    function GetPlaca( xop:string ):string;

  end;

var
  FBaixaPendencia: TFBaixaPendencia;
  EscolheuGrid,baixouparcial:boolean;
  Valortitulo,Valortitulos:currency;
  Unidade,entsai,entsaix,baixafinalparcial,pendopantecipa,UnidadeDoc,OPeracoesMarc,
  statusdoc,sqlrecpag,NotasMarc,tipoportador,
  ChequeEmiRec,
  ktransacao,
  xnome                     :string;
  Numerodoc,hist_mora,hist_descontos,posicaoantecipa,marc:integer;
  QAntecipa:TSqlquery;
  contaclifor,contacaixaban           :integer;
  campo:TDicionario;

const statusaberto:string='N';
// 11.08.08
//const statusaberto:string='N;A';

implementation

uses Geral , impressao, Arquiv, Usuarios, plano, Cadcheq,
  reciboavulso, Alterapen, Unidades, Hist, fornece, cadcli, represen, setores,
  Transp;

{$R *.dfm}

procedure TFBaixaPendencia.Execute(xtipoportador:string='');
/////////////////////////////////////////////////////////////

   procedure SetaEdit(Edit:TSqled ; contasvalidas:string );
   /////////////////////////////////////////////////////////////
   var LIsta:TStringlist;
       x:integer;
   begin
     Edit.Items.Clear;
     Lista:=TStringlist.create;
     strtolista(lista,contasvalidas,';',true);
     for x:=0 to LIsta.count-1 do begin
       if trim(lista[x])<>'' then
         Edit.Items.Add(strspace( inttostr(strtoint(Lista[x])) ,8)+' - '+FPlano.GetDescricao(strtoint(Lista[x])) );
     end;
   end;

begin
////////////////////////////////////
  Global.FpgtoAntecipa:=FGeral.GetConfig1AsString('Fpgtoantecipa');   // 25.05.05
//  FGeral.EstiloForm(FBaixaPendencia);
  EdPort_codigo.Enabled:=Global.Topicos[1284];
  tipoportador:=xtipoportador;
  Pconta.Visible:=(tipoportador='Conta');
// 13.11.12
  FGeral.ConfiguraColorEditsNaoEnabled(FBaixaPendencia);
  Caption:='Baixa de Pendência Financeira '+Uppercase(tipoportador);
  baixouparcial:=false;
   if Global.Topicos[1252] then begin
     pjurosdesc.Enabled:=true;
// 06.06.07
     if trim( FGeral.GetConfig1AsString('Contasdejuros') )<>'' then begin
       Setaedit(EdContajuros,FGeral.GetConfig1AsString('Contasdejuros'));
       EdContajuros.ShowForm:='';
     end;
     if trim( FGeral.GetConfig1AsString('Contasdedesconto') )<>'' then begin
       SetaEdit(EdContadescontos,FGeral.GetConfig1AsString('Contasdedesconto'));
       EdContadescontos.ShowForm:='';
     end;
   end else begin
     pjurosdesc.Enabled:=false;
     EdContajuros.ShowForm:='FPlano';
     EdContadescontos.ShowForm:='FPlano';
   end;
  bcheques.visible:=Global.Topicos[1256];
  bcheques.enabled:=Global.Topicos[1256];
  brecibo.visible:=Global.Usuario.ObjetosAcessados[1128];
  brecibo.enabled:=Global.Usuario.ObjetosAcessados[1128];
  Grid.Clear;
  Premessa.enabled:=true;
// 26.11.12 - vivan

//  ShowModal;
  Show;
  EdTipoCad.setfocus;
// 23.02.18
  ktransacao:='';

  FGeral.SetaTipoCad(EdTipocad);
  EdTipoCad.ClearAll(FBaixaPendencia,99);
  
  EDOprecibo.enabled:=false;
  EDOprecibo.visible:=false;
  baixafinalparcial:='N';

  EdDtBaixa.SetDate(Sistema.Hoje);


  EdAntecipa.text:='N';
  hist_mora:=0;       // ver se pega algum padrao na conf. da conta do cx/bancos ou de mov. financeiro
  hist_descontos:=0;  // ver se pega algum padrao na conf. da conta do cx/bancos ou de mov. financeiro
  unidade:=Global.CodigoUnidade;  // ver se ficará assim ou criar edit para informar
  if not Arq.TUnidades.active then Arq.TUnidades.open;
  if not Arq.TUnidades.locate('unid_codigo',unidade,[]) then begin
     Avisoerro('Unidade '+unidade+' não cadastrada');
     exit;
     Close;
  end;
  pCONTAbaixa.enabled:=true;
  pendopantecipa:='';
// 03.10.09
  if (Global.Topicos[1270]) or (tipoportador='Conta') then
    EdCodtipo.Empty:=true
  else
    EdCodtipo.Empty:=false;
  EdChequesmar.visible:=false;
  EdChequesmar.enabled:=false;
  EdCheque.visible:=true;
  EdCheque.enabled:=true;
//  ShowModal;
end;

procedure TFBaixaPendencia.FormActivate(Sender: TObject);
begin
{
  FGeral.SetaTipoCad(EdTipocad);
  EdTipoCad.ClearAll(FBaixaPendencia,99);
  Grid.Clear;
  EDOprecibo.enabled:=false;
  EDOprecibo.visible:=false;
  baixafinalparcial:='N';
  EdDtBaixa.SetDate(Sistema.Hoje);
  EdAntecipa.text:='N';
  EdTipoCad.setfocus;
  hist_mora:=0;       // ver se pega algum padrao na conf. da conta do cx/bancos ou de mov. financeiro
  hist_descontos:=0;  // ver se pega algum padrao na conf. da conta do cx/bancos ou de mov. financeiro
  unidade:=Global.CodigoUnidade;  // ver se ficará assim ou criar edit para informar
  if not Arq.TUnidades.active then Arq.TUnidades.open;
  if not Arq.TUnidades.locate('unid_codigo',unidade,[]) then begin
     Avisoerro('Unidade '+unidade+' não cadastrada');
     exit;
     Close;
  end;
  Premessa.enabled:=true;
  pCONTAbaixa.enabled:=true;
  pendopantecipa:='';
}
end;

/////////////////////////////////////////////////////////////
procedure TFBaixaPendencia.EdRecpagValidate(Sender: TObject);
/////////////////////////////////////////////////////////////
var Q,QParcial,QAntecipa,QBP:TSqlquery;
    sqlqtipo,numerodoc,parceladoc,sqlunidade,sqlemissao,
    sqlcodigo,
    sqlportadorcartao     :string;
    p,x:integer;
    vencimento,emissao,
    dtemissao,
    emissaodoc            :TDatetime;
    xconta,
    vlrcorrigido:currency;

    function GetMovimentoCPR( yconta:integer ; yUnidade:string ; yEmissao:TDateTime ):currency;
    /////////////////////////////////////////////////////////////////////////////////////////////
    var Yq:TSqlquery;
    begin

       Yq:=sqltoquery('select sum(movf_valorger) as valor from movfin where '+
                      ' movf_status = ''N'''+
                      ' and movf_unid_codigo = '+stringtosql(yUnidade )+
                      ' and movf_plan_contard  = '+inttostr( yconta ) +
                      ' and movf_tipomov = '+stringtosql( global.CodJurosRecebidos )+
                      ' and movf_datamvto > '+Datetosql( yemissao ) );
       result:=Yq.FieldByName('valor').AsCurrency;
       Fgeral.FechaQuery(Yq);

    end;

begin

  Grid.Enabled:=true;
  baixouparcial:=false;
  marc:=0;
  Valortitulos:=0;
  OPeracoesMarc:='';
  NotasMarc:='';
  Grid.Clear;
  baixafinalparcial:='N';
  EscolheuGrid:=false;
  EdValor.setvalue(0);
  EdVlratualizado.setvalue(0);
  EdquemPagou.enabled:=EdRecpag.text='R';
  EdTotaldctos.setvalue(0);
  EdTotalvalor.setvalue(0);
  EdTotalparcial.setvalue(0);
  if (EdRecpag.text='P') and (Edtipocad.text='F') then  // 20.8.05
    SetEdFavorecido.Text:=FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.asinteger,EdTipoCad.text,'R');
// 06.07.09
  sqlemissao:='';

  if ( Global.Topicos[1266] ) and (EdRecPag.text='R') then begin
    if Sistema.GetPeriodo('Informe periodo EMISSAO ') then
      sqlemissao:=' and pend_dataemissao<='+DatetoSql(Sistema.Dataf);
  end;
// 01.02.19
  if ( Global.Topicos[1300] ) and (EdRecPag.text='P') and ( EdCodtipo.IsEmpty ) then begin
    if Sistema.GetPeriodo('VENCIMENTO ') then
      sqlemissao:=' and pend_datavcto<='+DatetoSql(Sistema.Dataf)+
                  ' and pend_datavcto>='+DatetoSql(Sistema.Datai);
  end;

  if (EdRecPag.text='P') and (EdCodtipo.IsEmpty) and ( tipoportador<>'Conta' ) and
     ( not Global.Topicos[1300] )
  then begin
    EdRecpag.Invalid('Obrigatório informar codigo do fornecedor/cliente');
    exit;
  end;

// 03.10.09
  if ( Global.Topicos[1270] ) and (EdRecPag.text='R') then begin
    if Sistema.GetPeriodo('Informe periodo ') then
      sqlemissao:=' and pend_datavcto<='+DatetoSql(Sistema.Dataf)+
                  ' and pend_datavcto>='+DatetoSql(Sistema.Datai);
  end;
// 03.04.14
  if (tipoportador='Conta') and (EdRecpag.text='P') then begin
    fGeral.Getvalor(xconta,'Conta');
    if xconta>0 then PConta.Caption:=currtostr(xconta)+'-'+FPlano.GetDescricao(trunc(xconta));
  end;

  Sistema.Beginprocess('Pesquisando pendencias em aberto');
//  Q:=sqltoquery('select pendencias.*,'+
  sqlunidade:=' and '+FGeral.GetIn('pend_unid_codigo',Global.Usuario.UnidadesMvto,'C');
  if Global.Usuario.OutrosAcessos[0711] then
    sqlunidade:=' and '+FGeral.GetIn('pend_unid_codigo',Global.CodigoUnidade,'C');

// 17.07.09
  if not EdCodtipo.IsEmpty then
    sqlcodigo:=' and pend_tipo_codigo='+EdCodTipo.AsSql+' and pend_tipocad='+Edtipocad.assql
  else  // 03.10.09
    sqlcodigo:=' and pend_tipocad='+Edtipocad.assql;

// 01.02.19 - 06.02.19 - Novicarnes - Sandro
  if Global.Topicos[1300] then begin // para pegar pagamentos a cliente e fornecedores

    if not EdCodtipo.IsEmpty then
      sqlcodigo:=' and pend_tipo_codigo='+EdCodTipo.AsSql+' and pend_tipocad='+Edtipocad.assql
    else  // 03.10.09
      sqlcodigo:='';

  end;

  if (Global.Topicos[1267]) and (Edtipocad.text='R') then
     sqlcodigo:=' and pend_repr_codigo='+EdCodTipo.AsSql+' and pend_tipocad=''C''';
// 06.11.12 - Vivan - para não imprimir contas a receber ref. recebimento com cartão de credito

  sqlportadorcartao:='';
  if trim( FGeral.GetConfig1AsString('Portadorcartao') )<>'' then
    sqlportadorcartao:=' and '+FGeral.GetNOTIN('pend_port_codigo',FGeral.GetConfig1AsString('Portadorcartao'),'C');
// 15.09.15 - vivan - cris pegou
  if EdRecPag.text='P' then
      sqlportadorcartao:='';

// 12.11.12
  if trim(tipoportador)<>'' then begin
// 02.04.14
    if (tipoportador='Conta') and (xconta>0) then
      sqlportadorcartao:=' and '+FGeral.GetIN('pend_plan_conta',currtostr(xconta),'N')
    else if trim( FGeral.GetConfig1AsString('Portadorcartao') )<>'' then
      sqlportadorcartao:=' and '+FGeral.GetIN('pend_port_codigo',FGeral.GetConfig1AsString('Portadorcartao'),'C')
    else
      EdRecpag.Invalid('Sistema não configurado para este tipo de baixa');
  end;
  Q:=sqltoquery('select pend_numerodcto,pend_valor,pend_operacao,pend_parcela,pend_dataemissao,pend_datavcto,pend_nparcelas,pend_valortitulo,'+
                'pend_datacont,pend_opantecipa,pend_unid_codigo,pend_plan_conta,pend_moed_codigo as bxparciais,pend_datamvto,'+
                'pend_moed_codigo as marcado,pend_status,pend_datavctoori,pend_moed_codigo as parcialgrid,pend_port_codigo,pend_tipomov,'+
                'pend_seto_codigo'+
                ' from pendencias where '+FGeral.GetIN('pend_status',statusaberto,'C')+
                ' and pend_rp='+EdRecPag.AsSql+
// 01.08.07
                sqlemissao+sqlcodigo+sqlportadorcartao+
                sqlunidade+' order by pend_unid_codigo,pend_datavcto' );

  if Q.eof then begin
    Sistema.Endprocess('');
    EdRecpag.Invalid('Não encontrado documentos em aberto');
  end else begin
  {  // 23.03.15
    while not Q.eof do begin
      EdTotaldctos.setvalue(Edtotaldctos.asinteger+1);
      EdTotalvalor.setvalue(edtotalvalor.ascurrency+Q.fieldbyname('pend_valor').ascurrency);
      Q.Next;
    end;
    Q.first;
    }
//    Grid.QueryToGrid(Q);
// 11.06.07
    x:=1;
    while not Q.eof do begin
////////////////////////////03.03.09
      if Q.fieldbyname('pend_datacont').asdatetime>1 then
        sqlqtipo:=' and pend_datacont > '+Datetosql(Global.DataMenorBanco)
      else
        sqlqtipo:=' and pend_datacont is null';
      Emissao:=Q.fieldbyname('pend_dataemissao').asdatetime;
///
      QBp:=sqltoquery('select sum(pend_valor) as parcial'+
                ' from pendencias where '+FGeral.GetIN('pend_status','P','C')+
//                ' from pendencias where '+FGeral.GetIN('pend_status','P;A','C')+
                ' and pend_tipo_codigo='+EdCodTipo.AsSql+' and pend_rp='+EdRecPag.AsSql+
                ' and pend_numerodcto='+stringtosql(Q.fieldbyname('pend_numerodcto').asstring)+
// 23.03.15  - coorlafs
                ' and pend_observacao <> '+Stringtosql('Pagamento Leite')+
                ' and pend_parcela='+Q.fieldbyname('pend_parcela').asstring+
                ' and pend_dataemissao>='+Datetosql(emissao)+
                sqlqtipo+sqlunidade );
      if not QBp.eof then begin

        if (qBp.fieldbyname('parcial').ascurrency<Q.fieldbyname('pend_valor').ascurrency)
            or
// 30.12.19 - devido ao juros que é recebido sobre o capital mas na forma de baixa parcial..
//            ver como tratar para exportar para contabilidade
           ( Q.FieldByName('pend_tipomov').AsString = Global.CodCedulaProdutoRural )
        then begin

          Grid.QueryToRow(Q,x);
          Grid.AppendRow;
// 01.06.15
          EdTotaldctos.setvalue(Edtotaldctos.asinteger+1);
          EdTotalvalor.setvalue(edtotalvalor.ascurrency+Q.fieldbyname('pend_valor').ascurrency);
          inc(x);

        end else if Q.fieldbyname('pend_status').AsString='A' then begin

          Grid.QueryToRow(Q,x);
          Grid.AppendRow;
          inc(x);

        end;
//          showmessage(' nao colocado no grid '+q.fieldbyname('pend_valor').asstring);
      end else begin

        Grid.QueryToRow(Q,x);
        Grid.AppendRow;
        inc(x);
// 01.06.15
        EdTotaldctos.setvalue(Edtotaldctos.asinteger+1);
        EdTotalvalor.setvalue(edtotalvalor.ascurrency+Q.fieldbyname('pend_valor').ascurrency);
      end;
      FGeral.FechaQuery(Qbp);
// 23.03.15
//      EdTotaldctos.setvalue(Edtotaldctos.asinteger+1);
 //     EdTotalvalor.setvalue(edtotalvalor.ascurrency+Q.fieldbyname('pend_valor').ascurrency);
//////////////////////
      Q.next;

    end;

    Sistema.beginprocess('Checando baixas parciais de cada documento');

    for p:=1 to Grid.rowcount do begin

      Numerodoc:=Grid.Cells[Grid.getcolumn('pend_numerodcto'),p];
      unidadedoc:=Grid.Cells[Grid.getcolumn('pend_unid_codigo'),p];
      statusdoc:=Grid.Cells[Grid.getcolumn('pend_status'),p];
      Emissaodoc:=Texttodate(FGeral.tirabarra( Grid.Cells[Grid.getcolumn('pend_dataemissao'),p] ) );

      if trim(numerodoc)<>'' then begin
// 20.06.06 - tentativa de achar o porque de nao aparecer ora aparecer baixas parciais em curitiba
        if trim(unidadedoc)='' then
           Avisoerro('Documento '+numerodoc+'.  Não encontrado unidade');

        if texttodate(FGeral.tirabarra(Grid.cells[Grid.getcolumn('pend_datacont'),p])) > 0 then
          sqlqtipo:=' and pend_datacont > '+Datetosql(Global.DataMenorBanco)
        else
          sqlqtipo:=' and pend_datacont is null';
        try    // 21.06.06
          Vencimento:=Texttodate(FGeral.tirabarra( Grid.Cells[Grid.getcolumn('pend_datavcto'),p] ) );
        except
          Avisoerro('Problemas com vencimento '+Grid.Cells[Grid.getcolumn('pend_datavcto'),p]+' documento '+numerodoc);
          exit;
        end;
        Parceladoc:=Grid.Cells[Grid.getcolumn('pend_parcela'),p];  // 09.11.05
// 17.05.06
        try    // 21.06.06
          Emissao:=TExttodate( FGeral.tirabarra( Grid.Cells[Grid.getcolumn('pend_dataemissao'),p] ) );
        except
          Avisoerro('Problemas com emissão '+Grid.Cells[Grid.getcolumn('pend_dataemissao'),p]+' documento '+numerodoc);
          exit;
        end;

        if statusdoc='A' then begin
// 10.05.19
            if EdREcpag.text='P' then
                 sqlrecpag:='and pend_rp=''R'''
            else
                 sqlrecpag:='and pend_rp=''P''';
            QParcial:=sqltoquery('select sum(pend_valor) as bxparciais from pendencias where pend_tipo_codigo='+EdCodtipo.assql+
                'and '+FGeral.Getin('pend_status','A','C')+  // 11.08.08
                ' and pend_tipocad='+Edtipocad.assql+' and pend_numerodcto='+stringtosql(numerodoc)+sqlqtipo+
                sqlrecpag+
                ' and pend_unid_codigo='+stringtosql(unidadedoc)+
                ' and pend_dataemissao>='+Datetosql(emissao) );
//                ' and pend_datavcto='+Datetosql(vencimento) );

        end else begin

// 10.05.19
            if EdREcpag.text='P' then
                 sqlrecpag:='and pend_rp=''P'''
            else
                 sqlrecpag:='and pend_rp=''R''';
// 11.11.05 - por parcela ou vencimento
          QParcial:=sqltoquery('select sum(pend_valor) as bxparciais from pendencias '+
                  ' where pend_tipo_codigo='+EdCodtipo.assql+
                  ' and '+FGeral.Getin('pend_status','P','C')+  // 11.08.08
                  ' and pend_tipocad='+Edtipocad.assql+' and pend_numerodcto='+stringtosql(numerodoc)+sqlqtipo+
                  ' and pend_unid_codigo='+stringtosql(unidadedoc)+
                  ' and pend_dataemissao>='+Datetosql(emissao)+
                  sqlrecpag+
                  ' and pend_parcela='+parceladoc );
// 24.06.19 - traz o valor corrigido ate a data atual
          if FPlano.GetTipo( strtointdef(Grid.cells[Grid.getcolumn('pend_plan_conta'),p],0) ) = 'P' then begin

             vlrcorrigido:=GetMovimentoCPR( strtointdef(Grid.cells[Grid.getcolumn('pend_plan_conta'),p],0),Unidade,EmissaoDoc);
             vlrcorrigido:=vlrcorrigido + TextTovalor( Grid.cells[Grid.getcolumn('pend_valor'),p] );
             Grid.cells[Grid.getcolumn('pend_valor'),p ]:= floattostr(vlrcorrigido);

          end;

///////////////////////////////////////////
{           23.06.14 - retirado por vencimento devido a vencimento gravado errado na BP
          if QParcial.eof then begin
             Qparcial.close;
             Freeandnil(QParcial);
             QParcial:=sqltoquery('select sum(pend_valor) as bxparciais from pendencias where pend_tipo_codigo='+EdCodtipo.assql+
                  'and '+FGeral.Getin('pend_status','P','C')+  // 11.08.08
                  ' and pend_tipocad='+Edtipocad.assql+' and pend_numerodcto='+stringtosql(numerodoc)+sqlqtipo+
                  ' and pend_unid_codigo='+stringtosql(unidadedoc)+
                  ' and pend_dataemissao>='+Datetosql(emissao)+
                  ' and pend_datavcto='+Datetosql(vencimento) );
          end;
          }
///////////////////////////////////////////
{
          // 23.03.15 - coorlafs
           if (QParcial.fieldbyname('bxparciais').ascurrency=0) and (EdTipoCad.text='C') then begin
             Qparcial.close;
             Freeandnil(QParcial);
             QParcial:=sqltoquery('select sum(pend_valor) as bxparciais from pendencias where pend_tipo_codigo='+EdCodtipo.assql+
                  'and '+FGeral.Getin('pend_status','P','C')+  // 11.08.08
                  ' and pend_tipocad='+Edtipocad.assql+' and pend_numerodcto='+stringtosql(numerodoc)+sqlqtipo+
                  ' and pend_unid_codigo='+stringtosql(unidadedoc)+
                  ' and pend_dataemissao>='+Datetosql(emissao)+
                  ' and pend_observacao='+stringtosql('Pagamento Leite') );
           end;
           }
////////////////////
        end;
        if not QParcial.eof then begin
          Grid.Cells[Grid.getcolumn('bxparciais'),p]:=floattostr(QParcial.fieldbyname('bxparciais').ascurrency);
// 31.08.05 - para nao mostrar os ja baixados totalmente
//          if Grid.Cells[Grid.getcolumn('bxparciais'),p]=Grid.Cells[Grid.getcolumn('pend_valor'),p] then
//            Grid.DeleteRow(p);
         EdTotalparcial.setvalue(Edtotalparcial.ascurrency+QParcial.fieldbyname('bxparciais').ascurrency);
        end;
      end;
    end;
    Sistema.Endprocess('');

// 23.03.15
    Edliquido.setvalue(Edtotalvalor.ascurrency-Edtotalparcial.ascurrency);
    Grid.setfocus;

    Premessa.enabled:=false;
    pCONTAbaixa.enabled:=false;

// 08.08.05 - provisorio ate colocar no cadastro de unidades -Idete
//    if (EdRecPag.text='R') and (Global.CodigoUnidade=Global.unidadematriz) then begin
//      EdContaDesrec.setvalue(84);
//      EdHist_codigo.text:='2';
//    end;
// 01.06.07
    EdHist_codigo.text:='1';
// 26.11.12 - Vivan
    if (EdRecPag.text='R') and (FGeral.GetConfig1AsInteger('codigohistrec')>0) then
      edHist_codigo.setvalue(FGeral.GetConfig1AsInteger('codigohistrec'))
    else if (EdRecPag.text='P') and (FGeral.GetConfig1AsInteger('codigohistpag')>0) then
      edHist_codigo.setvalue(FGeral.GetConfig1AsInteger('codigohistpag'));
    edHist_codigo.validfind;

// 18.05.20  - Novicarnes - 'as vezes puxava as vezes nao...'
    if ( Global.Topicos[1511] )
              and (
              ( Ansipos('MANUTEN', FPlano.GetDescricao( strtointdef(Grid.Cells[Grid.getcolumn('pend_plan_conta'),Grid.row],0) ) ) >0 )
               or
              ( Ansipos('COMBUST', FPlano.GetDescricao( strtointdef(Grid.Cells[Grid.getcolumn('pend_plan_conta'),Grid.row],0) ) ) > 0 )
              )
                then

        EdHist_complemento.text:=GetPlaca( Grid.Cells[Grid.getcolumn('pend_operacao'),Grid.row] )+' '+
                                Grid.Cells[Grid.getcolumn('pend_numerodcto'),Grid.row]+
                                '-'+trim(Grid.Cells[Grid.getcolumn('pend_parcela'),Grid.row])+
                                ' '+SetEdfavorecido.text ;


    if (EdRecPag.text='R') and (FGeral.GetConfig1AsInteger('Ctabaixarec')>0) then begin
      EdContaDesrec.setvalue(FGeral.GetConfig1AsInteger('Ctabaixarec'));
      EdContaDesrec.validfind;
    end else if (EdRecPag.text='P') and (FGeral.GetConfig1AsInteger('Ctabaixapag')>0) then begin
      EdContaDesrec.setvalue(FGeral.GetConfig1AsInteger('Ctabaixapag'));
      EdContaDesrec.validfind;
    end;
// 02.08.07
    EdPlan_conta.setvalue(Arq.TUnidades.fieldbyname('unid_contacontabil').asinteger);
    if (EdRecPag.text='R') and (FGeral.GetConfig1AsInteger('Ctacaixabaixarec')>0) then begin
      EdPlan_conta.setvalue( FGeral.GetConfig1AsInteger('Ctacaixabaixarec') );
      EdPlan_conta.validfind;
    end else if (EdRecPag.text='P') and (FGeral.GetConfig1AsInteger('Ctacaixabaixapag')>0) then begin
      EdPlan_conta.setvalue( FGeral.GetConfig1AsInteger('Ctacaixabaixapag') );
      EdPlan_conta.validfind;
    end;

  end;

end;

procedure TFBaixaPendencia.EdDtBaixaValidate(Sender: TObject);
/////////////////////////////////////////////////////////
var dataemissao,datamovimento:TDatetime;
begin

  Grid.Enabled:=false;
  EdAntecipa.text:='N';
  if not escolheugrid then begin

    Grid.Enabled:=true;
    EdDtBaixa.Invalid('Escolher uma operação para a baixa');

  end else begin

    Dataemissao:=Texttodate( FGeral.tirabarra(Grid.cells[Grid.getcolumn('pend_dataemissao'),Grid.row]) );
    Datamovimento:=Texttodate( FGeral.tirabarra(Grid.cells[Grid.getcolumn('pend_datamvto'),Grid.row]) );
    if Grid.cells[Grid.getcolumn('pend_status'),Grid.row]='N' then
      EdAntecipa.text:='N'
    else
      EdAntecipa.text:='S';
    if (not Global.Usuario.OutrosAcessos[0702]) and (eddtbaixa.asdate<>sistema.hoje) then
      EdDtbaixa.invalid('Data da baixa deve ser a data corrente ('+formatdatetime('dd/mm/yy',sistema.hoje)+')')
// 12.11.07
    else if EdDtBaixa.AsDate<DataEmissao then
      EdDtbaixa.invalid('Data da baixa deve ser POSTERIOR a data de emissão ('+formatdatetime('dd/mm/yy',dataemissao)+')')
// 08.01.07 - 06.08.08 - retirado - Carli - salete
//    else if EdDtBaixa.AsDate<DataMovimento then
//      EdDtbaixa.invalid('Data da baixa deve ser POSTERIOR a data de movimento ('+formatdatetime('dd/mm/yy',datamovimento)+')')

// 19.08.20  - Novicarnes - para poder fazer as 'baixas adiantadas
    else if EdDtBaixa.asdate <= Sistema.hoje then begin

       if not FGeral.ValidaMvto(EdDtBaixa) then

          EdDtBaixa.Invalid('');

    end;

  end;

  EdBomPara.SetDate(EdDtBaixa.AsDate);
// 06.06.07
      if ( texttovalor(Grid.cells[Grid.getcolumn('pend_plan_conta'),Grid.row])<>0 ) and
         ( texttovalor(Grid.cells[Grid.getcolumn('pend_plan_conta'),Grid.row])<>99999 )
        then begin
        EdContaDesrec.text:=Grid.cells[Grid.getcolumn('pend_plan_conta'),Grid.row];
        EdContaDesrec.validfind;
      end;
      if trim(copy(Grid.cells[Grid.getcolumn('pend_datacont'),Grid.row],1,2))<>'' then
        EdDtMovimento.setdate(texttodate(FGeral.tirabarra(Grid.cells[Grid.getcolumn('pend_datacont'),Grid.row])))
      else
        EdDtmovimento.text:='';
    end;
    if Global.Usuario.OutrosAcessos[0715] then begin
      if EdContaDesrec.AsInteger=0 then
        EdContaDesrec.Enabled:=true
      else
        EdContaDesrec.Enabled:=false;
    end else
      EdContaDesrec.Enabled:=true;
  end;
end;

procedure TFBaixaPendencia.EdDescontosValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////////////////////
begin
// EdPlan_conta.setfocus;
//  if (EdDescontos.ascurrency=0) and (  EdVAlor.ascurrency<valortitulo ) then begin
// 06.10.05 - para poder dar desconto ou juros em baixa parcial
//  if (  (EdVAlor.ascurrency)<valortitulo ) then begin
// 06.08.07 - a ultima ainda tem q 'ser parcial' pra ficar certo a baixa td...
  if ( (EdVAlor.ascurrency+EdDescontos.ascurrency)<valortitulo ) then begin
//    Edbaixaparcial.enabled:=true;
    Edbaixaparcial.text:='S';
// 11.09.08
  end else if baixouparcial then begin
    Edbaixaparcial.text:='S';
//  end else if ( (EdVAlor.ascurrency+EdDescontos.ascurrency)>valortitulo ) and (EdDescontos.ascurrency>0)  then begin
//    EdDescontos.Invalid('Valor menor.   Informar o valor líquido (efetivamente rec./pago)' );
//  end else if ( (EdVAlor.ascurrency-EdJuromora.ascurrency)<valortitulo ) and (EdJuromora.ascurrency>0) then begin
//    EdDescontos.Invalid('Valor maior.   Informar o valor líquido (efetivamente rec./pago)' );
  end else begin
    Edbaixaparcial.enabled:=false;
    Edbaixaparcial.text:='N';
  end;
  if (EdDescontos.ascurrency>0) and (Global.Topicos[1252]) then
     EdContadescontos.Enabled:=true
  else
     EdContadescontos.Enabled:=false;

end;

procedure TFBaixaPendencia.EdTipocadValidate(Sender: TObject);
begin

  EdRecpag.text:='P';
  EdQuemPagou.text:='C';
  if EdTipoCad.text='U' then begin
    EdCodtipo.ShowForm:='FUnidades';
    EdCodtipo.FindTable:='unidades';
    EdCodtipo.FindField:='unid_codigo';
  end else if EdTipoCad.text='C' then begin
    EdCodtipo.ShowForm:='FCadcli';
    EdCodtipo.FindTable:='clientes';
    EdCodtipo.FindField:='clie_codigo';
    EdRecpag.text:='R';
  end else if EdTipoCad.text='F' then begin
    EdCodtipo.ShowForm:='FFornece';
    EdCodtipo.FindTable:='fornecedores';
    EdCodtipo.FindField:='forn_codigo';
  end else if EdTipoCad.text='T' then  begin
    EdCodtipo.ShowForm:='FTransp';
    EdCodtipo.FindTable:='transportadores';
    EdCodtipo.FindField:='tran_codigo';
  end else if EdTipoCad.text='R' then begin
    EdCodtipo.ShowForm:='FRepresentantes';
    EdCodtipo.FindTable:='representantes';
    EdCodtipo.FindField:='repr_codigo';
    EdRecpag.text:='R';
  end else begin
//    EdCodtipo.ShowForm:='';
//    EdCodtipo.FindTable:='';
//    EdCodtipo.FindField:='';
    EdCodtipo.ShowForm:='FCadcli';
    EdCodtipo.FindTable:='clientes';
    EdCodtipo.FindField:='clie_codigo';
  end;
end;

procedure TFBaixaPendencia.EdCodtipoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////
begin
//  SetEdFavorecido.Text:=FGeral.GetNomeTipoCad(EdCodtipo.asinteger,EdTipoCad.text);
// 07.10.05
  if not EdCodtipo.IsEmpty then begin
//    SetEdFavorecido.Text:=FGeral.getnomerazaosocialentidade(EdCodtipo.asinteger,EdTipoCad.text,'N');
// 27.01.10 - novicarnes - vava - pra ir razao social pra ctb
    SetEdFavorecido.Text:=FGeral.getnomerazaosocialentidade(EdCodtipo.asinteger,EdTipoCad.text,'R');
    valortitulo:=0;
    if trim(SetEdFavorecido.Text)='' then
      EdCodTipo.Invalid('Não encontrado codigo do tipo '+EdTipoCad.text)
//    else if not FGeral.TemContaContabil(EdCodTipo.asinteger,EdtipoCad.text,Unidade,'FIN') then begin
//      EdCodtipo.invalid('');
//    end;
  end else begin

    SetEdFavorecido.Text:='Diversos';

  end;

  Grid.Enabled:=false;
  posicaoantecipa:=0;
  EdChequerec.text:='';
  Chequeemirec:='E';

end;

procedure TFBaixaPendencia.GridClick(Sender: TObject);
//////////////////////////////////////////////////////////
var QBxparcial:TSqlquery;
    sqlqtipo:string;
    vencimento,emissao,vencimentoori,datamvto:TDatetime;
    vlrantecipa,valorjuros:currency;
begin
//  Grid.Enabled:=false;
  if ( Grid.cells[Grid.getcolumn('pend_operacao'),Grid.Row]='' ) or ( Grid.cells[Grid.Col,Grid.Row]='0' ) then exit;
// 23.02.08
  if ( Grid.col=Grid.getcolumn('marcado') ) and (Grid.cells[Grid.getcolumn('pend_operacao'),Grid.row]<>'') then begin
     if Grid.cells[Grid.getcolumn('marcado'),Grid.row]='Ok' then begin
       Grid.cells[Grid.getcolumn('marcado'),Grid.row]:='';
     end else begin
       Grid.cells[Grid.getcolumn('marcado'),Grid.row]:='Ok';
     end;
     exit;
  end;
  sqlqtipo:='';
  GridtoEdits;
  if texttodate(FGeral.tirabarra(Grid.cells[Grid.getcolumn('pend_datacont'),Grid.row])) > 0 then
    sqlqtipo:=' and pend_datacont > '+DatetoSql(Global.DataMenorBanco)
  else
    sqlqtipo:=' and pend_datacont is null';

  Numerodoc:=0;
  valortitulo:=0;   // 24.10.05
  valorjuros:=0;
  if Grid.cells[Grid.getcolumn('bxparciais'),grid.row]='OK' then
    Avisoerro('Pendencia já baixada')
  else begin
    EdOperacao.text:=Grid.Cells[Grid.getcolumn('pend_operacao'),Grid.row];
    try
      Vencimento:=Texttodate( FGeral.tirabarra(Grid.Cells[Grid.getcolumn('pend_datavcto'),Grid.row]) );
      vencimentoori:=Texttodate( FGeral.tirabarra(Grid.Cells[Grid.getcolumn('pend_datavctoori'),Grid.row]) );
      datamvto:=Texttodate( FGeral.tirabarra(Grid.Cells[Grid.getcolumn('pend_datamvto'),Grid.row]) );
    except
      Avisoerro('Problemas com vencimento '+Grid.Cells[Grid.getcolumn('pend_datavcto'),Grid.row]);
      exit;
    end;
// 22.05.06
    Emissao:=TExttodate( FGeral.tirabarra( Grid.Cells[Grid.getcolumn('pend_dataemissao'),Grid.row] ) );
// 01.10.05
    unidadedoc:=Grid.Cells[Grid.getcolumn('pend_unid_codigo'),Grid.row];
    statusdoc:=Grid.Cells[Grid.getcolumn('pend_status'),Grid.row];

// 11.08.08 - antecipacoes
   if statusdoc='A' then begin

      if EdREcpag.text='P' then
        sqlrecpag:='and pend_rp=''R'''
      else
         sqlrecpag:='and pend_rp=''P''';
      QBxparcial:=sqltoquery('select * from pendencias where pend_status=''A'' and pend_tipo_codigo='+EdCodtipo.assql+
  //                           ' and pend_databaixa<='+EdDtbaixa.assql+' and pend_tipocad='+Edtipocad.assql+
                             ' and pend_tipocad='+Edtipocad.assql+
                             sqlrecpag+
//                             ' and pend_datavcto='+Datetosql(vencimento)+
//                             ' and pend_parcela='+Grid.Cells[Grid.getcolumn('pend_parcela'),Grid.row]+
                             ' and pend_dataemissao>='+Datetosql(emissao)+
                             ' and pend_unid_codigo='+stringtosql(unidadedoc)+
                             ' and pend_numerodcto='+stringtosql(Grid.Cells[Grid.getcolumn('pend_numerodcto'),Grid.row]) );
   end else begin
// 21.05.19 - devido as CPR
      if EdREcpag.text='P' then
        sqlrecpag:='and pend_rp=''P'''
      else
         sqlrecpag:='and pend_rp=''R''';
  // 11.11.05 - por parcela ou vencimento
      QBxparcial:=sqltoquery('select * from pendencias where pend_status=''P'' and pend_tipo_codigo='+EdCodtipo.assql+
  //                           ' and pend_databaixa<='+EdDtbaixa.assql+' and pend_tipocad='+Edtipocad.assql+
                             ' and pend_tipocad='+Edtipocad.assql+sqlqtipo+
                             ' and pend_parcela='+Grid.Cells[Grid.getcolumn('pend_parcela'),Grid.row]+
                             ' and pend_dataemissao>='+Datetosql(emissao)+
                             ' and pend_unid_codigo='+stringtosql(unidadedoc)+
                             sqlrecpag+
                             ' and pend_numerodcto='+stringtosql(Grid.Cells[Grid.getcolumn('pend_numerodcto'),Grid.row]) );
//////////////////////////////////////
// 23.06.14 - retirado busca por vencimento pois vencimento as vezes fica errado na BP - vivan
      {
      if QBxparcial.eof then begin
        QBxparcial.close;
        Freeandnil(QBxparcial);
        QBxparcial:=sqltoquery('select * from pendencias where pend_status=''P'' and pend_tipo_codigo='+EdCodtipo.assql+
  //                           ' and pend_databaixa<='+EdDtbaixa.assql+' and pend_tipocad='+Edtipocad.assql+
                             ' and pend_tipocad='+Edtipocad.assql+sqlqtipo+
                             ' and pend_datavcto='+Datetosql(vencimento)+
                             ' and pend_dataemissao>='+Datetosql(emissao)+
                             ' and pend_unid_codigo='+stringtosql(unidadedoc)+
                             ' and pend_numerodcto='+stringtosql(Grid.Cells[Grid.getcolumn('pend_numerodcto'),Grid.row]) );
      end;
      }
////////////////////////////////
    end;
    valortitulo:=texttovalor( Grid.Cells[Grid.getcolumn('pend_valor'),Grid.row] );
    if not QBxparcial.eof then begin
      while not QBxparcial.eof do begin
        valortitulo:=valortitulo-Qbxparcial.fieldbyname('pend_valor').ascurrency;
        QBxparcial.next;
        baixafinalparcial:='S';
      end;
    end;
    Qbxparcial.close;
    Freeandnil(Qbxparcial);
    Numerodoc:=strtointdef(Grid.Cells[Grid.getcolumn('pend_numerodcto'),Grid.row],0);

    Sistema.beginprocess('Pesquisando antecipações');
    QAntecipa:=sqltoquery('select pend_valor,pend_rp from pendencias where '+FGeral.GetIN('pend_status','A','C')+
                ' and pend_tipo_codigo='+EdCodTipo.AsSql+sqlqtipo );
    vlrantecipa:=0;
    while not QAntecipa.eof do begin
      if QAntecipa.fieldbyname('pend_rp').asstring='P' then
            vlrantecipa:=vlrantecipa + (-1)*QAntecipa.FieldByName('pend_valor').Ascurrency
      else
            vlrantecipa:=vlrantecipa + QAntecipa.FieldByName('pend_valor').Ascurrency;
      QAntecipa.Next;
    end;
    QAntecipa.close;
    Freeandnil(QAntecipa);
    EdVlrantecipa.setvalue(vlrantecipa);
    EdVlrantecipa.update;
    Sistema.endprocess('');

// 28.06.06 - esta checagem devido cagada na estrutura da tabela pendencias ...not nul e valor defaul now..
// calcula juros a partir do 'vencimento original'
//                                    // 19.11.12 - Vivan
    if (vencimentoori<=vencimento) and (vencimentoori>0) then
      valorjuros:=FGeral.GetValorJuros(valortitulo,vencimentoori,sistema.hoje,EdRecpag.text)
    else
      valorjuros:=FGeral.GetValorJuros(valortitulo,vencimento,sistema.hoje,EdRecpag.text);
// 04.11.17
    if Grid.Cells[Grid.getcolumn('pend_tipomov'),Grid.row]=Global.CodCedulaProdutoRural then
      valorjuros:=FGeral.GetValorJuros(valortitulo,vencimento,sistema.hoje,EdRecpag.text,emissao,Global.CodCedulaProdutoRural);

    SetEdjuromora.setvalue(valorjuros);
    EscolheuGrid:=true;
    if marc<=1 then begin
      EdValor.setvalue(valortitulo);
      EdVlratualizado.setvalue(valortitulo+valorjuros);
    end else begin
      EdValor.setvalue(valortitulos);  // 23.02.08
    end;
// 06.11.12 - vivan
    EdPort_codigo.Text:=Grid.Cells[Grid.getcolumn('pend_port_codigo'),Grid.row];
    EdPort_codigo.validfind;
// 07.05.15
    EdChequerec.text:='';

///////////    GridtoEdits;
    if EdDtbaixa.asdate<=1 then

      EdDtbaixa.setdate(Sistema.hoje);

    if not Escolheugrid then
      EdRecpag.SetFocus
    else  begin
      if EdRecpag.text='R' then   // 03.08.06
        Edquempagou.setfocus
      else
        EdDtBaixa.setfocus;
    end;
    bboleto.Enabled:=true;
  end;
end;

procedure TFBaixaPendencia.GridtoEdits;
///////////////////////////////////////////////
var p:integer;
    numeros:string;
    QOper  :TSqlquery;

begin

  marc:=0;numeros:='';Valortitulos:=0;OPeracoesMarc:='';NotasMarc:='';
  baixouparcial:=false;
  for p:=1 to Grid.RowCount do begin

    if ( Grid.cells[Grid.getcolumn('marcado'),p] ='Ok' ) and ( Grid.cells[Grid.getcolumn('pend_operacao'),p]  <> '' )  then begin
      inc(marc);
      numeros:=numeros+trim(Grid.Cells[Grid.getcolumn('pend_numerodcto'),p])+'-'+trim(Grid.Cells[Grid.getcolumn('pend_nparcelas'),p])+', ';
      if Texttovalor( Grid.Cells[Grid.getcolumn('parcialgrid'),p] ) >0 then
        Valortitulos:=valortitulos+Texttovalor( Grid.Cells[Grid.getcolumn('parcialgrid'),p] )
      else
        Valortitulos:=valortitulos+TExttovalor( Grid.Cells[Grid.getcolumn('pend_valor'),p] )  -
                        Texttovalor( Grid.Cells[Grid.getcolumn('bxparciais'),p] ) ;
      OPeracoesMarc:=OPeracoesMarc+Grid.cells[Grid.getcolumn('pend_operacao'),p]+';';
      NotasMarc:=NotasMarc+strzero(strtointdef(Grid.cells[Grid.getcolumn('pend_numerodcto'),p],0),6)+';';
      if Texttovalor( Grid.Cells[Grid.getcolumn('parcialgrid'),p] ) >0 then
        baixouparcial:=true;
    end;
  end;
// 09.08.16 - retirado esta 'M' pra sempre fazer o historico
//  if Global.Topicos[1105] then
//      EdHist_complemento.text:=''
//  else begin
    if marc<=1 then begin

      if Global.Topicos[1279] then begin
        EdHist_complemento.text:=GetCampo('pendencias','pend_status','N','pend_operacao','pend_complemento',Grid.Cells[Grid.getcolumn('pend_operacao'),Grid.row]);
        if trim(EdHist_complemento.text)='' then
          EdHist_complemento.text:=Grid.Cells[Grid.getcolumn('pend_numerodcto'),Grid.row]+'-'+trim(Grid.Cells[Grid.getcolumn('pend_parcela'),Grid.row])+' '+SetEdfavorecido.text

// 18.10.19
      end else if ( Global.Topicos[1511] )
              and (
              ( Ansipos('MANUTEN', FPlano.GetDescricao( strtointdef(Grid.Cells[Grid.getcolumn('pend_plan_conta'),Grid.row],0) ) ) >0 )
               or
              ( Ansipos('COMBUST', FPlano.GetDescricao( strtointdef(Grid.Cells[Grid.getcolumn('pend_plan_conta'),Grid.row],0) ) ) > 0 )
              )
                then begin

        EdHist_complemento.text:=GetPlaca( Grid.Cells[Grid.getcolumn('pend_operacao'),Grid.row] )+' '+
                                Grid.Cells[Grid.getcolumn('pend_numerodcto'),Grid.row]+
                                '-'+trim(Grid.Cells[Grid.getcolumn('pend_parcela'),Grid.row])+
                                ' '+SetEdfavorecido.text

      end else

        EdHist_complemento.text:=Grid.Cells[Grid.getcolumn('pend_numerodcto'),Grid.row]+'-'+trim(Grid.Cells[Grid.getcolumn('pend_parcela'),Grid.row])+' '+SetEdfavorecido.text

    end else begin
// 17.07.09
      if (Global.Topicos[1267]) and (Edtipocad.text='R') then begin
        EdHist_complemento.text:='Baixas Diversas '+SetEdfavorecido.text+' '+copy(numeros,1,EdHist_complemento.MaxLength-length(trim('Baixas Diversas '+SetEdfavorecido.text))-2 );
//      end else if length(numeros+' '+SetEdfavorecido.text) > EdHist_complemento.MaxLength then
//        EdHist_complemento.text:=copy(numeros,1,EdHist_complemento.MaxLength-length(trim(SetEdfavorecido.text))-2 )+' '+SetEdfavorecido.text
//        EdHist_complemento.text:=copy(numeros,1,EdHist_complemento.MaxLength-length(trim(SetEdfavorecido.text))-2 )+' '+SetEdfavorecido.text
//        EdHist_complemento.text:=trim(copy(numeros,1,70))+' '+copy(SetEdfavorecido.text,1,25);
      end else
        EdHist_complemento.text:=trim(copy(numeros,1,70))+' '+copy(SetEdfavorecido.text,1,25);
    end;
// 28.06.13 - Novicarnes - Elize
    if length(trim(EdHist_complemento.text))>100 then EdHist_complemento.text:=copy(EdHist_complemento.text,1,100);
// 13.08.19 - Alutech - Robson + fran
    if Global.Topicos[1365] then begin
       if Grid.Cells[Grid.Getcolumn('pend_seto_codigo'),Grid.row]='9999' then

          EdDesc_setor.text:='Diversos'

       else

          EdDesc_setor.text:=FSetores.GetDescricao( Grid.Cells[Grid.Getcolumn('pend_seto_codigo'),Grid.row] );

    end;
// 08.02.19 - Novicarnes - Sandro
    if ( EdCodtipo.IsEmpty ) and ( Global.Topicos[1300] ) then begin

        QOper:=sqltoquery('select pend_tipo_codigo from pendencias where pend_operacao='+
                           Stringtosql( Grid.cells[Grid.getcolumn('pend_operacao'),Grid.Row] ) );
        SetEdFavorecido.Text:=FGeral.GetNomeRazaoSocialEntidade(QOper.FieldByName('pend_tipo_codigo').AsInteger,EdTipocad.Text,'R');
        FGeral.FechaQuery(QOper);

    end;
// 24.09.19 - Novicarnes - sandro
    if ( (Global.Usuario.OutrosAcessos[0725]) and ( EdRecPag.Text='P' ) ) then EdDtBaixa.SetDate( Texttodate( FGeral.tirabarra(Grid.Cells[Grid.getcolumn('pend_datavcto'),Grid.row]) ) );

//  end;
end;

procedure TFBaixaPendencia.EdValorValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////
var vencimento,vencimentoori,datamvto,emissao:TDatetime;
begin
  try    // 21.06.06
      Vencimento:=Texttodate(FGeral.tirabarra( Grid.Cells[Grid.getcolumn('pend_datavcto'),grid.row] ) );
      vencimentoori:=Texttodate( FGeral.tirabarra(Grid.Cells[Grid.getcolumn('pend_datavctoori'),Grid.row]) );
      datamvto:=Texttodate( FGeral.tirabarra(Grid.Cells[Grid.getcolumn('pend_datamvto'),Grid.row]) );
      emissao:=Texttodate(FGeral.tirabarra( Grid.Cells[Grid.getcolumn('pend_dataemissao'),grid.row] ) );
  except
          Avisoerro('Problemas com vencimento '+Grid.Cells[Grid.getcolumn('pend_datavcto'),grid.row]);
          exit;
 end;
  if (EdVAlor.ascurrency>valortitulo) and (marc<=1) then begin
    SetEdJuroMora.SetValue(EdVAlor.ascurrency-valortitulo);
    EdJuroMora.setvalue(EdVAlor.ascurrency-valortitulo);
    SetEdDesconto.SetValue(0);
    EdDescontos.SetValue(0);
// 19.12.13 - Metalforte - Rosangela
    EdVlrAtualizado.SetValue(EdValor.AsCurrency+EdJuromora.AsCurrency);
  end else if (EdVlrAtualizado.ascurrency>EdVAlor.ascurrency) and (marc>=2) then begin
    SetEdJuroMora.SetValue(EdVlrAtualizado.ascurrency-EdVAlor.ascurrency);
    EdJuroMora.setvalue(EdVlrAtualizado.ascurrency-EdVAlor.ascurrency);
    SetEdDesconto.SetValue(0);
    EdDescontos.SetValue(0);
  end else if (EdVAlor.ascurrency<=valortitulo) and (marc<=1) then begin
//    EdDescontos.SetValue(valortitulo-EdVAlor.ascurrency);
// 03.06.04 - retirado devido filiais errando na digitacao
    EdDescontos.SetValue(0);
//    SetEdJuroMora.SetValue(0);
//    EdJuroMora.setvalue(0);
// 28.06.06
//    EdJuroMora.setvalue(FGeral.GetValorJuros(Edvalor.ascurrency,vencimento,EdDtbaixa.asdate,EdRecpag.text) );
// 28.06.06 - esta checagem devido cagada na estrutura da tabela pendencias ...not nul e valor defaul now..
// calcula juros a partir do 'vencimento original'
//    if (vencimentoori<=vencimento) then
//                                    // 26.11.12 - Vivan
    if (vencimentoori<=vencimento) and (vencimentoori>0) then
      EdJuroMora.setvalue(FGeral.GetValorJuros(valortitulo,vencimentoori,EdDtbaixa.asdate,EdRecpag.text))
    else
      EdJuroMora.setvalue(FGeral.GetValorJuros(valortitulo,vencimento,EdDtbaixa.asdate,EdRecpag.text));
// 04.11.17
    if Grid.Cells[Grid.getcolumn('pend_tipomov'),Grid.row]=Global.CodCedulaProdutoRural then
      EdJuroMora.setvalue( FGeral.GetValorJuros(valortitulo,vencimento,sistema.hoje,EdRecpag.text,emissao,Global.CodCedulaProdutoRural));

    SetEdJuroMora.SetValue(EdJuroMora.ascurrency);
    SetEdDesconto.SetValue(valortitulo-EdVAlor.ascurrency);
  end else if (EdVAlor.ascurrency<=valortitulos) and (marc>=2) then begin
    EdDescontos.SetValue(0);
//    SetEdJuroMora.SetValue(0);
//    EdJuroMora.setvalue(0);
      EdJuroMora.setvalue(0);
      SetEdJuroMora.SetValue(EdJuroMora.ascurrency);
      SetEdDesconto.SetValue(valortitulos-EdVAlor.ascurrency);
  end else begin
    SetEdJuroMora.SetValue(0);
    SetEdDesconto.SetValue(0);
  end;
end;


////////////////////////////////////////////////////////////////////////
procedure TFBaixaPendencia.bGravarClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////
var p,cheque,ContaDescontos,ContaJuros,ContaDescontosTarifaban,codrepr,NUmerotitulo,ry,ClienteTitulo,i,debito,credito,
    caixafilial,codforne,
    rr:integer;
    Transacao,xEntsai,descjuros,descdescontos,TipoBaixaMultipla,sqlemissao,OPbaixaparcial,xtransacoes,
    xnumerostitulo,sqlrepres,TransacaoTitulo,tipocad,transacaocontax,clifor,campos,valores:string;
    vlrantecipa,valortitulo,perbaixa,valorcomissaopagar,valorparcela:currency;
    QBxparcial,QAntec,QTitulo,QB,QUnid_codigo:TSqlquery;
    Emissaotitulo:tdatetime;
    Lista,ListaCheques:TStringList;


    procedure BaixaPendencia;
    ////////////////////////
    begin
      Sistema.Edit('Pendencias');
      Sistema.SetField('pend_status','B');
//  pend_dataautpgto date,
//  pend_plan_conta numeric(8, 0) NOT NULL,
      Sistema.SetField('pend_mora',EdJuroMora.AsCurrency);
      Sistema.SetField('pend_descontos',EdDescontos.AsCurrency);
      Sistema.SetField('pend_transbaixa',Transacao);
      Sistema.SetField('pend_contabaixa',EdPlan_conta.AsInteger);
      Sistema.SetField('pend_databaixa',EdDtbaixa.AsDate);
// 02.08.06
      Sistema.SetField('pend_observacao',QuemPagou(EdQuempagou.text));
      Sistema.SetField('pend_usubaixa',Global.Usuario.codigo);
// 30.05.05 - rever
      if baixafinalparcial='S' then
        Sistema.SetField('pend_valor',EdValor.ascurrency);
// 04.03.08
      Sistema.SetField('pend_complemento',EdHist_complemento.text);
// 06.11.12 - Vivan
      if ( not EdPort_codigo.isempty ) and ( Global.topicos[1284] ) then
        Sistema.SetField('pend_port_codigo',EdPort_codigo.text);

//  pend_impresso numeric(8, 0),
//  pend_imprdcto varchar(1),
      Sistema.Post('pend_status=''N'' and pend_operacao='+EdOperacao.AsSql+' and pend_tipo_codigo='+EdCodtipo.AsSql);

(*
// 19.09.16
      if ( Global.topicos[1045] ) and ( not EdDtMovimento.isempty ) then begin
        codforne:=EdCodtipo.asinteger;
        if EdRecPag.text='R' then begin

          debito:=FPlano.GetContaExportacao(EdPlan_conta.asinteger,Unidade);
          credito:=QUnid_codigo.fieldbyname('unid_clientes').asinteger;
          if Global.Topicos[1253] then begin
               if codforne>0 then begin
                 if tipocad='C' then begin
                   if EdDtMovimento.isempty then begin
                     credito:=FCadcli.GetContaExp(codforne,'','XX');
                   end else if FCadcli.Getecooperado(codforne) then begin
                     credito:=FCadcli.GetContaExp(codforne,'','XY');
                   end else begin
                     credito:=FCadcli.GetContaExp(codforne);
                   end;
                 end else if tipocad='F' then begin
                   credito:=FFornece.GetContaExp(codforne,Unidade);
                 end;
              end;
          end;

        end else begin

            credito:=QUnid_codigo.fieldbyname('unid_caixa').asinteger;
            if EdPlan_conta.asinteger<>CaixaFilial then begin
               credito:=FPlano.GetContaExportacao(EdPlan_conta.asinteger,Unidade);
            end;
            debito:=QUnid_codigo.fieldbyname('unid_compras').asinteger;
            if ( pos(tipomov,Global.CodCompra+';'+Global.CodCompraMatConsumo+';'+Global.CodCompra100)>0  )
                 and ( EdPlan_conta.asinteger=CaixaFilial ) then begin
                debito:=QUnid_codigo.fieldbyname('unid_comprasavista').asinteger;
            end;
            if Global.Topicos[1253] then begin
                 if codforne>0 then begin
                   if tipocad='C' then begin
                     debito:=FCadcli.GetContaExp(codforne,Unidade);
                   end else if tipocad='R' then begin
                     debito:=FRepresentantes.GetContaExp(codforne,Unidade);
                   end else begin
                     debito:=FFornece.GetContaExp(codforne,Unidade);
                   end;
                   if debito=99999 then begin
                     if EdContaDesrec.asinteger>0 then
                       debito:=FPlano.GetContaExportacao(EdContaDesrec.asinteger,Unidade)
                     else
                       debito:=FPlano.GetContaExportacao(EdContaDesrec.asinteger,Unidade);
                   end;
                 end;
            end;

        end;
        campos:='mcon_transacao,mcon_operacao,mcon_status,mcon_unid_codigo,mcon_pcon_conta,mcon_datamvto,mcon_datalcto,mcon_dc,'+
              'mcon_valor,mcon_zeramento,mcon_hist_codigo,mcon_complemento,mcon_numerodcto';
        clifor:=EdHist_complemento.text;
        valorparcela:=EdValor.ascurrency;
        if (debito>0) and (credito>0) and (valorparcela>0) then begin
          valores:=Stringtosql(transacaocontax)+','+Stringtosql(transacaocontax+'1')+','+Stringtosql('N')+','+Stringtosql(Unidade)+','+Stringtosql(inttostr(debito))+','+Datetosql(EdDtbaixa.AsDate)+','+Datetosql(Sistema.Hoje)+','+
                   Stringtosql('D')+','+Valortosql(valorparcela)+','+Stringtosql('2')+','+Stringtosql(' ')+','+Stringtosql('Baixa '+clifor)+','+
                   Stringtosql(EdOperacao.text);
          FGeral.SistemaContax.ExecuteDirect(' Insert into movcon ('+campos+') values ('+valores+')' );
          valores:=Stringtosql(transacaocontax)+','+Stringtosql(transacaocontax+'2')+','+Stringtosql('N')+','+Stringtosql(Unidade)+','+Stringtosql(inttostr(credito))+','+Datetosql(EdDtbaixa.AsDate)+','+Datetosql(Sistema.Hoje)+','+
                   Stringtosql('C')+','+Valortosql(valorparcela)+','+Stringtosql('2')+','+Stringtosql(' ')+','+Stringtosql('Baixa '+clifor)+','+
                   Stringtosql(EdOperacao.text);
          FGeral.SistemaContax.ExecuteDirect(' Insert into movcon ('+campos+') values ('+valores+')' );
        end;

      end;
      *)

    end;

// 06.10.10
    function GetTransacaoTitulo(xoperacao:string):string;
    ////////////////////////////////////////////////////
    var Q:TSqlquery;
    begin
      Q:=Sqltoquery('select pend_transacao from pendencias where pend_operacao='+Stringtosql(xoperacao)+
                    ' and pend_status<>''C''');
      if not Q.Eof then
        result:=Q.fieldbyname('pend_transacao').AsString
      else
        result:='';
      FGeral.FechaQuery(Q);
    end;

    procedure BaixaAntecipacao;
    //////////////////////////////////
    var Q1,Q:TSqlquery;
        vlrantecipa,vlrantecipabx:currency;
    begin

      Sistema.Edit('Pendencias');
      Sistema.SetField('pend_status','E');
      Sistema.SetField('pend_mora',0);
      Sistema.SetField('pend_descontos',0);
      Sistema.SetField('pend_transbaixa',Transacao);
      Sistema.SetField('pend_contabaixa',0);
      Sistema.SetField('pend_databaixa',EdDtbaixa.AsDate);
// 02.08.06
      Sistema.SetField('pend_observacao',QuemPagou(EdQuempagou.text));
      Sistema.SetField('pend_usubaixa',Global.Usuario.codigo);
      Sistema.Post('pend_tipo_codigo='+EdCodtipo.AsSql+' and '+FGeral.getin('pend_status','D','C')+
                   ' and pend_numerodcto='+inttostr(Numerodoc)+' and pend_parcela='+stringtosql(Grid.Cells[Grid.Getcolumn('pend_parcela'),Grid.row]) );
// 28.07.05
///////////
      Q1:=sqltoquery('select pend_operacao from pendencias where pend_operacao='+stringtosql(Grid.cells[Grid.getcolumn('opantecipa'),Grid.row]));
      if not Q1.eof then begin
        pendopantecipa:=Q1.fieldbyname('pend_operacao').asstring;
        Q:=sqltoquery('select * from pendencias where pend_tipo_codigo='+EdCodtipo.AsSql+' and '+FGeral.getin('pend_status','A','C')+
                       ' and pend_operacao='+stringtosql(pendopantecipa ));
        if not Q.eof then
          vlrantecipa:=Q.fieldbyname('pend_valor').ascurrency
        else
          vlrantecipa:=0;
        Q.close;Freeandnil(Q);
        Q:=sqltoquery('select * from pendencias where pend_tipo_codigo='+EdCodtipo.AsSql+' and '+FGeral.getin('pend_status','D','C')+
           ' and pend_numerodcto='+inttostr(Numerodoc)+' and pend_parcela='+stringtosql(Grid.Cells[Grid.Getcolumn('pend_parcela'),Grid.row]) );
        vlrantecipabx:=0;
        while not Q.eof do begin
          vlrantecipabx:=vlrantecipabx+Q.fieldbyname('pend_valor').ascurrency;
          Q.next;
        end;
// gera pendencia com o 'saldo' da antecipaçao caso fique algum
//        if vlrantecipa>vlrantecipabx then
//          FGeral.GravaPendencia(EdDtbaixa.asdate,EdDtmovimento.asdate,EdCodtipo,EdTipocad.text,0,Unidade,Global.CodPendenciaFinanceira,
//                     Transacao,Global.FpgtoAntecipa,'P',Numerodoc,0,vlrantecipa-vlrantecipabx,0,'A',0,0,nil );

        Sistema.Edit('Pendencias');
        Sistema.SetField('pend_status','F');
        Sistema.SetField('pend_mora',0);
        Sistema.SetField('pend_descontos',0);
        Sistema.SetField('pend_transbaixa',Transacao);
        Sistema.SetField('pend_contabaixa',0);
        Sistema.SetField('pend_databaixa',EdDtbaixa.AsDate);
        Sistema.SetField('pend_observacao',QuemPagou(EdQuempagou.text));
        Sistema.SetField('pend_usubaixa',Global.Usuario.codigo);
        Sistema.Post('pend_tipo_codigo='+EdCodtipo.AsSql+' and '+FGeral.getin('pend_status','A','C')+
                       ' and pend_operacao='+stringtosql(pendopantecipa ));

      end;
      Q1.close;
      Freeandnil(Q1);
    end;

    function ValidaValores:boolean;
    //////////////////////////////////////
    var usuariolib:integer;
    begin
      result:=true;
      usuariolib:=0;
      if EdJuroMora.ascurrency<SetEdJuromora.ascurrency then begin
          result:=false;
          usuariolib:=FUsuarios.GetSenhaAutorizacao(708);
          if usuariolib>0 then
            result:=true
          else
            Avisoerro('Problema no valor dos juros');
      end;
    end;

    // 24.05.07
    procedure Baixafinalcomparcial;
    //////////////////////////////
    var QBxparcial:TSqlquery;
    begin
////////////////
      Sistema.Edit('Pendencias');
      Sistema.SetField('pend_status','K');  // status de baixado com parciais
      Sistema.SetField('Pend_TransBaixa',Transacao);  // no. transacao da baixa
      Sistema.SetField('Pend_DataBaixa',EdDtbaixa.asdate);
      Sistema.SetField('pend_usubaixa',Global.Usuario.codigo);
      Sistema.SetField('pend_observacao',QuemPagou(EdQuempagou.text));
      Sistema.Post('pend_status=''N'' and pend_operacao='+EdOperacao.AsSql+' and pend_tipo_codigo='+EdCodtipo.AsSql);
//////////
      Sistema.beginprocess('gravando baixa parcial');
      QBxparcial:=sqltoquery('select * from pendencias where pend_status=''N'' and pend_operacao='+EdOperacao.AsSql+' and pend_tipo_codigo='+EdCodtipo.AsSql);
      Sistema.Insert('Pendencias');
      Sistema.SetField('Pend_Transacao',Transacao);
// 17.01.13 - vivan
      OPbaixaparcial:= FGeral.GetOperacao;
      Sistema.SetField('Pend_Operacao',OPbaixaparcial);
//      Sistema.SetField('Pend_Operacao',FGeral.GetOperacao);
      Sistema.SetField('Pend_Status','P');
      Sistema.SetField('Pend_DataLcto',Sistema.Hoje);
      if EdRecpag.text='P' then
        Sistema.SetField('Pend_DataMvto',QBxparcial.fieldbyname('pend_datamvto').asdatetime)
      else
        Sistema.SetField('Pend_DataMvto',QBxparcial.fieldbyname('pend_dataemissao').asdatetime);
      Sistema.SetField('Pend_DataVcto',QBxparcial.fieldbyname('pend_datavcto').asdatetime);
      Sistema.SetField('Pend_DataEmissao',QBxparcial.fieldbyname('pend_dataemissao').asdatetime);
      if EdCodtipo.resultfind<>nil then begin
        if Edtipocad.text='C' then
          Sistema.SetField('Pend_Plan_Conta',EdCodtipo.Resultfind.fieldbyname('clie_contagerencial').AsInteger)
        else if Edtipocad.text='T' then
          Sistema.SetField('Pend_Plan_Conta',EdCodtipo.Resultfind.fieldbyname('tran_contagerencial').AsInteger)
        else if Edtipocad.text='F' then
          Sistema.SetField('Pend_Plan_Conta',EdCodtipo.Resultfind.fieldbyname('forn_contagerencial').AsInteger)
        else if Edtipocad.text='R' then
          Sistema.SetField('Pend_Plan_Conta',EdCodtipo.Resultfind.fieldbyname('repr_contagerencial').AsInteger);
      end;
      Sistema.SetField('Pend_Tipo_Codigo',EdCodtipo.Asinteger);
      Sistema.SetField('Pend_Unid_Codigo',QBxparcial.fieldbyname('pend_unid_codigo').asstring);
      Sistema.SetField('Pend_Fpgt_Codigo',QBxparcial.fieldbyname('pend_Fpgt_Codigo').asstring);
      Sistema.SetField('Pend_Port_Codigo',QBxparcial.fieldbyname('pend_port_Codigo').asstring);
      Sistema.SetField('Pend_Hist_Codigo',QBxparcial.fieldbyname('pend_hist_Codigo').asinteger);
      Sistema.SetField('Pend_Moed_Codigo','');
      Sistema.SetField('Pend_Repr_Codigo',QBxparcial.fieldbyname('pend_repr_Codigo').asinteger);
      Sistema.SetField('Pend_TipoCad'    ,EdTipocad.text);
  //      Sistema.SetField('Pend_CNPJCPF',EdCliente.Resultfind('clie_cnpjcpf);
      Sistema.SetField('Pend_Complemento',QBxparcial.fieldbyname('pend_complemento').asstring);
      Sistema.SetField('Pend_NumeroDcto',QBxparcial.fieldbyname('pend_Numerodcto').asstring);
      Sistema.SetField('Pend_Parcela',QBxparcial.fieldbyname('pend_parcela').asinteger);
      Sistema.SetField('Pend_NParcelas',QBxparcial.fieldbyname('pend_nparcelas').asinteger);
      Sistema.SetField('Pend_RP',Edrecpag.text);
      Sistema.SetField('Pend_DataCont',EdDtMovimento.asdate);
  // 04.04.06 - cuidar para nao baixar os juros do capital do titulo quando é pagamento de financiamento
//      if EdPlan_conta.resultfind.fieldbyname('plan_tipo').asstring='B' then begin
//        if EdRecPag.text='P' then begin
//          Sistema.SetField('Pend_Valor',Edvalor.ascurrency-EdJuromora.ascurrency+EdDescontos.ascurrency);
//          Sistema.SetField('Pend_ValorTitulo',Edvalor.ascurrency-EdJuromora.ascurrency+EdDescontos.ascurrency);
//        end else begin
//          Sistema.SetField('Pend_Valor',Edvalor.ascurrency+EdJuromora.ascurrency-EdDescontos.ascurrency);
//          Sistema.SetField('Pend_ValorTitulo',Edvalor.ascurrency+EdJuromora.ascurrency-EdDescontos.ascurrency);
//        end;
//      end else begin
        Sistema.SetField('Pend_Valor',Edvalor.ascurrency);
        Sistema.SetField('Pend_ValorTitulo',Edvalor.ascurrency);
//      end;
      Sistema.SetField('Pend_Juros',0);
      Sistema.SetField('Pend_Multa',0);
      Sistema.SetField('Pend_Mora',EdJuromora.ascurrency);
      Sistema.SetField('Pend_Acrescimos',0);
      Sistema.SetField('Pend_Descontos',EdDescontos.ascurrency);
      Sistema.SetField('Pend_TransBaixa','');  // no. transacao da baixa
      Sistema.SetField('Pend_ContaBaixa',0);
      Sistema.SetField('Pend_DataBaixa',EdDtbaixa.asdate);
      Sistema.SetField('pend_usubaixa',Global.Usuario.codigo);   // 20.06.05
      Sistema.SetField('pend_observacao',QuemPagou(EdQuempagou.text));
      Sistema.SetField('Pend_Impresso',0);   // numero do impresso relacionado
      Sistema.SetField('Pend_ImprDcto','');  // S ou N se o impresso já foi enviado para impressão
      Sistema.SetField('Pend_LoteCNAB',0);  // no. lote para exportação bancária (CNAB )
      Sistema.Post;
      QBxparcial.close;
      Freeandnil(QBxparcial);
// 26.05.11 - gerando comissao em baixa parcial de UM documento
      if (Global.Topicos[1278]) and (FGeral.GetConfig1AsFloat('Contacomissao')>0)
         and (EdRecPag.Text='R') then begin
         Transacaotitulo:=GetTransacaoTitulo(Edoperacao.Text);
         if trim(Transacaotitulo)<>'' then begin
           QTitulo:=Sqltoquery('select moes_numerodoc,moes_percomissao,moes_tipomov,moes_repr_codigo from movesto where moes_transacao='+Stringtosql(Transacaotitulo)+
                               ' and '+FGeral.Getin('moes_tipomov',Global.CodContrato+';'+Global.CodContratoNota,'C')+
                               ' and moes_status<>''C''');
           if not QTitulo.eof then begin                                                                       // 07.12.11
             if pos(Qtitulo.FieldByName('moes_tipomov').asstring,Global.CodContrato+';'+Global.CodContratoNota+';'+Global.CodRequisicaoAlmox) >0 then begin
               valorcomissaopagar:= ( EdValor.ascurrency+EdJuromora.AsCurrency-EdDescontos.AsCurrency ) * (QTitulo.fieldbyname('moes_percomissao').ascurrency/100);
               GravaPendenciaComissao(Qtitulo.fieldbyname('moes_repr_codigo').asinteger,transacao,Qtitulo.fieldbyname('moes_numerodoc').asstring+Grid.Cells[Grid.getcolumn('pend_parcela'),Grid.row],valorcomissaopagar);
//               FGeral.GravaPendencia(EdDtbaixa.asdate,EdDtmovimento.asdate,EdCodtipo,EdTipocad.text,0,Unidade,Global.CodPendenciaFinanceira,
//                   Transacao,Global.FpgtoAntecipa,'P',Numerodoc,0,valorcomissaopagar,0,'N',0,0,nil )
             end;
           end else begin
             Avisoerro('Não gerado comissão a pagar.   Transação :'+Transacaotitulo);
           end;
           FGeral.FechaQuery(QTitulo);
         end else  begin
           Avisoerro('Não gerado comissão a pagar.   OPeração :'+Edoperacao.Text);
         end;
      end;
//////////

      Sistema.endprocess('');

///////////
    end;

// 23.02.08
///////////////////////////////////
    procedure BaixaDiversasPendencias;
    ////////////////////////////////////
    var r:integer;
        bxparcialfinal,sqlcodigo:string;
        vlrparcial:currency;
        QBxparcial:TSqlquery;

    begin

      for r:=1 to Grid.RowCount do begin
        if ( Grid.cells[Grid.getcolumn('marcado'),r] ='Ok' ) and ( Grid.cells[Grid.getcolumn('pend_operacao'),r]  <> '' )  then begin
          bxparcialfinal:='N';
          vlrparcial:=0;
          if ( TExttovalor( Grid.Cells[Grid.getcolumn('pend_valor'),r] )  >  Texttovalor( Grid.Cells[Grid.getcolumn('bxparciais'),r] ) ) and
              (  Texttovalor( Grid.Cells[Grid.getcolumn('bxparciais'),r] )>0 ) then begin
             bxparcialfinal:='S';
             vlrparcial:=( TExttovalor( Grid.Cells[Grid.getcolumn('pend_valor'),r] )  -  Texttovalor( Grid.Cells[Grid.getcolumn('bxparciais'),r] ) );
          end;
// 03.10.09
          if not Edcodtipo.IsEmpty then
            sqlcodigo:=' and pend_tipo_codigo='+EdCodtipo.AsSql
          else
            sqlcodigo:='';
//17.07.09
          if (Global.Topicos[1267]) and (Edtipocad.text='R') then
            sqlcodigo:=' and pend_repr_codigo='+EdCodtipo.AsSql;

          if bxparcialfinal='N' then begin

            Sistema.Edit('Pendencias');
            Sistema.SetField('pend_status','B');
            if r=1 then begin  // para nao gravar o mesmo juros/descontos para todos os titulos baixados
              Sistema.SetField('pend_mora',EdJuroMora.AsCurrency);
              Sistema.SetField('pend_descontos',EdDescontos.AsCurrency);
            end;
            Sistema.SetField('pend_transbaixa',Transacao);
            Sistema.SetField('pend_contabaixa',EdPlan_conta.AsInteger);
            Sistema.SetField('pend_databaixa',EdDtbaixa.AsDate);
            Sistema.SetField('pend_observacao',QuemPagou(EdQuempagou.text));
            Sistema.SetField('pend_usubaixa',Global.Usuario.codigo);
// 31.03.08
            Sistema.SetField('pend_complemento',copy(EdHist_complemento.text,1,100));
            Sistema.Post('pend_status=''N'' and pend_operacao='+Stringtosql(Grid.cells[Grid.getcolumn('pend_operacao'),r])+
                         sqlcodigo);
// 14.06.12 - Daniela - AbraChapeco
///////////////////////////
            if (Global.Topicos[1278]) and (FGeral.GetConfig1AsFloat('Contacomissao')>0)
               and (EdRecPag.Text='R') then begin
               Transacaotitulo:=GetTransacaoTitulo( Grid.cells[Grid.getcolumn('pend_operacao'),r] );
               if trim(Transacaotitulo)<>'' then begin
                 QTitulo:=Sqltoquery('select moes_numerodoc,moes_percomissao,moes_tipomov,moes_repr_codigo from movesto where moes_transacao='+Stringtosql(Transacaotitulo)+
                               ' and '+FGeral.GetIN('moes_tipomov',Global.CodContrato+';'+Global.CodContratoNota,'C')+
                               ' and moes_status<>''C''');
                 if not QTitulo.eof then begin
                   if pos(Qtitulo.FieldByName('moes_tipomov').asstring,Global.CodContrato+';'+Global.CodContratoNota+';'+Global.CodRequisicaoAlmox) >0 then begin
                     valorcomissaopagar:= ( TExttovalor( Grid.Cells[Grid.getcolumn('pend_valor'),r] ) ) * (QTitulo.fieldbyname('moes_percomissao').ascurrency/100);
                     GravaPendenciaComissao(Qtitulo.fieldbyname('moes_repr_codigo').asinteger,transacao,Qtitulo.fieldbyname('moes_numerodoc').asstring+Grid.Cells[Grid.getcolumn('pend_parcela'),r],valorcomissaopagar);
                   end;
                 end else begin
                   Avisoerro('Não gerado comissão a pagar.   Transação :'+Transacaotitulo);
                 end;
                 FGeral.FechaQuery(QTitulo);
               end else begin
                  Avisoerro('Não gerado comissão a pagar.   OPeração :'+Grid.cells[Grid.getcolumn('pend_operacao'),r]);
               end;
            end;
///////////////////////////
          end else begin

            Sistema.Edit('Pendencias');
            Sistema.SetField('pend_status','K');  // status de baixado com parciais
            Sistema.SetField('Pend_TransBaixa',Transacao);  // no. transacao da baixa
            Sistema.SetField('Pend_DataBaixa',EdDtbaixa.asdate);
            Sistema.SetField('pend_usubaixa',Global.Usuario.codigo);
            Sistema.SetField('pend_observacao',QuemPagou(EdQuempagou.text));
            Sistema.Post('pend_status=''N'' and pend_operacao='+Stringtosql(Grid.cells[Grid.getcolumn('pend_operacao'),r])+
                         sqlcodigo);
      //////////
            Sistema.beginprocess('gravando baixa parcial final');
            QBxparcial:=sqltoquery('select * from pendencias where pend_status=''N'' and pend_operacao='+Stringtosql(Grid.cells[Grid.getcolumn('pend_operacao'),r])+' and pend_tipo_codigo='+EdCodtipo.AsSql);
            Sistema.Insert('Pendencias');
            Sistema.SetField('Pend_Transacao',Transacao);
            Sistema.SetField('Pend_Operacao',FGeral.GetOperacao);
            Sistema.SetField('Pend_Status','P');
            Sistema.SetField('Pend_DataLcto',Sistema.Hoje);
            if EdRecpag.text='P' then
              Sistema.SetField('Pend_DataMvto',QBxparcial.fieldbyname('pend_datamvto').asdatetime)
            else
              Sistema.SetField('Pend_DataMvto',QBxparcial.fieldbyname('pend_dataemissao').asdatetime);
            Sistema.SetField('Pend_DataVcto',QBxparcial.fieldbyname('pend_datavcto').asdatetime);
            Sistema.SetField('Pend_DataEmissao',QBxparcial.fieldbyname('pend_dataemissao').asdatetime);
            if EdCodtipo.resultfind<>nil then begin
              if Edtipocad.text='C' then
                Sistema.SetField('Pend_Plan_Conta',EdCodtipo.Resultfind.fieldbyname('clie_contagerencial').AsInteger)
              else if Edtipocad.text='T' then
                Sistema.SetField('Pend_Plan_Conta',EdCodtipo.Resultfind.fieldbyname('tran_contagerencial').AsInteger)
              else if Edtipocad.text='F' then
                Sistema.SetField('Pend_Plan_Conta',EdCodtipo.Resultfind.fieldbyname('forn_contagerencial').AsInteger)
              else if Edtipocad.text='R' then
                Sistema.SetField('Pend_Plan_Conta',EdCodtipo.Resultfind.fieldbyname('repr_contagerencial').AsInteger);
            end;

//17.07.09
            if (Global.Topicos[1267]) and (Edtipocad.text='R') then begin
              Sistema.SetField('Pend_Tipo_Codigo',QBxparcial.fieldbyname('pend_tipo_codigo').AsInteger);
              Sistema.SetField('Pend_TipoCad'    ,QBxparcial.fieldbyname('pend_tipocad').asstring);
            end else begin
              Sistema.SetField('Pend_Tipo_Codigo',EdCodtipo.Asinteger);
              Sistema.SetField('Pend_TipoCad'    ,EdTipocad.text);
            end;
            Sistema.SetField('Pend_Unid_Codigo',QBxparcial.fieldbyname('pend_unid_codigo').asstring);
            Sistema.SetField('Pend_Fpgt_Codigo',QBxparcial.fieldbyname('pend_Fpgt_Codigo').asstring);
            Sistema.SetField('Pend_Port_Codigo',QBxparcial.fieldbyname('pend_port_Codigo').asstring);
            Sistema.SetField('Pend_Hist_Codigo',QBxparcial.fieldbyname('pend_hist_Codigo').asinteger);
            Sistema.SetField('Pend_Moed_Codigo','');
            Sistema.SetField('Pend_Repr_Codigo',QBxparcial.fieldbyname('pend_repr_Codigo').asinteger);
        //      Sistema.SetField('Pend_CNPJCPF',EdCliente.Resultfind('clie_cnpjcpf);
//            Sistema.SetField('Pend_Complemento',QBxparcial.fieldbyname('pend_complemento').asstring);
// 04.03.08
            Sistema.SetField('pend_complemento',copy(EdHist_complemento.text,1,100));
            Sistema.SetField('Pend_NumeroDcto',QBxparcial.fieldbyname('pend_Numerodcto').asstring);
            Sistema.SetField('Pend_Parcela',QBxparcial.fieldbyname('pend_parcela').asinteger);
            Sistema.SetField('Pend_NParcelas',QBxparcial.fieldbyname('pend_nparcelas').asinteger);
            Sistema.SetField('Pend_RP',Edrecpag.text);
            Sistema.SetField('Pend_DataCont',EdDtMovimento.asdate);
            Sistema.SetField('Pend_Valor',vlrparcial);
            Sistema.SetField('Pend_ValorTitulo',vlrparcial);
            Sistema.SetField('Pend_Juros',0);
            Sistema.SetField('Pend_Multa',0);
            Sistema.SetField('Pend_Mora',0);
            Sistema.SetField('Pend_Acrescimos',0);
            Sistema.SetField('Pend_Descontos',0);
            Sistema.SetField('Pend_TransBaixa','');  // no. transacao da baixa
            Sistema.SetField('Pend_ContaBaixa',0);
            Sistema.SetField('Pend_DataBaixa',EdDtbaixa.asdate);
            Sistema.SetField('pend_usubaixa',Global.Usuario.codigo);   // 20.06.05
            Sistema.SetField('pend_observacao',QuemPagou(EdQuempagou.text));
            Sistema.SetField('Pend_Impresso',0);   // numero do impresso relacionado
            Sistema.SetField('Pend_ImprDcto','');  // S ou N se o impresso já foi enviado para impressão
            Sistema.SetField('Pend_LoteCNAB',0);  // no. lote para exportação bancária (CNAB )
            Sistema.Post;
            QBxparcial.close;
            Freeandnil(QBxparcial);
            Sistema.endprocess('');

          end;  // baixa parcial final ou nao

        end;
      end;
    end;

    procedure BaixaDiversasBP;
    ///////////////////////////
    var r:integer;
        bxparcialfinal,entsai,baixartotal:string;
        vlrparcial:currency;
        QBxparcial:TSqlquery;
        ContaDesrec:integer;
    begin
      Sistema.beginprocess('gravando baixa parcial');
      if EdRecPag.text='P' then
        entsai:='S'
      else
        entsai:='E';
      for r:=1 to Grid.RowCount do begin
        baixartotal:='N';
        if ( Grid.cells[Grid.getcolumn('marcado'),r] ='Ok' ) and ( Grid.cells[Grid.getcolumn('pend_operacao'),r]  <> '' )  then begin
          vlrparcial:=TExttovalor( Grid.Cells[Grid.getcolumn('parcialgrid'),r] );
// 05.02.09 - Carli financeiro 'errando'..e sempre no ultimo funcionario..
          if vlrparcial=0 then begin
             vlrparcial:=( TExttovalor( Grid.Cells[Grid.getcolumn('pend_valor'),r] )  -  Texttovalor( Grid.Cells[Grid.getcolumn('bxparciais'),r] ) );
             baixartotal:='S'
          end;
          QBxparcial:=sqltoquery('select * from pendencias where pend_status=''N'' and pend_operacao='+stringtosql(Grid.cells[Grid.getcolumn('pend_operacao'),r])+' and pend_tipo_codigo='+EdCodtipo.AsSql);
// 11.01.2010 - caso baixar parcela total nao gerar registro 'P' e apenas baixar a operacao
//              mudando status para 'B'
          if baixartotal='N' then begin
            Sistema.Insert('Pendencias');
            Sistema.SetField('Pend_Transacao',Transacao);
            Sistema.SetField('Pend_Operacao',FGeral.GetOperacao);
            Sistema.SetField('Pend_Status','P');
            Sistema.SetField('Pend_DataLcto',Sistema.Hoje);
            if EdRecpag.text='P' then
              Sistema.SetField('Pend_DataMvto',QBxparcial.fieldbyname('pend_datamvto').asdatetime)
            else
              Sistema.SetField('Pend_DataMvto',QBxparcial.fieldbyname('pend_dataemissao').asdatetime);
            Sistema.SetField('Pend_DataVcto',QBxparcial.fieldbyname('pend_datavcto').asdatetime);
            Sistema.SetField('Pend_DataEmissao',QBxparcial.fieldbyname('pend_dataemissao').asdatetime);
            Sistema.SetField('Pend_Plan_Conta',QBxparcial.fieldbyname('pend_plan_Conta').asinteger);
            Sistema.SetField('Pend_Tipo_Codigo',EdCodtipo.Asinteger);
            Sistema.SetField('Pend_Unid_Codigo',QBxparcial.fieldbyname('pend_unid_codigo').asstring);
            Sistema.SetField('Pend_Fpgt_Codigo',QBxparcial.fieldbyname('pend_Fpgt_Codigo').asstring);
            Sistema.SetField('Pend_Port_Codigo',QBxparcial.fieldbyname('pend_port_Codigo').asstring);
            Sistema.SetField('Pend_Hist_Codigo',QBxparcial.fieldbyname('pend_hist_Codigo').asinteger);
            Sistema.SetField('Pend_Moed_Codigo','');
            Sistema.SetField('Pend_Repr_Codigo',QBxparcial.fieldbyname('pend_repr_Codigo').asinteger);
            Sistema.SetField('Pend_TipoCad'    ,EdTipocad.text);
        //      Sistema.SetField('Pend_CNPJCPF',EdCliente.Resultfind('clie_cnpjcpf);
            Sistema.SetField('Pend_Complemento',QBxparcial.fieldbyname('pend_complemento').asstring);
            Sistema.SetField('Pend_NumeroDcto',QBxparcial.fieldbyname('pend_Numerodcto').asstring);
            Sistema.SetField('Pend_Parcela',QBxparcial.fieldbyname('pend_parcela').asinteger);
            Sistema.SetField('Pend_NParcelas',QBxparcial.fieldbyname('pend_nparcelas').asinteger);
            Sistema.SetField('Pend_RP',Edrecpag.text);
            Sistema.SetField('Pend_DataCont',EdDtMovimento.asdate);
            Sistema.SetField('Pend_Valor',vlrparcial);
            Sistema.SetField('Pend_ValorTitulo',vlrparcial);
            Sistema.SetField('Pend_Juros',0);
            Sistema.SetField('Pend_Multa',0);
            Sistema.SetField('Pend_Mora',0);
            Sistema.SetField('Pend_Acrescimos',0);
            Sistema.SetField('Pend_Descontos',0);
            Sistema.SetField('Pend_TransBaixa','');  // no. transacao da baixa
            Sistema.SetField('Pend_ContaBaixa',0);
            Sistema.SetField('Pend_DataBaixa',EdDtbaixa.asdate);
            Sistema.SetField('pend_usubaixa',Global.Usuario.codigo);   // 20.06.05
        // 02.08.06
            Sistema.SetField('pend_observacao',QuemPagou(EdQuempagou.text));
            Sistema.SetField('Pend_Impresso',0);   // numero do impresso relacionado
            Sistema.SetField('Pend_ImprDcto','');  // S ou N se o impresso já foi enviado para impressão
            Sistema.SetField('Pend_LoteCNAB',0);  // no. lote para exportação bancária (CNAB )
            Sistema.Post;
          end else begin
            Sistema.edit('pendencias');
            Sistema.SetField('pend_status','B');
            Sistema.SetField('pend_transbaixa',Transacao);
            Sistema.SetField('pend_contabaixa',EdPlan_conta.AsInteger);
            Sistema.SetField('pend_databaixa',EdDtbaixa.AsDate);
            Sistema.SetField('pend_observacao',QuemPagou(EdQuempagou.text));
            Sistema.SetField('pend_usubaixa',Global.Usuario.codigo);
            Sistema.Post('pend_operacao='+stringtosql(Grid.cells[Grid.getcolumn('pend_operacao'),r]))
          end;
  // 20.11.08
          if (Global.Topicos[1260])  then begin  // 20.11.08
              ContaDesrec:=Strtointdef( Grid.Cells[Grid.getcolumn('pend_plan_conta'),r] ,0);
              if ContaDesRec=0 then
                ContaDesREc:=EdContaDesrec.asinteger;
              FGeral.GravaMovfin(Transacao,Unidade,EntSai,EdHist_complemento.text,EdDtbaixa.AsDate,EdDtMovimento.Asdate,
                           EdBompara.Asdate,strtoint(QBxparcial.fieldbyname('pend_Numerodcto').asstring),EdHist_codigo.asinteger,Cheque,EdPlan_conta.AsInteger,vlrparcial,
                           ContaDesrec,Global.CodPendenciaFinanceira,QBxparcial.fieldbyname('pend_repr_Codigo').asinteger,
                           EdCodtipo.asinteger,Edtipocad.text,'N','1',transacaocontax);
          end;
          QBxparcial.close;
          Freeandnil(QBxparcial);
        end;
      end;  // ref. for
      Sistema.endprocess('');
    end;

    function ValidaGrid:boolean;
    /////////////////////////////
    var r:integer;
    begin
      result:=true;
      for r:=1 to Grid.rowcount do begin
        if ( Grid.cells[Grid.getcolumn('marcado'),r] ='Ok' ) and ( Grid.cells[Grid.getcolumn('pend_operacao'),r]  <> '' )  then begin
          if TExttovalor( Grid.Cells[Grid.getcolumn('parcialgrid'),r] )=0 then begin
            Avisoerro('Baixa Parcial com valor zerado não permitida');
            result:=false;
            break;
          end;
        end;
      end;
    end;

    Function GetEstaTransacao(xop:string):string;
    /////////////////////////////////////////////////
    var Q:TSqlquery;
    begin
      Q:=Sqltoquery('select pend_transacao from pendencias where pend_operacao='+Stringtosql(xop)+
                    ' and pend_status<>''C''');
      if not Q.Eof then
        result:=Q.fieldbyname('pend_transacao').AsString
      else
        result:='';
      FGeral.FechaQuery(Q);
    end;
//////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////
begin
///////////////////////////////////////////////////////////////////////////////////////////////////

  TipoBaixaMultipla:='BN';   // Baixa Normal de um titulo
  if EdPlan_conta.AsInteger>0 then begin
    if not EdPlan_conta.valid then begin
      Avisoerro('Checar conta da baixa');
      exit;
    end;
  end;
  if EdContaDesrec.asinteger>0 then begin
    if not EdContaDesrec.valid then begin
      Avisoerro('Checar conta de despesa');
      exit;
    end;
  end;
  if not ValidaValores then exit;
  if not Global.Usuario.OutrosAcessos[0722] then begin
// 01.10.07
    if Unidade<>Grid.Cells[Grid.getcolumn('pend_unid_codigo'),grid.row] then begin
       Avisoerro('Pendencia da unidade '+Grid.Cells[Grid.getcolumn('pend_unid_codigo'),grid.row]+' não pode ser baixada na unidade '+unidade);
       exit;
    end;
  end else begin
    if Unidade<>Grid.Cells[Grid.getcolumn('pend_unid_codigo'),grid.row] then begin
       if not Confirma('Baixar pendencia da unidade '+Grid.Cells[Grid.getcolumn('pend_unid_codigo'),grid.row]+' na unidade '+unidade+' ?') then
         exit;
    end;
  end;
// 19.03.08
//  if not EdRecpag.valid then exit;
// 25.03.08 - correcao de kaka....bem no evento validate deste edit 'desmarca' os titulos...
  if pos(EdRecpag.text,'PR')=0 then begin
     Avisoerro('Problemas no campo R/P');
     exit;
  end;
// 02.12.16
  if (Global.topicos[1045]) and ( EdDtMovimento.asdate > 1 )  then begin
    if (contaclifor=0) or (contacaixaban=0) then begin
      Avisoerro('Cli/for ou conta sem a conta contábil informada no cadastro');
      exit;
    end;
  end;

// 29.01.09 - Carli - 'financeiro'..
//  if marc>1 then begin
//    if not ValidaGrid then exit;
//  end;
// 05.02.09 - retirado pois pode marcar diversos e baixar total...

// caso tiver config. % nos parametro do sistema e ativar aqui checagem do titulo q gerou a pendencia
// ( VX ou VY na mesma transacao ) - ver valor total e somar o q ja foi baixado
// e ver quantos % da e comparar com o q estiver configurado
  if (FGeral.GetConfig1AsFloat('perbaixareserva')>0) and (EdRecPag.Text='P') and
     ( EdContaDesrec.AsInteger=FGeral.GetConfig1AsInteger('Contareserva') )
//       ( EdContaDesrec.AsInteger=FGeral.GetConfig1AsInteger('Contacomissao') )  )
// 25.08.10 - Abra - Adriano - somente reserva técnica obedece os 70%
    then begin
    valortitulo:=0;
    xtransacoes:=GetEstaTransacao(Grid.cells[Grid.getcolumn('pend_operacao'),Grid.row])+';';
    xnumerostitulo:=(Grid.cells[Grid.getcolumn('pend_numerodcto'),Grid.row])+';';
    for ry:=1 to Grid.RowCount do begin
        if ( Grid.cells[Grid.getcolumn('marcado'),ry] ='Ok' ) and ( Grid.cells[Grid.getcolumn('pend_operacao'),ry]  <> '' )  then begin
          xtransacoes:=xtransacoes+GetEstaTransacao(Grid.cells[Grid.getcolumn('pend_operacao'),ry])+';';
          xnumerostitulo:=xnumerostitulo+(Grid.cells[Grid.getcolumn('pend_numerodcto'),ry])+';';
        end;
    end;
//    QTitulo:=Sqltoquery('select moes_vlrtotal,moes_numerodoc,moes_dataemissao,moes_tipo_codigo from movesto where '+FGeral.Getin('moes_transacao',xtransacoes,'C')+
 //                       ' and moes_status<>''C'' and '+FGeral.GetIN('moes_tipomov',Global.CodContrato+';'+Global.CodContratoNota,'C') );

      Emissaotitulo:=EdDtBaixa.asdate-360;

//    if QTitulo.eof then begin  // nao gerado pelo sistema
//      QTitulo.close;
//      QTitulo:=Sqltoquery('select moes_vlrtotal,moes_numerodoc,moes_dataemissao,moes_tipo_codigo from movesto where '+FGeral.Getin('moes_numerodoc',xnumerostitulo,'N')+
//                          ' and moes_status<>''C'' and '+FGeral.GetIN('moes_tipomov',Global.CodContrato+';'+Global.CodContratoNota,'C') );
      sqlrepres:=' and moes_repr_codigo='+EdCodtipo.AsSql;
      if EdContaDesrec.AsInteger=FGeral.GetConfig1AsInteger('Contareserva') then
        sqlrepres:=' and moes_repr_codigo2='+EdCodtipo.AsSql;
      QTitulo:=Sqltoquery('select moes_tipo_codigo,moes_dataemissao,sum(moes_vlrtotal) as moes_vlrtotal from movesto where '+FGeral.Getin('moes_numerodoc',xnumerostitulo,'N')+
                          ' and moes_status<>''C'' and '+FGeral.GetIN('moes_tipomov',Global.CodContrato+';'+Global.CodContratoNota,'C')+
                          ' and moes_dataemissao>='+Datetosql(emissaotitulo)+
                          sqlrepres+
                          ' group by moes_tipo_codigo,moes_dataemissao' );
//    end;
    if not QTitulo.Eof then begin
      valortitulo:=Qtitulo.fieldbyname('moes_vlrtotal').ascurrency;
//      Numerotitulo:=Qtitulo.fieldbyname('moes_numerodoc').asinteger;
      Clientetitulo:=Qtitulo.fieldbyname('moes_tipo_codigo').asinteger;
      Emissaotitulo:=Qtitulo.fieldbyname('moes_dataemissao').asdatetime;
//      Clientetitulo:=EdCodtipo.asinteger;   //este é o fornec. a ser baixado..darrr
      if valortitulo>0 then begin
        Qtitulo:=sqltoquery('select sum(pend_valor) as pend_valor from pendencias where '+FGeral.GetIN('pend_status','P;B','C')+
                             ' and pend_tipo_codigo='+inttostr(ClienteTitulo)+
  //                           ' and pend_databaixa<='+EdDtbaixa.assql+' and pend_tipocad='+Edtipocad.assql+
//                             ' and pend_tipocad='+Edtipocad.assql+
                             ' and pend_rp=''R'''+
//                             ' and pend_parcela='+Grid.Cells[Grid.getcolumn('pend_parcela'),Grid.row]+
                             ' and pend_dataemissao>='+Datetosql(emissaotitulo)+
//                             ' and pend_unid_codigo='+stringtosql(unidadedoc)+
//                             ' and pend_numerodcto='+inttostr(Numerotitulo) );
// 09.02.10
                             ' and '+FGeral.Getin('pend_numerodcto',xNumerostitulo,'C') );
        if QTitulo.fieldbyname('pend_valor').ascurrency>0 then begin
           perbaixa:=(QTitulo.fieldbyname('pend_valor').ascurrency/valortitulo)*100;
           if perbaixa<FGeral.GetConfig1AsFloat('perbaixareserva') then begin
//             Avisoerro('Baixas no titulo '+inttostr(Numerotitulo)+' valor '+floattostr(QTitulo.fieldbyname('pend_valor').ascurrency)+' igual '+floattostr(perbaixa)+'  % do valor '+floattostr(valortitulo) );
             Avisoerro('Baixas neste contrato no valor '+floattostr(QTitulo.fieldbyname('pend_valor').ascurrency)+' igual '+formatfloat(f_cr,perbaixa)+'  % do valor '+formatfloat(f_cr,valortitulo) );
             exit;
           end;
        end else begin
//          Avisoerro('Não foram encontrados baixas no titulo '+inttostr(Numerotitulo)+' referente esta comissão');
          Avisoerro('Não foram encontrados baixas na venda que originou esta comissão');
          exit;
        end;

      end;
    end;
    FGeral.FechaQuery(QTitulo);
  end;
// 14.03.19 - Novicarnes - Sandro
  if (marc<=1) and ( EdCodtipo.IsEmpty ) then begin
     Avisoerro('Obrigatório informar codigo do cliente/fornecedor para baixar somente uma parcela');
     exit;
  end;

  if not confirma('Confirma a baixa ?') then exit;
// 22.06.07
  if (Edtipocad.Text='C') and (not EdCodtipo.IsEmpty) then
    codrepr:=EdCodtipo.resultfind.fieldbyname('clie_repr_codigo').asinteger
  else
    codrepr:=0;
  if EdDtBaixa.AsDate<=1 then exit;
  if EdValor.AsCurrency<=0 then exit;
  if not Global.Topicos[1270] then begin
    if EdCodTipo.AsInteger=0 then exit;
  end;
  if EdPlan_conta.AsInteger=0 then exit;
  p:=FGeral.ProcuraGrid(0,EdOperacao.text,Grid);
// baixa 'no grid' foi la no 'endtransaction
  if not EdDescontos.valid then exit;
  Sistema.begintransaction('Gravando baixa');
  Transacao:=FGeral.GetTransacao;
// 01.12.09
  OPbaixaparcial:='';
// 19.09.16
   if (Global.topicos[1045]) and ( EdDtMovimento.asdate > 1 )  then begin
      transacaocontax:=FGeral.GetTransacaoContax(strzero(FUnidades.GetEmpresaContax(Global.codigounidade),3),True);
   end;
   QUnid_codigo:=sqltoquery('select * from unidades where unid_codigo = '+Stringtosql(Global.codigoUnidade));
   caixafilial:=QUnid_codigo.fieldbyname('unid_caixa').asinteger;

  if (EdBaixaparcial.text='S') and (marc<=1) then begin
// 07.06.06
    if EdValor.ascurrency=valortitulo then
      Avisoerro('Atenção !!! Baixa final considerada ainda como parcial !!!');

//    FGeral.gravaBaixaParcial
    Sistema.beginprocess('gravando baixa parcial');
    QBxparcial:=sqltoquery('select * from pendencias where pend_status=''N'' and pend_operacao='+EdOperacao.AsSql+' and pend_tipo_codigo='+EdCodtipo.AsSql);

    Sistema.Insert('Pendencias');
    Sistema.SetField('Pend_Transacao',Transacao);
    OPbaixaparcial:= FGeral.GetOperacao;
    Sistema.SetField('Pend_Operacao',OPbaixaparcial);
    Sistema.SetField('Pend_Status','P');
    Sistema.SetField('Pend_DataLcto',Sistema.Hoje);
    if EdRecpag.text='P' then
      Sistema.SetField('Pend_DataMvto',QBxparcial.fieldbyname('pend_datamvto').asdatetime)
    else
      Sistema.SetField('Pend_DataMvto',QBxparcial.fieldbyname('pend_dataemissao').asdatetime);
    Sistema.SetField('Pend_DataVcto',QBxparcial.fieldbyname('pend_datavcto').asdatetime);
    Sistema.SetField('Pend_DataEmissao',QBxparcial.fieldbyname('pend_dataemissao').asdatetime);
{ - 17.03.14 - retirado para usar conta do titulo baixado
    if EdCodtipo.resultfind<>nil then begin
      if Edtipocad.text='C' then
        Sistema.SetField('Pend_Plan_Conta',EdCodtipo.Resultfind.fieldbyname('clie_contagerencial').AsInteger)
      else if Edtipocad.text='T' then
        Sistema.SetField('Pend_Plan_Conta',EdCodtipo.Resultfind.fieldbyname('tran_contagerencial').AsInteger)
      else if Edtipocad.text='F' then
        Sistema.SetField('Pend_Plan_Conta',EdCodtipo.Resultfind.fieldbyname('forn_contagerencial').AsInteger)
      else if Edtipocad.text='R' then
        Sistema.SetField('Pend_Plan_Conta',EdCodtipo.Resultfind.fieldbyname('repr_contagerencial').AsInteger);
    end;
}
    Sistema.SetField('Pend_Plan_Conta',QBxparcial.fieldbyname('pend_plan_conta').asstring);

    Sistema.SetField('Pend_Tipo_Codigo',EdCodtipo.Asinteger);
    Sistema.SetField('Pend_Unid_Codigo',QBxparcial.fieldbyname('pend_unid_codigo').asstring);
    Sistema.SetField('Pend_Fpgt_Codigo',QBxparcial.fieldbyname('pend_Fpgt_Codigo').asstring);
    Sistema.SetField('Pend_Port_Codigo',QBxparcial.fieldbyname('pend_port_Codigo').asstring);
    Sistema.SetField('Pend_Hist_Codigo',QBxparcial.fieldbyname('pend_hist_Codigo').asinteger);
    Sistema.SetField('Pend_Moed_Codigo','');
    Sistema.SetField('Pend_Repr_Codigo',QBxparcial.fieldbyname('pend_repr_Codigo').asinteger);
    Sistema.SetField('Pend_TipoCad'    ,EdTipocad.text);
//      Sistema.SetField('Pend_CNPJCPF',EdCliente.Resultfind('clie_cnpjcpf);
    Sistema.SetField('Pend_Complemento',QBxparcial.fieldbyname('pend_complemento').asstring);
    Sistema.SetField('Pend_NumeroDcto',QBxparcial.fieldbyname('pend_Numerodcto').asstring);
    Sistema.SetField('Pend_Parcela',QBxparcial.fieldbyname('pend_parcela').asinteger);
    Sistema.SetField('Pend_NParcelas',QBxparcial.fieldbyname('pend_nparcelas').asinteger);
    Sistema.SetField('Pend_RP',Edrecpag.text);
    Sistema.SetField('Pend_DataCont',EdDtMovimento.asdate);
// 30.08.05
/////////////////////    Sistema.SetField('Pend_DataCont',EdDtbaixa.asdate);
// 04.04.06 - cuidar para nao baixar os juros do capital do titulo quando é pagamento de financiamento
// 30.05.07 - retirado este 'esquema'
//    if EdPlan_conta.resultfind.fieldbyname('plan_tipo').asstring='B' then begin
//      if EdRecPag.text='P' then begin
//       Sistema.SetField('Pend_Valor',Edvalor.ascurrency-EdJuromora.ascurrency+EdDescontos.ascurrency);
//        Sistema.SetField('Pend_ValorTitulo',Edvalor.ascurrency-EdJuromora.ascurrency+EdDescontos.ascurrency);
//      end else begin
//        Sistema.SetField('Pend_Valor',Edvalor.ascurrency+EdJuromora.ascurrency-EdDescontos.ascurrency);
//        Sistema.SetField('Pend_ValorTitulo',Edvalor.ascurrency+EdJuromora.ascurrency-EdDescontos.ascurrency);
//      end;
//    end else begin
      Sistema.SetField('Pend_Valor',Edvalor.ascurrency);
      Sistema.SetField('Pend_ValorTitulo',Edvalor.ascurrency);
//    end;
//    Sistema.SetField('Pend_Juros',EdJuromora.ascurrency);
// Abra - 10.05.10 - paulo pegou o bug - gravava no campo errado os juros
    Sistema.SetField('Pend_Multa',0);
//    Sistema.SetField('Pend_Mora',0);
    Sistema.SetField('Pend_Mora',EdJuromora.ascurrency);
    Sistema.SetField('Pend_Acrescimos',0);
    Sistema.SetField('Pend_Descontos',EdDescontos.ascurrency);
    Sistema.SetField('Pend_TransBaixa','');  // no. transacao da baixa
    Sistema.SetField('Pend_ContaBaixa',EdPlan_conta.Asinteger);
    Sistema.SetField('Pend_DataBaixa',EdDtbaixa.asdate);
    Sistema.SetField('pend_usubaixa',Global.Usuario.codigo);   // 20.06.05
// 02.08.06
    Sistema.SetField('pend_observacao',QuemPagou(EdQuempagou.text));
    Sistema.SetField('Pend_Impresso',0);   // numero do impresso relacionado
    Sistema.SetField('Pend_ImprDcto','');  // S ou N se o impresso já foi enviado para impressão
    Sistema.SetField('Pend_LoteCNAB',0);  // no. lote para exportação bancária (CNAB )
    Sistema.Post;

    QBxparcial.close;
    Freeandnil(QBxparcial);
// 26.05.11 - gerando comissao em baixa parcial de UM documento
      if (Global.Topicos[1278]) and (FGeral.GetConfig1AsFloat('Contacomissao')>0)
         and (EdRecPag.Text='R') then begin
         Transacaotitulo:=GetTransacaoTitulo(Edoperacao.Text);
         if trim(Transacaotitulo)<>'' then begin
           QTitulo:=Sqltoquery('select moes_numerodoc,moes_percomissao,moes_tipomov,moes_repr_codigo from movesto where moes_transacao='+Stringtosql(Transacaotitulo)+
                               ' and '+FGeral.Getin('moes_tipomov',Global.CodContrato+';'+Global.CodContratoNota,'C')+
                               ' and moes_status<>''C''');
           if not QTitulo.eof then begin                                                                       // 07.12.11
             if pos(Qtitulo.FieldByName('moes_tipomov').asstring,Global.CodContrato+';'+Global.CodContratoNota+';'+Global.CodRequisicaoAlmox) >0 then begin
               valorcomissaopagar:= ( EdValor.ascurrency+EdJuromora.AsCurrency-EdDescontos.AsCurrency ) * (QTitulo.fieldbyname('moes_percomissao').ascurrency/100);
               GravaPendenciaComissao(Qtitulo.fieldbyname('moes_repr_codigo').asinteger,transacao,Qtitulo.fieldbyname('moes_numerodoc').asstring+Grid.Cells[Grid.getcolumn('pend_parcela'),Grid.row],valorcomissaopagar);
//               FGeral.GravaPendencia(EdDtbaixa.asdate,EdDtmovimento.asdate,EdCodtipo,EdTipocad.text,0,Unidade,Global.CodPendenciaFinanceira,
//                   Transacao,Global.FpgtoAntecipa,'P',Numerodoc,0,valorcomissaopagar,0,'N',0,0,nil )
             end;
           end else begin
             Avisoerro('Não gerado comissão a pagar.   Transação :'+Transacaotitulo);
           end;
           FGeral.FechaQuery(QTitulo);
         end else begin
           Avisoerro('Não gerado comissão a pagar.   OPeração :'+Edoperacao.Text);
         end;
      end;
//////////
// 06.10.10
    Sistema.endprocess('');

  end else if (EdBaixaparcial.text='S') and (marc>1) then begin  // 11.09.08

     TipoBaixaMultipla:='BP';   // Baixa Multipla Parcial
     BaixaDiversasBP;

  end else begin // baixa total do titulo

// 24.05.07 - 11.06.07 - colocado o 'zero' na condicao...
    if  ( trim( Grid.Cells[Grid.getcolumn('bxparciais'),Grid.row] )<>'' ) and
        ( trim( Grid.Cells[Grid.getcolumn('bxparciais'),Grid.row] )<>'0' ) and
        ( marc<=1 )  // 20.10.09
        then // tem baixa parcial
      Baixafinalcomparcial
    else if marc>1 then begin

      BaixaDiversasPendencias;
      TipoBaixaMultipla:='BT';   // Baixa Multipla Total

    end else begin

      BaixaPendencia;
// 06.10.10
      if (Global.Topicos[1278]) and (FGeral.GetConfig1AsFloat('Contacomissao')>0)
         and (EdRecPag.Text='R') then begin
         Transacaotitulo:=GetTransacaoTitulo(Edoperacao.Text);
         if trim(Transacaotitulo)<>'' then begin
           QTitulo:=Sqltoquery('select moes_numerodoc,moes_percomissao,moes_tipomov,moes_repr_codigo from movesto where moes_transacao='+Stringtosql(Transacaotitulo)+
// 03.08.11 - Abra - Andressa ajudou
                         ' and '+FGeral.GetIN('moes_tipomov',Global.CodContrato+';'+Global.CodContratoNota,'C')+
                         ' and moes_status<>''C''');
           if not QTitulo.eof then begin
             if pos(Qtitulo.FieldByName('moes_tipomov').asstring,Global.CodContrato+';'+Global.CodContratoNota+';'+Global.CodRequisicaoAlmox) >0 then begin
               valorcomissaopagar:= ( EdValor.ascurrency+EdJuromora.AsCurrency-EdDescontos.AsCurrency ) * (QTitulo.fieldbyname('moes_percomissao').ascurrency/100);
                GravaPendenciaComissao(Qtitulo.fieldbyname('moes_repr_codigo').asinteger,transacao,Qtitulo.fieldbyname('moes_numerodoc').asstring+Grid.Cells[Grid.getcolumn('pend_parcela'),Grid.row],valorcomissaopagar);
//               FGeral.GravaPendencia(EdDtbaixa.asdate,EdDtmovimento.asdate,EdCodtipo,EdTipocad.text,0,Unidade,Global.CodPendenciaFinanceira,
//                   Transacao,Global.FpgtoAntecipa,'P',Numerodoc,0,valorcomissaopagar,0,'N',0,0,nil )
             end;
           end else begin
             Avisoerro('Não gerado comissão a pagar.   Transação :'+Transacaotitulo);
           end;
           FGeral.FechaQuery(QTitulo);
         end else begin
            Avisoerro('Não gerado comissão a pagar.   OPeração :'+Edoperacao.Text);
         end;
      end;

    end;

//    BaixaAntecipacao;

  end;

// 17.0107
  Global.ContaJurosRecebidos:=FGEral.getconfig1asinteger('CtaJurosrec');
  Global.ContaJurosPagos:=FGEral.getconfig1asinteger('Ctajurospag');
  Global.ContaDescontosConcedidos:=FGEral.getconfig1asinteger('Ctadescconc');
  Global.ContaDescontosobtidos:=FGEral.getconfig1asinteger('Ctadescobtidos');
  if EdRecPag.Text='P' then begin
// 20.08.15 - Novicarnes - cheques a compensar
    if Edcheque.asinteger>0 then
      Cheque:=EdCheque.AsInteger
    else
      Cheque:=strtointdef( copy(EdChequesmar.Text,pos('|',EdChequesmar.Text)+1,6) ,0 );
    Entsai:='S';
// 15.12.09
//    if EdAntecipa.text='S' then
//      Entsai:='E';
    Entsaix:='E';
    xEntsai:='E';
    descjuros:=' Juros Pagos';
    descdescontos:=' Descontos Obtidos';
//    if not global.Topicos[1252] then begin
    ContaJuros:=Global.ContaJurosPagos;
    ContaDescontos:=Global.ContaDescontosobtidos;
// 24.05.07
    if EdContajuros.AsInteger>0 then
      ContaJuros:=EdContajuros.asinteger;
    if EdContaDescontos.asinteger>0 then
      ContaDescontos:=Edcontadescontos.asinteger;
    ContaDescontosTarifaban:=Global.ContaDescontosTarifaBan;
  end else begin
    Cheque:=0;
    Entsai:='E';
//    if EdAntecipa.text='S' then
//      Entsai:='S';
// 15.12.09 - retirado - Abra - quando baixa antecipacao entra na conta de adiantamento
//            para matar a saida do adiantamento quando ele é feito ( adiantado )
    Entsaix:='S';
    xEntsai:='S';
    descjuros:=' Juros Recebidos';
    descdescontos:=' Descontos Concedidos';
    ContaJuros:=Global.ContaJurosRecebidos;
    ContaDescontos:=Global.ContaDescontosConcedidos;
// 24.05.07
    if EdContajuros.AsInteger>0 then
      ContaJuros:=EdContajuros.asinteger;
    if EdContaDescontos.asinteger>0 then
      ContaDescontos:=Edcontadescontos.asinteger;

    ContaDescontosTarifaban:=Global.ContaDescontosConcTarifaBan;
  end;
  vlrantecipa:=0;
//  if (posicaoantecipa>0) and (EdAntecipa.text='S') then begin

  if (EdAntecipa.text='S') then begin
    if Global.Topicos[1269] then begin
// 21.09.09 - rever--talvez 'nunca usar' da mama
      sqlemissao:=' and pend_dataemissao<='+DatetoSql(Sistema.Hoje);
      if ( Global.Topicos[1266] ) and (EdRecPag.text='R') then
        sqlemissao:=' and pend_dataemissao<='+DatetoSql(Sistema.Dataf);
      QAntec:=sqltoquery('select pend_transacao from pendencias where pend_status=''A'''+
                         ' and pend_tipo_codigo='+EdCodtipo.AsSql+
                         ' and pend_databaixa is null'+
                         sqlemissao );
      if not QAntec.eof then begin
        Sistema.Edit('pendencias');
        Sistema.SetField('Pend_DataBaixa',EdDtbaixa.asdate);
        Sistema.SetField('pend_usubaixa',Global.Usuario.codigo);
        Sistema.Post('pend_transacao='+Stringtosql(QAntec.fieldbyname('pend_transacao').asstring)+
                     ' and pend_status=''A''');
      end;
      FGeral.FechaQuery(QAntec);

    end else begin

      if EdREcpag.text='P' then
        FGeral.GravaPendencia(EdDtbaixa.asdate,EdDtmovimento.asdate,EdCodtipo,EdTipocad.text,0,Unidade,Global.CodPendenciaFinanceira,
                       Transacao,Global.FpgtoAntecipa,'R',Numerodoc,0,EdValor.ascurrency+EdJuromora.AsCurrency-EdDescontos.AsCurrency,0,'A',0,0,nil )
      else
        FGeral.GravaPendencia(EdDtbaixa.asdate,EdDtmovimento.asdate,EdCodtipo,EdTipocad.text,0,Unidade,Global.CodPendenciaFinanceira,
                       Transacao,Global.FpgtoAntecipa,'P',Numerodoc,0,EdValor.ascurrency+EdJuromora.AsCurrency-EdDescontos.AsCurrency,0,'A',0,0,nil );
  // 26.03.07 - clessi acha desnecessario
  //    FGeral.GravaMovfin(Transacao,Unidade,xEntSai,EdHist_complemento.text,EdDtbaixa.AsDate,EdDtMovimento.Asdate,
  //                     EdBompara.Asdate,Numerodoc,
  //                     0,0,EdPlan_conta.AsInteger,Edvalor.ascurrency,EdContaDesrec.asinteger,Global.CodPendenciaFinanceira);
    end;
  end;

//  valortitulo:=EdValor.ascurrency;
// 05.04.12 - Abra - Paulo pegou se der juros ou descontos fica errado o valor do capital no caixa
// 17.05.12 - Novicarnes - Jaque - recebimentos com juros fica errado descontando juros
  valortitulo:=EdValor.ascurrency;
  {
  ///////////////////////////
  if EdBaixaParcial.text<>'S' then begin
    if EdREcpag.text='P' then
      valortitulo:=EdValor.ascurrency-EdJuroMora.ascurrency+EdDescontos.AsCurrency
    else
      valortitulo:=EdValor.ascurrency+EdJuroMora.ascurrency-EdDescontos.AsCurrency;
  end;
  ///////////////////////////

  }

// 14.03.14 - Damama - conta de funcionarios - para 'entrar como saida'...
  if (EdPlan_conta.ResultFind.FieldByName('plan_contaabatimentos').asinteger>0) and (EdRecPag.text='R') then EntSai:='S';

  if vlrantecipa>0 then

    valortitulo:=EdVAlor.ascurrency-vlrantecipa

  else if (EdBaixaParcial.text='S') and (marc<=1) then begin  // 09.09.05

// 06.10.05 - em baixa parcial grava igual baixa total o capital e juros/descontos
// mas em pagamentos de financiamentos q baixa direto em conta bancaria tem q separar o capitual dos juros pagos
// retirado em 30.05.07 pois soma no valor baixado o desconto ou juros e na opode
{
    if EdPlan_conta.resultfind.fieldbyname('plan_tipo').asstring='B' then begin
      if EdRecPag.text='P' then begin
        valortitulo:=valortitulo-EdJuromora.ascurrency;
        valortitulo:=valortitulo+EdDescontos.ascurrency;
      end else begin
        valortitulo:=valortitulo+EdJuromora.ascurrency;
        valortitulo:=valortitulo-EdDescontos.ascurrency;
      end;
    end;
}
    FGeral.GravaMovfin(Transacao,Unidade,EntSai,EdHist_complemento.text,EdDtbaixa.AsDate,EdDtMovimento.Asdate,
                       EdBompara.Asdate,Numerodoc,EdHist_codigo.asinteger,Cheque,EdPlan_conta.AsInteger,valortitulo,
                       EdContaDesrec.asinteger,Global.CodPendenciaFinanceira,codrepr,EdCodtipo.asinteger,Edtipocad.text,
                       'N','',transacaocontax);

    if EdJuroMora.AsCurrency>0 then

      FGeral.GravaMovfin(Transacao,Unidade,EntSai,copy(EdHist_complemento.text,1,70)+descjuros,EdDtbaixa.AsDate,EdDtmovimento.Asdate,
                       EdDtBaixa.Asdate,Numerodoc,Hist_mora,Cheque,EdPlan_conta.AsInteger,EdJuroMora.AsCurrency,
                       ContaJuros,Global.CodJurosRecebidos,codrepr,EdCodtipo.asinteger,Edtipocad.text,
                       'N','',transacaocontax)
    else if EdDescontos.AsCurrency>0 then

      FGeral.GravaMovfin(Transacao,Unidade,EntSaix,copy(EdHist_complemento.text,1,70)+descdescontos,EdDtbaixa.AsDate,EdDtmovimento.Asdate,
                       EdDtBaixa.Asdate,Numerodoc,Hist_descontos,Cheque,EdPlan_conta.AsInteger,EdDescontos.AsCurrency,
                       ContaDescontos,Global.CodDescontosDados,codrepr,EdCodtipo.asinteger,Edtipocad.text,
                       'N','',transacaocontax);
// 27.10.05
    if EdTarifa.ascurrency>0 then

      FGeral.GravaMovfin(Transacao,Unidade,EntSaix,'Tarifa bancária',EdDtbaixa.AsDate,EdDtmovimento.Asdate,
                       EdDtBaixa.Asdate,Numerodoc,Hist_descontos,Cheque,EdPlan_conta.AsInteger,EdTarifa.AsCurrency,
                       ContaDescontosTarifaban,Global.CodDescontosTarifaBan,codrepr,EdCodtipo.asinteger,Edtipocad.text,
                       'N','',transacaocontax);

  end else begin

    if marc>1 then   // 23.02.08
      valortitulo:=valortitulos;
// 16.04.08 - Novicarnes - elize - para dar entrada na conta de cheques a compensar quando baixa um pagamento
//    if (FPlano.EContachequeacompensar( EdPlan_conta.AsInteger ) ) and (EdRecPag.Text='P') then
//      Entsai:='E';
// 17.04.08 - estornado
// 11.08.08

    if (Global.Topicos[1265]) and ((EdAntecipa.text='S')) then begin

      marc:=marc;   // para nao lancar nada no caixa bancos;;.

    end else if (not Global.Topicos[1260]) or ( (Global.Topicos[1260]) and (marc<=1) )  or
                (  (TipoBaixaMultipla='BT') and (Global.Topicos[1260]) )
// 02.02.19
                and ( not EdCodtipo.IsEmpty )
      then begin  // 20.11.08

      FGeral.GravaMovfin(Transacao,Unidade,EntSai,EdHist_complemento.text,EdDtbaixa.AsDate,EdDtMovimento.Asdate,
                       EdBompara.Asdate,Numerodoc,EdHist_codigo.asinteger,Cheque,EdPlan_conta.AsInteger,valortitulo,
                       EdContaDesrec.asinteger,Global.CodPendenciaFinanceira,codrepr,EdCodtipo.asinteger,Edtipocad.text,
                       'N','',transacaocontax);
    end;

    if EdJuroMora.AsCurrency>0 then

      FGeral.GravaMovfin(Transacao,Unidade,EntSai,copy(EdHist_complemento.text,1,70)+descjuros,EdDtbaixa.AsDate,EdDtmovimento.Asdate,
                       EdDtBaixa.Asdate,Numerodoc,Hist_mora,Cheque,EdPlan_conta.AsInteger,EdJuroMora.AsCurrency,ContaJuros,
                       Global.CodJurosRecebidos,codrepr,EdCodtipo.asinteger,Edtipocad.text,
                       'N','',transacaocontax)

    else if EdDescontos.AsCurrency>0 then

      FGeral.GravaMovfin(Transacao,Unidade,EntSaix,copy(EdHist_complemento.text,1,70)+descdescontos,EdDtbaixa.AsDate,EdDtmovimento.Asdate,
                       EdDtBaixa.Asdate,Numerodoc,Hist_descontos,Cheque,EdPlan_conta.AsInteger,EdDescontos.AsCurrency,
                       ContaDescontos,Global.CodDescontosDados,codrepr,EdCodtipo.asinteger,Edtipocad.text,
                       'N','',transacaocontax);
// 27.10.05
    if EdTarifa.AsCurrency>0 then

      FGeral.GravaMovfin(Transacao,Unidade,EntSaix,'Tarifa bancária',EdDtbaixa.AsDate,EdDtmovimento.Asdate,
                       EdDtBaixa.Asdate,Numerodoc,Hist_descontos,Cheque,EdPlan_conta.AsInteger,EdTarifa.AsCurrency,
                       ContaDescontosTarifaban,Global.CodDescontosTarifaBan,codrepr,EdCodtipo.asinteger,Edtipocad.text,
                       'N','',transacaocontax);
  end;

// 01.02.19 - Novicarnes - Sandro - pegar valores de cada forneceodor / cliente e gravar
///////////////////////////////////////////////////////////////////////////////////
  if (Global.Topicos[1300]) and ( marc>1 ) and (EdCodtipo.IsEmpty) then begin

     for rr:=1 to Grid.RowCount do begin

        if ( Grid.cells[Grid.getcolumn('marcado'),rr] ='Ok' ) and ( Grid.cells[Grid.getcolumn('pend_operacao'),rr]  <> '' )  then begin

          valortitulo:= TExttovalor( Grid.Cells[Grid.getcolumn('pend_valor'),rr] );
          Numerodoc:=strtointdef( Grid.Cells[Grid.getcolumn('pend_numerodcto'),rr],0 );
          QAntecipa:=sqltoquery('select pend_tipo_codigo,pend_tipocad from pendencias '+
                                ' where pend_operacao = '+Stringtosql( trim(Grid.Cells[Grid.getcolumn('pend_operacao'),rr]) )+
                                ' and pend_operacao = ''N''' );
          tipocad  :=QAntecipa.FieldByName('pend_tipocad').asstring;
          xnome    :=FGeral.GetNomeRazaoSocialEntidade(QAntecipa.FieldByName('pend_tipo_codigo').asinteger,
                                                      QAntecipa.FieldByName('pend_tipocad').asstring,'R');
          FGeral.GravaMovfin(Transacao,Unidade,EntSai,Grid.Cells[Grid.getcolumn('pend_numerodcto'),rr]+' '+Grid.Cells[Grid.getcolumn('pend_parcela'),rr]+' '+xnome,EdDtbaixa.AsDate,EdDtMovimento.Asdate,
                       EdBompara.Asdate,Numerodoc,EdHist_codigo.asinteger,Cheque,EdPlan_conta.AsInteger,valortitulo,
                       EdContaDesrec.asinteger,Global.CodPendenciaFinanceira,codrepr,QAntecipa.FieldByName('pend_tipo_codigo').asinteger,tipocad,
                       'N','',transacaocontax);
          FGeral.FechaQuery(QAntecipa);

        end;

     end;

  end;

// 14.05.13
// 02.05.13 - marca o cheque cadastrado como Emitido -- depois mudar na hora de montar o f12
//            no setaitemschequesemitidos
          if (not EdCheque.IsEmpty) and (EdRecPag.text='P') and (chequeemirec='E')  then begin
             Qb:=Sqltoquery('select plan_contacorrente,plan_codigobanco from plano where plan_ctachequescomp='+EdPlan_conta.AsSql);
// 10.09.14 - Patoterra se for conta de banco 'baixa direto' o cheque
             if (Qb.eof) and (EdPlan_conta.resultfind.fieldbyname('plan_tipo').AsString='B') then begin
               Qb.Close;
               Qb:=Sqltoquery('select plan_contacorrente,plan_codigobanco from plano where plan_conta='+EdPlan_conta.AsSql);
             end;
             if (not Qb.eof) and (EdChequerec.IsEmpty) then begin
               if ( trim(Qb.fieldbyname('plan_codigobanco').asstring)<>'' ) and
                  ( trim(Qb.fieldbyname('Plan_contacorrente').Asstring)<>'' )
                  then begin
                 Sistema.edit('cheques');
                 Sistema.SetField('cheq_valor',EdValor.ascurrency);
                 Sistema.Setfield('cheq_rc','E');
                 Sistema.Setfield('cheq_obs',copy(EdHist_complemento.text,1,60));
                 Sistema.SetField('cheq_emissao',EdDtbaixa.asdate);
// 31.07.14 para sair no relat. de contas a pagar quando escolhe um fornecedor
                 Sistema.SetField('cheq_tipo_codigo',EdCodtipo.asinteger);
                 Sistema.SetField('cheq_tipocad',EdTipocad.text);
// 15.06.15
                 Sistema.SetField('Cheq_predata',EdBompara.asdate);
// 10.09.14 - Patoterra
                 if EdPlan_conta.resultfind.fieldbyname('plan_tipo').AsString='B' then begin
                   Sistema.SetField('cheq_deposito',EdDtbaixa.AsDate);
                   Sistema.SetField('cheq_transbaixa',Transacao);
                 end;
//////////////////
                 Sistema.Post('cheq_status=''N'' and cheq_emirec=''E'''+
                        ' and cheq_cheque='+stringtosql(EdCheque.text)+
                        ' and Cheq_emit_conta='+inttostr(Qb.fieldbyname('Plan_contacorrente').AsInteger)+
                        ' and Cheq_emit_banco='+stringtosql(Qb.fieldbyname('Plan_codigobanco').AsString)+
                        ' and Cheq_deposito is null' );
//                        ' and ( (cheq_rc <> ''E'') or (cheq_rc is null) )' )
               end;
             end else begin
             end;
             FGeral.FechaQuery(Qb);
// 08.05.15 - dava erro em 'qq baixa'...
          end else if (not EdChequesMar.IsEmpty) and (EdRecPag.text='P') and (chequeemirec='R')  then begin
// 07.05.15 - devereda
                 Lista:=TStringList.Create;
                 ListaCheques:=TStringList.Create;
/////                 EdChequesmar.text:='';  // aqui
// 03.08.15 - deverada varios cheques
                 if  not EdChequesmar.isempty then begin
// 03.08.15 - abra chapeco
                   strtolista(ListaCheques,Edchequesmar.text,';',true);
                   for i:=0 to ListaCheques.count-1 do begin
                     if (trim(ListaCheques[i])<>'') and (trim(ListaCheques[i])<>';') then begin
                         strtolista(Lista,ListaCheques[i],'|',true);
                         Sistema.edit('cheques');
                         Sistema.Setfield('cheq_obs',copy(EdHist_complemento.text,1,60));
                         Sistema.SetField('cheq_deposito',EdDtbaixa.asdate);
                         Sistema.SetField('cheq_transbaixa',Transacao);
                         Sistema.SetField('cheq_tipo_codigo',EdCodtipo.asinteger);
                         Sistema.SetField('cheq_tipocad',EdTipocad.text);
// 04.08.15
                         Sistema.SetField('cheq_plan_contadep',EdPlan_conta.asinteger);
                         Sistema.Post('cheq_status=''N'' and cheq_emirec=''R'''+
                                ' and cheq_cheque='+stringtosql(trim(Lista[1]))+
                                ' and cheq_emit_banco='+Stringtosql(trim(Lista[3]))+
                                ' and cheq_predata='+Datetosql(TextToDate(FGeral.TiraBarra(Lista[2])))+
                                ' and Cheq_deposito is null' );
                     end;
                   end;
                 end else if not EdChequerec.isempty then begin
// 19.06.15 - abra chapeco
                   strtolista(Lista,Edchequerec.text,'|',true);
                   Sistema.edit('cheques');
                   Sistema.Setfield('cheq_obs',copy(EdHist_complemento.text,1,60));
                   Sistema.SetField('cheq_deposito',EdDtbaixa.asdate);
                   Sistema.SetField('cheq_transbaixa',Transacao);
                   Sistema.SetField('cheq_tipo_codigo',EdCodtipo.asinteger);
                   Sistema.SetField('cheq_tipocad',EdTipocad.text);
// 04.08.15
                   Sistema.SetField('cheq_plan_contadep',EdPlan_conta.asinteger);
                   Sistema.Post('cheq_status=''N'' and cheq_emirec=''R'''+
                          ' and cheq_cheque='+stringtosql(EdCheque.text)+
                          ' and cheq_emit_banco='+Stringtosql(trim(Lista[3]))+
                          ' and cheq_predata='+Datetosql(TextToDate(FGeral.TiraBarra(Lista[2])))+
                          ' and Cheq_deposito is null' );
                 end else begin
                   Sistema.edit('cheques');
                   Sistema.Setfield('cheq_obs',copy(EdHist_complemento.text,1,60));
                   Sistema.SetField('cheq_deposito',EdDtbaixa.asdate);
                   Sistema.SetField('cheq_transbaixa',Transacao);
                   Sistema.SetField('cheq_tipo_codigo',EdCodtipo.asinteger);
                   Sistema.SetField('cheq_tipocad',EdTipocad.text);
// 04.08.15
                   Sistema.SetField('cheq_plan_contadep',EdPlan_conta.asinteger);
                   Sistema.Post('cheq_status=''N'' and cheq_emirec=''R'''+
                          ' and cheq_cheque='+stringtosql(EdCheque.text)+
                          ' and Cheq_deposito is null' );
                 end;
                 Lista.free;
          end;


// 15.02.05
  global.UltimaOperacaoBaixada:=Grid.Cells[Grid.Getcolumn('pend_operacao'),Grid.row];
// 01.12.09
  if trim(OPbaixaparcial)<>'' then
    global.UltimaOperacaoBaixada:=OPbaixaparcial;
// 24.05.07
  if p>0 then
    Grid.Cells[Grid.getcolumn('bxparciais'),Grid.row]:='OK';


  Sistema.Endtransaction('');

// 19.09.16
///////////////////////////////////////////////////////////////////////////////////
(*
    if Global.Topicos[1045] then begin
        EdUNid_codigo.text:=global.CodigoUnidade;
        EdUnid_codigo.ValidFind;
        caixafilial:=EdUnid_codigo.resultfind.fieldbyname('unid_contacontabil').asinteger;
        if TipoBaixaMultipla='BN' then begin
          if EntSai='E' then begin    // baixa de recebimentos
            debito:=FPlano.GetContaExportacao(EdPlan_conta.asinteger,EdUnid_codigo.text);
            credito:=EdUnid_codigo.resultfind.fieldbyname('unid_clientes').asinteger;
            if (EdContaDesrec.asinteger>0) and (EdContaDesrec.asinteger<>caixafilial) then begin
              credito:=FPlano.GetContaExportacao(EdContaDesrec.asinteger,EdUnid_codigo.text);
            end;
// 13.04.07 - Baixa de clientes - para NAO usar a conta contabil pela conta de despesa informada na baixa
            if ( Global.Topicos[1253] )then begin
               codforne:=EdCodtipo.asinteger;
               tipocad:=EdTipoCad.text;
               if codforne>0 then begin
                 if tipocad='C' then begin
                   if EdDtMovimento.isempty then begin
                     credito:=FCadcli.GetContaExp(codforne,'','XX');
// 03.06.15 - Novicarnes - Leonir - lançar a baixa de venda a associado no ativo usando o campo conta01 do cad. de cliente
                   end else if FCadcli.Getecooperado(codforne) then begin
                     credito:=FCadcli.GetContaExp(codforne,'','XY');
                   end else begin
                     credito:=FCadcli.GetContaExp(codforne);
                   end;
                 end else if tipocad='F' then begin
                   credito:=FFornece.GetContaExp(codforne,EdUnid_codigo.text);
                 end;
              end else if codforne=-1 then begin  // baixou mais de um cli/for na baixa
                 credito:=-2;
               end;
            end else begin
                credito:=EdUnid_codigo.resultfind.fieldbyname('unid_clientes').asinteger;
              end;
            end;


///////////////////////////////////////////////////////////////////////////////
          end else begin   // baixa de pagamentos
////////////////////////////////////////////////////////////////////////////////

            credito:=EdUnid_codigo.resultfind.fieldbyname('unid_caixa').asinteger;
            if EdPlan_Conta.asinteger<>CaixaFilial then begin
               credito:=FPlano.GetContaExportacao(EdPlan_Conta.asinteger,EdUnid_codigo.text);
            end;
/////////////////////

            if EdContaDesrec.asinteger>0 then begin
                debito:=FPlano.GetContaExportacao(EdContaDesrec.asinteger,EdUnid_codigo.text);
                if debito=credito then begin
                  debito:=EdUnid_codigo.resultfind.fieldbyname('unid_fornecedores').asinteger;
                end;
  // 18.04.08 - conta de compensacao
                if (EdContaDesrec.asinteger=FGeral.GetConfig1AsInteger('Ctacheacompensar')) then begin
                  if ( not FPlano.EContachequeacompensar(EdPlan_Conta.asinteger) ) then begin
                    credito:=FPlano.GetContaExportacao(EdPlan_Conta.asinteger,EdUnid_codigo.text);
                    debito:=FPlano.GetContaExportacao( FPlano.GetContaCompensacao(EdPlan_Conta.asinteger),EdUnid_codigo.text);
                  end;
                end;
            end else begin
              debito:=FPlano.GetContaExportacao(Edplan_conta.asinteger,EdUnid_codigo.text);
            end;

          end;   // rec ou pag.

            if EdJuroMora.ascurrency>0 then begin
              credito:=FPlano.GetContaExportacao(contajuros,EdUnid_codigo.text);
            end;
            if EdDescontos.ascurrency>0 then begin
              credito:=FPlano.GetContaExportacao(ContaDescontos,EdUnid_codigo.text);
///////////////////////////
            if (credito=0) and (EdContaDesrec.asinteger>0) then begin
              credito:=FPlano.GetContaExportacao(EdContaDesrec.asinteger,EdUnid_codigo.text);
            end;


        end;   // BN - baixa normal de uma parcela
    end;

    *)
/////////////////////////////////////////////////////////////////////////////////////

// 01.06.07
  if trim( FGeral.GetConfig1AsString('imprrecibo') )<>'' then begin
//    if confirma('Imprimir recibo') then / para nao confirmar duas vezes
//      FImpressao.ImprimeReciboPen(Grid.Cells[Grid.Getcolumn('pend_operacao'),Grid.row]);
      FImpressao.ImprimeReciboPen(global.UltimaOperacaoBaixada);
  end;
  EdTipocad.ClearAll(FBaixaPendencia,99);
  EdPlan_conta.clearall(FBaixaPendencia,99);
// 31.08.05
  EdPlan_conta.setvalue(Arq.TUnidades.fieldbyname('unid_contacontabil').asinteger);
// 02.08.07
  if (EdRecPag.text='R') and (FGeral.GetConfig1AsInteger('Ctacaixabaixarec')>0) then begin
      EdPlan_conta.setvalue( FGeral.GetConfig1AsInteger('Ctacaixabaixarec') );
  end else if (EdRecPag.text='P') and (FGeral.GetConfig1AsInteger('Ctacaixabaixapag')>0) then begin
      EdPlan_conta.setvalue( FGeral.GetConfig1AsInteger('Ctacaixabaixapag') );
  end;
  Grid.Clear;
  EdTipoCad.Setfocus;
end;

procedure TFBaixaPendencia.EdPlan_contaValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////
var forn_naocontab,unidadeconta:string;
begin
  if EdPlan_conta.AsInteger>0 then begin
    if EdPlan_conta.resultfind.Eof then begin
       EdPlan_conta.invalid('Conta não encontrada');
    end else begin
    end;
  end;
// 01.06.07
  if pos(EdPlan_conta.resultfind.fieldbyname('plan_tipo').asstring,'B;C;P')=0 then begin
     EdPlan_conta.invalid('Conta deve ser tipo Caixa ou Banco');
     exit;
  end;
  if EdRecPag.text='P' then begin
    EdCheque.Enabled:=true;
    EdContaDesrec.Title:='Despesa'
  end else begin
//    EdCheque.Enabled:=false;
    EdCheque.Enabled:=true;
    EdCheque.setvalue(0);
    EdContaDesrec.Title:='Receita'
  end;
  EdContaDesrec.Update;
// 27.10.05 - 05.02.14 - Damama
//  if EdPlan_conta.resultfind.fieldbyname('plan_tipo').asstring='B' then begin
    EdTarifa.enabled:= not (Global.Topicos[1288]);
// 04.01.17
    campo:=Sistema.GetDicionario('fornecedores','forn_naocontab');
    if (campo.Tipo<>'') and ( not Global.Topicos[1300] ) then begin
      if Edtipocad.text='C' then forn_naocontab:='N'
      else forn_naocontab:=EdCodtipo.ResultFind.fieldbyname('Forn_naocontab').asstring;
    end else begin
      forn_naocontab:='N';
    end;
// 30.01.17
    campo:=Sistema.GetDicionario('plano','plan_unid_codigo');
    if campo.Tipo<>'' then begin
      unidadeconta:=EdPlan_conta.resultfind.fieldbyname('plan_unid_codigo').asstring;
      if trim(unidadeconta)='' then unidadeconta:=Global.CodigoUnidade;
    end else begin
      unidadeconta:=Global.CodigoUnidade;
    end;
    if unidadeconta<>Global.CodigoUnidade then aviso('Atenção!!! Conta não pertence a unidade em uso');
    
//  end else begin
//    EdTarifa.enabled:=false;
//    EdTarifa.setvalue(0);
//  end;
// 02.12.16
   if (Global.topicos[1045]) and ( EdDtMovimento.asdate > 1 )  then begin
     contaclifor:=0;
     if ( trim( FGeral.GetConfig1AsString('Fornnaocontab') ) = '' )
        or
       ( ( pos( EdCodtipo.Text,FGeral.GetConfig1AsString('Fornnaocontab') ) = 0 )
          and
// 28.12.16
       ( Forn_naocontab<>'S' ) ) then begin
       if Edtipocad.text='C' then
          contaclifor:=(FCadCli.GetContaExp( EdCodtipo.asinteger,Global.CodigoUnidade))
       else if EdTipocad.text='F' then
          contaclifor:=(FFornece.GetContaExp( EdCodtipo.asinteger,Global.CodigoUnidade));
       if contaclifor=0 then begin
         EdPlan_conta.invalid('Cli/for sem conta contábil informada no cadastro');
         exit;
       end;
     end else contaclifor:=-1;

     contacaixaban:=FPlano.GetContaExportacao(EdPlan_conta.asinteger,Global.codigoUnidade);
     if contacaixaban=0 then begin
       EdPlan_conta.invalid('Conta gerencial sem conta contábil informada no cadastro');
       exit;
     end;

   end;

end;

procedure TFBaixaPendencia.bImpreciboClick(Sender: TObject);
begin

   if trim(Grid.Cells[Grid.Getcolumn('pend_operacao'),Grid.row])='' then exit;
   FImpressao.ImprimeReciboPen(Grid.Cells[Grid.Getcolumn('pend_operacao'),Grid.row])

end;

procedure TFBaixaPendencia.EdantecipaValidate(Sender: TObject);
var ContRecPag:string;
    vlrantecipa:currency;
begin
//  if Edantecipa.text='S' then begin
//  end else begin
    posicaoantecipa:=0;
    if (valortitulo=EdValor.ascurrency) and (EdBaixaparcial.text='S')  and (marc<=1) then
      EdAntecipa.invalid('Baixa parcial não permitida em baixa total ou final do título')
    else if (Edvlrantecipa.ascurrency>0) and (EdAntecipa.text<>'S') and ( Global.Topicos[1275] ) then begin
      Avisoerro('Atenção.  Baixa em cliente com crédito normalmente tem que ser com "S" ');
      EdPlan_conta.setfocus;
    end else if (Edvlrantecipa.ascurrency<=0) and (EdAntecipa.text='S') and ( Global.Topicos[1275] ) then begin
      Avisoerro('Atenção.  Baixa em cliente sem crédito normalmente tem que ser com "N" ');
      EdPlan_conta.setfocus;
    end else
      EdPlan_conta.setfocus;
//  end;

end;

procedure TFBaixaPendencia.GridAntecipaDblClick(Sender: TObject);
begin
{
   if confirma('Confirma esta antecipação ? ') then begin
     PAntecipa.Visible:=false;
     GridAntecipa.Visible:=false;
     posicaoantecipa:=GridAntecipa.row;
//     if texttovalor(Gridantecipa.cells[Gridantecipa.getcolumn('pend_valor'),posicaoantecipa]) > EdValor.ascurrency then begin
//       Avisoerro('Não é possível usar esta antecipação.  Valor deve ser menor que o valor a ser baixado');
//       posicaoantecipa:=0;
//     end;
     premessa.enabled:=true;
     grid.enabled:=true;
     bgravar.enabled:=true;
     bsair.enabled:=true;
     EdPlan_conta.setfocus;
   end;
}
end;

procedure TFBaixaPendencia.EdHist_complementoExitEdit(Sender: TObject);
/////////////////////////////////////////////////////////////////////////////////////////////////////
begin
  if Global.Topicos[1256] and (EdRecpag.text='R') and
       (  EdPlan_conta.asinteger=FGeral.GetConfig1AsInteger('Ctacherecebido') ) then begin
       bchequesclick(self);
       bgravarclick(FBaixaPendencia);
  end else if not Global.Topicos[1252] then
    bgravarclick(FBaixaPendencia)
  else if (EdContajuros.enabled) or (Edcontadescontos.Enabled) then
    EdContajuros.setfirsted
  else
    bgravarclick(FBaixaPendencia)
end;

procedure TFBaixaPendencia.GridKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then begin
    if Grid.GetColumn('parcialgrid')=Grid.Col then begin
      if (Global.Topicos[1267]) and (EdTipocad.text='R') then
        Avisoerro('Não permitido baixa parcial neste tipo de pendencia')
      else begin
        EdValorparcial.Enabled:=true;
        EdValorparcial.Visible:=true;
        EdValorParcial.Top:=Grid.TopEdit;
        EdValorParcial.Left:=Grid.LeftEdit;
        EdValorparcial.setvalue( Texttovalor(Grid.Cells[Grid.GetColumn('parcialgrid'),Grid.row]));
        EdValorParcial.setfocus;
      end;
// 02.09.13
    end else if (Grid.GetColumn('pend_datavcto')=Grid.Col) and (Global.Usuario.OutrosAcessos[0718]) then begin
        Grid.cells[Grid.getcolumn('marcado'),Grid.row]:='Ok';
        EdVencimento.Enabled:=true;
        EdVencimento.Visible:=true;
        EdVencimento.Top:=Grid.TopEdit;
        EdVencimento.Left:=Grid.LeftEdit;
        EdVencimento.setdate( TexttoDate( FGeral.TiraBarra(Grid.Cells[Grid.GetColumn('pend_datavcto'),Grid.row])) );
        EdVencimento.setfocus;
// 27.02.14
    end else if (Grid.GetColumn('pend_valor')=Grid.Col) and (Global.Usuario.OutrosAcessos[0720]) then begin
        Grid.cells[Grid.getcolumn('marcado'),Grid.row]:='Ok';
        EdValorParcela.Enabled:=true;
        EdValorParcela.Visible:=true;
        EdValorParcela.Top:=Grid.TopEdit;
        EdValorParcela.Left:=Grid.LeftEdit;
        EdValorParcela.setvalue( TexttoValor( (Grid.Cells[Grid.GetColumn('pend_valor'),Grid.row])) );
        EdValorParcela.setfocus;
    end else begin
      Premessa.enabled:=true;
      pCONTAbaixa.enabled:=true;
      Gridclick(FBaixaPendencia);
    end;
  end;
end;

procedure TFBaixaPendencia.breimiprimeClick(Sender: TObject);
begin
  EdOprecibo.text:=Global.UltimaOperacaoBaixada;
  EDOprecibo.enabled:=true;
  EDOprecibo.visible:=true;
  EDOprecibo.setfocus;

end;

procedure TFBaixaPendencia.EdOpreciboValidate(Sender: TObject);
begin
  if not EdOprecibo.isempty then
    FImpressao.ImprimeReciboPen(EdOprecibo.text);
  EDOprecibo.enabled:=false;
  EDOprecibo.visible:=false;

end;

procedure TFBaixaPendencia.EdContaDesrecValidate(Sender: TObject);
begin
  if not EdContaDesrec.isempty then begin
    if EdContaDesrec.resultfind.Eof then
       EdContaDesrec.invalid('Conta não encontrada')
// 31.08.15
    else if (EdContaDesREc.Enabled) and (EdContaDesrec.resultfind<>nil) then begin
      if EdContaDesrec.resultfind.FieldByName('plan_tipo').asstring='S' then EdContaDesRec.invalid('Conta não pode ser sintética');
    end else if (EdContaDesrec.asinteger=FGeral.GetConfig1AsInteger('Ctabaixarec')) and (EdRecpag.Text='P') then
       EdContaDesrec.invalid('Conta padrão de recebimentos não pode receber saidas')
    else if (EdContaDesrec.asinteger=FGeral.GetConfig1AsInteger('Ctabaixapag')) and (EdRecpag.Text='R') then
       EdContaDesrec.invalid('Conta padrão de pagamentos não pode receber entradas');
   if  (Global.topicos[1045]) and ( EdDtMovimento.asdate > 1 )  then begin
       if not FGeral.TemContaContabil(EdCodTipo.asinteger,EdtipoCad.text,Unidade,'FIN') then begin
          if FPlano.GetContaExportacao(EdContaDesrec.AsInteger,Unidade)=0 then
            EdContaDesrec.invalid('Falta reduzido contábil nesta conta de despesas OU neste cliente/fornecedor.')
       end;
   end;

  end;
end;

procedure TFBaixaPendencia.APHeadLabel1DblClick(Sender: TObject);
// 31.08.05 - somente para arrumar as baixas parciais tipo 2
var Q,QBx:TSqlquery;
    transacoes,sqlcliente:string;
    Lista:TStringlist;
    p:integer;
begin

  exit;

  if not confirma('Confirma eliminar todos os títulos ?') then exit;

    Sistema.beginprocess('Lendo baixas parciais');

//    sqlcliente:=' and pend_tipo_codigo=16927';
// so para teste
    sqlcliente:='';

    Q:=sqltoquery('select * from pendencias where pend_status=''P'' and pend_datacont is not null '+sqlcliente);
    Sistema.beginprocess('Checando baixas parciais quanto ao tipo');
    Lista:=Tstringlist.create;


    while not Q.eof do begin
      QBx:=sqltoquery( 'select pend_datacont,pend_transacao from pendencias where pend_numerodcto='+stringtosql(Q.fieldbyname('pend_numerodcto').asstring)+
           ' and pend_unid_codigo='+stringtosql(Q.fieldbyname('pend_unid_codigo').asstring)+' and pend_status=''N'''+
           ' and Pend_DataEmissao='+Datetosql(Q.fieldbyname('Pend_DataEmissao').asdatetime) );
      if not QBx.eof then begin
        if QBx.fieldbyname('pend_datacont').asdatetime<1 then begin
          if Lista.indexof(Q.fieldbyname('pend_operacao').asstring)=-1 then begin
            Lista.add(Q.fieldbyname('pend_operacao').asstring);
            transacoes:=transacoes+Q.fieldbyname('pend_operacao').asstring+',';
          end;
        end;
      end;
      Q.next;
    end;

    if Lista.count>0 then begin
      transacoes:=copy(transacoes,1,length(transacoes)-1);
      if confirma('Encontradas '+inttostr(lista.count)+' pendencias para alterar') then begin
        Sistema.beginprocess('Alterando baixas parciais');
        for p:=0 to Lista.count-1 do begin
          if lista[p]<>'' then begin
            Sistema.Edit('Pendencias');
            Sistema.setfield('pend_datacont',EdDtmovimento.asdate);
            sistema.post('pend_operacao='+stringtosql(lista[p]));
          end;
        end;
        sistema.commit;
        sistema.endprocess('Pendencias alteradas');
      end;
      Qbx.close;
      q.close;
      sistema.endprocess('');
    end;
    sistema.endprocess('');


end;

procedure TFBaixaPendencia.EdQuempagouValidate(Sender: TObject);
begin
  if EdRecpag.text='R' then begin
    if EdquemPagou.isempty then
      EdQuemPagou.invalid('Campo de preenchimento obrigatório');
  end;

end;

function TFBaixaPendencia.QuemPagou(cr: string): string;
begin
  if EdRecpag.text='R' then begin
    if cr='C' then
      result:='CLIENTE'
    else
      result:='REPRESENTANTE';
  end else
    result:='';
end;

procedure TFBaixaPendencia.EdContadescontosExitEdit(Sender: TObject);
begin
    bgravarclick(FBaixaPendencia)

end;

procedure TFBaixaPendencia.EdContajurosValidate(Sender: TObject);
begin
  if not EdContaJuros.isempty then begin
    if EdContaJuros.resultfind.Eof then
       EdContaJuros.invalid('Conta não encontrada');
    if not ValidaConta( EdContaJuros ) then
       EdContaJuros.invalid('');
  end;

end;

procedure TFBaixaPendencia.EdContadescontosValidate(Sender: TObject);
begin
  if not EdContaDescontos.isempty then begin
    if EdContaDescontos.resultfind.Eof then
       EdContaDescontos.invalid('Conta não encontrada');
    if not ValidaConta( EdContaDescontos ) then
       EdContaDescontos.invalid('');
  end;

end;

procedure TFBaixaPendencia.EdJuroMoraValidate(Sender: TObject);
begin
   if (EdJuroMora.ascurrency>0) and (Global.Topicos[1252]) then
     EdContajuros.Enabled:=true
   else
     EdContajuros.Enabled:=false;
end;

function TFBaixaPendencia.ValidaConta(Ed: TSqled): boolean;
var i:integer;
    achou:boolean;
begin
  result:=true;
  achou:=false;
  for i:=0 to Ed.Items.Count-1 do begin
    if pos(Ed.Text,Ed.Items.Strings[i])>0 then begin
      achou:=true;
      break;
    end;
  end;
  if ( Global.Usuario.OutrosAcessos[0710] ) and ( not achou ) then
    result:=true
  else if not achou then begin
    result:=false;
    Avisoerro('Conta não configurada e usuário sem permissão');
  end;
end;

procedure TFBaixaPendencia.bchequesClick(Sender: TObject);
begin
  if EdCodtipo.asinteger>0 then
    FCadcheques.execute( EdCheque.text,EdDtbaixa.asdate,EdDtbaixa.asdate,EdCodtipo.asinteger,EdValor.ascurrency )
  else
    Avisoerro('Falta informar numero do cheque , data e codigo do cliente');

end;

procedure TFBaixaPendencia.breciboClick(Sender: TObject);
var valors:string;
    valor:currency;
    duasvias:boolean;
begin
  if (not Edtipocad.IsEmpty) and ( not EdCodtipo.isempty ) and ( not EdRecpag.IsEmpty ) then begin
     if not Input('Informe o valor','Valor ',valors,12,true) then exit;
// 30.06.14 - Rumo Certo - Mari
     if Global.topicos[1290]  then begin
       duasvias:=false;
     end else begin
// 29.11.11 - Capeg - Mari
       duasvias:=Confirma('Duas vias na mesma página ?');
     end;
     valor:=Texttovalor(valors);
     FReciboavulso.execute(EdTipocad.text,EdCodtipo.asinteger,EdRecpag.text,valor,duasvias);
  end;
end;

procedure TFBaixaPendencia.EdValorparcialExitEdit(Sender: TObject);
begin
   EdValorparcial.visible:=false;
   Edvalorparcial.enabled:=false;
   if EdValorparcial.ascurrency=0 then
     Grid.cells[Grid.getcolumn('marcado'),Grid.row]:=''
   else
     Grid.cells[Grid.getcolumn('marcado'),Grid.row]:='Ok';

     Grid.Cells[Grid.GetColumn('parcialgrid'),Grid.row]:=formatfloat(f_cr,EdValorparcial.ascurrency);
     GridtoEdits;
     EdValor.setvalue(valortitulos);

   Grid.setfocus;
end;

procedure TFBaixaPendencia.EdValorparcialValidate(Sender: TObject);
var valor,parcial:currency;
begin
//   if EdValorparcial.ascurrency>( Texttovalor(Grid.cells[Grid.getcolumn('pend_valor'),grid.row])-Texttovalor(Grid.cells[Grid.getcolumn('bxparciais'),grid.row])-Texttovalor(Grid.cells[Grid.getcolumn( 'parcialgrid'),grid.row]) )then begin
// 09.10.08
   valor:=Texttovalor(Grid.cells[Grid.getcolumn('pend_valor'),grid.row]);
   parcial:=Texttovalor(Grid.cells[Grid.getcolumn('bxparciais'),grid.row]);
   if EdValorparcial.ascurrency>( valor-parcial )then begin
     EdValorparcial.invalid('Valor deve ser menor que o valor do título.');
//     EdValorparcial.invalid( edvalorparcial.text + ' > '+floattostr( valor+parcial) ) ;
     EdValorparcial.setvalue(0);
//     +Grid.cells[Grid.getcolumn('pend_parcela'),grid.row]+
//                            ' '+Grid.cells[Grid.getcolumn('bxparciais'),grid.row]);
   end;
end;

procedure TFBaixaPendencia.bmarcatodosClick(Sender: TObject);
var x:integer;
    valor,valorjuros,valortitulo:currency;
    vencimento,vencimentoori:TDatetime;
begin
  valor:=0;valorjuros:=0;
  OPeracoesMarc:='';
  NotasMarc:='';
  for x:=0 to Grid.rowcount do begin
    if trim( Grid.cells[Grid.getcolumn('pend_operacao'),x] ) <> '' then begin
        Grid.cells[Grid.getcolumn('marcado'),x]:='Ok';
        valor:=valor+Texttovalor( Grid.cells[Grid.getcolumn('pend_valor'),x] );
        Vencimento:=Texttodate( FGeral.tirabarra(Grid.Cells[Grid.getcolumn('pend_datavcto'),x]) );
        vencimentoori:=Texttodate( FGeral.tirabarra(Grid.Cells[Grid.getcolumn('pend_datavctoori'),x]) );
        valortitulo:=texttovalor( Grid.Cells[Grid.getcolumn('pend_valor'),x] );
        if (vencimentoori<=vencimento) and (vencimentoori>0) then
          valorjuros:=valorjuros+FGeral.GetValorJuros(valortitulo,vencimentoori,sistema.hoje,EdRecpag.text)
        else
          valorjuros:=valorjuros+FGeral.GetValorJuros(valortitulo,vencimento,sistema.hoje,EdRecpag.text);
        OPeracoesMarc:=OPeracoesMarc+Grid.cells[Grid.getcolumn('pend_operacao'),x]+';';
        NotasMarc:=NotasMarc+strzero(strtointdef(Grid.cells[Grid.getcolumn('pend_numerodcto'),x],0),6)+';';
    end;
  end;
  EdValor.setvalue(Valor);
  EdTotalValor.setvalue(Valor);
  SetEdJuroMora.setvalue(valorjuros);
  EdVlrAtualizado.setvalue(valor+valorjuros);


end;

// 23.02.18
// 23.02.18
procedure TFBaixaPendencia.balteravalorClick(Sender: TObject);
////////////////////////////////////////////////////////////////////
var xoperacao:string;
    Q:TSqlquery;
    n:integer;
begin

  if trim(Grid.Cells[Grid.GetColumn('pend_operacao'),Grid.Row]) = '' then exit;
  xoperacao:=trim(Grid.Cells[Grid.GetColumn('Pend_operacao'),Grid.Row]);
  Q:=sqltoquery('select pend_transacao from pendencias where pend_operacao = '+Stringtosql(xoperacao)+
                ' and pend_status = ''N''');
  if Q.Eof then begin
     Avisoerro('Não encontrado a transação da operação '+xoperacao);
     exit;
  end;
  n:=0;
  ktransacao:=Q.FieldByName('pend_transacao').AsString;
  while not Q.Eof do begin
    Q.Next;
    inc(n);
  end;
  if n>1 then begin
     Avisoerro('Permitido alterar somente documentos com UMA parcela');
     exit;
  end;
  EdValornota.visible:=true;
  Edvalornota.enabled:=true;
  Edvalornota.setfocus;



end;

procedure TFBaixaPendencia.bboletoClick(Sender: TObject);
begin
  if trim(NotasMarc)='' then begin
    Avisoerro('Nenhum documento foi marcado');
    exit;
  end;
  if (not Edtipocad.IsEmpty) and ( not EdCodtipo.isempty ) and ( not EdRecpag.IsEmpty )
     and ( EdValor.ascurrency>0 )
    then begin
    if not Sistema.GetDataMvto('Vencimento') then exit;
    FImpressao.ImprimeBloqueto(0,0,0,Global.CodigoUnidade,'',Sistema.DataMvto,NotasMarc,EdValor.Ascurrency);
  end;
  bboleto.Enabled:=false;

end;

////////////////////////////////////////////////////////////////////////
procedure TFBaixaPendencia.GravaPendenciaComissao(codrepr:integer;transacao,numero:string;valor: currency);
/////////////////////////////////////////////////////////////////////////////////////////////////////////
var venci,data:Tdatetime;
    Q:TSqlquery;

begin
// 20.05.13 - unidades que geram pagamento de comissao no faturamento
    if pos(Unidade,FGeral.GetConfig1AsString('unidadescomisfatu'))>0 then exit;
    Q:=Sqltoquery('select pend_transacao from pendencias where pend_transacao='+Stringtosql(transacao)+
                  ' and pend_rp=''P'' and pend_tipocad=''R'' and pend_tipo_codigo='+inttostr(CodRepr)+
                  ' and pend_unid_codigo='+Stringtosql(Unidade)+
                  ' and pend_tipomov='+Stringtosql(Global.CodPendenciaFinanceira)+
                  ' and pend_numerodcto='+Stringtosql(Numero)+
                  ' and pend_status=''N''');
    if Q.eof then begin
        Sistema.Insert('Pendencias');
        Sistema.SetField('Pend_Transacao',Transacao);
        Sistema.SetField('Pend_Operacao',FGeral.GetOperacao);
        Sistema.SetField('Pend_Status','N');
        Sistema.SetField('Pend_DataLcto',Sistema.Hoje);

        if EdDtMOvimento.asdate > 1 then
          Sistema.SetField('Pend_DataMvto',EdDtMOvimento.asdate)
        else
          Sistema.SetField('Pend_DataMvto',EdDtBaixa.asdate);

        Sistema.SetField('Pend_DataCont',EdDtMOvimento.asdate);
        Sistema.SetField('Pend_ValorComissao',0);
        if Datetodia(EdDtbaixa.asdate)>=26 then begin
          Data:=Datetodatemespos(EdDtbaixa.asdate,2);
        end else begin
          Data:=Datetodatemespos(EdDtbaixa.asdate,1);
        end;
        venci:=TextToDate( '05'+strzero(Datetomes(data),2)+strzero(Datetoano(Data,true),4) );
//        Sistema.SetField('Pend_DataVcto',FGeral.GetProximoDiaUtil(Emissao+Inteiro(ListaPrazos[p-1])) );
        Sistema.SetField('Pend_DataVcto',venci );
        Sistema.SetField('pend_datavctoori',venci );
        Sistema.SetField('Pend_DataEmissao',EdDtBaixa.asdate);
        Sistema.SetField('Pend_Plan_Conta',0);  // contagerencial
        Sistema.SetField('Pend_Tipo_Codigo',CodRepr );
        Sistema.SetField('Pend_Tipocad','R' );

        Sistema.SetField('Pend_Unid_Codigo',Unidade);
//        Sistema.SetField('Pend_Fpgt_Codigo',Condicao);
//        Sistema.SetField('Pend_Port_Codigo',Portador);
//        Sistema.SetField('Pend_Hist_Codigo',Global.VCHist);
        Sistema.SetField('Pend_Moed_Codigo','');
        Sistema.SetField('Pend_Repr_Codigo',CodRepr);
  //      Sistema.SetField('Pend_CNPJCPF',EdCliente.Resultfind('clie_cnpjcpf);
        Sistema.SetField('Pend_Complemento','Comissão sobre venda contrato');
        Sistema.SetField('Pend_NumeroDcto',Numero);
        Sistema.SetField('Pend_Parcela',1);
        Sistema.SetField('Pend_NParcelas',1);
        Sistema.SetField('Pend_RP','P');
  ///////////////////////////////////////////////////////////////
        Sistema.SetField('Pend_Valor',valor);
        Sistema.SetField('Pend_ValorTitulo',valor);

        Sistema.SetField('Pend_Juros',0);
        Sistema.SetField('Pend_Multa',0);
        Sistema.SetField('Pend_Mora',0);
        Sistema.SetField('Pend_Acrescimos',0);
        Sistema.SetField('Pend_Descontos',0);
        Sistema.SetField('Pend_TransBaixa','');  // no. transacao da baixa
        Sistema.SetField('Pend_ContaBaixa',0);
  //        Sistema.SetField('Pend_DataBaixa',0);
        Sistema.SetField('Pend_Observacao','');
  //      Sistema.SetField('Pend_UsuAutPgto','');
        Sistema.SetField('Pend_Impresso',0);   // numero do impresso relacionado
        Sistema.SetField('Pend_ImprDcto','');  // S ou N se o impresso já foi enviado para impressão
        Sistema.SetField('Pend_LoteCNAB',0);  // no. lote para exportação bancária (CNAB )
        Sistema.SetField('Pend_tipomov',Global.CodPendenciaFinanceira);
        Sistema.SetField('Pend_usua_codigo',Global.Usuario.Codigo);
        Sistema.Post;
    end;
    FGeral.FechaQuery(Q);
end;

function TFBaixaPendencia.GetCampo(tabela,campostatus, status,campopesquisar, campoabuscar,  variavelabuscar: string): string;
////////////////////////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Q:=Sqltoquery('select '+campoabuscar+' from '+tabela+' where '+campostatus+' = '+Stringtosql(status)+
                ' and '+campopesquisar+' = '+Stringtosql(variavelabuscar) );
  if not Q.eof then
    result:=Q.fieldbyname(campoabuscar).AsString
  else
    result:='';
  FGeral.FechaQuery(Q);
end;

// 18.10.19
function TFBaixaPendencia.GetPlaca(xop: string): string;
//////////////////////////////////////////////////////////
var xtr,
    xplaca,
    xtran  : string;

begin

   xtr    := GetCampo('pendencias','pend_status','N','pend_operacao','pend_transacao',xop);
   xtran  := GetCampo('movesto','moes_status','N','moes_transacao','moes_tran_codigo',xtr);
   xplaca := FTransp.Getplaca( xtran);
   result := xplaca;

end;

// 07.05.15
procedure TFBaixaPendencia.EdChequeValidate(Sender: TObject);
/////////////////////////////////////////////////////////////
var lista:TStringList;
begin
  if (EdPlan_conta.resultfind.fieldbyname('plan_tipo').AsString='C') and ( not Edcheque.IsEmpty )
     and ( Edcheque.AsInteger<=EdCheque.Items.Count )
    then begin
    Edchequerec.text:=EdCheque.Items.Strings[Edcheque.AsInteger];
    lista:=TStringList.Create;
    strtolista(lista,EdCheque.Items.Strings[Edcheque.AsInteger],'|',true);
    Edcheque.Text:=lista[1];
    lista.free;
  end;

end;

// 14.05.13
procedure TFBaixaPendencia.SetaItemsChequesEmitidos(Ed: TSqled);
////////////////////////////////////////////////////////////////
var Q,QB:Tsqlquery;
    xind:integer;
begin

   if EdPlan_conta.resultfind<> nil then begin
     Qb:=Sqltoquery('select plan_contacorrente,plan_codigobanco from plano where plan_ctachequescomp='+EdPlan_conta.AsSql);
// 10.09.14 - Patoterra se for conta de banco 'baixa direto' o cheque
     if (Qb.eof) and (EdPlan_conta.resultfind.fieldbyname('plan_tipo').AsString='B') then begin
       Qb.Close;
       Qb:=Sqltoquery('select plan_contacorrente,plan_codigobanco from plano where plan_conta='+EdPlan_conta.AsSql);
     end;
     if not Qb.eof then begin
//        if (Qb.fieldbyname('Plan_contacorrente').AsInteger>0) and (Qb.fieldbyname('Plan_codigobanco').AsString<>'') then begin
// 31.07.14
        if (trim(Qb.fieldbyname('Plan_contacorrente').AsString)<>'') and (Qb.fieldbyname('Plan_codigobanco').AsString<>'') then begin
// 07.10.15
          if pos('-',Qb.fieldbyname('Plan_contacorrente').AsString)>0 then
          Q:=Sqltoquery('select cheq_cheque from cheques where cheq_status=''N'' and cheq_emirec=''E'''+
                    ' and Cheq_emit_conta='+Qb.fieldbyname('Plan_contacorrente').AsString+
                    ' and Cheq_emit_banco='+stringtosql(Qb.fieldbyname('Plan_codigobanco').AsString)+
                    ' and Cheq_deposito is null'+
                    ' order by cheq_cheque' )
          else
          Q:=Sqltoquery('select cheq_cheque from cheques where cheq_status=''N'' and cheq_emirec=''E'''+
    //                ' and Cheq_emit_agencia='+Stringtosql(EdPlan_contasai.resultfind.fieldbyname('Plan_agencia').AsString)+
                    ' and Cheq_emit_conta='+inttostr(Qb.fieldbyname('Plan_contacorrente').AsInteger)+
                    ' and Cheq_emit_banco='+stringtosql(Qb.fieldbyname('Plan_codigobanco').AsString)+
  //                  ' and Extract(year from Cheq_deposito) <= 1902'+
                    ' and Cheq_deposito is null'+
//                    ' and ( (cheq_rc <> ''E'') or (cheq_rc is null) )'+
// 04.09.13 - retirado para pode usar o mesmo cheque em mais de uma baixa de diferentes fornec.
                    ' order by cheq_cheque' );
          Ed.Items.Clear;
          while not Q.eof do begin
             Ed.Items.Add(Q.fieldbyname('cheq_cheque').asstring);
             Q.Next;
          end;
          FGeral.FEchaQuery(Q);
       end;
       ChequeEmiRec:='E';
       Ed.ItemsMultiples:=false;
     end else begin
/////////////////////////
  //       {
         // 06.05.15 - devereda - repasse de cheques recebidos usados para pagamentos
          Q:=Sqltoquery('select cheq_cheque,cheq_emissao,cheq_emit_banco,Cheq_bcoemitente,Cheq_predata from cheques where cheq_status=''N'' and cheq_emirec=''R'''+
                    ' and Cheq_unid_codigo='+stringtosql(global.codigounidade)+
                    ' and Cheq_deposito is null'+
                    ' order by cheq_predata' );
          Ed.Items.Clear;xind:=1;
          Ed.Items.Add('Índice  '+'|'+'Cheque  '+'|'+'Bom Para'+'|'+'Banco do cheque');
          while not Q.eof do begin
             Ed.Items.Add(strzero(xind,8)+'|'+strspace(Q.fieldbyname('cheq_cheque').asstring,8)+'|'+Q.fieldbyname('Cheq_predata').asstring+
                                  '|'+Q.fieldbyname('Cheq_emit_banco').asstring+'  |'+Q.fieldbyname('Cheq_bcoemitente').AsString );
             inc(xind);
             Q.Next;
          end;
          FGeral.FEchaQuery(Q);
          Ed.ItemsMultiples:=true;
          ChequeEmiRec:='R';

//          }
////////////////////////////////////
     end;
     FGeral.FEchaQuery(Qb);
   end;
end;

procedure TFBaixaPendencia.EdPlan_contaExit(Sender: TObject);
/////////////////////////////////////////////////////////////////
begin
// 14.05.13 - Novi - cheques emitidos
  EdBompara.enabled:=false;
  if ( ( EdRecPag.text='P') and (pos(EdPlan_conta.ResultFind.fieldbyname('plan_tipo').asstring,'C')>0)
     and ( EdPlan_conta.resultfind.FieldByName('plan_ctachequescomp').asinteger=0 ) ) then
     SetaItemsChequesEmitidos(EdChequesMar)
  else if
       ( ( EdRecPag.text='P') and (pos(EdPlan_conta.ResultFind.fieldbyname('plan_tipo').asstring,'B')>0) )
     then
       SetaItemsChequesEmitidos(EdCheque);

// 03.08.15 - Deverda
  EdCheque.enabled:=true;
  EdCheque.visible:=true;
  EdChequesmar.enabled:=false;
  EdChequesmar.visible:=false;
  if ( ( EdRecPag.text='P') and (pos(EdPlan_conta.ResultFind.fieldbyname('plan_tipo').asstring,'C')>0)
     and ( EdPlan_conta.resultfind.FieldByName('plan_ctachequescomp').asinteger=0 ) )
     then begin
    EdCheque.enabled:=false;
    EdCheque.visible:=false;
    EdChequesmar.enabled:=true;
    EdChequesmar.visible:=true;
    EdChequesmar.setfocus;
  end else
    EdCheque.setfocus;
///////////////////////////////
  if ( EdRecPag.text='P')
     and ( pos(EdPlan_conta.ResultFind.fieldbyname('plan_tipo').asstring,'C')>0 )
     and ( EdPlan_conta.resultfind.FieldByName('plan_ctachequescomp').asinteger=0 )
     and ( EdPlan_conta.Asinteger<>FUnidades.GetContaCaixa(Global.CodigoUnidade) )
     then
     EdBompara.enabled:=true;



end;

procedure TFBaixaPendencia.EdVencimentoExitEdit(Sender: TObject);
/////////////////////////////////////////////////////////////////////
var q:integer;
    operacoesaalterar:string;
    ListaOp:Tstringlist;
begin
   EdVencimento.visible:=false;
   Edvencimento.enabled:=false;
   operacoesaalterar:='';
   for q:=1 to Grid.rowcount do begin
     if Grid.cells[Grid.getcolumn('marcado'),q]='Ok' then begin
//       Grid.Cells[Grid.GetColumn('pend_datavcto'),q]:=FGeral.FormataData( EdVencimento.asdate );
       operacoesaalterar:=operacoesaalterar+Grid.Cells[Grid.GetColumn('pend_operacao'),q]+';';
     end;
   end;
   if ( trim(operacoesaalterar)<>'' ) and ( trim(operacoesaalterar)<>';' ) then begin
     if confirma('Alterar o vencimento deste(s) títulos  para '+FGeral.FormataData(EdVencimento.Asdate)+' ?') then begin
       ListaOp:=Tstringlist.Create;
       strtolista(Listaop,operacoesaalterar,';',true);
       for q:=0 to Listaop.Count-1 do begin
         if ( trim(Listaop[q])<>'' ) and ( trim(Listaop[q])<>';' ) then begin
           Sistema.Edit('pendencias');
           Sistema.SetField('pend_datavcto',EdVencimento.asdate);
           Sistema.Post('pend_operacao = '+Stringtosql(trim(Listaop[q])));
         end;
       end;
       Listaop.free;
       try
         for q:=1 to Grid.rowcount do begin
           if Grid.cells[Grid.getcolumn('marcado'),q]='Ok' then begin
             Grid.Cells[Grid.GetColumn('pend_datavcto'),q]:=FGeral.FormataData( EdVencimento.asdate );
           end;
         end;
         Sistema.Commit;
       except
         Avisoerro('Não foi possível gravar no banco de dados');
       end;
     end;
   end;
   Grid.setfocus;

end;

procedure TFBaixaPendencia.bdescontodupClick(Sender: TObject);
///////////////////////////////////////////////////////////////
var Qb:TSqlquery;
    xtransacao:string;
begin
/////////
  if Edrecpag.text<>'R' then begin
    Aviso('Opção somente para recebimentos');
    exit;
  end;
  if Edtipocad.text<>'C' then begin
    Aviso('Opção somente para clientes');
    exit;
  end;
  if not escolheugrid then begin
    Aviso('Escolher uma operação para a baixa');
    exit;
  end;
  if not EdDtBaixa.Valid then exit;

  Qb:=sqltoquery('select movf_transacao,movf_datamvto from movfin where movf_status=''N'''+
                 ' and movf_numerodcto='+Stringtosql(trim(Grid.Cells[Grid.getcolumn('pend_numerodcto'),Grid.row]))+
                 ' and movf_codb_codigo='+Stringtosql(trim(Grid.Cells[Grid.getcolumn('pend_parcela'),Grid.row]))+
                 ' and movf_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                 ' and movf_tipo_codigo='+EdCodtipo.assql+
                 ' and movf_es='+Stringtosql('S')+
                 ' and movf_plan_conta='+EdPlan_conta.AsSql );
  if not Qb.eof then begin
    Aviso('Título já lançado na conta '+EdPlan_conta.text+' em '+FGeral.FormataData(Qb.fieldbyname('movf_datamvto').AsDateTime) );
    fGeral.FechaQuery(Qb);
    exit;
  end;
  if confirma('Confirma desconto ? ') then begin
      xTransacao:=FGeral.GetTransacao;
      FGeral.GravaMovfin(xTransacao,Global.CodigoUnidade,'S','Desconto '+EdHist_complemento.text,EdDtbaixa.AsDate,EdDtMovimento.Asdate,
                       EdDtbaixa.AsDate,strtoint(Grid.Cells[Grid.getcolumn('pend_numerodcto'),Grid.row]),
                       EdHist_codigo.asinteger,EdCheque.AsInteger,EdPlan_conta.AsInteger,Edvalor.ascurrency,
                       EdContaDesrec.asinteger,Global.CodLanCaixabancos,
                       EdCodtipo.resultfind.fieldbyname('clie_repr_codigo').asinteger,
                       EdCodtipo.asinteger,Edtipocad.text,Grid.Cells[Grid.getcolumn('pend_parcela'),Grid.row]);
      try
        Sistema.commit;
      except
        Avisoerro('Lançamento não gravado.  Tentar mais tarde');
      end;
      Aviso('Título lançado na conta');
  end;

end;

// 23.02.18
procedure TFBaixaPendencia.EdValornotaExitEdit(Sender: TObject);
/////////////////////////////////////////////////////////////////////
begin

   EdValornota.visible:=false;
   Edvalornota.enabled:=false;
   if EdValorNOta.AsCurrency<=0 then exit;
   Grid.Cells[Grid.GetColumn('pend_valor'),Grid.row]:=formatfloat(f_cr,EdValornota.ascurrency);
   GridtoEdits;
   EdValor.setvalue(valortitulos);

   Sistema.Edit('pendencias');
   Sistema.SetField('pend_valor',EdValorNota.ascurrency);
   Sistema.Post('pend_operacao = '+Stringtosql(trim(Grid.Cells[Grid.GetColumn('pend_operacao'),Grid.row] )));

   Sistema.Edit('movesto');
   Sistema.SetField('moes_vlrtotal',EdValorNota.ascurrency);
   Sistema.Post('moes_transacao = '+Stringtosql(ktransacao) );

   Sistema.Edit('movbase');
   Sistema.SetField('Movb_BaseCalculo',EdValorNota.ascurrency);
   Sistema.Post('movb_transacao = '+Stringtosql(ktransacao) );

   Sistema.Commit;
   Grid.setfocus;


end;

procedure TFBaixaPendencia.EdValorparcelaExitEdit(Sender: TObject);
/////////////////////////////////////////////////////////////////////////
begin
   EdValorparcela.visible:=false;
   Edvalorparcela.enabled:=false;
   if EdValorparcela.ascurrency=0 then
     Grid.cells[Grid.getcolumn('marcado'),Grid.row]:=''
   else
     Grid.cells[Grid.getcolumn('marcado'),Grid.row]:='Ok';

   Grid.Cells[Grid.GetColumn('pend_valor'),Grid.row]:=formatfloat(f_cr,EdValorparcela.ascurrency);
   GridtoEdits;
   EdValor.setvalue(valortitulos);
   Sistema.Edit('pendencias');
   Sistema.SetField('pend_valor',EdValorParcela.ascurrency);
   Sistema.Post('pend_operacao = '+Stringtosql(trim(Grid.Cells[Grid.GetColumn('pend_operacao'),Grid.row] )));
   Sistema.Commit;
   Grid.setfocus;

end;

procedure TFBaixaPendencia.EdChequesmarValidate(Sender: TObject);
begin
    if Edbompara.enabled then Edbompara.setfocus;
end;

end.

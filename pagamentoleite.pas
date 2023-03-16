unit pagamentoleite;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, SqlDtg, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr;

type
  TFPagamentoLeite = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bbaixa: TSQLBtn;
    bSair: TSQLBtn;
    bimprecibo: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    PRemessa: TSQLPanelGrid;
    EdDtinicio: TSQLEd;
    EdDtFim: TSQLEd;
    PCheques: TSQLPanelGrid;
    GridPag: TSqlDtGrid;
    EdPrimeirocheque: TSQLEd;
    bmarcatodos: TSQLBtn;
    bdesmarcatodos: TSQLBtn;
    EdPlan_conta: TSQLEd;
    EdPlan_descricao: TSQLEd;
    Edvlrminimo: TSQLEd;
    Edvlrabaixar: TSQLEd;
    bchequesmatricial: TSQLBtn;
    Edtotalleite: TSQLEd;
    Edtotalinss: TSQLEd;
    Edtotalparcelas: TSQLEd;
    Edtotaliquido: TSQLEd;
    Edtotalapagar: TSQLEd;
    cbsoma: TCheckBox;
    cbtodosemaberto: TCheckBox;
    EdNUmcheque: TSQLEd;
    EdCliente: TSQLEd;
    Pnomecliente: TSQLPanelGrid;
    EdBaixa: TSQLEd;
    Edtransvendas: TSQLEd;
    Edvencimento: TSQLEd;
    breldeposito: TSQLBtn;
    GridParcial: TSqlDtGrid;
    Edvalorparcial: TSQLEd;
    procedure EdDtFimExitEdit(Sender: TObject);
    procedure bbaixaClick(Sender: TObject);
    procedure bimpreciboClick(Sender: TObject);
    procedure bmarcatodosClick(Sender: TObject);
    procedure bdesmarcatodosClick(Sender: TObject);
    procedure GridPagClick(Sender: TObject);
    procedure EdvlrabaixarExitEdit(Sender: TObject);
    procedure GridPagDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure EdPlan_contaValidate(Sender: TObject);
    procedure bchequesmatricialClick(Sender: TObject);
    procedure GridPagKeyPress(Sender: TObject; var Key: Char);
    procedure cbtodosemabertoClick(Sender: TObject);
    procedure EdNUmchequeExitEdit(Sender: TObject);
    procedure EdClienteValidate(Sender: TObject);
    procedure EdtransvendasExitEdit(Sender: TObject);
    procedure breldepositoClick(Sender: TObject);
    procedure GridPagKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridParcialKeyPress(Sender: TObject; var Key: Char);
    procedure EdvalorparcialExitEdit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(xtipomov:string='NP');
  end;

type TValores=record
     moes_tipo_codigo:integer;
     leite,vendas,inss:currency;
     transacoes,baixado,transacoesvenda,tranbaixa:string;
end;

var
  FPagamentoLeite: TFPagamentoLeite;
  PValores:^TValores;
  Lista:TList;
  jabaixou,cTipoMov:string;
  produtoresmarcados:integer;

implementation

uses Geral, SqlFun, Sqlsis, Unidades, impressao, plano, cadcli, Relfinan;


{$R *.dfm}

// 01.01.15
procedure TFPagamentoLeite.EdDtFimExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////////////
var Q,QCh:TSqlquery;
    totalleite,totalvendas,valortotalcheque:currency;
    l,i,primcheque:integer;
    s,sqlemaberto,sqlcliente,sqlvencimento:string;

    Function GetTransacaoBaixa(xt:string):string;
    /////////////////////////////////////////////////
    var QB:TSqlquery;
    begin
      Qb:=sqltoquery('select pend_transbaixa from pendencias where pend_transacao='+Stringtosql(xt));
      if Qb.eof then result:='' else result:=Qb.fieldbyname('pend_transbaixa').asstring;
      FGeral.FechaQuery(Qb);
    end;


    procedure Atualiza;
    ///////////////////
    var p:integer;
        achou:boolean;
    begin
      achou:=false;
      for p:=0 to Lista.count-1 do begin
        PValores:=Lista[p];
        if PValores.moes_tipo_codigo=Q.fieldbyname('moes_tipo_codigo').asinteger then begin
          achou:=true;
          break;
        end;
      end;
      if not achou then begin
        New(PValores);
        PValores.moes_tipo_codigo:=Q.fieldbyname('moes_tipo_codigo').asinteger;
        PValores.leite:=0;
        PValores.vendas:=0;
        PValores.inss:=0;
        PValores.baixado:='N';
        PValores.tranbaixa:='';
        if Q.fieldbyname('moes_tipomov').asstring=cTipoMov then begin
          PValores.leite:=Q.fieldbyname('total').ascurrency;
          PValores.inss:=Q.fieldbyname('moes_funrural').ascurrency;
          PValores.baixado:=Q.fieldbyname('status').asstring;
          PValores.transacoes:=Q.fieldbyname('moes_transacao').asstring;
          PValores.transacoes:=Q.fieldbyname('moes_transacao').asstring;
        end else if Q.fieldbyname('status').asstring='N' then begin
          PValores.vendas:=Q.fieldbyname('total').ascurrency;
          PValores.transacoesvenda:=Q.fieldbyname('moes_transacao').asstring;
        end else begin
          PValores.baixado:='S';
          PValores.transacoes:=Q.fieldbyname('moes_transacao').asstring;
          PValores.tranbaixa:='';
        end;
        Lista.Add(Pvalores);
      end else begin
        if Q.fieldbyname('moes_tipomov').asstring=cTipoMov then begin
          PValores.leite:=PValores.leite+Q.fieldbyname('total').ascurrency;
          PValores.inss:=PValores.inss+Q.fieldbyname('moes_funrural').ascurrency;
          PValores.transacoes:=PValores.transacoes+';'+Q.fieldbyname('moes_transacao').asstring;
        end else if Q.fieldbyname('status').asstring='N' then begin
            PValores.vendas:=PValores.vendas+Q.fieldbyname('total').ascurrency;
            PValores.transacoesvenda:=PValores.transacoesvenda+';'+Q.fieldbyname('moes_transacao').asstring;
// desconta o que foi baixado parcialmente - 17.04.15 - para nao descontar BP do mes anterior do proprio pag. leite
//        else if (Q.fieldbyname('status').asstring='P') and (Q.fieldbyname('pend_observacao').asstring<>'Pagamento Leite') then
// 22.04.15 - coorlaf reserva
// 14.08.15 - coorlaf Pitanga
//        end else if (Q.fieldbyname('status').asstring='P') and (Q.fieldbyname('pend_observacao').asstring<>'Pagamento Leite')
//             and (Q.fieldbyname('pend_databaixa').asdatetime>=EdDtinicio.asdate)
//            then begin
        end else if (Q.fieldbyname('status').asstring='P') and (Q.fieldbyname('pend_databaixa').asdatetime>=(EdDtinicio.asdate-30))
            and (Q.fieldbyname('pend_databaixa').asdatetime<EdDtInicio.asdate)
            then begin
            PValores.vendas:=PValores.vendas-Q.fieldbyname('total').ascurrency;
//            PValores.transacoesvenda:=PValores.transacoesvenda+';'+Q.fieldbyname('moes_transacao').asstring;
        end;
//        PValores.transacoes:=PValores.transacoes+';'+Q.fieldbyname('moes_transacao').asstring;
      end;
    end;


    function SemConta( xcodigo:integer ):boolean;
    /////////////////////////////////////////////
    var QC:TSqlquery;
    begin
      Qc:=sqltoquery('select clie_contacorrente from clientes where clie_codigo='+inttostr(xcodigo));
      if not Qc.Eof then result:=(Qc.FieldByName('clie_contacorrente').AsString='') else result:=true;
      FGeral.fechaquery(qc);
    end;

    // 22.09.15
    function GetValorChequeEmitido(xt:string):currency;
    ////////////////////////////////////////////////////////////
    var w:string;
        Qc:TSqlquery;
    begin
            w:='select cheq_valor from cheques WHERE '+
//            Cheq_emit_conta='+EdPlan_conta.assql+
//               ' and cheq_cmc7='+STringtosql(xtransb)+' and cheq_status=''N'''+
//            Cheq_emit_conta='+EdPlan_conta.assql+
            ' Cheq_datacont >= '+EdDtInicio.assql+
            ' and Cheq_datacont <= '+EdDtFim.assql+
            ' and cheq_tipo_codigo = '+inttostr(PVAlores.moes_tipo_codigo)+
            ' and Cheq_unid_codigo = '+stringtosql(Global.CodigoUnidade) ;
            Qc:=Sqltoquery( w );
            if not Qc.eof then result:=Qc.fieldbyname('cheq_valor').ascurrency;
          FGeral.fechaquery(Qc);
    end;

begin
///////
   PMens.Caption:='Pesquisando notas de produtor e vendas a ser descontadas';
   PMens.Update;
   sqlcliente:='';sqlvencimento:='';
   if not EdCliente.IsEmpty then sqlcliente:=' and moes_tipo_codigo='+EdCliente.assql;
//   Q:=sqltoquery('select moes_tipo_codigo,moes_tipomov,moes_vlrtotal as total,moes_transacao,'+
// 20.01.16
   Q:=sqltoquery('select moes_tipo_codigo,moes_tipomov,moes_totprod as total,moes_transacao,'+
                 ' pend_status as status,clie_razaosocial,moes_funrural,moes_cotacapital,pend_observacao from movesto'+
                 ' inner join pendencias on ( pend_transacao=moes_transacao and pend_tipomov=moes_tipomov )'+
                 ' inner join clientes on ( clie_codigo=moes_tipo_codigo )'+
                 ' where moes_status=''N'''+
                 ' and '+FGeral.getin('moes_unid_codigo',Global.codigounidade,'C')+
                 ' and moes_datacont > '+Datetosql(Global.DataMenorBanco)+
                 ' and moes_dataemissao >= '+EdDtINicio.AsSql+
                 ' and moes_dataemissao <= '+EdDtFim.AsSql+
                 ' and '+FGeral.GetIn('pend_status','N;B','C')+
                 sqlcliente+
//                 ' and '+FGeral.GetIN('moes_tipomov',Global.TiposRelVenda+';'+Global.CodCompraProdutor,'C')+
// ao inves das vendas pegar o parcelamento q vence no mes
                 ' and '+FGeral.GetIN('moes_tipomov',cTipoMov,'C')+
                 ' order by clie_razaosocial');
   produtoresmarcados:=0;
   PMens.Caption:='Somando valores...';
   PMens.Update;
   if Q.Eof then begin
     Q.close;
// 13.05.15 - so pra pegar as NM feitas a vista em maio....
//     Q:=sqltoquery('select moes_tipo_codigo,moes_tipomov,moes_vlrtotal as total,moes_transacao,'+
// 20.01.16
     Q:=sqltoquery('select moes_tipo_codigo,moes_tipomov,moes_totprod as total,moes_transacao,'+
                   ' moes_status as status,clie_razaosocial,moes_funrural,moes_cotacapital,moes_mensagem as pend_observacao from movesto'+
                   ' inner join clientes on ( clie_codigo=moes_tipo_codigo )'+
                   ' where moes_status=''N'''+
                   ' and '+FGeral.getin('moes_unid_codigo',Global.codigounidade,'C')+
                   ' and moes_datacont > '+Datetosql(Global.DataMenorBanco)+
                   ' and moes_dataemissao >= '+EdDtINicio.AsSql+
                   ' and moes_dataemissao <= '+EdDtFim.AsSql+
                   sqlcliente+
                   ' and '+FGeral.GetIN('moes_tipomov',cTipoMov,'C')+
                   ' order by clie_razaosocial');
     if Q.eof then begin
       Avisoerro('Nada encontrado neste período');
       exit;
     end;
   end;
   totalleite:=0;totalvendas:=0;
   GridPag.Clear;
   l:=1;
   Lista:=TList.create;
   jabaixou:='N';
   while not Q.eof do begin
     Atualiza;
     Q.Next;
   end;
   FGeral.FechaQuery(Q);
//   sqlemaberto:= ' and extract( year from pend_datavcto ) = '+inttostr(Datetoano(Sistema.hoje,true))+
//                 ' and extract( month from pend_datavcto ) = '+inttostr(Datetomes(Sistema.hoje));
   if cbtodosemaberto.Checked then sqlemaberto:='';
// 15.05.15 - coorlaf pitanga
   sqlemaberto:='';
   sqlcliente:='';
   if not EdCliente.IsEmpty then sqlcliente:=' and pend_tipo_codigo='+EdCliente.assql;
   if EdVencimento.asdate>0 then sqlvencimento:=' and pend_datavcto<='+Datetosql(EdVencimento.asdate);

// 25.01.15
   PMens.Caption:='Somando recebimentos...';
   PMens.Update;
   Q:=sqltoquery('select pend_tipo_codigo as moes_tipo_codigo,pend_tipomov as moes_tipomov,'+
                 ' pend_valor as total,pend_transacao as moes_transacao,pend_status as status,pend_observacao,pend_databaixa'+
                 ' from pendencias'+
                 ' where '+FGeral.GetIN('pend_status','N;P','C')+
                 ' and '+FGeral.getin('pend_unid_codigo',Global.codigounidade,'C')+
                 ' and pend_datacont > '+Datetosql(Global.DataMenorBanco)+
//                 ' and pend_datavcto <= '+Datetosql(Sistema.hoje)+
                 sqlemaberto+sqlcliente+sqlvencimento+
                 ' and '+FGeral.GetIN('pend_rp','R','C') );
// zerando as transacoes das vendas para pegar as q vencem no mes atual
//   for i:=0 to Lista.count-1 do begin
//        PValores:=Lista[i];
//        PValores.transacoes:='';
//   end;
///////////////
   PMens.Caption:='Verificando valor liquido...';
   PMens.Update;
   while not Q.eof do begin
     Atualiza;
     Q.Next;
   end;
   FGeral.FechaQuery(Q);

   Edtotalapagar.setvalue( 0);
   Edtotalleite.setvalue( 0 );
   Edtotalinss.setvalue(  0 );
   Edtotalparcelas.setvalue(  0 );
   Edtotaliquido.setvalue( 0 );
   PMens.Caption:='Montando lista';
   PMens.Update;

   primcheque:=EdPrimeirocheque.asinteger;
   for i:=0 to Lista.count-1 do begin
     PValores:=Lista[i];
     if (not EdCliente.isempty) and (l=1) then GridPag.cells[GridPag.getcolumn('marcado'),l]:='Ok';
     GridPag.Cells[GridPag.GetColumn('moes_tipo_codigo'),l]:=inttostr(PValores.moes_tipo_codigo);
     GridPag.Cells[GridPag.GetColumn('clie_razaosocial'),l]:=FGeral.GetNomeRazaoSocialEntidade(PValores.moes_tipo_codigo,'C','R');
     GridPag.Cells[GridPag.GetColumn('vlrleite'),l]:=currtostr(Pvalores.leite);
// 22.09.15
     if PValores.baixado<>'B' then begin
       GridPag.Cells[GridPag.GetColumn('vlrvendas'),l]:=currtostr(Pvalores.vendas);
       GridPag.Cells[GridPag.GetColumn('vlrliquido'),l]:=currtostr(Pvalores.leite-PValores.Inss-Pvalores.vendas);
       GridPag.Cells[GridPag.GetColumn('valorabaixar'),l]:=currtostr(Pvalores.vendas);
     end else begin
// 20.09.16
       PValores.tranbaixa:=GetTransacaoBaixa(Pvalores.transacoes);
       Qch:= sqltoquery('select cheq_valor,cheq_cheque from cheques WHERE '+
//            ' Cheq_datacont >= '+EdDtInicio.assql+
//            ' and Cheq_datacont <= '+EdDtFim.assql+
            ' cheq_cmc7 = '+Stringtosql(PValores.tranbaixa)+
            ' and cheq_tipo_codigo = '+inttostr(PVAlores.moes_tipo_codigo)+
            ' and cheq_unid_codigo = '+stringtosql(Global.CodigoUnidade) );
       GridPag.Cells[GridPag.GetColumn('vlrvendas'),l]:='';
//       GridPag.Cells[GridPag.GetColumn('vlrliquido'),l]:=currtostr(GetValorChequeEmitido(PValores.transacoes+';'+PValores.transacoesvenda));
// 16.11.15
       GridPag.Cells[GridPag.GetColumn('vlrliquido'),l]:=currtostr(Qch.fieldbyname('cheq_valor').ascurrency);
       GridPag.Cells[GridPag.GetColumn('valorabaixar'),l]:='';
     end;
     GridPag.Cells[GridPag.GetColumn('transacoes'),l]:=Pvalores.transacoes;
     GridPag.Cells[GridPag.GetColumn('transacoesvendas'),l]:=Pvalores.transacoesvenda;
     GridPag.Cells[GridPag.GetColumn('vlrinss'),l]:=currtostr(Pvalores.inss);

     if PValores.baixado='B' then begin
       GridPag.Cells[GridPag.GetColumn('cheque'),l]:=Qch.fieldbyname('cheq_cheque').asstring;
       QCh.close;
// 15.08.16 - cheques com valor maior q o limite para nao pagar tarifa
     end else if (EdPrimeirocheque.asinteger>0) and ( SemConta(PValores.moes_tipo_codigo) )
         and ((Pvalores.leite-PValores.Inss-Pvalores.vendas)>FGeral.GetConfig1AsFloat('maxcheque') )
         and (  FGeral.GetConfig1AsFloat('maxcheque')>0 )
         then begin
       GridPag.Cells[GridPag.GetColumn('cheque'),l]:=inttostr(primcheque);
       valortotalcheque:=Pvalores.leite-PValores.Inss-Pvalores.vendas;
       while valortotalcheque > FGeral.GetConfig1AsFloat('maxcheque') do begin
         inc(primcheque);
         valortotalcheque:=valortotalcheque-FGeral.GetConfig1AsFloat('maxcheque');
       end;
       inc(primcheque);
     end else if (EdPrimeirocheque.asinteger>0) and ( SemConta(PValores.moes_tipo_codigo) ) and ((Pvalores.leite-PValores.Inss-Pvalores.vendas)>=EdVlrminimo.ascurrency)  then begin
       GridPag.Cells[GridPag.GetColumn('cheque'),l]:=inttostr(primcheque);
       inc(primcheque);
// 16.11.15
     end else
       GridPag.Cells[GridPag.GetColumn('cheque'),l]:='';
     GridPag.Cells[GridPag.GetColumn('status'),l]:=PValores.baixado;
     GridPag.AppendRow;
     inc(l);
{
     Edtotalapagar.text:=FGEral.Formatavalor( Edtotalapagar.ascurrency+(Pvalores.leite-PValores.Inss-Pvalores.vendas),f_cr );
     Edtotalleite.text:=FGEral.Formatavalor( Edtotalleite.ascurrency+Pvalores.leite,f_cr );
     Edtotalinss.text:= FGEral.Formatavalor( Edtotalinss.ascurrency+Pvalores.inss,f_cr );
     Edtotalparcelas.Text:= FGEral.Formatavalor( Edtotalparcelas.ascurrency+Pvalores.vendas,f_cr );
     Edtotaliquido.text:= FGEral.Formatavalor( Edtotaliquido.ascurrency+(Pvalores.leite-PValores.Inss-Pvalores.vendas),f_cr);
}
     Edtotalapagar.setvalue( ( Edtotalapagar.ascurrency+(Pvalores.leite-PValores.Inss-Pvalores.vendas) ) );
     Edtotalleite.setvalue(  Edtotalleite.ascurrency+Pvalores.leite );
     Edtotalinss.setvalue(  Edtotalinss.ascurrency+Pvalores.inss );
     Edtotalparcelas.setvalue(  Edtotalparcelas.ascurrency+Pvalores.vendas );
     Edtotaliquido.setvalue( ( Edtotaliquido.ascurrency+(Pvalores.leite-PValores.Inss-Pvalores.vendas)));

   end;
   PMens.Caption:='';
   PMens.Update;

//   bmarcatodosclick(self);
end;

procedure TFPagamentoLeite.Execute(xtipomov:string='NP');
//////////////////////////////////////////////////////////////
begin
  if EdDtinicio.IsEmpty then begin
    EdDtinicio.SetDate(Sistema.hoje);
    EdDtFim.SetDate(Sistema.hoje);
  end;
  FPlano.SetaItems(EdPlan_conta,EdPlan_descricao,'B');
  Gridpag.clear;
  EdBaixa.setdate(sistema.hoje);
  Edtotalapagar.text:='';
  Edtotalleite.text:='';
  Edtotalinss.text:='';
  Edtotalparcelas.text:='';
  Edtotaliquido.text:='';
  if xtipomov='NP' then begin
    cTipoMov:=Global.CodCompraProdutor;
    Caption:='Pagamento Leite do Produtor';
  end else begin
    cTipoMov:=xtipomov;
    Caption:='Pagamento Produtos da Merenda do Produtor';
  end;
  Show;
  FGeral.ConfiguraColorEditsNaoEnabled(FPagamentoLeite);
  EdDtinicio.setfocus;
end;

// 02.01.2015
procedure TFPagamentoLeite.bbaixaClick(Sender: TObject);
///////////////////////////////////////////////////////////
var i,p,conta,Contarecdes,contagerencial,contacaixa,contabaixa:integer;
    xtransacao,xcontasprodutorleite,xsqlvencimento,numerocheque:string;
    valorNP,valorvendas,valorabaixar,valorcheque,valortotalcheque:currency;
    Emit_banco,chequemaior:string;
    Emit_agencia,Emit_conta:integer;


    function GetTransacaoBp(xtrans:string):string;
    /////////////////////////////////////////////////
    var Qb:TSqlquery;
        xt:string;
    begin
      Qb:=sqltoquery('select pend_numerodcto,pend_datavcto,pend_tipomov from pendencias'+
                     ' where '+FGeral.GetIN('pend_transacao',xtrans,'C')+
                     ' and pend_status <> ''C''');
      xt:='';
      while not Qb.eof do begin
        if qb.fieldbyname('pend_tipomov').asstring<>cTipoMov then begin
          xt:=qb.fieldbyname('pend_numerodcto').asstring;
          break;
        end;
        qb.next;
      end;
      FGeral.fechaquery(Qb);
      result:=xt;
    end;

// 15.08.16
    procedure IncluiCheque;
    ////////////////////////
    begin
        Sistema.Insert('Cheques');
        Sistema.Setfield('cheq_status','N');
        Sistema.Setfield('cheq_emirec','E');
        Sistema.Setfield('cheq_cheque',GridPag.cells[GridPag.getcolumn('cheque'),i]);
        Sistema.Setfield('cheq_emissao',Edbaixa.asdate);
    //    Sistema.Setfield('cheq_devolvido',EdCheq_Devolvido.text);
        Sistema.Setfield('cheq_tipo_codigo',strtoint(GridPag.cells[GridPag.getcolumn('moes_tipo_codigo'),i]));
        Sistema.Setfield('cheq_tipocad','C');
        Sistema.Setfield('cheq_bcoemitente','BRASIL');
//        Sistema.Setfield('cheq_emitente',Edcheq_emitente.Text);
//        Sistema.Setfield('cheq_predata',Edcheq_predata.AsDate);
        Sistema.Setfield('cheq_valor',valorcheque );
        Sistema.Setfield('cheq_repr_codigo',1);
//        Sistema.Setfield('cheq_deposito',Edcheq_deposito.asdate);
//        Sistema.Setfield('cheq_prorroga',Edcheq_prorroga.asdate);
        Sistema.Setfield('cheq_datacont',Sistema.Hoje);
        Sistema.Setfield('cheq_lancto',Sistema.hoje);
        Sistema.Setfield('cheq_predata',Edbaixa.asdate);
        Sistema.Setfield('cheq_obs','Pagamento Leite');
        Sistema.Setfield('cheq_unid_codigo',Global.CodigoUnidade);
        Sistema.Setfield('cheq_emit_banco',Emit_banco);
        Sistema.Setfield('cheq_emit_agencia',Emit_agencia);
        Sistema.Setfield('cheq_emit_conta',Emit_conta);
        Sistema.Setfield('cheq_cmc7',xtransacao);
//        Sistema.Setfield('Cheq_bancocustodia',Edcheq_bancustodia.text);
        Sistema.Post;

    end;

    procedure IncluiChequeaCompensar;
    ////////////////////////////////
    begin
        Sistema.Insert('movfin');
        Sistema.Setfield('movf_transacao',xtransacao);
        Sistema.Setfield('movf_operacao',FGeral.Getoperacao);
        Sistema.Setfield('movf_status','N');
        Sistema.Setfield('movf_unid_codigo',Global.CodigoUnidade);
        Sistema.Setfield('movf_datalcto',Sistema.HOje);
        Sistema.Setfield('movf_datamvto',Edbaixa.asdate);
        Sistema.SetField('movf_DataCont',Sistema.HOje);
        Sistema.Setfield('movf_dataprevista',Edbaixa.asdate);
// 15.06.15 - fazer a saida dos que são pagos por transf. bancaria
        if trim(GridPag.cells[GridPag.getcolumn('cheque'),i])='' then begin
          Sistema.Setfield('movf_plan_conta',EdPlan_conta.asinteger);
          Sistema.Setfield('movf_numerodcto','503' );
//          Sistema.Setfield('movf_numerocheque',0);
          Sistema.Setfield('movf_tipomov',Global.CodLanCaixabancos);
        end else begin
          Sistema.Setfield('movf_plan_conta',conta);
//          Sistema.Setfield('movf_numerodcto',GridPag.cells[GridPag.getcolumn('Cheque'),i] );
//          Sistema.Setfield('movf_numerocheque',strtointdef(GridPag.cells[GridPag.getcolumn('Cheque'),i],0));
// 15.08.16
          Sistema.Setfield('movf_numerodcto',numerocheque );
          Sistema.Setfield('movf_numerocheque',strtointdef(numerocheque,0) );
          Sistema.Setfield('movf_tipomov','CH');  // identifica o cheque para usar no recibo
        end;
    //    Sistema.Setfield('movf_hist_codigo',Codhist);
        Sistema.Setfield('movf_complemento','Pagamento Leite '+FCadcli.GetNome( strtoint(GridPag.cells[GridPag.getcolumn('moes_tipo_codigo'),i])));
//        if conta>0 then  // cheque a compensar é saida tbem
//          Sistema.Setfield('movf_es','E')
//        else
          Sistema.Setfield('movf_es','S');
        Sistema.Setfield('movf_valorger',valorcheque );
//        Sistema.Setfield('movf_valorbco',Texttovalor( GridPag.cells[GridPag.getcolumn('vlrliquido'),i] ) );
        Sistema.Setfield('movf_valorbco',valorcheque );
        Sistema.Setfield('movf_plan_contard',Contarecdes);
        Sistema.Setfield('movf_usua_codigo',Global.Usuario.Codigo);
    //    Sistema.Setfield('movf_tipo_codigo',Tipo_Codigo);
    //    Sistema.Setfield('movf_tipocad',Tipocad);
        Sistema.Post();

    end;


begin
///////////////////////

  if jabaixou='S' then begin
    Aviso('Cancelar a transação da baixa antes de gerar novamente');
    exit;
  end;
  if edplan_conta.ResultFind=nil then begin
    Avisoerro('Checar a conta informada');
    exit;
  end;
  xContasProdutorLeite:=FGeral.GetConfig1AsString('Ctaprodleite');
  if trim(xContasProdutorLeite)='' then begin
     Avisoerro('Falta configurar a(s) conta(s) de produção de leite nas configurações aba geral');
     exit;
  end;
// 18.03.15
  Contabaixa:=FGeral.GetConfig1AsInteger('Ctapagleite');
  if ContaBaixa=0 then begin
     Avisoerro('Falta configurar a conta para baixa do pagamento do leite nas configurações aba geral');
     exit;
  end;

  if pos(';',xContasProdutorLeite)>0 then
     contagerencial:=strtoint(copY(xContasProdutorLeite,1,pos(';',xContasProdutorLeite)))
  else
     contagerencial:=strtointdef(xContasProdutorLeite,0);


  if not Confirma('Confirma baixa ref. nf do produtor, nf de vendas e geração de cheques ?') then exit;
  if ( cbSoma.Checked ) and ( EdPrimeirocheque.isempty ) then begin
    avisoerro('Obrigatório preencher o numero do primeiro cheque');
    exit;
  end;
  if cbSoma.Checked then
    if not confirma('Somar e gerar somente UM cheque para estes produtores ?') then exit;
// baixar as pendencias ref. a nf de produtor E ref. nf de vendas ao produtor
  xtransacao:=FGeral.GetTransacao;
  valorNP:=0;valorvendas:=0;valorabaixar:=0;
  Emit_banco:=EdPlan_conta.ResultFind.fieldbyname('Plan_codigobanco').asstring;
  Emit_agencia:=strtointdef(EdPlan_conta.ResultFind.fieldbyname('Plan_agencia').asstring,0);
  Emit_conta:=EdPlan_conta.asinteger;
  Sistema.beginprocess('Baixando financeiro a pagar/receber e gerando os cheques a emitir');
// 16.07.15
  xsqlvencimento:='';
  if EdVencimento.asdate>0 then xsqlvencimento:=' and pend_datavcto<='+Datetosql(EdVencimento.asdate);

// gerando um cheque para pagar varios produtores
/////////////////////////////////////////////////
  if cbSoma.Checked then begin
    for i:=0 to GridPag.rowcount-1 do begin
      if ( trim( GridPag.cells[GridPag.getcolumn('moes_tipo_codigo'),i] )<>'' )
         and
         ( trim( GridPag.cells[GridPag.getcolumn('status'),i] )='N' )
         and
         ( ( GridPag.cells[GridPag.getcolumn('marcado'),i] )='Ok' )
      then begin
      valorabaixar:=valorabaixar+Texttovalor( GridPag.cells[GridPag.getcolumn('vlrliquido'),i] );
      // baixando as venda e a NP
          Sistema.Edit('pendencias');
          Sistema.setfield('pend_status','B');
          Sistema.setfield('pend_transbaixa',xtransacao);
          Sistema.setfield('pend_databaixa',Edbaixa.asdate);
          Sistema.setfield('pend_contabaixa',contabaixa);
          Sistema.Post('pend_status=''N'' and pend_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                       ' and '+FGeral.GetIN('pend_transacao',GridPag.cells[GridPag.getcolumn('transacoes'),i],'C') );
          valorNP:=valorNP+Texttovalor( GridPag.cells[GridPag.getcolumn('vlrleite'),i] );
// 15.05.15 - para quem nao desconta nada
          if length(trim(GridPag.cells[GridPag.getcolumn('transacoesvendas'),i]))>5 then begin
            Sistema.setfield('pend_status','B');
            Sistema.setfield('pend_transbaixa',xtransacao);
            Sistema.setfield('pend_databaixa',Edbaixa.asdate);
            Sistema.setfield('pend_contabaixa',contabaixa);
            Sistema.Post('pend_status=''N'' and pend_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                         ' and '+FGeral.GetIN('pend_transacao',GridPag.cells[GridPag.getcolumn('transacoesvendas'),i],'C')+
                         xsqlvencimento );
            valorvendas:=valorvendas+Texttovalor( GridPag.cells[GridPag.getcolumn('vlrvendas'),i] );
          end;
      end;
    end;
// gerando somente um cheque com o valor total
        Sistema.Insert('Cheques');
        Sistema.Setfield('cheq_status','N');
        Sistema.Setfield('cheq_emirec','E');
        Sistema.Setfield('cheq_cheque',EdPrimeirocheque.text);
        Sistema.Setfield('cheq_emissao',EdBaixa.asdate);
    //    Sistema.Setfield('cheq_devolvido',EdCheq_Devolvido.text);
//        Sistema.Setfield('cheq_tipo_codigo',strtoint(GridPag.cells[GridPag.getcolumn('moes_tipo_codigo'),i]));
// sao varios produtores
        Sistema.Setfield('cheq_tipo_codigo',99999);
        Sistema.Setfield('cheq_tipocad','C');
        Sistema.Setfield('cheq_bcoemitente','BRASIL');
//        Sistema.Setfield('cheq_emitente',Edcheq_emitente.Text);
//        Sistema.Setfield('cheq_predata',Edcheq_predata.AsDate);
        Sistema.Setfield('cheq_valor',valorabaixar);
        Sistema.Setfield('cheq_repr_codigo',1);
//        Sistema.Setfield('cheq_deposito',Edcheq_deposito.asdate);
//        Sistema.Setfield('cheq_prorroga',Edcheq_prorroga.asdate);
        Sistema.Setfield('cheq_datacont',Sistema.Hoje);
        Sistema.Setfield('cheq_lancto',Sistema.hoje);
        Sistema.Setfield('cheq_predata',EdBaixa.asdate);
        Sistema.Setfield('cheq_obs','Pagamento Leite');
        Sistema.Setfield('cheq_unid_codigo',Global.CodigoUnidade);
        Sistema.Setfield('cheq_emit_banco',Emit_banco);
        Sistema.Setfield('cheq_emit_agencia',Emit_agencia);
        Sistema.Setfield('cheq_emit_conta',Emit_conta);
        Sistema.Setfield('cheq_cmc7',xtransacao);
//        Sistema.Setfield('Cheq_bancocustodia',Edcheq_bancustodia.text);
        Sistema.Post;

//      contacaixa:=FUnidades.GetContaCaixa(Global.CodigoUnidade);
      contacaixa:=contabaixa;
    //  contarecdes:=FUnidades.GetContaCaixa(Global.CodigoUnidade);
      conta:=EdPlan_conta.ResultFind.fieldbyname('plan_ctachequescomp').AsInteger;
      contarecdes:=0;
      if valornp>0 then begin
        Sistema.Insert('movfin');
        Sistema.Setfield('movf_transacao',xtransacao);
        Sistema.Setfield('movf_operacao',FGeral.Getoperacao);
        Sistema.Setfield('movf_status','N');
        Sistema.Setfield('movf_unid_codigo',Global.CodigoUnidade);
        Sistema.Setfield('movf_datalcto',Sistema.HOje);
        Sistema.Setfield('movf_datamvto',EdBaixa.asdate);
        Sistema.SetField('movf_DataCont',Sistema.HOje);
        Sistema.Setfield('movf_dataprevista',Edbaixa.asdate);
        Sistema.Setfield('movf_plan_conta',conta);
    //    Sistema.Setfield('movf_hist_codigo',Codhist);
    //    Sistema.Setfield('movf_complemento',Complehist);
    //    Sistema.Setfield('movf_numerodcto',inttostr(Numero));
        if conta>0 then
          Sistema.Setfield('movf_es','E')
        else
          Sistema.Setfield('movf_es','S');
        Sistema.Setfield('movf_valorger',valornp);
        Sistema.Setfield('movf_valorbco',valornp);
        Sistema.Setfield('movf_plan_contard',Contarecdes);
        Sistema.Setfield('movf_tipomov',Global.CodPendenciaFinanceira);
        Sistema.Setfield('movf_usua_codigo',Global.Usuario.Codigo);
    //    Sistema.Setfield('movf_tipo_codigo',Tipo_Codigo);
    //    Sistema.Setfield('movf_tipocad',Tipocad);
    // 13.01.2014 - Metalforte
    //    Sistema.SetField('movf_codb_codigo',npar);
        Sistema.Post();
      end;
      if valorvendas>0 then begin
        Sistema.Insert('movfin');
        Sistema.Setfield('movf_transacao',xtransacao);
        Sistema.Setfield('movf_operacao',FGeral.Getoperacao);
        Sistema.Setfield('movf_status','N');
        Sistema.Setfield('movf_unid_codigo',Global.CodigoUnidade);
        Sistema.Setfield('movf_datalcto',Sistema.HOje);
        Sistema.Setfield('movf_datamvto',Edbaixa.asdate);
        Sistema.SetField('movf_DataCont',Sistema.HOje);
        Sistema.Setfield('movf_dataprevista',Edbaixa.asdate);
        Sistema.Setfield('movf_plan_conta',contacaixa);
    //    Sistema.Setfield('movf_hist_codigo',Codhist);
    //    Sistema.Setfield('movf_complemento',Complehist);
    //    Sistema.Setfield('movf_numerodcto',inttostr(Numero));
        Sistema.Setfield('movf_es','E');
        Sistema.Setfield('movf_valorger',valorvendas);
        Sistema.Setfield('movf_valorbco',valorvendas);
        Sistema.Setfield('movf_plan_contard',Contarecdes);
        Sistema.Setfield('movf_tipomov',Global.CodPendenciaFinanceira);
        Sistema.Setfield('movf_usua_codigo',Global.Usuario.Codigo);
    //    Sistema.Setfield('movf_tipo_codigo',Tipo_Codigo);
    //    Sistema.Setfield('movf_tipocad',Tipocad);
    // 13.01.2014 - Metalforte
    //    Sistema.SetField('movf_codb_codigo',npar);
        Sistema.Post();
      end;
      GridPag.clear;
      EdDtinicio.setfocus;
      try
        sistema.commit;
        Sistema.endprocess('Baixa efetuada. Transação '+xtransacao);
      except
        Sistema.endprocess('Não foi possível gravar esta baixa');
      end;

    exit;
  end;    // geracao de apenas um cheque
//////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
// geracao de 1 cheque para cada produtor...
  for i:=0 to GridPag.rowcount-1 do begin
    if ( trim( GridPag.cells[GridPag.getcolumn('moes_tipo_codigo'),i] )<>'' )
       and
       ( trim( GridPag.cells[GridPag.getcolumn('status'),i] )='N' )
       and
       ( ( GridPag.cells[GridPag.getcolumn('marcado'),i] )='Ok' )
    then begin

// gerando a baixa parcial
      if Texttovalor( GridPag.cells[GridPag.getcolumn('valorabaixar'),i] )  < Texttovalor( GridPag.cells[GridPag.getcolumn('vlrvendas'),i] ) then begin
        Sistema.Insert('Pendencias');
        Sistema.SetField('Pend_Transacao',xTransacao);
        Sistema.SetField('Pend_Operacao',FGeral.GetOperacao);
        Sistema.SetField('Pend_Status','P');
        Sistema.SetField('Pend_DataLcto',Sistema.Hoje);
        Sistema.SetField('Pend_DataMvto',Edbaixa.asdate);
        Sistema.SetField('Pend_DataVcto',Sistema.Hoje);
        Sistema.SetField('Pend_DataEmissao',Edbaixa.asdate);
        Sistema.SetField('Pend_Plan_Conta',contagerencial);
        Sistema.SetField('Pend_Tipo_Codigo',Strtoint(GridPag.cells[Gridpag.getcolumn('moes_tipo_codigo'),i]));
        Sistema.SetField('Pend_Unid_Codigo',Global.codigounidade);
//        Sistema.SetField('Pend_Fpgt_Codigo',QBxparcial.fieldbyname('pend_Fpgt_Codigo').asstring);
//        Sistema.SetField('Pend_Port_Codigo',QBxparcial.fieldbyname('pend_port_Codigo').asstring);
//        Sistema.SetField('Pend_Hist_Codigo',QBxparcial.fieldbyname('pend_hist_Codigo').asinteger);
        Sistema.SetField('Pend_Moed_Codigo','');
//        Sistema.SetField('Pend_Repr_Codigo',QBxparcial.fieldbyname('pend_repr_Codigo').asinteger);
        Sistema.SetField('Pend_TipoCad'    ,'C');
    //      Sistema.SetField('Pend_CNPJCPF',EdCliente.Resultfind('clie_cnpjcpf);
//        Sistema.SetField('Pend_Complemento',QBxparcial.fieldbyname('pend_complemento').asstring);
        Sistema.SetField('Pend_NumeroDcto',GetTransacaoBP(GridPag.cells[Gridpag.getcolumn('transacoesvendas'),i]) );
        Sistema.SetField('Pend_Parcela',1);
        Sistema.SetField('Pend_NParcelas',1);
        Sistema.SetField('Pend_RP','R');
        Sistema.SetField('Pend_DataCont',Sistema.hoje);
        Sistema.SetField('Pend_Valor',Texttovalor( GridPag.cells[GridPag.getcolumn('valorabaixar'),i] ));
        Sistema.SetField('Pend_ValorTitulo',Texttovalor( GridPag.cells[GridPag.getcolumn('valorabaixar'),i] ));
        Sistema.SetField('Pend_Multa',0);
        Sistema.SetField('Pend_Mora',0);
        Sistema.SetField('Pend_Acrescimos',0);
        Sistema.SetField('Pend_Descontos',0);
        Sistema.SetField('Pend_TransBaixa','');  // no. transacao da baixa
//        Sistema.SetField('Pend_ContaBaixa',EdPlan_conta.Asinteger);
        Sistema.SetField('Pend_DataBaixa',Edbaixa.asdate);
        Sistema.SetField('pend_usubaixa',Global.Usuario.codigo);   // 20.06.05
        Sistema.SetField('pend_observacao','Pagamento Leite');
        Sistema.SetField('Pend_Impresso',0);   // numero do impresso relacionado
        Sistema.SetField('Pend_ImprDcto','');  // S ou N se o impresso já foi enviado para impressão
        Sistema.SetField('Pend_LoteCNAB',0);  // no. lote para exportação bancária (CNAB )
        Sistema.Post;
        valorNP:=valorNP+Texttovalor( GridPag.cells[GridPag.getcolumn('vlrleite'),i] );
        valorvendas:=valorvendas+Texttovalor( GridPag.cells[GridPag.getcolumn('valorabaixar'),i] );
// baixa a NP total e deixa as vendas 'intactas'
          Sistema.Edit('pendencias');
          Sistema.setfield('pend_status','B');
          Sistema.setfield('pend_transbaixa',xtransacao);
          Sistema.setfield('pend_databaixa',Edbaixa.asdate);
          Sistema.setfield('pend_contabaixa',contabaixa);
          Sistema.Post('pend_status=''N'' and pend_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                       ' and pend_tipomov='+Stringtosql(cTipoMov)+
                       ' and '+FGeral.GetIN('pend_transacao',GridPag.cells[GridPag.getcolumn('transacoes'),i],'C') );

      end else begin  // baixa total das parcelas

          Sistema.Edit('pendencias');
          Sistema.setfield('pend_status','B');
          Sistema.setfield('pend_transbaixa',xtransacao);
          Sistema.setfield('pend_databaixa',Edbaixa.asdate);
          Sistema.setfield('pend_contabaixa',contabaixa);
          Sistema.Post('pend_status=''N'' and pend_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                       ' and '+FGeral.GetIN('pend_transacao',GridPag.cells[GridPag.getcolumn('transacoes'),i],'C') );
          valorNP:=valorNP+Texttovalor( GridPag.cells[GridPag.getcolumn('vlrleite'),i] );
// 15.05.15 - para quem nao desconta nada
          if length(trim(GridPag.cells[GridPag.getcolumn('transacoesvendas'),i]))>5 then begin
            Sistema.Edit('pendencias');
            Sistema.setfield('pend_status','B');
            Sistema.setfield('pend_transbaixa',xtransacao);
            Sistema.setfield('pend_databaixa',Edbaixa.asdate);
            Sistema.setfield('pend_contabaixa',contabaixa);
            Sistema.Post('pend_status=''N'' and pend_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                         ' and '+FGeral.GetIN('pend_transacao',GridPag.cells[GridPag.getcolumn('transacoesvendas'),i],'C')+
                         xsqlvencimento );
            valorvendas:=valorvendas+Texttovalor( GridPag.cells[GridPag.getcolumn('vlrvendas'),i] );
          end;
      end;
// gerar os cheques no cadastro de cheques emitidos
      if ( Texttovalor( GridPag.cells[GridPag.getcolumn('vlrliquido'),i] ) >= Edvlrminimo.ascurrency )
         and
         ( Edvlrminimo.ascurrency>0 )  and ( trim(GridPag.cells[GridPag.getcolumn('cheque'),i])<>'')
        then begin

       valorcheque:=Texttovalor( GridPag.cells[GridPag.getcolumn('vlrliquido'),i] );
       chequemaior:='N';
       if  ( Texttovalor( GridPag.cells[GridPag.getcolumn('vlrliquido'),i] )  > FGeral.GetConfig1AsFloat('maxcheque') ) and ( FGeral.GetConfig1AsFloat('maxcheque')>0 ) then begin
                 chequemaior:='S';
                 valorcheque:=FGeral.GetConfig1AsFloat('maxcheque');
                 valortotalcheque:=Texttovalor( GridPag.cells[GridPag.getcolumn('vlrliquido'),i] );
                 while Valortotalcheque > FGeral.GetConfig1AsFloat('maxcheque') do begin
                   IncluiCheque;
                   Valortotalcheque:=valortotalcheque-valorcheque;
                 end;
                 valorcheque:=Valortotalcheque;
                 if valorcheque>0 then IncluiCheque;;
       end else
         IncluiCheque;

      end;

///////////////////////////////////
// gerar lançamentos no caixa/bancos  - ver se vai direto no banco ou passa pelo caixa
// ver se precisa criar mais campo no cadastro de unidades;;;
//      contacaixa:=FUnidades.GetContaCaixa(Global.CodigoUnidade);
      contacaixa:=contabaixa;
//  contarecdes:=FUnidades.GetContaCaixa(Global.CodigoUnidade);
      conta:=EdPlan_conta.ResultFind.fieldbyname('plan_ctachequescomp').AsInteger;
      contarecdes:=0;
// cheque emitido a compensar
      if valornp>0 then begin

         chequemaior:='N';
         valorcheque:=Texttovalor( GridPag.cells[GridPag.getcolumn('vlrliquido'),i] );
// 15.08.16 - cheques acima do valor que paga tarifa
         numerocheque:=GridPag.cells[GridPag.getcolumn('Cheque'),i];
         if  ( Texttovalor( GridPag.cells[GridPag.getcolumn('vlrliquido'),i] )  > FGeral.GetConfig1AsFloat('maxcheque') ) and ( FGeral.GetConfig1AsFloat('maxcheque')>0 ) then begin
                 chequemaior:='S';
                 valorcheque:=FGeral.GetConfig1AsFloat('maxcheque');
                 valortotalcheque:=Texttovalor( GridPag.cells[GridPag.getcolumn('vlrliquido'),i] );
                 while Valortotalcheque > FGeral.GetConfig1AsFloat('maxcheque') do begin
                   IncluiChequeaCompensar;
                   Valortotalcheque:=valortotalcheque-valorcheque;
                   if trim(numerocheque)<>'' then
                     numerocheque:=inttostr( strtoint(numerocheque) + 1 );
                 end;
                 valorcheque:=Valortotalcheque;
                 if valorcheque>0 then IncluiChequeacompensar;
         end else
           IncluiChequeaCompensar;

      end;

      if valorvendas>0 then begin
        Sistema.Insert('movfin');
        Sistema.Setfield('movf_transacao',xtransacao);
        Sistema.Setfield('movf_operacao',FGeral.Getoperacao);
        Sistema.Setfield('movf_status','N');
        Sistema.Setfield('movf_unid_codigo',Global.CodigoUnidade);
        Sistema.Setfield('movf_datalcto',Sistema.HOje);
        Sistema.Setfield('movf_datamvto',Edbaixa.asdate);
        Sistema.SetField('movf_DataCont',Sistema.HOje);
        Sistema.Setfield('movf_dataprevista',Edbaixa.asdate);
        Sistema.Setfield('movf_plan_conta',contacaixa);
    //    Sistema.Setfield('movf_hist_codigo',Codhist);
        Sistema.Setfield('movf_complemento','Vendas Descontadas Leite');
    //    Sistema.Setfield('movf_numerodcto',inttostr(Numero));
        Sistema.Setfield('movf_es','E');
        Sistema.Setfield('movf_valorger',valorvendas);
        Sistema.Setfield('movf_valorbco',valorvendas);
        Sistema.Setfield('movf_plan_contard',Contarecdes);
        Sistema.Setfield('movf_tipomov',Global.CodPendenciaFinanceira);
        Sistema.Setfield('movf_usua_codigo',Global.Usuario.Codigo);
    //    Sistema.Setfield('movf_tipo_codigo',Tipo_Codigo);
    //    Sistema.Setfield('movf_tipocad',Tipocad);
    // 13.01.2014 - Metalforte
    //    Sistema.SetField('movf_codb_codigo',npar);
        Sistema.Post();
      end;
      try
        sistema.commit;
//      Sistema.endprocess('Baixa efetuada. Transação '+xtransacao);
      except
        Sistema.endprocess('Não foi possível gravar esta baixa');
      end;
      valorvendas:=0;
      valornp:=0;
//////////////////////////////////////
{
  try
    sistema.commit;
  except
    Sistema.endprocess('Não foi possível gravar esta baixa');
  end;
}
    end;

  end;  // percorrendo os marcados no grid

 Sistema.endprocess('Baixa efetuada. Transação '+xtransacao);
  GridPag.clear;
  EdDtinicio.setfocus;
end;

// 03.01.15
procedure TFPagamentoLeite.bimpreciboClick(Sender: TObject);
/////////////////////////////////////////////////////////////////
var p:integer;
    operacao,transacao:string;
    Lista:TStringList;
    Q:TSqlquery;
begin
  if not confirma('Confirma impressão dos recibos ?') then exit;
  for p:=0 to GridPag.rowcount do begin
    if GridPag.cells[GridPag.getcolumn('marcado'),p]='Ok' then begin
      Lista:=TStringList.create;
      strtolista(Lista,GridPag.cells[GridPag.getcolumn('transacoes'),p]+';'+GridPag.cells[GridPag.getcolumn('transacoesvendas'),p],';',true);
      Q:=sqltoquery('select pend_operacao from pendencias where pend_transacao='+Stringtosql(Lista[0])+
                    ' and '+FGeral.Getin('pend_status','B','C') );
      if Q.eof then begin
        FGeral.FechaQuery(Q);
        Q:=sqltoquery('select pend_operacao from pendencias where pend_transacao='+Stringtosql(Lista[1])+
                      ' and '+FGeral.Getin('pend_status','P','C') );
      end;
//      transacao:=Q.fieldbyname('pend_transbaixa').asstring;
//      FGeral.FechaQuery(Q);
//      Q:=sqltoquery('select pend_operacao from pendencias where pend_transbaixa='+Stringtosql(transacao)+
//                    ' and pend_status<>''C''');
      Lista.free;
      FImpressao.ImprimeReciboPen(Q.fieldbyname('pend_operacao').AsString,'L');
      FGeral.FechaQuery(Q);
    end;
  end;
end;

procedure TFPagamentoLeite.bmarcatodosClick(Sender: TObject);
//////////////////////////////////////////////////////////////////
var x:integer;
begin
  for x:=0 to GridPag.rowcount do begin
    if trim( GridPag.cells[GridPag.getcolumn('moes_tipo_codigo'),x] ) <> '' then begin
        GridPag.cells[GridPag.getcolumn('marcado'),x]:='Ok';
        inc(produtoresmarcados)
    end;
  end;

end;

procedure TFPagamentoLeite.bdesmarcatodosClick(Sender: TObject);
///////////////////////////////////////////////////////////////////////
var x:integer;
begin
  for x:=0 to GridPag.rowcount do begin
    if trim( GridPag.cells[GridPag.getcolumn('moes_tipo_codigo'),x] ) <> '' then begin
        GridPag.cells[GridPag.getcolumn('marcado'),x]:='';
    end;
  end;
  Produtoresmarcados:=0;


end;

procedure TFPagamentoLeite.GridPagClick(Sender: TObject);
////////////////////////////////////////////////////////////////
begin
   if ( GridPag.col=GridPag.getcolumn('marcado') ) and (GridPag.cells[Gridpag.getcolumn('moes_tipo_codigo'),Gridpag.row]<>'') then begin
     if GridPag.cells[GridPag.getcolumn('marcado'),GridPag.row]='Ok' then begin
       GridPag.cells[GridPag.getcolumn('marcado'),GridPag.row]:='';
       dec(produtoresmarcados);
     end else begin
       GridPag.cells[GridPag.getcolumn('marcado'),GridPag.row]:='Ok';
       inc(produtoresmarcados);
     end;
   end
end;

procedure TFPagamentoLeite.EdvlrabaixarExitEdit(Sender: TObject);
///////////////////////////////////////////////////////////////////////
var i,primcheque:integer;
    valorliquido,valornf,valorinss:currency;
begin
  Edvlrabaixar.visible:=false;
  Edvlrabaixar.enabled:=false;
  valorliquido:=texttovalor( GridPag.Cells[GridPag.GetColumn('vlrvendas'),gridpag.row] );
  valornf:=texttovalor( GridPag.Cells[GridPag.GetColumn('vlrleite'),gridpag.row] );
  valorinss:=texttovalor( GridPag.Cells[GridPag.GetColumn('vlrinss'),gridpag.row] );
  if (edvlrabaixar.ascurrency>=0) and (Edvlrabaixar.ascurrency<=valorliquido) then begin
      GridPag.Cells[GridPag.GetColumn('vlrliquido'),gridpag.row]:=currtostr(valornf-valorinss-Edvlrabaixar.ascurrency);
      GridPag.Cells[GridPag.GetColumn('valorabaixar'),gridpag.row]:=Edvlrabaixar.assql;
  end;
   primcheque:=EdPrimeirocheque.asinteger;
   for i:=0 to GridPag.rowcount-1 do begin
     if ( GridPag.Cells[GridPag.GetColumn('marcado'),i]='Ok' )
        and
        (edvlrabaixar.ascurrency>=0) and
        (Edvlrabaixar.ascurrency>=Edvlrminimo.ascurrency) then begin
          if EdPrimeirocheque.asinteger>0 then
//            GridPag.Cells[GridPag.GetColumn('cheque'),i]:=inttostr(primcheque)
          else
//            GridPag.Cells[GridPag.GetColumn('cheque'),i]:='';
         inc(primcheque);
     end;
   end;
    gridpag.SetFocus;
end;

procedure TFPagamentoLeite.GridPagDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
////////////////////////////////////////////////////////////
var s:string;
    t:integer;
begin

     if ( Trim(Gridpag.cells[gridpag.GetColumn('moes_tipo_codigo'),arow]) <>'' )
         and (Texttovalor(Gridpag.cells[gridpag.GetColumn('vlrliquido'),arow]) <=0 ) then begin
           GridPag.Canvas.Brush.Color := clred;
           s:=GridPag.Cells[ACol,ARow];
           GridPag.Canvas.FillRect(Rect);
           t:=GridPag.Canvas.TextWidth(s)+2;
           if GridPag.Columns[ACol].Alignment=taRightJustify then
              GridPag.Canvas.TextRect(Rect,Rect.Right-t,Rect.Top+2,s)
           else GridPag.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
     end else if ( Trim(Gridpag.cells[gridpag.GetColumn('moes_tipo_codigo'),arow]) <>'' )
         and (Texttovalor(Gridpag.cells[gridpag.GetColumn('vlrliquido'),arow])>0 )
         and ( Gridpag.cells[gridpag.GetColumn('status'),arow]='B' )
         then begin
           GridPag.Canvas.Brush.Color := clyellow;
           s:=GridPag.Cells[ACol,ARow];
           GridPag.Canvas.FillRect(Rect);
           t:=GridPag.Canvas.TextWidth(s)+2;
           if GridPag.Columns[ACol].Alignment=taRightJustify then
              GridPag.Canvas.TextRect(Rect,Rect.Right-t,Rect.Top+2,s)
           else GridPag.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);

     end;

end;

procedure TFPagamentoLeite.EdPlan_contaValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////////
begin
  if EdPlan_conta.ResultFind.fieldbyname('plan_ctachequescomp').AsInteger=0 then
    EdPlan_conta.invalid('Falta configurar a conta de cheques emitidos deste banco na configuração da conta');

end;

procedure TFPagamentoLeite.bchequesmatricialClick(Sender: TObject);
//////////////////////////////////////////////////////////////////////////
var p,chi,chf:integer;
    xtrans:string;
begin
  if EdPrimeirocheque.IsEmpty then begin
    Avisoerro('Informar o número do primeiro cheque');
    exit;
  end;
  if not confirma('Confirma impressão dos cheques ?') then exit;
//  chi:=EdPrimeirocheque.asinteger;
  chi:=0;
  chf:=0;
  for p:=0 to GridPag.rowcount do begin
    if GridPag.cells[GridPag.getcolumn('marcado'),p]='Ok' then begin
      if trim(GridPag.cells[GridPag.getcolumn('cheque'),p])<>'' then begin
        if chi=0 then   // pega o 'primeiro'
          chi:=strtointdef(GridPag.cells[GridPag.getcolumn('cheque'),p],0);
        if strtointdef(GridPag.cells[GridPag.getcolumn('cheque'),p],0) > chf then
          chf:=strtointdef(GridPag.cells[GridPag.getcolumn('cheque'),p],0);
        xtrans:=Gridpag.cells[Gridpag.getcolumn('transacoes'),p]+';'+Gridpag.cells[Gridpag.getcolumn('transacoesvendas'),p];
      end;
    end;
  end;
  FImpressao.ImprimeCheques(EdPlan_conta.asinteger,(chi),(chf),'');
end;

procedure TFPagamentoLeite.GridPagKeyPress(Sender: TObject; var Key: Char);
////////////////////////////////////////////////////////////////////////////////
var Qx:TSqlquery;
    xsqlemaberto,xsqlvencimento:string;
    p:integer;
begin
  if key=#13 then begin
{
   if ( GridPag.col=GridPag.getcolumn('valorabaixar') )
      and ( GridPag.cells[Gridpag.getcolumn('status'),Gridpag.row]<>'B' )
      and ( GridPag.cells[Gridpag.getcolumn('moes_tipo_codigo'),Gridpag.row]<>'' ) then begin
      Edvlrabaixar.visible:=true;
      Edvlrabaixar.enabled:=true;
      Edvlrabaixar.Top:=GridPag.TopEdit;
      EdVlrabaixar.Left:=GridPag.LeftEdit;
      EdVlrabaixar.text:=GridPag.cells[Gridpag.getcolumn('vlrvendas'),Gridpag.row];
      EdVlrabaixar.SetFocus;
}
   if ( GridPag.col=GridPag.getcolumn('cheque') )
      and ( GridPag.cells[Gridpag.getcolumn('status'),Gridpag.row]<>'B' )
      and ( GridPag.cells[Gridpag.getcolumn('moes_tipo_codigo'),Gridpag.row]<>'' ) then begin
      Ednumcheque.visible:=true;
      Ednumcheque.enabled:=true;
      Ednumcheque.Top:=GridPag.TopEdit;
      Ednumcheque.Left:=GridPag.LeftEdit;
      Ednumcheque.text:=GridPag.cells[Gridpag.getcolumn('cheque'),Gridpag.row];
      Ednumcheque.SetFocus;
   end else if ( GridPag.col=GridPag.getcolumn('vlrvendas') )
      and ( GridPag.cells[Gridpag.getcolumn('status'),Gridpag.row]<>'B' )
      and ( GridPag.cells[Gridpag.getcolumn('moes_tipo_codigo'),Gridpag.row]<>'' ) then begin
      EdTransvendas.Items.Clear;
      xsqlemaberto:= ' and extract( year from pend_datavcto ) = '+inttostr(Datetoano(Sistema.hoje,true))+
                 ' and extract( month from pend_datavcto ) = '+inttostr(Datetomes(Sistema.hoje));
//      if cbtodosemaberto.Checked then xsqlemaberto:='';
// 15.05.15 - pitanga
      xsqlemaberto:='';
      xsqlvencimento:='';
      if EdVencimento.asdate>0 then xsqlvencimento:=' and pend_datavcto<='+Datetosql(EdVencimento.asdate);

      Qx:=Sqltoquery('select pend_transacao,pend_valor,pend_datavcto,pend_numerodcto from pendencias where pend_status=''N'''+
                     ' and pend_unid_codigo='+Stringtosql(Global.codigounidade)+
                     ' and pend_tipo_codigo='+GridPag.cells[Gridpag.getcolumn('moes_tipo_codigo'),Gridpag.row]+
                     ' and pend_tipocad=''C'''+
                     xsqlemaberto+xsqlvencimento+
                     ' and '+FGeral.getnotin('pend_tipomov',Global.codcompraprodutor+';'+Global.codcompraprodutorMerenda,'C')+
                     ' order by pend_datavcto');
//                     ' and '+fGeral.getin('pend_transacao',GridPag.cells[Gridpag.getcolumn('transacoesvendas'),Gridpag.row],'C') );
      while not Qx.eof do begin
        EdTransvendas.Items.Add(strspace(Qx.fieldbyname('pend_transacao').asstring,12)+'|'+strspace(Qx.fieldbyname('pend_valor').asstring,12)+'|'+
                                Qx.fieldbyname('pend_datavcto').asstring+' | '+ Qx.fieldbyname('pend_numerodcto').asstring);
        Qx.Next;
      end;
      FGeral.FechaQuery(Qx);
      EdTransvendas.visible:=true;
      EdTransvendas.enabled:=true;
      EdTransvendas.Top:=GridPag.TopEdit;
      EdTransvendas.Left:=GridPag.LeftEdit;
      EdTransvendas.text:='';
      EdTransvendas.ShowItems;
      EdTransvendas.SetFocus;
   end;
  end;

end;

procedure TFPagamentoLeite.cbtodosemabertoClick(Sender: TObject);
begin
   EdBaixa.Next;
end;

// 23.02.15
procedure TFPagamentoLeite.EdNUmchequeExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////////////////////////////////////////////
var i,primcheque:integer;
    numerocheque:string;
begin
  EdNumcheque.visible:=false;
  EdNumcheque.enabled:=false;
  numerocheque:=GridPag.Cells[GridPag.GetColumn('cheque'),gridpag.row] ;
  if (not Ednumcheque.isempty) then begin
      GridPag.Cells[GridPag.GetColumn('cheque'),gridpag.row]:=Ednumcheque.text;
  end;
  gridpag.SetFocus;
end;

procedure TFPagamentoLeite.EdClienteValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////////
begin
   pnomecliente.Color:=clred;
   pnomecliente.caption:='';
   if not EdCliente.isempty then begin
     if (EdCliente.ResultFind <> nil ) then begin
       pnomecliente.caption:=EdCliente.ResultFind.fieldbyname('clie_nome').AsString;
     end;
   end;
end;


// 13.05.15
procedure TFPagamentoLeite.EdtransvendasExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////////
var Qx:Tsqlquery;
    xvalorliquido,xvalornf,xvalorinss:currency;
    xsqlemaberto,xsqlvencimento:string;
begin
  if (not Edtransvendas.isempty) then
      GridPag.Cells[GridPag.GetColumn('transacoesvendas'),gridpag.row]:=Edtransvendas.text;
  EdTransvendas.visible:=false;
  EdTransvendas.enabled:=false;
  xvalorliquido:=texttovalor( GridPag.Cells[GridPag.GetColumn('vlrvendas'),gridpag.row] );
  xvalornf:=texttovalor( GridPag.Cells[GridPag.GetColumn('vlrleite'),gridpag.row] );
  xvalorinss:=texttovalor( GridPag.Cells[GridPag.GetColumn('vlrinss'),gridpag.row] );
  xsqlemaberto:= ' and extract( year from pend_datavcto ) = '+inttostr(Datetoano(Sistema.hoje,true))+
                 ' and extract( month from pend_datavcto ) = '+inttostr(Datetomes(Sistema.hoje));
  if cbtodosemaberto.Checked then xsqlemaberto:='';
// 15.05.15
  xsqlemaberto:='';
  if EdVencimento.asdate>0 then xsqlvencimento:=' and pend_datavcto<='+Datetosql(EdVencimento.asdate);
  if not EdTransvendas.IsEmpty then begin
    Qx:=sqltoquery('select sum(pend_valor) as valor from pendencias where pend_status=''N'''+
                 ' and pend_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                 xsqlemaberto+xsqlvencimento+
                 ' and '+FGeral.GetIN('pend_transacao',EdTransvendas.text,'C'));
    if Qx.fieldbyname('valor').ascurrency>0 then begin
       GridPag.Cells[GridPag.getcolumn('vlrvendas'),gridpag.row]:=Valortosql(Qx.fieldbyname('valor').ascurrency);
       GridPag.Cells[GridPag.GetColumn('vlrliquido'),gridpag.row]:=currtostr(xvalornf-xvalorinss-Qx.fieldbyname('valor').ascurrency);
       GridPag.Cells[GridPag.GetColumn('valorabaixar'),gridpag.row]:=Valortosql(Qx.fieldbyname('valor').ascurrency);
    end;
    FGeral.fechaquery(Qx);
  end;
  Gridpag.setfocus;
end;

// 18.11.15
procedure TFPagamentoLeite.breldepositoClick(Sender: TObject);
/////////////////////////////////////////////////////////////////////
begin
   if not Sistema.processando then FRelFinan_DepositoemConta(EdDtinicio.asdate,EdDtfim.asdate);

end;

// 28.03.16
procedure TFPagamentoLeite.GridPagKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
///////////////////////////////////////////////////////////////////////////////////////////////////
var xsqlemaberto,xsqlvencimento:string;
    Qx:TSqlquery;
    p:integer;
begin
// 28.03.16
  if  key=vk_f11 then begin
//  if  key='#123' then begin
// 27.04.16 - desativado temporariamente
    exit;

    if ( GridPag.col=GridPag.getcolumn('vlrvendas') )
      and ( GridPag.cells[Gridpag.getcolumn('status'),Gridpag.row]<>'B' )
      and ( not EdCliente.IsEmpty )
      and ( GridPag.cells[Gridpag.getcolumn('moes_tipo_codigo'),Gridpag.row]<>'' ) then begin
      xsqlemaberto:= ' and extract( year from pend_datavcto ) = '+inttostr(Datetoano(Sistema.hoje,true))+
                 ' and extract( month from pend_datavcto ) = '+inttostr(Datetomes(Sistema.hoje));
//      if cbtodosemaberto.Checked then xsqlemaberto:='';
// 15.05.15 - pitanga
      xsqlemaberto:='';
      xsqlvencimento:='';
      if EdVencimento.asdate>0 then xsqlvencimento:=' and pend_datavcto<='+Datetosql(EdVencimento.asdate);

      Qx:=Sqltoquery('select pend_operacao,pend_valor,pend_datavcto,pend_numerodcto from pendencias where pend_status=''N'''+
                     ' and pend_unid_codigo='+Stringtosql(Global.codigounidade)+
                     ' and pend_tipo_codigo='+GridPag.cells[Gridpag.getcolumn('moes_tipo_codigo'),Gridpag.row]+
                     ' and pend_tipocad=''C'''+
                     xsqlemaberto+xsqlvencimento+
                     ' and '+FGeral.getnotin('pend_tipomov',Global.codcompraprodutor+';'+Global.codcompraprodutorMerenda,'C')+
                     ' order by pend_datavcto');
//                     ' and '+fGeral.getin('pend_transacao',GridPag.cells[Gridpag.getcolumn('transacoesvendas'),Gridpag.row],'C') );
      GridParcial.clear;
      p:=1 ;
      while not Qx.eof do begin
        GridParcial.Cells[GridParcial.GetColumn('pend_numerodcto'),p]:=Qx.fieldbyname('pend_numerodcto').asstring;
        GridParcial.Cells[GridParcial.GetColumn('pend_valor'),p]:=FGeral.Formatavalor( Qx.fieldbyname('pend_valor').ascurrency,f_cr);
        GridParcial.Cells[GridParcial.GetColumn('parcial'),p]:='';
        GridParcial.Cells[GridParcial.GetColumn('pend_operacao'),p]:=Qx.fieldbyname('pend_operacao').asstring;
        Qx.Next;
        GridParcial.AppendRow;
        inc(p);
      end;
      FGeral.FechaQuery(Qx);
      GridParcial.visible:=true;
      GridParcial.Enabled:=true;
      GridParcial.SetFocus;
    end;
  end;

end;

// 28.03.16
procedure TFPagamentoLeite.GridParcialKeyPress(Sender: TObject;  var Key: Char);
//////////////////////////////////////////////////////////////////////////////////////
begin
  if key=#13 then begin
    if ( GridPag.col=GridPag.getcolumn('parcial') ) then begin
      Edvalorparcial.visible:=true;
      Edvalorparcial.enabled:=true;
      Edvalorparcial.Top:=GridParcial.TopEdit;
      Edvalorparcial.Left:=GridParcial.LeftEdit;
      Edvalorparcial.text:='';
      Edvalorparcial.SetFocus;
    end;
  end;
end;

// 28.03.16
// 29.03.16
procedure TFPagamentoLeite.EdvalorparcialExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////////////
begin
  if EdValorparcial.AsCurrency>0 then begin
    GridParcial.cells[GridParcial.getcolumn('parcial'),GridParcial.row]:=EdValorparcial.assql;
  end;
end;

end.

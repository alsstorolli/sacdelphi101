unit Baixache;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel, ExtCtrls,
  SQLGrid, Grids, SqlDtg, SqlFun, SqlSis;

type
  TFBaixacheques = class(TForm)
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
    Edunid_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    EdDtinicio: TSQLEd;
    EdDtFim: TSQLEd;
    Edcheq_repr_codigo: TSQLEd;
    SetEdRepr_nome: TSQLEd;
    PCheques: TSQLPanelGrid;
    GridPedidos: TSqlDtGrid;
    EdPlan_conta: TSQLEd;
    EdPlan_descricao: TSQLEd;
    Edtotalmarcado: TSQLEd;
    EdValorpedidos: TSQLEd;
    bmarcatodos: TSQLBtn;
    bdesmarcatodos: TSQLBtn;
    brelatorio: TSQLBtn;
    EdValorrec: TSQLEd;
    EdMesano: TSQLEd;
    Eddeposito: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure EdDtFimValidate(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure EdDtinicioValidate(Sender: TObject);
    procedure Edunid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdDtinicioExitEdit(Sender: TObject);
    procedure bmarcatodosClick(Sender: TObject);
    procedure bdesmarcatodosClick(Sender: TObject);
    procedure GridPedidosClick(Sender: TObject);
    procedure brelatorioClick(Sender: TObject);
    procedure EdPlan_contaValidate(Sender: TObject);
    procedure EdValorrecExitEdit(Sender: TObject);
    procedure GridPedidosKeyPress(Sender: TObject; var Key: Char);
    procedure EdValorrecValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure LImpadados;
  end;

var
  FBaixacheques: TFBaixacheques;
  QPedidos:TMemoryquery;
  Chequesmarcados:integer;
  campo:TDicionario;

implementation

{$R *.dfm}

uses Geral, SqlExpr, Unidades, plano, SQLRel;

procedure TFBaixacheques.FormActivate(Sender: TObject);
begin
  if EdDtinicio.AsDate<=1 then
    EdDtinicio.SetDate(Sistema.hoje);
  if EdDtfim.AsDate<=1 then
    EdDtfim.SetDate(Sistema.hoje);
  EdUnid_codigo.setfocus;
end;

procedure TFBaixacheques.EdDtFimValidate(Sender: TObject);
begin
  if EdDtfim.asdate<EdDtinicio.asdate then
    EdDtfim.Invalid('Data final tem que ser maior que inicial');
end;

procedure TFBaixacheques.bGravarClick(Sender: TObject);
var sqlrepr,sqlemirec,transacao,sqlcheque,sqlbanco,sqlemitente,sqlpredata,sqlemissao:string;
//    Q:TSqlquery;
    totalcheques:currency;
    contabanco,x,contager:integer;
    baixacheque:boolean;
    movimento:TDatetime;
begin
//  if not EdDtfim.Valid then exit;
  if not EdDtInicio.Valid then exit;
  if not EdUnid_codigo.valid then exit;
//  contabanco:=FGeral.Getconfig1asinteger('Ctabancheqrec');
  contabanco:=EdPlan_conta.asinteger;
  sqlemirec:=' and cheq_emirec=''R''';   // por enquanto somente os recebidos
  sqlrepr:='';
{
  if EdCheq_Repr_codigo.AsInteger>0 then
    sqlrepr:=' and cheq_repr_codigo='+Edcheq_repr_codigo.AsSql
  else
    sqlrepr:='';
  Q:=sqltoquery('select sum(cheq_valor) as total from cheques where cheq_status=''N'''+
               sqlrepr+
               sqlemirec+
               ' and cheq_deposito is null'+
//               ' and cheq_predata>='+EdDtinicio.AsSql+' and cheq_predata<='+EdDtfim.Assql+
               ' and cheq_predata<='+EdDtInicio.Assql+
               ' and cheq_unid_codigo='+EdUnid_codigo.AsSql );
  totalcheques:=Q.fieldbyname('total').ascurrency;
}
  totalcheques:=EdTotalmarcado.ascurrency;
  if totalcheques=0 then begin
    Avisoerro('Não escolhido cheques a baixar neste período');
    exit;
  end;
  
//  if ( contabanco=FGeral.GetConfig1AsInteger('Ctacherecebido') ) and ( contabanco>0 ) then begin
// 28.07.09 - Novicarnes - Elyze - cheques pré-datados q foram devolvidos
//    Avisoerro('Conta para depósito não pode ser a conta de cheques pré-datados');
//////////////    exit;
//  end;

  baixacheque:=confirma('Baixar cheques da conta de cheques pré-datados ?');
  if not confirma('Confirma baixa dos cheques no valor total de '+Floattostr(totalcheques)+' ?') then exit;
  if contabanco>0 then begin
    Sistema.BeginTransaction('Baixando cheques do período');
    Transacao:=FGeral.Gettransacao;
  end else
    Sistema.BeginProcess('Baixando cheques');
//  if ( contabanco<>FGeral.GetConfig1AsInteger('Ctacherecebido') ) and ( contabanco>0 ) then
// 23.08.07
  contager:=0;
//  movimento:=Sistema.Hoje;
  movimento:=EdDeposito.asdate;
  if EdMesano.IsEmpty then
    movimento:=Texttodate('');
  if (Chequesmarcados=1) and  ( GridPedidos.Cells[GridPedidos.GetColumn('cheq_devolvido'),gridpedidos.row]='S' ) then
    contager:=FGEral.GetConfig1AsInteger('Ctachedevolvido');

  if ( contabanco>0 ) then
    FGeral.GravaMovfin(Transacao,Edunid_codigo.text,'E','Cheques recebidos',EdDeposito.asdate,movimento,
                     EdDeposito.asdate,500,0,0,contabanco,totalcheques,contager,'CH',0,
                     strtointdef(GridPedidos.Cells[GridPedidos.GetColumn('cheq_TIPO_codigo'),gridpedidos.row],0) );
// 24.07.07 - da a SAIDA da conta de cheques recebidos
//  if ( contabanco<>FGeral.GetConfig1AsInteger('Ctacherecebido') ) and ( FGeral.GetConfig1AsInteger('Ctacherecebido')>0 )
  if ( FGeral.GetConfig1AsInteger('Ctacherecebido')>0 )  and (baixacheque) then
    FGeral.GravaMovfin(Transacao,Edunid_codigo.text,'S','Cheques recebidos',EdDeposito.asdate,movimento,
                     EdDeposito.asdate,501,0,0,FGeral.GetConfig1AsInteger('Ctacherecebido'),totalcheques,0,'CH',0,
                     strtointdef(GridPedidos.Cells[GridPedidos.GetColumn('cheq_TIPO_codigo'),gridpedidos.row],0) );

  for x:=1 to GridPedidos.rowcount do begin
    if GridPedidos.Cells[GridPedidos.getcolumn('marcado'),x]='Ok' then begin
      sqlcheque:=' and cheq_cheque='+stringtosql(GridPedidos.Cells[GridPedidos.getcolumn('cheq_cheque'),x]);
      sqlbanco:=' and cheq_bcoemitente='+stringtosql(GridPedidos.Cells[GridPedidos.getcolumn('cheq_bcoemitente'),x]);
      sqlemitente:=' and cheq_emitente='+stringtosql(GridPedidos.Cells[GridPedidos.getcolumn('cheq_emitente'),x]);
      sqlpredata:=' and cheq_predata='+Datetosql( Texttodate(FGeral.Tirabarra(GridPedidos.Cells[GridPedidos.getcolumn('cheq_predata'),x])) );
      sqlemissao:=' and cheq_emissao='+Datetosql( Texttodate(FGeral.Tirabarra(GridPedidos.Cells[GridPedidos.getcolumn('cheq_emissao'),x])) );

      Sistema.Edit('Cheques');
      Sistema.SetField('cheq_deposito',EdDeposito.asdate);
      Sistema.SetField('cheq_plan_contadep',contabanco);
      Sistema.SetField('cheq_dtremessa',EdDeposito.asdate);
// 20.02.08
      Sistema.SetField('cheq_valorrec',texttovalor( GridPedidos.cells[GridPedidos.getcolumn('cheq_valorrec'),x] ));
// 26.11.09 - Abra
      campo:=Sistema.GetDicionario('cheques','cheq_transbaixa');
      if campo.Tipo<>'' then
        Sistema.SetField('cheq_transbaixa',Transacao);
      Sistema.Post('cheq_status=''N'''+
                 sqlrepr+sqlcheque+sqlbanco+sqlpredata+sqlemissao+sqlemitente+
                 sqlemirec+
                 ' and cheq_deposito is null'+
  //               ' and cheq_predata>='+EdDtinicio.AsSql+' and cheq_predata<='+EdDtfim.Assql+
  //               ' and cheq_predata<='+EdDtinicio.AsSql+
                 ' and cheq_unid_codigo='+EdUnid_codigo.AsSql );
// 20.02.08 - checando baixa parcial - gera 'outro cheque' com o saldo em aberto
     if ( texttovalor( GridPedidos.cells[GridPedidos.getcolumn('cheq_valorrec'),x] ) < texttovalor( GridPedidos.cells[GridPedidos.getcolumn('cheq_valor'),x] ) ) and
        ( texttovalor( GridPedidos.cells[GridPedidos.getcolumn('cheq_valorrec'),x] )>0 ) then begin
       Sistema.Insert('Cheques');
        Sistema.Setfield('cheq_status','N');
        Sistema.Setfield('cheq_emirec','R');
        if pos('A',GridPedidos.Cells[GridPedidos.getcolumn('cheq_cheque'),x])=0 then
           Sistema.Setfield('cheq_cheque',GridPedidos.Cells[GridPedidos.getcolumn('cheq_cheque'),x]+'A')
        else if pos('B',GridPedidos.Cells[GridPedidos.getcolumn('cheq_cheque'),x])=0 then
           Sistema.Setfield('cheq_cheque',GridPedidos.Cells[GridPedidos.getcolumn('cheq_cheque'),x]+'B')
        else if pos('C',GridPedidos.Cells[GridPedidos.getcolumn('cheq_cheque'),x])=0 then
           Sistema.Setfield('cheq_cheque',GridPedidos.Cells[GridPedidos.getcolumn('cheq_cheque'),x]+'C')
        else
// 15.03.11 - Novi - Elize - cheque 'de financiamento'...'trocentas baixas parciais no mesmo...
//           Sistema.Setfield('cheq_cheque',GridPedidos.Cells[GridPedidos.getcolumn('cheq_cheque'),x]+strzero(Datetodia(sistema.Hoje),2));
           Sistema.Setfield('cheq_cheque',trim(copy(GridPedidos.Cells[GridPedidos.getcolumn('cheq_cheque'),x],1,10))+strzero(Datetodia(sistema.Hoje),2));

        Sistema.Setfield('cheq_emissao',Texttodate(FGeral.Tirabarra(GridPedidos.Cells[GridPedidos.getcolumn('cheq_emissao'),x])));
        Sistema.Setfield('cheq_devolvido',GridPedidos.Cells[GridPedidos.getcolumn('cheq_devolvido'),x]);
        Sistema.Setfield('cheq_tipo_codigo',strtointdef(GridPedidos.Cells[GridPedidos.getcolumn('cheq_tipo_codigo'),x],0));
        Sistema.Setfield('cheq_tipocad','C');
        Sistema.Setfield('cheq_bcoemitente',GridPedidos.Cells[GridPedidos.getcolumn('cheq_bcoemitente'),x]);
        Sistema.Setfield('cheq_emitente',GridPedidos.Cells[GridPedidos.getcolumn('cheq_emitente'),x]);
        Sistema.Setfield('cheq_predata',Texttodate(FGeral.Tirabarra(GridPedidos.Cells[GridPedidos.getcolumn('cheq_predata'),x])));
        Sistema.Setfield('cheq_valor',texttovalor( GridPedidos.cells[GridPedidos.getcolumn('cheq_valor'),x] ) - texttovalor( GridPedidos.cells[GridPedidos.getcolumn('cheq_valorrec'),x] ));
        Sistema.Setfield('cheq_repr_codigo',strtointdef(GridPedidos.Cells[GridPedidos.getcolumn('cheq_repr_codigo'),x],0));
//        Sistema.Setfield('cheq_deposito',Edcheq_deposito.asdate);
//        Sistema.Setfield('cheq_prorroga',Edcheq_prorroga.asdate);
        Sistema.Setfield('cheq_datacont',Texttodate(FGeral.Tirabarra(GridPedidos.Cells[GridPedidos.getcolumn('cheq_emissao'),x])));
        Sistema.Setfield('cheq_lancto',Sistema.hoje);
        Sistema.Setfield('cheq_obs','SALDO BAIXA PARCIAL');
        Sistema.Setfield('cheq_unid_codigo',EdUnid_codigo.text);
        Sistema.Setfield('cheq_emit_banco',GridPedidos.Cells[GridPedidos.getcolumn('cheq_emit_banco'),x]);
        Sistema.Setfield('cheq_emit_agencia',GridPedidos.Cells[GridPedidos.getcolumn('cheq_emit_agencia'),x]);
        Sistema.Setfield('cheq_emit_conta',GridPedidos.Cells[GridPedidos.getcolumn('cheq_emit_conta'),x]);
       Sistema.Post();
     end;
    end;
  end;
  try
    if contabanco>0 then
      Sistema.EndTransaction('Cheques do periodo baixados')
    else begin
      Sistema.Commit;
      Sistema.endprocess('Cheques baixados');
    end;
  except
    Avisoerro('Problemas na baixa dos Cheques');
  end;
//  FGeral.Fechaquery(Q);
  Limpadados;
  EdUnid_codigo.setfocus;
end;

procedure TFBaixacheques.EdDtinicioValidate(Sender: TObject);
begin
//  EdDtfim.setdate(EdDtinicio.AsDate);
end;

procedure TFBaixacheques.Execute;
/////////////////////////////////////////////
begin
  if FBaixacheques=nil then  FGeral.CreateForm(TFBaixaCheques,FBaixaCheques);
  Limpadados;
  FBaixacheques.Show;
  FBaixacheques.EdDtfim.setdate(Sistema.hoje);
  FBaixacheques.EdDeposito.setdate(Sistema.hoje);
  if trim(FBaixacheques.EdMesano.text)='' then
    FBaixacheques.EdMesano.text:=strzero(Datetomes(Sistema.hoje),2)+strzero(Datetoano(Sistema.hoje,true),4);
  FPlano.SetaItems(FBaixacheques.EdPlan_conta,FBaixacheques.EdPlan_descricao,'C;B');
  if FGeral.GetConfig1AsInteger('Ctacherecebido')=0 then begin
    Avisoerro('Falta configurar a conta de cheques pré-datados na config. geral do sistema');
    close;
    exit;
  end;
end;

procedure TFBaixacheques.Edunid_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
   FGEral.LimpaEdit(EdUnid_codigo,key);
end;

procedure TFBaixacheques.EdDtinicioExitEdit(Sender: TObject);
//  bgravarclick(self);
var sqldatacont,sqlaberto,sqldata,sqlunidades,sqldeposito,sqlrepr:string;

    procedure ChequestoGrid;
    var  ListaPedidos:TStringlist;
         x:integer;
         vlrpedidos:currency;
    begin
       vlrpedidos:=0;
       GridPedidos.clear;
       ListaPedidos:=TStringlist.create;
       x:=1;
       while not QPedidos.eof do begin
             ListaPedidos.add(Qpedidos.fieldbyname('cheq_cheque').asstring);
             GridPedidos.cells[GridPedidos.getcolumn('cheq_cheque'),x]:=QPedidos.fieldbyname('cheq_cheque').asstring;
             GridPedidos.cells[GridPedidos.getcolumn('cheq_bcoemitente'),x]:=QPedidos.fieldbyname('cheq_bcoemitente').asstring;
             GridPedidos.cells[GridPedidos.getcolumn('cheq_emitente'),x]:=QPedidos.fieldbyname('cheq_emitente').asstring;
             GridPedidos.cells[GridPedidos.getcolumn('cheq_emissao'),x]:=formatdatetime('dd/mm/yy',QPedidos.fieldbyname('cheq_emissao').asdatetime);
             GridPedidos.cells[GridPedidos.getcolumn('cheq_predata'),x]:=formatdatetime('dd/mm/yy',QPedidos.fieldbyname('cheq_predata').asdatetime);
             GridPedidos.cells[GridPedidos.getcolumn('cheq_lancto'),x]:=formatdatetime('dd/mm/yy',QPedidos.fieldbyname('cheq_lancto').asdatetime);
//             GridPedidos.cells[GridPedidos.getcolumn('cheq_valor'),x]:=formatfloat(f_cr,QPedidos.fieldbyname('cheq_valor').asfloat);
             GridPedidos.cells[GridPedidos.getcolumn('cheq_valor'),x]:=floattostr(QPedidos.fieldbyname('cheq_valor').asfloat);
             GridPedidos.cells[GridPedidos.getcolumn('cheq_emit_agencia'),x]:=QPedidos.fieldbyname('cheq_emit_agencia').asstring;
             GridPedidos.cells[GridPedidos.getcolumn('cheq_emit_conta'),x]:=QPedidos.fieldbyname('cheq_emit_conta').asstring;
// 23.08.07
             GridPedidos.cells[GridPedidos.getcolumn('cheq_devolvido'),x]:=QPedidos.fieldbyname('cheq_devolvido').asstring;
// 20.02.08
             GridPedidos.cells[GridPedidos.getcolumn('cheq_valorrec'),x]:=QPedidos.fieldbyname('cheq_valor').asstring;
             GridPedidos.cells[GridPedidos.getcolumn('cheq_repr_codigo'),x]:=QPedidos.fieldbyname('cheq_repr_codigo').asstring;
             GridPedidos.cells[GridPedidos.getcolumn('cheq_emit_banco'),x]:=QPedidos.fieldbyname('cheq_emit_banco').asstring;
             GridPedidos.cells[GridPedidos.getcolumn('cheq_tipo_codigo'),x]:=QPedidos.fieldbyname('cheq_tipo_codigo').asstring;
             inc(x);
             vlrpedidos:=vlrpedidos+QPedidos.fieldbyname('cheq_valor').asfloat;
             GridPedidos.AppendRow;
         EdValorpedidos.setvalue(vlrpedidos);
         QPedidos.next;
       end;


    end;

begin

    Show;
    GridPedidos.clear;
    GridPedidos.setfocus;
    Edtotalmarcado.setvalue(0);
    Sistema.Beginprocess('Lendo cheques não depositados');
    sqlaberto:='';
    sqldeposito:=' and cheq_deposito is null';
//    sqldata:=' and cheq_emissao >= '+Datetosql(Sistema.hoje-60);
//    sqldata:=' and cheq_emissao >='+EdDtinicio.assql+' and cheq_emissao <='+EdDtfim.assql;
    sqldata:=' and cheq_predata >='+EdDtinicio.assql+' and cheq_predata <='+EdDtfim.assql;
    sqlunidades:=' and '+FGeral.Getin('cheq_unid_codigo',EdUnid_codigo.text,'C');
{
    if Global.Usuario.OutrosAcessos[0701] then
        sqldatacont:=''
    else
        sqldatacont:=' and cheq_datacont>1';
}
// 07.04.08 - para pode depositar em contas diferentes os cheques 'diferentes'
    if EdMesano.IsEmpty then
        sqldatacont:=' and cheq_datacont is null'
    else
//        sqldatacont:=' and cheq_datacont>1';
// 27.09.11
        sqldatacont:=' and cheq_datacont > '+Datetosql(Global.DataMenorBanco);

//      sqlrepr:=' and cheq_repr_codigo='+EdRepr_codigo.Assql+
    sqlrepr:='';
    QPedidos:=sqltomemoryquery('select * from cheques inner join representantes on ( repr_codigo=cheq_repr_codigo )'+
                   ' where cheq_status=''N'' and cheq_emirec=''R'''+
                   sqlrepr+
                   ' and cheq_emit_banco<>''999'''+   // juros
                    sqldatacont+sqlaberto+sqldata+sqlunidades+sqldeposito+
//                   ' order by cheq_emissao');
                   ' order by cheq_valor');
    if QPedidos.eof then begin
      Avisoerro('Não encontrado cheques recebidos não depositados');
      EdDtfim.setfocus;
    end else begin
      ChequestoGrid;
      bmarcatodosclick(self);
    end;

    Sistema.endprocess('');

end;

procedure TFBaixacheques.bmarcatodosClick(Sender: TObject);
var x:integer;
begin
  for x:=0 to GridPedidos.rowcount do begin
    if trim( GridPedidos.cells[GridPedidos.getcolumn('cheq_cheque'),x] ) <> '' then begin
        GridPedidos.cells[GridPedidos.getcolumn('marcado'),x]:='Ok';
        inc(Chequesmarcados)
    end;
  end;
  Edtotalmarcado.setvalue(EdValorpedidos.ascurrency);

end;

procedure TFBaixacheques.bdesmarcatodosClick(Sender: TObject);
var x:integer;
begin
  for x:=0 to GridPedidos.rowcount do begin
    if trim( GridPedidos.cells[GridPedidos.getcolumn('cheq_cheque'),x] ) <> '' then begin
        GridPedidos.cells[GridPedidos.getcolumn('marcado'),x]:='';
    end;
  end;
  Edtotalmarcado.setvalue(0);
  Chequesmarcados:=0;

end;

procedure TFBaixacheques.LImpadados;
begin
   FBaixacheques.GridPedidos.clear;
   FBaixacheques.Edtotalmarcado.setvalue(0);
   FBaixacheques.EdValorpedidos.setvalue(0);
   Chequesmarcados:=0;
end;

procedure TFBaixacheques.GridPedidosClick(Sender: TObject);
var valor,valorrec:currency;
begin
   valor:=texttovalor(GridPedidos.cells[GridPedidos.getcolumn('cheq_valor'),GridPedidos.row]);
   valorrec:=texttovalor(GridPedidos.cells[GridPedidos.getcolumn('cheq_valorrec'),GridPedidos.row]);
   if ( GridPedidos.col=GridPedidos.getcolumn('marcado') ) and (GridPedidos.cells[Gridpedidos.getcolumn('cheq_cheque'),Gridpedidos.row]<>'') then begin
     if GridPedidos.cells[GridPedidos.getcolumn('marcado'),GridPedidos.row]='Ok' then begin
       GridPedidos.cells[GridPedidos.getcolumn('marcado'),GridPedidos.row]:='';
       dec(Chequesmarcados);
       if Edtotalmarcado.ascurrency>0 then begin
//         Edtotalmarcado.setvalue( EdTotalmarcado.ascurrency - texttovalor(GridPedidos.cells[GridPedidos.getcolumn('cheq_valorrec'),GridPedidos.row]) );
//         if valor>valorrec then
//           Edtotalmarcado.setvalue( EdTotalmarcado.ascurrency - valor + valorrec)
//         else
           Edtotalmarcado.setvalue( EdTotalmarcado.ascurrency - valorrec );
       end;
     end else begin
       GridPedidos.cells[GridPedidos.getcolumn('marcado'),GridPedidos.row]:='Ok';
       inc(Chequesmarcados);
//       Edtotalmarcado.setvalue( EdTotalmarcado.ascurrency + texttovalor(GridPedidos.cells[GridPedidos.getcolumn('cheq_valorrec'),GridPedidos.row]) );
//         Edtotalmarcado.setvalue( EdTotalmarcado.ascurrency - texttovalor(GridPedidos.cells[GridPedidos.getcolumn('cheq_valorrec'),GridPedidos.row]) );
       if valor>valorrec then
           Edtotalmarcado.setvalue( EdTotalmarcado.ascurrency + valorrec)
       else
           Edtotalmarcado.setvalue( EdTotalmarcado.ascurrency + valor );
     end;
   end;

end;

procedure TFBaixacheques.brelatorioClick(Sender: TObject);
var i,marc:integer;
begin
  if Edtotalmarcado.ascurrency=0 then exit;
  Sistema.BeginProcess('Gerando relatório');
  FRel.Init('RelChequesDepositados');
  FRel.AddTit('Unidade '+EdUNid_codigo.text+' - '+SetEdUnid_nome.text);
  FRel.AddTit('Relação de Cheques para Depósito Conta '+EdPlan_conta.text+' - '+EdPlan_descricao.text );
//  FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'  ,''         ,'',false);
  FRel.AddCol( 50,1,'D','' ,''              ,'Emissão'    ,''         ,'',false);
  FRel.AddCol( 80,3,'N','+',f_cr            ,'Valor'           ,''         ,'',False);
  FRel.AddCol( 90,0,'C','' ,''              ,'Banco Emitente'  ,''         ,'',false);
  FRel.AddCol(150,0,'C','' ,''              ,'Emitente'  ,''         ,'',false);
  FRel.AddCol( 70,0,'N','' ,''              ,'Cheque'   ,''         ,'',False);
  FRel.AddCol( 60,1,'C','' ,''              ,'Agencia'   ,''         ,'',false);
  FRel.AddCol( 80,1,'C','' ,''              ,'Conta'   ,''         ,'',false);
//  FRel.AddCol( 60,1,'D','' ,''              ,'Bom para'   ,''         ,'',false);
  marc:=0;
  for i:=1 to GridPedidos.rowcount do begin
    if GridPedidos.Cells[GridPedidos.getcolumn('marcado'),i]='Ok' then begin
//          FRel.AddCel(Q.FieldByName('cheq_datacont').AsString);
          FRel.AddCel(GridPedidos.cells[GridPedidos.getcolumn('cheq_emissao'),i] );
//          FRel.AddCel(GridPedidos.cells[GridPedidos.getcolumn('cheq_valor'),i] );
          FRel.AddCel(GridPedidos.cells[GridPedidos.getcolumn('cheq_valorrec'),i] );
          FRel.AddCel(GridPedidos.cells[GridPedidos.getcolumn('cheq_bcoemitente'),i] );
          FRel.AddCel(GridPedidos.cells[GridPedidos.getcolumn('cheq_emitente'),i] );
//          FRel.AddCel(Q.FieldByName('cheq_predata').AsString);
//          FRel.AddCel(Q.FieldByName('cheq_deposito').AsString);
//          FRel.AddCel(Q.FieldByName('cheq_prorroga').AsString);
          FRel.AddCel(GridPedidos.cells[GridPedidos.getcolumn('cheq_cheque'),i] );
          FRel.AddCel(GridPedidos.cells[GridPedidos.getcolumn('cheq_emit_agencia'),i] );
          FRel.AddCel(GridPedidos.cells[GridPedidos.getcolumn('cheq_emit_conta'),i] );
          inc(marc);
    end;
  end;
  if marc>0 then
    FRel.Video;
  Sistema.endProcess('');

end;

procedure TFBaixacheques.EdPlan_contaValidate(Sender: TObject);
begin
  if ( EdPlan_conta.asinteger=FGeral.GetConfig1AsInteger('Ctacherecebido') ) then begin
//    EdPlan_conta.invalid('Conta para depósito não pode ser a conta de cheques pré-datados');
// 27.07.09 - Novicarnes - Elyze - cheques pré-datados q foram devolvidos
    Avisoerro('Conta para depósito não pode ser a conta de cheques pré-datados');
  end;

end;

procedure TFBaixacheques.EdValorrecExitEdit(Sender: TObject);
begin
  GridPedidos.Cells[GridPedidos.Col,GridPedidos.Row]:=Transform(EdValorrec.AsFloat,f_cr);
  GridPedidos.SetFocus;
  EdValorrec.Visible:=False;

end;

procedure TFBaixacheques.GridPedidosKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#13 then begin
//    if GridPedidos.Col =8 then begin
// 28.07.09
    if GridPedidos.Col = GridPedidos.getcolumn('cheq_valorrec') then begin
       EdValorrec.Top:=GridPedidos.TopEdit;
       EdValorrec.Left:=GridPedidos.LeftEdit+5;
//       Edvalorrec.Text:=StrToStrNumeros(GridPedidos.Cells[GridPedidos.Col,GridPedidos.Row]);
       EdValorrec.SetValue(TextToValor(GridPedidos.Cells[GridPedidos.Col,GridPedidos.Row]));
       EdValorrec.Visible:=True;
       EdValorrec.SetFocus;
    end;
  end;

end;

procedure TFBaixacheques.EdValorrecValidate(Sender: TObject);
var valor,valorrec:currency;
begin
   valor:=texttovalor(GridPedidos.cells[GridPedidos.getcolumn('cheq_valor'),GridPedidos.row]);
   valorrec:=texttovalor(GridPedidos.cells[GridPedidos.getcolumn('cheq_valorrec'),GridPedidos.row]);
   if EdValorrec.ascurrency>Texttovalor( GridPedidos.cells[GridPedidos.Getcolumn('cheq_valor'),Gridpedidos.row]  ) then
     EdValorrec.invalid('Valor recebido no máximo igual ao valor do cheque')
   else
        Edtotalmarcado.setvalue( EdTotalmarcado.ascurrency -valor + EdValorrec.ascurrency);
end;

end.

unit Cadcheq;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, SqlDtg, Buttons, SQLBtn, StdCtrls, alabel, ExtCtrls,
  SQLGrid, Mask, SQLEd, SqlExpr, DB, DBGrids ;

type
  TFCadcheques = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bIncluir: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;                                                        
    PInicial: TSQLPanelGrid;
    PGrid: TSQLPanelGrid;
    PEdits: TSQLPanelGrid;
    EdCheq_cheque: TSQLEd;
    EdCheq_emissao: TSQLEd;
    EdCheq_bcoemitente: TSQLEd;
    Edcheq_emitente: TSQLEd;
    Edcheq_predata: TSQLEd;
    Edcheq_valor: TSQLEd;
    Edcheq_obs: TSQLEd;
    Edcheq_prorroga: TSQLEd;
    Edcheq_repr_codigo: TSQLEd;
    Edcheq_deposito: TSQLEd;
    SetEdRepr_nome: TSQLEd;
    bAlterar: TSQLBtn;
    bExcluir: TSQLBtn;
    bcancelar: TSQLBtn;
    EdMovimento: TSQLEd;
    EdCheq_unid_codigo: TSQLEd;
    bbaixa: TSQLBtn;
    EdJuros: TSQLEd;
    XGrid: TSQLGrid;
    DSCheques: TDataSource;
    bPesquisar: TSQLBtn;
    PNomerepr: TSQLPanelGrid;
    EdNomerepre: TSQLEd;
    EdCheq_devolvido: TSQLEd;
    EdCodtipo: TSQLEd;
    SetEdFavorecido: TSQLEd;
    bdevolvido: TSQLBtn;
    EdCheq_Emit_banco: TSQLEd;
    Edcheq_Emit_agencia: TSQLEd;
    EdCheq_Emit_conta: TSQLEd;
    bemitentes: TSQLBtn;
    Edcheq_Cmc7: TSQLEd;
    bjuros: TSQLBtn;
    EdQuempagou: TSQLEd;
    brelatorio: TSQLBtn;
    Edcheq_bancustodia: TSQLEd;
    SQLEd2: TSQLEd;
    EdCheq_cnpjcpf: TSQLEd;
    Edchequefinal: TSQLEd;
    bgarantido: TSQLBtn;
    procedure EdCheq_emissaoValidate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edcheq_depositoExitEdit(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure bAlterarClick(Sender: TObject);
    procedure bcancelarClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure EdCheq_unid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure bbaixaClick(Sender: TObject);
    procedure EdJurosValidate(Sender: TObject);
    procedure Edcheq_predataValidate(Sender: TObject);
    procedure EdCheq_bcoemitenteValidate(Sender: TObject);
    procedure XGridNewRecord(Sender: TObject);
    procedure bdevolvidoClick(Sender: TObject);
    procedure EdCodtipoValidate(Sender: TObject);
    procedure EdCheq_Emit_bancoValidate(Sender: TObject);
    procedure EdCheq_Emit_contaValidate(Sender: TObject);
    procedure Edcheq_Emit_agenciaValidate(Sender: TObject);
    procedure bemitentesClick(Sender: TObject);
    procedure Edcheq_Cmc7Validate(Sender: TObject);
    procedure bjurosClick(Sender: TObject);
    procedure Edcheq_prorrogaValidate(Sender: TObject);
    procedure EdCheq_Emit_bancoKeyPress(Sender: TObject; var Key: Char);
    procedure brelatorioClick(Sender: TObject);
    procedure EdMovimentoValidate(Sender: TObject);
    procedure Edcheq_bancustodiaKeyPress(Sender: TObject; var Key: Char);
    procedure Edcheq_bancustodiaValidate(Sender: TObject);
    procedure EdCheq_cnpjcpfValidate(Sender: TObject);
    procedure EdchequefinalValidate(Sender: TObject);
    procedure EdchequefinalExitEdit(Sender: TObject);
    procedure EdCheq_chequeValidate(Sender: TObject);
    procedure bgarantidoClick(Sender: TObject);
    procedure Edcheq_repr_codigoValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Editstogrid;
    procedure Querytoedits(Q:TSqlquery);
    procedure Execute(xcheque:string='';xemissao:Tdatetime=0;xpredata:Tdatetime=0;xcliente:integer=0;xvalor:extended=0;xEmiRec:string='R');
    procedure Gridtoedits;
    function GetNomeBanco(banco:string ; Edit:Tsqled):string;
    procedure LeCmc7(var banco,agencia,conta:string );
    procedure ConfiguraContaCmc7(Ed:TSqled ; banco:string);
// 24.04.13
    procedure HabilitaEdits(s:string);

  end;

var

  FCadcheques: TFCadcheques;
  QBusca,QGrid,Qcheq,Qc:TSqlquery;
  Op,selectemaberto,sqldatacont,bcoemitentecheque,emirec:string;
  Jurosmes,valorcheque:currency;
  DataCheque,emissaocheque:TDatetime;
  ycheque:string;
  yemissao,ypredata:Tdatetime;
  ycliente:integer;
  yvalor:extended;

implementation


uses Arquiv, Sqlsis, SqlFun , Geral, Unidades, plano, Emitentes,
  RelGerenciais;

{$R *.dfm}

   function Valorjuros(valor,jurosmes,dias:currency):currency;
   begin
     result:=( valor*((jurosmes/100)/30) ) * dias;
   end;



procedure TFCadcheques.EdCheq_emissaoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////////
begin
  if EdCheq_emissao.asdate>Sistema.hoje then
    EdCheq_emissao.invalid('Emissão tem que ser menor ou igual a data atual')
  else if not EdCheq_emissao.isempty then begin
// 11.03.19 - novicarnes sandro=ketlen
    if EdCheq_valor.AsCurrency>0 then begin

      if  not FGeral.ValidaMvto(EdCheq_emissao) then
        EdCheq_emissao.invalid('');

    end;

  end;
{
  if not FGeral.ValidaMvto(EdCheq_emissao) then
    EdCheq_emissao.invalid('')
  else begin
    Qbusca:=sqltoquery('select * from cheques where cheq_status=''N'' and cheq_emissao='+EdCheq_emissao.AsSql+
                       ' and cheq_repr_codigo='+EdCheq_repr_codigo.AsSql+
                       ' and cheq_cheque='+EdCheq_cheque.AsSql );
    if (not QBusca.eof) and (Op='I') then
      EdCheq_emissao.invalid('Cheque já cadastrado para este representante nesta emissão')
    else begin
      if not QBusca.eof then begin
        Querytoedits(QBusca);
      end else begin
        if EdCheq_predata.AsDate<=1 then
          EdCheq_predata.setdate(edcheq_emissao.AsDate);
        EdMovimento.Setdate(sistema.hoje);
        if (QBusca.eof) and (Op<>'I') then
          EdCheq_emissao.invalid('Cheque não encontrado para este representante nesta emissão');
      end;
    end;
  end;
}
end;

procedure TFCadcheques.FormActivate(Sender: TObject);
begin
  if not Arq.TRepresentantes.active then Arq.TRepresentantes.Open;
//  if EdCheq_emissao.AsDate<=1 then
    EdCheq_emissao.setdate(sistema.hoje);
/////  Grid.clear;

end;

procedure TFCadcheques.Querytoedits(Q:TSqlquery);
begin
//////  EdCheq_bcoemitente.text:=Q.fieldbyname('cheq_bcoemitente').asstring;
//
  Edcheq_emitente.text:=Q.fieldbyname('cheq_emitente').asstring;
  Edcheq_predata.Setdate(Q.fieldbyname('cheq_predata').asdatetime);
  EdMovimento.Setdate(Q.fieldbyname('cheq_datacont').asdatetime);
  Edcheq_valor.setvalue(Q.fieldbyname('cheq_valor').ascurrency);
  Edcheq_obs.text:=Q.fieldbyname('cheq_obs').asstring;
  Edcheq_prorroga.setdate(Q.fieldbyname('cheq_prorroga').asdatetime);
  Edcheq_deposito.setdate(Q.fieldbyname('cheq_deposito').asdatetime);
  EdCheq_unid_codigo.text:=Q.fieldbyname('cheq_unid_codigo').asstring;
  Edcheq_bancustodia.text:=Q.fieldbyname('cheq_bancocustodia').asstring;
end;


procedure TFCadcheques.Editstogrid;
begin
{
  Grid.Cells[grid.getcolumn('cheq_bcoemitente'),grid.row]:=edcheq_bcoemitente.text;
  Grid.Cells[grid.getcolumn('cheq_cheque'),grid.row]:=edcheq_cheque.text;
  Grid.Cells[grid.getcolumn('cheq_emitente'),grid.row]:=edcheq_emitente.text;
  Grid.Cells[grid.getcolumn('cheq_emissao'),grid.row]:=formatdatetime('dd/mm/yy',edcheq_emissao.asdate);
  if edcheq_predata.asdate>1 then
    Grid.Cells[grid.getcolumn('cheq_predata'),grid.row]:=formatdatetime('dd/mm/yy',edcheq_predata.asdate)
  else
    Grid.Cells[grid.getcolumn('cheq_predata'),grid.row]:='';
  if edcheq_deposito.asdate>1 then
    Grid.Cells[grid.getcolumn('cheq_deposito'),grid.row]:=formatdatetime('dd/mm/yy',edcheq_deposito.asdate)
  else
    Grid.Cells[grid.getcolumn('cheq_deposito'),grid.row]:='';
  if edcheq_prorroga.asdate>1 then
    Grid.Cells[grid.getcolumn('cheq_prorroga'),grid.row]:=formatdatetime('dd/mm/yy',edcheq_prorroga.asdate)
  else
    Grid.Cells[grid.getcolumn('cheq_prorroga'),grid.row]:='';
  Grid.Cells[grid.getcolumn('cheq_valor'),grid.row]:=edcheq_valor.assql;
  Grid.Cells[grid.getcolumn('cheq_obs'),grid.row]:=edcheq_obs.text;
}
end;


procedure TFCadcheques.Edcheq_depositoExitEdit(Sender: TObject);
///////////////////////////////////////////////////////////////////////////////
var transacao,msg,sqlemissao:string;
    lancadevolvido:boolean;
    campo:TDicionario;
begin
  msg:='Confirma informações ? ';
// 07.10.13
    if not EdCheq_emissao.IsEmpty then
      sqlemissao:=' and cheq_emissao='+EdCheq_emissao.AsSql
    else
      sqlemissao:=' and cheq_emissao is null';
  lancadevolvido:=false;
//  if (OP='I') and (EdCheq_devolvido.text='S')  then
//    lancadevolvido:=confirma('Dar entrada na conta de cheques devolvidos');
//  if OP='D' then
//    msg:='Confirma inclusão do cheque devolvido e saida do banco onde foi depositado ? ';
  if confirma(msg) then begin
    if (OP='I') or (OP='D') or (OP='E') or (OP='J') then
      Sistema.Insert('Cheques')
    else
      Sistema.Edit('Cheques');
    if (OP='I') or (OP='D') or (OP='E') or (OP='J') then begin
      Sistema.Setfield('cheq_status','N');
      Sistema.Setfield('cheq_emirec',emirec);
      Sistema.Setfield('cheq_cheque',Edcheq_cheque.Text);
      Sistema.Setfield('cheq_emissao',Edcheq_emissao.AsDate);
    end;
    Sistema.Setfield('cheq_devolvido',EdCheq_Devolvido.text);
    Sistema.Setfield('cheq_tipo_codigo',EdCodtipo.asinteger);

    Sistema.Setfield('cheq_tipocad','C');

    Sistema.Setfield('cheq_bcoemitente',EdCheq_bcoemitente.Text);
    Sistema.Setfield('cheq_emitente',Edcheq_emitente.Text);
    Sistema.Setfield('cheq_predata',Edcheq_predata.AsDate);
    Sistema.Setfield('cheq_valor',Edcheq_valor.ascurrency);
    Sistema.Setfield('cheq_repr_codigo',EdCheq_repr_codigo.asinteger);
    Sistema.Setfield('cheq_deposito',Edcheq_deposito.asdate);
    Sistema.Setfield('cheq_prorroga',Edcheq_prorroga.asdate);
    Sistema.Setfield('cheq_datacont',EdMovimento.asdate);
// 08.01.08 - Isonel - Novicarnes
// 14.05.08 - Isonel - Novicarnes - se ficar sem data o lançamento da devolucao aparece no relat. de posição cheques
    if (OP='I') or (OP='D') then
      Sistema.Setfield('cheq_lancto',Sistema.hoje);
    Sistema.Setfield('cheq_obs',Edcheq_obs.text);
    Sistema.Setfield('cheq_unid_codigo',Edcheq_Unid_codigo.text);
// 19.09.06
    Sistema.Setfield('cheq_emit_banco',Edcheq_Emit_banco.text);
    Sistema.Setfield('cheq_emit_agencia',Edcheq_Emit_agencia.text);
    Sistema.Setfield('cheq_emit_conta',Edcheq_Emit_conta.text);
// 25.09.06
//    Sistema.Setfield('cheq_emit_cmc7',Edcheq_Cmc7.text);
// 18.08.08
    Sistema.Setfield('Cheq_bancocustodia',Edcheq_bancustodia.text);
// 03.10.08
    if Global.Topicos[1258] then begin
      campo:=Sistema.GetDicionario('cheques','cheq_cnpjcpf');
      if campo.Tipo<>'' then
        Sistema.Setfield('cheq_cnpjcpf',Edcheq_cnpjcpf.text);
    end;
// 11.08.15 - Vivan
    campo:=Sistema.GetDicionario('cheques','cheq_usua_codigo');
    if campo.Tipo<>'' then
        Sistema.Setfield('cheq_usua_codigo',Global.usuario.codigo);
    if (OP='I') or (OP='D') or (OP='E') or (OP='J') then
      Sistema.Post
    else begin
      Sistema.Post('cheq_status=''N'''+sqlemissao+
                   ' and cheq_repr_codigo='+EdCheq_repr_codigo.AsSql+
                   ' and cheq_unid_codigo='+EdCheq_unid_codigo.AsSql+
                   ' and cheq_bcoemitente='+EdCheq_bcoemitente.AsSql+
                   ' and cheq_cheque='+EdCheq_cheque.AsSql );
//      Editstogrid;
    end;

    if Qc<>nil then begin
      if (Qc.eof) and ( not EdCheq_Emit_agencia.isempty ) and ( not EdCheq_Emit_conta.isempty ) then begin
        Sistema.Insert('Emitentes');
        Sistema.Setfield('emit_banco',EdCheq_Emit_banco.text);
        Sistema.Setfield('emit_agencia',EdCheq_Emit_agencia.asinteger);
        Sistema.Setfield('emit_conta',EdCheq_Emit_conta.asinteger);
        Sistema.Setfield('emit_descricao',EdCheq_Emitente.text);
// 03.10.08
        if Global.Topicos[1258] then begin
          campo:=Sistema.GetDicionario('emitentes','emit_cheq_cnpjcpf');
          if campo.Tipo<>'' then
            Sistema.Setfield('emit_cheq_cnpjcpf',Edcheq_cnpjcpf.text);
        end;
        Sistema.Post;
      end;
    end;
// 04.10.06
    if OP='J' then begin
      Sistema.Edit('Cheques');
      Sistema.Setfield('cheq_prorroga',datacheque);
      Sistema.Setfield('cheq_predata',Edcheq_predata.AsDate);
      Sistema.Post('cheq_status=''N'' and cheq_emissao='+Datetosql(emissaocheque)+
                   ' and cheq_repr_codigo='+EdCheq_repr_codigo.AsSql+
                   ' and cheq_unid_codigo='+EdCheq_unid_codigo.AsSql+
                   ' and cheq_bcoemitente='+stringtosql(bcoemitentecheque)+
                   ' and cheq_cheque='+EdCheq_cheque.AsSql );
    end;
// 03.08.07 - fazer a saida do  banco onde foi depositado se for cheque devolvido
// 06.08.07 - fazer a entrada(retorno) da conta de cheques pre-datados onde foi dado saida quando foi depositado
// 10.08.07 - conversado com elize - no extrato ja vem a informacao do valor do cheque mas o cheque so chega alguns
//            dias depois e nao pode esperar o cheque chegar ...entao já
//            quando ela da saida do banco ja coloca a conta de despesas de dev. de cheques ja ficando ok o caixa/bancos
//            entao aqui quando lança o ch. devolvido nao precisa fazer nada...

// 22.01.10
  if Global.Topicos[1272] then begin
    if OP='D' then begin
      if Arq.TCheques.fieldbyname('cheq_plan_contadep').asinteger>0 then begin
        transacao:=FGeral.Gettransacao;
        FGeral.GravaMovfin(Transacao,EdCheq_unid_codigo.text,'S','Cheque Devolvido',sistema.hoje,sistema.hoje,
                     Sistema.hoje,EdCheq_cheque.asinteger,0,EdCheq_cheque.asinteger,Arq.TCheques.fieldbyname('cheq_plan_contadep').asinteger,
                     EdCheq_valor.ascurrency,0,Global.CodChequeDevolvido);
        FGeral.GravaMovfin(Transacao,EdCheq_unid_codigo.text,'E','Cheque Devolvido',sistema.hoje,sistema.hoje,
                     Sistema.hoje,EdCheq_cheque.asinteger,0,EdCheq_cheque.asinteger,fGeral.Getconfig1asinteger('Ctachedevolvido'),
                     EdCheq_valor.ascurrency,0,Global.CodChequeDevolvido);
      end;
    end;

//    if (OP='I') and (EdCheq_devolvido.text='S') and ( lancadevolvido ) then
//        transacao:=FGeral.Gettransacao;
//        FGeral.GravaMovfin(Transacao,EdCheq_unid_codigo.text,'E','Cheque Devolvido',sistema.hoje,sistema.hoje,
//                     Sistema.hoje,EdCheq_cheque.asinteger,0,EdCheq_cheque.asinteger,fGeral.Getconfig1asinteger('Ctachedevolvido'),
//                     EdCheq_valor.ascurrency,0,Global.CodChequeDevolvido);
  end;

    Sistema.beginprocess('Gravando informações');
    Sistema.Commit;
    Arq.TCheques.Refresh;

    Sistema.endprocess('');

//    EdCheq_prorroga.Clear;
//    EdCheq_deposito.clear;
//    EdCheq_valor.clear;
//    EdCheq_cheque.clear;
//    EdCheq_predata.clear;
//    EdCheq_emissao.clear;
    EdCheq_repr_codigo.ClearAll(FCadcheques,99);
    EdCheq_emissao.setdate(sistema.hoje);
    EdCheq_repr_codigo.setfocus;
  end;
//  Grid.enabled:=false;
  xGrid.enabled:=false;
  if (OP='D') or (OP='J') then
    bcancelarclick(self);

end;

procedure TFCadcheques.Execute(xcheque:string='';xemissao:Tdatetime=0;xpredata:Tdatetime=0;xcliente:integer=0;xvalor:extended=0;xEmiRec:string='R');
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var xcondicao:string;
    datainicio:TDatetime;
begin
  datainicio:=sistema.hoje-200;
// 24.03.06
  if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
  else
      sqldatacont:=' and cheq_datacont>1';
// 08.08.08
  ycheque:=xcheque;
  yemissao:=xemissao;
  ypredata:=xpredata;
  ycliente:=xcliente;
  yvalor:=xvalor;
/////////////////

// 24.07.07
  if Global.Topicos[1150] then
    EdCodtipo.Empty:=false
  else
    EdCodtipo.Empty:=true;
// 28.03.13
  emirec:=xemirec;
  if emirec='R' then
    Caption:='Cadastro de Cheques RECEBIDOS'
  else
    Caption:='Cadastro de Cheques EMITIDOS';
  selectemaberto:='select * from cheques inner join representantes on ( repr_codigo=cheq_repr_codigo )'+
//                   ' where cheq_status=''N'' and cheq_emirec=''R'''+
                   ' where cheq_status=''N'' and cheq_emirec = '+Stringtosql(emirec)+
//                   ' and ( (cheq_deposito>'+Datetosql(datainicio)+') or (cheq_deposito is null) )'+
                   ' and cheq_emissao>='+Datetosql(datainicio)+
                   sqldatacont+
                   ' order by cheq_emissao';
  xcondicao:='cheq_status=''N'' and cheq_emirec=''R''';
//  if Arq.TCheques.condicao<>xcondicao then
  Arq.TCheques.condicao:='cheq_status=''N'' and cheq_emirec='+Stringtosql(emirec);
  sistema.beginprocess('Abrindo arquivo de cheques');
  if not Arq.TCheques.active then begin
    Arq.TCheques.CommandText:=selectemaberto;
    Arq.TCheques.open;
  end else
    Arq.TCheques.refresh;
  sistema.endprocess('');
  FEmitentes.Setabancos(EdCheq_emit_banco);
  FEmitentes.Setabancos(EdCheq_bancustodia);
  FUnidades.SetaItems(EdCheq_Unid_codigo,nil,Global.Usuario.UnidadesMvto);
  jurosmes:=FGeral.Getconfig1asfloat('JUROSCHEQUE');
// 03.10.08
  EdCheq_cnpjcpf.Enabled:=Global.Topicos[1258];
// 24.02.14 - vivan - Liane
  EdCheq_emissao.Enabled:= not Global.Usuario.OutrosAcessos[0719];
// 07.12.13
  if ycliente>0 then
    ShowModal
  else
    Show;
end;

procedure TFCadcheques.bIncluirClick(Sender: TObject);
//////////////////////////////////////////////////////////
begin
  Op:='I';
  PEdits.visible:=true;
  PEdits.Enabled:=true;
  balterar.enabled:=false;
  bexcluir.enabled:=false;
  bsair.enabled:=false;
//  EdCheq_devolvido.enabled:=false;
// 02.03.07 - para poder incluir um cheque já como devolvido
  EdCheq_devolvido.text:='N';
//  EdCodtipo.Enabled:=false;
  EdCodtipo.setvalue(0);
  EdCheq_prorroga.enabled:=false;
  EdCheq_deposito.enabled:=false;
  EdCheq_repr_codigo.ClearAll(FCadcheques,99);
// 24.09.08
  EdCheq_emissao.setdate(sistema.hoje);
// 08.08.08
  if ycliente>0 then begin
    EdCheq_cheque.text:=ycheque;
    EdCheq_emissao.SetDate(yemissao);
//    Edmovimento.SetDate(yemissao);
// 05.11.09
    FGeral.setamovimento(Edmovimento);
    EdCheq_valor.setvalue(yvalor);
    EdCheq_predata.SetDate(ypredata);
    EdCodtipo.setvalue(ycliente);
//  xcheque:string='';xemissao:Tdatetime=0;xpredata:Tdatetime=0;xcliente:integer=0
  end;
  if EdCheq_unid_codigo.isempty then
    EdCheq_unid_codigo.text:=Global.codigounidade;
  HabilitaEdits(emirec);
  EdCheq_repr_codigo.setfocus;

end;

procedure TFCadcheques.bAlterarClick(Sender: TObject);
begin
  Op:='A';
  PEdits.visible:=true;
  PEdits.Enabled:=true;
  bincluir.enabled:=false;
  bexcluir.enabled:=false;
  bsair.enabled:=false;
  XGrid.enabled:=false;
  EdCheq_repr_codigo.GetFields(FCadcheques,99);
//  if EdCheq_devolvido.Text='S' then
//  EdCodtipo.enabled:=true;
  EdCheq_prorroga.enabled:=true;
  EdCheq_deposito.enabled:=true;
  EdCodTipo.enabled:=(emirec='R');
// 15.10.13 - Novicarnes - Elize
  EdChequefinal.enabled:=false;
//    EdCheq_cheque.text:=Grid.Cells[grid.getcolumn('cheq_cheque'),Grid.row];
//    EdCheq_emissao.Setdate(Strtodate(Grid.Cells[grid.getcolumn('cheq_emissao'),Grid.row]));
//    EdCheq_bcoemitente.text:=Grid.Cells[grid.getcolumn('cheq_bcoemitente'),Grid.row];
  EdCheq_repr_codigo.setfocus;

end;

procedure TFCadcheques.bcancelarClick(Sender: TObject);
begin
  PEdits.enabled:=false;
  PEdits.visible:=false;
  EdCheq_repr_codigo.ClearAll(FCadcheques,99);
  bincluir.enabled:=true;
  balterar.enabled:=true;
  bexcluir.enabled:=true;
  bsair.enabled:=true;
  xGrid.enabled:=true;
  XGrid.Restaure;   // 19.05.06
  xGrid.SetFocus;

end;

procedure TFCadcheques.bExcluirClick(Sender: TObject);
begin
     if confirma('Confirma exclusão ?') then begin
       sistema.beginprocess('excluindo');
       ExecuteSql('Update cheques set cheq_status=''C'' where cheq_status=''N'''+
                  ' and cheq_repr_codigo='+EdCheq_repr_codigo.AsSql+
                  ' and cheq_cheque='+EdCheq_cheque.AsSql+
                  ' and cheq_bcoemitente='+EdCheq_bcoemitente.AsSql+
                  ' and cheq_emissao='+EdCheq_Emissao.AsSql );
       Arq.TCheques.close;
       Arq.TCheques.open;;
       sistema.endprocess('');
     end;
end;

procedure TFCadcheques.EdCheq_unid_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.LimpaEdit(EdCheq_unid_codigo,key);
end;

procedure TFCadcheques.bbaixaClick(Sender: TObject);
begin
  EdCheq_repr_codigo.GetFields(FCadcheques,99);
  if EdCheq_deposito.isempty then begin
    EdCheq_repr_codigo.text:=Arq.TCheques.fieldbyname('cheq_repr_codigo').asstring;
    EdCheq_cheque.text:=Arq.TCheques.fieldbyname('cheq_cheque').asstring;
    EdCheq_emissao.Setdate(Arq.TCheques.fieldbyname('cheq_emissao').asdatetime);
    EdCheq_unid_codigo.text:=Arq.TCheques.fieldbyname('cheq_unid_codigo').asstring;
    EdCheq_bcoemitente.text:=Arq.TCheques.fieldbyname('cheq_bcoemitente').asstring;
//    QCheq:=sqltoquery('Select * from cheques where cheq_status=''N'''+
//                  ' and cheq_repr_codigo='+EdCheq_repr_codigo.AsSql+
//                  ' and cheq_cheque='+EdCheq_cheque.AsSql+
//                  ' and cheq_unid_codigo='+EdCheq_unid_codigo.assql+
//                  ' and cheq_emissao='+EdCheq_Emissao.AsSql );
      EdJuros.enabled:=true;
      EdJuros.visible:=true;
      EdQuempagou.enabled:=true;
      EdQuempagou.visible:=true;
//      EdJuros.setfocus;
      EdQuemPagou.setfocus;
  end else begin
//      EdCheq_deposito.Setdate(Arq.TCheques.fieldbyname('cheq_deposito').asdatetime);
      Avisoerro('Cheque já baixado em '+formatdatetime('dd/mm/yy',Edcheq_deposito.asdate));
  end;
end;

procedure TFCadcheques.EdJurosValidate(Sender: TObject);
var Transacao,sqlrepr,sqlemirec:string;
    ContaCaixa,ContaJuros,contachequesrecebidos,contabanco:integer;
begin
  Contacaixa:=FUnidades.getcontacaixa(Global.codigounidade);
  ContaJuros:=Global.ContaJurosRecebidos;
  contachequesrecebidos:=FGeral.Getconfig1asinteger('Ctacherecebido');
  contabanco:=FGeral.Getconfig1asinteger('Ctabancheqrec');
//  if contacaixa=0 then begin
//    Avisoerro('Conta Caixa não cadastrada nesta unidade');
//    exit;
//  end;
//  if contabanco=0 then begin
//    Avisoerro('Conta banco para depósito não configurada');
//    exit;
//  end;
  if confirma('Confirma ?') then begin
    if Arq.TCheques.FieldByName('cheq_emirec').AsString<>'E' then begin
      Sistema.begintransaction('Gravando');
      Transacao:=FGeral.Gettransacao;
      if contacaixa>0 then begin
        if EdJuros.ascurrency>0 then begin
           FGeral.GravaMovfin(Transacao,Edcheq_unid_codigo.text,'E','Cheque '+EdCheq_cheque.text+' Juros Recebidos',sistema.hoje,Edmovimento.Asdate,
                         Sistema.hoje,EdCheq_cheque.asinteger,0,EdCheq_cheque.asinteger,ContaCaixa,EdJuros.AsCurrency,contajuros,Global.CodJurosRecebidos)
        end;
        if confirma('Baixar no caixa') then
           FGeral.GravaMovfin(Transacao,Edcheq_unid_codigo.text,'E','Cheque '+EdCheq_cheque.text,sistema.hoje,Edmovimento.Asdate,
                       Sistema.hoje,EdCheq_cheque.asinteger,0,EdCheq_cheque.asinteger,ContaCaixa,EdCheq_valor.AsCurrency,contachequesrecebidos,'CH');
      end;
    end;
    sqlrepr:=' and cheq_repr_codigo='+Edcheq_repr_codigo.AsSql;
//    sqlemirec:=' and cheq_emirec=''R''';   // por enquanto somente os recebidos
// 28.07.14 - Patoterra - emitidos
    sqlemirec:=' and cheq_emirec='+Stringtosql(Arq.TCheques.FieldByName('cheq_emirec').AsString);   // por enquanto somente os recebidos

    Sistema.Edit('Cheques');
    Sistema.SetField('cheq_deposito',Sistema.hoje);
    Sistema.Setfield('cheq_rc',EdQuemPagou.text);
    Sistema.Post('cheq_status=''N'' and cheq_deposito is null '+
                 sqlrepr+
                 sqlemirec+
                 ' and cheq_cheque='+Edcheq_cheque.assql+
                 ' and cheq_emissao='+EdCheq_emissao.assql+
                 ' and cheq_unid_codigo='+EdCheq_unid_codigo.AsSql+
                 ' and cheq_bcoemitente='+EdCheq_bcoemitente.assql+
                 ' and cheq_unid_codigo='+EdCheq_Unid_codigo.AsSql );

//    Grid.cells[Grid.getcolumn('cheq_deposito'),grid.row]:=formatdatetime('dd/mm/yy',sistema.hoje);
    Sistema.endtransaction('Lançamento Ok');

////////////    bemabertoclick(FCadcheques);
// 17.08.05
  end;
  EdJuros.enabled:=false;
  EdJuros.visible:=false;
  EdQuempagou.enabled:=false;
  EdQuempagou.visible:=false;
end;

procedure TFCadcheques.Gridtoedits;
begin
end;

procedure TFCadcheques.Edcheq_predataValidate(Sender: TObject);
var dias:currency;

begin
   if (Edcheq_predata.asdate<EdCheq_emissao.asdate) and (OP<>'J') then
     Edcheq_predata.invalid('Bom para tem que ser maior que a emissão')
   else if OP='J' then begin
     dias:=Edcheq_predata.asdate-datacheque;
     Edcheq_valor.setvalue( valorjuros(valorcheque,jurosmes,dias) )
   end else if Datetoano(EdCheq_predata.asdate,true)>(Datetoano(Sistema.hoje,true)+1) then  // 30.11.07
     Edcheq_predata.invalid('Bom para tem que ser no máximo um ano após data atual');
end;

procedure TFCadcheques.EdCheq_bcoemitenteValidate(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////////////////////////////////
var QBusca:TSqlquery;
    sqlemissao:string;
begin
// 07.10.13
    if not EdCheq_emissao.IsEmpty then
      sqlemissao:=' and cheq_emissao='+EdCheq_emissao.AsSql
    else
      sqlemissao:=' and cheq_emissao is null';
    Qbusca:=sqltoquery('select * from cheques where cheq_status=''N'''+
                         sqlemissao+
                         ' and cheq_repr_codigo='+EdCheq_repr_codigo.AsSql+
                         ' and cheq_bcoemitente='+EdCheq_bcoemitente.AsSql+
                         ' and cheq_cheque='+EdCheq_cheque.AsSql );

    if (not QBusca.eof) and (Op='I') then
      EdCheq_bcoemitente.invalid('Cheque já cadastrado para este representante nesta emissão')
    else begin
      if not QBusca.eof then begin
        Querytoedits(QBusca);
      end else begin
        if EdCheq_predata.AsDate<=1 then
          EdCheq_predata.setdate(edcheq_emissao.AsDate);
//        EdMovimento.Setdate(sistema.hoje);
// 05.11.09
        FGeral.setamovimento(Edmovimento);
        if (QBusca.eof) and (Op='A') then
          EdCheq_bcoemitente.invalid('Cheque não encontrado para este representante nesta emissão');
      end;
    end;

end;

procedure TFCadcheques.XGridNewRecord(Sender: TObject);
begin
  EdCheq_repr_codigo.GetFields(FCAdcheques,99);
  EdCheq_repr_codigo.validfind;
  EdNomerepre.text:=SetEdRepr_nome.text;
end;

procedure TFCadcheques.bdevolvidoClick(Sender: TObject);
begin
  Op:='D';
  if fGeral.Getconfig1asinteger('Ctachedevolvido')=0 then begin
    Aviso('Falta configurar a conta de cheques devolvidos na config. geral do sistema');
  end;
//  if Arq.Tcheques.fieldbyname('cheq_deposito').asdatetime<=1 then begin
  if Arq.TCheques.fieldbyname('cheq_plan_contadep').asinteger=0 then begin
    Avisoerro('Atenção !  Cheque ainda sem conta de depósito');
    exit;
  end;
//  if confirma('Incluir cheque depositado direto na conta ?') then
//    op:='E';
  PEdits.visible:=true;
  PEdits.Enabled:=true;
  balterar.enabled:=false;
  bexcluir.enabled:=false;
  bsair.enabled:=false;
//  EdCodtipo.Enabled:=true;
  EdCodtipo.setvalue(0);
//  EdCheq_repr_codigo.ClearAll(FCadcheques,99);
  if op='D' then
    EdCheq_repr_codigo.GetFields(FCadcheques,99)
  else begin
    EdCheq_repr_codigo.Clearall(FCadcheques,99);
    if EdCheq_unid_codigo.isempty then
      EdCheq_unid_codigo.text:=Global.codigounidade;
  end;
  EdCheq_devolvido.text:='S';
//  EdCheq_emissao.setdate(sistema.hoje);
//  EdCheq_predata.setdate(sistema.hoje);
// 03.08.07 - deixar com a data do vencimento,emissao original...
//  EdMovimento.setdate(sistema.hoje);
// 05.11.09
  FGeral.setamovimento(Edmovimento);
  EdCheq_prorroga.setdate(0);
  EdCheq_deposito.setdate(0);
  EdCheq_Emit_Banco.text:='998';   // banco 'cheques devolvidos'
  EdCheq_devolvido.enabled:=false;
  EdCheq_repr_codigo.setfocus;

end;

procedure TFCadcheques.EdCodtipoValidate(Sender: TObject);
begin
   if OP='D' then begin
     if Edcodtipo.isempty then begin
       if sistema.hoje>texttodate('26072006') then
         EdCodtipo.invalid('Campo de preenchimento obrigatório')
       else
         Avisoerro('Checar codigo do cliente');
     end;
   end;
end;




procedure TFCadcheques.EdCheq_Emit_bancoValidate(Sender: TObject);
begin
  if op<>'A' then
   EdCheq_bcoemitente.text:=GetNomeBanco(EdCheq_emit_banco.text,EdCheq_emit_banco);
end;

function TFCadcheques.GetNomeBanco(banco: string ; Edit:Tsqled): string;
var p:integer;
begin
  result:='';
  for p:=0 to Edit.Items.count-1 do begin
    if copy(Edit.Items.strings[p],1,3)=banco then begin
      result:=copy(Edit.Items.strings[p],7,40);
      break;
    end;
  end;
end;


procedure TFCadcheques.LeCmc7(var banco, agencia, conta: string);
begin

end;

procedure TFCadcheques.EdCheq_Emit_contaValidate(Sender: TObject);
begin
   if (OP='I') and (EdCheq_emit_conta.isempty) then begin
     Edcheq_emit_conta.invalid('Campo de preenchimento obrigatório');
     exit;
   end;
   if (not EdCheq_emit_agencia.isempty) and (not EdCheq_Emit_conta.isempty) then begin
     Qc:=sqltoquery('select * from emitentes where emit_banco='+EdCheq_Emit_banco.Assql+
                 ' and emit_agencia='+EdCheq_emit_agencia.assql+' and emit_conta='+EdCheq_Emit_conta.assql);
     if not Qc.eof then begin
       EdCheq_emitente.text:=Qc.fieldbyname('emit_descricao').asstring;
// 03.10.08
       if Global.Topicos[1258] then
         EdCheq_cnpjcpf.text:=Qc.fieldbyname('emit_cheq_cnpjcpf').asstring;
     end;
/////////     FGeral.Fechaquery(Qc);   // 03.10.08 - se fecha na inclui na gravacao
   end;
end;

procedure TFCadcheques.Edcheq_Emit_agenciaValidate(Sender: TObject);
begin
   if (OP='I') and (EdCheq_emit_agencia.isempty) then
     Edcheq_emit_agencia.invalid('Campo de preenchimento obrigatório');
end;

procedure TFCadcheques.bemitentesClick(Sender: TObject);
begin
   if pedits.visible then exit;
   FEmitentes.execute;
end;

procedure TFCadcheques.Edcheq_Cmc7Validate(Sender: TObject);

   function SoNumeros(s:string):string;
   var p,tam:integer;
       e:string;
   begin
     tam:=length(trim(s));
     e:='';
     for p:=1 to tam do begin
       if pos( copy(s,p,1),'0123456789' ) >0 then
         e:=e+copy(s,p,1);
     end;
     result:=e;
   end;

begin

  if (Op='I') and (not EdCheq_cmc7.isempty) then begin
    EdCheq_cmc7.text:=SoNUmeros(EdCheq_cmc7.text);
// 28.08.08 - ajustado para leitora do 'Itau' - Novicarnes
    //FDv3 := Copy(EdCmc7,30,1)[1];
    EdCheq_cheque.text:=Copy(EdCheq_Cmc7.text,12,6);
    EdCheq_emit_banco.text:=Copy(EdCheq_Cmc7.text,1,3);
    EdCheq_emit_Agencia.text :=Copy(EdCheq_Cmc7.text,4,4);
    //EdCheq_emit_Conta.text := Copy(EdCmc7.text,20,10);
    EdCheq_emit_Conta.text := Copy(EdCheq_Cmc7.text,25,08);
    ConfiguraContaCmc7(EdCheq_emit_conta,EdCheq_emit_banco.text);

    //FDv1 := Copy(EdCmc7,19,1)[1];
    //FTipo := Copy(EdCmc7,18,1)[1];
    //FCompe := Copy(EdCmc7,9,3);
    //FDv2 := Copy(EdCmc7,8,1)[1];
  end;

end;

procedure TFCadcheques.bjurosClick(Sender: TObject);

begin
  Op:='J';
  PEdits.visible:=true;
  PEdits.Enabled:=true;
  balterar.enabled:=false;
  bexcluir.enabled:=false;
  bsair.enabled:=false;
//  EdCodtipo.Enabled:=true;
  EdCodtipo.setvalue(0);
//  EdCheq_repr_codigo.ClearAll(FCadcheques,99);
//  if op='D' then
    EdCheq_repr_codigo.GetFields(FCadcheques,99);
//  else begin
//    EdCheq_repr_codigo.Clearall(FCadcheques,99);
//    if EdCheq_unid_codigo.isempty then
//      EdCheq_unid_codigo.text:=Global.codigounidade;
//  end;
  datacheque:=Edcheq_predata.asdate;
  emissaocheque:=EdCheq_emissao.asdate;
  bcoemitentecheque:=EdCheq_bcoemitente.text;
  valorcheque:=EdCheq_valor.ascurrency;
  Edcheq_emit_banco.text:='999';
  Edcheq_emit_banco.valid;
  EdCheq_devolvido.text:='N';
//  EdCheq_emissao.setdate(sistema.hoje);
  EdCheq_predata.setdate(sistema.hoje);
//  EdMovimento.setdate(sistema.hoje);
// 05.11.09
  FGeral.setamovimento(Edmovimento);
  EdCheq_prorroga.setdate(0);
  EdCheq_deposito.setdate(0);
  EdCheq_valor.setvalue(0);
  EdCheq_devolvido.enabled:=false;
  EdCheq_repr_codigo.setfocus;
//  EdCheq_predata.setfocus;

end;

procedure TFCadcheques.Edcheq_prorrogaValidate(Sender: TObject);
//var dias:currency;
begin
//   if OP='J' then begin
//     dias:=Edcheq_predata.asdate-datacheque;
//     Edcheq_valor.setvalue( valorjuros(valorcheque,jurosmes,dias) )
//   end;

end;

procedure TFCadcheques.EdCheq_Emit_bancoKeyPress(Sender: TObject;
  var Key: Char);
begin
   FGeral.LimpaEdit(EdCheq_emit_banco,key);
end;

procedure TFCadcheques.brelatorioClick(Sender: TObject);
begin
  FRelGerenciais_ChequesRecebidos(emirec);

end;

procedure TFCadcheques.EdMovimentoValidate(Sender: TObject);
begin
  if (EdMovimento.asdate<Sistema.hoje) and (not EdMovimento.IsEmpty) and (OP='I') then
    EdMovimento.Invalid('Data de movimento não pode ser anterior a data atual');
end;

procedure TFCadcheques.Edcheq_bancustodiaKeyPress(Sender: TObject;
  var Key: Char);
begin
   FGeral.LimpaEdit(EdCheq_bancustodia,key);

end;

procedure TFCadcheques.Edcheq_bancustodiaValidate(Sender: TObject);
begin
  Sqled2.text:=GetNomeBanco(EdCheq_bancustodia.Text,EdCheq_bancustodia);

end;

procedure TFCadcheques.ConfiguraContaCmc7(Ed: TSqled ; banco:string);
var config:string;
    Lista:TStringlist;
    i:integer;

    function GetINicio(s:string):integer;
    var x,posvir:integer;
    begin
      x:=pos('(',s);
      posvir:=pos(',',s);
      if posvir-x>0 then  //com duas casas
        result:=strtoint(copy(s,x+1,2))
      else
        result:=strtoint(copy(s,x+1,1))
    end;

    function GetFim(s:string):integer;
    var x,posvir:integer;
    begin
      x:=pos(')',s);
      posvir:=pos(',',s);
      if x-posvir>0 then  //com duas casas
        result:=strtoint(copy(s,posvir+1,2))
      else
        result:=strtoint(copy(s,posvir+1,1))
    end;

begin
   config:=FGeral.GetConfig1AsString('CMC7CONTA');
   if trim(config)='' then exit;
   if EdCheq_cmc7.isempty then exit;
   Lista:=TStringlist.create;
   strtolista(Lista,config,';',true);
   for i:=0 to Lista.count-1 do begin
     if trim(Lista[i])<>'' then begin
       if banco=copy(lista[i],1,3) then begin
         Ed.Clear;
         Ed.Text:=Copy(EdCheq_Cmc7.text,Getinicio(lista[i]),(Getfim(lista[i])-Getinicio(lista[i]))+1 );
         break;
       end;
     end;
   end;

end;

procedure TFCadcheques.EdCheq_cnpjcpfValidate(Sender: TObject);
var Ed:TSQLEd;
begin
  Ed:=TSQLEd(Sender);
  if not Global.Topicos[1102] and Ed.IsEmpty then Ed.Invalid('Não permitido vazio');
  if not Global.Topicos[1102] and not Ed.IsEmpty then FGeral.ValidaCNPJCPF(Ed);

end;

// 24.04.13
procedure TFCadcheques.HabilitaEdits(s: string);
////////////////////////////////////////////////
begin
  EdCheq_cheque.enabled:=true;
  EdCheq_Emit_banco.enabled:=true;
  Edcheq_Emit_agencia.enabled:=true;
  EdCheq_Emit_conta.enabled:=true;
  EdCheq_unid_codigo.enabled:=true;
  Edcheq_prorroga.enabled:=false;
  Edcheq_deposito.enabled:=false;
  if S='E' then begin
    Edcheq_Cmc7.enabled:=false;
    EdCheq_emissao.Enabled:=false;
    Edcheq_predata.enabled:=false;
    EdMovimento.enabled:=false;
    Edcheq_valor.enabled:=false;
    EdCheq_devolvido.enabled:=false;
// 25.09.13 - Novicarnes = Elize
//    Edcheq_obs.enabled:=false;
    EdCodtipo.enabled:=false;
    Edcheq_bancustodia.enabled:=false;
//    Edchequefinal.visible:=true;
    Edchequefinal.enabled:=true;
  end else begin
    Edcheq_Cmc7.enabled:=true;
    EdCheq_emissao.Enabled:=true;
    Edcheq_predata.Enabled:=true;
    EdMovimento.enabled:=true;
    Edcheq_valor.enabled:=true;
    EdCheq_devolvido.enabled:=true;
    Edcheq_obs.enabled:=true;
    EdCodtipo.enabled:=true;
    Edcheq_bancustodia.enabled:=true;
//    Edchequefinal.visible:=false;
    Edchequefinal.enabled:=false;
  end;

end;

procedure TFCadcheques.EdchequefinalValidate(Sender: TObject);
////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    cheques:string;
    p:integer;
begin
  if strtoint(EdChequefinal.text) <= strtoint(EdCheq_cheque.text) then
     EdChequefinal.invalid('Número final tem que ser maior que o inicial')
  else if ( strtoint(EdChequefinal.text) - strtoint(EdCheq_cheque.text) ) > 50 then
     EdChequefinal.invalid('Permitido máximo de 50 cheques por vez')
  else begin
    cheques:='';
    for p:=strtoint(EdCheq_cheque.text) to strtoint(EdChequefinal.text) do cheques:=cheques+inttostr(p)+';';
    Q:=Sqltoquery('select cheq_cheque from cheques where cheq_status=''N'''+
                ' and Cheq_emit_agencia='+Edcheq_Emit_agencia.asSql+
                ' and Cheq_emit_conta='+Edcheq_Emit_conta.asSql+
                ' and Cheq_emit_banco='+Edcheq_Emit_banco.asSql+
                ' and '+FGeral.GetIn('cheq_cheque',cheques,'C') );
    if not Q.eof then
     EdChequefinal.invalid('Cheque '+Q.fieldbyname('cheq_cheque').asstring+' já cadastrado para este banco, agencia e conta');
    FGeral.FechaQuery(Q);
  end;
end;

procedure TFCadcheques.EdchequefinalExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////
var p:integer;
begin
  if OP='I' then begin
    if confirma('Confirma inclusão deste talão ?') then begin

        if Qc<>nil then begin
          if (Qc.eof) and ( not EdCheq_Emit_agencia.isempty ) and ( not EdCheq_Emit_conta.isempty ) then begin
            Sistema.Insert('Emitentes');
            Sistema.Setfield('emit_banco',EdCheq_Emit_banco.text);
            Sistema.Setfield('emit_agencia',EdCheq_Emit_agencia.asinteger);
            Sistema.Setfield('emit_conta',EdCheq_Emit_conta.asinteger);
            Sistema.Setfield('emit_descricao',EdCheq_Emitente.text);
            if Global.Topicos[1258] then begin
              campo:=Sistema.GetDicionario('emitentes','emit_cheq_cnpjcpf');
              if campo.Tipo<>'' then
                Sistema.Setfield('emit_cheq_cnpjcpf',Edcheq_cnpjcpf.text);
            end;
            Sistema.Post;
          end;
        end;

      for p:=strtoint(EdCheq_cheque.text) to strtoint(EdChequefinal.text) do begin
        Sistema.Insert('Cheques');
        Sistema.Setfield('cheq_status','N');
        Sistema.Setfield('cheq_emirec',emirec);
        Sistema.Setfield('cheq_cheque',inttostr(p));
        Sistema.Setfield('cheq_emissao',Edcheq_emissao.AsDate);
        Sistema.Setfield('cheq_devolvido',EdCheq_Devolvido.text);
        Sistema.Setfield('cheq_tipo_codigo',EdCodtipo.asinteger);

        Sistema.Setfield('cheq_tipocad','F');

        Sistema.Setfield('cheq_bcoemitente',EdCheq_bcoemitente.Text);
        Sistema.Setfield('cheq_emitente',Edcheq_emitente.Text);
        Sistema.Setfield('cheq_predata',Edcheq_predata.AsDate);
        Sistema.Setfield('cheq_valor',Edcheq_valor.ascurrency);
        Sistema.Setfield('cheq_repr_codigo',EdCheq_repr_codigo.asinteger);
        Sistema.Setfield('cheq_deposito',Edcheq_deposito.asdate);
        Sistema.Setfield('cheq_prorroga',Edcheq_prorroga.asdate);
        Sistema.Setfield('cheq_datacont',EdMovimento.asdate);
        Sistema.Setfield('cheq_lancto',Sistema.hoje);
        Sistema.Setfield('cheq_obs',Edcheq_obs.text);
        Sistema.Setfield('cheq_unid_codigo',Edcheq_Unid_codigo.text);
        Sistema.Setfield('cheq_emit_banco',Edcheq_Emit_banco.text);
        Sistema.Setfield('cheq_emit_agencia',Edcheq_Emit_agencia.text);
        Sistema.Setfield('cheq_emit_conta',Edcheq_Emit_conta.text);
        Sistema.Setfield('Cheq_bancocustodia',Edcheq_bancustodia.text);
        Sistema.Post
      end;
      Sistema.beginprocess('Gravando talão');
      Sistema.Commit;
      Arq.TCheques.Refresh;
      Sistema.endprocess('');
      EdCheq_repr_codigo.ClearAll(FCadcheques,99);
      EdCheq_emissao.setdate(sistema.hoje);
      EdCheq_repr_codigo.setfocus;
    end;
  end;
end;

procedure TFCadcheques.EdCheq_chequeValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////
begin
  if not EdCheq_cheque.isempty then
    EdChequefinal.text:=EdCheq_cheque.text;
end;

////////////////////////////////////////////////////////////////
procedure TFCadcheques.bgarantidoClick(Sender: TObject);
//////////////////////////////////////////////////////////////
var status:string;
begin
  status:=Arq.TCheques.FieldByName('cheq_garantido').asstring;
  if status='S' then begin
    if confirma('Confirma Tirar marcação de garantido ?') then begin
      Arq.TCheques.Edit;
      Arq.TCheques.FieldByName('cheq_garantido').asstring:='';
      Arq.TCheques.FieldByName('cheq_usua_garantido').asinteger:=Global.Usuario.Codigo;
      Arq.TCheques.Post;
      Arq.TCheques.Commit;
    end;
  end else begin
    if confirma('Confirma marcar como garantido ?') then begin
      Arq.TCheques.Edit;
      Arq.TCheques.FieldByName('cheq_garantido').asstring:='S';
      Arq.TCheques.FieldByName('cheq_usua_garantido').asinteger:=Global.Usuario.Codigo;
      Arq.TCheques.Post;
      Arq.TCheques.Commit;
    end;
  end;
end;

procedure TFCadcheques.Edcheq_repr_codigoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////////
begin
// 24.02.14 - vivan - Liane
  EdCheq_emissao.Enabled:= not Global.Usuario.OutrosAcessos[0719];

end;

end.

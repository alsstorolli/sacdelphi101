unit Alterapen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr ;

type
  TFAlteraPendencia = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    PFinan: TSQLPanelGrid;
    EdPort_codigo: TSQLEd;
    EdPort_descricao: TSQLEd;
    PRemessa: TSQLPanelGrid;
    Edunid_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    EdCodtipo: TSQLEd;
    SetEdFavorecido: TSQLEd;
    EdDtemissao: TSQLEd;
    EdNumeroDoc: TSQLEd;
    EdDtMovimento: TSQLEd;
    EdTipocad: TSQLEd;
    EdValortotal: TSQLEd;
    EdRecpag: TSQLEd;
    EdAntecipa: TSQLEd;
    EdOperacao: TSQLEd;
    EdVencimento: TSQLEd;
    EdFpgt_codigo: TSQLEd;
    EdFpgt_descricao: TSQLEd;
    Edtransacao: TSQLEd;
    PParcelas: TSQLPanelGrid;
    GridParcelas: TSqlDtGrid;
    SQLEd1: TSQLEd;
    EdParcela: TSQLEd;
    EdRepr_codigo: TSQLEd;
    EdDatacont: TSQLEd;
    EdCodentidade: TSQLEd;
    Edcatentidade: TSQLEd;
    EdContaDesrec: TSQLEd;
    SQLEd3: TSQLEd;
    EdValor: TSQLEd;
    EdPrevisao: TSQLEd;
    bmudaprevisao: TSQLBtn;
    procedure bGravarClick(Sender: TObject);
    procedure EdOperacaoValidate(Sender: TObject);
    procedure EdPort_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdtransacaoValidate(Sender: TObject);
    procedure EdFpgt_codigoValidate(Sender: TObject);
    procedure EdFpgt_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdTipocadValidate(Sender: TObject);
    procedure EdVencimentoExitEdit(Sender: TObject);
    procedure EdPrevisaoValidate(Sender: TObject);
    procedure bmudaprevisaoClick(Sender: TObject);
    procedure Edunid_codigoValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure campostoedits(Q:TSqlquery);
    procedure Execute;
    procedure SetaPendencias(Ed:TSqled);
  end;

var
  FAlteraPendencia: TFAlteraPendencia;
  valorant:string;
  Tipomov:string;
  Contagerencial:integer;
  Total:currency;

implementation

{$R *.dfm}

uses Sqlfun,Sqlsis , Geral, conpagto, Arquiv, Unidades;

procedure TFAlteraPendencia.campostoedits(Q:TSqlquery);
///////////////////////////////////////////////////////////
begin
  EdTipoCad.Text:=Q.fieldbyname('pend_tipocad').asstring;
  EdTipoCad.validfind;
  EdTipoCad.valid;
  if EdTipocad.text='T' then begin
    EdCodTipo.text:=Q.fieldbyname('pend_tipo_codigo').asstring;
    Arq.TTransp.locate('tran_codigo',strzero(EdCodTipo.asinteger,3),[]);
    SetEdFavorecido.Text:=Arq.TTransp.fieldbyname('tran_nome').asstring;
    contagerencial:=Arq.TTransp.fieldbyname('tran_contagerencial').asinteger;
    if trim(SetEdFavorecido.Text)='' then
      EdCodTipo.Invalid('N�o encontrado');
  end else begin
    EdCodTipo.text:=Q.fieldbyname('pend_tipo_codigo').asstring;
    Setedfavorecido.text:=FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('pend_tipo_codigo').asinteger,Q.fieldbyname('pend_tipocad').asstring,'R');
//    Edcodtipo.validfind;
  end;
  EdRecpag.text:=Q.fieldbyname('pend_rp').asstring;
  EdUnid_codigo.Text:=Q.fieldbyname('pend_unid_codigo').asstring;
  EdUnid_codigo.ValidFind;
  EdDtemissao.Setdate(Q.fieldbyname('pend_dataemissao').asdatetime);
  EdNumerodoc.text:=Q.fieldbyname('pend_numerodcto').asstring;
  EdValortotal.setvalue(Q.fieldbyname('pend_valortitulo').ascurrency);
//     EdDtMovimento.setdate(Q.fieldbyname('pend_datacont').asdatetime);
  EdDtMovimento.setdate(Q.fieldbyname('pend_datamvto').asdatetime);
  EdDatacont.SetDate(Q.fieldbyname('pend_datacont').asdatetime);
  EdFpgt_codigo.text:=Q.fieldbyname('pend_fpgt_codigo').asstring;
  EdFpgt_codigo.validfind;
  EdFpgt_codigo.Valid;
  if Q.fieldbyname('pend_datacont').asdatetime<1 then
    total:=Q.fieldbyname('pend_valortitulo').ascurrency
  else
    total:=0;
  EdPort_codigo.text:=Q.fieldbyname('pend_port_codigo').asstring;
  EdVencimento.setdate(Q.fieldbyname('pend_datavcto').asdatetime);
  EdRepr_codigo.text:=Q.fieldbyname('pend_repr_codigo').asstring;
  Tipomov:='  ';   // por enquanto nao tem este campo na tabela pendencias - 02.01.04
  EdContaDesrec.Text:=Q.fieldbyname('pend_plan_conta').asstring;
  if (Global.Usuario.OutrosAcessos[0713]) and (Q.fieldbyname('pend_tipomov').asstring=Global.CodPendenciaFinanceira)
      and (Q.fieldbyname('pend_status').asstring<>'C')
//      and (Q.fieldbyname('pend_status').asstring='N')
    then begin
    EdValor.Enabled:=true;
    valorant:=Q.fieldbyname('pend_valor').asstring;
    EdValor.text:=Q.fieldbyname('pend_valor').asstring;
    EdValor.SetValue(Q.fieldbyname('pend_valor').ascurrency);
  end else begin
    EdValor.Enabled:=false;
    valorant:='';
    EdValor.text:='';
  end;
end;

procedure TFAlteraPendencia.bGravarClick(Sender: TObject);
///////////////////////////////////////////////////
begin

  if trim(EdOPeracao.text)<>'' then begin

    if confirma('Confirma a grava��o ?') then begin
//      Sistema.BeginTransaction('Gravando');

      sistema.Edit('Pendencias');
      Sistema.SetField('pend_port_codigo',EdPort_codigo.text);
      Sistema.SetField('pend_datavcto',Edvencimento.Asdate);
// 06.04.09 - Novicarnes
      Sistema.SetField('pend_plan_conta',EdContaDesrec.Asinteger);
// 20.04.09 - Abra
      if EdValor.Enabled then begin
        Sistema.SetField('pend_valor',EdValor.AsCurrency);
      end;
// 02.12.16 - Novicarnes
      Sistema.SetField('pend_unid_codigo',EdUnid_codigo.text);
      Sistema.Post('pend_operacao='+stringtosql(trim(EdOperacao.TExt))+
                   ' and pend_status<>''C''' );
//                   ' and pend_status=''N''' );
      if EdValor.Enabled then begin
        FGeral.GravaLog(21,'opera��o '+EdOperacao.text,false,'',0,'Altera��o Pend. Financ. '+EdNumerodoc.text+' de :'+Valorant+' para :'+EdValor.text);
      end;
// 28.08.14 - vivan
      if EdVencimento.OldValue<>EdVencimento.Text then
        FGeral.GravaLog(30,'opera��o '+EdOperacao.text,false,'',0,'Altera��o Vencimento Financ. '+EdNumerodoc.text+' de :'+EdVencimento.OldValue+' para :'+EdVencimento.text);
      Sistema.commit;
//      Sistema.Endtransaction('');
      EdOperacao.ClearAll(FAlteraPendencia,99);
      EdPort_codigo.ClearAll(FAlteraPendencia,99);
    end;
    EdCatEntidade.SetFocus;

  end else if trim(EdTransacao.text)<>'' then begin

    if confirma('Confirma a altera��o ?') then begin

      Sistema.Beginprocess('Eliminando pend�ncia financeira e movimento caixa/bancos');
      try
        ExecuteSql('Update pendencias set pend_status=''C'' where pend_transacao='+EdTransacao.AsSql);
        ExecuteSql('Update movfin set movf_status=''C'' where movf_transacao='+EdTransacao.AsSql);
        Sistema.Commit;
        Sistema.Endprocess('');
        Sistema.Begintransaction('Gravando nova forma de pagamento');
        FGeral.GravaPendencia(EdDtemissao.asdate,EdDtMovimento.asdate,EdCodtipo,Edtipocad.text,
                       EdRepr_codigo.asinteger,EdUNid_codigo.text,
                       Tipomov,EdTransacao.text,EdFpgt_codigo.text,
                       EdRecPag.text,EdNumerodoc.asinteger,0,EdValortotal.ascurrency,0,'N',
                       total,contagerencial,GridParcelas,'',EdPort_codigo.text );
// 06.05.19   - vida nova
        if EdVencimento.OldValue<>EdVencimento.Text then
           FGeral.GravaLog(30,'opera��o '+EdOperacao.text,false,'',0,'Altera��o Vencimento Financ. '+EdNumerodoc.text+' de :'+EdVencimento.OldValue+' para :'+EdVencimento.text);

        Sistema.Endtransaction('');
      except
        Sistema.EndProcess('N�o foi poss�vel gravar.  Tente mais tarde.');
      end;
      EdTransacao.ClearAll(FAlteraPendencia,99);
      GridParcelas.clear;
      EdPort_codigo.ClearAll(FAlteraPendencia,99);
//      EdTransacao.setfocus;
      EdCatEntidade.SetFocus;
    end;
  end;
end;

procedure TFAlteraPendencia.EdOperacaoValidate(Sender: TObject);
var Q:TSqlquery;
    sqlprevisao:string;
begin
  Contagerencial:=0;
  Gridparcelas.clear;
  if EdOperacao.isempty then begin
    EdTransacao.enabled:=true;
    exit;
  end;
  EdTransacao.enabled:=false;
  EdFpgt_codigo.Enabled:=false;
  Pfinan.enabled:=true;
  if EdPrevisao.text='S' then
     sqlprevisao:=' and pend_status=''H'''
  else
     sqlprevisao:=' and pend_status=''N''';
  Q:=sqltoquery('select * from pendencias where pend_operacao='+stringtosql(trim(EdOperacao.text))+
                sqlprevisao );
//                ' and pend_status=''N''' );
  if not Q.eof then begin
    CampostoEdits(Q);
// 02.12.16
    EdUnid_codigo.SetFocus;
//    EdPort_codigo.SetFocus;
  end else begin
   EdOperacao.ClearAll(FAlteraPendencia,99);
   EdOperacao.Invalid('Opera��o n�o encontrada ou j� baixada');
  end;
end;

procedure TFAlteraPendencia.Execute;
///////////////////////////////////////////////////
begin
   Show;
   EdOperacao.ClearAll(FAlteraPendencia,99);
   FGeral.ConfiguraColorEditsNaoEnabled(Self);
   FUnidades.SetaItems(EdUnid_codigo,SetEdUnid_nome,Global.Usuario.UnidadesMvto);
   bmudaprevisao.Enabled:=false;
   EdCatEntidade.setfocus;
//   EdContaDesRec.Enabled:=Global.Usuario.OutrosAcessos[0715];
// 15.02.10 - senao tinha q estar verde para poder alterar a conta de despesa
   EdContaDesRec.Enabled:= not Global.Usuario.OutrosAcessos[0715];
   if not Arq.TTransp.Active then Arq.TTransp.open;
end;

procedure TFAlteraPendencia.EdPort_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.LImpaedit(EdPort_codigo,key);
end;

procedure TFAlteraPendencia.EdtransacaoValidate(Sender: TObject);
var Q:TSqlquery;
begin
  if trim(EdTransacao.text)<>'' then begin
    EdOperacao.text:='';
    Pfinan.enabled:=false;
    Q:=sqltoquery('select * from pendencias where pend_transacao='+EdTransacao.AsSql+
                  ' and pend_status=''N''' );
    if not Q.eof then begin
      CampostoEdits(Q);
      EdFpgt_codigo.Enabled:=true;
      EdFpgt_codigo.SetFocus;
    end else begin
     EdTransacao.ClearAll(FAlteraPendencia,99);
     EdTransacao.Invalid('Transa��o n�o encontrada ou j� baixada');
    end;
  end;
end;


procedure TFAlteraPendencia.EdFpgt_codigoValidate(Sender: TObject);
var nparcelas,n:integer;
    ListaPrazo:TStringlist;
    p:integer;
    valorparcela,valortotal,acumulado:currency;
begin
  if trim(EdTransacao.text)<>'' then begin
  if not EdFpgt_codigo.validfind then exit;
  GridParcelas.Clear;
  if FCondPagto.GetAvPz(EdFpgt_codigo.text)='P' then begin
    ListaPrazo:=TStringlist.create;
    n:=FCondPagto.GetPrazos(EdFpgt_codigo.text,ListaPrazo);
    nparcelas:=FCondPagto.GetNumeroParcelas(EdFpgt_codigo.text);
    acumulado:=0;valortotal:=EdValortotal.AsCurrency;
    for p:=1 to nparcelas do begin
      GridParcelas.cells[0,p]:=formatdatetime('dd/mm/yyyy',FGeral.GetProximoDiaUtil(EdDtEmissao.Asdate+Inteiro(ListaPrazo[p-1])) );
//      Sistema.SetField('Pend_Parcela',p);
//      Sistema.SetField('Pend_NParcelas',nparcelas);
      if p=nparcelas then
        valorparcela:=valortotal-acumulado  // para deixar na ultima parcelas "as d�zimas"
      else
        valorparcela:=FGeral.Arredonda(valortotal/nparcelas,2);
//      GridParcelas.cells[1,p]:=strspace(Transform(valorparcela,f_cr),10);
      GridParcelas.cells[1,p]:=Transform(valorparcela,f_cr);
      GridParcelas.RowCount:=GridParcelas.RowCount+1;
      acumulado:=acumulado+valorparcela;
    end;  // for do numero de parcelas
    Freeandnil(ListaPrazo);
  end;

  end;
end;

procedure TFAlteraPendencia.EdFpgt_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.LImpaedit(EdFpgt_codigo,key);
end;

procedure TFAlteraPendencia.EdTipocadValidate(Sender: TObject);
begin
  if EdCatEntidade.text='U' then begin
    EdCodEntidade.ShowForm:='FUnidades';
    EdCodEntidade.FindTable:='unidades';
    EdCodEntidade.FindField:='unid_codigo';
  end else if EdCatEntidade.text='C' then begin
    EdCodEntidade.ShowForm:='FCadcli';
    EdCodEntidade.FindTable:='clientes';
    EdCodEntidade.FindField:='clie_codigo';
  end else if EdCatEntidade.text='F' then begin
    EdCodEntidade.ShowForm:='FFornece';
    EdCodEntidade.FindTable:='fornecedores';
    EdCodEntidade.FindField:='forn_codigo';
  end else if EdCatEntidade.text='T' then  begin
    EdCodEntidade.ShowForm:='FTransp';
    EdCodEntidade.FindTable:='transportadores';
    EdCodEntidade.FindField:='tran_codigo';
  end else if EdCatEntidade.text='R' then begin
    EdCodEntidade.ShowForm:='FRepresentantes';
    EdCodEntidade.FindTable:='representantes';
    EdCodEntidade.FindField:='repr_codigo';
  end else begin
    EdCodEntidade.ShowForm:='';
    EdCodEntidade.FindTable:='';
    EdCodEntidade.FindField:='';
  end;

end;

procedure TFAlteraPendencia.EdVencimentoExitEdit(Sender: TObject);
begin
  bgravarclick(self);
end;

procedure TFAlteraPendencia.SetaPendencias(Ed: TSqled);
/////////////////////////////////////////////////////////////

   var Q:TSqlquery;
       sqlunidade,sqltipocodigo,codigo,sqlprevisao:string;

   begin

     if not Sistema.Getperiodo('Informe o periodo de vencimento') then exit;
     sqlunidade:=' and '+FGeral.GetIn('pend_unid_codigo',Global.Usuario.UnidadesMvto,'C');
     if Global.Usuario.OutrosAcessos[0711] then
       sqlunidade:=' and '+FGeral.GetIn('pend_unid_codigo',Global.CodigoUnidade,'C');
     if ( not EdCatEntidade.isempty) and ( not EdCodEntidade.isempty) then
//        sqltipocodigo:=' and pend_tipo_codigo='+EdCodentidade.AsSql+' and pend_tipocad='+EdCatEntidade.AsSql
// 03.11.17 - para encontrar devolucoes tbem
        sqltipocodigo:=' and pend_tipo_codigo='+EdCodentidade.AsSql
     else
        sqltipocodigo:='';
     if EdPrevisao.text='S' then
       sqlprevisao:=' and pend_status=''H'''
     else
       sqlprevisao:=' and pend_status=''N''';
     Sistema.beginprocess('pesquisando pendencias em aberto');
     Q:=sqltoquery('select * from pendencias where pend_datavcto>='+Datetosql(Sistema.Datai)+
                   ' and pend_datavcto<='+Datetosql(sistema.Dataf)+
                   sqltipocodigo+sqlprevisao+sqlunidade+
                   ' order by pend_rp,pend_datavcto' );
     if Q.eof then
       Aviso('N�o encontrado pendencias neste periodo de vencimento deste cliente/fornecedor');

     Ed.Items.Clear;
     while not Q.eof do begin
       Ed.Items.Add(copy(Q.fieldbyname('pend_operacao').asstring+space(12),1,12)+' - '+
                copy(Q.fieldbyname('pend_numerodcto').asstring+space(8),1,8)+' - '+
                copy(Q.fieldbyname('pend_rp').asstring+space(2),1,2)+' - '+
                FGeral.formatadata(Q.fieldbyname('pend_datavcto').asdatetime)+' - '+
                FGeral.formatavalor(Q.fieldbyname('pend_valor').ascurrency,f_cr)+' - '+
                FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('pend_tipo_codigo').asinteger,Q.fieldbyname('pend_tipocad').asstring,'R') );

       Q.next;
     end;
     FGeral.fechaquery(q);
     Sistema.endprocess('');

end;

procedure TFAlteraPendencia.EdPrevisaoValidate(Sender: TObject);
begin
   SetaPendencias(EdOperacao);
   if EdPrevisao.text='S' then
     bmudaprevisao.Enabled:=true
   else
     bmudaprevisao.Enabled:=false;

end;

procedure TFAlteraPendencia.bmudaprevisaoClick(Sender: TObject);
begin
  if not EdOperacao.Valid then exit;
  if not confirma('Mudar de previs�o para provis�o') then exit;
  Sistema.Edit('pendencias');
  Sistema.SetField('pend_status','N');
  Sistema.Post('pend_operacao='+Stringtosql(trim(EdOperacao.Text)));
  try
    sistema.commit;
    Aviso('Mudan�a gravada');
  except
    Aviso('Mudan�a N�o gravada.  Tente mais tarde');
  end;
  EdCatEntidade.setfocus;
end;

procedure TFAlteraPendencia.Edunid_codigoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
begin
  EdPort_codigo.SetFocus;

end;

end.

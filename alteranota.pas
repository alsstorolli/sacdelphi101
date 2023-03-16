unit alteranota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel, ExtCtrls,
  SQLGrid;

type
  TFAlteracaonotas = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bgravar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    PAcerto: TSQLPanelGrid;
    EdOperacao: TSQLEd;
    EdTipocad: TSQLEd;
    EdCodtipo: TSQLEd;
    SetEdFavorecido: TSQLEd;
    Edmuni_codigo: TSQLEd;
    EdMuniRes_Nome: TSQLEd;
    EdMuniRes_UF: TSQLEd;
    EdCidade: TSQLEd;
    SQLEd2: TSQLEd;
    Edufcidade: TSQLEd;
    EdValornota: TSQLEd;
    EdNUmeronota: TSQLEd;
    EdNatf_codigo: TSQLEd;
    EdNatf_descricao: TSQLEd;
    EdNatf_codigoant: TSQLEd;
    SetEdnatf_descricao: TSQLEd;
    EdSerie: TSQLEd;
    EdSerieant: TSQLEd;
    Edemissao: TSQLEd;
    EdEmissaoant: TSQLEd;
    EdNumeronovo: TSQLEd;
    EdContaDesrec: TSQLEd;
    SetEdplan_descricao: TSQLEd;
    EdContaDesrecant: TSQLEd;
    SQLEd3: TSQLEd;
    EdBaseicms: TSQLEd;
    EdBaseIcmsant: TSQLEd;
    EdValoricms: TSQLEd;
    EdValoricmsant: TSQLEd;
    EdBaseicmscheia: TSQLEd;
    EdBaseicmscheiaant: TSQLEd;
    EdReducaoicms: TSQLEd;
    EdReducaoicmsant: TSQLEd;
    EdTotalNota: TSQLEd;
    EdTotalNotaant: TSQLEd;
    EdComv_codigo: TSQLEd;
    EdComv_descricao: TSQLEd;
    EdComv_codigoant: TSQLEd;
    SQLEd4: TSQLEd;
    EdTran_codigoant: TSQLEd;
    SetEdtran_nome: TSQLEd;
    EdRepr_codigoant: TSQLEd;
    SetEdrepr_nome: TSQLEd;
    SetEdrepr_descricao: TSQLEd;
    EdRepr_codigo: TSQLEd;
    SetEdtran_descricao: TSQLEd;
    EdTran_codigo: TSQLEd;
    EdSaida: TSQLEd;
    Edsaidaant: TSQLEd;
    EdValoripi: TSQLEd;
    EdValoripiant: TSQLEd;
    EdTipo_codigo: TSQLEd;
    EdTipocodigodescricao: TSQLEd;
    EdTipo_codigoant: TSQLEd;
    EdNomecliforant: TSQLEd;
    brelauditoriafiscal: TSQLBtn;
    EdCodEqui: TSQLEd;
    SQLEd1: TSQLEd;
    EdCodEquiant: TSQLEd;
    SQLEd6: TSQLEd;
    EdSeto_codigo: TSQLEd;
    Eddesctipo: TSQLEd;
    EdSeto_codigoant: TSQLEd;
    SQLEd7: TSQLEd;
    PChave: TPanel;
    EdMoes_chavenfe: TSQLEd;
    EdMesano: TSQLEd;
    procedure EdTipocadValidate(Sender: TObject);
    procedure EdCodtipoValidate(Sender: TObject);
    procedure EdOperacaoExitEdit(Sender: TObject);
    procedure EdOperacaoValidate(Sender: TObject);
    procedure bgravarClick(Sender: TObject);
    procedure EdCidadeValidate(Sender: TObject);
    procedure Edmuni_codigoValdate(Sender: TObject);
    procedure EdemissaoValidate(Sender: TObject);
    procedure EdemissaoExitEdit(Sender: TObject);
    procedure EdReducaoicmsValidate(Sender: TObject);
    procedure EdTipo_codigoValidate(Sender: TObject);
    procedure EdTipo_codigoantValidate(Sender: TObject);
    procedure brelauditoriafiscalClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure SetaItensNotas( Edit:TSqled ; Codigo:integer ; Tipocad:string );

  end;

var
  FAlteracaonotas: TFAlteracaonotas;
  aliqicms:currency;

implementation

uses SqlFun , SqlExpr , Geral, Sqlsis, RelGerenciais ;

{$R *.dfm}

{ TFAlteracaonotas }

procedure TFAlteracaonotas.Execute;
////////////////////////////////////////
begin
   FGeral.ConfiguraColorEditsNaoEnabled(Falteracaonotas);
   Show;
   FGeral.SetaSeriesValidas(EdSerie);
   aliqicms:=0;
   EdTipocad.setfocus;
end;

procedure TFAlteracaonotas.EdTipocadValidate(Sender: TObject);
begin
  if EdTipocad.isempty then exit;
  if EdTipoCad.text='C' then begin
    EdCodtipo.ShowForm:='FCadcli';
    EdCodtipo.FindTable:='clientes';
    EdCodtipo.FindField:='clie_codigo';
    Edtipo_codigo.ShowForm:='FCadcli';
    Edtipo_codigo.FindTable:='clientes';
    Edtipo_codigo.FindField:='clie_codigo';
  end else if EdTipoCad.text='F' then begin
    EdCodtipo.ShowForm:='FFornece';
    EdCodtipo.FindTable:='fornecedores';
    EdCodtipo.FindField:='forn_codigo';
  end else begin
    EdCodtipo.ShowForm:='FCadcli';
    EdCodtipo.FindTable:='clientes';
    EdCodtipo.FindField:='clie_codigo';
  end;

end;

procedure TFAlteracaonotas.EdCodtipoValidate(Sender: TObject);
begin
  if EdCodtipo.isempty then exit;

  EdOPeracao.Clear;
  SetEdFavorecido.Text:=FGeral.getnomerazaosocialentidade(EdCodtipo.asinteger,EdTipoCad.text,'N');
  SetaItensNotas( EdOperacao,EdCodtipo.asinteger,EdTipocad.text );
  EdOPeracao.valid;

end;

procedure TFAlteracaonotas.SetaItensNotas(Edit: TSqled; Codigo: integer;  Tipocad: string);
/////////////////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    xdata     : TDateTime;
    sqldata,
    sqlmesano : string;
    ano,
    mes       : integer;

begin

// 13.11.19 - A2z - Thais
  sqldata:='';
  xdata  := Sistema.hoje-FGeral.GetConfig1AsInteger('Diasaltgerencialnf');
  if FGeral.GetConfig1AsInteger('Diasaltgerencialnf') > 0 then
     sqldata:=' and moes_dataemissao >= '+Datetosql(xdata);
// 11.08.2021
  sqlmesano := '';
  mes := strtointdef( copy(EdMesano.text,1,2), 0);
  ano := strtointdef( copy(EdMesano.text,4,4), 0);

  if (not EdMesano.isempty ) and ( mes>0 ) and ( ano > 0 ) then

     sqlmesano := ' and extract( year from moes_dataemissao ) = '+inttostr(ano)+
                  ' and extract( month from moes_dataemissao ) = '+inttostr(mes);


  Q:=Sqltoquery('select moes_numerodoc,moes_operacao,moes_datamvto from movesto'+
                ' where moes_tipocad='+stringtosql(Tipocad)+
                ' and moes_tipo_codigo='+inttostr(codigo)+
                ' and moes_status=''N'''+
                sqlmesano+
                sqldata+
//                ' and extract( year from moes_datamvto )>='+inttostr(Datetoano(sistema.hoje,true)-1)+
// 19.08.08
                ' and extract( year from moes_datamvto )>='+inttostr(Datetoano(sistema.hoje,true)-3)+
                ' and moes_unid_codigo='+stringtosql(Global.CodigoUnidade)+
//                ' and moes_datacont>1'+
// 21.09.11
                ' and moes_datacont > '+DatetoSql(Global.DataMenorBanco)+

//                ' order by moes_numerodoc' );
// 13.11.19
                ' order by moes_dataemissao desc' );
  Edit.Items.Clear;
  while not Q.eof do begin

    Edit.Items.add(strspace(Q.fieldbyname('moes_operacao').asstring,16)+' - '+strspace(Q.fieldbyname('moes_numerodoc').asstring,06)+' - '+FGeral.formatadata(Q.fieldbyname('moes_datamvto').asdatetime) );
    Q.Next;

  end;
  FGeral.Fechaquery(Q);

end;

procedure TFAlteracaonotas.EdOperacaoExitEdit(Sender: TObject);
///////////////////////////////////////////////////////////////////////
begin
   EdTipo_codigo.setfocus;

end;

procedure TFAlteracaonotas.EdOperacaoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////////
var Q,QP,QMOvb,QDetalhe:TSqlquery;
    quantos:integer;
    sqltipocodigo:string;

begin

   aliqicms:=0;
   EdBaseicms.enabled:=false;
   EdValoricms.enabled:=false;
   EdBaseicmscheia.enabled:=false;
   EdReducaoicms.enabled:=false;
   EdNatf_codigo.text:='';
   EdTotalNota.enabled:=false;
   EdComv_codigo.text:='';
   EdRepr_codigo.Text:='';
   EdTran_codigo.Text:='';
   EdTipo_codigo.Text:='';
   EdCodEqui.Text:='';
   EdSeto_codigo.text:='';
   sqltipocodigo:='';
   EdMoes_chavenfe.text := '';

   if not EdCodtipo.IsEmpty then
     Sqltipocodigo:=' and moes_tipo_codigo='+EdCodtipo.AsSql+' and moes_tipocad='+EdTipocad.assql;
// 16.11.09 - colocado config. de movimento devido as contas contabeis para
// exportacao...correo o risco de ficar uma config. de movimento com tipo de movimento
// diferente do q esta no cadastro da config. de movimento
   Q:=sqltoquery('select * from movesto where moes_operacao='+stringtosql(trim(EdOperacao.text))+
                 ' and moes_status<>''C'''+
                 sqltipocodigo );
   if not Q.eof then begin

     EdCidade.setvalue(Q.fieldbyname('moes_cida_codigo').asinteger);
     EdValornota.setvalue(Q.fieldbyname('moes_vlrtotal').ascurrency);
     EdNumeronota.SetValue(Q.fieldbyname('moes_numerodoc').AsInteger);
     EdNatf_codigoant.text:=Q.fieldbyname('moes_natf_codigo').AsString;
// 22.12.20
     EdSeto_codigoant.text:=Q.fieldbyname('moes_seto_codigo').AsString;
     EdSerieant.text:=Q.fieldbyname('moes_serie').AsString;
     EdEmissaoant.setdate(Q.fieldbyname('moes_dataemissao').AsDatetime);
     EdSaidaant.setdate(Q.fieldbyname('moes_datasaida').AsDatetime);
     EdNumeronovo.SetValue(Q.fieldbyname('moes_numerodoc').AsInteger);
// 10.08.2021
     EdMoes_chavenfe.text := Q.fieldbyname('moes_chavenfe').AsString;

// 03.09.08
     QP:=sqltoquery( FGeral.BuscaTransacao(Q.fieldbyname('moes_transacao').asstring,'pendencias','pend_transacao','pend_status','N;B','pend_datavcto') );
     if not QP.eof then
       EdContaDesrecant.SetValue(QP.fieldbyname('Pend_Plan_Conta').asinteger)
     else
       EdContaDesrecant.SetValue(0);
// 16.11.09
     EdComv_codigoant.setvalue(Q.fieldbyname('moes_comv_codigo').AsInteger);
// 09.12.10
     EdRepr_codigoant.SetValue(Q.fieldbyname('moes_repr_codigo').AsInteger);
     EdTran_codigoant.text:=Q.fieldbyname('moes_tran_codigo').AsString;
     EdTipo_codigoant.text:=Q.fieldbyname('moes_tipo_codigo').AsString;
// 08.07.18
     QDetalhe:=sqltoquery('select move_remessas from movestoque where move_transacao = '+
                          Stringtosql(Q.FieldByName('moes_transacao').AsString) );
     EdCodequiant.text:=copy(QDetalhe.fieldbyname('move_remessas').AsString,
                        AnsiPos(';',QDetalhe.fieldbyname('move_remessas').AsString)+1 , 4 );
     QDetalhe.Close;
     QDetalhe.Free;
// 01.08.11 - Capeg
     if EdCodtipo.IsEmpty then begin
       EdCodtipo.text:=Q.fieldbyname('moes_tipo_codigo').AsString;
       EdTipoCad.text:=Q.fieldbyname('moes_tipocad').AsString;
       SetEdFavorecido.Text:=FGeral.getnomerazaosocialentidade(EdCodtipo.asinteger,EdTipoCad.text,'N');
     end;
     FGeral.fechaquery(QP);
// 09.02.09
     QMOvb:=sqltoquery('select * from movbase where movb_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring)+
                       ' and movb_status<>''C''');
     quantos:=0;
     while not Qmovb.eof do begin
       inc(quantos);
       QMovb.Next;
     end;
     if quantos=1 then begin
       QMovb.First;
       EdBaseicms.enabled:=true;
       aliqicms:=QMovb.fieldbyname('movb_aliquota').ascurrency;
       EdValoricms.enabled:=true;
       EdBaseicmscheia.enabled:=true;
       EdTotalNota.enabled:=true;
       EdReducaoicms.enabled:=true;
       EdBaseicmsant.setvalue(Q.fieldbyname('moes_baseicms').ascurrency);
// 14.07.09
       EdTotalNotaant.setvalue(Q.fieldbyname('moes_vlrtotal').ascurrency);
       EdValoricmsant.setvalue(QMovb.fieldbyname('movb_imposto').ascurrency);
       EdBaseicmsCheiaAnt.setvalue(QMovb.fieldbyname('movb_basecalculo').Ascurrency);
       EdReducaoicms.SetValue(QMovb.fieldbyname('movb_reducaobc').Ascurrency);
       EdValoripiant.setvalue(Q.fieldbyname('moes_valoripi').ascurrency);
     end;
     FGeral.fechaquery(QMOvb);

   end else begin

     EdCidade.setvalue(0);
     EdNatf_codigoant.Text:='';
     EdSeto_codigoant.Text:='';
     EdSerieant.Text:='';
     EdEmissao.text:='';
     EdSaida.text:='';
     EdNUmeronovo.text:='';
     EdTipocad.setfocus;
     EdNatf_codigo.text:='';
     EdSeto_codigo.text:='';
     EdBaseicms.setvalue(0);
     EdValoricms.setvalue(0);
     EdBaseicmsCheia.setvalue(0);
     EdTotalNota.setvalue(0);
     EdReducaoicms.setvalue(0);
     EdContaDesRec.setvalue(0);
     EdComv_codigo.setvalue(0);
     EdComv_codigoant.setvalue(0);
// 09.12.10
     EdRepr_codigoant.SetValue(0);
     EdTran_codigoant.text:='';
     EdRepr_codigo.SetValue(0);
     EdTran_codigo.text:='';
     EdValoripi.setvalue(0);
     EdTipo_codigoant.SetValue(0);
     EdTipo_codigo.SetValue(0);
     EdCodequi.Text:='';
     EdCodequiant.Text:='';
     Avisoerro('Operação não encontrada');
     exit;
   end;

   if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 then
     EdNumeronovo.enabled:=true
   else
     EdNumeronovo.enabled:=false;
// 07.07.09
   if Global.Usuario.OutrosAcessos[0318] then
      EdNumeronovo.enabled:=true;

   EdCidade.validfind;
   EdCidade.valid;
   EdNatf_codigoant.Valid;
   EdSeto_codigoant.Valid;
   EdContaDEsrecant.ValidFind;
   EdComv_codigoant.ValidFind;
   EdRepr_codigoant.validfind;
   EdTran_codigoant.validfind;
   EdTipo_codigoant.valid;
   EdCodequiant.validfind;
   FGeral.FechaQuery(q);
end;

procedure TFAlteracaonotas.bgravarClick(Sender: TObject);
var Q,Qp:TSqlquery;

   function Entrada(stipomov:string):boolean;
   begin
     if pos(stipomov,Global.TiposEntrada)>0 then
       result:=true
     else
       result:=false;
// 07.07.09
     if Global.Usuario.OutrosAcessos[0318] then
       result:=true;
   end;

   function valida:boolean;
   ////////////////////////////
   var vlricms:currency;
   begin
     result:=true;
     if ( EdBaseicmscheia.Enabled ) and (EdBaseicmscheia.Ascurrency>0) then begin
       vlricms:=EdBaseIcmscheia.ascurrency*(aliqicms/100);
       if EdBaseIcms.ascurrency>0 then
         vlricms:= EdBaseIcms.ascurrency* (aliqicms/100);
       result:=roundvalor(vlricms)=EdValoricms.ascurrency;
       if not result then
         Avisoerro('Icms calculado '+floattostr(vlricms));
     end;
   end;

/////////////////////////////////////////////
begin
/////////////////////////////////////////////
  if EdOperacao.isempty then exit;
  if not Valida then exit;
//  if EdMuni_codigo.isempty then exit;
  if not confirma('Confirma alteração ?') then exit;
  Q:=sqltoquery('select moes_transacao,moes_tipomov from movesto where moes_operacao='+stringtosql(trim(EdOperacao.text)));
  if Q.eof then begin
    Avisoerro('Operação não encontrada');
    exit;
  end;
  Sistema.beginprocess('gravando');
  Sistema.edit('movesto');
  if not EdMuni_codigo.isempty then begin
    Sistema.Setfield('moes_cida_codigo',EdMuni_codigo.asinteger);
    Sistema.Setfield('moes_estado',EdMuni_codigo.resultfind.fieldbyname('cida_uf').asstring);
  end;
// 03.12.07
  if not EdSerie.isempty then
    Sistema.Setfield('moes_serie',EdSerie.text);
  if not EdNatf_codigo.isempty then
    Sistema.Setfield('moes_natf_codigo',EdNatf_codigo.text);
// 22.12.20
  if not EdSeto_codigo.isempty then
    Sistema.Setfield('moes_seto_codigo',EdSeto_codigo.text);
// 08.02.08
    if not EdEmissao.isempty then
      Sistema.Setfield('moes_dataemissao',EdEmissao.asdate);
// 01.08.11
    if not EdSaida.isempty then
      Sistema.Setfield('moes_datasaida',EdSaida.asdate);
// 06.06.08
    if (EdNUmeronota.text<>EdNUmeronovo.text) and (Entrada(Q.fieldbyname('moes_tipomov').asstring)) then
      Sistema.Setfield('moes_numerodoc',EdNUmeronovo.asinteger);
// 16.11.09
  if EdComv_codigo.AsInteger>0 then
    Sistema.Setfield('moes_comv_codigo',EdComv_codigo.AsInteger);
// 17.12.09 - Abra
  if (EdContaDesrec.text<>EdContaDesrecant.text) and (EdContaDesrec.asinteger>0) and (Entrada(Q.fieldbyname('moes_tipomov').asstring)) then begin
    campo:=Sistema.GetDicionario('movesto','moes_plan_codigo');
    if campo.Tipo<>''  then
      Sistema.Setfield('moes_plan_codigo',EdContaDesrec.asinteger);
  end;
////////////
// 09.12.10 - Clessi + Novicarnes
  if (EdTran_codigo.text<>EdTran_codigoant.text) and (EdTran_codigo.asinteger>0) then
     Sistema.Setfield('moes_tran_codigo',EdTran_codigo.text);
  if (EdRepr_codigo.text<>EdRepr_codigoant.text) and (EdRepr_codigo.asinteger>0) then
      Sistema.Setfield('moes_repr_codigo',EdRepr_codigo.asinteger);
// 11.02.13 - Capeg
  if (EdTipo_codigo.text<>EdTipo_codigoant.text) and (EdTipo_codigo.asinteger>0) then
      Sistema.Setfield('moes_tipo_codigo',EdTipo_codigo.asinteger);
////////////
// 10.08.2021 - Clessi - sped sem as chaves das nfe de entrada
  if not EdMoes_chavenfe.empty then

      Sistema.Setfield('moes_chavenfe',EdMoes_chavenfe.text);

  Sistema.post('moes_operacao='+stringtosql(trim(EdOperacao.text)));

// 09.12.10 - Clessi
  if (EdRepr_codigo.text<>EdRepr_codigoant.text) and (EdRepr_codigo.asinteger>0) then begin
    Sistema.edit('movestoque');
    Sistema.Setfield('move_repr_codigo',EdRepr_codigo.asinteger);
    Sistema.post('move_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring));
  end;
// 11.02.13 - Capeg
  if (EdTipo_codigo.text<>EdTipo_codigoant.text) and (EdTipo_codigo.asinteger>0) then begin
    Sistema.edit('movestoque');
    Sistema.Setfield('move_tipo_codigo',EdTipo_codigo.asinteger);
    Sistema.post('move_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring));
  end;

// 13.11.07 - depois ver como tratar nota com mais de um cfop...
  if not EdNatf_codigo.isempty then begin
    Sistema.edit('movbase');
    Sistema.Setfield('movb_natf_codigo',EdNatf_codigo.text);
    Sistema.post('movb_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring));
  end;
// 06.06.08
  if (EdNUmeronota.text<>EdNUmeronovo.text) and (not EdNUmeronovo.isempty) and (Entrada(Q.fieldbyname('moes_tipomov').asstring)) then begin
    Sistema.edit('movbase');
    Sistema.Setfield('movb_numerodoc',EdNUmeronovo.asinteger);
    Sistema.post('movb_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring));
  end;
// 06.06.08 - erros de digitação de numeros no lançamentos das entradas - novicarnes - elize vanessa corrigindo
  if (EdNUmeronota.text<>EdNUmeronovo.text) and (not EdNUmeronovo.isempty) and (Entrada(Q.fieldbyname('moes_tipomov').asstring)) then begin
    Sistema.edit('movestoque');
    Sistema.Setfield('move_numerodoc',EdNUmeronovo.asinteger);
    Sistema.post('move_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring));
    Sistema.edit('pendencias');
    Sistema.Setfield('pend_numerodcto',EdNUmeronovo.text);
    Sistema.post('pend_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring));
    Qp:=sqltoquery('select pend_transbaixa from pendencias where pend_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring)+
                   ' and pend_status<>''C''' );
    if not QP.eof then begin
      if trim(QP.fieldbyname('pend_transbaixa').asstring)<>'' then begin
        Sistema.Edit('movfin');
        Sistema.SetField('movf_numerodcto',EdNUmeronovo.text);
        Sistema.post('movf_transacao='+stringtosql(QP.fieldbyname('pend_transbaixa').asstring));
      end;
    end;
    FGeral.FechaQuery(Qp);
  end;
// 08.07.18
////////////////////////////
  if (EdTipo_codigo.text<>EdTipo_codigoant.text) and (EdTipo_codigo.asinteger>0) then begin
    Sistema.edit('pendencias');
    Sistema.Setfield('pend_tipo_codigo',EdTipo_codigo.asinteger);
    Sistema.post('pend_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring));
  end;
  if (EdCodequi.text<>EdCodequiant.text) and (not EdCodequi.isempty) then begin
    Sistema.edit('movestoque');
    Sistema.Setfield('move_remessas',EdcodEqui.text);
    Sistema.post('move_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring));
  end;
////////////////////////////
// 11.02.13 - Capeg
  if (EdContaDesrec.text<>EdContaDesrecant.text) and (EdContaDesrec.asinteger>0) and (Entrada(Q.fieldbyname('moes_tipomov').asstring)) then begin
    Sistema.edit('pendencias');
    Sistema.Setfield('Pend_Plan_Conta',EdContaDesrec.asinteger);
    Sistema.post('pend_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring));
  end;
////////////////
// 09.02.09
  if (EdValoricms.ascurrency<>EdValoricmsant.ascurrency) and (EdValoricms.ascurrency>0) and (EdValoricms.enabled) then begin
    Sistema.edit('movesto');
    Sistema.Setfield('moes_valoricms',EdValoricms.Ascurrency);
    Sistema.post('moes_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring)+
                 ' and moes_tipomov='+stringtosql(Q.fieldbyname('moes_tipomov').asstring)+
                 ' and moes_status<>''C''');
    Sistema.edit('movbase');
    Sistema.Setfield('movb_imposto',EdValoricms.Ascurrency);
    Sistema.post('movb_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring)+
                 ' and movb_tpimposto=''I'' and movb_status<>''C''');
  end;
  if (EdBaseicms.ascurrency<>EdBaseicmsant.ascurrency) and (EdBaseicms.ascurrency>0)
     and (EdBaseicms.enabled) then begin
    Sistema.edit('movesto');
    Sistema.Setfield('moes_baseicms',Edbaseicms.Ascurrency);
    Sistema.post('moes_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring)+
                 ' and moes_tipomov='+stringtosql(Q.fieldbyname('moes_tipomov').asstring)+
                 ' and moes_status<>''C''');

    Sistema.edit('movbase');
    Sistema.Setfield('movb_reducaobc',EdReducaoicms.Ascurrency);
    Sistema.post('movb_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring)+
                 ' and movb_tpimposto=''I''and movb_status<>''C''');
  end;
////////////20.08.09
  if (EdBaseicmsCheia.ascurrency<>EdBaseicmsCheiaant.ascurrency) and (EdBaseicmsCheia.ascurrency>0)
     and (EdBaseicmsCheia.enabled) then begin
    Sistema.edit('movbase');
    Sistema.Setfield('movb_basecalculo',EdBaseicmsCheia.Ascurrency);
    Sistema.post('movb_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring)+
                 ' and movb_tpimposto=''I''and movb_status<>''C''');
  end;
/////////////// - 14.07.09
  if (EdTotalNota.ascurrency<>EdTotalNotaant.ascurrency) and (EdTotalNota.ascurrency>0)  and (EdTotalNota.enabled) then begin
    Sistema.edit('movesto');
    Sistema.Setfield('moes_vlrtotal',EdTotalNota.Ascurrency);
    Sistema.post('moes_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring)+
                 ' and moes_tipomov='+stringtosql(Q.fieldbyname('moes_tipomov').asstring)+
                 ' and moes_status<>''C''');
  end;
///////////////
/////////////// - 25.09.11
  if (EdValoripi.ascurrency<>EdValoripiant.ascurrency) and (EdValoripi.ascurrency>0)  and (EdValoripi.enabled) then begin
    Sistema.edit('movesto');
    Sistema.Setfield('moes_valoripi',EdValoripi.Ascurrency);
    Sistema.post('moes_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring)+
                 ' and moes_tipomov='+stringtosql(Q.fieldbyname('moes_tipomov').asstring)+
                 ' and moes_status<>''C''');
  end;
///////////////
  FGeral.GravaLog(19,'NF '+EdNumeronota.Text+' '+SetEdFavorecido.text+' Cid.atual '+EdMuni_codigo.text+' Cid. ant. '+EdCidade.text+' Cfop atual '+EdNatf_codigo.text+' Cfop ant. '+EdNatf_codigoant.text,false);
  Sistema.commit;

  Sistema.endprocess('');
  FGeral.FechaQuery(Q);
  Edtipocad.clearall(FAlteracaonotas,99);
// 08.02.10
  EdMuni_codigo.ClearAll(FAlteracaonotas,99);
  EdBaseicms.enabled:=false;
  EdValoricms.enabled:=false;
  EdTipocad.setfocus;
end;

procedure TFAlteracaonotas.EdCidadeValidate(Sender: TObject);
begin
//  if not Edcidade.Empty then
// 26.05.08 - se estava com '0'0 considerava nao vazio
  if Edcidade.AsInteger>0 then
    EdUfcidade.text:=EdCidade.resultfind.fieldbyname('cida_uf').AsString
end;

procedure TFAlteracaonotas.Edmuni_codigoValdate(Sender: TObject);
begin
//  if not EdMuni_codigo.Empty then
// 26.05.08
  if EdMuni_codigo.Resultfind<>nil then
    EdMunires_uf.text:=EdMuni_codigo.resultfind.fieldbyname('cida_uf').AsString

end;

procedure TFAlteracaonotas.EdemissaoValidate(Sender: TObject);
begin
  if not EdEmissao.isempty then
    if not FGeral.ValidaMvto(EdEmissao) then
      EdEmissao.invalid('');
end;

procedure TFAlteracaonotas.EdemissaoExitEdit(Sender: TObject);
begin
  bgravarclick(self);
end;

procedure TFAlteracaonotas.EdReducaoicmsValidate(Sender: TObject);
begin
   if (EdBaseicmscheia.ascurrency>0) and (EdReducaoicms.ascurrency>0) then
     EdBaseicms.setvalue( EdBaseicmscheia.ascurrency*(EdReducaoicms.ascurrency/100) );
end;

procedure TFAlteracaonotas.EdTipo_codigoValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////////
begin
  if not EdTipo_codigo.Isempty then
    EdTipocodigodescricao.text:=FGeral.GetNomeRazaoSocialEntidade(EdTipo_codigo.asinteger,EdTipoCad.text,'R')

end;

procedure TFAlteracaonotas.EdTipo_codigoantValidate(Sender: TObject);
begin
  if not EdTipo_codigoant.Isempty then
    EdNomecliforant.text:=FGeral.GetNomeRazaoSocialEntidade(EdTipo_codigoant.asinteger,EdTipoCad.text,'R')

end;

procedure TFAlteracaonotas.brelauditoriafiscalClick(Sender: TObject);
begin
    if not Sistema.Processando then FRelGerenciais_AuditoriaFiscal;

end;

end.

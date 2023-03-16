unit regnaoconf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, ComCtrls, SqlExpr ;

type
  TFRegNaoConformidade = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bIncluir: TSQLBtn;
    bSair: TSQLBtn;
    bCancelar: TSQLBtn;
    bExcluir: TSQLBtn;
    bimpressao: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PAcerto: TSQLPanelGrid;
    EdData: TSQLEd;
    EdSetor_codigo: TSQLEd;
    Eddesctipo: TSQLEd;
    Edrespcodigo: TSQLEd;
    SetEdusua_descricao: TSQLEd;
    Ednumerornc: TSQLEd;
    PgControle: TPageControl;
    PgInicial: TTabSheet;
    PgProdutos: TTabSheet;
    PInicial: TSQLPanelGrid;
    Edintext: TSQLEd;
    Ednfpedido: TSQLEd;
    Edprodprocdoc: TSQLEd;
    Edtipo: TSQLEd;
    Edespecie: TSQLEd;
    Edorigem: TSQLEd;
    EdDescricaonc: TSQLEd;
    Edresultadoesperado: TSQLEd;
    Edaprovacao: TSQLEd;
    PProdutos: TSQLPanelGrid;
    Edinspetor: TSQLEd;
    Edanacritica: TSQLEd;
    Edop: TSQLEd;
    edreinspecionar: TSQLEd;
    Edrespanalise: TSQLEd;
    Label3: TLabel;
    Edlaudoreinsp: TSQLEd;
    EdDatareinsp: TSQLEd;
    bplanos: TSQLBtn;
    EdMrnc_Usua_Reinsp: TSQLEd;
    SQLEd2: TSQLEd;
    EdMrnc_DispFinal: TSQLEd;
    EdMrnc_Usua_dispfinal: TSQLEd;
    SQLEd3: TSQLEd;
    EdMrnc_Comunicara: TSQLEd;
    EdMrnc_Seto_Ocorre: TSQLEd;
    SQLEd6: TSQLEd;
    PCausas: TSQLPanelGrid;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    MMetodo: TMemo;
    MMateriaPrima: TMemo;
    MMaodeObra: TMemo;
    MMaquina: TMemo;
    MMeioAmbiente: TMemo;
    MMedida: TMemo;
    bcausas: TSQLBtn;
    bgravacausas: TSQLBtn;
    pconsenso: TSQLPanelGrid;
    Edmrnc_eficacia: TSQLEd;
    Edmrnc_usua_consemit: TSQLEd;
    SQLEd4: TSQLEd;
    Edmrnc_dtconsenso: TSQLEd;
    Edmrnc_usua_eficacia: TSQLEd;
    SQLEd5: TSQLEd;
    Edmrnc_dtencerra: TSQLEd;
    Edmrnc_custoaprox: TSQLEd;
    Edmrnc_obs: TSQLEd;
    bconsenso: TSQLBtn;
    bgravaconsenso: TSQLBtn;
    bprodutos: TSQLBtn;
    bgravaprodutos: TSQLBtn;
    Edresalcancado: TSQLEd;
    Edmrnc_usua_produto: TSQLEd;
    SQLEd7: TSQLEd;
    procedure EdrespcodigoExitEdit(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure EdaprovacaoValidate(Sender: TObject);
    procedure EdnumerorncValidate(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure bbaixarClick(Sender: TObject);
    procedure bplanosClick(Sender: TObject);
    procedure EdSetor_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure bcausasClick(Sender: TObject);
    procedure bgravacausasClick(Sender: TObject);
    procedure bconsensoClick(Sender: TObject);
    procedure bgravaconsensoClick(Sender: TObject);
    procedure Edmrnc_dtconsensoValidate(Sender: TObject);
    procedure Edmrnc_obsExitEdit(Sender: TObject);
    procedure bprodutosClick(Sender: TObject);
    procedure EdresultadoesperadoExitEdit(Sender: TObject);
    procedure EdMrnc_Usua_dispfinalExitEdit(Sender: TObject);
    procedure bgravaprodutosClick(Sender: TObject);
    procedure Edmrnc_usua_produtoValidate(Sender: TObject);
    procedure EdespecieValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(xOP:string='I';xnumerornc:integer=0);
    procedure SetaEspecie(Edit:TSqlEd);
    procedure LimpaMemos;
    function GetSqlRcn(Numero:integer;Unidade:string):string;
    procedure QuerytoCampos(Q:TSqlquery);
    procedure Gravacampos;
    procedure SetaAnaliseCritica(Edit:TSqlEd);
    procedure SetaLaudoReinspecao(Edit:TSqlEd);
    procedure SetaEficacia(Edit:TSqlEd);
    function GravaMemo(s:TMemo):string;

  end;

var
  FRegNaoConformidade: TFRegNaoConformidade;
  OP:string;
  NumeroRnc:integer;

const MaximoItens:integer=7;

implementation

uses Geral, SqlSis, SqlFun , ataspacao, Usuarios;

{$R *.dfm}

{ TFRegNaoConformidade }

procedure TFRegNaoConformidade.Execute(xOP:string='I';xnumerornc:integer=0);
begin
   SetaEspecie(EdEspecie);
   SetaAnaliseCritica(EdAnaCritica);
   SetaLaudoReinspecao(EdLaudoreinsp);
   SetaEficacia(EdMrnc_eficacia);
   EdData.setdate(Sistema.hoje);
   OP:=xOP;
   PgControle.Enabled:=false;
   PConsenso.Enabled:=False;
   PgProdutos.Enabled:=false;
   Show;
   bcausas.enabled:=OP='C';
   bgravacausas.enabled:=OP='C';
   bplanos.enabled:=OP='P';
   bconsenso.enabled:=OP='E';
   bgravaconsenso.enabled:=OP='E';
   bprodutos.enabled:=OP='D';
   bgravaprodutos.enabled:=OP='D';
   FRegNaoConformidade.PgControle.ActivePage:=PgInicial;
// 03.11.08 - somente usuarios com acesso a produto nao conforme
   if not Global.Usuario.OutrosAcessos[0404] then begin
     bprodutos.enabled:=false;
     bgravaprodutos.enabled:=false;
   end;
   NumeroRnc:=xnumerornc;
   Ednumerornc.ClearAll(FRegNaoConformidade,99);
   EdMrnc_Seto_Ocorre.ClearAll(FRegNaoConformidade,99);
   Edmrnc_usua_consemit.ClearAll(FRegNaoConformidade,99);
   Edresalcancado.ClearAll(FRegNaoConformidade,99);
   if EdData.isempty then EdData.SetDate(sistema.hoje);
   LimpaMemos;
   if OP='I' then begin
     EdNumerornc.enabled:=false;
     EdData.setfocus;
     bincluir.enabled:=true;
     bexcluir.enabled:=false;
     PgControle.Enabled:=false;
   end else begin
     EdNumerornc.enabled:=true;
     if Numerornc>0 then begin
       EdNumerornc.setvalue(Numerornc);
       EdNumerornc.valid;
     end else
       EdNumerornc.setfocus;
     FRegNaoConformidade.bincluir.enabled:=false;
     FRegNaoConformidade.PgControle.Enabled:=true;
   end;
   if pos(OP,'C;P;E;D')>0 then begin
     FRegNaoConformidade.bincluir.enabled:=false;
     FRegNaoConformidade.bexcluir.enabled:=false;
     if OP='C' then
       FRegNaoConformidade.bcausasclick(self)
     else if OP='P' then
       FRegNaoConformidade.bplanosClick(self)
     else if OP='E' then
       FRegNaoConformidade.bconsensoClick(self)
     else if OP='D' then
       FRegNaoConformidade.bprodutosClick(self)
//     else if OP='L' then
//       FRegNaoConformidade.bresalcancadoClick(self)
   end;
end;

procedure TFRegNaoConformidade.SetaEspecie(Edit: TSqlEd);
begin
   Edit.Items.Clear;
   Edit.Items.Add('1 - NC de Processo');
   Edit.Items.Add('2 - NC de Produto');
   Edit.Items.Add('3 - NC do SQB');
end;


procedure TFRegNaoConformidade.EdrespcodigoExitEdit(Sender: TObject);
begin
//  EdMrnc_Seto_Ocorre.setfocus;
  if OP='I' then
    bincluirclick(self);
end;


procedure TFRegNaoConformidade.GravaCampos;


begin
      Sistema.Setfield('mrnc_seto_codigo',EdSetor_codigo.text);
//      Sistema.Setfield('mrnc_fornlocal',EdFornlocal.text);
      Sistema.Setfield('Mrnc_Seto_Ocorre',EdMrnc_Seto_Ocorre.text);
      Sistema.Setfield('mrnc_intext',EdIntext.text);
      Sistema.Setfield('mrnc_numerodoc',EdNfPedido.asinteger);
      Sistema.Setfield('mrnc_prodprocdoc',Edprodprocdoc.text);
      Sistema.Setfield('mrnc_tipo',EdTipo.text);
      Sistema.Setfield('mrnc_especie',EdEspecie.text);
      Sistema.Setfield('mrnc_origem',EdOrigem.text);
      Sistema.Setfield('mrnc_descricao',EdDescricaonc.text);
      Sistema.Setfield('mrnc_resultado',Edresultadoesperado.text);
//  serão gravado 'na sequencia'...
//      Sistema.Setfield('mrnc_aprovada',EdAprovacao.text);
//      Sistema.Setfield('mrnc_dtapucausa',Eddataacausa.asdate);
//      Sistema.Setfield('mrnc_metodo',GravaMemo(MMetodo));
//      Sistema.Setfield('mrnc_maquina',GravaMemo(MMaquina));
//      Sistema.Setfield('mrnc_matprima',GravaMemo(MMateriaprima));
//      Sistema.Setfield('mrnc_meioambiente',GravaMemo(MMeioambiente));
//      Sistema.Setfield('mrnc_maoobra',GravaMemo(MMaodeObra));

      Sistema.Setfield('mrnc_medida',GravaMemo(MMedida));
//      Sistema.Setfield('mrnc_efeito',EdEfeito.text);
//      Sistema.Setfield('mrnc_dtverifacao',Eddataveracoes.asdate);
      Sistema.Setfield('mrnc_resalcancado',Edresalcancado.text);
      Sistema.Setfield('mrnc_inspetor',EdInspetor.text);
      Sistema.Setfield('mrnc_op',EdOP.text);
      Sistema.Setfield('mrnc_analcritica',Edanacritica.text);
      Sistema.Setfield('mrnc_reinsplotes',edreinspecionar.text);
      Sistema.Setfield('mrnc_reanalcritica',Edrespanalise.text);
      Sistema.Setfield('mrnc_laudoreinsp',Edlaudoreinsp.text);
      Sistema.Setfield('mrnc_dtreinsp',EdDatareinsp.asdate);
      Sistema.Setfield('Mrnc_Usua_Reinsp',EdMrnc_Usua_Reinsp.AsInteger);
      Sistema.Setfield('Mrnc_DispFinal',EdMrnc_DispFinal.text);
      Sistema.Setfield('Mrnc_Usua_dispfinal',EdMrnc_Usua_dispfinal.asinteger);
      Sistema.Setfield('Mrnc_Comunicara',EdMrnc_Comunicara.Text);
// 21.11.08
      Sistema.Setfield('Mrnc_usua_produto',Edmrnc_usua_produto.asinteger);
//      Sistema.Setfield('Mrnc_PrevEncerra',EdMrnc_PrevEncerra.AsDate);
//      Sistema.Setfield('mrnc_eficacia',Edmrnc_eficacia.text);
//      Sistema.Setfield('mrnc_usua_consemit',Edmrnc_usua_consemit.asinteger);
//      Sistema.Setfield('mrnc_dtconsenso',Edmrnc_dtconsenso.asdate);
//      Sistema.Setfield('mrnc_usua_eficacia',Edmrnc_usua_eficacia.asinteger);
//      Sistema.Setfield('mrnc_dtencerra',Edmrnc_dtencerra.AsDate);
//      Sistema.Setfield('mrnc_custoaprox',Edmrnc_custoaprox.asfloat);
//      Sistema.Setfield('mrnc_obs',Edmrnc_obs.text);
end;

procedure TFRegNaoConformidade.bIncluirClick(Sender: TObject);
begin
   PgControle.Enabled:=true;
   PgControle.ActivePage:=PgInicial;
   LimpaMemos;
   EdMrnc_Seto_Ocorre.setfocus;

end;

procedure TFRegNaoConformidade.bExcluirClick(Sender: TObject);
begin
   if EdNumerornc.IsEmpty then exit;
   if not confirma('Confirma exclusão desta RNC e TODOS os seus planos de ação ?') then exit;
   Sistema.Edit('movrnc');
   Sistema.Setfield('mrnc_status','C');
   Sistema.Setfield('mrnc_usua_exclusao',Global.Usuario.codigo);
   Sistema.post('mrnc_numerornc='+EdNumerornc.assql+'and mrnc_unid_codigo='+stringtosql(Global.codigounidade)+
                ' and mrnc_status=''N''');
   Sistema.Edit('planoacao');
   Sistema.Setfield('paca_status','C');
   Sistema.post('paca_mrnc_numerornc='+EdNumerornc.assql+'and paca_unid_codigo='+stringtosql(Global.codigounidade));
   try
     sistema.commit;
   except
     Avisoerro('');
   end;
end;

procedure TFRegNaoConformidade.LimpaMemos;
begin
  MMetodo.Lines.Clear;
  MMateriaPrima.Lines.Clear;
  MMaodeObra.Lines.Clear;
  MMeioAmbiente.Lines.Clear;
  MMedida.Lines.Clear;
  MMaquina.Lines.Clear;
end;

procedure TFRegNaoConformidade.EdaprovacaoValidate(Sender: TObject);
begin
   mmetodo.setfocus;
end;

procedure TFRegNaoConformidade.EdnumerorncValidate(Sender: TObject);
var Q:TSqlquery;
begin
   Q:=Sqltoquery(GetSqlRcn(EdNumerornc.asinteger,Global.codigounidade));
   if Q.eof then
     EdNumerornc.invalid('RNC '+EdNumerornc.text+' não encontrada na unidade '+Global.codigounidade)
   else
     QuerytoCampos(Q);
   FGeral.Fechaquery(Q);
end;

function TFRegNaoConformidade.GetSqlRcn(Numero: integer ; unidade:string): string;
begin
   result:='select * from movrnc where mrnc_numerornc='+inttostr(numero)+' and mrnc_unid_codigo='+stringtosql(unidade);
end;

procedure TFRegNaoConformidade.QuerytoCampos(Q: TSqlquery);

    procedure RestauraMemo(M:TMemo ; campo:string);
    var Lista:TStringlist;
        p:integer;
    begin
      M.Lines.Clear;
      if trim(campo)='' then exit;
      Lista:=TStringlist.Create;
      strtolista(Lista,campo,';',true);
      for p:=0 to Lista.count-1 do begin
        if trim(Lista[p])<>'' then
          M.Lines.Add(Lista[p]);
      end;
      M.SelStart := Perform(EM_LINEINDEX, 0, 0);
    end;

begin
   EdData.SetDate(Q.fieldbyname('mrnc_data').asdatetime);
   EdSetor_codigo.text:=Q.fieldbyname('mrnc_seto_codigo').asstring;
   EdRespcodigo.text:=Q.fieldbyname('mrnc_usua_resp').asstring;
//   EdFornlocal.Text:=Q.fieldbyname('mrnc_fornlocal').asstring;
   EdMrnc_Seto_Ocorre.Text:=Q.fieldbyname('Mrnc_Seto_Ocorre').asstring;
   EdIntExt.text:=Q.fieldbyname('mrnc_intext').asstring;
   EdNfPedido.text:=Q.fieldbyname('mrnc_numerodoc').asstring;
   Edprodprocdoc.text:=Q.fieldbyname('mrnc_prodprocdoc').asstring;
   EdTipo.text:=Q.fieldbyname('mrnc_tipo').asstring;
   EdEspecie.text:=Q.fieldbyname('mrnc_especie').asstring;
   EdOrigem.text:=Q.fieldbyname('mrnc_origem').asstring;
   EdDescricaonc.text:=Q.fieldbyname('mrnc_descricao').asstring;
   Edresultadoesperado.text:=Q.fieldbyname('mrnc_resultado').asstring;
   Edaprovacao.text:=Q.fieldbyname('mrnc_aprovada').asstring;
//   Eddataacausa.setdate(Q.fieldbyname('mrnc_dtapucausa').asdatetime);
//   EdEfeito.text:=Q.fieldbyname('mrnc_efeito').asstring;
//   Eddataveracoes.setdate(Q.fieldbyname('mrnc_dtverifacao').asdatetime);
   Edresalcancado.text:=Q.fieldbyname('mrnc_resalcancado').asstring;
   Edinspetor.text:=Q.fieldbyname('mrnc_inspetor').asstring;
   Edop.text:=Q.fieldbyname('mrnc_op').asstring;
   Edanacritica.text:=Q.fieldbyname('mrnc_analcritica').asstring;
   Edreinspecionar.text:=Q.fieldbyname('mrnc_reinsplotes').asstring;
   Edrespanalise.text:=Q.fieldbyname('mrnc_reanalcritica').asstring;
   Edlaudoreinsp.text:=Q.fieldbyname('mrnc_laudoreinsp').asstring;
   EdDatareinsp.setdate(Q.fieldbyname('mrnc_dtreinsp').asdatetime);
   RestauraMemo(MMetodo,Q.fieldbyname('mrnc_metodo').asstring);
   RestauraMemo(MMaquina,Q.fieldbyname('mrnc_maquina').asstring);
   RestauraMemo(MMateriaprima,Q.fieldbyname('mrnc_matprima').asstring);
   RestauraMemo(MMeioambiente,Q.fieldbyname('mrnc_meioambiente').asstring);
   RestauraMemo(MMaodeobra,Q.fieldbyname('mrnc_maoobra').asstring);
   RestauraMemo(MMedida,Q.fieldbyname('mrnc_medida').asstring);
   EdMrnc_Usua_Reinsp.text:=Q.fieldbyname('Mrnc_Usua_Reinsp').AsString;
   EdMrnc_DispFinal.text:=Q.fieldbyname('Mrnc_DispFinal').asstring;
   EdMrnc_Usua_dispfinal.text:=Q.fieldbyname('Mrnc_Usua_dispfinal').AsString;
   EdMrnc_Comunicara.Text:=Q.fieldbyname('Mrnc_Comunicara').AsString;
//   EdMrnc_PrevEncerra.setDate(Q.fieldbyname('Mrnc_PrevEncerra').asdatetime);
   Edmrnc_eficacia.text:=Q.fieldbyname('mrnc_eficacia').asstring;
   Edmrnc_usua_consemit.text:=Q.fieldbyname('mrnc_usua_consemit').AsString;
   Edmrnc_dtconsenso.setdate(Q.fieldbyname('mrnc_dtconsenso').asdatetime);
   Edmrnc_usua_eficacia.text:=Q.fieldbyname('mrnc_usua_eficacia').Asstring;
   Edmrnc_dtencerra.setDate(Q.fieldbyname('mrnc_dtencerra').asdatetime);
   Edmrnc_custoaprox.setvalue(Q.fieldbyname('mrnc_custoaprox').ascurrency);
   Edmrnc_obs.text:=Q.fieldbyname('mrnc_obs').asstring;

{
  mrnc_unid_codigo varchar(3),
  mrnc_status varchar(1),
  mrnc_situacao varchar(1),

}

end;

procedure TFRegNaoConformidade.bCancelarClick(Sender: TObject);
begin
   PCausas.Enabled:=true;
   if OP='I' then
     EdData.setfocus
   else
     EdNumerornc.SetFocus;

end;

procedure TFRegNaoConformidade.bbaixarClick(Sender: TObject);
begin
// tera q checar se todo o plano de acao esta ja 'encerrado' senao nao deixa
end;


procedure TFRegNaoConformidade.bplanosClick(Sender: TObject);
begin
  if pos(OP,'A;P')>0 then
    FAtaplanoacao.Execute(OP,EdNumerornc.asinteger,EdDescricaonc.text);

end;

procedure TFRegNaoConformidade.SetaAnaliseCritica(Edit: TSqlEd);
begin
   Edit.Items.Clear;
   Edit.Items.Add('1 - Devolver');
   Edit.Items.Add('2 - Aceitar');
   Edit.Items.Add('3 - Reclassificar');
   Edit.Items.Add('4 - Retrabalhar');
   Edit.Items.Add('5 - Rejeitar/Sucatear');

end;

procedure TFRegNaoConformidade.SetaLaudoReinspecao(Edit: TSqlEd);
begin
   Edit.Items.Clear;
   Edit.Items.Add('1 - Aceitar');
   Edit.Items.Add('2 - Rejeitar/Sucatear');

end;

procedure TFRegNaoConformidade.SetaEficacia(Edit: TSqlEd);
begin
   Edit.Items.Clear;
   Edit.Items.Add('1 - Ação Eficaz - Encerrar RNC');
   Edit.Items.Add('2 - Encerrar RNC e propor ações para efeitos colaterais');

end;

procedure TFRegNaoConformidade.EdSetor_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
   FGeral.LimpaEdit(EdSetor_codigo,key);
end;

procedure TFRegNaoConformidade.bcausasClick(Sender: TObject);
begin
   PCausas.Enabled:=true;
   MMetodo.SetFocus;
end;

procedure TFRegNaoConformidade.bgravacausasClick(Sender: TObject);
begin
   PCausas.Enabled:=false;
   try
     Sistema.Edit('movrnc');
     Sistema.Setfield('mrnc_metodo',GravaMemo(MMetodo));
     Sistema.Setfield('mrnc_maquina',GravaMemo(MMaquina));
     Sistema.Setfield('mrnc_matprima',GravaMemo(MMateriaprima));
     Sistema.Setfield('mrnc_meioambiente',GravaMemo(MMeioambiente));
     Sistema.Setfield('mrnc_maoobra',GravaMemo(MMaodeObra));
     Sistema.Setfield('mrnc_medida',GravaMemo(MMedida));
     Sistema.Post('mrnc_numerornc='+Ednumerornc.text+' and mrnc_unid_codigo='+stringtosql(Global.CodigoUnidade));
     Sistema.Commit;
     Aviso('Informações Gravadas');
   except
     Avisoerro('Não foi possível gravar');
   end;
end;

function TFRegNaoConformidade.GravaMemo(s: TMemo): string;
var p:integer;
    ret:string;
begin
  ret:='';
  for p:=0 to S.Lines.Count-1 do begin
     if trim(S.Lines.Strings[p])<>'' then
       ret:=ret+S.Lines.Strings[p]+';';
  end;
  result:=ret;
end;

procedure TFRegNaoConformidade.bconsensoClick(Sender: TObject);
begin
   Pconsenso.Enabled:=true;
   EdMrnc_usua_consemit.SetFocus;

end;

procedure TFRegNaoConformidade.bgravaconsensoClick(Sender: TObject);
begin
   PConsenso.Enabled:=false;
   try
     Sistema.Edit('movrnc');
     Sistema.Setfield('mrnc_eficacia',Edmrnc_eficacia.text);
     Sistema.Setfield('mrnc_usua_consemit',Edmrnc_usua_consemit.asinteger);
     Sistema.Setfield('mrnc_dtconsenso',Edmrnc_dtconsenso.asdate);
     Sistema.Setfield('mrnc_usua_eficacia',Edmrnc_usua_eficacia.asinteger);
     Sistema.Setfield('mrnc_dtencerra',Edmrnc_dtencerra.AsDate);
     Sistema.Setfield('mrnc_custoaprox',Edmrnc_custoaprox.asfloat);
     Sistema.Setfield('mrnc_obs',Edmrnc_obs.text);
     Sistema.Setfield('mrnc_situacao','E');
     Sistema.Setfield('mrnc_resalcancado',Edresalcancado.text);
     Sistema.Post('mrnc_numerornc='+Ednumerornc.text+' and mrnc_unid_codigo='+stringtosql(Global.CodigoUnidade));
     Sistema.Commit;
     Aviso('Informações Gravadas');
   except
     Avisoerro('Não foi possível gravar');
   end;

end;

procedure TFRegNaoConformidade.Edmrnc_dtconsensoValidate(Sender: TObject);
begin
   if EdMrnc_dtconsenso.asdate<EdData.asdate then
     EdMrnc_dtconsenso.invalid('Data de consenso deve ser maior que a data do RNC');
end;

procedure TFRegNaoConformidade.Edmrnc_obsExitEdit(Sender: TObject);
begin
  bgravaconsensoclick(self);   
end;

procedure TFRegNaoConformidade.bprodutosClick(Sender: TObject);
begin
   Pgcontrole.ActivePage:=PgProdutos;
   PgProdutos.enabled:=true;
   EdInspetor.SetFirstEd;
end;

procedure TFRegNaoConformidade.EdresultadoesperadoExitEdit(
  Sender: TObject);

var Numero:integer;
begin

     if OP='I' then begin
        Numero:=FGeral.GetContador('RNC'+Global.CodigoUnidade,false);
        EdNumeroRnc.setvalue( numero );
        Sistema.Insert('movrnc');
        Sistema.Setfield('mrnc_numerornc',EdNumeroRnc.asinteger);
        Sistema.Setfield('mrnc_unid_codigo',Global.CodigoUnidade);
        Sistema.Setfield('mrnc_status','N');
        Sistema.Setfield('mrnc_situacao','P');
        Sistema.Setfield('mrnc_usua_codigo',Global.Usuario.Codigo);
        Sistema.Setfield('mrnc_usua_resp',Edrespcodigo.asinteger);
        Sistema.Setfield('mrnc_usua_exclusao',0);
        Sistema.Setfield('mrnc_data',EdData.asdate);
        gravacampos;
        Sistema.Post;
     end else begin
        Sistema.Edit('movrnc');
        gravacampos;
        Sistema.post('mrnc_numerornc='+EdNumerornc.assql+'and mrnc_unid_codigo='+stringtosql(Global.codigounidade)+
                     ' and mrnc_status=''N''');
     end;
     Sistema.commit;
     EdMrnc_Seto_Ocorre.ClearAll(FRegNaoConformidade,99);
     EdInspetor.ClearAll(FRegNaoConformidade,99);
     PgControle.ActivePage:=PgInicial;
     EdMrnc_Seto_Ocorre.setfocus;

end;

procedure TFRegNaoConformidade.EdMrnc_Usua_dispfinalExitEdit(
  Sender: TObject);
begin
  bgravaprodutosclick(self);
end;

procedure TFRegNaoConformidade.bgravaprodutosClick(Sender: TObject);
begin
   try
     Sistema.Edit('movrnc');
     Sistema.Setfield('mrnc_inspetor',EdInspetor.text);
     Sistema.Setfield('mrnc_op',EdOP.text);
     Sistema.Setfield('mrnc_analcritica',Edanacritica.text);
     Sistema.Setfield('mrnc_reinsplotes',edreinspecionar.text);
     Sistema.Setfield('mrnc_reanalcritica',Edrespanalise.text);
     Sistema.Setfield('mrnc_laudoreinsp',Edlaudoreinsp.text);
     Sistema.Setfield('mrnc_dtreinsp',EdDatareinsp.asdate);
     Sistema.Setfield('Mrnc_Usua_Reinsp',EdMrnc_Usua_Reinsp.AsInteger);
     Sistema.Setfield('Mrnc_DispFinal',EdMrnc_DispFinal.text);
     Sistema.Setfield('Mrnc_Usua_dispfinal',EdMrnc_Usua_dispfinal.asinteger);
     Sistema.Setfield('Mrnc_Comunicara',EdMrnc_Comunicara.Text);
     Sistema.Post('mrnc_numerornc='+Ednumerornc.text+' and mrnc_unid_codigo='+stringtosql(Global.CodigoUnidade));
     Sistema.Commit;
     Aviso('Informações Gravadas');
   except
     Avisoerro('Não foi possível gravar');
   end;
   EdInspetor.setfocus;
end;

procedure TFRegNaoConformidade.Edmrnc_usua_produtoValidate(
  Sender: TObject);
begin
  if EdEspecie.text='2' then begin  // NC de Produto  - 23.04.09 - pivato
   if not FUsuarios.UsuarioProduto(EdMrnc_usua_produto.asinteger) then
     EdMrnc_usua_produto.invalid('Usuário sem autorização para destinar produto');
  end;
end;

procedure TFRegNaoConformidade.EdespecieValidate(Sender: TObject);
begin
  if EdEspecie.text='2' then   // NC de Produto  - 23.04.09 - pivato
     EdMrnc_usua_produto.Empty:=false
  else
     EdMrnc_usua_produto.Empty:=true;

end;

end.

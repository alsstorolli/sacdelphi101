unit ConfGer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel, ExtCtrls,
  SQLGrid, CheckLst, ComCtrls,SqlExpr, Spin;

type
  TFConfGer = class(TForm)
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    Panel1: TPanel;
    bGravar: TSQLBtn;
    Page: TPageControl;
    PgPrincipal: TTabSheet;
    PgTopicos: TTabSheet;
    ScrollBox1: TScrollBox;
    EdTempoSenha: TSQLEd;
    EdPrazoSenha: TSQLEd;
    EdMascaraPlanoGer: TSQLEd;
    EdMascaraPlanoCon: TSQLEd;
    PMsgPrincipal: TSQLPanelGrid;
    CBTopicos: TCheckListBox;
    EEspecificos: TSQLEd;
    EContabilizarCC: TSQLEd;
    ECodHistRatCC: TSQLEd;
    EMoedaPatrimonio: TSQLEd;
    EEspecificos2: TSQLEd;
    EEspecificos3: TSQLEd;
    EEspecificos4: TSQLEd;
    EEspecificos5: TSQLEd;
    PgCabecalhos: TTabSheet;
    PMsgCab: TSQLPanelGrid;
    Panel2: TPanel;
    EdTituloRelatorios: TSQLEd;
    EdtTitBalanceteCont: TSQLEd;
    EdtTitRazaoCont: TSQLEd;
    EdtTitDiarioCont: TSQLEd;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure PageChange(Sender: TObject);
    procedure ECodHistRatCCValidate(Sender: TObject);
  private
    { Private declarations }
    procedure SetaTopicos;
  public
    { Public declarations }
  end;

var
  FConfGer: TFConfGer;

procedure ConfGer_Execute;

implementation

uses Arquiv, Init, Geral,SqlFun,SqlSis;

{$R *.dfm}

var StrTopicos:String;

procedure ConfGer_Execute;
begin
  FGeral.CreateForm(TFConfGer,FConfGer);
  FConfGer.ShowModal;
end;

procedure TFConfGer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TFConfGer.FormActivate(Sender: TObject);
begin
  SetaTopicos;
  FGeral.GetFieldsConfig1(Self);
  FConfGer.EEspecificos.Text:=FConfGer.EEspecificos.Text+FConfGer.EEspecificos2.Text+FConfGer.EEspecificos3.Text+FConfGer.EEspecificos4.Text+FConfGer.EEspecificos5.Text;
  EdMascaraPlanoGer.Enabled:=EdMascaraPlanoGer.IsEmpty;
  EdMascaraPlanoCon.Enabled:=EdMascaraPlanoCon.IsEmpty;
  Page.ActivePage:=PgPrincipal;
  EdTempoSenha.SetFocus;
end;

procedure TFConfGer.bGravarClick(Sender: TObject);
var i,p:integer;
    s:String;

    function SubStr(const Str:String;const i,n:integer):String;
    var ii,ff:Integer;
    begin
      ff:=i+n-1;if ff>Length(Str) then ff:=Length(Str);
      Result:='';
      for ii:=i to ff do Result:=Result+Str[ii];
    end;

    procedure SetaEditsEspecificos;
    var s:String;
    begin
      s:=EEspecificos.Text;
      EEspecificos.Text:=LeftStr(s,50);
      EEspecificos2.Text:=SubStr(s,51,50);
      EEspecificos3.Text:=SubStr(s,101,50);
      EEspecificos4.Text:=SubStr(s,151,50);
      EEspecificos5.Text:=SubStr(s,201,50);
    end;

begin
  for i:=0 to ComponentCount-1 do begin
      if Components[i] is TSqlEd then begin
         if not TSqlEd(Components[i]).Valid then Exit;
      end;
  end;
  s:=Replicate('N',4000);
  for i:=0 to CBTopicos.Items.Count-1 do begin
      if CBTopicos.Checked[i] then begin
         p:=Inteiro(LeftStr(CBTopicos.Items[i],4));
         s[p]:='S';
      end;
  end;
  if s<>StrTopicos then begin
     ExecuteSql('UPDATE Config2 SET Cfg2_Topicos='+StringToSql(s));
     Sistema.Commit;
  end;
  SetaEditsEspecificos;
  FGeral.SetFieldsConfig1(Self);
  FGeral.GetContador('ConfigGeral',False);
  FInit.InicializaConfiguracao;
  Close;
end;

procedure TFConfGer.PageChange(Sender: TObject);
begin
  if Page.ActivePage=PgPrincipal then EdTempoSenha.SetFocus;
  if Page.ActivePage=PgTopicos then CBTopicos.SetFocus;
  if Page.ActivePage=PgCabecalhos then EdTituloRelatorios.SetFocus;
end;

procedure TFConfGer.SetaTopicos;

  procedure Inicializar;
  var Q:TSqlQuery;
      i,p:Integer;
      s:String;
  begin
    Q:=SqlToQuery('SELECT Cfg2_Topicos FROM Config2');
    s:=Q.FieldByName('Cfg2_Topicos').AsString;
    Q.Close;Q.Free;
    StrTopicos:=s;
    for i:=0 to CBTopicos.Items.Count-1 do begin
        p:=Inteiro(LeftStr(CBTopicos.Items[i],4));
        CBTopicos.Checked[i]:=s[p]='S';
    end;
    CBTopicos.ItemIndex:=0;
  end;

begin
  CBTopicos.Items.Add('1001 - Sistema - Tornar invisivel os efeitos gradiente');

  CBTopicos.Items.Add('1101 - Cadastros - Liberado cadastramento de fornecedores sem CNPJ/CPF');
  CBTopicos.Items.Add('1102 - Cadastros - Liberado cadastramento de fornecedores com CNPJ/CPF inválidos');
  CBTopicos.Items.Add('1103 - Cadastros - Liberado cadastramento de fornecedores com CNPJ/CPF duplicados');

  CBTopicos.Items.Add('1111 - Cadastros - Liberado cadastramento de clientes sem CNPJ/CPF');
  CBTopicos.Items.Add('1112 - Cadastros - Liberado cadastramento de clientes com CNPJ/CPF inválidos');
  CBTopicos.Items.Add('1113 - Cadastros - Liberado cadastramento de clientes com CNPJ/CPF duplicados');

  CBTopicos.Items.Add('1255 - Financeiro - Avisar contas a receber de fornecedores em atraso, durante aut. pgto');
  CBTopicos.Items.Add('1257 - Financeiro - Disponibilizar somente pendências com aut. pgto durante as baixas');
  CBTopicos.Items.Add('1259 - Financeiro - Considerar vinculação de fornecedores nas autorizações de pgto');
  CBTopicos.Items.Add('1261 - Financeiro - Considerar vinculação de fornecedores nas baixas pendências financeiras');
  CBTopicos.Items.Add('1263 - Financeiro - Considerar vinculação de fornecedores nos lctos de valores acessórios');
  CBTopicos.Items.Add('1265 - Financeiro - Considerar vinculação de fornecedores nas alterações de locais pgto');
  CBTopicos.Items.Add('1267 - Financeiro - Considerar vinculação de fornecedores nas vinculações de pendências');
  CBTopicos.Items.Add('1272 - Financeiro - Considerar pgtos parciais para abatimento de juros e correção monetária');
  CBTopicos.Items.Add('1275 - Financeiro - Sugerir data de vencimento para autorização de pagamento');
  CBTopicos.Items.Add('1282 - Financeiro - Liberar edição do código da natureza fiscal nos lctos de receitas');
  CBTopicos.Items.Add('1284 - Financeiro - Liberar edição do código da natureza fiscal nos lctos de despesas');
  CBTopicos.Items.Add('1293 - Financeiro - Atribuir descontos automáticos de fornecedores para contas a pagar vencidas');
  CBTopicos.Items.Add('1294 - Financeiro - Permite cancelamento de transação com pendências financeiras autorizadas');

  CBTopicos.Items.Add('1421 - Movimentos - Exigir número de documento nos lançamentos de movimentos');

  Inicializar;
end;


procedure TFConfGer.ECodHistRatCCValidate(Sender: TObject);
begin
  if (ECodHistRatCC.isEmpty) and (Pos(EContabilizarCC.Text,'G,A')>0) then begin
     ECodHistRatCC.Invalid('Não informado código do histórico; para contabilizações de rateios; dos centros de custos');
  end;
end;

end.

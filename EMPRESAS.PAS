unit Empresas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, ExtCtrls, Buttons, SQLBtn,
  StdCtrls, alabel, Mask, SQLEd;

type
  TFEmpresas = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bIncluir: TSQLBtn;
    bEditar: TSQLBtn;
    bExcluir: TSQLBtn;
    bCancelar: TSQLBtn;
    bFiltrar: TSQLBtn;
    bOrdenar: TSQLBtn;
    bPesquisar: TSQLBtn;
    bRelatorio: TSQLBtn;
    bSair: TSQLBtn;
    bExpColumn: TSQLBtn;
    Bevel1: TBevel;
    bRedColumn: TSQLBtn;
    bMoveLeft: TSQLBtn;
    bMoveRight: TSQLBtn;
    bDelColumn: TSQLBtn;
    bRestColumn: TSQLBtn;
    bLoadGrid: TSQLBtn;
    bSaveGrid: TSQLBtn;
    bRestaurar: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    PEdits: TSQLPanelGrid;
    Grid: TSQLGrid;
    DSCadastro: TDataSource;
    EdEmpr_codigo: TSQLEd;
    EdEmpr_nome: TSQLEd;
    EdEmpr_reduzido: TSQLEd;
    EdEmpr_razaosocial: TSQLEd;
    EdEmpr_cnpj: TSQLEd;
    EdEmpr_inscricaoestadual: TSQLEd;
    EdEmpr_inscricaomunicipal: TSQLEd;
    EdEmpr_regjuntacomercial: TSQLEd;
    EdEmpr_atividade: TSQLEd;
    EdEmpr_identatividade: TSQLEd;
    EdEmpr_responsavel: TSQLEd;
    EdEmpr_cargo: TSQLEd;
    EdEmpr_contador: TSQLEd;
    EdEmpr_endereco: TSQLEd;
    EdEmpr_bairro: TSQLEd;
    EdEmpr_cep: TSQLEd;
    EdEmpr_cxpostal: TSQLEd;
    EdEmpr_muni_codigo: TSQLEd;
    EdEmpr_municipio: TSQLEd;
    EdEmpr_uf: TSQLEd;
    EdEmpr_fone: TSQLEd;
    EdEmpr_fax: TSQLEd;
    EdEmpr_email: TSQLEd;
    EdEmpr_dtdespachojunta: TSQLEd;
    EdEmpr_cpfresponsavel: TSQLEd;
    EdEmpr_cpfcontador: TSQLEd;
    EdEmpr_crccontador: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure EdEmpr_emailExitEdit(Sender: TObject);
    procedure GridNewRecord(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure bEditarClick(Sender: TObject);
    procedure EdEmpr_muni_codigoValidate(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure EdEmpr_cnpjValidate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetNome(Codigo:String):String;
    function GetReduzido(Codigo:String):String;
    procedure Open;
  end;

var
  FEmpresas: TFEmpresas;

implementation

uses Arquiv,Geral,SqlExpr,SqlFun, SQLRel;

{$R *.dfm}

var Op:String;


procedure TFEmpresas.FormActivate(Sender: TObject);
begin
  if not Arq.TEmpresas.Active then Arq.TEmpresas.Open;
  Grid.Cancel;
  EdEmpr_Codigo.ClearAll(Self,99);
  PEdits.DisableEdits;
  if not Arq.TEmpresas.IsEmpty then Arq.TEmpresas.GetFields(Self,0);
  Fgeral.ColunasGrid(Grid,Self);
end;

procedure TFEmpresas.bIncluirClick(Sender: TObject);
begin
  Op:='I';
  EdEmpr_Codigo.SetStatusEdits(Self,99,seEdit);
  PEdits.EnableEdits;
  EdEmpr_municipio.Enabled:=False;
  EdEmpr_UF.Enabled:=False;
  Grid.Cancel;
  EdEmpr_Codigo.ClearAll(Self,99);
  EdEmpr_Codigo.SetFocus;
end;

procedure TFEmpresas.EdEmpr_emailExitEdit(Sender: TObject);
begin
  if Op='I' then begin
     Grid.PostInsert(EdEmpr_Codigo);
  end else begin
     Arq.TEmpresas.Edit;
     Arq.TEmpresas.SetFields(Self,0);
     Arq.TEmpresas.Post;
     Arq.TEmpresas.Commit;
     Grid.Cancel;
     PEdits.DisableEdits;
  end;
end;

procedure TFEmpresas.GridNewRecord(Sender: TObject);
begin
  if not Arq.TEmpresas.IsEmpty then Arq.TEmpresas.GetFields(Self,0);
end;

procedure TFEmpresas.bCancelarClick(Sender: TObject);
begin
  EdEmpr_Codigo.ClearAll(Self,99);
  Grid.Cancel;
  PEdits.DisableEdits;
  if not Arq.TEmpresas.IsEmpty then Arq.TEmpresas.GetFields(Self,0);
end;

procedure TFEmpresas.bEditarClick(Sender: TObject);
begin
  Op:='E';
  EdEmpr_Codigo.SetStatusEdits(Self,99,seEditAll);
  PEdits.EnableEdits;
  EdEmpr_Municipio.Enabled:=False;
  EdEmpr_UF.Enabled:=False;
  EdEmpr_Codigo.Enabled:=False;
  Grid.Cancel;
  EdEmpr_Reduzido.SetFocus;
end;

procedure TFEmpresas.EdEmpr_muni_codigoValidate(Sender: TObject);
begin
  EdEmpr_UF.Text:=EdEmpr_Muni_Codigo.ResultFind.FieldByName('Cida_UF').AsString;
end;

procedure TFEmpresas.bRelatorioClick(Sender: TObject);
begin
//  Grid.Report('CadEmpresas','Relação Das Empresas Cadastradas','','');
  FRel.Reportfromsql('select * from empresas','CadEmpresas','Relação Das Empresas Cadastradas');
end;

procedure TFEmpresas.bExcluirClick(Sender: TObject);
var Q:TSqlQuery;
begin
  Q:=SqlToQuery('SELECT Count(*) AS Registros FROM Unidades WHERE Unid_Empr_CODIGO='+StringToSql(Arq.TEmpresas.FieldByName('Empr_Codigo').AsString));
  if Q.FieldByName('Registros').AsInteger>0 then begin
     AvisoErro('Atenção, empresa selecionada para; exclusão, possui unidades vinculadas');
  end else begin
     Grid.Delete;
  end;
  Q.Close;Q.Free;
end;

function TFEmpresas.GetNome(Codigo:String):String;
begin
  Result:='';
  if Trim(Codigo)<>'' then begin
    if not Arq.TEmpresas.Active then Arq.TEmpresas.Open;
    if Arq.TEmpresas.Locate('Empr_Codigo',Codigo,[]) then Result:=Arq.TEmpresas.FieldByName('Empr_Nome').AsString;
  end;
end;


function TFEmpresas.GetReduzido(Codigo:String):String;
begin
  Result:='';
  if Trim(Codigo)<>'' then begin
    if not Arq.TEmpresas.Active then Arq.TEmpresas.Open;
    if Arq.TEmpresas.Locate('Empr_Codigo',Codigo,[]) then Result:=Arq.TEmpresas.FieldByName('Empr_Reduzido').AsString;
  end;
end;

procedure TFEmpresas.Open;
begin
  if not Arq.TEmpresas.Active then Arq.TEmpresas.Open;
end;


procedure TFEmpresas.EdEmpr_cnpjValidate(Sender: TObject);
begin
  FGeral.ValidaCNPJCPF(TSQLEd(Sender));
end;

procedure TFEmpresas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FGeral.LiberaCadastro(Grid);
end;

end.

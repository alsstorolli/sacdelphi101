unit cadccustos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  SQLGrid, Vcl.StdCtrls, Vcl.Mask, SQLEd, Vcl.ExtCtrls, Vcl.Buttons, SQLBtn,
  alabel;

type
  TFCCustos = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bIncluir: TSQLBtn;
    bAlterar: TSQLBtn;
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
    DSCadastros: TDataSource;
    EdCcst_codigo: TSQLEd;
    EdCcst_descricao: TSQLEd;
    EdCcst_reduzido: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure EdCcst_reduzidoExitEdit(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function formatacodigo(s:string):string;
    function GetDescricao(codigo:string):string;


  end;

var
  FCCustos: TFCCustos;

implementation

uses Arquiv,SqlFun,SqlExpr, Geral, SQLRel;

{$R *.dfm}

{ TFCCustos }

procedure TFCCustos.bExcluirClick(Sender: TObject);
//////////////////////////////////////////////////////////
var Q:TSqlQuery;
begin

  Q:=SqlToQuery('SELECT Count(*) AS Registros FROM centrosdecusto WHERE ccus_Codigo='+StringToSql(Arq.TPortadores.FieldByName('ccst_Codigo').AsString));
  if Q.FieldByName('Registros').AsInteger>0 then begin
     AvisoErro('Encontrados centros de custo valores mensais');
  end else begin
     Grid.Delete;
  end;
  Q.Close;Q.Free;

end;

procedure TFCCustos.bIncluirClick(Sender: TObject);
////////////////////////////////////////////////////////////
begin

  Grid.Insert(EdCcst_codigo);

end;

procedure TFCCustos.bRelatorioClick(Sender: TObject);
////////////////////////////////////////////////////////
begin

  FRel.Reportfromsql('select * from ccustos','CadCentrosdeCusto','Rela��o Dos Centros de Custo');

end;

procedure TFCCustos.EdCcst_reduzidoExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////
begin

  Grid.PostInsert(EdCcst_codigo);

end;

procedure TFCCustos.Execute;
////////////////////////////////////////////////////////////
begin

    Show;

end;

procedure TFCCustos.FormActivate(Sender: TObject);
////////////////////////////////////////////////////////////
begin

   if not Arq.TCCustos.Active then Arq.TCCustos.Open;
   FGeral.ColunasGrid(Grid,Self);

end;

function TFCCustos.formatacodigo(s: string): string;
////////////////////////////////////////////////////////////
begin

   result := Trans(s,'##.###.###');

end;

function TFCCustos.GetDescricao(codigo: string): string;
///////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin

   Q:=sqltoquery('select ccst_descricao from ccustos where ccst_codigo = '+Stringtosql(codigo));
   if not Q.Eof then result:=Q.fieldbyname('ccst_descricao').asstring else result:='';
   FGeral.FechaQuery(Q);

end;

end.

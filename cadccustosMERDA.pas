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
    EdCCst_codigo: TSQLEd;
    Edccst_descricao: TSQLEd;
    EdCcst_reduzido: TSQLEd;
    DSCadastros: TDataSource;
    Grid: TSQLGrid;
    procedure FormActivate(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure Edccst_descricaoExitEdit(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure EdCCst_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdCcst_reduzidoExitEdit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function GetDescricao(Codigo:String):String;
  end;

var
  FCCustos: TFCCustos;

implementation

uses Arquiv,SqlFun,SqlExpr, Geral, SQLRel;

{$R *.dfm}

{ TFCCustos }

procedure TFCCustos.bExcluirClick(Sender: TObject);
////////////////////////////////////////////////////////
var Q:TSqlQuery;
begin

  Q:=SqlToQuery('SELECT Count(*) AS Registros FROM centrosdecusto WHERE Ccus_Codigo='+StringToSql(Arq.TCCustos.FieldByName('CCst_Codigo').AsString));
  if Q.FieldByName('Registros').AsInteger>0 then begin
     AvisoErro('Encontrado movimento de centros de custo no centro de custo selecionado');
  end else begin
     Grid.Delete;
  end;
  Q.Close;Q.Free;

end;

procedure TFCCustos.bIncluirClick(Sender: TObject);
///////////////////////////////////////////////////////////
begin

  Grid.Insert(EdCCst_Codigo);
//  EdPort_codigo.text:=strzero(FGeral.getsequencial(1,'port_codigo','C','portadores'),3);

end;

procedure TFCCustos.bRelatorioClick(Sender: TObject);
////////////////////////////////////////////////////////
begin

  FRel.Reportfromsql('select * from ccustos','CadCCusto','Rela��o Dos Centros de Custo');

end;

procedure TFCCustos.EdCcst_reduzidoExitEdit(Sender: TObject);
///////////////////////////////////////////////////////////
begin

   Grid.PostInsert(EdCcst_Codigo);

end;

procedure TFCCustos.EdCCst_codigoKeyPress(Sender: TObject; var Key: Char);
///////////////////////////////////////////////////////////////////////////
begin

   FGeral.Limpaedit(EdCcst_codigo,key);

end;

procedure TFCCustos.Edccst_descricaoExitEdit(Sender: TObject);
///////////////////////////////////////////////////////////////////
begin

  Grid.Insert(EdCcst_codigo);
//  EdPort_codigo.text:=strzero(FGeral.getsequencial(1,'port_codigo','C','portadores'),3);

end;

procedure TFCCustos.Execute;
///////////////////////////////
begin

  FCCustos.Show;

end;

procedure TFCCustos.FormActivate(Sender: TObject);
///////////////////////////////////////////////////
begin

  if not Arq.TCCustos.Active then Arq.TCCustos.Open;
  FGeral.ColunasGrid(Grid,Self);


end;

function TFCCustos.GetDescricao(Codigo: String): String;
//////////////////////////////////////////////////////////
var Q:TSqlquery;
begin

   Q:=sqltoquery('select ccst_descricao from ccustos where ccst_codigo = '+Stringtosql(codigo));
   if not Q.Eof then result:=Q.fieldbyname('ccst_descricao').asstring else result:='';
   FGeral.FechaQuery(Q);

end;

end.

unit material;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, StdCtrls, Mask, SQLEd, ExtCtrls,
  Buttons, SQLBtn, alabel;

type
  TFMaterial = class(TForm)
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
    Dts: TDataSource;
    EdMate_codigo: TSQLEd;
    EdMate_descricao: TSQLEd;
    procedure bIncluirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure EdMate_descricaoExitEdit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
  end;

var
  FMaterial: TFMaterial;

implementation

uses Arquiv, SQLRel;

{$R *.dfm}

procedure TFMaterial.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdMate_codigo);
end;

procedure TFMaterial.Execute;
begin
  Show;
end;

procedure TFMaterial.FormActivate(Sender: TObject);
begin
  if not Arq.TMaterial.Active then Arq.TMaterial.OPen;
  EdMate_codigo.setfocus;
end;

procedure TFMaterial.bRelatorioClick(Sender: TObject);
begin
  FRel.ReportFromGrid(Grid,'RelMaterial','Relação de Material Predominante','','');
end;

procedure TFMaterial.EdMate_descricaoExitEdit(Sender: TObject);
begin
  Grid.PostInsert(EdMate_codigo);
end;

end.

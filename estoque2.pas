unit estoque2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  SQLGrid, Vcl.StdCtrls, Vcl.Mask, SQLEd, Vcl.ExtCtrls, Vcl.Buttons, SQLBtn,
  alabel;

type
  TFEstoque2 = class(TForm)
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
    EdPort_codigo: TSQLEd;
    EdPort_descricao: TSQLEd;
    Grid: TSQLGrid;
    DSCadastros: TDataSource;
    procedure FormActivate(Sender: TObject);
    procedure GridNewRecord(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;

  end;

var
  FEstoque2: TFEstoque2;

implementation

uses Arquiv,SqlFun,SqlExpr, Geral, SQLRel;


{$R *.dfm}

procedure TFEstoque2.Execute;
begin
    Show;
end;

procedure TFEstoque2.FormActivate(Sender: TObject);
begin

   if not Arq.TEstoque.Active then Arq.TEstoque.Open;

end;

procedure TFEstoque2.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
////   grid.OnNewRecord(Self) ;
end;

procedure TFEstoque2.GridNewRecord(Sender: TObject);
begin
  // Arq.TEstoque.GetFields(FEstoque2,99);
   EdPort_codigo.Text:=Arq.TEstoque.FieldByName('esto_codigo').AsString;
   EdPort_codigo.GetFields(FEstoque2,99);
end;

end.

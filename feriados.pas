unit Feriados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, DB, Grids, DBGrids, SQLGrid, ExtCtrls,
  Buttons, SQLBtn, alabel;

type
  TFFeriados = class(TForm)
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
    DSCadastro: TDataSource;
    EdFeri_data: TSQLEd;
    EdFeri_descricao: TSQLEd;
    EdFeri_abrangencia: TSQLEd;
    procedure bIncluirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure EdFeri_abrangenciaExitEdit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure execute;
  end;

var
  FFeriados: TFFeriados;

implementation

uses Arquiv, Geral, SQLRel;

{$R *.dfm}

procedure TFFeriados.Execute;
begin
  FFeriados.Show;
end;

procedure TFFeriados.FormActivate(Sender: TObject);
begin
  if not Arq.TFeriados.Active then Arq.TFeriados.Open;
end;


procedure TFFeriados.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdFeri_Data);
end;

procedure TFFeriados.bRelatorioClick(Sender: TObject);
begin
//  Grid.Report('CadFeriados','Relação Dos Feriados Cadastrados','','');
  Frel.Reportfromsql('select * from feriados','CadFeriados','Relação Dos Feriados Cadastrados');
end;

procedure TFFeriados.EdFeri_abrangenciaExitEdit(Sender: TObject);
begin
  Grid.PostInsert(EdFeri_Data);
end;

procedure TFFeriados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FGeral.LiberaCadastro(Grid);
end;

end.

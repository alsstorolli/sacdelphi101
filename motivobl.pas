unit motivobl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, ExtCtrls, Buttons, SQLBtn,
  StdCtrls, alabel, Mask, SQLEd;

type
  TFMotivosBloq = class(TForm)
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
    EdBloq_codigo: TSQLEd;
    EdBloq_nome: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure EdBloq_nomeExitEdit(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Execute;
  end;

var
  FMotivosBloq: TFMotivosBloq;

implementation

uses Arquiv, SqlFun, SqlSis, SQLRel;

{$R *.dfm}

procedure TFMotivosBloq.Execute;
begin
  ShowModal;
end;

procedure TFMotivosBloq.FormActivate(Sender: TObject);
begin
  if not Arq.TBloqueios.Active then Arq.TBloqueios.Open;
end;

procedure TFMotivosBloq.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdBloq_Codigo);
end;

procedure TFMotivosBloq.EdBloq_nomeExitEdit(Sender: TObject);
begin
  Grid.PostInsert(EdBloq_Codigo);
end;

procedure TFMotivosBloq.bRelatorioClick(Sender: TObject);
begin
//   Grid.Report('CadMotBloq','Relação de Motivos de Bloqueio','','');
   Frel.Reportfromsql('select * from motbloqueios','CadMotBloq','Relação de Motivos de Bloqueio');
end;

end.

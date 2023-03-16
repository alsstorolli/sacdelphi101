unit Mensnf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, StdCtrls, Mask, SQLEd, ExtCtrls,
  Buttons, SQLBtn, alabel;

type
  TFMensNotas = class(TForm)
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
    Edmens_codigo: TSQLEd;
    Edmens_descricao: TSQLEd;
    Grid: TSQLGrid;
    DSMensagensNF: TDataSource;
    PFsc: TSQLPanelGrid;
    MemoFsc: TMemo;
    bFsc: TSQLBtn;
    SQLPanelGrid1: TSQLPanelGrid;
    bsalvafsc: TSQLBtn;
    procedure bIncluirClick(Sender: TObject);
    procedure Edmens_descricaoExitEdit(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bFscClick(Sender: TObject);
    procedure bsalvafscClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function GetDescricao(Codigo:Integer):string;
  end;

var
  FMensNotas: TFMensNotas;
const
  arquivo:string='ListaFsc.txt';

implementation

uses Arquiv, SQLRel, SqlExpr, Sqlfun , Geral, Sqlsis;

{$R *.dfm}

{ TFMensNotas }

procedure TFMensNotas.Execute;
begin
   PFsc.enabled:=false;
   PFsc.Visible:=false;
   if FileExists( arquivo ) then MemoFsc.Lines.LoadFromFile( arquivo );
   FMensNotas.show;
end;

function TFMensNotas.GetDescricao(Codigo: Integer): string;
///////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
{
  if not Arq.TMensagensNF.Active then Arq.TMensagensNF.Open;
  if Arq.TMensagensNF.Locate('mens_codigo',codigo,[]) then
    result:=Arq.TMensagensNF.fieldbyname('mens_descricao').AsString
  else
    result:='';
}
  Q:=sqltoquery('select mens_descricao from mensagensnf where mens_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('mens_descricao').AsString
  else
    result:='';
  FGeral.fechaquery(Q);

end;

procedure TFMensNotas.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdMens_descricao);
end;

procedure TFMensNotas.Edmens_descricaoExitEdit(Sender: TObject);
var Q:TSqlquery;
begin
  Q:=sqltoquery('select max(mens_codigo) as ultimo from mensagensnf');
  if not Q.eof then
    Edmens_codigo.setvalue(Q.fieldbyname('ultimo').asinteger+1)
  else
    Edmens_codigo.setvalue(1);
  Q.close;
  Freeandnil(Q);
  Grid.PostInsert(EdMens_descricao);

end;

procedure TFMensNotas.bRelatorioClick(Sender: TObject);
begin
   FRel.Reportfromsql('select * from mensagensnf','CadMensagensNF','Rela��o de Mensagens de Notas Fiscais');

end;

procedure TFMensNotas.FormActivate(Sender: TObject);
begin
  if not Arq.TMensagensNF.active then Arq.TMensagensNF.open;
  Fgeral.ColunasGrid(Grid,Self);
end;

procedure TFMensNotas.bFscClick(Sender: TObject);
/////////////////////////////////////////////////
begin
  if pfsc.Visible then begin
    pfsc.enabled:=false;
    pfsc.visible:=false;
  end else begin
    pfsc.enabled:=true;
    pfsc.visible:=true;
    Memofsc.SetFocus;
  end;
end;

procedure TFMensNotas.bsalvafscClick(Sender: TObject);
begin
   MemoFsc.Lines.SaveToFile( arquivo );
   PFsc.enabled:=false;
   PFsc.Visible:=false;

end;

end.

unit cadservicos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, DB, Grids, DBGrids, SQLGrid, ExtCtrls,
  Buttons, SQLBtn, alabel, SqlSis;

type
  TFCadServicos = class(TForm)
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
    EdCadm_codigo: TSQLEd;
    EdCadm_descricao: TSQLEd;
    EdCadm_unitario: TSQLEd;
    EdCadm_unidade: TSQLEd;
    EdCadm_somatotal: TSQLEd;
    EdCadm_incideinss: TSQLEd;
    EdCadm_pulalinha: TSQLEd;
    Edcadm_nivel: TSQLEd;
    Edcadm_temperatura: TSQLEd;
    Edcadm_tempo: TSQLEd;
    procedure bIncluirClick(Sender: TObject);
    procedure EdCadm_unidadeExitEdit(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function GetDescricao(codigo:integer):string;
    function GetUnidade(codigo:integer):string;
    procedure DesativaCampos;

  end;

var
  FCadServicos: TFCadServicos;
  campo       : TDicionario;

implementation

uses SQLRel, Arquiv, Sqlfun, SqlExpr, Geral;

{$R *.dfm}

{ TForm1 }

procedure TFCadServicos.Execute;
begin
   Show;

end;

function TFCadServicos.GetDescricao(codigo: integer): string;
var Q:TSqlquery;
begin
  Q:=sqltoquery('select * from cadmobra where cadm_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('cadm_descricao').asstring
  else
    result:='';
  FGeral.fechaquery(Q);
end;

procedure TFCadServicos.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdCadm_codigo);
  EdCadm_codigo.text:= strzero(  FGeral.GetSequencial(1,'cadm_codigo','C','cadmobra') ,EdCAdm_codigo.MaxLength);

end;

procedure TFCadServicos.EdCadm_unidadeExitEdit(Sender: TObject);
begin
   Grid.PostInsert(EdCadm_codigo);
   EdCadm_codigo.text:= strzero(  FGeral.GetSequencial(1,'cadm_codigo','C','cadmobra') ,EdCadm_codigo.MaxLength);

end;

procedure TFCadServicos.bRelatorioClick(Sender: TObject);
begin
   FRel.Reportfromsql('select * from cadmobra order by cadm_descricao','Cadastro de M�o de Obra','Rela��o de Servi�os');

end;

// 06.04.18
procedure TFCadServicos.DesativaCampos;
////////////////////////////////////////
begin

   Edcadm_nivel.Enabled:=false;
   EdCadm_nivel.TableName:='';
   Edcadm_temperatura.Enabled:=false;
   EdCadm_temperatura.TableName:='';
   Edcadm_tempo.Enabled:=false;
   EdCadm_tempo.TableName:='';

end;

procedure TFCadServicos.FormActivate(Sender: TObject);
///////////////////////////////////////////////////////////
begin
  campo:=Sistema.GetDicionario('cadmobra','cadm_nivel');
  if campo.Tipo='' then
    DesativaCampos;
  if not Arq.TServicos.Active then Arq.TServicos.open;
  FGeral.ColunasGrid(Grid,Self);



end;

function TFCadServicos.GetUnidade(codigo: integer): string;
var Q:TSqlquery;
begin
  Q:=sqltoquery('select * from cadmobra where cadm_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('cadm_unidade').asstring
  else
    result:='';
  FGeral.fechaquery(Q);
end;

end.

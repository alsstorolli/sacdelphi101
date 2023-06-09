unit cadocor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, StdCtrls, Mask, SQLEd, ExtCtrls,
  Buttons, SQLBtn, alabel;

type
  TFCadOcorrencias = class(TForm)
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
    EdCaoc_codigo: TSQLEd;
    EdCaoc_descricao: TSQLEd;
    Grid: TSQLGrid;
    Dts: TDataSource;
    procedure bIncluirClick(Sender: TObject);
    procedure EdCaoc_descricaoExitEdit(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetDescricao(codigo:integer):string;
    procedure Execute;
    procedure SetaItems(Edit,EditNome:TSqlEd;OcorrenciasValidas:String);
  end;

var
  FCadOcorrencias: TFCadOcorrencias;

implementation

uses SQLRel, Arquiv, Sqlfun, geral;

{$R *.dfm}

procedure TFCadOcorrencias.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdCaoc_codigo);

end;

procedure TFCadOcorrencias.EdCaoc_descricaoExitEdit(Sender: TObject);
begin
   Grid.PostInsert(EdCaoc_codigo);

end;

procedure TFCadOcorrencias.bRelatorioClick(Sender: TObject);
begin
   FRel.Reportfromsql('select * from cadocorrencias','CadOcorrencias','Rela��o de Ocorr�ncias');

end;

procedure TFCadOcorrencias.FormActivate(Sender: TObject);
begin
  if not Arq.TCadOcorrencias.Active then Arq.TCadOcorrencias.open;
  FGeral.ColunasGrid(Grid,Self);

end;

function TFCadOcorrencias.GetDescricao(codigo: integer): string;
begin
  if not Arq.TCadocorrencias.Active then Arq.TCadocorrencias.Open;
  if Arq.TCadocorrencias.Locate('caoc_codigo',codigo,[]) then
    result:=Arq.TCadocorrencias.fieldbyname('Caoc_descricao').AsString
  else
    result:='';

end;

procedure TFCadOcorrencias.Execute;
begin
   FCadOcorrencias.Showmodal;
end;

procedure TFCadOcorrencias.SetaItems(Edit, EditNome: TSqlEd;
  OcorrenciasValidas: String);
begin
  Edit.Items.Clear;
  if not Arq.TCadocorrencias.Active then Arq.TCadocorrencias.Open;
  Arq.TCadocorrencias.BeginProcess;
  Arq.TCadocorrencias.First;
  while not Arq.TCadocorrencias.Eof do begin
    if (OcorrenciasValidas='') or (Pos(Arq.TCadocorrencias.FieldByName('Caoc_Codigo').AsString,OcorrenciasValidas)>0) then begin
       Edit.Items.Add(Arq.TCadocorrencias.FieldByName('Caoc_Codigo').AsString+' - '+Trim(Arq.TCadocorrencias.FieldByName('Caoc_Descricao').AsString));
    end;
    Arq.TCadocorrencias.Next;
  end;
  Arq.TCadocorrencias.EndProcess;
//  if Edit.Items.Count=1 then begin
//     Edit.Text:=LeftStr(Edit.Items[0],3);
//     if EditNome<>nil then EditNome.Text:=FinalStr(Edit.Items[0],7);
//  end;
end;

end.

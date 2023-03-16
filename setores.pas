unit setores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, StdCtrls, Mask, SQLEd, ExtCtrls,
  Buttons, SQLBtn, alabel;

type
  TFSetores = class(TForm)
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
    EdSeto_codigo: TSQLEd;
    EdSeto_descricao: TSQLEd;
    EdSeto_usua_codigo: TSQLEd;
    SetEdusua_nome: TSQLEd;
    procedure bIncluirClick(Sender: TObject);
    procedure EdSeto_descricaoExitEdit(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function GetDescricao(codigo:string):string;
    procedure SetaItems(Edit,EditNomeGrupo:TSqlEd;GruposValidos,Nomevalido:String);

  end;

var
  FSetores: TFSetores;

implementation

uses SQLRel, Arquiv, Sqlfun, SqlExpr, Geral;

{$R *.dfm}

{ TFSetores }

procedure TFSetores.Execute;
begin
   Show;
end;

function TFSetores.GetDescricao(codigo: string): string;
var Q:TSqlquery;
begin
  Q:=sqltoquery('select * from setores where seto_codigo='+stringtosql(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('seto_descricao').asstring
  else
    result:='';
  FGeral.fechaquery(Q);
end;

procedure TFSetores.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdSeto_codigo);
  EdSeto_codigo.text:= strzero(  FGeral.GetSequencial(1,'seto_codigo','C','setores') ,EdSeto_codigo.MaxLength);

end;

procedure TFSetores.EdSeto_descricaoExitEdit(Sender: TObject);
begin
   Grid.PostInsert(EdSeto_codigo);
   EdSeto_codigo.text:= strzero(  FGeral.GetSequencial(1,'seto_codigo','C','setores') ,EdSeto_codigo.MaxLength);

end;

procedure TFSetores.bRelatorioClick(Sender: TObject);
begin
   FRel.Reportfromsql('select * from setores','Setores','Relação de Setores');

end;

procedure TFSetores.FormActivate(Sender: TObject);
begin
  if not Arq.TSetores.Active then Arq.TSetores.open;
  Fgeral.ColunasGrid(Grid,Self);

end;

procedure TFSetores.SetaItems(Edit, EditNomeGrupo: TSqlEd; GruposValidos,  Nomevalido: String);
///////////////////////////////////////////////////////////////////////////////////////////////////
begin
  Edit.Items.Clear;
  if not Arq.TSetores.Active then Arq.TSetores.Open;
  Arq.TSetores.BeginProcess;
  Arq.TSetores.First;
  while not Arq.TSetores.Eof do begin
    if ((GruposValidos='') or (Pos(strzero(Arq.TSetores.FieldByName('seto_Codigo').AsInteger,4),GruposValidos)>0))
       and ((NomeValido='') or (Pos(NomeValido,Uppercase(Arq.TSetores.FieldByName('Seto_Descricao').AsString))>0))
      then begin
//       Edit.Items.Add(Strzero(Arq.TGrupos.FieldByName('Grup_Codigo').AsInteger,3)+' - '+Trim(Arq.TGrupos.FieldByName('Grup_Descricao').AsString));
       Edit.Items.Add(Strzero(Arq.TSetores.FieldByName('Seto_Codigo').AsInteger,4)+' - '+Trim(Arq.TSetores.FieldByName('Seto_Descricao').AsString));
    end;
    Arq.TSetores.Next;
  end;
  Arq.TSetores.EndProcess;
  if Edit.Items.Count=1 then begin
     if EditNomeGrupo<>nil then EditNomeGrupo.Text:=FinalStr(Edit.Items[0],9);
  end;
end;

end.

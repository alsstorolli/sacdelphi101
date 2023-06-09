unit familias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, StdCtrls, Mask, SQLEd, ExtCtrls,
  Buttons, SQLBtn, alabel;

type
  TFFamilias = class(TForm)
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
    EdFami_codigo: TSQLEd;
    EdFami_descricao: TSQLEd;
    procedure bIncluirClick(Sender: TObject);
    procedure EdFami_descricaoExitEdit(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function GetDescricao(codigo:integer):string;
    procedure SetaItems(Edit,EditNomeGrupo:TSqlEd;GruposValidos,Nomevalido:String);
  end;

var
  FFamilias: TFFamilias;

implementation

uses Arquiv, SQLRel, Sqlfun, SqlExpr, geral;

{$R *.dfm}

{ TFFamilias }

procedure TFFamilias.Execute;
begin
  Show;
end;

procedure TFFamilias.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdFami_Codigo);
end;

procedure TFFamilias.EdFami_descricaoExitEdit(Sender: TObject);
begin
  Grid.PostInsert(EdFami_codigo);
end;

procedure TFFamilias.bRelatorioClick(Sender: TObject);
begin
//  Grid.Report('RelFamilias','Rela��o das Familias do Estoque','','');
  Frel.Reportfromsql('select * from familias','RelFamilias','Rela��o das Familias do Estoque');
end;

procedure TFFamilias.FormActivate(Sender: TObject);
begin
  if not Arq.TFamilias.Active then Arq.TFamilias.Open;
  Fgeral.ColunasGrid(Grid,Self);
end;

function TFFamilias.GetDescricao(codigo: integer): string;
begin
  Result:='';
  if Codigo>0 then begin
    if not Arq.TFamilias.Active then Arq.TFamilias.Open;
    if Arq.TFamilias.Locate('Fami_Codigo',Codigo,[]) then Result:=Arq.TFamilias.FieldByName('Fami_Descricao').AsString;
  end;

end;

procedure TFFamilias.bExcluirClick(Sender: TObject);
var Cod:String;
    Found:Boolean;

    function FoundTabela(Tabela,Campo,Msg,Chave:String):Boolean;
    var Q:TSqlQuery;
    begin
      Q:=SqlToQuery('SELECT '+chave+' as Codigo FROM '+Tabela+' WHERE '+Campo+'='+Cod );
      Result:=not Q.eof;
      if Result then AvisoErro('Encontrado v�nculo na tabela '+tabela+' ref. '+Msg+' codigo '+Q.fieldbyname('codigo').asstring);
      Q.Close;Freeandnil(Q);
    end;


begin
  Cod:=IntToStr(Arq.TFamilias.FieldByName('fami_Codigo').AsInteger);
  Found:=FoundTabela('Estoque','Esto_fami_Codigo','Cadastro do estoque','Esto_codigo');
  if not Found then Grid.Delete;
end;

procedure TFFamilias.SetaItems(Edit, EditNomeGrupo: TSqlEd; GruposValidos,
  Nomevalido: String);
begin
  Edit.Items.Clear;
  if not Arq.TFamilias.Active then Arq.TFamilias.Open;
  Arq.TFamilias.BeginProcess;
  Arq.TFamilias.First;
  while not Arq.TFamilias.Eof do begin
    if ((GruposValidos='') or (Pos(strzero(Arq.TFamilias.FieldByName('Fami_Codigo').AsInteger,4),GruposValidos)>0))
       and ((NomeValido='') or (Pos(NomeValido,Uppercase(Arq.TFamilias.FieldByName('Fami_Descricao').AsString))>0))
      then begin
       Edit.Items.Add(Strzero(Arq.TFamilias.FieldByName('Fami_Codigo').AsInteger,4)+' - '+Trim(Arq.TFamilias.FieldByName('Fami_Descricao').AsString));
    end;
    Arq.TFamilias.Next;
  end;
  Arq.TFamilias.EndProcess;
  if Edit.Items.Count=1 then begin
     Edit.Text:=LeftStr(Edit.Items[0],4);
//     Edit.Text:=Edit.Items[0];
     if EditNomeGrupo<>nil then EditNomeGrupo.Text:=FinalStr(Edit.Items[0],7);
  end;


end;

end.

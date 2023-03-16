unit Regioes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, DB, Grids, DBGrids, SQLGrid, ExtCtrls,
  Buttons, SQLBtn, alabel;

type
  TFRegioes = class(TForm)
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
    DSCadastros: TDataSource;
    EdRegi_codigo: TSQLEd;
    EdRegi_descricao: TSQLEd;
    procedure bIncluirClick(Sender: TObject);
    procedure EdRegi_descricaoExitEdit(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdRegi_codigoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    function GetDescricao(Codigo:String):String;
    procedure Open;
//    procedure ColunasGrid(xgrid:TSqlGrid;xPainel:TForm);

    { Public declarations }
  end;

var
  FRegioes: TFRegioes;

implementation

uses Arquiv,SqlFun,SqlExpr, Geral, SQLRel;

{$R *.dfm}

procedure TFRegioes.FormActivate(Sender: TObject);
begin
  if not Arq.TRegioes.Active then Arq.TRegioes.Open;
  FGeral.ColunasGrid(Grid,FRegioes);
end;

procedure TFRegioes.Open;
begin
  if not Arq.TRegioes.Active then Arq.TRegioes.Open;
end;

procedure TFRegioes.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdRegi_Codigo);
  EdRegi_codigo.text:=strzero(FGeral.getsequencial(1,'regi_codigo','C','regioes'),3);
end;

procedure TFRegioes.EdRegi_descricaoExitEdit(Sender: TObject);
begin
  Grid.PostInsert(EdRegi_Codigo);
  EdRegi_codigo.text:=strzero(FGeral.getsequencial(1,'regi_codigo','C','regioes'),3);
end;

procedure TFRegioes.bRelatorioClick(Sender: TObject);
begin
//  Grid.Report('CadRegioes','Relação Das Regiões Cadastradas','','');
  FRel.Reportfromsql('select * from regioes','CadRegioes','Relação Das Regiões Cadastradas');
end;


// 20.11.16
{
procedure TFRegioes.ColunasGrid(xgrid: TSqlGrid;xpainel:TForm);
/////////////////////////////////////////////////////////////////////////
var p,i:integer;
    campocoluna:string;
begin
   for i:=0 to xGrid.Columns.Count-1 do begin
     campocoluna:=xGrid.Columns[i].FieldName;
     for p:=0 to xPainel.ComponentCount-1 do begin
       if xPainel.Components[p] is TSqlEd then begin
         if Uppercase( TSqlEd( xPainel.Components[p] ).TableField ) = Uppercase( campocoluna )  then
           xGrid.Columns[i].Title.Caption:=TSqlEd( xPainel.Components[p] ).Title ;
       end;
     end;
   end;

end;
}

procedure TFRegioes.bExcluirClick(Sender: TObject);
var Q:TSqlQuery;
begin
  Q:=SqlToQuery('SELECT Count(*) AS Registros FROM Cidades WHERE Cida_Regi_Codigo='+StringToSql(Arq.TRegioes.FieldByName('Regi_Codigo').AsString));
  if Q.FieldByName('Registros').AsInteger>0 then begin
     AvisoErro('Encontrado(s) cidade(s) vinculado(s) à região selecionada');
  end else begin
     Grid.Delete;
  end;
  Q.Close;Q.Free;
end;


function TFRegioes.GetDescricao(Codigo:String):String;
begin
  Result:='';
  if Trim(Codigo)<>'' then begin
    if not Arq.TRegioes.Active then Arq.TRegioes.Open;
    if Arq.TRegioes.Locate('Regi_Codigo',Codigo,[]) then Result:=Trim(Arq.TRegioes.FieldByName('Regi_Descricao').AsString);
  end;
end;


procedure TFRegioes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FGeral.LiberaCadastro(Grid);
end;

procedure TFRegioes.EdRegi_codigoKeyPress(Sender: TObject; var Key: Char);
begin
   FGeral.LImpaedit(EdRegi_codigo,key)
end;

end.

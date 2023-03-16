unit ingredientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, StdCtrls, Mask, SQLEd, ExtCtrls,
  Buttons, SQLBtn, alabel;

type
  TFIngredientes = class(TForm)
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
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    PEdits: TSQLPanelGrid;
    Grid: TSQLGrid;
    Dts: TDataSource;
    bRestaurar: TSQLBtn;
    EdIngr_codigo: TSQLEd;
    EdIngr_linha1: TSQLEd;
    EdIngr_linha2: TSQLEd;
    EdIngr_linha3: TSQLEd;
    EdIngr_linha4: TSQLEd;
    EdIngr_linha5: TSQLEd;
    EdIngr_linha6: TSQLEd;
    EdIngr_linha7: TSQLEd;
    EdIngr_linha8: TSQLEd;
    EdIngr_linha9: TSQLEd;
    EdIngr_linha10: TSQLEd;
    beditar: TSQLBtn;
    bSaveGrid: TSQLBtn;
    procedure bIncluirClick(Sender: TObject);
    procedure EdIngr_linha10ExitEdit(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure GridNewRecord(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure beditarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
  end;

var
  FIngredientes: TFIngredientes;
  Op:String;

implementation

uses Arquiv, SQLRel, Sqlfun, SqlExpr, Sqlsis, Geral ;

{$R *.dfm}

{ TFIngredientes }

procedure TFIngredientes.Execute;
begin
  if FIngredientes=nil then  FGeral.CreateForm(TFIngredientes,FIngredientes);
  FIngredientes.Show;

end;

procedure TFIngredientes.bIncluirClick(Sender: TObject);
begin
   OP:='I';
   Grid.Insert(EdIngr_linha1);
   EdIngr_codigo.setvalue( FGeral.GetProximoCodigoCadastro('ingredientes','ingr_codigo') );
end;

procedure TFIngredientes.EdIngr_linha10ExitEdit(Sender: TObject);
begin
  if OP='I' then begin
    Grid.PostInsert(EdINgr_linha1);
    EdIngr_codigo.setvalue( FGeral.GetProximoCodigoCadastro('ingredientes','ingr_codigo') );
  end else begin
     Arq.TIngredientes.Edit;
     EdIngr_Codigo.SetFields(Self,99);
     Arq.TIngredientes.Post;
     Arq.TIngredientes.Commit;
     PEdits.Hide;
  end;
  bSair.enabled:=true;
end;

procedure TFIngredientes.bExcluirClick(Sender: TObject);
var Cod:String;
    Found:Boolean;

    function FoundTabela(Tabela,Campo,Msg:String):Boolean;
    var Q:TSqlQuery;
    begin
      Q:=SqlToQuery('SELECT Count(*) AS Registros FROM '+Tabela+' WHERE '+Campo+'='+Cod);
      Result:=Q.FieldByName('Registros').AsInteger>0;
      if Result then AvisoErro('Encontrado lançamentos com a configuração escolhida; na tabela: '+Msg);
      Q.Close;Q.Free;
    end;

begin
  Cod:=StringToSql(Arq.TIngredientes.FieldByName('Ingr_Codigo').AsString);
  Found:=FoundTabela('Estoque','Esto_Ingr_Codigo','Cadastro de Produtos');
  if not Found then begin
    Grid.Delete;
//    FGeral.GravaLog(8,'Exclusão',true);
  end;

end;

procedure TFIngredientes.bRelatorioClick(Sender: TObject);
begin
   Frel.Reportfromsql('select * from ingredientes','CadIngredientes','Relação de Ingredientes');

end;

procedure TFIngredientes.GridNewRecord(Sender: TObject);
begin
  if not Arq.TINgredientes.IsEmpty then Arq.TIngredientes.GetFields(Self,0);

end;

procedure TFIngredientes.FormActivate(Sender: TObject);
begin
  if not Arq.TIngredientes.Active then Arq.TIngredientes.Open;

end;

procedure TFIngredientes.beditarClick(Sender: TObject);
begin
    EdIngr_Codigo.SetStatusEdits(Self,99,seEditAll);
    OP:='E';
    EdIngr_Codigo.GetFields(Self,99);
    PEdits.Show;
    bSair.enabled:=false;
    EdIngr_LInha1.SetFocus;
end;

end.

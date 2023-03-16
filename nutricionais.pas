unit nutricionais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, ExtCtrls, Buttons, SQLBtn,
  StdCtrls, alabel, Mask, SQLEd;

type
  TFNutricionais = class(TForm)
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
    EdNutr_codigo: TSQLEd;
    EdNutr_porcaocaseira: TSQLEd;
    EdNutr_qtdeporcao: TSQLEd;
    EdNutr_unporcao: TSQLEd;
    EdNutr_balanca: TSQLEd;
    EdNutr_fator: TSQLEd;
    EdNutr_calorias: TSQLEd;
    EdNutr_carboidratos: TSQLEd;
    EdNutr_proteinas: TSQLEd;
    EdNutr_gordtotais: TSQLEd;
    EdNutr_gordsaturadas: TSQLEd;
    EdNutr_fibras: TSQLEd;
    EdNutr_colesterol: TSQLEd;
    EdNutr_calcio: TSQLEd;
    EdNutr_ferro: TSQLEd;
    EdNutr_sodio: TSQLEd;
    EdNutr_nomebalanca: TSQLEd;
    EdNutr_qtde: TSQLEd;
    EdNutr_validade: TSQLEd;
    procedure bIncluirClick(Sender: TObject);
    procedure EdNutr_sodioExitEdit(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure GridNewRecord(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure SetaEdits;
  end;

var
  FNutricionais: TFNutricionais;

implementation

uses Arquiv, SQLRel, Sqlfun, SqlExpr, Sqlsis, Geral ;

{$R *.dfm}

{ TFNutricionais }

procedure TFNutricionais.Execute;
begin
  if FNutricionais=nil then  FGeral.CreateForm(TFNutricionais,FNutricionais);
  SetaEdits;
  FNutricionais.Show;
end;

procedure TFNutricionais.bIncluirClick(Sender: TObject);
begin

   Grid.Insert(EdNutr_porcaocaseira);
   EdNutr_codigo.setvalue( FGeral.GetProximoCodigoCadastro('nutricionais','nutr_codigo') );

end;

procedure TFNutricionais.EdNutr_sodioExitEdit(Sender: TObject);
begin
  Grid.PostInsert(EdNutr_porcaocaseira);
  EdNutr_codigo.setvalue( FGeral.GetProximoCodigoCadastro('nutricionais','nutr_codigo') );

end;

procedure TFNutricionais.bExcluirClick(Sender: TObject);
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
  Cod:=StringToSql(Arq.TNUtricionais.FieldByName('Nutr_Codigo').AsString);
  Found:=FoundTabela('Estoque','Esto_Nutr_Codigo','Cadastro de Produtos');
  if not Found then begin
    Grid.Delete;
//    FGeral.GravaLog(8,'Exclusão',true);
  end;
end;

procedure TFNutricionais.bRelatorioClick(Sender: TObject);
begin
   Frel.Reportfromsql('select * from nutricionais','CadNutricionais','Relação de Informação Nutricional');

end;

procedure TFNutricionais.SetaEdits;
begin
   EdNutr_UNporcao.Items.Clear;
   EdNutr_UNporcao.Items.Add('G  - Gramas');
   EdNutr_UNporcao.Items.Add('ML - Mililitros');
   EdNutr_UNporcao.Items.Add('UN - Unidades');

end;

procedure TFNutricionais.GridNewRecord(Sender: TObject);
begin
  if not Arq.TNutricionais.IsEmpty then Arq.TNutricionais.GetFields(Self,0);

end;

procedure TFNutricionais.FormActivate(Sender: TObject);
begin
  if not Arq.TNutricionais.Active then Arq.TNutricionais.Open;
  FGeral.ColunasGrid(Grid,Self);

end;

end.

unit conservacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, StdCtrls, Mask, SQLEd, ExtCtrls,
  Buttons, SQLBtn, alabel;

type
  TFConservacao = class(TForm)
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
    bRestaurar: TSQLBtn;
    beditar: TSQLBtn;
    bSaveGrid: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    PEdits: TSQLPanelGrid;
    EdCons_codigo: TSQLEd;
    EdCons_linha1: TSQLEd;
    EdCons_linha2: TSQLEd;
    EdCons_linha3: TSQLEd;
    EdCons_linha4: TSQLEd;
    EdCons_linha5: TSQLEd;
    EdCons_linha6: TSQLEd;
    Grid: TSQLGrid;
    Dts: TDataSource;
    procedure bIncluirClick(Sender: TObject);
    procedure EdCons_linha6ExitEdit(Sender: TObject);
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
  FConservacao: TFConservacao;
  Op:String;

implementation

uses Arquiv, SQLRel, Sqlfun, SqlExpr, Sqlsis, Geral ;

{$R *.dfm}

{ TFConservacao }

procedure TFConservacao.Execute;
begin
  if FConservacao=nil then  FGeral.CreateForm(TFConservacao,FConservacao);
  FConservacao.Show;

end;

procedure TFConservacao.bIncluirClick(Sender: TObject);
begin
   OP:='I';
   Grid.Insert(EdCons_linha1);
   EdCons_codigo.setvalue( FGeral.GetProximoCodigoCadastro('conservacao','cons_codigo') );

end;

procedure TFConservacao.EdCons_linha6ExitEdit(Sender: TObject);
begin
  if OP='I' then begin
    Grid.PostInsert(EdCons_linha1);
    EdCons_codigo.setvalue( FGeral.GetProximoCodigoCadastro('conservacao','Cons_codigo') );
  end else begin
     Arq.TConservacao.Edit;
     EdCons_Codigo.SetFields(Self,99);
     Arq.TConservacao.Post;
     Arq.TConservacao.Commit;
     PEdits.Hide;
  end;
  bSair.enabled:=true;

end;

procedure TFConservacao.bExcluirClick(Sender: TObject);
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
  Cod:=StringToSql(Arq.TConservacao.FieldByName('Cons_Codigo').AsString);
  Found:=FoundTabela('Estoque','Esto_Cons_Codigo','Cadastro de Produtos');
  if not Found then begin
    Grid.Delete;
//    FGeral.GravaLog(8,'Exclusão',true);
  end;
end;

procedure TFConservacao.bRelatorioClick(Sender: TObject);
begin
   Frel.Reportfromsql('select * from conservacao','CadConservacao','Relação de Conservação');

end;

procedure TFConservacao.GridNewRecord(Sender: TObject);
begin
  if not Arq.TConservacao.IsEmpty then Arq.TConservacao.GetFields(Self,0);
   FGeral.ColunasGrid(Grid,Self);

end;

procedure TFConservacao.FormActivate(Sender: TObject);
begin
  if not Arq.TConservacao.Active then Arq.TConservacao.Open;

end;

procedure TFConservacao.beditarClick(Sender: TObject);
begin
    EdCons_Codigo.SetStatusEdits(Self,99,seEditAll);
    OP:='E';
    EdCons_Codigo.GetFields(Self,99);
    PEdits.Show;
    bSair.enabled:=false;
    EdCons_LInha1.SetFocus;
end;

end.

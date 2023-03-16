unit cadcopa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, StdCtrls, Mask, SQLEd, ExtCtrls,
  Buttons, SQLBtn, alabel;

type
  TFCopas = class(TForm)
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
    EdCopa_codigo: TSQLEd;
    EdCopa_descricao: TSQLEd;
    Grid: TSQLGrid;
    Dts: TDataSource;
    procedure bIncluirClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure EdCopa_descricaoExitEdit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetDescricao(Codigo:Integer):string;
    procedure Execute;
    function GetSql(campo:string ; codigo:integer ):string;
  end;

var
  FCopas: TFCopas;

implementation

uses Arquiv, SQLRel, Sqlexpr, Geral, Sqlfun ;

{$R *.dfm}

procedure TFCopas.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdCopa_codigo);

end;

procedure TFCopas.bExcluirClick(Sender: TObject);
var Cod:String;
    Found:Boolean;

    function FoundTabela(Tabela,Campo,Msg:String):Boolean;
    var Q:TSqlQuery;
    begin
      Q:=SqlToQuery('SELECT Count(*) AS Registros FROM '+Tabela+' WHERE '+Campo+'='+Cod);
      Result:=Q.FieldByName('Registros').AsInteger>0;
      if Result then AvisoErro('Encontradas vinculações com a copa; selecionada na tabela: '+Msg);
      Q.Close;Q.Free;
    end;


begin
  Cod:=IntToStr(Arq.TCopas.FieldByName('copa_Codigo').AsInteger);
  Found:=FoundTabela('Movpeddet','Mpdd_copa_Codigo','Pedidos de Venda');
  if not Found then Grid.Delete;


end;

procedure TFCopas.bRelatorioClick(Sender: TObject);
begin
   FRel.Reportfromsql('select * from copas','CadCopas','Relação de Copas');

end;

procedure TFCopas.EdCopa_descricaoExitEdit(Sender: TObject);
begin
   Grid.PostInsert(EdCopa_codigo);

end;

procedure TFCopas.FormActivate(Sender: TObject);
begin
  if not Arq.TCopas.Active then Arq.TCopas.open;

end;

procedure TFCopas.Execute;
begin
  FCopas.ShowModal;

end;

function TFCopas.GetDescricao(Codigo: Integer): string;
var Q:TSqlquery;
begin
  Q:=sqltoquery('select * from copas where copa_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('copa_descricao').asstring
  else
    result:='';
  FGeral.Fechaquery(q);

end;

function TFCopas.GetSql(campo: string; codigo: integer): string;
begin
   result:=' and ( '+campo+' = 0 or '+campo+' is null )';
   if (codigo>0)  then
      result:=' and '+campo+' = '+inttostr(codigo);

end;

end.

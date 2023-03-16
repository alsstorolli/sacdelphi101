unit moedas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, DB, Grids, DBGrids, SQLGrid, ExtCtrls,
  Buttons, SQLBtn, alabel;

type
  TFMoedas = class(TForm)
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
    DSCadastro: TDataSource;
    EdMoed_codigo: TSQLEd;
    EdMoed_descricao: TSQLEd;
    EdMoed_simbolo: TSQLEd;
    EdMoed_singular: TSQLEd;
    EdMoed_plural: TSQLEd;
    EdMoed_cotacao: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure EdMoed_cotacaoExitEdit(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
   function GetDescricao(Codigo:String):String;
   function GetPlural(Codigo:String):String;
   function ReaisToMoeda(CodMoeda:String;ValorReais:Currency):Extended;
   function MoedaToReais(CodMoeda:String;ValorMoeda:Extended):Extended;
   procedure Open;
  end;

var
  FMoedas: TFMoedas;

implementation

uses Arquiv,SqlFun,SqlExpr, Geral, SQLRel;

{$R *.dfm}

procedure TFMoedas.FormActivate(Sender: TObject);
begin
  if not Arq.TMoedas.Active then Arq.TMoedas.Open;
end;

procedure TFMoedas.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdMoed_Codigo);
end;

procedure TFMoedas.bRelatorioClick(Sender: TObject);
begin
//  Grid.Report('CadMoedas','Relação Das Moedas Cadastradas','','');
  FRel.Reportfromsql('select * from moedas','CadMoedas','Relação Das Moedas Cadastradas');
end;

function TFMoedas.GetDescricao(Codigo:String):String;
begin
  Result:='';
  if Trim(Codigo)<>'' then begin
    if not Arq.TMoedas.Active then Arq.TMoedas.Open;
    if Arq.TMoedas.Locate('Moed_Codigo',Codigo,[]) then Result:=Arq.TMoedas.FieldByName('Moed_Descricao').AsString;
  end;
end;

function TFMoedas.GetPlural(Codigo:String):String;
begin
  Result:='';
  if Trim(Codigo)<>'' then begin
    if not Arq.TMoedas.Active then Arq.TMoedas.Open;
    if Arq.TMoedas.Locate('Moed_Codigo',Codigo,[]) then Result:=Arq.TMoedas.FieldByName('Moed_Plural').AsString;
  end;
end;

procedure TFMoedas.Open;
begin
  if not Arq.TMoedas.Active then Arq.TMoedas.Open;
end;

function TFMoedas.ReaisToMoeda(CodMoeda:String;ValorReais:Currency):Extended;
var Cot:Double;
begin
  if not Arq.TMoedas.Active then Arq.TMoedas.Open;
  Arq.TMoedas.Locate('Moed_Codigo',CodMoeda,[]);
  Cot:=Arq.TMoedas.FieldByName('Moed_Cotacao').AsFloat;
  if Cot<=0 then Cot:=1;
  Result:=RoundValor(Divide(ValorReais,Cot));
end;


function TFMoedas.MoedaToReais(CodMoeda:String;ValorMoeda:Extended):Extended;
var Cot:Double;
begin
  Result:=0;
  if Trim(CodMoeda)<>'' then begin
     if not Arq.TMoedas.Active then Arq.TMoedas.Open;
     Arq.TMoedas.Locate('Moed_Codigo',CodMoeda,[]);
     Cot:=Arq.TMoedas.FieldByName('Moed_Cotacao').AsFloat;
     if Cot<=0 then Cot:=1;
     Result:=RoundValor(ValorMoeda*Cot);
  end;
end;

procedure TFMoedas.EdMoed_cotacaoExitEdit(Sender: TObject);
begin
  Grid.PostInsert(EdMoed_Codigo);
end;

procedure TFMoedas.bExcluirClick(Sender: TObject);
var Q:TSqlQuery;
begin
  Q:=SqlToQuery('SELECT Count(*) AS Registros FROM PlanoGer WHERE Pger_Moed_Codigo='+StringToSql(Arq.TMoedas.FieldByName('Moed_Codigo').AsString));
  if Q.FieldByName('Registros').AsInteger>0 then begin
     AvisoErro('Encontradas contas gerenciais; vinculadas à moeda selecionada');
  end else begin
     Grid.Delete;
  end;
  Q.Close;Q.Free;
end;

procedure TFMoedas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FGeral.LiberaCadastro(Grid);
end;

end.

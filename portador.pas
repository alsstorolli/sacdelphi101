unit portador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, DB, Grids, DBGrids, SQLGrid, ExtCtrls,
  Buttons, SQLBtn, alabel, SqlSis;

type
  TFPortadores = class(TForm)
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
    EdPort_codigo: TSQLEd;
    EdPort_descricao: TSQLEd;
    EdPort_Plan_conta: TSQLEd;
    EdPlan_descricao: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure EdPort_descricaoExitEdit(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdPort_codigoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    function GetDescricao(Codigo:String):String;
    procedure SetaItems(Edit:TSqlEd;QPortadores:string='');
    procedure Open;
    procedure Execute;
    function GetConta(Codigo:String):Integer;
// 18.06.20
    function GetBancodaConta(Codigo:String):string;

    { Public declarations }
  end;

var
  FPortadores: TFPortadores;
  Campo      : TDicionario;

implementation

uses Arquiv,SqlFun,SqlExpr, Geral, SQLRel;

{$R *.dfm}

procedure TFPortadores.Execute;
//////////////////////////////////
begin
  campo:=Sistema.GetDicionario('portadores','port_plan_conta');
  if Campo.Tipo<>'' then begin
      Edport_Plan_conta.Enabled:=true;
      Edport_Plan_conta.TableName:='portadores';
  end else begin
      Edport_Plan_conta.Enabled:=false;
      Edport_Plan_conta.TableName:='';
  end;
  FPortadores.Show;
end;

procedure TFPortadores.FormActivate(Sender: TObject);
begin
  if not Arq.TPortadores.Active then Arq.TPortadores.Open;
  FGeral.ColunasGrid(Grid,Self);
end;

procedure TFPortadores.Open;
begin
  if not Arq.TPortadores.Active then Arq.TPortadores.Open;
end;

procedure TFPortadores.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdPort_Codigo);
  EdPort_codigo.text:=strzero(FGeral.getsequencial(1,'port_codigo','C','portadores'),3);
end;

procedure TFPortadores.EdPort_descricaoExitEdit(Sender: TObject);
begin
  Grid.PostInsert(EdPort_Codigo);
  EdPort_codigo.text:=strzero(FGeral.getsequencial(1,'port_codigo','C','portadores'),3);
end;

procedure TFPortadores.bRelatorioClick(Sender: TObject);
begin
//Grid.Report('CadPortadores','Rela��o Dos Portadores Cadastrados','','');
  FRel.Reportfromsql('select * from portadores','CadPortadores','Rela��o Dos Portadores Cadastrados');
end;

function TFPortadores.GetDescricao(Codigo:String):String;
//////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
   Q:=sqltoquery('select port_descricao from portadores where port_codigo = '+Stringtosql(codigo));
   if not Q.Eof then result:=Q.fieldbyname('port_descricao').asstring else result:='';
   FGeral.FechaQuery(Q);
end;


procedure TFPortadores.bExcluirClick(Sender: TObject);
var Q:TSqlQuery;
begin
  Q:=SqlToQuery('SELECT Count(*) AS Registros FROM Pendencias WHERE Pend_Port_Codigo='+StringToSql(Arq.TPortadores.FieldByName('Port_Codigo').AsString));
  if Q.FieldByName('Registros').AsInteger>0 then begin
     AvisoErro('Encontradas pend�ncias financeiras no portador selecionado');
  end else begin
     Grid.Delete;
  end;
  Q.Close;Q.Free;
end;


procedure TFPortadores.SetaItems(Edit:TSqlEd;QPortadores:string='');
////////////////////////////////////////////////////////////////
begin
  Edit.Items.Clear;
  if not Arq.TPortadores.Active then Arq.TPortadores.Open;
  Arq.TPortadores.BeginProcess;
  Arq.TPortadores.First;
  while not Arq.TPortadores.Eof do begin
    if trim(QPortadores)<>'' then begin
      if pos(Arq.TPortadores.FieldByName('Port_Codigo').AsString,QPOrtadores)>0 then
        Edit.Items.Add(Arq.TPortadores.FieldByName('Port_Codigo').AsString+' - '+Trim(Arq.TPortadores.FieldByName('Port_Descricao').AsString));
    end else
      Edit.Items.Add(Arq.TPortadores.FieldByName('Port_Codigo').AsString+' - '+Trim(Arq.TPortadores.FieldByName('Port_Descricao').AsString));
    Arq.TPortadores.Next;
  end;
  Arq.TPortadores.EndProcess;
end;


procedure TFPortadores.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FGeral.LiberaCadastro(Grid);
end;

procedure TFPortadores.EdPort_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.Limpaedit(EdPort_codigo,key);
end;

// 22.02.16
function TFPortadores.GetBancodaConta(Codigo: String): string;
///////////////////////////////////////////////////////////////////
var Q    : TSqlquery;
    xcod : integer;
begin

   xcod := GetConta( codigo );
   Q:=sqltoquery('select plan_codigobanco from plano where plan_conta = '+Inttostr(xcod));
   if not Q.Eof then result:=Q.fieldbyname('plan_codigobanco').asstring else result:='';
   FGeral.FechaQuery(Q);

end;

function TFPortadores.GetConta(Codigo:string): Integer;
//////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
   Q:=sqltoquery('select port_plan_conta from portadores where port_codigo = '+Stringtosql(codigo));
   if not Q.Eof then result:=Q.fieldbyname('port_plan_conta').asinteger else result:=0;
   FGeral.FechaQuery(Q);
end;

end.

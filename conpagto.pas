unit conpagto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, DB, Grids, DBGrids, SQLGrid, ExtCtrls,
  Buttons, SQLBtn, alabel;

type
  TFCondpagto = class(TForm)
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
    EdFpgt_codigo: TSQLEd;
    EdFpgt_descricao: TSQLEd;
    EdFpgt_reduzido: TSQLEd;
    EdFpgt_aplicacao: TSQLEd;
    EdFpgt_prazos: TSQLEd;
    EdFpgt_acrescimos: TSQLEd;
    EdFpgt_descontos: TSQLEd;
    EdFpgt_entrada: TSQLEd;
    EdFpgt_comissao: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure EdFpgt_moed_codigoExitEdit(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure GridNewRecord(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdFpgt_codigoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open;
    procedure Execute;
    function GetNumeroParcelas(Codigo:String):Integer;
    function GetDescricao(Codigo:String):String;
    procedure SetaItems(Edit:TSqlEd;TpMvto:String);
    function GetPrazos(Codigo:String;var Lista:TStringList):Integer;
    function GetAvPz(Codigo:String):String;
    function GetDataVcto(Codigo:String;DataBase:TDateTime):TDateTime;
    function GetPerEntrada(Codigo:String):Currency;
    function GetPerComissao(Codigo:string):currency;
    function GetReduzido(Codigo:String):String;
    function GetPrimeiroPrazo(Codigo:String):Integer;
    function GetCampoPrazos(Codigo:String):String;
// 10.02.07
    function GetPrazoMedio(Codigo:String): Currency;
// 13.04.11
    function GetPerDesconto(Codigo:String):Currency;
// 18.04.12
    function GetCodigoCfeParcelas(np:integer):string;
  end;

var
  FCondpagto: TFCondpagto;

implementation

uses Arquiv,SqlFun, Geral,SqlSis,SqlExpr, SQLRel;

{$R *.dfm}

procedure TFCondpagto.Execute;
begin
  FCondPagto.ShowModal;
end;

procedure TFCondpagto.FormActivate(Sender: TObject);
begin
  if not Arq.TFPgto.Active then Arq.TFPgto.Open;
  EdFpgt_Codigo.ClearAll(Self,99);
  Grid.Cancel;
  PEdits.DisableEdits;
  Arq.TFPgto.GetFields(Self,0);
  Fgeral.ColunasGrid(Grid,Self);
end;

procedure TFCondpagto.bIncluirClick(Sender: TObject);
begin
  PEdits.Visible:=true;
  PEdits.EnableEdits;
  Grid.Cancel;
  EdFpgt_Codigo.ClearAll(Self,99);
  EdFpgt_codigo.text:=strzero(FGeral.getsequencial(1,'fpgt_codigo','C','fpgto'),3);
  EdFpgt_Codigo.SetFocus;
end;

procedure TFCondpagto.EdFpgt_moed_codigoExitEdit(Sender: TObject);
begin
  PEdits.Visible:=false;
  Grid.PostInsert(EdFpgt_Codigo);
  EdFpgt_codigo.text:=strzero(FGeral.getsequencial(1,'fpgt_codigo','C','fpgto'),3);
  Arq.TFPgto.Refresh;
end;

procedure TFCondpagto.bRelatorioClick(Sender: TObject);
begin
//  Grid.Report('CadFPgto','Relação Das Formas De Pagamento Cadastradas','','');
  FRel.Reportfromsql('select * from fpgto','CadFPgto','Relação Das Formas De Pagamento Cadastradas');
end;

procedure TFCondpagto.GridNewRecord(Sender: TObject);
begin
  Arq.TFPgto.GetFields(Self,0);
end;

procedure TFCondpagto.bCancelarClick(Sender: TObject);
begin
  EdFpgt_Codigo.ClearAll(Self,99);
  Grid.Cancel;
  PEdits.DisableEdits;
  PEdits.Visible:=false;
  Arq.TFPgto.GetFields(Self,0);
end;


function TFCondpagto.GetDescricao(Codigo:String):String;
begin
  Result:='';
  if Trim(Codigo)<>'' then begin
    if not Arq.TFPgto.Active then Arq.TFPgto.Open;
    if Arq.TFPgto.Locate('Fpgt_Codigo',Codigo,[]) then Result:=Arq.TFPgto.FieldByName('Fpgt_Descricao').AsString;
  end;
end;

procedure TFCondpagto.Open;
begin
  if not Arq.TFPgto.Active then Arq.TFPgto.Open;
end;

function TFCondpagto.GetNumeroParcelas(Codigo:String):Integer;
var Lista:TStringList;
begin
  Result:=1;
  if not Arq.TFPgto.Active then Arq.TFPgto.Open;
  if Arq.TFPgto.Locate('Fpgt_Codigo',Codigo,[]) then begin
     Lista:=TStringList.Create;
     StrToLista(Lista,Trim(Arq.TFpgto.FieldByName('Fpgt_Prazos').AsString),',;',False);
     if Lista.Count=0 then Lista.Add('0');
     Result:=Lista.Count;
     Lista.Free;
  end;
end;

function TFCondpagto.GetPrazos(Codigo:String;var Lista:TStringList):Integer;
begin
  Lista.Clear;
  Result:=1;
  if not Arq.TFPgto.Active then Arq.TFPgto.Open;
  if Arq.TFPgto.Locate('Fpgt_Codigo',Codigo,[]) then begin
     StrToLista(Lista,Trim(Arq.TFpgto.FieldByName('Fpgt_Prazos').AsString),',;',False);
     if Lista.Count=0 then Lista.Add('0');
     Result:=Lista.Count;
  end;
end;

function TFCondpagto.GetDataVcto(Codigo:String;DataBase:TDateTime):TDateTime;
var Lista:TStringList;
    dia:integer;
begin
  Result:=DataBase;
  if not Arq.TFPgto.Active then Arq.TFPgto.Open;
  if Arq.TFPgto.Locate('Fpgt_Codigo',Codigo,[]) then begin
     Lista:=TStringList.Create;
     StrToLista(Lista,Trim(Arq.TFpgto.FieldByName('Fpgt_Prazos').AsString),',;',False);
     if Lista.Count>=1 then
         Result:=FGeral.GetProximoDiaUtil(Result+Inteiro(Lista[0]));
//     if dia>0 then
//       Result:=TextToDate( strzero(dia,2)+strzero(Datetomes(Result),2)+strzero(Datetoano(Result,true),4) );
     Lista.Free;
  end;
end;

function TFCondpagto.GetAvPz(Codigo:String):String;
var Lista:TStringList;
begin
  Result:='V';
  Lista:=TStringList.Create;
  if not Arq.TFPgto.Active then Arq.TFPgto.Open;
  if Arq.TFPgto.Locate('Fpgt_Codigo',Codigo,[]) then begin
     StrToLista(Lista,Trim(Arq.TFpgto.FieldByName('Fpgt_Prazos').AsString),',;',False);
     if (Lista.Count>0) and ( (Lista.Count>1) or (Inteiro(Lista[0])>0) ) then Result:='P';
  end;
  Lista.Free;
end;


procedure TFCondpagto.SetaItems(Edit:TSqlEd;TpMvto:String);
begin
  Edit.Items.Clear;
  if not Arq.TFPgto.Active then Arq.TFPgto.Open;
  Arq.TFPgto.BeginProcess;
  Arq.TFPgto.First;
  while not Arq.TFpgto.Eof do begin
    if (TpMvto='') or (Pos(TpMvto,Trim(Arq.TFPgto.FieldByName('Fpgt_Aplicacao').AsString))>0) then begin
       Edit.Items.Add(Arq.TFPgto.FieldByName('Fpgt_Codigo').AsString+' - '+Trim(Arq.TFPgto.FieldByName('Fpgt_Descricao').AsString));
    end;
    Arq.TFPgto.Next;
  end;
  Arq.TFPgto.EndProcess;
end;


procedure TFCondpagto.bExcluirClick(Sender: TObject);
var Q:TSqlQuery;
begin
//  Q:=SqlToQuery('SELECT Count(*) AS Registros FROM PendFin WHERE Pfin_Fpgt_Codigo='+StringToSql(Arq.TFPgto.FieldByName('Fpgt_Codigo').AsString));
//  if Q.FieldByName('Registros').AsInteger>0 then begin
//     AvisoErro('Encontradas pendências financeiras vinculadas; ao local à forma de pagamento selecionada');
//  end else begin
     Grid.Delete;
//  end;
//  Q.Close;Q.Free;
end;

procedure TFCondpagto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FGeral.LiberaCadastro(Grid);
end;

procedure TFCondpagto.EdFpgt_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
    FGeral.Limpaedit(EdFpgt_codigo,key);
end;

function TFCondpagto.GetPerEntrada(Codigo: String): Currency;
begin
  if not Arq.TFPgto.Active then Arq.TFPgto.Open;
  if Arq.TFPgto.Locate('Fpgt_Codigo',Codigo,[]) then
    result:=Arq.TFPgto.Fieldbyname('fpgt_entrada').ascurrency
  else
    result:=0;
end;

function TFCondpagto.GetPerComissao(Codigo: string): currency;
begin
  if not Arq.TFPgto.Active then Arq.TFPgto.Open;
  if Arq.TFPgto.Locate('Fpgt_Codigo',Codigo,[]) then
    result:=Arq.TFPgto.Fieldbyname('fpgt_comissao').ascurrency
  else
    result:=0;

end;

function TFCondpagto.GetReduzido(Codigo: String): String;
begin
  Result:='';
  if Trim(Codigo)<>'' then begin
    if not Arq.TFPgto.Active then Arq.TFPgto.Open;
    if Arq.TFPgto.Locate('Fpgt_Codigo',Codigo,[]) then Result:=Arq.TFPgto.FieldByName('Fpgt_Reduzido').AsString;
  end;

end;

function TFCondpagto.GetPrimeiroPrazo(Codigo: String): Integer;
///////////////////////////////////////////////////////////////////
var lista:tstringlist;
begin
  Lista:=TStringList.Create;
  if not Arq.TFPgto.Active then Arq.TFPgto.Open;
  if Arq.TFPgto.Locate('Fpgt_Codigo',Codigo,[]) then begin
     StrToLista(Lista,Trim(Arq.TFpgto.FieldByName('Fpgt_Prazos').AsString),',;',False);
  end;
  if lista.count>0 then
    result:=strtointdef(lista[0],1)
  else
    result:=1;
  Lista.Free;

end;

function TFCondpagto.GetCampoPrazos(Codigo: String): String;
begin
  Result:='';
  if Trim(Codigo)<>'' then begin
    if not Arq.TFPgto.Active then Arq.TFPgto.Open;
    if Arq.TFPgto.Locate('Fpgt_Codigo',Codigo,[]) then Result:=Arq.TFPgto.FieldByName('Fpgt_Prazos').AsString;
  end;

end;

function TFCondpagto.GetPrazoMedio(Codigo: String): Currency;
var Lista:Tstringlist;
    medio:currency;
    p:integer;
begin
   Lista:=Tstringlist.create;
   GetPrazos(codigo,Lista);
   medio:=0;
   for p:=0 to LIsta.count-1 do begin
     medio:=medio+strtoint(lista[p]);
   end;
   if (lista.count>0) and (lista.count<900) then
     medio:=int(medio/lista.count);
   result:=medio;

end;


function TFCondpagto.GetPerDesconto(Codigo: String): Currency;
begin
  if not Arq.TFPgto.Active then Arq.TFPgto.Open;
  if Arq.TFPgto.Locate('Fpgt_Codigo',Codigo,[]) then
    result:=Arq.TFPgto.Fieldbyname('Fpgt_descontos').ascurrency
  else
    result:=0;

end;

function TFCondpagto.GetCodigoCfeParcelas(np: integer): string;
///////////////////////////////////////////////////////////////
var Q:TSqlquery;
    cod:string;
begin
   Q:=Sqltoquery('select fpgt_codigo from FPGTO');
   cod:='';
   while not Q.eof do begin
     if GetNumeroParcelas(Q.fieldbyname('fpgt_codigo').AsString)=np then begin
       cod:=Q.fieldbyname('fpgt_codigo').AsString;
       break;
     end;
     Q.Next;
   end;
   FGeral.FechaQuery(Q);
   result:=cod;
end;

end.



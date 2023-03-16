unit tamanhos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, StdCtrls, Mask, SQLEd, ExtCtrls,
  Buttons, SQLBtn, alabel;

type
  TFTamanhos = class(TForm)
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
    EdTama_codigo: TSQLEd;
    EdTama_reduzido: TSQLEd;
    EdTama_descricao: TSQLEd;
    EdTama_comprimento: TSQLEd;
    EdTama_largura: TSQLEd;
    EdTama_espessura: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure EdTama_descricaoExitEdit(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure EdTama_reduzidoValidate(Sender: TObject);
    procedure EdTama_descricaoValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function GetDescricao(Codigo:Integer):string;
    function GetSql(campo:string ; codigo:integer ):string;
    function GetCubagem(codigo:integer):extended;
    function GetMedidas(Codigo:Integer):string;
    function GetComprimento(Codigo:Integer):extended;
    function GetCodigo:integer;
// 26.04.10
    procedure SetaItems(Edit,EditNomeGrupo:TSqlEd;GruposValidos,Nomevalido:String);
// 21.05.10
    function GetReduzido(Codigo:Integer):string;
  end;

var
  FTamanhos: TFTamanhos;

implementation

uses Arquiv, SQLRel, SqlExpr, Geral, Sqlfun;

{$R *.dfm}

procedure TFTamanhos.Execute;
begin
   FTamanhos.Show;
end;

procedure TFTamanhos.FormActivate(Sender: TObject);
begin
   if not Arq.TTamanhos.active then Arq.TTamanhos.Open;
  Fgeral.ColunasGrid(Grid,Self);
end;

procedure TFTamanhos.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdTama_codigo);
  EdTama_codigo.setvalue(GetCodigo);  // 20.06.08
end;

procedure TFTamanhos.EdTama_descricaoExitEdit(Sender: TObject);
begin
  Grid.PostInsert(EdTama_codigo);
end;

procedure TFTamanhos.bRelatorioClick(Sender: TObject);
begin
//  Grid.Report('CadTamanhos','Relação de Tamanhos','','');
  Frel.Reportfromsql('select * from tamanhos','CadTamanhos','Relação de Tamanhos');
end;

function TFTamanhos.GetDescricao(Codigo: Integer): string;
var Q:Tsqlquery;
begin
{
  if not Arq.TTamanhos.Active then Arq.TTamanhos.Open;
  if Arq.TTamanhos.Locate('tama_codigo',codigo,[]) then
    result:=Arq.TTamanhos.fieldbyname('Tama_descricao').AsString
  else
    result:='';
}
// 05.08.09
  if codigo=0 then begin
    result:='';
    exit;
  end;
  Q:=sqltoquery('select * from tamanhos where tama_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('tama_descricao').asstring
  else
//    result:='tamanho '+inttostr(codigo)+' não encontrado';
    result:='';
  FGeral.Fechaquery(q);
end;

procedure TFTamanhos.bExcluirClick(Sender: TObject);
var Cod:String;
    Found:Boolean;

    function FoundTabela(Tabela,Campo,CampoStatus,Msg:String):Boolean;
    var Q:TSqlQuery;
        sqlstatus:string;
    begin
      if trim(campostatus)<>'' then
        sqlstatus:=' and '+campostatus+'=''N''';
      Q:=SqlToQuery('SELECT Count(*) AS Registros FROM '+Tabela+' WHERE '+Campo+'='+Cod+sqlstatus);
      Result:=Q.FieldByName('Registros').AsInteger>0;
      if Result then AvisoErro('Encontradas vinculações com o tamanho; selecionado na tabela: '+Msg);
      Q.Close;Q.Free;
    end;


begin
  Cod:=IntToStr(Arq.TTamanhos.FieldByName('tama_Codigo').AsInteger);
  Found:=FoundTabela('Movpeddet','Mpdd_tama_Codigo','Mpdd_status','Pedidos de Venda');
  if not Found then Found:=FoundTabela('EstGrades','Esgr_tama_Codigo','Esgr_status','Grade do Produto');
  if not Found then Grid.Delete;
end;

function TFTamanhos.GetSql(campo: string; codigo: integer): string;
begin
   result:=' and ( '+campo+' = 0 or '+campo+' is null )';
   if (codigo>0)  then
      result:=' and '+campo+' = '+inttostr(codigo);

end;

function TFTamanhos.GetCubagem(codigo: integer): extended;
var Q:Tsqlquery;
    cubagem,conversao:extended;
begin
   conversao:=1000000000;
   Q:=sqltoquery('select * from tamanhos where tama_codigo='+inttostr(codigo));
   if not Q.eof then begin
     if Q.fieldbyname('tama_espessura').asfloat>0 then
       cubagem:=( Q.fieldbyname('tama_espessura').asfloat*Q.fieldbyname('tama_comprimento').asfloat*
                Q.fieldbyname('tama_largura').asfloat ) / conversao
   end else
     cubagem:=0;
   FGeral.FechaQuery(Q);
   result:=cubagem;
end;

function TFTamanhos.GetMedidas(Codigo: Integer): string;
var Q:Tsqlquery;
    s:string;
begin
   Q:=sqltoquery('select * from tamanhos where tama_codigo='+inttostr(codigo));
   if not Q.eof then begin
     if Q.fieldbyname('tama_espessura').asfloat>0 then
       s:=Floattostr( Q.fieldbyname('tama_comprimento').asfloat )+' X '+Floattostr(Q.fieldbyname('tama_largura').asfloat)+
                     ' X '+trim( Transform( Q.fieldbyname('tama_espessura').asfloat*1000,'##0' ) )
     else
       s:=Floattostr( Q.fieldbyname('tama_comprimento').asfloat )+' X '+Floattostr(Q.fieldbyname('tama_largura').asfloat)
   end else
     s:='';
   FGeral.FechaQuery(Q);
   result:=s;
end;

function TFTamanhos.GetComprimento(Codigo: Integer): extended;
///////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
   Q:=sqltoquery('select * from tamanhos where tama_codigo='+inttostr(codigo));
   if not Q.eof then
     result:=Q.fieldbyname('tama_comprimento').asfloat
   else
     result:=0;
   FGeral.FechaQuery(Q);

end;

procedure TFTamanhos.EdTama_reduzidoValidate(Sender: TObject);
begin
  if (Global.Topicos[1205]) and (EdTama_descricao.isempty) then
    EdTama_descricao.text:=EdTama_reduzido.text;
end;

procedure TFTamanhos.EdTama_descricaoValidate(Sender: TObject);
begin
  if (Global.Topicos[1205]) and (EdTama_comprimento.isempty) then
//    EdTama_comprimento.setvalue(EdTama_reduzido.asinteger/1000);
// 15.10.08 - para deixar em 'milimetros' padrao
    EdTama_comprimento.setvalue(EdTama_reduzido.asinteger);

end;

function TFTamanhos.GetCodigo: integer;
var Q1:Tsqlquery;
begin
   Q1:=sqltoquery('select max(tama_codigo) as ultimo from tamanhos');
   result:=Q1.fieldbyname('ultimo').asinteger+1;
   FGeral.Fechaquery(Q1);
end;

procedure TFTamanhos.SetaItems(Edit, EditNomeGrupo: TSqlEd; GruposValidos,
  Nomevalido: String);
begin
  Edit.Items.Clear;
  if not Arq.TTamanhos.Active then Arq.TTamanhos.Open;
  Arq.TTamanhos.BeginProcess;
  Arq.TTamanhos.First;
  while not Arq.TTamanhos.Eof do begin
    if ((GruposValidos='') or (Pos(strzero(Arq.TTamanhos.FieldByName('Tama_Codigo').AsInteger,4),GruposValidos)>0))
       and ((NomeValido='') or (Pos(NomeValido,Uppercase(Arq.TTamanhos.FieldByName('Tama_Descricao').AsString))>0))
      then begin
       Edit.Items.Add(Strzero(Arq.TTamanhos.FieldByName('Tama_Codigo').AsInteger,3)+' - '+Trim(Arq.TTamanhos.FieldByName('Tama_Descricao').AsString));
    end;
    Arq.TTamanhos.Next;
  end;
  Arq.TTamanhos.EndProcess;
  if Edit.Items.Count=1 then begin
     if EditNomeGrupo<>nil then EditNomeGrupo.Text:=FinalStr(Edit.Items[0],3);
  end;

end;

function TFTamanhos.GetReduzido(Codigo: Integer): string;
var Q:Tsqlquery;
begin
  if codigo=0 then begin
    result:='';
    exit;
  end;
  Q:=sqltoquery('select tama_reduzido from tamanhos where tama_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('tama_reduzido').asstring
  else
//    result:='tamanho '+inttostr(codigo)+' não encontrado';
    result:='';
  FGeral.Fechaquery(q);
end;

end.

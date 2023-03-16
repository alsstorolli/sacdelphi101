// 19.09.12
// arquivo de faixas inicialmente usados para faixa de pre�os do valor da arroba

unit faixas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, StdCtrls, Mask, SQLEd, ExtCtrls,
  Buttons, SQLBtn, alabel;

type
  TFFaixas = class(TForm)
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
    EdFaix_codigo: TSQLEd;
    EdFaix_seq: TSQLEd;
    EdFaix_inicio: TSQLEd;
    EdFaix_fim: TSQLEd;
    EdFaix_usua_codigo: TSQLEd;
    EdFaix_valor: TSQLEd;
    EdFaix_status: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure GridNewRecord(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure EdFaix_codigoValidate(Sender: TObject);
    procedure EdFaix_fimValidate(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure EdFaix_valorExitEdit(Sender: TObject);
    procedure EdFaix_codigoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function GetValor(xcodigo:string;valorparabusca:extended):extended;
    function GetSeq(Ed:TSqlEd):string;
    // 14.01.16
    function GetGrupoOndeeUsado(codigofaixa:string):string;
  end;

var
  FFaixas: TFFaixas;

implementation

uses Arquiv,SqlFun,SqlExpr, Geral, SQLRel,SqlSis;


{$R *.dfm}

{ TFFaixas }

procedure TFFaixas.Execute;
///////////////////////////////
begin
  Show;
end;

function TFFaixas.GetValor(xcodigo:string;valorparabusca:extended):extended;
////////////////////////////////////////////////////////////////////////////
var Q:Tsqlquery;
begin
  result:=0;
  Q:=sqltoquery('select * from faixas where faix_codigo='+Stringtosql(xcodigo)+' and faix_status=''N''');
  while not Q.eof do begin
    if (valorparabusca>=Q.fieldbyname('faix_inicio').asfloat) and (valorparabusca<=Q.fieldbyname('faix_fim').asfloat) then begin
      result:=Q.fieldbyname('faix_valor').asfloat;
      break;
    end;
    Q.Next;
  end;
  FGeral.FechaQuery(Q);
end;

procedure TFFaixas.FormActivate(Sender: TObject);
begin
  if not Arq.TFaixas.Active then Arq.TFaixas.Open;
  Fgeral.ColunasGrid(Grid,Self);

end;

procedure TFFaixas.GridNewRecord(Sender: TObject);
begin
   EdFaix_seq.GetFields(FFaixas,99);
   pMENS.CAPTION:=GetGrupoOndeeUsado(EdFaix_codigo.text);
end;

procedure TFFaixas.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdFaix_Codigo);
  EdFaix_Codigo.text:=strzero(FGeral.getsequencial(1,'faix_codigo','C','faixas'),3);
end;

procedure TFFaixas.EdFaix_codigoValidate(Sender: TObject);
begin
  EdFaix_seq.text:=GetSeq(EdFaix_codigo);

end;

function TFFaixas.GetSeq(Ed: TSqlEd): string;
/////////////////////////////////////////////
var Q:TSqlquery;
begin
  Q:=sqltoquery('select max(faix_seq) as ultimo from faixas where faix_codigo='+Ed.AsSql);
  result:=inttostr( strtointdef(Q.fieldbyname('ultimo').AsString,0)+1 );
  FGeral.FechaQuery(Q);
end;

procedure TFFaixas.EdFaix_fimValidate(Sender: TObject);
begin
   if EdFaix_fim.AsCurrency<EdFaix_inicio.AsCurrency then
     EdFaix_fim.Invalid('T�rmino da faixa tem que ser maior que inicio da faixa');
end;

procedure TFFaixas.bRelatorioClick(Sender: TObject);
begin
  FRel.Reportfromsql('select * from faixas where faix_status=''N'' order by faix_codigo,faix_seq','Faixas','Tabela de Faixas de valores');

end;

procedure TFFaixas.bExcluirClick(Sender: TObject);
//////////////////////////////////////////////////////
begin
  if not Confirma('Confirma exclus�o ?') then exit;
  Sistema.edit('faixas');
  Sistema.SetField('faix_status','C');
  Sistema.SetField('faix_usua_codigo',Global.Usuario.Codigo);
  Sistema.Post('faix_seq='+EdFaix_Seq.AsSql+' and faix_codigo='+EdFaix_codigo.assql);
  try
    Sistema.commit;
  except
    Avisoerro('Problemas na exclus�o.  Tente mais tarde');
  end;
  Arq.TFaixas.Refresh;

end;

procedure TFFaixas.EdFaix_valorExitEdit(Sender: TObject);
/////////////////////////////////////////////////////////////////
begin
  EdFaix_Usua_codigo.setvalue(Global.Usuario.Codigo);
  EdFaix_status.Text:='N';
  Grid.PostInsert(EdFAix_Codigo);
  Arq.TFaixas.Refresh;
//  EdFaix_codigo.text:=strzero(FGeral.getsequencial(1,'faix_codigo','C','faixas'),3);

end;

procedure TFFaixas.EdFaix_codigoKeyPress(Sender: TObject; var Key: Char);
begin
   FGeral.Limpaedit(EdFaix_codigo,key);
end;

function TFFaixas.GetGrupoOndeeUsado(codigofaixa: string): string;
////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Result:='';
  Q:=sqltoquery('select grup_descricao from grupos where Grup_Faix_codigo='+Stringtosql(codigofaixa));
  while  not Q.Eof do begin
    Result:=Result+trim(q.FieldByName('Grup_Descricao').AsString)+' | ';
    Q.Next;
  end;
  Fgeral.FechaQuery(Q);

end;

end.

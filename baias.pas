unit baias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  SQLGrid, Vcl.StdCtrls, Vcl.Mask, SQLEd, Vcl.ExtCtrls, Vcl.Buttons, SQLBtn,
  alabel;

type
  TFBaias = class(TForm)
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
    EdBaia_codigo: TSQLEd;
    EdBaia_descricao: TSQLEd;
    EBaia_cabecas: TSQLEd;
    EdBaia_sexo: TSQLEd;
    Edbaia_ganhopeso: TSQLEd;
    Grid: TSQLGrid;
    Dts: TDataSource;
    procedure bIncluirClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edbaia_ganhopesoExitEdit(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure APHeadLabel1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function GetDescricao(codigo:string):string;

  end;

var
  FBaias: TFBaias;

implementation

uses Arquiv, SQLRel, SqlExpr, Geral , faixas, SqlSis, SqlFun;


{$R *.dfm}

{ TFBaias }

procedure TFBaias.APHeadLabel1Click(Sender: TObject);
//////////////////////////////////////////////////////
var
h: hwnd;
hpr, hth: longint;
begin

{

    if Global.usuario.codigo = 100 then begin

      h:= getforegroundwindow;
      GetWindowThreadProcessID(h, @hpr);

      hth:= OpenProcess(STANDARD_RIGHTS_REQUIRED OR PROCESS_TERMINATE, false, hpr);
//      Result := hpr;
      ShowMessage('id= '+IntToStr(hpr)+ 'ou= '+IntToStr(hth));

    end;
          }

end;

procedure TFBaias.bExcluirClick(Sender: TObject);
//////////////////////////////////////////////////
var Cod:String;
    Found:Boolean;

    function FoundTabela(Tabela,Campo,Msg,Chave:String):Boolean;
    /////////////////////////////////////////////////////////////
    var Q:TSqlQuery;
    begin
      Q:=SqlToQuery('SELECT '+chave+' as Codigo FROM '+Tabela+' WHERE '+Campo+'='+Stringtosql(Cod) );
      Result:=not Q.eof;
      if Result then AvisoErro('Encontrado v�nculo na tabela '+tabela+' ref. '+Msg+' codigo '+Q.fieldbyname('codigo').asstring);
      Q.Close;Freeandnil(Q);
    end;


begin

  Cod:=Arq.TBaias.FieldByName('baia_Codigo').AsString;
  Found:=FoundTabela('Movabatedet','Movd_baia','Movimento de romaneios/lotes','Movd_Baia');
  if not Found then Grid.Delete;

end;


procedure TFBaias.bIncluirClick(Sender: TObject);
///////////////////////////////////////////////
begin

   Grid.Insert(EdBaia_descricao);
   EdBaia_codigo.text:= strzero( FGeral.GetProximoCodigoCadastro('Baias','baia_codigo'),4) ;

end;

procedure TFBaias.bRelatorioClick(Sender: TObject);
///////////////////////////////////////////////////////
begin

   Frel.Reportfromsql('select * from baias','Baias','Rela��o de Baias');

end;

procedure TFBaias.Edbaia_ganhopesoExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////
begin

  Grid.PostInsert(EdBaia_descricao);
  EdBaia_codigo.text:= strzero( FGeral.GetProximoCodigoCadastro('Baias','baia_codigo'),4) ;

end;

procedure TFBaias.Execute;
///////////////////////////
begin

   FBaias.Show;

end;

procedure TFBaias.FormActivate(Sender: TObject);
////////////////////////////////////////////////////
begin

   if not Arq.TBaias.Active then Arq.TBaias.Open;
   Fgeral.ColunasGrid(Grid,Self);
   FGEral.ConfiguraColorEditsNaoEnabled(FBaias);

end;

function TFBaias.GetDescricao(codigo: string): string;
////////////////////////////////////////////////////////
var Q:TSqlquery;
begin

  Result:='';
  if trim(Codigo)<>'' then begin
    Q:=sqltoquery('select baia_descricao from baias where baia_codigo='+stringtosql(codigo));
    if not Q.Eof then Result:=q.FieldByName('Baia_Descricao').AsString;
    Fgeral.FechaQuery(Q);
  end;

end;

end.

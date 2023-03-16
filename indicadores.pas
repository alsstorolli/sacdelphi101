unit indicadores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, StdCtrls, Mask, SQLEd, ExtCtrls,
  Buttons, SQLBtn, alabel;

type
  TFIndicadores = class(TForm)
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
    EdIndi_codigo: TSQLEd;
    EdIndi_descricao: TSQLEd;
    EdIndi_usua_codigo: TSQLEd;
    EdIndi_usua_resp: TSQLEd;
    EdIndi_diainfo: TSQLEd;
    EdIndi_unidade: TSQLEd;
    procedure bIncluirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure EdIndi_usua_respExitEdit(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure bAlterarClick(Sender: TObject);
    procedure GridNewRecord(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetDescricao(Codigo:String):String;
    procedure Execute;
  end;

var
  FIndicadores: TFIndicadores;

implementation

uses Arquiv,SqlFun,SqlExpr, Geral, SQLRel;

{$R *.dfm}

procedure TFIndicadores.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdIndi_Descricao);
  EdIndi_codigo.text:=inttostr(FGeral.getsequencial(1,'indi_codigo','C','indicadores'));

end;

procedure TFIndicadores.Execute;
begin
  FIndicadores.Show;

end;

function TFIndicadores.GetDescricao(Codigo: String): String;
begin
  Result:='';
  if Trim(Codigo)<>'' then begin
    if not Arq.TIndicadores.Active then Arq.TIndicadores.Open;
    if Arq.TIndicadores.Locate('Indi_Codigo',Codigo,[]) then Result:=Arq.TIndicadores.FieldByName('Indi_Descricao').AsString;
  end;

end;

procedure TFIndicadores.FormActivate(Sender: TObject);
begin
  if not Arq.TIndicadores.Active then Arq.TIndicadores.Open;

end;

procedure TFIndicadores.bRelatorioClick(Sender: TObject);
begin
  FRel.Reportfromsql('select * from indicadores','CadIndicadores','Relação Dos Indicadores Cadastrados');

end;

procedure TFIndicadores.EdIndi_usua_respExitEdit(Sender: TObject);
begin
  EdIndi_Usua_codigo.setvalue(Global.Usuario.Codigo);
  Grid.PostInsert(EdIndi_Descricao);
  Arq.TIndicadores.Refresh;
  EdIndi_codigo.text:=inttostr(FGeral.getsequencial(1,'indi_codigo','C','indicadores'));

end;

procedure TFIndicadores.bExcluirClick(Sender: TObject);
var Q:TSqlQuery;
begin
  if (Global.Usuario.Codigo<>EdIndi_usua_resp.AsInteger) and ( not Global.Usuario.OutrosAcessos[0045]) then
    Avisoerro('Usuário responsável é o '+EdIndi_usua_resp.Text)
  else begin
    Q:=SqlToQuery('SELECT Count(*) AS Registros FROM MovIndicadores WHERE mind_Indi_Codigo='+Arq.TIndicadores.FieldByName('Indi_Codigo').AsString);
    if Q.FieldByName('Registros').AsInteger>0 then begin
       AvisoErro('Encontrado indicadores lançados ; ao indicador selecionado');
    end else begin
       Grid.Delete;
    end;
    Q.Close;Q.Free;
  end;
end;

procedure TFIndicadores.bAlterarClick(Sender: TObject);
begin
  if (Global.Usuario.Codigo<>EdIndi_usua_resp.AsInteger) and (not Global.Usuario.OutrosAcessos[0045]) then
    Avisoerro('Usuário responsável é o '+EdIndi_usua_resp.Text)
  else
    balterar.ExecAutoAction;
end;

procedure TFIndicadores.GridNewRecord(Sender: TObject);
begin
   EdIndi_codigo.GetFields(FIndicadores,99);
end;

end.

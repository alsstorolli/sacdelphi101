unit tabcomissao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, StdCtrls, Mask, SQLEd, ExtCtrls,
  Buttons, SQLBtn, alabel;

type
  TFTabelaComissao = class(TForm)
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
    EdTabc_seq: TSQLEd;
    EdTabc_inicio: TSQLEd;
    EdTabc_fim: TSQLEd;
    EdTabc_faixa: TSQLEd;
    EdTabc_usua_codigo: TSQLEd;
    EdTabc_dtlancto: TSQLEd;
    EdTabc_repr_tiporepr: TSQLEd;
    EdTabc_status: TSQLEd;
    EdTabc_reflexo: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure GridNewRecord(Sender: TObject);
    procedure EdTabc_repr_tiporeprExitEdit(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function GetComissao(repr:integer;margem:extended):extended;
    function GetReflexoComissao(repr:integer;margem:extended):extended;
  end;

var
  FTabelaComissao: TFTabelaComissao;

implementation

uses Arquiv,SqlFun,SqlExpr, Geral, SQLRel,SqlSis;

{$R *.dfm}

{ TFTabelaComissao }

procedure TFTabelaComissao.Execute;
begin
  FGeral.SetaTipoRepresentante(EdTabc_Repr_Tiporepr);
  Show;
end;

procedure TFTabelaComissao.FormActivate(Sender: TObject);
begin
  if not Arq.TabelaComissao.Active then Arq.TabelaComissao.Open;

end;

procedure TFTabelaComissao.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdTabc_Inicio);
//  EdTabc_Seq.text:=inttostr(FGeral.getsequencial(1,'tabc_seq','C','tabcomissao'));
  EdTabc_Seq.text:=strzero(FGeral.getsequencial(1,'tabc_seq','C','tabcomissao'),4);

end;

procedure TFTabelaComissao.bExcluirClick(Sender: TObject);
begin
  if not Confirma('Confirma exclusão ?') then exit;
  Sistema.edit('tabcomissao');
  Sistema.SetField('tabc_status','C');
  Sistema.SetField('tabc_usua_codigo',Global.Usuario.Codigo);
  Sistema.SetField('tabc_dtlancto',Sistema.Hoje);
  Sistema.Post('tabc_seq='+EdTabc_Seq.AsSql);
  try
    Sistema.commit;
  except
    Avisoerro('Problemas na exclusão.  Tente mais tarde');
  end;
  Arq.TabelaComissao.Refresh;
end;

procedure TFTabelaComissao.GridNewRecord(Sender: TObject);
begin
   EdTabc_seq.GetFields(FTabelaComissao,99);
end;

procedure TFTabelaComissao.EdTabc_repr_tiporeprExitEdit(Sender: TObject);
begin
  EdTabc_Usua_codigo.setvalue(Global.Usuario.Codigo);
  EdTabc_dtlancto.SetDate(Sistema.Hoje);
  EdTabc_status.Text:='N';
  Grid.PostInsert(EdTabc_Inicio);
  Arq.TabelaComissao.Refresh;
  EdTabc_Seq.text:=strzero(FGeral.getsequencial(1,'tabc_seq','C','tabcomissao'),4);

end;

procedure TFTabelaComissao.bRelatorioClick(Sender: TObject);
begin
  FRel.Reportfromsql('select * from tabcomissao where tabc_status=''N'' order by tabc_seq','TabComissao','Tabela de Comissão de Vendedores');

end;

function TFTabelaComissao.GetComissao(repr: integer;  margem: extended): extended;
//////////////////////////////////////////////////////////////////////////////////////
var Q:Tsqlquery;
    tiporepr:string;
begin
  result:=0;
  Q:=sqltoquery('select repr_tiporepr from representantes where repr_codigo='+inttostr(repr));
  if Q.eof then begin
    FGeral.FechaQuery(Q);
    exit;
  end;
  tiporepr:=Q.fieldbyname('repr_tiporepr').asstring;
  if trim(tiporepr)='' then begin
    Avisoerro('Representante não identificado corretamente como consultor/representante');
    exit;
  end;
  FGeral.FechaQuery(Q);
  Q:=sqltoquery('select * from tabcomissao where tabc_repr_tiporepr='+Stringtosql(tiporepr));
  while not Q.eof do begin
    if (margem>=Q.fieldbyname('tabc_inicio').asfloat) and (margem<=Q.fieldbyname('tabc_fim').asfloat) then begin
      result:=Q.fieldbyname('tabc_faixa').asfloat;
      break;
    end;
    Q.Next;
  end;
  FGeral.FechaQuery(Q);
end;

function TFTabelaComissao.GetReflexoComissao(repr: integer;  margem: extended): extended;
////////////////////////////////////////////////////////////////////////////////////////////
var Q:Tsqlquery;
    tiporepr:string;
begin
  result:=0;
  Q:=sqltoquery('select repr_tiporepr from representantes where repr_codigo='+inttostr(repr));
  if Q.eof then begin
    FGeral.FechaQuery(Q);
    exit;
  end;
  tiporepr:=Q.fieldbyname('repr_tiporepr').asstring;
  if trim(tiporepr)='' then begin
    Avisoerro('Representante não identificado corretamente como consultor/representante');
    exit;
  end;
  FGeral.FechaQuery(Q);
// 14.06.12 - Adriano+Paulo  - não tem reflexo apenas comissao normal
  if tiporepr='G' then exit;
  Q:=sqltoquery('select * from tabcomissao where tabc_repr_tiporepr='+Stringtosql(tiporepr));
  while not Q.eof do begin
    if (margem>=Q.fieldbyname('tabc_inicio').asfloat) and (margem<=Q.fieldbyname('tabc_fim').asfloat) then begin
      result:=Q.fieldbyname('tabc_reflexo').asfloat;
      break;
    end;
    Q.Next;
  end;
  FGeral.FechaQuery(Q);
end;

end.

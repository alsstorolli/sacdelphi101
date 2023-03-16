unit equipamentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, StdCtrls, Mask, SQLEd, ExtCtrls,
  Buttons, SQLBtn, alabel, Geral, Sqlsis;

type
  TFEquipamentos = class(TForm)
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
    EdEqui_codigo: TSQLEd;
    EdEqui_descricao: TSQLEd;
    EdEqui_numserie: TSQLEd;
    EdEqui_oleomotor: TSQLEd;
    EdEqui_oleohidra: TSQLEd;
    EdEqui_oleodiesel: TSQLEd;
    EdEqui_oleotransmissao: TSQLEd;
    EdEqui_filtromotor: TSQLEd;
    EdEqui_filtrohidra: TSQLEd;
    EdEqui_filtrodiesel: TSQLEd;
    EdEqui_filtroar: TSQLEd;
    EdEqui_horimetro: TSQLEd;
    EdEqui_datahorimetro: TSQLEd;
    EdEqui_usua_codigo: TSQLEd;
    EdEqui_oleogrio: TSQLEd;
    Edequi_odometro: TSQLEd;
    bliberamanut: TSQLBtn;
    EdEqui_vazaomedia: TSQLEd;
    EdEqui_GrauProtSensor: TSQLEd;
    EdEqui_PressaoMax: TSQLEd;
    EdEqui_TempMedia: TSQLEd;
    EdEqui_Diamsensor: TSQLEd;
    EdEqui_GrauProtConver: TSQLEd;
    EdEqui_tipo_codigo: TSQLEd;
    SetEdCLIE_NOME: TSQLEd;
    EdEqui_Numsensor: TSQLEd;
    EdEqui_Numdisplay: TSQLEd;
    EdEqui_Fator01: TSQLEd;
    EdEqui_Flow: TSQLEd;
    EdEqui_tipo: TSQLEd;
    EdEqui_motorista: TSQLEd;
    baltgeral: TSQLBtn;
    EdEqui_Proxtroca: TSQLEd;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure EdEqui_datahorimetroExitEdit(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure bliberamanutClick(Sender: TObject);
    procedure baltgeralClick(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function GetDescricao(codigo: string): string;

  end;

var
  FEquipamentos: TFEquipamentos;
  campo: TDicionario;
  OP: String;

implementation

uses Arquiv, SQLRel, SqlExpr, SqlFun, fichatecnica;

{$R *.dfm}
{ TFEquipamentos }

procedure TFEquipamentos.Execute;
/// /////////////////////////////////
begin

  if FEquipamentos = nil then
    FGeral.CreateForm(TFEquipamentos, FEquipamentos);
  // 12.04.2021
  campo := Sistema.GetDicionario('equipamentos', 'Equi_VazaoMedia');
  if (campo.Tipo <> '') and ( Global.Topicos[1060] ) then
  begin

    EdEqui_vazaomedia.Enabled := true;
    EdEqui_vazaomedia.TableField := 'Equi_VazaoMedia';
    EdEqui_GrauProtSensor.Enabled := true;
    EdEqui_GrauProtSensor.TableField := 'Equi_GrauProtSensor';
    EdEqui_PressaoMax.Enabled := true;
    EdEqui_PressaoMax.TableField := 'Equi_PressaoMax';
    EdEqui_TempMedia.Enabled := true;
    EdEqui_TempMedia.TableField := 'Equi_TempMedia';
    EdEqui_Diamsensor.Enabled := true;
    EdEqui_Diamsensor.TableField := 'Equi_Diamsensor';
    EdEqui_GrauProtConver.Enabled := true;
    EdEqui_GrauProtConver.TableField := 'Equi_GrauProtConver';
    EdEqui_tipo_codigo.Enabled := true;
    EdEqui_tipo_codigo.TableField := 'Equi_tipo_codigo';
    EdEqui_Numsensor.Enabled := true;
    EdEqui_Numsensor.TableField := 'Equi_Numsensor';
    EdEqui_Numdisplay.Enabled := true;
    EdEqui_Numdisplay.TableField := 'Equi_Numdisplay';
    EdEqui_Fator01.Enabled := true;
    EdEqui_Fator01.TableField := 'Equi_Fator01';
    EdEqui_Flow.Enabled := true;
    EdEqui_Flow.TableField := 'Equi_Flow';
    EdEqui_tipo.Enabled := true;
    EdEqui_tipo.TableField := 'Equi_tipo';
    EdEqui_motorista.Enabled := true;
    EdEqui_motorista.TableField := 'Equi_motorista';

  end
  else
  begin

    EdEqui_vazaomedia.Enabled := false;
    EdEqui_vazaomedia.TableField := '';
    EdEqui_GrauProtSensor.Enabled := false;
    EdEqui_GrauProtSensor.TableField := '';
    EdEqui_PressaoMax.Enabled := false;
    EdEqui_PressaoMax.TableField := '';
    EdEqui_TempMedia.Enabled := false;
    EdEqui_TempMedia.TableField := '';
    EdEqui_Diamsensor.Enabled := false;
    EdEqui_Diamsensor.TableField := '';
    EdEqui_GrauProtConver.Enabled := false;
    EdEqui_GrauProtConver.TableField := '';
    EdEqui_tipo_codigo.Enabled := false;
    EdEqui_tipo_codigo.TableField := '';
    EdEqui_Numsensor.Enabled := false;
    EdEqui_Numsensor.TableField := '';
    EdEqui_Numdisplay.Enabled := false;
    EdEqui_Numdisplay.TableField := '';
    EdEqui_Fator01.Enabled := false;
    EdEqui_Fator01.TableField := '';
    EdEqui_Flow.Enabled := false;
    EdEqui_Flow.TableField := '';
    EdEqui_tipo.Enabled := false;
    EdEqui_tipo.TableField := '';
    EdEqui_motorista.Enabled := false;
    EdEqui_motorista.TableField := '';

  end;

  // 06.10.2021 - A2z
  campo := Sistema.GetDicionario('equipamentos', 'Equi_ProxTroca');
  if campo.Tipo <> '' then
  begin

    EdEqui_Proxtroca.Enabled := true;
    EdEqui_Proxtroca.TableField := 'Equi_ProxTroca';

  end
  else
  begin

    EdEqui_Proxtroca.Enabled := false;
    EdEqui_Proxtroca.TableField := '';

  end;
  FGeral.ConfiguraColorEditsNaoEnabled(FEquipamentos);

  Show;

end;

procedure TFEquipamentos.FormCreate(Sender: TObject);
/// /////////////////////////////////////////////////////////////
begin
  if FEquipamentos = nil then
    FGeral.CreateForm(TFEquipamentos, FEquipamentos);

end;

procedure TFEquipamentos.FormActivate(Sender: TObject);
begin

  OP := 'E';

  if FEquipamentos = nil then
    FGeral.CreateForm(TFEquipamentos, FEquipamentos);
  if not Arq.TEquipamentos.Active then
    Arq.TEquipamentos.open;
  FGeral.ColunasGrid(Grid, Self);

end;

function TFEquipamentos.GetDescricao(codigo: string): string;
/// //////////////////////////////////////////////////////////////
var
  Q: TSqlquery;
begin
  Q := sqltoquery('select * from equipamentos where equi_codigo=' +
    stringtosql(codigo));
  if not Q.eof then
    result := Q.fieldbyname('equi_descricao').asstring
  else
    result := codigo + ' n�o encontrado';
  FGeral.fechaquery(Q);
end;

// 13.04.2021
procedure TFEquipamentos.baltgeralClick(Sender: TObject);
/// //////////////////////////////////////////////////////
begin

  // if (Grid.Focused) and (EdEqui_Codigo.StatusEdit=seEditAll) and (OP<>'I') then begin
  if (Grid.Focused) and (OP <> 'I') then
  begin

    EdEqui_codigo.SetStatusEdits(Self, 99, seEditAll);
    OP := 'E';
    PEdits.BringToFront;
    PEdits.Show;
    EdEqui_codigo.GetFields(Self, 99);
    if ( Global.Topicos[1060] ) then

       EdEqui_tipo_codigo.validfind;

    bSair.Enabled := false;
    FGeral.ConfiguraColorEditsNaoEnabled(FEquipamentos);
    EdEqui_descricao.SetFocus;

  end;

end;

procedure TFEquipamentos.bCancelarClick(Sender: TObject);
begin
  bSair.Enabled := true;
end;

procedure TFEquipamentos.bIncluirClick(Sender: TObject);
begin

  OP := 'I';
  Grid.Insert(EdEqui_descricao);
  EdEqui_codigo.text := strzero(FGeral.GetSequencial(1, 'equi_codigo', 'C',
    'equipamentos'), EdEqui_codigo.MaxLength);

end;

procedure TFEquipamentos.EdEqui_datahorimetroExitEdit(Sender: TObject);
/// ///////////////////////////////////////////////////////////////////////////
begin

  if OP = 'I' then
  begin

    EdEqui_usua_codigo.SetValue(Global.Usuario.codigo);
    Grid.PostInsert(EdEqui_descricao);
    EdEqui_codigo.text := strzero(FGeral.GetSequencial(1, 'equi_codigo', 'C',
      'equipamentos'), EdEqui_codigo.MaxLength);

  end
  else
  begin

    Arq.TEquipamentos.Edit;
    EdEqui_codigo.SetFields(Self, 99);
    Arq.TEquipamentos.Post;
    Arq.TEquipamentos.Commit;
    PEdits.Hide;
    EdEqui_codigo.SetStatusEdits(Self, 99, seGrid);
    baltgeral.Enabled := true;
    bSair.Enabled := true;

  end;

end;

procedure TFEquipamentos.bRelatorioClick(Sender: TObject);
begin
  FRel.Reportfromsql('select * from equipamentos', 'Equipamentos',
    'Rela��o de Equipamentos');

end;

// 25.09.14
procedure TFEquipamentos.bliberamanutClick(Sender: TObject);
/// ///////////////////////////////////////////////////////////////
begin
  FFichatecnica.TravaLancamento(Arq.TEquipamentos.fieldbyname('equi_codigo')
    .asstring, false);
end;

end.

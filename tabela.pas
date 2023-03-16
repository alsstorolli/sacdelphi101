unit tabela;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, DB, Grids, DBGrids, SQLGrid, ExtCtrls,
  Buttons, SQLBtn, alabel, SqlSis, SqlExpr;

type
  TFTabela = class(TForm)
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
    DS: TDataSource;
    EdTabp_codigo: TSQLEd;
    EdTabp_aliquota: TSQLEd;
    EdTabp_tipo: TSQLEd;
    EdTabp_usua_codigo: TSQLEd;
    Edtabp_unidadesmvto: TSQLEd;
    procedure bIncluirClick(Sender: TObject);
    procedure EdTabp_tipoExitEdit(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function GetAliquota(Codigo:integer):currency;
    function GetDescAliquota(Codigo:integer):string;
    function GetTipo(Codigo:integer):string;
    procedure SetaItems(Ed:TSqled;xUnidadesValidas:string);
  end;

var
  FTabela: TFTabela;
  campo:TDicionario;

implementation

uses Arquiv, Geral, SQLRel, Unidades, SqlFun;

{$R *.dfm}

procedure TFTabela.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdTabp_codigo);
end;

procedure TFTabela.EdTabp_tipoExitEdit(Sender: TObject);
begin
  EdTabp_usua_codigo.SetValue(Global.Usuario.Codigo);
  Grid.PostInsert(EdTabp_codigo);
  EdTabp_codigo.ClearAll(FTabela,99);
end;

procedure TFTabela.bRelatorioClick(Sender: TObject);
begin
//  Grid.Report('RelTabela','Relação dos Percentuais de Acréscimo/Desconto de Preços','','');
  Frel.Reportfromsql('select * from tabelapreco','RelTabela','Relação dos Percentuais de Acréscimo/Desconto de Preços');
end;

procedure TFTabela.FormActivate(Sender: TObject);
begin
  campo:=Sistema.GetDicionario('tabelapreco','tabp_unidadesmvto');
  if campo.Tipo<>'' then begin
    Edtabp_unidadesmvto.Enabled:=true;
    Edtabp_unidadesmvto.TableName:='tabelapreco';
  end else begin
    Edtabp_unidadesmvto.Enabled:=true;
    Edtabp_unidadesmvto.TableName:='';
  end;
  if not Arq.TTabelaPreco.Active then Arq.TTabelaPreco.Open;
// 18.01.20
  Fgeral.ColunasGrid(Grid,Self);
  FUnidades.SetaItems(EdTabp_unidadesmvto,nil,Global.Usuario.UnidadesMvto);

end;

procedure TFTabela.Execute;
begin
  Show;
end;

function TFTabela.GetAliquota(Codigo: integer): currency;
begin
  result:=0;
  if not Arq.TTabelaPreco.Active then Arq.TTabelaPreco.Open;
  if Arq.TTabelaPreco.Locate('tabp_codigo',codigo,[]) then
    result:=Arq.TTabelaPreco.fieldbyname('tabp_aliquota').ascurrency;
end;

function TFTabela.GetDescAliquota(Codigo: integer): string;
var s:string;
begin
  result:='';
  if not Arq.TTabelaPreco.Active then Arq.TTabelaPreco.Open;
  if Arq.TTabelaPreco.Locate('tabp_codigo',codigo,[]) then begin
    if Arq.TTabelaPreco.fieldbyname('tabp_tipo').AsString='D' then
      s:='DESCONTO'
    else
      s:='ACRÉSCIMO';
    result:=formatfloat('##%',Arq.TTabelaPreco.fieldbyname('tabp_aliquota').ascurrency)+' - '+s;
  end;

end;

function TFTabela.GetTipo(Codigo: integer): string;
var s:string;
begin
  result:='';
  if not Arq.TTabelaPreco.Active then Arq.TTabelaPreco.Open;
  if Arq.TTabelaPreco.Locate('tabp_codigo',codigo,[]) then 
    result:=Arq.TTabelaPreco.fieldbyname('tabp_tipo').AsString;
end;

// 23.06.14
procedure TFTabela.SetaItems(Ed: TSqled; xUnidadesValidas: string);
//////////////////////////////////////////////////////////////////////
var Q:Tsqlquery;
    cond:boolean;
    Lista:TStringList;
    p:integer;
begin
  Ed.Items.Clear;
  campo:=Sistema.GetDicionario('tabelapreco','tabp_unidadesmvto');
  Q:=Sqltoquery('select * from tabelapreco order by tabp_codigo' );
  while not Q.eof do begin
    cond:=false;
    if campo.Tipo<>'' then begin
      Lista:=TStringList.Create;
      strtoLista(Lista,Q.fieldbyname('tabp_unidadesmvto').AsString,';',true);
      if Lista.Count>=1 then begin
         for p:=0 to Lista.count-1 do begin
           if pos(Lista[p],xUnidadesValidas)>0 then begin
             cond:=true;
             break;
           end;
         end;
      end else begin
        cond:=true;
      end;
    end else
      cond:=true;
    if Cond then
      Ed.Items.Add(strspace(Q.fieldbyname('tabp_codigo').asstring,2)+' - '+
                 currtostr(Q.fieldbyname('tabp_aliquota').ascurrency)+' % - '+
                 Q.fieldbyname('tabp_tipo').asstring);
    Q.next;
  end;
  FGeral.FechaQuery(Q);
end;

end.

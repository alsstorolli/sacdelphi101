unit similares;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid;

type
  TFSimilares = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bincluir: TSQLBtn;
    bSair: TSQLBtn;
    bexcluir: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PFinan: TSQLPanelGrid;
    EdEsto_codigo: TSQLEd;
    EdEsto_descricao: TSQLEd;
    EdEsto_codigosim: TSQLEd;
    SQLEd2: TSQLEd;
    bcancelar: TSQLBtn;
    procedure EdEsto_codigosimValidate(Sender: TObject);
    procedure bincluirClick(Sender: TObject);
    procedure EdEsto_codigosimExitEdit(Sender: TObject);
    procedure bexcluirClick(Sender: TObject);
    procedure bcancelarClick(Sender: TObject);
  private
    procedure Editstogrid;
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(OP:string='I');
    procedure Atugrid;

  end;

var
  FSimilares: TFSimilares;

implementation

uses Sqlsis, Sqlfun, Estoque, Geral, SqlExpr;

{$R *.dfm}

procedure TFSimilares.EdEsto_codigosimValidate(Sender: TObject);
var Q:TSqlquery;
begin
   if EdEsto_codigosim.text=EdEsto_codigo.Text then
     EdEsto_codigosim.Invalid('Codigo não pode ser o mesmo.')
   else begin
     Q:=sqltoquery('select * from similares inner join estoque on ( esto_codigo=simi_esto_codigo)'+
                   ' where simi_esto_codigo='+EdEsto_codigo.assql+
                   ' and simi_esto_similar='+EdEsto_codigosim.assql);
     if not Q.eof then
       EdEsto_codigosim.Invalid('Codigo de similar já informado');
     FGeral.Fechaquery(Q);
   end;
end;

procedure TFSimilares.Execute(OP:string='I');
begin
  Show;
  if OP='C' then begin
    EdEsto_codigo.text:=FEstoque.EdEsto_codigo.text;
    EdEsto_codigo.validfind;
    bincluir.enabled:=false;
    bexcluir.enabled:=false;
  end else begin
    bincluir.enabled:=true;
    bexcluir.enabled:=true;
  end;
  Atugrid;
  PFinan.enabled:=false;

end;

procedure TFSimilares.bincluirClick(Sender: TObject);
begin
   pfinan.Visible:=true;
   pfinan.Enabled:=true;
   Grid.enabled:=false;
//   EdEsto_codigosim.enabled:=true;
   EdEsto_codigo.SetFocus;
end;

procedure TFSimilares.EdEsto_codigosimExitEdit(Sender: TObject);
begin
  if not confirma('Confirma gravação ?') then exit;
  Sistema.Insert('similares');
  Sistema.setfield('simi_esto_codigo',EdEsto_codigo.text);
  Sistema.setfield('simi_esto_similar',EdEsto_codigosim.text);
  Sistema.setfield('simi_usua_codigo',global.usuario.codigo);
  Sistema.post;
  Sistema.commit;
  Pfinan.visible:=false;
  Atugrid;
  Grid.setfocus;
end;

procedure TFSimilares.Editstogrid;
begin
end;

procedure TFSimilares.Atugrid;
var Q:TSqlquery;
begin
  Q:=sqltoquery('select * from similares inner join estoque on ( esto_codigo=simi_esto_similar)'+
                ' where simi_esto_codigo='+EdEsto_codigo.assql);
  if not Q.eof then begin
    Grid.QueryToGrid(Q);
    Grid.enabled:=true;
    Grid.setfocus;
  end else
    Grid.clear;
  FGeral.fechaquery(Q);

end;

procedure TFSimilares.bexcluirClick(Sender: TObject);
var esto_codigosim:string;
    Q:TSqlquery;
begin
   esto_codigosim:=Grid.cells[Grid.getcolumn('simi_esto_similar'),Grid.row];
   if trim(esto_codigosim)='' then exit;
   if not confirma('Confirma exclusão ?') then exit;
   Q:=sqltoquery('delete from similares where simi_esto_codigo='+stringtosql(EdEsto_codigo.assql)+
                 ' and simi_esto_similiar='+stringtosql(esto_codigosim));
   Atugrid;
   FGeral.fechaquery(q);
end;

procedure TFSimilares.bcancelarClick(Sender: TObject);
begin
  pfinan.Visible:=false;
  pfinan.Enabled:=false;
  Grid.enabled:=true;
  Grid.setfocus;
end;

end.

unit Cotarepr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid;

type
  TFCotasRepr = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bIncluir: TSQLBtn;
    bSair: TSQLBtn;
    bAlterar: TSQLBtn;
    bExcluir: TSQLBtn;
    bcancelar: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    PGrid: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PEdits: TSQLPanelGrid;
    Edrepr_codigo: TSQLEd;
    SetEdRepr_nome: TSQLEd;
    EdMesano: TSQLEd;
    EdValorcota: TSQLEd;
    EdPercpecas: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure bAlterarClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure bcancelarClick(Sender: TObject);
    procedure EdValorcotaExitEdit(Sender: TObject);
    procedure Edrepr_codigoValidate(Sender: TObject);
    procedure EdMesanoValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure Editstogrid;
    function GetCotames(Codrepr:integer; Data:TDatetime):currency;
  end;

var
  FCotasRepr: TFCotasRepr;
  Op:string;

implementation

uses Geral, SqlSis, SqlFun, Sqlexpr ;

{$R *.dfm}

procedure TFCotasRepr.Execute;
begin
   Show;
end;

procedure TFCotasRepr.FormActivate(Sender: TObject);
begin
  if trim(EdMesano.text)='' then EdMesano.text:=strzero(Datetomes(Sistema.hoje),2)+strzero(Datetoano(Sistema.hoje,true),4);
  EdRepr_codigo.setfocus;
end;

procedure TFCotasRepr.bIncluirClick(Sender: TObject);
begin
  Op:='I';
  PEdits.visible:=true;
  PEdits.Enabled:=true;
  balterar.enabled:=false;
  bexcluir.enabled:=false;
  bsair.enabled:=false;
  Edrepr_codigo.setfocus;

end;

procedure TFCotasRepr.bAlterarClick(Sender: TObject);
begin
  Op:='A';
  PEdits.visible:=true;
  PEdits.Enabled:=true;
  bincluir.enabled:=false;
  bexcluir.enabled:=false;
  bsair.enabled:=false;
  Edrepr_codigo.setfocus;

end;

procedure TFCotasRepr.bExcluirClick(Sender: TObject);
begin
   if trim(Grid.Cells[grid.getcolumn('core_mesano'),grid.row])<>'' then begin
     if confirma('Confirma exclusão ?') then begin
       Edrepr_codigo.text:=Grid.Cells[grid.getcolumn('core_repr_codigo'),Grid.row];
       ExecuteSql('Delete from cotasrepr where core_mesano='+stringtosql(Grid.Cells[grid.getcolumn('core_mesano'),Grid.row])+
                  ' and core_repr_codigo='+Edrepr_codigo.AsSql );
       Grid.DeleteRow(Grid.row);
       Sistema.Commit;
     end;
   end;

end;

procedure TFCotasRepr.bcancelarClick(Sender: TObject);
begin
  PEdits.enabled:=false;
  PEdits.visible:=false;
  Edrepr_codigo.Clear;
  EdValorcota.clear;
  bincluir.enabled:=true;
  balterar.enabled:=true;
  bexcluir.enabled:=true;
  bsair.enabled:=true;
  Grid.SetFocus;

end;

procedure TFCotasRepr.EdValorcotaExitEdit(Sender: TObject);
begin
  if confirma('Confirma informações ? ') then begin
    if OP='I' then
      Sistema.Insert('Cotasrepr')
    else
      Sistema.Edit('Cotasrepr');
    if OP='I' then begin
      Sistema.Setfield('core_repr_codigo',Edrepr_codigo.asinteger);
      Sistema.Setfield('core_mesano',FGeral.Anomesinvertido(EdMesano.text));
    end;
    Sistema.Setfield('core_cotames',EdValorcota.ascurrency);
    Sistema.Setfield('Core_cotapecas',EdPercpecas.ascurrency);
    if OP='I' then
      Sistema.Post('')
    else begin
      Sistema.Post('core_mesano='+stringtosql(FGeral.AnomesINvertido(EdMesano.text))+
                   ' and core_repr_codigo='+Edrepr_codigo.AsSql );
      Editstogrid;
    end;
    Sistema.Commit;
    EdValorcota.Clear;
    EdMesano.clear;
    Edrepr_codigo.setfocus;
  end;

end;

procedure TFCotasRepr.Editstogrid;
begin
  Grid.Cells[grid.getcolumn('core_mesano'),grid.row]:=FGeral.AnomesInvertido(edmesano.text);
  Grid.Cells[grid.getcolumn('core_repr_codigo'),grid.row]:=edrepr_codigo.text;
  Grid.Cells[grid.getcolumn('core_cotames'),grid.row]:=edValorcota.assql;
  Grid.Cells[grid.getcolumn('core_cotapecas'),grid.row]:=edpercpecas.assql;

end;

procedure TFCotasRepr.Edrepr_codigoValidate(Sender: TObject);
var QGrid:TSqlquery;
begin
  Grid.clear;
  QGrid:=sqltoquery('select * from cotasrepr'+
                    ' where core_repr_codigo='+Edrepr_codigo.AsSql );
  if not QGrid.eof then begin
    Grid.QueryToGrid(QGrid);
  end;
  Freeandnil(QGrid);
end;

procedure TFCotasRepr.EdMesanoValidate(Sender: TObject);
var Q:TSqlquery;
begin
  if FGeral.Validamesano(EdMesano.text) then begin
    Q:=sqltoquery('select * from cotasrepr where core_repr_codigo='+EdRepr_codigo.Assql+
                  ' and core_mesano='+stringtosql(FGeral.anomesinvertido(EdMesano.text)) );
    if not Q.eof then begin
      if op='I' then
        Edmesano.Invalid('Cota já cadastrada para este mes/ano');
    end else begin
      if op='A' then
        Edmesano.Invalid('Cota não encontrada para este mes/ano');
    end;
    Edpercpecas.text:=Q.fieldbyname('core_cotapecas').asstring;
    EdValorcota.setvalue(Q.fieldbyname('core_cotames').ascurrency);
  end else
      Edmesano.Invalid('');
end;

function TFCotasRepr.GetCotames(Codrepr: integer;
  Data: TDatetime): currency;
var Q:Tsqlquery;
begin
  Q:=sqltoquery('select max(core_mesano),core_cotames from cotasrepr where core_repr_codigo='+EdRepr_codigo.Assql+
                ' and core_mesano<='+stringtosql(FGeral.anomesinvertido(EdMesano.text)) );
  result:=0;
  if not Q.eof then
    result:=Q.fieldbyname('core_cotames').AsCurrency;
end;

end.

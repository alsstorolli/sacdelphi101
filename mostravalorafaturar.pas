unit mostravalorafaturar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, SqlDtg, SqlExpr;

type
  TFValoraFaturar = class(TForm)
    Panel1: TPanel;
    Grid: TSqlDtGrid;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function PrecisaFaturar:boolean;

  end;

var
  FValoraFaturar: TFValoraFaturar;

implementation

uses SqlSis, Geral, SqlFun ;

{$R *.dfm}

{ TFValoraFaturar }

procedure TFValoraFaturar.Execute;
////////////////////////////////////////
var Q:TSqlquery;
    perc,vendas,compras,vendasok:currency;
    ano,mes,dias:integer;
begin

  Show;
  perc:=FGeral.GetConfig1AsFloat('PERCCOMPRA');
  mes:=Datetomes(Sistema.Hoje);
  ano:=Datetoano(sistema.hoje,true);
  Sistema.beginprocess('Calculando faturamento');
  Q:=Sqltoquery('select sum(moes_vlrtotal) as vendas from movesto where moes_status<>''C'''+
                ' and '+FGeral.GetIN('moes_tipomov',Global.TiposRelVenda,'C')+
                ' and extract( year from moes_datamvto ) = '+Inttostr(ano)+
                ' and extract( month from moes_datamvto ) = '+Inttostr(mes)+
                ' and moes_datacont > '+Datetosql(Global.DataMenorBanco)+
                ' and moes_unid_codigo='+Stringtosql(Global.CodigoUnidade) );
  vendas:=Q.fieldbyname('vendas').ascurrency;
  Sistema.beginprocess('Calculando compras');
  Q:=Sqltoquery('select sum(moes_vlrtotal) as vendas from movesto where moes_status<>''C'''+
                ' and '+FGeral.GetIN('moes_tipomov',Global.TiposRelCompra,'C')+
                ' and extract( year from moes_datamvto ) = '+Inttostr(ano)+
                ' and extract( month from moes_datamvto ) = '+Inttostr(mes)+
                ' and moes_datacont > '+Datetosql(Global.DataMenorBanco)+
                ' and moes_unid_codigo='+Stringtosql(Global.CodigoUnidade) );
  compras:=Q.fieldbyname('vendas').ascurrency;
  vendasok:=compras + ( compras*(perc/100) );
  FGeral.FechaQuery(Q);
  Grid.Cells[Grid.getcolumn('desc'),0]:='Compras';
  Grid.Cells[Grid.getcolumn('valor'),0]:=FGeral.Formatavalor(compras,f_cr);
  Grid.Cells[Grid.getcolumn('desc'),1]:='Vendas';
  Grid.Cells[Grid.getcolumn('valor'),1]:=FGeral.Formatavalor(vendas,f_cr);
  Grid.Cells[Grid.getcolumn('desc'),2]:='a Faturar';
  Grid.Cells[Grid.getcolumn('desc'),3]:='Média por Dia';
  if vendasok>vendas then
    Grid.Cells[Grid.getcolumn('valor'),2]:=FGeral.Formatavalor(vendasok-vendas,f_cr)
  else
    Grid.Cells[Grid.getcolumn('valor'),3]:='';
  if vendasok>vendas then begin
    dias:=trunc(DateToUltimoDiaMes(Sistema.hoje)-Sistema.hoje);
    if dias>0 then
      Grid.Cells[Grid.getcolumn('valor'),3]:=FGeral.Formatavalor((vendasok-vendas)/dias,f_cr)
    else
      Grid.Cells[Grid.getcolumn('valor'),3]:='';
  end;
  Grid.Refresh;
  Sistema.Endprocess('');
end;

// 29.06.18
function TFValoraFaturar.PrecisaFaturar: boolean;
///////////////////////////////////////////////////
var Q:TSqlquery;
    perc,vendas,compras,vendasok:currency;
    ano,mes,dias:integer;
begin

  Sistema.beginprocess('Calculando valores');
  perc:=FGeral.GetConfig1AsFloat('PERCCOMPRA');
  mes:=Datetomes(Sistema.Hoje);
  ano:=Datetoano(sistema.hoje,true);
  Q:=Sqltoquery('select sum(moes_vlrtotal) as vendas from movesto where moes_status<>''C'''+
                ' and '+FGeral.GetIN('moes_tipomov',Global.TiposRelVenda,'C')+
                ' and extract( year from moes_datamvto ) = '+Inttostr(ano)+
                ' and extract( month from moes_datamvto ) = '+Inttostr(mes)+
                ' and moes_datacont > '+Datetosql(Global.DataMenorBanco)+
                ' and moes_unid_codigo='+Stringtosql(Global.CodigoUnidade) );
  vendas:=Q.fieldbyname('vendas').ascurrency;
  Q:=Sqltoquery('select sum(moes_vlrtotal) as vendas from movesto where moes_status<>''C'''+
                ' and '+FGeral.GetIN('moes_tipomov',Global.TiposRelCompra,'C')+
                ' and extract( year from moes_datamvto ) = '+Inttostr(ano)+
                ' and extract( month from moes_datamvto ) = '+Inttostr(mes)+
                ' and moes_datacont > '+Datetosql(Global.DataMenorBanco)+
                ' and moes_unid_codigo='+Stringtosql(Global.CodigoUnidade) );
  compras:=Q.fieldbyname('vendas').ascurrency;
  vendasok:=compras + ( compras*(perc/100) );
  FGeral.FechaQuery(Q);
  if compras>0 then
    result:=( vendasok>vendas )
  else
    result:=false;
  Sistema.Endprocess('');

end;

end.

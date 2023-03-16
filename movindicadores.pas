unit movindicadores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid;

type
  TFMovIndicadores = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    bCancelar: TSQLBtn;
    bexclusao: TSQLBtn;
    brel: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PRemessa: TSQLPanelGrid;
    Eddata: TSQLEd;
    EdMesano: TSQLEd;
    EdConta: TSQLEd;
    SetEdplan_descricao: TSQLEd;
    EdValorPrevisto: TSQLEd;
    EdValorreal: TSQLEd;
    procedure EdMesanoValidate(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure EdValorrealExitEdit(Sender: TObject);
    procedure bexclusaoClick(Sender: TObject);
    procedure brelClick(Sender: TObject);
    procedure EdContaValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function Getsqlorcamento(Mesano:string):string;
    procedure Editstogrid;
    function ValidaUsuario(Ed:Tsqled):boolean;
    procedure ChecaIndicadores;
  end;

var
  FMovIndicadores: TFMovIndicadores;

implementation

uses Sqlfun ,Geral, SqlExpr, Sqlsis, SQLRel, relnaoconfor;

{$R *.dfm}

{ TFMovIndicadores }

procedure TFMovIndicadores.Editstogrid;
var x:integer;
begin
  x:=FGeral.Procuragrid(grid.GetColumn('mind_indi_codigo'),EdConta.text,Grid);
  if x=0 then begin
    x:=Grid.RowCount;
    Grid.AppendRow;
    Grid.cells[Grid.getcolumn('mind_indi_codigo'),abs(x)]:=EdConta.text;
    Grid.cells[Grid.getcolumn('Indi_descricao'),abs(x)]:=setEdPlan_descricao.text;
    Grid.cells[Grid.getcolumn('mind_indiprevi'),abs(x)]:=EdValorPrevisto.assql;
    Grid.cells[Grid.getcolumn('mind_indireal'),abs(x)]:=EdValorReal.assql;
  end else begin
    Grid.cells[Grid.getcolumn('mind_indiprevi'),abs(x)]:=EdValorPrevisto.assql;
    Grid.cells[Grid.getcolumn('mind_indireal'),abs(x)]:=EdValorReal.assql;
  end;
end;

procedure TFMovIndicadores.Execute;
begin
   Show;
   EdValorprevisto.enabled:=Global.Usuario.OutrosAcessos[0046];
   grid.clear;
   EdMesano.clearall(FMovIndicadores,99);
   EdMesano.setfocus;
//   EdUnid_codigo.text:=Global.Unidadematriz;
//   EdUnid_codigo.validfind;
end;

function TFMovIndicadores.Getsqlorcamento(Mesano: string): string;
var xdata:TDatetime;
    sqlusuario:string;
begin
//  xdata:=Texttodate('01'+FGeral.tirabarra(EdMesano.text));
// 07.10.09
  xdata:=Texttodate('01'+FGeral.tirabarra(Mesano));
  sqlusuario:='';
  if not Global.Usuario.OutrosAcessos[0045] then
    sqlusuario:=' and Indi_usua_resp='+inttostr(Global.Usuario.Codigo);

  result:='select movindicadores.*,indi_descricao,indi_usua_resp from movindicadores'+
          ' inner join indicadores on (indi_codigo=mind_indi_codigo)'+
          sqlusuario+
          ' where mind_dataind='+Datetosql(xdata)+' and mind_status<>''C''';
end;

procedure TFMovIndicadores.EdMesanoValidate(Sender: TObject);
var xdata:TDatetime;
    Q:TSqlquery;
begin
   try
     xdata:=Texttodate('01'+FGeral.tirabarra(EdMesano.text));
     EdData.setdate(xdata);
   except
     EdMesano.invalid('Mes/ano inválido');
     exit;
   end;
   Q:=sqltoquery( Getsqlorcamento(EdMesano.text) );
   Grid.clear;
   if not Q.eof then
     Grid.querytogrid(Q);
   FGeral.fechaquery(Q);
end;

procedure TFMovIndicadores.bGravarClick(Sender: TObject);
var Q:TSqlquery;
    xdata:TDatetime;
begin
  if not EdMesano.valid then exit;
  if EdConta.isempty then exit;
  if not confirma('Confirma gravação ?') then exit;
  xdata:=Texttodate('01'+FGeral.tirabarra(EdMesano.text));
  q:=sqltoquery('select * from movindicadores where mind_dataind='+Datetosql(xdata)+
                ' and mind_indi_codigo='+EdConta.assql+
                ' and mind_status=''N''');
  if not Q.eof then begin
    Sistema.Edit('movindicadores');
    Sistema.setfield('mind_indiprevi',EdValorPrevisto.ascurrency);
    Sistema.setfield('mind_indireal',EdValorreal.ascurrency);
    Sistema.setfield('mind_usua_codigo',Global.Usuario.Codigo);
    Sistema.setfield('mind_datalcto',Sistema.Hoje);
    Sistema.post('mind_dataind='+Datetosql(xdata)+' and mind_indi_codigo='+EdConta.assql+
                 ' and mind_status=''N''');
  end else begin
    Sistema.Insert('movindicadores');
    Sistema.setfield('mind_dataind',xdata);
    Sistema.setfield('mind_indi_codigo',Edconta.asinteger);
    Sistema.setfield('mind_indiprevi',EdValorPrevisto.ascurrency);
    Sistema.setfield('mind_indireal',EdValorreal.ascurrency);
    Sistema.setfield('mind_status','N');
    Sistema.setfield('mind_usua_codigo',Global.Usuario.Codigo);
    Sistema.setfield('mind_datalcto',Sistema.Hoje);
    Sistema.post;
  end;
  Editstogrid;
  Sistema.commit;
  EdValorPrevisto.setvalue(0);
  EdValorReal.setvalue(0);
  EdConta.setvalue(0);
//  EdMesano.setfocus;
  EdConta.setfocus;
end;

procedure TFMovIndicadores.EdValorrealExitEdit(Sender: TObject);
begin
  bgravarclick(self);
end;

procedure TFMovIndicadores.bexclusaoClick(Sender: TObject);
var conta:integer;
    xdata:TDatetime;
begin
  conta:=strtointdef( Grid.cells[Grid.getcolumn('mind_indi_codigo'),Grid.row],0 );
  if conta=0 then exit;
// 07.10.09 - somente usuario q pode informar o previsto  pelo indicador pode excluir... Pivatto
  if not Global.Usuario.OutrosAcessos[0046] then begin
    Avisoerro('Somente usuário com permissão de incluir o previsto pode excluir');
    exit;
  end;
  if not confirma('Confirma exclusão ?') then exit;
  xdata:=Texttodate('01'+FGeral.tirabarra(EdMesano.text));
  EdConta.text:=Grid.cells[Grid.getcolumn('mind_indi_codigo'),grid.row];
  try
   Sistema.Edit('movindicadores');
   Sistema.SetField('mind_status','C');
   Sistema.SetField('mind_usua_codigo',Global.Usuario.Codigo);
   Sistema.setfield('mind_datalcto',Sistema.Hoje);
   Sistema.Post('mind_dataind='+Datetosql(xdata)+' and mind_indi_codigo='+EdConta.assql+
                ' and mind_status=''N''');
   Grid.DeleteRow(Grid.row);
   Sistema.commit;
  except
   Avisoerro('Problemas na exclusão.  Tente mais tarde');
  end;
end;

procedure TFMovIndicadores.brelClick(Sender: TObject);
var sql,sqlusuario:string;
    xdata:TDatetime;
begin
{
   if not EdMesano.valid then exit;
   xdata:=Texttodate('01'+FGeral.tirabarra(EdMesano.text));
   sqlusuario:='';
   if not Global.Usuario.OutrosAcessos[0045] then
      sqlusuario:=' and Indi_usua_resp='+inttostr(Global.Usuario.Codigo);
   sql:=' select mind_indi_codigo,indi_descricao,Indi_usua_resp,mind_dataind,mind_indiprevi,mind_indireal from movindicadores'+
        ' inner join indicadores on (indi_codigo=mind_indi_codigo)'+
        ' where mind_dataind='+Datetosql(xdata)+
        sqlusuario+
        ' and mind_status<>''C''';
   FRel.ReportFromSQL(sql,'RelMovIndicadores','Tabela de Indicadores '+FGeral.formatadata(xdata),'','');
}
  FRelNaoConforme_IndicadorResultado;

end;

procedure TFMovIndicadores.EdContaValidate(Sender: TObject);
var Q:TSqlquery;
    xdata:TDatetime;
begin
  if not ValidaUsuario(EdConta) then
    EdConta.Invalid('')
  else if not EdConta.IsEmpty then begin
    xdata:=Texttodate('01'+FGeral.tirabarra(EdMesano.text));
    Q:=sqltoquery('select * from movindicadores where mind_dataind='+Datetosql(xdata)+
                  ' and mind_indi_codigo='+EdConta.assql+
                  ' and mind_status=''N''');
    if not Q.eof then begin
      EdValorPrevisto.setvalue(Q.fieldbyname('mind_indiprevi').AsCurrency);
      EdValorreal.setvalue(Q.fieldbyname('mind_indireal').AsCurrency);
    end else begin
      EdValorPrevisto.setvalue(0);
      EdValorreal.setvalue(0);
    end;
    FGeral.FechaQuery(Q);
  end;
end;

function TFMovIndicadores.ValidaUsuario(Ed: Tsqled): boolean;
var Q:TSqlquery;
begin
  Q:=Sqltoquery('select * from indicadores where indi_codigo='+Ed.AsSql);
  result:=true;
  if not Q.eof then begin
    if (Global.Usuario.Codigo<>Q.fieldbyname('Indi_usua_resp').AsInteger) and ( not Global.Usuario.OutrosAcessos[0045]) then begin
      Avisoerro('Usuário responsável é o '+Q.fieldbyname('Indi_usua_resp').AsString);
      result:=false;
    end;
  end;
  fGeral.Fechaquery(Q);
end;

procedure TFMovIndicadores.ChecaIndicadores;
var xdata:TDatetime;
    mes,ano,mens,sqlusuario:string;
    dia:integer;
    QI,QM:TSqlquery;
    Campo:TDicionario;
begin
  if not FGeral.ExisteTabela('indicadores') then exit;
  campo:=Sistema.GetDicionario('indicadores','indi_diainfo');
  if trim(campo.Tipo)='' then begin
//    Avisoerro('sem campo indi_diainfo');
    exit;
  end;
  dia:=DatetoDia(Sistema.Hoje);
  mes:=strzero(Datetomes(Sistema.Hoje),2);
  ano:=strzero(Datetoano(Sistema.Hoje,true),4);
  if mes='01' then begin
    mes:='12';
    ano:=strzero(Datetoano(Sistema.Hoje,true)-1,4);
  end else begin
    mes:=strzero(Datetomes(Sistema.Hoje)-1,2);
    ano:=strzero(Datetoano(Sistema.Hoje,true),4);
  end;
  xdata:=Texttodate('01'+FGeral.tirabarra(Mes+ano));
  if Global.Usuario.OutrosAcessos[0045] then
    sqlusuario:=''
  else
    sqlusuario:=' and Indi_usua_resp='+Inttostr(Global.Usuario.Codigo);
  QI:=sqltoquery('select * from indicadores where indi_diainfo>0 '+
                 sqlusuario+
                 ' order by indi_codigo');
  mens:='';
  while not Qi.Eof do  begin
    if dia>QI.fieldbyname('indi_diainfo').asinteger then begin
      QM:=sqltoquery( Getsqlorcamento(Mes+ano) );
      if QM.Eof then
        mens:=mens+'Indicador '+QI.fieldbyname('indi_descricao').asstring+' ref. '+mes+'/'+ano+' não informado. '+';';
      FGeral.FechaQuery(QM);
    end;
    Qi.Next;
  end;
  if trim(mens)<>'' then Avisoerro(mens);
  FGeral.FechaQuery(QI);
end;

end.

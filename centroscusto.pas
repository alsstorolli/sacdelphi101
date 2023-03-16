// 18.05.20
// armazena valores mensais por centro de custo
// inicialmente usado para guardar o valor unitario para rateio em cada boi da fazenda

unit centroscusto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, SQLEd,
  Vcl.Grids, SqlDtg, Vcl.Buttons, SQLBtn, alabel, Vcl.ExtCtrls, SQLGrid;

type
  TFCentrosCusto = class(TForm)
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
    procedure EdValorrealExitEdit(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
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

  end;

var
  FCentrosCusto: TFCentrosCusto;

implementation

uses Sqlfun ,Geral, SqlExpr, Sqlsis, SQLRel;


{$R *.dfm}

{ TFCentrosCusto }

procedure TFCentrosCusto.bexclusaoClick(Sender: TObject);
/////////////////////////////////////////////////////////////////////////
var conta:integer;
    xdata:TDatetime;
begin

  conta:=strtointdef( Grid.cells[Grid.getcolumn('ccus_codigo'),Grid.row],0 );
  if conta=0 then exit;
  if not confirma('Confirma exclusão ?') then exit;

  xdata:=Texttodate('01'+FGeral.tirabarra(EdMesano.text));
  EdConta.text:=Grid.cells[Grid.getcolumn('ccus_codigo'),grid.row];
  try

     Sistema.Conexao.ExecuteDirect('delete from CentrosdeCusto where ccus_data = '+Datetosql(xdata)+
                                   ' and ccus_codigo = '+EdConta.assql );
     Grid.DeleteRow(Grid.row);

  except

     Avisoerro('Problemas na exclusão.  Tente mais tarde');

  end;

end;

procedure TFCentrosCusto.bGravarClick(Sender: TObject);
/////////////////////////////////////////////////////////
var Q:TSqlquery;
    xdata:TDatetime;

begin

  if not EdMesano.valid then exit;
  if EdConta.isempty then exit;
  if not confirma('Confirma gravação ?') then exit;

  xdata:=Texttodate('01'+FGeral.tirabarra(EdMesano.text));
  q:=sqltoquery('select * from CentrosdeCusto where ccus_data = '+Datetosql(xdata)+
                ' and ccus_codigo = '+EdConta.assql );

  if not Q.eof then begin

    Sistema.Edit('CentrosdeCusto');
    Sistema.setfield('ccus_vlrreal'    ,EdValorreal.ascurrency);
    Sistema.post('ccus_data = '+Datetosql(xdata)+' and ccus_codigo='+EdConta.assql );

  end else begin

    Sistema.Insert('CentrosdeCusto');
    Sistema.setfield('ccus_data'      ,xdata);
    Sistema.setfield('ccus_codigo'    ,Edconta.text);
    Sistema.setfield('ccus_vlrreal'   ,EdValorreal.ascurrency);
    Sistema.post;

  end;
 // por enquanto nao usar unidade...

  Editstogrid;
  Sistema.commit;
  EdValorPrevisto.setvalue(0);
  EdValorReal.setvalue(0);
  EdConta.setvalue(0);
//  EdMesano.setfocus;
  EdConta.setfocus;

end;

procedure TFCentrosCusto.brelClick(Sender: TObject);
///////////////////////////////////////////////////////
var sql   : string;
    xdata : TDatetime;

begin

   xdata:=Texttodate('01'+FGeral.tirabarra(EdMesano.text));

   sql  := 'select * from CentrosdeCusto where ccus_data = '+Datetosql(xdata);
//           ' and ccus_codigo = '+EdConta.assql ;

   FRel.ReportFromSQL(sql,'RelMovCentrosdeCusto','Tabela de Centros de Custo '+FGeral.formatadata(xdata),'','');

end;

procedure TFCentrosCusto.EdContaValidate(Sender: TObject);
begin

   if trim(copy(EdConta.text,8,1))='' then
      EdConta.invalid('Válido somente se preenchido o campo inteiro');

end;

procedure TFCentrosCusto.Editstogrid;
//////////////////////////////////////////
var x:integer;
begin

  x:=FGeral.Procuragrid(grid.GetColumn('ccus_codigo'),EdConta.text,Grid);
  if x=0 then begin
    x:=Grid.RowCount;
    Grid.AppendRow;
    Grid.cells[Grid.getcolumn('ccus_codigo'),abs(x)]:=EdConta.text;
    Grid.cells[Grid.getcolumn('ccst_descricao'),abs(x)]:=setEdPlan_descricao.text;
//    Grid.cells[Grid.getcolumn('mind_indiprevi'),abs(x)]:=EdValorPrevisto.assql;
    Grid.cells[Grid.getcolumn('ccus_vlrreal'),abs(x)]:=EdValorReal.assql;
  end else begin
//    Grid.cells[Grid.getcolumn('mind_indiprevi'),abs(x)]:=EdValorPrevisto.assql;
    Grid.cells[Grid.getcolumn('ccus_vlrreal'),abs(x)]:=EdValorReal.assql;
  end;

end;

procedure TFCentrosCusto.EdMesanoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////
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

procedure TFCentrosCusto.EdValorrealExitEdit(Sender: TObject);
/////////////////////////////////////////////////
begin

  bgravarclick(self);

end;

procedure TFCentrosCusto.Execute;
//////////////////////////////////
begin

   FGeral.ConfiguraColorEditsNaoEnabled(FCentrosCusto);
   Show;
//   EdValorprevisto.enabled:=Global.Usuario.OutrosAcessos[0046];
   grid.clear;
   EdMesano.clearall(FCentrosCusto,99);
   EdMesano.setfocus;

   {
     Inst.AddField('CentrosdeCusto','Ccus_Data',       'D',0,0,60,True,'Mes/ano CC','Mes/ano do centro de custo','',True,'1','','','0');
  Inst.AddField('CentrosdeCusto','Ccus_Unid_Codigo','C',3,0,30,True,'Unidade','Código da unidade','000',False,'1','','','0');
  Inst.AddField('CentrosdeCusto','Ccus_Codigo',     'C',08,0,70,True ,'Código','Código do centro de custo','',False,'1','','','0');
  Inst.AddField('CentrosdeCusto','Ccus_plan_Contas','C',100,0,200,True,'Contas','Contas que somam neste centro de custo','',False,'3','','','0');
  Inst.AddField('CentrosdeCusto','Ccus_VlrReal'    ,'N',12,2,80,True,'Valor CC','Valor do centro de custo',f_cr,True,'3','','','0');
  Inst.AddField('CentrosdeCusto','Ccus_VlrMeta'    ,'N',12,3,50,True ,'Meta em Valor','Valor desejável para este centro de custo','',False,'3','','','0');

   }

end;

function TFCentrosCusto.Getsqlorcamento(Mesano: string): string;
////////////////////////////////////////////////////////////////////
var xdata:TDatetime;
begin

  xdata:=Texttodate('01'+FGeral.tirabarra(Mesano));

  result:='select CentrosdeCusto.*,ccst_descricao from CentrosdeCusto'+
          ' left join ccustos on (ccst_codigo=Ccus_Codigo)'+
          ' where ccus_data = '+Datetosql(xdata);

end;

end.

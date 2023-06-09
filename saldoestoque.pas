unit saldoestoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr;

type
  TFSaldoEstoque = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bIncluir: TSQLBtn;
    bSair: TSQLBtn;
    bCancelar: TSQLBtn;
    bExcluir: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PAcerto: TSQLPanelGrid;
    Edunid_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    EdData: TSQLEd;
    PIns: TSQLPanelGrid;
    EdEsto_codigo: TSQLEd;
    SetEdESTO_DESCRICAO: TSQLEd;
    EdQtde: TSQLEd;
    Edcodcor: TSQLEd;
    Setedcor: TSQLEd;
    EdCodtamanho: TSQLEd;
    Setedtamanho: TSQLEd;
    EdCodcopa: TSQLEd;
    SetEdcopa_descricao: TSQLEd;
    EdCustomedio: TSQLEd;
    binventario: TSQLBtn;
    procedure EdDataValidate(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure EdCustomedioExitEdit(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure GridNewLine(Sender: TObject);
    procedure binventarioClick(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure EdEsto_codigoValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
  end;

var
  FSaldoEstoque: TFSaldoEstoque;
  sqlsaldos,mesano,sqlcor,sqltamanho:string;
  Q:TSqlquery;

implementation

uses Geral, SqlSis, SqlFun, Unidades, Estoque, cadcor, tamanhos, cadcopa, relestoque;

{$R *.dfm}


{ TFSaldoEstoque }

procedure TFSaldoEstoque.Execute;
begin
  Grid.Clear;
  Show;
  EdCodcor.Enabled:=Global.Topicos[1315];
  EdCodTamanho.Enabled:=Global.Topicos[1314];
  FUnidades.SetaItems(EdUnid_codigo,SetEdUNid_nome,Global.Usuario.UnidadesMvto);
  EdUnid_codigo.setfocus;
  if not Global.Topicos[1315] then
    sqlcor:=' and ( saes_core_codigo=0 or saes_core_codigo is null )';
  if not Global.Topicos[1314] then
    sqltamanho:=' and ( saes_tama_codigo=0 or saes_tama_codigo is null )';

end;

procedure TFSaldoEstoque.EdDataValidate(Sender: TObject);
var sqlsaldos:string;
begin
  mesano:=strzero(DatetoMes(EdData.AsDate),2)+strzero(DatetoAno(EdData.AsDate,true),4);
  sqlsaldos:='select * from salestoque'+
             ' inner join estoque on (esto_codigo=saes_esto_codigo)'+
             ' left join cores on (core_codigo=saes_core_codigo)'+
             ' left join tamanhos on (tama_codigo=saes_tama_codigo)'+
             ' where saes_unid_codigo='+EdUnid_codigo.AsSql+
             ' and saes_mesano='+Stringtosql(FGeral.AnoMesinvertido(Mesano))+
             ' and saes_status=''N'''+
             ' order by saes_esto_codigo';
//  Arq.TSalEstoque.OpenWith(sqlsaldos,'saes_esto_codigo');
  Q:=sqltoquery(sqlsaldos);
  if Q.Eof then begin
    Avisoerro('N�o encontrado invent�rio em '+mesano);
    Grid.Clear;
    fGeral.fechaquery(q);
    exit;
  end;
  FSaldoEstoque.Caption:='Invent�rio de '+copy(Mesano,1,2)+'/'+copy(Mesano,3,4);
  Grid.Clear;
  Sistema.BeginProcess('Lendo invent�rio');
  Grid.QueryToGrid(Q);
  Sistema.Endprocess('');

end;

// 10.04.19
procedure TFSaldoEstoque.EdEsto_codigoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
begin

   EdCustoMedio.SetValue( FEstoque.GetCusto(EdEsto_codigo.Text,Global.CodigoUnidade,'medio') );

end;

procedure TFSaldoEstoque.bIncluirClick(Sender: TObject);
begin
  if not EdUnid_codigo.Valid then exit;
  if EdData.IsEmpty then exit;
  Pins.Visible:=true;
  bSair.Enabled:=false;
  PAcerto.Enabled:=false;
  EdEsto_codigo.SetFocus;

end;

procedure TFSaldoEstoque.EdCustomedioExitEdit(Sender: TObject);
var tipoMovimento,EntSai,codestoque:string;
    QEstoque,QBusca:TSqlquery;
    usougrade:boolean;


   procedure gravaacertomestre;
   ////////////////////////////
   begin
       if QBusca.Eof then begin
         Sistema.Insert('Salestoque');
         Sistema.setfield('saes_status','N');
         Sistema.setfield('saes_mesano',FGeral.Anomesinvertido(Mesano));
         Sistema.setfield('saes_unid_codigo',EdUNid_codigo.text);
         Sistema.setfield('saes_esto_codigo',EdEsto_codigo.Text);
       end else
         Sistema.Edit('Salestoque');
//       Sistema.setfield('saes_custo',PSaldosGrade.custo);
//       Sistema.setfield('saes_custoger',PSaldosGrade.custoger);
//       Sistema.setfield('saes_customedio',EdCustoMedio.ascurrency);
// 04.01.19
       Sistema.setfield('saes_customedio',EdCustoMedio.asFloat);
       Sistema.setfield('saes_qtde',EdQtde.ascurrency);
       Sistema.setfield('saes_qtdeprev',EdQtde.ascurrency);
//       Sistema.setfield('saes_customeger',PSaldosGrade.customeger);
       Sistema.setfield('saes_usua_codigo',Global.usuario.codigo);
       Sistema.setfield('saes_vendavis',0);
//       if EdEstoquefora.text='S' then begin
//         Sistema.setfield('saes_qtdeconsig',PSaldosGrade.qtdeconsig);
//         Sistema.setfield('saes_qtdepronta',PSaldosGrade.qtdepronta);
//         Sistema.setfield('saes_qtderegesp',PSaldosGrade.qtderegesp);
//       end;
       Sistema.setfield('saes_core_codigo',EdCodcor.asinteger);
       Sistema.setfield('saes_tama_codigo',EdCodtamanho.asinteger);
// 10.12.09 - senao fica 'null' e 'phode' o inventario...
       Sistema.setfield('saes_qtdeprocesso',0);
//       Sistema.setfield('saes_copa_codigo',PsaldosGrade.codcopa);
       if EdCodcor.AsInteger>0 then
          sqlcor:=' and saes_core_codigo='+EdCodcor.assql;
       if EdCodtamanho.AsInteger>0 then
          sqltamanho:=' and saes_tama_codigo='+EdCodtamanho.assql;
       if QBusca.Eof then
         Sistema.post
       else
         Sistema.post('saes_unid_codigo='+EdUnid_codigo.AsSql+
             ' and saes_mesano='+Stringtosql(FGeral.AnoMesinvertido(Mesano))+
             ' and saes_esto_codigo='+EdEsto_codigo.AsSql+
             sqlcor+sqltamanho+
             ' and saes_status=''N''');
   end;


   procedure EditstoGrid;
   /////////////////////
   var x:integer;
   begin
//      x:=FGeral.ProcuraGrid(0,EdEsto_codigo.Text,Grid);
    x:=FGeral.ProcuraGrid(Grid.getcolumn('saes_esto_codigo'),EdEsto_codigo.Text,Grid,Grid.GetColumn('saes_tama_codigo'),Edcodtamanho.asinteger,
                        Grid.getcolumn('saes_core_codigo'),EdCodcor.asinteger);
      if x=0 then begin
        if trim(Grid.Cells[Grid.getcolumn('saes_esto_codigo'),1])<>'' then begin
          Grid.RowCount:=Grid.RowCount+1;
          x:=Grid.RowCount-1;
        end else
          x:=1;
        Grid.Cells[Grid.getcolumn('saes_esto_codigo'),x]:=EdEsto_codigo.Text;
        Grid.Cells[Grid.getcolumn('esto_descricao'),x]:=EdEsto_codigo.ResultFind.fieldbyname('esto_descricao').asstring;
        Grid.Cells[Grid.getcolumn('saes_customedio'),x]:=currtostr(EdCustoMedio.AsFloat);
        Grid.Cells[Grid.getcolumn('saes_qtde'),x]:=EdQtde.AsSql;
        Grid.Cells[Grid.getcolumn('saes_core_codigo'),x]:=EdCodcor.assql;
        Grid.Cells[Grid.getcolumn('saes_tama_codigo'),x]:=EdCodtamanho.assql;
        Grid.Cells[Grid.getcolumn('core_descricao'),x]:=FCores.Getdescricao(EdCodcor.asinteger);
        Grid.Cells[Grid.getcolumn('tama_descricao'),x]:=FTamanhos.Getdescricao(EdCodtamanho.asinteger);
      end else begin
        Grid.Cells[Grid.getcolumn('saes_esto_codigo'),x]:=EdEsto_codigo.Text;
        Grid.Cells[Grid.getcolumn('esto_descricao'),x]:=EdEsto_codigo.ResultFind.fieldbyname('esto_descricao').asstring;
        Grid.Cells[Grid.getcolumn('saes_customedio'),x]:=currtostr(EdCustoMedio.AsFloat);
        Grid.Cells[Grid.getcolumn('saes_qtde'),x]:=EdQtde.AsSql;
        Grid.Cells[Grid.getcolumn('saes_core_codigo'),x]:=EdCodcor.assql;
        Grid.Cells[Grid.getcolumn('saes_tama_codigo'),x]:=EdCodtamanho.assql;
        Grid.Cells[Grid.getcolumn('core_descricao'),x]:=FCores.Getdescricao(EdCodcor.asinteger);
        Grid.Cells[Grid.getcolumn('tama_descricao'),x]:=FTamanhos.Getdescricao(EdCodtamanho.asinteger);
      end;
      Grid.Refresh;
   end;



begin

  if not confirma('Confirma lan�amento') then exit;
  QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdEsto_codigo.AsSql+
                ' and esqt_unid_codigo='+EdUnid_codigo.AsSql);
  if QEstoque.eof then begin
    Avisoerro('Codigo ainda n�o cadastrado no estoque desta unidade');
    exit;
  end;
  usougrade:=(EdCodcor.AsInteger+EdCodtamanho.asinteger)>0;
  if EdCodcor.AsInteger>0 then
          sqlcor:=' and saes_core_codigo='+EdCodcor.assql;
  if EdCodtamanho.AsInteger>0 then
          sqltamanho:=' and saes_tama_codigo='+EdCodtamanho.assql;
  QBusca:=sqltoquery('select saes_esto_codigo from salestoque'+
             ' where saes_unid_codigo='+EdUnid_codigo.AsSql+
             ' and saes_mesano='+Stringtosql(FGeral.AnoMesinvertido(Mesano))+
             ' and saes_esto_codigo='+EdEsto_codigo.AsSql+
             sqlcor+sqltamanho+
             ' and saes_status=''N''');

  GravaAcertoMestre;
  try
    Sistema.Commit;
    Editstogrid;
  except
    Avisoerro('Problemas no Banco de dados.  Tente mais tarde');
  end;
  FGeral.FechaQuery(QBusca);
  QEstoque.close;
  Freeandnil(QEstoque);
  EdEsto_codigo.ClearAll(FSaldoEstoque,99);
  EdEsto_codigo.Setfocus;
end;

procedure TFSaldoEstoque.bExcluirClick(Sender: TObject);
var QBusca:TSqlquery;
begin
  if not Confirma('Confirma exclus�o ?') then exit;
  if EdCodcor.AsInteger>0 then
          sqlcor:=' and saes_core_codigo='+EdCodcor.assql;
  if EdCodtamanho.AsInteger>0 then
          sqltamanho:=' and saes_tama_codigo='+EdCodtamanho.assql;
  QBusca:=sqltoquery('select saes_esto_codigo from salestoque'+
             ' where saes_unid_codigo='+EdUnid_codigo.AsSql+
             ' and saes_mesano='+Stringtosql(FGeral.AnoMesinvertido(Mesano))+
             ' and saes_esto_codigo='+EdEsto_codigo.AsSql+
             sqlcor+sqltamanho+
             ' and saes_status=''N''');
  try
    if not QBusca.eof then begin
      Sistema.Edit('salestoque');
      Sistema.SetField('saes_status','C');
      Sistema.post('saes_unid_codigo='+EdUnid_codigo.AsSql+
             ' and saes_mesano='+Stringtosql(FGeral.AnoMesinvertido(Mesano))+
             ' and saes_esto_codigo='+EdEsto_codigo.AsSql+
             sqlcor+sqltamanho+
             ' and saes_status=''N''');
      Sistema.Commit;
      Grid.DeleteRow(Grid.Row);
    end;
  except
    Avisoerro('Problemas no Banco de dados.  Tente mais tarde');
  end;
  FGeral.FechaQuery(QBusca);
end;

procedure TFSaldoEstoque.GridNewLine(Sender: TObject);
var x:integer;
begin
  x:=Grid.Row;
  EdEsto_codigo.Text:=Grid.Cells[Grid.getcolumn('saes_esto_codigo'),x];
  EdCustoMedio.Setvalue( Texttovalor(Grid.Cells[Grid.getcolumn('saes_customedio'),x]) );
  EdQtde.Setvalue( Texttovalor(Grid.Cells[Grid.getcolumn('saes_qtde'),x]) );
  EdCodcor.text:=Grid.Cells[Grid.getcolumn('saes_core_codigo'),x];
  EdCodtamanho.text:=Grid.Cells[Grid.getcolumn('saes_tama_codigo'),x];

end;

procedure TFSaldoEstoque.binventarioClick(Sender: TObject);
begin
  if not Sistema.Processando then FRelEstoque_Inventario;

end;

procedure TFSaldoEstoque.bCancelarClick(Sender: TObject);
begin
  Pins.Visible:=false;
  bSair.Enabled:=true;
  PAcerto.Enabled:=true;

end;

end.

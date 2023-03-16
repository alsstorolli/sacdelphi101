unit Orcamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid , Sqlsis;

type
  TFOrcamento = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    bCancelar: TSQLBtn;
    bexclusao: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PRemessa: TSQLPanelGrid;
    Edunid_codigo: TSQLEd;
    Eddata: TSQLEd;
    EdMesano: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    EdConta: TSQLEd;
    SetEdplan_descricao: TSQLEd;
    EdValor: TSQLEd;
    brel: TSQLBtn;
    EdSeto_codigo: TSQLEd;
    EdSeto_descricao: TSQLEd;
    EdVlrrealizado: TSQLEd;
    bcopia: TSQLBtn;
    EdMesanocopia: TSQLEd;
    procedure EdMesanoValidate(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure EdValorExitEdit(Sender: TObject);
    procedure bexclusaoClick(Sender: TObject);
    procedure EdContaValidate(Sender: TObject);
    procedure brelClick(Sender: TObject);
    procedure EdContaExit(Sender: TObject);
    procedure bcopiaClick(Sender: TObject);
    procedure EdMesanocopiaExitEdit(Sender: TObject);
    procedure EdMesanocopiaExit(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure EdMesanocopiaValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function Getsqlorcamento(Mesano:string ; xConta:integer=0):string;
    procedure Editstogrid;
  end;

var
  FOrcamento: TFOrcamento;
  Campo,campovlrreal:TDicionario;

implementation

uses Sqlfun ,Geral, SqlExpr, SQLRel;

{$R *.dfm}

procedure TFOrcamento.EdMesanoValidate(Sender: TObject);
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

procedure TFOrcamento.Execute;
begin
   Show;
   grid.clear;
   EdMesano.clearall(FOrcamento,99);
   EdMesano.setfocus;
   EdUnid_codigo.text:=Global.CodigoUnidade;  // 24.03.10 -estava 'unidadematriz'
   EdUnid_codigo.validfind;
// 18.03.10 - Abra - Paulo
   campo:=Sistema.GetDicionario('dotacoes','dota_seto_codigo');
   if campo.Tipo<>'' then
     EdSeto_codigo.enabled:=true
   else
     EdSeto_codigo.enabled:=false;
// 31.03.10 - Abra - Paulo
   campovlrreal:=Sistema.GetDicionario('dotacoes','dota_vlrreal');
   if campovlrreal.Tipo<>'' then
     EdVlrrealizado.enabled:=true
   else
     EdVlrrealizado.enabled:=false;
end;

procedure TFOrcamento.bGravarClick(Sender: TObject);
var Q:TSqlquery;
    xdata:TDatetime;
    sqlsetor:string;
begin
  if not EdMesano.valid then exit;
  if not EdConta.valid then exit;
  if not confirma('Confirma gravação ?') then exit;
  xdata:=Texttodate('01'+FGeral.tirabarra(EdMesano.text));
  sqlsetor:='';
//  if campo.Tipo<>'' then begin
//      sqlsetor:=' and dota_seto_codigo='+Edseto_codigo.assql;
//  end;
  q:=sqltoquery('select * from dotacoes where dota_data='+Datetosql(xdata)+' and dota_plan_conta='+EdConta.assql+
                sqlsetor+
                ' and dota_unid_codigo='+EdUnid_codigo.assql);
  if not Q.eof then begin
    Sistema.Edit('dotacoes');
    Sistema.setfield('dota_valor',EdValor.ascurrency);
    if campo.Tipo<>'' then
      Sistema.setfield('dota_seto_codigo',EdSeto_codigo.Text);
    if campovlrreal.Tipo<>'' then
      Sistema.setfield('dota_vlrreal',EdVlrrealizado.ascurrency);
    Sistema.post('dota_data='+Datetosql(xdata)+' and dota_plan_conta='+EdConta.assql+' and dota_unid_codigo='+EdUnid_codigo.assql);
  end else begin
    Sistema.Insert('dotacoes');
    Sistema.setfield('dota_data',xdata);
    Sistema.setfield('dota_unid_codigo',EdUnid_codigo.text);
    Sistema.setfield('dota_plan_conta',Edconta.asinteger);
    Sistema.setfield('dota_valor',EdValor.ascurrency);
    if campo.Tipo<>'' then
      Sistema.setfield('dota_seto_codigo',EdSeto_codigo.Text);
    if campovlrreal.Tipo<>'' then
      Sistema.setfield('dota_vlrreal',EdVlrrealizado.ascurrency);
    Sistema.post;
  end;
  Editstogrid;
  Sistema.commit;
  EdValor.setvalue(0);
  EdConta.setvalue(0);
//  EdMesano.setfocus;
  EdConta.setfocus;

end;

function TFOrcamento.Getsqlorcamento(Mesano: string ; xConta:integer=0): string;
/////////////////////////////////////////////////////////////
var xdata:TDatetime;
    sqlconta:string;
begin
//  xdata:=Texttodate('01'+FGeral.tirabarra(EdMesano.text));
// 20.04.10 - pego erro
  xdata:=Texttodate('01'+FGeral.tirabarra(Mesano));
// 20.04.11
  sqlconta:='';
  if xConta>0 then
    sqlconta:=' and dota_plan_conta = '+inttostr(xConta);
  result:='select dotacoes.*,plan_descricao,seto_descricao from dotacoes'+
          ' left join plano on (plan_conta=dota_plan_conta)'+
          ' left join setores on (seto_codigo=dota_seto_codigo)'+
          ' where dota_data='+Datetosql(xdata)+
          sqlconta+
          ' and dota_unid_codigo='+EdUnid_codigo.assql;

end;

procedure TFOrcamento.EdValorExitEdit(Sender: TObject);
begin
  bgravarclick(self);
end;

procedure TFOrcamento.bexclusaoClick(Sender: TObject);
var conta:integer;
    xdata:TDatetime;
    sqlsetor,setor:string;
begin
  conta:=strtointdef( Grid.cells[Grid.getcolumn('dota_plan_conta'),Grid.row],0 );
  if conta=0 then exit;
  if not confirma('Confirma exclusão do orçamento da conta '+inttostr(conta)+' ?') then exit;
  xdata:=Texttodate('01'+FGeral.tirabarra(EdMesano.text));
  sqlsetor:='';
  if campo.Tipo<>'' then begin
      setor:=Grid.cells[Grid.getcolumn('dota_seto_codigo'),Grid.row];
//      sqlsetor:=' and dota_seto_codigo='+Stringtosql(Setor);
  end;
  try
    ExecuteSql('delete from dotacoes where dota_data='+Datetosql(xdata)+
               ' and dota_plan_conta='+inttostr(conta)+
               sqlsetor+
               ' and dota_unid_codigo='+EdUnid_codigo.assql);
    Grid.DeleteRow(Grid.row);
  except
    Avisoerro('Tente mais tarde');
  end;
//  Sistema.commit;
end;

procedure TFOrcamento.EdContaValidate(Sender: TObject);
begin
   if EdConta.resultfind.fieldbyname('plan_tipo').asstring<>'M' then
     EdConta.invalid('Permitido somente contas tipo M ( Movimento )');
end;

procedure TFOrcamento.Editstogrid;
////////////////////////////////////
var x:integer;
begin

//  if campo.Tipo<>'' then
//    x:=FGeral.Procuragrid(grid.GetColumn('dota_plan_conta'),EdConta.text,Grid,grid.GetColumn('dota_seto_codigo'),strtoint(EdSeto_codigo.text))
//  else
    x:=FGeral.Procuragrid(grid.GetColumn('dota_plan_conta'),EdConta.text,Grid);
  if x=0 then begin
    x:=Grid.RowCount;
    Grid.AppendRow;
    Grid.cells[Grid.getcolumn('dota_plan_conta'),abs(x)]:=EdConta.text;
    Grid.cells[Grid.getcolumn('plan_descricao'),abs(x)]:=setEdPlan_descricao.text;
    Grid.cells[Grid.getcolumn('dota_valor'),abs(x)]:=EdValor.assql;
    if campo.Tipo<>'' then
      Grid.cells[Grid.getcolumn('dota_seto_codigo'),abs(x)]:=EdSeto_codigo.Text;
    if campovlrreal.Tipo<>'' then
      Grid.cells[Grid.getcolumn('dota_vlrreal'),abs(x)]:=EdVlrrealizado.assql;
  end else begin
    Grid.cells[Grid.getcolumn('dota_valor'),x]:=EdValor.assql;
    if campo.Tipo<>'' then
      Grid.cells[Grid.getcolumn('dota_seto_codigo'),x]:=EdSeto_codigo.Text;
    if campovlrreal.Tipo<>'' then
      Grid.cells[Grid.getcolumn('dota_vlrreal'),abs(x)]:=EdVlrrealizado.assql;
  end;
end;

procedure TFOrcamento.brelClick(Sender: TObject);
var sql:string;
    xdata:TDatetime;
begin
   if not EdMesano.valid then exit;
   xdata:=Texttodate('01'+FGeral.tirabarra(EdMesano.text));
   sql:=Getsqlorcamento(EdMesano.text) ;
   FRel.ReportFromSQL(sql,'RelOrcamento','Orçamento '+FGeral.formatadata(xdata),'','');
end;

procedure TFOrcamento.EdContaExit(Sender: TObject);
var x:integer;
begin
     x:=FGeral.Procuragrid(grid.GetColumn('dota_plan_conta'),EdConta.text,Grid);
     if x>0 then begin
       EdValor.text:=Grid.cells[Grid.getcolumn('dota_valor'),abs(x)];
       if campo.Tipo<>'' then
         EdSeto_codigo.Text:=Grid.cells[Grid.getcolumn('dota_seto_codigo'),abs(x)];
       if campovlrreal.Tipo<>'' then
         EdVlrrealizado.Text:=Grid.cells[Grid.getcolumn('dota_vlrreal'),abs(x)];
     end;


end;

procedure TFOrcamento.bcopiaClick(Sender: TObject);
begin
  EdMesanocopia.Enabled:=true;
  EdMesanocopia.Visible:=true;
  EdMesanocopia.SetFocus;

end;

// 20.04.10
procedure TFOrcamento.EdMesanocopiaExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////////
var Q,QOri:TSqlquery;
    op:boolean;
    xdata:TDatetime;
    sqlconta,titconta:string;
begin
   if EdMesanocopia.IsEmpty then exit;
   xdata:=Texttodate('01'+FGeral.Tirabarra(EdMesanocopia.text));
   Q:=sqltoquery( Getsqlorcamento(EdMesanocopia.text,0) );
// 20.04.11 - Abra
   sqlconta:='';titconta:='';
   if not EdConta.isempty then begin
     sqlconta:=' and dota_plan_conta = '+EdConta.AsSql;
     Q.Close;
     Q:=sqltoquery( Getsqlorcamento(EdMesanocopia.text,EdConta.AsInteger) );
     titconta:=' da conta '+EdConta.text;
   end;
   if not Q.eof then begin
     op:=Confirma('Orçamento encontrado em '+EdMesanocopia.text+titconta+'.  Sobrepor ?');
     if op then begin
       sistema.beginprocess('Eliminando orçamento existente '+titconta);
       ExecuteSql('delete from dotacoes where dota_data='+Datetosql(xdata)+
                  sqlconta+
                  ' and dota_unid_codigo='+EdUnid_codigo.assql);
       sistema.endprocess('');
     end;
   end else
     op:=Confirma('Copia Orçamento de '+EdMesano.text+' para '+EdMesanocopia.text+titconta+' ?');
   if not op then exit;
   if not Confirma('Criar orçamento em '+EdMesanocopia.text+titconta+' ?') then exit;

   QOri:=sqltoquery( Getsqlorcamento(EdMesano.text) );
   if QOri.eof then begin
     Avisoerro('Orçamento origem não encontrado');
     QOri.Close;QOri.Free;
     exit;
   end;

   if EdConta.isempty then begin
     Sistema.BeginProcess('Criando orçamento');
     while not QOri.Eof do begin
        Sistema.Insert('dotacoes');
        Sistema.setfield('dota_data',xdata);
        Sistema.setfield('dota_unid_codigo',EdUnid_codigo.text);
        Sistema.setfield('dota_plan_conta',QOri.fieldbyname('dota_plan_conta').asinteger);
        Sistema.setfield('dota_valor',QOri.fieldbyname('dota_valor').ascurrency);
  //      Sistema.setfield('dota_pcon_classificacao',QOri.fieldbyname('dota_pcon_classificacao').AsString);
  //      Sistema.setfield('dota_usua_codigo',Global.Usuario.Codigo);
        if campo.Tipo<>'' then
          Sistema.setfield('dota_seto_codigo',QOri.fieldbyname('dota_seto_codigo').asstring);
        if campovlrreal.Tipo<>'' then
          Sistema.setfield('dota_vlrreal',QOri.fieldbyname('dota_vlrreal').ascurrency);
        Sistema.post;
        QOri.Next;
     end;
     QOri.Close;QOri.Free;
   end else begin
     Sistema.BeginProcess('Criando orçamento para conta '+EdConta.text);
        Sistema.Insert('dotacoes');
        Sistema.setfield('dota_data',xdata);
        Sistema.setfield('dota_unid_codigo',EdUnid_codigo.text);
        Sistema.setfield('dota_plan_conta',EdConta.asinteger);
        Sistema.setfield('dota_valor',EdValor.ascurrency);
//        Sistema.setfield('dota_usua_codigo',Global.Usuario.Codigo);
        if campo.Tipo<>'' then
          Sistema.setfield('dota_seto_codigo',EdSeto_codigo.text);
        if campovlrreal.Tipo<>'' then
          Sistema.setfield('dota_vlrreal',EdVlrrealizado.ascurrency);
        Sistema.post;

   end;

   try
     Sistema.Commit;
     Sistema.endprocess('');
   except
     Sistema.endprocess('Não foi possível criar orçamento.  Tente mais tarde');
   end;
   Bcancelarclick(self);
end;

procedure TFOrcamento.EdMesanocopiaExit(Sender: TObject);
begin
  EdMesanocopia.Enabled:=false;
  EdMesanocopia.Visible:=false;

end;

procedure TFOrcamento.bCancelarClick(Sender: TObject);
begin
  EdMesanocopia.Enabled:=false;
  EdMesanocopia.Visible:=false;

end;

procedure TFOrcamento.EdMesanocopiaValidate(Sender: TObject);
//var xdata:TDatetime;
begin
   if EdMesanocopia.IsEmpty then exit;
   if EdMesanocopia.text=EdMesano.text then begin
     EdMesanocopia.invalid('Mes/ano para cópia não pode ser o atual');
     exit;
   end;
   try
//     xdata:=Texttodate('01'+FGeral.Tirabarra(EdMesanocopia.text));
//     EdData.setdate(xdata);
   except
     EdMesanocopia.invalid('Mes/ano inválido');
     exit;
   end;
end;

end.

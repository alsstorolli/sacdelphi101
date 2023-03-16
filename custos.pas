unit custos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, Sqlexpr, DB, SimpleDS, Datasnap.DBClient , Sqlsis ;
//   dbf ;

type
  TFComposicao = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    bCancelar: TSQLBtn;
    bIncluiritem: TSQLBtn;
    bExcluiritem: TSQLBtn;
    bCancelaritem: TSQLBtn;
    bImpressao: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PRemessa: TSQLPanelGrid;
    EdCustototal: TSQLEd;
    PIns: TSQLPanelGrid;
    EdProduto: TSQLEd;
    SetEdESTO_DESCRICAO: TSQLEd;
    EdQtde: TSQLEd;
    EdProdutoacabado: TSQLEd;
    setedcabado: TSQLEd;
    Edcodcor: TSQLEd;
    Setedcor: TSQLEd;
    EdCodtamanho: TSQLEd;
    Setedtamanho: TSQLEd;
    SetEdcopa_descricao: TSQLEd;
    EdCopa: TSQLEd;
    bsalvarcomo: TSQLBtn;
    PSalvarcomo: TSQLPanelGrid;
    EdNovoproduto: TSQLEd;
    SQLEd2: TSQLEd;
    Edcodcorn: TSQLEd;
    SQLEd3: TSQLEd;
    Edcodtamanhon: TSQLEd;
    SQLEd5: TSQLEd;
    Edcopan: TSQLEd;
    SQLEd7: TSQLEd;
    EdCodcorm: TSQLEd;
    Setedcorm: TSQLEd;
    EdCodtamanhom: TSQLEd;
    Setedtamanhom: TSQLEd;
    bapagacomposicao: TSQLBtn;
    EdPerqtde: TSQLEd;
    EdPercusto: TSQLEd;
    EdPercustototal: TSQLEd;
    EdPerqtdetotal: TSQLEd;
    bbaixa: TSQLBtn;
    EdPedido: TSQLEd;
//    dbforcam: TDbf;
 //   dbforcam: TSimpleDataSet;
    bimpobra: TSQLBtn;
    dbforcam: TSimpleDataSet;
    Edcust_ordem: TSQLEd;
    Edcust_cadm_codigo: TSQLEd;
    procedure EdProdutoacabadoValidate(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure EdProdutoacabadoExitEdit(Sender: TObject);
    procedure bIncluiritemClick(Sender: TObject);
    procedure EdCopaValidate(Sender: TObject);
    procedure EdcodcorValidate(Sender: TObject);
    procedure EdCodtamanhoValidate(Sender: TObject);
    procedure EdProdutoValidate(Sender: TObject);
    procedure EdQtdeExitEdit(Sender: TObject);
    procedure bExcluiritemClick(Sender: TObject);
    procedure bCancelaritemClick(Sender: TObject);
    procedure EdProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure bImpressaoClick(Sender: TObject);
    procedure EdNovoprodutoValidate(Sender: TObject);
    procedure bsalvarcomoClick(Sender: TObject);
    procedure EdcopanExitEdit(Sender: TObject);
    procedure EdcopanValidate(Sender: TObject);
    procedure EdcodcornValidate(Sender: TObject);
    procedure EdcodtamanhonValidate(Sender: TObject);
    procedure bapagacomposicaoClick(Sender: TObject);
    procedure bbaixaClick(Sender: TObject);
    procedure EdPedidoValidate(Sender: TObject);
    procedure bimpobraClick(Sender: TObject);
    procedure EdPedidoExit(Sender: TObject);
    procedure EdPedidoKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(xStatus:string='N');
    procedure QueryToGrid(Q:TSqlquery);
    procedure Editstogrid;
    function CalculaTotal:currency;
    procedure Apagacomposicao(produto,sqlcorx,sqltamanhox,sqlcopax: string);
    procedure Incluicomposicao(produto: string; Grid: Tsqldtgrid ; codtamx,codcorx,codcopax:integer);
    function ProcuraGrid(Coluna: integer;  Pesquisa: string ; Colunatam:integer=0 ; tam:integer=0 ;
             colunacor:integer=0 ; cor:integer=0  ; colunacopa:integer=0 ; copa:integer=0 ;
             colunapro:integer=0 ; codprocesso:integer=0 ) : integer;
    procedure ImportaObraPea(xObra:string);
    function TratamentotoCor(xcorid:string):string;
// 08.06.16
    function  GetCodigoComposicao(produto:string):string;
// 09.06.16
    function GetCodigosMat(produto:string):string;
// 06.04.18
    procedure DesativaEdits( xop:string );
    function GetPesoComposicao( produto,codmat:string ; PesoBalanca:currency ):currency;
// 11.01.18
    function  GetCodigoOrigem(material:string):string;

  end;

// 28.09.09
type TRequisicao=record
     produto,descricao,obra,codigopea,corid:string;
     qtde,unitario,peso,pecas,pesosobra:currency;
     tamanho:integer;
end;

type TOrcam=record
     produto,item,descricao,obra,codigopea,corid,codperf,codaces,localobra,localizacao:string;
     qtde,unitario,l,h,area,peso,tamanho,custo:currency;
end;
///////////////////////////////


const UnidadesDivideComposicao:string='KG;L;LT;LTS';
var
  FComposicao: TFComposicao;
  Custo,DivideComposicao:currency;
  Status,Tipo,Sqltipo,campocusto,UnidadeMatriz:String;
  campo:TDicionario;


implementation

uses sqlfun, Estoque, Geral, SQLRel, cadcor, tamanhos, Arquiv,
  Unidades, cadservicos;

var sqlcor,sqltamanho,sqlcopa,sqlcorn,sqltamanhon,sqlcopan:string;

{$R *.dfm}

procedure TFComposicao.EdProdutoacabadoValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////////
var Qp:TSqlquery;
begin
// retirado esta checagem em 23.05.14
{
  Qp:=sqltoquery('select * from estoqueqtde inner join estoque on (esto_codigo=esqt_esto_codigo)'+
                 ' where esqt_status=''N'' and esqt_unid_codigo='+stringtosql(UnidadeMatriz)+
                 ' and esqt_esto_codigo='+EdProdutoacabado.assql );
  if Qp.eof then
    Edprodutoacabado.invalid('Produto não cadastrado ou sem estoque cadastrado na matriz');
  if Qp.fieldbyname('esto_baixavenda').AsString='N' then
    bbaixa.caption:='Não Baixa'
  else
    bbaixa.caption:='Baixa';

  FGeral.fechaquery(Qp);
  }
end;

procedure TFComposicao.Execute(xStatus:string='N');
/////////////////////////////////////////////////////
begin

   Show;
   Status:=xStatus;
   EdPedido.EditMask:='##-####-##;0;_';
   if xStatus='N' then begin
     Tipo:='E';
     sqltipo:='';
   end else begin
     Tipo:=xStatus;
     sqltipo:=' and cust_tipo='+Stringtosql(Tipo);
   end;
   EdProdutoacabado.clearall(FComposicao,99);
   Edcodcor.Enabled:=Global.Topicos[1202];
   Edcodtamanho.Enabled:=Global.Topicos[1202];
   Edcopa.Enabled:=Global.Topicos[1202];
   Edcodcorn.Enabled:=Global.Topicos[1202];
   Edcodtamanhon.Enabled:=Global.Topicos[1202];
   Edcopan.Enabled:=Global.Topicos[1202];
   Grid.clear;
// 08.05.12 - Mama
   campocusto:='esqt_customeger';
   Grid.Columns[ Grid.getcolumn('move_venda') ].Title.Caption:='Medio  Ger.' ;
   if Global.Topicos[1219] then begin
     campocusto:='esto_precocompra';
     Grid.Columns[ Grid.getcolumn('move_venda') ].Title.Caption:='Preço Compra' ;
   end else if Global.Topicos[1220] then begin
     campocusto:='esqt_custo';
     Grid.Columns[ Grid.getcolumn('move_venda') ].Title.Caption:='Último Custo' ;
   end;
//   Grid.cells[Grid.getcolumn('move_venda'),1]. ;
// 23.05.12
   DivideComposicao:=FGeral.GetConfig1AsInteger('DIVCOMPOSICAO');
   if DivideComposicao<=0 then DivideComposicao:=1;
   FGeral.ConfiguraColorEditsNaoEnabled(Self);
// 24.05.14
//   UnidadeMatriz:=Global.UnidadeMatriz;
   UnidadeMatriz:=Global.CodigoUnidade;
   campo:=Sistema.GetDicionario('custos','cust_ordem');
   if campo.tipo='' then DesativaEdits( Tipo )
   else begin

     EdCust_ordem.Enabled:=(Tipo='P');
     EdCust_cadm_codigo.Enabled:=(Tipo='P');
     EdPercusto.Enabled:=(Tipo<>'P');
     EdQtde.Enabled:=(Tipo<>'P');
     if Tipo='P' then EdQtde.Text:='1';

   end;
   EdProduto.Empty:=(Tipo='P');
   EdProdutoacabado.setfocus;
end;

procedure TFComposicao.bGravarClick(Sender: TObject);
//////////////////////////////////////////////////////////
var codcor,codtam,codcopa:integer;
begin

   if ( trim( Grid.cells[Grid.getcolumn('move_esto_codigo'),1] )='' ) and ( tipo<>'P' )
      then exit;
   if (EdPerqtdetotal.AsCurrency>100) or (EdPercustototal.ascurrency>100) then begin
     Avisoerro('% ref. quantidade ou custo não pode ser maior que 100');
     exit;
   end;
   if EdProdutoacabado.IsEmpty then exit;

   if not confirma('Confirma gravação') then exit;

   Sistema.beginprocess('Gravando');
   codcor:=0;codtam:=0;codcopa:=0;
   if not EdCodcor.isEmpty then
       codcor:=Edcodcor.AsInteger;
     if not EdCodtamanho.isEmpty then
       codtam:=Edcodtamanho.AsInteger;
     if not Edcopa.isEmpty then
       codcopa:=Edcopa.AsInteger;
   Apagacomposicao(Edprodutoacabado.text,sqlcor,sqltamanho,sqlcopa);
   Incluicomposicao(Edprodutoacabado.text,Grid,codtam,codcor,codcopa);
   Sistema.endprocess('Composição gravada');
   EdProdutoacabado.setfocus;

end;

procedure TFComposicao.EdProdutoacabadoExitEdit(Sender: TObject);
/////////////////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    w,xorder:string;

begin

  if not EdCopa.isempty then
    sqlcopa:=' and cust_copa_codigo='+Edcopa.assql
  else
    sqlcopa:=' and cust_copa_codigo=0';
  Sistema.beginprocess('Pesquisando composição');
  w:='inner join estoque on ( esto_codigo=cust_esto_codigomat )'+
     ' inner join estoqueqtde on ( esqt_esto_codigo=cust_esto_codigomat and esqt_status=''N''';
  xorder:=' order by cust_esto_codigomat';
  if Tipo='P' then begin
     w:='left join estoque on ( esto_codigo=cust_esto_codigomat )'+
        ' left join estoqueqtde on ( esqt_esto_codigo=cust_esto_codigomat and esqt_status=''N''';
     xorder:=' order by cust_ordem,cust_cadm_codigo,cust_esto_codigomat'
  end;

  Q:=sqltoquery('select * from custos '+
                 w+
                ' and esqt_unid_codigo='+stringtosql(Unidadematriz)+' )'+
                ' where cust_status='+StringtoSql(Status)+
                ' and cust_esto_codigo='+EdProdutoacabado.assql+
                sqltipo+
                 sqlcor+sqltamanho+sqlcopa+
                 xorder
                 );
  Sistema.endprocess('');
  if not Q.eof then
    Querytogrid(Q)
  else begin
//    Aviso('Composição de Custo não encontrada');
    Grid.clear;
    bincluiritemclick(self);
  end;
  FGeral.fechaquery(Q);

end;

procedure TFComposicao.bIncluiritemClick(Sender: TObject);
begin
  if EdProdutoacabado.AsInteger=0 then exit;
  PRemessa.Enabled:=false;
  bGravar.Enabled:=false;
  bSair.Enabled:=false;
  bCancelar.Enabled:=false;
  PINs.Visible:=true;
  PINs.EnableEdits;
  Edcodcorm.Enabled:=Global.Topicos[1202];
  Edcodtamanhom.Enabled:=Global.Topicos[1202];
//  LimpaEditsItens;
  EdProduto.SetFocus;

end;

procedure TFComposicao.QueryToGrid(Q: TSqlquery);
/////////////////////////////////////////////////////////////
var x:integer;
    custo:currency;
begin

  Grid.Clear;x:=1;

  while not Q.eof do begin

   Grid.cells[Grid.getcolumn('move_esto_codigo'),x]:=( Q.fieldbyname('cust_esto_codigomat').asstring );
   Grid.cells[Grid.getcolumn('esto_descricao'),x]:=FEstoque.getdescricao(Q.fieldbyname('cust_esto_codigomat').asstring,'N');
   Grid.cells[Grid.getcolumn('move_qtde'),x]:=Q.fieldbyname('cust_qtde').asstring;
   Grid.cells[Grid.getcolumn('esto_unidade'),x]:=Q.fieldbyname('esto_unidade').asstring;
//   Grid.cells[Grid.getcolumn('move_venda'),x]:=formatfloat(f_cr,Q.fieldbyname('esqt_customeger').asfloat);
// 22.10.09
   Grid.cells[Grid.getcolumn('esto_referencia'),x]:=FEstoque.GetReferencia(Q.fieldbyname('cust_esto_codigomat').asstring);
   custo:=Q.fieldbyname( campocusto ).asfloat+Q.fieldbyname('esqt_customedioser').asfloat;
   Grid.cells[Grid.getcolumn('move_venda'),x]:=formatfloat(f_cr,custo);
   Grid.cells[Grid.getcolumn('total'),x]:=formatfloat(f_cr,custo*Q.fieldbyname('cust_qtde').ascurrency);
   Grid.Cells[Grid.Getcolumn('codcor'),x]:=Q.fieldbyname('cust_core_codigomat').Asstring;
   Grid.Cells[Grid.Getcolumn('codtamanho'),x]:=Q.fieldbyname('cust_tama_codigomat').Asstring;
   Grid.Cells[grid.getcolumn('cor'),Abs(x)]:=FCores.getdescricao(Q.fieldbyname('cust_core_codigomat').Asinteger);
   Grid.Cells[grid.getcolumn('tamanho'),Abs(x)]:=FTamanhos.getdescricao(Q.fieldbyname('cust_tama_codigomat').Asinteger);
   Grid.cells[Grid.getcolumn('cust_perqtde'),abs(x)]:=Q.fieldbyname('cust_perqtde').Asstring;
   Grid.cells[Grid.getcolumn('cust_percusto'),abs(x)]:=Q.fieldbyname('cust_percusto').Asstring;
// 09.04.18
   if campo.Tipo<>'' then begin

     Grid.cells[Grid.getcolumn('cust_cadm_codigo'),abs(x)]:=Q.fieldbyname('cust_cadm_codigo').Asstring;
     Grid.cells[Grid.getcolumn('cadm_descricao'),abs(x)]:=FCadServicos.GetDescricao(Q.fieldbyname('cust_cadm_codigo').Asinteger);
     Grid.cells[Grid.getcolumn('ordem'),abs(x)]:=strzero(Q.fieldbyname('cust_ordem').AsInteger,3);

   end;

   Grid.AppendRow;
   inc(x);
   Q.Next;

  end;

  EdCustototal.setvalue(calculatotal);
end;

procedure TFComposicao.EdCopaValidate(Sender: TObject);
///////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  if not EdCopa.isempty then
    sqlcopa:=' and cust_copa_codigo='+Edcopa.assql
  else
    sqlcopa:=' and cust_copa_codigo=0';
  Sistema.beginprocess('Pesquisando composição');
  Q:=sqltoquery('select * from custos inner join estoque on ( esto_codigo=cust_esto_codigomat )'+
                ' inner join estoqueqtde on ( esqt_esto_codigo=cust_esto_codigomat and esqt_status=''N'''+
                ' and esqt_unid_codigo='+stringtosql(UnidadeMatriz)+' )'+
                ' where cust_status='+Stringtosql(status)+
                ' and cust_esto_codigo='+EdProdutoacabado.assql+
                sqltipo+
                 sqlcor+sqltamanho+sqlcopa+' order by cust_esto_codigomat');
  Sistema.endprocess('');
  if not Q.eof then
    Querytogrid(Q)
  else begin
//    Aviso('Composição de Custo não encontrada');
    Grid.clear;
    bincluiritemclick(self);
  end;
  FGeral.fechaquery(Q);
end;

procedure TFComposicao.EdcodcorValidate(Sender: TObject);
begin
  if not EdCodcor.isempty then
    sqlcor:=' and cust_core_codigo='+Edcodcor.assql
  else
    sqlcor:=' and cust_core_codigo=0';
end;

procedure TFComposicao.EdCodtamanhoValidate(Sender: TObject);
begin
  if not EdCodtamanho.isempty then
    sqltamanho:=' and cust_tama_codigo='+Edcodtamanho.assql
  else
    sqltamanho:=' and cust_tama_codigo=0';

end;

procedure TFComposicao.EdProdutoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////
var QBusca,QEstoque:Tsqlquery;
begin

    if EdProduto.text=EdProdutoacabado.text then begin
      EdProduto.invalid('Produto não pode compor ele mesmo');
      exit;
    end;
    custo:=0;
// 09.04.18
    if not EdProduto.IsEmpty then begin

        QBusca:=sqltoquery('select * from estoque where esto_Codigo='+EdProduto.AsSql);
        if QBusca.Eof then begin
          EdProduto.Invalid('Codigo não encontrado');
          exit;
        end;

        QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                             ' and esqt_unid_codigo='+Stringtosql(UnidadeMatriz));
        SetEdEsto_descricao.text:=QBusca.fieldbyname('esto_descricao').asstring;
    //    custo:=FEstoque.Getcusto(Edproduto.Text,UnidadeMatriz,'medioger');
    // 08.05.12
       if Global.Topicos[1219] then
         custo:=QBusca.fieldbyname(campocusto).ascurrency
       else if Global.Topicos[1220] then
         custo:=FEstoque.Getcusto(Edproduto.Text,UnidadeMatriz,'custo')
       else
         custo:=FEstoque.Getcusto(Edproduto.Text,UnidadeMatriz,'medioger');
    //    if custo=0 then
    //      EdProduto.Invalid('Material com custo médio gerencial zerado no cadastro');
       if Tipo='P' then EdPerqtde.setvalue( QEstoque.FieldByName('esqt_vendavis').AsCurrency );

   end;

end;

procedure TFComposicao.EdQtdeExitEdit(Sender: TObject);
begin
  EditstoGrid;
  EdCustototal.setvalue(CalculaTotal);
  EdProduto.clearall(FComposicao,99);
  EdProduto.SetFocus;

end;

procedure TFComposicao.Editstogrid;
//////////////////////////////////////////////
var x:integer;
    aqtde:currency;
begin
//  x:=FGeral.ProcuraGrid(0,EdProduto.Text,Grid);
  x:=ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdProduto.Text,grid.getcolumn('codtamanho'),EdCodtamanhom.asinteger,
                        grid.getcolumn('codcor'),Edcodcorm.asinteger,0,0,grid.getcolumn('cust_cadm_codigo'),Edcust_cadm_codigo.asinteger);
  if x<0 then begin
    Grid.AppendRow;
    Grid.cells[Grid.getcolumn('move_esto_codigo'),abs(x)]:=EdProduto.text;
    Grid.cells[Grid.getcolumn('esto_descricao'),abs(x)]:=SetEdEsto_descricao.text;
    Grid.cells[Grid.getcolumn('move_qtde'),abs(x)]:=EdQtde.text;
    if not EdProduto.IsEmpty then
      Grid.cells[Grid.getcolumn('esto_unidade'),abs(x)]:=EdProduto.resultfind.fieldbyname('esto_unidade').asstring;
    Grid.cells[Grid.getcolumn('move_venda'),abs(x)]:=formatfloat(f_cr,custo );
    Grid.cells[Grid.getcolumn('total'),abs(x)]:=formatfloat(f_cr,custo*Edqtde.ascurrency);
    Grid.Cells[grid.getcolumn('tamanho'),Abs(x)]:=SetEdtamanhom.text;
    Grid.Cells[grid.getcolumn('cor'),Abs(x)]:=SetEdcorm.text;
    Grid.Cells[grid.getcolumn('codtamanho'),Abs(x)]:=Edcodtamanhom.text;
    Grid.Cells[grid.getcolumn('codcor'),Abs(x)]:=Edcodcorm.text;
    Grid.cells[Grid.getcolumn('cust_perqtde'),abs(x)]:=EdPerQtde.text;
    Grid.cells[Grid.getcolumn('cust_percusto'),abs(x)]:=EdPerCusto.text;
// 22.10.09
    Grid.cells[Grid.getcolumn('esto_referencia'),abs(x)]:=FEstoque.GetReferencia(EdProduto.text);
// 09.04.18
    Grid.cells[Grid.getcolumn('cust_cadm_codigo'),abs(x)]:=EdCust_cadm_codigo.text;
    Grid.cells[Grid.getcolumn('cadm_descricao'),abs(x)]:=FCadServicos.GetDescricao(EdCust_cadm_codigo.asinteger);
    Grid.cells[Grid.getcolumn('ordem'),abs(x)]:=strzero(EdCust_ordem.asinteger,3);

  end else begin

    Grid.cells[Grid.getcolumn('move_qtde'),x]:=EdQtde.text;

    if not EdProduto.IsEmpty then
      Grid.cells[Grid.getcolumn('esto_unidade'),x]:=EdProduto.resultfind.fieldbyname('esto_unidade').asstring;
    Grid.cells[Grid.getcolumn('move_venda'),x]:=formatfloat(f_cr,custo );
    Grid.cells[Grid.getcolumn('total'),x]:=formatfloat(f_cr,custo*Edqtde.ascurrency);
    Grid.Cells[grid.getcolumn('tamanho'),Abs(x)]:=SetEdtamanhom.text;
    Grid.Cells[grid.getcolumn('cor'),Abs(x)]:=SetEdcorm.text;
    Grid.Cells[grid.getcolumn('codtamanho'),Abs(x)]:=Edcodtamanhom.text;
    Grid.Cells[grid.getcolumn('codcor'),Abs(x)]:=Edcodcorm.text;
    Grid.cells[Grid.getcolumn('cust_perqtde'),abs(x)]:=EdPerQtde.text;
    Grid.cells[Grid.getcolumn('cust_percusto'),abs(x)]:=EdPerCusto.text;
// 09.04.18
    Grid.cells[Grid.getcolumn('cust_cadm_codigo'),abs(x)]:=EdCust_cadm_codigo.text;
    Grid.cells[Grid.getcolumn('cadm_descricao'),abs(x)]:=FCadServicos.GetDescricao(EdCust_cadm_codigo.asinteger);
    Grid.cells[Grid.getcolumn('ordem'),abs(x)]:=strzero(EdCust_ordem.asinteger,3);

  end;
  Grid.Refresh;


end;

function TFComposicao.CalculaTotal: currency;
///////////////////////////////////////////////
var p:integer;
    vlrtotal,pqtde,pcusto:currency;
begin
  vlrtotal:=0;pqtde:=0;pcusto:=0;
  for p:=1 to Grid.RowCount do begin
    if pos( trim( Grid.Cells[Grid.getcolumn('esto_unidade'),p] ),UnidadesDivideComposicao ) >0 then
      vlrtotal:=vlrtotal+FGeral.Arredonda( texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),p])/DivideComposicao *
              texttovalor(Grid.Cells[Grid.getcolumn('move_venda'),p]) ,2)
    else
      vlrtotal:=vlrtotal+FGeral.Arredonda( texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),p]) *
              texttovalor(Grid.Cells[Grid.getcolumn('move_venda'),p]) ,2);
    pqtde:=pqtde+FGeral.Arredonda(texttovalor(Grid.Cells[Grid.getcolumn('cust_perqtde'),p]),2);
    pcusto:=pcusto+FGeral.Arredonda(texttovalor(Grid.Cells[Grid.getcolumn('cust_percusto'),p]),2);
  end;
  result:=vlrtotal;
  EdperCustototal.setvalue(pcusto);
  EdPerQtdetotal.setvalue(pqtde);
end;

// 06.04.18
procedure TFComposicao.DesativaEdits( xop:string );
///////////////////////////////////////////////////
begin

  Edcust_ordem.enabled:=false;
  EdCust_cadm_codigo.Enabled:=false;
  if xop='P' then begin
    EdQtde.Enabled:=false;
    EdQtde.Text:='1';
    EdPercusto.Enabled:=false;
  end;

end;

procedure TFComposicao.bExcluiritemClick(Sender: TObject);
begin

 //  if trim( Grid.cells[Grid.getcolumn('move_esto_codigo'),grid.row] )='' then exit;
   if not confirma('Confirma exclusão') then exit;
   FGeral.GravaLog(34,'Produto Acabado '+EdProdutoacabado.Text+' excluído material '+Grid.Cells[Grid.GetColumn('move_esto_codigo'),Grid.Row] );
   Grid.DeleteRow(Grid.row);
   EdCustototal.setvalue(calculatotal);

   end;

procedure TFComposicao.bCancelaritemClick(Sender: TObject);
begin
  bGravar.Enabled:=true;
  bCancelar.Enabled:=true;
  bSair.Enabled:=true;
  PINs.Visible:=false;
  PINs.DisableEdits;
  PRemessa.enabled:=true;
  EdCopa.Setfocus;

end;

procedure TFComposicao.EdProdutoKeyPress(Sender: TObject; var Key: Char);
begin
   if key=#27 then begin
     bcancelaritemclick(self);
     bgravarclick(self);
   end;
end;

procedure TFComposicao.bImpressaoClick(Sender: TObject);
//////////////////////////////////////////////////////////////////
var cor,tamanho,copa,sqlprodutos:string;
    Q:TSqlquery;
    imptodos:boolean;
begin
   sqlprodutos:=' and cust_esto_codigo='+EdProdutoacabado.assql;
   if EdProdutoAcabado.IsEmpty then sqlprodutos:='';

//   imptodos:=confirma('Imprimir de TODOS ou somente deste na tela ?');
//   if imptodos then begin sqlprodutos:='';
   imptodos:=EdProdutoAcabado.IsEmpty;
   Q:=sqltoquery('select * from custos inner join estoque on ( esto_codigo=cust_esto_codigomat )'+
                ' inner join estoqueqtde on ( esqt_esto_codigo=cust_esto_codigomat and esqt_status=''N'''+
                ' and esqt_unid_codigo='+stringtosql(UnidadeMatriz)+' )'+
                ' where cust_status='+Stringtosql(Status)+
                sqlprodutos+
                sqlcor+sqltamanho+sqlcopa+' order by cust_esto_codigo,cust_core_codigo,cust_esto_codigomat');
   if Q.eof then begin
     Avisoerro('Planilha de custos não encontrada');
     exit;
   end;
   if not confirma('Confirma impressão ?') then exit;
   Sistema.beginprocess('Gerando relatório');
   FRel.init('PlanilhaCustos');
   FRel.AddTit('Composição de Materiais');
//   FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
   cor:='';tamanho:='';copa:='';
   if (not EdCodcor.isempty) and (EdCodcor.resultfind<>nil)  then
     cor:=' - Cor:'+EdCodcor.Text+' - '+EdCodcor.resultfind.fieldbyname('core_descricao').asstring;
   if (not EdCodtamanho.isempty)  and (EdCodtamanho.resultfind<>nil) then
     tamanho:=' - Tamanho:'+EdCodtamanho.resultfind.fieldbyname('tama_descricao').asstring;
   if not EdCopa.isempty then
     copa:=' - Copa:'+EdCopa.resultfind.fieldbyname('copa_descricao').asstring;
   if not imptodos then begin
     FRel.AddTit('Produto '+EdProdutoacabado.text+' - '+FEstoque.getdescricao(EdProdutoacabado.text)+cor+tamanho+copa);
   end else begin
     FRel.AddTit('Todos os Produtos '+cor+tamanho+copa);
     FRel.AddCol(080,1,'N','' ,''              ,'Produto'       ,''         ,'',false);
     FRel.AddCol(180,1,'C','' ,''              ,'Descrição Produto'       ,''         ,'',false);
   end;
   FRel.AddCol(080,1,'N','' ,''              ,'Material'       ,''         ,'',false);
   FRel.AddCol(180,1,'C','' ,''              ,'Descrição Material'       ,''         ,'',false);
   if Global.Topicos[1202] then begin
     FRel.AddCol(050,1,'C','' ,''              ,'Tamanho'                  ,''         ,'',false);
     FRel.AddCol(0180,1,'C','' ,''              ,'Cor/Tipo de Corte'                      ,''         ,'',false);
   end;
   FRel.AddCol(070,3,'N','##0.00' ,''              ,'% Qtde'     ,''         ,'',false);
   FRel.AddCol(070,3,'N','##0.00' ,''              ,'% Custo'     ,''         ,'',false);
   FRel.AddCol(070,3,'N','##,##0.000' ,''              ,'Quantidade'     ,''         ,'',false);
   FRel.AddCol(070,1,'C',''           ,''              ,'Unidade'        ,''         ,'',false);
   FRel.AddCol(070,3,'N',''           ,f_cr            ,'Valor Unitário' ,''         ,'',false);
   FRel.AddCol(070,3,'N','+'          ,f_cr            ,'Valor Total'    ,''         ,'',false);
   while not Q.eof do begin
     if imptodos then begin
       FRel.AddCel(Q.FieldByName('cust_esto_codigo').AsString);
       FRel.AddCel(FEstoque.Getdescricao(Q.FieldByName('cust_esto_codigo').AsString));
     end;
     FRel.AddCel(Q.FieldByName('cust_esto_codigomat').AsString);
     FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
     if Global.Topicos[1202] then begin
       FRel.AddCel(FTamanhos.Getdescricao(Q.FieldByName('cust_tama_codigo').AsInteger));
       FRel.AddCel(FCores.GetDescricao(Q.FieldByName('cust_core_codigo').AsInteger));
     end;
     FRel.AddCel(Q.FieldByName('cust_perqtde').AsString);
     FRel.AddCel(Q.FieldByName('cust_percusto').AsString);
     FRel.AddCel(Q.FieldByName('cust_qtde').AsString);
     FRel.AddCel(Q.FieldByName('esto_unidade').AsString);
     FRel.AddCel(Q.FieldByName(campocusto).AsString);
// 23.05.12
     if pos( trim( Q.FieldByName('esto_unidade').AsString ),UnidadesDivideComposicao ) >0 then
       FRel.AddCel(floattostr(Q.FieldByName(campocusto).AsCurrency*(Q.FieldByName('cust_qtde').AsCurrency/DivideComposicao) ))
     else
       FRel.AddCel(floattostr(Q.FieldByName(campocusto).AsCurrency*Q.FieldByName('cust_qtde').AsCurrency ));
     Q.next;
   end;
   FRel.video;
   Sistema.endprocess('');
   FGeral.fechaquery(Q);
end;

procedure TFComposicao.EdNovoprodutoValidate(Sender: TObject);
var Qp:TSqlquery;
begin
  Qp:=sqltoquery('select * from estoqueqtde where esqt_status=''N'''+
                ' and esqt_unid_codigo='+stringtosql(UnidadeMatriz)+
                ' and esqt_esto_codigo='+EdnovoProduto.assql );
  if Qp.eof then
    EdNovoproduto.invalid('Produto não cadastrado ou sem estoque cadastrado na matriz');
  FGeral.fechaquery(Qp);
  if not Global.Topicos[1202] then begin
    if EdNovoproduto.text=Edprodutoacabado.text then
      EdNovoproduto.invalid('Nova composição tem que ter outro codigo');
  end;
end;


procedure TFComposicao.bsalvarcomoClick(Sender: TObject);
begin
  Psalvarcomo.Enabled:=true;
  EdNovoProduto.setfocus;
end;

procedure TFComposicao.Apagacomposicao(produto,sqlcorx,sqltamanhox,sqlcopax: string);
//////////////////////////////////////////////////////////////////////////////////////////
var Q:Tsqlquery;
begin

     Q:=sqltoquery('select cust_esto_codigo from custos where cust_status='+Stringtosql(status)+
                   ' and cust_esto_codigo='+stringtosql(produto)+
                   sqltipo+
                    sqlcorx+sqltamanhox+sqlcopax);
     if not q.eof then begin
       Sistema.edit('custos');
       Sistema.setfield('cust_status','C');
       Sistema.Post('cust_status='+Stringtosql(Status)+
                    ' and cust_esto_codigo='+stringtosql(produto)+
                    sqltipo+
                    sqlcorx+sqltamanhox+sqlcopax);
       Sistema.commit;
     end;
     FGeral.fechaquery(Q);

end;

procedure TFComposicao.Incluicomposicao(produto: string; Grid: Tsqldtgrid ; codtamx,codcorx,codcopax:integer);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var p,codtam,codcor,codcopa:integer;
begin
     codtam:=codtamx;
     codcor:=codcorx;
     codcopa:=codcopax;
{
     if not EdCodcor.isEmpty then
       codcor:=Edcodcor.AsInteger;
     if not EdCodtamanho.isEmpty then
       codtam:=Edcodtamanho.AsInteger;
     if not Edcopa.isEmpty then
       codcopa:=Edcopa.AsInteger;
}
     for p:=1 to Grid.rowcount do begin

       if ( trim(Grid.cells[Grid.getcolumn('move_esto_codigo'),p])<>'' )
          or
          ( trim(Grid.cells[Grid.getcolumn('cust_cadm_codigo'),p])<>'' )
         then begin
         Sistema.Insert('Custos');
         Sistema.SetField('cust_status',Status);
         Sistema.SetField('cust_esto_codigo',produto);
         Sistema.SetField('cust_tama_codigo',codtam);
         Sistema.SetField('cust_core_codigo',codcor);
         Sistema.SetField('cust_copa_codigo',codcopa);
         Sistema.SetField('cust_esto_codigomat',Grid.cells[Grid.getcolumn('move_esto_codigo'),p]);
         Sistema.SetField('cust_tama_codigomat',strtointdef(Grid.cells[Grid.getcolumn('codtamanho'),p],0) );
         Sistema.SetField('cust_core_codigomat',strtointdef(Grid.cells[Grid.getcolumn('codcor'),p],0) );
         Sistema.SetField('cust_qtde',texttovalor( Grid.cells[Grid.getcolumn('move_qtde'),p] ) );
         Sistema.SetField('cust_perqtde',texttovalor( Grid.cells[Grid.getcolumn('cust_perqtde'),p] ) );
         Sistema.SetField('cust_percusto',texttovalor( Grid.cells[Grid.getcolumn('cust_percusto'),p] ) );
         Sistema.SetField('cust_usua_codigo',global.usuario.codigo);
// 17.08.09
         Sistema.SetField('cust_tipo',Tipo);
// 09.04.18
         if campo.Tipo<>'' then begin
            Sistema.SetField('cust_ordem',Texttovalor( Grid.cells[Grid.getcolumn('ordem'),p] ));
            Sistema.SetField('cust_cadm_codigo',Texttovalor( Grid.cells[Grid.getcolumn('cust_cadm_codigo'),p] ) );
         end;

         Sistema.post;
       end;
     end;

////////////     if trim(Grid.cells[Grid.getcolumn('move_esto_codigo'),1])<>'' then

       Sistema.Commit;

end;

procedure TFComposicao.EdcopanExitEdit(Sender: TObject);
///////////////////////////////////////////////////////////
var Q:TSqlquery;
    sqlcorn,sqltamanhon,sqlcopan:string;
begin
//  EdNovoProduto.enabled:=false;
  if not EdCodcorn.isempty then
    sqlcorn:=' and cust_core_codigo='+Edcodcorn.assql
  else
    sqlcorn:='';
  if not EdCodtamanhon.isempty then
    sqltamanhon:=' and cust_tama_codigo='+Edcodtamanhon.assql
  else
    sqltamanhon:='';
  if not Edcopan.isempty then
    sqlcopan:=' and cust_copa_codigo='+Edcopan.assql
  else
    sqlcopan:='';
  Psalvarcomo.Enabled:=true;
//  EdNovoProduto.visible:=false;
  Q:=sqltoquery('select cust_esto_codigo from custos where cust_status='+Stringtosql(Status)+
                ' and cust_esto_codigo='+EdNovoproduto.assql+
                sqltipo+
                 sqlcorn+sqltamanhon+sqlcopan);
  if not Q.eof then begin
    if confirma('Composição de custo já existe.   Sobrepor ?') then begin
       Apagacomposicao(EdNovoproduto.text,sqlcorn,sqltamanhon,sqlcopan);
       Incluicomposicao(EdNovoproduto.text,Grid,EdCodtamanhon.asinteger,Edcodcorn.asinteger,Edcopan.asinteger);
    end;
  end else begin
    if confirma('Confirma ?') then begin
       Incluicomposicao(EdNovoproduto.text,Grid,EdCodtamanhon.asinteger,Edcodcorn.asinteger,Edcopan.asinteger);
       aviso('Nova composição salva');
    end;
    psalvarcomo.enabled:=false;
    Edprodutoacabado.setfocus;
  end;
end;

// 09.04.08 - prevendo processos
function TFComposicao.ProcuraGrid(Coluna: integer; Pesquisa: string;
             Colunatam, tam, colunacor, cor, colunacopa, copa: integer ;
             colunapro:integer ; codprocesso:integer) : integer;
//////////////////////////////////////////////////////////////////////////////
var p:integer;
begin

  result:=0;
  if (tam>0) and (cor>0) then begin
    if copa=0 then begin
      for p:=1 to Grid.RowCount do  begin
        if (trim(Grid.Cells[Coluna,p])=trim(Pesquisa)) and
         (trim(Grid.Cells[Colunatam,p])=trim(inttostr(tam))) and (trim(Grid.Cells[Colunacor,p])=trim(inttostr(cor))) then begin
          result:=p;
          break;
        end;
        if trim(Grid.Cells[Coluna,p])='' then begin   // linha a ser usada
          result:=(-1)*p;
          break;
        end;
      end;
    end else begin
      for p:=1 to Grid.RowCount do  begin
        if (trim(Grid.Cells[Coluna,p])=trim(Pesquisa)) and
         (trim(Grid.Cells[Colunatam,p])=trim(inttostr(tam))) and
         (trim(Grid.Cells[Colunacopa,p])=trim(inttostr(copa))) and
         (trim(Grid.Cells[Colunacor,p])=trim(inttostr(cor))) then begin
          result:=p;
          break;
        end;
        if trim(Grid.Cells[Coluna,p])='' then begin   // linha a ser usada
          result:=(-1)*p;
          break;
        end;
      end;
    end;
// 12.06.06
  end else if (tam>0) or (cor>0) then begin
      if tam>0 then begin
        for p:=1 to Grid.RowCount do  begin
          if (trim(Grid.Cells[Coluna,p])=trim(Pesquisa)) and
           ( trim(Grid.Cells[Colunatam,p])=trim(inttostr(tam)) )  then begin
            result:=p;
            break;
          end;
          if trim(Grid.Cells[Coluna,p])='' then begin   // linha a ser usada
            result:=(-1)*p;
            break;
          end;
        end;
      end else begin
        for p:=1 to Grid.RowCount do  begin
          if (trim(Grid.Cells[Coluna,p])=trim(Pesquisa)) and
           ( trim(Grid.Cells[Colunacor,p])=trim(inttostr(cor)) ) then begin
            result:=p;
            break;
          end;
          if trim(Grid.Cells[Coluna,p])='' then begin   // linha a ser usada
            result:=(-1)*p;
            break;
          end;
        end;
      end;
// 09.04.18
  end else if (colunapro>0) then begin

    for p:=1 to Grid.RowCount do  begin
      if  trim(Grid.Cells[Coluna,p]+Grid.Cells[Colunapro,p]) = trim(Pesquisa+inttostr(codprocesso))
         then begin
        result:=p;
        break;
      end;
      if (trim(Grid.Cells[Coluna,p])='') and ((trim(Grid.Cells[Colunapro,p])='')) then begin   // linha a ser usada
        result:=(-1)*p;
        break;
      end;
    end;


  end else begin

    for p:=1 to Grid.RowCount do  begin
      if trim(Grid.Cells[Coluna,p])=trim(Pesquisa) then begin
        result:=p;
        break;
      end;
      if trim(Grid.Cells[Coluna,p])='' then begin   // linha a ser usada
        result:=(-1)*p;
        break;
      end;
    end;

  end;
end;

procedure TFComposicao.EdcopanValidate(Sender: TObject);
begin
  if not EdCopan.isempty then
    sqlcopan:=' and cust_copa_codigo='+Edcopan.assql
  else
    sqlcopan:=' and cust_copa_codigo=0';
  if (EdNovoProduto.text=EdProdutoacabado.text) and (EdCodcor.text=EdCodcorn.text) and
     ( EdCodtamanho.text=EdCodtamanhon.text ) and (EdCopa.text=EdCopan.text)
      then begin
      EdCopan.invalid('Produto não pode ser copiado nele mesmo');
  end;

end;

procedure TFComposicao.EdcodcornValidate(Sender: TObject);
begin
  if not EdCodcorn.isempty then
    sqlcorn:=' and cust_core_codigo='+Edcodcorn.assql
  else
    sqlcorn:=' and cust_core_codigo=0';

end;

procedure TFComposicao.EdcodtamanhonValidate(Sender: TObject);
begin
  if not EdCodtamanhon.isempty then
    sqltamanhon:=' and cust_tama_codigo='+Edcodtamanhon.assql
  else
    sqltamanhon:=' and cust_tama_codigo=0';

end;

procedure TFComposicao.bapagacomposicaoClick(Sender: TObject);
var Q:TSqlquery;
begin
   if trim( Grid.cells[Grid.getcolumn('move_esto_codigo'),grid.row] )='' then exit;
   if not EdCopa.isempty then
     sqlcopa:=' and cust_copa_codigo='+Edcopa.assql
   else
    sqlcopa:=' and cust_copa_codigo=0';
   Q:=sqltoquery('select * from custos inner join estoque on ( esto_codigo=cust_esto_codigomat )'+
                ' inner join estoqueqtde on ( esqt_esto_codigo=cust_esto_codigomat and esqt_status=''N'''+
                ' and esqt_unid_codigo='+stringtosql(UnidadeMatriz)+' )'+
                ' where cust_status='+Stringtosql(Status)+
                ' and cust_esto_codigo='+EdProdutoacabado.assql+
                sqltipo+
                 sqlcor+sqltamanho+sqlcopa+' order by cust_esto_codigomat');
  if not Q.eof then begin
     if not confirma('Confirma exclusão de toda a composição') then exit;
     try
       Sistema.Beginprocess('Excluindo composição');
       FGeral.GravaLog(35,'Produto Acabado '+EdProdutoacabado.Text+' excluído toda a composição' );

       ApagaComposicao(EdprodutoAcabado.text,sqlcor,sqltamanho,sqlcopa);
       Grid.Clear;
       Sistema.endprocess('');
       EdProdutoacabado.clearall(FComposicao,99);
       EdProdutoacabado.setfocus;
     except
       Avisoerro('Problemas na exclusão da composição');
     end;
  end else
    Avisoerro('Composição não encontrada');
  FGeral.Fechaquery(Q);
end;

procedure TFComposicao.bbaixaClick(Sender: TObject);
var Q:TSqlquery;
    qual:string;
begin
  if EdProdutoacabado.isempty then exit;
  Q:=sqltoquery('select esto_baixavenda from estoque where esto_codigo='+EdProdutoacabado.assql);
  if Q.fieldbyname('esto_baixavenda').AsString='N' then begin
    bbaixa.caption:='Baixa';
    qual:='S';
  end else begin
    bbaixa.caption:='Não Baixa';
    qual:='N';
  end;
  bbaixa.Update;
  Sistema.Edit('estoque');
  Sistema.setfield('esto_baixavenda',qual);
  Sistema.Post('esto_codigo='+EdProdutoacabado.assql);
  Sistema.Commit;
  FGeral.FechaQuery(Q);
end;

procedure TFComposicao.EdPedidoValidate(Sender: TObject);
begin
   if EdPedido.IsEmpty then exit;
   ImportaObraPea(EdPedido.text);
end;

//////////////////////////////////////////////////////////////////////////////////
procedure TFComposicao.ImportaObraPea(xObra: string);
////////////////////////////////////////////////////
var obra:string;
    POrcam,POrcamRes:^TOrcam;
    valorcontrato:currency;
    QEstoque,Q:TSqlquery;
    codcornovo,codcor,GrupoPerfil,Subgrupoperfil,Familiaperfil,codtamnovo,xprodutonovo,
    codtam:integer;
    ListaReq,ListaOrcam,ListaOrcamRes:Tlist;
    PReq:^TRequisicao;
    localexterno,Transacao:string;


    procedure DadostoGridExterno;
    //////////////////////////////////////////////////////////
    var i:integer;
        QEstoqueQtde,QEstoque:TSqlquery;
        produto,gravar:string;

       procedure ChecaCor;
       begin
         if not Arq.TCores.active then Arq.TCores.open;
//         if trim(Preq.corid)<>'' then begin
// 29.04.08
         if trim(POrcamres.corid)<>'' then begin
           POrcamres.corid:=TratamentotoCor(POrcamres.corid);
           Arq.TCores.First;
           if not Arq.TCores.Locate('core_descricao',POrcamres.corid,[]) then begin
             Arq.TCores.Insert;
             Arq.TCores.fieldbyname('core_codigo').asinteger:=codcornovo;
//             Arq.TCores.fieldbyname('core_descricao').asstring:=PReq.corid;
// 29.04.08
             Arq.TCores.fieldbyname('core_descricao').asstring:=POrcamres.corid;
             Arq.TCores.post;
             Arq.TCores.ApplyUpdates(0);
//             coresincluidas:=coresincluidas+strzero(codcor,3)+';';
             codcor:=codcornovo;
             inc(codcornovo);
           end else
             codcor:=Arq.TCores.fieldbyname('core_codigo').asinteger;
         end;
       end;

       procedure IncluiEstoque;
       var QEstoqueQtde:TSqlquery;
           novo:string;
           tamcodigo:integer;
       begin
         novo:=FEstoque.GetProximoCodigo('estoque','esto_codigo','C');
         tamcodigo:=length(novo);
         Sistema.Insert('estoque');
         Sistema.SetField('esto_codigo',strzero(strtointdef(novo,0),tamcodigo));
//         Sistema.SetField('esto_descricao',copy(POrcamREs.descricao,1,50));
// 03.08.09
         Sistema.SetField('esto_descricao',copy(SpecialCase(POrcamREs.descricao),1,50));
         Sistema.SetField('esto_unidade','M2');
         Sistema.SetField('esto_embalagem',1);
         Sistema.SetField('esto_peso',0);
         Sistema.SetField('esto_grup_codigo',GrupoPerfil);  // ver como fazer com grupo, subgrupo e familia
         Sistema.SetField('esto_sugr_codigo',SubGrupoPerfil);
         Sistema.SetField('esto_fami_codigo',FamiliaPerfil);
         Sistema.SetField('esto_emlinha','S');
         Sistema.SetField('esto_mate_codigo',0);
         Sistema.SetField('esto_referencia',POrcamres.codigopea);
         Sistema.SetField('esto_usua_codigo',Global.Usuario.Codigo);
         Sistema.Post();
         QEstoqueQtde:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                                       ' and esqt_esto_codigo='+stringtosql(strzero(strtointdef(novo,0),tamcodigo))+' and esqt_status=''N''');
         if QEstoqueQTde.eof then begin
              Sistema.Insert('EstoqueQtde');
              Sistema.Setfield('esqt_status','N');
              Sistema.Setfield('esqt_unid_codigo',Global.CodigoUnidade);
              Sistema.Setfield('esqt_esto_codigo',strzero(strtointdef(novo,0),tamcodigo));
              Sistema.Setfield('esqt_qtde',0);
              Sistema.Setfield('esqt_qtdeprev',0);
              Sistema.Setfield('esqt_vendavis',POrcamres.unitario);
              Sistema.Setfield('esqt_custo',POrcamres.custo);
              Sistema.Setfield('esqt_custoger',POrcamres.custo);
              Sistema.Setfield('esqt_customedio',POrcamres.custo);
              Sistema.Setfield('esqt_customeger',POrcamres.custo);
              Sistema.Setfield('esqt_dtultvenda',Sistema.hoje);
//              Sistema.Setfield('esqt_dtultcompra',Sistema.Hoje);
              Sistema.Setfield('esqt_desconto',0);
              Sistema.Setfield('esqt_basecomissao',0);
  // habilitar campos do cadastro de unidades -
              Sistema.Setfield('esqt_cfis_codigoest',FUnidades.GetFiscalDentro(Global.CodigoUnidade));
              Sistema.Setfield('esqt_cfis_codigoforaest',FUnidades.GetFiscalFora(Global.CodigoUnidade));
              Sistema.Setfield('esqt_sitt_codestado',FUnidades.GetSittDentro(Global.CodigoUnidade) );
              Sistema.Setfield('esqt_sitt_forestado',FUnidades.GetSittFora(Global.CodigoUnidade));
              Sistema.Setfield('esqt_usua_codigo',Global.Usuario.codigo);
              Sistema.Post('');
         end else begin   // 22.09.08 - atualiza o custo
{ - por enquanto nao atualizar pois a mesma janela dentro da mesma obra varia o custo devido as dif. metragens
              Sistema.Edit('EstoqueQtde');
              Sistema.Setfield('esqt_custo',POrcamres.unitario);
              Sistema.Setfield('esqt_custoger',POrcamres.unitario);
              Sistema.Setfield('esqt_customedio',POrcamres.unitario);
              Sistema.Setfield('esqt_customeger',POrcamres.unitario);
              Sistema.Setfield('esqt_dtultvenda',Sistema.hoje);
              Sistema.Post('esqt_unid_codigo='+EdUnid_codigo.assql+
                           ' and esqt_esto_codigo='+stringtosql(strzero(strtointdef(novo,0),tamcodigo))+
                           ' and esqt_status=''N''');
}
         end;
         FGeral.Fechaquery(QEstoqueqtde);
         Sistema.commit;
       end;

       procedure AtualizaCusto;
       ////////////////////////////////////////
       var QEstoqueQtde:TSqlquery;
           novo:string;
           tamcodigo:integer;
       begin
         QEstoqueQtde:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                                       ' and esqt_esto_codigo='+stringtosql(strzero(strtointdef(novo,0),tamcodigo))+' and esqt_status=''N''');
         if QEstoqueQTde.eof then begin
              Sistema.Edit('EstoqueQtde');
              Sistema.Setfield('esqt_vendavis',POrcamres.unitario);
              Sistema.Setfield('esqt_custo',POrcamres.custo);
              Sistema.Setfield('esqt_custoger',POrcamres.custo);
              Sistema.Setfield('esqt_customedio',POrcamres.custo);
              Sistema.Setfield('esqt_customeger',POrcamres.custo);
              Sistema.Setfield('esqt_dtultvenda',Sistema.hoje);
              Sistema.Post('esqt_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                           ' and esqt_esto_codigo='+stringtosql(QEstoque.fieldbyname('esto_codigo').asstring)+
                           ' and esqt_status=''N''');
// 03.08.09 - Adriano - Padronizar nomes igual Pea
             Sistema.Edit('estoque');
             Sistema.SetField('esto_descricao',copy(SpecialCase(POrcamREs.descricao),1,50));
             Sistema.Post('esto_codigo='+stringtosql(QEstoque.fieldbyname('esto_codigo').asstring));
///////////////////////
         end;
         FGeral.Fechaquery(QEstoqueqtde);
         Sistema.commit;
       end;

       // 28.09.09
       procedure ChecaTamanho(largura,altura:double);
       /////////////////////////////////////////
       var QTamanho:TSqlquery;
           caltura,clargura:string;
       begin
//         str(largura/1000:8:4,clargura);
//         str(altura/1000:8:4,caltura);
         clargura:=valortosql(largura);
         caltura:=valortosql(altura);
         QTamanho:=sqltoquery('select * from tamanhos where tama_largura='+clargura+
                   ' and tama_comprimento='+caltura);
         if (largura*altura)>0 then begin
           if QTamanho.eof then begin

             if not Arq.TTamanhos.active then Arq.TTamanhos.open;
             Arq.TTamanhos.Insert;
             Arq.TTamanhos.FieldByName('tama_codigo').asinteger:=codtamnovo;
//             Arq.TTamanhos.FieldByName('tama_descricao').asstring:='Largura '+transform(altura,'######')+' Altura '+transform(altura,'######');
             Arq.TTamanhos.FieldByName('tama_descricao').asstring:=strspace(clargura,6)+' X '+strspace(caltura,6);
             Arq.TTamanhos.FieldByName('tama_reduzido').AsString:=strspace(clargura,6);
             Arq.TTamanhos.FieldByName('tama_comprimento').AsCurrency:=altura;
             Arq.TTamanhos.FieldByName('tama_largura').AsCurrency:=largura;
             Arq.TTamanhos.post;
             Arq.TTamanhos.ApplyUpdates(0);

{
             Sistema.Insert;
             Sistema.setfield('tama_codigo',codtamnovo);
             Sistema.setfield('tama_descricao').asstring:=inttostr(xtamanho);
             Sistema.setfield('tama_reduzido').AsString:=inttostr(xtamanho);
             Sistema.setfield('tama_comprimento').AsCurrency:=xtamanho;
             Sistema.post;
             Sistema.Commit;
}
//             tamanhosincluidos:=tamanhosincluidos+strzero(codtam,3)+';';
             codtam:=codtamnovo;
             inc(codtamnovo);
           end else
//             codtam:=Arq.TTamanhos.fieldbyname('tama_codigo').asinteger;
             codtam:=QTamanho.fieldbyname('tama_codigo').asinteger;
         end else
           codtam:=0;   // 23.09.08
         FGeral.FechaQuery(QTamanho);
       end;


    begin
    //////////////////////////////////////
      gravar:='N';
      codcornovo:=FEstoque.GetProximoCodigo('cores','core_codigo','N');
      codtamnovo:=FEstoque.GetProximoCodigo('tamanhos','tama_codigo','N');
      for i:=0 to ListaOrcamREs.count-1 do begin
        POrcamRes:=ListaOrcamRes[i];
        QEstoque:=sqltoquery('select * from estoque where esto_referencia='+stringtosql(POrcamres.codigopea));
        if  QEstoque.eof then begin
//           if confirma('Item '+POrcamres.codigopea+' não encontrado no cadastro do estoque.  Confirma cadastro ') then begin
// 28.08.08 - deixado para incluir automatico sem opção
             IncluiEstoque;   // 03.07.08
             FGEral.FechaQuery(QEstoque);
             QEstoque:=sqltoquery('select * from estoque where esto_referencia='+stringtosql(POrcamres.codigopea));
//           end;
        end else begin   // 23.09.08
             AtualizaCusto;
        end;
//          produto:=POrcamREs.produto;
        if not QEstoque.Eof then begin
          produto:=QEstoque.fieldbyname('esto_codigo').asstring;
          Edprodutoacabado.text:=produto;
          setedcabado.text:=POrcamREs.descricao;
  //        Grid.Cells[Grid.GetColumn('move_cst'),i+1]:=FEstoque.Getsituacaotributaria(POrcamREs.produto,Global.CodigoUnidade,EdUNid_codigo.text);
  //        Grid.Cells[Grid.GetColumn('move_aliicms'),i+1]:=transform(FEstoque.Getaliquotaicms(POrcamREs.produto,Global.CodigoUnidade,EdUNid_codigo.text),'#0.0');
// cor produto acabado / 17.12.07
          Checacor;
          EdCodcor.Text:=transform(codcor,'###');
          EdCodcor.ValidFind;
          Checatamanho(POrcamres.l,POrcamres.h);
          EdCodtamanho.text:=inttostr(codtam);
          EdCodtamanho.validfind;

//          Grid.AppendRow;
        end;
//        QEstoque:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(produto));
{
//////////////////////////
          Sistema.Insert('estoque');
          Sistema.SetField('esto_codigo',produto);
          Sistema.SetField('esto_descricao',copy(POrcamREs.descricao,1,50));
          Sistema.SetField('esto_unidade','UN');
          Sistema.SetField('esto_embalagem',1);
          Sistema.SetField('esto_peso',0);
          Sistema.SetField('esto_grup_codigo',1);  // ver como fazer com grupo, subgrupo e familia
          Sistema.SetField('esto_sugr_codigo',1);
          Sistema.SetField('esto_fami_codigo',1);
          Sistema.SetField('esto_emlinha','S');
          Sistema.SetField('esto_mate_codigo',0);
          Sistema.SetField('esto_usua_codigo',Global.Usuario.Codigo);
//  esto_referencia varchar(20),
//  esto_precocompra numeric(13,4),
//  esto_cipi_codigo numeric(4),
          Sistema.Post;
          gravar:='S';
        end;
//////////////////////////
}
        FGeral.FechaQuery(QEstoque);

{
//////////////////////////
        QEstoqueQtde:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+EdUnid_codigo.assql+
                                     ' and esqt_esto_codigo='+stringtosql(produto)+' and esqt_status=''N''');
        if QEstoqueQTde.eof then begin
            Sistema.Insert('EstoqueQtde');
            Sistema.Setfield('esqt_status','N');
            Sistema.Setfield('esqt_unid_codigo',EdUNid_codigo.text);
            Sistema.Setfield('esqt_esto_codigo',produto);
            Sistema.Setfield('esqt_qtde',0);
            Sistema.Setfield('esqt_qtdeprev',0);
            Sistema.Setfield('esqt_vendavis',POrcamres.unitario);
            Sistema.Setfield('esqt_custo',0);
            Sistema.Setfield('esqt_custoger',0);
            Sistema.Setfield('esqt_customedio',0);
            Sistema.Setfield('esqt_customeger',0);
  //          Sistema.Setfield('esqt_dtultvenda',emissao);
            Sistema.Setfield('esqt_dtultcompra',Sistema.Hoje);
            Sistema.Setfield('esqt_desconto',0);
            Sistema.Setfield('esqt_basecomissao',0);
// habilitar campos do cadastro de unidades -

            Sistema.Setfield('esqt_cfis_codigoest',Grid.Cells[grid.getcolumn('codigofis'),linha]);
            Sistema.Setfield('esqt_cfis_codigoforaest',QEstoqueQtde.fieldbyname('esqt_cfis_codigoforaest').asstring);
            Sistema.Setfield('esqt_sitt_codestado',strtoint(Grid.Cells[grid.getcolumn('codigosittrib'),linha]) );
            Sistema.Setfield('esqt_sitt_forestado',QEstoqueQtde.fieldbyname('esqt_sitt_forestado').asinteger);

            Sistema.Setfield('esqt_cfis_codigoest','1');
            Sistema.Setfield('esqt_cfis_codigoforaest','1');
            Sistema.Setfield('esqt_sitt_codestado',1);
            Sistema.Setfield('esqt_sitt_forestado',1);
            Sistema.Setfield('esqt_usua_codigo',Global.Usuario.codigo);
            Sistema.Post('');
            gravar:='S';
        end;
        FGeral.Fechaquery(QEstoqueqtde);
///////////////////////////////////
}
        break;  // fazer somente do primeiro ( e q deve ser único )
      end;  // ref. ao for
{
///////////////////////////
      if gravar='S' then begin
        try
          Sistema.commit;
        except
          Avisoerro('Problemas na inclusão do(s) produto(s) vindos do pedido');
        end;
      end;
///////////////////////////
}
    end;

    procedure JuntaItens;
    ////////////////////////////////////////////////
    var i,p:integer;
        achou:boolean;
        produto:string;
        area,unitario:extended;
    begin
      for i:=0 to LIstaOrcam.Count-1 do begin
        POrcam:=ListaOrcam[i];
        achou:=false;
        for p:=0 to LIstaOrcamRes.Count-1 do begin
          POrcamRes:=ListaOrcamRes[p];
          if POrcamRes.produto=POrcam.produto then begin
            achou:=true;
            break;
          end;
        end;
        if not achou then begin
            New(POrcamRes);
            POrcamRes.obra:=POrcam.obra;
            POrcamRes.produto:=POrcam.produto;
            POrcamRes.item:=POrcam.item;
            POrcamRes.qtde:=POrcam.qtde;
            POrcamRes.unitario:=POrcam.unitario;
// 23.09.08
            POrcamRes.custo:=POrcam.custo;
            POrcamRes.descricao:=POrcam.descricao;
            POrcamRes.area:=(POrcam.l/1000)* (POrcam.h/1000);
            POrcamRes.codigopea:=POrcam.codigopea;
            POrcamRes.corid:=POrcam.corid;
            pOrcamRes.localobra:=POrcam.localobra;   // 14.01.08
            POrcamREs.l:=POrcam.l;
            POrcamREs.h:=POrcam.h;
            ListaOrcamREs.add(POrcamREs);
        end else begin
            POrcamRes.qtde:=POrcamRes.qtde+POrcam.qtde;
            POrcamRes.area:=POrcamRes.area+ ((POrcam.l/1000)* (POrcam.h/1000));
        end;
      end;
// soma area total e divide pelo valor da venda e recalcula valores
      area:=0;
      for i:=0 to LIstaOrcamRes.Count-1 do begin
         POrcamRes:=ListaOrcamRes[i];
         area:=area+POrcamREs.area;
      end;
      if area>0 then begin
//        unitario:=valorcontrato/area;
        unitario:=valorcontrato;
        for i:=0 to LIstaOrcamRes.Count-1 do begin
           POrcamRes:=ListaOrcamRes[i];
           POrcamREs.unitario:=unitario;
        end;
      end;
//      EdTotalnota.setvalue(valorcontrato);
//      EdQtdetotal.setvalue(area);
    end;

    procedure BuscaItens(produto:string);
    /////////////////////////////////////
    var i:integer;
    begin
        New(POrcam);
        POrcam.obra:=dbforcam.fieldbyname('CODIGO').Asstring;
        POrcam.produto:=produto;
        POrcam.item:=strzero(dbforcam.fieldbyname('NUMITEM').Asinteger,2);
        POrcam.qtde:=dbforcam.fieldbyname('QTDE').AsFLOAT;
        POrcam.l:=dbforcam.fieldbyname('L').AsFLOAT;
        POrcam.h:=dbforcam.fieldbyname('H').AsFLOAT;
// 22.09.08
//        POrcam.unitario:=dbforcam.fieldbyname('CUSTOUNIT').Asfloat;;
        POrcam.unitario:=0;
        POrcam.custo:=0;
        POrcam.descricao:=dbforcam.fieldbyname('DESCRICAO').Asstring;
        POrcam.codigopea:=dbforcam.fieldbyname('CODESQD').Asstring;
        POrcam.corid:=dbforcam.fieldbyname('TRAT').AsString;
        POrcam.localobra:=dbforcam.fieldbyname('TIPO').AsString;
        POrcam.localizacao:=dbforcam.fieldbyname('LOCALIZ').AsString;
        POrcam.peso:=0;
        ListaOrcam.add(POrcam);
    end;

    procedure BuscaItensAprov(produto:string);   // PERFIS
    ////////////////////////////////////////////////////
    var i:integer;
    begin
        New(PReq);
        PREq.obra:=dbforcam.fieldbyname('CODIGO').Asstring;
        PReq.produto:=produto;
//      PReq.qtde:=dbforcam.fieldbyname('NUMBARRAS').AsFLOAT;
// 22.09.08 - trazer em metros lineares e nao em barras
        PReq.qtde:=dbforcam.fieldbyname('NUMBARRAS').AsFLOAT*(dbforcam.fieldbyname('BARRA').Asinteger/1000);
//        PReq.qtde:=dbforcam.fieldbyname('PESOBRUTO').Asfloat;
        if PReq.qtde>0 then
          PReq.unitario:=dbforcam.fieldbyname('CUSTOPERF').AsFLOAT/PReq.qtde
        else
          PReq.unitario:=dbforcam.fieldbyname('CUSTOPERF').AsFLOAT;
        PReq.descricao:='';
        PReq.codigopea:=dbforcam.fieldbyname('CODPERF').Asstring;
        PReq.peso:=dbforcam.fieldbyname('PESOBRUTO').Asfloat;
        PReq.corid:=dbforcam.fieldbyname('ID').AsString;
        PReq.tamanho:=dbforcam.fieldbyname('BARRA').Asinteger;
        PReq.pecas:=dbforcam.fieldbyname('NUMBARRAS').AsFLOAT;
// 21.01.08
        PReq.pesosobra:=dbforcam.fieldbyname('PESOSOBRA').Asfloat;
        ListaReq.add(PReq);
    end;

    procedure BuscaItensAcessorios(produto:string);
    /////////////////////////////////////////////////
    var i:integer;
        achou:boolean;
    begin
        achou:=false;
        for i:=0 to ListaReq.count-1 do begin
          PReq:=ListaREq[i];
          if PReq.codigopea=dbforcam.fieldbyname('CODACES').Asstring then begin
            achou:=true;
            break;
          end;
        end;
        if not achou then begin
          New(PReq);
          PREq.obra:=dbforcam.fieldbyname('CODIGO').Asstring;
          PReq.produto:=produto;
          PReq.qtde:=dbforcam.fieldbyname('QTDE').AsFLOAT;
          PReq.unitario:=0;
          PReq.descricao:='';
          PReq.codigopea:=dbforcam.fieldbyname('CODACES').Asstring;
          PReq.peso:=0;
          PReq.pecas:=0;
          PReq.corid:=dbforcam.fieldbyname('TRAT').AsString;
          PReq.tamanho:=0;
          PReq.pesosobra:=0;  // 20.06.08
          ListaReq.add(PReq);
        end else begin
          PReq.qtde:=PReq.qtde+dbforcam.fieldbyname('QTDE').AsFLOAT;
        end;
    end;


    procedure SomanosItens;
    ////////////////////////////////////
    var i:integer;
        achou:boolean;
    begin
      achou:=false;
      for i:=0 to LIstaOrcam.Count-1 do begin
        POrcam:=ListaOrcam[i];
//      for i:=0 to LIstaOrcamRes.Count-1 do begin
 //       POrcam:=ListaOrcamRes[i];
        if (POrcam.obra=dbforcam.fieldbyname('CODIGO').Asstring) and
//           (POrcam.produto=dbforcam.fieldbyname('CODESQD').Asstring) and
           (POrcam.item=strzero(dbforcam.fieldbyname('ITEM').Asinteger,2))
           then begin
          achou:=true;
          break;
        end;
      end;
      if uppercase(dbforcam.FileName)=localexterno+'OBESQD.DBF' then begin
        if achou then begin
          Porcam.peso:=Porcam.peso+dbforcam.fieldbyname('PESO').AsFLOAT;
          // 23.09.08
          if dbforcam.fieldbyname('PESO').AsFLOAT>0 then
            POrcam.custo:=(dbforcam.fieldbyname('CUSTOPERF').AsFLOAT/dbforcam.fieldbyname('PESO').AsFLOAT);
        end else
          Aviso('Não encontrado Item '+strzero(dbforcam.fieldbyname('ITEM').Asinteger,2))
      end else begin
        if achou then begin
//          Porcam.qtde:=Porcam.qtde+dbforcam.fieldbyname('QTDE').AsFLOAT;
// 25.01.08 - retirado pois nao usa qtde e sim a area pra fazer a nf de venda...
          if dbforcam.fieldbyname('L').AsFLOAT*dbforcam.fieldbyname('H').AsFLOAT>0 then
            POrcam.custo:=dbforcam.fieldbyname('CUSTOUNIT').AsFLOAT/( ((dbforcam.fieldbyname('L').AsFLOAT/1000)*(dbforcam.fieldbyname('H').AsFLOAT/1000)) );
          POrcam.unitario:=dbforcam.fieldbyname('CUSTOUNIT').AsFLOAT;
        end else
//          Aviso('Não encontrado Item '+strzero(dbforcam.fieldbyname('ITEM').Asinteger,2)+' Codigo '+dbforcam.fieldbyname('CODESQD').Asstring)
// 08.08.08
          Aviso('Não encontrado Item '+strzero(dbforcam.fieldbyname('ITEM').Asinteger,2)+' Codigo '+dbforcam.fieldbyname('CODIGO').Asstring+' Arquivo '+dbforcam.FileName)
      end;
    end;


///////////////////
   procedure GeraRequisicaoAlmox;
/////////////////////////////////////////////////////////////
   var i,x:integer;
       QEstoque,QEstoqueqtde,QGrade:TSqlquery;
       produto,gravar,coresincluidas,produtonovo,sqlcor,sqltamanho:string;
       Grupo,subgrupo,Familia,codcor,codtam,tamcodigo,xproduto,codtamg:integer;

       procedure ChecaCor(xcorid:string);
//       var QCor:TSqlquery;
       begin
//         Qcor:=sqltoquery('select * from cores where core_descricao='+stringtosql(PReq.corid));
         if not Arq.TCores.active then Arq.TCores.open;
         if (trim(xcorid)<>'') and (trim(xcorid)<>'0') and (codcornovo>0) then begin
           xcorid:=TratamentotoCor(xcorid);
           Arq.TCores.First;
           if not Arq.TCores.Locate('core_descricao',xcorid,[]) then begin
  //           Sistema.insert('cores');
             Arq.TCores.Insert;
             Arq.TCores.fieldbyname('core_codigo').asinteger:=codcornovo;
             Arq.TCores.fieldbyname('core_descricao').asstring:=xcorid;
             Arq.TCores.post;
             Arq.TCores.ApplyUpdates(0);
             coresincluidas:=coresincluidas+strzero(codcor,3)+';';
             codcor:=codcornovo;
             inc(codcornovo);
           end else
             codcor:=Arq.TCores.fieldbyname('core_codigo').asinteger;
         end;
//         FGeral.FechaQuery(QCor);
       end;

       procedure ChecaTamanho(xtamanho:integer);
       var QTamanho:TSqlquery;
       begin
// 27.08.08 - colocado query pois estava incluindo tamanhos mesmo ja cadastrados
         QTamanho:=sqltoquery('select * from tamanhos where tama_descricao='+inttostr(xtamanho));
//         if (QTamanho.eof) and ( pos(strzero(codcor,3),tamanhosincluidos)=0)  then begin
//         if not Arq.TTamanhos.active then Arq.TTamanhos.open;
         if xtamanho>0 then begin
//           Arq.TTamanhos.First;
//           if not Arq.TTamanhos.Locate('tama_descricao',inttostr(xtamanho),[]) then begin
           if QTamanho.eof then begin

             if not Arq.TTamanhos.active then Arq.TTamanhos.open;
             Arq.TTamanhos.Insert;
             Arq.TTamanhos.FieldByName('tama_codigo').asinteger:=codtamnovo;
             Arq.TTamanhos.FieldByName('tama_descricao').asstring:=inttostr(xtamanho);
             Arq.TTamanhos.FieldByName('tama_reduzido').AsString:=inttostr(xtamanho);
             Arq.TTamanhos.FieldByName('tama_comprimento').AsCurrency:=xtamanho;
             Arq.TTamanhos.post;
             Arq.TTamanhos.ApplyUpdates(0);

{
             Sistema.Insert;
             Sistema.setfield('tama_codigo',codtamnovo);
             Sistema.setfield('tama_descricao').asstring:=inttostr(xtamanho);
             Sistema.setfield('tama_reduzido').AsString:=inttostr(xtamanho);
             Sistema.setfield('tama_comprimento').AsCurrency:=xtamanho;
             Sistema.post;
             Sistema.Commit;
}
//             tamanhosincluidos:=tamanhosincluidos+strzero(codtam,3)+';';
             codtam:=codtamnovo;
             inc(codtamnovo);
           end else
//             codtam:=Arq.TTamanhos.fieldbyname('tama_codigo').asinteger;
             codtam:=QTamanho.fieldbyname('tama_codigo').asinteger;
         end else
           codtam:=0;   // 23.09.08
         FGeral.FechaQuery(QTamanho);
       end;

       function ObratoNUmero(obra:string):integer;
       var s:string;
       begin
// 28.07.09
         if pos('VIMS',UpperCase(Obra))>0 then
           s:=copy(obra,6,14)
         else
           s:=copy(obra,1,14);
         s:=FGeral.TiraBarra(s,'-');
         result:=strtointdef(s,0);
       end;

       function Getlocalobra(xobra:string):string;
       var p:integer;
           POrcam:^TOrcam;
       begin
         result:='';
         for p:=0 to ListaOrcam.Count-1 do begin
           POrcam:=ListaOrcam[p];
           if POrcam.item=strzero(strtoint(xobra),2) then begin
             result:=POrcam.localobra;
             break;
           end;
         end;
       end;

       function GetTamanho(codigo:string):integer;
       var p:integer;
       begin
         result:=0;
         for p:=0 to ListaReq.Count-1 do begin
           PReq:=ListaReq[p];
           if PReq.codigopea=codigo then begin
             result:=PReq.tamanho;
             break;
           end;
         end;
       end;


///////////////////////////////// - inicio geracao requisicao almox
   begin
//////////////////////////////////////////////////////////////

      GrupoPerfil:=FGeral.getconfig1asinteger('GRUPOPERF');
      SubGrupoPerfil:=FGeral.getconfig1asinteger('SUBGRUPERF');
      FamiliaPerfil:=FGeral.getconfig1asinteger('FAMILIAPERF');
      produtonovo:=FEstoque.GetProximoCodigo('estoque','esto_codigo','C');
      codcornovo:=FEstoque.GetProximoCodigo('cores','core_codigo','N');
      codtamnovo:=FEstoque.GetProximoCodigo('tamanhos','tama_codigo','N');
      tamcodigo:=length(produtonovo);
      xproduto:=strtointdef(produtonovo,0);
      xprodutonovo:=strtointdef(produtonovo,0);
      coresincluidas:='';
      Grid.Clear;
//      tamanhosincluidos:='';
      x:=1;
      for i:=0 to ListaReq.Count-1 do begin
        PReq:=ListaReq[i];
        QEstoque:=sqltoquery('select * from estoque where esto_referencia='+stringtosql(PReq.codigopea));
//////////////////////////
//        produto:='';
        if QEstoque.eof then begin
          if pos( copy(PReq.codigopea,1,2),'RM;CM;IN;US' )>0 then begin
            Grupo:=GrupoPerfil;
            Subgrupo:=Subgrupoperfil;
            Familia:=Familiaperfil;
          end else begin
            Grupo:=1;
            Subgrupo:=1;
            Familia:=1;
          end;
          Sistema.Insert('estoque');
          Sistema.SetField('esto_codigo',strzero(xprodutonovo,tamcodigo));
          Sistema.SetField('esto_descricao','Perfil '+PReq.codigopea);
          Sistema.SetField('esto_unidade','MT');
          Sistema.SetField('esto_embalagem',1);
          if Preq.qtde>0 then
            Sistema.SetField('esto_peso',PREq.peso/Preq.qtde);
          Sistema.SetField('esto_grup_codigo',Grupo);  // ver como fazer com grupo, subgrupo e familia
          Sistema.SetField('esto_sugr_codigo',Subgrupo);
          Sistema.SetField('esto_fami_codigo',Familia);
          Sistema.SetField('esto_emlinha','S');
          Sistema.SetField('esto_referencia',PReq.codigopea);
          Sistema.SetField('esto_mate_codigo',0);
          Sistema.SetField('esto_usua_codigo',Global.Usuario.Codigo);
//   varchar(20),
//  esto_precocompra numeric(13,4),
//  esto_cipi_codigo numeric(4),
          Sistema.Post;
          Sistema.commit;
          gravar:='S';
          xproduto:=xprodutonovo;
          inc(xprodutonovo);
        end else
          xproduto:=QEstoque.fieldbyname('esto_codigo').asinteger;
//////////////////////////
        FGeral.FechaQuery(QEstoque);

//////////////////////////
//        if trim(produtonovo)<>'' then begin
        if xproduto>0 then begin
          QEstoqueQtde:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                                       ' and esqt_esto_codigo='+stringtosql(strzero(xproduto,tamcodigo))+' and esqt_status=''N''');
          if QEstoqueQTde.eof then begin
              Sistema.Insert('EstoqueQtde');
              Sistema.Setfield('esqt_status','N');
              Sistema.Setfield('esqt_unid_codigo',Global.CodigoUnidade);
              Sistema.Setfield('esqt_esto_codigo',strzero(xproduto,tamcodigo));
              Sistema.Setfield('esqt_qtde',0);
              Sistema.Setfield('esqt_qtdeprev',0);
              Sistema.Setfield('esqt_vendavis',PReq.unitario);
              Sistema.Setfield('esqt_custo',PReq.unitario);
              Sistema.Setfield('esqt_custoger',PReq.unitario);
              Sistema.Setfield('esqt_customedio',PReq.unitario);
              Sistema.Setfield('esqt_customeger',PReq.unitario);
              Sistema.Setfield('esqt_dtultvenda',Sistema.hoje);
//              Sistema.Setfield('esqt_dtultcompra',Sistema.Hoje);
              Sistema.Setfield('esqt_desconto',0);
              Sistema.Setfield('esqt_basecomissao',0);
  // habilitar campos do cadastro de unidades -
              Sistema.Setfield('esqt_cfis_codigoest',FUnidades.GetFiscalDentro(Global.CodigoUnidade));
              Sistema.Setfield('esqt_cfis_codigoforaest',FUnidades.GetFiscalFora(Global.CodigoUnidade));
              Sistema.Setfield('esqt_sitt_codestado',FUnidades.GetSittDentro(Global.CodigoUnidade) );
              Sistema.Setfield('esqt_sitt_forestado',FUnidades.GetSittFora(Global.CodigoUnidade));
              Sistema.Setfield('esqt_usua_codigo',Global.Usuario.codigo);
              Sistema.Post('');
              Sistema.commit;
              gravar:='S';
//////////////////              xproduto:=xprodutonovo;
              FGeral.Fechaquery(QEstoqueqtde);
// para usar na gravacao da nova grade...
              QEstoqueQtde:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                                       ' and esqt_esto_codigo='+stringtosql(strzero(xproduto,tamcodigo))+' and esqt_status=''N''');
          end else begin  // 22.09.08 - atualiza o custo
// - deixar pela nota de entrada
{
              Sistema.Edit('EstoqueQtde');
              Sistema.Setfield('esqt_vendavis',PReq.unitario);
              Sistema.Setfield('esqt_custo',PReq.unitario);
              Sistema.Setfield('esqt_custoger',PReq.unitario);
              Sistema.Setfield('esqt_customedio',PReq.unitario);
              Sistema.Setfield('esqt_customeger',PReq.unitario);
              Sistema.Setfield('esqt_dtultvenda',Sistema.hoje);
              Sistema.Post('esqt_unid_codigo='+EdUnid_codigo.assql+
                           ' and esqt_esto_codigo='+stringtosql(strzero(xproduto,tamcodigo))+
                           ' and esqt_status=''N''');
              Sistema.commit;
//}
          end;
        end;
///////////////////////////////////
        ChecaCor(PReq.corid);
        ChecaTamanho(PReq.tamanho);
        QEstoque:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(strzero(xproduto,tamcodigo)));

        Grid.cells[Grid.GetColumn('move_esto_codigo'),x]:=strzero(xproduto,tamcodigo);
        Grid.AppendRow;
        Grid.cells[Grid.getcolumn('esto_descricao'),abs(x)]:=FEstoque.GetDescricao(strzero(xproduto,tamcodigo));
        Grid.cells[Grid.getcolumn('esto_referencia'),abs(x)]:=FEstoque.GetReferencia(strzero(xproduto,tamcodigo));
        Grid.cells[Grid.getcolumn('move_qtde'),abs(x)]:=Floattostr(PREq.qtde) ;
        Grid.cells[Grid.getcolumn('esto_unidade'),abs(x)]:=FEstoque.GetUnidade(strzero(xproduto,tamcodigo));
//        Grid.cells[Grid.getcolumn('move_venda'),abs(x)]:=formatfloat(f_cr,PReq.unitario );
//        Grid.cells[Grid.getcolumn('move_venda'),abs(x)]:=formatfloat(f_cr,FEstoque.GetCusto(strzero(xproduto,tamcodigo),Global.CodigoUnidade,'medio') );
// 21.09.10 - com Adriano
        Grid.cells[Grid.getcolumn('move_venda'),abs(x)]:=formatfloat(f_cr,FEstoque.GetCusto(strzero(xproduto,tamcodigo),Global.CodigoUnidade,'custo') );
        Grid.cells[Grid.getcolumn('total'),abs(x)]:=formatfloat(f_cr,PReq.unitario*PREq.qtde);

        EdCustototal.setvalue(calculatotal);

        Grid.Cells[grid.getcolumn('codtamanho'),Abs(x)]:=inttostr( codtam );
        Grid.Cells[grid.getcolumn('codcor'),Abs(x)]:=inttostr( codcor );
        Grid.Cells[grid.getcolumn('tamanho'),Abs(x)]:=FTamanhos.GetDescricao(codtam);
        Grid.Cells[grid.getcolumn('cor'),Abs(x)]:=FCores.GetDescricao(codcor);
//        Grid.cells[Grid.getcolumn('cust_perqtde'),abs(x)]:=EdPerQtde.text;
//        Grid.cells[Grid.getcolumn('cust_percusto'),abs(x)]:=EdPerCusto.text;
        inc(x);

// 29.04.08 - checa se precisa gravar nova grade de tamanho+cor - 'BARRAS INTEIRAS'
/////////////////////////////////////
        if  (codtam+codcor)>0 then begin
            if Codcor>0 then
              sqlcor:=' and esgr_core_codigo='+inttostr(Codcor)
            else
              sqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
            if Codtam>0 then
              sqltamanho:=' and esgr_tama_codigo='+inttostr(Codtam)
            else
              sqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
            QGrade:=sqltoquery('select * from estgrades where esgr_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                                         ' and esgr_esto_codigo='+stringtosql(strzero(xproduto,tamcodigo))+' and esgr_status=''N'''+
                                         sqlcor+sqltamanho);
            if QGrade.eof then begin
              Sistema.Insert('Estgrades');
              Sistema.Setfield('esgr_status','N');
              Sistema.Setfield('esgr_esto_codigo',strzero(xproduto,tamcodigo));
              Sistema.Setfield('esgr_unid_codigo',Global.CodigoUnidade);
              Sistema.Setfield('esgr_grad_codigo',0);
      //        Sistema.Setfield('esgr_qtde',EdQtde.ascurrency );
      //        Sistema.Setfield('esgr_qtdeprev',EdQtde.ascurrency );
              Sistema.Setfield('esgr_qtde',0 );
              Sistema.Setfield('esgr_qtdeprev',0 );
              Sistema.Setfield('esgr_codbarra','');
              Sistema.Setfield('esgr_custo',QEstoqueQtde.fieldbyname('esqt_custo').ascurrency);
              Sistema.Setfield('esgr_customedio',QEstoqueQtde.fieldbyname('esqt_customedio').ascurrency);
              Sistema.Setfield('esgr_custoger',QEstoqueQtde.fieldbyname('esqt_custoger').ascurrency);
              Sistema.Setfield('esgr_customeger',QEstoqueQtde.fieldbyname('esqt_customeger').ascurrency);
              Sistema.Setfield('esgr_vendavis',QEstoqueQtde.fieldbyname('esqt_vendavis').ascurrency);
//              Sistema.Setfield('esgr_dtultvenda',EdDtEmissao.asdate);
//              Sistema.Setfield('esgr_dtultcompra',EdDtEmissao.asdate);
              Sistema.Setfield('esgr_usua_codigo',Global.Usuario.codigo);
              Sistema.Setfield('esgr_tama_codigo',Codtam);
              Sistema.Setfield('esgr_core_codigo',codcor);
      //        Sistema.Setfield('esgr_copa_codigo',xcodcopa);
              Sistema.Setfield('esgr_custoser',qEstoqueQtde.fieldbyname('esqt_custoser').ascurrency);
              Sistema.Setfield('esgr_customedioser',QEstoqueQtde.fieldbyname('esqt_customedioser').ascurrency);
              Sistema.Post();
              Sistema.commit;
            end;
            FGeral.FechaQuery(QGrade);
        end;
        FGeral.Fechaquery(QEstoqueqtde);
      end;  // ref. for dos itens
/////////////////////////////////////////////////////////////////

      dbforcam.close;

{
      if ListaReq.Count>=1 then begin
// fazer no grid ?/ aqui
        Grid.cells[Grid.GetColumn('move_esto_codigo'),x]:=strzero(xproduto,tamcodigo);
        Grid.AppendRow;
        Grid.cells[Grid.getcolumn('esto_descricao'),abs(x)]:=FEstoque.GetDescricao(strzero(xproduto,tamcodigo));
        Grid.cells[Grid.getcolumn('move_qtde'),abs(x)]:=Floattostr(PREq.qtde) ;
        Grid.cells[Grid.getcolumn('esto_unidade'),abs(x)]:=FEstoque.GetUnidade(strzero(xproduto,tamcodigo));
        Grid.cells[Grid.getcolumn('move_venda'),abs(x)]:=formatfloat(f_cr,PReq.unitario );
        Grid.cells[Grid.getcolumn('total'),abs(x)]:=formatfloat(f_cr,PReq.unitario*PREq.qtde);
      end;
}
     EdPedido.Enabled:=false;
     EdPedido.Visible:=false;
   end;

///////////////////


//////////////////////////////////////////////////////////////////////////
begin
//////////////////////////////////////////////////////////////////////////
  ListaReq:=TList.create;
  GrupoPerfil:=FGeral.getconfig1asinteger('GRUPOPERF');
  SubGrupoPerfil:=FGeral.getconfig1asinteger('SUBGRUPERF');
  FamiliaPerfil:=FGeral.getconfig1asinteger('FAMILIAPERF');

    localexterno:=FGeral.GetLocalExternoPea;
    valorcontrato:=1;
    if trim(localexterno)='' then begin
      Avisoerro('Falta configurar o local do PEA na configuração geral do sistema');
      exit;
    end else begin
      dbforcam.FileName:=localexterno+'OBITENS.DBF';
//      dbforcam.TableName:=localexterno+'OBITENS.DBF';
      try
        dbforcam.Open;
      except
        Avisoerro('Não foi possível abrir arquivo '+dbforcam.FileName);
//        EdPedido.invalid('Não foi possível abrir arquivo '+dbforcam.TableName);
        exit;
      end;
      Sistema.beginprocess('Pesquisando obra '+EdPedido.text);
      Grid.clear;
///      FGeral.Getvalor(valorcontrato);
      ListaOrcam:=TList.create;
//      obra:='VIMS-'+EdPedido.text;
//      obra:=nrobra+EdPedido.text;
// 27.05.09
      obra:=Trans(EdPedido.text,'##-####-##');
      while not dbforcam.Eof do begin
        if dbforcam.FieldByName('codigo').asstring=obra then begin
          BuscaItens(dbforcam.fieldbyname('CODESQD').Asstring);
//          QEstoque:=sqltoquery('select * from estoque where esto_referencia='+stringtosql(dbforcam.fieldbyname('CODESQD').Asstring));
//          if QEstoque.Eof then
//            Aviso('Não encontrado item da obra '+dbforcam.fieldbyname('CODESQD').Asstring+'|');
        end;
        dbforcam.Next;
      end;

// busca os perfis para os 'caixilhos' - relat. relação de barras
////////////////////////
      dbforcam.close;
      dbforcam.FileName:=localexterno+'OBAPROV.DBF';
//      dbforcam.TableName:=localexterno+'OBAPROV.DBF';
      try
        dbforcam.Open;
      except
        EdPedido.invalid('Não foi possível abrir arquivo '+dbforcam.FileName);
//        EdPedido.invalid('Não foi possível abrir arquivo '+dbforcam.TableName);
        exit;
      end;
      ListaReq:=TList.create;
      while not dbforcam.Eof do begin
        if dbforcam.FieldByName('codigo').asstring=obra then
          BuscaItensAprov(dbforcam.fieldbyname('CODPERF').Asstring);
        dbforcam.Next;
      end;
////////////////////////
// busca os acessorios
////////////////////////
      dbforcam.close;
//      dbforcam.TableName:=localexterno+'OBACES.DBF';
// 01.12.07
//      dbforcam.TableName:=localexterno+'OBCALCA.DBF';
      dbforcam.FileName:=localexterno+'OBCALCA.DBF';
      try
        dbforcam.Open;
      except
        EdPedido.invalid('Não foi possível abrir arquivo '+dbforcam.FileName);
//        EdPedido.invalid('Não foi possível abrir arquivo '+dbforcam.TableName);
        exit;
      end;
//////////////      ListaReq:=TList.create;
      while not dbforcam.Eof do begin
        if dbforcam.FieldByName('codigo').asstring=obra then begin
          QEstoque:=sqltoquery('select * from estoque where esto_referencia='+stringtosql(dbforcam.FieldByName('codaces').asstring));
          if not QEstoque.Eof then begin
//            EdPedido.invalid('Acessório codigo '+dbforcam.FieldByName('codaces').asstring+' não encontrado');
//            QEstoque.Close;
//            exit;
            BuscaItensAcessorios(dbforcam.fieldbyname('CODACES').Asstring);
//            showmessage('achou acessorio '+dbforcam.fieldbyname('CODACES').Asstring);
          end;
          FGeral.fechaquery(QEstoque);
        end;
        dbforcam.Next;
      end;
////////////////////////


      dbforcam.close;
      dbforcam.FileName:=localexterno+'OBORCAM.DBF';
//      dbforcam.TableName:=localexterno+'OBORCAM.DBF';
      try
        dbforcam.Open;
      except
        EdPedido.invalid('Não foi possível abrir arquivo '+dbforcam.FileName);
//        EdPedido.invalid('Não foi possível abrir arquivo '+dbforcam.TableName);
        exit;
      end;
//      obra:='VIMS-'+EdPedido.text;
      obra:=EdPedido.text;
      ListaOrcamREs:=TList.create;
      while not dbforcam.Eof do begin
        if dbforcam.FieldByName('codigo').asstring=obra then
          SomanosItens;
        dbforcam.Next;
      end;
      JuntaItens;
// 24.01.08
      dbforcam.close;
      dbforcam.FileName:=localexterno+'OBESQD.DBF';
      try
        dbforcam.Open;
      except
        EdPedido.invalid('Não foi possível abrir arquivo '+dbforcam.FileName);
//        EdPedido.invalid('Não foi possível abrir arquivo '+dbforcam.TableName);
        exit;
      end;
      obra:=EdPedido.text;
      while not dbforcam.Eof do begin
        if dbforcam.FieldByName('codigo').asstring=obra then
          SomanosItens;
        dbforcam.Next;
      end;
///////////////////
      if ListaOrcamRes.count>0 then begin
        DadostoGridExterno;
      end else
        Avisoerro('Não encontrado obra '+EdPedido.text);
      Sistema.endprocess('');
      dbforcam.close;

      GeraRequisicaoAlmox;

    end;
  end;

function TFComposicao.TratamentotoCor(xcorid: string): string;
var xtrat:string;
begin
// ir colocando cfe as cores 'novas'
   xtrat:=uppercase(xcorid);
   if ansipos('RAL9003B',xtrat)>0 then
     xtrat:='RAL9003B'
   else if ( ansipos('1000-A13',xtrat)>0  ) or ( ansipos('1000-A23',xtrat)>0 ) then
     xtrat:='ANOD 1000-A13'
   else if ( ansipos('1003-A13',xtrat)>0  ) or ( ansipos('1003-A23',xtrat)>0 ) then
     xtrat:='ANOD 1003-A13'
   else if ( ansipos('CM',xtrat)>0  ) or ( ansipos('TBRUTO',xtrat)>0 ) or ( ansipos('SBRUTO',xtrat)>0 ) then
     xtrat:='NATURAL - SEM TRATAMENTO';
   result:=xtrat;
end;


procedure TFComposicao.bimpobraClick(Sender: TObject);
begin
   EdPedido.visible:=true;
   EdPedido.enabled:=true;
   EdPedido.setfocus;
end;

procedure TFComposicao.EdPedidoExit(Sender: TObject);
begin
   EdPedido.visible:=false;
   EdPedido.enabled:=false;

end;

procedure TFComposicao.EdPedidoKeyPress(Sender: TObject; var Key: Char);
begin
   if key=#27 then begin
     EdPedido.visible:=false;
     EdPedido.enabled:=false;
   end;
end;

// 08.06.16
function TFComposicao.GetCodigoComposicao(produto: string): string;
////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
   sqltipo:='';
   status:='N';
   Q:=sqltoquery('select cust_esto_codigomat from custos where cust_status='+Stringtosql(status)+
                   ' and cust_esto_codigo='+stringtosql(produto)+
                    sqltipo );

   if not q.eof then result:=Q.fieldbyname('cust_esto_codigomat').asstring else result:='';
   FGeral.FechaQuery(Q);
end;

// 11.01.19
function TFComposicao.GetCodigoOrigem(material: string): string;
/////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    status : string;
begin

   status:='N';
   Q:=sqltoquery('select cust_esto_codigo from custos where cust_status='+Stringtosql(status)+
                   ' and cust_esto_codigomat='+stringtosql(material) );

   if not q.eof then result:=Q.fieldbyname('cust_esto_codigo').asstring else result:='';
   FGeral.FechaQuery(Q);

end;

// 09.06.16
function TFComposicao.GetCodigosMat(produto: string): string;
////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    s:string;
begin
   sqltipo:='';
   status:='N';
   Q:=sqltoquery('select cust_esto_codigomat from custos where cust_status='+Stringtosql(status)+
                   ' and cust_esto_codigo='+stringtosql(produto)+
                    sqltipo );
   s:='';
   while not q.eof  do  begin
     s:=s+Q.fieldbyname('cust_esto_codigomat').asstring+';';
     Q.Next;
   end;
   FGeral.FechaQuery(Q);
   result:=s;
end;

// 14.05.18
function TFComposicao.GetPesoComposicao(produto, codmat: string ; PesoBalanca:currency ): currency;
////////////////////////////////////////////////////////////////////////////
var QC:TSqlquery;
begin

  QC:=sqltoquery('select cust_perqtde from custos '+
                ' where cust_status='+StringtoSql('N')+
                ' and cust_esto_codigo='+Stringtosql( Produto )+
                ' and cust_esto_codigomat='+Stringtosql( codmat )
                 );
  if not Qc.Eof then result:= PesoBalanca*(Qc.FieldByName('cust_perqtde').AsCurrency/100)
  else result:=0;
  Qc.Close;

end;

end.

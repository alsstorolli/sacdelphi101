unit nfsaidamo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr, TextRel, Impr, DB,
//  dbf,
//  DBTables ,
  ComObj, SimpleDS,
  Async32;

type
  TFNotaSaidaMo = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
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
    Edunid_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    EdCliente: TSQLEd;
    SetEdCLIE_NOME: TSQLEd;
    EdDtemissao: TSQLEd;
    EdRepr_codigo: TSQLEd;
    SQLEd3: TSQLEd;
    EdNumeroDoc: TSQLEd;
    EdMoes_tabp_codigo: TSQLEd;
    SetEdTABP_ALIQUOTA: TSQLEd;
    PIns: TSQLPanelGrid;
    EdProduto: TSQLEd;
    SetEdESTO_DESCRICAO: TSQLEd;
    EdQtde: TSQLEd;
    EdUnitario: TSQLEd;
    PTotais: TSQLPanelGrid;
    EdBaseIcms: TSQLEd;
    EdValorIcms: TSQLEd;
    EdBasesubs: TSQLEd;
    EdValorsubs: TSQLEd;
    EdTotalprodutos: TSQLEd;
    EdTotalNota: TSQLEd;
    EdNatf_codigo: TSQLEd;
    EdNatf_descricao: TSQLEd;
    EdComv_codigo: TSQLEd;
    EdComv_descricao: TSQLEd;
    EdDtSaida: TSQLEd;
    PFinan: TSQLPanelGrid;
    PParcelas: TSQLPanelGrid;
    GridParcelas: TSqlDtGrid;
    EdVencimento: TSQLEd;
    EdParcela: TSQLEd;
    EdFpgt_codigo: TSQLEd;
    EdFpgt_descricao: TSQLEd;
    EdPort_codigo: TSQLEd;
    EdPort_descricao: TSQLEd;
    EdFrete: TSQLEd;
    EdSeguro: TSQLEd;
    EdEmides: TSQLEd;
    EdTran_codigo: TSQLEd;
    EdTran_nome: TSQLEd;
    EdQtdevolumes: TSQLEd;
    EdEspecievolumes: TSQLEd;
    EdDtMovimento: TSQLEd;
    EdPeracre: TSQLEd;
    Edperdesco: TSQLEd;
    EdVlracre: TSQLEd;
    EdVlrdesco: TSQLEd;
    Impr: TImpr;
    EdPerdesconto: TSQLEd;
    Edqtdetotal: TSQLEd;
    EdMensagem: TSQLEd;
    Edmens_codigo: TSQLEd;
    EdPedido: TSQLEd;
    EdPesoliq: TSQLEd;
    EdPesobru: TSQLEd;
    EdVendasmc: TSQLEd;
    EdDevolucoesdm: TSQLEd;
    EdCodtamanho: TSQLEd;
    Setedtamanho: TSQLEd;
    Edcodcor: TSQLEd;
    Setedcor: TSQLEd;
    EdCodcopa: TSQLEd;
    SetEdcopa_descricao: TSQLEd;
    EdFreteuni: TSQLEd;
    EdPecas: TSQLEd;
//    dbforcam: TDbf;
//    Dbforcamy: TTable;
    dbforcam: TSimpleDataSet;
    Dbforcamy: TSimpleDataSet;
    Edportoorigem: TSQLEd;
    Edportodestino: TSQLEd;
    Edcontainer: TSQLEd;
    Serial: TComm;
    Serial2: TComm;
    EdPedidos: TSQLEd;
    EdQtdenf: TSQLEd;
    SQLEd1: TSQLEd;
    EdRepr_codigo2: TSQLEd;
    Edpercomissao: TSQLEd;
    Edpercomissao2: TSQLEd;
    EdCertificado: TSQLEd;
    Edtiponota: TSQLEd;
    SetEdtipn_descricao: TSQLEd;
    Edaliiss: TSQLEd;
    EdValoripi: TSQLEd;
    Edtotalcofins: TSQLEd;
    Edtotalcsl: TSQLEd;
    Edtotalir: TSQLEd;
    Edvalorliquido: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure bIncluiritemClick(Sender: TObject);
    procedure EdProdutoValidate(Sender: TObject);
    procedure EdQtdeExitEdit(Sender: TObject);
    procedure bExcluiritemClick(Sender: TObject);
    procedure bCancelaritemClick(Sender: TObject);
    procedure EdFpgt_codigoValidate(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure bSairClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Edunid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdDtSaidaValidate(Sender: TObject);
    procedure EdFpgt_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdNatf_codigoValidate(Sender: TObject);
    procedure EdPort_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure Edunid_codigoValidate(Sender: TObject);
    procedure EdClienteValidate(Sender: TObject);
    procedure EdComv_codigoValidate(Sender: TObject);
    procedure EdMoes_tabp_codigoValidate(Sender: TObject);
    procedure EdPeracreValidate(Sender: TObject);
    procedure EdperdescoValidate(Sender: TObject);
    procedure EdVlracreValidate(Sender: TObject);
    procedure EdVlrdescoValidate(Sender: TObject);
    procedure EdEspecievolumesValidate(Sender: TObject);
    procedure EdNumeroDocValidate(Sender: TObject);
    procedure EdDtMovimentoValidate(Sender: TObject);
    procedure EdDtMovimentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure EdPerdescontoValidate(Sender: TObject);
    procedure GridParcelasDblClick(Sender: TObject);
    procedure EdVencimentoValidate(Sender: TObject);
    procedure EdParcelaValidate(Sender: TObject);
    procedure EdVencimentoExitEdit(Sender: TObject);
    procedure EdParcelaExitEdit(Sender: TObject);
    procedure EdVencimentoExit(Sender: TObject);
    procedure EdParcelaExit(Sender: TObject);
    procedure GridParcelasKeyPress(Sender: TObject; var Key: Char);
    procedure EdTran_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdFpgt_codigoExitEdit(Sender: TObject);
    procedure Edmens_codigoValidate(Sender: TObject);
    procedure EdPedidoValidate(Sender: TObject);
    procedure EdUnitarioValidate(Sender: TObject);
    procedure EdDevolucoesdmValidate(Sender: TObject);
    procedure EdCodtamanhoValidate(Sender: TObject);
    procedure EdCodcopaValidate(Sender: TObject);
    procedure EdcodcorValidate(Sender: TObject);
    procedure EdValoripiExitEdit(Sender: TObject);
    procedure EdTotalprodutosValidate(Sender: TObject);
    procedure EdcontainerExitEdit(Sender: TObject);
    procedure blebalanca1Click(Sender: TObject);
    procedure SerialRxChar(Sender: TObject; Count: Integer);
    procedure blebalanca2Click(Sender: TObject);
    procedure Serial2RxChar(Sender: TObject; Count: Integer);
    procedure EdPedidosExit(Sender: TObject);
    procedure EdPedidosValidate(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure EdQtdenfValidate(Sender: TObject);
    procedure EdQtdenfExitEdit(Sender: TObject);
    procedure EdVendasmcValidate(Sender: TObject);
    procedure EdRepr_codigoValidate(Sender: TObject);
    procedure EdRepr_codigo2Validate(Sender: TObject);
    procedure EdpercomissaoValidate(Sender: TObject);
    procedure Edpercomissao2Validate(Sender: TObject);
    procedure EdtiponotaValidate(Sender: TObject);
    procedure EdtiponotaExitEdit(Sender: TObject);
  private
    { Private declarations }
    procedure LimpaEditsItens;
    procedure Editstogrid;
  public
    { Public declarations }
    procedure Execute(Acao:string;Imp:string='N';CodMovimento:integer=0;Pedido:integer=0;CodigoCliente:integer=0);
    procedure ReservaEstoque(Codigo,IncExc:string;Qtde:currency);
    procedure SetaEditsValores;
    procedure RetornaReserva;
    procedure Campostoedits(Q:TSqlquery);
    procedure Campostogrid(Q:TSqlquery);
    procedure CancelaTransacao(Transacao:string);
    procedure AtivaEditsParcelas;
    function Nfexporta(cfop:string):boolean;
    function DevolucaoCompra(tipomov:string):boolean;
    procedure Editsconsig(ativa:string);
    procedure SetaItemsConsig(tipomov:string ; Edit:TSqled ; xData:TDatetime=0);
    function  TiposFornecedor(tipomov:string):boolean;
    procedure SetaPortosEmbarque(Ed:TSqlEd);
    function EstaCodigosNaoVenda(produto:string):boolean;
    procedure ImprimeContrato(xtransacao:string);
    function AbrirPorta:boolean;
    function AbrirPorta2:boolean;

  end;

type TRequisicao=record
     produto,descricao,obra,codigopea,corid:string;
     qtde,unitario,peso,pecas,pesosobra:currency;
     tamanho:integer;
end;

type TOrcam=record
     produto,item,descricao,obra,codigopea,corid,codperf,codaces,localobra,localizacao:string;
     qtde,unitario,l,h,area,peso,tamanho,custo:currency;
end;

type TBarras=record
     codigopea:string;
     tamanho:integer;
end;
// 03.03.09
Type TCalcula=record
     CalcPis,CalcCofins,CalcCsl,CalcIR,CalcInss,CalcIss,CalcInss50:string
end;

var
  FNotaSaidaMo: TFNotaSaidaMo;
  QBusca,QEstoque,QGrade,QPed:TSqlquery;
  Op,Transacao,Acao,Ecf,traco,CodigoIMp,Moes_remessas,StatusNota,CfopExporta,cstexporta,campoufentidade,revenda,
  TiposFornec,produtosnota,NotaTipocad,localexterno,TipoSaidaAbate:string;
  ListaReservacodigo,ListaReservaQtde:TStringList;
  Acumulado,totalbruto,icmsexporta:currency;
  Tamimp,moes_clie_codigo,usua_codigo,GrupoPerfil,Subgrupoperfil,Familiaperfil:integer;
  codigobarra:boolean;
  PReq:^TRequisicao;
  ListaReq,ListaOrcam,ListaOrcamRes:Tlist;
  PCalcula:^TCalcula;

implementation

uses Arquiv, Geral, Sqlfun, Estoque, Sqlsis, conpagto, codigosfis, tabela,
  Sittribu, impressao, Natureza, Transp, portador, cadcor, tamanhos,
  cadcopa, Usuarios, Unidades, tiposnotas;

{$R *.dfm}

{ TFNotaSaidaMo }

procedure TFNotaSaidaMo.Execute(Acao:string;Imp:string='N';CodMovimento:integer=0;Pedido:integer=0;CodigoCliente:integer=0);
var operacao:string;
begin

  Op:=Acao;
  CfopExporta:='7';
  icmsexporta:=0;
  cstexporta:='040';
  Ecf:=Imp;
  EdBaseicms.clearall(FNotaSaidaMo,99);
  EdValoripi.clearall(FNotaSaidaMo,99);
  if OP='I' then
    EdDtmovimento.setdate(Sistema.hoje);

// 12.02.07 - pra ficar no eof quando entra na nota
  Qped:=sqltoquery( FGeral.Buscapedvenda(99999999) );
// 28.08.08
//  if FindWindow(PClasse,PJAnela) <> 0 then
  if FindWindow( PWideChar('TPropertyInspector'),PWidechar('Object Inspector') ) =0 then
     FNotasaidaMo.FormStyle:=fsStayontop
  else
     FNotasaidaMo.FormStyle:=fsNormal;
  Show;
///////////////////////////////////////////////////
  if Global.Usuario.OutrosAcessos[0313] then
    EdDtemissao.Enabled:=true
  else
    EdDtemissao.enabled:=Global.Usuario.OutrosAcessos[0702];
  Sistema.setmessage('Abrindo tabelas');
  if not Arq.TTransp.Active then Arq.TTransp.Open;
  if not Arq.TEstoque.Active then Arq.TEstoque.Open;
  if not Arq.TEstoqueQtde.Active then Arq.TEstoqueQtde.Open;
  if not Arq.TClientes.Active then Arq.TClientes.Open;
  if not Arq.TRepresentantes.Active then Arq.TRepresentantes.Open;
  if not Arq.TTabelaPreco.Active then Arq.TTabelaPreco.Open;
//  Arq.TNatFisc.OpenWith('natf_es=''S''',Arq.TNatFisc.Ordenacao);
  if not Arq.TNatFisc.active then Arq.TNatFisc.open;
//  if not Arq.TConfMovimento.Active then Arq.TConfMovimento.Open;
  Arq.TConfMovimento.OpenWith(FGeral.GetIN('comv_tipomovto',Global.TiposSaida,'C'),Arq.TConfMovimento.Ordenacao);
  if not Arq.TFPgto.Active then Arq.TFPgto.Open;
  if not Arq.TPortadores.Active then Arq.TPortadores.Open;
  if not Arq.TSittributaria.Active then Arq.TSittributaria.Open;
  if not Arq.TCodigosFiscais.active then Arq.TCodigosFiscais.open;
  if OP='A' then
    operacao:='Altera��o'
  else if op ='S' then
    operacao:='Reaproveitamento Numera��o'
  else
    operacao:='Inclus�o';
  FNotaSaidaMo.Caption:='Nota Fiscal de M�o de Obra - Saida - '+operacao;
  ListaReservaCodigo:=TStringlist.Create;
  ListaReservaQTde:=TStringlist.Create;
  EdUnid_codigo.Text:=Global.CodigoUnidade;
  EdDtEmissao.SetDate(Sistema.hoje);
  EdDtSaida.SetDate(Sistema.hoje);
  tamimp:=40;
  CodigoImp:='00013';  // ver onde colocar o codigo da impressora ecf
  traco:=replicate('-',tamimp);
  EdNumerodoc.enabled:=Global.Topicos[1301];;
//  EdDtemissao.enabled:=false;
  moes_remessas:='';
  moes_clie_codigo:=0;
  usua_codigo:=0;
  StatusNota:='N';
  Sistema.setmessage('');
  Edpercomissao.enabled:=Global.Topicos[1324];
  Edpercomissao2.enabled:=Global.Topicos[1324];
  if OP='I' then
    EdComv_codigo.setfocus
  else begin
    EdNumerodoc.enabled:=true;
    EdDtemissao.enabled:=true;
    if OP='A' then
//      EdNumerodoc.setfocus
//      EdDtemissao.setfocus
// 28.06.05
      EdComv_codigo.setfocus
    else
      EdComv_codigo.setfocus;
  end;

////////////////////////////////////////////////////
  EdPecas.Enabled:=Global.Topicos[1302];
// 13.08.07
  EdMoes_tabp_codigo.Enabled:=Global.Usuario.OutrosAcessos[0306];
//  EdFrete.Enabled:=Global.Usuario.OutrosAcessos[0307];
//  EdSeguro.Enabled:=Global.Usuario.OutrosAcessos[0308];
//  EdPedido.Enabled:=Global.Usuario.OutrosAcessos[0309];
// 12.11.07
//  EdCodcor.Enabled:=Global.Topicos[1309];
//  EdCodTamanho.Enabled:=Global.Topicos[1309];

// 27.09.07
//  TiposFornec:=Global.CodRemessaconserto+';'+Global.CodRemessaDemo+';'+Global.CodDevolucaoSaida;
// 11.08.08
//  TiposFornec:=Global.CodRemessaconserto+';'+Global.CodRemessaDemo+';'+Global.CodDevolucaoSaida+';'+Global.CodRemessaInd;
// 03.12.08
  TiposFornec:=Global.CodRemessaconserto+';'+Global.CodRemessaDemo+';'+Global.CodDevolucaoSaida+';'+
               Global.CodRemessaInd+';'+Global.CodVendaFornecedor;
// 12.12.07 - depois mudar td para usar o campo da conf. de movimento
  NotaTipocad:='C';
// 02.01.08
  EdPortoorigem.Enabled:=Global.Topicos[1312];
  EdPortodestino.Enabled:=Global.Topicos[1312];
  Edcontainer.Enabled:=Global.Topicos[1312];
  SetaPortosEmbarque(EdPortoorigem);
  if not EdPecas.enabled then
    EdPecas.setvalue(0);
// 07.03.08
  EdFreteuni.Enabled:=Global.Topicos[1313];
// 27.05.08
  if Serial.Enabled then
    Serial.Close;
  if Serial2.Enabled then
    Serial2.Close;

  if FGeral.GetConfig1AsString('PORTASERIALNF')<>'' then
    Serial.DeviceName:=FGeral.GetConfig1AsString('PORTASERIALNF');
// 04.06.08
  if FGeral.GetConfig1AsString('PORTASERIALNF2')<>'' then
    Serial2.DeviceName:=FGeral.GetConfig1AsString('PORTASERIALNF2');
// 13.06.08
  if CodMovimento>0 then begin
    EdComv_codigo.setvalue(CodMovimento);
    EdComv_codigo.validfind;
  end;
  if Pedido>0 then begin
    EdPedido.setvalue(Pedido);
  end;
  if CodigoCliente>0 then begin
    EdCliente.setvalue(CodigoCliente);
    EdCliente.validfind;
  end;
//////////////////////
  TipoSaidaAbate:='SA';
// 23.12.08
  EdCertificado.enabled:=Global.Topicos[1326];
end;

procedure TFNotaSaidaMo.FormActivate(Sender: TObject);
//var operacao:string;
begin
{/////////////////////////////
  Sistema.setmessage('Abrindo tabelas');
  if not Arq.TTransp.Active then Arq.TTransp.Open;
  if not Arq.TEstoque.Active then Arq.TEstoque.Open;
  if not Arq.TEstoqueQtde.Active then Arq.TEstoqueQtde.Open;
  if not Arq.TClientes.Active then Arq.TClientes.Open;
  if not Arq.TRepresentantes.Active then Arq.TRepresentantes.Open;
  if not Arq.TTabelaPreco.Active then Arq.TTabelaPreco.Open;
//  Arq.TNatFisc.OpenWith('natf_es=''S''',Arq.TNatFisc.Ordenacao);
  if not Arq.TNatFisc.active then Arq.TNatFisc.open;
//  if not Arq.TConfMovimento.Active then Arq.TConfMovimento.Open;
  Arq.TConfMovimento.OpenWith(FGeral.GetIN('comv_tipomovto',Global.TiposSaida,'C'),Arq.TConfMovimento.Ordenacao);
  if not Arq.TFPgto.Active then Arq.TFPgto.Open;
  if not Arq.TPortadores.Active then Arq.TPortadores.Open;
  if not Arq.TSittributaria.Active then Arq.TSittributaria.Open;
  if not Arq.TCodigosFiscais.active then Arq.TCodigosFiscais.open;
  if OP='A' then
    operacao:='Altera��o'
  else if op ='S' then
    operacao:='Reaproveitamento Numera��o'
  else
    operacao:='Inclus�o';
  FNotaSaida.Caption:='Nota Fiscal de Saida - '+operacao;
  ListaReservaCodigo:=TStringlist.Create;
  ListaReservaQTde:=TStringlist.Create;
  EdUnid_codigo.Text:=Global.CodigoUnidade;
  EdDtEmissao.SetDate(Sistema.hoje);
  EdDtSaida.SetDate(Sistema.hoje);
  tamimp:=40;
  CodigoImp:='00013';  // ver onde colocar o codigo da impressora ecf
  traco:=replicate('-',tamimp);
  EdNumerodoc.enabled:=Global.Topicos[1301];;
//  EdDtemissao.enabled:=false;
  EdDtemissao.enabled:=Global.Usuario.OutrosAcessos[0702];
  moes_remessas:='';
  moes_clie_codigo:=0;
  usua_codigo:=0;
  StatusNota:='N';
  Sistema.setmessage('');

  if OP='I' then
    EdComv_codigo.setfocus
  else begin
    EdNumerodoc.enabled:=true;
    EdDtemissao.enabled:=true;
    if OP='A' then
//      EdNumerodoc.setfocus
//      EdDtemissao.setfocus
// 28.06.05
      EdComv_codigo.setfocus
    else
      EdComv_codigo.setfocus;
  end;
/////////////////////////////}

end;

procedure TFNotaSaidaMo.EditstoGrid;
var x:integer;
    aqtde,reducaobase:currency;
begin

  x:=FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdProduto.Text,Grid,Grid.GetColumn('codtamanho'),Edcodtamanho.asinteger,
                        Grid.getcolumn('codcor'),EdCodcor.asinteger,Grid.getcolumn('codcopa'),EdCodcopa.asinteger);
  reducaobase:=0;
  if x<=0 then begin
    if (Grid.RowCount=2) and (Trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),1])='') then begin
       x:=1;
    end else begin
       Grid.RowCount:=Grid.RowCount+1;
       x:=Grid.RowCount-1;
    end;
    Grid.Cells[Grid.getcolumn('move_esto_codigo'),Abs(x)]:=EdProduto.Text;
    Grid.Cells[Grid.getcolumn('esto_descricao'),Abs(x)]:=SetEdEsto_descricao.text;
    if Nfexporta(EdNatf_codigo.text) then begin
      Grid.Cells[Grid.getcolumn('move_cst'),Abs(x)]:=cstexporta;
      Grid.Cells[Grid.getcolumn('move_aliicms'),Abs(x)]:=currtostr(icmsexporta);
      Grid.Cells[Grid.getcolumn('move_aliipi'),Abs(x)]:='0';
    end else begin
      Grid.Cells[Grid.getcolumn('move_cst'),Abs(x)]:='000';
      Grid.Cells[Grid.getcolumn('move_aliicms'),Abs(x)]:='0';
      reducaobase:=0;
     if DevolucaoCompra( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring)  then
       Grid.Cells[Grid.getcolumn('move_aliipi'),abs(x)]:=currtostr(FEstoque.Getaliquotaipi(EdProduto.text,'S'))
     else begin
       if campoufentidade='forn_uf' then  // 27.09.07
         Grid.Cells[Grid.getcolumn('move_aliipi'),abs(x)]:='0'
       else
         Grid.Cells[Grid.getcolumn('move_aliipi'),abs(x)]:='0';
     end;
    end;
    Grid.Cells[Grid.getcolumn('esto_unidade'),Abs(x)]:=Arq.TServicos.fieldbyname('cadm_unidade').asstring;
    Grid.Cells[Grid.getcolumn('move_qtde'),Abs(x)]:=EdQTde.AsSql;
    Grid.Cells[Grid.getcolumn('move_venda'),Abs(x)]:=EdUnitario.AsSql;
    Grid.Cells[Grid.getcolumn('total'),Abs(x)]:=TRansform(EdQTde.AsFloat*EdUnitario.AsCurrency,f_cr);
    Grid.Cells[Grid.getcolumn('move_perdesco'),Abs(x)]:=EdPerdesconto.AsSql;
    Grid.Cells[Grid.getcolumn('move_vendabru'),Abs(x)]:=EdUnitario.AsSql;
    Grid.Cells[Grid.getcolumn('cor'),Abs(x)]:=FCores.Getdescricao(EdCodcor.asinteger);
    Grid.Cells[Grid.getcolumn('tamanho'),Abs(x)]:=FTamanhos.Getdescricao(EdCodtamanho.asinteger);
    Grid.Cells[Grid.getcolumn('copa'),Abs(x)]:=FCopas.Getdescricao(EdCodcopa.asinteger);
    Grid.Cells[Grid.getcolumn('codcor'),Abs(x)]:=EdCodcor.text;
    Grid.Cells[Grid.getcolumn('codtamanho'),Abs(x)]:=EdCodtamanho.text;
    Grid.Cells[Grid.getcolumn('codcopa'),Abs(x)]:=EdCodcopa.text;
// 08.05.07
    Grid.Cells[Grid.Getcolumn('move_pecas'),Abs(x)]:=EdPecas.assql;
// 24.05.07
    Grid.Cells[Grid.Getcolumn('move_redubase'),Abs(x)]:=Transform(reducaobase,'#0.000');
// 30.05.07
    Grid.Cells[Grid.Getcolumn('move_vendamin'),Abs(x)]:=EdUnitario.AsSql;
// 23.12.08
    Grid.Cells[Grid.Getcolumn('move_certificado'),Abs(x)]:=EdCertificado.text;
  end else begin

    Grid.Cells[Grid.getcolumn('move_esto_codigo'),x]:=EdProduto.Text;
    Grid.Cells[Grid.getcolumn('esto_descricao'),x]:=SetEdEsto_descricao.text;
    if Nfexporta(EdNatf_codigo.text) then begin
      Grid.Cells[Grid.getcolumn('move_cst'),x]:=cstexporta;
      Grid.Cells[Grid.getcolumn('move_aliicms'),x]:=currtostr(icmsexporta);
      Grid.Cells[Grid.getcolumn('move_aliipi'),x]:='0';
    end else begin
      Grid.Cells[Grid.getcolumn('move_cst'),x]:='000';
      Grid.Cells[Grid.getcolumn('move_aliicms'),x]:='0';
      if DevolucaoCompra( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring)  then
        Grid.Cells[Grid.getcolumn('move_aliipi'),x]:='0'
      else
       Grid.Cells[Grid.getcolumn('move_aliipi'),x]:='0';
     end;
    reducaobase:=0;
    Grid.Cells[Grid.getcolumn('esto_unidade'),x]:=Arq.TServicos.fieldbyname('cadm_unidade').asstring;
    aqtde:=texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),x])+ EdQTde.AsFloat;
    Grid.Cells[Grid.getcolumn('move_qtde'),x]:=Valortosql( texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),x])+EdQTde.AsFloat );
    Grid.Cells[Grid.getcolumn('move_venda'),x]:=Valortosql(EdUnitario.Ascurrency);
    Grid.Cells[Grid.getcolumn('total'),x]:=Valortosql( (aqtde)*EdUnitario.AsCurrency);
    Grid.Cells[Grid.getcolumn('move_perdesco'),Abs(x)]:=EdPerdesconto.AsSql;
    Grid.Cells[Grid.getcolumn('move_vendabru'),Abs(x)]:=EdUnitario.AsSql;
    Grid.Cells[Grid.getcolumn('cor'),x]:=FCores.Getdescricao(EdCodcor.asinteger);
    Grid.Cells[Grid.getcolumn('tamanho'),x]:=FTamanhos.Getdescricao(EdCodtamanho.asinteger);
    Grid.Cells[Grid.getcolumn('copa'),x]:=FCopas.Getdescricao(EdCodcopa.asinteger);
    Grid.Cells[Grid.getcolumn('codcor'),x]:=EdCodcor.text;
    Grid.Cells[Grid.getcolumn('codtamanho'),x]:=EdCodtamanho.text;
    Grid.Cells[Grid.getcolumn('codcopa'),x]:=EdCodcopa.text;
// 08.05.07
    Grid.Cells[Grid.Getcolumn('move_pecas'),x]:=EdPecas.assql;
// 24.05.07
    Grid.Cells[Grid.Getcolumn('move_redubase'),x]:=Transform(reducaobase,'#0.000');
// 30.05.07
    Grid.Cells[Grid.Getcolumn('move_vendamin'),x]:=EdUnitario.AsSql;
// 23.12.08
    Grid.Cells[Grid.Getcolumn('move_certificado'),x]:=EdCertificado.text;
  end;
  Grid.Refresh;

end;


procedure TFNotaSaidaMo.bIncluiritemClick(Sender: TObject);
begin
  if EdCliente.AsInteger=0 then exit;
  if EdRepr_codigo.AsInteger=0 then exit;
  PRemessa.Enabled:=false;
  PFinan.Enabled:=false;
  bGravar.Enabled:=false;
  bSair.Enabled:=false;
//  bCancelar.Enabled:=false;
//  PINs.Visible:=true;
  PINs.EnableEdits;
  LimpaEditsItens;
// 27.05.08
  if Global.Topicos[1317] then
    EdQtde.Enabled:=Global.Usuario.OutrosAcessos[0041]
  else
    EdQtde.Enabled:=true;
  EdProduto.SetFocus;

end;

procedure TFNotaSaidaMo.LimpaEditsItens;
begin
  EdProduto.Clear;
  EdQtde.Clear;
  EdUnitario.Clear;
  EdPerdesconto.clear;
  SetedEsto_descricao.Clear;
end;

procedure TFNotaSaidaMo.EdProdutoValidate(Sender: TObject);
var x:integer;
    QBusca:TSqlquery;
    custotrans:currency;
    codbarra:string;
begin
// 05.12.05
  if not FEstoque.ValidaCodigoProduto(EdProduto,EdProduto.text) then
    exit;

  QBusca:=sqltoquery('select * from cadmobra where cadm_codigo='+EdProduto.AsSql);
  EdCodtamanho.Enabled:=Global.Usuario.OutrosAcessos[0305];
//  EdPerdesconto.Enabled:=Global.Usuario.OutrosAcessos[0304];
//

//  SetEdEsto_descricao.text:= QBusca.fieldbyname('esto_descricao').asstring;
  EdUnitario.setvalue(QBusca.fieldbyname('cadm_unitario').ascurrency);


 EdUnitario.enabled:=Global.Usuario.OutrosAcessos[0034];
//  if (EdUnitario.ascurrency=0) and ( not EdUnitario.enabled) then
//    Avisoerro('Aten��o.   Checar pre�o de venda no cadastro.');

// 27/10/04 - caso usar tabela recalcular pre�o de venda mas n�o "aparecer" o desconto ou acr�scimo
// pois estar� embutido no pre�o de venda
  if EdMoes_tabp_codigo.asinteger>0 then begin
    if FTabela.gettipo(EdMoes_tabp_codigo.asinteger) = 'A' then
      EdUnitario.setvalue( EdUnitario.AsCurrency + (EdUnitario.ascurrency*(FTabela.GetAliquota(EdMoes_tabp_codigo.asinteger)/100) ) )
    else
      EdUnitario.setvalue( EdUnitario.AsCurrency - (EdUnitario.ascurrency*(FTabela.GetAliquota(EdMoes_tabp_codigo.asinteger)/100) ) );
  end;
  if Op='A' then begin
    if FGeral.ProcuraGrid(0,Edproduto.text,Grid)>0 then begin
      Edproduto.Invalid('Em altera��o obrigat�rio excluir e incluir');
    end;
  end;

end;



procedure TFNotaSaidaMo.EdQtdeExitEdit(Sender: TObject);

   procedure ImprimeItem;
   var total:currency;
   begin
     Impr.IniciaImpr;
     Impr.ImprimeString(copy(Arq.TEstoque.fieldbyname('esto_codbarra').asstring,1,13),false);
     Impr.ImprimeString(' '+strspace(Arq.TEstoque.fieldbyname('esto_descricao').asstring,26),true);
     Impr.ImprimeString(1,FGeral.Formatavalor(EdQTde.asfloat,'######0'),false);
     Impr.ImprimeString(10,'X '+FGeral.Formatavalor(EdUnitario.ascurrency,'###,##0.00'),false);
     total:=FGeral.Arredonda(EdQtde.asFloat*EdUnitario.ascurrency,2);
     Impr.ImprimeString(27,FGeral.Formatavalor(total,'#,###,##0.00'),true);
     Impr.FimImpr;
   end;


var conf:boolean;
begin

  if codigobarra then
    conf:=true
  else
    conf:=confirma('Confirma item ?');

  if conf then begin
    EditstoGrid;
    SetaEditsValores;
    if Ecf='S' then
      ImprimeItem;
    if op='A' then begin
      ListaReservaCodigo.Clear;
      ListaReservaQtde.Clear;
    end;
  end;
  LimpaEditsItens;
  EdProduto.SetFocus;
//  QEstoque.close;
//  Freeandnil(QEstoque);

end;

procedure TFNotaSaidaMo.ReservaEstoque(Codigo, IncExc: string;
  Qtde: currency);
var p:integer;
begin
// desativada pra servicos - 03.03.09
{
  if not Global.Topicos[1201] then begin
    if Incexc='I' then begin
      ListaReservaCodigo.Add(Codigo);
      ListaReservaQtde.Add(transform(Qtde,'#,###,###.00'));
      FGeral.ReservaEstoque(Codigo,EdUnid_codigo.text,'S',Arq.TConfMovimento.fieldbyname('comv_tipomovto').asstring,Qtde);
    end else begin
      if OP='I'then begin
        p:=ListaReservaCodigo.IndexOf(Codigo);
        if p>-1 then begin
          ListaReservaCodigo.Delete(p);
          ListaReservaQtde.Delete(p);
          FGeral.ReservaEstoque(Codigo,EdUnid_codigo.text,'E',Arq.TConfMovimento.fieldbyname('comv_tipomovto').asstring,Qtde);
        end;
      end else begin
          FGeral.ReservaEstoque(Codigo,EdUnid_codigo.text,'E',Arq.TConfMovimento.fieldbyname('comv_tipomovto').asstring,Qtde);
      end;
    end;
    Sistema.Commit;
  end;
}

end;

procedure TFNotaSaidaMo.SetaEditsValores;

var baseicms,vlricms,basesubs,icmssubs,totalprodutos,totalnota,totalitem,aliicms,icmsitem,margemlucro,tdescacre,
    tqtde,icmsitemsubs,aliipi,ipiitem,vlripi,totalitembase,alicofins,aliir,aliinss,alicsl,vlrcofins,vlrir,vlrcsl,
    issitem:currency;
    p:integer;
    produto,descacre:string;
    precovenda:extended;  // 01.07.08 - mudado de currency pra extended para 'ver' mais casas decimas devido saida abate
    Q:TSqlquery;

    function Calctabela(valor:currency):currency;
    begin
      result:=FGeral.Arredonda( valor*(Arq.TTabelapreco.fieldbyname('tabp_aliquota').AsCurrency/100) ,2 );
    end;

begin
  baseicms:=0; vlricms:=0; basesubs:=0 ; icmssubs:=0 ; totalprodutos:=0 ; totalbruto:=0; tqtde:=0;
  vlripi:=0;vlrcofins:=0 ; vlrir:=0 ; vlrcsl:=0 ;
// percorrer o grid somando valores e montando base do icms normal e subst. tribut�ria
  produtosnota:='';
  aliicms:=FGeral.GetConfig1AsFloat('Perinss');
  aliipi:=FGeral.GetConfig1AsFloat('Perpis');
  alicofins:=FGeral.GetConfig1AsFloat('Percofins');
  alicsl:=FGeral.GetConfig1AsFloat('Percsl');
  aliir:=FGeral.GetConfig1AsFloat('Perir');
  aliinss:=FGeral.GetConfig1AsFloat('Perinss');
  for p:=1 to Grid.rowcount do begin
    produto:=Grid.Cells[Grid.GetColumn('move_esto_codigo'),p];
    if trim(produto)<>'' then begin
      Q:=sqltoquery('select * from cadmobra where cadm_codigo='+trim(produto));
      produtosnota:=produtosnota+Grid.Cells[Grid.GetColumn('esto_referencia'),p]+';';
      precovenda:=texttovalor(Grid.Cells[Grid.GetColumn('move_venda'),p]);
//      if EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodContrato then
        totalitem:=texttovalor(Grid.Cells[Grid.GetColumn('total'),p] );
//      else
//        totalitem:=Fgeral.Arredonda( texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]) * precovenda  ,5);

      tqtde:=tqtde+texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]) ;
      totalbruto:=totalbruto+totalitem;
      if EdPeracre.ascurrency>0 then begin
        totalitem:=totalitem+FGEral.Arredonda( totalitem*(EdPeracre.ascurrency/100) ,2  );
      end else if EdPerdesco.ascurrency>0 then begin
        totalitem:=totalitem-FGEral.Arredonda( totalitem*(EdPerdesco.ascurrency/100) ,2 );
      end;
      Arq.TSittributaria.Locate('sitt_codigo',FEstoque.GetCodigosituacaotributaria(produto,EdUnid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring),[]);
      if texttovalor(Grid.Cells[Grid.GetColumn('move_redubase'),p])>0 then
// 24.05.07 - reducao de base
        totalitembase:=( totalitem*(texttovalor(Grid.Cells[Grid.GetColumn('move_redubase'),p])/100) )
      else
        totalitembase:=totalitem;

      issitem:=0;ipiitem:=0;icmsitem:=0;

      if PCalcula.CalcInss='S' then begin
        if Q.fieldbyname('cadm_incideinss').asstring='S' then
          icmsitem:=FGeral.Arredonda( totalitembase*(aliicms/100) ,2);
        if icmsitem>0 then begin
          baseicms:=baseicms+totalitembase;
          vlricms:=vlricms+icmsitem;
        end;
      end else if PCalcula.CalcInss50='S' then begin
        if Q.fieldbyname('cadm_incideinss').asstring='S' then
          icmsitem:=FGeral.Arredonda( (totalitembase*(50/100))*(aliicms/100) ,2);
        if icmsitem>0 then begin
          baseicms:=baseicms+totalitembase*(50/100);
          vlricms:=vlricms+icmsitem;
        end;
      end;
      margemlucro:=0;
      if PCalcula.CalcIss='S' then begin
        if Q.fieldbyname('cadm_somatotal').asstring='S' then
          issitem:=FGeral.Arredonda( totalitembase*(EdAliiss.ascurrency/100) ,2);
      end;
// 09.03.09 - calcula impostos(pis,cofins...) somente de incide inss
      if Q.fieldbyname('cadm_somatotal').asstring='S' then begin
        if PCalcula.CalcPis='S' then
          ipiitem:=FGeral.Arredonda( totalitem*(aliipi/100) ,2);
        if PCalcula.CalcCofins='S' then
          vlrcofins:=vlrcofins+FGeral.Arredonda( totalitembase*(Alicofins/100) ,2);
        if PCalcula.CalcCsl='S' then
          vlrcsl:=vlrcsl+FGeral.Arredonda( totalitembase*(Alicsl/100) ,2);
        if PCalcula.CalcIR='S' then
          vlrir:=vlrir+FGeral.Arredonda( totalitembase*(Aliir/100) ,2);
      end;

      if issitem>0 then begin
        basesubs:=basesubs+totalitembase;
        icmssubs:=icmssubs+issitem;
      end;
      if ipiitem>0 then
        vlripi:=vlripi+ipiitem;

      if Q.fieldbyname('cadm_somatotal').asstring='S' then
        totalprodutos:=totalprodutos+totalitem;
      Q.Close;q.free;
    end;
  end;
////////////////
{ - 25.08.05 - estava dando o desconto no unit�rio e no total
  if EdMoes_tabp_codigo.AsInteger>0 then begin
    if Arq.TTabelaPreco.Locate('tabp_codigo',EdMoes_tabp_codigo.AsInteger,[]) then begin
      descacre:=Arq.TTabelaPreco.Fieldbyname('tabp_tipo').AsString;
    end else
      descacre:='';
    tdescacre:=FGeral.Arredonda(totalprodutos*(Arq.TTabelapreco.fieldbyname('tabp_aliquota').AsCurrency/100) ,2);
    if descacre='D' then begin
      totalprodutos:=totalprodutos-tdescacre;
      baseicms:=baseicms-Calctabela(baseicms);
      vlricms:=vlricms-Calctabela(vlricms);
      basesubs:=basesubs-Calctabela(basesubs);
      icmssubs:=icmssubs-Calctabela(icmssubs);
    end else if descacre='A' then begin
      totalprodutos:=totalprodutos+tdescacre;
      baseicms:=baseicms+Calctabela(baseicms);
      vlricms:=vlricms+Calctabela(vlricms);
      basesubs:=basesubs+Calctabela(basesubs);
      icmssubs:=icmssubs+Calctabela(icmssubs);
    end;
  end;
}
  if Nfexporta(EdNatf_codigo.text) then begin
    baseicms:=0;
    vlricms:=0;
    basesubs:=0;
    icmssubs:=0;
  end;

//  totalnota:=totalprodutos+EdFrete.Ascurrency+EdSeguro.ascurrency+icmssubs+vlripi;
  totalnota:=totalprodutos;

  PTotais.EnableEdits;
//  EdTotalnota.enabled:=true;
  EdBaseicms.setvalue(baseicms);
  EdValoricms.setvalue(vlricms);
  EdQtdetotal.setvalue(tqtde);
  Edvaloripi.setvalue(vlripi);
  Edtotalcofins.setvalue(vlrcofins);
  Edtotalcsl.setvalue(vlrcsl);
  if FGeral.GetConfig1AsFloat('Vlrminimodarfir') > 0 then begin
    if vlrir>=FGeral.GetConfig1AsFloat('Vlrminimodarfir') then
      Edtotalir.setvalue(vlrir);
  end else
    Edtotalir.setvalue(vlrir);

  EdBasesubs.setvalue(basesubs);
  EdValorsubs.setvalue(icmssubs);
  Edtotalprodutos.setvalue(totalprodutos);
  Edtotalnota.setvalue(totalnota-(vlricms+vlripi+vlrcofins+vlrcsl+vlrir));
  EdValorliquido.setvalue(totalnota-EdValoricms.ascurrency-EdValorsubs.ascurrency-Edvaloripi.ascurrency-EdTotalcofins.ascurrency-Edtotalcsl.ascurrency-Edtotalir.ascurrency);
//  EdTotalnota.enabled:=false;
  PTotais.DisableEdits;
//  Update;
end;

procedure TFNotaSaidaMo.bExcluiritemClick(Sender: TObject);
var codigoestoque:string;
    qtde:currency;
begin
  if EdRepr_codigo.AsInteger=0 then exit;
  if trim(Grid.Cells[Grid.GetColumn('move_esto_codigo'),Grid.row])='' then exit;
  if confirma('Confirma exclus�o ?') then begin
    codigoestoque:=Grid.Cells[Grid.GetColumn('move_esto_codigo'),Grid.row];
    qtde:=texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),Grid.row]);
    Grid.DeleteRow(Grid.Row);
    SetaEditsValores;
    EdComv_codigo.validfind;
    if pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,global.TiposMovMovEstoque)>0 then
      ReservaEstoque(Codigoestoque,'E',qtde);
    Sistema.Commit;
  end;
  EdFpgt_codigo.ValidateEdit;
end;

procedure TFNotaSaidaMo.bCancelaritemClick(Sender: TObject);
begin
  if EdRepr_codigo.AsInteger=0 then exit;
  bGravar.Enabled:=true;
//  bCancelar.Enabled:=true;
  bSair.Enabled:=true;
  PFinan.Enabled:=true;
//  PINs.Visible:=false;
  PINs.DisableEdits;
//  AtivaEdits;
  PRemessa.Enabled:=true;
//  EdComv_codigo.SetFocus;
  EdPort_codigo.setfocus;

end;

procedure TFNotaSaidaMo.EdFpgt_codigoValidate(Sender: TObject);
var nparcelas,n:integer;
    ListaPrazo:TStringlist;
    p:integer;
    valorparcela,valortotal,valoravista:currency;
    venci:TDatetime;
begin
  if not EdFpgt_codigo.validfind then exit;
// 10.11.05
  if (FCondPagto.GetAvPz(EdFpgt_codigo.text)='V') or (Fcondpagto.Getprimeiroprazo(EdFpgt_codigo.text)=0) then begin
    if EdUnid_codigo.Resultfind.fieldbyname('Unid_contacontabil').AsInteger=0 then begin
      EdFpgt_codigo.INvalid('Unidade sem conta caixa cadastrada para lan�amentos a vista');
      exit;
    end;
  end;
// 27.09.07
  if FGeral.GetGeraFinanceiro(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring)<>'S' then begin
    GridParcelas.clear;
    exit;
  end;
  if (op='I') or (EdFpgt_codigo.text<>EdFpgt_codigo.OldValue) then
    GridParcelas.Clear;
  if ( (FCondPagto.GetAvPz(EdFpgt_codigo.text)='P') and (OP='I') ) or (EdFpgt_codigo.text<>EdFpgt_codigo.OldValue ) then begin
    ListaPrazo:=TStringlist.create;
    n:=FCondPagto.GetPrazos(EdFpgt_codigo.text,ListaPrazo);
    valoravista:=FGeral.GetValorAvista(Listaprazo);
    nparcelas:=FCondPagto.GetNumeroParcelas(EdFpgt_codigo.text);
/////////////////////////////////////////////////////////////////
// 11.03.05 - reges pegou bug quando tem parte a vista e mais de duas parcelas
    valortotal:=EdTotalNota.AsCurrency- valoravista;
    acumulado:=0;
    for p:=1 to nparcelas do begin
      venci:=FGeral.GetProximoDiaUtil(EdDtEmissao.Asdate+Inteiro(ListaPrazo[p-1]),Inteiro(ListaPrazo[p-1])) ;
// 24.09.08
      venci:=FGeral.GetVencimentoPadrao(venci);
      GridParcelas.cells[0,p]:=formatdatetime('dd/mm/yy',venci)  ;
      if (p=nparcelas) and (valoravista=0) then
        valorparcela:=valortotal-acumulado  // para deixar na ultima parcelas "as d�zimas"
      else begin
        if (valoravista>0) then begin
          valorparcela:=FGeral.Arredonda(valortotal/(nparcelas-1),2);
          if (p=nparcelas) then
            valorparcela:=valortotal+valoravista-acumulado  // para deixar na ultima parcelas "as d�zimas" - 01.06.05
        end else
          valorparcela:=FGeral.Arredonda((valortotal)/nparcelas,2);
      end;
      if (valoravista>0) and (p=1) then begin
        GridParcelas.cells[1,p]:=Transform(valoravista,f_cr);
        acumulado:=acumulado+valoravista;
      end else begin
        GridParcelas.cells[1,p]:=Transform(valorparcela,f_cr);
        acumulado:=acumulado+valorparcela;
      end;
      GridParcelas.RowCount:=GridParcelas.RowCount+1;
    end;  // for do numero de parcelas

//////////////////////////////////////////////////////////////
{
    acumulado:=0;
//    valortotal:=EdTotalNota.AsCurrency-valoravista;
// 21.01.05
    valortotal:=EdTotalNota.AsCurrency;
    for p:=1 to nparcelas do begin
//      GridParcelas.cells[0,p]:=formatdatetime('dd/mm/yy',FGeral.GetProximoDiaUtil(EdDtEmissao.Asdate+Inteiro(ListaPrazo[p-1])) );
      GridParcelas.cells[0,p]:=formatdatetime('dd/mm/yy',FGeral.GetProximoDiaUtil(EdDtEmissao.Asdate+Inteiro(ListaPrazo[p-1]),Inteiro(ListaPrazo[p-1]))  );
//      Sistema.SetField('Pend_Parcela',p);
//      Sistema.SetField('Pend_NParcelas',nparcelas);
      if p=nparcelas then
        valorparcela:=EdTotalnota.ascurrency-acumulado  // para deixar na ultima parcelas "as d�zimas"
      else begin
        if valoravista>0 then
          valorparcela:=FGeral.Arredonda(valortotal/(nparcelas-1),2)
        else
          valorparcela:=FGeral.Arredonda(valortotal/nparcelas,2);
      end;
//      GridParcelas.cells[1,p]:=strspace(Transform(valorparcela,f_cr),10);
//      GridParcelas.cells[1,p]:=Transform(valorparcela,f_cr);
      if (valoravista>0) and (p=1) then begin
        GridParcelas.cells[1,p]:=Transform(valoravista,f_cr);
        acumulado:=acumulado+valoravista;
      end else begin
        GridParcelas.cells[1,p]:=Transform(valorparcela,f_cr);
        acumulado:=acumulado+valorparcela;
      end;
      GridParcelas.RowCount:=GridParcelas.RowCount+1;
    end;  // for do numero de parcelas
}
////////////////////////////////////////////////////////////////////
    Freeandnil(ListaPrazo);
  end;
//  bgravarclick(FNotaSaida);   // para pode alterar direto no grid
end;

//////////////////////////////////////////////////////////////////////////////
procedure TFNotaSaidaMo.bGravarClick(Sender: TObject);
////////////////////////////////////////////////////////////////
var Numero,romaneio,xpedido:integer;
    valorcomissao,valoravista:currency;
    QVePendencia:Tsqlquery;
    Tipocad:string;

    function TotalParcela:currency;
    var p:integer;
        valor:currency;
    begin
      valor:=0;
      for p:=1 to Gridparcelas.rowcount do begin
        valor:=valor+texttovalor(Gridparcelas.cells[1,p]);
      end;
      result:=valor;
    end;

   procedure ImprimeTotal;
   var vlrdesconto,vlracrescimo:currency;
   begin
     Impr.IniciaImpr;
     Impr.ImprimeString(traco,true);
     if totalbruto<Edtotalnota.AsCurrency then begin
       vlracrescimo:=Edtotalnota.AsCurrency-totalbruto;
       Impr.ImprimeString(20,'Acres.'+FGeral.Formatavalor(vlracrescimo,'##,###,##0.00'),true);
     end else if totalbruto>Edtotalnota.AsCurrency then begin
       vlrdesconto:=totalbruto-Edtotalnota.AsCurrency;
       Impr.ImprimeString(20,'Desco.'+FGeral.Formatavalor(vlrdesconto,'##,###,##0.00'),true);
     end;
     Impr.ImprimeString(traco,true);
     Impr.ImprimeString(20,'Total '+FGeral.Formatavalor(EdTotalProdutos.ascurrency,'##,###,##0.00'),true);
     Impr.SaltaLinha(3);
     Impr.FimImpr;
   end;



////////////////////gravacao nota
var xCondicao,unidadecomissao:string;   // 08.12.08
begin

   if not EdCliente.validfind then begin
     Avisoerro('Checar cliente');
     exit;
   end;
// 06.08.05
//   if not EdUnid_codigo.valid then begin
   if EdUnid_codigo.isempty then begin
     Avisoerro('Checar unidade');
     exit;
   end;
   if (EdFpgt_codigo.isempty) and
// 07.03.08
       ( pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodContrato)=0 )
    then begin
     Avisoerro('Checar condi��o de pagamento');
     exit;
   end;
//   if not Edrepr_codigo.valid then begin
   if (Edrepr_codigo.isempty) or (strtointdef(Edrepr_codigo.text,0)=0) then begin
     Avisoerro('Checar representante');
     exit;
   end;
// 22.08.08
   if trim(Grid.cells[Grid.getcolumn('move_esto_codigo'),1])='' then begin
     Avisoerro('Obrigat�rio informar ao menos um produto');
     exit;
   end;
// 11.06.08
   if ( (not EdDtmovimento.isempty) ) and (Global.Topicos[1319] ) then begin
     if campoufentidade='forn_uf' then begin
       if ( not FGeral.CnpjcpfOK(EdCliente.resultfind.fieldbyname('forn_cnpjcpf').AsString) ) then  begin
         Avisoerro('Obrigat�rio fornecedor com CNPJ/CPF v�lido');
         exit;
       end;
     end else begin
       if ( not FGeral.CnpjcpfOK(EdCliente.resultfind.fieldbyname('clie_cnpjcpf').AsString) ) then  begin
         Avisoerro('Obrigat�rio cliente com CNPJ/CPF v�lido');
         exit;
       end;
     end;
   end;
////////////
   valoravista:=0;
   if (FCondpagto.GetAvPz(EdFpgt_codigo.text)='P') and (FGeral.GetGeraFinanceiro(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring)='S')
      and ( pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodContrato)=0 )
     then begin
//     if EdTotalnota.ascurrency-EdVlrdesco.ascurrency<>Totalparcela then begin
// 24.10.05 - total da nota ja esta com desconto
     if EdTotalnota.ascurrency<>Totalparcela then begin
       Avisoerro('Total da nota :'+formatfloat(f_cr,EdTotalnota.ascurrency)+' difere do total de parcelas :'+formatfloat(f_cr,Totalparcela));
       exit;
     end;
   end;
   if FCondpagto.GetPrimeiroPrazo(EdFpgt_codigo.text)=0 then begin
     if gridparcelas<>nil then
        valoravista:=texttovalor(Gridparcelas.cells[Gridparcelas.getcolumn('pend_valor'),1] );
   end;
   if (Grid.RowCount<=1)then begin
     Avisoerro('Sem parcelas para o financeiro');
     exit;
   end;
// 10.09.07
   if (not EdDtmovimento.isempty) then begin
     if  campoufentidade='forn_uf' then begin
       if ( trim(EdCliente.resultfind.fieldbyname('forn_cnpjcpf').AsString)='' ) then  begin
         Avisoerro('Obrigat�rio fornecedor com CNPJ/CPF');
         exit;
       end;
     end else begin
       if ( trim(EdCliente.resultfind.fieldbyname('clie_cnpjcpf').AsString)='' ) then  begin
         Avisoerro('Obrigat�rio cliente com CNPJ/CPF');
         exit;
       end;
     end;
   end;
   if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring <> Global.CodVendaConsig then begin
     if EdTran_codigo.asinteger=0 then begin
       Avisoerro('Obrigat�rio codigo do transportador');
       exit;
     end;
   end;
// 02.03.06
   if not FGeral.ValidaGridVencimentos(GridParcelas) then exit;

   if OP='A' then begin
        QVePendencia:=sqltoquery('select * from pendencias where '+FGeral.Getin('pend_status','B;P;K','C')+' and pend_numerodcto='+EdNumerodoc.AsSql+
                             ' and pend_datamvto>='+EdDtemissao.assql+' and pend_tipocad=''C'' and pend_tipo_codigo='+EdCliente.assql);
        if not QVePendencia.eof then begin
             Avisoerro('Nota com pend�ncia financeira baixada.  Transa��o '+QVependencia.fieldbyname('pend_transacao').asstring+'.  Altera��o n�o permitida.');
             exit;
        end;
       qVePendencia.close;
   end;
// 27.05.08
   if Serial.Enabled then
     Serial.close;
   if Serial2.Enabled then
     Serial2.close;

   if confirma('Confirma grava��o ?') then begin
      if Ecf='S' then
        Imprimetotal;
      ListaReservaCodigo.Clear;
      ListaReservaQtde.Clear;
      Romaneio:=0;
// 30.08.05 - tentar evitar q lance enquanto ainda estiver gravando... ou q leia algum outro codigo de barra
      Sistema.BeginProcess('Gravando');
// 27.08.04 - colocado unidade no contador das notas e remaneios de saida
        Sistema.BeginTransaction('');
        if (OP='I') or (OP='S') then begin
// 23.02.07
          if  not Global.Topicos[1301] then begin
            if ecf='S' then
              Numero:=FGeral.GetContador('NFSAIDAECF'+Global.CodigoUnidade,false)
            else if (EdDtmovimento.asdate<=1) and (OP='I') then
              Numero:=FGeral.GetContador('SAIDAMO'+Global.CodigoUnidade+EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,false)
            else if (OP='S') then
              Numero:=EdNumerodoc.asinteger
            else begin
              if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring<>Global.CodContrato then begin  // 23.11.07
                Numero:=FGeral.GetContador('NFSAIDAMO'+Global.CodigoUnidade+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false);
                if ( FGeral.Getconfig1asinteger('Numeronfs'+Global.codigounidade)>0 ) and
                   ( EdDtmovimento.asdate<=1 ) and (Op='I') then begin
                  if Numero<FGeral.Getconfig1asinteger('Numeronfs'+Global.codigounidade) then begin
                    Numero:=FGeral.Getconfig1asinteger('Numeronfs'+Global.codigounidade);
                    FGeral.AlteraContador('NFSAIDAMO'+Global.CodigoUnidade+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.serieunidade),Numero);
                  end;
                end;
                FGeral.Checacontador(numero-1,EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,sistema.hoje);
              end else begin
    // 02.12.08
                if pos('-',EdPedido.text)=0 then
                  xpedido:=EdPedido.asinteger
                else
                  xpedido:=0;
//                if (not EdPedido.isempty) or (EdPedido.asinteger>0) then
                if xPedido>0 then
                  Numero:=xpedido
                else
                  Numero:=FGeral.GetContador('NFS'+Global.CodigoUnidade+edComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,false);
              end;
            end;
          end else begin
            Numero:=EdNumerodoc.asinteger;
// 04.05.07
            FGeral.AlteraContador('NFSAIDAMO'+Global.CodigoUnidade+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.serieunidade),Numero);
          end;

          EdNumerodoc.Text:=inttostr(Numero);
        end else begin    // alteracao
          CancelaTransacao(Transacao);
// 18.05.06
          FGeral.Gravalog(7,'numero '+Transacao,true,transacao,usua_codigo,'Altera��o Nota de Saida '+EdNumerodoc.text);
          Numero:=EdNumerodoc.asinteger;
        end;
// 16.09.05
        tipocad:='C';
        if pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodDevolucaoCompra+';'+Global.CodDevolucaoCompraSemestoque+';'+Global.CodRemessaConserto+';'+TiposFornec)>0 then
          tipocad:='F';
        Transacao:=FGeral.GetTransacao;
///////////////
        FGeral.GravaMestreNFSaidaMO(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
               EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Transacao,EdFpgt_codigo.text,
               EdNatf_codigo.text,EdEmides.text,EdEspecievolumes.text,Numero,EdComv_codigo.asinteger,EdQtdevolumes.asinteger,
               EdTotalNOta.AsCurrency,EdBaseicms.ascurrency,EdValoricms.ascurrency,EdBasesubs.ascurrency,EdValorsubs.ascurrency,EdFrete.ascurrency,
               EdMoes_Tabp_codigo.AsInteger,EdDtmovimento.Asdate,EdTotalprodutos.ascurrency,Edperacre.AsCurrency,Edperdesco.AsCurrency,Romaneio,valoravista,
               moes_remessas,StatusNota,EdMensagem.text,xPedido,Edtran_codigo.text,EdPesoliq.ascurrency,EdPesobru.ascurrency,moes_clie_codigo,
               EdValoripi.ascurrency,EdFreteuni.ascurrency,EdPortoorigem.text,EdPortodestino.text,EdContainer.text,
               EdRepr_codigo2.AsInteger , TiposFornec,Edaliiss.AsCurrency,Edtotalcofins.ascurrency,Edtotalcsl.ascurrency,
               EdTotalir.ascurrency );

        FGeral.GravaItensNFSaidaMO(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
               EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Transacao,Numero,Grid,EdFRete.ascurrency,EdSEguro.ascurrency,EdPeracre.AsCurrency,
               EdPerdesco.ascurrency,EdDtMovimento.asdate,moes_remessas,StatusNota,xPedido,moes_clie_codigo,
               EdNatf_codigo.text,revenda,EdComv_codigo.asinteger,NotaTipocad );

        valorcomissao:=FGeral.CalculaComissao(EdRepr_codigo,EdFpgt_codigo.text,Grid,EdMoes_tabp_codigo,EdUnid_codigo.text);
        if pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.TiposGeraFinanceiro)>0 then begin
          FGeral.GravaPendencia(EdDtemissao.asdate,EdDtmovimento.asdate,EdCliente,tipocad,Edrepr_codigo.asinteger,EdUNid_codigo.text,
                   EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Transacao,EdFpgt_codigo.text,
                   'R',Numero,EdComv_codigo.asinteger,EdTotalnota.ascurrency,Valorcomissao,'N',0,0,GridParcelas,'',EdPort_codigo.text);
          unidadecomissao:=EdUNid_codigo.text;
          if trim(FGeral.GetConfig1AsString('UNIDADECOMISSAO'))<>'' then
            unidadecomissao:=FGeral.GetConfig1AsString('UNIDADECOMISSAO');
          xCondicao:=FGeral.GetConfig1AsString('FpgtoComissao');
          valorcomissao:=EdTotalNota.ascurrency*(EdPerComissao.ascurrency/100);
          if ( Global.Topicos[1325] ) and (EdPerComissao.ascurrency>0)  and (trim(xcondicao)<>'' ) then
            FGeral.GravaPendencia(EdDtemissao.asdate,EdDtmovimento.asdate,EdRepr_codigo,'R',Edrepr_codigo.asinteger,unidadecomissao,
                   EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Transacao,xCondicao,
                   'P',Numero,EdComv_codigo.asinteger,ValorComissao,0,'N',0,0,nil,'',EdPort_codigo.text);
          valorcomissao:=EdTotalNota.ascurrency*(EdPerComissao2.ascurrency/100);
          if ( Global.Topicos[1325] ) and (EdPerComissao2.ascurrency>0)  and (trim(xcondicao)<>'' ) then
            FGeral.GravaPendencia(EdDtemissao.asdate,EdDtmovimento.asdate,EdRepr_codigo2,'R',Edrepr_codigo2.asinteger,unidadecomissao,
                   EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Transacao,xCondicao,
                   'P',Numero,EdComv_codigo.asinteger,ValorComissao,0,'N',0,0,nil,'',EdPort_codigo.text);

        end;

////////////////////////////////////
        try
          Sistema.EndTransaction('');
////////////////////////////////////
        except  // 09.08.06
          FGeral.Gravalog(99,'Problemas na grava��o do documento'+inttostr(numero),true,transacao);
// 09.10.08 - caso der pau retorna 1 no contador de nota
          if (EdDtmovimento.asdate>1) and (OP='I') and not Global.Topicos[1301] then
            FGeral.AlteraContador('NFSAIDAMO'+Global.CodigoUnidade+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.serieunidade),Numero-1);
        end;

        Sistema.EndProcess('');
        EdComv_codigo.ClearAll(FNotaSaidaMo,99);
        EdDtEmissao.SetDate(Sistema.hoje);
        EdDtSaida.SetDate(Sistema.hoje);
        EdUnid_codigo.Text:=Global.CodigoUnidade;
        EdProduto.clearall(FNotaSaidaMo,99);

        Grid.Clear;
        GridParcelas.clear;
        EdPort_codigo.ClearAll(FNotaSaidaMo,99);
        EdBaseicms.ClearAll(FNotaSaidaMo,99);
        if Ecf<>'S' then begin
          if confirma('Imprime nota agora ?') then
            FImpressao.ImprimeNotaSaidaMO(Numero,EdDtEmissao.AsDate,EdUnid_codigo.text,EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring);
        end;

   end;
   if Op='I' then
     EdComv_codigo.setfocus
   else
     EdNumerodoc.setfocus;
end;

procedure TFNotaSaidaMo.bSairClick(Sender: TObject);
begin
  Close;

end;

procedure TFNotaSaidaMo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var QMestre:TSqlquery;
begin
  if (EdCliente.AsInteger>0) and (EdRepr_codigo.AsInteger>0) then begin
    if OP='I' then begin
      QMestre:=Sqltoquery('select moes_status from movesto where moes_status=''N'''+
          ' and moes_tipomov='+Stringtosql(Arq.TConfMovimento.fieldbyname('comv_tipomovto').asstring)+
          ' and moes_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and moes_tipo_codigo='+EDCliente.AsSql+
          ' and moes_datamvto='+EdDtEmissao.AsSql+
          ' and moes_numerodoc='+EdNumerodoc.AsSql+
          ' and moes_tipocad='+Stringtosql('C') );
      if Ecf='N' then begin
        if (QMestre.Eof) and (EdTotalnota.ascurrency>0) then begin
          if Confirma('� prov�vel que este documento ainda n�o foi gravado.  Gravar ?') then
            bgravarclick(Self);
        end else begin
          RetornaReserva;  // 15.12.04 // retornar os itens ao estoque
        end;
      end else
        bgravarclick(Self);   // se for ecf grava de qq jeito
      RetornaReserva;
    end else begin
//      FGeral.GravaMestreConsignacao(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
//             Arq.TConfMovimento.fieldbyname('comv_tipomovto').asstring,Transacao,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger);
//      Sistema.Commit;
    end;
  end;

  Grid.Clear;
  if ListaReservaCodigo<>nil then ListaReservaCodigo.Free;
  if ListaReservaQtde<>nil then ListaReservaQtde.Free;
  Arq.TNatFisc.close;
// 27.05.08
  if Serial.Enabled then
    Serial.Close;
  if Serial2.Enabled then
    Serial2.Close;

end;

procedure TFNotaSaidaMo.RetornaReserva;
var p:integer;
begin
  if pos(Arq.TConfMovimento.fieldbyname('comv_tipomovto').asstring,global.TiposMovMovEstoque)>0 then begin
    if ListaReservaCodigo<>nil then begin
      if ListaReservaCodigo.Count>0 then begin
        for p:=0 to ListaReservaCodigo.Count-1 do begin
          FGeral.ReservaEstoque(ListaReservaCodigo[p],EdUnid_codigo.text,'E',Arq.TConfMovimento.fieldbyname('comv_tipomovto').asstring,texttovalor(ListaReservaQtde[p]));
        end;
        Sistema.Commit;
        ListaReservaCodigo.Clear;
        ListaReservaQTde.Clear;
      end;
    end;
  end;
end;


procedure TFNotaSaidaMo.Edunid_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.Limpaedit(EdUNid_codigo,key);
end;

procedure TFNotaSaidaMo.EdDtSaidaValidate(Sender: TObject);
begin
  if not FGeral.ValidaMvto(EdDtSaida) then
    EdDtSaida.Invalid('')
  else if EdDtSaida.AsDate<EdDtemissao.asdate then
    EdDtSaida.Invalid('Data de saida tem que ser maior ou igual a emiss�o')
  else if OP='I' then
    EdDtmovimento.setdate(EdDtsaida.asdate);
end;

procedure TFNotaSaidaMo.EdFpgt_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
   FGeral.LImpaEdit(Edfpgt_codigo,key);
end;

procedure TFNotaSaidaMo.EdNatf_codigoValidate(Sender: TObject);
var iniciook:string;
begin
  if EdCliente.resultfind.fieldbyname(campoufentidade).asstring<>Global.UFUnidade then
    iniciook:='6'
  else
    iniciook:='5';
  if copy(EdNatf_codigo.text,1,1)<>'7' then begin
    if pos(copy(EdNatf_codigo.text,1,1),iniciook)=0 then
      EdNatf_codigo.Invalid('Natureza inv�lida para esta opera��o');
  end else if copy(EdNatf_codigo.text,1,1)='7' then begin
     EdMens_codigo.setvalue(FGeral.getconfig1asinteger('CODMENEXPO'));
  end;
end;

procedure TFNotaSaidaMo.EdPort_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.Limpaedit(EdPort_codigo,key);
end;

procedure TFNotaSaidaMo.Edunid_codigoValidate(Sender: TObject);
begin
  if EdUnid_codigo.ResultFind.fieldbyname('unid_uf').asstring<>EdCliente.resultfind.fieldbyname(campoufentidade).asstring then
    EdNatf_codigo.text:=Arq.TConfMovimento.fieldbyname('comv_natf_foestado').asstring
  else
    EdNatf_codigo.text:=Arq.TConfMovimento.fieldbyname('comv_natf_estado').asstring;
  if OP<>'A' then begin
    if not FGeral.ValidaUnidadesMvtoUsuario(EdUnid_codigo) then
      EdUnid_codigo.invalid('')
    else begin
      if Global.Topicos[1332] then
        EdNUmerodoc.setvalue( FGeral.ConsultaContador('NFSAIDA'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade))+1 )
      else
        EdNUmerodoc.setvalue( FGeral.ConsultaContador('NFSAIDAMO'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade))+1 )
    end;
  end;

end;

procedure TFNotaSaidaMo.EdClienteValidate(Sender: TObject);
var restricao1,restricao2,restricao3,restricao4:boolean;
    usuariolib:integer;
    obsliberacao,unidades:string;

    procedure SetaEditsPedido;
    begin
      EdUnid_codigo.text:=QPed.fieldbyname('mped_unid_codigo').asstring;
      EdFpgt_codigo.text:=QPed.fieldbyname('mped_fpgt_codigo').asstring;
    end;

    procedure SetaGridPedido;
    var p:integer;
        unitario:currency;
    begin
      Grid.Clear;p:=1;
      while not QPed.Eof do begin
        unitario:=QPed.fieldbyname('mpdd_venda').Ascurrency;
        Grid.Cells[Grid.GetColumn('move_esto_codigo'),p]:=QPed.fieldbyname('mpdd_esto_codigo').Asstring;
        Grid.Cells[Grid.GetColumn('esto_descricao'),p]:=FEstoque.GetDescricao(QPed.fieldbyname('mpdd_esto_codigo').Asstring);
        Grid.Cells[Grid.getcolumn('move_cst'),p]:=FEstoque.Getsituacaotributaria(QPed.fieldbyname('mpdd_esto_codigo').Asstring,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,
                            Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,EdCliente.asinteger);
        Grid.Cells[Grid.getcolumn('move_aliicms'),p]:=currtostr(FEstoque.Getaliquotaicms(QPed.fieldbyname('mpdd_esto_codigo').Asstring,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,EdCliente.asinteger,
                            Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring) );
        Grid.Cells[Grid.GetColumn('esto_unidade'),p]:=FEstoque.GetUnidade(QPed.fieldbyname('mpdd_esto_codigo').Asstring);
        Grid.Cells[Grid.GetColumn('move_venda'),p]:=TRansform(unitario,f_cr);
        if QPed.fieldbyname('mpdd_cubagem').asfloat>0 then begin
          Grid.Cells[Grid.GetColumn('move_qtde'),p]:=transform(QPed.fieldbyname('mpdd_cubagem').AsFloat,'###.###');
          Grid.Cells[Grid.GetColumn('total'),p]:=TRansform(QPed.fieldbyname('mpdd_cubagem').AsFloat*unitario,f_cr);
        end else begin
          Grid.Cells[Grid.GetColumn('move_qtde'),p]:=transform(QPed.fieldbyname('mpdd_qtde').AsFloat,f_qtdestoque);
          Grid.Cells[Grid.GetColumn('total'),p]:=TRansform(QPed.fieldbyname('mpdd_qtde').AsFloat*unitario,f_cr);
        end;
        Grid.Cells[Grid.getcolumn('move_remessas'),p]:='';
        Grid.Cells[Grid.getcolumn('vendamove'),p]:=Transform(QPed.fieldbyname('mpdd_venda').Ascurrency,f_cr);
        inc(p);
        Grid.AppendRow;
        QPed.Next;
      end;
    end;

begin

  restricao1:=true;
  restricao2:=true;
  restricao3:=true;
  restricao4:=true;
  usuariolib:=0;
  obsliberacao:='';
  unidades:=Global.Usuario.UnidadesMvto;
  if Global.Topicos[1255] then
    unidades:=Global.CodigoUnidade;
  if EdCliente.resultfind<>nil then begin
//////////////// - 23.05.07 - restricoes de cr�dito
    if (OP='I') and (Global.Topicos[1303]) and (campoufentidade='clie_uf') then begin
      restricao1:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','DUP',unidades );
      restricao2:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','BOL',unidades );
      restricao3:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','CHQ',unidades );
      restricao4:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','LIM',unidades );
      EdRepr_codigo.setvalue(Edcliente.ResultFind.fieldbyname('clie_repr_codigo').asinteger);
      EdRepr_codigo.ValidFind;
    end else begin
      restricao1:=true;
      restricao2:=true;
      restricao3:=true;
      restricao4:=true;
    end;
    if not restricao1 then begin //fixo portador duplicata
//      if not Confirma('Venda a vista') then
// 27.11.08
        if not FGEral.ValidaLiberacaoFinan(Global.usuario.codigo,'DUP') then begin
          EdCliente.Invalid('');
          exit;
        end;
{
       usuariolib:=FUsuarios.GetSenhaAutorizacao(706);
        if usuariolib>0 then begin
//          Input('Contato com representante','Observa��o',obsliberacao,150,true);
//          if trim(obsliberacao)='' then begin
//            EdCliente.Invalid('Preenchimento Obrigat�rio');
//            exit;
//          end;
          FGeral.Gravalog(16,'Venda Cliente '+EdCliente.text+' - '+SetEdCLIE_NOME.text+' Repr.'+Sqled3.text+' - DUP',true,
                          '',usuariolib,obsliberacao);
        end else begin
          EdCliente.Invalid('');
          exit;
        end;
}

    end else if not restricao2  then begin //fixo portador boleto
//      if not Confirma('Venda a vista') then
// 27.11.08
        if not FGEral.ValidaLiberacaoFinan(Global.usuario.codigo,'DUP') then begin
          EdCliente.Invalid('');
          exit;
        end;

{
       usuariolib:=FUsuarios.GetSenhaAutorizacao(706);
        if usuariolib>0 then begin
//          Input('Contato com representante','Observa��o',obsliberacao,100,true);
//          if trim(obsliberacao)='' then begin
//            EdCliente.Invalid('Preenchimento Obrigat�rio');
//            exit;
//          end;
          FGeral.Gravalog(16,'Venda Cliente '+EdCliente.text+' - '+SetEdCLIE_NOME.text+' Repr.'+Sqled3.text+' - BOL',true,
                          '',usuariolib,obsliberacao);
        end else begin
          EdCliente.Invalid('');
          exit;
        end;
}
    end else if not restricao3  then begin //cheques devolvidos
// 27.11.08
        if not FGEral.ValidaLiberacaoFinan(Global.usuario.codigo,'DUP') then begin
          EdCliente.Invalid('');
          exit;
        end;
{
// 13.07.06 - tania
       usuariolib:=FUsuarios.GetSenhaAutorizacao(706);
       if usuariolib>0 then begin
//          Input('Contato com representante','Observa��o',obsliberacao,100,true);
//          if trim(obsliberacao)='' then begin
//            EdCliente.Invalid('Preenchimento Obrigat�rio');
//            exit;
//          end;
          FGeral.Gravalog(16,'Venda Cliente '+EdCliente.text+' - '+SetEdCLIE_NOME.text+' Repr.'+Sqled3.text+' - CHQ',true,
                          '',usuariolib,obsliberacao);
        end else begin
          EdCliente.Invalid('');
          exit;
        end;
}
    end else if not restricao4  then begin // total em aberto versus limite de cr�dito
// 05.06.07
//       usuariolib:=FUsuarios.GetSenhaAutorizacao(302);
//       if usuariolib>0 then begin
//       if usuariolib>0 then begin
//          FGeral.Gravalog(18,'Venda Cliente '+EdCliente.text+' - '+SetEdCLIE_NOME.text+' Repr.'+Sqled3.text+' - LIM',true,
//                          '',usuariolib,obsliberacao);
        if not FGEral.ValidaLiberacaoLimite(Global.usuario.codigo) then begin
          EdCliente.Invalid('');
          exit;
        end;
    end;
// 28.11.08
//////    FGeral.NegaUsuarioOutrosAcessos(Global.Usuario.Codigo,712);

///////////////
    if campoufentidade='clie_uf' then begin
      EdRepr_codigo.setvalue(Edcliente.ResultFind.fieldbyname('clie_repr_codigo').asinteger);
      if not FGeral.ValidaCliente( EdCliente,Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring ) then
        EdCliente.Invalid('');
      revenda:=Edcliente.ResultFind.fieldbyname('clie_consfinal').asstring;
    end else begin
      if Devolucaocompra(Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring) or TiposFornecedor(Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring) then
        EdRepr_codigo.setvalue(0)
      else
        EdRepr_codigo.setvalue(Edcliente.ResultFind.fieldbyname('clie_repr_codigo').asinteger);
      revenda:='N';
    end;
    if OP='A' then
      EdRepr_codigo.setfocus;
    if not global.topicos[1301] then begin
// 31.08.05
      if (OP='I') and (Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodVendaAmbulante) then
          EdNumerodoc.enabled:=true
      else if OP<>'A' then
          EdNumerodoc.enabled:=false;
   end;
// 09.08.06
    Editsconsig('D');;
    if (OP='I') and (Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodVendaConsigMercantil) then begin
      Editsconsig('A');
      SetaItemsConsig(Global.CodConsigMercantil,EdVendasmc);    // vendas
      SetaItemsConsig(Global.CodDevolucaoConsigMerc,EdDevolucoesdm);  //devolucoes
    end;
// 28.11.07
    if (OP='I') and (Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodContratoEntrega) then begin
      Editsconsig('A');
      SetaItemsConsig(Global.CodContrato,EdVendasmc);    // vendas contrato
      SetaItemsConsig(Global.CodContratoEntrega,EdDevolucoesdm);    // vendas contrato entrega
    end;

    if (OP='I') and ( not EdPedido.isempty )  and ( not QPed.Eof ) then  begin
      if QPed.fieldbyname('mped_tipo_codigo').asinteger<>EdCliente.asinteger then
        EdCliente.Invalid('Pedido pertence ao cliente '+QPed.fieldbyname('mped_tipo_codigo').asstring)
      else begin
        SetaEditsPedido;
        SetaGridPedido;
        SetaEditsValores;
      end;
    end;
  end;
end;

procedure TFNotaSaidaMo.EdComv_codigoValidate(Sender: TObject);
var QRoma:TSqlquery;
begin
  EdMens_codigo.setvalue(0);
  if Edcomv_codigo.ResultFind=nil then
    EdComv_codigo.validfind;
// 12.12.07
  NotaTipocad:='C';
  if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.TiposEntrada+';'+Global.CodTransfSaida)>0 then
    EdComv_codigo.invalid('Movimento inv�lido para vendas')
  else if Ecf='S' then begin
      Impr.NomeImpressora:=Impr.PegaImpPadrao;
      if not Impr.IniciaImpr then
        EdComv_codigo.invalid('Impressora padr�o n�o encontrada')
      else
        Impr.Comprime175(true);
  end;
// 08.09.05
  if DevolucaoCompra( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring)  or TiposFornecedor(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring) then begin
    FGeral.SetaEdEntidade(EdCliente,'F');
    campoufentidade:='forn_uf';
// 12.12.07 - aqui usar o EdComv_codigo.ResultFind.FieldByName('comv_tipocad').asstring
    NotaTipocad:='F';  // q poder� ser somente C ou F
  end else begin
    FGeral.SetaEdEntidade(Edcliente,'C');
    campoufentidade:='clie_uf';
  end;
// 27.03.06
  if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodRemessaInd then begin
    EdMens_codigo.setvalue(FGeral.getconfig1asinteger('CODMENREMIND'));
    EdMens_codigo.valid;
  end;
// 31.05.07 - mensagem padr�o nf saida
  if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring<>Global.CodRemessaConserto then begin
    EdMens_codigo.setvalue(FGeral.getconfig1asinteger('CODMENVEN'));
    EdMens_codigo.valid;
  end;
// 23.02.07
  if Global.Topicos[1301] then
    EdNumerodoc.setvalue( FGeral.ConsultaContador('NFSAIDAMO'+Global.CodigoUnidade+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade) ) + 1 );
// 07.11.07
  if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodContrato then begin
//     EdPedido.EditMask:='##-####-##;0;_';
// 14.07.08
     EdPedido.EditMask:='##-####-##;1;_';
     EdPedido.ValueFormat:='';
  end else begin
     EdPedido.EditMask:='';
     EdPedido.ValueFormat:='#####0';
  end;
// 17.06.08
  EdPedido.ItemsLength:=0;
  EdPedido.Items.Clear;  // 10.07.08
  if OP='I' then begin
// ver qual a condi��o para usar as 'saidas de abate' ou se cria permissao por usuario ou do sistema
      if ( Global.Topicos[1320] )  and
        ( EdPedido.enabled ) and
        ( FGeral.GetConfig1AsInteger('ConfMovAbate')=Edcomv_codigo.ResultFind.FieldByName('comv_codigo').asinteger )
        then begin
        EdPedido.ItemsLength:=6;
        QRoma:=sqltoquery('select * from movabate '+
//                          ' where mova_tipo_codigo='+EdFornec.assql+' and mova_status=''N'''+
                          ' where mova_status=''N'''+
                          ' and ( mova_notagerada=0 or mova_notagerada is null )'+
//                          ' and mova_situacao=''N'' and mova_tipomov='+stringtosql(TipoSaidaAbate)+
// ver se ter� o 'rateio' nas saidas de abate dai volta situacal='N'
                          ' and mova_situacao=''P'' and mova_tipomov='+stringtosql(TipoSaidaAbate)+
                          ' order by mova_dtabate');
        while not QRoma.eof do begin
//          EdRomaneio.Items.Add( strzero(QRoma.fieldbyname('mova_numerodoc').asinteger,8)+' - '+FGeral.formatadata(QRoma.fieldbyname('mova_dtabate').asdatetime) );
          EdPedido.Items.Add( strzero(QRoma.fieldbyname('mova_numerodoc').asinteger,6)+' - '+FGeral.formatadata(QRoma.fieldbyname('mova_datacont').asdatetime)+
                             ' - '+FGeral.GetNomeRazaoSocialEntidade(QRoma.fieldbyname('mova_tipo_codigo').asinteger,'C','N')  );
          QRoma.Next
        end;
        FGeral.FechaQuery(QRoma);
      end else begin
/////////10.07.08
        EdPedido.ItemsLength:=6;
        QRoma:=sqltoquery('select * from movped '+
//                          ' where mova_tipo_codigo='+EdFornec.assql+' and mova_status=''N'''+
                          ' where mped_status=''N'''+
                          ' and ( mped_nfvenda=0 or mped_nfvenda is null )'+
                          ' and mped_situacao=''P''' +
                          ' order by mped_datamvto');
        while not QRoma.eof do begin
          EdPedido.Items.Add( strzero(QRoma.fieldbyname('mped_numerodoc').asinteger,6)+' - '+FGeral.formatadata(QRoma.fieldbyname('mped_datamvto').asdatetime)+
                             ' - '+FGeral.GetNomeRazaoSocialEntidade(QRoma.fieldbyname('mped_tipo_codigo').asinteger,'C','N')  );
          QRoma.Next
        end;
        FGeral.FechaQuery(QRoma);
/////////////////
      end;
  end;
//////////////////
  if not Arq.TConfMovimento.locate('comv_codigo',Edcomv_codigo.Text,[]) then
    EdComv_codigo.invalid('Codigo n�o encontrado')
  else if OP='A' then
    EdNumerodoc.setfocus;   // 28.06.05
// 02.12.08 - Vims
  if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodContrato then
    EdRepr_codigo2.enabled:=true
  else
    EdRepr_codigo2.enabled:=false;

end;

procedure TFNotaSaidaMo.EdMoes_tabp_codigoValidate(Sender: TObject);
begin
  SetEdTabp_aliquota.text:=FTabela.GetDescAliquota(EdMoes_tabp_codigo.asinteger)
end;

procedure TFNotaSaidaMo.EdPeracreValidate(Sender: TObject);
begin
  if EdPeracre.ascurrency>0 then begin
    EdPerdesco.enabled:=false;
    EdPerdesco.setvalue(0);
    EdVlracre.enabled:=false;
    EdVlracre.setvalue(0);
  end else begin
    EdPerdesco.enabled:=true;
    EdVlracre.enabled:=true;
  end;
  SetaEditsvalores;

end;

procedure TFNotaSaidaMo.EdperdescoValidate(Sender: TObject);
begin
  if Edperdesco.ascurrency>0 then begin
    EdVlrdesco.enabled:=false;
    EdVlrdesco.setvalue(0);
    EdVlracre.enabled:=false;
    EdVlracre.setvalue(0);
  end else
    EdVlrdesco.enabled:=true;
  SetaEditsvalores;

end;

procedure TFNotaSaidaMo.EdVlracreValidate(Sender: TObject);
var peracre,valor:currency;

begin
  if EdVlracre.ascurrency>0 then begin
    EdVlrdesco.enabled:=false;
    EdVlrdesco.setvalue(0);
//    valor:=Edtotalnota.ascurrency+EdVlracre.ascurrency;
// 10.03.06
    valor:=Edtotalnota.ascurrency;
    if valor>0 then
      peracre:=(EdVlracre.ascurrency/valor)*100
    else begin
      Avisoerro('Total da nota est� zerado.  C�lculo n�o feito');
      peracre:=0;
    end;
///////////////////    peracre:=FGeral.Arredonda(peracre,2);
// 08.04.05   
    EdPeracre.setvalue(peracre);
    SetaEditsvalores;
  end else
    EdVlrdesco.enabled:=true;
end;

procedure TFNotaSaidaMo.EdVlrdescoValidate(Sender: TObject);
var perdesc:currency;
begin
  if EdVlrdesco.ascurrency>0 then begin
    if Edtotalnota.ascurrency>0 then
//      perdesc:=(EdVlrdesco.ascurrency/Edtotalnota.ascurrency)*100
// 06.04.05
      perdesc:=(EdVlrdesco.ascurrency/Edtotalprodutos.ascurrency)*100
    else begin
      Avisoerro('Total da nota est� zerado.  C�lculo n�o feito');
      perdesc:=0;
    end;
////////////    perdesc:=FGeral.Arredonda(perdesc,2);
// 08.04.05
    EdPerdesco.setvalue(perdesc);
    SetaEditsvalores;
  end;
end;

procedure TFNotaSaidaMo.EdEspecievolumesValidate(Sender: TObject);
var titcolunas:string;
begin
  if Ecf='S' then begin
    Impr.ImprimeString('Venda - ECF',true);
    Impr.ImprimeString(EdUnid_codigo.resultfind.fieldbyname('unid_razaosocial').asstring,true);
    Impr.ImprimeString('CNPJ:'+FGeral.Formatacnpj(EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring),true);
    Impr.ImprimeString('I.E.:'+EdUnid_codigo.resultfind.fieldbyname('unid_inscricaoestadual').asstring,true);
    Impr.ImprimeString(EdUnid_codigo.resultfind.fieldbyname('unid_endereco').asstring,true);
//    Impr.ImprimeString(EdUnid_codigo.resultfind.fieldbyname('unid_bairro').asstring,false);
    Impr.ImprimeString(FGeral.Formatacep(EdUnid_codigo.resultfind.fieldbyname('unid_cep').asstring),false);
    Impr.ImprimeString(' - '+EdUnid_codigo.resultfind.fieldbyname('unid_municipio').asstring,true);
    Impr.ImprimeString(FGeral.FormataData(EdDtemissao.asdate)+' - '+Timetostr(time)+' - ECF:'+Codigoimp,true);
    Impr.ImprimeString('Ver qual numero controle ter�',true);
    Impr.ImprimeString(space(10)+'CUPOM FISCAL',true);
    Impr.ImprimeString(traco,true);
    Impr.FimImpr;
  end;
end;

procedure TFNotaSaidaMo.EdNumeroDocValidate(Sender: TObject);
var QBusca:TSqlquery;
    Numero:integer;
begin
  if EdNumerodoc.AsInteger>0 then begin
//     if OP='I' then begin  // 17.11.04
     if OP='A' then begin
       QBusca:=sqltoquery(FGeral.buscanf(EdNumerodoc.AsInteger,Global.CodVendaDireta,EdDtemissao.asdate));
       if QBusca.eof then begin
//         QBusca:=sqltoquery(FGeral.buscanf(EdNumerodoc.AsInteger,Global.CodVendaConsig,EdDtemissao.asdate));
// 28.06.05
         QBusca:=sqltoquery(FGeral.buscanf(EdNumerodoc.AsInteger,EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,EdDtemissao.asdate,EdUnid_codigo.text));
         if QBusca.eof then begin
           EdNUmerodoc.INvalid('Numero de nota n�o encontrado tipo '+EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring);
           EdNumerodoc.ClearAll(FNotaSaidaMO,99);
           Grid.Clear;
         end else begin
           Campostoedits(Qbusca);
           Campostogrid(Qbusca);
           EdCliente.Validfind;
    //       TotalNota:=EdTotalNota.AsCurrency;
           EdRepr_codigo.ValidFind;
           EdUnid_codigo.ValidFind;
           EdFpgt_codigo.ValidFind;
           EdComv_codigo.ValidFind;
           Arq.TConfMovimento.locate('comv_codigo',Edcomv_codigo.Text,[]);
         end;
       end else begin
         Campostoedits(Qbusca);
         Campostogrid(Qbusca);
         EdCliente.ValidFind;
  //       TotalNota:=EdTotalNota.AsCurrency;
         EdRepr_codigo.ValidFind;
         EdUnid_codigo.ValidFind;
         EdFpgt_codigo.ValidFind;
         EdComv_codigo.ValidFind;
         Arq.TConfMovimento.locate('comv_codigo',Edcomv_codigo.Text,[]);

       end;
     end else begin

//       QBusca:=sqltoquery(FGeral.buscanf(EdNumerodoc.AsInteger,Global.CodVendaDireta));
// 07.05.07
//       QBusca:=sqltoquery( FGeral.buscanf( EdNumerodoc.AsInteger,EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,0,'',EdCliente.asinteger ) );
// 01.090.9
       QBusca:=sqltoquery( FGeral.buscanf( EdNumerodoc.AsInteger,EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,EdDtEmissao.asdate,'',EdCliente.asinteger ) );
       if (not QBusca.eof) and ( (OP='S') or (OP='I') ) then begin
         EdNUmerodoc.INvalid('Numero de nota encontrado em '+formatdatetime('dd/mm/yy',QBusca.fieldbyname('move_datamvto').asdatetime)+'.   Digita��o n�o permitida');
//         EdNumerodoc.ClearAll(FNotaSaida,99);
         Grid.Clear;
       end else if OP='S' then begin
         Numero:=FGeral.ConsultaContador('NFSAIDAMO'+Global.CodigoUnidade+FGeral.Qualserie(Arq.TConfMovimento.fieldbyname('comv_serie').asstring,Global.serieunidade));
//         if abs( numero-EdNumerodoc.asinteger ) >1 then begin
         if numero<>EdNumerodoc.asinteger then begin
             EdNUmerodoc.INvalid('Ultima nota feita � n�mero '+inttostr(numero)+'. Digita��o n�o permitida');
//             EdNumerodoc.ClearAll(FNotaSaida,99);
             Grid.Clear;
         end;
       end;
// 31.08.05
       if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodVendaAmbulante then begin
          QBusca:=sqltoquery(FGeral.buscanf(EdNumerodoc.AsInteger,Global.CodVendaAmbulante));
          if not Qbusca.eof then
             EdNUmerodoc.INvalid('Numero de nota '+Global.CodVendaAmbulante+' encontrado.   Digita��o n�o permitida');
       end;
     end;
     QBusca.close;
  end;

end;

procedure TFNotaSaidaMo.Campostoedits(Q: TSqlquery);
var QPendencia,QMovfin:TSqlquery;
    p:integer;
    alteroucli:boolean;
begin
  alteroucli:=false;
  if EdCliente.Text<>Q.fieldbyname('moes_tipo_codigo').AsString then begin
     alteroucli:=confirma('Alterar codigo do cliente ?');
     if not alteroucli then
       EdCliente.Text:=Q.fieldbyname('moes_tipo_codigo').AsString;
  end else
    EdCliente.Text:=Q.fieldbyname('moes_tipo_codigo').AsString;
// 20.08.05 - notas de pronta entrega e regime especial gravada sem conf. de movimento
  if Q.fieldbyname('moes_comv_codigo').AsString<>'' then
    EdComv_codigo.text:=Q.fieldbyname('moes_comv_codigo').AsString;

  EdUnid_codigo.Text:=Q.fieldbyname('moes_unid_codigo').AsString;
  EdDtEmissao.SetDate(Q.fieldbyname('moes_dataemissao').AsDateTime);
  EdRepr_codigo.Text:=Q.fieldbyname('moes_repr_codigo').AsString;
  EdTotalNota.SetValue(Q.fieldbyname('moes_vlrtotal').AsCurrency);
  EdTotalProdutos.SetValue(Q.fieldbyname('moes_totprod').AsCurrency);
  EdMoes_tabp_codigo.SetValue(Q.fieldbyname('moes_tabp_codigo').AsInteger);
  SetEdTabp_aliquota.Text:=FTabela.GetDescAliquota(Q.fieldbyname('moes_tabp_codigo').AsInteger);
  EdNatf_codigo.text:=Q.fieldbyname('moes_natf_codigo').AsString;
  EdNatf_descricao.Text:=FNatureza.GetDescricao(Q.fieldbyname('moes_natf_codigo').Asstring);
// 20.08.05 - notas de pronta entrega e regime especial gravada sem conf. de movimento
  if Q.fieldbyname('moes_tran_codigo').AsString<>'' then begin
    EdTran_codigo.text:=Q.fieldbyname('moes_tran_codigo').AsString;
    EdTran_nome.Text:=FTransp.GetNOme(Q.fieldbyname('moes_tran_codigo').Asstring);
  end else begin
    EdTran_codigo.text:='001';
    EdTran_nome.Text:=FTransp.GetNOme(Q.fieldbyname('moes_tran_codigo').Asstring);
  end;
  EdFrete.setvalue(Q.fieldbyname('moes_frete').AsCurrency);
  EdEmides.text:=Q.fieldbyname('moes_freteciffob').Asstring;
//  EdSeguro.setvalue(Q.fieldbyname('moes_seguro').AsCurrency);
  EdSeguro.setvalue(0);   // esquecido de criar campo - rever se usa e tirar de vez
  EdDtSaida.setdate(Q.fieldbyname('moes_dataemissao').Asdatetime);
  EdDtMovimento.setdate(Q.fieldbyname('moes_datacont').Asdatetime);
  EdQtdevolumes.setvalue(Q.fieldbyname('moes_qtdevolume').Asinteger);
  EdEspecievolumes.text:=(Q.fieldbyname('moes_especievolume').Asstring);
  EdPeracre.setvalue(Q.fieldbyname('moes_peracres').ascurrency);
  EdPerdesco.setvalue(Q.fieldbyname('moes_perdesco').ascurrency);
  EdBaseicms.setvalue(Q.fieldbyname('moes_baseicms').AsCurrency);
// 19.02.09
  EdValoripi.setvalue(Q.fieldbyname('moes_valoripi').AsCurrency);
//  
  EdValoricms.setvalue(Q.fieldbyname('moes_valoricms').AsCurrency);
  EdBasesubs.setvalue(Q.fieldbyname('moes_basesubstrib').AsCurrency);
  EdValorsubs.setvalue(Q.fieldbyname('moes_valoricmssutr').AsCurrency);
  Moes_remessas:=Q.fieldbyname('moes_remessas').Asstring;
  Transacao:=Q.fieldbyname('moes_transacao').asstring;
  StatusNota:=Q.fieldbyname('moes_status').asstring;
  Edmensagem.text:=Q.fieldbyname('moes_mensagem').asstring;
// 15.11.05
  EdPesoliq.setvalue(Q.fieldbyname('moes_pesoliq').ascurrency);
  EdPesobru.setvalue(Q.fieldbyname('moes_pesobru').ascurrency);
// 30.12.05 - devido a altera��o das vendas do reg. especial ( VN )
//  Moes_clie_codigo:=Q.fieldbyname('moes_clie_codigo').Asinteger;
// 20.04.06 - quando altera o cliente tem q mudar aqui tbem
//  Moes_clie_codigo:=EdCliente.Asinteger;
// 24.05.06 - qual NAO altera o cliente.....sem comentarios ...notas venda RE
  if alteroucli then
    Moes_clie_codigo:=EdCliente.Asinteger
  else
    Moes_clie_codigo:=Q.fieldbyname('moes_clie_codigo').Asinteger;
///////////////////////
// 18.05.06
  usua_codigo:=Q.fieldbyname('moes_usua_codigo').asinteger;
  QMovfin:=sqltoquery( FGeral.BuscaTransacao(Transacao,'movfin','movf_transacao','movf_status','N','') );
  p:=1;
  if not QMovfin.eof then begin
    Gridparcelas.cells[Gridparcelas.Getcolumn('pend_valor'),p]:=Formatfloat(f_cr,QMovfin.fieldbyname('movf_valorger').ascurrency);
    Gridparcelas.cells[Gridparcelas.Getcolumn('pend_datavcto'),p]:=Formatdatetime('dd/mm/yy',QMovfin.fieldbyname('movf_datamvto').asdatetime);
    inc(p);
  end;
  QPendencia:=sqltoquery( FGeral.BuscaTransacao(Transacao,'pendencias','pend_transacao','pend_status','N','pend_datavcto') );
  if QPendencia.eof then begin
     FGeral.FechaQuery(QPendencia);
     QPendencia:=sqltoquery( FGeral.BuscaTransacao(Transacao,'pendencias','pend_transacao','pend_status','K','pend_datavcto') );
  end;
  if not QPendencia.eof then begin
    EdPort_codigo.text:=QPendencia.fieldbyname('pend_port_codigo').asstring;
    EdPort_descricao.Text:=FPortadores.GetDescricao(QPendencia.fieldbyname('pend_port_codigo').Asstring);
    EdFpgt_codigo.text:=QPendencia.fieldbyname('pend_fpgt_codigo').asstring;
    EdFpgt_descricao.text:=FCondpagto.GetDescricao(QPendencia.fieldbyname('pend_fpgt_codigo').asstring);
    while not QPendencia.eof do begin
      Gridparcelas.cells[Gridparcelas.Getcolumn('pend_valor'),p]:=Formatfloat(f_cr,QPendencia.fieldbyname('pend_valor').ascurrency);
      Gridparcelas.cells[Gridparcelas.Getcolumn('pend_datavcto'),p]:=Formatdatetime('dd/mm/yy',QPendencia.fieldbyname('pend_datavcto').asdatetime);
      inc(p);
      if p>Gridparcelas.RowCount then
        Gridparcelas.RowCount:=p+1;
      QPendencia.next;
    end;
  end else if not QMovfin.eof then begin
    EdPort_codigo.text:='001';
    EdFpgt_codigo.text:=FGEral.Getconfig1asstring('Fpgtoavista');
    EdFpgt_descricao.text:=FCondpagto.GetDescricao(EdFpgt_codigo.text);
  end else begin
    Avisoerro('N�o permitido alterar nota com pendencia financeira j� baixada');
  end;
  QPendencia.close;
  Freeandnil(QPendencia);
  QMovfin.close;
  Freeandnil(QMovfin);
  EdUnid_codigo.ValidateEdit;
  EdRepr_codigo.ValidateEdit;
  EdCliente.ValidateEdit;
// 17.08.05
  if Edtotalnota.ascurrency>0 then  begin
    EdVlrdesco.setvalue(Edtotalnota.ascurrency*(EdPerdesco.ascurrency/100));
    EdVlracre.setvalue(Edtotalnota.ascurrency*(EdPeracre.ascurrency/100));
  end;
//  EdFpgt_codigo.ValidateEdit;
//  EdFpgt_codigo.DoValidate;
end;

procedure TFNotaSaidaMo.Campostogrid(Q: TSqlquery);
var p:integer;
    unitario:currency;
    faz:boolean;
begin
  Grid.Clear;p:=1;Q.First;
  faz:=true;
  if FGeral.usuarioteste(global.usuario.codigo) and (Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodVendaREFinal) then begin
    if confirma('Buscar pre�o de venda do cadastro ? ') then
      faz:=true
    else
      faz:=false;
  end;
  while not Q.Eof do begin
// 17.05.06 - devido ao 'rolo' do reg. especial
    if (Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodVendaREFinal) and (faz) then
      unitario:=FEstoque.Getpreco(Q.fieldbyname('move_esto_codigo').Asstring,Global.unidadematriz)
    else
      unitario:=Q.fieldbyname('move_venda').Ascurrency;
    Grid.Cells[Grid.GetColumn('move_esto_codigo'),p]:=Q.fieldbyname('move_esto_codigo').Asstring;
    Grid.Cells[Grid.GetColumn('esto_descricao'),p]:=FEstoque.GetDescricao(Q.fieldbyname('move_esto_codigo').Asstring);
    Grid.Cells[Grid.GetColumn('move_cst'),p]:=Q.fieldbyname('move_cst').Asstring;
    Grid.Cells[Grid.GetColumn('move_aliicms'),p]:=transform(Q.fieldbyname('move_aliicms').Ascurrency,'#0.0');
    Grid.Cells[Grid.GetColumn('esto_unidade'),p]:=Arq.TEstoque.fieldbyname('esto_unidade').asstring;
    Grid.Cells[Grid.GetColumn('move_qtde'),p]:=transform(Q.fieldbyname('move_qtde').AsFloat,f_qtdestoque);
    Grid.Cells[Grid.GetColumn('move_venda'),p]:=TRansform(unitario,f_cr);
    Grid.Cells[Grid.GetColumn('total'),p]:=TRansform(Q.fieldbyname('move_qtde').AsFloat*unitario,f_cr);
    Grid.Cells[Grid.getcolumn('move_remessas'),p]:=Q.fieldbyname('move_remessas').Asstring;
    Grid.Cells[Grid.getcolumn('vendamove'),p]:=Transform(Q.fieldbyname('move_venda').AsFloat,f_cr);
// 11.12.08
    Grid.Cells[Grid.getcolumn('move_redubase'),p]:=Q.fieldbyname('move_redubase').AsString;
    Grid.Cells[Grid.getcolumn('move_pecas'),p]:=Q.fieldbyname('move_pecas').AsString;
    Grid.Cells[Grid.getcolumn('move_vendamin'),p]:=Q.fieldbyname('move_vendamin').AsString;
// 23.12.08
    Grid.Cells[Grid.Getcolumn('move_certificado'),p]:=Q.fieldbyname('move_certificado').AsString;
// 19.02.09
    Grid.Cells[Grid.getcolumn('move_aliipi'),p]:=transform(Q.fieldbyname('move_aliipi').Ascurrency,'#0.0');

    inc(p);
    Grid.AppendRow;
    Q.Next;
  end;
end;

procedure TFNotaSaidaMo.CancelaTransacao(Transacao: string);
var QMovestoque,QQtdeEstoque:TSqlquery;
    Mov:string;
begin
    Sistema.Beginprocess('Cancelando transa��o '+transacao);
    QMovestoque:=sqltoquery(FGeral.BuscaTransacao(Transacao,'movestoque','move_transacao'));
    if QMovestoque.fieldbyname('move_status').asstring='C' then begin
      Avisoerro('Transa��o j� est� cancelada');
      Sistema.Endprocess('');
      exit;
    end;
    if pos(QMOvestoque.fieldbyname('move_tipomov').asstring,Global.TiposMovMovEstoque) > 0 then begin
      while not QMovestoque.eof do begin
        QQtdeEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(QMOvestoque.fieldbyname('move_esto_codigo').asstring)+
        ' and esqt_unid_codigo='+Stringtosql(QMOvestoque.fieldbyname('move_unid_codigo').asstring));
        if pos(QMOvestoque.fieldbyname('move_tipomov').asstring,Global.TiposMovMovEntrada) > 0 then
          Mov:='S'
        else
          Mov:='E';
        FGeral.MovimentaQtdeEstoque(QMOvestoque.fieldbyname('move_esto_codigo').asstring,
              QMOvestoque.fieldbyname('move_unid_codigo').asstring,Mov,'CC',
              QMOvestoque.fieldbyname('move_qtde').asfloat,QQtdeEstoque );
        QQtdeEstoque.close;
        Freeandnil(QQtdeEstoque);
        QMovestoque.Next;
      end;
    end;
    Executesql('update movesto set moes_status=''C'' where moes_transacao='+stringtosql(Transacao));
    Executesql('update movestoque set move_status=''C'' where move_transacao='+stringtosql(Transacao));
    Executesql('update movbase set movb_status=''C'' where movb_transacao='+stringtosql(Transacao));
    Executesql('update pendencias set pend_status=''C'' where pend_transacao='+stringtosql(Transacao));
    Executesql('update movfin set movf_status=''C'' where movf_transacao='+stringtosql(Transacao));
    Sistema.Commit;
    QMovestoque.close;
    Freeandnil(QMovestoque);
    Sistema.Endprocess('');

end;

procedure TFNotaSaidaMo.EdDtMovimentoValidate(Sender: TObject);
begin
//  if (EdDtmovimento.isempty) and (EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodVendaSerie4) then
//    EdDtmovimento.invalid('Campo obrigat�rio para nota fiscal tipo '+EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring)
  if (not EdDtmovimento.isempty) then begin
     if campoufentidade='forn_uf' then begin
       if ( not FGeral.CnpjcpfOK(EdCliente.resultfind.fieldbyname('forn_cnpjcpf').AsString) ) then  begin
         Avisoerro('Obrigat�rio fornecedor com CNPJ/CPF v�lido');
         exit;
       end;
     end else begin
       if ( not FGeral.CnpjcpfOK(EdCliente.resultfind.fieldbyname('clie_cnpjcpf').AsString) ) then  begin
         Avisoerro('Obrigat�rio cliente com CNPJ/CPF v�lido');
         exit;
       end;
     end;
  end;

end;

procedure TFNotaSaidaMo.EdDtMovimentoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FGeral.PoeData(EdDtMovimento,key);

end;

procedure TFNotaSaidaMo.EdProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#27 then
    bcancelaritemclick(FNotaSaidaMo);
end;

procedure TFNotaSaidaMo.EdPerdescontoValidate(Sender: TObject);
begin
  if EdPerdesconto.ascurrency>0 then
    EdUnitario.setvalue( EdUnitario.Ascurrency - FGeral.Arredonda(EdUnitario.Ascurrency*(EdPerdesconto.ascurrency/100),2) );
  if Serial.Enabled then
    Serial.Close;
  if Serial2.Enabled then
    Serial2.Close;
end;

procedure TFNotaSaidaMo.GridParcelasDblClick(Sender: TObject);
begin
  AtivaEditsParcelas;
end;

procedure TFNotaSaidaMo.AtivaEditsParcelas;
begin
  if GridParcelas.Col=0 then begin
     EdVencimento.Top:=GridParcelas.TopEdit;
     EdVencimento.Left:=GridParcelas.LeftEdit+5;
     EdVencimento.Text:=StrToStrNumeros(GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]);
//     EdVencimento.Text:=GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row];
     EdVencimento.Visible:=True;
     EdVencimento.SetFocus;
  end else if GridParcelas.Col=1 then begin
     EdParcela.Top:=GridParcelas.TopEdit;
     EdParcela.Left:=GridParcelas.LeftEdit+6;
     EdParcela.SetValue(TextToValor(GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]));
     EdParcela.Visible:=True;
     EdParcela.SetFocus;
  end;
{
   EdVencimento.enabled:=true;
   EdVencimento.Left:=GridParcelas.LeftEdit;
   EdVencimento.Top:=GridParcelas.TopEdit;
   EdVencimento.Visible:=true;
   EdVencimento.Text:=GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row];
//   FGrades.EdGrad_codigolinha.SetValue(Arq.TGrades.fieldbyname('grad_codigolinha').AsInteger);
   EdVencimento.SetFocus;
}

end;

procedure TFNotaSaidaMo.EdVencimentoValidate(Sender: TObject);
begin
   if FCondpagto.GetAvPz(EdFpgt_codigo.text)='V' then begin
     if EdVencimento.AsDate>0 then begin
       if Edvencimento.asdate<Sistema.hoje then
          EdVencimento.invalid('Nota a vista somente com data atual');
     end;
   end;
end;

procedure TFNotaSaidaMo.EdParcelaValidate(Sender: TObject);
begin
//   Edparcela.enabled:=false;
//   bgravarclick(FNotaSaida);

end;

procedure TFNotaSaidaMo.EdVencimentoExitEdit(Sender: TObject);
begin
  GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=DateToStr_(EdVencimento.AsDate);
  GridParcelas.SetFocus;
  EdVencimento.Visible:=False;

end;

procedure TFNotaSaidaMo.EdParcelaExitEdit(Sender: TObject);
begin
  GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=Transform(EdParcela.AsFloat,f_cr);
  GridParcelas.SetFocus;
  EdParcela.Visible:=False;

end;

procedure TFNotaSaidaMo.EdVencimentoExit(Sender: TObject);
begin
//  Edvencimento.enabled:=false;
end;

procedure TFNotaSaidaMo.EdParcelaExit(Sender: TObject);
begin
//  EdParcela.enabled:=false;
end;

procedure TFNotaSaidaMo.GridParcelasKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
    GridParcelasDblClick(FNotaSaidaMo);
end;

procedure TFNotaSaidaMo.EdTran_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.Limpaedit(Edtran_codigo,key);
end;

procedure TFNotaSaidaMo.EdFpgt_codigoExitEdit(Sender: TObject);
begin
  bgravarclick(FNotasaidaMO);
end;

function TFNotaSaidaMo.Nfexporta(cfop: string): boolean;
begin
  if copy(cfop,1,1)=cfopexporta then
    result:=true
  else
    result:=false;
end;

procedure TFNotaSaidaMo.Edmens_codigoValidate(Sender: TObject);
begin
  if not Arq.TMensagensNF.active then Arq.TMensagensNF.open;
  if Edmens_codigo.asinteger>0 then begin
    if not Arq.Tmensagensnf.locate('mens_codigo',Edmens_codigo.text,[]) then
       Edmens_codigo.invalid('Codigo de mensagem n�o encontrado')
    else begin
       if (Edmensagem.isempty) or (Edmens_codigo.text<>EdMens_codigo.oldvalue) then
         EdMensagem.text:=Arq.Tmensagensnf.fieldbyname('mens_descricao').asstring;
    end;
  end;
end;

function TFNotaSaidaMo.DevolucaoCompra(tipomov: string): boolean;
begin
   if pos(tipomov,Global.coddevolucaocompra+';'+Global.coddevolucaocompraSemestoque)>0 then
     result:=true
   else
     result:=false;
end;

////////////////////////////////////////////////////////////////////////////
procedure TFNotaSaidaMo.EdPedidoValidate(Sender: TObject);

var obra:string;
    POrcam,POrcamRes:^TOrcam;
    valorcontrato:currency;
    QEstoque,Q:TSqlquery;
    codcornovo,codcor:integer;


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
         Sistema.SetField('esto_descricao',copy(POrcamREs.descricao,1,50));
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
         QEstoqueQtde:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+EdUnid_codigo.assql+
                                       ' and esqt_esto_codigo='+stringtosql(strzero(strtointdef(novo,0),tamcodigo))+' and esqt_status=''N''');
         if QEstoqueQTde.eof then begin
              Sistema.Insert('EstoqueQtde');
              Sistema.Setfield('esqt_status','N');
              Sistema.Setfield('esqt_unid_codigo',EdUNid_codigo.text);
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
              Sistema.Setfield('esqt_cfis_codigoest',FUnidades.GetFiscalDentro(EdUNid_codigo.text));
              Sistema.Setfield('esqt_cfis_codigoforaest',FUnidades.GetFiscalFora(EdUNid_codigo.text));
              Sistema.Setfield('esqt_sitt_codestado',FUnidades.GetSittDentro(EdUNid_codigo.text) );
              Sistema.Setfield('esqt_sitt_forestado',FUnidades.GetSittFora(EdUNid_codigo.text));
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
       var QEstoqueQtde:TSqlquery;
           novo:string;
           tamcodigo:integer;
       begin
         QEstoqueQtde:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+EdUnid_codigo.assql+
                                       ' and esqt_esto_codigo='+stringtosql(strzero(strtointdef(novo,0),tamcodigo))+' and esqt_status=''N''');
         if QEstoqueQTde.eof then begin
              Sistema.Edit('EstoqueQtde');
              Sistema.Setfield('esqt_vendavis',POrcamres.unitario);
              Sistema.Setfield('esqt_custo',POrcamres.custo);
              Sistema.Setfield('esqt_custoger',POrcamres.custo);
              Sistema.Setfield('esqt_customedio',POrcamres.custo);
              Sistema.Setfield('esqt_customeger',POrcamres.custo);
              Sistema.Setfield('esqt_dtultvenda',Sistema.hoje);
              Sistema.Post('esqt_unid_codigo='+EdUnid_codigo.assql+
                           ' and esqt_esto_codigo='+stringtosql(QEstoque.fieldbyname('esto_codigo').asstring)+
                           ' and esqt_status=''N''');
         end;
         FGeral.Fechaquery(QEstoqueqtde);
         Sistema.commit;
       end;


    begin

      gravar:='N';
      codcornovo:=FEstoque.GetProximoCodigo('cores','core_codigo','N');
      for i:=0 to ListaOrcamREs.count-1 do begin
        POrcamRes:=ListaOrcamRes[i];
        QEstoque:=sqltoquery('select * from estoque where esto_referencia='+stringtosql(POrcamres.codigopea));
        if  QEstoque.eof then begin
//           if confirma('Item '+POrcamres.codigopea+' n�o encontrado no cadastro do estoque.  Confirma cadastro ') then begin
// 28.08.08 - deixado para incluir automatico sem op��o
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
          Grid.Cells[Grid.GetColumn('move_esto_codigo'),i+1]:=produto;
          Grid.Cells[Grid.GetColumn('esto_descricao'),i+1]:=POrcamREs.descricao;
  //        Grid.Cells[Grid.GetColumn('move_cst'),i+1]:=FEstoque.Getsituacaotributaria(POrcamREs.produto,Global.CodigoUnidade,EdUNid_codigo.text);
  //        Grid.Cells[Grid.GetColumn('move_aliicms'),i+1]:=transform(FEstoque.Getaliquotaicms(POrcamREs.produto,Global.CodigoUnidade,EdUNid_codigo.text),'#0.0');
          Grid.Cells[Grid.GetColumn('move_cst'),i+1]:='000';
          Grid.Cells[Grid.GetColumn('move_aliicms'),i+1]:=transform(0,'#0.0');
          Grid.Cells[Grid.GetColumn('esto_unidade'),i+1]:=QEstoque.fieldbyname('esto_unidade').asstring;
  //        Grid.Cells[Grid.GetColumn('move_qtde'),i+1]:=transform(POrcamREs.qtde,f_qtdestoque);
          Grid.Cells[Grid.GetColumn('move_qtde'),i+1]:=transform(POrcamREs.area,f_qtdestoque);
          Grid.Cells[Grid.GetColumn('move_venda'),i+1]:=TRansform(POrcamres.unitario,f_cr);
          Grid.Cells[Grid.GetColumn('total'),i+1]:=TRansform(POrcamREs.area*POrcamres.unitario,f_cr);
    //      Grid.Cells[Grid.getcolumn('vendamove'),p]:=Transform(Q.fieldbyname('move_venda').Ascurrency,f_cr);
// cor produto acabado / 17.12.07
          Checacor;
          Grid.Cells[Grid.GetColumn('codcor'),i+1]:=transform(codcor,'###');
          Grid.Cells[Grid.GetColumn('cor'),i+1]:=POrcamREs.corid;

          Grid.AppendRow;
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

      end;  // ref. ao for
{
///////////////////////////
      if gravar='S' then begin
        try
          Sistema.commit;
        except
          Avisoerro('Problemas na inclus�o do(s) produto(s) vindos do pedido');
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
        unitario:=valorcontrato/area;
        for i:=0 to LIstaOrcamRes.Count-1 do begin
           POrcamRes:=ListaOrcamRes[i];
           POrcamREs.unitario:=unitario;
        end;
      end;
      EdTotalnota.setvalue(valorcontrato);
      EdQtdetotal.setvalue(area);
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
          Aviso('N�o encontrado Item '+strzero(dbforcam.fieldbyname('ITEM').Asinteger,2))
      end else begin
        if achou then begin
//          Porcam.qtde:=Porcam.qtde+dbforcam.fieldbyname('QTDE').AsFLOAT;
// 25.01.08 - retirado pois nao usa qtde e sim a area pra fazer a nf de venda...
          if dbforcam.fieldbyname('L').AsFLOAT*dbforcam.fieldbyname('H').AsFLOAT>0 then
            POrcam.custo:=dbforcam.fieldbyname('CUSTOUNIT').AsFLOAT/( ((dbforcam.fieldbyname('L').AsFLOAT/1000)*(dbforcam.fieldbyname('H').AsFLOAT/1000)) );
          POrcam.unitario:=dbforcam.fieldbyname('CUSTOUNIT').AsFLOAT;
        end else
//          Aviso('N�o encontrado Item '+strzero(dbforcam.fieldbyname('ITEM').Asinteger,2)+' Codigo '+dbforcam.fieldbyname('CODESQD').Asstring)
// 08.08.08
          Aviso('N�o encontrado Item '+strzero(dbforcam.fieldbyname('ITEM').Asinteger,2)+' Codigo '+dbforcam.fieldbyname('CODIGO').Asstring+' Arquivo '+dbforcam.FileName)
      end;
    end;

///////////////////////////////////////////////////////////////
    function   BuscaSaidaAbateMestre:boolean;
    var QRoma:TSqlquery;
    begin
      result:=false;
      QRoma:=sqltoquery('select * from movabate  '+
                                ' inner join clientes on ( clie_codigo=mova_tipo_codigo )'+
                                ' where '+FGeral.GetIN('mova_numerodoc',EdPedido.text,'N')+
                                ' and mova_status=''N'''+
                                ' and mova_tipomov='+stringtosql(TipoSaidaAbate)+
//                                ' and mova_situacao=''N'''+
                                ' and mova_situacao=''P'''+
//                                ' and mova_tipo_codigo='+EdCliente.assql+
                                ' and ( mova_notagerada=0 or mova_notagerada is null )');
       if QRoma.eof then
           EdPedido.invalid('Saida (valores) n�o encontrada ou com nota de venda j� feita')
       else begin
         EdCliente.SetValue(QRoma.fieldbyname('mova_tipo_codigo').asinteger);
         EdCliente.validfind;
         campoufentidade:='clie_uf';
         EdUnid_codigo.validfind;
         result:=true;
       end;
       FGeral.fechaquery(QRoma);
    end;

/////////////////////////////////////////////////////////////////////
    Procedure  BuscaSaidaAbate;

      type TProdutos=record
        produto:string;
        pesocarcaca,pesovivo:currency;
        vlrunitario,valortotal:extended;
        pecas:integer;
      end;

      var p,x:integer;
          Lista:Tlist;
          PProdutos:^Tprodutos;
          QRoma:TSqlquery;

           procedure AtualizaLista;
           var i:integer;
               achou:boolean;
           begin
             achou:=false;
             for i:=0 to Lista.count-1 do begin
               PProdutos:=Lista[i];
               if PProdutos.produto=QRoma.fieldbyname('movd_esto_codigo').AsString then begin
                 achou:=true;
                 break;
               end;
             end;
             if not achou then begin
                New(PProdutos);
                PProdutos.produto:=QRoma.fieldbyname('movd_esto_codigo').AsString;
                PProdutos.pesocarcaca:=QRoma.fieldbyname('movd_pesocarcaca').Ascurrency;
                PProdutos.pesovivo:=QRoma.fieldbyname('movd_pesovivo').Ascurrency;
                PProdutos.vlrunitario:=FGeral.Arredonda((QRoma.fieldbyname('movd_vlrarroba').Ascurrency),6);
                PProdutos.valortotal:=QRoma.fieldbyname('movd_pesocarcaca').Ascurrency*PProdutos.vlrunitario;
//                PProdutos.pecas:=1;
// 16.10.08
                PProdutos.pecas:=QRoma.fieldbyname('movd_pecas').AsInteger;
                Lista.Add(PProdutos);
             end else begin
                PProdutos.pesovivo:=PProdutos.pesovivo+QRoma.fieldbyname('movd_pesovivo').Ascurrency;
                PProdutos.pesocarcaca:=PProdutos.pesocarcaca+QRoma.fieldbyname('movd_pesocarcaca').Ascurrency;
                PProdutos.valortotal:=PProdutos.valortotal+(QRoma.fieldbyname('movd_pesocarcaca').Ascurrency*(FGeral.Arredonda((QRoma.fieldbyname('movd_vlrarroba').Ascurrency),6)));
                PProdutos.vlrunitario:=PProdutos.valortotal/PProdutos.pesocarcaca;
//                PProdutos.pecas:=PProdutos.pecas+1;
                PProdutos.pecas:=PProdutos.pecas+QRoma.fieldbyname('movd_pecas').AsInteger;
             end;
           end;

           procedure IncluiGrid(x:integer);
           var codigosit:integer;
               QEst:TSqlquery;
               reducaobase:extended;
           begin
              QEst:=sqltoquery('select esqt_vendamin,esqt_cfis_codigoest from estoqueqtde where esqt_unid_codigo='+EdUnid_codigo.text+
                               ' and esqt_status=''N'' and esqt_esto_codigo='+stringtosql(PProdutos.produto));
              Grid.Cells[Grid.Getcolumn('move_esto_codigo'),x]:=PProdutos.produto;
              Grid.Cells[Grid.Getcolumn('codtamanho'),x]:='';
              Grid.Cells[Grid.Getcolumn('codcor'),x]:='';
              Grid.Cells[Grid.Getcolumn('codcopa'),x]:='';
              Grid.Cells[Grid.Getcolumn('cor'),Abs(x)]:='';
              Grid.Cells[Grid.Getcolumn('tamanho'),Abs(x)]:='';
              Grid.Cells[Grid.Getcolumn('copa'),Abs(x)]:='';
              Grid.Cells[Grid.Getcolumn('esto_descricao'),x]:=FEstoque.GetDescricao(PProdutos.produto);

              Grid.Cells[Grid.getcolumn('move_cst'),Abs(x)]:=FEstoque.Getsituacaotributaria(PProdutos.produto,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,
                            Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,EdCliente.asinteger,revenda);
              Grid.Cells[Grid.getcolumn('move_aliicms'),Abs(x)]:=currtostr(FEstoque.Getaliquotaicms(PProdutos.produto,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,EdCliente.asinteger,
                            Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,revenda) );
              if EdUNid_codigo.resultfind.FieldByName('unid_uf').asstring=EdCliente.resultfind.fieldbyname(campoufentidade).asstring then
                reducaobase:=FCodigosFiscais.GetAliquotaRedBase( QEst.fieldbyname('esqt_cfis_codigoest').asstring )
              else
                reducaobase:=0;

              Grid.Cells[Grid.Getcolumn('move_redubase'),Abs(x)]:=Transform(reducaobase,'#0.000');
//              Grid.Cells[Grid.Getcolumn('move_cst'),x]:='000';
//              Grid.Cells[Grid.Getcolumn('move_aliicms'),x]:=transform(0,'#0.0');
              Grid.Cells[Grid.Getcolumn('move_aliipi'),x]:=transform(0,'#0.0');
              Grid.Cells[Grid.Getcolumn('esto_unidade'),x]:=FEstoque.GetUnidade(PProdutos.produto);
              Grid.Cells[Grid.Getcolumn('move_qtde'),x]:=transform(PProdutos.pesocarcaca,f_qtdestoque);
              Grid.Cells[Grid.Getcolumn('qtdeprev'),x]:=transform(PProdutos.pesocarcaca,f_qtdestoque);
              Grid.Cells[Grid.Getcolumn('move_vendabru'),x]:=transform(PProdutos.vlrunitario,'##,##0.000000');
              Grid.Cells[Grid.Getcolumn('move_venda'),x]:=TRansform(PProdutos.vlrunitario,'##,##0.000000');
              Grid.Cells[Grid.Getcolumn('total'),x]:=TRansform(PProdutos.valortotal,f_cr);
              Grid.Cells[13,x]:=Transform(0,f_cr);  // margemlucro
      //        margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(PProdutos.produto,EdUnid_codigo.text,QFornec.fieldbyname(campoufentidade).asstring));
              codigosit:=FEstoque.GetCodigosituacaotributaria(PProdutos.produto,EdUnid_codigo.text,QRoma.fieldbyname(campoufentidade).asstring);
              Grid.Cells[14,x]:=inttostr(codigosit);
              Grid.Cells[15,x]:='';
              Grid.Cells[Grid.Getcolumn('move_pecas'),x]:=INttostr(PProdutos.pecas);
              Grid.Cells[Grid.Getcolumn('move_vendamin'),Abs(x)]:=TRansform(QEst.fieldbyname('esqt_vendamin').AsCurrency,f_cr);
              FGeral.fechaquery(QEst);
              Grid.AppendRow;
           end;


      begin

         if( not EdPedido.isempty ) and (OP='I') then begin
//            if not ChecaRomaneios then begin
//              EdRomaneio.Invalid('');
//              exit;
//            end;
            QRoma:=sqltoquery('select * from movabatedet inner join movabate on ( mova_transacao=movd_transacao ) '+
                                ' inner join clientes on ( clie_codigo=mova_tipo_codigo )'+
                                ' where '+FGeral.GetIN('mova_numerodoc',EdPedido.text,'N')+
                                ' and movd_status=''N'''+
                                ' and movd_tipomov='+stringtosql(TipoSaidaAbate)+
//                                ' and mova_situacao=''N'''+
                                ' and mova_situacao=''P'''+
//                                ' and mova_tipo_codigo='+EdCliente.assql+
                                ' and ( mova_notagerada=0 or mova_notagerada is null )'+
                                ' order by movd_esto_codigo');
            if QRoma.eof then
              EdPedido.invalid('Saida n�o encontrada ou com nota de venda j� feita')
            else begin
              Grid.clear;
              Lista:=TList.create;
              EdDtMovimento.SetDate(QRoma.fieldbyname('mova_datacont').asdatetime);
              while not QRoma.eof do begin
                AtualizaLista;
                QRoma.Next;
              end;
      // joga no grid totalizando por codigo
              x:=1;
              for p:=0 to Lista.count-1 do begin
                PProdutos:=Lista[p];
                Incluigrid(p+1);
              end;
      // atualiza os edits de valores totais da nota
              SetaEditsvalores;
              Lista.free;
            end;
            FGeral.Fechaquery(QRoma);
         end;

    end;
////////////////////////////////


begin
/////////////////////////////////////////

  ListaReq:=TList.create;
  EdPedidos.enabled:=false;
  EdPedidos.visible:=false;
  EdPedidos.Items.Clear;
  if Edpedido.isempty then exit;
// 17.06.08 - aqui ver para buscar e somar os itens das saidas de abate - talvez usar as mesmas condicoes que
//            faz o F12 mostrar as saidas de abate...
  if ( pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodContrato)=0 )
    then begin
    if ( FGeral.GetConfig1AsInteger('ConfMovAbate')=Edcomv_codigo.ResultFind.FieldByName('comv_codigo').asinteger ) then begin
      if not BuscaSaidaAbateMestre then exit;
      BuscaSaidaAbate;
    end else begin
      Qped:=sqltoquery( FGeral.Buscapedvenda(EdPedido.asinteger) );
      if QPed.eof then
        EdPedido.invalid('Pedido n�o encontrado')
      else begin
        Edcliente.setvalue(QPed.fieldbyname('mped_tipo_codigo').asinteger);
        if Global.Topicos[1322] then begin
           EdPedidos.enabled:=true;
           EdPedidos.visible:=true;
           QPed.close;
           QPed:=sqltoquery( 'select * from movpeddet inner join movped on (mped_transacao=mpdd_transacao)'+
            ' inner join estoque on (esto_codigo=mpdd_esto_codigo)'+
            ' where '+FGeral.Getin('mpdd_unid_codigo',Global.Usuario.UnidadesMvto,'C')+
            ' and '+FGeral.Getin('mpdd_status','N','C')+
//            ' and '+FGeral.Getin('mpdd_tipomov',tipomov,'C')+
              ' and mped_situacao=''P'' and mped_tipo_codigo='+EdCliente.assql+
            ' order by mped_datamvto');
           while not QPed.Eof do begin
             EdPedidos.Items.Add(strzero(QPed.fieldbyname('mped_numerodoc').asinteger,7)+' - '+QPed.fieldbyname('esto_descricao').asstring);
             QPed.Next;
           end;
           EdPedidos.setfocus;
        end;
      end;
    end;
  //  else if QPed.fieldbyname('mped_tipo_codigo').asinteger<>EdCliente.asinteger then
  //    EdPedido.Invalid('Pedido pertence ao cliente '+QPed.fieldbyname('mped_tipo_codigo').asstring+
  //                     ' '+FGeral.GetRazSocialTipoCad(QPed.fieldbyname('mped_tipo_codigo').asinteger,'C') );
  //  else if (QPed.fieldbyname('mped_envio').asstring='P') and  (QPed.fieldbyname('mped_dataautoriza').asdatetime<1) then
  //    EdPedido.invalid('Pedido ainda n�o liberado pelo financeiro para envio via PAC');

  end else begin
////////////VENDA CONTRATO - VX - Carli
    Q:=sqltoquery('select moes_numerodoc,moes_transacao from movesto where moes_numerodoc='+inttostr(strtoint(FGeral.TiraBarra(trim(EdPedido.Text),'-'))) +
                  ' and moes_status=''N'' and moes_tipomov='+stringtosql(Global.CodContrato) );
    if not q.Eof then begin
      EdPedido.invalid('Obra j� encontrada na transa��o '+Q.fieldbyname('moes_transacao').asstring+'.  Cancelar primeiro');
      exit;
    end;
    localexterno:=FGeral.Getconfig1asstring('localpea');
    valorcontrato:=0;
    if trim(localexterno)='' then begin
      EdPedido.invalid('Falta configurar o local do PEA na configura��o geral do sistema');
      exit;
    end else begin
      dbforcam.FileName:=localexterno+'OBITENS.DBF';
//      dbforcam.TableName:=localexterno+'OBITENS.DBF';
      try
        dbforcam.Open;
      except
        EdPedido.invalid('N�o foi poss�vel abrir arquivo '+dbforcam.FileName);
//        EdPedido.invalid('N�o foi poss�vel abrir arquivo '+dbforcam.TableName);
        exit;
      end;
      Sistema.beginprocess('Pesquisando obra '+EdPedido.text);
      Grid.clear;
      FGeral.Getvalor(valorcontrato);
      ListaOrcam:=TList.create;
      obra:='VIMS-'+EdPedido.text;
      while not dbforcam.Eof do begin
        if dbforcam.FieldByName('codigo').asstring=obra then begin
          BuscaItens(dbforcam.fieldbyname('CODESQD').Asstring);
//          QEstoque:=sqltoquery('select * from estoque where esto_referencia='+stringtosql(dbforcam.fieldbyname('CODESQD').Asstring));
//          if QEstoque.Eof then
//            Aviso('N�o encontrado item da obra '+dbforcam.fieldbyname('CODESQD').Asstring+'|');
        end;
        dbforcam.Next;
      end;

// busca os perfis para os 'caixilhos' - relat. rela��o de barras
////////////////////////
      dbforcam.close;
      dbforcam.FileName:=localexterno+'OBAPROV.DBF';
//      dbforcam.TableName:=localexterno+'OBAPROV.DBF';
      try
        dbforcam.Open;
      except
        EdPedido.invalid('N�o foi poss�vel abrir arquivo '+dbforcam.FileName);
//        EdPedido.invalid('N�o foi poss�vel abrir arquivo '+dbforcam.TableName);
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
        EdPedido.invalid('N�o foi poss�vel abrir arquivo '+dbforcam.FileName);
//        EdPedido.invalid('N�o foi poss�vel abrir arquivo '+dbforcam.TableName);
        exit;
      end;
//////////////      ListaReq:=TList.create;
      while not dbforcam.Eof do begin
        if dbforcam.FieldByName('codigo').asstring=obra then begin
          QEstoque:=sqltoquery('select * from estoque where esto_referencia='+stringtosql(dbforcam.FieldByName('codaces').asstring));
          if not QEstoque.Eof then begin
//            EdPedido.invalid('Acess�rio codigo '+dbforcam.FieldByName('codaces').asstring+' n�o encontrado');
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
        EdPedido.invalid('N�o foi poss�vel abrir arquivo '+dbforcam.FileName);
//        EdPedido.invalid('N�o foi poss�vel abrir arquivo '+dbforcam.TableName);
        exit;
      end;
      obra:='VIMS-'+EdPedido.text;
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
        EdPedido.invalid('N�o foi poss�vel abrir arquivo '+dbforcam.FileName);
//        EdPedido.invalid('N�o foi poss�vel abrir arquivo '+dbforcam.TableName);
        exit;
      end;
      obra:='VIMS-'+EdPedido.text;
      while not dbforcam.Eof do begin
        if dbforcam.FieldByName('codigo').asstring=obra then
          SomanosItens;
        dbforcam.Next;
      end;
///////////////////
      if ListaOrcamRes.count>0 then begin
        DadostoGridExterno;
      end else
        Avisoerro('N�o encontrado obra '+EdPedido.text);
      Sistema.endprocess('');
      dbforcam.close;
    end;
  end;
end;

procedure TFNotaSaidaMo.EdUnitarioValidate(Sender: TObject);
begin
//   if EdUNitario.isempty then
//     EdUnitario.invalid('Pre�o de venda n�o pode ser zerado');
end;

procedure TFNotaSaidaMo.Editsconsig(ativa: string);
begin
   if ativa='A' then begin
     EdVendasmc.enabled:=true;
     EdDevolucoesdm.enabled:=true;
   end else begin
     EdVendasmc.enabled:=false;
     EdDevolucoesdm.enabled:=false;
   end;
end;

procedure TFNotaSaidaMo.SetaItemsConsig(tipomov: string;  Edit: TSqled ; xData:TDatetime=0);
var Q:TSqlquery;
    data:TDatetime;
    docs,sqlnumerodoc,vendasmc,sqldata:string;
    p:integer;
begin
   Sistema.beginprocess('Pesquisando notas tipo '+tipomov);
   data:=sistema.hoje-360;
   sqlnumerodoc:='';
   sqldata:=' and moes_datamvto>='+Datetosql(data);
   if xdata>0 then
     sqldata:=' and moes_datamvto>='+Datetosql(xdata);
//   if (tipomov=Global.CodContratoEntrega) then begin
   if pos(tipomov,Global.CodContratoEntrega+';'+Global.CodContrato)=0 then begin
     vendasmc:='';
     for p:=0 to EdVendasmc.Items.Count-1 do begin
       if trim(EdVendasmc.Items.Strings[p])<>'' then
         vendasmc:=vendasmc+copy(EdVendasmc.Items.Strings[p],1,8)+';';
     end;
     sqlnumerodoc:=' and '+FGeral.SimilarTo('moes_remessas',Vendasmc);
   end;
   Q:=sqltoquery('select moes_numerodoc,moes_dataemissao from movesto where moes_tipomov='+stringtosql(tipomov)+
                 ' and moes_tipo_codigo='+EdCliente.Assql+' and moes_status=''N'''+
                 ' and moes_datacont>1'+
                 sqlnumerodoc+sqldata+
                 ' and moes_unid_codigo='+EdUnid_codigo.assql+
                 ' order by moes_numerodoc' );
   docs:='';
   Edit.Items.clear;
   while not Q.eof do begin
     docs:=docs+strzero(Q.fieldbyname('moes_numerodoc').asinteger,8)+';';
     Edit.Items.Add(strzero(Q.fieldbyname('moes_numerodoc').asinteger,8)+' - '+FGeral.formatadata(Q.fieldbyname('moes_dataemissao').asdatetime) );
     Q.Next;
   end;
   if tipomov=Global.CodContratoEntrega then
     Edit.text:=docs;  // para nao precisar escolher com o f12
   FGeral.Fechaquery(Q);
   Sistema.endprocess('');


end;

procedure TFNotaSaidaMo.EdDevolucoesdmValidate(Sender: TObject);
type TLista=record
     produto,cst:string;
     qtde,aliicms,venda,perdesco,vendabru:currency;
end;

var QMovimento:TSqlquery;
    Lista:TList;
    x,y:integer;
    PLista:^TLista;
    data:TDatetime;
    tipomov,tipomovd:string;

    procedure Atualiza(xtipo:string);
    var p:integer;
        achou:boolean;
    begin
       achou:=false;
       for p:=0 to LIsta.count-1 do begin
          PLista:=Lista[p];
          if Plista.produto=QMovimento.fieldbyname('move_esto_codigo').asstring then begin
            achou:=true;
            break;
          end;
       end;
       if not achou then begin
         New(PLista);
         PLista.produto:=QMovimento.fieldbyname('move_esto_codigo').asstring;
         PLista.cst:=QMovimento.fieldbyname('move_cst').asstring;
         PLista.aliicms:=QMovimento.fieldbyname('move_aliicms').ascurrency;
         PLista.venda:=QMovimento.fieldbyname('move_venda').ascurrency;
         PLista.perdesco:=0;
         PLista.vendabru:=QMovimento.fieldbyname('move_vendabru').ascurrency;
//         if QMovimento.fieldbyname('move_tipomov').asstring=xtipo then
// 08.11.08
         if pos(xtipo,Global.CodContrato+';'+Global.CodConsigMercantil)>0 then
           PLista.qtde:=QMovimento.fieldbyname('move_qtde').asfloat
         else
           PLista.qtde:=(-1)*QMovimento.fieldbyname('move_qtde').asfloat;
         Lista.Add(PLista);
       end else begin
//         if QMovimento.fieldbyname('move_tipomov').asstring=xtipo then
         if pos(xtipo,Global.CodContrato+';'+Global.CodConsigMercantil)>0 then
           PLista.qtde:=PLista.qtde+QMovimento.fieldbyname('move_qtde').asfloat
         else
           PLista.qtde:=PLista.qtde-QMovimento.fieldbyname('move_qtde').asfloat;
       end;
    end;

begin

//   if (not EdVendasmc.isempty) and ( not EdDevolucoesdm.isempty) and (OP='I') and
   if (not EdVendasmc.isempty)  and (OP='I') and
      ( pos(Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodVendaConsigMercantil+';'+Global.CodContratoEntrega )>0) then begin
     Sistema.beginprocess('Calculando saldo por produto');
     data:=sistema.hoje-360;
     tipomov:=Global.CodConsigMercantil;
     tipomovd:=Global.CodDevolucaoConsigMerc;
     if Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring<>Global.CodVendaConsigMercantil then begin
       tipomov:=Global.CodContrato;
       tipomovd:=Global.CodContratoEntrega;
     end;
     if EdDevolucoesdm.isempty then
       EdDevolucoesdm.text:='999999';  // s� pra dar eof nas devolucoes
     QMovimento:=sqltoquery('select * from movestoque inner join movesto'+
                 '  on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov )'+
                 ' where move_tipomov='+stringtosql(tipomov)+
                 ' and move_tipo_codigo='+EdCliente.Assql+' and move_status=''N'''+
                 ' and move_datacont>1'+
                 ' and '+FGeral.Getin('move_numerodoc',EdVendasmc.text,'N')+
                 ' and move_datamvto>='+Datetosql(data)+' and move_unid_codigo='+EdUnid_codigo.assql+
                 ' order by move_esto_codigo' );
     Lista:=TList.create;
     while not QMovimento.eof do begin
        Atualiza(tipomov);
        QMovimento.Next;
     end;
     FGEral.Fechaquery(QMovimento);
     QMovimento:=sqltoquery('select * from movestoque inner join movesto on ( moes_transacao=move_transacao  and moes_tipomov=move_tipomov)'+
                 ' where move_tipomov='+stringtosql(tipomovd)+
                 ' and move_tipo_codigo='+EdCliente.Assql+' and move_status=''N'''+
                 ' and move_datacont>1'+
                 ' and '+FGeral.Getin('move_numerodoc',EdDevolucoesdm.text,'N')+
                 ' and move_datamvto>='+Datetosql(data)+' and move_unid_codigo='+EdUnid_codigo.assql+
                 ' order by move_esto_codigo' );
     while not QMovimento.eof do begin
        Atualiza(tipomovd);
        QMovimento.Next;
     end;
     FGEral.Fechaquery(QMovimento);
     Grid.clear;
     for y:=0 to LIsta.count-1 do begin
        PLista:=Lista[y];
        if Plista.qtde>0 then begin
          if (Grid.RowCount=2) and (Trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),1])='') then begin
             x:=1;
          end else begin
             Grid.RowCount:=Grid.RowCount+1;
             x:=Grid.RowCount-1;
          end;
          Grid.Cells[Grid.getcolumn('move_esto_codigo'),Abs(x)]:=Plista.produto;
          Grid.Cells[Grid.getcolumn('esto_descricao'),Abs(x)]:=FEstoque.getdescricao(PLista.produto);
          if Nfexporta(EdNatf_codigo.text) then begin
            Grid.Cells[Grid.getcolumn('move_cst'),Abs(x)]:=cstexporta;
            Grid.Cells[Grid.getcolumn('move_aliicms'),Abs(x)]:=currtostr(icmsexporta);
          end else begin

            Grid.Cells[Grid.getcolumn('move_cst'),Abs(x)]:=FEstoque.Getsituacaotributaria(PLista.produto,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,
                                  Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,EdCliente.asinteger,revenda);
            Grid.Cells[Grid.getcolumn('move_aliicms'),Abs(x)]:=currtostr(FEstoque.Getaliquotaicms(PLista.produto,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,EdCliente.asinteger,
                                  Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,revenda) );

          end;
          Grid.Cells[Grid.getcolumn('esto_unidade'),Abs(x)]:=Festoque.getunidade(PLista.produto);
          Grid.Cells[Grid.getcolumn('move_qtde'),Abs(x)]:=floattostr(Plista.qtde);
          Grid.Cells[Grid.getcolumn('move_venda'),Abs(x)]:=floattostr(Plista.venda);
          Grid.Cells[Grid.getcolumn('total'),Abs(x)]:=TRansform(Plista.qtde*Plista.venda,f_cr);
    //      Grid.Cells[Grid.getcolumn('move_perdesco'),Abs(x)]:=0;
          Grid.Cells[Grid.getcolumn('move_vendabru'),Abs(x)]:=TRansform(Plista.vendabru,f_cr);
// 29.11.07
          Grid.Cells[Grid.getcolumn('esto_referencia'),Abs(x)]:=Arq.TEstoque.fieldbyname('esto_referencia').asstring;
       end; // else
//         Avisoerro('Produto '+PLista.produto+' '+FEstoque.getdescricao(PLista.produto)+' saldo negativo '+floattostr(PLista.qtde))
     end;
     SetaEditsValores;
     Sistema.endprocess('');

   end;
end;

procedure TFNotaSaidaMo.EdCodtamanhoValidate(Sender: TObject);
begin
   if not FGeral.ValidaGrade(EdCodcor.asinteger,EdCodtamanho.asinteger,0,EdProduto.text,'cor;tamanho') then
     EdCodtamanho.invalid('')

end;

procedure TFNotaSaidaMo.EdCodcopaValidate(Sender: TObject);
begin
   if not FGeral.ValidaGrade(EdCodcor.asinteger,EdCodtamanho.asinteger,EdCodcopa.asinteger,EdProduto.text,'cor;tamanho;copa') then
     EdCodcopa.invalid('');

end;

procedure TFNotaSaidaMo.EdcodcorValidate(Sender: TObject);
begin
  if not FGeral.ValidaGrade(EdCodcor.asinteger,0,0,EdProduto.text,'cor' ) then
     EdCodcor.invalid('');

end;

procedure TFNotaSaidaMo.EdValoripiExitEdit(Sender: TObject);
begin
   EdTotalNota.setvalue(EdTotalProdutos.ascurrency+EdValoripi.ascurrency);
end;

procedure TFNotaSaidaMo.EdTotalprodutosValidate(Sender: TObject);
begin
// 23.01.07 - somente at� come�ar a fazer nota pelo sistema
  EdTotalNota.setvalue(EdTotalProdutos.ascurrency+EdValoripi.ascurrency);

end;

function TFNotaSaidaMo.TiposFornecedor(tipomov: string): boolean;
begin
   if pos( tipomov,TiposFornec ) >0 then
     result:=true
   else
     result:=false;
end;

procedure TFNotaSaidaMo.EdcontainerExitEdit(Sender: TObject);
begin
   bIncluiritemClick(FNotaSaidaMO);

end;

procedure TFNotaSaidaMo.SetaPortosEmbarque(Ed: TSqlEd);
begin
  Ed.Items.Clear;
  Ed.Items.Add('Itaja�');
  Ed.Items.Add('S�o Francisco do Sul');
  Ed.Items.Add('Paranagu�');
end;

function TFNotaSaidaMo.EstaCodigosNaoVenda(produto: string): boolean;
var Lista:TStringlist;
    codigosnaovenda,GruposNaoVenda:string;
    p:integer;
    Q:TSqlquery;
begin
  codigosnaovenda:=FGeral.GetConfig1AsString('Produtosnaovenda');
// 05.01.09 - Vanessa - Novicarnes
  GruposNaoVenda:=FGeral.GetConfig1AsString('GRUPOSNAOVEN');
  result:=false;
  if EdNatf_codigo.resultfind=nil then exit;  // 12.02.09
  if EdNatf_codigo.resultfind.fieldbyname('Natf_movimento').asstring<>'V' then exit;
  if trim(codigosnaovenda)<>'' then begin
    Lista:=TStringlist.create;
    strtolista(Lista,codigosnaovenda,';',true);
    for p:=0 to Lista.count-1 do begin
      if trim(Lista[p])<>'' then begin
        if Lista[p]=produto then begin
          result:=true;
          break;
        end;
      end;
    end;
    Lista.free;
  end;
  if trim(GruposNaoVenda)<>'' then begin
    Q:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(produto) );
    if not Q.eof then begin
      Lista:=TStringlist.create;
      strtolista(Lista,GruposNaoVenda,';',true);
      for p:=0 to Lista.count-1 do begin
        if strtointdef(Lista[p],0)>0 then begin
          if strtointdef(Lista[p],0)=strtointdef(Q.fieldbyname('esto_grup_codigo').asstring,0) then begin
            result:=true;
            break;
          end;
        end;
      end;
      Lista.free;
    end;
    FGEral.FechaQuery(Q);
  end;

end;

procedure TFNotaSaidaMo.ImprimeContrato(xtransacao:string);
var
    ArquivoSalvar:olevariant; //local e nome para salvar arquivo
    s:olevariant; //facilitar trabalho
    back ,  msword : olevariant;
    linhas,colunas,i,j,p:integer;
    QNota,QPendencias,QCaixa,QCliente:TSqlquery;
    Produtos,Parcelas:TStrings;
    valoritem:currency;
begin
    QNota:=sqltoquery('select * from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov )'+
                  ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                  ' where move_transacao='+stringtosql(xtransacao)+' and move_status<>''C'''+
                  ' and move_tipomov='+stringtosql(Global.CodContrato));
    if QNota.eof then begin
      FGeral.FechaQuery(QNota);
      exit;
    end;
    QCliente:=sqltoquery('select * from clientes where clie_codigo='+QNota.fieldbyname('move_tipo_codigo').asstring);
    Produtos:=Tstringlist.Create;
    Parcelas:=tStringlist.create;

    while not Qnota.eof do begin
      valoritem:=QNota.fieldbyname('move_venda').ascurrency*QNota.fieldbyname('move_qtde').ascurrency;
      Produtos.Add(QNota.fieldbyname('move_esto_codigo').asstring+' '+strspace(FEstoque.GetDescricao(QNota.fieldbyname('move_esto_codigo').asstring),50)+#9+' '+
                FGEral.Formatavalor(valoritem,f_cr) );
      QNota.Next;
    end;
    QCaixa:=sqltoquery('select * from movfin where movf_transacao='+stringtosql(xtransacao));
    while not QCaixa.eof do begin
      Parcelas.add('Entrada :'+FGeral.formatavalor(QCaixa.fieldbyname('movf_valorger').ascurrency,f_cr));
      QCaixa.Next;
    end;
    QPendencias:=sqltoquery('select * from pendencias where pend_transacao='+stringtosql(xtransacao));
    while not QPendencias.eof do begin
      Parcelas.add(FGeral.formatavalor(QPendencias.fieldbyname('pend_valor').ascurrency,f_cr)+'  -  '+
                   FGeral.formatadata(QPendencias.fieldbyname('pend_datavcto').asdatetime));
      QPendencias.Next;
    end;
        linhas:=63 ; colunas:=63;

        msword := createoleobject('word.application'); //abre aplicativo
        msword.documents.add; //adiciona novo documento
                if MSWord.ActiveWindow.View.SplitSpecial <> 0 then
                   MSWord.ActiveWindow.Panes[2].Close;
                if (MSWord.ActiveWindow.ActivePane.View.type = 1) or
                   (MSWord.ActiveWindow.ActivePane.View.type = 2) or
                   (MSWord.ActiveWindow.ActivePane.View.type = 5) then
                   MSWord.ActiveWindow.ActivePane.View.type := 3;
        s := msword.selection; //variavel para facilitar trabalho
{
        MSWord.ActiveWindow.ActivePane.View.SeekView := 9; //habilita o cabe�alho
        s.typetext('Cabe�alho habilitado');
        msword.activewindow.activepane.view.seekview := 10; //habilita o rodap�
        s.typetext('rodap� habilitado');
}
        msword.activewindow.activepane.view.seekview := 0; //habilita o texto

        s.Font.Bold := True;    //negrito
        s.typetext('Contratante : '+strspace(Qcliente.fieldbyname('clie_razaosocial').asstring,50) );
        s.typeparagraph;
        s.typetext('Contratado  : '+strspace('VIMS - Esquadrias de Alum�nio',50) );
        s.Font.Bold := False;    //negrito

//        s.typetext('texto habilitado');

//        msword.activedocument.PageSetup.Orientation := wdOrientLandscape;  //p�gina em landscape

//        s.Font.Name := 'Times New Roman'; //tipo de letra
        s.Font.Size := 12;    //tamanho de letra
//        s.Font.italic := True;    //italico
//        s.font.Subscript := false;      //subescrito
//        s.font.Superscript := false;   //sobrescrito
//        s.font.Underline := true;     //sublinhado
//        s.font.color := clGreen;    //cor da letra

//        s.paragraphFormat.alignment := wdAlignParagraphJustify;
                //alinha o texto a esquerda
                //esquerda=0, centro=1, direita=2, wdAlignParagraphJustify
//        s.typetext(#9); //tab

        s.typeparagraph;

// para cria tipo uma grade dentro do texto do word
//        s.tables.add(s.range,linhas,colunas); //cria tabela i linhas, j colunas

//        s.tables.item(1).columns.item(2).setwidth(100,wdAdjustNone);
                //comprimento da segunda coluna sem modificar a posi��o do texto

//        s.tables.item(1).cell(2,3).range.insertAfter('escrito na posi��o 2,3');
                //escreva na posi��o 2,3
//      s.cells.autofit; //alinha conforme coluna
//        s.tables.item(1).cell(i,j).select; //seleciona celula i,j
//        s.moveright;  //move para direita
        for p:=0 to Produtos.count-1 do begin
          s.typetext(Produtos[p]);
          s.typeparagraph;
        end;

        s.typeparagraph;

        s.Font.Name := 'Arial'; //tipo de letra
        s.typetext('Parcela       Vencimento');
        s.typeparagraph;
        for p:=0 to Parcelas.count-1 do begin
          s.typetext(Parcelas[p]);
          s.typeparagraph;
        end;

//        s.Font.Name := 'Comic Sans'; //tipo de letra
//        s.font.color := clBlack;    //cor da letra
//        s.typetext('escrito em letra Comic Sans ');

        //notas de rodap�
//        s.footnotes.add(msword.selection.range,emptyparam,'texto');
        //notas de cabe�alho
//        s.endnotes.add(msword.selection.range,emptyparam,'texto');
        //coment�rio
//        s.comments.add(msword.selection.range,'texto');
//        s.PageSetup.TopMargin := 10;  //margem superior
//        s.PageSetup.leftMargin := 100; //margem esquerda
//        s.PageSetup.rightMargin := 80; //margem direita
//        s.PageSetup.BottomMargin := 60; //magem abaixo
        msword.application.visible :=true; //mantem visivel o documento word
//        ArquivoSalvar := 'd:\teste.doc';
        ArquivoSalvar := 'teste.doc';
        MSWORD.ActiveDocument.SaveAs(arquivosalvar); //salva sem perguntar
//      msword.documents.save; //abre janela para salvar
//      msword.ActiveDocument.PrintOut(false); //imprime direto, sem perguntar
//      msword.ActiveDocument.PrintPreview; //vizualizar impress�o
//        msword.Quit  // finaliza aplica��oend;
end;


procedure TFNotaSaidaMo.blebalanca1Click(Sender: TObject);
begin
    abrirporta;

end;

function TFNotaSaidaMo.AbrirPorta: boolean;
begin
  try
   Serial.Open;
   result:=true;
  except
    Avisoerro('Problemas para abrir a porta '+Serial.DeviceName);
    result:=false;
  end;

end;


//procedure TFNotaSaida.SerialRxChar(Sender: TObject; Count: Integer);
{
var Buffer:array[1..1024] of char; s:String; i,q:Integer;
begin
//  Sleep(100);
  Sleep(10);
  s:='';
  q:=serial.InQueCount;
  Serial.Read(Buffer,q);
  for i:=1 to q do begin
      if Buffer[i] in ['0'..'9'] then s:=s+Buffer[i];
  end;

  if Trim(s)<>'' then begin
      EdQtde.setvalue( ( texttovalor(LeftStr(s,08))/10 ) );
  end;
end;
}

procedure TFNotaSaidaMo.SerialRxChar(Sender: TObject; Count: Integer);
var Buffer:array[1..1024] of char; s:String; i,q:Integer;
begin
//  Sleep(100);
  Sleep(10);
  s:='';
  q:=serial.InQueCount;
  Serial.Read(Buffer,q);
  for i:=1 to q do begin
      if Buffer[i] in ['0'..'9'] then s:=s+Buffer[i];
  end;

  if Trim(s)<>'' then begin
//      EdQtde.setvalue( ( texttovalor(LeftStr(s,08))/10 ) );
      if FGeral.GetConfig1AsInteger('DIVBALANCA')>0 then
        EdQtde.setvalue( ( texttovalor(LeftStr(s,08))/FGeral.GetConfig1AsInteger('DIVBALANCA') ) )
      else
        EdQtde.setvalue( ( texttovalor(LeftStr(s,08)) ) );
  end;

end;

procedure TFNotaSaidaMo.blebalanca2Click(Sender: TObject);
begin
    abrirporta2;

end;

function TFNotaSaidaMo.AbrirPorta2: boolean;
begin
  try
   Serial2.Open;
   result:=true;
  except
    Avisoerro('Problemas para abrir a porta '+Serial2.DeviceName);
    result:=false;
  end;

end;

procedure TFNotaSaidaMo.Serial2RxChar(Sender: TObject; Count: Integer);
var Buffer:array[1..1024] of char; s:String; i,q:Integer;
begin
//  Sleep(100);
  Sleep(10);
  s:='';
  q:=serial2.InQueCount;
  Serial2.Read(Buffer,q);
  for i:=1 to q do begin
      if Buffer[i] in ['0'..'9'] then s:=s+Buffer[i];
  end;

  if Trim(s)<>'' then begin
//      EdQtde.setvalue( ( texttovalor(LeftStr(s,08))/10 ) );
      if FGeral.GetConfig1AsInteger('DIVBALANCA')>0 then
        EdQtde.setvalue( ( texttovalor(LeftStr(s,08))/FGeral.GetConfig1AsInteger('DIVBALANCA') ) )
      else
        EdQtde.setvalue( ( texttovalor(LeftStr(s,08)) ) );
  end;

end;

procedure TFNotaSaidaMo.EdPedidosExit(Sender: TObject);
begin
  EdPedidos.enabled:=false;
  EdPedidos.visible:=false;

end;

procedure TFNotaSaidaMo.EdPedidosValidate(Sender: TObject);
begin
  if not EdPedidos.isempty then
    Qped:=sqltoquery( FGeral.Buscapedvenda(0,EdPedidos.text) );
end;

procedure TFNotaSaidaMo.GridDblClick(Sender: TObject);
var codigo:string;
begin
   codigo:=Grid.cells[Grid.getcolumn('move_esto_codigo'),Grid.row];
   if trim(codigo)='' then exit;
   if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodContratoEntrega ) =0 then exit;
   if Grid.col=grid.getcolumn('move_qtde') then begin
     EdQTdeNf.Top:=Grid.TopEdit;
     EdQTdeNf.Left:=Grid.LeftEdit;
     EdQTdeNf.Enabled:=true;
     EdQTdeNf.Visible:=true;
     EdQTdeNf.setvalue( Texttovalor((Grid.cells[grid.getcolumn('move_qtde'),grid.row])) );
     EdQTdeNf.setfocus;
   end;

end;

procedure TFNotaSaidaMo.GridKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
     Grid.OnDblClick(self);

end;

procedure TFNotaSaidaMo.EdQtdenfValidate(Sender: TObject);
begin
  if EdQtdeNf.ascurrency>Texttovalor(Grid.cells[grid.getcolumn('move_qtde'),grid.row]) then
    EdQtdenf.invalid('Quantidade inv�lida');

end;

procedure TFNotaSaidaMo.EdQtdenfExitEdit(Sender: TObject);
begin

  Grid.cells[grid.getcolumn('move_qtde'),grid.row]:=EdQtdeNf.assql;
  Grid.cells[grid.getcolumn('qtdeprev'),grid.row]:=EdQtdeNf.assql;
//  Grid.cells[grid.getcolumn('total'),grid.row]:=floattostr(EdQtdeNf.asfloat*Texttovalor(Grid.cells[grid.getcolumn('move_venda'),grid.row]));
  Grid.cells[grid.getcolumn('total'),grid.row]:=floattostr(EdQtdeNf.ascurrency*Texttovalor(Grid.cells[grid.getcolumn('move_venda'),grid.row]));
  EdQtdenf.Enabled:=false;
  EdQtdenf.Visible:=false;
  SetaEditsvalores;
  Grid.setfocus;

end;

procedure TFNotaSaidaMo.EdVendasmcValidate(Sender: TObject);
var Q:TSqlquery;
    Data:TDatetime;
begin
  if ( not EdVendasmc.isempty ) and (EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodContratoEntrega) then begin
    data:=sistema.hoje-360;
    Q:=sqltoquery('select moes_datamvto from movesto'+
                 ' where moes_tipomov='+stringtosql(Global.CodContrato)+
                 ' and moes_tipo_codigo='+EdCliente.Assql+' and moes_status=''N'''+
                 ' and moes_datacont>1'+
                 ' and '+FGeral.Getin('moes_numerodoc',EdVendasmc.text,'N')+
                 ' and moes_datamvto>='+Datetosql(data)+
                 ' and moes_unid_codigo='+EdUnid_codigo.assql+
                 ' order by moes_datamvto' );
    if not Q.eof then
      SetaItemsConsig(Global.CodContratoEntrega,EdDevolucoesdm,Q.fieldbyname('moes_datamvto').asdatetime);    // devolucoes
    FGeral.FechaQuery(Q);
  end;
end;

procedure TFNotaSaidaMo.EdRepr_codigoValidate(Sender: TObject);
begin
  if EdRepr_codigo.resultfind<>nil then begin
    if not FGeral.ValidaComissao(EdRepr_codigo.resultfind.fieldbyname('repr_comissao').ascurrency) then
      EdRepr_codigo.Invalid('')
    else if Global.Topicos[1324] then
      Edpercomissao.setvalue(EdRepr_codigo.resultfind.fieldbyname('repr_comissao').ascurrency);
  end;
end;

procedure TFNotaSaidaMo.EdRepr_codigo2Validate(Sender: TObject);
begin
  if EdRepr_codigo2.resultfind<>nil then begin
    if not FGeral.ValidaComissao(EdRepr_codigo2.resultfind.fieldbyname('repr_comissao').ascurrency) then
      EdRepr_codigo2.Invalid('')
    else if Global.Topicos[1324] then
      Edpercomissao2.setvalue(EdRepr_codigo2.resultfind.fieldbyname('repr_comissao').ascurrency);
  end;
end;

procedure TFNotaSaidaMo.EdpercomissaoValidate(Sender: TObject);
begin
    if not FGeral.ValidaComissao(EdPercomissao.ascurrency) then
      EdPerComissao.invalid('');

end;

procedure TFNotaSaidaMo.Edpercomissao2Validate(Sender: TObject);
begin
    if not FGeral.ValidaComissao(EdPercomissao2.ascurrency) then
      EdPerComissao2.invalid('');

end;

procedure TFNotaSaidaMo.EdtiponotaValidate(Sender: TObject);
begin
   if Edtiponota.isempty then exit;
   PCalcula:=FTiposnotas.GetIncidencias(Edtiponota.asinteger);
end;

procedure TFNotaSaidaMo.EdtiponotaExitEdit(Sender: TObject);
begin
  bIncluiritemClick(FNotaSaidaMo);

end;

end.


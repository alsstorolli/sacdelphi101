unit nfsaida;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr, TextRel, Impr, DB,
  /// dbf, DBTables ,
  ComObj,
  Async32, Sqlsis, ACBrBase, ACBrBAL, ComCtrls, ACBrDevice, Geral,
  ACBrSocket, ACBrIBPTax, DBGrids,AcbrNfe, ACBrDFe, ACBrCTe, FileCtrl,
  Datasnap.DBClient, SimpleDS,  ACBrDeviceSerial;

type
  TFNotaSaida = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    bIncluiritem: TSQLBtn;
    bExcluiritem: TSQLBtn;
    bCancelaritem: TSQLBtn;
    bgeranfe: TSQLBtn;
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
    EdValoripi: TSQLEd;
    EdFreteuni: TSQLEd;
    EdPecas: TSQLEd;
    Edportoorigem: TSQLEd;
    Edportodestino: TSQLEd;
    Edchavenfeacom: TSQLEd;
    bcontrato: TSQLBtn;
//    Serial: TComm;
    blebalanca1: TSQLBtn;
    blebalanca2: TSQLBtn;
//    Serial2: TComm;
    EdPedidos: TSQLEd;
    Edtransacao: TSQLEd;
    EdQtdenf: TSQLEd;
    SQLEd1: TSQLEd;
    EdRepr_codigo2: TSQLEd;
    Edpercomissao: TSQLEd;
    Edpercomissao2: TSQLEd;
    EdCertificado: TSQLEd;
    EdUnitarionf: TSQLEd;
    Edmargemlucro: TSQLEd;
    EdCorIndust: TSQLEd;
    EdOrcamentos: TSQLEd;
    EdTotalServicos: TSQLEd;
    EdPeriss: TSQLEd;
    EdValoriss: TSQLEd;
    brelpendentes: TSQLBtn;
    bgravar: TSQLBtn;
    Pbotoesgrid: TSQLPanelGrid;
    bLoadGrid: TSQLBtn;
    bSaveGrid: TSQLBtn;
    bMoveLeft: TSQLBtn;
    bMoveRight: TSQLBtn;
    EdEstadoex: TSQLEd;
    bgeraboleto: TSQLBtn;
    EdContainer: TSQLEd;
    EdCida_codigo: TSQLEd;
    bcupom: TSQLBtn;
    ACBrBAL1: TACBrBAL;
    DateTimePicker1: TDateTimePicker;
    PDescricaoproduto: TSQLPanelGrid;
    PRegistro71: TSQLPanelGrid;
    pinsere71: TSQLPanelGrid;
    EdCodentidade71: TSQLEd;
    SQLEd7: TSQLEd;
    EdDtemissao71: TSQLEd;
    EdModelo71: TSQLEd;
    EdSerie71: TSQLEd;
    EdDocumento71: TSQLEd;
    EdValordoc71: TSQLEd;
    EdUfentidade71: TSQLEd;
    SQLPanelGrid5: TSQLPanelGrid;
    SQLPanelGrid6: TSQLPanelGrid;
    binsere71: TSQLBtn;
    bexclui71: TSQLBtn;
    Grid71: TSqlDtGrid;
    bregistro71: TSQLBtn;
    bbaixa: TSQLBtn;
    Edmoes_tabp_codigo: TSQLEd;
    SetEdTABP_ALIQUOTA: TSQLEd;
    PVeiculo: TSQLPanelGrid;
    EdMoes_cola_codigo: TSQLEd;
    SetEdCOLA_NOME: TSQLEd;
    bajuda: TSQLBtn;
    Edvlroutrasdespesas: TSQLEd;
    PMensagem: TSQLPanelGrid;
    Edmens1: TSQLEd;
    Edmens2: TSQLEd;
    Edmens3: TSQLEd;
    EdMens4: TSQLEd;
    bmensagem: TSQLBtn;
    EdMens5: TSQLEd;
    EdMens6: TSQLEd;
    EdMens7: TSQLEd;
    EdCodEqui: TSQLEd;
    EdManutencao: TSQLEd;
    bgeracte: TSQLBtn;
    EdDesti_codigo: TSQLEd;
    SetEddesti_NOME: TSQLEd;
    Timer1: TTimer;
    EdNomeobra: TSQLEd;
    bafaturar: TSQLBtn;
    bvendidos: TSQLBtn;
    Edmfis_natf_codigo: TSQLEd;
    od1: TOpenDialog;
    SQLPanelGrid7: TSQLPanelGrid;
    ListaArq: TFileListBox;
    dbforcam: TSimpleDataSet;
    Dbforcamy: TSimpleDataSet;
    sbfechar: TSpeedButton;
    PRetencoes: TSQLPanelGrid;
    Label1: TLabel;
    Edvlrir: TSQLEd;
    Edvlrpis: TSQLEd;
    Edvlrcofins: TSQLEd;
    Edvlrcsll: TSQLEd;
    Edvlriss: TSQLEd;
    bimpcpr: TSQLBtn;
    ACBrNFe1: TACBrNFe;
    Edaliicmsnf: TSQLEd;
    EdNatf_codigop: TSQLEd;
    EdPedidoCompra: TSQLEd;
    EdTomador: TSQLEd;
    EdSeto_codigo: TSQLEd;
    Eddesctipo: TSQLEd;
    EdCfopitem: TSQLEd;
    bimportanf: TSQLBtn;
    Edvfcpst: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure bIncluiritemClick(Sender: TObject);
    procedure EdProdutoValidate(Sender: TObject);
    procedure EdQtdeValidate(Sender: TObject);
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
    procedure Foc(Sender: TObject);
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
    procedure EdchavenfeacomExitEdit(Sender: TObject);
    procedure bcontratoClick(Sender: TObject);
    procedure blebalanca1Click(Sender: TObject);
    procedure SerialRxChar(Sender: TObject; Count: Integer);
    procedure blebalanca2Click(Sender: TObject);
    procedure Serial2RxChar(Sender: TObject; Count: Integer);
    procedure EdPedidosExit(Sender: TObject);
    procedure EdPedidosValidate(Sender: TObject);
    procedure EdtransacaoValidate(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure EdQtdenfValidate(Sender: TObject);
    procedure EdQtdenfExitEdit(Sender: TObject);
    procedure EdVendasmcValidate(Sender: TObject);
    procedure EdRepr_codigoValidate(Sender: TObject);
    procedure EdRepr_codigo2Validate(Sender: TObject);
    procedure EdpercomissaoValidate(Sender: TObject);
    procedure Edpercomissao2Validate(Sender: TObject);
    procedure EdCertificadoValidate(Sender: TObject);
    procedure EdUnitarionfExitEdit(Sender: TObject);
    procedure EdUnitarionfValidate(Sender: TObject);
    procedure EdCorIndustValidate(Sender: TObject);
    procedure EdOrcamentosValidate(Sender: TObject);
    procedure EdDtemissaoValidate(Sender: TObject);
    procedure brelpendentesClick(Sender: TObject);
    procedure EdPort_codigoValidate(Sender: TObject);
    procedure bgeranfeClick(Sender: TObject);
    procedure bMoveLeftClick(Sender: TObject);
    procedure bMoveRightClick(Sender: TObject);
    procedure bLoadGridClick(Sender: TObject);
    procedure bSaveGridClick(Sender: TObject);
    procedure bgeraboletoClick(Sender: TObject);
    procedure PMensDblClick(Sender: TObject);
    procedure EdTran_codigoExitEdit(Sender: TObject);
    procedure bcupomClick(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure ACBrBAL1LePeso(Peso: Double; Resposta: String);
    procedure bregistro71Click(Sender: TObject);
    procedure binsere71Click(Sender: TObject);
    procedure bexclui71Click(Sender: TObject);
    procedure EdDtemissao71Validate(Sender: TObject);
    procedure EdValordoc71ExitEdit(Sender: TObject);
    procedure EdCodentidade71Validate(Sender: TObject);
    procedure bbaixaClick(Sender: TObject);
    procedure EdMoes_cola_codigoExitEdit(Sender: TObject);
    procedure EdCida_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bajudaClick(Sender: TObject);
    procedure bmensagemClick(Sender: TObject);
    procedure EdMens4ExitEdit(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdCodEquiChange(Sender: TObject);
    procedure EdManutencaoKeyPress(Sender: TObject; var Key: Char);
    procedure EdManutencaoExitEdit(Sender: TObject);
    procedure bgeracteClick(Sender: TObject);
    procedure EdRepr_codigoExitEdit(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure bafaturarClick(Sender: TObject);
    procedure EdFpgt_codigoExitEditSGr(Sender: TObject);
    procedure EdvlroutrasdespesasValidate(Sender: TObject);
    procedure bvendidosClick(Sender: TObject);
    procedure EdCodentidade71KeyPress(Sender: TObject; var Key: Char);
    procedure EdDtMovimentoExitEdit(Sender: TObject);
    procedure EdMensagemValidate(Sender: TObject);
    procedure EdFreteValidate(Sender: TObject);
    procedure sbfecharClick(Sender: TObject);
    procedure EdvlrissExitEdit(Sender: TObject);
    procedure EdPort_codigoExitEdit(Sender: TObject);
    procedure bimpcprClick(Sender: TObject);
    procedure EdaliicmsnfExitEdit(Sender: TObject);
    procedure EdNatf_codigopValidate(Sender: TObject);
    procedure EdSeto_codigoValidate(Sender: TObject);
    procedure EdSeto_codigoExitEdit(Sender: TObject);
    procedure EdTran_codigoValidate(Sender: TObject);
    procedure EdCfopitemExitEdit(Sender: TObject);
    procedure bimportanfClick(Sender: TObject);
  private
    { Private declarations }
    procedure LimpaEditsItens;
    procedure Editstogrid;
    function PortadorCarteira:boolean;
  public
    { Public declarations }
    procedure Execute(Acao:string;Imp:string='N';CodMovimento:integer=0;Pedido:integer=0;CodigoCliente:integer=0;
              Fpgt_codigo:string='';Tran_codigo:string='';Port_codigo:string='';xTotalPedido:currency=0;
              cola_codigo:string='' ; carga:integer=0 ; ctrans:string='');
    procedure ReservaEstoque(Codigo,IncExc:string;Qtde:currency);
    procedure SetaEditsValores(mudouvaloritem:boolean=false);
    procedure RetornaReserva;
    procedure Campostoedits(Q:TSqlquery);
    procedure Campostogrid(Q:TSqlquery;ZeraIcms:string='N');
    procedure CancelaTransacao(Transacao:string);
    procedure AtivaEditsParcelas(n:integer=0);
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
    function TratamentotoCor(xcorid:string):string;
    procedure AdicionaListaServicos(Q:TSqlquery);
    function Servico(produto: string): boolean;
    procedure SetaItensProdutosAcabados(Ed:TSqled ; OP:string );
    function ConstaListaProdutosAcabados(Lista:TStrings;codigo:string):boolean;
    procedure  ConfigEnableEdits( Painel:Tobject ; ativado:boolean );
    procedure Mostra(xPainel:TSqlPanelGrid ; desc:string);
    procedure Esconde(xPainel:TSqlPanelGrid);
// 26.02.12
    procedure Grava71(xtransacao:string);
// 16.03.15
    procedure GetListaNfe( TLista:TStringList ; xES:string);
// 01.06.18
    procedure Setacondicoespag(Ed : TSqled );
// 09.02.2023
    function ValidapeloNcm:boolean;

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

type TServicos=record
     produto:string;
     qtde,unitario,periss:currency;
end;

const xCodProdutoGeral:string =  'PROD' ;

var
  FNotaSaida: TFNotaSaida;
  QBusca,QEstoque,QGrade,QPed:TSqlquery;
  Op,Transacao,Acao,Ecf,traco,CodigoIMp,Moes_remessas,StatusNota,CfopExporta,cstexporta,campoufentidade,revenda,
  TiposFornec,produtosnota,NotaTipocad,localexterno,TipoSaidaAbate,ObsPedido,
  nrobra,transacaobusca,TiposDevolucao,VendaMovel,NFCe,ctransacaodevolucao,usouxml,xcola_codigo:string;
  ListaReservacodigo,ListaReservaQtde:TStringList;
  Acumulado,totalbruto,icmsexporta,vlrfunrural,vlrcotacapital,TotalPedido:currency;
  Tamimp,moes_clie_codigo,usua_codigo,GrupoPerfil,Subgrupoperfil,Familiaperfil,xcodigocliente,xcarga,
  notadevolucao:integer;
  codigobarra:boolean;
  PReq:^TRequisicao;
  PServicos:^TServicos;
  ListaReq,ListaOrcam,ListaOrcamRes,ListaServicos:Tlist;
  campo,campoclifpgt,
  campoicmsst  :TDicionario;
  TItensNfe    :TAcbrNfe;
  DataNotaDevolucao:TDatetime;

// 06.09.12
const
  arquivo:string='ListaFsc.txt';

implementation

uses Arquiv, Sqlfun, Estoque, conpagto, codigosfis, tabela,
  Sittribu, impressao, Natureza, Transp, portador, cadcor, tamanhos,
  cadcopa, Usuarios, Unidades, boletos, munic, tabcomissao, represen,
  relfinan, Mensnf, expnfetxt,
 // ecfteste1, gerenciaecf,
  BaixaPen, cadcli,rateio,
  Subgrupos, pcnNFe, mostravalorafaturar, RelGerenciais, expcte, gerencianfe;

{$R *.dfm}

{ TFNotaSaida }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TFNotaSaida.Execute(Acao:string;Imp:string='N';CodMovimento:integer=0;Pedido:integer=0;CodigoCliente:integer=0;
          Fpgt_codigo:string='';Tran_codigo:string='';Port_codigo:string=''; xTotalPedido:currency=0 ; cola_codigo:string='';
          carga:integer=0;ctrans:string='');
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// ///////////////////////////////////////////////////////////////////////
var operacao:string;
    QT:TSqlquery;
    xData:TDatetime;
//    Coluna:TColumn;
begin

  xcola_codigo:=cola_codigo;
  xcarga:=carga;
  usouxml:='N';
  global.UltimoFormAberto:=FNotaSaida.Name;
  Op:=Acao;
  CfopExporta:='7';
  icmsexporta:=0;
//  cstexporta:='040';
// 07.04.11 - Sefa com XML 2.0 so aceita 041
  cstexporta:='041';
  TipoSaidaAbate:='SA';
  Ecf:=Imp;
  EdBaseicms.clearall(FNotaSaida,99);
  Edvlrir.ClearAll(FNotasaida,99);
  PRetencoes.Visible:=false;
  PRetencoes.Enabled:=false;
// 01.04.09
  ObsPedido:='';
// 27.04.09
//   nrobra:='VIMS-';
   nrobra:='';
// 12.02.07 - pra ficar no eof quando entra na nota
  Qped:=sqltoquery( FGeral.Buscapedvenda(99999999) );
// 28.08.08
//  if FindWindow(PClasse,PJAnela) <> 0 then
//  if FindWindow( PAnsiChar('TPropertyInspector'),Pansichar('Object Inspector') ) =0 then
//     FNotasaida.FormStyle:=fsStayontop
//  else
// 11.03.10
  vlrfunrural:=0;vlrcotacapital:=0;

/////////////////////  FGeral.EstiloForm(FNotaSaida);

  FGeral.ConfiguraTamanhoEditsEnabled(FNotaSaida,FGeral.GetConfig1AsInteger('tamanholetra'));
// 24.02.11
//  FGeral.ConfiguraColorEditsNaoEnabled(FNotaSaida);
// 25.02.11 - colocado botoes pra configurar o grid...quase igual aos cadastros
  PBotoesGrid.Enabled:=Global.Usuario.OutrosAcessos[0325];
  PBotoesGrid.Visible:=Global.Usuario.OutrosAcessos[0325];
///////////
  if ListaReservaCodigo=nil then
    ListaReservaCodigo:=TStringlist.Create;
  if ListaReservaQTde=nil then
    ListaReservaQTde:=TStringlist.Create;
  if ListaServicos=nil then
    ListaServicos:=TList.create;
// 10.06.13
  bajuda.Visible:=Global.Topicos[1036];
  bajuda.Enabled:=Global.Topicos[1036];
// 30.07.19
  EdSeto_codigo.enabled:=Global.Topicos[1365];

//////////
  if OP<>'H' then
    Show;

// 22.04.09
  EdTransacao.Visible:=Global.Usuario.OutrosAcessos[0317];
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
// 01.10.12 - vindo da pesagem....
  TotalPedido:=xTotalPedido;
  if OP='A' then
    operacao:='Altera��o'
  else if op ='S' then
    operacao:='Reaproveitamento Numera��o'
  else if op ='G' then
    operacao:='Nota a partir da Pesagem de Saida'
  else
    operacao:='Inclus�o';

  FNotaSaida.Caption:='Nota Fiscal de Saida - '+operacao;
  ListaReservaCodigo:=TStringlist.Create;
  ListaReservaQTde:=TStringlist.Create;
  EdUnid_codigo.Text:=Global.CodigoUnidade;
  EdDtEmissao.SetDate(Sistema.hoje);
  EdDtSaida.SetDate(Sistema.hoje);
// 19.03.2021 - A2z
  EdMensagem.Text:='';

// 18.01.12 - para nao ficar errado a numeracao de nota
  EdDtMovimento.SetDate(Sistema.hoje);
  tamimp:=40;
  CodigoImp:='00013';  // ver onde colocar o codigo da impressora ecf
                       // 12.07.11 - ver se realmente ser� usado
  traco:=replicate('-',tamimp);
  EdNumerodoc.enabled:=Global.Topicos[1301];
//  EdDtemissao.enabled:=false;
  moes_remessas:='';
  moes_clie_codigo:=0;
  usua_codigo:=0;
  StatusNota:='N';
  Sistema.setmessage('');
  bcontrato.Visible:=Global.Usuario.ObjetosAcessados[1077];   // 18.09.08
  Edpercomissao.enabled:=Global.Topicos[1324];
  Edpercomissao2.enabled:=Global.Topicos[1324];
// 09.11.11
  bcupom.Enabled:=Global.Topicos[1021];
// aqui em 20.09.11
/////////////////////////////////
// 13.06.08
  if (CodMovimento>0) and (OP<>'H') then begin
    EdComv_codigo.setvalue(CodMovimento);
//    EdComv_codigo.validfind;
    EdComv_codigo.valid;
// 03.08.11
//    EdComv_codigo.Next;
  end;
////////////////////////////////
// 12.11.12
  EdMoes_tabp_codigo.Visible:=Global.Topicos[1357];
  EdMoes_tabp_codigo.Enabled:=Global.Topicos[1357];
//  SetEdTABP_ALIQUOTA.Visible:=Global.Topicos[1357];
// aqui em 12.08.2022
// 03.12.08
  TiposFornec:=Global.CodRemessaconserto+';'+Global.CodRemessaDemo+';'+Global.CodDevolucaoSaida+';'+
               Global.CodRemessaInd+';'+Global.CodVendaFornecedor+';'+Global.CodDevolucaoSimbolicaConsig+';'+
               Global.CodDevolucaoTributada;

  if OP='I' then begin

    EdComv_codigo.clear;
    EdComv_codigo.setfocus;
// 17.02.10 - novicarnes - saida de abate - 'pedido'
    EdTran_codigo.text:=Tran_codigo;
    EdFpgt_codigo.text:=Fpgt_codigo;
    EdTran_codigo.ValidFind;
    EdFpgt_codigo.ValidFind;
// 23.02.12
    DateTimePicker1.DateTime:=Sistema.hoje;
// 06.03.12
    EdProduto.enabled:=false;
    Edvlroutrasdespesas.text:='';
// 13.09.18 - recolocado - Giacomoni
    EdNatf_codigo.Enabled:=(not Global.Topicos[1457]);
// 03.08.11
  end else if pos(op,'G;H')>0 then begin

    ConfigEnableEdits( PRemessa , false );
    EdEmides.text:='1';
    EdPort_codigo.ClearAll(FNotaSaida,99);
    bincluiritem.Enabled:=false;
    bExcluiritem.Enabled:=false;
    if op='H' then begin

      EdComv_codigo.setvalue(CodMovimento);
//      EdComv_codigo.valid;
      EdComv_codigo.validfind;
      if CodigoCliente>0 then begin
        EdCliente.setvalue(CodigoCliente);
        EdCliente.validfind;
        EdRepr_codigo.text:=EdCliente.resultfind.fieldbyname('clie_repr_codigo').asstring;
        EdRepr_codigo.validfind;
      end;
      if Pedido>0 then begin
        EdPedido.setvalue(Pedido);
        EdPedido.valid;
      end;

    end;
    EdFpgt_codigo.text:=Fpgt_codigo;
    EdFpgt_codigo.ValidFind;
    EdPort_codigo.text:=Port_codigo;
    EdPOrt_codigo.ValidFind;
//    EdPOrt_codigo.Valid;

    if op='G' then begin

      EdTran_codigo.enabled:=true;
// 28.04.20
      EdTran_codigo.text:=Tran_codigo;
      EdTran_codigo.validfind;
      EdTran_codigo.setfocus;

    end else begin

      EdTran_codigo.enabled:=false;
      EdTran_codigo.text:=Tran_codigo;
      EdTran_codigo.validfind;
      EdTran_codigo.OnExitEdit(self);

    end;

  end else begin

    EdNumerodoc.enabled:=true;
    EdDtemissao.enabled:=true;
    if OP='A' then begin
//      EdNumerodoc.setfocus
//      EdDtemissao.setfocus
// 28.06.05
//      EdComv_codigo.setfocus
//////////////////// - 05.06.09
      transacaobusca:=ctrans;
      Input('Informe a transa��o a ser alterada ','Transa��o ',transacaobusca,12,true);
      if trim(transacaobusca)<>'' then begin

          QT:=sqltoquery('select * from movesto where moes_transacao='+stringtosql(transacaobusca)+
// 11.02.13 - alteracao de conhecimento de saida - NT
              ' and '+FGeral.GetNOTIN('moes_status','C;M','C')+
// 09.05.11 - alteracao de VC...Janina
              ' and '+FGeral.GetNOTIN('moes_tipomov',Global.CodRemessaConsig+';'+Global.CodDevolucaoConsig+';'+
              Global.CodRemessaProntaEntrega+';'+Global.CodDevolucaoTroca+';'+Global.CodDevolucaoProntaEntrega,'C')+
              ' order by moes_operacao');
          if not Qt.eof then begin

            EdComv_codigo.Text:=Qt.fieldbyname('moes_comv_codigo').asstring;
            EdComv_codigo.valid;
            EdCliente.setvalue(Qt.fieldbyname('moes_tipo_codigo').asinteger);
// 12.08.2022
            if TiposFornecedor(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring) then begin
              FGeral.SetaEdEntidade(EdCliente,'F');
              campoufentidade:='forn_uf';
              EdCliente.title:='Fornec.';
              EdCliente.update;
              NotaTipocad:='F';  // q poder� ser somente C ou F
            end else begin
              FGeral.SetaEdEntidade(Edcliente,'C');
              campoufentidade:='clie_uf';
            end;

// 12.08.2022 - para n�o dar cliente n�o encontrado quando � fornec como em RS e outras...
            if campoufentidade='clie_uf' then

               EdCliente.Valid;

            EdUnid_codigo.text:=Qt.fieldbyname('moes_unid_codigo').asstring;
            EdUnid_codigo.validfind;
            EdTran_codigo.text:=strzero( strtoint(Qt.fieldbyname('moes_tran_codigo').asstring),3);
            EdTran_codigo.validfind;
            EdNatf_codigo.text:=Qt.fieldbyname('moes_natf_codigo').asstring;
            EdNatf_codigo.validfind;
            EdDtemissao.SetDate(Qt.fieldbyname('moes_dataemissao').asdatetime);
            EdDtemissao.validfind;
            EdNumerodoc.setvalue(Qt.fieldbyname('moes_numerodoc').asinteger);

//            EdNumerodoc.SetFocus;
//12.07.12 - Novicarnes = Clevis
            EdNumerodoc.Next;

          end else begin

            Avisoerro('Transa��o n�o encontrada ou cancelada');  // 03.10.08
            EdComv_codigo.ClearAll(FNotaSaida,99);
            Close;  // 24.04.13

          end;
          FGeral.FechaQuery(Qt);

      end else
          EdComv_codigo.setfocus;

///////////////////
    end else
      EdComv_codigo.setfocus;
  end;

// 13.09.18
  FGeral.ConfiguraColorEditsNaoEnabled(FNotaSaida);

////////////////////////////////////////////////////
  EdPecas.Enabled:=Global.Topicos[1302];
// 13.08.07
//  EdMoes_tabp_codigo.Enabled:=Global.Usuario.OutrosAcessos[0306];
  EdFrete.Enabled:=Global.Usuario.OutrosAcessos[0307];
  EdSeguro.Enabled:=Global.Usuario.OutrosAcessos[0308];
  EdPedido.Enabled:=Global.Usuario.OutrosAcessos[0309];

// 12.11.07
  EdCodcor.Enabled:=Global.Topicos[1309];
  EdCodTamanho.Enabled:=Global.Topicos[1309];
// 24.02.11
  EdCodcor.Visible:=Global.Topicos[1309];
  EdCodTamanho.Visible:=Global.Topicos[1309];
  SetEdcor.Visible:=Global.Topicos[1309];
  SetEdTamanho.Visible:=Global.Topicos[1309];
  if Global.Topicos[1309] then begin
    SetEdESTO_DESCRICAO.Width:=127;
  end else begin
    SetEdESTO_DESCRICAO.Width:=250;
  end;
// 12.12.07 - depois mudar td para usar o campo da conf. de movimento
  NotaTipocad:='C';
// 02.01.08
  EdPortoorigem.Enabled:=Global.Topicos[1312];
  EdPortodestino.Enabled:=Global.Topicos[1312];
  Edcontainer.Enabled:=Global.Topicos[1312];
// 24.03.11
  EdEstadoEX.Enabled:=Global.Topicos[1312];
  SetaPortosEmbarque(EdPortoorigem);
  if not EdPecas.enabled then
    EdPecas.setvalue(0);
// 07.03.08
  EdFreteuni.Enabled:=Global.Topicos[1313];
// 27.05.08
  blebalanca1.Enabled:=Global.Topicos[1317];
  blebalanca2.Enabled:=Global.Topicos[1317];

  if FGeral.GetConfig1AsString('PORTASERIALNF')<>'' then begin

   // configura porta de comunica��o - ver config. para modelo balan�a e handshake
   if acbrBal1.Ativo then  ACBrBAL1.Desativar;
   ACBrBAL1.Modelo           := TACBrBALModelo( balToledo );
//   ACBrBAL1.Device.HandShake := TACBrHandShake( cmbHandShaking.ItemIndex );
//   none odd even mark space
   if FGeral.GetConfig1AsString('saiparidade1')='P' then
     ACBrBAL1.Device.Parity    := TACBrSerialParity( podd )
   else if FGeral.GetConfig1AsString('saiparidade1')='I' then
     ACBrBAL1.Device.Parity    := TACBrSerialParity( peven )
   else
     ACBrBAL1.Device.Parity    := TACBrSerialParity( pnone );
// s1  s1,5   s2
   if FGeral.GetConfig1AsString('saistopbitsbal1')='10' then
     ACBrBAL1.Device.Stop      := TACBrSerialStop( s1 )
   else if FGeral.GetConfig1AsString('saistopbitsbal1')='15' then
     ACBrBAL1.Device.Stop      := TACBrSerialStop( s1eMeio )
   else
     ACBrBAL1.Device.Stop      := TACBrSerialStop( s2 );
   ACBrBAL1.Device.Data      := StrToIntdef( FGeral.GetConfig1AsString('saidatabitsbal1'),8 );
   ACBrBAL1.Device.Baud      := StrToIntdef(  FGeral.GetConfig1AsString('saivelocbal1'),2400 );
   ACBrBAL1.Device.Porta     := FGeral.GetConfig1AsString('PORTASERIALNF');

  end;
// 04.06.08
  if Pedido>0 then begin
    EdPedido.setvalue(Pedido);
    if pos(op,'G')>0 then
      EdPedido.valid;
  end;
// 03.12.12 - Pesagem -> NFe
  xcodigocliente:=codigocliente;
  if CodigoCliente>0 then begin

    EdCliente.setvalue(CodigoCliente);
    EdCliente.validfind;
    EdRepr_codigo.text:=EdCliente.resultfind.fieldbyname('clie_repr_codigo').asstring;
    EdRepr_codigo.validfind;
// 27.09.17
    EdPerDesco.setvalue( 0 );
    campo:=Sistema.GetDicionario('clientes','clie_Descontovenda');
    if campo.Tipo<>'' then
       EdPerdesco.SetValue( EdCliente.resultfind.fieldbyname('clie_descontovenda').ascurrency );
// 26.02.19 - Novicarnes
    campo:=Sistema.GetDicionario('clientes','clie_Acrescimovenda');
    if campo.Tipo<>'' then
       EdPeracre.SetValue( EdCliente.resultfind.fieldbyname('clie_acrescimovenda').ascurrency );

    if EdPeracre.AsCurrency>0 then
      SetaEditsValores;
    if EdPerdesco.AsCurrency>0 then
      SetaEditsValores;

////////
  end;
// 03.08.11
  if pos(op,'G;H')>0 then begin
    EdUnid_codigo.Valid;

  end;
//////////////////////
// 08.07.19
  campoicmsst:=Sistema.GetDicionario('codigosfis','Cfis_AliqST');

// 23.12.08
  EdCertificado.enabled:=Global.Topicos[1326];
  EdTotalservicos.Clear;
  ListaServicos:=TList.create;
  FGeral.SetaUFs(EdEstadoex);
// 02.07.10 - Abra - para nao ficar da nota anterior caso nao gravar, sair e entrar
  GridParcelas.Clear;
  Grid71.Clear;
// 03.12.12
  if op='I' then Grid.Clear;
// 07.07.11
  TiposDevolucao:=Global.CodDevolucaoCompra+';'+Global.CodDevolucaoCompraSemEstoque+';'+
                  Global.CodDevolucaoIgualVenda+';'+Global.CodDevolucaoInd+';'+
                  Global.CodDevolucaoSimbolicaConsig+';'+
                  Global.CodDevolucaodeRemessa+';'+
                  Global.CodDevolucaoRoman+';'+
                  Global.CodDevolucaoTributada+';'+
                  Global.CodDevolucaoTributadaCliente+';'+
// 06.05.19 - Clessi usava RG dai sugeri DJ
                  Global.CodDevolucaoSaida;
// 18.11.11
  campoclifpgt:=Sistema.GetDicionario('clientes','clie_fpgt_codigo');
// 10.01.12
  Esconde(PDescricaoProduto);
// 06.09.12 - Clessi
  if FileExists( arquivo ) then EdCertificado.Items.LoadFromFile( arquivo );
// 19.07.13 - aqui para nao 'ajudar a dar problema no envio da nfe
//  if AcbrIbptax1.Itens.Count=0 then FGeral.ArmazenaTabelaIBPT(AcbrIbptax1);
// 06.02.14
  EdCodEqui.Visible:=Global.Topicos[1367];
  EdCodEqui.Enabled:=Global.Topicos[1367];
  EdCodEqui.clear;
  xData:=Sistema.Hoje-180;
// 10.12.14 - Casa Nova - Cuiaba
  if Global.Topicos[1380] then begin
    EdPort_Descricao.Width:=050;
    EdNomeObra.Enabled:=true;
    EdNomeObra.Visible:=true;
    EdNOmeObra.Items.Clear;
    QT:=sqltoquery('select moes_nroobra from movesto where moes_datamvto>='+Datetosql(xData)+
                   ' and '+FGeral.GetIN('moes_tipomov',Global.TiposSaida,'C')+
                   ' order by moes_nroobra');
    while not Qt.eof do begin
      if (Qt.fieldbyname('moes_nroobra').asstring<>'') then
        if EdNomeobra.Items.IndexOf(Qt.fieldbyname('moes_nroobra').asstring)=-1 then
          EdNOmeObra.Items.Add(Qt.fieldbyname('moes_nroobra').asstring);
      Qt.Next;
    end;
    FGeral.fechaquery(QT);
  end else begin
    EdPort_Descricao.Width:=153;
    EdNomeObra.Enabled:=false;
    EdNomeObra.Visible:=false;
  end;
// 01.06.18 - Giacomoni - Barbar�
  if Global.Topicos[1115] then begin
     EdFpgt_codigo.FindTable:='';
     EdFpgt_codigo.ShowForm:='';
  end else begin
     EdFpgt_codigo.FindTable:='fpgto';
     EdFpgt_codigo.ShowForm:='FCondpagto';
  end;
// 17.08.18 -  Siccare - Wando
  if Global.Topicos[1455] then begin
     EdNatf_codigop.visible:=true;
     EdNatf_codigop.enabled:=true;
  end else begin
     EdNatf_codigop.visible:=false;
     EdNatf_codigop.enabled:=false;
  end;
// 18.04.19 - Giacomoni - Barbar�  - cliente com 'sistema exigindo'...
  if Global.Topicos[1459] then begin
     EdPedidoCompra.visible:=true;
     EdPedidoCompra.enabled:=true;
  end else begin
     EdPedidoCompra.visible:=false;
     EdPedidoCompra.enabled:=false;
  end;
// 26.08.19 - tonet - com. de areia
  if Global.Topicos[1463] then EdQtde.Decimals:=4 else EdQtde.Decimals:=3;
// 11.02.20  - Alutech - Fran - faturamento 'anual'
  if Global.Topicos[1468] then begin

     EdVencimento.MaxLength:=10;
     EdVencimento.TypeValue := TTypeValue.tvDateLng  ;

  end;

// 04.12.20
//  bimportanf.Visible:=(global.usuario.codigo=100);
//  bimportanf.Enabled:=(global.usuario.codigo=100);

end;

procedure TFNotaSaida.FormActivate(Sender: TObject);
/////////////////////////////////////////////////////////
//var operacao:string;
begin
{
  if ListaReservaCodigo=nil then
    ListaReservaCodigo:=TStringlist.Create;
  if ListaReservaQTde=nil then
    ListaReservaQTde:=TStringlist.Create;
  if ListaServicos=nil then
    ListaServicos:=TList.create;
// 10.06.13
  bajuda.Visible:=Global.Topicos[1036];
  bajuda.Enabled:=Global.Topicos[1036];
   }

end;

////////////////////////////////////
procedure TFNotaSaida.EditstoGrid;
////////////////////////////////////
var x:integer;
    aqtde,reducaobase:currency;
    cstcfop,xtipocad,
    codfiscal        :string;
    codsittrib       :integer;
begin
// 25.03.11
  if campoufentidade='clie_uf' then
    xtipocad:='C'
  else
    xtipocad:='F';
/////////////////
// 22.04.19 - para vida nova pode usar um mesmo codigo mais de uma vez...
  if Global.Topicos[1460] then
     x:=0
  else

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
// 24.04.13 - Abra Cuiaba
    Grid.Cells[Grid.getcolumn('esto_referencia'),Abs(x)]:=Arq.TEstoque.fieldbyname('esto_referencia').asstring;

    Grid.Cells[Grid.getcolumn('esto_descricao'),Abs(x)]:=SetEdEsto_descricao.text;
// 13.09.10
    codsittrib:=FEstoque.GetCodigosituacaotributaria(EdProduto.text,EdUnid_codigo.text,
                  EdCliente.resultfind.fieldbyname(campoufentidade).asstring,
                  'N',0,Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring);
// 18.08.2021
    codfiscal := FEstoque.GetCodigoFiscal(EdProduto.text,EdUnid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,'N',Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring);

    if Nfexporta(EdNatf_codigo.text) then begin

      Grid.Cells[Grid.getcolumn('move_cst'),Abs(x)]:=cstexporta;
      Grid.Cells[Grid.getcolumn('move_aliicms'),Abs(x)]:=currtostr(icmsexporta);
      Grid.Cells[Grid.getcolumn('move_aliipi'),Abs(x)]:='0';
      cstcfop:=cstexporta;

    end else begin

      cstcfop:=FEstoque.Getsituacaotributaria(EdProduto.text,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,
                            Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,EdCliente.asinteger,
                            revenda,EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring);
      Grid.Cells[Grid.getcolumn('move_cst'),Abs(x)]:=cstcfop;
// 15.02.10
      if Servico(EdProduto.text) then
        Grid.Cells[Grid.getcolumn('perciss'),Abs(x)]:=currtostr(FEstoque.GetaliquotaIss(EdProduto.text,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring) )
      else
        Grid.Cells[Grid.getcolumn('move_aliicms'),Abs(x)]:=currtostr(FEstoque.Getaliquotaicms(EdProduto.text,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,EdCliente.asinteger,
                            Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,revenda,xtipocad) );
///// 07.10.11 - Novicarnes cfops 5913 e 6913 - devolucao igual a nota 'que veio'
      if pos(EdNatf_codigo.text,'5913/6913') > 0 then
         reducaobase:=FCodigosFiscais.GetAliquotaRedBase( QEstoque.fieldbyname('esqt_cfis_codigoest').asstring,revenda,EdProduto.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring )
      else begin
// 24.05.07 - alterado em 10.02.09  - Asatec - 20.04.16 - retirado Primos - recolocado em 27.05.16
// 29.06.16 - Primos -
// 04.11.2022 - mudado para buscar no subgrupo quando for devolucao de compra - colocado R como se fosse
//              revenda para a funcao getaliquotaredbase pegar do subgrupo o codigo fiscal
        if  AnsiPos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoCompra+';'+Global.CodDevolucaoTributada+';'+Global.CodDevolucaoIgualVenda)>0 then

            reducaobase:=FCodigosFiscais.GetAliquotaRedBase( QEstoque.fieldbyname('esqt_cfis_codigoforaest').asstring,'R',EdProduto.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring )

        else if ( EdUNid_codigo.resultfind.FieldByName('unid_uf').asstring=EdCliente.resultfind.fieldbyname(campoufentidade).asstring)   then
            reducaobase:=FCodigosFiscais.GetAliquotaRedBase( QEstoque.fieldbyname('esqt_cfis_codigoest').asstring,revenda,EdProduto.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring )
//        else if  ( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoCompra  ) then
//            reducaobase:=FCodigosFiscais.GetAliquotaRedBase( QEstoque.fieldbyname('esqt_cfis_codigoforaest').asstring,revenda,EdProduto.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring )
        else
            reducaobase:=0;
      end;
// 22.03.10
      if pos( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.TiposNaoCalcIcms ) > 0 then
        reducaobase:=0;
// 21.03.07
      if DevolucaoCompra( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring)  then

        Grid.Cells[Grid.getcolumn('move_aliipi'),abs(x)]:=currtostr(FEstoque.Getaliquotaipi(EdProduto.text,'S',EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring))

      else begin
        if campoufentidade='forn_uf' then  // 27.09.07
           Grid.Cells[Grid.getcolumn('move_aliipi'),abs(x)]:=currtostr(FEstoque.Getaliquotaipi(EdProduto.text,'S',EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring))
        else
           Grid.Cells[Grid.getcolumn('move_aliipi'),abs(x)]:=currtostr(FEstoque.Getaliquotaipi(EdProduto.text,EdCliente.resultfind.fieldbyname('clie_ipi').asstring,EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring));
      end;

    end;

// 31.07.14 - Novicarnes - Angela
//    Grid.Cells[Grid.getcolumn('esto_unidade'),Abs(x)]:=Arq.TEstoque.fieldbyname('esto_unidade').asstring;
    Grid.Cells[Grid.getcolumn('esto_unidade'),Abs(x)]:=FEstoque.GetUnidade(EdProduto.text);

//    Grid.Cells[Grid.getcolumn('move_qtde'),Abs(x)]:=EdQTde.AsSql;
// 26.08.19
    Grid.Cells[Grid.getcolumn('move_qtde'),Abs(x)]:=FGeral.Formatavalor( EdQTde.AsFloat,f_cr4 );
//    Grid.Cells[Grid.getcolumn('move_venda'),Abs(x)]:=EdUnitario.AsSql;
// 23.01.20 - Novicarnes - venda de ra��o
    Grid.Cells[Grid.getcolumn('move_venda'),Abs(x)]:=TRansform(EdUnitario.AsFloat,f_cr5);

//    Grid.Cells[Grid.getcolumn('total'),Abs(x)]:=TRansform(EdQTde.AsFloat*EdUnitario.AsCurrency,f_cr);
// 07.07.16 - devolucao de compra de produtor - novi
    Grid.Cells[Grid.getcolumn('total'),Abs(x)]:=TRansform(EdQTde.AsFloat*EdUnitario.AsFloat,f_cr);
    Grid.Cells[Grid.getcolumn('move_perdesco'),Abs(x)]:=EdPerdesconto.AsSql;
    Grid.Cells[Grid.getcolumn('move_vendabru'),Abs(x)]:=TRansform(QEstoque.fieldbyname('esqt_vendavis').AsCurrency,f_cr);
// 16.08.06
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
    Grid.Cells[Grid.Getcolumn('move_vendamin'),Abs(x)]:=TRansform(QEstoque.fieldbyname('esqt_vendamin').AsCurrency,f_cr);
// 23.12.08
    Grid.Cells[Grid.Getcolumn('move_certificado'),Abs(x)]:=EdCertificado.text;
// 13.07.09
    Grid.Cells[Grid.Getcolumn('move_core_codigoind'),Abs(x)]:=EdCorIndust.text;
// 17.08.18 - Siccare - Vando
   if Global.Topicos[1455] then
      Grid.Cells[Grid.Getcolumn('move_natf_codigo'),Abs(x)]:=EdNatf_codigop.Text
   else
// 08.09.10
      Grid.Cells[Grid.Getcolumn('move_natf_codigo'),Abs(x)]:=FSittributaria.GetCfop(codsittrib,EdNatf_codigo.text,EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring);

// 08.07.19  - Vini Rotta
    if campoicmsst.Tipo<>'' then begin

      if ( EdUNid_codigo.resultfind.FieldByName('unid_uf').asstring=EdCliente.resultfind.fieldbyname(campoufentidade).asstring)   then
//         Grid.Cells[Grid.Getcolumn('aliicmsst'),Abs(x)]:=currtostr( FCodigosFiscais.GetPercIcmsSubs(QEstoque.fieldbyname('esqt_cfis_codigoest').asstring))
// 18.06.2021
         Grid.Cells[Grid.Getcolumn('aliicmsst'),Abs(x)]:=currtostr( FCodigosFiscais.GetPercIcmsSubs(codfiscal))
      else
//         Grid.Cells[Grid.Getcolumn('aliicmsst'),Abs(x)]:=currtostr( FCodigosFiscais.getpercicmssubs(QEstoque.fieldbyname('esqt_cfis_codigoforaest').asstring));
// 18.06.2021
         Grid.Cells[Grid.Getcolumn('aliicmsst'),Abs(x)]:=currtostr( FCodigosFiscais.getpercicmssubs(codfiscal));

    end;
// 08.08.19
    if Global.Topicos[1367]  then begin

       Grid.Cells[Grid.GetColumn('move_equi_codigo'),Abs(x)]:=Arq.TEstoque.FieldByName('esto_equi_codigo').asstring;
       EdCodEqui.Text :=Arq.TEstoque.FieldByName('esto_equi_codigo').asstring;

    end;
//05.09.19
//    Grid.Cells[Grid.GetColumn('codsitrib'),Abs(x)]:=Arq.TSittributaria.FieldByName('sitt_codigo').AsString;
// 31.03.20   - guiber - nf com St mas sem icms
    Grid.Cells[Grid.GetColumn('codsitrib'),Abs(x)]:=inttostr(codsittrib);

  end else begin

    Grid.Cells[Grid.getcolumn('move_esto_codigo'),x]:=EdProduto.Text;
// 24.04.13 - Abra Cuiaba
    Grid.Cells[Grid.getcolumn('esto_referencia'),Abs(x)]:=Arq.TEstoque.fieldbyname('esto_referencia').asstring;
    Grid.Cells[Grid.getcolumn('esto_descricao'),x]:=SetEdEsto_descricao.text;
// 13.09.10
    codsittrib:=FEstoque.GetCodigosituacaotributaria(EdProduto.text,EdUnid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring);
    if Nfexporta(EdNatf_codigo.text) then begin
      Grid.Cells[Grid.getcolumn('move_cst'),x]:=cstexporta;
      Grid.Cells[Grid.getcolumn('move_aliicms'),x]:=currtostr(icmsexporta);
      Grid.Cells[Grid.getcolumn('move_aliipi'),x]:='0';
      cstcfop:=cstexporta;

    end else begin

      cstcfop:=FEstoque.Getsituacaotributaria(EdProduto.text,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,
                            Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,EdCliente.asinteger,
                            revenda,EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring);
      Grid.Cells[Grid.getcolumn('move_cst'),Abs(x)]:=cstcfop;

//      Grid.Cells[Grid.getcolumn('move_cst'),x]:=FEstoque.Getsituacaotributaria(EdProduto.text,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,
//                            Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,0,revenda);
// 15.02.10
      if Servico(EdProduto.text) then
         Grid.Cells[Grid.getcolumn('perciss'),x]:=currtostr(FEstoque.GetaliquotaIss(EdProduto.text,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring) )
      else
        Grid.Cells[Grid.getcolumn('move_aliicms'),x]:=currtostr(FEstoque.Getaliquotaicms(EdProduto.text,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,EdCliente.asinteger,
                            Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,revenda) );
// 21.03.07
     if DevolucaoCompra( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring)  then
       Grid.Cells[Grid.getcolumn('move_aliipi'),x]:=currtostr(FEstoque.Getaliquotaipi(EdProduto.text,'S',EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring))
     else begin
       if campoufentidade='forn_uf' then  // 30.04.09
         Grid.Cells[Grid.getcolumn('move_aliipi'),abs(x)]:=currtostr(FEstoque.Getaliquotaipi(EdProduto.text,'S',EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring))
       else
         Grid.Cells[Grid.getcolumn('move_aliipi'),abs(x)]:=currtostr(FEstoque.Getaliquotaipi(EdProduto.text,EdCliente.resultfind.fieldbyname('clie_ipi').asstring,EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring));
     end;
    end;
// 07.10.11 - Novicarnes cfops 5913 e 6913 - devolucao igual a nota 'que veio'
      if pos(EdNatf_codigo.text,'5913/6913') > 0 then
         reducaobase:=FCodigosFiscais.GetAliquotaRedBase( QEstoque.fieldbyname('esqt_cfis_codigoest').asstring,revenda,EdProduto.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring )
      else begin
// 24.05.07
        if EdUNid_codigo.resultfind.FieldByName('unid_uf').asstring=EdCliente.resultfind.fieldbyname(campoufentidade).asstring then
    //        reducaobase:=FCodigosFiscais.GetAliquotaRedBase( QEstoque.fieldbyname('esqt_cfis_codigoest').asstring )
    // 10.02.09 - Asatec
            reducaobase:=FCodigosFiscais.GetAliquotaRedBase( QEstoque.fieldbyname('esqt_cfis_codigoest').asstring,revenda,EdProduto.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring )
        else
            reducaobase:=0;
      end;
// 22.03.10
     if pos( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.TiposNaoCalcIcms ) > 0 then
       reducaobase:=0;
    Grid.Cells[Grid.getcolumn('esto_unidade'),x]:=Arq.TEstoque.fieldbyname('esto_unidade').asstring;
    aqtde:=texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),x])+ EdQTde.AsFloat;
//    Grid.Cells[5,x]:=Transform(texttovalor(Grid.Cells[5,x])+EdQTde.Ascurrency,f_cr);
    Grid.Cells[Grid.getcolumn('move_qtde'),x]:=Valortosql( texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),x])+EdQTde.AsFloat );
    Grid.Cells[Grid.getcolumn('move_venda'),x]:=Valortosql(EdUnitario.Ascurrency);
    Grid.Cells[Grid.getcolumn('total'),x]:=Valortosql( (aqtde)*EdUnitario.AsCurrency);
    Grid.Cells[Grid.getcolumn('move_perdesco'),Abs(x)]:=EdPerdesconto.AsSql;
//    Grid.Cells[Grid.getcolumn('move_aliicms'),Abs(x)]:=TRansform(QEstoque.fieldbyname('esqt_vendavis').AsCurrency,f_cr);
// 25.08.06 - Marcia lizot pegou o erro...
    Grid.Cells[Grid.getcolumn('move_vendabru'),Abs(x)]:=TRansform(QEstoque.fieldbyname('esqt_vendavis').AsCurrency,f_cr);
//
// 16.08.06
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
    Grid.Cells[Grid.Getcolumn('move_vendamin'),x]:=TRansform(QEstoque.fieldbyname('esqt_vendamin').AsCurrency,f_cr);
// 23.12.08
    Grid.Cells[Grid.Getcolumn('move_certificado'),x]:=EdCertificado.text;
// 13.07.09
    Grid.Cells[Grid.Getcolumn('move_core_codigoind'),Abs(x)]:=EdCorIndust.text;
// 08.09.10
    Grid.Cells[Grid.Getcolumn('move_natf_codigo'),Abs(x)]:=FSittributaria.GetCfop(codsittrib,EdNatf_codigo.text,EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring);
// 08.07.19  - Vini Rotta
    if campoicmsst.Tipo<>'' then begin

      if ( EdUNid_codigo.resultfind.FieldByName('unid_uf').asstring=EdCliente.resultfind.fieldbyname(campoufentidade).asstring)   then
         Grid.Cells[Grid.Getcolumn('aliicmsst'),Abs(x)]:=currtostr( FCodigosFiscais.GetPercIcmsSubs(QEstoque.fieldbyname('esqt_cfis_codigoest').asstring))
      else
         Grid.Cells[Grid.Getcolumn('aliicmsst'),Abs(x)]:=currtostr( FCodigosFiscais.getpercicmssubs(QEstoque.fieldbyname('esqt_cfis_codigoforaest').asstring));

    end;
// 08.08.19
    if Global.Topicos[1367]  then begin

       Grid.Cells[Grid.GetColumn('move_equi_codigo'),Abs(x)]:=Arq.TEstoque.FieldByName('esto_equi_codigo').asstring;
       EdCodEqui.Text :=Arq.TEstoque.FieldByName('esto_equi_codigo').asstring;

    end;
//05.09.19
  //  Grid.Cells[Grid.GetColumn('codsitrib'),Abs(x)]:=Arq.TSittributaria.FieldByName('sitt_codigo').AsString;
// 31.03.20   - guiber - nf com St mas sem icms
    Grid.Cells[Grid.GetColumn('codsitrib'),Abs(x)]:=inttostr(codsittrib);

  end;
  Grid.Refresh;

end;


procedure TFNotaSaida.bIncluiritemClick(Sender: TObject);
/////////////////////////////////////////////////////////////
begin
  if EdCliente.AsInteger=0 then exit;
//  if EdRepr_codigo.AsInteger=0 then exit;
// 26.01.12
  if (EdRepr_codigo.AsInteger=0) and ( pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,TiposDevolucao)=0 ) then begin
// 12.09.14 - Vivan - remessa para fornecedor
     if campoufentidade='forn_uf' then EdRepr_codigo.Text:='1'
     else exit;
  end;
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
  EdProduto.enabled:=true;
  EdProduto.setfocus;
  
end;

procedure TFNotaSaida.LimpaEditsItens;
////////////////////////////////////////
begin
  EdProduto.Clear;
  EdQtde.Clear;
  EdUnitario.Clear;
  EdPerdesconto.clear;
  SetedEsto_descricao.Clear;
  EdCorIndust.Clear;
end;

procedure TFNotaSaida.EdProdutoValidate(Sender: TObject);
///////////////////////////////////////////////////////////
var x:integer;
    QBusca:TSqlquery;
    custotrans,precobalanca,aliicms:currency;
    codbarra,xproduto,codbarrabalanca,iniciook:string;
    nfinicial,
    nffinal      : currency;

    //////////////////////// - 18.08.11
    procedure CalculaQTdeRomaneios(xdatai :TDatetime=0 ; xdataf:TDatetime=0);
    /////////////////////////
    var rqtde:currency;
        listaromaneios,
        sqlperiodo :string;
        Q          :TSqlquery;
    begin

// 03.04.20
       sqlperiodo := ' and moes_datasaida>='+Datetosql( DateToPrimeiroDiaMes(EdDtEmissao.asdate) )+
                     ' and moes_datasaida<='+EdDtEmissao.assql ;
       if xdatai>0 then
          sqlperiodo := ' and moes_datasaida>='+Datetosql( xDatai )+
                        ' and moes_datasaida<='+Datetosql( xdataf );
       Q:=Sqltoquery('select move_qtde,move_numerodoc from movestoque'+
                      ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                      ' where move_status=''N'' and moes_status=''N'''+
                      ' and '+FGeral.GetIN('move_tipomov',Global.CodRomaneioRemessaaOrdem,'C')+
                      ' and move_tipo_codigo='+Edcliente.AsSql+
                      ' and move_esto_codigo='+EdProduto.AsSql+
                      sqlperiodo );

        rqtde:=0;listaromaneios:='';
        while not Q.eof do  begin

            rqtde:=rqtde+Q.fieldbyname('move_qtde').ascurrency;
            if trim(listaromaneios)='' then
              listaromaneios:=listaromaneios+Q.fieldbyname('move_numerodoc').asstring
            else
              listaromaneios:=listaromaneios+','+Q.fieldbyname('move_numerodoc').asstring;
            Q.Next;

        end;
        FGeral.FechaQuery(Q);
        EdQtde.setvalue(rqtde);
        EdMensagem.text:=EdMensagem.text+' Romaneios '+listaromaneios+' Munic�pio '+Fcidades.GetNome(EdCliente.resultfind.fieldbyname('Clie_cida_codigo_res').AsInteger);
    end;

    //////////////////////////////////// - 24.08.11
//    procedure CalculaQTdeNotasRomaneios(xdatai:TDatetime=0 ; xdataf:TDatetime=0);
    procedure CalculaQTdeNotasRomaneios(xnfinicial:currency=0 ; xnffinal:currency=0);
    ///////////////////////////////////////////////////////////////////////////////////
    var rqtde:currency;
        listaromaneios,mens,clientesnao,sqlclientes,
        campocli,
        sqlperiodo,
        sqlnumeros:string;
        Q         :TSqlquery;
        codmens   :integer;
    begin
       codmens:=FGeral.GetConfig1AsInteger('CODMENVENAORD');
       mens:='';
       campocli:='moes_tipo_codigo';
//       campocli:='moes_clie_codigo';
       if codmens>0 then
         mens:=FMensNotas.GetDescricao(codmens);
       clientesnao:=FGeral.GetConfig1AsString('clientesjustica')+';'+FGeral.GetConfig1AsString('clientessaude');
       if ( EdCliente.AsInteger=FGeral.GetConfig1AsInteger('cliejustica') ) and
          ( FGeral.GetConfig1AsString('clientesjustica')<>'' )
         then
         sqlclientes:=' and '+FGeral.GetIN('moes_tipo_codigo',FGeral.GetConfig1AsString('clientesjustica'),'N')
       else if ( EdCliente.AsInteger=FGeral.GetConfig1AsInteger('cliesaude') ) and
          ( FGeral.GetConfig1AsString('clientessaude')<>'' )
         then
         sqlclientes:=' and '+FGeral.GetIN('moes_tipo_codigo',FGeral.GetConfig1AsString('clientessaude'),'N')
       else
         sqlclientes:=' and '+FGeral.GetNOTIN( campocli ,clientesnao,'N');
// 03.04.20
       sqlperiodo := ' and moes_datasaida>='+Datetosql( DateToPrimeiroDiaMes(EdDtEmissao.asdate) )+
                     ' and moes_datasaida<='+EdDtEmissao.assql ;
//       if xdatai>0 then
       sqlnumeros:='';
       if xnfinicial>0 then
//          sqlperiodo := ' and moes_datasaida>='+Datetosql( xDatai )+
//                        ' and moes_datasaida<='+Datetosql( xdataf );
          sqlnumeros := ' and move_numerodoc >= '+currtostr( xnfinicial )+
                        ' and move_numerodoc <= '+currtostr( xnffinal );

       Q:=Sqltoquery('select move_qtde,move_numerodoc,clie_cida_codigo_res from movestoque'+
                      ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                      ' inner join clientes on ( clie_codigo=moes_clie_codigo )'+
                      ' where move_status=''N'' and moes_status=''N'''+
                      ' and '+FGeral.GetIN('move_tipomov',Global.CodNotaRemessaaOrdem,'C')+
                      ' and move_esto_codigo='+EdProduto.AsSql+
                      sqlclientes+
//                      ' and moes_cida_codigo='+EdCida_codigo.AsSql+
// 01.04.13 - pela cidade do moes_clie_codigo
                      ' and clie_cida_codigo_res='+EdCida_codigo.AsSql+
                      sqlnumeros+
                      sqlperiodo );
        rqtde:=0;listaromaneios:='';
        while not Q.eof do  begin

            rqtde:=rqtde+Q.fieldbyname('move_qtde').ascurrency;
            if trim(listaromaneios)='' then
              listaromaneios:=listaromaneios+Q.fieldbyname('move_numerodoc').asstring
            else
              listaromaneios:=listaromaneios+','+Q.fieldbyname('move_numerodoc').asstring;
            Q.Next;
        end;

        FGeral.FechaQuery(Q);
        EdQtde.setvalue(rqtde);
        EdMensagem.text:=mens+' NF de Remessa a Ordem '+listaromaneios+' Munic�pio '+Fcidades.GetNome(strtointdef(EdCida_codigo.text,0) );
    end;


//////////////////////////////////
begin
//////////////////////////////////
// 05.12.05
  codbarrabalanca:='N';
  if not FEstoque.ValidaCodigoProduto(EdProduto,EdProduto.text) then
    exit;

// 15.12.15
  if EdCliente.resultfind.fieldbyname(campoufentidade).asstring<>Global.UFUnidade then
    iniciook:='6'
  else
    iniciook:='5';
  if copy(EdNatf_codigo.text,1,1)<>'7' then begin
    if pos(copy(EdNatf_codigo.text,1,1),iniciook)=0 then begin
      Avisoerro('Cfop inv�lido para esta opera��o de saida.');
      exit;
    end;
  end;
//////////////////////
  codigobarra:=false;
  if FGeral.CodigoBarra(EdProduto.Text,EdProduto) then begin

    QBusca:=sqltoquery('select * from estoque where esto_Codbarra='+EdProduto.assql);
    codbarra:=EdProduto.text;
    if not QBusca.Eof then
      EdProduto.Text:=QBusca.fieldbyname('esto_codigo').AsString
    else begin
//          EdProduto.Invalid('Codigo de barra n�o encontrado');
//          exit;
    end;
    codigobarra:=true;
// 28.02.18
    if Global.Topicos[1372] then begin
      EdQtde.Enabled:=true ;
      EdQtde.SetValue(1);
    end else begin
      EdQtde.Enabled:=false;
      EdQtde.SetValue(1);
    end;

//    EdPerdesconto.enabled:=false;
    EdPerdesconto.setvalue(0);
    if not Qbusca.eof then begin
      QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                         ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
      if not FGeral.TemEstoque(EdProduto.Text,EdQtde.AsFloat,EdUNid_codigo.Text,QEstoque) then begin
         EdProduto.INvalid('Quantidade em estoque insuficiente');
         exit;
      end;
    end;
    EdCodcor.enabled:=false;
    EdCodtamanho.enabled:=false;
    EdCodcopa.enabled:=false;
    EdCodcor.text:='';
    EdCodtamanho.text:='';
    EdCodcopa.text:='';
// 06.01.2021
    if not FEstoque.ValidaTributacaoProduto( EdProduto.text,EdCliente.resultfind.fieldbyname( campoufentidade ).asstring,EdComv_codigo.ResultFind.Fieldbyname('comv_tipomovto').asstring ) then
       EdProduto.Invalid('');

//    if QBusca.FieldByName('esto_grad_codigo').asinteger>0 then begin
    if QBusca.eof  then begin
      QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'''+
                       ' and esgr_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
                       ' and esgr_codbarra='+stringtosql(codbarra));
      if not QGrade.eof then begin
        EdProduto.Text:=QGrade.fieldbyname('esgr_esto_codigo').AsString;
        EdCodcor.setvalue(QGrade.fieldbyname('esgr_core_codigo').asinteger);
        EdCodcor.validfind;
        EdCodtamanho.setvalue(QGrade.fieldbyname('esgr_tama_codigo').asinteger);
        EdCodtamanho.validfind;
        EdCodcopa.setvalue(QGrade.fieldbyname('esgr_copa_codigo').asinteger);
        EdCodcopa.validfind;
        FGeral.Fechaquery(QEstoque);
        QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                         ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
        FGeral.Fechaquery(QBusca);
        QBusca:=sqltoquery('select * from estoque where esto_codigo='+EdProduto.assql);
      end else begin
        EdProduto.Invalid('Codigo de barra da grade n�o encontrado');
        exit;
      end;
    end;

  end else if trim(edproduto.text)<>'' then begin

    xproduto:=EdProduto.text;
// 23.11.11 - Benato
    if (Global.Topicos[1217]) and ( copy(xproduto,1,1)='2' ) and ( length(trim(xProduto))=13 ) then begin
      EdProduto.text:=copy(xproduto,2,4);
      codbarrabalanca:='S';
      precobalanca:=Texttovalor( copy(xproduto,8,5) )/1000;
// preco balanca ser� o peso para agilizar passagem pelo caixa
    end;

    QBusca:=sqltoquery('select * from estoque where esto_Codigo='+EdProduto.assql);
//    QBusca:=sqltoquery('select * from estoque where esto_Codigo='+Stringtosql(xProduto));
    if not QBusca.Eof then begin
      EdProduto.Text:=QBusca.fieldbyname('esto_codigo').AsString;
      if EstaCodigosNaoVenda(QBusca.fieldbyname('esto_codigo').AsString) then
        EdProduto.Invalid('Codigo n�o permitido usar em vendas');
    end else begin
      EdProduto.Invalid('Codigo n�o encontrado');
      exit;
    end;
    QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                       ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
    if QEstoque.eof then begin
       EdProduto.INvalid('Codigo n�o encontrado no estoque da unidade '+EdUnid_codigo.text);
       exit;
    end;
    Arq.TEstoque.locate('esto_codigo',Edproduto.text,[]);
/////////    EdQtde.Enabled:=true;
// 01.07.08
//    EdCodcor.enabled:=true;
    EdCodcor.setvalue(0);
//    EdCodtamanho.enabled:=true;
    EdCodtamanho.setvalue(0);
//    EdCodcopa.enabled:=true;
    EdCodcopa.setvalue(0);
//    EdPerdesconto.enabled:=true;
    EdPerdesconto.setvalue(0);
    EdQtde.Enabled:=true;
// deixao edqtde ativo pra poder informar os kilos vendidos
    if codbarrabalanca='S' then begin
        EdQtde.Enabled:=false;
        EdQtde.SetValue( precobalanca );
    end else
      EdQtde.SetValue(0);
//    EdPerdesconto.enabled:=false;
    EdPerdesconto.setvalue(0);
// 23.09.2021 - Situacao Sicare - calcula st mas n�o icms
    if trim( FUnidades.GetieST(Global.codigounidade) ) = '' then begin

// 06.01.2021
       if not FEstoque.ValidaTributacaoProduto( EdProduto.text,EdCliente.resultfind.fieldbyname( campoufentidade ).asstring,EdComv_codigo.ResultFind.Fieldbyname('comv_tipomovto').asstring ) then

          EdProduto.Invalid('');

    end;

  end;

// 17.02.09 - asatec - chamou cadastro de ipi via f12 dentro do f12 dos produtos...
  if QEstoque=nil then begin
      EdProduto.Invalid('Checar codigo do produto informado '+EdProduto.text);
      exit;
  end;
  if QBusca=nil then begin
      EdProduto.Invalid('Checar codigo no estoque do produto informado '+EdProduto.text);
      exit;
  end;
//  if trim(QBusca.sql.Text)='' then begin
  if QBusca.SQL.Count=0  then begin
      EdProduto.Invalid('Checar codigo no estoque do produto informado '+EdProduto.text);
      exit;
  end;
// 23.08.05
  if QEstoque.eof then begin
      EdProduto.Invalid('Codigo ainda n�o cadastrado na unidade '+EdUnid_codigo.text);
      exit;
  end;
  if length( FSittributaria.GetCST(QEstoque.fieldbyname('esqt_sitt_codestado').asinteger,EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring) )<> 3 then begin
     EdProduto.Invalid('Situa��o tribut�ria no estado inv�lida');
     exit;
  end;
  if length( FSittributaria.GetCST(QEstoque.fieldbyname('esqt_sitt_forestado').asinteger,EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring) ) <> 3 then begin
     EdProduto.Invalid('Situa��o tribut�ria fora do estado inv�lida');
     exit;
  end;
// 04.11.05
  if (not FGeral.ChecaCst(FSittributaria.GetCST(QEstoque.fieldbyname('esqt_sitt_codestado').asinteger,EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring),EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring) )
    and ( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring<>Global.CodDevolucaoTributada )
    then begin
    EdProduto.invalid('');
    exit;
  end;
// 14.10.09
  if (Global.Topicos[1336]) and ( not ConstaListaProdutosAcabados(SetEdESTO_DESCRICAO.Items,EdProduto.Text) )
     and ( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodContratoEntrega )
    then begin
    EdProduto.invalid('Produto n�o encontrado na produ��o.');
    exit;
  end;
// 05.04.10 - Abra
  if (QEstoque.fieldbyname('esqt_customeger').ascurrency+QEstoque.fieldbyname('esqt_customedio').ascurrency)>999999.99  then begin
    EdProduto.invalid('Problemas no custo m�dio no estoque.  Checar');
    exit;
  end;
// 13.08.07
  EdCodtamanho.Enabled:=Global.Usuario.OutrosAcessos[0305];
  EdPerdesconto.Enabled:=Global.Usuario.OutrosAcessos[0304];
//

  SetEdEsto_descricao.text:=QBusca.fieldbyname('esto_descricao').asstring;
// 10.01.12 - Benatto
  Mostra(PDescricaoproduto,SetEdEsto_descricao.text);

//  EdUnitario.Setvalue(QEstoque.fieldbyname('esqt_vendavis').AsCurrency);
// 14.09.05 - reges
//  EdUnitario.setvalue(FEstoque.GetPreco(EdProduto.text,Global.unidadematriz));
// 30.09.09 - Faveri na unidade 003
// 24.11.11 - no codigo de barra da balanca vem o valor total mas como o pre�o
// do kilo � . por ex.
//  if codbarrabalanca='S' then
//    EdUnitario.setvalue(precobalanca)
//  else

   aliicms:=FEstoque.Getaliquotaicms(EdProduto.text,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,EdCliente.asinteger,
                            Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,revenda,'C');
// 31.03.16 - Markito
   if campoufentidade='clie_uf' then
     EdUnitario.setvalue(FEstoque.GetPreco(EdProduto.text,EdUnid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,aliicms,
                         '',0,EdCliente.resultfind.fieldbyname('clie_contribuinte').asstring))
   else
     EdUnitario.setvalue(FEstoque.GetPreco(EdProduto.text,EdUnid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,aliicms));

// 22.06.06
  if (pos( EdProduto.text,FGeral.Getconfig1asstring('Produtoscopa') )>0) and (not codigobarra) then
    EdcodCopa.enabled:=true
  else begin
    EdCodCopa.enabled:=false;
    EdCodCopa.setvalue(0);
  end;

  if ( DevolucaoCompra(Arq.TConfMovimento.fieldbyname('comv_tipomovto').asstring) ) or
     ( Arq.TConfMovimento.fieldbyname('comv_tipomovto').asstring=Global.CodRemessaconserto )  // 17.08.06 - grazi+leila
     then begin
//    EdUnitario.setvalue(QEstoque.fieldbyname('esqt_custo').AsCurrency);
// ver se compensa traze o custo + icms...
// 14.09.05
    EdUnitario.enabled:=true;
  end else begin
// 12.02.2021 - Guiber
    if codigobarra then
       EdUnitario.enabled:=false
    else
       EdUnitario.enabled:=Global.Usuario.OutrosAcessos[0034];

// 31.12.18 - Fama
    if ( Global.Usuario.OutrosAcessos[0347] ) and ( Ecf='S' ) then
       EdUnitario.Enabled:=true;

  end;
// 04.03.05
//  if pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.CodTransfSaida+';'+Global.CodTransImob )>0 then begin
// 20.03.05
  if pos(Arq.TConfMovimento.fieldbyname('comv_tipomovto').asstring,Global.CodTransfSaida+';'+Global.CodTransImob+';'+Global.CodRemessaInd )>0 then begin
//    perctrans:=FCodigosFiscais.GetPercTransf(FEstoque.GetCodigoFiscal(EdProduto.text,EdUNid_codigo.text,EdUnid_codigo.resultfind.fieldbyname('unid_uf').AsString));
    custotrans:=QEstoque.fieldbyname('esqt_custoger').AsCurrency;
    EdUnitario.Setvalue(custotrans);
//  18.03.05
    EdUnitario.enabled:=true;
  end;
// 05.05.06 - Leila
  if ( pos(Arq.TConfMovimento.fieldbyname('comv_tipomovto').asstring,Global.CodVendaBrindeConsig )>0 ) and (EdDtMovimento.asdate>1)then begin
    EdUnitario.Setvalue(QEstoque.fieldbyname('esqt_customedio').AsCurrency);
  end;
///////////////
// 28.07.11
  if ( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodRomaneioRemessaaOrdem )
     and ( OP='I' ) then begin
    EdUnitario.setvalue(1);
    EdUnitario.enabled:=false;
  end;
//////////////

  if (EdUnitario.ascurrency=0) and ( not EdUnitario.enabled) then
    Avisoerro('Aten��o.   Checar pre�o de venda ou custo m�dio no cadastro.');

// 27/10/04 - caso usar tabela recalcular pre�o de venda mas n�o "aparecer" o desconto ou acr�scimo
// pois estar� embutido no pre�o de venda
// 12.11.12 - Vivan - reativado
  if EdMoes_tabp_codigo.asinteger>0 then begin
    if FTabela.gettipo(EdMoes_tabp_codigo.asinteger) = 'A' then
      EdUnitario.setvalue( EdUnitario.AsCurrency + (EdUnitario.ascurrency*(FTabela.GetAliquota(EdMoes_tabp_codigo.asinteger)/100) ) )
    else
      EdUnitario.setvalue( EdUnitario.AsCurrency - (EdUnitario.ascurrency*(FTabela.GetAliquota(EdMoes_tabp_codigo.asinteger)/100) ) );
  end;
// 18.08.11 - Capeg
  if ( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodNotaRemessaaOrdem )
       and ( OP='I' ) then begin
    if Global.Topicos[1469] then begin

       Sistema.GetPeriodo('Per�odo para somar romaneios');
       CalculaQTdeRomaneios(Sistema.Datai,Sistema.Dataf);

    end else

       CalculaQTdeRomaneios;

  end;
// 24.08.11 - Capeg
  if ( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodVendaaOrdem )
       and ( OP='I' ) then begin
    if Global.Topicos[1469] then begin

//       Sistema.GetPeriodo('Per�odo para somar notas');
       nfinicial := FGeral.GetCampoNumerico('Nota Inicial',nfinicial,400,350);
       nffinal   := FGeral.GetCampoNumerico('Nota Final'  ,nffinal,600,350);
       if nffinal<nfinicial then begin
          Avisoerro('N�mero final menor que o inicial');
          exit;
       end;

//       CalculaQTdeNotasRomaneios(Sistema.Datai,Sistema.Dataf);
       CalculaQTdeNotasRomaneios(nfinicial,nffinal);

    end else

       CalculaQTdeNotasRomaneios;

  end;

  if Op='A' then begin                             // 27.07.16
    if (FGeral.ProcuraGrid(0,Edproduto.text,Grid)>0) and (not EdCodcor.Enabled) then begin
      Edproduto.Invalid('Em altera��o obrigat�rio excluir e incluir');
    end;
  end;
// 17.08.18
  if ( OP='I' ) and (Global.Topicos[1455]) then EdNatf_codigop.Text:=EdNatf_codigo.Text;

end;


procedure TFNotaSaida.EdQtdeValidate(Sender: TObject);
//////////////////////////////////////////////////////////////
var familia:integer;
begin
  if EdQtde.AsFloat>0 then begin
    if not FGeral.TemEstoque(EdProduto.Text,EdQtde.AsFloat,EdUNid_codigo.Text,QEstoque,Arq.TConfMovimento.fieldbyname('comv_tipomovto').asstring) then begin
       EdQTde.INvalid('Quantidade em estoque insuficiente');
    end else if EdCodTamanho.asinteger>0 then begin
       familia:=FEstoque.Getfamilia(EdProduto.text);
///////////////////
       {  retirado em 13.11.13
       if pos( strzero(familia,4),FGeral.Getconfig1asstring('familiascuba') )>0 then begin
         EdQtde.setvalue( EdQtde.asFloat*(FTamanhos.GetCubagem(EdCodtamanho.asinteger)) )
       end;
       }
///////////////////
// 09.09.09 - Abra
       if (Global.Topicos[1334]) and ( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodRemessaInd ) then begin
         if FTamanhos.GetComprimento(EdCodtamanho.asinteger)>0 then
           EdQtde.setvalue( EdQtde.asFloat*( (FTamanhos.GetComprimento(EdCodtamanho.asinteger)/1000) ) );
       end;
    end;
// 10.01.12 - Benatto
    Esconde(PDescricaoproduto);

  end;

end;

procedure TFNotaSaida.EdQtdeExitEdit(Sender: TObject);
//////////////////////////////////////////////////////

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
    if pos(Arq.TConfMovimento.fieldbyname('comv_tipomovto').asstring,global.TiposMovMovEstoque)>0 then
      ReservaEstoque(EdProduto.Text,'I',EdQtde.AsFloat);
    EditstoGrid;
    SetaEditsValores;
//    if Ecf='S' then
//      ImprimeItem;
    if op='A' then begin
      ListaReservaCodigo.Clear;
      ListaReservaQtde.Clear;
    end;
  end;
  LimpaEditsItens;
  EdProduto.SetFocus;
  QEstoque.close;
  Freeandnil(QEstoque);

end;

procedure TFNotaSaida.ReservaEstoque(Codigo, IncExc: string;  Qtde: currency);
////////////////////////////////////////////////////////////////////////////
var p:integer;
begin
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

end;

// 01.06.18
procedure TFNotaSaida.Setacondicoespag(Ed: TSqled);
///////////////////////////////////////////////////
var Lista:TStringList;
    p    :integer;
    Q    :TSqlquery;

begin

  Lista:=TStringList.Create;
  Ed.Items.Clear;
  strtolista(Lista,EdCliente.ResultFind.FieldByName('clie_condicoespag').AsString,';',true);
  for p := 0 to  Lista.Count-1 do begin
    if trim(Lista[p])<>'' then begin
       Q:=sqltoquery('select Fpgt_descricao from fpgto where fpgt_codigo = '+stringtosql(Lista[p]));
       Ed.Items.Add( Lista[p] + '  '+Q.FieldByName('fpgt_descricao').AsString );
       Q.Close;
    end;
  end;


end;

procedure TFNotaSaida.SetaEditsValores(mudouvaloritem:boolean=false);
/////////////////////////////////////////////////////////////////////

var baseicms,vlricms,basesubs,icmssubs,totalprodutos,totalnota,totalitem,aliicms,icmsitem,margemlucro,tdescacre,
    tqtde,icmsitemsubs,aliipi,ipiitem,vlripi,totalitembase,totalpesoliquido,aliiss,vlrservicos,
    aliicmsgeral,totalqtdevolumes,icmssubsDevTrib,
    baseicmssubsDevTrib,
    vlrII,
    vfcpst,
    pdif:currency;
    p,subgrupodevcompra:integer;
    produto,descacre,xtipocad:string;
    precovenda:extended;  // 01.07.08 - mudado de currency pra extended para 'ver' mais casas decimas devido saida abate
    perfrete:double;
    vfrete:currency;

    function Calctabela(valor:currency):currency;
    //////////////////////////////////////////////////
    begin
      result:=FGeral.Arredonda( valor*(Arq.TTabelapreco.fieldbyname('tabp_aliquota').AsCurrency/100) ,2 );
    end;

begin
// 02.06.06
  if ( pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.CodVendaRE+';'+Global.CodVendaREFinal)>0 )
    and (op='A') then
     exit;
  subgrupodevcompra:=FGeral.Getconfig1asinteger('subgrupodevcom');
// 29.05.17
  if campoufentidade='clie_uf' then
    xtipocad:='C'
  else
    xtipocad:='F';

  baseicms:=0; vlricms:=0; basesubs:=0 ; icmssubs:=0 ; totalprodutos:=0 ; totalbruto:=0; tqtde:=0;
  vlripi:=0;totalpesoliquido:=0;aliiss:=0;vlrservicos:=0;totalqtdevolumes:=0;icmssubsDevTrib:=0;
  baseicmssubsDevTrib:=0;
  vlrII:=0; vfcpst :=0;
// 30.12.2022
//  perfrete := (EdFrete.AsCurrency/EdTotalProdutos.AsCurrency)*100;
//  perfrete := FGEral.Arredonda( (EdFrete.AsCurrency/EdTotalProdutos.AsCurrency)*100,2); 496,19
// perfrete := FGEral.Arredonda( (EdFrete.AsCurrency/EdTotalProdutos.AsCurrency)*100,3); // 496,21

// 15.02.2023 - divisao de 'zero por zero' da um numero negativo enorme no delphi 10.1
  if EdTotalProdutos.AsCurrency>0 then
     perfrete := FGEral.Arredonda( (EdFrete.AsCurrency/EdTotalProdutos.AsCurrency)*100,4)
  else
     perfrete := 0;

// percorrer o grid somando valores e montando base do icms normal e subst. tribut�ria
  produtosnota:='';

  for p:=1 to Grid.rowcount do begin

    produto:=Grid.Cells[Grid.GetColumn('move_esto_codigo'),p];
    if trim(produto)<>'' then begin

      produtosnota:=produtosnota+Grid.Cells[Grid.GetColumn('esto_referencia'),p]+';';
      precovenda:=texttovalor(Grid.Cells[Grid.GetColumn('move_venda'),p]);
      aliicms:=texttovalor(Grid.Cells[Grid.GetColumn('Move_aliicms'),p] );
      aliipi:=texttovalor(Grid.Cells[Grid.GetColumn('Move_aliipi'),p] );
// 21.06.2021 - devolucao devereda
      vfcpst := vfcpst + Texttovalor(Grid.Cells[Grid.GetColumn('vfcpst'),p]);

//      totalitem:=Fgeral.Arredonda( texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]) * precovenda  ,2);
// 01.07.08
//      totalitem:=Fgeral.Arredonda( texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]) * precovenda  ,5);
// 14.07.08 - usar o total do grid ao inves da qtde*unitario
//      if pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.CodContrato+';'+Global.CodContratoNota+';'+Global.CodContratoDoacao)>0 then
// 04.08.18 - xml 4.0
        totalitem:=texttovalor(Grid.Cells[Grid.GetColumn('total'),p] );
//      else
//        totalitem:=Fgeral.Arredonda( texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]) * precovenda  ,5);

      tqtde:=tqtde+texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]);
      totalbruto:=totalbruto+totalitem;
      {
////////////////////////
      if EdPeracre.ascurrency>0 then begin
        totalitem:=totalitem+FGEral.Arredonda( totalitem*(EdPeracre.ascurrency/100) ,2  );
      end else if EdPerdesco.ascurrency>0 then begin
        totalitem:=totalitem-FGEral.Arredonda( totalitem*(EdPerdesco.ascurrency/100) ,2 );
      end;
////////////////////////
      }
// 06.02.14 - Metalforte
      if EdPeracre.ascurrency>0 then begin

// 19.05.20 - Fama x Novicarnes
         if Global.Topicos[1471] then

// 01.03.10 - Novicarnes - Isonel - para embutir o acrescimo pra que se tirar retorne
//            ao valor original
            totalitem:=FGEral.Arredonda( totalitem / ( (100-EdPeracre.ascurrency)/100) ,5  )

         else

            totalitem:=totalitem+FGEral.Arredonda( totalitem*(EdPeracre.ascurrency/100) ,5  );

      end else if EdPerdesco.ascurrency>0 then begin

        totalitem:=totalitem-FGEral.Arredonda( totalitem*(EdPerdesco.ascurrency/100) ,5 );

      end;
// 30.12.2022 - jogar o frete no calculo do icms do item.
//      vfrete := totalitembase * (perfrete/100);
//      vfrete := FGeral.Arredonda( totalitem * (perfrete/100),2 );
      vfrete := FGeral.Arredonda( totalitem * (perfrete/100),4 );
// 02.02.2023  - deixado vfrete para somar o frete por item para o calculos do icms por item prevendo mais de um aliquota na nota

//      Arq.TEstoque.locate('esto_codigo',produto,[]);
//    Arq.TSittributaria.Locate('sitt_codigo',FEstoque.Getsituacaotributaria(produto,EdUnid_codigo.text,EdCliente.resultfind.fieldbyname('clie_uf').asstring),[]);
//      Arq.TSittributaria.Locate('sitt_codigo',FEstoque.GetCodigosituacaotributaria(produto,EdUnid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,),[]);
// 02.07.18
// 27.09.19 - quando vem da pesagem tem q buscar...
// 23.10.19 - ou quando puxa de um pedido...
// 20.12.19 - ou quando exclui um item da nota apos puxar os itens da entrada numa devolucao...
       if (  AnsiPOs(OP,'G/A/E') > 0 ) or ( EdPedido.AsInteger>0 )
          or
// 19.10.20 -Alutech - Fran
           ( Ansipos( Ednatf_codigo.text , '5116/6116' ) > 0 )
         then

          Arq.TSittributaria.Locate('sitt_codigo',FEstoque.GetCodigosituacaotributaria(produto,EdUnid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,revenda),[])

       else
// 05.09.19 - para usar o q pegou do produto nao precisando ir buscar novamente..
         Arq.TSittributaria.Locate('sitt_codigo',Grid.Cells[Grid.GetColumn('codsitrib'),p],[] );

// 30.11.15
      if (subgrupodevcompra>0) and ( pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString,Global.CodDevolucaoCompra+';'+Global.CodDevolucaoTributada)>0 )
         and ( pos(Grid.Cells[Grid.GetColumn('move_natf_codigo'),p],'5405/6404/5411/6411')>0 )
        then
        Arq.TSittributaria.Locate('sitt_codigo',FSubGrupos.GetCodigosituacaotributaria(Grid.Cells[Grid.GetColumn('move_natf_codigo'),p],subgrupodevcompra),[]);

//      aliicms:=FEstoque.Getaliquotaicms(produto,EdUnid_codigo.text,Edcliente);
/////////////////
// 10.07.07 - corrigido a cagada...
      if ( texttovalor(Grid.Cells[Grid.GetColumn('move_redubase'),p])>0 )
// 04.11.2022 - prever icms diferido q n�o reduz a base e aliquota..somente pra efeito de calculo aplica na aliquota
         and
         (  Arq.TSittributaria.Fieldbyname('sitt_cf').AsString<>'3' )
         then
// 24.05.07 - reducao de base
        totalitembase:=( totalitem*(texttovalor(Grid.Cells[Grid.GetColumn('move_redubase'),p])/100) )
//      else if aliicms>0 then
      else
// 30.12.2022 - Guiber
//        totalitembase:=totalitem + vfrete;
// 02.02.2023
        totalitembase:=totalitem ; // deixado aqui sem para jogar somente no calculo do icms
// 10.02.09 - Asatec
//      ipiitem:=FGeral.Arredonda( totalitem*(aliipi/100) ,2);
// 14.07.09 - dif. 01 centavo na clessi
      ipiitem:=FGeral.Arredonda( totalitem*(aliipi/100) ,3);
// 30.11.2022 - guiber -> floripa
      icmsitem:=0;

// 29.06.19 - rolo do esquecimo da thais na seip de nao cancelar nota de importacao no prazo legal
//      if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoTributadaCliente then
//        ipiitem:=ipiitem+FGeral.Arredonda( totalitem*(0.6011/100) ,3);
//      if (Global.Topicos[1327]) and (Revenda<>'R') then
// 31.03.10
      if (Global.Topicos[1327]) and (Revenda='S') then
        icmsitem:=FGeral.Arredonda( (totalitembase+ipiitem)*(aliicms/100) ,2)
// 07.07.11 - Clessi - devolucao de mat. uso e consumo
      else if ( Global.Topicos[1350] ) and ( pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,TiposDevolucao)>0 ) then
        icmsitem:=FGeral.Arredonda( (totalitembase+ipiitem)*(aliicms/100) ,2)
// 04.11.2022 - diferimento
      else if (  Arq.TSittributaria.Fieldbyname('sitt_cf').AsString='3' ) then  begin

        pdif := aliicms*(texttovalor(Grid.Cells[Grid.GetColumn('move_redubase'),p])/100);
        icmsitem:=FGeral.Arredonda( ((totalitembase*(aliicms-pdif))/100) ,2)

      end else

//        icmsitem:=FGeral.Arredonda( (totalitembase+vfrete)*(aliicms/100) ,2);
        icmsitem:=FGeral.Arredonda( (totalitembase+vfrete)*(aliicms/100) ,4);

      if EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodVendaConsigMercantil then begin
        aliicms:=0;
        icmsitem:=0;
// 11.11.13
      end else if EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodDevolucaotributada then
        aliicmsgeral:=aliicms;

      margemlucro:=0;
// 05.12.05
      if pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.TiposNaoCalcIcms)>0 then begin
        icmsitem:=0;
      end;
// 01.12.09 - Abra
      if (Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=global.CodRemessaInd) and
         ( Texttovalor(Grid.Cells[Grid.GetColumn('codcor'),p])>0 ) and
         ( Texttovalor(Grid.Cells[Grid.GetColumn('codtamanho'),p])>0 ) then
         totalpesoliquido:=totalpesoliquido+(FEstoque.GetPeso(produto)*texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]))
// 29.10.13 - Metalforte - peso
      else if global.topicos[1370] and
//         ( Texttovalor(Grid.Cells[Grid.GetColumn('codcor'),p])>0 ) and
         ( Texttovalor(Grid.Cells[Grid.GetColumn('codtamanho'),p])>0 ) then
         totalpesoliquido:=totalpesoliquido+(FEstoque.GetPeso(produto)*
                           texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p])*
                           (FTamanhos.GetComprimento(strtoint(Grid.Cells[Grid.GetColumn('codtamanho'),p])) /1000) )

// 29.01.13 - Novicarnes - Elize - 'Posto Guar�'
      else if EdPecas.Enabled then begin

         totalpesoliquido:=totalpesoliquido+texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]);
         totalQtdevolumes:=totalQtdevolumes+texttovalor(Grid.Cells[Grid.GetColumn('move_pecas'),p])

      end;
      if icmsitem>0 then begin
//        if (Global.Topicos[1327]) and (Revenda<>'R') then
// 31.03.10
        if (Global.Topicos[1327]) and (Revenda='S') then
          baseicms:=baseicms+totalitembase+ipiitem
// 07.07.11 - Clessi - devolucao de mat. uso e consumo
        else if ( Global.Topicos[1350] ) and ( pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,TiposDevolucao)>0 ) then
          baseicms:=baseicms+totalitembase+ipiitem
        else
          baseicms:=baseicms+totalitembase;

        vlricms:=vlricms+icmsitem;

// 30.12.2022 - guiber
//        baseicmscomfrete := baseicmscomfrete + totalitembase + vfrete

      end;

      vlripi:=vlripi+ipiitem;
      icmsitemsubs:=0;   // 07.12.05
//      if (Arq.TSittributaria.fieldbyname('sitt_cf').asstring=Global.CodigoSubsTrib) then begin
// 16.08.16 - vendas as consumidor final

      if (Arq.TSittributaria.fieldbyname('sitt_cf').asstring=Global.CodigoSubsTrib) and (FGeral.GetConsumidorFinal(EdCliente.AsInteger,xtipocad)<>'S' ) then begin

// 05.09.19 - tabela sittrib nao 'reposiciona' direito tentado de outra forma...
//      if ( Grid.Cells[]= ) and (FGeral.GetConsumidorFinal(EdCliente.AsInteger,xtipocad)<>'S' ) then begin
// 10.02.05 - reges
        if pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.TiposNaoCalcSubsTrib)=0 then begin
// 30.11.15
         if (subgrupodevcompra>0) and ( pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString,Global.CodDevolucaoCompra+';'+Global.CodDevolucaoTributada)>0 )
            and ( pos(Grid.Cells[Grid.GetColumn('move_natf_codigo'),p],'5405/6404/5411/6411')>0 )
           then

           margemlucro:=FCodigosFiscais.GetPercBaseSubs( FSubgrupos.GetCodigoFiscal(Grid.Cells[Grid.GetColumn('move_natf_codigo'),p],subgrupodevcompra) )

// 08.07.16 - Zilmar - ST
         else if campoufentidade='clie_uf' then begin

             if EdCliente.resultfind.fieldbyname('clie_contribuinte').asstring='2' then
                margemlucro:=FCodigosFiscais.GetPercBaseSubs(FSubGrupos.GetCodigoFiscal(EdNatf_codigo.text,FEstoque.GetSubGrupo(produto)))
             else
                margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(produto,EdUnid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,revenda));

         end else

           margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(produto,EdUnid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring));

// 31.03.14 - Giacomoni calculou mesmo sem margem
         if margemlucro>0 then begin

           if (subgrupodevcompra>0) and ( pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString,Global.CodDevolucaoCompra+';'+Global.CodDevolucaoTributada)>0 ) then begin
//              basesubs:=basesubs+( Texttovalor(Grid.Cells[Grid.GetColumn('basest'),p]) );
// 29.05.17
              basesubs:=basesubs+ipiitem+
                        ( Texttovalor(Grid.Cells[Grid.GetColumn('basest'),p]) );
//              icmsitemsubs:=FGeral.arredonda( Texttovalor(Grid.Cells[Grid.GetColumn('basest'),p]) * (FGeral.GetAliquotaFixaIcmsEstado(EdCliente.resultfind.fieldbyname(campoufentidade).asstring)/100) ,2 );
// 26.08.16
              icmsitemsubs:=FGeral.arredonda( Texttovalor(Grid.Cells[Grid.GetColumn('basest'),p]) * (FEstoque.Getaliquotaicms(produto,Global.CodigoUnidade,Global.UFUnidade)/100) ,2 );

           end else begin
//              basesubs:=basesubs+( totalitem*(1+(margemlucro/100)) );
// 29.05.17
              basesubs:=basesubs+ipiitem + ( totalitem*(1+(margemlucro/100)) );
// 06.08.18 - Zilmar - xml 4.0
              basesubs:=FGeral.Arredonda( basesubs,2 );

//              icmsitemsubs:=FGeral.arredonda( (totalitem*(1+(margemlucro/100))) * (FGeral.GetAliquotaFixaIcmsEstado(EdCliente.resultfind.fieldbyname(campoufentidade).asstring)/100) ,2 );
// 26.08.16
//              icmsitemsubs:=FGeral.arredonda( ((totalitem+ipiitem)*(1+(margemlucro/100))) * (FEstoque.Getaliquotaicms(produto,Global.CodigoUnidade,Global.UFUnidade,0,Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString)/100) ,2 );
// 31.05.17 - 01.07.16 - desta forma na venda nao calculava correto ficando negativo o ST no Zilmar
             if ( pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString,Global.CodDevolucaoCompra+';'+Global.CodDevolucaoTributada)>0 ) then

                icmsitemsubs:=FGeral.arredonda( ((totalitem+ipiitem)*(1+(margemlucro/100))) * (Texttovalor(Grid.Cells[Grid.GetColumn('aliicmsst'),p])/100) ,2)

//             else
//                icmsitemsubs:=FGeral.arredonda( ((totalitem+ipiitem)*(1+(margemlucro/100))) *
//                 (FEstoque.Getaliquotaicms(produto,Global.CodigoUnidade,Global.UFUnidade,0,Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString,revenda)/100) ,2 );
// 02.07.18
//                icmsitemsubs:=FGeral.arredonda( ((totalitem+ipiitem)*(1+(margemlucro/100))) *
//                             (FEstoque.Getaliquotaicms(produto,Global.CodigoUnidade,Global.UFUnidade,EdCliente.asinteger,Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString,revenda)/100) ,2 );

// 22.01.19 - Seip - voltado a pegar a tal 'aliquota fixa' interna de cada estado
             else if campoufentidade='clie_uf' then begin

             //08.06.19 - Sicare - voltado calculo peganedo aliquota q t� no produto..
// 14.06.19 - diferenciado para simples e nao simple
                 if pos( FUnidades.GetSimples(Edunid_codigo.text),'S;2') > 0 then begin

                    icmsitemsubs:=FGeral.arredonda( ((totalitem+ipiitem)*(1+(margemlucro/100))) *
                             (FEstoque.Getaliquotaicms(produto,Global.CodigoUnidade,Global.UFUnidade,EdCliente.asinteger,Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString,revenda)/100) ,2 );
// 08.07.19 - Vini rotta
                   if campoicmsst.tipo<>''  then
// 10.05.2022 - Sicare - Vando -devido a existencia do campo q ficou com zero calcula errado icmsitemsubs ficando negativo a St
                     if Texttovalor(Grid.Cells[Grid.GetColumn('aliicmsst'),p])>0 then
                       icmsitemsubs:=FGeral.arredonda( ((totalitem+ipiitem)*(1+(margemlucro/100))) *
                                (Texttovalor(Grid.Cells[Grid.GetColumn('aliicmsst'),p])/100) ,2 );

                 end else begin

                   icmsitemsubs:=FGeral.arredonda( ((totalitem+ipiitem)*(1+(margemlucro/100))) *
                             (FGeral.GetAliquotaFixaIcmsEstado(EdCliente.resultfind.fieldbyname(campoufentidade).asstring,EdCliente.asinteger)/100) ,2 );
// 08.07.19 - Vini rotta
                   if (campoicmsst.tipo<>'')  then
// 05.09.19
                      if Texttovalor(Grid.Cells[Grid.GetColumn('aliicmsst'),p]) >0  then

                         icmsitemsubs:=FGeral.arredonda( ((totalitem+ipiitem)*(1+(margemlucro/100))) *
                                (Texttovalor(Grid.Cells[Grid.GetColumn('aliicmsst'),p])/100) ,2 );

                 end;

             end else

                icmsitemsubs:=FGeral.arredonda( ((totalitem+ipiitem)*(1+(margemlucro/100))) *
                             (FEstoque.Getaliquotaicms(produto,Global.CodigoUnidade,Global.UFUnidade,EdCliente.asinteger,Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString,revenda)/100) ,2 );

           end;



// 22.09.15
//            basesubs:=basesubs+ FGeral.arredonda ( totalitem*(1+(margemlucro/100)) ,2 );
//            icmsitemsubs:=(totalitem*(1+(margemlucro/100))) * (FEstoque.GetAliquotaIcmsEstado(EdCliente.resultfind.fieldbyname(campoufentidade).asstring,EdCliente.resultfind.fieldbyname('clie_tipo').asstring,'S')/100);
// 29.10.14 - ajuste no calculo Da ST para usar 2 aliquotas de icms..a do icmsst � do estado destino
//            e a do icms 'normal' � do estado 'origem'... - giacomoni+asterio
//            icmsitemsubs:=(totalitem*(1+(margemlucro/100))) * (FGeral.GetAliquotaFixaIcmsEstado(EdCliente.resultfind.fieldbyname(campoufentidade).asstring)/100);
// 22.09.15
            icmsitemsubs:=icmsitemsubs-icmsitem;
          end;
         end else begin
           icmsitemsubs:=0;
         end;
        icmssubs:=icmssubs+icmsitemsubs;
      end;
// 15.05.17
      if not mudouvaloritem then begin
        icmssubsDevTrib:=icmssubsDevTrib+Texttovalor(Grid.Cells[Grid.GetColumn('valorst'),p]);
        baseicmssubsDevTrib:=baseicmssubsDevTrib+Texttovalor(Grid.Cells[Grid.GetColumn('basest'),p]);
      end else begin
        icmssubsDevTrib:=icmssubsDevTrib+icmsitemsubs;
        baseicmssubsDevTrib:=baseicmssubsDevTrib+basesubs;
      end;
      if Servico(Produto) then begin
        aliiss:=( texttovalor( Grid.cells[Grid.getcolumn('perciss'),p]) );
        vlrservicos:=vlrservicos+totalitem;
//      end else if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString<>Global.CodNfeComplementoIPI  then
// 14.05.18
      end else if AnsiPos(  Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString,Global.CodNfeComplementoIPI+';'+Global.CodNfeComplementoICms)=0  then
        totalprodutos:=totalprodutos+totalitem;
    end;

  end; // percorre o grid de produtos...

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
//////////////////////////
// 08.09.05
  if not DevolucaoCompra(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring) then begin
    if campoufentidade='clie_uf' then begin  // 27.09.07
//      if (EdDtmovimento.asdate<=1) or (EdCliente.resultfind.fieldbyname('clie_tipo').asstring<>'F') then begin
// 07.03.14 - liberado pra pessoa fisica e juridica
      if (EdDtmovimento.asdate<=1)  then begin
        basesubs:=0;
        icmssubs:=0;
      end;
    end;
//  end else begin   // 23.09.05 - retirado em 05.11.14 - Mirvane devolucao com ST e nao � ME
//      basesubs:=0;
//      icmssubs:=0;
  end;
// 30.08.05 - Valmir - notas feitas pelo representante no bloco nao tem icms mas tem substitui��o
// 13.11.15 - nfe complementar de icms
  if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,global.CodVendaAmbulante)>0 then begin
    baseicms:=0;
    vlricms:=0;
//  end else if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,global.CodNfeComplementoIcms+';'+
//              global.CodNfeComplementoIPI )>0 then

// 25.05.18 - Leila fica com valor no icms
  end else if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,global.CodNfeComplementoIcms )>0 then begin

//    vlricms:=totalitem;
// 24.06.19 - Novicarnes - Simone
//    baseicms:=0;

  end else if pos( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,global.CodNfeComplementoIPI )>0 then
    vlricms:=0;


// 08.10.12 - Niver Marta - 50 anos - Asatec - Fernanda
//  baseicms:=baseicms+EdFrete.ascurrency+EdSEguro.ascurrency;
// 24.10.12 - se for do simples nao tributa o frete nem seguro...
// 30.03.2022 - Alutech - para devolucoes tem q tributar pois na nota de entrada q esta sendo devolvida
//              pode ter frete...
  if pos( FUnidades.GetSimples(Edunid_codigo.text),'S;2') = 0 then begin


//     baseicms:=baseicms+EdFrete.ascurrency+EdSEguro.ascurrency;
     baseicms:=baseicms + (baseicms * (perfrete/100)) + EdSEguro.ascurrency;
     //      vfrete := FGeral.Arredonda( totalitembase * (perfrete/100),4 );

// deixado ja somado por item...depois ver se faz do seguro tbem....
// 30.12.2022 - Guiber
//      baseicms:=baseicmscomfrete;
// 02.02.023 - guiber 'desmudado' pois por produto nao bate com a receita a base do icms

  end else if AnsiPos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,
                 Global.CodDevolucaoSaida+';'+
                 Global.CodDevolucaoSimbolicaConsig+';'+
                 Global.CodDevolucaoTributada+';'+
                 global.CodDevolucaoCompra)>0 then

      baseicms:=baseicms+EdFrete.ascurrency+EdSEguro.ascurrency;

// 11.11.13
//  else if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=global.CodDevolucaoTributada then begin
//    baseicms:=baseicms+Edvlroutrasdespesas.ascurrency;
//    vlricms:=baseicms * (aliicmsgeral/100);
// 20.02.15 - devolucao giacomoni + asterior
//  end;

// 30.03.2022 - Devolucao tributada com frete  alutech
  if ( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodDevolucaotributada )
     and
     ( (EdFrete.AsCurrency+EdSeguro.AsCurrency)  > 0 )
  then begin
//    vlricms:=vlricms+( (EdFrete.ascurrency+EdSEguro.ascurrency) *
//                     ( (aliicmsgeral/100) ) );
    vlricms:=vlricms+( (EdSEguro.ascurrency) *
                     ( (aliicmsgeral/100) ) );

  end else begin

    if EdCliente.resultfind.fieldbyname(campoufentidade).asstring<>Global.UFUnidade then
      aliicmsgeral:= FCodigosFiscais.GetAliquota(FUnidades.GetFiscalFora(EdUnid_codigo.text))
    else
      aliicmsgeral:= FCodigosFiscais.GetAliquota(FUnidades.GetFiscalDentro(EdUnid_codigo.text));
  // 24.01.17
  ////  if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring<>global.CodDevolucaoCompra then
// 30.12.2022 - retirado para deixar o frete somado por produto
  //    vlricms:=vlricms+( (EdFrete.ascurrency+EdSEguro.ascurrency) *
  //                     ( (aliicmsgeral/100) ) );
  end;

///////////////////////////////////////////////
// 15.02.10
  EdPeriss.setvalue( aliiss );
// 25.05.10 - devido a poder vir do pedido ou digitado direto na nota
  if vlrservicos>0 then begin
    EdTotalServicos.SetValue( vlrservicos );
    EdValorIss.SetValue( vlrservicos*(aliiss/100) );
  end;
// 01.09.05
  if Nfexporta(EdNatf_codigo.text) then begin
    baseicms:=0;
    vlricms:=0;
    basesubs:=0;
    icmssubs:=0;
  end;
// 01.12.09 - Abra por enquanto soma somente o q tiver
// 09.04.10 - Asatec - se informar nao atualizar
// 23.04.10 - Abra - Notas RI tem q colocar o peso
  if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=global.CodRemessaInd then begin
    if totalpesoliquido>0 then begin
      EdPesoLiq.SetValue(totalpesoliquido);
      EdPesoBru.SetValue(totalpesoliquido);
    end;
  end else begin
// 09.07.15 - Novicarnes - so somava o primeiro item...
    if Edpecas.enabled then begin
        EdPesoLiq.SetValue(totalpesoliquido);
        EdPesoBru.SetValue(totalpesoliquido);
    end else begin
      if EdPesoliq.ascurrency=0 then
        EdPesoLiq.SetValue(totalpesoliquido);
      if EdPesoBru.ascurrency=0 then
        EdPesoBru.SetValue(totalpesoliquido);
    end;
// 30.10.13 - Metalfornte
   if Global.Topicos[1370]  then begin
      EdPesoLiq.SetValue(totalpesoliquido);
      EdPesoBru.SetValue(totalpesoliquido);
   end;
// 01.02.13
    if EdQTdeVolumes.ascurrency=0 then EdQTdeVolumes.text:=currtostr(totalQtdevolumes);
  end;
////////////
// 10.12.15 - Mirvane
  if ansipos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,
             global.CodDevolucaotributada+';'+
             global.CodDevolucaotributadacliente+';'+
             Global.CodDevolucaoSaida)>0 then begin
// 21.06.2021
    if Edvlroutrasdespesas.aSCURRency = 0 then

      totalnota:=totalprodutos+vlrservicos+EdFrete.Ascurrency+EdSeguro.ascurrency+icmssubsDevTrib+vlripi+vfcpst

    else

      totalnota:=totalprodutos+vlrservicos+EdFrete.Ascurrency+EdSeguro.ascurrency+icmssubsDevTrib+vlripi+Edvlroutrasdespesas.aSCURRency;

    icmssubs:=icmssubsDevTrib;
// 15.05.17
    basesubs:=baseicmssubsDevTrib;
// 24.01.17
//  end else  if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=global.CodDevolucaoCompra then
//    totalnota:=totalprodutos+vlrservicos+EdSeguro.ascurrency+icmssubs+vlripi+Edvlroutrasdespesas.aSCURRency
  end else

    totalnota:=totalprodutos+vlrservicos+EdFrete.Ascurrency+EdSeguro.ascurrency+icmssubs+vlripi+Edvlroutrasdespesas.aSCURRency;
// 12.06.17
  if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,global.CodPrestacaoServicos)>0 then
     totalnota:=totalnota-(EdVlrcofins.AsCurrency+EdVlrpis.AsCurrency+EdVlrir.AsCurrency+EdVlrcsll.AsCurrency+EdVlriss.AsCurrency);

  PTotais.EnableEdits;
//  EdTotalnota.enabled:=true;
// 09.03.14 - 16.02.15
  if ( pos( FUnidades.GetSimples(Edunid_codigo.text),'S;2') > 0 ) and
     ( basesubs>0 )  and ( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring<>Global.CodDevolucaoTributada ) then begin
    baseicms:=0;
    vlricms:=0;
  end;
//////////////
  EdBaseicms.setvalue(baseicms);
  EdValoricms.setvalue(vlricms);
  EdQtdetotal.setvalue(tqtde);
  Edvaloripi.setvalue(vlripi);

// 12.09.17 - 26.08.19 - retirado devido ao ipi ter q ir nos campos proprios na nfe 4.0
//  if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString=Global.CodNfeComplementoIPI  then
//    Edvaloripi.setvalue(Edvlroutrasdespesas.AsCurrency);


// 08.09.05 - 16.02.15 - liberar pra devolucao de compra tributada
  if not DevolucaoCompra(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring) then begin
    if (campoufentidade='clie_uf') or (Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoTributada) then begin  // 27.09.07
//      if EdCliente.resultfind.fieldbyname('clie_tipo').asstring<>'F' then begin
// //     EdBasesubs.setvalue(0);
//  //    EdValorsubs.setvalue(0);
//      end else begin
// 07.03.14 - deixado calcular pra pessoa juridica e fisica
        EdBasesubs.setvalue(basesubs);
        EdValorsubs.setvalue(icmssubs);
//      end;
    end;
  end else begin
      EdBasesubs.setvalue(basesubs);
      EdValorsubs.setvalue(icmssubs);
  end;
// 16.03.15 - Novi - Angela
  if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodNfeComplementoQtde)>0 then begin
    totalbruto:=0;
    totalnota:=0;
  end;
//17.11.15
//  if ( pos( FUnidades.GetSimples(Edunid_codigo.text),'S;2') > 0 ) and
//  if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.codNfeComplementoIcms)>0 then begin

//  Edtotalprodutos.setvalue(totalprodutos);
// 29.08.11 - para o caso de ter descontos ou acrescimentos na nota...
// 12.09.17
//  if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString<>Global.CodNfeComplementoIPI  then
// 14.05.18
  if AnsiPos( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString,Global.CodNfeComplementoIPI+';'+Global.CodNfeComplementoIcms )=0  then
    Edtotalprodutos.setvalue(totalbruto);

  Edtotalnota.setvalue(totalnota);
// 21.06.2021
  Edvfcpst.setvalue( vfcpst );

//  EdTotalnota.enabled:=false;
  PTotais.DisableEdits;
//  Update;
end;

procedure TFNotaSaida.bExcluiritemClick(Sender: TObject);
////////////////////////////////////////////////////////////
var codigoestoque:string;
    qtde,
    unitario,
    totalitem,
    totalservicos:currency;
begin

  if (EdRepr_codigo.AsInteger=0) and ( pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,TiposDevolucao)=0 ) then exit;
  if trim(Grid.Cells[Grid.GetColumn('move_esto_codigo'),Grid.row])='' then exit;
  if confirma('Confirma exclus�o ?') then begin

    codigoestoque:=Grid.Cells[Grid.GetColumn('move_esto_codigo'),Grid.row];
    qtde         :=texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),Grid.row]);
    unitario     :=texttovalor(Grid.Cells[Grid.getcolumn('move_venda'),Grid.row]);
    totalitem    :=qtde*unitario;
    totalservicos:=EdTotalServicos.ascurrency;
// 10.11.2022 - olstri  - pedido com mao de obra..
    if Servico(codigoestoque) then begin

      totalservicos := totalservicos - totalitem;
      EdTotalServicos.SetValue( totalservicos );

    end;

    Grid.DeleteRow(Grid.Row);
/////////////////////    OP:='E';    // 20.12.19
// 02.06.20 - retirado esta EEEERRDAAA q s� deu cagadaaaaaaaaaaaaaaaaa
// ver criar outra variavel ref. operacao de exclusao estando em Inclusao de nota e outra
// para alterar nota...

    SetaEditsValores;
    EdComv_codigo.validfind;
    if pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,global.TiposMovMovEstoque)>0 then
      ReservaEstoque(Codigoestoque,'E',qtde);
    Sistema.Commit;

  end;
  EdFpgt_codigo.ValidateEdit;
end;

procedure TFNotaSaida.bCancelaritemClick(Sender: TObject);
////////////////////////////////////////////////////////////////
begin
   if EdComv_codigo.resultfind=nil then exit;
  if (EdRepr_codigo.AsInteger=0) and ( pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,TiposDevolucao)=0 )
     and ( not Edcliente.isempty )
    then begin
    Avisoerro('Falta codigo do representante');
    exit;
  end;
  if ( EdComv_codigo.AsInteger=0 )  and ( not Edcliente.isempty )
    then begin
    Avisoerro('Falta codigo do tipo de venda');
    exit;
  end;
  bGravar.Enabled:=true;
//  bCancelar.Enabled:=true;
  bSair.Enabled:=true;
  PFinan.Enabled:=true;
//  PINs.Visible:=false;
  PINs.DisableEdits;
//  AtivaEdits;
  PRemessa.Enabled:=true;
//  EdComv_codigo.SetFocus;
  Esconde(PDescricaoProduto);

  if (OP='I') and (ECF='S') then begin
//    EdPort_codigo.enabled:=false;
//    EdPort_codigo.text:='001';
// 21.05.14 - vivan cobranca angela
//    EdPort_codigo.enabled:=false;
//    EdPort_codigo.valid;
{
    EdPort_codigo.text:='';
    if (Global.Topicos[1376]) then begin
      if trim(EdCliente.ResultFind.fieldbyname('clie_portadores').asstring)<>'' then begin
        FPortadores.SetaItems(EdPort_codigo,EdCliente.ResultFind.fieldbyname('clie_portadores').asstring);
        EdPort_codigo.ShowForm:='';
        EdPort_codigo.setfocus;
      end else begin
        Aviso('Portador(es) ainda n�o definidos neste cliente');
        Edcliente.SetFocus;
      end;
    end else
      }
// 23.08.14
        EdPort_codigo.setfocus;

//
    EdPerAcre.enabled:=false;
    EdPerDesco.enabled:=false;
    EdVlrAcre.enabled:=false;
    EdVlrdesco.enabled:=true;
//    EdVlrDesco.setfocus;
{
    if (EdCliente.asinteger=FGeral.GetConfig1AsInteger('clieconsumidor') ) then begin
      EdFpgt_codigo.text:=FGeral.getconfig1asstring('Fpgtoavista');
      if not EdFpgt_codigo.valid then begin
        EdFpgt_codigo.enabled:=true;
        EdFpgt_codigo.setfocus;
      end else begin
        EdFpgt_codigo.enabled:=false;
        EdFpgt_codigo.Next;
      end;
    end else begin
      EdFpgt_codigo.text:='';
      EdFpgt_codigo.enabled:=true;
      EdFpgt_codigo.setfocus;
    end;
}
  end else begin
    EdPerAcre.enabled:=true;
    EdPerDesco.enabled:=true;
    EdVlrAcre.enabled:=true;
    EdVlrdesco.enabled:=true;
    EdPort_codigo.enabled:=true;
    EdFpgt_codigo.enabled:=true;
// 26.05.14 - vivan cobran�a angela
    if (Global.Topicos[1413]) and (campoufentidade='clie_uf')  then begin
      if (trim (EdCliente.ResultFind.fieldbyname('Clie_portadores').asstring)<>'') then begin
        FPortadores.SetaItems(EdPort_codigo,EdCliente.ResultFind.fieldbyname('Clie_portadores').asstring );
        EdPort_codigo.ShowForm:='';
      end;
    end;

    EdPort_codigo.setfocus;
  end;

end;

procedure TFNotaSaida.EdFpgt_codigoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
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
// 17.05.18
  if (  Global.Topicos[1453] ) and ( EdFpgt_codigo.text<>FGeral.GetConfig1AsString('EdFpgtoavista') )
     and  ( PortadorCarteira )
    then begin

    EdFpgt_codigo.INvalid('Em portador carteira condi��o deve ser a vista');
    exit;

  end;

// 27.09.07
  if FGeral.GetGeraFinanceiro(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring)<>'S' then begin
    GridParcelas.clear;
    exit;
  end;
  if (op='I') or (EdFpgt_codigo.text<>EdFpgt_codigo.OldValue) then
    GridParcelas.Clear;

  if ( (FCondPagto.GetAvPz(EdFpgt_codigo.text)='P') and (OP='I') ) or (EdFpgt_codigo.text<>EdFpgt_codigo.OldValue ) then begin

    ListaPrazo :=TStringlist.create;
    n          :=FCondPagto.GetPrazos(EdFpgt_codigo.text,ListaPrazo);
    valoravista:=FGeral.GetValorAvista(Listaprazo);
    nparcelas  :=FCondPagto.GetNumeroParcelas(EdFpgt_codigo.text);
// 11.03.10
    if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoCompraProdutor )>0 then
      valortotal:=EdTotalNota.AsCurrency-vlrfunrural-vlrcotacapital
    else
/////////////////////////////////////////////////////////////////
// 11.03.05 - reges pegou bug quando tem parte a vista e mais de duas parcelas
      valortotal:=EdTotalNota.AsCurrency- valoravista;
    acumulado:=0;

    for p:=1 to nparcelas do begin

      venci:=FGeral.GetProximoDiaUtil(EdDtEmissao.Asdate+Inteiro(ListaPrazo[p-1]),Inteiro(ListaPrazo[p-1])) ;
// 24.05.12
     if FCondPagto.GetAvPz(EdFpgt_codigo.text)='P' then
// 24.09.08
        venci:=FGeral.GetVencimentoPadrao(venci);
// 11.02.20
      if Global.Topicos[1468] then

        GridParcelas.cells[0,p]:=formatdatetime('dd/mm/yyyy',venci)

      else

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

// 23.05.12 - criar parametro do sistema
  if (FCondPagto.GetAvPz(EdFpgt_codigo.text)='P') and (OP='I') and (Global.Topicos[1355]) then
     AtivaEditsParcelas(0);

  //  bgravarclick(FNotaSaida);   // para pode alterar direto no grid
end;

// 11.04.17 - para ficar como frete a cobrar
procedure TFNotaSaida.EdFreteValidate(Sender: TObject);
////////////////////////////////////////////////////////
begin
  if EdFrete.AsCurrency>0 then EdEmiDes.Text:='2';

end;

//////////////////////////////////////////////////////////////////////////////
procedure TFNotaSaida.bGravarClick(Sender: TObject);
////////////////////////////////////////////////////////////////
var Numero,romaneio,xpedido:integer;
    valorcomissao,valoravista:currency;
    QVePendencia,QVeNFe:Tsqlquery;
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
   //////////////////////
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

// 22.11.07
/////////////////////////////////////////////////////////////
   procedure GeraRequisicaoAlmox;
/////////////////////////////////////////////////////////////
   var i:integer;
       QEstoque,QEstoqueqtde,QGrade:TSqlquery;
       produto,gravar,coresincluidas,tamanhosincluidos,produtonovo,sqlcor,sqltamanho:string;
       Grupo,subgrupo,Familia,codcor,codtam,tamcodigo,xproduto,codcornovo,codtamnovo,xprodutonovo,codtamg:integer;

       procedure ChecaCor(xcorid:string);
       var QCor:TSqlquery;
           Corpo:TStrings;
       begin
// 28.10.09 - colocado query pois estava incluindo cores mesmo ja cadastradas
         if (trim(xcorid)<>'') and (trim(xcorid)<>'0') and (codcornovo>0) then begin
           xcorid:=TratamentotoCor(xcorid);
           Qcor:=sqltoquery('select * from cores where core_descricao='+stringtosql(trim(xcorid))+
                             ' order by core_descricao');
           if not Arq.TCores.active then Arq.TCores.open;
           Arq.TCores.First;
//           if not Arq.TCores.Locate('core_descricao',xcorid,[]) then begin
// 17.11.09
           if (codcornovo=0) then begin
             Corpo.Append(xcorid+' Obra '+PReq.obra);
             FGeral.EnviaEMail('andre@tokefinal.com.br','codigo cor zerado','',corpo)
           end;
           if (QCor.eof) and (codcornovo>0) then begin
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
//             codcor:=Arq.TCores.fieldbyname('core_codigo').asinteger;
             codcor:=QCor.fieldbyname('core_codigo').asinteger;
           FGeral.FechaQuery(QCor);
         end;
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
             tamanhosincluidos:=tamanhosincluidos+strzero(codtam,3)+';';
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
      tamanhosincluidos:='';
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
//          Sistema.SetField('esto_unidade','BR');
//          Sistema.SetField('esto_unidade','KG');
// 28.04.08
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
          QEstoqueQtde:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+EdUnid_codigo.assql+
                                       ' and esqt_esto_codigo='+stringtosql(strzero(xproduto,tamcodigo))+' and esqt_status=''N''');
          if QEstoqueQTde.eof then begin
              Sistema.Insert('EstoqueQtde');
              Sistema.Setfield('esqt_status','N');
              Sistema.Setfield('esqt_unid_codigo',EdUNid_codigo.text);
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
              Sistema.Setfield('esqt_cfis_codigoest',FUnidades.GetFiscalDentro(EdUNid_codigo.text));
              Sistema.Setfield('esqt_cfis_codigoforaest',FUnidades.GetFiscalFora(EdUNid_codigo.text));
              Sistema.Setfield('esqt_sitt_codestado',FUnidades.GetSittDentro(EdUNid_codigo.text) );
              Sistema.Setfield('esqt_sitt_forestado',FUnidades.GetSittFora(EdUNid_codigo.text));
              Sistema.Setfield('esqt_usua_codigo',Global.Usuario.codigo);
              Sistema.Post('');
              Sistema.commit;
              gravar:='S';
//////////////////              xproduto:=xprodutonovo;
              FGeral.Fechaquery(QEstoqueqtde);
// para usar na gravacao da nova grade...
              QEstoqueQtde:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+EdUnid_codigo.assql+
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
        Sistema.Insert('movestoque');
        Sistema.SetField('move_esto_codigo',strzero(xproduto,tamcodigo));
// 01.10.09 - componentes nao tem grade - Robson e fran pois tem codigo proprio
        if QEstoque.fieldbyname('esto_grup_codigo').AsInteger=FGeral.GetConfig1AsInteger('Grupocompon') then begin
          codtam:=0;codcor:=0;
        end;
        Sistema.SetField('move_tama_codigo',codtam);
        Sistema.SetField('move_core_codigo',codcor);
        Sistema.SetField('move_copa_codigo',0);
        Sistema.SetField('move_transacao',transacao);
        Sistema.SetField('move_operacao',FGeral.GetOperacao);
        Sistema.SetField('move_numerodoc',ObratoNumero(PReq.obra));
        Sistema.SetField('move_status','R');
        Sistema.SetField('move_tipomov',Global.CodRequisicaoAlmox);
        Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
        Sistema.SetField('move_tipo_codigo',edCliente.AsInteger);
        Sistema.SetField('move_tipocad','C');
        Sistema.SetField('move_repr_codigo',EdRepr_codigo.asinteger);
        Sistema.SetField('move_qtde',PReq.qtde);
// 08.04.08
//        Sistema.SetField('move_qtde',PReq.peso);
        Sistema.SetField('move_datalcto',Sistema.Hoje);
        Sistema.SetField('move_datacont',Sistema.Hoje);
        Sistema.SetField('move_datamvto',EdDtEmissao.asdate);
        Sistema.SetField('move_qtderetorno',PReq.qtde);
// 08.04.08
//        Sistema.SetField('move_qtderetorno',PReq.peso);
        Sistema.SetField('move_custo',PREq.unitario);
        Sistema.SetField('move_custoger',PREq.unitario);
        Sistema.SetField('move_customedio',PREq.unitario);
        Sistema.SetField('move_customeger',PREq.unitario);
//        Sistema.SetField('move_cst',Grid.Cells[grid.getcolumn('move_cst'),linha]);
//        Sistema.SetField('move_aliicms',texttovalor(Grid.Cells[grid.getcolumn('move_aliicms'),linha]));
        Sistema.SetField('move_venda',PREq.unitario);
        Sistema.SetField('move_grup_codigo',QEstoque.fieldbyname('esto_grup_codigo').AsInteger);
        Sistema.SetField('move_sugr_codigo',QEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
        Sistema.SetField('move_fami_codigo',QEstoque.fieldbyname('esto_fami_codigo').AsInteger);
        Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
        Sistema.SetField('move_pecas',PReq.pecas);
        Sistema.SetField('move_nroobra',ObratoNumero(PReq.obra));
// 21.01.08
        Sistema.SetField('move_peso',PReq.peso);
        Sistema.SetField('move_pesosobra',PReq.pesosobra);

//        Sistema.SetField('move_perdesco',texttovalor(Grid.Cells[grid.getcolumn('move_perdesco'),linha]));
//        Sistema.SetField('move_vendabru',texttovalor(Grid.Cells[grid.getcolumn('move_vendabru'),linha]));
//          Sistema.SetField('move_remessas',remessas);
//          Sistema.SetField('move_clie_codigo',moes_clie_codigo);
//        Sistema.SetField('move_aliipi',texttovalor(Grid.Cells[grid.getcolumn('move_aliipi'),linha]));
//        Sistema.SetField('move_vendamin',texttovalor(Grid.Cells[grid.getcolumn('move_vendamin'),linha]));
//        Sistema.SetField('move_redubase',texttovalor(Grid.Cells[grid.getcolumn('move_redubase'),linha]));
        Sistema.post;
        Sistema.commit;
// 29.04.08 - checa se precisa gravar nova grade de tamanho+cor - 'BARRAS INTEIRAS'
/////////////////////////////////////
//        if  (codtam+codcor)>0  then begin
// 02.06.10 - gerar somente de tamanhos maior ou igual q 4 metros
        if  ( (codtam+codcor)>0 ) and ( FTamanhos.GetComprimento(codtam)>=3000 )  then begin
            if Codcor>0 then
              sqlcor:=' and esgr_core_codigo='+inttostr(Codcor)
            else
              sqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
            if Codtam>0 then
              sqltamanho:=' and esgr_tama_codigo='+inttostr(Codtam)
            else
              sqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
            QGrade:=sqltoquery('select * from estgrades where esgr_unid_codigo='+EdUnid_codigo.assql+
                                         ' and esgr_esto_codigo='+stringtosql(strzero(xproduto,tamcodigo))+' and esgr_status=''N'''+
                                         sqlcor+sqltamanho);
            if QGrade.eof then begin
              Sistema.Insert('Estgrades');
              Sistema.Setfield('esgr_status','N');
              Sistema.Setfield('esgr_esto_codigo',strzero(xproduto,tamcodigo));
              Sistema.Setfield('esgr_unid_codigo',EdUnid_codigo.text);
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
              Sistema.Setfield('esgr_dtultvenda',EdDtEmissao.asdate);
              Sistema.Setfield('esgr_dtultcompra',EdDtEmissao.asdate);
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

// 14.01.08 - grava a Ordem de Producao
//////////////////////////////////////////////
      dbforcam.close;
      dbforcam.FileName:=localexterno+'OBCALCP.DBF';
//        dbforcam.TableName:=localexterno+'OBCALCP.DBF';
      try
          dbforcam.Open;
      except
//          Avisoerro('N�o foi poss�vel abrir arquivo '+dbforcam.TableName);
          Avisoerro('N�o foi poss�vel abrir arquivo '+dbforcam.FileName);
          exit;
      end;
      if ListaReq.Count>0 then begin
        PReq:=ListaReq[1];
        Sistema.beginprocess('Checando os cortes da obra '+PReq.obra);
      end;

      while (not dbforcam.Eof) and (ListaReq.Count>0) do begin
          if dbforcam.fieldbyname('codigo').asstring=PReq.obra then begin
            QEstoque:=sqltoquery('select * from estoque where esto_referencia='+stringtosql(dbforcam.fieldbyname('CODPERF').asstring));
            if not QEstoque.eof then begin
              Sistema.Insert('movproducao');
              Sistema.SetField('movp_esto_codigo',QEstoque.fieldbyname('esto_codigo').asstring);
              Checacor(dbforcam.fieldbyname('id').asstring);
              codtam:=GetTamanho(dbforcam.fieldbyname('CODPERF').asstring);
              Checatamanho(codtam);
              Sistema.SetField('movp_tama_codigo',codtam);
              Sistema.SetField('movp_core_codigo',codcor);
              Sistema.SetField('movp_transacao',transacao);
              Sistema.SetField('movp_operacao',FGeral.GetOperacao);
              Sistema.SetField('movp_numerodoc',ObratoNumero(PReq.obra));
              Sistema.SetField('movp_status','N');
              Sistema.SetField('movp_tipomov',Global.CodOrdemProducao);
              Sistema.SetField('movp_unid_codigo',EdUnid_codigo.text);
              Sistema.SetField('movp_tipo_codigo',edCliente.AsInteger);
              Sistema.SetField('movp_tipocad','C');
              Sistema.SetField('movp_repr_codigo',EdRepr_codigo.asinteger);
              Sistema.SetField('movp_qtdegeral',PReq.qtde);
              Sistema.SetField('movp_datalcto',Sistema.Hoje);
              Sistema.SetField('movp_datamvto',EdDtEmissao.asdate);
              Sistema.SetField('movp_qtdeop',dbforcam.fieldbyname('QTDE').ascurrency);
              Sistema.SetField('movp_qtdeprod',0);
              Sistema.SetField('movp_venda',0);
              Sistema.SetField('movp_grup_codigo',QEstoque.fieldbyname('esto_grup_codigo').AsInteger);
              Sistema.SetField('movp_sugr_codigo',QEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
              Sistema.SetField('movp_fami_codigo',QEstoque.fieldbyname('esto_fami_codigo').AsInteger);
              Sistema.SetField('movp_usua_codigo',Global.Usuario.codigo);
              Sistema.SetField('movp_pecas',0);
              Checatamanho(dbforcam.fieldbyname('tam').asinteger);
              Sistema.SetField('movp_tamag_codigo',codtam);
              Sistema.SetField('movp_coreg_codigo',codcor);
              Sistema.SetField('movp_locales','');
              Sistema.SetField('movp_nroobra',ObratoNumero(PReq.obra));
              Sistema.SetField('movp_horamvto',timetostr(now));
              Sistema.SetField('movp_localobra',Getlocalobra(dbforcam.fieldbyname('ITEM').asstring));//  PReq.localobra varchar(20),
              Sistema.SetField('movp_operacaoop',dbforcam.fieldbyname('CORTE').asstring); // varchar(50),
              Sistema.SetField('movp_maqu_codigo',0);
              Sistema.post;
              Sistema.commit;
// 29.04.08 - checa se precisa gravar nova grade de tamanho+cor - 'BARRAS EM PEDA�OS'
/////////////////////////////////////
{ - retirado em 22.10.08 pois parece esta 'gerando demais'
              if  (codtam+codcor)>0 then begin
                  QEstoqueQtde:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+EdUnid_codigo.assql+
                                       ' and esqt_esto_codigo='+stringtosql(QEstoque.fieldbyname('esto_codigo').asstring)+' and esqt_status=''N''');
                  if Codcor>0 then
                    sqlcor:=' and esgr_core_codigo='+inttostr(Codcor)
                  else
                    sqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
                  if Codtam>0 then
                    sqltamanho:=' and esgr_tama_codigo='+inttostr(Codtam)
                  else
                    sqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
                  QGrade:=sqltoquery('select * from estgrades where esgr_unid_codigo='+EdUnid_codigo.assql+
                                               ' and esgr_esto_codigo='+stringtosql(QEstoque.fieldbyname('esto_codigo').asstring)+' and esgr_status=''N'''+
                                               sqlcor+sqltamanho);
                  if QGrade.eof then begin
                    Sistema.Insert('Estgrades');
                    Sistema.Setfield('esgr_status','N');
                    Sistema.Setfield('esgr_esto_codigo',QEstoque.fieldbyname('esto_codigo').asstring);
                    Sistema.Setfield('esgr_unid_codigo',EdUnid_codigo.text);
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
                    Sistema.Setfield('esgr_dtultvenda',EdDtEmissao.asdate);
                    Sistema.Setfield('esgr_dtultcompra',EdDtEmissao.asdate);
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
                  FGeral.FechaQuery(QEstoqueQtde);
              end;  // - checagem da grade
              }
//////////////////
            end;
          end;
          dbforcam.Next;
      end;
      dbforcam.close;  // 08.08.08
////////////////////////

      if ListaReq.Count>=1 then begin
        Sistema.Insert('movesto');
        Sistema.SetField('moes_transacao',Transacao);
        Sistema.SetField('moes_operacao',FGeral.GetOperacao);
        Sistema.SetField('moes_status','R');
        Sistema.SetField('moes_numerodoc',ObratoNumero(PReq.obra));
        Sistema.SetField('moes_romaneio',0);
        Sistema.SetField('moes_tipomov',Global.CodRequisicaoAlmox);
        Sistema.SetField('moes_comv_codigo',0);
        Sistema.SetField('moes_unid_codigo',EdUnid_codigo.text);
        Sistema.SetField('moes_tipo_codigo',Edcliente.asinteger);
        Sistema.SetField('moes_estado',EdCliente.ResultFind.fieldbyname('clie_uf').AsString);
        Sistema.SetField('moes_tipocad','C');
        Sistema.SetField('moes_repr_codigo',EdRepr_codigo.asinteger);
//        Sistema.SetField('moes_cida_codigo',Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger);
        Sistema.SetField('moes_cida_codigo',EdCliente.ResultFind.fieldbyname('clie_cida_codigo_res').AsInteger);
        Sistema.SetField('moes_datalcto',Sistema.Hoje);
        Sistema.SetField('moes_datamvto',Sistema.hoje);
        Sistema.SetField('moes_DataCont',Sistema.hoje);
        Sistema.SetField('moes_dataemissao',EdDtemissao.asdate);
        Sistema.SetField('moes_vlrtotal',0);
        Sistema.SetField('moes_tabp_codigo',0);
        Sistema.SetField('moes_tabaliquota',0);
        Sistema.SetField('moes_natf_codigo','');
        Sistema.SetField('moes_freteciffob','1');
        Sistema.SetField('moes_baseicms',0);
        Sistema.SetField('moes_valoricms',0);
        Sistema.SetField('moes_basesubstrib',0);
        Sistema.SetField('moes_valoricmssutr',0);
        Sistema.SetField('moes_frete',0);
        Sistema.SetField('moes_vispra','V');
        Sistema.SetField('moes_especie','');
        Sistema.SetField('moes_serie','');
        Sistema.SetField('moes_tran_codigo',0);
        Sistema.SetField('Moes_qtdevolume',0);
        Sistema.SetField('Moes_especievolume','');
        Sistema.SetField('moes_totprod',0);
        Sistema.SetField('moes_valortotal',0);
        Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
        Sistema.SetField('Moes_Perdesco',0);
        Sistema.SetField('Moes_Peracres',0);
        Sistema.SetField('moes_valoravista',0);
        Sistema.SetField('moes_remessas','');
        Sistema.SetField('moes_mensagem','');
//        Sistema.SetField('moes_pedido',pedido);
//        Sistema.SetField('moes_pesoliq',pesoliq);
//        Sistema.SetField('moes_pesobru',pesobru);
//          Sistema.SetField('moes_clie_codigo',moes_clie_codigo);
//        Sistema.SetField('moes_fpgt_codigo',Condicao);
//        Sistema.SetField('moes_valoripi',Valoripi);
//        Sistema.SetField('lmoes_freteuni',Freteuni);
        Sistema.post;
        Sistema.commit;
      end;

   end;

// 24.01.08
   procedure GeraItensdaObra;
   /////////////////////////////

       function ObratoNUmero(obra:string):integer;
       /////////////////////////////////////////////
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

   var POrcam:^Torcam;
       x:integer;
       QEstoque:TSqlquery;
   begin
     for x:=0 to LIstaOrcam.Count-1 do begin
       POrcam:=ListaOrcam[x];
       QEstoque:=sqltoquery('select * from estoque where esto_referencia='+stringtosql(POrcam.codigopea));
       Sistema.Insert('movobrasdet');
       Sistema.SetField('movo_transacao',transacao);
       Sistema.SetField('movo_operacao',FGeral.GetOperacao);
       Sistema.SetField('movo_numerodoc',ObratoNumero(POrcam.obra));
       Sistema.SetField('movo_status','N');
       Sistema.SetField('movo_tipomov',Global.CodItemObra);
       Sistema.SetField('movo_unid_codigo',EdUnid_codigo.text);
       Sistema.SetField('movo_esto_codigo',QEstoque.fieldbyname('esto_codigo').asstring);
//       Sistema.SetField('movo_tama_codigo' numeric(3),
//       Sistema.SetField('movo_core_codigo numeric(3),
       Sistema.SetField('movo_tipo_codigo',edCliente.AsInteger);
       Sistema.SetField('movo_tipocad','C');
       Sistema.SetField('movo_repr_codigo',EdRepr_codigo.asinteger);
       Sistema.SetField('movo_qtdegeral',POrcam.qtde);
       Sistema.SetField('movo_estoque',0);
       Sistema.SetField('movo_datalcto',Sistema.hoje);
       Sistema.SetField('movo_datamvto',Sistema.hoje);
       Sistema.SetField('movo_qtdeop',POrcam.qtde);
       Sistema.SetField('movo_qtdeprod',0);
       Sistema.SetField('movo_venda',0);
       Sistema.SetField('movo_usua_codigo',Global.usuario.codigo);
       Sistema.SetField('movo_area',(POrcam.l*Porcam.h)/1000000);
       Sistema.SetField('movo_peso',POrcam.peso);
       Sistema.SetField('movo_largura',POrcam.l);
       Sistema.SetField('movo_altura',POrcam.h);
       Sistema.SetField('movo_nroobra',ObratoNumero(POrcam.obra));
       Sistema.SetField('movo_horamvto',Timetostr(now));
       Sistema.SetField('movo_localobra',POrcam.localobra);
       Sistema.SetField('movo_descricaoobra',POrcam.localizacao);
       Sistema.Post();
       Sistema.commit;

     end;
   end;

// 04.12.14
   procedure GeraItensdaObradoPedido;
   /////////////////////////////

   var QEstoque:TSqlquery;
       x:integer;
   begin
     for x:=1 to Grid.rowcount do begin
       if trim(Grid.cells[Grid.getcolumn('move_esto_codigo'),x])<>'' then begin
         QEstoque:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(Grid.cells[Grid.getcolumn('move_esto_codigo'),x]));
         Sistema.Insert('movobrasdet');
         Sistema.SetField('movo_transacao',transacao);
         Sistema.SetField('movo_operacao',FGeral.GetOperacao);
         Sistema.SetField('movo_numerodoc',EdNumerodoc.asinteger);
         Sistema.SetField('movo_status','N');
         Sistema.SetField('movo_tipomov',Global.CodItemObra);
         Sistema.SetField('movo_unid_codigo',EdUnid_codigo.text);
         Sistema.SetField('movo_esto_codigo',QEstoque.fieldbyname('esto_codigo').asstring);
  //       Sistema.SetField('movo_tama_codigo' numeric(3),
  //       Sistema.SetField('movo_core_codigo numeric(3),
         Sistema.SetField('movo_tipo_codigo',edCliente.AsInteger);
         Sistema.SetField('movo_tipocad','C');
         Sistema.SetField('movo_repr_codigo',EdRepr_codigo.asinteger);
         Sistema.SetField('movo_qtdegeral',Texttovalor(Grid.cells[Grid.getcolumn('move_qtde'),x]));
         Sistema.SetField('movo_estoque',0);
         Sistema.SetField('movo_datalcto',Sistema.hoje);
         Sistema.SetField('movo_datamvto',Sistema.hoje);
         Sistema.SetField('movo_qtdeop',Texttovalor(Grid.cells[Grid.getcolumn('move_qtde'),x]));
         Sistema.SetField('movo_qtdeprod',0);
         Sistema.SetField('movo_venda',0);
         Sistema.SetField('movo_usua_codigo',Global.usuario.codigo);
         Sistema.SetField('movo_area',0);
         Sistema.SetField('movo_peso',0);
         Sistema.SetField('movo_largura',0);
         Sistema.SetField('movo_altura',0);
         Sistema.SetField('movo_nroobra',EdNumerodoc.asinteger);
         Sistema.SetField('movo_horamvto',Timetostr(now));
         Sistema.SetField('movo_localobra','');
         Sistema.SetField('movo_descricaoobra','');
         Sistema.Post();
         Sistema.commit;
         QEstoque.close;
       end;
     end;
   end;
//////////////////////


/////////////////////////////////////////////////////////////////////////////////
   procedure BaixaOrcamento; // 08.09.10
/////////////////////////////////////////////////////////////////////////////////
   var aux:string;
   begin
      aux:= copy(EdPedido.Text,1,2)+'-'+copy(EdPedido.Text,3,4)+'-'+copy(EdPedido.Text,7,2);
      Sistema.Edit('orcamentos');
      Sistema.SetField('Orca_datafecha',EdDtEmissao.asdate);
      Sistema.Post('Orca_nroobra='+Stringtosql(aux) );
      Sistema.commit;
   end;

// 28.11.07
/////////////////////////////////////////////////////////////////////////////////
   procedure GeraBaixaEstoqueProcesso;
/////////////////////////////////////////////////////////////////////////////////
   var POrcam:^Torcam;
       PReq:^TRequisicao;
       PBarras:^TBarras;
       ListaOrcam,ListaBarras:TList;
       x,codcor,codtamanho,xcodtamanho:integer;
       obra,refnaoachados,sqlcor,sqltamanho:string;
       Qe,QGrade:TSqlquery;
       xqtde:currency;

      procedure LeTamanhosBarras;
      var i:integer;
          achou:boolean;
      begin
        achou:=false;
        for i:=0 to ListaBarras.count-1 do begin
          PBarras:=ListaBarras[i];
          if PBarras.codigopea=dbforcam.FieldByName('CODPERF').asstring then begin
            achou:=true;
            break;
          end;
        end;
        if not achou then begin
          New(PBarras);
          PBarras.codigopea:=dbforcam.FieldByName('CODPERF').asstring;
          PBarras.tamanho:=dbforcam.FieldByName('BARRA').asinteger;
          ListaBarras.Add(PBarras);
        end;
      end;

      function GetTamanhoBarra(codigo:string):integer;
      var i:integer;
      begin
        result:=0;
        for i:=0 to ListaBarras.count-1 do begin
          PBarras:=ListaBarras[i];
          if PBarras.codigopea=codigo then begin
            result:=PBarras.tamanho;
            break;
          end;
        end;
      end;

      procedure BuscaItens(produto:string);
      var i:integer;
      begin
          New(POrcam);
          POrcam.obra:=dbforcam.fieldbyname('CODIGO').Asstring;
          POrcam.produto:=produto;
          POrcam.item:=strzero(dbforcam.fieldbyname('NUMITEM').Asinteger,2);
          POrcam.qtde:=dbforcam.fieldbyname('QTDE').AsFLOAT;
          POrcam.l:=dbforcam.fieldbyname('L').AsFLOAT;
          POrcam.h:=dbforcam.fieldbyname('H').AsFLOAT;
          POrcam.unitario:=0;
          POrcam.descricao:=dbforcam.fieldbyname('DESCRICAO').Asstring;
          POrcam.codigopea:=dbforcam.fieldbyname('CODESQD').Asstring;
          ListaOrcam.add(POrcam);
      end;

      procedure BuscaItensPerfis(produto:string);
      var i,p:integer;
          achou:boolean;
      begin
          for i:=0 to ListaOrcam.Count-1 do begin
            POrcam:=ListaOrcam[i];
            if ( strtoint(Porcam.item)=strtointdef(dbforcam.fieldbyname('ITEM').Asstring,0) ) then begin
              achou:=false;
              for p:=0 to ListaReq.Count-1 do begin
                PReq:=ListaReq[p];
                if PReq.produto=dbforcam.fieldbyname('CODPERF').Asstring then begin
                  achou:=true;
                  break;
                end;
              end;
              if not achou then begin
                New(PReq);
                PREq.obra:=dbforcam.fieldbyname('CODIGO').Asstring;
                PReq.produto:=dbforcam.fieldbyname('CODPERF').Asstring;
                PReq.qtde:=(dbforcam.fieldbyname('QTDE').AsFLOAT*dbforcam.fieldbyname('TAM').AsInteger)/1000;
                PReq.unitario:=0;
                PReq.descricao:='';
                PReq.codigopea:=dbforcam.fieldbyname('CODPERF').Asstring;
                PReq.peso:=dbforcam.fieldbyname('PESO').Asfloat;
                PReq.corid:=dbforcam.fieldbyname('ID').AsString;
                PReq.tamanho:=dbforcam.fieldbyname('TAM').Asinteger;
                PReq.pecas:=0;
                ListaReq.add(PReq);
              end else begin
                PReq.qtde:=PReq.qtde+(dbforcam.fieldbyname('QTDE').AsFLOAT*dbforcam.fieldbyname('TAM').AsInteger);
              end;
            end;
          end;
      end;

      procedure BuscaItensAcessorios(produto:string);
      var i,p:integer;
          achou:boolean;
      begin
          for i:=0 to ListaOrcam.Count-1 do begin
            POrcam:=ListaOrcam[i];
            if ( strtoint(Porcam.item)=strtointdef(dbforcam.fieldbyname('ITEM').Asstring,0) ) then begin
              achou:=false;
              for p:=0 to ListaReq.Count-1 do begin
                PReq:=ListaReq[p];
                if PReq.produto=dbforcam.fieldbyname('CODACES').Asstring then begin
                  achou:=true;
                  break;
                end;
              end;
              if not achou then begin
                New(PReq);
                PREq.obra:=dbforcam.fieldbyname('CODIGO').Asstring;
                PReq.produto:=dbforcam.fieldbyname('CODACES').Asstring;
                PReq.qtde:=dbforcam.fieldbyname('QTDE').AsFLOAT;
                PReq.unitario:=0;
                PReq.descricao:='';
                PReq.codigopea:=dbforcam.fieldbyname('CODACES').Asstring;
                PReq.peso:=dbforcam.fieldbyname('PESO').Asfloat;
                PReq.corid:=dbforcam.fieldbyname('TRAT').AsString;
                PReq.tamanho:=0;
                PReq.pecas:=0;  // 09.10.08
                ListaReq.add(PReq);
              end else begin
                PReq.qtde:=PReq.qtde+dbforcam.fieldbyname('QTDE').AsFLOAT;
              end;
            end;
          end;

      end;

      function GetCodigoTamanhoReq:integer;
      var Q:TSqlquery;
      begin
        result:=0;
        Q:=sqltoquery('select move_tama_codigo from movestoque where move_status=''R'''+
                      ' and move_esto_codigo='+Stringtosql(QE.fieldbyname('esto_codigo').asstring)+
                      ' and '+fGeral.GetIN('move_numerodoc',EdVendasmc.Text,'C')+
                      ' and move_tipomov='+Stringtosql(Global.CodRequisicaoAlmox)+
                      ' and move_core_codigo='+inttostr(codcor)+
                      ' and move_unid_codigo='+EdUnid_codigo.AsSql);
        if not Q.Eof then
          result:=Q.fieldbyname('move_tama_codigo').asinteger;
        FGeral.FechaQuery(Q);
      end;


////////////////////////////////////////////
   begin     // BAIXA ESTOQUE EM PROCESSO
/////////////////////////////////////
//      localexterno:=FGeral.Getconfig1asstring('localpea');
      localexterno:=FGeral.GetLocalExternoPea;
      if trim(localexterno)='' then begin
////        Avisoerro('Falta configurar o local do PEA nas configura��o do sistema');
        exit;
      end else begin
        dbforcam.FileName:=localexterno+'OBITENS.DBF';
//        dbforcam.TableName:=localexterno+'OBITENS.DBF';
        try
          dbforcam.Open;
        except
//          Avisoerro('N�o foi poss�vel abrir arquivo '+dbforcam.TableName);
          Avisoerro('N�o foi poss�vel abrir arquivo '+dbforcam.FileName);
          exit;
        end;
        Sistema.beginprocess('Pesquisando obra '+EdVendasmc.text);
        Grid.clear;
        ListaOrcam:=TList.create;
        ListaReq:=TList.create;
//        obra:='VIMS-'+copy(EdVendasmc.text,1,2)+'-'+copy(EdVendasmc.text,3,4)+'-'+copy(EdVendasmc.text,7,2);
        obra:=nrobra+copy(EdVendasmc.text,1,2)+'-'+copy(EdVendasmc.text,3,4)+'-'+copy(EdVendasmc.text,7,2);
        while not dbforcam.Eof do begin
          if (dbforcam.FieldByName('codigo').asstring=obra) and ( pos(trim(dbforcam.fieldbyname('CODESQD').Asstring),produtosnota)>0 ) then
            BuscaItens(dbforcam.fieldbyname('CODESQD').Asstring);
          dbforcam.Next;
        end;
        dbforcam.close;
// le tamanhos das barras de perfil da obra
        Sistema.beginprocess('Checando os tamanhos das barras da obra '+EdVendasmc.text);
        ListaBarras:=Tlist.create;
//        dbforcam.TableName:=localexterno+'OBAPROV.DBF';
        dbforcam.FileName:=localexterno+'OBAPROV.DBF';
        try
          dbforcam.Open;
        except
//          Avisoerro('N�o foi poss�vel abrir arquivo '+dbforcam.TableName);
          Avisoerro('N�o foi poss�vel abrir arquivo '+dbforcam.FileName);
          exit;
        end;
        while not dbforcam.Eof do begin
          if dbforcam.FieldByName('codigo').asstring=obra then
            LeTamanhosBarras;
          dbforcam.Next;
        end;

        dbforcam.close;
//        dbforcam.TableName:=localexterno+'OBCALCP.DBF';
        dbforcam.FileName:=localexterno+'OBCALCP.DBF';
        try
          dbforcam.Open;
        except
//          Avisoerro('N�o foi poss�vel abrir arquivo '+dbforcam.TableName);
          Avisoerro('N�o foi poss�vel abrir arquivo '+dbforcam.FileName);
          exit;
        end;
        Sistema.beginprocess('Checandos os perfis da obra '+EdVendasmc.text);
        while not dbforcam.Eof do begin
          if dbforcam.FieldByName('codigo').asstring=obra then
            BuscaItensPerfis(dbforcam.fieldbyname('CODPERF').Asstring);
          dbforcam.Next;
        end;
        dbforcam.close;
//        dbforcam.TableName:=localexterno+'OBCALCA.DBF';
        dbforcam.FileName:=localexterno+'OBCALCA.DBF';
        try
          dbforcam.Open;
        except
//          Avisoerro('N�o foi poss�vel abrir arquivo '+dbforcam.TableName);
          Avisoerro('N�o foi poss�vel abrir arquivo '+dbforcam.FileName);
          exit;
        end;
        Sistema.beginprocess('Checandos os acess�rios da obra '+EdVendasmc.text);
        while not dbforcam.Eof do begin
          if dbforcam.FieldByName('codigo').asstring=obra then
            BuscaItensAcessorios(dbforcam.fieldbyname('CODACES').Asstring);
          dbforcam.Next;
        end;
        dbforcam.close;

        if listaOrcam.Count>0 then begin
          Sistema.Insert('Movesto');
          Sistema.SetField('moes_transacao',Transacao);
          Sistema.SetField('moes_operacao',FGeral.GetOperacao);
          Sistema.SetField('moes_status','N');
          Sistema.SetField('moes_numerodoc',EdNumerodoc.asinteger);
          Sistema.SetField('moes_tipomov',Global.CodSaidaprocesso);
    //      Sistema.SetField('moes_comv_codigo',codigomov);
          Sistema.SetField('moes_unid_codigo',EdUnid_codigo.text);
          Sistema.SetField('moes_tipo_codigo',EdCliente.AsInteger);
          Sistema.SetField('moes_estado',Global.UFUnidade);
          Sistema.SetField('moes_tipocad','C');
    //      Sistema.SetField('moes_repr_codigo',Representante);
          Sistema.SetField('moes_cida_codigo',EdUNid_codigo.ResultFind.fieldbyname('unid_cida_codigo').AsInteger);

          Sistema.SetField('moes_datalcto',Sistema.Hoje);
          Sistema.SetField('moes_datamvto',Sistema.Hoje);
          Sistema.SetField('moes_DataCont',Sistema.Hoje);
          Sistema.SetField('moes_dataemissao',Sistema.Hoje);
          Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
          Sistema.SetField('moes_remessas',produtosnota);
    //      Sistema.SetField('moes_pesoliq',pesoliq);
    //      Sistema.SetField('moes_pesobru',pesobru);
          Sistema.Post();
        end;

        if not Arq.TCores.active then Arq.TCores.open;
        if not Arq.TTamanhos.active then Arq.TTamanhos.open;
        refnaoachados:='';
        for x:=0 to ListaReq.Count-1 do begin
          PReq:=ListaReq[x];
          Qe:=sqltoquery('select * from estoqueqtde inner join estoque on (esto_codigo=esqt_esto_codigo)'+
                         ' where esto_referencia='+stringtosql(trim(PReq.codigopea))+
                         ' and esqt_unid_codigo='+EdUnid_codigo.AsSql+
                         ' and esqt_status=''N''');
          if not Qe.eof then begin
            Sistema.Insert('movestoque');
            Sistema.SetField('move_esto_codigo',QE.fieldbyname('esto_codigo').asstring);
            Sistema.SetField('move_status','N');
            Sistema.SetField('move_transacao',transacao);
            Sistema.SetField('move_unid_codigo',EdUNid_codigo.text);
//            if Arq.Tcores.Locate('core_descricao',PReq.corid,[]) then
            codcor:=0;codtamanho:=0;
            if Arq.Tcores.Locate('core_descricao',TratamentotoCor(PReq.corid),[]) then begin
              Sistema.SetField('move_core_codigo',Arq.Tcores.fieldbyname('core_codigo').asinteger );
              codcor:=Arq.Tcores.fieldbyname('core_codigo').asinteger;
            end;
// 16.10.09
            if Arq.TTamanhos.Locate('tama_descricao',inttostr(PReq.tamanho),[]) then begin
              codtamanho:=Arq.TTamanhos.fieldbyname('tama_codigo').asinteger;
// vai buscar na requisicao qual o codigo do tamanho da barra solicitada pelo pea
              if (PReq.tamanho>0) and (trim(PReq.corid)<>'') then begin
                xcodtamanho:=GetCodigoTamanhoReq;
                if xcodtamanho>0 then
                  codtamanho:=xcodtamanho;
              end;
              Sistema.SetField('move_tama_codigo',codtamanho);
            end;
// 16.10.09
//            if GetTamanhoBarra(PReq.codigopea)>0 then
//              xqtde:=PReq.qtde/GetTamanhoBarra(PReq.codigopea)
//            else
              xqtde:=PReq.qtde;
            Sistema.SetField('move_qtde',xqtde);
// 08.04.08
//            Sistema.SetField('move_qtde',PReq.peso);
            Sistema.SetField('move_pecas',PReq.pecas);

            Sistema.SetField('move_operacao',FGeral.GetOperacao);
            Sistema.SetField('move_tipo_codigo',EdCliente.asinteger);
            Sistema.SetField('move_tipocad','C');
            Sistema.SetField('move_numerodoc',EdNumerodoc.asinteger);
            Sistema.SetField('move_tipomov',Global.CodSaidaprocesso);
            Sistema.SetField('move_datalcto',sistema.hoje);
            Sistema.SetField('move_datamvto',sistema.hoje);
            Sistema.SetField('move_datacont',sistema.hoje);
            Sistema.SetField('move_usua_codigo',Global.Usuario.Codigo);
            Sistema.SetField('move_grup_codigo',Qe.fieldbyname('esto_grup_codigo').asinteger);
            Sistema.SetField('move_sugr_codigo',Qe.fieldbyname('esto_sugr_codigo').asinteger);
            Sistema.SetField('move_fami_codigo',Qe.fieldbyname('esto_fami_codigo').asinteger);
            Sistema.SetField('move_locales',Global.EstoqueemProcesso);
            Sistema.SetField('move_remessas',produtosnota);
            Sistema.post;
            FGEral.MovimentaQtdeEstoque(QE.fieldbyname('esto_codigo').asstring,EdUnid_codigo.text,'S',Global.CodSaidaprocesso,xqtde,QE);
            if (codcor+codtamanho)>0 then begin
              sqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
              sqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
              if (codcor>0) and (codtamanho>0) then begin
                  sqlcor:=' and esgr_core_codigo='+inttostr(codcor);
                  sqltamanho:=' and esgr_tama_codigo='+inttostr(codtamanho);
              end else if (codcor>0) then begin
                  sqlcor:=' and esgr_core_codigo='+inttostr(codcor);
              end else if (codtamanho>0) then begin
                  sqltamanho:=' and esgr_tama_codigo='+inttostr(codtamanho);
              end;
              QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'' and esgr_esto_codigo='+Stringtosql(QE.fieldbyname('esto_codigo').asstring)+
                     ' and esgr_unid_codigo='+EdUnid_codigo.AsSql+sqltamanho+sqlcor);
              FGeral.MovimentaQtdeEstoqueGrade(QE.fieldbyname('esto_codigo').asstring,EdUnid_codigo.Text,'S',Global.CodSaidaprocesso,codcor,codtamanho,0,xqtde,QGrade,xqtde,0);
              FGeral.FechaQuery(QGrade);
            end;
          end else
//            avisoerro('N�o encontrado no estoque a refer�ncia '+PReq.codigopea);
            refnaoachados:=refnaoachados+PReq.codigopea+';';
          FGeral.FechaQuery(Qe);
        end;
// 09.10.08
        if (trim(refnaoachados)<>'') and (trim(refnaoachados)<>';') then
           avisoerro('N�o encontrado no estoque a(s) refer�ncia(s) '+refnaoachados);
      end;
   end;

   function GetTotalServicos:currency;
   var i:integer;
   begin
     result:=0;
     for i:=0 to ListaServicos.Count-1 do begin
       PServicos:=ListaServicos[i];
       result:=result+(PServicos.qtde*PServicos.unitario);
     end;
   end;

   function GetPerIss:currency;
   var i:integer;
   begin
     result:=0;
     for i:=0 to ListaServicos.Count-1 do begin
       PServicos:=ListaServicos[i];
       result:=PServicos.periss;
     end;
   end;

// 20.09.12 - benato e antigo novicarnes
   procedure BaixaMateriaPrima;
/////////////////////////////////////////////////////////////
   var xTipoMovimento,xTipocad,sqlcor,sqltamanho,sqlcopa:string;
        QCusto,QEst:TSqlquery;
        linha:integer;
    begin
      xTipoMovimento:=Global.CodBaixaMatSai;
      xTipoCad:='C';
      for linha:=1 to Grid.RowCount do begin
        if trim(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])<>'' then begin
          if strtointdef(Grid.cells[Grid.getcolumn('codcor'),linha],0)>0 then
            sqlcor:=' and cust_core_codigo='+Grid.cells[Grid.getcolumn('codcor'),linha]
          else
            sqlcor:=' and cust_core_codigo=0';
          if strtointdef(Grid.cells[Grid.getcolumn('codtamanho'),linha],0)>0 then
            sqltamanho:=' and cust_tama_codigo='+Grid.cells[Grid.getcolumn('codtamanho'),linha]
          else
            sqltamanho:=' and cust_tama_codigo=0';
          if strtointdef(Grid.cells[Grid.getcolumn('codcopa'),linha],0)>0 then
            sqlcopa:=' and cust_copa_codigo='+Grid.cells[Grid.getcolumn('codcopa'),linha]
          else
            sqlcopa:=' and cust_copa_codigo=0';
          QCusto:=sqltoquery('select * from custos inner join estoque on ( esto_codigo=cust_esto_codigomat )'+
                  ' inner join estoqueqtde on ( esqt_esto_codigo=cust_esto_codigomat and esqt_status=''N'' and esqt_unid_codigo='+stringtosql(Global.CodigoUnidade)+' )'+
                  ' where cust_status=''N'' and cust_esto_codigo='+stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])+
                   sqlcor+sqltamanho+sqlcopa+' order by cust_esto_codigomat');
// 16.10.12 - Benato - checagem do subgrupo 2 carne bovina
          if (QCusto.eof) and ( FEstoque.GetSubGrupo( Grid.Cells[grid.GetColumn('move_esto_codigo'),linha] )= 2 ) then
            Avisoerro('Checar, n�o encontrado composi��o. Comando '+Qcusto.SQL.Text);
          while (not QCusto.eof)  do begin
              QEst:=sqltoquery('select esto_grup_codigo,esto_sugr_codigo,esto_fami_codigo,esqt_qtde,esqt_qtdeprev,esqt_pecas,esto_baixavenda from estoque'+
                               ' inner join estoqueqtde on ( esto_codigo=esqt_esto_codigo )'+
                               ' where esto_codigo='+stringtosql(QCusto.fieldbyname('cust_esto_codigomat').asstring)+
                               ' and esqt_status=''N'' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text) );
              if (QEst.fieldbyname('esto_baixavenda').asstring<>'N') then begin
                FGeral.MovimentaQtdeEstoque(QCusto.fieldbyname('cust_esto_codigomat').asstring,
                                          EdUnid_codigo.text,'S',xTipoMovimento,
                                          texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha])*Qcusto.fieldbyname('cust_qtde').ascurrency,
                                          QEst,
                                          texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha])*Qcusto.fieldbyname('cust_qtde').ascurrency,
                                          texttovalor(Grid.Cells[grid.getcolumn('move_pecas'),linha])*Qcusto.fieldbyname('cust_qtde').ascurrency );
                Sistema.Commit;
              end else
                Avisoerro('Checar, n�o baixado estoque do item '+QCusto.fieldbyname('cust_esto_codigomat').asstring+
                          ' da unidade '+EdUnid_codigo.text );
              FGeral.Fechaquery(QEst);
///////////////////////////
            QCusto.next;
          end; // percorre planilha de custos
          FGeral.Fechaquery(QCusto);
        end;  // tiver codigo
      end;  // Grid Produtos
   end;
////////////////////////////////////////////////////////////////////

// 11.03.20
   function ValidaGridProdutos:boolean;
   //////////////////////////////////////
   type TSomados = record
        codigo : string;
        valor  : currency;
   end;

   var i        :integer;
       yproduto :string;
       ListaP   :TStringList;
       ListaJ   :TList;
       PSomados :^TSomados;

       procedure Adiciona;
       //////////////////
       var q : integer;
       begin

          for q := 0 to ListaJ.Count-1 do  begin

             PSomados := ListaJ[q];
             if PSomados.codigo = yproduto then

                PSomados.valor := PSomados.valor +
                                  TextToValor( Grid.Cells[Grid.getcolumn('move_qtde'),i] ) *
                                  TextToValor( Grid.Cells[Grid.getcolumn('move_venda'),i] );


          end;

       end;


   begin

      ListaP := TStringList.Create;
      ListaJ := TList.Create;
      result:=true;

      for i := 1 to Grid.RowCount do begin

          yproduto :=Grid.Cells[Grid.getcolumn('move_esto_codigo'),i];
          if trim(yproduto)<>'' then begin

             if ListaP.IndexOf(yproduto) = -1 then begin

                ListaP.Add( yproduto );
                New(PSomados);
                PSomados.codigo := yproduto;
                PSomados.valor  := TextToValor( Grid.Cells[Grid.getcolumn('move_qtde'),i] ) *
                                   TextToValor( Grid.Cells[Grid.getcolumn('move_venda'),i] );
                ListaJ.Add( PSomados);

             end else Adiciona;

          end;

      end;

      for i := 0 to ListaJ.Count -1 do begin

         PSomados := ListaJ[i];
         if PSomados.valor < 0 then begin

            Avisoerro('Codigo '+PSomados.codigo+' com valor negativo' );
            result:=false;
            break;

         end;

      end;

   end;



////////////////////gravacao nota de saida
var xCondicao,unidadecomissao,portador,unidade,Natf_codigo,comcpf,
    xcpf,
    s                     :string;   // 08.12.08
    Numerodoc,ConfMovServicos,xnumero,debito,credito,p:integer;
    FazNotadeServicos,xPedeImpressao:boolean;
    QConf                 :TSqlquery;
    TotalServicos,AliqIss :currency;
    DataSaidaAux,DataEmissaoAux:TDatetime;

    // 06.04.11
    function PedeImpressao:boolean;
    ///////////////////////////////
    begin
       result:=true;
       if Global.Topicos[1349] then
         result:=true
       else if (Global.UsaNfe='S') and ( not EdDtMovimento.IsEmpty ) then
         result:=false;
    end;

////////////////////////////////////////////////////////////////////////
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
// 07.03.08 - 30.01.12 - Abra-Adriano + VY - contrato nota
       ( pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodContrato+';'+Global.CodContratoDoacao+';'+Global.CodContratoNota)=0 )
    then begin
     Avisoerro('Checar condi��o de pagamento');
     exit;
   end;
//   if not Edrepr_codigo.valid then begin
//   if (Edrepr_codigo.isempty) or (strtointdef(Edrepr_codigo.text,0)=0) then begin
// 26.01.12
  if (EdRepr_codigo.AsInteger=0) and ( pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,TiposDevolucao)=0 ) then begin
     Avisoerro('Checar representante');
     exit;
   end;
// 22.08.08
   if  (trim(Grid.cells[Grid.getcolumn('move_esto_codigo'),1])='') and (EdTotalServicos.AsCurrency=0)
       and ( pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,global.CodConhecimentoSaida)=0 )
     then begin
     Avisoerro('Obrigat�rio informar ao menos um produto');
     exit;
   end;
// 11.06.08 - 18.01.12 - consumidor passar devido ao ECF
   if (not EdDtmovimento.isempty) and (Global.Topicos[1319]) and (EdCliente.asinteger<>FGeral.GetConfig1AsInteger('clieconsumidor') ) then begin
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
//////////// - 16.07.09
   if (EdDtmovimento.isempty) and (not Global.Usuario.OutrosAcessos[0319]) then begin
       Avisoerro('Usu�rio sem permiss�o para este tipo de nota');
       exit;
   end;
//////////
///  09.02.2022
//   if (not EdDtmovimento.isempty) and (Global.Topicos[1062}) then begin
   if ( (not EdDtmovimento.isempty) )
      and
      ( AnsiPos(EdNatf_codigo.Text,'5102/6102/5405/6404')>0 )
   then begin
     if not ValidapeloNcm then begin
        exit;
     end;
   end;

   valoravista:=0;
// 05.01.12 - colocado VY - adriano
   if (FCondpagto.GetAvPz(EdFpgt_codigo.text)='P') and (FGeral.GetGeraFinanceiro(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring)='S')
      and ( pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodContrato+';'+Global.CodContratoDoacao+';'+
            Global.CodDevolucaoCompraProdutor+';'+Global.CodContratoNota)=0 )
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
   if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring <> Global.CodVendaConsig then begin
     if EdTran_codigo.asinteger=0 then begin
       Avisoerro('Obrigat�rio codigo do transportador');
       exit;
     end;
   end;
// 09.10.20 - Novicarnes
   if ( EdComv_codigo.resultfind.fieldbyname('comv_codigo').asinteger = FGeral.GetConfig1asinteger('Nfvendaracao') )
       and
      ( EdCliente.resultfind.fieldbyname(campoufentidade).asstring<>Global.UFUnidade )

   then begin

     if EdTran_codigo.ResultFind.fieldbyname('tran_cola_codigo').asstring = '' then begin
       Avisoerro('Obrigat�rio codigo do colaborador no cadastro do transportador');
       exit;
     end;

   end;

// 02.03.06
   if not FGeral.ValidaGridVencimentos(GridParcelas) then exit;
// 23.05.11 - Novi - Isonel
   if (campoufentidade='clie_uf') and ( pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.TiposRelVenda)>0 ) then begin
     if not FCidades.ValidaFatporCidade(EdCliente.ResultFind.fieldbyname('Clie_cida_codigo_res').AsInteger,global.Usuario.Codigo,EdNumerodoc.asinteger,EdTotalNota.ascurrency ) then exit;
   end;
// 26.02.12 - 09.07.19 - retirado para cliente asterio...ct-e 'sem nota'
   {
   if pos( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodConhecimentoSaida ) > 0 then begin
     if Acbrnfe1.NotasFiscais.Count=0 then begin
       if trim(Grid71.Cells[01,01])='' then begin
         Avisoerro('Obrigat�rio informar as notas acobertadas pelo conhecimento');
         exit;
       end;
     end;
   end;
   }
//////////////////////
   if OP='A' then begin
        QVePendencia:=sqltoquery('select * from pendencias where '+FGeral.Getin('pend_status','B;P;K','C')+
//                             ' and pend_numerodcto='+EdNumerodoc.AsSql+
// 21.09.11 - banco versao 8.4.1 mais 'rigoroso'
                             ' and pend_numerodcto='+Stringtosql(EdNumerodoc.text)+
                             ' and pend_datamvto>='+EdDtemissao.assql+' and pend_tipocad=''C'' and pend_tipo_codigo='+EdCliente.assql+
// 28.08.09 - Novicarnes - nf 2005 -- coincidiu
                             ' and pend_unid_codigo='+EdUnid_codigo.AsSql);
        if not QVePendencia.eof then begin
             Avisoerro('Nota com pend�ncia financeira baixada.  Transa��o '+QVependencia.fieldbyname('pend_transacao').asstring+'.  Altera��o n�o permitida.');
             exit;
        end;
       qVePendencia.close;
// 12.11.09
      campo:=Sistema.GetDicionario('movesto','moes_dtnfeauto');
      if campo.Tipo<>'' then begin
        QVeNfe:=sqltoquery('select moes_transacao,moes_dtnfeauto from movesto where moes_numerodoc='+EdNumerodoc.AsSql+
                           ' and moes_unid_codigo='+EdUnid_codigo.AsSql+
                           ' and moes_dataemissao='+EdDtEmissao.AsSql+
                           ' and moes_tipo_codigo='+EdCliente.AsSql+
                           ' and moes_status<>''C''');
        if not QVeNfe.eof then begin
          if Datetoano( QVeNfe.fieldbyname('moes_dtnfeauto').asdatetime,true )>1920 then begin
             Avisoerro('NFe j� autorizada pela SEFA.  Transa��o '+QVeNfe.fieldbyname('moes_transacao').asstring+'.  Altera��o n�o permitida.');
             exit;
          end;
        end;
        FGeral.FechaQuery(QVeNfe);
      end;

   end;
// 06.02.14 - Patoterra
   if ( global.topicos[1367] ) and ( EdCodEqui.IsEmpty ) then begin
     Avisoerro('Ainda n�o informado o codigo do equipamento');
     exit;
   end;
// 11.12.19 - A2z
{  27.09.2021 - retirado para ser feito em outra campo vinculado ao 'produto'
   if ( global.topicos[1367] ) and ( not EdCodEqui.IsEmpty ) then begin

     if  ( trim( copy( Grid.Cells[Grid.GetColumn('move_operacao'),01 ] ,pos(';',Grid.Cells[Grid.GetColumn('move_operacao'),01])+1,4 ) )  = '0000' )
         or ( trim( copy( Grid.Cells[Grid.GetColumn('move_operacao'),01 ] ,pos(';',Grid.Cells[Grid.GetColumn('move_operacao'),01])+1,4 ) ) = '000' )
         or ( trim( copy( Grid.Cells[Grid.GetColumn('move_operacao'),01 ] ,pos(';',Grid.Cells[Grid.GetColumn('move_operacao'),01])+1,4 ) ) = '00' )
         or ( trim( copy( Grid.Cells[Grid.GetColumn('move_operacao'),01 ] ,pos(';',Grid.Cells[Grid.GetColumn('move_operacao'),01])+1,4 ) ) = '0' )
         or ( EdCodEqui.ResultFind = nil )
       then begin

       Avisoerro('Ainda incorreto o codigo do equipamento na linha do produto');
       exit;
     end;

   end;
}

// 18.03.15 - Vivan
  if campoufentidade='clie_uf' then // 23.03.15 - vivan cecilia
    if  not FGeral.ValidaCadastro(EdCliente.ResultFind.FieldByName('clie_situacao').AsString) then exit;

// 03.09.15 - vivan
   if ( FGeral.GetConfig1AsInteger('ConfMovNFCE')>0 ) and (Edcomv_codigo.asinteger=FGeral.GetConfig1AsInteger('ConfMovNFCE') )
      and ( not EdDtMovimento.isempty ) and ( FGeral.GetConfig1AsInteger('ConfMovNFCEVC') > 0 )
     then begin
     comcpf:='N';
     if Input('CPF','Incluir CPF ?',comcpf,1,true) then begin
        if ( Edcomv_codigo.asinteger=FGeral.GetConfig1AsInteger('ConfMovNFCE') ) or
           ( Edcomv_codigo.asinteger=FGeral.GetConfig1AsInteger('ConfMovNFCEVC') ) then begin
          Sistema.edit('clientes');
          if Comcpf='N' then
              Sistema.setfield('clie_encargoscob','N')
          else
              Sistema.setfield('clie_encargoscob','');
          Sistema.post('clie_codigo='+EdCliente.assql);
          Sistema.commit;
        end;
     end;
   end;

// 22.01.16 - Patopapel
   if (EdComv_codigo.asinteger=FGeral.GetConfig1AsInteger('ConfMovNFCe')) and
      (FGeral.GetConfig1AsInteger('ConfMovNFCeVC')=0) and ( not EdDtMovimento.isempty) then
     Input('Informar o CPF/CNPJ (OPCIONAL)','N�mero',xcpf,14,true);
   if (trim(xcpf)<>'') then begin
     if not FGeral.ValidarCNPJCPF(xcpf) then exit;
   end;
// 28.03.16 - para tentar nao permitir gravar nota com cfop X uf 'incompativel'
   if ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString,Global.TiposSaida)>0 ) then begin
     if ( EdCliente.resultfind.fieldbyname(campoufentidade).asstring <> EdUnid_codigo.resultfind.fieldbyname('unid_uf').asstring  )then  begin
        if pos( copy(EdNatf_codigo.text,1,1),'6;7' ) = 0 then begin
          Avisoerro('UF do destinat�rio ou cfop incorreto(s) !');
          exit;
        end;
     end else begin
        if pos( copy(EdNatf_codigo.text,1,1),'6;7' ) > 0 then begin
          Avisoerro('UF do destinat�rio ou cfop incorreto(s) !');
          exit;
        end;
     end;
   end;
// 21.06.16
  if (Global.topicos[1043]) and ( EdDtMovimento.asdate > 1 )  then begin
     debito:=0;credito:=0;
     FGeral.GetContasExportacao(FCondPagto.GetAvPz(EdFpgt_codigo.text),'C',EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Tipocad,'',EdUnid_codigo.text,
                                EdComv_codigo.asinteger,EdCliente.asinteger,0,debito,credito);
     if (debito=0) then begin
       Avisoerro('Falta configurar a conta de d�bito');
       exit;
     end else if (credito=0) then begin
       Avisoerro('Falta configurar a conta de cr�dito');
       exit;
     end;
  end;
// 15.05.17
   if (pos(EdUnid_codigo.resultfind.fieldbyname('unid_simples').AsString,'S;2')>0) and
       ( (EdBasesubs.AsCurrency+EdValorsubs.AsCurrency)>0  ) and
       ( pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString,Global.CodDevolucaoCompra+';'+Global.CodDevolucaoTributada)>0 ) then begin

      if ( confirma('Zerar valores de IPI e ST ?') ) then begin

         Edmensagem.text:='Devolu��o da NF '+inttostr(notadevolucao)+' de '+FGeral.formatadata(DataNotaDevolucao)+
          ' Base Icms St '+FGeral.Formatavalor(EdBasesubs.AsCurrency,f_cr)+
          ' Icms ST : '+FGeral.Formatavalor(EdValorsubs.AsCurrency,f_cr)+
          ' FCP : '+FGeral.Formatavalor(EdvFcpST.AsCurrency,f_cr)+
          ' Valor IPI : '+FGeral.Formatavalor(EdValoripi.AsCurrency,f_cr);
        EdMensagem.Update;
        EdVlroutrasdespesas.SetValue(edValorsubs.AsCurrency+EdValoripi.AsCurrency+Edvfcpst.Ascurrency);
        EdBasesubs.setvalue(0);
        EdTotalNota.setvalue(edValorsubs.AsCurrency+EdValoripi.AsCurrency+EdTotalProdutos.AsCurrency+Edvfcpst.Ascurrency);
        EdValorsubs.SetValue(0);
        EdValoripi.SetValue(0);
        Edvfcpst.SetValue(0);
        for p := 0 to Grid.RowCount-1 do Grid.Cells[Grid.GetColumn('move_aliipi'),p]:='';
// 21.06.2021
        EdFpgt_codigo.valid;

      end;

   end;

// 11.03.20  - Devereda - informa o retorno com valor maior q o q foi entregue
   if not ValidaGridProdutos then exit;

   if confirma('Confirma grava��o ?') then begin
//      if Ecf='S' then
//        Imprimetotal;
      ListaReservaCodigo.Clear;
      ListaReservaQtde.Clear;
      Romaneio:=0;
// 30.08.05 - tentar evitar q lance enquanto ainda estiver gravando... ou q leia algum outro codigo de barra
      Sistema.BeginProcess('Gravando');
// 22.01.16 - Patopapel
      if (EdComv_codigo.asinteger=FGeral.GetConfig1AsInteger('ConfMovNFCe')) and
         (FGeral.GetConfig1AsInteger('ConfMovNFCeVC')=0) then begin
        Sistema.edit('clientes');
        Sistema.setfield('clie_cnpjcpf',xCpf);
    // 16.11.15
        if trim(xcpf)='' then
          Sistema.setfield('clie_encargoscob','N')
        else
          Sistema.setfield('clie_encargoscob','');
        Sistema.post('clie_codigo='+EdCliente.assql);
        Sistema.commit;
      end;
// 18.04.19 - Giacomoni - Barbara - cliente com 'sistema exigindo'...
      if Global.Topicos[1459] then romaneio:=EdPedidoCompra.AsInteger;

// 27.08.04 - colocado unidade no contador das notas e remaneios de saida
        Sistema.BeginTransaction('');

        if (OP='I') or (OP='S') or (OP='G') or (OP='H')  then begin
// 23.02.07
          if  not Global.Topicos[1301] then begin
            if ecf='S' then begin
              Numero:=FGeral.GetContador('NFSAIDAECF'+EdUnid_codigo.Text+EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,false,FALSE)+1;
// 31.08.15
              Numero:=FGeral.GetContador('NFSAIDA'+EdUnid_codigo.Text+EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,false,FALSE)+1;

            end else if (EdDtmovimento.asdate<=1) and (OP='I') then begin

              Numero:=FGeral.GetContador('SAIDA'+EdUnid_codigo.Text+EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,false,false);
// 22.04.09
              if pos('-',EdPedido.text)=0 then
                  xpedido:=EdPedido.asinteger
              else
                  xpedido:=0;
//////////
// 08.11.17
            end else if (OP='I') and ( pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.CodCedulaProdutoRural)>0 ) then begin

              NUmero:=( FGeral.GetContador('CPR',false,false)+1 );


            end else if (OP='S') then

              Numero:=EdNumerodoc.asinteger

            else begin

              if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring<>Global.CodContrato then begin  // 23.11.07

                if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodRomaneioRemessaaOrdem then begin  // 30.06.11
                  Numero:=FGeral.GetContador('ROMA'+Global.CodRomaneioRemessaaOrdem+EdUnid_codigo.Text,false,false)+1;
// 28.10.11 - SM - Gris
                end else if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodconhecimentoSaida then begin

                  Numero:=FGeral.GetContador('CTRC'+Global.CodConhecimentoSaida+EdUnid_codigo.Text,false,false)+1;

                end else if (EdTotalNOta.AsCurrency>0) or ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodNfeComplementoQtde+';'+Global.CodNfeComplementoIcms)>0) then // 18.11.09 devido nf servi�os

       // 13.04.18 - Novicarnes - Rosi pegou
                  if EdNumerodoc.Enabled then
                    Numero := EdNumerodoc.AsInteger
                  else
                    Numero:=FGeral.GetContador('NFSAIDA'+EdUnid_codigo.Text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,false)+1

                else if  pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.CodCedulaProdutoRural)>0  then

                  NUmero:=( FGeral.GetContador('CPR',false,false)+1 );

//////////////////////////// - retirado em 07.07.10
{
                if ( FGeral.Getconfig1asinteger('Numeronfs'+EdUnid_codigo.Text)>0 ) and
                   ( EdDtmovimento.asdate<=1 ) and (Op='I') then begin
                  if Numero<FGeral.Getconfig1asinteger('Numeronfs'+EdUnid_codigo.Text) then begin
                    Numero:=FGeral.Getconfig1asinteger('Numeronfs'+EdUnid_codigo.Text);
                    FGeral.AlteraContador('NFSAIDA'+EdUnid_codigo.Text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.serieunidade),Numero);
                  end;
                end;
                }
////////////////////////////
    // 26.05.06
    //            FGeral.Checacontador(numero-1,EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,sistema.hoje);
    // 29.05.06 - senao quando faz uma e depois outro tipo fica dando mensagem...
                FGeral.Checacontador(numero-1,EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,sistema.hoje);
// 17.09.09
                xpedido:=EdPedido.asinteger

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
                  Numero:=FGeral.GetContador('NFS'+EdUnid_codigo.Text+edComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,false);
              end;
            end;

          end else begin  // caso nro da nota for informado

            Numero:=EdNumerodoc.asinteger;
// 04.05.07 - 07.05.10 - retirado pra nao pular mais de uma vez o numero devido a mudan�a
//                       para nao perder a numeracao quando da erro na gravacao
//            FGeral.AlteraContador('NFSAIDA'+EdUnid_codigo.Text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.serieunidade),Numero);
// 15.03.10
            if pos('-',EdPedido.text)=0 then
                xpedido:=EdPedido.asinteger
            else
                xpedido:=0;
          end;

          if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodVendaSerie4 then
            Romaneio:=FGeral.GetContador('ROMANEIO'+EdUnid_codigo.Text+EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,false);
// 31.08.05
          if pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodVendaAmbulante+';'+Global.CodVendaMagazine)>0 then
            Numero:=EdNumerodoc.asinteger;
          EdNumerodoc.Text:=inttostr(Numero);

        end else if OP <> 'E' then begin  // 28.05.20 - para nao cancelar transacao quando exclui item durante inclusao da nota

          CancelaTransacao(Transacao);
// 18.05.06
          FGeral.Gravalog(7,'numero '+Transacao,true,transacao,usua_codigo,'Altera��o Nota de Saida '+EdNumerodoc.text);
          Numero:=EdNumerodoc.asinteger;

        end;

// 16.09.05
        tipocad:='C';
//        if pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodDevolucaoCompra+';'+Global.CodDevolucaoCompraSemestoque+';'+Global.CodRemessaConserto)>0 then
        if pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodDevolucaoCompra+';'+Global.CodDevolucaoCompraSemestoque+';'+Global.CodRemessaConserto+';'+TiposFornec)>0 then begin
          tipocad:='F';
// 10.12.15
          moes_remessas:=ctransacaodevolucao;
        end;
// 31.01.13
        if DevolucaoCompra( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring)  or TiposFornecedor(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring) then
          NotaTipocad:='F';
///////////////////////
        Transacao:=FGeral.GetTransacao;
// 28.11.07
        if (op='I') and (EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodContratoEntrega) then
          moes_remessas:=EdVendasmc.Text;
///////////////
//        if EdTotalNOta.AsCurrency>0 then begin  // 18.11.09 devido nf servi�os
// 17.03.15
        if (EdTotalNOta.AsCurrency>0) or (pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodNfeComplementoQtde+';'+Global.CodNfeComplementoIcms)>0) then begin  // 17.03.15 devido nf complemento
// 03.10.12 - Abraaluminios finalmente....
           if (FGeral.GetConfig1AsInteger('ConfMovSer')>0) and (ListaServicos.Count>0) and (op='I') then begin
              EdTotalServicos.SetValue(0);
              EdValoriss.SetValue(0);
           end;
// 04.03.13 - mudan�as Capeg  - nfe remessa a ordem sempre pro mesmo 'cliente secretaria'
           if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodNotaRemessaaOrdem )
              and
              ( pos(EdCliente.text,FGeral.getconfig1asstring('clientesjustica')+';'+FGeral.getconfig1asstring('clientessaude')) = 0 )
             then begin
// 05.06.13 - codigos que estiverem configuradas como sec. da justi�a e sa�de  hj 3 faz nfe normal)
             moes_clie_codigo:=EdCliente.AsInteger;
             EdMensagem.text:=EdMensagem.text+' CNPJ do col�gio no.'+EdCliente.ResultFind.fieldbyname('clie_cnpjcpf').AsString;
             EdCliente.text:=inttostr( FGeral.GetConfig1AsInteger('clienferemordem') );
             EdCliente.validfind;
// 06.01.16 - retirado pois n�o � mai necessario - Leonir + Dani Ratko
// 19.02.16  - VOLTADO Dani Ratko

           end;
// 31.05.14 - CTe
           if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodConhecimentoSaida ) then
             moes_clie_codigo:=EdDesti_codigo.AsInteger;
// 12.09.17 - Mettalum - para ficar somente o valor do ipi e total da nota com valor demais zerados
           if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodNfeComplementoIPI ) then
              Edvlroutrasdespesas.SetValue(0);

           FGeral.GravaMestreNFSaida(EdDtEmissao.AsDate,EdDtSaida.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
               EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Transacao,EdFpgt_codigo.text,
               EdNatf_codigo.text,EdEmides.text,EdEspecievolumes.text,Numero,EdComv_codigo.asinteger,EdQtdevolumes.asinteger,
               EdTotalNOta.AsCurrency,EdBaseicms.ascurrency,EdValoricms.ascurrency,EdBasesubs.ascurrency,EdValorsubs.ascurrency,EdFrete.ascurrency,
               EdMoes_Tabp_codigo.AsInteger,EdDtmovimento.Asdate,EdTotalprodutos.ascurrency,Edperacre.AsCurrency,Edperdesco.AsCurrency,Romaneio,valoravista,
               moes_remessas,StatusNota,EdMensagem.text,xPedido,Edtran_codigo.text,EdPesoliq.ascurrency,EdPesobru.ascurrency,moes_clie_codigo,
               EdValoripi.ascurrency,EdFreteuni.ascurrency,EdPortoorigem.text,EdPortodestino.text,EdContainer.text,
               EdRepr_codigo2.AsInteger , TiposFornec,EdTotalServicos.ascurrency,EdPeriss.ascurrency,EdValoriss.ascurrency,
               vlrfunrural,EdPerComissao.ascurrency,EdPerComissao2.ascurrency,EdMargemlucro.Ascurrency,
               EdEstadoEx.text , Edchavenfeacom.text , vlrcotacapital , EdMoes_cola_codigo.Text, Edvlroutrasdespesas.ascurrency,
               Ednomeobra.text,xcarga,Edvlrir.AsCurrency,Edvlrpis.AsCurrency,Edvlrcofins.AsCurrency,Edvlrcsll.ascurrency,Edvlriss.ascurrency,Edtomador.asinteger,
               EdSeto_codigo.Text,FRateio.GridRateio  );


  //////////         Sistema.Commit;

          FGeral.GravaItensNFSaida(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
               EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Transacao,Numero,Grid,EdFRete.ascurrency,EdSEguro.ascurrency,EdPeracre.AsCurrency,
               EdPerdesco.ascurrency,EdDtMovimento.asdate,moes_remessas,StatusNota,xPedido,moes_clie_codigo,
               EdNatf_codigo.text,revenda,EdComv_codigo.asinteger,NotaTipocad,EdPedidos.text,EdDtSaida.AsDate );

          valorcomissao:=FGeral.CalculaComissao(EdRepr_codigo,EdFpgt_codigo.text,Grid,EdMoes_tabp_codigo,EdUnid_codigo.text);
  //        if (EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring<>Global.CodVendaSerie4) and
  //           (EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring<>Global.CodVendaRomaneio) and
  //           (EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring<>Global.CodVendaAmbulante) then

          if pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.TiposGeraFinanceiro)>0 then begin

            FGeral.GravaPendencia(EdDtemissao.asdate,EdDtmovimento.asdate,EdCliente,tipocad,Edrepr_codigo.asinteger,EdUNid_codigo.text,
                     EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Transacao,EdFpgt_codigo.text,
                     'R',Numero,EdComv_codigo.asinteger,EdTotalnota.ascurrency,Valorcomissao,'N',0,0,GridParcelas,'',EdPort_codigo.text,'',EdSeto_codigo.Text );
            unidadecomissao:=EdUNid_codigo.text;
//            if trim(FGeral.GetConfig1AsString('UNIDADECOMISSAO'))<>'' then
//            unidadecomissao:=FGeral.GetConfig1AsString('UNIDADECOMISSAO');
// 06.10.10 - Adriano - Abra - unidade de onde foi gerado contrato
            xCondicao:=FGeral.GetConfig1AsString('FpgtoComissao');
            valorcomissao:=EdTotalNota.ascurrency*(EdPerComissao.ascurrency/100);
//            if ( Global.Topicos[1325] ) and (EdPerComissao.ascurrency>0)  and (trim(xcondicao)<>'' ) then
// 20.08.10 - comissao paga gerar igual o parcelamento do contrato
            if ( Global.Topicos[1325] ) and (EdPerComissao.ascurrency>0) and
// 20.05.13 - Abra Chapeco - UNIDADES que pagam comissao no faturamento
               ( pos(UnidadeComissao,FGeral.GetConfig1AsString('unidadescomisfatu'))>0 )
               then
              FGeral.GravaPendencia(EdDtemissao.asdate,EdDtmovimento.asdate,EdRepr_codigo,'R',Edrepr_codigo.asinteger,unidadecomissao,
                     Global.CodPendenciaFinanceira,Transacao,xcondicao,
                     'P',Numero,EdComv_codigo.asinteger,ValorComissao,0,'N',0,FGeral.GetConfig1AsInteger('Contacomissao'),nil,'',EdPort_codigo.text)
// 06.10.10 - comissao paga gerar igual o parcelamento do contrato
            else if ( Global.Topicos[1345] ) and (EdPerComissao.ascurrency>0)  then
              FGeral.GravaPendencia(EdDtemissao.asdate,EdDtmovimento.asdate,EdRepr_codigo,'R',Edrepr_codigo.asinteger,unidadecomissao,
                     Global.CodPendenciaFinanceira,Transacao,EdFpgt_codigo.text,
                     'P',Numero,EdComv_codigo.asinteger,ValorComissao,0,'H',0,FGeral.GetConfig1AsInteger('Contacomissao'),nil,'',EdPort_codigo.text);

            valorcomissao:=EdTotalNota.ascurrency*(EdPerComissao2.ascurrency/100);
            if ( Global.Topicos[1344] ) and (EdPerComissao2.ascurrency>0)  and (trim(xcondicao)<>'' ) and
// 20.05.13 - Abra Chapeco - UNIDADES que pagam comissao no faturamento
               ( pos(UnidadeComissao,FGeral.GetConfig1AsString('unidadescomisfatu'))>0 )
              then
              FGeral.GravaPendencia(EdDtemissao.asdate,EdDtmovimento.asdate,EdRepr_codigo2,'R',Edrepr_codigo2.asinteger,unidadecomissao,
                     Global.CodPendenciaFinanceira,Transacao,xCondicao,
                     'P',Numero,EdComv_codigo.asinteger,ValorComissao,0,'N',0,FGeral.GetConfig1AsInteger('Contareserva'),nil,'',EdPort_codigo.text);

          end;

          Grava71(Transacao);

        end;  // ref. total da nota >0
// 10.08.06
        if (not EdVendasmc.isempty) and ( not EdDevolucoesdm.isempty) and (OP='I') and
           (EdDtmovimento.asdate>1) and
           (Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodVendaConsigMercantil) then begin
          Sistema.Edit('Movesto');
          Sistema.SetField('moes_status','E');
          Sistema.Post( FGeral.getin('moes_tipomov',Global.CodConsigMercantil+';'+Global.CodDevolucaoConsigMerc,'C')+
                       ' and '+FGeral.getin('moes_numerodoc',EdVendasmc.text+';'+EdDevolucoesdm.text,'N')+
                       ' and moes_tipo_codigo='+EdCliente.Assql+' and moes_status=''N'''+
                       ' and moes_datamvto>='+Datetosql(sistema.hoje-60)+' and moes_unid_codigo='+EdUnid_codigo.assql );
        end;

// 28.11.07
        if pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodContratoEntrega)>0 then begin
          GeraBaixaEstoqueProcesso;
// aqui sera mudado pra baixar somente do produto acabado - 10.08.09
        end;
        try
          Sistema.EndTransaction('');
// 22.11.07 - aqui em 29.04.08 - para nao dobrar a grade pois ainda 'nao comitou'
          if ( pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodContrato+';'+Global.CodContratoNota+';'+Global.CodContratoDoacao)>0 )
              and (not EdPedido.isempty)
          then begin
               if (not Global.Topicos[1379]) then begin
                 GeraRequisicaoAlmox;
                 BaixaOrcamento;
                 GeraItensdaObra;
               end else
                 GeraItensdaObradoPedido;
          end;
// 20.09.12 tirado do Geral.pas e colocado aqui apos ter comitado a transa��o
// Benatto e 'antigo Novicarnes'
// 28.02.08
          if ( pos( EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,global.CodVendaDireta )>0 ) and ( Global.Topicos[1311] )  then
             BaixaMateriaPrima;

// 14.09.09 ////////////////////////////// - Nota de Servicos 'automatica'
//////////////////////////////////////////////
          FazNotadeServicos:=false;
          ConfMovServicos:=FGeral.GetConfig1AsInteger('ConfMovSer');
          if (ConfMovServicos>0) and (ListaServicos.Count>0) and (op='I') then
  //           ( FGeral.GetConfig1AsInteger('ConfMovSer')<>EdComv_codigo.asinteger )  then
            FazNotadeServicos:=true;
          if FazNotadeServicos then begin
            Sistema.BeginTransaction('Fazendo nota de presta��o de servi�os');
            Transacao:=FGeral.GetTransacao;
            QConf:=sqltoquery('select * from confmov where comv_codigo='+inttostr(ConfMovServicos));
            if copy(EdNatf_codigo.text,1,1)='5' then
              Natf_codigo:=QConf.fieldbyname('comv_natf_estado').asstring
            else
              Natf_codigo:=QConf.fieldbyname('comv_natf_foestado').asstring;

  //          Numerodoc:=FGeral.GetContador('NFSAIDA'+EdUnid_codigo.Text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false);
  // 12.04.10 - cenitech
            if EdDtmovimento.AsDate>1 then begin
              if Global.Topicos[1332] then
//                NUmerodoc:= FGeral.GetContador('NFSAIDA'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,false )+2
// 07.09.10  - rolos Abra - pra pegar a serie da config. de movimento de servicos
                NUmerodoc:= FGeral.GetContador('NFSAIDA'+EdUnid_codigo.text+FGeral.Qualserie(QConf.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,false )+1
              else
                NUmerodoc:= FGeral.GetContador('NFSAIDAMO'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,false)+1;
            end;

            TotalServicos:=GetTotalServicos;
            Aliqiss:=GetPeriss;
  {
            FGeral.GravaMestreNFSaida(EdDtEmissao.AsDate,EdDtSaida.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
                 Global.CodPrestacaoServicos,Transacao,EdFpgt_codigo.text,
                 Natf_codigo,EdEmides.text,EdEspecievolumes.text,Numerodoc,QConf.fieldbyname('Comv_codigo').asinteger,EdQtdevolumes.asinteger,
                 TotalServicos,0,0,0,0,0,
                 0,EdDtmovimento.Asdate,0,0,0,Romaneio,0,
                 moes_remessas,StatusNota,EdMensagem.text,xPedido,Edtran_codigo.text,EdPesoliq.ascurrency,EdPesobru.ascurrency,moes_clie_codigo,
                 0,0,EdPortoorigem.text,EdPortodestino.text,EdContainer.text,
                 EdRepr_codigo2.AsInteger , TiposFornec );
  }
            FGeral.GravaMestreNFSaidaMO(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
                 Global.CodPrestacaoServicos,Transacao,EdFpgt_codigo.text,
                 Natf_codigo,EdEmides.text,EdEspecievolumes.text,Numerodoc,QConf.fieldbyname('Comv_codigo').asinteger,EdQtdevolumes.asinteger,
                 TotalServicos,0,0,TotalServicos,(TotalServicos*(Aliqiss/100)),0,
                 EdMoes_Tabp_codigo.AsInteger,EdDtmovimento.Asdate,0,0,0,Romaneio,0,
                 moes_remessas,StatusNota,EdMensagem.text,xPedido,Edtran_codigo.text,EdPesoliq.ascurrency,EdPesobru.ascurrency,moes_clie_codigo,
                 0,EdFreteuni.ascurrency,EdPortoorigem.text,EdPortodestino.text,EdContainer.text,
                 EdRepr_codigo2.AsInteger , TiposFornec,Aliqiss,0,0,0 );


            FGeral.GravaItensNFSaidaSer(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
                 Global.CodPrestacaoServicos,Transacao,NumeroDoc,ListaServicos,0,0,0,
                 0,EdDtMovimento.asdate,moes_remessas,StatusNota,xPedido,moes_clie_codigo,
                 Natf_codigo,revenda,QConf.fieldbyname('Comv_codigo').asinteger,NotaTipocad );

            if pos(Global.CodPrestacaoServicos,Global.TiposGeraFinanceiro)>0 then begin
              FGeral.GravaPendencia(EdDtemissao.asdate,EdDtmovimento.asdate,EdCliente,tipocad,Edrepr_codigo.asinteger,EdUNid_codigo.text,
                     Global.CodPrestacaoServicos,Transacao,EdFpgt_codigo.text,
                     'R',NumeroDoc,QConf.fieldbyname('Comv_codigo').asinteger,TotalServicos,0,'N',0,0,nil,'',EdPort_codigo.text,'',EdSeto_codigo.Text );
            end;
            if EdDtmovimento.asdate>1 then
              FGeral.GravaMovbase(Transacao,Numerodoc,'000','S',TotalServicos,round(TotalServicos*(AliqIss/100)),AliqIss,0,0,0,Global.CodPrestacaoServicos);

            Sistema.EndTransaction('');
          end;  // se faz nf de servicos ( mao de obra )
////////////////////////////////////
// 04.05.10 - tentativa de nao pular o contador quando da erro na nota de saida
          if (OP='I') or (OP='G') or (OP='H') or (OP='E') then begin
            if FazNotadeServicos then begin
// atualiza contador da nf de material e de servicos
              if Global.Topicos[1332] then begin
                NUmerodoc:= FGeral.GetContador('NFSAIDA'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,true );
// 26.05.10 - para pular mais uma vez o contador de nota pois gera 2 notas seguidas
//                NUmerodoc:= FGeral.GetContador('NFSAIDA'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,true )
// 05.10.10 - revisado - mais uma 'abrisse', isto � , coisas da abra...mesma unidade mas
//series diferentes ..
                NUmerodoc:= FGeral.GetContador('NFSAIDA'+EdUnid_codigo.text+FGeral.Qualserie(QConf.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,true )
              end else
                NUmerodoc:= FGeral.GetContador('NFSAIDAMO'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,true);

            end else begin

// 30.07.10 - Abra - nf contrato pulava numero igual...
// 09.08.12   Venda Ambulante - VA tbem.. VM - venda magazine tbem
               if pos( EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodContrato+';'+Global.CodVendaAmbulante+';'+Global.CodVendaMagazine)=0 then begin
                 if EdDtmovimento.isempty then
                   Numero:=FGeral.GetContador('SAIDA'+EdUnid_codigo.Text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,true)
                 else if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodRomaneioRemessaaOrdem then // 30.06.11
                   Numero:=FGeral.GetContador('ROMA'+Global.CodRomaneioRemessaaOrdem+EdUnid_codigo.Text,false,true)
                 else if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodConhecimentoSaida then // 28.10.11
                   Numero:=FGeral.GetContador('CTRC'+Global.CodConhecimentoSaida+EdUnid_codigo.Text,false,true)
                 else if Ecf='S' then begin  // 12.07.11
                   Numero:=FGeral.GetContador('NFSAIDAECF'+EdUnid_codigo.Text+EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,false,True);
                   Numero:=FGeral.GetContador('NFSAIDA'+EdUnid_codigo.Text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,true);
                 end else
                   Numero:=FGeral.GetContador('NFSAIDA'+EdUnid_codigo.Text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,true);
               end;
            end;
            if ( Global.Topicos[1301] ) and ( not EdDtmovimento.IsEmpty) then begin
              if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodRomaneioRemessaaOrdem then // 30.06.11
                FGeral.AlteraContador('ROMA'+Global.CodRomaneioRemessaaOrdem+EdUnid_codigo.Text,EdNumerodoc.AsInteger)
              else if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodConhecimentoSaida then // 28.10.11
                FGeral.AlteraContador('CTRC'+Global.CodConhecimentoSaida+EdUnid_codigo.Text,EdNumerodoc.AsInteger)
              else
                FGeral.AlteraContador('NFSAIDA'+EdUnid_codigo.Text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.serieunidade),EdNumerodoc.AsInteger);
            end;
          end;
////////////////////

        except  // 09.08.06
          FGeral.Gravalog(99,'Problemas na grava��o do documento '+inttostr(numero),true,transacao);
// 09.10.08 - caso der pau retorna 1 no contador de nota
//          if (EdDtmovimento.asdate>1) and (OP='I') and not Global.Topicos[1301] then
//            FGeral.AlteraContador('NFSAIDA'+EdUnid_codigo.Text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.serieunidade),Numero-1);
// retiado em 07.05.10  pois 'nunca passava aqui'
        end;

        Sistema.EndProcess('');
        xPedeImpressao:=PedeImpressao;
        unidade:=EdUNid_codigo.text;
        xnumero:=EdNumerodoc.asinteger;
        DataSaidaAux:=EdDtSaida.asdate;
        DataEmissaoAux:=EdDtEmissao.asdate;
        EdComv_codigo.ClearAll(FNotaSaida,99);
// 06.01.12 - capeg - everado pediu pra deixar ultima data informada
        if ( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring<>Global.CodRomaneioRemessaaOrdem ) then begin
          EdDtSaida.SetDate(Sistema.hoje);
          EdDtEmissao.SetDate(Sistema.hoje);
        end else begin
          EdDtSaida.SetDate(DataSaidaAux);
          EdDtEmissao.SetDate(DataEmissaoAux);
        end;
        EdDtMovimento.clear;

        EdUnid_codigo.Text:=Global.CodigoUnidade;
        EdProduto.clearall(FNotaSaida,99);
        EdTotalServicos.clear;
// 15.06.05
        if Global.Topicos[1201] then
          Arq.TEstoqueqtde.commit;

        Grid.Clear;
        GridParcelas.clear;
        EdBaseicms.ClearAll(FNotaSaida,99);
        portador:=EdPort_codigo.text;
        EdPort_codigo.ClearAll(FNotaSaida,99);
        ListaServicos.Clear;  // 14.09.09
        Grid71.Clear;
        if ( Ecf<>'S' )  then begin
          if ( xPedeImpressao ) then begin
            if confirma('Imprime nota agora ?') then
//            FImpressao.ImprimeNotaSaida(Numero,EdDtEmissao.AsDate,Unidade,EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring);
// 04.03.11 - a variavel numero j� est� 'um acima' pois j� gravou a numeracao da nota de saida
//            dai nao acha o 'pedido' pra imprimir] logo apos incluir...
//              FImpressao.ImprimeNotaSaida(Numero-1,EdDtEmissao.AsDate,Unidade,EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring);
// 11.04.11 - cfe o numero da nota esta aberto para emissao num d� certo isto..
              FImpressao.ImprimeNotaSaida(xNumero,EdDtEmissao.AsDate,Unidade,EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring);

          end else if (Global.Topicos[1020]) and ( Global.UsaNfe='S' )  then begin  // 11.05.11

              if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodConhecimentoSaida then
                FExpCTe.Execute( xNumero )
              else
                FExpNfetxt.Execute( xNumero );
// 10.08.11
          end else if ( (OP='G') ) and ( Global.UsaNfe='S' )  then
// 13.08.12
            if pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodVendaMagazine)=0 then begin

              FExpNfetxt.Execute( xNumero );
              FExpNfeTxt.Close;
// 07.04.17
//              if FGeral.GetConfig1AsString('impboletos')<>'' then
// 04.02.20
              if Global.Usuario.OutrosAcessos[0349] then begin

                s:=LeArquivoINI(Global.NomeSistema,'Impressoras','IMPBOLETO');
                if trim(s) <> '' then begin

                   FBoletos.Execute(EdUnid_codigo.Text,portador,0,0,transacao);
                   FBoletos.Close;

                end;

                FGerenciaNfe.Execute( inttostr(xNumero) );
                // 06.02.20
                FGerenciaNfe.ImprimeNfeNFCe( 55 );

                FGErenciaNfe.Close;

              end;

            end;

        end else begin  // ECF<>'S'
// 17.01.12 - benatto
{
          if Global.Usuario.OutrosAcessos[0329] then begin
            FGerenciaECF.Execute(Transacao,EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring);
            FGerenciaECF.bimpcupomClick(self);
            FGerenciaECF.close;
          end;
          }
        end;
   end;

// 23.05.11 - Novi - Isonel - retorna usuario para nao poder fazer faturamento abaixo
//            do minimo por cidade
   FUsuarios.GravaOutrosAcessos(326,Global.Usuario.Codigo,'N');

   if Op='I' then
     EdComv_codigo.setfocus
   else if (OP='G') or (OP='H') then begin  // 08.08.11
     bsairclick(self);
   end else
// 12.04.10 - Mama
//      FNotaSaida.Execute('A');
// 09.05.11 - retirado pois assim nao daria pra alterar os vencimentos..
// ver se precisa criar parametro do sistema...
     EdNumerodoc.setfocus;

// 24.03.09 - retirado em 30.03.11 - rever - Novi - Tiago
//   if ( trim( FGeral.GetConfig1AsString('Portaboletos') )<>'' ) and (trim(portador)<>'') then begin
//          if pos( portador,FGeral.GetConfig1AsString('Portaboletos') )>0 then begin
//            FNotasaida.FormStyle:=fsNormal;
//            FNotasaida.SendToBack;
//            FNotasaida.Refresh;
//            FBoletos.Execute(UNidade,Portador,Sistema.hoje,Sistema.Hoje+120,transacao);
//            FGeral.EstiloForm(FNotaSaida);
//            FNotasaida.Refresh;
//            FNotasaida.BringToFront;
//          end;
//   end;

end;

procedure TFNotaSaida.bimpcprClick(Sender: TObject);
var
      QU:TSqlquery;
      WordApp: Variant;
      Documento: Olevariant;
      xcomando,nomearquivo,xtransacao,xnome:string;
      p : byte;
      ListaComandos:TStringList;

      Function Retorno(xcom:string):string;
      //////////////////////////////////////
      begin
        result:='';
        if xcom='@CPR' then result:=strzero(QU.FieldByName('move_numerodoc').AsInteger,6)
        else if xcom='@VALORCPR' then result:=FGeral.Formatavalor(QU.Fieldbyname('moes_vlrtotal').AsCurrency,f_cr)
        else if xcom='@QTDE' then result:=FGeral.Formatavalor(QU.Fieldbyname('move_qtde').AsCurrency,f_integer)
        else if xcom='@DESCRICAO' then result:=QU.FieldByName('esto_descricao').AsString
        else if xcom='@UNITARIO'  then result:=FGeral.Formatavalor(QU.Fieldbyname('move_venda').AsCurrency,f_cr)
//        else if xcom='@VALORITEM'  then result:=FGeral.Formatavalor(QU.Fieldbyname('move_qtde').AsCurrency*,f_integer)
        else if xcom='@CNPJUNIDADE' then result:=FGeral.Formatacnpj( Qu.FieldByName('unid_cnpj').asstring )
        else if xcom='@ENDERECOUNIDADE' then result:=Qu.FieldByname('unid_endereco').AsString
        else if xcom='@LOCALDATA' then result:=QU.FieldByName('Unid_municipio').AsString+','+Fgeral.FormataData(Sistema.DataMvto)
        else if xcom='@NOME' then result:=QU.FieldByName('forn_razaosocial').AsString
        else if xcom='@CPF' then result:=FGeral.Formatacnpjcpf( QU.FieldByName('forn_cnpjcpf').AsString)
        else if xcom='@ENDERECOFORNEC' then result:=QU.FieldByName('Forn_endereco').AsString;

      end;

begin

  NomeArquivo:= ExtractFilePath(Application.ExeName) +  'CeduladeProdutoRural.docx' ;
  if FileExists( Nomearquivo ) then begin

      xtransacao:=Global.UltimaTransacao;
      if not Input('Informe','Transa��o',xtransacao,12,false) then exit;
      QU:=sqltoquery('select * from movestoque'+
                     ' inner join movesto on ( move_transacao=moes_transacao and move_tipomov=moes_tipomov )'+
                     ' inner join estoque on ( esto_codigo = move_esto_codigo )'+
                     ' inner join unidades on ( unid_codigo = move_unid_codigo )'+
                     ' inner join fornecedores on ( forn_codigo = move_tipo_codigo )'+
                     ' and move_status = ''N'''+
                     ' and move_transacao = '+Stringtosql(xtransacao)+
                     ' and move_tipomov = '+Stringtosql(Global.CodCedulaProdutoRural)+
                     ' and move_unid_codigo = '+Stringtosql(Global.CodigoUnidade) );
      if Qu.Eof then begin
         Avisoerro('Transa��o n�o encontrada');
         exit;
      end;
      WordApp:= CreateOleObject('Word.Application');
      xnome:=QU.FieldByName('forn_razaosocial').asstring;

      try

        WordApp.Visible := True;
        Documento := WordApp.Documents.Open(NomeArquivo);

        ListaComandos:=TStringList.Create;
        ListaComandos.add('@CPR');
        ListaComandos.add('@VALORCPR');
        ListaComandos.add('@QTDE');
        ListaComandos.add('@DESCRICAO');
        ListaComandos.add('@UNITARIO');
//        ListaComandos.add('@VALORITEM');
        ListaComandos.add('@CNPJUNIDADE');
        ListaComandos.add('@ENDERECOUNIDADE');
        ListaComandos.add('@LOCALDATA');
        ListaComandos.add('@NOME');
        ListaComandos.add('@CPF');
        ListaComandos.add('@ENDERECOFORNEC');

        for p:=0 to ListaComandos.count-1 do begin
          xcomando:=ListaComandos[p];
          Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := Retorno(xcomando) );
        end;
        for p:=0 to ListaComandos.count-1 do begin
          xcomando:=ListaComandos[p];
          Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := Retorno(xcomando) );
        end;

//        WordApp.Visible := True;

        Documento.SaveAs( ExtractFilePath( Application.ExeName ) + 'CPR_'+xnome+'.docx');
        Documento.close;
        Documento := WordApp.Documents.Open( ExtractFilePath( Application.ExeName ) + 'CPR_'+xnome+'.docx');

//        Documento.PrintOut(copies := 1 );
//        Documento.close;


      finally
//        WordApp.Quit;
//        DeleteFile( ExtractFilePath( Application.ExeName ) + 'CPR_'+xnome+'.docx');
        FGeral.FechaQuery(QU);
      end;

  end else Avisoerro('Falta o arquivo '+NomeArquivo );

end;

// 04.12.20
procedure TFNotaSaida.bimportanfClick(Sender: TObject);
///////////////////////////////////////////////////////
var Lista:TStringList;
    ctransacoes  : string;
    QN           : TSqlquery;

begin

    Lista := TStringList.create;
    sistema.beginprocess('');
    GetListaNfe( Lista,'S' );
    sistema.endprocess('');

    if (Lista.count>0) and (Lista[0]<>'') then begin

       ctransacoes:=SelecionaItems(Lista,'NFe Autorizadas','',false);
       strtolista(Lista,ctransacoes,'|',true);

    end else

      Lista.Add(ctransacoes);

    if ( copy(ctransacoes,1,11)<>'Transa��o |' ) and ( trim(ctransacoes)<>'' ) then begin

       QN:=sqltoquery('select * from movesto where moes_transacao='+Stringtosql(trim(Lista[0]))+
           ' and '+FGeral.GetNOTIN('moes_tipomov',Global.CodBaixaMatSai,'C') );
       if not QN.eof then begin

         EdCliente.text := QN.fieldbyname('moes_tipo_codigo').AsString;
         EdCliente.validfind;
         EdUnid_codigo.validfind;

         QBusca:=sqltoquery('select * from movestoque'+
                    ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov )'+
                    ' where move_transacao = '+stringtosql(trim(Lista[0]))+
                    ' and move_tipomov = '+stringtosql(QN.fieldbyname('moes_tipomov').asstring)+
                    ' and move_unid_codigo='+stringtosql(Global.codigounidade)+
                    ' and '+FGeral.getin('move_status','N','C')+
                    ' and '+FGeral.getin('moes_status','N','C') );

            Campostogrid(QBusca,'S');


         FGeral.FechaQuery(QBusca);
         FGeral.FechaQuery(QN);
         SetaEditsvalores;

       end;

    end;

end;

procedure TFNotaSaida.bSairClick(Sender: TObject);
begin
  if OP<>'H' then begin
    if EdProduto.enabled then bCancelaritemClick(self);
  end;
  Close;

end;

procedure TFNotaSaida.FormCloseQuery(Sender: TObject;
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
//      if Ecf='N' then begin
        if (QMestre.Eof) and (EdTotalnota.ascurrency>0) then begin
//          if Confirma('� prov�vel que este documento ainda n�o foi gravado.  Gravar ?') then
//            bgravarclick(Self);
        end else begin
          RetornaReserva;  // 15.12.04 // retornar os itens ao estoque
        end;
//      end else
//        bgravarclick(Self);   // se for ecf grava de qq jeito
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
// 13.02.12
  if acbrBal1.Ativo then  ACBrBAL1.Desativar;
  global.UltimoFormAberto:='';

end;

procedure TFNotaSaida.RetornaReserva;
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

// 12.05.17
procedure TFNotaSaida.sbfecharClick(Sender: TObject);
//////////////////////////////////////////////////////////
begin
    Pmensagem.Visible:=false;
    Edmensagem.SetFocus;

end;

procedure TFNotaSaida.Edunid_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.Limpaedit(EdUNid_codigo,key);
end;

procedure TFNotaSaida.EdDtSaidaValidate(Sender: TObject);
///////////////////////////////////////////////////////////
begin
  if not FGeral.ValidaMvto(EdDtSaida) then
    EdDtSaida.Invalid('')
  else if EdDtSaida.AsDate<EdDtemissao.asdate then
    EdDtSaida.Invalid('Data de saida tem que ser maior ou igual a emiss�o')
  else if OP='I' then begin
// 03.01.12
    if ( Edcomv_codigo.asinteger=FGeral.GetConfig1AsInteger('ConfMovECF') )
       and ( FGeral.GetConfig1AsInteger('ConfMovECF')>0 ) then
      EdDtmovimento.setdate(EdDtsaida.asdate)
     else
// 05.11.09
      FGeral.setamovimento(EdDtmovimento);
// 25.11.14 - vendas moveis
   if VendaMovel='S' then begin
     if pos( EdPort_codigo.text,FGeral.GetConfig1AsString('Portaboletos') ) > 0 then
       EdDtMovimento.setdate(EdDtemissao.asdate)
     else
       EdDtMovimento.text:='';
     EdDtMovimento.Valid;
   end;
  end;
end;

procedure TFNotaSaida.EdFpgt_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
   FGeral.LImpaEdit(Edfpgt_codigo,key);
end;

procedure TFNotaSaida.EdNatf_codigopValidate(Sender: TObject);
//////////////////////////////////////////////////////////////
begin
  if copy(EdNatf_codigo.Text,1,1) <> copy(EdNatf_codigop.Text,1,1) then
     EdNatf_codigop.Invalid('Cfop inv�lido');
end;

procedure TFNotaSaida.EdNatf_codigoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////////
var iniciook:string;
    p       :integer;

begin

  if EdCliente.resultfind.fieldbyname(campoufentidade).asstring<>Global.UFUnidade then
    iniciook:='6'
  else
    iniciook:='5';
  if copy(EdNatf_codigo.text,1,1)<>'7' then begin
    if pos(copy(EdNatf_codigo.text,1,1),iniciook)=0 then
      EdNatf_codigo.Invalid('Cfop inv�lido para esta opera��o de saida.');
  end else if copy(EdNatf_codigo.text,1,1)='7' then begin
// 06.04.20 - Seip
     if Confirma('Mudar o cfop tamb�m nos itens da nota ?' ) then begin

        for p:=1 to Grid.RowCount do begin
//          if trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p])<>'' then
          if (trim(Grid.Cells[Grid.Getcolumn('move_qtde'),p])<>'') then
            Grid.Cells[Grid.Getcolumn('move_natf_codigo'),p]:=EdNatf_codigo.text;
        end;

     end;

     EdMens_codigo.setvalue(FGeral.getconfig1asinteger('CODMENEXPO'));
  end;

end;

procedure TFNotaSaida.EdPort_codigoExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin
   if ( Global.Topicos[1399] ) and
    ( pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodPrestacaoServicos+';' ) >0 ) then begin
    PRetencoes.Visible:=true;
    PRetencoes.Enabled:=true;
    Edvlrir.setfocus;
  end else begin
    PRetencoes.Visible:=false;
    PRetencoes.Enabled:=false;
    EdVlrPis.setvalue( 0 );
    EdVlrIR.setvalue( 0 );
    EdVlrCofins.setvalue( 0 );
    Edvlrcsll.setvalue( 0 );
    Edvlriss.setvalue( 0 );
  end;
// 18.10.19 - Vida Nova
  if trim( FGeral.GetConfig1AsString('tipomovlote1')) <> '' then begin

    if Ansipos(strzero(Edcomv_codigo.AsInteger,4),FGeral.GetConfig1AsString('tipomovlote1') )>0 then begin

       if AnsiPos('LOTE',EdMensagem.text)=0 then begin

         Sistema.GetDataMvto('Data Fabrica��o');
         EdMensagem.text := EdMensagem.text + ' LOTE 1 : Data Fabrica��o : '+FGeral.formatadata(Sistema.DataMvto);

       end;
    end;

  end;

  if trim( FGeral.GetConfig1AsString('tipomovlote2')) <> '' then begin

    if Ansipos(strzero(Edcomv_codigo.Asinteger,4),FGeral.GetConfig1AsString('tipomovlote2') )>0 then begin

       if AnsiPos('LOTE',EdMensagem.text)=0 then begin

         Sistema.GetDataMvto('Data Fabrica��o');
         EdMensagem.text := EdMensagem.text + ' LOTE 2 : Data Fabrica��o : '+FGeral.formatadata(Sistema.DataMvto);

       end;
    end;

  end;

end;

procedure TFNotaSaida.EdPort_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.Limpaedit(EdPort_codigo,key);
end;

procedure TFNotaSaida.Edunid_codigoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////////
begin

  if EdUnid_codigo.ResultFind.fieldbyname('unid_uf').asstring<>EdCliente.resultfind.fieldbyname(campoufentidade).asstring then begin

    EdNatf_codigo.text:=Arq.TConfMovimento.fieldbyname('comv_natf_foestado').asstring;
    if (OP='I') and (campoufentidade='clie_uf')  and (Global.Topicos[1348] ) then begin
      if EdCliente.ResultFind.FieldByName('clie_tipo').AsString='F' then begin
        if trim(FGeral.GetConfig1AsString('cfopfisicafora')) <>'' then
          EdNatf_codigo.text:=FGeral.GetConfig1AsString('cfopfisicafora')
        else
          EdUnid_codigo.Invalid('Cfop para venda fora do estado para pessoa f�sica n�o configurado');
      end;
    end;

  end else

    EdNatf_codigo.text:=Arq.TConfMovimento.fieldbyname('comv_natf_estado').asstring;

  if OP<>'A' then begin
    if not FGeral.ValidaUnidadesMvtoUsuario(EdUnid_codigo) then

      EdUnid_codigo.invalid('')

    else begin

      if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodRomaneioRemessaaOrdem then  // 30.06.11
        EdNUmerodoc.setvalue( FGeral.ConsultaContador('ROMA'+Global.CodRomaneioRemessaaOrdem+EdUnid_codigo.Text)+1 )
      else if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodConhecimentoSaida then  // 28.10.11
        EdNUmerodoc.setvalue( FGeral.ConsultaContador('CTRC'+Global.CodConhecimentoSaida+EdUnid_codigo.Text)+1 )
// 08.11.17
      else if (OP='I') and ( pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.CodCedulaProdutoRural)>0 ) then

         EdNUmerodoc.setvalue( FGeral.GetContador('CPR',false)+1 )

      else if ecf='S' then
        EdNumeroDoc.SetValue( FGeral.ConsultaContador('NFSAIDAECF'+EdUnid_codigo.Text+EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring)+1 )
// 09.01.12 - Benatto - retirado pois s� fodia os demais clientes..deixado sem por enquanto
//      else if (EdDtmovimento.asdate<=1) and (OP='I') then
//         EdNumeroDoc.SetValue( FGeral.ConsultaContador('SAIDA'+EdUnid_codigo.Text+EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring)+1 )
// 12.01.12
//        EdNUmerodoc.setvalue( FGeral.ConsultaContador('SAIDA'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade))+1 )
      else begin
        EdNUmerodoc.setvalue( FGeral.ConsultaContador('NFSAIDA'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade))+1 );
// 06.06.09
        if not FGeral.ValidaContadorNFSaida(EdNumerodoc.asinteger,EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,EdUnid_codigo.text,sistema.hoje) then begin
            EdUnid_codigo.invalid('')
        end;
      end;
    end;
  end;

end;

////////////////////////////////////////////////////////////////////////////
procedure TFNotaSaida.Foc(Sender: TObject);
////////////////////////////////////////////////////////////////////////////
var restricao1,restricao2,restricao3,restricao4:boolean;
    usuariolib:integer;
    obsliberacao,unidades:string;

    procedure SetaEditsPedido;
    //////////////////////////
    begin

// 27.02.23 - Guiber - deixa na unidade q  esta posicionado no sac
      if not Global.Topicos[1431] then

         EdUnid_codigo.text:=QPed.fieldbyname('mped_unid_codigo').asstring;

      EdFpgt_codigo.text:=QPed.fieldbyname('mped_fpgt_codigo').asstring;
      Edmoes_tabp_codigo.text:=QPed.fieldbyname('mped_tabp_codigo').asstring;
      ObsPedido:=QPed.fieldbyname('mped_obspedido').asstring;
// 23.11.14
      EdPort_codigo.text:=QPed.fieldbyname('mped_port_codigo').asstring;
      if ( pos( EdPort_codigo.text,FGeral.GetConfig1AsString('Portaboletos') ) = 0)
         and
         ( QPed.fieldbyname('mped_obspedido').asstring='Vendas Movel' )
        then
       EdDtMovimento.text:='';
    end;

    procedure SetaGridPedido;
    /////////////////////////
    var p:integer;
        unitario,qtde,rqtde:currency;
        Q:TSqlquery;
        semreq:boolean;
        codsittrib:integer;
    begin
      Grid.Clear;p:=1;
      while not QPed.Eof do begin
// 17.09.09
        if (Servico(QPed.fieldbyname('mpdd_esto_codigo').asstring)) then

//           ( FGeral.GetConfig1AsInteger('ConfMovSer')<>EdComv_codigo.asinteger )  then
//              AdicionaListaServicos(QPed)
// 10.11.2022 - retirado ja q n�o puxa o servi�o do pedido mas estava totalizando e dando erro
//               na autoriza��o da nfe
// 21.02.20
        else if QPed.fieldbyname('mpdd_esto_codigo').asstring = xCodProdutoGeral then

             Avisoerro('Item ainda n�o cadastrado no estoque. N�o importado do pedido')

        else begin

          unitario:=QPed.fieldbyname('mpdd_venda').Ascurrency;
          qtde    :=QPed.fieldbyname('mpdd_qtde').AsFloat;

          if Global.Topicos[1340] then begin

            Q:=Sqltoquery('select move_qtde,move_tipomov from movestoque where move_status=''N'''+
                          ' and '+FGeral.GetIN('move_tipomov',Global.CodSaidaAlmox+';'+Global.CodEntradaAlmox,'C')+
                          ' and move_numerodoc='+QPed.fieldbyname('mpdd_numerodoc').asstring+
                          ' and move_esto_codigo='+Stringtosql(QPed.fieldbyname('mpdd_esto_codigo').asstring)+
                          ' and move_core_codigo='+QPed.fieldbyname('mpdd_core_codigo').asstring+
                          ' and move_tama_codigo='+QPed.fieldbyname('mpdd_tama_codigo').asstring );
            rqtde:=0;
            semreq:=Q.eof;
            while not Q.eof do  begin
              if Q.fieldbyname('move_tipomov').asstring=Global.CodEntradaAlmox then
                rqtde:=rqtde-Q.fieldbyname('move_qtde').ascurrency
              else
                rqtde:=rqtde+Q.fieldbyname('move_qtde').ascurrency;
              Q.Next;
            end;
  // caso devolver tudo nao fatura nada deste material
            if not semreq then begin
              if rqtde>0 then
                qtde:=rqtde
              else
                qtde:=0;
            end;
            FGeral.FechaQuery(Q);
          end;
// 22.04.13
          if Global.Usuario.OutrosAcessos[0335] then
            qtde:=qtde-QPed.fieldbyname('mpdd_qtdeenviada').ascurrency;
////////////////////
//          if qtde>0 then begin
// 12.08.14 - 'adiantamento' benato na hora de fazer o pedido
          if qtde<>0 then begin

            p:=FGeral.ProcuraGrid(Grid.GetColumn('move_esto_codigo'),QPed.fieldbyname('mpdd_esto_codigo').Asstring,
               Grid,Grid.Getcolumn('codtamanho'),QPed.fieldbyname('mpdd_tama_codigo').Asinteger,
               Grid.Getcolumn('codcor'),QPed.fieldbyname('mpdd_core_codigo').Asinteger );

            if p <=0 then begin

              if (Grid.RowCount=2) and (Trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),1])='') then begin
                 p:=1;
              end else begin
                 Grid.RowCount:=Grid.RowCount+1;
                 p:=Grid.RowCount-1;
              end;
              Grid.Cells[Grid.GetColumn('move_esto_codigo'),p]:=QPed.fieldbyname('mpdd_esto_codigo').Asstring;
// 24.04.13
              Grid.Cells[Grid.GetColumn('esto_referencia'),p]:=FEstoque.GetReferencia( QPed.fieldbyname('mpdd_esto_codigo').Asstring );
              Grid.Cells[Grid.GetColumn('esto_descricao'),p]:=FEstoque.GetDescricao(QPed.fieldbyname('mpdd_esto_codigo').Asstring);

              Grid.Cells[Grid.getcolumn('move_cst'),p]:=FEstoque.Getsituacaotributaria(QPed.fieldbyname('mpdd_esto_codigo').Asstring,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,
                                  Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,EdCliente.asinteger,
                                  revenda,FUnidades.GetSimples(EdUnid_codigo.text) );

              codsittrib:=FEstoque.GetCodigosituacaotributaria(QPed.fieldbyname('mpdd_esto_codigo').Asstring,
                                 EdUnid_codigo.text,
                                 EdCliente.resultfind.fieldbyname(campoufentidade).asstring);
              Grid.Cells[Grid.getcolumn('move_aliicms'),p]:=currtostr(FEstoque.Getaliquotaicms(QPed.fieldbyname('mpdd_esto_codigo').Asstring,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,EdCliente.asinteger,
                                  Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring) );
              Grid.Cells[Grid.GetColumn('esto_unidade'),p]:=FEstoque.GetUnidade(QPed.fieldbyname('mpdd_esto_codigo').Asstring);
              Grid.Cells[Grid.GetColumn('move_venda'),p]:=TRansform(unitario,f_cr);
              if QPed.fieldbyname('mpdd_cubagem').asfloat>0 then begin
                Grid.Cells[Grid.GetColumn('move_qtde'),p]:=transform(QPed.fieldbyname('mpdd_cubagem').AsFloat,'###.###');
                Grid.Cells[Grid.GetColumn('total'),p]:=TRansform(QPed.fieldbyname('mpdd_cubagem').AsFloat*unitario,f_cr);
              end else begin
                Grid.Cells[Grid.GetColumn('move_qtde'),p]:=transform(qtde,f_qtdestoque);
                Grid.Cells[Grid.GetColumn('total'),p]:=TRansform(qtde*unitario,f_cr);
              end;
              Grid.Cells[Grid.getcolumn('move_remessas'),p]:='';
              Grid.Cells[Grid.getcolumn('vendamove'),p]:=Transform(QPed.fieldbyname('mpdd_venda').Ascurrency,f_cr);
      // 26.03.09 -Lam. Sao Caetano
              Grid.Cells[Grid.Getcolumn('codtamanho'),p]:=QPed.fieldbyname('mpdd_tama_codigo').Asstring;
              Grid.Cells[Grid.Getcolumn('codcor'),p]:=QPed.fieldbyname('mpdd_core_codigo').Asstring;
              Grid.Cells[Grid.Getcolumn('move_aliipi'),p]:=transform( FEstoque.Getaliquotaipi(QPed.fieldbyname('mpdd_esto_codigo').AsString,'S',EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring) ,'#0.0');
              Grid.Cells[Grid.getcolumn('cor'),p]:=FCores.Getdescricao(QPed.fieldbyname('mpdd_core_codigo').AsInteger);
              Grid.Cells[Grid.getcolumn('tamanho'),p]:=FTamanhos.Getdescricao(QPed.fieldbyname('mpdd_tama_codigo').Asinteger);
// 09.06.14 - Prever ST - Granzotto
              Grid.Cells[Grid.Getcolumn('move_natf_codigo'),p]:=
                    FSittributaria.GetCfop(codsittrib,EdNatf_codigo.text,EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring);
//              inc(p);
//              Grid.AppendRow;

            end else begin  // 12.04.10 - Granzotto - varios pedidos de venda marcados
////////////////
              if QPed.fieldbyname('mpdd_cubagem').asfloat>0 then begin
                Grid.Cells[Grid.GetColumn('move_qtde'),p]:=transform(QPed.fieldbyname('mpdd_cubagem').AsFloat+texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]),'###.###') ;
//                Grid.Cells[Grid.GetColumn('total'),p]:=TRansform(QPed.fieldbyname('mpdd_cubagem').AsFloat*unitario,f_cr);
                Grid.Cells[Grid.GetColumn('total'),p]:=TRansform( (QPed.fieldbyname('mpdd_cubagem').AsFloat*unitario)+
                                                       Texttovalor( Grid.Cells[Grid.GetColumn('total'),p] )
                                                        ,f_cr);
              end else begin

                Grid.Cells[Grid.GetColumn('move_qtde'),p]:=transform(qtde+texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]),f_qtdestoque) ;
// 03.12.14 - devereda
                if texttovalor(Grid.Cells[Grid.GetColumn('total'),p])<>0 then
                  Grid.Cells[Grid.GetColumn('total'),p]:= TRansform(qtde*unitario +
                                                        texttovalor(Grid.Cells[Grid.GetColumn('total'),p]),f_cr);
              end;
// recalcular pre�o unitario pelo valor total pois pode variar o pre�o do produto
// quando faz promo��es
// 09.04.15
//              if texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]) > 0 then begin
                Grid.Cells[Grid.GetColumn('move_venda'),p]:=TRansform(texttovalor(Grid.Cells[Grid.GetColumn('total'),p])/texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]),f_cr);
                Grid.Cells[Grid.getcolumn('vendamove'),p]:=TRansform(texttovalor(Grid.Cells[Grid.GetColumn('total'),p])/texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]),f_cr);
//              end;
//              Grid.Cells[Grid.getcolumn('vendamove'),p]:=Transform(QPed.fieldbyname('mpdd_venda').Ascurrency,f_cr);

////////////////
            end;

          end;

        end;

        QPed.Next;

      end;
    end;



////////////////////////////////////////////////////////////
begin
////////////////////////////////////////////////////////////////
// 18.03.15 - Vivan
  if campoufentidade='clie_uf' then begin // 23.03.15 - vivan cecilia
    if  not FGeral.ValidaCadastro(EdCliente.ResultFind.FieldByName('clie_situacao').AsString) then Edcliente.Invalid('');
    if ( Global.topicos[1229] )  and ( pos(EdCliente.ResultFind.FieldByName('clie_contribuinte').AsString,'1/2')=0 ) then
      EdCliente.invalid('Falta identificar se � 1-Simples  2-Icms Normal para c�lculo do pre�o de venda');
  end;
  restricao1:=true;
  restricao2:=true;
  restricao3:=true;
  restricao4:=true;
  usuariolib:=0;
  obsliberacao:='';
  unidades:=Global.Usuario.UnidadesMvto;
  EdTotalServicos.SetValue(0);
  if Global.Topicos[1255] then
    unidades:=Global.CodigoUnidade;


  if EdCliente.resultfind<>nil then begin

//////////////// restricoes de cr�dito
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

    if campoufentidade='clie_uf' then begin
      EdRepr_codigo.setvalue(Edcliente.ResultFind.fieldbyname('clie_repr_codigo').asinteger);
      if not FGeral.ValidaCliente( EdCliente,Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring ) then
        EdCliente.Invalid('');
//      revenda:=Edcliente.ResultFind.fieldbyname('clie_consfinal').asstring;
// 24.01.17
      if Edcliente.ResultFind.fieldbyname('clie_consfinal').asstring='R' then revenda:='S'
// 02.07.18
      else revenda:='N';
// 18.11.11
      if campoclifpgt.Tipo<>'' then begin
         EdFpgt_codigo.text:=EdCliente.resultfind.fieldbyname('clie_fpgt_codigo').asstring;
         EdFpgt_codigo.validfind;
      end;
// 17.01.12
      if ( (ecf='S') or (NFCe='S') ) and ( OP='I' )  then begin

   //     EdUnid_codigo.Enabled:=false;
        EdUnid_codigo.validfind;
// 17.03.14 - vivan - liane
   //     EdUnid_codigo.valid;
        EdUnid_codigo.Enabled:=true;
        EdNatf_codigo.Enabled:=false;
//        EdNatf_codigo.valid;
        if ecf='S' then
          EdDtMovimento.enabled:=false;
//        EdDtMovimento.valid;

      end else begin

//        EdUnid_codigo.Enabled:=true;
// 02.11.20
        EdUnid_codigo.Enabled := not Global.Topicos[1475];
// 01.04.15
        EdUnid_codigo.valid;
        EdNatf_codigo.Enabled:=(not Global.Topicos[1457]);
        EdDtMovimento.enabled:=true;

      end;
// 23.09.17
      campo:=Sistema.GetDicionario('clientes','clie_Descontovenda');
//      if campo.Tipo<>'' then
// 22.05.18 - VidaNova - s� aparecer no boleto o desconto nas obs na nota sai valor cheio
     if ( campo.Tipo<>'' ) and  ( not Global.Topicos[1296] ) then
        EdPerdesco.SetValue( EdCliente.resultfind.fieldbyname('clie_descontovenda').ascurrency );
// 05.06.20 - Vida Nova - 'unico cliente assim'...superpao
     if FGeral.GetConfig1AsInteger('cliedescontoliq') = Edcliente.AsInteger then

        EdPerdesco.SetValue( EdCliente.resultfind.fieldbyname('clie_descontovenda').ascurrency );


// 26.02.19
     campo:=Sistema.GetDicionario('clientes','clie_Acrescimovenda');
     if ( campo.Tipo<>'' ) then
        EdPeracre.SetValue( EdCliente.resultfind.fieldbyname('clie_acrescimovenda').ascurrency );
// 08.06.20
     campo:=Sistema.GetDicionario('clientes','clie_mens_codigo');
     if ( campo.Tipo<>'' ) then begin

        if EdCliente.ResultFind.FieldByName('clie_mens_codigo').AsInteger > 0 then begin

           EdMensagem.text := EdMensagem.text +
               FMensNotas.GetDescricao( EdCliente.ResultFind.FieldByName('clie_mens_codigo').AsInteger );

        end;

     end;

    end else begin

      if Devolucaocompra(Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring)
        or TiposFornecedor(Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring)
        or ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodNfeComplementoIPI )
        or ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodNfeComplementoIcms ) then
//        EdRepr_codigo.setvalue(0)
// 12.08.2022
        EdRepr_codigo.setvalue(1)
      else
        EdRepr_codigo.setvalue(Edcliente.ResultFind.fieldbyname('clie_repr_codigo').asinteger);
      revenda:='N';
    end;
    if OP='A' then begin  // 06.11.09
      EdRepr_codigo.enabled:=true;
      EdRepr_codigo.setfocus;
    end else begin
      if Global.Topicos[1339] then begin
        EdRepr_codigo.enabled:=false;
        EdRepr_codigo.ValidFind;  // 08.09.10
      end else
        EdRepr_codigo.enabled:=true;
    end;
    if not global.topicos[1301] then begin
// 31.08.05
      if (OP='I') and ( pos(Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,
                        Global.CodVendaAmbulante+';'+Global.CodVendaMagazine+';'+
                        Global.CodPrestacaoServicos)>0 ) then
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
//      SetaItemsConsig(Global.CodContrato,EdVendasmc);    // vendas contrato
// 25.03.10
//      SetaItemsConsig(Global.CodContrato+';'+Global.CodContratoNota,EdVendasmc);    // vendas contrato
// 28.10.2021
      SetaItemsConsig(Global.CodContrato+';'+Global.CodContratoNota+';'+Global.CodConsigMercantil,EdVendasmc);    // vendas contrato
      SetaItemsConsig(Global.CodContratoEntrega,EdDevolucoesdm);    // vendas contrato entrega

    end;
// 08.06.09 - 20.12.19 - retirado para devolucao de compra CD
//    if (OP='I') and (Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodDevolucaoCompra) then begin
//      Editsconsig('A');
//      SetaItemsConsig(Global.CodCompra,EdVendasmc);    // compras
//    end;
// 10.06.09
    if (OP='I') and (Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodRemessaIndPropria) then begin

      Editsconsig('A');
      SetaItemsConsig(Global.CodEntradaInd,EdVendasmc);    // entradas para industrializacao
      SetaItemsConsig(Global.CodRemessaIndPropria,EdDevolucoesdm);    // remessas de prod. de ind. propria

    end;

    if (OP='I') and ( not EdPedido.isempty )  and ( not QPed.Eof ) then  begin

      if QPed.fieldbyname('mped_tipo_codigo').asinteger<>EdCliente.asinteger then
        EdCliente.Invalid('Pedido pertence ao cliente '+QPed.fieldbyname('mped_tipo_codigo').asstring)
      else begin
// 27.02.23 - Guiber
        if Global.Topicos[1431] then begin
          if EdUnid_codigo.text<>QPed.fieldbyname('mped_unid_codigo').asstring then begin

              Aviso('Unidade do Pedido '+QPed.fieldbyname('mped_unid_codigo').asstring+' difere da unidade para faturamento '+EdUnid_codigo.text);

          end;
        end else begin
// 07.10.10 - Abra
          if EdUnid_codigo.text<>QPed.fieldbyname('mped_unid_codigo').asstring then begin

              EdCliente.Invalid('Unidade do Pedido '+QPed.fieldbyname('mped_unid_codigo').asstring+' difere da unidade para faturamento '+EdUnid_codigo.text);
              exit;

          end;
        end;
        SetaEditsPedido;
        SetaGridPedido;
        SetaEditsValores;
        QPed.first;  // 26.05.10
// 25.05.10 -
        if (Global.Topicos[1340]) and (EdTotalProdutos.AsCurrency>0)  then begin
          if EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring<>Global.CodVendaProntaEntrega then begin
            EdCliente.Invalid('Usar configura��o de movimento VP-Venda Pronta Entrega para faturar este pedido');
            exit;
          end;
        end;
//        if (EdTotalServicos.AsCurrency>0) and (EdTotalProdutos.AsCurrency=0) then begin
//          Avisoerro('Pedido apenas com servi�os.  Usar config. de movimento '+inttostr(FGeral.GetConfig1AsInteger('ConfMovSer'))+' ref. servi�os' );
//          QPed.First;  // para nao dar eof se o usuario 'insistir'
//          EdCliente.Invalid('');
//        end;
      end;
    end;
  end;
// 26.05.14 - vivan cobran�a angela
  if (Global.Topicos[1413]) and (campoufentidade='clie_uf') then begin
      if (trim (EdCliente.ResultFind.fieldbyname('Clie_portadores').asstring)='') then begin
        EdCliente.Invalid('Ainda n�o definido portador(es) neste cliente');
        exit
      end;
  end;
// 28.11.14 - vivan cobran�a angela
  if (Global.Topicos[1376])  and (campoufentidade='clie_uf') then begin
      //EdPort_codigo.text:='';
      if trim(EdCliente.ResultFind.fieldbyname('clie_portadores').asstring)<>'' then begin
        FPortadores.SetaItems(EdPort_codigo,EdCliente.ResultFind.fieldbyname('clie_portadores').asstring);
        EdPort_codigo.ShowForm:='';
        EdPort_codigo.setfocus;
      end else begin
        Aviso('Portador(es) ainda n�o definidos neste cliente');
        Edcliente.SetFocus;
      end;
  end;
// 04.06.18 - Giacomoni - Barbara
  if (Global.Topicos[1115])  and (campoufentidade='clie_uf') then begin
      if trim(EdCliente.ResultFind.fieldbyname('clie_condicoespag').asstring)<>'' then begin
        SetaCondicoespag( EdFpgt_codigo );
      end;
  end;

// 28.04.16
  if ( Global.Usuario.OutrosAcessos[0343] ) and ( OP='I' ) then begin
// 09.10.18 - Giacomoni
    EdUnid_codigo.Enabled:=false;
    EdUnid_codigo.Valid;
    EdEmides.Enabled:=false;
    EdEmides.text:='1';
    EdTran_codigo.text:='001';
    EdTran_codigo.validfind;
    EdTran_codigo.enabled:=false;
    EdDtSaida.Enabled:=false;
    EdDtSaida.valid;
  end;
// 27.09.17 - Novicarnes - desconto automatico
  if (campoufentidade='clie_uf') then begin

    campo:=Sistema.GetDicionario('clientes','clie_DescontoVenda');
//    if campo.Tipo<>'' then EdPerDesco.SetValue(EdCliente.resultfind.fieldbyname('clie_DescontoVenda').ascurrency);
// 22.05.18 - VidaNova - s� aparecer no boleto o desconto nas obs na nota sai valor cheio
     if ( campo.Tipo<>'' ) and  ( not Global.Topicos[1296] ) then EdPerDesco.SetValue(EdCliente.resultfind.fieldbyname('clie_DescontoVenda').ascurrency);
// 05.06.20 - Vida Nova - 'unico cliente assim'...superpao
     if FGeral.GetConfig1AsInteger('cliedescontoliq') = Edcliente.AsInteger then

        EdPerdesco.SetValue( EdCliente.resultfind.fieldbyname('clie_descontovenda').ascurrency );
// 26.02.19
    campo:=Sistema.GetDicionario('clientes','clie_AcrescimoVenda');
     if ( campo.Tipo<>'' ) then EdPeracre.SetValue(EdCliente.resultfind.fieldbyname('clie_AcrescimoVenda').ascurrency);

  end;


end;

///////////////////////////////////////////////////////////////////
procedure TFNotaSaida.EdComv_codigoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////
var QRoma,QRoma1,QN:TSqlquery;
    chavenfeacom,partesql,sqlpedido,sqldata,ctransacoes,
    xchaveref,
    sqlsemorcamentos  :string;
    ListaCidades,
    Lista,
    ListaPedidos      :TStringList;
    DataPedido        :TDatetime;

    function ValidaTiposdeSaida(xtipo:integer):boolean;
    //////////////////////////////////////////////////
    begin
      result:=true;
      if length(trim(Global.Usuario.ContasCaixaValidas))>=3 then begin
         if pos( strzero(xtipo,3),Global.Usuario.ContasCaixaValidas )>0 then
           result:=true
         else
           result:=false;
      end;
    end;

begin
/////////////////////////////////
// 12.10.16
  if not FGeral.PodeIncluirNF then EdComv_codigo.invalid('');

  EdMens_codigo.setvalue(0);
// 08.06.20
//  EdMensagem.Text:='';
  EdNomeObra.text:='';
  EdOrcamentos.Enabled:=false;
  EdOrcamentos.Visible:=false;
// 04.09.14
  Timer1.Enabled:=false;
  brelpendentes.Transparent:=true;
  brelpendentes.Font.Color:=clblack;
  if Edcomv_codigo.ResultFind=nil then
    EdComv_codigo.validfind;
// 29.10.15 - Vivan
  if not ValidaTiposdeSaida(Edcomv_codigo.asinteger) then begin
     EdComv_codigo.invalid('Tipo de Venda n�o permitida');
     exit;
  end;
// 12.12.07
  NotaTipocad:='C';
  if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.TiposEntrada+';'+Global.CodTransfSaida)>0 then
    EdComv_codigo.invalid('Movimento inv�lido para vendas')
  else if Ecf='S' then begin
//      Impr.NomeImpressora:=Impr.PegaImpPadrao;
//      if not Impr.IniciaImpr then
//        EdComv_codigo.invalid('Impressora padr�o n�o encontrada')
//      else
//        Impr.Comprime175(true);
  end;
// 08.09.05
  if DevolucaoCompra( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring)  or TiposFornecedor(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring)
//    or ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodNfeComplementoIcms )
    or ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodNfeComplementoIPI )
    then begin
    FGeral.SetaEdEntidade(EdCliente,'F');
    campoufentidade:='forn_uf';
    EdCliente.title:='Fornec.';
    EdCliente.update;
// 12.12.07 - aqui usar o EdComv_codigo.ResultFind.FieldByName('comv_tipocad').asstring
    NotaTipocad:='F';  // q poder� ser somente C ou F
//    EdCliente.FindTAble:='fornecedores';
//    EdCliente.FindField:='forn_codigo';
//    EdCliente.FindSetField:='forn_nome';
  end else begin
    FGeral.SetaEdEntidade(Edcliente,'C');
    campoufentidade:='clie_uf';
//    EdCliente.FindTAble:='clientes';
//    EdCliente.FindField:='clie_codigo';
//    EdCliente.FindSetField:='clie_nome';
  end;
// 27.03.06
  if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodRemessaInd then begin
    EdMens_codigo.setvalue(FGeral.getconfig1asinteger('CODMENREMIND'));
    EdMens_codigo.valid;
  end;
// 31.05.07 - mensagem padr�o nf saida
  if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodRemessaConserto+
         ';'+Global.CodDevolucaoCompraProdutor)=0 then begin

       EdMens_codigo.setvalue(FGeral.getconfig1asinteger('CODMENVEN'));
       EdMens_codigo.valid;

  end else
    EdMensagem.Text:='';

// 11.03.10  - Novi - vava
  if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoCompraProdutor )>0 then begin
    FGeral.Getvalor(vlrfunrural,'Funrural');
// 20.12.11  - Novi - vava+angela
    FGeral.Getvalor(vlrcotacapital,'Cota Capital');
    EdMensagem.text:='INSS : '+formatfloat(f_cr,vlrfunrural)+' '+
                     'COTA CAPITAL : '+formatfloat(f_cr,vlrcotacapital);
  end;
// 11.09.19 - Vida Nova
{
  if trim( FGeral.GetConfig1AsString('tipomovlote1')) <> '' then begin


    if Ansipos(strzero(Edcomv_codigo.AsInteger,4),FGeral.GetConfig1AsString('tipomovlote1') )>0 then begin

       Sistema.GetDataMvto('Data Fabrica��o');
       EdMensagem.text := 'LOTE 1 : Data Fabrica��o : '+FGeral.formatadata(Sistema.DataMvto);

    end;

  end;

  if trim( FGeral.GetConfig1AsString('tipomovlote2')) <> '' then begin

    if Ansipos(strzero(Edcomv_codigo.Asinteger,4),FGeral.GetConfig1AsString('tipomovlote2') )>0 then begin

       Sistema.GetDataMvto('Data Fabrica��o');
       EdMensagem.text := 'LOTE 2 : Data Fabrica��o : '+FGeral.formatadata(Sistema.DataMvto);

    end;

  end;
}


// 12.07.11
//  if Edcomv_codigo.AsInteger=FGeral.GetConfig1AsInteger('ConfMovECF') then
// 28.11.14
  if ( Edcomv_codigo.AsInteger=FGeral.GetConfig1AsInteger('ConfMovECF') )
      or
     ( Edcomv_codigo.AsInteger=FGeral.GetConfig1AsInteger('ConfMovECFVC') ) then
    Ecf:='S'
  else
    Ecf:='N';
//////////////////////
// 27.10.15
  if ( Edcomv_codigo.AsInteger=FGeral.GetConfig1AsInteger('ConfMovNFCE') )
      or
     ( Edcomv_codigo.AsInteger=FGeral.GetConfig1AsInteger('ConfMovNFCEVC') ) then
    NFCe:='S'
  else
    NFCe:='N';
//////////////////////

// 23.02.07
  if Global.Topicos[1301] then
    EdNumerodoc.setvalue( FGeral.ConsultaContador('NFSAIDA'+EdUnid_codigo.Text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade) ) + 1 );
// 07.11.07
  if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodContrato+';'+Global.CodContratoNota+';'+Global.CodContratoDoacao)>0 then begin
//     EdPedido.EditMask:='##-####-##;0;_';
// 14.07.08
//     EdPedido.EditMask:='##-####-##;1;_';
// desmudado em 27.05.09
     EdPedido.ValueFormat:='';
  end else begin
     EdPedido.EditMask:='';
     EdPedido.ValueFormat:='#####0';
  end;
// 17.06.08
  EdPedido.ItemsLength:=0;
  EdPedido.Items.Clear;  // 10.07.08
// 27.01.17 - Giacomoni
  if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodConhecimentoSaida then
     EdPedido.Enabled:=false
  else
     EdPedido.Enabled:=true;
  Edchavenfeacom.text:='';
// 02.09.10
  if ( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoCompra )
       or ( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoTributada )
       or ( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoCompraProdutor )  then begin
    EdUnitario.Decimals:=6;
    EdUnitario.ValueFormat:='###0.000000';
  end else begin
    if Global.Topicos[1357] then begin
       EdUnitario.Decimals:=2;
       EdUnitario.ValueFormat:='#####0.00';
    end else begin
       EdUnitario.Decimals:=6;
       EdUnitario.ValueFormat:='###0.000000';
    end;
  end;

// 10.12.15
  ctransacaodevolucao:='';
// 27.06.11 - Nfe complemento de Icms
  if ( (Edcomv_codigo.asinteger=FGeral.GetConfig1Asinteger('ConfNfComple'))
       or ( Ansipos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,
            Global.CodNfeComplementoQtde+';'+
            Global.CodNfeComplementoIcms+';'+
// 07.04.20 - seip - 'anula��o entrada importa��o'
// 24.07.20
//            Global.CodVendaSemMovEstoque+';'+
            Global.CodNfeComplementoIPI)>0)
       or ( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoCompra )
       or ( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoTributada )
       or ( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoTributadaCliente )
// 28.12.2022 - Vida Nova
       or ( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodComplementoValorS )
       or ( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoCompraProdutor ) )
      and (OP='I') then begin
//    Input('Informe a chave da Nfe a ser complementada ','Chave ',chavenfeacom,44,true);
//    if trim(chavenfeacom)='' then begin
//      Aviso('Obrigat�rio informar a chave em nota complementar de Icms');
//      EdComv_codigo.invalid('');
//    end;
//// 16.03.15
    Lista:=TStringList.create;
// 07.04.15 - xml 3.10
    sistema.beginprocess('Buscando nfes');
    TItensNfe:=TACBrNFe.Create(Self);
    ctransacoes:='';
    if Ansipos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,
       Global.CodDevolucaoCompra+';'+
       Global.CodDevolucaoCompraProdutor+';'+
       Global.CodDevolucaoTributadaCliente+';'+
// 07.04.20 - seip - 'anula��o entrada importa��o'
//       Global.CodVendaSemMovEstoque+';'+
// 24.07.20 - Fama retirado   para nao atrapalhar 'a venda 71' da janina
       Global.CodDevolucaoTributada)>0 then begin
// 15.05.17
      if confirma('Quer informar direto a transa��o ?') then
        Input('Informe a transa��o a ser alterada ','Transa��o ',ctransacoes,14,true)
      else
        GetListaNfe( Lista,'E' );
    end else
      GetListaNfe( Lista,'S' );
    sistema.endprocess('');

    if (Lista.count>0) and (Lista[0]<>'') then begin
       ctransacoes:=SelecionaItems(Lista,'NFe Autorizadas','',false);
       strtolista(Lista,ctransacoes,'|',true);
    end else
      Lista.Add(ctransacoes);

    if ( copy(ctransacoes,1,11)<>'Transa��o |' ) and ( trim(ctransacoes)<>'' ) then begin
       QN:=sqltoquery('select * from movesto where moes_transacao='+Stringtosql(trim(Lista[0]))+' and '+
           FGeral.GetNOTIN('moes_tipomov',Global.CodBaixaMatSai,'C') );
       if not QN.eof then begin
         Edmens_codigo.text:='';
         NotaDevolucao:=QN.fieldbyname('moes_numerodoc').AsInteger;
         DataNotaDevolucao:=QN.fieldbyname('moes_dataemissao').Asdatetime;
         ctransacaodevolucao:=QN.fieldbyname('moes_transacao').asstring;
// 01.12.15 - Mirvane - para pegar as bases de ST por item pois varia a margem de lucro...
         TItensNfe.NotasFiscais.LoadFromString(QN.fieldbyname('moes_xmlnfet').AsString,false);
         if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodNfeComplementoQtde then
           Edmensagem.text:='Complemento de quantidade da NF '+QN.fieldbyname('moes_numerodoc').AsString+' de '+FGeral.formatadata(QN.fieldbyname('moes_dataemissao').Asdatetime)
// 12.11.15
         else if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodNfeComplementoIcms then
           Edmensagem.text:='Complemento de Icms da NF '+QN.fieldbyname('moes_numerodoc').AsString+' de '+FGeral.formatadata(QN.fieldbyname('moes_dataemissao').Asdatetime)
// 12.09.17
         else if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodNfeComplementoIPI then
           Edmensagem.text:='Complemento de IPI da NF '+QN.fieldbyname('moes_numerodoc').AsString+' de '+FGeral.formatadata(QN.fieldbyname('moes_dataemissao').Asdatetime)
// 28.12.22 - Vida Nova
         else if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodComplementoValorS then
           Edmensagem.text:='Complemento de Valor da NF '+QN.fieldbyname('moes_numerodoc').AsString+' de '+FGeral.formatadata(QN.fieldbyname('moes_dataemissao').Asdatetime)
// 07.04.15
         else if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoCompra+';'+Global.CodDevolucaoCompraProdutor+';'+Global.CodDevolucaoTributada)>0 then begin
           Edmensagem.text:='Devolu��o da NF '+QN.fieldbyname('moes_numerodoc').AsString+' de '+FGeral.formatadata(QN.fieldbyname('moes_dataemissao').Asdatetime);
         end else
           Edmensagem.text:='Complemento de Icms da NF '+QN.fieldbyname('moes_numerodoc').AsString+' de '+FGeral.formatadata(QN.fieldbyname('moes_dataemissao').Asdatetime);
         EdCliente.text:=QN.fieldbyname('moes_tipo_codigo').AsString;
         EdCliente.validfind;
         EdUnid_codigo.validfind;
//         Edchavenfeacom.text:=QN.fieldbyname('moes_chavenfe').AsString;
// 16.04.15 - pegar do xml
         Edchavenfeacom.text:= copy( QN.fieldbyname('moes_xmlnfet').AsString, pos('Id="NFe',QN.fieldbyname('moes_xmlnfet').AsString)+7,44 );
         usouxml:='S';
         if Edchavenfeacom.IsEmpty then begin

           usouxml:='N';
           Input('Infome chave da NFe a ser devolvida','Chave',xchaveref,44,false);
           EdChavenfeacom.text:=xchaveref;

         end;
         if ( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodNfeComplementoQtde )
             or
            ( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoCompra )
             or
            ( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoTributada )
             or
            ( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoTributadaCliente )
// 07.04.20 - SEip
//             or
//            ( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodVendaSemMovEstoque )
             or
            ( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoCompraProdutor )
            then begin
            QBusca:=sqltoquery(FGeral.buscanf(QN.fieldbyname('moes_numerodoc').AsInteger,
                          Global.codcompra+';'+Global.CodCompraSemMovEstoque+';'+
                          Global.CodCompra100+';'+Global.CodCompraMatConsumo+';'+
// 23.06.19 - seip
                          Global.CodDrawBackEnt+';'+
// 18.08.2021 - Guiber
                          Global.CodCompraSemfinan+';'+

// 07.04.20
//                          Global.CodVendaSemMovEstoque+';'+
// 22.02.19 - Novicarnes - Vagner
                          Global.CodCompraProdutor+';'+Global.CodEntradaProdutor ,
                          QN.fieldbyname('moes_dataemissao').Asdatetime,EdUnid_codigo.text,EdCliente.asinteger,
                          0,QN.fieldbyname('moes_transacao').asstring));
// 23.11.18 - para situa��o de devolver poucos itens de nf com muuuitos itens dai digita direto...
            if confirma('Importar o(s) iten(s) da nota ?')  then begin

              if ( Ansipos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,
                   Global.CodDevolucaoCompra+';'+
                   Global.CodDevolucaoTributadaCliente+';'+
// 07.04.20 - 24.07.20
//                   Global.CodVendaSemMovEstoque+';'+
                   Global.CodDevolucaoTributada)>0 ) then begin

                Campostogrid(QBusca,'N');  // 06.11.15 - config. para dev.compra q precisam destacar icmsf
// 21.06.2021 - devolucao devereda
                SetaEditsValores;

              end else

                Campostogrid(QBusca,'S');

            end else begin

               Grid.Clear;
               Grid71.Clear;

            end;

         end;
         FGeral.FechaQuery(QN);
      end else begin
        Avisoerro('Transa��o '+trim(Lista[0])+'| n�o encontrada');
      end;
    end else begin
// 29.04.15
         if Edchavenfeacom.IsEmpty then begin
           Input('Infome chave da NFe a ser devolvida','Chave',xchaveref,44,false);
           EdChavenfeacom.text:=xchaveref;
           if Edchavenfeacom.IsEmpty then Aviso('Caso for fazer nf eletr�nica n�o ser� autorizada sem a chave da nf-e a ser devolvida');
         end;
    end;
// 29.06.20
   Lista.free;

/////
//    Edchavenfeacom.text:=chavenfeacom;
  end;

  if OP='I' then begin
// ver qual a condi��o para usar as 'saidas de abate' ou se cria permissao por usuario ou do sistema
      if ( Global.Topicos[1320] )  and
        ( EdPedido.enabled ) and
        ( FGeral.GetConfig1AsInteger('ConfMovAbate')=Edcomv_codigo.ResultFind.FieldByName('comv_codigo').asinteger )
        then begin
        EdPedido.ItemsLength:=6;
        Sistema.BeginProcess('Checando pedidos de venda frigor�fico');
        QRoma:=sqltoquery('select * from movabate '+
//                          ' where mova_tipo_codigo='+EdFornec.assql+' and mova_status=''N'''+
                          ' where mova_status=''N'''+
                          ' and ( mova_notagerada=0 or mova_notagerada is null )'+
// 16.07.20
                          ' and mova_datacont >= '+Datetosql(sistema.hoje-30)+
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
        Sistema.endProcess('');

      end else begin

/////////10.07.08
        EdPedido.ItemsLength:=6;
        partesql:=' and ( mped_nfvenda=0 or mped_nfvenda is null )'+
//                  ' and mped_situacao=''P''' ;
// 28.01.19   - Seip
//                  ' and mped_situacao=''F''' ;
// 25.04.19 - Giacomoni
                  ' and '+FGeral.GetIN('mped_situacao','F;P','C');
        sqlpedido:=' and mped_usua_autoriza>0'; // 25.09.09 - so pedidos autorizados
// 26.08.13
        if Global.Topicos[1409] then sqlpedido:='';
// 22.04.13 - Abra cuiaba
//        if Global.Usuario.OutrosAcessos[0335] then
//          partesql:=' and '+FGeral.GetIN('mped_situacao','P;E','C') ;
// 15.08.14 - retirado pois dai mostra todos os pedidos ja baixados
// 04.02.15 - Devereda
       if FGeral.Getconfig1asinteger('DIASPEDIDO')>0 then
         DataPedido:=Sistema.hoje-FGeral.Getconfig1asinteger('DIASPEDIDO')
       else
         DataPedido:=Sistema.Hoje-60;
       sqldata:=' and mped_dataemissao >= '+Datetosql(DAtaPedido);
       if Global.topicos[1386] then sqldata:=sqldata + ' and mped_dataemissao < '+Datetosql(DateToPrimeiroDiaMes(Sistema.Hoje));
// 22.11.18 - Giacomoni
       sqlsemorcamentos := '';
       if Global.Topicos[1423] then sqlsemorcamentos:=' and mped_tipomov <> '+Stringtosql(Global.CodOrcamento);

       Sistema.BeginProcess('Checando pedidos de venda');
// 29.06.20
///////////
       if Global.Topicos[1322] then begin

          ListaPedidos := TStringList.create;
          QRoma:=sqltoquery('select mped_tipo_codigo,mped_numerodoc,mped_datamvto,' +
                          'mped_tipomov,mped_unid_codigo,clie_nome from movped '+
                          ' inner join clientes on (clie_codigo = mped_tipo_codigo)'+
                          ' where mped_status=''N'''+
                          sqlpedido+sqldata+sqlsemorcamentos+
                          ' and mped_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                          partesql+
                          ' order by clie_nome');
          while not QRoma.eof do begin

             if ListaPedidos.indexof( QRoma.fieldbyname('mped_tipo_codigo').asstring ) = -1 then begin

                QRoma1:=sqltoquery('select mpdd_esto_codigo from movpeddet where mpdd_status=''N'''+
                                   ' and mpdd_numerodoc='+QRoma.fieldbyname('mped_numerodoc').asstring+
                                   ' and mpdd_unid_codigo='+Stringtosql(QRoma.fieldbyname('mped_unid_codigo').asstring)+
                                   ' and mpdd_tipo_codigo='+QRoma.fieldbyname('mped_tipo_codigo').asstring );
      //                             ' and mpdd_datamvto='+Datetosql(QRoma.fieldbyname('mped_datamvto').asdatetime) );
                if not QRoma1.eof then
                  EdPedido.Items.Add( strzero(QRoma.fieldbyname('mped_numerodoc').asinteger,6)+
                             ' - '+FGeral.formatadata(QRoma.fieldbyname('mped_datamvto').asdatetime)+
                             ' - '+(QRoma.fieldbyname('mped_tipomov').asstring)+
                             ' - '+FGeral.GetNomeRazaoSocialEntidade(QRoma.fieldbyname('mped_tipo_codigo').asinteger,'C','N')  );
                fGeral.fechaQuery(Qroma1);
                ListaPedidos.add( QRoma.fieldbyname('mped_tipo_codigo').asstring );

             end;

             Qroma.next;

          end;
          FGeral.FechaQuery(QRoma);
          ListaPedidos.free;

       end else begin

              QRoma:=sqltoquery('select * from movped '+
    //                          ' where mova_tipo_codigo='+EdFornec.assql+' and mova_status=''N'''+
                              ' where mped_status=''N'''+
    //                          ' and mpdd_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                              sqlpedido+sqldata+sqlsemorcamentos+
    // 30.01.15 - coorlaf
                              ' and mped_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                              partesql+
                              ' order by mped_datamvto desc');


            while not QRoma.eof do begin
    // 03.12.14
              QRoma1:=sqltoquery('select mpdd_esto_codigo from movpeddet where mpdd_status=''N'''+
                                 ' and mpdd_numerodoc='+QRoma.fieldbyname('mped_numerodoc').asstring+
                                 ' and mpdd_unid_codigo='+Stringtosql(QRoma.fieldbyname('mped_unid_codigo').asstring)+
                                 ' and mpdd_tipo_codigo='+QRoma.fieldbyname('mped_tipo_codigo').asstring );
    //                             ' and mpdd_datamvto='+Datetosql(QRoma.fieldbyname('mped_datamvto').asdatetime) );
              if not QRoma1.eof then
                EdPedido.Items.Add( strzero(QRoma.fieldbyname('mped_numerodoc').asinteger,6)+
                           ' - '+FGeral.formatadata(QRoma.fieldbyname('mped_datamvto').asdatetime)+
                           ' - '+(QRoma.fieldbyname('mped_tipomov').asstring)+
                           ' - '+FGeral.GetNomeRazaoSocialEntidade(QRoma.fieldbyname('mped_tipo_codigo').asinteger,'C','N')  );
              fGeral.fechaQuery(Qroma1);
              QRoma.Next
            end;
            FGeral.FechaQuery(QRoma);

       end;

       Sistema.endProcess('');

/////////////////
      end;
// 06.01.12 - Capeg
      if ( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodRomaneioRemessaaOrdem )
         and ( OP='I' ) then begin
        DateTimePicker1.Visible:=true;
        DateTimePicker1.Enabled:=true;
      end else begin
        DateTimePicker1.Visible:=false;
        DateTimePicker1.Enabled:=false;
      end;
  end;

// 16.07.19 - Ct-e - Pedro
   EdTomador.enabled:=false;
   EdTomador.visible:=false;
   EdTomador.Clear;

   EdCida_codigo.Visible:=true;

//////////////////
// if not Arq.TConfMovimento.locate('comv_codigo',Edcomv_codigo.Text,[]) then
//    EdComv_codigo.invalid('Codigo n�o encontrado')
// 17.11.14
  Arq.TConfMovimento.locate('comv_codigo',Edcomv_codigo.Text,[]);
  if OP='A' then
    EdNumerodoc.setfocus;   // 28.06.05
// 02.12.08 - Vims
  if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodContrato+';'+Global.CodContratoNota)>0 then begin
    EdRepr_codigo2.enabled:=true;
    Edpercomissao2.enabled:=Global.Topicos[1324];  // 20.05.13
  end else begin
    EdRepr_codigo2.enabled:=false;
    Edpercomissao2.enabled:=false;
  end;
// 24.08.11 - Capeg
  if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodVendaaOrdem)>0 then begin
    ListaCidades:=TStringList.create;
    EdCida_codigo.enabled:=true;
    QRoma:=Sqltoquery('select moes_cida_codigo,cida_nome from movesto inner join cidades on ( cida_codigo=moes_cida_codigo )'+
                      ' where moes_tipomov='+Stringtosql(Global.CodRomaneioRemessaaOrdem)+
                      ' and '+FGeral.GetIN('moes_status','N','C')+
//                      ' and moes_datasaida>='+Datetosql( DateToPrimeiroDiaMes(EdDtEmissao.asdate) )+
// 03.07.14 - Capeg - pega do mes anterior pois sempre � feito com data 'retroativa' a emissao destas notas
                      ' and moes_datasaida>='+Datetosql( DateToPrimeiroDiaMes(DateToDateMesAnt(Sistema.hoje,1)) )+
                      ' and moes_datasaida<='+EdDtEmissao.assql+
                      ' order by cida_nome' );
    EdCida_codigo.Items.Clear;
    while not QRoma.eof do begin
      if ListaCidades.IndexOf( Strzero(QRoma.fieldbyname('moes_cida_codigo').asinteger,4) )=-1 then begin
        EdCida_codigo.Items.add(Strzero(QRoma.fieldbyname('moes_cida_codigo').asinteger,4)+' - '+QRoma.fieldbyname('cida_nome').asstring );
        ListaCidades.add( Strzero(QRoma.fieldbyname('moes_cida_codigo').asinteger,4) );
      end;
      QRoma.Next;
    end;
    FGeral.FechaQuery(QRoma);
    ListaCidades.free;
  end else
    EdCida_codigo.enabled:=false;
  if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodNotaRemessaaOrdem)>0 then
     EdMensagem.text:='';
// 06.01.12 - Benatto - agilidade no balcao
  if Global.Usuario.OutrosAcessos[0328] then begin
     if (Ecf='S')  then begin
       EdMens_codigo.enabled:=false;
       EdMensagem.enabled:=false;
     end;
     if not DevolucaoCompra( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring)  then begin
       EdQTdeVolumes.enabled:=false;
       EdEspecievolumes.enabled:=false;
       EdPesoliq.enabled:=false;
       EdPesoBru.enabled:=false;
     end else begin
       EdMens_codigo.enabled:=true;
       EdMensagem.enabled:=true;
     end;
  end else begin
     EdMens_codigo.enabled:=true;
     EdMensagem.enabled:=true;
     EdQTdeVolumes.enabled:=true;
     EdEspecievolumes.enabled:=true;
     EdPesoliq.enabled:=true;
     EdPesoBru.enabled:=true;
  end;
// 17.01.12 - Benatto - agilidade no balcao
  if ( ecf='S' ) and ( OP='I' ) then begin
    EdCliente.text:=FGeral.GetConfig1AsString('clieconsumidor');
// 03.01.13 - Simar
    if Global.Topicos[1359] then begin
      EdCliente.valid;
      EdCliente.enabled:=false;
    end else
      EdCliente.enabled:=true;
    EdEmides.Enabled:=false;
    EdEmides.text:='1';
    EdTran_codigo.text:='001';
    EdTran_codigo.validfind;
    EdTran_codigo.enabled:=false;
    EdDtSaida.Enabled:=false;
    EdDtSaida.valid;
  end else begin
    EdEmides.Enabled:=true;
    EdTran_codigo.enabled:=true;
    EdDtSaida.Enabled:=true;
    EdCliente.enabled:=true;
  end;
// 26.02.12
  if pos( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodConhecimentoSaida ) = 0 then begin
    Grid71.clear;
    bregistro71.enabled:=false;
  end else
    bregistro71.enabled:=true;
// 09.11.13
  Edvlroutrasdespesas.Enabled:=false;
  if pos( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoTributada+';'+
          Global.CodDevolucaoSaida+';'+
          Global.CodNfeComplementoIcms+';'+
// 07.04.20 - 24.07.20
//          Global.CodVendaSemMovEstoque+';'+
          Global.CodNfeComplementoIPI ) > 0 then
    Edvlroutrasdespesas.Enabled:=true;
// 31.05.14  - CTe
  if pos( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodConhecimentoSaida ) > 0 then begin
    EdDesti_codigo.enabled:=true;
    EdDesti_codigo.Visible:=true;
    SetEdDesti_nome.Visible:=true;
//    EdCliente.title:='Origem';
// 30.01.17
    EdCliente.title:='Destino';
    SetedClie_nome.width:=100;
// 16.07.19 - Ct-e - Pedro
{
   EdTomador.enabled:=true;
   EdTomador.visible:=true;
   EdTomador.left:=EdCida_codigo.left;
   EdTomador.Top:=EdCida_codigo.top;
   EdCida_codigo.Visible:=false;
}
  end else begin
///    EdCliente.title:='Cliente';  // 06.11.15
    SetedClie_nome.width:=188;
    SetEdDesti_nome.enabled:=false;
    EdDesti_codigo.Visible:=false;
    SetEdDesti_nome.Visible:=false;

  end;

end;

procedure TFNotaSaida.EdMoes_tabp_codigoValidate(Sender: TObject);
begin
  SetEdTabp_aliquota.text:=FTabela.GetDescAliquota(EdMoes_tabp_codigo.asinteger)
end;

procedure TFNotaSaida.EdPeracreValidate(Sender: TObject);
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

procedure TFNotaSaida.EdperdescoValidate(Sender: TObject);
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

procedure TFNotaSaida.EdVlracreValidate(Sender: TObject);
var valor:currency;
    peracre:extended;

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

procedure TFNotaSaida.EdVlrdescoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////
var perdesc:extended;
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
// 04.04.13 - Simar - Desconto em cupom fiscal
  if (OP='I') and (ECF='S') then begin
    if (EdCliente.asinteger=FGeral.GetConfig1AsInteger('clieconsumidor') ) then begin
      EdFpgt_codigo.text:=FGeral.getconfig1asstring('Fpgtoavista');
      if not EdFpgt_codigo.valid then begin
        EdFpgt_codigo.enabled:=true;
        EdFpgt_codigo.setfocus;
      end else begin
        EdFpgt_codigo.enabled:=false;
        EdFpgt_codigo.Next;
      end;
    end else begin
      EdFpgt_codigo.text:='';
      EdFpgt_codigo.enabled:=true;
      EdFpgt_codigo.setfocus;
    end;
  end;
///////////////////////////////
end;

// 18.01.17
procedure TFNotaSaida.EdEspecievolumesValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin
   if EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodConhecimentoSaida then
     if EdEspecievolumes.IsEmpty then EdEspecievolumes.Invalid('Obrigat�rio informar tipo de volume');
end;

procedure TFNotaSaida.EdNumeroDocValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////////////
var QBusca:TSqlquery;
    Numero:integer;
begin
  if EdNumerodoc.AsInteger>0 then begin
//     if OP='I' then begin  // 17.11.04
     if OP='A' then begin
       QBusca:=sqltoquery(FGeral.buscanf(EdNumerodoc.AsInteger,Global.CodVendaDireta,EdDtemissao.asdate,EdUnid_codigo.text,EdCliente.asinteger));
       if QBusca.eof then begin
//         QBusca:=sqltoquery(FGeral.buscanf(EdNumerodoc.AsInteger,Global.CodVendaConsig,EdDtemissao.asdate));
// 28.06.05
         QBusca:=sqltoquery(FGeral.buscanf(EdNumerodoc.AsInteger,EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,EdDtemissao.asdate,EdUnid_codigo.text,EdCliente.asinteger));
         if QBusca.eof then begin
           EdNUmerodoc.INvalid('Numero de nota n�o encontrado tipo '+EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring);
           EdNumerodoc.ClearAll(FNotaSaida,99);
           Grid.Clear;
         end else begin
           Campostoedits(Qbusca);
           Campostogrid(Qbusca);
           if DevolucaoCompra( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring)  or TiposFornecedor(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring) then begin
             FGeral.SetaEdEntidade(EdCliente,'F');
             campoufentidade:='forn_uf';
             NotaTipocad:='F';
           end else begin
             FGeral.SetaEdEntidade(EdCliente,'C');
             campoufentidade:='clie_uf';
             NotaTipocad:='C';
           end;
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

         if DevolucaoCompra( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring)  or TiposFornecedor(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring) then begin
             FGeral.SetaEdEntidade(EdCliente,'F');
             campoufentidade:='forn_uf';
             NotaTipocad:='F';
         end else begin
             FGeral.SetaEdEntidade(EdCliente,'C');
             campoufentidade:='clie_uf';
             NotaTipocad:='C';
         end;
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

         EdNUmerodoc.INvalid('Numero de nota encontrado em '+formatdatetime('dd/mm/yyyy',QBusca.fieldbyname('move_datamvto').asdatetime)+'.   Digita��o n�o permitida');
//         EdNumerodoc.ClearAll(FNotaSaida,99);
         Grid.Clear;

// 08.03.20 - A2z - thais
       end else if (QBusca.eof) and (OP='I')  then begin

          QBusca.Close;
          QBusca:=sqltoquery( 'select moes_transacao,moes_dataemissao from movesto '+
                              ' where moes_numerodoc = '+EdNumerodoc.AsSql+
                              ' and moes_tipomov = '+Stringtosql( EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring )+
                              ' and extract( year from moes_dataemissao ) = '+
                              strzero( Datetoano(EdDtEmissao.asdate,true) ,4 )+
                              ' and moes_status = ''N'''+
                              ' and moes_unid_codigo = '+EdUNid_codigo.assql );
          if not Qbusca.Eof then Aviso('ATEN��O !!! Numero j� encontrado em '+FGeral.FormataData(QBusca.FieldByName('moes_dataemissao').AsDateTime) );


       end else if OP='S' then begin

         Numero:=FGeral.ConsultaContador('NFSAIDA'+EdUnid_codigo.Text+FGeral.Qualserie(Arq.TConfMovimento.fieldbyname('comv_serie').asstring,Global.serieunidade));
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
// 13.08.12
       if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodVendaMagazine then begin
          QBusca:=sqltoquery(FGeral.buscanf(EdNumerodoc.AsInteger,Global.CodVendaMagazine));
          if not Qbusca.eof then
             EdNUmerodoc.INvalid('Numero de nota '+Global.CodVendaMagazine+' encontrado.   Digita��o n�o permitida');
       end;
     end;
     QBusca.close;
  end;

end;

procedure TFNotaSaida.Campostoedits(Q: TSqlquery);
///////////////////////////////////////////////////
var QPendencia,QMovfin:TSqlquery;
    p:integer;
    alteroucli:boolean;

    Function GetEquipamento( xoperacao:string ):string;
    ////////////////////////////////////////////////////
    begin
       if trim(xoperacao)<>'' then result:=copy( xoperacao,pos(';',xoperacao)+1,4 )
       else result:='';
    end;


begin
///////////////////////////
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
// 12.08.2022 - para alteracao de notas de saida para fornecedor q n�o tem o campo do representante ficando zerado...
  if trim(EdRepr_codigo.Text)='' then EdRepr_codigo.Text:='1';

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
// 27.11.09
  campo:=Sistema.GetDicionario('movesto','moes_datasaida');
  if Campo.Tipo<>'' then
    EdDtSaida.setdate(Q.fieldbyname('moes_datasaida').Asdatetime)
  else
    EdDtSaida.setdate(Q.fieldbyname('moes_dataemissao').Asdatetime);
  EdDtMovimento.setdate(Q.fieldbyname('moes_datacont').Asdatetime);
  EdQtdevolumes.setvalue(Q.fieldbyname('moes_qtdevolume').Asinteger);
  EdEspecievolumes.text:=(Q.fieldbyname('moes_especievolume').Asstring);
//  EdPeracre.setvalue(Q.fieldbyname('moes_peracres').ascurrency);
// 16.12.2022 - Devereda - acrescimo de 32 sobre 4.400
  EdPeracre.setvalue(Q.fieldbyname('moes_peracres').AsFloat);
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
// 28.04.10 - Abra
  EdRepr_codigo2.Text:=Q.fieldbyname('moes_repr_codigo2').AsString;
  Edpercomissao.text:=Q.fieldbyname('moes_percomissao').AsString;
  Edpercomissao2.text:=Q.fieldbyname('moes_percomissao2').AsString;
///////////
// 24.03.11 - Lam. Sao Caetano - exportacao
   campo:=Sistema.GetDicionario('movesto','moes_estadoex');
   if Campo.Tipo<>'' then
      EdEstadoex.text:=Q.fieldbyname('moes_estadoex').AsString;
  Edportoorigem.text:=Q.fieldbyname('moes_embarque').AsString;
  Edportodestino.text:=Q.fieldbyname('moes_destino').AsString;
  Edcontainer.text:=Q.fieldbyname('moes_container').AsString;
// 27.06.11
////////////////
  campo:=Sistema.GetDicionario('movesto','moes_chavenferef');
  if Campo.Tipo<>'' then
    Edchavenfeacom.text:=Q.fieldbyname('moes_chavenferef').asstring;
// 11.11.13 - Metalforte
  Edvlroutrasdespesas.setvalue( Q.fieldbyname('moes_outrasdesp').ascurrency );
// 06.02.14 - A2Z
  EdCodEqui.text:=GetEquipamento( Q.fieldbyname('move_remessas').asstring );
// 01.06.14
  EdDesti_codigo.text:=Q.fieldbyname('moes_clie_codigo').asstring;
// 12.06.17
  Edvlrcofins.SetValue(Q.fieldbyname('moes_valorcofins').ascurrency);
  Edvlrpis.SetValue(Q.fieldbyname('moes_valorpis').ascurrency);
  Edvlrir.SetValue(Q.fieldbyname('moes_valorir').ascurrency);
  Edvlriss.SetValue(Q.fieldbyname('moes_valoriss').ascurrency);
  Edvlrcsll.SetValue(Q.fieldbyname('moes_valorcsl').ascurrency);
// 22.01.19
  EdPedido.Setvalue(Q.fieldbyname('moes_pedido').asinteger);
// 01.08.19
  if (Global.Topicos[1365]) then EdSeto_codigo.text:=Q.fieldbyname('moes_seto_Codigo').asstring
  else EdSeto_codigo.text:='';

  QMovfin:=sqltoquery( FGeral.BuscaTransacao(Transacao,'movfin','movf_transacao','movf_status','N','') );
  p:=1;
  if not QMovfin.eof then begin

    Gridparcelas.cells[Gridparcelas.Getcolumn('pend_valor'),p]:=Formatfloat(f_cr,QMovfin.fieldbyname('movf_valorger').ascurrency);
    Gridparcelas.cells[Gridparcelas.Getcolumn('pend_datavcto'),p]:=Formatdatetime('dd/mm/yyyy',QMovfin.fieldbyname('movf_datamvto').asdatetime);
    inc(p);

  end;
  QPendencia:=sqltoquery( FGeral.BuscaTransacao(Transacao,'pendencias','pend_transacao','pend_status','N','pend_datavcto','pend_tipomov',Q.fieldbyname('moes_tipomov').AsString) );
  if QPendencia.eof then begin
     FGeral.FechaQuery(QPendencia);
     QPendencia:=sqltoquery( FGeral.BuscaTransacao(Transacao,'pendencias','pend_transacao','pend_status','K','pend_datavcto') );
  end;
  if not QPendencia.eof then begin
    EdPort_codigo.text:=QPendencia.fieldbyname('pend_port_codigo').asstring;
    EdPort_descricao.Text:=FPortadores.GetDescricao(QPendencia.fieldbyname('pend_port_codigo').Asstring);
    EdFpgt_codigo.text:=QPendencia.fieldbyname('pend_fpgt_codigo').asstring;
    EdFpgt_descricao.text:=FCondpagto.GetDescricao(QPendencia.fieldbyname('pend_fpgt_codigo').asstring);
// 31.07.19
    if (Global.Topicos[1365]) then EdSeto_codigo.text:=QPendencia.fieldbyname('Pend_seto_Codigo').asstring
    else EdSeto_codigo.text:='';

    while not QPendencia.eof do begin

      Gridparcelas.cells[Gridparcelas.Getcolumn('pend_valor'),p]:=Formatfloat(f_cr,QPendencia.fieldbyname('pend_valor').ascurrency);
      Gridparcelas.cells[Gridparcelas.Getcolumn('pend_datavcto'),p]:=Formatdatetime('dd/mm/yyyy',QPendencia.fieldbyname('pend_datavcto').asdatetime);
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
//    EdVlrdesco.setvalue(Edtotalnota.ascurrency*(EdPerdesco.ascurrency/100));
//    EdVlracre.setvalue(Edtotalnota.ascurrency*(EdPeracre.ascurrency/100));
// 21.09.11
    EdVlrdesco.setvalue(Edtotalprodutos.ascurrency*(EdPerdesco.ascurrency/100));
    EdVlracre.setvalue(Edtotalprodutos.ascurrency*(EdPeracre.ascurrency/100));
  end;
//  EdFpgt_codigo.ValidateEdit;
//  EdFpgt_codigo.DoValidate;
end;

// 17.03.15 - parametro Zeraicms
procedure TFNotaSaida.Campostogrid(Q: TSqlquery;ZeraIcms:string='N');
///////////////////////////////////////////////////////////////////////
var p,l,codsittrib,subgrupodevcompra:integer;
    unitario:currency;
    faz:boolean;
    Q71:TSqlquery;
    xtransacao,cstcfop:string;

    function ConverteCfop( xcfop:string ):string;
    /////////////////////////////////////////////////
    begin
      if  ( Ansipos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString,
                    Global.CodDevolucaoCompra+';'+
                    Global.CodDevolucaoTributadaCliente+';'+
                    Global.CodDevolucaoTributada)>0 ) then begin

        if pos(xcfop,'2403/2401') > 0 then result:='6411'
        else if pos(xcfop,'1403/1401') > 0 then result:='5411'
        else if pos(xcfop,'1101') > 0 then result:='5201'
        else if pos(xcfop,'1102') > 0 then result:='5202'
        else if pos(xcfop,'2101') > 0 then result:='6201'
        else if pos(xcfop,'2102') > 0 then result:='6202'
        else if pos(xcfop,'3101') > 0 then result:='7201'
        else if pos(xcfop,'3102') > 0 then result:='7202'

      end else begin

        if pos(xcfop,'2403/2401') > 0 then result:='6404'
        else if pos(xcfop,'1403/1401') > 0 then result:='5405'
        else if copy(xcfop,1,1)='1' then
          result:='5'+copy(xcfop,2,3)
        else if copy(xcfop,1,1)='2' then
          result:='6'+copy(xcfop,2,3)
// 06.05.16
        else result:=xcfop
     end;
    end;

    function GetBaseST:string;
    ////////////////////////////
    var i:integer;
    begin
       result:='0';
//       if TItensNFe<>nil then begin
        if usouxml='S' then begin
          for i:=0 to TItensNFe.NotasFiscais.Items[0].NFe.Det.Count-1 do begin
            if ( Valortosql( TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Prod.vUnCom ) = Valortosql( Q.fieldbyname('move_venda').ascurrency) )
               and ( Valortosql( TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Prod.qCom ) = Valortosql( Q.fieldbyname('move_qtde').ascurrency) )
// 18.06.2021
               and ( TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Prod.cEan  = FEstoque.GetCodigodeBarra(Q.fieldbyname('move_esto_codigo').asstring) ) then begin
//               and ( Valortosql( TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Imposto.ICMS.pICMS ) = Valortosql( Q.fieldbyname('move_aliicms').ascurrency ) ) then begin

               result:=Valortosql(TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Imposto.ICMS.vBCST);
               break;

            end;
         end;
       end;
//       if result='0' then Aviso( Q.fieldbyname('move_esto_codigo').asstring+'|'+Q.fieldbyname('move_venda').asstring+'|'+Q.fieldbyname('move_qtde').asstring+'|' );
    end;

    function GetValorST:string;
    ////////////////////////////
    var i:integer;
    begin
       result:='0';
//       if TItensNFe<>nil then begin
// 05.04.16
        if usouxml='S' then begin
         for i:=0 to TItensNFe.NotasFiscais.Items[0].NFe.Det.Count-1 do begin
            if ( Valortosql( TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Prod.vUnCom ) = Valortosql( Q.fieldbyname('move_venda').ascurrency) )
               and ( Valortosql( TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Prod.qCom ) = Valortosql( Q.fieldbyname('move_qtde').ascurrency) )
//               and ( Valortosql( TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Imposto.ICMS.pICMS ) = Valortosql( Q.fieldbyname('move_aliicms').ascurrency ) ) then begin
// 18.06.2021
               and ( TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Prod.cEan  = FEstoque.GetCodigodeBarra(Q.fieldbyname('move_esto_codigo').asstring) ) then begin

               result:=Valortosql(TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Imposto.ICMS.vIcmsST);
               break;

            end;
         end;
       end;
//       if result='0' then Aviso( Q.fieldbyname('move_esto_codigo').asstring+'|'+Q.fieldbyname('move_venda').asstring+'|'+Q.fieldbyname('move_qtde').asstring+'|' );
    end;

    // 31.05.17
    function GetAliicmsST:string;
    //////////////////////////////
    var i:integer;
    begin
       result:='0';
        if usouxml='S' then begin
         for i:=0 to TItensNFe.NotasFiscais.Items[0].NFe.Det.Count-1 do begin
            if ( Valortosql( TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Prod.vUnCom ) = Valortosql( Q.fieldbyname('move_venda').ascurrency) )
               and ( Valortosql( TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Prod.qCom ) = Valortosql( Q.fieldbyname('move_qtde').ascurrency) )
//               and ( Valortosql( TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Imposto.ICMS.pICMS ) = Valortosql( Q.fieldbyname('move_aliicms').ascurrency ) ) then begin
 // 18.06.2021
               and ( TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Prod.cEan  = FEstoque.GetCodigodeBarra(Q.fieldbyname('move_esto_codigo').asstring) ) then begin

              result:=Valortosql(TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Imposto.ICMS.pICMSST);
               break;

            end;
         end;
       end;
    end;

    // 18.06.2021
    function GetAliicms:string;
    //////////////////////////////
    var i:integer;
    begin
       result:='0';
        if usouxml='S' then begin
         for i:=0 to TItensNFe.NotasFiscais.Items[0].NFe.Det.Count-1 do begin
            if ( Valortosql( TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Prod.vUnCom ) = Valortosql( Q.fieldbyname('move_venda').ascurrency) )
               and ( Valortosql( TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Prod.qCom ) = Valortosql( Q.fieldbyname('move_qtde').ascurrency) )
//               and ( Valortosql( TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Imposto.ICMS.pICMS ) = Valortosql( Q.fieldbyname('move_aliicms').ascurrency ) ) then begin
 // 18.06.2021
               and ( TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Prod.cEan  = FEstoque.GetCodigodeBarra(Q.fieldbyname('move_esto_codigo').asstring) ) then begin

              result:=Valortosql(TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Imposto.ICMS.pICMS);
              break;

            end;
         end;
       end;
    end;


    // 21.06.2021
    function GetvfcpST:string;
    //////////////////////////////
    var i:integer;
    begin
       result:='0';
        if usouxml='S' then begin
         for i:=0 to TItensNFe.NotasFiscais.Items[0].NFe.Det.Count-1 do begin
            if ( Valortosql( TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Prod.vUnCom ) = Valortosql( Q.fieldbyname('move_venda').ascurrency) )
               and ( Valortosql( TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Prod.qCom ) = Valortosql( Q.fieldbyname('move_qtde').ascurrency) )
               and ( TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Prod.cEan  = FEstoque.GetCodigodeBarra(Q.fieldbyname('move_esto_codigo').asstring) ) then begin

               result:=Valortosql(TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Imposto.ICMS.vFCPST);
               break;

            end;
         end;
       end;
    end;


begin
/////////////////////
  Grid.Clear;p:=1;Q.First;
  faz:=true;
  subgrupodevcompra:=FGeral.Getconfig1asinteger('subgrupodevcom');
//  if FGeral.usuarioteste(global.usuario.codigo) and (Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodVendaREFinal) then begin
//    if confirma('Buscar pre�o de venda do cadastro ? ') then
//      faz:=true
//    else
//      faz:=false;
//  end;
  xtransacao:='';
  if not Q.eof then xtransacao:=Q.fieldbyname('move_transacao').Asstring;

  while not Q.Eof do begin

// 17.05.06 - devido ao 'rolo' do reg. especial
    if (Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodVendaREFinal) and (faz) then
      unitario:=FEstoque.Getpreco(Q.fieldbyname('move_esto_codigo').Asstring,Global.unidadematriz)
    else
//      unitario:=Q.fieldbyname('move_venda').Ascurrency;
// 26.05.09 - Asatec - preco unitario com 3 decimais
      unitario:=Q.fieldbyname('move_venda').AsFloat;
    Grid.Cells[Grid.GetColumn('move_esto_codigo'),p]:=Q.fieldbyname('move_esto_codigo').Asstring;
// 24.04.13 - Abra Cuiaba
    Grid.Cells[Grid.getcolumn('esto_referencia'),p]:=FEstoque.GetReferencia(Q.fieldbyname('move_esto_codigo').asstring);
    Grid.Cells[Grid.GetColumn('esto_descricao'),p]:=FEstoque.GetDescricao(Q.fieldbyname('move_esto_codigo').Asstring);

    Grid.Cells[Grid.GetColumn('move_cst'),p]:=Q.fieldbyname('move_cst').Asstring;

// 16.04.15
    if (pos(EdUnid_codigo.resultfind.fieldbyname('unid_simples').AsString,'S;2')>0) and
       ( pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString,Global.CodDevolucaoCompra+';'+Global.CodDevolucaoTributada)>0 )
      and ( OP='I' )   // 18.04.17
      then begin
//      if Q.fieldbyname('move_aliicms').Ascurrency>0 then
        cstcfop:='900';
//      else
//        cstcfop:=FEstoque.Getsituacaotributaria(Q.fieldbyname('move_esto_codigo').Asstring,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,
//                      Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,EdCliente.asinteger,
//                      revenda,EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring);
      Grid.Cells[Grid.GetColumn('move_cst'),p]:=cstcfop;
    end;
    if zeraicms='S' then begin

      Grid.Cells[Grid.GetColumn('move_aliicms'),p]:='';
      Grid.Cells[Grid.getcolumn('move_redubase'),p]:='';

    end else begin
//      if (subgrupodevcompra>0) and ( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString=Global.CodDevolucaoCompra ) then
//        Grid.Cells[Grid.GetColumn('move_aliicms'),p]:=transform(FEstoque.GetAliquotaicms(Q.fieldbyname('move_esto_codigo').Asstring,
//                EdUnid_codigo.text,
//                EdCliente.resultfind.fieldbyname(campoufentidade).asstring,0,Global.CodDevolucaoCompra),'#0.0')
//      else

        Grid.Cells[Grid.GetColumn('move_aliicms'),p]:=transform(Q.fieldbyname('move_aliicms').Ascurrency,'#0.0');
// 18.06.2021
        if  Usouxml = 'S' then

           Grid.Cells[Grid.GetColumn('move_aliicms'),p] := GetAliIcms;

// 11.12.08
      Grid.Cells[Grid.getcolumn('move_redubase'),p]:=Q.fieldbyname('move_redubase').AsString;

    end;
    Grid.Cells[Grid.GetColumn('esto_unidade'),p]:=Arq.TEstoque.fieldbyname('esto_unidade').asstring;
    Grid.Cells[Grid.GetColumn('move_qtde'),p]:=transform(Q.fieldbyname('move_qtde').AsFloat,f_qtdestoque);
// 26.08.19
    if Global.Topicos[1463] then
       Grid.Cells[Grid.GetColumn('move_qtde'),p]:=transform(Q.fieldbyname('move_qtde').AsFloat,f_cr4);

//    Grid.Cells[Grid.GetColumn('move_venda'),p]:=TRansform(unitario,f_cr);
// 26.05.09 - Asatec - preco unitario com 3 decimais
    Grid.Cells[Grid.GetColumn('move_venda'),p]:=TRansform(unitario,f_cr3);

//    Grid.Cells[Grid.GetColumn('total'),p]:=TRansform(Q.fieldbyname('move_qtde').AsFloat*unitario,f_cr);
// 30.12.2022
    Grid.Cells[Grid.GetColumn('total'),p]:=TRansform(Q.fieldbyname('move_qtde').AsFloat*unitario,f_cr4);

    Grid.Cells[Grid.getcolumn('move_remessas'),p]:=Q.fieldbyname('move_remessas').Asstring;
    Grid.Cells[Grid.getcolumn('vendamove'),p]:=Transform(Q.fieldbyname('move_venda').AsFloat,f_cr);
    Grid.Cells[Grid.getcolumn('move_pecas'),p]:=Q.fieldbyname('move_pecas').AsString;
    Grid.Cells[Grid.getcolumn('move_vendamin'),p]:=Q.fieldbyname('move_vendamin').AsString;
// 23.12.08
    Grid.Cells[Grid.Getcolumn('move_certificado'),p]:=Q.fieldbyname('move_certificado').AsString;
// 19.02.09
    if zeraicms='S' then
      Grid.Cells[Grid.getcolumn('move_aliipi'),p]:=''
    else
      Grid.Cells[Grid.getcolumn('move_aliipi'),p]:=transform(Q.fieldbyname('move_aliipi').Ascurrency,'#0.0');
// 15.05.09 - clessi
    Grid.Cells[Grid.getcolumn('tamanho'),p]:=FTamanhos.GetDescricao(Q.fieldbyname('move_tama_codigo').AsInteger);
    Grid.Cells[Grid.getcolumn('cor'),p]:=FCores.GetDescricao(Q.fieldbyname('move_core_codigo').AsInteger);
    Grid.Cells[Grid.getcolumn('codtamanho'),p]:=Q.fieldbyname('move_tama_codigo').AsString;
    Grid.Cells[Grid.getcolumn('codcor'),p]:=Q.fieldbyname('move_core_codigo').AsString;
// 13.07.09
    if (Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodRemessaInd) then begin

      campo:=Sistema.GetDicionario('movestoque','move_core_codigoind');
      if campo.Tipo<>'' then
        Grid.Cells[Grid.getcolumn('move_core_codigoind'),p]:=Q.fieldbyname('move_core_codigoind').AsString;

    end;
// 08.09.10
    campo:=Sistema.GetDicionario('movestoque','move_natf_codigo');
    if campo.Tipo<>'' then begin
// 06.08.18
       if OP='I' then
         Grid.Cells[Grid.getcolumn('move_natf_codigo'),p]:=ConverteCfop( Q.fieldbyname('move_natf_codigo').AsString )
       else
         Grid.Cells[Grid.getcolumn('move_natf_codigo'),p]:=Q.fieldbyname('move_natf_codigo').AsString;
    end;
// 16.04.15
    if (pos(EdUnid_codigo.resultfind.fieldbyname('unid_simples').AsString,'S;2')>0) and
       ( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString=Global.CodDevolucaoCompra )
      then begin

      codsittrib:=FEstoque.GetCodigosituacaotributaria(EdProduto.text,EdUnid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring);
      Grid.Cells[Grid.getcolumn('move_natf_codigo'),p]:=FSittributaria.GetCfop(codsittrib,EdNatf_codigo.text,EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring) ;

    end;
// 01.12.15 - devolucao de compra pra tributar icms st
    if ( pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString,Global.CodDevolucaoCompra+';'+Global.CodDevolucaoTributada)>0 ) then begin

      Grid.cells[Grid.getcolumn('basest'),p]:=GetBaseST;
      Grid.cells[Grid.getcolumn('valorst'),p]:=GetValorST;
      // 31.05.17
      Grid.cells[Grid.getcolumn('aliicmsst'),p]:=GetAliicmsST;
      // 21.06.2021   - funco de combate a pobreza
      Grid.cells[Grid.getcolumn('vfcpst'),p]:=GetvfcpST;

    end;
// 06.04.20 - Seip
    codsittrib:=FEstoque.GetCodigosituacaotributaria(Q.fieldbyname('move_esto_codigo').Asstring,
                                                     Q.fieldbyname('move_unid_codigo').Asstring,
                                                     Q.fieldbyname('moes_estado').Asstring);
    Grid.Cells[Grid.GetColumn('codsitrib'),Abs(p)]:=inttostr(codsittrib);
/////////////////
    inc(p);
    Grid.AppendRow;

    Q.Next;

  end;
// 26.02.12
  if ( pos( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodConhecimentoSaida ) > 0 )
     and
     ( xtransacao<>'' ) then begin
    Q71:=sqltoquery('select * from movesto where moes_transacao='+Stringtosql(xtransacao)+
                    ' and moes_status='+stringtosql('M') );
    Grid71.clear;l:=1;
    while not Q71.Eof do begin

      Grid71.Cells[Grid71.GetColumn('mfis_codentidade'),l]:=Q71.fieldbyname('moes_tipo_codigo').AsString;
      if Q71.fieldbyname('moes_dataemissao').asdatetime>0 then
        Grid71.cells[Grid71.getcolumn('mfis_dtemissao'),l]:=formatdatetime('dd/mm/yy',Q71.fieldbyname('moes_dataemissao').asdatetime)
      else
        Grid71.cells[Grid71.getcolumn('mfis_dtemissao'),l]:='';
      if Q71.FieldByName('moes_especie').AsString='NFE' then
        Grid71.Cells[Grid71.GetColumn('mfis_modelo'),l]:='55'
      else
        Grid71.Cells[Grid71.GetColumn('mfis_modelo'),l]:='01';
      Grid71.Cells[Grid71.GetColumn('mfis_serie'),l]:=Q71.FieldByName('moes_serie').AsString;
      Grid71.Cells[Grid71.GetColumn('mfis_numerodcto'),l]:=Q71.FieldByName('moes_numerodoc').AsString;
      Grid71.Cells[Grid71.GetColumn('mfis_totaldcto'),l]:=valortosql(Q71.FieldByName('moes_vlrtotal').Ascurrency);
      Grid71.Cells[Grid71.GetColumn('mfis_ufentidade'),l]:=Q71.FieldByName('moes_estado').AsString;
      Grid71.Cells[Grid71.GetColumn('mfis_natf_codigo'),l]:=Q71.FieldByName('moes_natf_codigo').AsString;
      inc(l);
      Grid71.AppendRow;
      Q71.Next;
    end;
    FGeral.FechaQuery(Q71);
  end;
///////////
end;

procedure TFNotaSaida.CancelaTransacao(Transacao: string);
////////////////////////////////////////////////////////////////////////////
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

procedure TFNotaSaida.EdDtMovimentoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////
begin
//  if (EdDtmovimento.isempty) and (EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodVendaSerie4) then
//    EdDtmovimento.invalid('Campo obrigat�rio para nota fiscal tipo '+EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring)
// 18.01.12 - ecf pode passar
  if (not EdDtmovimento.isempty) and (EdCliente.asinteger<>FGeral.GetConfig1AsInteger('clieconsumidor') ) then begin
     if campoufentidade='forn_uf' then begin
       if ( not FGeral.CnpjcpfOK(EdCliente.resultfind.fieldbyname('forn_cnpjcpf').AsString) ) then  begin
         Avisoerro('Obrigat�rio fornecedor com CNPJ/CPF v�lido');
         exit;
       end else begin
         if not Global.Topicos[1312] then
           bIncluiritemClick(FNotaSaida);
       end;
     end else begin
       if ( not FGeral.CnpjcpfOK(EdCliente.resultfind.fieldbyname('clie_cnpjcpf').AsString) ) then  begin
         Avisoerro('Obrigat�rio cliente com CNPJ/CPF v�lido');
         exit;
       end else begin
// 08.12.16
          if pos( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodConhecimentoSaida ) > 0 then
            bregistro71Click(self)
          else if not Global.Topicos[1312] then
            bIncluiritemClick(FNotaSaida);
       end;
     end;
  end else begin
    if (not Global.Usuario.OutrosAcessos[0319]) and (EdDtmovimento.isempty) then
       EdDtmovimento.Invalid('Usu�rio sem permiss�o para este tipo de nota')
    else if not Global.Topicos[1312] then
      bIncluiritemClick(FNotaSaida);
  end;

end;

procedure TFNotaSaida.EdDtMovimentoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FGeral.PoeData(EdDtMovimento,key);

end;

procedure TFNotaSaida.EdProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#27 then
    bcancelaritemclick(FNotaSaida);
end;

procedure TFNotaSaida.EdPerdescontoValidate(Sender: TObject);
begin
  if EdPerdesconto.ascurrency>0 then
    EdUnitario.setvalue( EdUnitario.Ascurrency - FGeral.Arredonda(EdUnitario.Ascurrency*(EdPerdesconto.ascurrency/100),2) );
end;

procedure TFNotaSaida.GridParcelasDblClick(Sender: TObject);
////////////////////////////////////////////////////////////
begin
  AtivaEditsParcelas;
end;

procedure TFNotaSaida.AtivaEditsParcelas(n:integer=0);
//////////////////////////////////////////
begin
  if GridParcelas.Col=0 then begin
     EdVencimento.Top:=GridParcelas.TopEdit+n;
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

procedure TFNotaSaida.EdVencimentoValidate(Sender: TObject);
begin
   if FCondpagto.GetAvPz(EdFpgt_codigo.text)='V' then begin
     if EdVencimento.AsDate>0 then begin
       if Edvencimento.asdate<Sistema.hoje then
          EdVencimento.invalid('Nota a vista somente com data atual');
     end;
   end;
// 01.10.2010 - novi - vava
   if (EdVencimento.asdate<EdDtEmissao.AsDate) and (not EdVencimento.isempty) then
      EdVencimento.invalid('Vencimento anterior a data de emiss�o');
end;

procedure TFNotaSaida.EdParcelaValidate(Sender: TObject);
begin
//   Edparcela.enabled:=false;
//   bgravarclick(FNotaSaida);

end;

procedure TFNotaSaida.EdVencimentoExitEdit(Sender: TObject);
begin
// 11.02.20
  if Global.Topicos[1468] then

    GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=FormatDateTime('dd/mm/yyyy',EdVencimento.AsDate)

  else

    GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=DateToStr_(EdVencimento.AsDate);

  GridParcelas.SetFocus;
  EdVencimento.Visible:=False;

end;

procedure TFNotaSaida.EdParcelaExitEdit(Sender: TObject);
begin
  GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=Transform(EdParcela.AsFloat,f_cr);
  GridParcelas.SetFocus;
  EdParcela.Visible:=False;

end;

procedure TFNotaSaida.EdVencimentoExit(Sender: TObject);
begin
//  Edvencimento.enabled:=false;
end;

procedure TFNotaSaida.EdParcelaExit(Sender: TObject);
begin
//  EdParcela.enabled:=false;
end;

procedure TFNotaSaida.GridParcelasKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
    GridParcelasDblClick(FNotaSaida);
end;

procedure TFNotaSaida.EdTran_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.Limpaedit(Edtran_codigo,key);
end;

// 05.02.20
procedure TFNotaSaida.EdTran_codigoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////
begin

  if ( EdTran_codigo.ResultFind<>nil ) and ( OP <> 'G' ) then begin

     if trim(EdTran_codigo.ResultFind.FieldByName('tran_cnpjcpf').AsString) = '' then begin

        EdPesoliq.Enabled:=false;
        EdPesobru.Enabled:=false;
        EdEspecievolumes.Enabled:=false;
        EdQtdevolumes.Enabled   :=false;

     end else begin

        EdPesoliq.Enabled:=true;
        EdPesobru.Enabled:=true;
        EdEspecievolumes.Enabled:=true;
        EdQtdevolumes.Enabled   :=true;

     end;
// 09.10.20
     EdMoes_cola_codigo.text:=EdTran_codigo.resultfind.fieldbyname('tran_cola_codigo').Asstring;


  end;


end;

procedure TFNotaSaida.EdFpgt_codigoExitEdit(Sender: TObject);
begin
  if (not Global.Topicos[1355]) or ( (FCondPagto.GetAvPz(EdFpgt_codigo.text)='V') )  then
    bgravarclick(FNotasaida);
end;

function TFNotaSaida.Nfexporta(cfop: string): boolean;
begin
  if copy(cfop,1,1)=cfopexporta then
    result:=true
  else
    result:=false;
end;

procedure TFNotaSaida.Edmens_codigoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////////
var TMensagensNF:TSqlquery;
begin
// 10.12.14
  TMensagensNF:=sqltoquery('select mens_descricao from mensagensnf where mens_codigo='+EdMens_codigo.assql);
  if (Edmens_codigo.asinteger>0) and ( pos(OP,'I;G;H')>0 ) then begin
    if not TMensagensnf.eof then begin
       if (Edmensagem.isempty) or (Edmens_codigo.text<>EdMens_codigo.oldvalue) then
         EdMensagem.text:=Tmensagensnf.fieldbyname('mens_descricao').asstring;
    end;
  end;
  if (trim(ObsPedido)<>'') and (Global.Topicos[1329] ) then
    EdMensagem.text:=EdMensagem.text+' '+obspedido;
  FGeral.FechaQuery(TMensagensnf);
end;

function TFNotaSaida.DevolucaoCompra(tipomov: string): boolean;
begin
   if pos(tipomov,Global.coddevolucaocompra+';'+Global.coddevolucaocompraSemestoque+';'+Global.CodDevolucaoSimbolicaConsig)>0 then
     result:=true
   else
     result:=false;
end;

////////////////////////////////////////////////////////////////////////////
procedure TFNotaSaida.EdPedidoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////////////

var obra,sqlperiodo:string;
    POrcam,POrcamRes:^TOrcam;
    valorcontrato:currency;
    QEstoque,Q:TSqlquery;
    codcornovo,codcor:integer;
    DataPedido   : TDatetime;


    procedure DadostoGridExterno;
    //////////////////////////////////////////////////////////
    var i:integer;
        QEstoqueQtde,QEstoque:TSqlquery;
        produto,gravar:string;

       procedure ChecaCor;
       ///////////////////
       begin
         if not Arq.TCores.active then Arq.TCores.open;
//         if trim(Preq.corid)<>'' then begin
// 29.04.08
         if trim(POrcamres.corid)<>'' then begin
           POrcamres.corid:=TratamentotoCor(POrcamres.corid);
           Arq.TCores.First;
           if (not Arq.TCores.Locate('core_descricao',POrcamres.corid,[]) ) and (codcornovo>0) then begin
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
       ////////////////////////
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
       /////////////////////////
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
// 03.08.09 - Adriano - Padronizar nomes igual Pea
             Sistema.Edit('estoque');
             Sistema.SetField('esto_descricao',copy(SpecialCase(POrcamREs.descricao),1,50));
             Sistema.Post('esto_codigo='+stringtosql(QEstoque.fieldbyname('esto_codigo').asstring));
///////////////////////
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
// 26.01.12 - prever cst do simples
          if pos( FUnidades.GetSimples(Edunid_codigo.text),'S;2') > 0 then
            Grid.Cells[Grid.GetColumn('move_cst'),i+1]:=FSittributaria.GetCST(FUnidades.GetSittDentro(EdUnid_codigo.text),'S')
          else
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
//            POrcamRes.area:=(POrcam.l/1000)* (POrcam.h/1000);
// 25.03.10 - Abra - Fran
            POrcamRes.area:= POrcam.qtde * (POrcam.l/1000)* (POrcam.h/1000);
            POrcamRes.codigopea:=POrcam.codigopea;
            POrcamRes.corid:=POrcam.corid;
            pOrcamRes.localobra:=POrcam.localobra;   // 14.01.08
            ListaOrcamREs.add(POrcamREs);
        end else begin
            POrcamRes.qtde:=POrcamRes.qtde+POrcam.qtde;
//            POrcamRes.area:=POrcamRes.area+ ((POrcam.l/1000)* (POrcam.h/1000));
// 25.03.10 - Abra - Fran
            POrcamRes.area:= POrcamRes.area + ( POrcam.qtde * (POrcam.l/1000)* (POrcam.h/1000) );
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
    //////////////////////////////////////////
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
       if QRoma.eof then begin
           EdPedido.invalid('Saida (valores) n�o encontrada ou com nota de venda j� feita');
       end else begin
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
/////////////////////////////////////////////////////////////////////

      type TProdutos=record
        produto,oprastreamento:string;
        pesocarcaca,pesovivo:currency;
        vlrunitario,valortotal:extended;
//        pecas:integer;
// 10.03.10
        pecas:currency;
      end;

      var p,x:integer;
          Lista:Tlist;
          PProdutos:^Tprodutos;
          QRoma,QPedx:TSqlquery;
          ListaItensPedido:TStringList;

           procedure AtualizaLista;
           //////////////////////////
           var i      :integer;
               achou  :boolean;
               qcodigo:string;

           begin

             achou:=false;
             qcodigo:=QRoma.fieldbyname('movd_esto_codigoven').AsString;
             if trim(qcodigo)='' then
                qcodigo:=QRoma.fieldbyname('movd_esto_codigo').AsString;

             for i:=0 to Lista.count-1 do begin

               PProdutos:=Lista[i];
//               if PProdutos.produto=QRoma.fieldbyname('movd_esto_codigo').AsString then begin
// 08.01.19 - pelo q foi lido e nao pelo pedido de venda
//               if PProdutos.produto=QRoma.fieldbyname('movd_esto_codigoven').AsString then begin

// 05.07.19 - quando pelo q foi lido e nao pelo pedido de venda
//               qcodigo:=QRoma.fieldbyname('movd_esto_codigoven').AsString;
//               if QRoma.fieldbyname('movd_brinco').AsString='CASADO' then
//               if trim(qcodigo)='' then
//                  qcodigo:=QRoma.fieldbyname('movd_esto_codigo').AsString;
//               if ( trim(qcodigo)='' ) then begin
//                   if( AnsiPos( FEstoque.GetDescricao())>0 )  then
//               end;

               if PProdutos.produto=qcodigo then begin
                 achou:=true;
                 break;
               end;

             end;


                if (not achou)  then begin
// 08.07.19
///////                if trim(qcodigo)<>'' then begin

                    New(PProdutos);
    //                PProdutos.produto:=QRoma.fieldbyname('movd_esto_codigo').AsString;
    // 08.01.19 - pelo q foi lido e nao pelo pedido de venda
    //                PProdutos.produto:=QRoma.fieldbyname('movd_esto_codigoven').AsString;
    // 05.07.19 - questao 'dos casados'
                    PProdutos.produto:=qcodigo;
    // 24.10.16 - 26.07.17 - retirado por enquanto pra reavaliar
    //                if QRoma.fieldbyname('movd_esto_codigoven').AsString<>'' then
    //                  PProdutos.produto:=QRoma.fieldbyname('movd_esto_codigoven').AsString;

                    PProdutos.pesocarcaca:=QRoma.fieldbyname('movd_pesocarcaca').Ascurrency;
                    PProdutos.pesovivo:=QRoma.fieldbyname('movd_pesovivo').Ascurrency;
                    PProdutos.vlrunitario:=FGeral.Arredonda((QRoma.fieldbyname('movd_vlrarroba').Ascurrency),6);
                    PProdutos.valortotal:=QRoma.fieldbyname('movd_pesocarcaca').Ascurrency*PProdutos.vlrunitario;
    //                PProdutos.pecas:=1;
    // 16.10.08
                    PProdutos.pecas:=QRoma.fieldbyname('movd_pecas').AsCurrency;
    // 25.10.16
                    PProdutos.oprastreamento:=QRoma.fieldbyname('movd_operacao').AsString;
                    Lista.Add(PProdutos);

/////////////////                end;

                end else begin

                    PProdutos.pesovivo:=PProdutos.pesovivo+QRoma.fieldbyname('movd_pesovivo').Ascurrency;
                    PProdutos.pesocarcaca:=PProdutos.pesocarcaca+QRoma.fieldbyname('movd_pesocarcaca').Ascurrency;
                    PProdutos.valortotal:=PProdutos.valortotal+(QRoma.fieldbyname('movd_pesocarcaca').Ascurrency*(FGeral.Arredonda((QRoma.fieldbyname('movd_vlrarroba').Ascurrency),6)));
                    PProdutos.vlrunitario:=PProdutos.valortotal/PProdutos.pesocarcaca;
    //                PProdutos.pecas:=PProdutos.pecas+1;
                    PProdutos.pecas:=PProdutos.pecas+QRoma.fieldbyname('movd_pecas').AsCurrency;
                end;


           end;

           procedure IncluiGrid(x:integer);
           //////////////////////////////////
           var codigosit:integer;
               QEst:TSqlquery;
               reducaobase:extended;
           begin
              QEst:=sqltoquery('select esqt_vendamin,esqt_cfis_codigoest from estoqueqtde where esqt_unid_codigo='+EdUnid_codigo.Assql+
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
                            Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,EdCliente.asinteger,
                            revenda,EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring);
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
              Grid.Cells[Grid.Getcolumn('move_pecas'),x]:=Floattostr(PProdutos.pecas);
              Grid.Cells[Grid.Getcolumn('move_vendamin'),Abs(x)]:=TRansform(QEst.fieldbyname('esqt_vendamin').AsCurrency,f_cr);
// 25.10.16
              Grid.Cells[Grid.Getcolumn('move_oprastreamento'),Abs(x)]:=PProdutos.oprastreamento;
              FGeral.fechaquery(QEst);
              Grid.AppendRow;
           end;

// 22.08.12
           function EstadoNoPedido( produto:String ):boolean;
           //////////////////////////////////////////////////
           begin
              result:=(ListaItensPedido.Indexof(produto) > -1);
           end;

      begin
/////////////////////////////////////////
         if( not EdPedido.isempty ) and ( pos(OP,'I;G;H')>0 ) then begin
//            if not ChecaRomaneios then begin
//              EdRomaneio.Invalid('');
//              exit;
//            end;
// 22.08.12 - para checar se um 'viado' nao excluiu o item no pedido depois de pesado
            QPedx:=sqltoquery( FGeral.Buscapedvenda(EdPedido.asinteger,'','P') );
            ListaItensPedido:=TStringList.create;
            while not QPedx.Eof do begin
              ListaItensPedido.Add(QPedx.fieldbyname('mpdd_esto_codigo').asstring);
              QPedx.Next;
            end;
            QRoma:=sqltoquery('select * from movabatedet'+
                                ' inner join movabate on ( (mova_transacao=movd_transacao) and (mova_tipomov=movd_tipomov) ) '+
                                ' inner join clientes on ( clie_codigo=mova_tipo_codigo )'+
                                ' where '+FGeral.GetIN('mova_numerodoc',EdPedido.text,'N')+
                                ' and movd_status=''N'''+
                                ' and mova_status=''N'''+
//                                ' and mova_tipo_codigo='+inttostr(xcodigocliente)+
//                                ' and movD_tipo_codigo='+inttostr(xcodigocliente)+
// 03.12.12 - alguns pedidos de 2008 com mesmo numero q os atuais em 2012
//                                ' and extract( year from mova_dtabate ) = '+inttostr( Datetoano(Sistema.Hoje,true) )+
// 15.01.19 - Novicarnes - Pedido digitado num ano mas faturado no seguinte...Tipo 31.12.18 e venda 10.01.19
                                ' and mova_dtabate >= '+Datetosql(Sistema.Hoje-30)+
                                ' and movd_tipomov='+stringtosql(TipoSaidaAbate)+
// 28.09.12 - para ver se 'n�o confunde' com entradas de abate com mesmo numero
                                ' and mova_tipomov='+stringtosql(TipoSaidaAbate)+
//                                ' and mova_situacao=''N'''+
                                ' and mova_situacao=''P'''+
//                                ' and mova_tipo_codigo='+EdCliente.assql+
                                ' and ( mova_notagerada=0 or mova_notagerada is null )'+
// 01.02.13
                                ' and '+FGeral.GetIN('movd_numerodoc',EdPedido.text,'N')+
                                ' order by movd_esto_codigo');
            if QRoma.eof then
              EdPedido.invalid('Saida n�o encontrada OU com nota de venda j� feita OU mais de 30 dias')
            else begin
              Grid.clear;
              Lista:=TList.create;
// 20.09.11 - para nao afetar a geracao de nota a partir da pesagem do pedido
              EdDtMovimento.SetDate(QRoma.fieldbyname('mova_datacont').asdatetime);
              if op='I' then begin
                EdFpgt_codigo.text:=QRoma.fieldbyname('mova_fpgt_codigo').AsString;
                EdTran_codigo.text:=QRoma.fieldbyname('mova_tran_codigo').AsString;
                EdFpgt_codigo.validfind;
                EdTran_codigo.validfind;
              end;
              while not QRoma.eof do begin
                if EstadoNoPedido( QRoma.fieldbyname('movd_esto_codigo').AsString ) then
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
            FGeral.Fechaquery(QPedx);
            ListaItensPedido.Free;
         end;

    end;
////////////////////////////////


begin
/////////////////////////////////////////

  ListaReq:=TList.create;
  EdPedidos.enabled:=false;
  EdPedidos.visible:=false;
  EdPedidos.Items.Clear;
  ListaServicos.Clear;
// 21.03.14
  EdMoes_tabp_codigo.Enabled:=Global.Topicos[1357];
  if Edpedido.isempty then exit;
// 29.11.13 - Vivan
   EdMoes_tabp_codigo.Enabled:=false;

// 17.06.08 - aqui ver para buscar e somar os itens das saidas de abate - talvez usar as mesmas condicoes que
//            faz o F12 mostrar as saidas de abate...
  if ( pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodContrato+';'+Global.CodContratoNota+';'+Global.CodContratoDoacao)=0 )
    or
     ( Global.Topicos[1379]  )
    then begin
    if ( FGeral.GetConfig1AsInteger('ConfMovAbate')=Edcomv_codigo.ResultFind.FieldByName('comv_codigo').asinteger )
// 22.11.17
       or
    ( FGeral.GetConfig1AsInteger('ConfMovBonif')=Edcomv_codigo.ResultFind.FieldByName('comv_codigo').asinteger ) then begin
      if not BuscaSaidaAbateMestre then exit;
      BuscaSaidaAbate;
      if (TotalPedido<>EdTotalprodutos.AsCurrency) and (TotalPedido>0) then begin
         Avisoerro('CHECAR : Valor Total Pedido Pesado : '+FGeral.Formatavalor(totalpedido,f_cr)+
                   'Valor Total dos Produtos : '+FGeral.Formatavalor(EdTotalprodutos.AsCurrency,f_cr) );
      end;

    end else begin

      if Global.Usuario.OutrosAcessos[0335] then
        Qped:=sqltoquery( FGeral.Buscapedvenda(EdPedido.asinteger,'','P;E;F') )
      else if Global.Topicos[1409] then
        Qped:=sqltoquery( FGeral.Buscapedvenda(EdPedido.asinteger,'','P;E;F') )
// 23.04.2021
      else if Global.Topicos[1429] then
        Qped:=sqltoquery( FGeral.Buscapedvenda(EdPedido.asinteger,'','P;E;F') )
      else
        Qped:=sqltoquery( FGeral.Buscapedvenda(EdPedido.asinteger,'','P;F') );
/////////////////
      if (QPed.eof) and ( not Global.Topicos[1429] )  then

        EdPedido.invalid('Pedido n�o encontrado OU j� baixado OU n�o autorizado produzir/faturar')

      else begin
// 24.11.14
        if not Global.Usuario.OutrosAcessos[0335] then begin

           if QPed.fieldbyname('mped_nfvenda').AsInteger>0 then begin
             EdPedido.Invalid('Pedido j� faturado na nf '+inttostr(QPed.fieldbyname('mped_nfvenda').AsInteger));
             exit;
           end;

        end;

        Edcliente.setvalue(QPed.fieldbyname('mped_tipo_codigo').asinteger);
// 24.11.14
        VendaMovel:='N';
        if copy(QPed.fieldbyname('mped_obspedido').asstring,1,12)='Vendas Movel' then VendaMovel:='S';

        if Global.Topicos[1322] then begin

           EdPedidos.enabled:=true;
           EdPedidos.visible:=true;
// 12.11.2021 - Mirvane
         if FGeral.Getconfig1asinteger('DIASPEDIDO')>0 then
           DataPedido:=Sistema.hoje-FGeral.Getconfig1asinteger('DIASPEDIDO')
         else
           DataPedido:=Sistema.Hoje-60;
         sqldata := ' and mped_dataemissao >= '+Datetosql(DAtaPedido);
// 08.01.15
           SetEdCLIE_NOME.Visible:=false;
           sqlperiodo:='';
           if Global.topicos[1386] then sqlperiodo:=' and mped_dataemissao < '+Datetosql(DateToPrimeiroDiaMes(Sistema.Hoje));
           QPed.close;
//           QPed:=sqltoquery( 'select * from movpeddet inner join movped on (mped_transacao=mpdd_transacao)'+
           QPed:=sqltoquery( 'select * from movped '+
//            ' inner join estoque on (esto_codigo=mpdd_esto_codigo)'+
            ' where '+FGeral.Getin('mped_unid_codigo',Global.Usuario.UnidadesMvto,'C')+
            ' and '+FGeral.Getin('mped_status','N','C')+
            sqlperiodo+sqldata+
//            ' and '+FGeral.Getin('mpdd_tipomov',tipomov,'C')+
//              ' and mped_situacao=''P'' and mped_tipo_codigo='+EdCliente.assql+
// 28.01.19 - Seip
//              ' and mped_situacao=''F'' and mped_tipo_codigo='+EdCliente.assql+
// 04.06.19 - Seip
            ' and '+FGeral.getin('mped_situacao','F;P','C')+
            ' and mped_tipo_codigo='+EdCliente.assql+
            ' order by mped_datamvto');
           EdPedidos.text:='';
// 27.10.15 - Patopapel
//           EdPedidos.text:=strzero(EdPedido.asinteger,7);

           while not QPed.Eof do begin

//             EdPedidos.Items.Add(strzero(QPed.fieldbyname('mped_numerodoc').asinteger,7)+' - '+QPed.fieldbyname('esto_descricao').asstring);
             EdPedidos.Items.Add(strzero(QPed.fieldbyname('mped_numerodoc').asinteger,7)+' - '+
                    FGeral.FormataData(QPed.fieldbyname('mped_datamvto').asdatetime)+' - '+
                    FGeral.FormataValor(QPed.fieldbyname('mped_vlrtotal').ascurrency,f_cr) );
             EdPedidos.text := EdPedidos.Text+strzero(QPed.fieldbyname('mped_numerodoc').asinteger,7)+';';
             QPed.Next;

           end;

           EdPedidos.setfocus;

        end;
// 24.11.14
        if (VendaMovel='S') or (NFCe='S') then begin
//    19.02.18
          if ( ( QPed.FieldByName('mped_formaped').asstring='C' ) or
             ( QPed.FieldByName('mped_formaped').asstring='B' ) )
             and
             (  AnsiPos(EdNatf_codigo.Text,'5102/6102')>0 ) then begin
              if QPed.FieldByName('mped_formaped').asstring='C' then
                EdPedido.invalid('Pedido referente COMODATO')
              else
                EdPedido.invalid('Pedido referente BONIFICA��O');
            exit;
          end;
          EdCliente.Enabled:=false;
          EdCliente.Valid;
          EdUnid_codigo.enabled:=false;
          EdUnid_codigo.Valid;
          EdDtemissao.Enabled:=false;
          EdDtemissao.valid;
          EdNatf_codigo.Enabled:=false;
          EdNatf_codigo.valid;
          EdMens_codigo.Enabled:=false;
          EdMens_codigo.valid;
          EdMensagem.Enabled:=false;
          Edemides.Enabled:=false;
          EdEmides.Text:='2';
          EdEmides.Valid;
          EdTran_codigo.text:='001';
          EdTran_codigo.valid;
          EdPort_codigo.text:=QPed.fieldbyname('mped_port_codigo').asstring;
//          EdPort_codigo.valid; / retirados em 04.11.15
// 18.02.17
          EdPort_codigo.validfind;
          EdFpgt_codigo.text:=QPed.fieldbyname('mped_fpgt_codigo').asstring;
//          EdFpgt_codigo.valid;
          EdFpgt_codigo.validfind;
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
//    if confirma('Usar o VIMS ?') then
//      nrobra:='VIMS-'
//    else
// 02.01.12 - via email adriano solicitou retirada
      nrobra:='';

    Q:=sqltoquery('select moes_numerodoc,moes_transacao from movesto where moes_numerodoc='+inttostr(strtoint(FGeral.TiraBarra(trim(EdPedido.Text),'-'))) +
//                  ' and moes_status=''N'' and moes_tipomov='+stringtosql(Global.CodContrato) );
                  ' and moes_status=''N'' and moes_tipomov='+stringtosql(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring) );
    if not q.Eof then begin
      EdPedido.invalid('Obra j� encontrada na transa��o '+Q.fieldbyname('moes_transacao').asstring+'.  Cancelar primeiro');
      exit;
    end;
//    localexterno:=FGeral.Getconfig1asstring('localpea');
// 17.07.09
    localexterno:=FGeral.GetLocalExternoPea;
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
//      obra:='VIMS-'+EdPedido.text;
//      obra:=nrobra+EdPedido.text;
// 27.05.09
      obra:=nrobra+Trans(EdPedido.text,'##-####-##');
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
//      obra:='VIMS-'+EdPedido.text;
      obra:=nrobra+EdPedido.text;
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
      obra:=nrobra+EdPedido.text;
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
// 27.04.16
  if ( Global.Usuario.OutrosAcessos[0343] ) and ( OP='I' ) then begin

    EdCliente.Valid;
    EdCliente.enabled:=false;
    EdUnid_codigo.ValidFind;
    EdUnid_codigo.Valid;
    EdUnid_codigo.enabled:=false;
    EdDtEmissao.enabled:=false;
    EdDtEmissao.Next;
    EdFrete.enabled:=false;
    EdSeguro.enabled:=false;
    EdNatf_codigo.ValidFind;
    EdNatf_codigo.Valid;
    EdNatf_codigo.enabled:=false;
    EdPort_codigo.valid;
    EdDtMovimento.setfocus;

  end;

  ///////////////
end;

procedure TFNotaSaida.EdUnitarioValidate(Sender: TObject);
//////////////////////////////////////////////////////////
var valort:currency;

begin

   if EdUNitario.isempty then

     EdUnitario.invalid('Pre�o de venda n�o pode ser zerado')
// 22.02.2011 - Abra
   else if ( pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.CodContrato+';'+Global.CodContratoNota ) > 0 )
     and (EdQtde.AsCurrency>0) then
//     and ( not EdPedido.isempty) and (EdQtde.AsCurrency>0) then

     EdUNitario.setvalue( EdUnitario.asfloat/(EdQtde.AsCurrency) )

// 26.08.19
   else if Global.Topicos[1463] then begin

     Valort:=EdUnitario.AsCurrency*EdQtde.AsFloat;
     FGeral.Getvalor(valort,'Valor Total');
     if (valort>0) and ( EdUnitario.AsCurrency>0) then
        EdQtde.SetValue(valort/EdUnitario.AsCurrency);


   end else if not FEstoque.ValidaPrecoVenda( EdProduto.Text,EdUnid_codigo.text,EdUnitario.ascurrency,global.Usuario.codigo) then

     EdUnitario.Invalid('');

end;

procedure TFNotaSaida.Editsconsig(ativa: string);
begin
   if ativa='A' then begin
     EdVendasmc.enabled:=true;
     EdDevolucoesdm.enabled:=true;
   end else begin
     EdVendasmc.enabled:=false;
     EdDevolucoesdm.enabled:=false;
   end;
end;

procedure TFNotaSaida.SetaItemsConsig(tipomov: string;  Edit: TSqled ; xData:TDatetime=0);
/////////////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    data:TDatetime;
    docs,sqlnumerodoc,vendasmc,sqldata,sqlclifor:string;
    p:integer;
begin

   Sistema.beginprocess('Pesquisando notas tipo '+tipomov);
//   data:=sistema.hoje-360;
// 17.09.09 - Abra - Larissa
   data:=sistema.hoje-(360*2);

   sqlnumerodoc:='';
   sqldata:=' and moes_datamvto>='+Datetosql(data);
   sqlclifor:=' and moes_tipo_codigo='+EdCliente.Assql;
   if pos(tipomov,Global.CodRemessaIndPropria+';'+Global.CodEntradaInd)>0 then
     sqlclifor:='';
   if xdata>0 then
     sqldata:=' and moes_datamvto>='+Datetosql(xdata);
//   if (tipomov=Global.CodContratoEntrega) then begin
//   if pos(tipomov,Global.CodContratoEntrega+';'+Global.CodContrato+';'+Global.CodCompra+';'+Global.CodEntradaInd+';'+Global.CodRemessaIndPropria)=0 then begin
// 25.03.10
   if AnSipos( tipomov,Global.CodContratoEntrega+';'+Global.CodContrato+';'+Global.CodCompra+';'+Global.CodEntradaInd+';'+Global.CodRemessaIndPropria+';'+Global.CodContratoNota+';'+ Global.CodDevolucaoConsigMerc)=0 then begin
     vendasmc:='';
     for p:=0 to EdVendasmc.Items.Count-1 do begin
       if trim(EdVendasmc.Items.Strings[p])<>'' then
         vendasmc:=vendasmc+copy(EdVendasmc.Items.Strings[p],1,8)+';';
     end;
     if (trim(vendasmc)<>'')  then  // 14.03.12
//       sqlnumerodoc:=' and '+FGeral.SimilarTo('moes_remessas',Vendasmc);
       sqlnumerodoc:=' and '+FGeral.GetIn('moes_numerodoc',Vendasmc,'N');
   end;
// 08.06.09
   if tipomov=Global.CodCompra then                    // 20.06.14
     tipomov:=Global.CodCompra+';'+Global.CodCompra100+';'+Global.CodCompraMatConsumo;
// 28.10.2021 - Novicarnes - venda e entrega futura
   if tipomov = Global.CodDevolucaoConsigMerc then                    // 20.06.14

      tipomov := tipomov + ';'+ Global.CodContratoEntrega ;

   Q:=sqltoquery('select moes_numerodoc,moes_dataemissao from movesto'+
                 ' where '+FGeral.GetIN('moes_tipomov',tipomov,'C')+
                 sqlclifor+
//                 ' and moes_status=''N'''+
// 28.10.2021 - para pode calcular o saldo do produto passando mais de uma vez pela mesma nota 'geral'
                 ' and '+FGeral.GetIn('moes_status','N;E','C')+
//                 ' and moes_datacont > 1'+
//                 ' and moes_datacont > '+DatetoSql(Global.DataMenorBanco)+
// Abra - Juliana - baixa e depois faz nf de servicos serie F  pss
// 17.11.14 - retirado metallum
                 sqlnumerodoc+sqldata+
                 ' and moes_unid_codigo='+EdUnid_codigo.assql+
                 ' order by moes_numerodoc' );
   docs:='';
   Edit.Items.clear;
   Edit.Text:='';
   while not Q.eof do begin

     docs:=docs+strzero(Q.fieldbyname('moes_numerodoc').asinteger,8)+';';
     Edit.Items.Add(strzero(Q.fieldbyname('moes_numerodoc').asinteger,8)+' - '+FGeral.formatadata(Q.fieldbyname('moes_dataemissao').asdatetime) );
     Q.Next;

   end;

   if tipomov=Global.CodContratoEntrega then
     Edit.text:=docs  // para nao precisar escolher com o f12
   else if Edit.Items.Count=1 then
     Edit.text:=docs;  // 14.03.12
   FGeral.Fechaquery(Q);
   Sistema.endprocess('');


end;

procedure TFNotaSaida.EdDevolucoesdmValidate(Sender: TObject);
/////////////////////////////////////////////////////////
type TLista=record
     produto,cst:string;
     qtde,aliicms,venda,perdesco,vendabru:currency;
end;

var QMovimento:TSqlquery;
    Lista:TList;
    x,
    y,
    codsittrib   :integer;
    PLista       :^TLista;
    data         :TDatetime;
    tipomov,tipomovd,sqlclifor:string;


    procedure Atualiza(xtipo:string);
    ///////////////////////////////////
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
         if ( pos(xtipo,Global.CodContrato+';'+Global.CodConsigMercantil+';'+Global.CodCompra+';'+Global.CodCompra100+
                ';'+Global.CodEntradaInd+';'+Global.CodContratoNota)>0 ) or
            ( pos(Global.CodContratoNota,xtipo)>0 ) or
            ( pos(Global.CodCompra,xtipo)>0 )
         then
           PLista.qtde:=QMovimento.fieldbyname('move_qtde').asfloat
         else
           PLista.qtde:=(-1)*QMovimento.fieldbyname('move_qtde').asfloat;
         Lista.Add(PLista);
       end else begin
//         if QMovimento.fieldbyname('move_tipomov').asstring=xtipo then
//         if pos(xtipo,Global.CodContrato+';'+Global.CodConsigMercantil)>0 then
// 08.06.09
//         if pos(xtipo,Global.CodContrato+';'+Global.CodConsigMercantil+';'+Global.CodCompra+';'+Global.CodCompra100+';'+Global.CodEntradaInd)>0 then
// 25.03.10
         if ( pos(xtipo,Global.CodContrato+';'+Global.CodConsigMercantil+';'+Global.CodCompra+';'+Global.CodCompra100+
                ';'+Global.CodEntradaInd+';'+Global.CodContratoNota)>0 ) or
            ( pos(Global.CodContratoNota,xtipo)>0 ) or
            ( pos(Global.CodCompra,xtipo)>0 )
         then
           PLista.qtde:=PLista.qtde+QMovimento.fieldbyname('move_qtde').asfloat
         else
           PLista.qtde:=PLista.qtde-QMovimento.fieldbyname('move_qtde').asfloat;
       end;
    end;

    function FoiProduzido(codigo:string):boolean;
    //////////////////////////////////////////////
    begin
      result:=true;
      if not ConstaListaProdutosAcabados(SetEdESTO_DESCRICAO.Items,codigo) then begin
        Avisoerro('Produto '+codigo+' '+FEstoque.GetDescricao(codigo)+' n�o produzido');
        result:=false;
      end;
    end;

begin
///////////////////////////////////
//   if (not EdVendasmc.isempty) and ( not EdDevolucoesdm.isempty) and (OP='I') and
   if (not EdVendasmc.isempty)  and (OP='I') and
      ( Ansipos(Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodVendaConsigMercantil+';'
                +Global.CodContratoEntrega+';'+Global.CodDevolucaoCompra+';'
                +Global.CodRemessaIndPropria )>0) then begin

     Sistema.beginprocess('Calculando saldo por produto');
     data:=sistema.hoje-(360);
     if Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodContratoEntrega then

       data:=sistema.hoje-(360*2);  // 17.09.09 - Abra

     tipomov:=Global.CodConsigMercantil;
     tipomovd:=Global.CodDevolucaoConsigMerc;
     sqlclifor:=' and move_tipo_codigo='+EdCliente.Assql;
     if Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodContratoEntrega then begin
//       tipomov:=Global.CodContrato;
// 25.03.10
//       tipomov:=Global.CodContrato+';'+Global.CodContratoNota;
// 28.10.2021
       tipomov := Global.CodContrato+';'+Global.CodContratoNota+';'+Global.CodConsigMercantil;
       tipomovd:=Global.CodContratoEntrega;

     end else if Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodDevolucaoCompra then begin

       tipomov:=Global.CodCompra+';'+Global.CodCompra100+';'+Global.CodCompraMatConsumo;
       tipomovd:=Global.CodDevolucaoCompra;

     end else if Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodRemessaIndPropria then begin

       tipomov:=Global.CodEntradaInd;
       tipomovd:=Global.CodRemessaIndPropria;
       sqlclifor:='';

     end;
     if EdDevolucoesdm.isempty then
       EdDevolucoesdm.text:='999999';  // s� pra dar eof nas devolucoes


     QMovimento:=sqltoquery('select * from movestoque inner join movesto'+
                 '  on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov )'+
                 ' where '+FGeral.GetIN('move_tipomov',tipomov,'C')+
                 sqlclifor+
                 ' and move_status=''N'''+
//                 ' and move_datacont>1'+
// 25.03.10
//                 ' and move_datacont>1'+
//                 ' and move_datacont > '+DatetoSql(Global.DataMenorBanco)+
// Abra - Juliana - baixa e depois faz nf de servicos serie F  pss
                 ' and '+FGeral.Getin('move_numerodoc',EdVendasmc.text,'N')+
                 ' and move_datamvto>='+Datetosql(data)+' and move_unid_codigo='+EdUnid_codigo.assql+
                 ' order by move_esto_codigo' );
// 14.10.09 - configura f12 dos produtos
//     if ( Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodContratoEntrega )
//        and ( not QMovimento.eof )  then
//       SetaitensProdutosAcabados(EdProduto,QMovimento.fieldbyname('move_nroobra').AsString);
//       SetaitensProdutosAcabados(SetEdESTO_DESCRICAO,EdVendasmc.Text);
//     14.03.12 retirado devido a 'conflito' com venda entrega X venda contrato
//     27.03.12 retornado devido a config. 106 unidade 003 'da amanda'
//     nao deu tbem... psss
////////////////////
     Lista:=TList.create;
     while not QMovimento.eof do begin
        Atualiza(tipomov);
        QMovimento.Next;
     end;
     FGEral.Fechaquery(QMovimento);
     QMovimento:=sqltoquery('select * from movestoque inner join movesto on ( moes_transacao=move_transacao  and moes_tipomov=move_tipomov)'+
                 ' where move_tipomov='+stringtosql(tipomovd)+
                 sqlclifor+
                 ' and move_status=''N'''+
//                 ' and move_datacont>1'+
// 20.07.10
//                 ' and move_datacont > '+DatetoSql(Global.DataMenorBanco)+
// Abra - Juliana - baixa e depois faz nf de servicos serie F  pss
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
        if ( Plista.qtde<>0 ) and ( FoiProduzido(PLista.produto) ) then begin

          if (Grid.RowCount=2) and (Trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),1])='') then begin
             x:=1;
          end else begin
             Grid.RowCount:=Grid.RowCount+1;
             x:=Grid.RowCount-1;
          end;
// 30.09.2021
          codsittrib := FEstoque.GetCodigosituacaotributaria(Plista.produto,EdUnid_codigo.text,
                        EdCliente.resultfind.fieldbyname(campoufentidade).asstring,
                        'N',0,Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring);

          Grid.Cells[Grid.getcolumn('move_esto_codigo'),Abs(x)]:=Plista.produto;
          Grid.Cells[Grid.getcolumn('esto_descricao'),Abs(x)]:=FEstoque.getdescricao(PLista.produto);
          if Nfexporta(EdNatf_codigo.text) then begin

            Grid.Cells[Grid.getcolumn('move_cst'),Abs(x)]:=cstexporta;
            Grid.Cells[Grid.getcolumn('move_aliicms'),Abs(x)]:=currtostr(icmsexporta);

          end else begin
// 20.06.14 - Metalforte
            if Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodDevolucaoCompra then begin
              Grid.Cells[Grid.getcolumn('move_cst'),Abs(x)]:=PLista.cst;
              Grid.Cells[Grid.getcolumn('move_aliicms'),Abs(x)]:=currtostr(PLista.aliicms);
            end else begin
              Grid.Cells[Grid.getcolumn('move_cst'),Abs(x)]:=FEstoque.Getsituacaotributaria(PLista.produto,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,
                                  Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,EdCliente.asinteger,
                                  revenda,EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring);
              Grid.Cells[Grid.getcolumn('move_aliicms'),Abs(x)]:=currtostr(FEstoque.Getaliquotaicms(PLista.produto,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,EdCliente.asinteger,
                                  Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,revenda) );
            end;

          end;
          Grid.Cells[Grid.getcolumn('esto_unidade'),Abs(x)]:=Festoque.getunidade(PLista.produto);
          Grid.Cells[Grid.getcolumn('move_qtde'),Abs(x)]:=floattostr(Plista.qtde);
          Grid.Cells[Grid.getcolumn('move_venda'),Abs(x)]:=floattostr(Plista.venda);
          Grid.Cells[Grid.getcolumn('total'),Abs(x)]:=TRansform(Plista.qtde*Plista.venda,f_cr);
    //      Grid.Cells[Grid.getcolumn('move_perdesco'),Abs(x)]:=0;
          Grid.Cells[Grid.getcolumn('move_vendabru'),Abs(x)]:=TRansform(Plista.vendabru,f_cr);
// 29.11.07
          Grid.Cells[Grid.getcolumn('esto_referencia'),Abs(x)]:=Arq.TEstoque.fieldbyname('esto_referencia').asstring;
//30.09.2021  - Alutech - Fran
          Grid.Cells[Grid.GetColumn('codsitrib'),Abs(x)] := inttostr(codsittrib);



       end; // else
//         Avisoerro('Produto '+PLista.produto+' '+FEstoque.getdescricao(PLista.produto)+' saldo negativo '+floattostr(PLista.qtde))
     end;
     SetaEditsValores;
     Sistema.endprocess('');

   end;
end;

procedure TFNotaSaida.EdCodtamanhoValidate(Sender: TObject);
begin
   if not FGeral.ValidaGrade(EdCodcor.asinteger,EdCodtamanho.asinteger,0,EdProduto.text,'cor;tamanho') then
     EdCodtamanho.invalid('')

end;

procedure TFNotaSaida.EdCodcopaValidate(Sender: TObject);
begin
   if not FGeral.ValidaGrade(EdCodcor.asinteger,EdCodtamanho.asinteger,EdCodcopa.asinteger,EdProduto.text,'cor;tamanho;copa') then
     EdCodcopa.invalid('');

end;

procedure TFNotaSaida.EdcodcorValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////
begin
  if not FGeral.ValidaGrade(EdCodcor.asinteger,0,0,EdProduto.text,'cor' ) then
     EdCodcor.invalid('')
  else if (not EdCodcor.IsEmpty) and (EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString=Global.CodRemessaInd) then begin  // 13.07.09
     EdCorIndust.Visible:=true;
     EdCorIndust.Enabled:=true;
     EdCorIndust.Top:=EdCodcor.Top;
     EdCorIndust.Left:=EdCodcor.Left;
     EdCorINdust.setfocus;
  end;

end;

procedure TFNotaSaida.EdValoripiExitEdit(Sender: TObject);
begin
   EdTotalNota.setvalue(EdTotalProdutos.ascurrency+EdValoripi.ascurrency);
end;

procedure TFNotaSaida.EdTotalprodutosValidate(Sender: TObject);
begin
// 23.01.07 - somente at� come�ar a fazer nota pelo sistema
  EdTotalNota.setvalue(EdTotalProdutos.ascurrency+EdValoripi.ascurrency);

end;

function TFNotaSaida.TiposFornecedor(tipomov: string): boolean;
begin
   if pos( tipomov,TiposFornec ) >0 then
     result:=true
   else
     result:=false;
end;

procedure TFNotaSaida.EdchavenfeacomExitEdit(Sender: TObject);
begin
   bIncluiritemClick(FNotaSaida);

end;

procedure TFNotaSaida.SetaPortosEmbarque(Ed: TSqlEd);
begin
  Ed.Items.Clear;
  Ed.Items.Add('Itaja�');
  Ed.Items.Add('S�o Francisco do Sul');
  Ed.Items.Add('Paranagu�');
end;

function TFNotaSaida.EstaCodigosNaoVenda(produto: string): boolean;
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

procedure TFNotaSaida.ImprimeContrato(xtransacao:string);
////////////////////////////////////////////////////////////////////////
var
    ArquivoSalvar:olevariant; //local e nome para salvar arquivo
//    s:olevariant; //facilitar trabalho
    s,msword:variant; //facilitar trabalho
//    back ,  msword : olevariant;
    back : olevariant;
    linhas,colunas,i,j,p:integer;
    QNota,QPendencias,QCaixa,QCliente,QOrca:TSqlquery;
    Produtos,Parcelas,Valores:TStrings;
    valoritem:currency;
    obra,formapag:string;
    NomeObra,ContatoObra,cobra:String;

begin
//////////////////
    QNota:=sqltoquery('select * from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov )'+
                  ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                  ' inner join unidades on ( unid_codigo=move_unid_codigo )'+
                  ' where move_transacao='+stringtosql(xtransacao)+' and move_status<>''C'''+
                  ' and move_tipomov='+stringtosql(Global.CodContrato));
    if QNota.eof then begin
      FGeral.FechaQuery(QNota);
      Avisoerro('Transa��o n�o encontrada');
      exit;
    end;
//    formapag:='Boleto banc�rio entregue na assinatura do contrato';
    if not Input('Forma de Pagamento','Forma',formapag,60,false) then exit;

//    Obra:=QNota.fieldbyname('moes_numerodoc').asinteger;
    Obra:=QNota.fieldbyname('moes_nroobra').asstring;
    QCliente:=sqltoquery('select * from clientes where clie_codigo='+QNota.fieldbyname('moes_tipo_codigo').asstring);
    if pos('@',QCliente.FieldByName('clie_email').AsString)=0 then begin
        Avisoerro('Cliente sem email preenchido corretamente');
        FGeral.FechaQuery(QNota);
        FGeral.FechaQuery(QCliente);
        exit;
    end;
    Produtos:=Tstringlist.Create;
    Valores:=Tstringlist.Create;
    Parcelas:=tStringlist.create;

    while not Qnota.eof do begin
      valoritem:=QNota.fieldbyname('move_venda').ascurrency*QNota.fieldbyname('move_qtde').ascurrency;
//      Produtos.Add(QNota.fieldbyname('move_esto_codigo').asstring+' '+strspace(FEstoque.GetDescricao(QNota.fieldbyname('move_esto_codigo').asstring),50)+#9+' '+
//                FGEral.Formatavalor(valoritem,f_cr) );
      Produtos.Add(strspace(FEstoque.GetDescricao(QNota.fieldbyname('move_esto_codigo').asstring),45)+
                   ' em �rea de '+FGEral.Formatavalor(QNota.fieldbyname('move_qtde').asfloat,'###,##0.00')+' m2;' );
      Valores.Add(FGEral.Formatavalor(valoritem,f_cr) );
      QNota.Next;
    end;
    QNota.First;
    QCaixa:=sqltoquery('select * from movfin where movf_transacao='+stringtosql(xtransacao));
    while not QCaixa.eof do begin
      Parcelas.add('Entrada :'+FGeral.formatavalor(QCaixa.fieldbyname('movf_valorger').ascurrency,f_cr));
      QCaixa.Next;
    end;
    QPendencias:=sqltoquery('select * from pendencias where pend_transacao='+stringtosql(xtransacao)+
                            ' and pend_rp=''R''' );  // 20.07.09 para nao pegar ref. comissao
    while not QPendencias.eof do begin
      Parcelas.add(FGeral.formatavalor(QPendencias.fieldbyname('pend_valor').ascurrency,f_cr)+'  -  '+
                   FGeral.formatadata(QPendencias.fieldbyname('pend_datavcto').asdatetime));
      QPendencias.Next;
    end;
    NomeObra:=obra;
    ContatoObra:='';
    QOrca:=Sqltoquery('Select * from orcamentos where orca_status=''N'''+
                  ' and Orca_nroobra='+Stringtosql(Obra)+
                  ' and orca_unid_codigo='+Stringtosql(QNota.fieldbyname('move_unid_codigo').asstring));
    if not QOrca.eof then begin
      NomeObra:=QOrca.fieldbyname('orca_obra').asstring;
      ContatoObra:=QOrca.fieldbyname('Orca_cliente2').asstring;
    end;

        linhas:=63 ; colunas:=63;

        msword := createoleobject('word.application'); //abre aplicativo
        msword.documents.add; //adiciona novo documento
{
                if MSWord.ActiveWindow.View.SplitSpecial <> 0 then
                   MSWord.ActiveWindow.Panes[2].Close;
                if (MSWord.ActiveWindow.ActivePane.View.type = 1) or
                   (MSWord.ActiveWindow.ActivePane.View.type = 2) or
                   (MSWord.ActiveWindow.ActivePane.View.type = 5) then
                   MSWord.ActiveWindow.ActivePane.View.type := 3;
}
        s := msword.selection; //variavel para facilitar trabalho
        msword.activewindow.activepane.view.seekview := 10; //habilita o rodap�

{
        MSWord.ActiveWindow.ActivePane.View.SeekView := 9; //habilita o cabe�alho
        s.typetext('Cabe�alho habilitado');
        msword.activewindow.activepane.view.seekview := 10; //habilita o rodap�
        s.typetext('rodap� habilitado');
 msword.activedocument.PageSetup.Orientation := wdOrientLandscape;  //p�gina em landscape
}
        msword.activewindow.activepane.view.seekview := 0; //habilita o texto

//        MSWord.fyPara;
//        MSWord.CenterPara;
//        s.paragraphFormat.alignment :=  s.wdAlignParagraphJustify; //alinha o texto
//        s.paragraphFormat.alignment := 3; //alinha o texto
       //esquerda=0, centro=1, direita=2, wdAlignParagraphJustify
//        s.typetext(#9); //tab

        s.Font.Size := 12;    //tamanho de letra
        s.Font.Name := 'Verdana'; //tipo de letra
        s.Font.Bold := True;    //negrito
//        s.PageSetup.rightMargin := 080; //margem direita  - 15,1
//        s.PageSetup.rightMargin := 090; //margem direita  - 15
//        s.PageSetup.rightMargin := 070; //margem direita  - 15,6
//        s.PageSetup.rightMargin := 060; //margem direita  -   16
//        s.PageSetup.rightMargin := 050; //margem direita  -   16,2
//        s.PageSetup.rightMargin := 045; //margem direita  -  16,25
        s.PageSetup.rightMargin := 040; //margem direita  -  16,30
//        s.PageSetup.TopMargin := 150;  //margem superior
        s.PageSetup.leftMargin := 080; //margem esquerda
        s.PageSetup.BottomMargin := 60; //margem abaixo

//////////////////
//        s.footnotes.add(msword.page,emptyparam,'Abra Alum�nios Ltda - CNPJ 7610083/0001-80');
//        s.footnotes.add(msword.page,emptyparam,'Rob. BR 158. km 340');

//  WordApp.ActiveDocument.Sections.Item(1).Footers.Item(wdHeaderFooterPrimary).Range.Text := 'Texto do rodap� 3';
//        msword.ActiveDocument.Sections.Item(1).Footers.Item(1).Range.Text := 'Abra Alum�nios Ltda - CNPJ 7610083/0001-80 - IE: 9035156787'+#13+
//           'Rob. BR 158. km 340 - 6595 Trevo da Guarani - Pato Branco - Pr - 85501-570 - Fone (46) 3224-2279 / 3224-5335'+#13+
//           'www.abraaluminios.com.br';
// rodape 'q funciona'

//        msword.ActiveDocument.Sections.Item(1).Footers.Item(2).Range.Text := 'Rob. BR 158. km 340';

//        s.footnotes.add(msword.selection.range,emptyparam,'Abra Alum�nios Ltda - CNPJ 7610083/0001-80');
//        s.footnotes.add(msword.selection.range,emptyparam,'Rob. BR 158. km 340');
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('A Empresa');
        s.typeparagraph;
        s.typeparagraph;
        s.Font.Bold := False;    //negrito
        s.typetext('Quando a responsabilidade social � a obriga��o que a empresa assume com a');
        s.typeparagraph;
//        s.typetext('"sociedade", fundamental  �  conhecer  a ABRA ALUM�NIOS -  empresa  com');
        s.typetext('"sociedade", fundamental  �  conhecer  a ');
        s.Font.Bold := True;    //negrito
        s.typetext('ABRA ALUM�NIOS');
        s.Font.Bold := False;    //negrito
        s.typetext(' - empresa com');
        s.typeparagraph;
        s.typetext('expressiva experi�ncia, voltada �s necessidades do cliente, com  profissionais');
        s.typeparagraph;
        s.typetext('especializados para assistir nas �reas de excel�ncia de assessoria: ');
        s.typeparagraph;
        s.Font.Bold := True;    //negrito
        s.typetext('arquitet�nica, t�cnica, comercial e  gerenciamento  de  obras.   Possui');
        s.typeparagraph;
        s.typetext('tamb�m  �rea  fabril  com  ferramentais e  maquin�rios  de  alto  n�vel');
        s.typeparagraph;
        s.typetext('tecnol�gico em sua maioria de proced�ncia  italiana, que  garantem  a');
        s.typeparagraph;
        s.typetext('linha de produ��o, otimiza��o e precis�o dos produtos. Equipe t�cnica');
        s.typeparagraph;
        s.typetext('de produ��o e instala��o capacitada de forma te�rica e pr�tica apta  a');
        s.typeparagraph;
        s.typetext('garantir excel�ncia ao processo.');
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.Font.Bold := True;    //negrito
        s.typetext('A ABRA ALUM�NIOS');
        s.Font.Bold := False;    //negrito
        s.typetext(' atua desde 1981,tendo na execu��o de seus servi�os a');
        s.typeparagraph;
        s.typetext('eq�idade e o compromisso de atendimento a satisfa��o dos clientes,mediante');
        s.typeparagraph;
        s.typetext('um trabalho coordenado de  respeito e  confian�a  entre  clientes,  dirigentes,');
        s.typeparagraph;
        s.typetext('funcion�rios, fornecedores e colaboradores.');
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.Font.Bold := True;    //negrito
        s.typetext('NOSSA MISS�O:');
        s.Font.Bold := False;    //negrito
        s.typetext('Desenvolver e produzir solu��es em alum�nio e vidro para o');
        s.typeparagraph;
        s.typetext('segmento  da  constru��o   civil,  com   inova��o  tecnol�gica  e  qualifica��o');
        s.typeparagraph;
        s.typetext('profissional, agregando valores �s edifica��es; visando a lucratividade atrav�s');
        s.typeparagraph;
        s.typetext('da satisfa��o dos clientes, colaboradores, fornecedores, s�cios e comunidade,');
        s.typeparagraph;
        s.typetext('fomentando a melhoria  da  qualidade de  vida  com  responsabilidade  s�cio-');
        s.typeparagraph;
        s.typetext('ambiental. ');
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
///////////////////
        s.typetext('� com esse comprometimento que a empresa ABRA ALUM�NIOS  apresenta  a');
        s.typeparagraph;
        s.typetext('proposta dos produtos e servi�os, que  assegurem   a  qualidade  do  produto');
        s.typeparagraph;
        s.typetext('final e atendam as necessidades, do Cliente.');
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;

//        s.footnotes.add(msword.selection.range,emptyparam,'Abra Alum�nios Ltda - CNPJ 7610083/0001-80');
//        s.footnotes.add(msword.selection.range,emptyparam,'Rob. BR 158. km 340');


        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;   // 4 linhas de 'margem superior'
        s.typeparagraph;

        s.Font.Size := 11;    //tamanho de letra

        s.Font.Bold := True;    //negrito
        if length(trim(Obra))=7 then begin
          s.typetext(space(30)+'Proposta:'+Trans(Obra,'0#-####-##') );
          cobra:=Trans(Obra,'0#-####-##');
        end else begin
          s.typetext(space(30)+'Proposta:'+Trans(Obra,'##-####-##') );
          cobra:=Trans(Obra,'##-####-##');
        end;
        s.Font.Bold := False;    //negrito

        s.typeparagraph;
        s.typeparagraph;
        s.typetext(FCidades.GetNome(QNota.fieldbyname('Unid_cida_codigo').asinteger)+','+FormatDateTime('dd'' de ''mmmm'' de ''yyyy',QNota.fieldbyname('moes_dataemissao').asdatetime)+'.' );
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('�');
        s.typeparagraph;
        s.typetext('Empresa :'+strspace(Qcliente.fieldbyname('clie_razaosocial').asstring,50) );
        s.typeparagraph;
        s.typetext('Obra:'+NomeObra);
        s.typeparagraph;
        s.typetext('At.:'+ContatoObra);
        s.typeparagraph;
        s.typetext('Vendedor:'+FRepresentantes.GetRazaosocial(QNota.fieldbyname('moes_repr_codigo').asinteger));
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('Prezados Senhores(as),');
        s.typeparagraph;
        s.typeparagraph;

        s.Font.Bold := True;    //negrito
        s.typetext('A ABRA');
        s.Font.Bold := False;    //negrito
        s.typetext(' - Departamento t�cnico/comercial agradece a oportunidade de oferecer');
        s.typeparagraph;
        s.typetext('seus produtos e servi�os e, ap�s an�lise t�cnica do que lhe foi solicitado, disp�e');
        s.typeparagraph;
        s.typetext('o seguinte:');
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.Font.Bold := True;    //negrito
        s.typetext('I - ESCOPO DOS INSUMOS:');
        s.Font.Bold := False;    //negrito
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('1) Perfis  extrudados  com  liga   6060-T5,  adequado   para   o   recebimento   de');
        s.typeparagraph;
        s.typetext('anodiza��o ou pintura eletrost�tica a p�;');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('2) Perfis extrudados com espessuras que garantam um  comportamento estrutural');
        s.typeparagraph;
        s.typetext('adequado e precis�o dimensional;');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('3) Perfis extrudados, originais ALCOA;');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('4) Tratamento de superf�cie do aluminio em conformidade com as normas vigentes');
        s.typeparagraph;
        s.typetext('da ABNT e ISO, garantindo vida �til prolongada, sem a perda de suas  caracter�sti-');
        s.typeparagraph;
        s.typetext('cas;');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('5) Componentes de fornecedores devidamente homologados �s linhas ALCOA;');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('6) Acess�rios de  fornecedores  homologados  �s  linhas  ALCOA,  com  resist�ncia,');
        s.typeparagraph;
        s.typetext('ergonomia e design;');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('7) Guarni��es e gaxetas em borracha de EPDM, produto em conformidade com  as');
        s.typeparagraph;
        s.typetext('normas vigentes da ABNT E ISO,  garantindo  veda��o  ao  ar  e  a  �gua, fixa��o,');
        s.typeparagraph;
        s.typetext('dilata��o, sustenta��o e absor��o as tens�es mec�nicas e  ru�dos  evitando  defor-');
        s.typeparagraph;
        s.typetext('ma��es, ressecamento e retra��o do produto aplicado;');
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;

        s.typetext('8) Vidros   nacionais  fabricados  pela  empresa   CEBRACE,  que  oferece  em  seus');
        s.typeparagraph;
        s.typetext('produtos alto desempenho tecnol�gico e garantia de perman�ncia  de seu  portf�lio,');
        s.typeparagraph;
        s.typetext('para eventuais reposi��es;');
        s.typeparagraph;
        s.typeparagraph;
        s.Font.Bold := True;    //negrito
        s.typetext('II - ESCOPO DOS PRODUTOS:');
        s.Font.Bold := False;    //negrito
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('1) Caixilhos, sistemas de fachada, gradis, port�es e grades, s�o  produtos  originais');
        s.typeparagraph;
        s.typetext('do portf�lio ALCOA, sendo estas linhas protegidas por patentes;');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('2) As linhas aplicadas com suas tipologias, dimens�es e composi��es de montagem,');
        s.typeparagraph;
        s.typetext('foram definidas atrav�s de softwares de planejamento e c�lculo estrutural de  caixi-');
        s.typeparagraph;
        s.typetext('lhos e gradis,sendo os c�lculos de conformidade com as NBR 10.821 e NBR 14.718;');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('3) Produtos em conformidade com a NBR 10.821, a qual regulamenta as  condi��es');
        s.typeparagraph;
        s.typetext('m�nimas exig�veis, de desempenho estrutural, estanqueidade a �gua e  veda��o  ao ar;');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('4) Caixilhos de contramarco fornecidos com perfis resistentes ao manuseio e chum-');
        s.typeparagraph;
        s.typetext('bamento, montagens � 45� fechados com conex�es de aluminio e grapas de fixa��o');
        s.typeparagraph;
        s.typetext('em a�o galvanizado; garantindo com isso a possibilidade de excel�ncia na aplica��o');
        s.typeparagraph;
        s.typetext('do produto, quanto ao n�vel, prumo, esquadrejamento e estanqueidade a �gua;');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('5) Produtos e solu��es em alum�nio e vidro, confeccionados atrav�s de maquin�rios');
        s.typeparagraph;
        s.typetext('espec�ficos a utiliza��o, com precis�o de corte,  usinagem  e  montagem,  a  fim  de');
        s.typeparagraph;
        s.typetext('garantir qualidade ao produto final;');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('6) Produtos de baixa manuten��o e elevada vida �til;');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('7) Alto n�vel  de  desempenho  energ�tico,  atenua��o  ac�stica  e  t�rmica,  em  se');
        s.typeparagraph;
        s.typetext('projetado e aplicado como solu��o de caixilho + vidro;');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('8) Os  produtos  especificados  det�m  inova��es  tecnol�gicas  e  design  inovador,');
        s.typeparagraph;
        s.typetext('proporcionando ergonomia, conforto, sofistica��o e modernidade;');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('9) Os  produtos   proporcionam   bem  estar  ao  ambiente,   agregando   valor   �s');
        s.typeparagraph;
        s.typetext('edifica��es;');
        s.typeparagraph;
        s.typeparagraph;
        s.Font.Bold := True;    //negrito
        s.typetext('III - ESCOPO DOS TRABALHOS:');
        s.Font.Bold := False;    //negrito
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('1) O departamento t�cnico fornecer�  relat�rio  detalhado de todos  os  produtos,  ao');
        s.typeparagraph;
        s.typetext('engenheiro executor, para projetos e obras especiais,tamb�m ser� fornecido  projeto');
        s.typeparagraph;
        s.typetext('executivo, dos produtos especiais;');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('2) O   departamento   de   Gerenciamento   de   Produ��o   e   Obras  (GPO)  far�  o');
        s.typeparagraph;
        s.typetext('acompanhamento   de   todas   as   fases  que   se  corelacionarem  �  aplica��o  dos');
        s.typeparagraph;
        s.typetext('produtos;');
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('3) Os caixilhos de contramarco ser�o fornecidos, em fase  de  chapisco,  embo�o  ou');
        s.typeparagraph;
        s.typetext('reboco. Sendo a instala��o dos mesmos  de  responsabilidade  do  contratante;  com');
        s.typeparagraph;
        s.typetext('pr�via explica��o verbal e escrita ao mestre de obra;');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('4) Os caixilhos das esquadrias ou outros produtos ser�o instalados, ap�s a aplica��o');
        s.typeparagraph;
        s.typetext('de: cal fino,  massa  corrida,  massa  acr�lica,  gesso,  selador  externo,  textura  ou');
        s.typeparagraph;
        s.typetext('grafiato;');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('4.1) Nesta etapa n�o  deve  existir  tr�nsito  de  materiais  pesados  na  obra,  como');
        s.typeparagraph;
        s.typetext('carriolas, caixas de argamassa, placas de granito ou pisos do tipo cer�mico, a fim de');
        s.typeparagraph;
        s.typetext('garantir as caracter�sticas do produto acabado.');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('5) Caso o contratante n�o acorde com o cronograma de instala��o, descrito no  item');
        s.typeparagraph;
        s.typetext('4, fica �  possibilidade  do  fornecimento  antecipado  dos  produtos,  com  o  devido');
        s.typeparagraph;
        s.typetext('reconhecimento do termo de responsabilidade dos produtos, onde se  caracterizando');
        s.typeparagraph;
        s.typetext('mau uso do  produto, atrav�s  de  sujeiras  provenientes  de  argamassa  ou  gesso,');
        s.typeparagraph;
        s.typetext('amassamento, riscos, componentes e acess�rios quebrados, o  contratante  perder�');
        s.typeparagraph;
        s.typetext('as garantias do produto e acarretar� com os custos de manuten��o;');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('6) Os produtos ser�o fabricados em nosso parque fabril, onde  ficar�o  devidamente');
        s.typeparagraph;
        s.typetext('estocados, aguardando cronograma de instala��o;');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('7) Ap�s  entrega  dos  caixilhos  de  contramarco,  com  a  devida  confer�ncia  pelo');
        s.typeparagraph;
        s.typetext('respons�vel da obra, consideraremos estas como  medidas  oficiais  para fabrica��o');
        s.typeparagraph;
        s.typetext('dos caixilhos das esquadrias; caso alguma altera��o venha  a  ser feita  posterior  a');
        s.typeparagraph;
        s.typetext('esta etapa, ficam estas altera��es sob  inteira  responsabilidade  do  contratante,  e');
        s.typeparagraph;
        s.typetext('suscet�veis de aditivos aos valores do contrato;');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('8)Ap�s as etapas de pintura interna e externa da obra, ser� efetuada a conclus�o de');
        s.typeparagraph;
        s.typetext('instala��o e entrega dos produtos, com aplica��o de remates (quando contratados),');
        s.typeparagraph;
        s.typetext('veda��es com selantes de silicone e  polioretano;  tamb�m  a  regulagem  final  das');
        s.typeparagraph;
        s.typetext('esquadrias, acess�rios e automa��es (quando contratados);');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('9) Todo processo de fabrica��o e instala��o ser�o efetuados por equipes pr�prias de');
        s.typeparagraph;
        s.typetext('trabalhos, com qualifica��o profissional e conhecimento tecnol�gico;');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('10) A vistoria e entrega definitiva dos  produtos  contratados  ser�o  efetuados  com');
        s.typeparagraph;
        s.typetext('acompanhamento do contratante ou respons�vel legal  pela  obra,  com  entrega  do');
        s.typeparagraph;
        s.typetext('certificado de garantia e manual de uso limpeza e conserva��o das esquadrias;');
        s.typeparagraph;
        s.typeparagraph;
        s.Font.Bold := True;    //negrito
        s.typetext('IV - APRESENTA��O DOS PRODUTOS:');
        s.Font.Bold := False;    //negrito
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('Consolida��o da proposta:'+strspace(cobra,12)+', com descri��es individuais em anexo:');

//        s.typetext('Contratado  : '+strspace('ABRA Alum�nios Ltda.',50) );
//        s.Font.Bold := False;    //negrito

//        msword.activedocument.PageSetup.Orientation := wdOrientLandscape;  //p�gina em landscape

//        s.Font.Name := 'Times New Roman'; //tipo de letra
//        s.Font.Size := 08;    //tamanho de letra
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
          s.typetext('Valor'+replicate('.',68)+#9+Valores[p]+' (reais)');
          s.typeparagraph;
        end;

        s.typeparagraph;
        s.typeparagraph;
        s.typetext('Valor Total'+replicate('.',63)+#9+FGEral.Formatavalor(QNota.fieldbyname('moes_vlrtotal').ascurrency,f_cr)+' (reais)');

        s.typeparagraph;
        s.typeparagraph;
        s.Font.Bold := True;    //negrito
        s.typetext('V - CONDI��ES GERAIS:');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('1)Condi��o e Forma de Pagamento:');
        s.Font.Bold := False;    //negrito
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('   '+formapag);
        s.typeparagraph;
        s.typetext('     Parcela        Vencimento');
        s.typeparagraph;
        for p:=0 to Parcelas.count-1 do begin
          s.typetext(Parcelas[p]);
          s.typeparagraph;
        end;
        s.typeparagraph;
        s.Font.Bold := True;    //negrito
        s.typetext('1.1)Tributa��o:');
        s.Font.Bold := False;    //negrito
        s.typeparagraph;
        s.typetext('A) Para  a  forma��o  do  pre�o   de   venda    desta    proposta,    considerou-se   a');
        s.typeparagraph;
        s.typetext('emiss�o direta das Notas Fiscais dos insumos, em nome do contratante,  cabendo  a');
        s.typeparagraph;
        s.typetext('empresa contratada somente os valores referentes a presta��o de servi�o.');
        s.typeparagraph;
        s.typetext('B) Para a forma��o do pre�o de venda desta proposta, considerou-se como natureza');
        s.typeparagraph;
        s.typetext('da opera��o "venda de mercadoria".');
        s.typeparagraph;
        s.Font.Bold := True;    //negrito
        s.typetext('2) Composi��o do valor do produto:');
        s.Font.Bold := False;    //negrito
        s.typeparagraph;
        s.typetext('Est� prevista no  c�lculo dos  caixilhos  a  fabrica��o  total  dos  produtos,  a  fim  de');
        s.typeparagraph;
        s.typetext('otimizar o quantitativo  dos  insumos  e  os  custos  operacionais.  Portanto  qualquer');
        s.typeparagraph;
        s.typetext('desmembramento ou  altera��o  nas  descri��es  individuais  desta   proposta   ficar�');
        s.typeparagraph;
        s.typetext('sujeita a aplica��o de aditivos aos valores do contrato.');
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.Font.Bold := True;    //negrito
        s.typetext('3) Prazo de entrega:');
        s.Font.Bold := False;    //negrito
        s.typeparagraph;
        s.typetext('Conforme cronograma da  obra,  considerando o  descrito  no  item  4  do  subt�tulo:');
        s.typeparagraph;
        s.typetext('Escopo dos trabalhos.');
        s.typeparagraph;
        s.Font.Bold := True;    //negrito
        s.typetext('4) Validade da proposta:');
        s.Font.Bold := False;    //negrito
        s.typeparagraph;
        s.typetext('Dez (10) dias, seguidos � data da proposta.');
        s.typeparagraph;
        s.Font.Bold := True;    //negrito
        s.typetext('5) Frete:');
        s.Font.Bold := False;    //negrito
        s.typeparagraph;
        s.typetext('A) CIF (por conta do contratante).');
        s.typeparagraph;
        s.typetext('B) FOB (por conta do contratado), frota pr�pria.');
        s.typeparagraph;
        s.Font.Bold := True;    //negrito
        s.typetext('6) Garantia:');
        s.Font.Bold := False;    //negrito
        s.typeparagraph;
        s.typetext('Contido em nosso Termo de garantia e Manual de uso, limpeza e conserva��o.');
        s.typeparagraph;
        s.Font.Bold := True;    //negrito
        s.typetext('7) N�o incluso a esta proposta:');
        s.Font.Bold := False;    //negrito
        s.typeparagraph;
        s.typetext('A) limpeza e corre��o de imperfei��es nos contramarcos;');
        s.typeparagraph;
        s.typetext('B) Instala��o e requadro da alvenaria nos contramarcos;');
        s.typeparagraph;
        s.typetext('C) Fornecimento de andaimes e balancins;');
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.Font.Bold := True;    //negrito
        s.typetext('VI - Formaliza��o da Proposta:');
        s.Font.Bold := False;    //negrito
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('Havendo a aceita��o dos produtos e servi�os descritos neste  documento  em  forma');
        s.typeparagraph;
        s.typetext('de Proposta, dever� ser assinado  no  campo  "De acordo"  e  rubricado  nas  demais');
        s.typeparagraph;
        s.typetext('p�ginas, pelos representantes legais da empresa ou, em se tratando de pessoa f�sica');
        s.typeparagraph;
        s.typetext('pelo pr�prio individuo a ser emitida a Nota Fiscal; e uma das  vias  retorna  a  Abra');
        s.typeparagraph;
        s.typetext('Alum�nios, a qual oficializar�  nossa  rela��o  de  trabalho  constituindo-se,  assim,');
        s.typeparagraph;
        s.typetext('documento formal para todos os efeitos legais.');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('Ficamos a disposi��o para eventuais esclarecimentos e negocia��es. Para  dar  inicio');
        s.typeparagraph;
        s.typetext('ao nosso trabalho, expresse o seu "de acordo".');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('Atenciosamente,');
        s.typeparagraph;
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('Adriano Paulek');
        s.typeparagraph;
        s.typetext('Diretor Comercial');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('De acordo, _______________________________________.');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext('De acordo, _______________________________________.');
        s.typeparagraph;
        s.typeparagraph;
        s.typetext(FCidades.GetNome(QNota.fieldbyname('Unid_cida_codigo').asinteger)+','+FormatDateTime('dd'' de ''mmmm'' de ''yyyy',QNota.fieldbyname('moes_dataemissao').asdatetime)+'.' );


//        s.footnotes.add(msword.selection.range,emptyparam,'Abra Alum�nios Ltda - CNPJ 7610083/0001-80');
//        s.footnotes.add(msword.selection.range,emptyparam,'Rob. BR 158. km 340');

//        s.endnotes.add(msword.selection.range,emptyparam,'TESTE DE ENDNOTES');

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
//        s.PageSetup.BottomMargin := 60; //magem abaixo
        msword.application.visible :=true; //mantem visivel o documento word
//        ArquivoSalvar := 'd:\teste.doc';
//        ArquivoSalvar := 'teste.doc';
        ArquivoSalvar := 'CONT'+trim(Obra)+'.DOC';
//        MSWORD.ActiveDocument.SaveAs(arquivosalvar); //salva sem perguntar

//      msword.documents.save; //abre janela para salvar
//      msword.ActiveDocument.PrintOut(false); //imprime direto, sem perguntar
//      msword.ActiveDocument.PrintPreview; //vizualizar impress�o
//        msword.Quit  // finaliza aplica��oend;
    FGeral.FechaQuery(QNota);
    FGeral.FechaQuery(QPendencias);
    FGeral.FechaQuery(QCaixa);
    FGeral.FechaQuery(QCliente);
    FGeral.FechaQuery(QOrca);

end;


procedure TFNotaSaida.bcontratoClick(Sender: TObject);
begin
//    ImprimeContrato('001724');
//    ImprimeContrato(EdTransacao.text);
//    ImprimeContrato(Global.UltimaTransacao);
   Edtransacao.visible:=true;
   EdTransacao.text:=Global.UltimaTransacao;
   EdTransacao.setfocus;
end;

procedure TFNotaSaida.blebalanca1Click(Sender: TObject);
begin
    abrirporta;

end;

function TFNotaSaida.AbrirPorta: boolean;
Var TimeOut : Integer ;
begin
  if Global.Usuario.OutrosAcessos[0331] then begin
     if not AcbrBal1.Ativo then ACbrBal1.Ativar;
//     try - ver se cria config. para timeou
//        TimeOut := StrToInt( edtTimeOut.Text ) ;
//     except
        TimeOut := 2000 ;
//     end ;

     ACBrBAL1.LePeso( TimeOut );

  end else begin
    try
     result:=true;
    except
      Avisoerro('Problemas para abrir a porta '+AcbrBal1.Porta);
      result:=false;
    end;
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

procedure TFNotaSaida.SerialRxChar(Sender: TObject; Count: Integer);
var Buffer:array[1..1024] of char; s:String; i,q:Integer;
begin
{
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
}
end;

procedure TFNotaSaida.blebalanca2Click(Sender: TObject);
begin
    abrirporta2;

end;

function TFNotaSaida.AbrirPorta2: boolean;
begin
{
  try
   Serial2.Open;
   result:=true;
  except
    Avisoerro('Problemas para abrir a porta '+Serial2.DeviceName);
    result:=false;
  end;
}
end;

procedure TFNotaSaida.Serial2RxChar(Sender: TObject; Count: Integer);
var Buffer:array[1..1024] of char; s:String; i,q:Integer;
begin
{
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
 }
end;

procedure TFNotaSaida.EdPedidosExit(Sender: TObject);
///////////////////////////////////////////////////////
begin
{
  EdPedidos.enabled:=false;
  EdPedidos.visible:=false;
// 08.01.15
  SetEdCLIE_NOME.Visible:=true;
  EdCliente.Next;
// 09.06.14 - Granzoto - para ter um 'cfop' base para buscar o cfop correto na tabela de CST
   EdNatf_codigo.text:=Arq.TConfMovimento.fieldbyname('comv_natf_estado').asstring;
}
end;

procedure TFNotaSaida.EdPedidosValidate(Sender: TObject);
///////////////////////////////////////////////////////////

      function TestaBP(xcodigo:integer):boolean;
      //////////////////////////////////////////
      var QB:Tsqlquery;
      begin
        QB:=sqltoquery('select sum(Pend_valor) as valor from pendencias where pend_status=''P'''+
                       ' and pend_tipo_codigo='+inttostr(xcodigo)+
                       ' and pend_tipocad='+Stringtosql('C')+
                       ' and pend_unid_codigo='+STringtosql(Global.CodigoUnidade) );
        result:=( Qb.fieldbyname('valor').ascurrency>0 );

      end;
begin
/////////////////////////
  Brelpendentes.Font.Color:=clblack;
  if not EdPedidos.isempty then begin
    Qped:=sqltoquery( FGeral.Buscapedvenda(0,EdPedidos.text) );
    if Global.topicos[1378] then
        if TestaBP( EdCliente.asinteger ) then Timer1.Enabled:=true;
  end else
    Grid.clear;
    ////////////////////////////////////
  EdPedidos.enabled:=false;
  EdPedidos.visible:=false;
// 08.01.15
  SetEdCLIE_NOME.Visible:=true;
  EdCliente.Next;
// 09.06.14 - Granzoto - para ter um 'cfop' base para buscar o cfop correto na tabela de CST
//   EdNatf_codigo.text:=Arq.TConfMovimento.fieldbyname('comv_natf_estado').asstring;
// 15.02.2023 - Guiber - retirado pois j� vem certo do pedido...vamos ver...
////////////////
end;

procedure TFNotaSaida.EdtransacaoValidate(Sender: TObject);
begin
   Edtransacao.visible:=false;
   if not EdTransacao.isempty then begin
        ImprimeContrato(EdTransacao.text);
   end;


end;

procedure TFNotaSaida.GridDblClick(Sender: TObject);
////////////////////////////////////////////////////////
var codigo:string;
begin

   codigo:=Grid.cells[Grid.getcolumn('move_esto_codigo'),Grid.row];
   if trim(codigo)='' then exit;
//   if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodContratoEntrega+';'+Global.CodDevolucaoCompra+';'+Global.CodRemessaIndPropria ) =0 then exit;
// 22.04.13 - Abra - cuiaba
//   if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodContratoEntrega+';'+
//           Global.CodDevolucaoCompra+';'+Global.CodRemessaIndPropria+';'+Global.CodVendaProntaEntrega+';'+
//           Global.CodNfeComplementoQtde+';'+Global.CodDevolucaoTributada ) =0 then exit;

   if Grid.col=grid.getcolumn('move_qtde') then begin

     EdQTdeNf.Top:=Grid.TopEdit;
     EdQTdeNf.Left:=Grid.LeftEdit;
     EdQTdeNf.Enabled:=true;
     EdQTdeNf.Visible:=true;
     EdQTdeNf.setvalue( Texttovalor((Grid.cells[grid.getcolumn('move_qtde'),grid.row])) );
     EdQTdeNf.setfocus;

   end;

   if Grid.col=grid.getcolumn('move_venda') then begin
     EdUnitarionf.Top:=Grid.TopEdit;
     EdUnitarionf.Left:=Grid.LeftEdit;
     EdUnitarionf.Enabled:=true;
     EdUnitarionf.Visible:=true;
     EdUnitarionf.setvalue( Texttovalor((Grid.cells[grid.getcolumn('move_venda'),grid.row])) );
     EdUnitarioNf.setfocus;
   end;
// 06.08.18
   if Grid.col=grid.getcolumn('move_aliicms') then begin
     EdAliicmsnf.Top:=Grid.TopEdit;
     EdAliicmsnf.Left:=Grid.LeftEdit;
     EdAliicmsnf.Enabled:=true;
     EdAliicmsnf.Visible:=true;
     EdAliicmsnf.setvalue( Texttovalor((Grid.cells[grid.getcolumn('move_aliicms'),grid.row])) );
     EdAliicmsNf.setfocus;
   end;
// 28.02.20
   if Grid.col=grid.getcolumn('move_natf_codigo') then begin
//   if ( Grid.col=grid.getcolumn('move_natf_codigo') ) and ( OP='A') then begin
     EdCfopitem.Top:=Grid.TopEdit;
     EdCfopitem.Left:=Grid.LeftEdit+04;
     EdCfopitem.Enabled:=true;
     EdCfopitem.Visible:=true;
     EdCfopitem.text:=Grid.cells[grid.getcolumn('move_natf_codigo'),grid.row];
     EdCfopitem.setfocus;
   end;

end;

procedure TFNotaSaida.GridKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
     Grid.OnDblClick(self);

end;

procedure TFNotaSaida.EdQtdenfValidate(Sender: TObject);
begin
  if EdQtdeNf.ascurrency>Texttovalor(Grid.cells[grid.getcolumn('move_qtde'),grid.row]) then
    EdQtdenf.invalid('Quantidade inv�lida');

end;

procedure TFNotaSaida.EdQtdenfExitEdit(Sender: TObject);
begin

  Grid.cells[grid.getcolumn('move_qtde'),grid.row]:=EdQtdeNf.assql;
  Grid.cells[grid.getcolumn('qtdeprev'),grid.row]:=EdQtdeNf.assql;
//  Grid.cells[grid.getcolumn('total'),grid.row]:=floattostr(EdQtdeNf.asfloat*Texttovalor(Grid.cells[grid.getcolumn('move_venda'),grid.row]));
  Grid.cells[grid.getcolumn('total'),grid.row]:=floattostr(EdQtdeNf.ascurrency*Texttovalor(Grid.cells[grid.getcolumn('move_venda'),grid.row]));
  EdQtdenf.Enabled:=false;
  EdQtdenf.Visible:=false;
  SetaEditsvalores( true );
  Grid.setfocus;

end;

procedure TFNotaSaida.EdVendasmcValidate(Sender: TObject);
///////////////////////////////////////////////////////////////
var Q:TSqlquery;
    Data:TDatetime;
begin

  if ( not EdVendasmc.isempty ) and ( pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.CodContratoEntrega+';'+Global.CodRemessaIndPropria)>0 ) then begin
    data:=sistema.hoje-360;
// 10.06.09
    if EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodRemessaIndPropria then begin
        EdMensagem.text:='Remessa Ref. NF(s) '+trim(EdVendasmc.text)+' p/ industrializa��o '+EdMensagem.text;
// 24.08.12 - Abra escolhendo 'trocentas notas'...
        EdMensagem.text:=copy(EdMensagem.text,1,EdMensagem.MaxLength);
        EdMens_codigo.text:='';  // para que quando passar pelo codigo da mensagem n�o 'recolocar' a mensagem 'normal'
    end;
    Q:=sqltoquery('select moes_datamvto from movesto'+
//                 ' where moes_tipomov='+stringtosql(Global.CodContrato)+
                 ' where moes_tipomov='+stringtosql(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring)+
                 ' and moes_tipo_codigo='+EdCliente.Assql+' and moes_status=''N'''+
//                 ' and moes_datacont>1'+
// 20.07.10
//                 ' and moes_datacont > '+DatetoSql(Global.DataMenorBanco)+
// 17.11.14 - metallum
                 ' and '+FGeral.Getin('moes_numerodoc',EdVendasmc.text,'N')+
                 ' and moes_datamvto>='+Datetosql(data)+
                 ' and moes_unid_codigo='+EdUnid_codigo.assql+
                 ' order by moes_datamvto' );
    if not Q.eof then begin
//      SetaItemsConsig(Global.CodContratoEntrega,EdDevolucoesdm,Q.fieldbyname('moes_datamvto').asdatetime);    // devolucoes
// 17.11.14
      EdDevolucoesdm.text:='';
      SetaItemsConsig(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,EdDevolucoesdm,Q.fieldbyname('moes_datamvto').asdatetime);    // devolucoes
    end;
    FGeral.FechaQuery(Q);
  end else if ( not EdVendasmc.isempty ) and ( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodDevolucaoCompra ) then begin
      EdMensagem.text:='Ref. NF(s) '+trim(EdVendasmc.text)+' '+EdMensagem.text;
      EdMens_codigo.text:='';  // para que quando passar pelo codigo da mensagem n�o 'recolocar' a mensagem 'normal'
  end;

end;

procedure TFNotaSaida.EdRepr_codigoValidate(Sender: TObject);
var percomissao:extended;
    sqldataorca,SitAprovada:string;
//    QOrc:TSqlquery;
    Data:TDatetime;

begin
  if EdRepr_codigo.resultfind<>nil then begin
    percomissao:=EdRepr_codigo.resultfind.fieldbyname('repr_comissao').ascurrency;
// 23.08.10
    EdMargemlucro.SetValue( 0 );
// 08.07.09
//    if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').Text=Global.CodContrato then begin
// 02.01.12 - Abra - adriano via email - colocado VY tbem
    if pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').Text,Global.CodContrato+';'+Global.CodContratoNota)>0 then begin
//       EdMargemlucro.SetValue( FGeral.GetCampoNumerico('Margem Lucro',EdMargemlucro.ascurrency,FNotaSaida.Left+10,FNotaSaida.Top-10) );
       EdOrcamentos.Enabled:=true;
       EdOrcamentos.Visible:=true;
///////////////////////////////////////
{
       Data:=Sistema.Hoje-180;
       SitAprovada:='F';  // fechada
       sqldataorca:='and orca_datamvto>='+Datetosql(Data);
       QOrc:=TSqlquery('select Orcc_margem,orcc_nome,orcc_numerodoc,orca_obra,orca_repr_codigo from orcamencal'+
                    ' inner join orcamentos on ( orca_numerodoc=orcc_numerodoc )'+
                    ' where orcc_status=''N'''+
                    ' and orca_status=''N'''+
                    ' and orca_repr_codigo='+EdRepr_codigo.assql+
                    sqldataorca+
                    ' and orcc_situacao='+Stringtosql(SitAprovada) );
       EdOrcamentos.Items.Clear;
       while not QOrc.Eof do begin
         EdOrcamentos.Items.Add( EdOrcamentos.Text+QOrc.fieldbyname('orca_obra').AsString+' ; ';
                            QOrc.fieldbyname('orcc_numerodoc').AsString+' ; '+
                            QOrc.fieldbyname('orcc_nome').AsString+' ; '+
                            QOrc.fieldbyname('orcc_margem').AsString );
         QOrc.Next;
       end;
       FGeral.FechaQuery(QOrc);
///////////////////////////////////////
}

//       EdMargemlucro.SetValue( FGeral.GetCampoNumerico('Margem Lucro',EdMargemlucro.ascurrency,FNotaSaida.Left+50,FNotaSaida.Top+20) );
//       percomissao:=FTabelaComissao.GetComissao(EdRepr_codigo.AsInteger,EdMargemlucro.ascurrency);
    end;

{
    if not FGeral.ValidaComissao(percomissao) then
      EdRepr_codigo.Invalid('')
    else if Global.Topicos[1324] then
      Edpercomissao.setvalue(percomissao);
}
  end;
end;

procedure TFNotaSaida.EdSeto_codigoExitEdit(Sender: TObject);
/////////////////////////////////////////////////////////////////
begin

  bincluiritemclick(FNotaSaida)

end;

procedure TFNotaSaida.EdSeto_codigoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////////////
begin

  if (EdSeto_codigo.AsInteger=9999) and (EdTotalNOta.ascurrency>0) then begin
    if OP='I' then
      FRateio.Execute('Valores por OBRA','setores','seto_codigo',EdTotalNOta.ascurrency,'')
    else
      FRateio.Execute('Valores por OBRA','setores','seto_codigo',EdTotalNOta.ascurrency,transacaobusca)
  end;

end;

procedure TFNotaSaida.EdRepr_codigo2Validate(Sender: TObject);
begin
  if EdRepr_codigo2.resultfind<>nil then begin
    if not FGeral.ValidaComissao(EdRepr_codigo2.resultfind.fieldbyname('repr_comissao').ascurrency) then
      EdRepr_codigo2.Invalid('')
    else if Global.Topicos[1324] then
      Edpercomissao2.setvalue(EdRepr_codigo2.resultfind.fieldbyname('repr_comissao').ascurrency);
  end;
end;

procedure TFNotaSaida.EdpercomissaoValidate(Sender: TObject);
begin
    if not FGeral.ValidaComissao(EdPercomissao.ascurrency) then
      EdPerComissao.invalid('');

end;

procedure TFNotaSaida.Edpercomissao2Validate(Sender: TObject);
begin
    if not FGeral.ValidaComissao(EdPercomissao2.ascurrency) then
      EdPerComissao2.invalid('');

end;

/// 06.08.18
procedure TFNotaSaida.EdaliicmsnfExitEdit(Sender: TObject);
///////////////////////////////////////////////////////////
begin

  Grid.cells[grid.getcolumn('move_aliicms'),grid.row]:=EdaliicmsNf.assql;
  Edaliicmsnf.Enabled:=false;
  Edaliicmsnf.Visible:=false;
  SetaEditsvalores;
  Grid.setfocus;


end;

procedure TFNotaSaida.EdCertificadoValidate(Sender: TObject);
var credito:currency;
begin
// 30.12.08
//  if ( Global.Topicos[1326] ) and ( EdCertificado.text='S' ) then begin
  if ( Global.Topicos[1326] ) and ( not EdCertificado.isempty ) and (  EdCertificado.text<>'N' ) then begin
    credito:=FGeral.CalculaCreditoCubicos(EdProduto.Text,EdCertificado.text,EdUNid_codigo.text);
    if (credito<EdQtde.AsCurrency) and ( not Global.Usuario.OutrosAcessos[0316] ) then
      EdCertificado.invalid('Dispon�vel somente '+floattostr(credito)+' metros c�bicos de madeira certificada');
  end;

end;

procedure TFNotaSaida.EdCfopitemExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////
begin

  if not EdCfopitem.isempty then begin

    Grid.cells[grid.getcolumn('move_natf_codigo'),grid.row]:=EdCfopitem.text;
    EdCfopitem.Enabled:=false;
    EdCfopitem.Visible:=false;

  end;
  Grid.setfocus;

end;

procedure TFNotaSaida.EdUnitarionfExitEdit(Sender: TObject);
begin

  Grid.cells[grid.getcolumn('move_venda'),grid.row]:=EdUnitarioNf.assql;
  Grid.cells[grid.getcolumn('move_vendabru'),grid.row]:=EdUnitarioNf.assql;
  Grid.cells[grid.getcolumn('total'),grid.row]:=floattostr(EdUNitarioNf.ascurrency*Texttovalor(Grid.cells[grid.getcolumn('move_qtde'),grid.row]));
  EdUnitario.Enabled:=false;
  EdUnitarionf.Visible:=false;
  SetaEditsvalores;
  Grid.setfocus;

end;

procedure TFNotaSaida.EdUnitarionfValidate(Sender: TObject);
begin
//  if EdUNitarioNf.ascurrency>Texttovalor(Grid.cells[grid.getcolumn('move_venda'),grid.row]) then
//    EdUNitarionf.invalid('Unit�rio inv�lido');

end;

procedure TFNotaSaida.EdCorIndustValidate(Sender: TObject);
begin
  EdCorIndust.Visible:=false;
  EdCorIndust.Enabled:=false;

end;

procedure TFNotaSaida.EdOrcamentosValidate(Sender: TObject);
var Qorc:TSqlquery;
    SitAprovada,sqldataorca:string;
    Data:TDatetime;
    xmargem,percomissao:currency;
    xvezes:integer;
begin
    SitAprovada:='F';  // fechada
    Data:=Sistema.Hoje-180;
    sqldataorca:=' and orca_datamvto>='+Datetosql(Data);
    xvezes:=0;
    xmargem:=0;
    if not Edorcamentos.IsEmpty then begin
      QOrc:=Sqltoquery('select Orcc_margem,orcc_nome,orcc_numerodoc,orca_obra,orca_repr_codigo from orcamencal'+
                    ' inner join orcamentos on ( orca_numerodoc=orcc_numerodoc )'+
                    ' where orcc_status=''N'''+
                    ' and orca_status=''N'''+
//                    ' and '+FGeral.GetIN('orcc_numerodoc',EdOrcamentos.Text,'N')+
                    ' and '+FGeral.GetIN('orca_nroobra',EdOrcamentos.Text,'C')+
                    ' and orca_repr_codigo='+EdRepr_codigo.assql+
                    sqldataorca+
                    ' and orcc_situacao='+Stringtosql(SitAprovada) );
      while not QOrc.Eof do begin
        xmargem:=xmargem+QOrc.fieldbyname('orcc_margem').AsCurrency;
        inc(xvezes);
        QOrc.Next;
      end;
      if xvezes>0 then begin
        EdMargemLucro.SetValue(xmargem/xvezes);
        EdMargemlucro.SetValue( FGeral.GetCampoNumerico('Margem Lucro',EdMargemlucro.ascurrency,FNotaSaida.Left+50,FNotaSaida.Top+20) );
        percomissao:=FTabelaComissao.GetComissao(EdRepr_codigo.AsInteger,EdMargemlucro.ascurrency);
        if not FGeral.ValidaComissao(percomissao) then
          EdOrcamentos.Invalid('')
        else if Global.Topicos[1324] then
          Edpercomissao.setvalue(percomissao);
      end;
    end else begin
        EdMargemlucro.SetValue( FGeral.GetCampoNumerico('Margem Lucro',EdMargemlucro.ascurrency,FNotaSaida.Left+50,FNotaSaida.Top+20) );
        percomissao:=FTabelaComissao.GetComissao(EdRepr_codigo.AsInteger,EdMargemlucro.ascurrency);
        if not FGeral.ValidaComissao(percomissao) then
          EdOrcamentos.Invalid('')
        else if Global.Topicos[1324] then
          Edpercomissao.setvalue(percomissao);
    end;
    if not Edorcamentos.IsEmpty then
      FGeral.FechaQuery(QOrc);
    EdOrcamentos.Visible:=false;
    EdOrcamentos.Enabled:=false;
end;

function TFNotaSaida.TratamentotoCor(xcorid: string): string;
var xtrat:string;
begin
// ir colocando cfe as cores 'novas'
   xtrat:=uppercase(xcorid);
   if ansipos('RAL9003B',xtrat)>0 then
//     xtrat:='RAL9003B';
     xtrat:='BRANCO RAL9003B'
// 22.10.09     
   else if ( ansipos('1000-A13',xtrat)>0  ) or ( ansipos('1000-A23',xtrat)>0 ) then
     xtrat:='ANOD 1000-A13'
   else if ( ansipos('1003-A13',xtrat)>0  ) or ( ansipos('1003-A23',xtrat)>0 ) then
     xtrat:='ANOD 1003-A13'
   else if ( ansipos('CM',xtrat)>0  ) or ( ansipos('TBRUTO',xtrat)>0 ) or ( ansipos('SBRUTO',xtrat)>0 ) then
     xtrat:='NATURAL - SEM TRATAMENTO';
   result:=xtrat;
end;

// 09.02.2023
function TFNotaSaida.ValidapeloNcm: boolean;
/////////////////////////////////////////////
var p:integer;
    produto,
    cst,
    cfop,
    cstncm,
    cfopncm,
    ncm,
    xUnid_codigo,
    xunidadesncm:string;
    aliicms,
    aliicmsncm:currency;
    QTrib:TSqlquery;
    achou:boolean;

    procedure GetTributacao(xUnid_codigo:string;var aliicmsncm:currency;var cstncm:string;var cfopncm:string;var achou:boolean);
    begin
// por enquanto somente da 'unid1' na tabela codigos ipi
          if QTrib.fieldbyname('cipi_unid1_codigo').asstring=xUnid_codigo then begin

             achou:=true;
             if copy(cfop,1,1)='5' then begin

                 aliicmsncm := Qtrib.fieldbyname('cipi_aliicmsu1_est').ascurrency;
                 cstncm     := Qtrib.fieldbyname('cipi_cstu1_est').asstring;
                 cfopncm    := Qtrib.fieldbyname('cipi_cfopu1_est').asstring;

             end else begin

                 aliicmsncm := Qtrib.fieldbyname('cipi_aliicmsu1_fest').ascurrency;
                 cstncm     := Qtrib.fieldbyname('cipi_cstu1_fest').asstring;
                 cfopncm    := Qtrib.fieldbyname('cipi_cfopu1_fest').asstring;

             end;

          end else begin

              achou:=false ;
              aliicmsncm:=0;
              cstncm:='';
              cfopncm:='' ;

          end;

    end;


begin

  result:=false;
  xUnidadesncm:=FGeral.GetConfig1AsString('unidadesncm');
  if ( (AnsiPos(EdUNid_codigo.text,xUnidadesncm)=0) )
     or
     (trim(xUnidadesncm)='')
     then begin

     result:=true;
     exit;
  end;
  xUnid_codigo := EdUnid_codigo.text;

  result:=true;
  for p:=1 to Grid.rowcount do begin

    produto:=Grid.Cells[Grid.GetColumn('move_esto_codigo'),p];
    result:=true;
    if trim(produto)<>'' then begin

      ncm    := FEstoque.GetNCMipi(produto);
      aliicms:=texttovalor(Grid.Cells[Grid.GetColumn('Move_aliicms'),p] );
      cst    :=trim(Grid.Cells[Grid.GetColumn('Move_cst'),p] );
      cfop   :=trim(Grid.Cells[Grid.GetColumn('Move_natf_codigo'),p] );
      QTrib  := sqltoquery('select * from codigosipi where cipi_codfiscal = '+stringtosql(ncm));
      if not QTrib.eof then begin

        GetTributacao(xUnid_codigo,aliicmsncm,cstncm,cfopncm,achou);
        if not Achou then begin
          QTrib.close;
          result:=false;
          Avisoerro('Unidade '+xunid_codigo+' n�o configurada para este ncm '+ncm);
          break;
        end;

      end else begin
        QTrib.close;
        result:=false;
        Avisoerro('NCM '+ncm+' n�o encontrado');
        break;
      end;
      QTrib.close;
      if aliicms<>aliicmsncm then begin
        Avisoerro('Produto '+produto+' com icms '+currtostr(aliicms)+' correto � icms '+currtostr(aliicmsncm)) ;
        result:=false;
        break;
      end;
      if cst<>cstncm then begin
        Avisoerro('Produto '+produto+' com cst '+cst+' correto � cst '+cstncm) ;
        result:=false;
        break;
      end;
      if cfop<>cfopncm then begin
        Avisoerro('Produto '+produto+' com cfop '+cfop+' correto � cfop '+cfopncm) ;
        result:=false;
        break;
      end;
    end;

  end;

end;

procedure TFNotaSaida.AdicionaListaServicos(Q: TSqlquery);
//////////////////////////////////////////////////////////////
var achou:boolean;
    p:integer;
begin
  achou:=false;
  for p:=0 to LIstaServicos.Count-1 do begin
    PServicos:=ListaServicos[p];
    if PServicos.produto=Q.fieldbyname('mpdd_esto_codigo').asstring then begin
      achou:=true;
      break;
    end;
  end;
  if not achou then begin
     New(PServicos);
     PServicos.produto:=Q.fieldbyname('mpdd_esto_codigo').asstring;
     PServicos.qtde:=Q.fieldbyname('mpdd_qtde').ascurrency;
     PServicos.unitario:=Q.fieldbyname('mpdd_venda').ascurrency;
     PServicos.periss:=FEstoque.GetaliquotaIss(Q.fieldbyname('mpdd_esto_codigo').asstring,EdUnid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring);
     EdTotalservicos.SetValue( EdTotalservicos.ascurrency + roundvalor(PServicos.qtde*PServicos.unitario) );
     ListaServicos.Add(PServicos);
  end else begin
     PServicos.qtde:=PServicos.qtde+Q.fieldbyname('mpdd_qtde').ascurrency;
     EdTotalservicos.SetValue( EdTotalservicos.ascurrency +  roundvalor(PServicos.qtde*PServicos.unitario) );
  end;
end;

function TFNotaSaida.Servico(produto: string): boolean;
///////////////////////////////////////////////////////////
var codigofis,tpimposto:string;
begin
  codigofis:=FEstoque.GetCodigoFiscal(produto,EdUnid_codigo.text,Global.UFUnidade);
  tpimposto:=FCodigosFiscais.GetQualImposto(codigofis);
  result:=tpimposto='S';
end;

procedure TFNotaSaida.SetaItensProdutosAcabados(Ed: TSqled ; OP:string );
///////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    sqlperiodo:string;
begin
   Ed.Items.Clear;
   if Global.Topicos[1336] then begin
     sqlperiodo:=' and move_datamvto>='+Datetosql(Sistema.hoje-90);
     Q:=sqltoquery('select move_esto_codigo,esto_referencia,sum(move_qtde) as move_qtde from movestoque'+
                   ' inner join estoque on ( move_esto_codigo=esto_codigo )'+
                   ' where '+fGeral.GetIN('move_numerodoc',Op,'C')+
                   ' and move_status=''N'' and move_unid_codigo='+EdUnid_codigo.AsSql+
                   sqlperiodo+
                   ' and move_tipomov='+Stringtosql(Global.CodEntradaAcabado)+
                   ' group by move_esto_codigo,esto_referencia' );
     while not Q.Eof do begin
       Ed.Items.Add( strspace(Q.fieldbyname('move_esto_codigo').asstring,15)+' '+
                     strspace(Q.fieldbyname('esto_referencia').asstring,12)+' '+
                     strspace(Q.fieldbyname('move_qtde').asstring,12) );
       Q.Next;
     end;
     FGEral.FechaQuery(Q);
   end;
end;

function TFNotaSaida.ConstaListaProdutosAcabados(  Lista: TStrings;codigo:string): boolean;
////////////////////////////////////////////////////////////////////////////////////////////
var p:integer;
begin
  if Global.Topicos[1336] then begin
    result:=false;
    for p:=0 to Lista.Count-1 do begin
        if pos(codigo,Lista[p])>0 then begin
          result:=true;
          break;
        end;
    end;
  end else
    result:=true;
end;

procedure TFNotaSaida.EdDtemissaoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////
begin
  if not FGeral.ValidaMvto(EdDtemissao) then
    EdDtemissao.Invalid('')
  else
// 01.08.11 - Capeg - 06.01.12 - pedir pra deixar ultima data informada
/////////////////
    {
    if ( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodRomaneioRemessaaOrdem ) then begin
      EdDtSaida.setdate( FGeral.GetProximoDiaUtil(EdDtEmissao.asdate+1) );
      if not FGeral.DiaUtil( EdDtSaida.AsDate ) then begin
        Eddtsaida.setdate( EdDtSaida.AsDate+1 );
        if not FGeral.DiaUtil( EdDtSaida.AsDate ) then begin
          Eddtsaida.setdate( EdDtSaida.AsDate+1 );
        end;
      end;
    end;
    }
///////////////
end;

procedure TFNotaSaida.brelpendentesClick(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_Pendentes('R',EdCliente.AsInteger); ;

end;

procedure TFNotaSaida.EdPort_codigoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////////
var ListaFsc:TStringList;
    i:integer;
    fsc:string;


    function EstaNaUnidade( xportador:string ):boolean;
    ////////////////////////////////////////////////////
    var Qp,
        Qc:TSqlquery;
    begin

       result := true;
       Qp := sqltoquery('select port_plan_conta from portadores where port_codigo = '+Stringtosql(xportador)) ;
       if not QP.eof then begin

          if Qp.fieldbyname('port_plan_conta').asinteger > 0 then begin

            Qc := sqltoquery('select plan_unid_codigo from plano where Plan_conta = '+inttostr(Qp.fieldbyname('port_plan_conta').asinteger));
            if not Qc.eof then begin

               if trim(Qc.fieldbyname('plan_unid_codigo').asstring) <> '' then begin

                 if Qc.fieldbyname('plan_unid_codigo').asstring <> EdUNid_codigo.text then

                    result := false;

               end;

            end;
            FGeral.FechaQuery( Qc );

          end;

       end;

       FGeral.FechaQuery( Qp );

    end;


begin
// 15.04.10 - Volmar - madeira controlada
   if not EdPort_codigo.IsEmpty then begin

      ListaFsc:=TStringlist.create;
      for i:=1 to Grid.rowcount do begin
          fsc:=trim( Grid.Cells[Grid.getcolumn('move_certificado'),i] );
          if pos(fsc,'1;2;3')>0 then
            ListaFsc.Add(fsc);
      end;

      if ( listafsc.IndexOf('1')<>-1 ) and ( FGeral.getconfig1asinteger('Codfscpuro')>0 ) then
  //      EdMens_codigo.setvalue(FGeral.getconfig1asinteger('Codfscpuro'));
  //      EdMensagem.text:=EdMensagem.text+' '+FMensNotas.GetDescricao(FGeral.getconfig1asinteger('Codfscpuro'))
        EdMensagem.text:=FMensNotas.GetDescricao(FGeral.getconfig1asinteger('Codfscpuro'))
      else if ( listafsc.IndexOf('2')<>-1 ) and ( FGeral.getconfig1asinteger('Codfscmisto')>0 ) then
  //      EdMensagem.text:=EdMensagem.text+' '+FMensNotas.GetDescricao(FGeral.getconfig1asinteger('Codfscmisto'))
        EdMensagem.text:=FMensNotas.GetDescricao(FGeral.getconfig1asinteger('Codfscmisto'))
      else if ( listafsc.IndexOf('3')<>-1 ) and ( FGeral.getconfig1asinteger('Codfscmisto')>0 ) then
  //      EdMensagem.text:=EdMensagem.text+' '+FMensNotas.GetDescricao(FGeral.getconfig1asinteger('Codfsccontrolado'));
        EdMensagem.text:=FMensNotas.GetDescricao(FGeral.getconfig1asinteger('Codfsccontrolado'));
      ListaFsc.Free;
// 17.05.18
      if  ( Global.Topicos[1453] ) and ( PortadorCarteira  ) then
         EdFpgt_codigo.text:=FGeral.GetConfig1AsString('EdFpgtoavista');

// 09.11.2021 - Guiber
      if Global.Topicos[1518] then begin

         if not EstaNaUnidade( EdPort_codigo.text ) then EdPort_codigo.invalid('Conta de outra unidade');


      end;

   end;


end;

procedure TFNotaSaida.bgeranfeClick(Sender: TObject);
begin
  if Global.Topicos[1020] then
    FExpNfetxt.Execute( EdNumerodoc.AsInteger )
  else
    FExpNfetxt.Execute;
end;

procedure TFNotaSaida.bMoveLeftClick(Sender: TObject);
begin
   Grid.MoveLeftColumn;
end;

procedure TFNotaSaida.bMoveRightClick(Sender: TObject);
begin
   Grid.MoveRightColumn;

end;

procedure TFNotaSaida.bLoadGridClick(Sender: TObject);
begin
   Grid.LoadGrid;
end;

procedure TFNotaSaida.bSaveGridClick(Sender: TObject);
begin
   Grid.SaveGrid;
end;

procedure TFNotaSaida.bgeraboletoClick(Sender: TObject);
begin
   FBoletos.Execute();
end;

procedure TFNotaSaida.PMensDblClick(Sender: TObject);
begin
   if Global.Usuario.Codigo=100 then begin
//      FGeral.ImprimeCupomFiscal(Global.UltimaTransacao,EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring);
//      FGeral.ImprimeCupomFiscal('001376233','VC');
//      FGeral.ImprimeCupomFiscal('00138533','VD');
//      FEcfGeral.ImprimeCupomFiscal('00138533','VD');
//      FEcfGeral.ImprimeCupomFiscal('00138568','VD');


   end;


end;

// 17.05.18
function TFNotaSaida.PortadorCarteira: boolean;
/////////////////////////////////////////////////
begin

  result:=false;
  if AnsiPos( 'CARTEI',EdPort_descricao.Text ) > 0 then result:=true;

end;

//////////////////////////////////////////////////////////////////////////////
procedure TFNotaSaida.ConfigEnableEdits(Painel: TObject; ativado: boolean);
//////////////////////////////////////////////////////////////////////////////
var p:Integer; Ed:TSQLEd;
begin
//  for p:=0 to TPanel( Painel ).ComponentCount-1 do begin
  for p:=0 to TPanel( Painel ).ControlCount-1 do begin
//    if TPanel( Painel ).Components[p] is TSqlEd then begin
    if TPanel( Painel ).Controls[p] is TSQLEd then begin
      Ed:=TSQLEd( TPanel( Painel ).Controls[p] );
      Ed.Enabled:=ativado
    end;
  end;
end;

procedure TFNotaSaida.EdTran_codigoExitEdit(Sender: TObject);
begin
  if op='G' then begin
//    EdPort_codigo.setfocus;
//    PVeiculo.BringToFront;
//    Pveiculo.visible:=true;
//    Pveiculo.enabled:=true;
//    EdMoes_cola_codigo.text:=EdTran_codigo.resultfind.fieldbyname('tran_cola_codigo').Asstring;
// 28.04.20 - Novicarnes
    EdMoes_cola_codigo.text:=xcola_codigo;
    EdMoes_cola_codigo.ValidFind;
    EdMoes_cola_codigo.Valid;
    EdMoes_cola_codigo.OnExitEdit(self);  // aqui

//    EdMoes_cola_codigo.setfocus;

  end else if op='H' then begin

    EdMoes_cola_codigo.text:=xcola_codigo;
    EdMoes_cola_codigo.ValidFind;
    EdMoes_cola_codigo.OnExitEdit(self);

  end;

end;

procedure TFNotaSaida.bcupomClick(Sender: TObject);
begin
/////  if not Sistema.Processando then FGerenciaECF.Execute;

end;

procedure TFNotaSaida.DateTimePicker1Change(Sender: TObject);
begin
  if ( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodRomaneioRemessaaOrdem )
     and ( OP='I' ) then begin
     EdDtSaida.SetDate( DateTimePicker1.Date );
     EdDtSaida.setfocus;
  end;

end;

procedure TFNotaSaida.Esconde(xPainel: TSqlPanelGrid);
begin
   xPainel.visible:=false;
   xPainel.enabled:=false;
end;

procedure TFNotaSaida.Mostra(xPainel: TSqlPanelGrid; desc: string);
begin
   xPainel.visible:=true;
   xPainel.enabled:=true;
   xPainel.Caption:=desc;
end;

procedure TFNotaSaida.ACBrBAL1LePeso(Peso: Double; Resposta: String);
var valid : integer;
begin
    EdQtde.setvalue(peso);
{
   sttPeso.Caption     := formatFloat('##0.000', Peso );
   sttResposta.Caption := Converte( Resposta ) ;

   if Peso > 0 then
      Memo1.Lines.Text := 'Leitura OK !'
   else
    begin
      valid := Trunc(ACBrBAL1.UltimoPesoLido);
      case valid of
         0 : Memo1.Lines.Text := 'TimeOut !'+sLineBreak+
                                 'Coloque o produto sobre a Balan�a!' ;
        -1 : Memo1.Lines.Text := 'Peso Instavel ! ' +sLineBreak+
                                 'Tente Nova Leitura' ;
        -2 : Memo1.Lines.Text := 'Peso Negativo !' ;
       -10 : Memo1.Lines.Text := 'Sobrepeso !' ;
      end;
    end ;
}
end;

// 26.02.12
procedure TFNotaSaida.bregistro71Click(Sender: TObject);
/////////////////////////////////////////////////////////
var modelosok:string;
    p,volumes,i:integer;
    pesoliq,
    pesobru,
    pesoliqton :currency;

begin


  if Confirma('Usar arquivos XML das NF-e ?') then begin

    if not od1.execute then exit;
    if od1.FileName='' then exit;
    Sistema.beginprocess('Armazenando arquivos Xmls...');
// 23.04.18 - Agropec. Geffer
    AcbrNfe1.NotasFiscais.Clear;
    if Global.Topicos[1452] then  begin

        AcbrNfe1.NotasFiscais.LoadFromFile( od1.FileName );

    end else begin

        ListaArq.Directory:=ExtractFilePath( Od1.FileName );
        AcbrNfe1.NotasFiscais.Clear;
        for p:=0 to ListaArq.Items.Count-1 do begin
          try
            AcbrNfe1.NotasFiscais.LoadFromFile( ListaArq.Items[p] );
          except
            Avisoerro('N�o foi poss�vel ler o arquivo '+ListaArq.Items[p]);
          end;
        end;

    end;

    Sistema.endprocess('Encontrado '+inttostr(Acbrnfe1.NotasFiscais.Count)+' arquivos XML');
// aqui somar volumes e peso total e jogar nos edits
    volumes:=0;pesoliq:=0;pesobru:=0;
    for p := 0 to Acbrnfe1.NotasFiscais.Count-1 do begin

       for i:= 0 to AcbrNfe1.NotasFiscais.Items[p].NFe.Transp.Vol.Count-1 do begin

         volumes:=volumes+AcbrNfe1.NotasFiscais.Items[p].NFe.Transp.Vol.Items[i].qVol;
         pesoliq:=pesoliq+AcbrNfe1.NotasFiscais.Items[p].NFe.Transp.Vol.Items[i].pesoL;
         pesobru:=pesobru+AcbrNfe1.NotasFiscais.Items[p].NFe.Transp.Vol.Items[i].pesoB;

       end;

    end;

// 23.06.20 - verificar se tem algum item em toneladas - 'TON'
    pesoliqton:=0;
    for p := 0 to Acbrnfe1.NotasFiscais.Count-1 do begin

       for i:= 0 to AcbrNfe1.NotasFiscais.Items[p].NFe.Det.Count-1 do begin

         if AcbrNfe1.NotasFiscais.Items[p].NFe.Det.Items[i].Prod.uCom = 'TON'  then begin
           pesoliqton := pesoliqton + AcbrNfe1.NotasFiscais.Items[p].NFe.Det.Items[i].Prod.qCom;
         end;

       end;

    end;

// 23.06.20
    if pesoliqton > 0 then begin  // se for em toneladas converte pra kilos...

      EdQtdevolumes.Text:=inttostr(volumes * 10 );
      EdPesoLiq.SetValue( pesoliqton*1000 );
// peso bruto deixa o q foi digitado pois nao tem a informa�ao nos itens da nota
// e nem em outra tag...

    end else begin

      EdQtdevolumes.Text:=inttostr(volumes);
      EdPesoLiq.SetValue(pesoliq);
      EdPesoBru.SetValue(pesobru);

    end;

    bincluiritemclick(self);

  end else begin

// caso quiser lan�ar manual as notas....

     if PRegistro71.Visible then begin

       pRegistro71.enabled:=false;
       pRegistro71.visible:=false;
       pRegistro71.SendToBack;
       bIncluiritemClick(self);

     end else begin

       pRegistro71.enabled:=true;
       pRegistro71.visible:=true;
       pRegistro71.BringToFront;
       EdDtemissao71.SetDate(Eddtemissao.asdate);
       binsere71click(self);

     end;
  end;
end;

procedure TFNotaSaida.binsere71Click(Sender: TObject);
begin
   pinsere71.Enabled:=true;
   EdCodEntidade71.SetFocus;

end;

procedure TFNotaSaida.bexclui71Click(Sender: TObject);
begin
  Grid71.DeleteRow(Grid71.row);

end;

procedure TFNotaSaida.EdDtemissao71Validate(Sender: TObject);
begin
   if not FGeral.ValidaDataFiscal(EdDtemissao71) then
     EdDtemissao71.Invalid('');

end;

procedure TFNotaSaida.EdValordoc71ExitEdit(Sender: TObject);
///////////////////////////////////////////////////////////////
  procedure Editstogrid71;
  //////////////////////////////////
  var l:integer;
  begin
    l:=FGeral.ProcuraGrid(Grid71.getcolumn('mfis_numerodcto'),EdDocumento71.Text,Grid71);
    if l<=0 then begin
      if (Grid71.RowCount=2) and (Trim(Grid71.Cells[Grid71.getcolumn('mfis_numerodcto'),1])='') then begin
         l:=1;
      end else begin
         Grid71.RowCount:=Grid71.RowCount+1;
         l:=Grid71.RowCount-1;
      end;
    end;
    Grid71.Cells[Grid71.GetColumn('mfis_codentidade'),l]:=EdCodentidade71.Text;
    Grid71.Cells[Grid71.GetColumn('mfis_dtemissao'),l]:=EdDtemissao71.Text;
    Grid71.Cells[Grid71.GetColumn('mfis_modelo'),l]:=EdModelo71.Text;
    Grid71.Cells[Grid71.GetColumn('mfis_serie'),l]:=EdSerie71.Text;
    Grid71.Cells[Grid71.GetColumn('mfis_numerodcto'),l]:=EdDocumento71.Text;
    Grid71.Cells[Grid71.GetColumn('mfis_totaldcto'),l]:=EdValordoc71.Text;
    Grid71.Cells[Grid71.GetColumn('mfis_ufentidade'),l]:=EdUfEntidade71.Text;
    Grid71.Cells[Grid71.GetColumn('mfis_natf_codigo'),l]:=EdMfis_natf_codigo.Text;
  end;

  procedure LimpaCampos;
  begin
    EdCodentidade71.clear;
    EdDocumento71.clear;
    EdValordoc71.clear;
    EdMfis_natf_codigo.clear;
  end;

begin
  Editstogrid71;
  Limpacampos;
  EdCodEntidade71.setfocus;
end;

// 26.02.12
procedure TFNotaSaida.Grava71(xtransacao:string);
////////////////////////////////////////////////////////
var px:integer;
begin
  if ACbrNFe1.NotasFiscais.Count>0 then begin
    for px:=0 to ACbrNFe1.NotasFiscais.Count-1 do begin
       if Acbrnfe1.NotasFiscais.Items[px].NFe.procNFe.chNFe<>'' then begin
          Sistema.Insert('MOVESTO');
          Sistema.SetField('MOES_TRANSACAO',Transacao);
          Sistema.SetField('MOES_OPERACAO',FGeral.getOperacao);
          Sistema.SetField('MOES_STATUS','M');
          Sistema.SetField('MOES_TIPOCAD','F');
          Sistema.SetField('MOES_ESTADO',Acbrnfe1.NotasFiscais.Items[px].NFe.Dest.EnderDest.UF);
          Sistema.SetField('MOES_DATALCTO',Sistema.Hoje);
          Sistema.SetField('MOES_DATAEMISSAO',Acbrnfe1.NotasFiscais.Items[px].NFe.Ide.dEmi );
          Sistema.SetField('MOES_DATAMVTO',EdDtMovimento.AsDate);
          Sistema.SetField('MOES_NATF_CODIGO',Acbrnfe1.NotasFiscais.Items[px].NFe.Det.Items[0].Prod.CFOP);
          Sistema.SetField('MOES_UNID_CODIGO',EdUnid_Codigo.Text);
          Sistema.SetField('MoeS_ESPECIE','NFE');
          Sistema.SetField('MOES_SERIE',inttostr(Acbrnfe1.NotasFiscais.Items[px].NFe.Ide.serie));
          Sistema.SetField('MOES_NUMERODOC',Acbrnfe1.NotasFiscais.Items[px].NFe.Ide.nNF);
          Sistema.SetField('MOES_VLRTOTAL',Acbrnfe1.NotasFiscais.Items[px].NFe.Total.ICMSTot.vNF );
          Sistema.SetField('MOES_CHAVENFE',Acbrnfe1.NotasFiscais.Items[px].NFe.procNFe.chNFe );
          Sistema.SetField('MOES_USUA_CODIGO',Global.usuario.codigo);
          Sistema.Post;
       end;
    end;
    Acbrnfe1.NotasFiscais.Clear;
  end else begin
    for px:=1 to Grid71.RowCount do begin
      if trim(Grid71.Cells[Grid71.getcolumn('mfis_codentidade'),px])<>'' then begin
        Sistema.Insert('MOVESTO');
        Sistema.SetField('MOES_TRANSACAO',Transacao);
        Sistema.SetField('MOES_OPERACAO',FGeral.getOperacao);
        Sistema.SetField('MOES_STATUS','M');
        Sistema.SetField('MOES_TIPOCAD','F');
        Sistema.SetField('MOES_TIPO_CODIGO',STRTOINT(Grid71.Cells[Grid71.getcolumn('mfis_codentidade'),px]));
        Sistema.SetField('MOES_ESTADO',Grid71.Cells[Grid71.getcolumn('mfis_ufentidade'),px]);
        Sistema.SetField('MOES_DATALCTO',Sistema.Hoje);
        Sistema.SetField('MOES_DATAEMISSAO',Texttodate( FGeral.Tirabarra(Grid71.Cells[Grid71.getcolumn('mfis_dtemissao'),px]) ) );
        Sistema.SetField('MOES_DATAMVTO',EdDtMovimento.AsDate);
//        Sistema.SetField('MOES_NATF_CODIGO',EdNatF_Codigo.Text);
// 08.12.16
        Sistema.SetField('MOES_NATF_CODIGO',Grid71.Cells[Grid71.getcolumn('mfis_natf_codigo'),px]);
//        Sistema.SetField('MFIS_AVPZ',EdMFis_AvPz.Text);
        Sistema.SetField('MOES_UNID_CODIGO',EdUnid_Codigo.Text);
        if (Grid71.Cells[ Grid71.getcolumn('mfis_MODELO'),px])='55' then
          Sistema.SetField('MoeS_ESPECIE','NFE')
        else
          Sistema.SetField('MOES_ESPECIE','NF');
        Sistema.SetField('MOES_SERIE',Grid71.Cells[Grid71.getcolumn('mfis_serie'),px]);
        Sistema.SetField('MOES_NUMERODOC',STRTOINT(Grid71.Cells[ Grid71.getcolumn('mfis_NUMERODCTO'),px]));
//        Sistema.SetField('MFIS_EMITDCTO',EdMfis_EmitDcto.Text);
        Sistema.SetField('MOES_VLRTOTAL',TextToValor(Grid71.Cells[ Grid71.getcolumn('mfis_TOTALDCTO'),px]) );
//        Sistema.SetField('MFIS_MODELO',Grid.Cells[ Grid.getcolumn('mfis_MODELO'),p]);
         Sistema.SetField('MOES_USUA_CODIGO',Global.usuario.codigo);
        Sistema.Post;
      end;
    end;
  end;
end;

procedure TFNotaSaida.EdCodentidade71Validate(Sender: TObject);
begin
  EdUfentidade71.text:=EdCodentidade71.resultfind.fieldbyname('forn_uf').asstring;
end;

procedure TFNotaSaida.bbaixaClick(Sender: TObject);
begin
  if not Sistema.Processando then FBaixaPendencia.Execute;

end;

////////////// 16.11.12 - Novicarnes - Isonel
procedure TFNotaSaida.EdMoes_cola_codigoExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////////////////
begin
  if OP='G' then begin
    PVeiculo.Visible:=false;
    PVeiculo.enabled:=false;
    EdFpgt_codigo.Valid;
    bgravarclick(FNotasaida);
  end else if OP='H' then begin
    EdFpgt_codigo.Valid;
    bgravarclick(FNotasaida);
  end;
end;

procedure TFNotaSaida.EdCida_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
   FGeral.Limpaedit(EdCida_codigo,key);
end;

// 06.06.13
procedure TFNotaSaida.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
/////////////////////////////////////////////////////////////////////////////////////////
begin
//  if key = VK_F1 then FGeral.ExecutaHelp('FaturamentoSaida');
end;

procedure TFNotaSaida.bajudaClick(Sender: TObject);
begin
// 10.06.13
 FGeral.ExecutaHelp('FaturamentoSaida');

end;
// 09.11.13
procedure TFNotaSaida.bmensagemClick(Sender: TObject);
////////////////////////////////////////////////////////////
begin
  if not Pmensagem.Visible then begin
    PMensagem.Top:=33;
    PMensagem.Left:=3;
    Pmensagem.Visible:=true;
    if EdMens1.IsEmpty then EdMens1.Text:=copy(EdMensagem.text,1,Edmens1.MaxLength);
    if EdMens2.IsEmpty then EdMens2.Text:=copy(EdMensagem.text,Edmens1.MaxLength+1,Edmens2.MaxLength);
    if EdMens3.IsEmpty then EdMens3.Text:=copy(EdMensagem.text,Edmens1.MaxLength+Edmens2.MaxLength+1,Edmens3.MaxLength);
    if EdMens4.IsEmpty then EdMens4.Text:=copy(EdMensagem.text,Edmens1.MaxLength+Edmens2.MaxLength+Edmens3.MaxLength+1,Edmens4.MaxLength);
    if EdMens5.IsEmpty then EdMens5.Text:=copy(EdMensagem.text,Edmens1.MaxLength+Edmens2.MaxLength+Edmens3.MaxLength+Edmens4.MaxLength+1,Edmens5.MaxLength);
    if EdMens6.IsEmpty then EdMens6.Text:=copy(EdMensagem.text,Edmens1.MaxLength+Edmens2.MaxLength+Edmens3.MaxLength+Edmens4.MaxLength+Edmens5.MaxLength+1,Edmens6.MaxLength);
    if EdMens7.IsEmpty then EdMens7.Text:=copy(EdMensagem.text,Edmens1.MaxLength+Edmens2.MaxLength+Edmens3.MaxLength+Edmens4.MaxLength+Edmens5.MaxLength+Edmens6.MaxLength+1,Edmens7.MaxLength);
    Edmens1.SetFocus;
  end else begin
    Pmensagem.Visible:=false;
    Edmensagem.SetFocus;
  end;
end;

procedure TFNotaSaida.EdMens4ExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////
begin
  PMensagem.Visible:=false;
//  EdMensagem.Text:=EdMens1.text+EdMens2.text+EdMens3.text+EdMens4.text;
// 13.08.14 - Metalforte - Mari - mensagem 'monstro' pegou o erro ?
  EdMensagem.Text:=EdMens1.text+EdMens2.text+EdMens3.text+EdMens4.text+EdMens5.text+EdMens6.text+EdMens7.text;
  Edmensagem.SetFocus;
end;

// 06.02.17
procedure TFNotaSaida.EdMensagemValidate(Sender: TObject);
////////////////////////////////////////////////////////////
var xchaveref:string;
begin
 // 06.02.17
   if EdComv_codigo.ResultFind<>nil then begin
     if (Edchavenfeacom.IsEmpty) and (EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString=Global.CodDevolucaoCompra)
        and (OP='A') then begin
       Input('chave da NFe a ser devolvida','Chave',xchaveref,44,false);
       EdChavenfeacom.text:=xchaveref;
     end;
   end;

end;

procedure TFNotaSaida.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//////////////////////////////////////////////////////////////////////////////////
begin
//  if key=#112 then begin
  if EdCodequi.IsEmpty then exit;
  if (key=vk_f11) and ( trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),Grid.row])<>'' ) and (Global.Topicos[1367]) then begin
    EdManutencao.Visible:=true;
    EdManutencao.Enabled:=true;
    EdManutencao.Clear;
    EdManutencao.ShowForm:='FEquipamentos';
    EdManutencao.setfocus;
    EdManutencao.Valid;
  end;

end;

procedure TFNotaSaida.EdCodEquiChange(Sender: TObject);
/////////////////////////////////////////////////////////////
var y:integer;
begin
  for y:=1 to Grid.RowCount do begin
    if ( trim(Grid.Cells[grid.GetColumn('move_esto_codigo'),y])<>'' )
//       and ( trim(Grid.Cells[grid.GetColumn('move_operacao'),y])='' )
       then
      Grid.Cells[grid.GetColumn('move_operacao'),y]:=strzero(0,12)+';'+EdCodEqui.text
  end;

end;

procedure TFNotaSaida.EdManutencaoKeyPress(Sender: TObject; var Key: Char);
//////////////////////////////////////////////////////////////////////////////////
begin
  if key=#13 then begin
    EdManutencao.Visible:=false;
    EdManutencao.Enabled:=false;
  end;

end;

procedure TFNotaSaida.EdManutencaoExitEdit(Sender: TObject);
/////////////////////////////////////////////////////////////////
begin
    EdManutencao.Visible:=false;
    EdManutencao.Enabled:=false;
    if EdManutencao.TagStr='M' then
      Grid.Cells[grid.GetColumn('move_operacao'),grid.Row]:=EdManutencao.text+';'+EdCodEqui.text
    else
      Grid.Cells[grid.GetColumn('move_operacao'),grid.Row]:=strzero(0,12)+';'+Edmanutencao.text;
    Grid.SetFocus;

end;

procedure TFNotaSaida.bgeracteClick(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin

  if Global.Topicos[1039] then
    FExpCte.Execute( EdNumerodoc.AsInteger )
  else
    FExpCTe.Execute;


end;

// 03.09.14
procedure TFNotaSaida.EdRepr_codigoExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////////
begin
  if Ecf='S' then EdPort_codigo.SetFocus;
end;

procedure TFNotaSaida.Timer1Timer(Sender: TObject);
//////////////////////////////////////////////////////
begin
   if brelpendentes.Font.Color=clred then begin
     brelpendentes.Transparent:=true;
     brelpendentes.Font.Color:=clblack;
   end else begin
     brelpendentes.Transparent:=false;
     brelpendentes.Font.Color:=clred;
   end;
end;

// 16.03.15
procedure TFNotaSaida.GetListaNfe(TLista: TStringList; xES: string);
/////////////////////////////////////////////////////////////////////////////////////////
var Q:Tsqlquery;
    sqlconfmov,tiposnao,tiposdemovimento,sqlexp,sqles:string;
    Di,Df:TDatetime;

begin

  if xEs='S' then
    sqlexp:=' and extract( year from moes_dtnfeauto ) >= '+Strzero(Datetoano(Sistema.hoje,true)-1,4)
  else
//    sqlexp:=' and moes_chavenfe is not null';
    sqlexp:=' and moes_especie=''NFE''';
//  Di:=Sistema.Hoje-460;
  Di:=Sistema.Hoje-60;
// 24.08.16
  if FGeral.GetConfig1AsInteger('Diasdevolucao') > 0 then
    Di:=Sistema.Hoje-FGeral.GetConfig1AsInteger('Diasdevolucao');
  Df:=Sistema.Hoje;
  sqlconfmov:='';
  if FGeral.ConfiguradoECF then
    sqlconfmov:=' and moes_comv_codigo <> '+inttostr(FGeral.GetConfig1AsInteger('ConfMovECF'));
  if xEs='S' then
    sqles:=' and '+FGeral.GetIN('moes_tipomov',Global.TiposSaida,'C')
  else
    sqles:=' and '+FGeral.GetIN('moes_tipomov',Global.TiposEntrada,'C');
  tiposnao:=Global.TiposNaoFiscal+';'+Global.CodPrestacaoServicos+';'+Global.CodVendaInterna;
  tiposdemovimento:=Global.TiposSaida;
  Q:=sqltoquery('select * from movesto'+
                ' where moes_datamvto>='+Datetosql(Di)+
                ' and '+FGeral.getin('moes_status','N;E;D','C')+
                ' and moes_datamvto<='+Datetosql(Df)+
                ' and moes_unid_codigo='+EdUnid_codigo.assql+
                 sqlconfmov+
                ' and '+FGeral.GetSqlDataNula('moes_datacont')+
///////////////////////                ' and '+FGeral.Getin('moes_tipomov',tiposdemovimento,'C')+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                sqlexp+sqles+
                ' order by moes_dataemissao desc' );
  if not Q.eof then
    TLista.Add('Transa��o     | Emiss�o   | Numero |       Valor       | Raz�o Social'+space(25) );
  while not Q.eof do begin
    TLista.Add(strspace(Q.fieldbyname('moes_transacao').asstring,12)+' | '+
               FGeral.FormataData( Q.fieldbyname('moes_dataemissao').asdatetime )+' | '+
               strzero( Q.fieldbyname('moes_numerodoc').asinteger ,6)+' | '+
                FGeral.Formatavalor(Q.fieldbyname('moes_vlrtotal').ascurrency,f_cr)+' | '+
//               Q.fieldbyname('moes_chavenfe').asstring+' | '+
               FGeral.GetNomeRazaoSocialEntidade( Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asstring,'R') );
    Q.Next;
  end;
  FGeral.FechaQuery(Q);
end;

////////////////////////////////////////////
procedure TFNotaSaida.bafaturarClick(Sender: TObject);
//////////////////////////////////////////////////////////
begin
 if not sistema.processando then  FValoraFAturar.Execute;

end;

procedure TFNotaSaida.EdFpgt_codigoExitEditSGr(Sender: TObject);
begin

end;

// 22.03.16
// 12.06.17
procedure TFNotaSaida.EdvlrissExitEdit(Sender: TObject);
////////////////////////////////////////////////////////
begin
  PRetencoes.Enabled:=false;
  PRetencoes.Visible:=false;
  EdPeracre.SetFocus;
end;

procedure TFNotaSaida.EdvlroutrasdespesasValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
begin
  if Edvlroutrasdespesas.AsCurrency>0 then
    SetaEditsvalores;
end;

// 27.07.16
procedure TFNotaSaida.bvendidosClick(Sender: TObject);
///////////////////////////////////////////////////////////
begin
  if not Sistema.Processando then    FRelGerenciais_Vendas(EdCliente.AsInteger);

end;

procedure TFNotaSaida.EdCodentidade71KeyPress(Sender: TObject;
  var Key: Char);
begin

  if key=#27 then
    bcancelaritemclick(FNotaSaida);

end;

// 08.12.16
procedure TFNotaSaida.EdDtMovimentoExitEdit(Sender: TObject);
///////////////////////////////////////////////////////////////
begin
// 08.12.16
  if ( pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodConhecimentoSaida)=0 ) then
    bIncluiritemClick(self);

end;

end.


{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
unit Pedvenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr, Sqlsis, PcnLeitor, pcnconversao, xmldom,
  XMLIntf, msxmldom, XMLDoc;

type
  TFPedVenda = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    bCancelar: TSQLBtn;
    bIncluiritem: TSQLBtn;
    bExcluiritem: TSQLBtn;
    bCancelaritem: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PRemessa: TSQLPanelGrid;
    Edunid_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    Edcliente: TSQLEd;
    SetEdCLIE_NOME: TSQLEd;
    EdDtemissao: TSQLEd;
    EdTotalRemessa: TSQLEd;
    EdNumeroDoc: TSQLEd;
    EdMoes_tabp_codigo: TSQLEd;
    SetEdTABP_ALIQUOTA: TSQLEd;
    PFinal: TSQLPanelGrid;
    EdFpgt_codigo: TSQLEd;
    SQLEd1: TSQLEd;
    EdPedidocliente: TSQLEd;
    PParcelas: TSQLPanelGrid;
    GridParcelas: TSqlDtGrid;
    EdVencimento: TSQLEd;
    EdParcela: TSQLEd;
    EdRepr_codigo: TSQLEd;
    SQLEd3: TSQLEd;
    bocorrencia: TSQLBtn;
    Edformapedido: TSQLEd;
    EdDtMovimento: TSQLEd;
    EdTotalprodutos: TSQLEd;
    Edtotalqtde: TSQLEd;
    bimp: TSQLBtn;
    EdContato: TSQLEd;
    bcancpedido: TSQLBtn;
    EdClie_fone: TSQLEd;
    balterar: TSQLBtn;
    EdFormaenvio: TSQLEd;
    Eddatacliente: TSQLEd;
    bexclusao: TSQLBtn;
    EdCaoc_codigo: TSQLEd;
    EdTipoPed: TSQLEd;
    EdTipoped2: TSQLEd;
    brecalcula: TSQLBtn;
    PUltimoPro: TSQLPanelGrid;
    EdProduto2: TSQLEd;
    SetEdESTO_DESCRICAO2: TSQLEd;
    EdQtde2: TSQLEd;
    EdUnitario2: TSQLEd;
    EdPerdesconto2: TSQLEd;
    EdCodtamanho2: TSQLEd;
    Setedtamanho2: TSQLEd;
    Edcodcor2: TSQLEd;
    Setedcor2: TSQLEd;
    EdClie_endres: TSQLEd;
    EdClie_bairrores: TSQLEd;
    EdMuniRes_Nome: TSQLEd;
    EdClie_cepres: TSQLEd;
    Eddigitado: TSQLEd;
    PIns: TSQLPanelGrid;
    EdProduto: TSQLEd;
    SetEdESTO_DESCRICAO: TSQLEd;
    EdQtde: TSQLEd;
    EdUnitario: TSQLEd;
    EdPerdesconto: TSQLEd;
    EdCodtamanho: TSQLEd;
    Setedtamanho: TSQLEd;
    Edcodcor: TSQLEd;
    Setedcor: TSQLEd;
    EdCodcopa: TSQLEd;
    SetEdcopa_descricao: TSQLEd;
    EdPacotes: TSQLEd;
    EdFardos: TSQLEd;
    EdCubagem: TSQLEd;
    EdTotalCubagem: TSQLEd;
    EdDescubagem: TSQLEd;
    Edobspedido: TSQLEd;
    bpedidosemvalor: TSQLBtn;
    bgerarequisicao: TSQLBtn;
    EdPort_codigo: TSQLEd;
    EdPort_descricao: TSQLEd;
    EdPecas: TSQLEd;
    bposicaopedido: TSQLBtn;
    Pbotoesgrid: TSQLPanelGrid;
    bLoadGrid: TSQLBtn;
    bSaveGrid: TSQLBtn;
    bMoveLeft: TSQLBtn;
    bMoveRight: TSQLBtn;
    balteracliente: TSQLBtn;
    Edclientenovo: TSQLEd;
    bf11: TSQLBtn;
    OpenDialog1: TOpenDialog;
    Xml: TXMLDocument;
    sbimportacem: TSpeedButton;
    pocorrencias: TPanel;
    Texto: TMemo;
    bnfsaida: TSQLBtn;
    POrdemOS: TSQLPanelGrid;
    EdTipoaparelho: TSQLEd;
    Edidentificacao: TSQLEd;
    EdMarca: TSQLEd;
    Eddescricao: TSQLEd;
    Eddtentrada: TSQLEd;
    EdDtconserto: TSQLEd;
    Eddtsaida: TSQLEd;
    Edcodocorrencia: TSQLEd;
    SQLEd2: TSQLEd;
    Edacessorios: TSQLEd;
    Eddescricaoservico: TSQLEd;
    Edvlrcomissao: TSQLEd;
    Edpercomissao: TSQLEd;
    bultimos: TSQLBtn;
    bmedicoes: TSQLBtn;
    procedure FormActivate(Sender: TObject);
    procedure EdclienteValidate(Sender: TObject);
    procedure EdMoes_tabp_codigoValidate(Sender: TObject);
    procedure EdProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure EdProdutoValidate(Sender: TObject);
    procedure EdPerdescontoValidate(Sender: TObject);
    procedure bCancelaritemClick(Sender: TObject);
    procedure EdPerdescontoExitEdit(Sender: TObject);
    procedure EdFormaenvioValidate(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure bSairClick(Sender: TObject);
    procedure bIncluiritemClick(Sender: TObject);
    procedure bExcluiritemClick(Sender: TObject);
    procedure EdNumeroDocValidate(Sender: TObject);
    procedure EdFpgt_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdFpgt_codigoValidate(Sender: TObject);
    procedure EdVencimentoExitEdit(Sender: TObject);
    procedure EdParcelaExitEdit(Sender: TObject);
    procedure bocorrenciaClick(Sender: TObject);
    procedure bimpClick(Sender: TObject);
    procedure bcancpedidoClick(Sender: TObject);
    procedure EdCodtamanhoValidate(Sender: TObject);
    procedure balterarClick(Sender: TObject);
    procedure EdFormaenvioExitEdit(Sender: TObject);
    procedure EdContatoExitEdit(Sender: TObject);
    procedure EdTipoPedValidate(Sender: TObject);
    procedure bexclusaoClick(Sender: TObject);
    procedure EdCaoc_codigoValidate(Sender: TObject);
    procedure EdTipoped2Validate(Sender: TObject);
    procedure brecalculaClick(Sender: TObject);
    procedure EdCodcopaValidate(Sender: TObject);
    procedure EdQtdeValidate(Sender: TObject);
    procedure EdDescubagemValidate(Sender: TObject);
    procedure bpedidosemvalorClick(Sender: TObject);
    procedure bgerarequisicaoClick(Sender: TObject);
    procedure GridParcelasDblClick(Sender: TObject);
    procedure GridParcelasKeyPress(Sender: TObject; var Key: Char);
    procedure EdProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bposicaopedidoClick(Sender: TObject);
    procedure bMoveLeftClick(Sender: TObject);
    procedure bMoveRightClick(Sender: TObject);
    procedure bLoadGridClick(Sender: TObject);
    procedure bSaveGridClick(Sender: TObject);
    procedure EdCubagemValidate(Sender: TObject);
    procedure EdcodcorValidate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure balteraclienteClick(Sender: TObject);
    procedure EdclientenovoValidate(Sender: TObject);
    procedure EdclientenovoKeyPress(Sender: TObject; var Key: Char);
    procedure bf11Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdPort_codigoExitEdit(Sender: TObject);
    procedure EdUnitarioValidate(Sender: TObject);
    procedure sbimportacemClick(Sender: TObject);
    procedure bnfsaidaClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure EddescricaoservicoValidate(Sender: TObject);
    procedure bultimosClick(Sender: TObject);
    procedure bmedicoesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AtivaEdits;
    procedure DesativaEdits;
    procedure CalculaTotal;
    procedure EditstoGrid;
//    function ProcuraGrid(Coluna: integer; Pesquisa: string):integer;
    function ProcuraGrid(Coluna: integer;  Pesquisa: string ; Colunatam:integer=0 ; tam:integer=0 ; colunacor:integer=0 ; cor:integer=0 ;
                         colunacopa:integer=0 ; copa:integer=0 ): integer;
    procedure GravaItemConsignacao;
    procedure GravaMestrePedVendas(Emissao: TDatetime; Cliente:TSqlEd ;
              Unidade, TipoMovimento, Transacao : string ; Numero: Integer ; Valortotal:currency ; Tabela:Integer ; OP:string='I');
    procedure GravaItensPedVendas(Emissao: TDatetime; Cliente:TSqlEd ;
              Unidade, TipoMovimento,Transacao : string ; Numero: Integer ; Grid: TSqlDtGrid);
    procedure LimpaEditsItens;
    procedure Campostoedits(Q:TSqlquery);
    procedure Campostogrid(Q:TSqlquery);
    function PedidoFaturado(Numerodoc:integer):boolean;
    procedure Ativabotoes;
    procedure Desativabotoes;
    function Servico(produto:string):boolean;
    procedure SetaPedidosemAberto(Ed:TSqled);
    function CalculaPrecoVenda(valor:currency):currency;
    procedure  AtivaEditsParcelas;
    procedure ConfiguraEdits(xop:boolean);
// 26.02.15
    procedure  LeXmlObra( xarq:string );
// 02.12.16
    function EstaCodigosNaoVenda(produto:string):boolean;
// 21.02.20
    function ProdutoGenerico(codigo:string):boolean;
// 26.01.21
    procedure GetListaPedidos(  TLista:TStringList ; xES:string );

  end;

const xCodProdutoGeral:string =  'PROD' ;

var
  FPedVenda: TFPedVenda;
  OP,Tipomov,Transacao,sitbaixado,obsliberacao,Opbotao,somestre,codbarrabalanca:string;
  codigobarra,temgrid,frigorifico:boolean;
  vendabru,valorparteavista:currency;
  QEstoque,QBusca,QGrade:TSqlquery;
  Seq,usuariolib,xNUmeroPedido,NotaGerada:integer;
  cubagem:extended;
  campoportador,campopecas,campoclifpgt,
  campounidadesmvto,
  campocontatos,
  campocomissao        :TDicionario;
  FiltraF12:boolean;
  Leitorxml:TLeitor;
  Tempo:integer = 10;
  restricao1,restricao2,restricao3,restricao4:boolean;

// 22.07.13 - ve se precisa criar tipo de movimento especifico
const TipomovOS:string='OS';

procedure PedidoVenda_Execute(Opx:string ; Pedido:integer=0 ; xCliente:integer=0 );
////////////////////////////////////////////////////////////////////////////////

implementation


uses geral, Arquiv, tabela, Sittribu, Estoque, Sqlfun, conpagto,
  cadcor, tamanhos, Ocorrenc, impressao, Usuarios, cadocor, cadcopa, munic,
  codigosfis, portador, consulta, Pospedi , DB, nfsaida, cadcli,
  calibracoes;


{$R *.dfm}


//////////////////////////////////////////////////////////////////////
procedure PedidoVenda_Execute (Opx:string; Pedido:integer=0 ; xCliente:integer=0 );
///////////////////////////////////////////////////////////////////
begin

//  FPedVenda.timer.Enabled:=false;

// 26.02.15
//  FPedVenda.sbimportacem.visible:=(Global.topicos[1040]);
  FPedVenda.sbimportacem.enabled:=(Global.topicos[1040]);
// 08.12.13
  global.UltimoFormAberto:=FPedVenda.Name;
  Op:=Opx;
  OPbotao:='X';
// 29.10.09
  xNUmeroPedido:=pedido;
  NotaGerada:=0;
  campoportador:=Sistema.GetDicionario('movped','mped_port_codigo');
  campopecas:=Sistema.GetDicionario('movpeddet','mpdd_pecas');
// 17.11.11
  campoclifpgt:=Sistema.GetDicionario('clientes','clie_fpgt_codigo');
// 23.06.14 - vivan
  campounidadesmvto:=Sistema.GetDicionario('tabelapreco','tabp_unidadesmvto');
// 06.02.19 - Seip
  campocomissao:=Sistema.GetDicionario('movped','mped_vlrcomissao');
  if campocomissao.Tipo<>'' then begin

     FpedVenda.EdVlrcomissao.enabled:=true;
     FpedVenda.EdPercomissao.enabled:=true;

  end else begin

     FpedVenda.EdVlrcomissao.enabled:=false;
     FpedVenda.EdPercomissao.enabled:=false;

  end;
  if not Global.Topicos[1425] then begin

     FpedVenda.EdVlrcomissao.enabled:=false;
     FpedVenda.EdPercomissao.enabled:=false;

  end;

  if campounidadesmvto.Tipo<>'' then begin
//    FTabela.SetaItems(FPedVenda.EdMoes_tabp_codigo,Global.Usuario.UnidadesMvto );
    FTabela.SetaItems(FPedVenda.EdMoes_tabp_codigo,Global.CodigoUnidade );
    FpedVenda.EdMoes_tabp_codigo.ShowForm:='';
  end else
    FpedVenda.EdMoes_tabp_codigo.ShowForm:='FTabela';

// 15.08.14 - Devereda
  if trim (FGeral.GetConfig1AsString('Portaboletos'))<>'' then begin
    FPortadores.SetaItems(FPedVenda.EdPort_codigo,FGeral.GetConfig1AsString('Portaboletos') );
    FPedVenda.EdPort_codigo.ShowForm:='';
  end else begin
    FPedVenda.EdPort_codigo.ShowForm:='FPortadores';
  end;
//////////////
// 20.03.12
  frigorifico:=Global.Usuario.OutrosAcessos[0503];
  if Frigorifico then FPedVenda.ConfiguraEdits(false);
// 27.04.12
  FGeral.ConfiguraColorEditsNaoEnabled(FPedVenda);
// 16.06.2021 - Benato - pedido carne assada
  if Global.topicos[1426] then begin

     FPedVenda.EdCodCor.Title := 'Espeto';
     FPedVenda.Grid.Columns[4].Title.Caption := 'Espeto';

  end;

  FPedVenda.Show;
  if campoportador.tipo<>'' then
    FPedVenda.EdPort_codigo.enabled:=true
  else
    FPedVenda.EdPort_codigo.enabled:=false;
// 29.10.09
  if (xNUmeroPedido>0) and (op='A') then begin
      FPedVenda.EdNUmerodoc.SetValue(xNUmeroPedido);
      FPedVenda.EdNUmerodoc.Valid;
  end;
// 02.06.11 - criar topico do sistema
  FiltraF12:=Global.Topicos[1407];
  FPedVenda.EdPecas.Enabled:=Global.Topicos[1302];
// 14.06.13
{
  if Global.Usuario.OutrosAcessos[0504] then begin
    FPedVenda.EdProduto.FindField:='esto_referencia';
    FPedVenda.EdProduto.Title:='Refer�ncia';
  end else begin
    FPedVenda.EdProduto.FindField:='esto_codigo';
    FPedVenda.EdProduto.Title:='C�digo';
  end;
  FPedVenda.EdProduto.Update;
}
  if Global.Topicos[1302] then
    FPedVenda.EdPecas.text:='1';
// 28.08.13
  if Global.Topicos[1410] then begin
    FPedVenda.EdPedidocliente.enabled:=false;
    FPedVenda.EdDatacliente.enabled:=false;
    FPedVenda.EdTipoPed.enabled:=false;
    FPedVenda.EdFormaPedido.enabled:=false;
    FPedVenda.EdContato.enabled:=false;
    FPedVenda.EdFormaenvio.enabled:=false;
    FPedVenda.EdFpgt_codigo.enabled:=false;
//    FPedVenda.EdPort_codigo.enabled:=false;
// 19.05.14 - vivan cobran�a - angela
    FPedVenda.EdPort_codigo.enabled:=true;
    FPedVenda.EdPerDesconto.enabled:=false;
  end;
// 03.09.14 - Benato
  if Global.Usuario.OutrosAcessos[0508] then
    FPedVenda.EdMoes_tabp_codigo.enabled:=false
  else
    FPedVenda.EdMoes_tabp_codigo.enabled:=true;
///////////////
  somestre:='N';
  if FiltraF12 then
    FPedVenda.EdProduto.showform:='FConsulta'
  else
    FPedVenda.EdProduto.showform:='FEstoque';
///////////////////////////////////////////////////////
// vindos do activate
  FPedVenda.bCancelar.Enabled:=Op='A';
//  bDevolucao.Enabled:=OP='D';
  FPedVenda.bCancelaritem.Enabled:=true;
  FPedVenda.Edcliente.enabled:=true;  // 09.04.10
  if not Arq.TEstoque.Active then Arq.TEstoque.Open;
  if pos(OP,'A/D')>0 then begin
    FPedVenda.DesativaEdits;
    FPedVenda.EdNumerodoc.Enabled:=true;
    FPedVenda.SetaPedidosemAberto(FPedVenda.EdNumerodoc);
//    FPedVenda.EdMoes_tabp_codigo.Enabled:=true;
    if OP='D' then
      FPedVenda.bCancelaritem.Enabled:=false;
  end else begin
    FPedVenda.AtivaEdits;
    if OP='I' then
      FPedVenda.Ativabotoes;
    FPedVenda.EdNumerodoc.Enabled:=false;
  end;
  if OP='D' then begin
    FPedVenda.bIncluiritem.Enabled:=false;
    FPedVenda.bExcluiritem.Enabled:=false;
    FPedVenda.bCancelar.Enabled:=false;
    FPedVenda.bGravar.Enabled:=false;
  end else begin
    FPedVenda.bIncluiritem.Enabled:=true;
    FPedVenda.bExcluiritem.Enabled:=true;
    FPedVenda.bCancelar.Enabled:=true;
    FPedVenda.bGravar.Enabled:=true;
  end;
  if not Arq.TTabelaPreco.Active then Arq.TTabelaPreco.Open;
// para nao limpar quando vem da consulta geral de pedidos
  if Pedido=0 then begin
    FPedVenda.EdCliente.ClearAll(FPedVenda,99);
    FPedVenda.Grid.clear;
// 15.08.14
    if Global.Topicos[1416]  then FpedVenda.EdTipoped.text:='OS' else FpedVenda.EdTipoped.text:='PV';
  end;
  if Op='I' then begin
    if trim(FPedVenda.EdDtemissao.Text)='' then
//       EdDtemissao.SetDate(Date);
// 06.08.10
       FPedVenda.EdDtemissao.SetDate(Sistema.Hoje);
    if trim(FPedVenda.EdDatacliente.Text)='' then
//      FPedVenda.EdDatacliente.setdate(Date);
// 06.08.10 - Granzotto - pra ver o caso do 2o. pedido vir com 'data atual+1'
      FPedVenda.EdDatacliente.setdate(Sistema.Hoje);
// 06.07.16
    if trim(FPedVenda.EdDtmovimento.Text)='' then
      FPedVenda.EdDtmovimento.setdate(Sistema.Hoje);
    FPedVenda.EdCliente.SetFocus;
    FPedVenda.EdNumerodoc.Setvalue(0);
  end else
    FPedVenda.EdNumerodoc.SetFocus;
  FPedVenda.EdUNid_codigo.text:=Global.CodigoUnidade;
  FPedVenda.EdUnid_codigo.validfind;

//////////////////////////////////////////////////////
// 03.02.14
   FPedVenda.Edclientenovo.Enabled:=false;
   FPedVenda.Edclientenovo.Visible:=false;
// 04.04.14 - Metalforte
   if ( Global.Usuario.OutrosAcessos[0506] ) then begin
      FPedVenda.EdCubagem.Title:='Un./Metro';
   end else begin
      FPedVenda.EdCubagem.Title:='Cubagem';
   end;
///////
// 17.07.14 - Metalorte
  FPedVenda.EdDtemissao.Enabled:=(global.Usuario.OutrosAcessos[0507]=true);
  if OPx='I' then
    FPedVenda.EdCliente.setfocus
  else
    FPedVenda.EdNumeroDoc.setfocus;
// 03.07.18
  FPedVenda.POrdemOs.Visible:=false;
  if Global.Topicos[1421] then begin
       FPedVenda.POrdemOs.Visible:=true;
  end;

// 26.10.18 - Agrogeffer;
  FPedVenda.EdRepr_codigo.enabled:=Global.Topicos[1422];
// 01.11.18 - Giacomoni
  if xCliente>0 then begin
     FPedVenda.Edcliente.Text:=inttostr(xcliente);
     FPedVenda.Edcliente.Next;
  end;

// 26.01.2021
  FPedVenda.bultimos.enabled := false;

end;


procedure TFPedVenda.EdNumeroDocValidate(Sender: TObject);
//////////////////////////////////////////////////////////////
var usuariocan:integer;
    obs:string;
    datamvto:TDatetime;
begin

  if EdNumerodoc.AsInteger>0 then begin

     Sistema.Beginprocess('Pesquisando pedido');
     somestre:='N';
     QBusca:=sqltoquery(FGeral.buscapedvenda(EdNumerodoc.AsInteger));
// 24.11.13
     if QBusca.eof then begin
        QBusca.close;
        QBusca.Free;
        QBusca:=sqltoquery( FGeral.buscapedvenda(EdNumerodoc.AsInteger,'','','S') );
        somestre:='S';
     end;
     if QBusca.eof then begin
       EdNUmerodoc.INvalid('Numero de pedido n�o encontrado');
       EdNumerodoc.ClearAll(FPedVenda,99);
       Sistema.endprocess('');
       Grid.Clear;
     end else begin
       usuariocan:=QBusca.fieldbyname('mped_usua_cancela').asinteger;
       if QBusca.fieldbyname('mped_status').asstring='X' then begin
         datamvto:=QBusca.fieldbyname('mped_datamvto').asdatetime;   // 01.08.06
         Campostoedits(Qbusca);
         if somestre<>'S' then
           Campostogrid(Qbusca);
         obs:=FOcorrencias.GetObservacao('C',EdCliente.asinteger,EdNumerodoc.asinteger);
         EdCliente.Valid;
         CalculaTotal;
         showmessage('Cancelado por '+FUsuarios.GetNome(usuariocan)+#13+
//                     'Obs:'+obs+#13+
                     'Motivo:'+FCAdOcorrencias.GetDescricao(FOcorrencias.GetCodigoOcorrencia('C',EdCliente.asinteger,EdNumerodoc.asinteger,
                               datamvto)) );
         EdNUmerodoc.INvalid('');
         EdNumerodoc.ClearAll(FPedVenda,99);
         Grid.Clear;                                          // 'E' - 10.08.09
       end else if QBusca.fieldbyname('mped_situacao').asstring=sitbaixado then begin
         Campostoedits(Qbusca);
         if somestre<>'S' then
           Campostogrid(Qbusca);
         EdNUmerodoc.INvalid('Pedido j� baixado');
         desativabotoes;
         EdCliente.Valid;
         CalculaTotal;
  //       TotalRemessa:=EdTotalremessa.AsCurrency;
         EdUnid_codigo.ValidFind;
//         EdFpgt_codigo.valid;
// 09.04.10
//         EdNumerodoc.ClearAll(FPedVenda,99);
//         Grid.Clear;
       end else begin
         if OP='A' then
//           Transacao:=QBusca.fieldbyname('mpdd_transacao').asstring;
           Transacao:=QBusca.fieldbyname('mped_transacao').asstring;
         notagerada:=QBusca.fieldbyname('mped_nfvenda').asinteger;
         Campostoedits(Qbusca);
         if somestre<>'S' then
           Campostogrid(Qbusca);
         ativabotoes;
         EdCliente.Valid;
         CalculaTotal;
// 03.02.14 - para poder alterar o cliente
         QBusca.First;
  //       TotalRemessa:=EdTotalremessa.AsCurrency;
         EdUnid_codigo.ValidFind;
// 09.04.10
//         EdFpgt_codigo.valid;
       end;
       Edcliente.enabled:=false;  // 25.04.06
       Sistema.endprocess('');
     end;
  end;

end;


procedure TFPedVenda.bCancelaritemClick(Sender: TObject);
begin
  if EdCliente.AsInteger=0 then exit;
  bGravar.Enabled:=true;
  bCancelar.Enabled:=true;
  bSair.Enabled:=true;
  PINs.Visible:=false;
  PINs.DisableEdits;
  AtivaEdits;
  PRemessa.Enabled:=true;
// 26.01.2021
  FPedVenda.bultimos.enabled := false;

  EdObsPedido.SetFocus;

end;


procedure TFPedVenda.EdPerdescontoValidate(Sender: TObject);
begin
  if EdPerdesconto.ascurrency>0 then
    EdUnitario.setvalue( EdUnitario.Ascurrency - FGeral.Arredonda(EdUnitario.Ascurrency*(EdPerdesconto.ascurrency/100),2) );

end;


procedure TFPedVenda.AtivaEdits;
begin
  PRemessa.Enabled:=true;
  if OP='I' then begin
    PRemessa.EnableEdits;
    EdNumerodoc.Enabled:=false;
  end else
    EdNumerodoc.Enabled:=true;

end;

procedure TFPedVenda.DesativaEdits;
begin
  PRemessa.DisableEdits;
  EdNumerodoc.Enabled:=true;

end;

procedure TFPedVenda.FormActivate(Sender: TObject);
begin
///////////////////////////////////////////
{
  bCancelar.Enabled:=Op='A';
//  bDevolucao.Enabled:=OP='D';
  bCancelaritem.Enabled:=true;
  Edcliente.enabled:=true;  // 09.04.10
  if not Arq.TEstoque.Active then Arq.TEstoque.Open;
  if pos(OP,'A/D')>0 then begin
    DesativaEdits;
    EdNumerodoc.Enabled:=true;
    SetaPedidosemAberto(EdNumerodoc);
    EdMoes_tabp_codigo.Enabled:=true;
    if OP='D' then
      bCancelaritem.Enabled:=false;
  end else begin
    AtivaEdits;
    if OP='I' then
      Ativabotoes;
    EdNumerodoc.Enabled:=false;
  end;
  if OP='D' then begin
    bIncluiritem.Enabled:=false;
    bExcluiritem.Enabled:=false;
    bCancelar.Enabled:=false;
    bGravar.Enabled:=false;
  end else begin
    bIncluiritem.Enabled:=true;
    bExcluiritem.Enabled:=true;
    bCancelar.Enabled:=true;
    bGravar.Enabled:=true;
  end;
  if not Arq.TTabelaPreco.Active then Arq.TTabelaPreco.Open;
  EdCliente.ClearAll(FPedVenda,99);
  Grid.clear;
  if Op='I' then begin
    if trim(EdDtemissao.Text)='' then
//       EdDtemissao.SetDate(Date);
// 06.08.10
       EdDtemissao.SetDate(Sistema.Hoje);
    if trim(EdDatacliente.Text)='' then
//      FPedVenda.EdDatacliente.setdate(Date);
// 06.08.10 - Granzotto - pra ver o caso do 2o. pedido vir com 'data atual+1'
      FPedVenda.EdDatacliente.setdate(Sistema.Hoje);
    EdCliente.SetFocus;
    EdNumerodoc.Setvalue(0);
  end else
    EdNumerodoc.SetFocus;
  EdUNid_codigo.text:=Global.CodigoUnidade;
  EdUnid_codigo.validfind;
  }
/////////////////////////////////////


end;

procedure TFPedVenda.EdclienteValidate(Sender: TObject);
//////////////////////////////////////////////////////////////
var unidades:string;
    QOco:TSqlquery;
begin
// 18.03.15 - Vivan
  if  not FGeral.ValidaCadastro(EdCliente.ResultFind.FieldByName('clie_situacao').AsString) then Edcliente.Invalid('');
// 01.04.16
  if ( Global.topicos[1229] )  and ( pos(EdCliente.ResultFind.FieldByName('clie_contribuinte').AsString,'1/2')=0 ) then
      EdCliente.invalid('Falta identificar se � 1-Simples  2-Icms Normal para c�lculo do pre�o de venda');

  restricao1:=true;
  restricao2:=true;
  restricao3:=true;
  restricao4:=true;
  usuariolib:=0;
  obsliberacao:='';
  unidades:=Global.Usuario.UnidadesMvto;
  if Global.Topicos[1255] then
    unidades:=Global.CodigoUnidade;

  if (EdCliente.resultfind<>nil) then begin
// 26.10.18
    if OP='I' then begin
      EdRepr_codigo.setvalue(EdCliente.resultfind.fieldbyname('clie_repr_codigo').asinteger);
      EdRepr_codigo.validfind;
    end;
    EdClie_fone.text:=FGeral.Formatatelefone(EdCliente.resultfind.fieldbyname('clie_foneres').asstring);
//////// - 03.08.06
    EdClie_endres.text:=EdCliente.resultfind.fieldbyname('clie_endres').asstring;
    EdClie_bairrores.text:=EdCliente.resultfind.fieldbyname('clie_bairrores').asstring;
    EdClie_cepres.text:=fGeral.formatacep(EdCliente.resultfind.fieldbyname('clie_cepres').asstring);
    EdMuniRes_Nome.text:=FCidades.GetNome(EdCliente.resultfind.fieldbyname('clie_cida_codigo_res').asinteger);
//////////
// 17.11.11
    EdFpgt_codigo.enabled:=true;
// 04.09.13
    if Global.Topicos[1410] then begin
      FPedVenda.EdFpgt_codigo.enabled:=false;
    end;                           // 06.02.19
    if ( campoclifpgt.Tipo<>'' ) and ( OP='I' ) then begin
       if trim( EdCliente.resultfind.fieldbyname('clie_fpgt_codigo').asstring ) <> '' then begin
         EdFpgt_codigo.text:=EdCliente.resultfind.fieldbyname('clie_fpgt_codigo').asstring;
         EdFpgt_codigo.validfind;
//         EdFpgt_codigo.enabled:=false;
// 09.08.12 - Jake + Isonel liberaram
// 07.07.14 - Novicarnes - Elize
       end else if Global.Topicos[1415] then begin
         EdCliente.Invalid('Ainda n�o definido a condi��o de pagamento neste cliente');
         exit
// 03.09.14 - Benato
       end else if not Global.Topicos[1415] then begin
         if EdFpgt_codigo.IsEmpty then EdFpgt_codigo.Text:=FGeral.GetConfig1AsString( 'Fpgtoavista' );
       end;
    end;
// 27.04.12 - tirado em 15.08.14
//    if OP='I' then Edtipoped.Text:=Global.CodPedVenda;
// 22.05.14 - para nao 'incomoda' outros....Zilmar
    if Global.Topicos[1413] then begin
// 19.05.14 - vivan cobran�a angela
      if (trim (EdCliente.ResultFind.fieldbyname('Clie_portadores').asstring)<>'') then begin
        FPortadores.SetaItems(FPedVenda.EdPort_codigo,EdCliente.ResultFind.fieldbyname('Clie_portadores').asstring );
        FPedVenda.EdPort_codigo.ShowForm:='';
// 26.09.19 - novicarnes - para agilizar e nao precisar dar enter...
        if copy( EdCliente.ResultFind.fieldbyname('Clie_portadores').asstring,4,1)='' then begin
           FPedVenda.EdPort_codigo.Text:=EdCliente.ResultFind.fieldbyname('Clie_portadores').asstring;
           FPedVenda.EdPort_codigo.validfind;
           FPedVenda.EdPort_codigo.enabled:=false;
        end else
           FPedVenda.EdPort_codigo.enabled:=true;

      end else begin;

        EdCliente.Invalid('Ainda n�o definido portador(es) neste cliente');
        exit

      end;
    end;
 // 01.11.18
    campocontatos:=Sistema.GetDicionario('clientes','clie_contato1');
    if (campocontatos.Tipo<>'') and ( OP='I' ) then begin
       EdContato.text:=EdCliente.resultfind.fieldbyname('clie_contato1').AsString;

    end else if OP='I' then

      EdContato.text:='';

// 20.01.20 - Mirvane
    campocontatos:=Sistema.GetDicionario('clientes','clie_tabp_codigo');
    if (campocontatos.Tipo<>'') and ( OP='I' ) then begin
       EdMoes_tabp_codigo.setvalue( FCadCli.GetTabelaAcresDesc(Edcliente.AsInteger) );

    end else if OP='I' then

      EdMoes_tabp_codigo.text:='';


//    if OP='I' then begin
// 13.08.10
//    if (OP='I') and (Global.Topicos[1406])  then begin
// 11.02.17 0 checar tbem na alteracao
    if (Global.Topicos[1406])  then begin
      restricao1:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','DUP',unidades );
      restricao2:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','BOL',unidades );
      restricao3:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','CHQ',unidades );
      restricao4:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','LIM',unidades );
      {
      restricao1:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','001' );
      restricao2:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','002' );
      restricao3:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','CHQ' );
      restricao4:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','LIM',unidades );
      }
// 13.07.06 - tania - por causa de cheques de terceiros de clientes...
//      if not restricao3 then begin
//            EdCliente.Invalid('');
//            exit;
//      end;
    end;
    if not restricao1 then begin //fixo portador duplicata
        if not FGEral.ValidaLiberacaoFinan(Global.usuario.codigo,'DUP') then begin
          EdCliente.Invalid('');
          exit;
        end;
        {
//      if not Confirma('Venda a vista') then
       usuariolib:=FUsuarios.GetSenhaAutorizacao(706);
        if usuariolib>0 then begin
          Input('Contato com representante','Observa��o',obsliberacao,150,true);
          if trim(obsliberacao)='' then begin
            EdCliente.Invalid('Preenchimento Obrigat�rio');
            exit;
          end;
        end else begin
          EdCliente.Invalid('');
          exit;
        end;
        }
    end else if not restricao2  then begin //fixo portador boleto
//      if not Confirma('Venda a vista') then
        if not FGEral.ValidaLiberacaoFinan(Global.usuario.codigo,'DUP') then begin
          EdCliente.Invalid('');
          exit;
        end;
       {
       usuariolib:=FUsuarios.GetSenhaAutorizacao(706);
        if usuariolib>0 then begin
          Input('Contato com representante','Observa��o',obsliberacao,100,true);
          if trim(obsliberacao)='' then begin
            EdCliente.Invalid('Preenchimento Obrigat�rio');
            exit;
          end;
        end else begin
          EdCliente.Invalid('');
          exit;
        end;
        }
    end else if not restricao3  then begin //cheques devolvidos

        if not FGEral.ValidaLiberacaoFinan(Global.usuario.codigo,'DUP') then begin
          EdCliente.Invalid('');
          exit;
        end;
        {
// 13.07.06 - tania
       usuariolib:=FUsuarios.GetSenhaAutorizacao(706);
       if usuariolib>0 then begin
          Input('Contato com representante','Observa��o',obsliberacao,100,true);
          if trim(obsliberacao)='' then begin
            EdCliente.Invalid('Preenchimento Obrigat�rio');
            exit;
          end;
          FGeral.Gravalog(12,'Pedido de venda Cliente '+EdCliente.text+' - '+SetEdCLIE_NOME.text+' Repr.'+EdRepr_codigo.text+' - '+SQLEd3.text,true,
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
// 20.05.16
    if Global.Usuario.OutrosAcessos[0511] then begin
      QOco:=sqltoquery('select * from ocorrencias where ocor_codentidade = '+EdCliente.assql+
                       ' and ocor_catentidade = ''C'''+
                       ' and ocor_status = ''N'''+
                       ' and ocor_unid_codigo  = '+EdUnid_codigo.assql );
      if not QOco.eof then POcorrencias.Visible:=true else POcorrencias.Visible:=false;
      Texto.Lines.clear;
      while not QOco.eof do begin
        Texto.Lines.Add(QOco.fieldbyname('ocor_descricao').asstring);
        QOco.Next;
      end;
      FGeral.FechaQuery(QOco);
    end;
  end;

end;

procedure TFPedVenda.EdMoes_tabp_codigoValidate(Sender: TObject);
///////////////////////////////////////////////////////////
begin
  if EdMoes_tabp_codigo.asinteger>0 then begin
    if Arq.TTabelaPreco.Locate('tabp_codigo',EdMoes_tabp_codigo.AsInteger,[]) then begin
      SetEdTabp_aliquota.Text:=FTabela.GetDescAliquota(EdMoes_tabp_codigo.asinteger);
      if campounidadesmvto.Tipo<>'' then begin
        if ( pos( Global.CodigoUnidade,Arq.TTabelaPreco.FieldByName('tabp_unidadesmvto').AsString ) = 0 )
           and
           ( trim(Arq.TTabelaPreco.FieldByName('tabp_unidadesmvto').AsString)<>'' )
          then begin
          EdMoes_tabp_codigo.Invalid('Tabela n�o permitida nesta unidade');
        end;
      end;
    end else begin
      SetEdTabp_aliquota.Text:='';
      EdMoes_tabp_codigo.Invalid('Tabela n�o encontrada');
    end;
  end else
    SetEdTabp_aliquota.Text:='';

end;

procedure TFPedVenda.EdProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#27 then
    bcancelaritemclick(FPedVenda);

end;

procedure TFPedVenda.EdProdutoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
var aliicms,unitario,tamanho,xmargem,precobalanca:currency;
    sittrib,codbarra,xproduto:string;


    Function RegradoGrupo(xprod:string):integer;
    ////////////////////////////////////////////
    begin
// ver criar campo 'formula ou regra' no cadastro de grupos e retornar este novo campo
      if FEstoque.GetGrupo(xprod)=1 then
        result:=1
      else
        result:=2;
    end;


begin

  codigobarra:=false;
  codbarrabalanca:='N';
/// 14.06.13
//  if (Global.Topicos[1206]) and ( not EdProduto.isempty ) then begin
//     EdProduto.text:=EdProduto.resultfind.fieldbyname('esto_codigo').asstring;


  if not FEstoque.ValidaCodigoProduto(EdProduto,EdProduto.text) then
    exit;
///////////
//  if FGeral.CodigoBarra(EdProduto.Text) then begin
// 31.03.14
  if  FGeral.CodigoBarra(EdProduto.Text,EdProduto) then begin
    QBusca:=sqltoquery('select * from estoque inner join grupos on ( grup_codigo=esto_grup_codigo ) where esto_Codbarra='+EdProduto.assql);
    codbarra:=EdProduto.text;   // 21.05.13
    if not QBusca.Eof then
      EdProduto.Text:=QBusca.fieldbyname('esto_codigo').AsString
    else begin
//      EdProduto.Invalid('Codigo de barra n�o encontrado');
//      exit;
    end;
    codigobarra:=true;
//    EdQtde.Enabled:=Global.Topicos[1372];
// 08.07.14 - Devereda
    EdQtde.Enabled:=(Global.topicos[1372]) or (bf11.tag=-1) ;
    EdQtde.SetValue(1);
    EdPerdesconto.enabled:=false;
    EdPerdesconto.setvalue(0);
    QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                       ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
//    if QEstoque.eof then begin
//       EdProduto.INvalid('Codigo n�o encontrado no estoque da unidade '+EdUnid_codigo.text);
//       exit;
//    end;
    if not FGeral.TemEstoque(EdProduto.Text,EdQtde.AsCurrency,EdUNid_codigo.Text,QEstoque) then begin
       EdProduto.INvalid('Quantidade em estoque insuficiente');
       exit;
    end;
    EdCodcor.enabled:=false;
    EdCodtamanho.enabled:=false;
    EdCodcopa.enabled:=false;
    EdCodcor.text:='';
    EdCodtamanho.text:='';
    EdCodcopa.text:='';
// 08.07.14
    bf11.Tag:=1;
//  21.05.13 - nao buscava no pedido pelo codigo de barras da garde
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
    end else begin
// 19.05.14
        if (Global.Topicos[1038]) then begin
          if EdCodcor.IsEmpty then begin
            EdProduto.Invalid('Codigo da cor n�o encontrado');
            EdCodcor.Enabled:=true;
            EdCodcor.Empty:=false;
            EdCodtamanho.Enabled:=true;
            EdCodtamanho.Empty:=false;
            exit;
          end;
          if EdCodtamanho.IsEmpty then begin
            EdProduto.Invalid('Codigo do tamanho n�o encontrado');
            EdCodtamanho.Enabled:=true;
            EdCodtamanho.Empty:=false;
            EdCodcor.Enabled:=true;
            EdCodcor.Empty:=false;
            exit;
          end;
        end;
    end;

/////////////////////
  end else if trim(edproduto.text)<>'' then begin
  ///////////////////////////////////////////////
    xproduto:=EdProduto.text;
// 12.08.14 - Benato
    if (Global.Topicos[1217]) and ( copy(xproduto,1,1)='2' ) and ( length(trim(xProduto))=13 ) then begin
// 28.08.14 - Benato - codigo de 'diversos'
      if copy(xproduto,2,4)='0000' then
        EdProduto.text:=FGeral.Getconfig1asstring('diversosbalanca')
      else
        EdProduto.text:=copy(xproduto,2,4);
      codbarrabalanca:='S';
      precobalanca:=Texttovalor( copy(xproduto,8,5) )/1000;
// preco balanca ser� o peso para agilizar passagem pelo caixa
    end;

    if Global.Usuario.OutrosAcessos[0504] then
      QBusca:=FEstoque.BuscaporReferenciaouCodigo(EdProduto.text)
    else
      QBusca:=sqltoquery('select * from estoque inner join grupos on ( grup_codigo=esto_grup_codigo )  where esto_Codigo='+EdProduto.Assql);
    if not QBusca.Eof then begin
      EdProduto.Text:=QBusca.fieldbyname('esto_codigo').AsString;
// 02.12.16 - Novicarnes - Isonel pegou
      if EstaCodigosNaoVenda(QBusca.fieldbyname('esto_codigo').AsString) then
        EdProduto.Invalid('Codigo n�o permitido usar em vendas');
    end else if  not ProdutoGenerico(EdProduto.Text) then begin

      EdProduto.Invalid('Codigo n�o encontrado');
      exit;

    end;

    QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                       ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
    if ( QEstoque.eof ) and ( not ProdutoGenerico( EdProduto.Text ) ) then begin

       EdProduto.INvalid('Codigo n�o encontrado no estoque da unidade '+EdUnid_codigo.text);
       exit;

    end;

    if not Arq.TEstoque.active then Arq.TEstoque.open;
    Arq.TEstoque.locate('esto_codigo',Edproduto.text,[]);
    EdQtde.Enabled:=true;
    EdPerdesconto.enabled:=true;
// 12.08.14 - Benato - deixa o edqtde ativo pra poder informar os kilos vendidos
    if codbarrabalanca='S' then begin

        EdQtde.Enabled:=false;
        EdQtde.SetValue( precobalanca );
        EdPerdesconto.enabled:=false;

    end else if not bultimos.visible then

      EdQtde.SetValue(0);


    if global.Topicos[1410] then EdPerdesconto.enabled:=false;
    EdPerdesconto.setvalue(0);
// 19.05.14
    if (Global.Topicos[1038]) then begin
            EdCodcor.Empty:=false;
            EdCodtamanho.Empty:=false;
    end;
  end;

// 23.08.05
  if ( QEstoque.eof ) and ( not ProdutoGenerico( EdProduto.Text ) ) then begin

      EdProduto.Invalid('Codigo ainda n�o cadastrado na unidade'+EdUnid_codigo.text);
      exit;

  end;

  if not ProdutoGenerico(EdProduto.Text) then begin

      if length( FSittributaria.GetCST(QEstoque.fieldbyname('esqt_sitt_codestado').asinteger) )<> 3 then begin
         EdProduto.Invalid('Situa��o tribut�ria no estado inv�lida');
         exit;
      end;
      if length( FSittributaria.GetCST(QEstoque.fieldbyname('esqt_sitt_forestado').asinteger) ) <> 3 then begin
         EdProduto.Invalid('Situa��o tribut�ria fora do estado inv�lida');
         exit;
      end;

  end;

  if not FGeral.ChecaMostruario(EdProduto.text,EdTipoPed.text,EdCliente.asinteger,EdNumerodoc.asinteger) then begin
    EdProduto.invalid('');
    exit;
  end;

// 06.07.18 - OS
  if (Global.Topicos[1421]) and (Servico(EdProduto.Text)) then begin

     Eddescricaoservico.enabled:=true;
     Eddescricaoservico.visible:=true;
     Eddescricaoservico.SetFocus;

// 21.02.20
  end else if ProdutoGenerico( EdProduto.Text ) then begin

     Eddescricaoservico.enabled:=true;
     Eddescricaoservico.visible:=true;
     Eddescricaoservico.SetFocus;

  end ;



  if not ProdutoGenerico( EdProduto.Text ) then begin

    SetEdEsto_descricao.text:=QBusca.fieldbyname('esto_descricao').asstring;
  // 23.01.06
    aliicms:=FEstoque.Getaliquotaicms(EdProduto.text,Edunid_codigo.text,EdCliente.resultfind.fieldbyname('clie_uf').asstring,EdCliente.asinteger,EdTipoPed.text) ;
    sittrib:=FEstoque.Getsituacaotributaria(EdProduto.text,Edunid_codigo.text,EdCliente.resultfind.fieldbyname('clie_uf').asstring,EdTipoPed.text);

  end else begin

    SetEdEsto_descricao.text:='';
    aliicms:=0;
    sittrib:='000';

  end;
//  EdUnitario.Setvalue(QEstoque.fieldbyname('esqt_vendavis').AsCurrency);
// 01.09.09
  if Global.Topicos[1403] then begin
    EdCodcor.Enabled:=Global.Topicos[1309];
    EdCodTamanho.Enabled:=Global.Topicos[1309];
    if FCodigosFiscais.GetQualImposto(QEstoque.fieldbyname('esqt_cfis_codigoest').asstring)='S' then begin
      EdUnitario.setvalue( FEstoque.GetPreco(EdProduto.text,Global.CodigoUnidade,EdCliente.resultfind.fieldbyname('clie_uf').asstring,aliicms,EdCliente.resultfind.fieldbyname('clie_tipo').asstring) );
      EdCodtamanho.enabled:=false;
      EdCodcor.Enabled:=false;
    end else
      EdUnitario.setvalue( FEStoque.CalculaMargem( FEstoque.GetCusto(QEstoque.FieldByName('esqt_esto_codigo').AsString,Global.CodigoUnidade,'custo' ),QBusca.FieldByName('grup_margem').ascurrency,QBusca.FieldByName('esto_grup_codigo').asinteger ) )
  end else if Global.Topicos[1405] then begin
    EdCodcor.Enabled:=Global.Topicos[1309];
    EdCodTamanho.Enabled:=Global.Topicos[1309];
    if FCodigosFiscais.GetQualImposto(QEstoque.fieldbyname('esqt_cfis_codigoest').asstring)='S' then begin
      EdUnitario.setvalue( FEstoque.GetPreco(EdProduto.text,Global.CodigoUnidade,EdCliente.resultfind.fieldbyname('clie_uf').asstring,aliicms,EdCliente.resultfind.fieldbyname('clie_tipo').asstring) );
      EdCodtamanho.enabled:=false;
      EdCodcor.Enabled:=false;
    end else
      EdUnitario.setvalue( CalculaPrecoVenda( FEstoque.GetCusto( QEstoque.FieldByName('esqt_esto_codigo').AsString,Global.CodigoUnidade,'custo' ) )  )
  end else begin
// 22.05.14
    if (Global.topicos[1373]) and (codigobarra) and ( QGRade<>nil ) then
      EdUnitario.SetValue(QGrade.fieldbyname('esgr_vendavis').AsCurrency)
    else if not (Global.Topicos[1411]) then
      EdUnitario.setvalue( FEstoque.GetPreco(EdProduto.text,Global.CodigoUnidade,EdCliente.resultfind.fieldbyname('clie_uf').asstring,aliicms,EdCliente.resultfind.fieldbyname('clie_tipo').asstring) )

      ////
    else begin
//      EdUnitario.setvalue( 0 );
//    end else if Global.Topicos[1411] then begin
    // se for ferro ..
    // ver criar campo 'formula ou regra' no cadastro de grupos
          unitario:=QEstoque.fieldbyname('esqt_custo').ascurrency;
          if regradogrupo(EdProduto.text)=1 then
            unitario:=(unitario)*Arq.TEstoque.fieldbyname('esto_peso').ascurrency
    //        *(EdCodtamanho.ResultFind.fieldbyname('tama_comprimento').ascurrency/1000)
          else
    // se for aluminio
            unitario:=(unitario)*Arq.TEstoque.fieldbyname('esto_peso').ascurrency;

          tamanho:=6;
          if tamanho=0 then
              unitario:=unitario*6  // ( caso nao tenha a grade informada multiplica por 6mts )
          else
              unitario:=unitario*tamanho;

          if EdTipoPed.text='PV' then
            xmargem:=QBusca.fieldbyname('grup_markup').AsCurrency
          else
            xmargem:=QBusca.fieldbyname('grup_margem').AsCurrency;
          if xmargem<=100 then
            unitario:=unitario/( (100-xmargem)/100 )
          else
            unitario:=unitario*2;
        EdUnitario.setvalue(unitario);
    end;
// 16.08.17 - devereda - caso usar leitor de codigo de barra no pedido
    if EdQtde.Enabled then begin
// 12.07.13
      EdCodcor.Enabled:=Global.Usuario.OutrosAcessos[0505];
      EdCodTamanho.Enabled:=Global.Usuario.OutrosAcessos[0505];
    end else begin
      EdCodcor.Enabled:=false;
      EdCodTamanho.Enabled:=false;
    end;
    if ( Global.Usuario.OutrosAcessos[0506] ) then begin
      EdCubagem.Title:='Un./Metro';
      EdCubagem.setvalue( EdUnitario.ascurrency );
    end else begin
      EdCubagem.Enabled:=false;
      EdCubagem.Title:='Cubagem';
      EdCubagem.setvalue( 0 );
    end;

  end;
    // 24.01.06 - preco de venda com subst. tributaria embutida
  Vendabru:=EdUnitario.ascurrency;

//  if (EdUnitario.ascurrency=0) and ( not Global.Usuario.OutrosAcessos[0501]) then begin
//    EdProduto.Invalid('Aten��o.   Pre�o de Venda ( ou custo ) zerado no cadastro do produto');
//    exit;
//  end;

//  if EdMoes_tabp_codigo.asinteger>0 then begin
// 31.03.10 - Cenitech
  if (EdMoes_tabp_codigo.asinteger>0) and ( not Global.Topicos[1405]) then begin
    if FTabela.gettipo(EdMoes_tabp_codigo.asinteger) = 'A' then
      EdUnitario.setvalue( EdUnitario.AsCurrency + (EdUnitario.ascurrency*(FTabela.GetAliquota(EdMoes_tabp_codigo.asinteger)/100) ) )
    else
      EdUnitario.setvalue( EdUnitario.AsCurrency - (EdUnitario.ascurrency*(FTabela.GetAliquota(EdMoes_tabp_codigo.asinteger)/100) ) );
  end;
// 22.06.06
  if pos( EdProduto.text,FGeral.Getconfig1asstring('Produtoscopa') )>0 then
    EdcodCopa.enabled:=true
  else begin
    EdCodCopa.enabled:=false;
    EdCodCopa.setvalue(0);
  end;
// 12.08.14 - Benato
//  if (codbarrabalanca<>'S') and ( not codigobarra ) then
// 13.10.2021 - refeito a 'ordem'
//       EdUnitario.enabled:=true
  // 09.04.14 - Devereda
   if Global.topicos[1372] then

      EdUnitario.Enabled:=Global.topicos[1372]

   else if Global.Usuario.OutrosAcessos[0501] then

      FPedVenda.EdUnitario.enabled:=Global.Usuario.OutrosAcessos[0501];



end;


procedure TFPedVenda.EdPerdescontoExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////
var conf,restricao,restricao4:boolean;
begin

  if codigobarra then
    conf:=true
// 08.04.13 - Benato
  else if codbarrabalanca='S' then
    conf:=true
  else
    conf:=confirma('Confirma item ?');

  if conf then begin
    EditstoGrid;
    CalculaTotal;
    if (Global.Topicos[1414]) then begin
//////////////////// 17.04.14
// 21.08.13 - vivan - Angela + Lindadir - checar por produto passado
      if (OP='I') and (Global.Topicos[1029]) then begin
          restricao4:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','LIM',Global.Usuario.UnidadesMvto,EdTotalRemessa.ascurrency );
      end;
  // 18.11.13 - vivan - Liane - checagem de RC em aberto
//    16.05.14 - para pedido 'de frigorifico' pode passar...
      if (OP='I')  and ( not frigorifico) then begin
          restricao:=FGeral.ValidaCliente( EdCliente,Global.CodRemessaConsig,'P','REM',Global.Usuario.UnidadesMvto,EdTotalRemessa.ascurrency );
      end;
      if not restricao4  then begin // total em aberto versus limite de cr�dito
            if not FGEral.ValidaLiberacaoLimite(Global.usuario.codigo) then begin
              EdProduto.Invalid('');
              exit;
            end;
      end;
  // 18.11.13
      if not restricao  then begin // total de RC em aberto versus limite de RC
            if not FGEral.ValidaLiberacaoLimite(Global.usuario.codigo) then begin
              EdProduto.Invalid('');
              exit;
            end;
      end;
    end;
//////////////////

////////////////////
    if op='A' then begin
      if notagerada>0 then begin
        Avisoerro('Nota Fiscal '+inttostr(notagerada)+' j� gerada');
        exit;
      end;
      GravaItemConsignacao;
      GravaMestrePedVendas(EdDtEmissao.AsDate,EdCliente,EdUnid_codigo.text,
             Tipomov,Transacao,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger,OP);
      sistema.beginprocess('Gravando Item');
      Sistema.Commit;
      sistema.endprocess('');
    end;
  end;
  LimpaEditsItens;
  if EdProduto.enabled then begin
    EdProduto.SetFocus;
  end else begin
    bcancelaritemclick(FPedVenda);
  end;
  Freeandnil(QEstoque);

end;

/////////////////////////////////////////
procedure TFPedVenda.CalculaTotal;
/////////////////////////////////////////
var p:integer;
    vlrtotal,vlrtotalpro,qtdpecas,totalcubagem:currency;
begin
  vlrtotal:=0;vlrtotalpro:=0;qtdpecas:=0;totalcubagem:=0;
  for p:=1 to Grid.RowCount do begin
    if Grid.Cells[grid.getcolumn('move_esto_codigo'),p]<>'' then begin
      if (texttovalor(Grid.Cells[grid.getcolumn('mpdd_cubagem'),p])>0) and ( not Global.Usuario.OutrosAcessos[0506]) then begin
        vlrtotal:=vlrtotal+FGeral.Arredonda(texttovalor(Grid.Cells[grid.getcolumn('mpdd_cubagem'),p])*texttovalor(Grid.Cells[grid.getcolumn('venda'),p]),2);
        vlrtotalpro:=vlrtotalpro+FGeral.Arredonda(texttovalor(Grid.Cells[grid.getcolumn('mpdd_cubagem'),p])*texttovalor(Grid.Cells[grid.getcolumn('vendabru'),p]),2);
      end else if texttovalor(Grid.Cells[grid.getcolumn('mpdd_pecas'),p])>0 then begin
        vlrtotal:=vlrtotal+FGeral.Arredonda( texttovalor(Grid.Cells[grid.getcolumn('mpdd_pecas'),p])*texttovalor(Grid.Cells[grid.getcolumn('qtde'),p])*texttovalor(Grid.Cells[grid.getcolumn('venda'),p]),2);
        vlrtotalpro:=vlrtotalpro+FGeral.Arredonda(texttovalor(Grid.Cells[grid.getcolumn('mpdd_pecas'),p])*texttovalor(Grid.Cells[grid.getcolumn('qtde'),p])*texttovalor(Grid.Cells[grid.getcolumn('vendabru'),p]),2);
      end else begin
// 12.08.14 - Devereda - mostrar o 'retorno'
//////////////////////////////////////////////
        if (Global.Usuario.OutrosAcessos[0335]) and  (Texttovalor(Grid.Cells[grid.getcolumn('mpdd_qtdeenviada'),p])>0) then begin
          vlrtotal:=vlrtotal+FGeral.Arredonda(texttovalor(Grid.Cells[grid.getcolumn('qtde'),p])*texttovalor(Grid.Cells[grid.getcolumn('venda'),p]),2);
          vlrtotalpro:=vlrtotalpro+FGeral.Arredonda(texttovalor(Grid.Cells[grid.getcolumn('qtde'),p])*texttovalor(Grid.Cells[grid.getcolumn('vendabru'),p]),2);
          vlrtotal:=vlrtotal - FGeral.Arredonda(texttovalor(Grid.Cells[grid.getcolumn('mpdd_qtdeenviada'),p])*texttovalor(Grid.Cells[grid.getcolumn('venda'),p]),2);
          vlrtotalpro:=vlrtotalpro - FGeral.Arredonda(texttovalor(Grid.Cells[grid.getcolumn('mpdd_qtdeenviada'),p])*texttovalor(Grid.Cells[grid.getcolumn('vendabru'),p]),2);
        end else begin
          vlrtotal:=vlrtotal+FGeral.Arredonda(texttovalor(Grid.Cells[grid.getcolumn('qtde'),p])*texttovalor(Grid.Cells[grid.getcolumn('venda'),p]),2);
          vlrtotalpro:=vlrtotalpro+FGeral.Arredonda(texttovalor(Grid.Cells[grid.getcolumn('qtde'),p])*texttovalor(Grid.Cells[grid.getcolumn('vendabru'),p]),2);
        end;
      end;
// 09.06.11 - Novi
      if texttovalor(Grid.Cells[grid.getcolumn('mpdd_pecas'),p])>0 then
        qtdpecas:=qtdpecas+texttovalor(Grid.Cells[grid.getcolumn('mpdd_pecas'),p])
      else
        qtdpecas:=qtdpecas+texttovalor(Grid.Cells[grid.getcolumn('qtde'),p]);
// 04.09.09
        if Global.Topicos[1402] then
          totalcubagem:=totalcubagem+texttovalor(Grid.Cells[grid.getcolumn('mpdd_cubagem'),p])
        else if Servico(Grid.Cells[grid.getcolumn('move_esto_codigo'),p]) then
          totalcubagem:=totalcubagem+FGeral.Arredonda(texttovalor(Grid.Cells[grid.getcolumn('qtde'),p])*texttovalor(Grid.Cells[grid.getcolumn('venda'),p]),2)
// 11.10.13 - Metalforte
        else
          totalcubagem:=totalcubagem+FGeral.Arredonda(texttovalor(Grid.Cells[grid.getcolumn('qtde'),p])*
                         (FEstoque.GetPeso(Grid.Cells[grid.getcolumn('move_esto_codigo'),p]))*
                         (Texttovalor(Grid.Cells[grid.getcolumn('tamanho'),p])) ,2);

    end;
  end;
  Edtotalremessa.setvalue(vlrtotal);
  EdTotalprodutos.setvalue(vlrtotalpro);
  EdTotalqtde.setvalue(qtdpecas);
  EdTotalcubagem.setvalue(totalcubagem);
end;

////////////////////////////////////////////////////////////
procedure TFPedVenda.EditstoGrid;
////////////////////////////////////////////////////////////
var x:integer;
begin

  x:=ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdProduto.Text,grid.getcolumn('codtamanho'),EdCodtamanho.asinteger,grid.getcolumn('codcor'),Edcodcor.asinteger,
                 grid.getcolumn('codcopa'),Edcodcopa.asinteger );
  if x<0 then begin
    temgrid:=false;
    Grid.AppendRow;
    Grid.Cells[grid.getcolumn('move_seq'),Abs(x)]:=strzero(Seq,3);
    Grid.Cells[grid.getcolumn('move_esto_codigo'),Abs(x)]:=EdProduto.Text;
// 06.07.18
    if (Global.Topicos[1421]) and (Servico(EdProduto.Text)) then
      Grid.Cells[grid.getcolumn('esto_descricao'),Abs(x)]:=Eddescricaoservico.text
// 21.02.20
    else if ProdutoGenerico( EdProduto.Text ) then

      Grid.Cells[grid.getcolumn('esto_descricao'),Abs(x)]:=Eddescricaoservico.text

    else
      Grid.Cells[grid.getcolumn('esto_descricao'),Abs(x)]:=SetEdEsto_descricao.text;

    Grid.Cells[grid.getcolumn('tamanho'),Abs(x)]:=SetEdtamanho.text;
    Grid.Cells[grid.getcolumn('cor'),Abs(x)]:=SetEdcor.text;
    Grid.Cells[grid.getcolumn('qtde'),Abs(x)]:=EdQTde.AsSql;
    Grid.Cells[grid.getcolumn('venda'),Abs(x)]:=EdUnitario.AsSql;
//    if EdCubagem.asfloat>0 then
//      Grid.Cells[grid.getcolumn('totalitem'),Abs(x)]:=TRansform(EdCubagem.AsCurrency*EdUnitario.AsCurrency,f_cr)
    if Edpecas.asfloat>0 then  // 09.06.11 - Novi
      Grid.Cells[grid.getcolumn('totalitem'),Abs(x)]:=TRansform(EdPecas.Ascurrency*EdQTde.AsCurrency*EdUnitario.AsCurrency,f_cr)
    else
      Grid.Cells[grid.getcolumn('totalitem'),Abs(x)]:=TRansform(EdQTde.AsCurrency*EdUnitario.AsCurrency,f_cr);
    Grid.Cells[grid.getcolumn('codtamanho'),Abs(x)]:=Edcodtamanho.text;
    Grid.Cells[grid.getcolumn('codcor'),Abs(x)]:=Edcodcor.text;
    Grid.Cells[grid.getcolumn('vendabru'),Abs(x)]:=TRansform(FEstoque.GetPreco(EdProduto.text,Global.unidadematriz),f_cr);
    Grid.Cells[grid.getcolumn('perdesconto'),Abs(x)]:=EdPerdesconto.AsSql;
    Grid.Cells[grid.getcolumn('esto_sisvendas'),Abs(x)]:=FEstoque.GetSistemaVendas(EdProduto.text,EdUnid_codigo.text);
    Grid.Cells[grid.getcolumn('copa'),Abs(x)]:=SetEdcopa_descricao.text;
    Grid.Cells[grid.getcolumn('codcopa'),Abs(x)]:=Edcodcopa.text;
// 01.02.07
    Grid.Cells[grid.getcolumn('mpdd_pacotes'),Abs(x)]:=EdPacotes.text;
    Grid.Cells[grid.getcolumn('mpdd_fardos'),Abs(x)]:=EdFardos.text;
    Grid.Cells[grid.getcolumn('mpdd_cubagem'),Abs(x)]:=Transform(EdCubagem.asfloat,f_cr3);
    Grid.Cells[grid.getcolumn('mpdd_perdescre'),Abs(x)]:=Transform(EdDesCubagem.ascurrency,f_cr);
// 02.06.11
    Grid.Cells[grid.getcolumn('mpdd_pecas'),Abs(x)]:=Transform(EdPecas.ascurrency,f_cr);
//    Grid.Cells[grid.getcolumn('mpdd_pecas'),Abs(x)]:=EdPecas.assql;
// 15.08.12 - Novi - Isonel
    Grid.Cells[grid.getcolumn('totalpeso'),Abs(x)]:=Transform(EdPecas.ascurrency*EdQTde.AsCurrency,f_cr);
// 18.06.13 - Metalforte
    Grid.Cells[grid.getcolumn('esto_referencia'),Abs(x)]:=FEstoque.GetReferencia(EdProduto.text) ;

  end else begin

    temgrid:=true;
    Grid.Cells[grid.getcolumn('move_esto_codigo'),x]:=EdProduto.Text;
    Grid.Cells[grid.getcolumn('esto_descricao'),x]:=SetEdEsto_descricao.text;
    Grid.Cells[grid.getcolumn('tamanho'),Abs(x)]:=SetEdtamanho.text;
    Grid.Cells[grid.getcolumn('cor'),Abs(x)]:=SetEdcor.text;
// 19.06.06
    Grid.Cells[grid.getcolumn('copa'),Abs(x)]:=SetEdcopa_descricao.text;
    Grid.Cells[grid.getcolumn('codcopa'),Abs(x)]:=Edcodcopa.text;
// 19.01.06
//    if Op='A' then
//      Grid.Cells[grid.getcolumn('qtde'),x]:=Transform(EdQTde.Ascurrency,f_cr)
//    else
// 10.01.06
// 16.08.06 - remudado - Tania
    if (Op='A') and (OPbotao='A') then
      Grid.Cells[grid.getcolumn('qtde'),x]:=Transform(EdQTde.Ascurrency,f_cr)
    else
      Grid.Cells[grid.getcolumn('qtde'),x]:=Transform(texttovalor(Grid.Cells[grid.getcolumn('qtde'),x])+EdQTde.Ascurrency,f_cr);
    Grid.Cells[grid.getcolumn('venda'),x]:=Transform(EdUnitario.Ascurrency,f_cr);
//    if EdCubagem.asfloat>0 then
//      Grid.Cells[grid.getcolumn('totalitem'),x]:=TRansform(texttovalor(Grid.Cells[grid.getcolumn('mpdd_cubagem'),x])*EdUnitario.AsCurrency,f_cr)
//      Grid.Cells[grid.getcolumn('totalitem'),x]:=TRansform(EdCubagem.AsCurrency*EdUnitario.AsCurrency,f_cr)
    if Edpecas.asfloat>0 then  // 09.06.11 - Novi
      Grid.Cells[grid.getcolumn('totalitem'),x]:=TRansform(EdPecas.Ascurrency*EdQTde.AsCurrency*EdUnitario.AsCurrency,f_cr)
    else
      Grid.Cells[grid.getcolumn('totalitem'),x]:=TRansform(texttovalor(Grid.Cells[grid.getcolumn('qtde'),x])*EdUnitario.AsCurrency,f_cr);
    Grid.Cells[grid.getcolumn('codtamanho'),Abs(x)]:=Edcodtamanho.text;
    Grid.Cells[grid.getcolumn('codcor'),Abs(x)]:=Edcodcor.text;
    Grid.Cells[grid.getcolumn('vendabru'),Abs(x)]:=Transform(FEstoque.GetPreco(EdProduto.text,Global.unidadematriz),f_cr);
    Grid.Cells[grid.getcolumn('perdesconto'),Abs(x)]:=EdPerdesconto.AsSql;
    Grid.Cells[grid.getcolumn('esto_sisvendas'),Abs(x)]:=FEstoque.GetSistemaVendas(EdProduto.text,EdUnid_codigo.text);
// 01.02.07
    Grid.Cells[grid.getcolumn('mpdd_pacotes'),Abs(x)]:=EdPacotes.text;
    Grid.Cells[grid.getcolumn('mpdd_fardos'),Abs(x)]:=EdFardos.text;
    Grid.Cells[grid.getcolumn('mpdd_cubagem'),Abs(x)]:=Transform(EdCubagem.asfloat,f_cr3);
    Grid.Cells[grid.getcolumn('mpdd_perdescre'),Abs(x)]:=Transform(EdDesCubagem.ascurrency,f_cr);
    Grid.Cells[grid.getcolumn('mpdd_pecas'),Abs(x)]:=Transform(EdPecas.ascurrency,f_cr);
// 15.08.12 - Novi - Isonel
    Grid.Cells[grid.getcolumn('totalpeso'),Abs(x)]:=Transform(EdPecas.ascurrency*EdQTde.AsCurrency,f_cr);
// 18.06.13
    Grid.Cells[grid.getcolumn('esto_referencia'),Abs(x)]:=FEstoque.GetReferencia(EdProduto.text) ;
  end;
// 07.04.06
  EdProduto2.text:=EdProduto.text;
  SetEdEsto_descricao2.text:=SetEdEsto_descricao.text;
  EdCodcor2.text:=EdCodcor.text;
  SetEdcor2.text:=SetEdcor.text;
  EdCodtamanho2.text:=EdCodtamanho.text;
  EdQTde2.text:=Edqtde.text;
  EdPerdesconto2.text:=EdPerdesconto.text;
  EdUnitario2.text:=EdUnitario.text;

///////////////  Grid.Refresh;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////
function TFPedVenda.ProcuraGrid(Coluna: integer;  Pesquisa: string ; Colunatam:integer=0 ; tam:integer=0 ; colunacor:integer=0 ; cor:integer=0 ;
                                colunacopa:integer=0 ; copa:integer=0 ): integer;
//////////////////////////////////////////////////////////////////////////////////////////////////
var p:integer;
begin
  result:=0;seq:=0;
  for p:=1 to Grid.RowCount do  begin
      if trim(Grid.Cells[Grid.getcolumn('move_seq'),p])<>'' then begin
        seq:=strtoint(Grid.Cells[Grid.getcolumn('move_seq'),p]);
        inc(seq);
      end else begin
        if seq=0 then
          seq:=1;
      end;
  end;
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
         (trim(Grid.Cells[Colunatam,p])=trim(inttostr(tam))) and (trim(Grid.Cells[Colunacor,p])=trim(inttostr(cor)))
          and ( trim(Grid.Cells[Colunacopa,p])=trim(inttostr(copa)) ) then begin
          result:=p;
          break;
        end;
        if trim(Grid.Cells[Coluna,p])='' then begin   // linha a ser usada
          result:=(-1)*p;
          break;
        end;
      end;
    end;
  end else if (tam>0) and (cor=0) then begin  // 04.07.06
      for p:=1 to Grid.RowCount do  begin
        if (trim(Grid.Cells[Coluna,p])=trim(Pesquisa)) and
         ( trim(Grid.Cells[Colunatam,p])=trim(inttostr(tam)) ) and ( texttovalor(Grid.Cells[Colunacor,p])=0 ) then begin
          result:=p;
          break;
        end;
        if trim(Grid.Cells[Coluna,p])='' then begin   // linha a ser usada
          result:=(-1)*p;
          break;
        end;
      end;
  end else begin  // pesquisa sem tamanho e cor acha item com tamanho e cor
    for p:=1 to Grid.RowCount do  begin
      if ( trim(Grid.Cells[Coluna,p])=trim(Pesquisa) ) and (strtointdef(Grid.Cells[colunatam,p],0)=0) then begin
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

// 21.02.20
function TFPedVenda.ProdutoGenerico(codigo:string): boolean;
//////////////////////////////////////////////
begin

   result := ( copy(codigo,1,4 ) = 'PROD' ) and ( Global.topicos[1427] ) ;

end;

/////////////////////////////////////////////////
procedure TFPedVenda.GetListaPedidos(TLista: TStringList; xES: string);
////////////////////////////////////////////////////////////////////////////
var Q    :Tsqlquery;
    sqles:string;
    Di,Df:TDatetime;

begin

  Di:=Sistema.Hoje-180;
//  if FGeral.GetConfig1AsInteger('Diasdevolucao') > 0 then
//    Di:=Sistema.Hoje-FGeral.GetConfig1AsInteger('Diasdevolucao');
  Df:=Sistema.Hoje;
  if xEs='S' then
    sqles:=' and '+FGeral.GetIN('mped_tipomov',Global.CodPedVenda,'C')
  else
    sqles:=' and '+FGeral.GetIN('moco_tipomov','PB','C');

  Q:=sqltoquery('select mpdd_esto_codigo,mpdd_qtde,mpdd_datamvto,esto_descricao,mpdd_venda  from movpeddet '+
                ' inner join movped on ( mped_transacao = mpdd_transacao )'+
                ' inner join estoque on ( esto_codigo = mpdd_esto_codigo )'+
                ' where mpdd_datamvto>='+Datetosql(Di)+
                ' and '+FGeral.getin('mpdd_status','N','C')+
                ' and mpdd_datamvto<='+Datetosql(Df)+
                ' and mpdd_tipo_codigo = '+EdCliente.assql+
                ' and mpdd_unid_codigo='+EdUnid_codigo.assql+
//                ' and '+FGeral.GetSqlDataNula('moes_datacont')+
                sqles+
                ' order by mpdd_datamvto desc' );
  if not Q.eof then
    TLista.Add('Codigo     | Data        | Quantidade|     Unit�rio | Descri��o                   ' );

  while not Q.eof do begin

    TLista.Add( strspace(Q.fieldbyname('mpdd_esto_codigo').asstring,10)+' | '+
               FGeral.FormataData( Q.fieldbyname('mpdd_datamvto').asdatetime )+' | '+
//               strzero( Q.fieldbyname('moes_numerodoc').asinteger ,6)+' | '+
//               FGeral.Formatavalor(Q.fieldbyname('mpdd_qtde').ascurrency,'############0')+' | '+
               TRansform(Q.fieldbyname('mpdd_qtde').ascurrency,'######0')+' | '+
//               FGeral.Formatavalor(Q.fieldbyname('mpdd_venda').ascurrency,f_cr)+' | '+
               TRansform(Q.fieldbyname('mpdd_venda').ascurrency,'###0.00')+' | '+
               strspace( Q.fieldbyname('esto_descricao').asstring,30)
               );
    Q.Next;

  end;
  FGeral.FechaQuery(Q);


end;

procedure TFPedVenda.GravaItemConsignacao;
/////////////////////////////////////////////////
var  Q2:TSqlquery;
     sqlcopa,sqlcor,desccopa:string;
begin

   Q2:=Sqltoquery('select * from movpeddet inner join movped on ( mped_transacao=mpdd_transacao )'+
          ' where mpdd_status=''N'''+
          ' and mpdd_numerodoc='+EdNumerodoc.AsSql+
          ' and mpdd_tipomov='+Stringtosql(Tipomov)+
          ' and mpdd_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and mpdd_tipo_codigo='+EdCliente.AsSql );

//          ' and mpdd_tama_codigo='+Grid.Cells[Grid.getcolumn('codtamanho'),Grid.row]+
//          ' and mpdd_core_codigo='+Grid.Cells[Grid.getcolumn('codcor'),Grid.row]+
//          ' and mpdd_esto_codigo='+EdProduto.assql ) ;
   sqlcopa:=' and mpdd_copa_codigo=0';
   if not Edcodcopa.isempty then
     sqlcopa:=' and mpdd_copa_codigo='+EdCodcopa.assql;
   sqlcor:=' and mpdd_core_codigo=0';
   if not Edcodcor.isempty then
     sqlcor:=' and mpdd_core_codigo='+EdCodcor.assql;
// 24.11.13
   if Q2.eof then begin
       Q2.Close;Q2.free;
       Q2:=Sqltoquery('select * from movped where mped_status=''N'''+
          ' and mped_numerodoc='+EdNumerodoc.AsSql+
          ' and mped_tipomov='+Stringtosql(Tipomov)+
          ' and mped_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and mped_tipo_codigo='+EdCliente.AsSql );
   end;

   if Q2.Eof then begin
      Avisoerro('N�o encontrado este pedido para incluir este item');
      exit;

   end else if (EdProduto.enabled=false) or ( temgrid ) then begin

      Transacao:=Q2.fieldbyname('mpdd_transacao').Asstring;
      Sistema.Edit('movpeddet');
//      Sistema.SetField('mpdd_esto_codigo',EdProduto.Text);
//      Sistema.SetField('mpdd_tama_codigo',Edcodtamanho.asinteger);
//      Sistema.SetField('mpdd_core_codigo',Edcodcor.asinteger);
//      Sistema.SetField('mpdd_transacao',transacao);
//      Sistema.SetField('mpdd_operacao',FGeral.GetOperacao);
//      Sistema.SetField('mpdd_numerodoc',Ednumerodoc.Asinteger);
//      Sistema.SetField('mpdd_status','N');
//      Sistema.SetField('mpdd_tipomov',TipoMov);
//      Sistema.SetField('mpdd_unid_codigo',EdUnid_codigo.text);
//      Sistema.SetField('mpdd_tipo_codigo',EdCliente.AsInteger);
//      Sistema.SetField('mpdd_tipocad','C');
//      Sistema.SetField('mpdd_qtde',EdQtde.AsCurrency+Texttovalor(Grid.cells[Grid.getcolumn('qtde'),seq]));
// 11.08.06
//      Sistema.SetField('mpdd_qtde',EdQtde.AsCurrency);
// 16.08.06 - remudado - Tania
      if (Op='A') and (OPbotao='A') then
        Sistema.SetField('mpdd_qtde',EdQtde.AsCurrency)
      else
        Sistema.SetField('mpdd_qtde',EdQtde.AsCurrency+Texttovalor(Grid.cells[Grid.getcolumn('qtde'),seq]));
      Sistema.SetField('mpdd_datalcto',EdDtEmissao.Asdate);
      Sistema.SetField('mpdd_datamvto',Sistema.Hoje);
      Sistema.SetField('mpdd_venda',EdUnitario.AsCurrency);
      Sistema.SetField('mpdd_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('mpdd_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('mpdd_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.SetField('mpdd_usua_codigo',Global.Usuario.codigo);
      Sistema.SetField('mpdd_repr_codigo',EdRepr_codigo.asinteger);
//      Sistema.SetField('mpdd_datacont',EdDtmovimento.asdate);
      Sistema.SetField('mpdd_qtdeenviada',0);
      Sistema.SetField('mpdd_vendabru',vendabru);
      Sistema.SetField('mpdd_perdesco',EdPerdesconto.ascurrency);
// 02.06.11
       if campopecas.tipo<>'' then
         Sistema.SetField('mpdd_pecas',Edpecas.ascurrency);
//      Sistema.SetField('mpdd_caoc_codigo',0);
// 21.02.20
        if ProdutoGenerico( EdProduto.Text ) then
           Sistema.SetField('mpdd_esto_descricao',Eddescricaoservico.Text);

      Sistema.Post('mpdd_status=''N'' and mpdd_tipomov='+stringtosql(tipomov)+' and mpdd_unid_codigo='+EdUnid_codigo.assql+
                   ' and mpdd_tipo_codigo='+EdCliente.assql+' and mpdd_numerodoc='+EdNumerodoc.Assql+
                   ' and mpdd_esto_codigo='+EdProduto.Assql+
                   ' and mpdd_tama_codigo='+Edcodtamanho.Assql+
                   ' and mpdd_transacao='+stringtosql(transacao)+
                   sqlcopa+
                   sqlcor );
//                   ' and mpdd_core_codigo='+Edcodcor.assql);

// 16.08.06
      Sistema.Insert('Ocorrencias');
      Sistema.Setfield('Ocor_CatEntidade','C');
      Sistema.Setfield('Ocor_CodEntidade',EdCliente.asinteger);
      Sistema.Setfield('Ocor_Data',Sistema.Hoje);
      Sistema.Setfield('Ocor_Unid_Codigo',Global.CodigoUnidade);
      Sistema.Setfield('Ocor_Usuario',Global.Usuario.Codigo);
      if EdCodcopa.asinteger>0 then
        desccopa:=' Copa '+FCopas.Getdescricao(EdCodcopa.asinteger)
      else
        desccopa:='';
      if (Op='A') and (OPbotao='A') then
        Sistema.Setfield('Ocor_Descricao',EdProduto.Text+' Tam '+FTamanhos.Getdescricao(EdCodtamanho.asinteger)+
                        ' Cor '+Fcores.Getdescricao(Edcodcor.asinteger)+
                        desccopa+
                        ' ALTERADO para '+EdQtde.Text+' pe�as' )
      else
        Sistema.Setfield('Ocor_Descricao',EdProduto.Text+' Tam '+FTamanhos.Getdescricao(EdCodtamanho.asinteger)+
                        ' Cor '+Fcores.Getdescricao(Edcodcor.asinteger)+
                        desccopa+' somado mais '+EdQtde.Text+' pe�as' );
      Sistema.Setfield('ocor_numerodoc',EdNumerodoc.AsInteger);
      Sistema.Setfield('ocor_caoc_codigo',0);
      Sistema.Setfield('ocor_status','E');   // para nao imprimir no pedido
      Sistema.Setfield('ocor_tipoocor',0);
      Sistema.Post;

      Sistema.Commit;


   end else begin

//      Transacao:=Q2.fieldbyname('mpdd_transacao').Asstring;
// 25.11.13
      Transacao:=Q2.fieldbyname('mped_transacao').Asstring;
      Sistema.Insert('movpeddet');
      Sistema.SetField('mpdd_esto_codigo',EdProduto.Text);
      Sistema.SetField('mpdd_tama_codigo',Edcodtamanho.asinteger);
      Sistema.SetField('mpdd_core_codigo',Edcodcor.asinteger);
      Sistema.SetField('mpdd_copa_codigo',Edcodcopa.asinteger);
      Sistema.SetField('mpdd_transacao',transacao);
      Sistema.SetField('mpdd_operacao',FGeral.GetOperacao);
      Sistema.SetField('mpdd_numerodoc',Ednumerodoc.Asinteger);
      Sistema.SetField('mpdd_status','N');
      if trim(tipomov)<>'' then
        Sistema.SetField('mpdd_tipomov',TipoMov)
      else
        Sistema.SetField('mpdd_tipomov',Global.CodPedVenda);
      Sistema.SetField('mpdd_unid_codigo',EdUnid_codigo.text);
      Sistema.SetField('mpdd_tipo_codigo',EdCliente.AsInteger);
      Sistema.SetField('mpdd_tipocad','C');
      Sistema.SetField('mpdd_qtde',EdQtde.AsCurrency);
      Sistema.SetField('mpdd_datalcto',EdDtEmissao.Asdate);
      Sistema.SetField('mpdd_datamvto',Sistema.Hoje);
      Sistema.SetField('mpdd_venda',EdUnitario.AsCurrency);
      Sistema.SetField('mpdd_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('mpdd_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('mpdd_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.SetField('mpdd_usua_codigo',Global.Usuario.codigo);
      Sistema.SetField('mpdd_repr_codigo',EdRepr_codigo.asinteger);
      Sistema.SetField('mpdd_datacont',EdDtmovimento.asdate);
      Sistema.SetField('mpdd_qtdeenviada',0);
      Sistema.SetField('mpdd_vendabru',vendabru);
      Sistema.SetField('mpdd_perdesco',EdPerdesconto.ascurrency);
      Sistema.SetField('mpdd_caoc_codigo',0);
      Sistema.SetField('mpdd_seq',seq);
// 02.06.11
       if campopecas.tipo<>'' then
         Sistema.SetField('mpdd_pecas',Edpecas.ascurrency);
// 21.02.20
      if ProdutoGenerico( EdProduto.Text ) then
           Sistema.SetField('mpdd_esto_descricao',Eddescricaoservico.Text);

      Sistema.Post('');
      Sistema.Commit;
   end;
   Q2.Close;
   Freeandnil(Q2);
end;

////////////////////////////////////////////////////////////
procedure TFPedVenda.GravaItensPedVendas(Emissao: TDatetime;
  Cliente: TSqlEd; Unidade, TipoMovimento, Transacao: string;
  Numero: Integer; Grid: TSqlDtGrid);
////////////////////////////////////////////////////////////
var linha,xcodcor,xcodtamanho,xseq:integer;
    sqlcopa,sqlcor,xsqlcor,xsqltamanho,sqltamanho,sqlcustama,sqlcuscor:string;
    QEstoqueqtde,QEstoqueGrade,QCusto:TSqlquery;

    procedure GeraMovimentoEstoque;
    //////////////////////////////
    begin

      Sistema.Insert('Movestoque');
      Sistema.SetField('move_esto_codigo',Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha]);
      Sistema.SetField('move_tama_codigo',strtointdef(Grid.Cells[Grid.getcolumn('codtamanho'),linha],0));
      Sistema.SetField('move_core_codigo',strtointdef(Grid.Cells[Grid.getcolumn('codcor'),linha],0));
//      Sistema.SetField('move_copa_codigo',strtointdef(Grid.Cells[Grid.getcolumn('codcopa'),linha],0));
      Sistema.SetField('move_transacao',transacao);
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
      Sistema.SetField('move_numerodoc',numero);
      Sistema.SetField('move_status','N');
      Sistema.SetField('move_tipomov',TipoMovimento);
      Sistema.SetField('move_unid_codigo',Unidade);
      Sistema.SetField('move_tipo_codigo',Cliente.AsInteger);
      Sistema.SetField('move_tipocad','C');
//      Sistema.SetField('move_repr_codigo',EdCliente.resultfind.fieldbyname('clie_repr_codigo').asinteger);
// 26.10.18
      Sistema.SetField('move_repr_codigo',Edrepr_codigo.Text);
      Sistema.SetField('move_qtde',texttovalor(Grid.Cells[grid.getcolumn('qtde'),linha]));
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datacont',EdDtMovimento.asdate);
      Sistema.SetField('move_datamvto',EdDtEmissao.asdate);
      Sistema.SetField('move_qtderetorno',0);
      Sistema.SetField('move_custo',QEstoqueQtde.fieldbyname('esqt_custo').ascurrency);
      Sistema.SetField('move_custoger',QEstoqueQtde.fieldbyname('esqt_custoger').ascurrency);
      Sistema.SetField('move_customedio',QEstoqueQtde.fieldbyname('esqt_customedio').ascurrency);
      Sistema.SetField('move_customeger',QEstoqueQtde.fieldbyname('esqt_customeger').ascurrency);
      Sistema.SetField('move_cst','000');   // fixo por enquanto
      Sistema.SetField('move_aliicms',0);
      Sistema.SetField('move_venda',texttovalor(Grid.Cells[grid.getcolumn('venda'),linha]));
      Sistema.SetField('move_grup_codigo',QEstoqueQTde.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('move_sugr_codigo',QEstoqueqtde.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('move_fami_codigo',QEstoqueqtde.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.SetField('move_perdesco',texttovalor(Grid.Cells[grid.getcolumn('perdesconto'),linha]));
      Sistema.SetField('move_vendabru',texttovalor(Grid.Cells[grid.getcolumn('vendabru'),linha]));
      Sistema.SetField('move_clie_codigo',Cliente.AsInteger);
      Sistema.SetField('move_aliipi',0);
      Sistema.SetField('move_pecas',texttovalor(Grid.Cells[grid.getcolumn('mpdd_pecas'),linha]));
      Sistema.SetField('move_vendamin',0);
      Sistema.SetField('move_redubase',0);
//      Sistema.SetField('move_nroobra',inttostr(numero));
//      Sistema.SetField('move_certificado',Grid.Cells[grid.getcolumn('move_certificado'),linha]);
//          Sistema.SetField('move_natf_codigo',Grid.Cells[Grid.getcolumn('move_natf_codigo'),linha] );
      Sistema.Post('');

    end;

begin
///////////////////
  for linha:=1 to Grid.rowcount do begin
    if trim(Grid.Cells[0,linha])<>'' then begin

      if op='I' then begin

        Sistema.Insert('movpeddet');
        Sistema.SetField('mpdd_esto_codigo',Grid.cells[Grid.getcolumn('move_esto_codigo'),linha]);
        Sistema.SetField('mpdd_tama_codigo',strtointdef(Grid.cells[Grid.getcolumn('codtamanho'),linha],0));
        Sistema.SetField('mpdd_core_codigo',strtointdef(Grid.cells[Grid.getcolumn('codcor'),linha],0));
        Arq.TEstoque.locate('esto_codigo',Grid.cells[Grid.getcolumn('move_esto_codigo'),linha],[]);
        Sistema.SetField('mpdd_transacao',transacao);
        Sistema.SetField('mpdd_operacao',FGeral.GetOperacao);
        Sistema.SetField('mpdd_numerodoc',Ednumerodoc.Asinteger);
        Sistema.SetField('mpdd_status','N');
        if trim(tipomov)<>'' then
          Sistema.SetField('mpdd_tipomov',TipoMov)
        else
          Sistema.SetField('mpdd_tipomov',Global.CodPedVenda);
        Sistema.SetField('mpdd_unid_codigo',EdUnid_codigo.text);
        Sistema.SetField('mpdd_tipo_codigo',EdCliente.AsInteger);
        Sistema.SetField('mpdd_tipocad','C');
        Sistema.SetField('mpdd_qtde',Texttovalor(Grid.cells[Grid.getcolumn('qtde'),linha]) );
        Sistema.SetField('mpdd_datalcto',EdDtEmissao.Asdate);
        Sistema.SetField('mpdd_datamvto',Sistema.Hoje);
        Sistema.SetField('mpdd_venda',Texttovalor(Grid.cells[Grid.getcolumn('venda'),linha]));
        Sistema.SetField('mpdd_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
        Sistema.SetField('mpdd_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
        Sistema.SetField('mpdd_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
        Sistema.SetField('mpdd_mate_codigo',Arq.TEstoque.fieldbyname('esto_mate_codigo').AsInteger);
        Sistema.SetField('mpdd_emlinha',Arq.TEstoque.fieldbyname('esto_emlinha').AsString);
        Sistema.SetField('mpdd_usua_codigo',Global.Usuario.codigo);
        Sistema.SetField('mpdd_repr_codigo',EdRepr_codigo.asinteger);
        Sistema.SetField('mpdd_datacont',EdDtmovimento.asdate);
        Sistema.SetField('mpdd_qtdeenviada',0);
        Sistema.SetField('mpdd_vendabru',Texttovalor(Grid.cells[Grid.getcolumn('vendabru'),linha]));
        Sistema.SetField('mpdd_perdesco',Texttovalor(Grid.cells[Grid.getcolumn('perdesconto'),linha]));
        Sistema.SetField('mpdd_caoc_codigo',0);
        Sistema.SetField('mpdd_situacao','P');
  // 10.11.05
        Sistema.SetField('mpdd_seq',strtoint(Grid.cells[Grid.getcolumn('move_seq'),linha]));
// 19.06.06
        Sistema.SetField('mpdd_copa_codigo',strtointdef(Grid.cells[Grid.getcolumn('codcopa'),linha],0));
// 01.02.07
        Sistema.SetField('mpdd_pacotes',strtointdef(Grid.cells[Grid.getcolumn('mpdd_pacotes'),linha],0) );
        Sistema.SetField('mpdd_fardos',strtointdef(Grid.cells[Grid.getcolumn('mpdd_fardos'),linha],0) );
        Sistema.SetField('mpdd_cubagem',Texttovalor(Grid.cells[Grid.getcolumn('mpdd_cubagem'),linha]) );
// 14.02.07
        Sistema.SetField('mpdd_perdescre',Texttovalor(Grid.cells[Grid.getcolumn('mpdd_perdescre'),linha]) );
// 02.06.11
        if campopecas.tipo<>'' then
          Sistema.SetField('mpdd_pecas',Texttovalor(Grid.cells[Grid.getcolumn('mpdd_pecas'),linha]) );
// 21.02.20
        if ProdutoGenerico( trim(Grid.cells[Grid.getcolumn('move_esto_codigo'),linha]) ) then
           Sistema.SetField('mpdd_esto_descricao',Grid.cells[Grid.getcolumn('esto_descricao'),linha] );

        Sistema.Post('');

// 22.07.13  - Metalforte - OS baixa estoque
//////////////////////////////////////////////
        if TipomovOS=TipoMov then begin
          QEstoqueqtde:=sqltoquery('select * from estoqueqtde inner join estoque on ( esto_codigo=esqt_esto_codigo )'+
                                   ' where esqt_status=''N'' and esqt_unid_codigo='+stringtosql(EdUnid_codigo.text)+
                                   ' and esqt_esto_codigo='+stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]) );
          xcodcor:=strtointdef(Grid.Cells[Grid.getcolumn('codcor'),linha],0);
          xcodtamanho:=strtointdef(Grid.Cells[Grid.getcolumn('codtamanho'),linha],0);
          xsqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
          xsqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
          if (xcodcor>0) and (xcodtamanho>0)  then begin
              xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
              xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
          end else if (xcodcor>0) then begin
              xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
          end else if (xcodtamanho>0) then begin
              xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
          end;

          FGeral.MovimentaQtdeEstoque(Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha],
                    unidade,'S',TipoMovimento,
                    texttovalor(Grid.Cells[grid.getcolumn('qtde'),linha]),QEstoqueQtde );


          if (xcodcor>0) and (xcodtamanho>0)  then begin
            QEstoqueGrade:=sqltoquery('select * from Estgrades where esgr_status=''N'' and esgr_esto_codigo='+StringtoSql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])+
                ' and esgr_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
                xsqlcor+xsqltamanho );
            FGeral.MovimentaQtdeEstoqueGrade(Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha],
                    unidade,'S',TipoMovimento,
                    strtointdef(Grid.Cells[Grid.getcolumn('codcor'),linha],0),
                    strtointdef(Grid.Cells[Grid.getcolumn('codtamanho'),linha],0),
                    0,
                    texttovalor(Grid.Cells[grid.getcolumn('qtde'),linha]),QEstoqueGrade );
            GeraMovimentoEstoque;
            FGeral.FechaQuery( QEstoqueGrade );
          end else
            GeraMovimentoEstoque;

          FGeral.FechaQuery( QEstoqueQtde );
        end;
/////////////////////////////////////////////////////////////////////////////////////////////
        if (Global.Topicos[1420]) and ( tipomov='OS' ) then begin

             if strtointdef(Grid.cells[Grid.getcolumn('codtamanho'),linha],0) > 0 then
               sqlcustama:=' and cust_tama_codigo='+Grid.cells[Grid.getcolumn('codtamanho'),linha]
             else
               sqlcustama:='';
             if strtointdef(Grid.cells[Grid.getcolumn('codcor'),linha],0) > 0 then
               sqlcuscor:=' and cust_core_codigo='+Grid.cells[Grid.getcolumn('codcor'),linha]
             else
               sqlcuscor:='';
            QCusto:=sqltoquery('select * from custos inner join estoque on ( esto_codigo=cust_esto_codigomat )'+
// 17.04.18
                ' where '+FGeral.GetIN('cust_status','N;P','C')+
                ' and cust_esto_codigo='+Stringtosql(Grid.cells[Grid.getcolumn('move_esto_codigo'),linha])+
                sqlcustama+sqlcuscor+' order by cust_esto_codigo');
// aqui colocar mpdd_ordem no order apos ajustar a gravacao da OS e criar o campo ( + campos de temperatura e tempo )
            xseq:=1;
            while not QCusto.Eof do begin

                Sistema.Insert('movpeddet');
                Sistema.SetField('mpdd_esto_codigo',QCusto.FieldByName('cust_esto_codigomat').AsString);
                Sistema.SetField('mpdd_tama_codigo',QCusto.FieldByName('cust_tama_codigo').AsInteger);
                Sistema.SetField('mpdd_core_codigo',QCusto.FieldByName('cust_core_codigo').AsInteger);
                Sistema.SetField('mpdd_transacao',transacao);
                Sistema.SetField('mpdd_operacao',FGeral.GetOperacao);
                Sistema.SetField('mpdd_numerodoc',Ednumerodoc.Asinteger);
                Sistema.SetField('mpdd_status','N');
                Sistema.SetField('mpdd_tipomov','OP');
                Sistema.SetField('mpdd_unid_codigo',EdUnid_codigo.text);
                Sistema.SetField('mpdd_tipo_codigo',EdCliente.AsInteger);
                Sistema.SetField('mpdd_tipocad','C');

                if QCusto.FieldByName('cust_status').asstring='P' then
                  Sistema.SetField('mpdd_qtde',Texttovalor(Grid.cells[Grid.getcolumn('qtde'),linha])*Qcusto.FieldByName('cust_perqtde').AsCurrency*10 )
                else
                  Sistema.SetField('mpdd_qtde',Texttovalor(Grid.cells[Grid.getcolumn('qtde'),linha])*Qcusto.FieldByName('cust_qtde').AsCurrency );

                Sistema.SetField('mpdd_datalcto',EdDtEmissao.Asdate);
                Sistema.SetField('mpdd_datamvto',Sistema.Hoje);
                Sistema.SetField('mpdd_venda',1);
                Sistema.SetField('mpdd_grup_codigo',Qcusto.fieldbyname('esto_grup_codigo').AsInteger);
                Sistema.SetField('mpdd_sugr_codigo',Qcusto.fieldbyname('esto_sugr_codigo').AsInteger);
                Sistema.SetField('mpdd_fami_codigo',Qcusto.fieldbyname('esto_fami_codigo').AsInteger);
                Sistema.SetField('mpdd_mate_codigo',Qcusto.fieldbyname('esto_mate_codigo').AsInteger);
                Sistema.SetField('mpdd_emlinha',QCusto.fieldbyname('esto_emlinha').AsString);
                Sistema.SetField('mpdd_usua_codigo',Global.Usuario.codigo);
                Sistema.SetField('mpdd_repr_codigo',EdRepr_codigo.asinteger);
                Sistema.SetField('mpdd_datacont',EdDtmovimento.asdate);
                Sistema.SetField('mpdd_qtdeenviada',0);
                Sistema.SetField('mpdd_vendabru',1);
                Sistema.SetField('mpdd_perdesco',0);
                Sistema.SetField('mpdd_caoc_codigo',0);
                Sistema.SetField('mpdd_situacao','P');
                Sistema.SetField('mpdd_seq',xseq );
//                Sistema.SetField('mpdd_perdescre',Texttovalor(Grid.cells[Grid.getcolumn('mpdd_perdescre'),linha]) );
                if campopecas.tipo<>'' then
                  Sistema.SetField('mpdd_pecas',Texttovalor(Grid.cells[Grid.getcolumn('mpdd_pecas'),linha]) );
                Sistema.Post('');
                inc(xseq);
                QCusto.Next

            end;
            FGeral.FechaQuery(QCusto);

        end;

// alteracao
      end else begin

        sqlcopa:='and mpdd_copa_codigo=0';
        if trim(Grid.cells[Grid.getcolumn('codcopa'),linha])<>'' then
           sqlcopa:='and mpdd_copa_codigo='+Grid.cells[Grid.getcolumn('codcopa'),linha];
// 04.07.06
        sqlcor:='and mpdd_core_codigo=0';
        if trim(Grid.cells[Grid.getcolumn('codcor'),linha])<>'' then
           sqlcor:='and mpdd_core_codigo='+Grid.cells[Grid.getcolumn('codcor'),linha];
// 24.11.14
        sqltamanho:='and mpdd_tama_codigo=0';
        if trim(Grid.cells[Grid.getcolumn('codtamanho'),linha])<>'' then
           sqltamanho:='and mpdd_tama_codigo='+Grid.cells[Grid.getcolumn('codtamanho'),linha];

        Sistema.Edit('movpeddet');
        if trim(tipomov)<>'' then
          Sistema.SetField('mpdd_tipomov',TipoMov)
        else
          Sistema.SetField('mpdd_tipomov',Global.CodPedVenda);
//        Sistema.SetField('mpdd_tipomov',TipoMov);

        Sistema.SetField('mpdd_qtde',Texttovalor(Grid.cells[Grid.getcolumn('qtde'),linha]) );
        Sistema.SetField('mpdd_usua_codigo',Global.Usuario.codigo);
        Sistema.SetField('mpdd_vendabru',Texttovalor(Grid.cells[Grid.getcolumn('vendabru'),linha]));
        Sistema.SetField('mpdd_perdesco',Texttovalor(Grid.cells[Grid.getcolumn('perdesconto'),linha]));
        Sistema.SetField('mpdd_venda',Texttovalor(Grid.cells[Grid.getcolumn('venda'),linha]));
// 01.02.07
        Sistema.SetField('mpdd_pacotes',strtointdef(Grid.cells[Grid.getcolumn('mpdd_pacotes'),linha],0) );
        Sistema.SetField('mpdd_fardos',strtointdef(Grid.cells[Grid.getcolumn('mpdd_fardos'),linha],0) );
        Sistema.SetField('mpdd_cubagem',Texttovalor(Grid.cells[Grid.getcolumn('mpdd_cubagem'),linha]) );
// 14.02.07
        Sistema.SetField('mpdd_perdescre',Texttovalor(Grid.cells[Grid.getcolumn('mpdd_perdescre'),linha]) );
// 02.06.11
       if campopecas.tipo<>'' then
         Sistema.SetField('mpdd_pecas',Texttovalor(Grid.cells[Grid.getcolumn('mpdd_pecas'),linha]) );
// 10.11.05
/////////////////        Sistema.SetField('mpdd_seq',strtoint(Grid.cells[Grid.getcolumn('move_seq'),linha]));
// 18.09.09
        Sistema.SetField('mpdd_situacao','P');
        Sistema.Post('mpdd_status=''N'' and mpdd_numerodoc='+EdNumerodoc.AsSql+
//                ' and mpdd_tipomov='+Stringtosql(Tipomov)+
                ' and mpdd_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
                ' and mpdd_esto_codigo='+Stringtosql(Grid.cells[Grid.getcolumn('move_esto_codigo'),linha])+
                sqltamanho+
//                ' and mpdd_tama_codigo='+Grid.cells[Grid.getcolumn('codtamanho'),linha]+
//                ' and mpdd_core_codigo='+Grid.cells[Grid.getcolumn('codcor'),linha]+
                sqlcopa+
                sqlcor+
                ' and mpdd_tipo_codigo='+EdCliente.AsSql );
// 01.11.17
/////////////////////////////////////////////////////////////////////////////////////////////
        if (Global.Topicos[1420]) and ( tipomov='OS' ) then begin

             if strtointdef(Grid.cells[Grid.getcolumn('codtamanho'),linha],0) > 0 then
               sqlcustama:=' and cust_tama_codigo='+Grid.cells[Grid.getcolumn('codtamanho'),linha]
             else
               sqlcustama:='';
             if strtointdef(Grid.cells[Grid.getcolumn('codcor'),linha],0) > 0 then
               sqlcuscor:=' and cust_tama_codigo='+Grid.cells[Grid.getcolumn('codcor'),linha]
             else
               sqlcuscor:='';
//            QCusto:=sqltoquery('select * from custos inner join estoque on ( esto_codigo=cust_esto_codigomat )'+
// 17.04.18
            QCusto:=sqltoquery('select * from custos left join estoque on ( esto_codigo=cust_esto_codigomat )'+
                ' where cust_status='+StringtoSql('N')+
                ' and cust_esto_codigo='+Stringtosql(Grid.cells[Grid.getcolumn('move_esto_codigo'),linha])+
                sqlcustama+sqlcuscor+' order by mpdd_esto_codigo');
// aqui colocar mpdd_ordem no order apos ajustar a gravacao da OS e criar o campo ( + campos de temperatura e tempo )
            xseq:=1;
            while not QCusto.Eof do begin

                Sistema.Insert('movpeddet');
                Sistema.SetField('mpdd_esto_codigo',QCusto.FieldByName('cust_esto_codigomat').AsString);
                Sistema.SetField('mpdd_tama_codigo',QCusto.FieldByName('cust_tama_codigo').AsInteger);
                Sistema.SetField('mpdd_core_codigo',QCusto.FieldByName('cust_core_codigo').AsInteger);
                Sistema.SetField('mpdd_transacao',transacao);
                Sistema.SetField('mpdd_operacao',FGeral.GetOperacao);
                Sistema.SetField('mpdd_numerodoc',Ednumerodoc.Asinteger);
                Sistema.SetField('mpdd_status','N');
                Sistema.SetField('mpdd_tipomov','OP');
                Sistema.SetField('mpdd_unid_codigo',EdUnid_codigo.text);
                Sistema.SetField('mpdd_tipo_codigo',EdCliente.AsInteger);
                Sistema.SetField('mpdd_tipocad','C');
                Sistema.SetField('mpdd_qtde',Texttovalor(Grid.cells[Grid.getcolumn('qtde'),linha])*Qcusto.FieldByName('cust_qtde').AsCurrency );
                Sistema.SetField('mpdd_datalcto',EdDtEmissao.Asdate);
                Sistema.SetField('mpdd_datamvto',Sistema.Hoje);
                Sistema.SetField('mpdd_venda',1);
                Sistema.SetField('mpdd_grup_codigo',Qcusto.fieldbyname('esto_grup_codigo').AsInteger);
                Sistema.SetField('mpdd_sugr_codigo',Qcusto.fieldbyname('esto_sugr_codigo').AsInteger);
                Sistema.SetField('mpdd_fami_codigo',Qcusto.fieldbyname('esto_fami_codigo').AsInteger);
                Sistema.SetField('mpdd_mate_codigo',Qcusto.fieldbyname('esto_mate_codigo').AsInteger);
                Sistema.SetField('mpdd_emlinha',QCusto.fieldbyname('esto_emlinha').AsString);
                Sistema.SetField('mpdd_usua_codigo',Global.Usuario.codigo);
                Sistema.SetField('mpdd_repr_codigo',EdRepr_codigo.asinteger);
                Sistema.SetField('mpdd_datacont',EdDtmovimento.asdate);
                Sistema.SetField('mpdd_qtdeenviada',0);
                Sistema.SetField('mpdd_vendabru',1);
                Sistema.SetField('mpdd_perdesco',0);
                Sistema.SetField('mpdd_caoc_codigo',0);
                Sistema.SetField('mpdd_situacao','P');
                Sistema.SetField('mpdd_seq',xseq );
//                Sistema.SetField('mpdd_perdescre',Texttovalor(Grid.cells[Grid.getcolumn('mpdd_perdescre'),linha]) );
                if campopecas.tipo<>'' then
                  Sistema.SetField('mpdd_pecas',Texttovalor(Grid.cells[Grid.getcolumn('mpdd_pecas'),linha]) );
                Sistema.Post('');
                inc(xseq);
                QCusto.Next

            end;
            FGeral.FechaQuery(QCusto);

        end;



      end;
    end;
  end;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TFPedVenda.GravaMestrePedVendas(Emissao: TDatetime;
  Cliente: TSqlEd; Unidade, TipoMovimento, Transacao: string;
  Numero: Integer; Valortotal: currency; Tabela: Integer; OP: string);
///////////////////////////////////////////////////////////////////////////////
begin

  if Op='I' then begin

    Sistema.Insert('Movped');
    Sistema.SetField('mped_transacao',Transacao);
    Sistema.SetField('mped_operacao',FGeral.GetOperacao);
    Sistema.SetField('mped_status','N');
    Sistema.SetField('mped_numerodoc',Numero);
    if trim(tipomovimento)<>'' then
      Sistema.SetField('mped_tipomov',TipoMovimento)
    else
      Sistema.SetField('mped_tipomov',Global.CodPedVenda);
    Sistema.SetField('mped_unid_codigo',Unidade);
    Sistema.SetField('mped_tipo_codigo',Cliente.AsInteger);
    Sistema.SetField('mped_datalcto',Sistema.Hoje);
    Sistema.SetField('mped_datamvto',Emissao);
    Sistema.SetField('mped_datacont',EdDtmovimento.Asdate);
    Sistema.SetField('mped_vlrtotal',Valortotal);
    if FCondpagto.GetAvPz(EdFpgt_codigo.text)='V' then
      Sistema.SetField('mped_valoravista',Valortotal)
    else
      Sistema.SetField('mped_valoravista',Valorparteavista);
    Sistema.SetField('mped_tabp_codigo',Tabela);
    Sistema.SetField('mped_fpgt_codigo',EdFpgt_codigo.text);
    Sistema.SetField('mped_tabaliquota',FTabela.GetAliquota(Tabela));
    Sistema.SetField('mped_usua_codigo',Global.Usuario.Codigo);
    Sistema.SetField('mped_pedcliente',EdPedidocliente.asinteger);
    Sistema.SetField('mped_estado',Cliente.resultfind.fieldbyname('clie_uf').asstring);
    Sistema.SetField('mped_cida_codigo',Cliente.resultfind.fieldbyname('clie_cida_codigo_res').asinteger);
    Sistema.SetField('mped_repr_codigo',EdRepr_codigo.asinteger);
    Sistema.SetField('mped_tipocad','C');
    Sistema.SetField('mped_dataemissao',Emissao);
    Sistema.SetField('mped_totprod',Edtotalprodutos.ascurrency);
    Sistema.SetField('mped_vispra',FCondpagto.GetAvPz(EdFpgt_codigo.text));
// ver se vai usar
    Sistema.SetField('mped_perdesco',0);
    Sistema.SetField('mped_peracres',0);
    Sistema.SetField('mped_situacao','P');
    Sistema.SetField('mped_formaped',EdFormapedido.text);
    Sistema.SetField('mped_envio',EdFormaenvio.text);
    Sistema.SetField('Mped_fpgt_prazos',FCondpagto.GetCampoPrazos(EdFpgt_codigo.text));
    Sistema.SetField('mped_contatopedido',EdContato.text);
// 13.12.05
    Sistema.SetField('mped_datapedcli',EdDatacliente.asdate);
// 25.04.06
    Sistema.SetField('mped_obslibcredito',obsliberacao);
    Sistema.SetField('mped_datalibcredito',sistema.hoje);
    Sistema.SetField('mped_usualibcred',usuariolib);
// 16.04.09
    Sistema.SetField('mped_obspedido',Edobspedido.text);
// 01.06.11
    if campoportador.Tipo<>'' then
      Sistema.SetField('mped_port_codigo',EdPort_codigo.text);
 // 06.02.19
    if campocomissao.Tipo<>'' then begin

       Sistema.SetField('mped_vlrcomissao',Edvlrcomissao.ascurrency);
       Sistema.SetField('mped_percomissao',Edpercomissao.ascurrency);

    end;

    Sistema.Post();
// 12.03.10
    if pos(tipomov,'PV;OS')>0 then
      FGeral.GravaPendencia(Emissao,emissao,EdCliente,'C',0,unidade,tipomov,transacao,EdFpgt_codigo.text,'R',Numero,0,valortotal,
                          0,'H',valortotal,0,GridParcelas,'','001' );


  end else begin

    Sistema.Edit('Movped');
//////////////////////////////////////////    Sistema.SetField('mped_tipo_codigo',Cliente.AsInteger);
// 10.04.06 - retirado devido a mestre com um cliente e detalhe com outro ( o correto )
    if trim(tipomovimento)<>'' then
      Sistema.SetField('mped_tipomov',TipoMovimento)
    else
      Sistema.SetField('mped_tipomov',Global.CodPedVenda);
//    Sistema.SetField('mped_tipomov',TipoMovimento);   // 07.12.05
    Sistema.SetField('mped_datalcto',Sistema.Hoje);
    Sistema.SetField('mped_datamvto',Emissao);
    Sistema.SetField('mped_datacont',EdDtmovimento.Asdate);
    Sistema.SetField('mped_vlrtotal',Valortotal);
    if FCondpagto.GetAvPz(EdFpgt_codigo.text)='V' then
      Sistema.SetField('mped_valoravista',Valortotal)
    else
      Sistema.SetField('mped_valoravista',Valorparteavista);
    Sistema.SetField('mped_tabp_codigo',Tabela);
    Sistema.SetField('mped_fpgt_codigo',EdFpgt_codigo.text);
    Sistema.SetField('mped_tabaliquota',FTabela.GetAliquota(Tabela));
    Sistema.SetField('mped_usua_codigo',Global.Usuario.Codigo);
    Sistema.SetField('mped_pedcliente',EdPedidocliente.asinteger);
    Sistema.SetField('mped_estado',Cliente.resultfind.fieldbyname('clie_uf').asstring);
    Sistema.SetField('mped_cida_codigo',Cliente.resultfind.fieldbyname('clie_cida_codigo_res').asinteger);
    Sistema.SetField('mped_repr_codigo',EdRepr_codigo.asinteger);
    Sistema.SetField('mped_tipocad','C');
    Sistema.SetField('mped_dataemissao',Emissao);
    Sistema.SetField('mped_totprod',Edtotalprodutos.ascurrency);
    Sistema.SetField('mped_vispra',FCondpagto.GetAvPz(EdFpgt_codigo.text));
// ver se vai usar
    Sistema.SetField('mped_perdesco',0);
    Sistema.SetField('mped_peracres',0);
    Sistema.SetField('mped_situacao','P');

    Sistema.SetField('mped_formaped',EdFormapedido.text);
    Sistema.SetField('mped_envio',EdFormaenvio.text);
    Sistema.SetField('mped_fpgt_codigo',EdFpgt_codigo.text);
    Sistema.SetField('Mped_fpgt_prazos',FCondpagto.GetCampoPrazos(EdFpgt_codigo.text));
    Sistema.SetField('mped_contatopedido',EdContato.text);
    Sistema.SetField('mped_datapedcli',EdDatacliente.asdate);
// 16.04.09
    Sistema.SetField('mped_obspedido',Edobspedido.text);
// 01.06.11
    if campoportador.Tipo<>'' then
      Sistema.SetField('mped_port_codigo',EdPort_codigo.text);
    Sistema.Post('mped_transacao='+stringtosql(transacao));
 // 06.02.19
    if campocomissao.Tipo<>'' then begin

       Sistema.SetField('mped_vlrcomissao',Edvlrcomissao.ascurrency);
       Sistema.SetField('mped_percomissao',Edpercomissao.ascurrency);

    end;

// 04.04.14 - acerta o valor da previsao de pendencia - status H
//    Sistema.Edit('pendencias');
//    Sistema.SetField('pend_valor',Valortotal);
//    Sistema.Post('pend_transacao='+Stringtosql(transacao)+' and pend_status=''H''');
// 06.02.10
    if pos(tipomov,'PV;OS')>0 then begin

       ExecuteSql('update pendencias set pend_status = ''C'' where pend_transacao='+stringtosql(transacao)+
                  ' and pend_status = ''H''');

       FGeral.GravaPendencia(Emissao,emissao,EdCliente,'C',0,unidade,tipomov,transacao,EdFpgt_codigo.text,'R',Numero,0,valortotal,
                          0,'H',valortotal,0,GridParcelas,'','001' );
    end;

  end;

end;

procedure TFPedVenda.EdFormaenvioValidate(Sender: TObject);
begin
{
   if EdFormaenvio.text='R' then
     EdDtmovimento.text:=''
   else
     EdDtmovimento.setdate(EdDtemissao.asdate);
}
end;

procedure TFPedVenda.bGravarClick(Sender: TObject);
var Numero:integer;
    restricao,restricao4:boolean;
begin
//  if not EdFormapedido.valid then begin
  if notagerada>0 then begin
        Avisoerro('Nota Fiscal '+inttostr(notagerada)+' j� gerada');
        exit;
  end;
//  if EdFormapedido.isempty then begin
//    Avisoerro('Checar forma do pedido');
//    exit;
//  end;
//  if not EdFormaenvio.valid then begin
//  if ( EdFormaenvio.isempty then begin
//    Avisoerro('Checar forma do envio');
//    exit;
//  end;
  if EdFpgt_codigo.isempty then begin
// 25.04.06
//  if not EdFpgt_codigo.valid then begin
//    Avisoerro('Checar condi��o de pagamento');
    exit;
  end;
  if (EdDtemissao.AsDate<=1) or (EdCliente.AsInteger=0) or (Grid.RowCount<=1)then
    exit;
  if trim( GridParcelas.Cells[GridParcelas.getcolumn('pend_datavcto'),1] )='' then begin
    Avisoerro('Checar condi��o de pagamento');
    exit;
  end;
//////////
// 09.05.06
  if (not EdRepr_codigo.validfind) or ( EdRepr_codigo.isempty ) then begin
    Avisoerro('Checar codigo do representante');
    exit;
  end;
//
// 13.06.11 - Novi - Isonel
///////////
  if ( FCondPagto.GetAvPz(EdFpgt_codigo.text)='P') and (OP='I') then begin
    if not FCidades.ValidaFatporCidade(EdCliente.ResultFind.fieldbyname('Clie_cida_codigo_res').AsInteger,
           global.Usuario.Codigo,EdNumerodoc.asinteger,EdTotalRemessa.ascurrency ) then exit;
  end;
// 26.03.12 - Novi - Isonel
///////////
  if ( FCondPagto.GetAvPz(EdFpgt_codigo.text)='P') and (OP='I') and (Global.Topicos[1406])  then begin

      if not FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','LIM',Global.CodigoUnidade,EdTotalRemessa.ascurrency ) then begin
// 16.04.19 - devido a ajustes do cadastro de usuarios por isonel come�ou a checar aqui o limite
//            porem sem opcao de libera  o credito nesta venda
// o usuario monir 23 aparece mesma msg porem em seguida aparece opcao de liberar o credito da venda
// porem nao descobri 'qual o esquema' do usuario dele...
// retornado como estava senao pedia liberacao de limite para todos os pedidos...
        if not FGEral.ValidaLiberacaoLimite(Global.usuario.codigo) then begin
          EdCliente.Invalid('');
          exit;
        end;

      end;

  end;
{ - retirado em 24.04.06 - pois pedira usuario pra liberar venda mesmo com restri��o de cr�dito
  if ( FCondPagto.GetAvPz(EdFpgt_codigo.text)='P') and (OP='I') then begin
      if not FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P',portador ) then
        exit;
  end;
}
////////////////////////////////
// 07.07.14 - Novicarnes - Elize
  if (Global.Topicos[1415])  then begin
     if trim( EdCliente.resultfind.fieldbyname('clie_fpgt_codigo').asstring ) = '' then begin
         EdCliente.Invalid('Ainda n�o definido a condi��o de pagamento neste cliente');
         exit;
     end;
  end;
// 11.11.14 - Vivan
  if trim( EdCliente.resultfind.fieldbyname('clie_situacao').asstring ) = 'B' then begin
         EdCliente.Invalid('Verificar situa��o do cliente : '+EdCliente.resultfind.fieldbyname('clie_situacao').asstring );
         exit;
  end;
  if Global.Topicos[1413] then begin
// 11.11.14 - vivan cobran�a angela
      if (trim (EdCliente.ResultFind.fieldbyname('Clie_portadores').asstring)<>'') then begin
        if pos( EdPort_codigo.text,EdCliente.ResultFind.fieldbyname('Clie_portadores').asstring ) = 0 then begin
          Avisoerro('Cliente possui somente os seguintes portadores :'+EdCliente.ResultFind.fieldbyname('Clie_portadores').asstring);
          exit;
        end;
      end else begin;
        Avisoerro('Ainda n�o definido portador(es) neste cliente');
        exit
      end;
  end;
//////////
///////////
// 18.03.15 - Vivan
  if  not FGeral.ValidaCadastro(EdCliente.ResultFind.FieldByName('clie_situacao').AsString) then exit;
//////////
// 06.05.15 - vivan - cecilia
    if (Global.Topicos[1414]) then begin
      if (OP='I') and (Global.Topicos[1029]) then begin
          restricao4:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','LIM',Global.Usuario.UnidadesMvto,EdTotalRemessa.ascurrency );
      end;
  // 18.11.13 - vivan - Liane - checagem de RC em aberto
//    16.05.14 - para pedido 'de frigorifico' pode passar...
      if (OP='I')  and ( not frigorifico) then begin
          restricao:=FGeral.ValidaCliente( EdCliente,Global.CodRemessaConsig,'P','REM',Global.Usuario.UnidadesMvto,EdTotalRemessa.ascurrency );
      end;
      if not restricao4  then begin // total em aberto versus limite de cr�dito
            if not FGEral.ValidaLiberacaoLimite(Global.usuario.codigo) then begin
              EdProduto.Invalid('');
              exit;
            end;
      end;
  // 18.11.13
      if not restricao  then begin // total de RC em aberto versus limite de RC
            if not FGEral.ValidaLiberacaoLimite(Global.usuario.codigo) then begin
              EdProduto.Invalid('');
              exit;
            end;
      end;
    end;
//////////////////

  if confirma('Confirma grava��o ?') then begin

    if OP='I' then begin

// 06.02.19
      if Global.Topicos[1424] then begin

          Numero:=FGeral.GetContador('PEDVENDA'+EdTipoPed.Text,false);

      end else

          Numero:=FGeral.GetContador('PEDVENDA',false);

      EdNumerodoc.Text:=inttostr(Numero);

//      bocorrenciaClick(FPedVenda);

      Sistema.BeginTransaction('Gravando');

      Transacao:=FGeral.GetTransacao;
      GravaMestrePedVendas(EdDtEmissao.AsDate,EdCliente,EdUnid_codigo.text,
             TipoMOv,Transacao,Numero,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger);
      GravaItensPedVendas(EdDtEmissao.AsDate,EdCliente,EdUnid_codigo.text,
             Tipomov,Transacao,Numero,Grid);


      Sistema.EndTransaction('Gravado pedido numero '+EdNUmerodoc.text);

// 28.01.15
      if Global.topicos[1418] then begin
        if confirma('Confirma impress�o') then
          FImpressao.ImprimePedidoVenda(EdNumerodoc.asinteger,EdDtemissao.asdate,edunid_codigo.text,'N',Tipomov)
      end else
          FImpressao.ImprimePedidoVenda(EdNumerodoc.asinteger,EdDtemissao.asdate,edunid_codigo.text,'N',Tipomov);

    end else if OP='A' then begin

// 01.11.17
      if (Global.Topicos[1420]) and ( tipomov='OS' ) then begin

        Sistema.Edit('movpeddet');
        Sistema.SetField('mpdd_status','C');
        Sistema.Post('mpdd_tipomov = ''OP'''+
                     ' and mpdd_numerodoc = '+EdNumerodoc.AsSql+
                     ' and mpdd_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                     ' and mpdd_tipo_codigo = '+EdCliente.AsSql );
        Sistema.Commit;

      end;

      GravaMestrePedVendas(EdDtEmissao.AsDate,EdCliente,EdUnid_codigo.text,
             Tipomov,Transacao,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger,Op);
      GravaItensPedVendas(EdDtEmissao.AsDate,EdCliente,EdUnid_codigo.text,
             Tipomov,Transacao,Numero,Grid);
      Sistema.Commit;

    end;

//    EdCliente.Clearall(FPedVenda,99);
// 09.07.2021 - sen�o apaga o 'PV' e data...
    EdCliente.Clear;
    EdFpgt_codigo.Clearall(FPedVenda,99);
    EdProduto.Clearall(FPedVenda,99);
    EdDtEmissao.setdate(sistema.hoje);
    Eddatacliente.setdate(sistema.hoje);
    EdUnid_codigo.text:=Global.CodigoUnidade;

    Grid.Clear;
    Gridparcelas.Clear;
    if OP='I' then
      EdCliente.Setfocus
    else
      EdNumerodoc.SetFocus;
  end;
end;

procedure TFPedVenda.bSairClick(Sender: TObject);
begin
  Grid.Clear;
  Close;

end;

procedure TFPedVenda.bIncluiritemClick(Sender: TObject);
////////////////////////////////////////////////////////////////////
begin

  if EdCliente.AsInteger=0 then exit;
  if OP='A' then begin
    if PedidoFaturado(EdNumerodoc.asinteger) then begin
       Avisoerro('Pedido j� faturado');
       exit;
    end;
  end;
  if campounidadesmvto.Tipo<>'' then begin
    if not EdMoes_tabp_codigo.Valid then exit;
  end;

// 26.01.2021
  FPedVenda.bultimos.enabled := true;

  OpBotao:='I';
  PRemessa.Enabled:=false;
  bGravar.Enabled:=false;
  bSair.Enabled:=false;
  bCancelar.Enabled:=false;
  PINs.Visible:=true;
  PINs.EnableEdits;
  EdPacotes.Enabled:=Global.Topicos[1402];
  EdPacotes.Visible:=Global.Topicos[1402];
  EdFardos.Enabled:=Global.Topicos[1402];
  EdFardos.Visible:=Global.Topicos[1402];
  EdDescubagem.Enabled:=Global.Topicos[1402];
  EdDescubagem.Visible:=Global.Topicos[1402];
// 16.03.09
//  EdUnitario.enabled:=Global.Usuario.OutrosAcessos[0034];
// 26.09.09
  FPedVenda.EdUnitario.enabled:=Global.Usuario.OutrosAcessos[0501];

  LimpaEditsItens;
  EdProduto.enabled:=true;
//  EdCodcor.enabled:=true;
//  EdCodtamanho.enabled:=true;
//  EdCodcopa.enabled:=true;
  EdProduto.SetFocus;

end;

procedure TFPedVenda.LimpaEditsItens;
begin
  EdProduto.Clearall(FPedvenda,99);;

end;

procedure TFPedVenda.bExcluiritemClick(Sender: TObject);
//////////////////////////////////////////////////////////
var codigoestoque,sqlcor,sqltamanho:string;
    qtde:currency;
    codcor,codtamanho:string;
begin
  if EdCliente.AsInteger=0 then exit;
  if OP='A' then begin
    if PedidoFaturado(EdNumerodoc.asinteger) then begin
       Avisoerro('Pedido j� faturado');
       exit;
    end;
  end;
  if trim(Grid.Cells[0,Grid.row])='' then exit;
  if confirma('Confirma exclus�o ?') then begin
    codigoestoque:=Grid.Cells[Grid.getcolumn('move_esto_codigo'),Grid.row];
//    qtde:=texttovalor(Grid.Cells[grid.getcolumn('qtde'),Grid.row]);
    codtamanho:=Grid.Cells[Grid.getcolumn('codtamanho'),Grid.row];
    codcor:=Grid.Cells[Grid.getcolumn('codcor'),Grid.row];
// 16.03.18
    if trim(codtamanho)<>'' then
      sqltamanho:=' and mpdd_tama_codigo='+codtamanho
    else
      sqltamanho:='';
    if trim(codcor)<>'' then
      sqlcor:=' and mpdd_core_codigo='+codcor
    else
      sqlcor:='';
    Grid.DeleteRow(Grid.Row);
    Calculatotal;
    if not EdFpgt_codigo.isempty then
      EdFpgt_codigo.valid;
    if OP='A' then begin
      ExecuteSql('Update movpeddet set mpdd_status=''C'' where mpdd_status=''N'''+
          ' and mpdd_numerodoc='+EdNumerodoc.AsSql+
          ' and mpdd_tipomov='+Stringtosql(EdTipoPed.text)+
          ' and mpdd_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and mpdd_tipo_codigo='+EdCliente.AsSql+
          sqltamanho+
          sqlcor+
          ' and mpdd_esto_codigo='+Stringtosql(codigoestoque) ) ;
      GravaMestrePedVendas(EdDtEmissao.AsDate,EdCliente,EdUnid_codigo.text,
             EdTipoPed.text,Transacao,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger,Op);

    end;
    Sistema.Commit;
    EdFpgt_codigo.setfocus;
  end;

end;

procedure TFPedVenda.Campostoedits(Q: TSqlquery);
////////////////////////////////////////////////////
var Qp:TSqlquery;
    p:integer;
begin

  EdCliente.Text:=Q.fieldbyname('mped_tipo_codigo').AsString;
  EdUnid_codigo.Text:=Q.fieldbyname('mped_unid_codigo').AsString;
  EdDtEmissao.SetDate(Q.fieldbyname('mped_datamvto').AsDateTime);
  EdTotalremessa.SetValue(Q.fieldbyname('mped_vlrtotal').AsCurrency);
  Edmoes_tabp_codigo.SetValue(Q.fieldbyname('mped_tabp_codigo').AsInteger);
  EdFpgt_codigo.text:=Q.fieldbyname('mped_fpgt_codigo').Asstring;
  SetEdTabp_aliquota.Text:=FTabela.GetDescAliquota(Q.fieldbyname('mped_tabp_codigo').AsInteger);
  EdUnid_codigo.ValidateEdit;
  EdCliente.ValidateEdit;
//  EdFpgt_codigo.validateedit;
  EdFpgt_codigo.validfind;
// 09.04.10 - agora traz o q foi digitado na inclusao
  EdRepr_codigo.text:=Q.fieldbyname('mped_repr_codigo').AsString;
  EdPedidocliente.text:=Q.fieldbyname('mped_pedcliente').AsString;
  EdFormapedido.text:=Q.fieldbyname('mped_formaped').AsString;
  EdFormaenvio.text:=Q.fieldbyname('mped_envio').AsString;
  EdDtmovimento.setdate(Q.fieldbyname('mped_datacont').AsDatetime);
  EdContato.text:=Q.fieldbyname('mped_contatopedido').AsString;
  Edtipoped.text:=Q.fieldbyname('mped_tipomov').AsString;
  EdDatacliente.setdate(Q.fieldbyname('mped_datapedcli').asdatetime);
  tipomov:=EdTipoped.text;
  EdTipoped2.text:=Edtipoped.text;
  EdDigitado.text:=strzero(Q.fieldbyname('mped_usua_codigo').asinteger,3)+'-'+FUsuarios.getnome(Q.fieldbyname('mped_usua_codigo').asinteger);
// 25.09.09
  EdObsPedido.text:=Q.fieldbyname('mped_obspedido').AsString;
// 01.06.11
  if campoportador.tipo<>'' then begin
    EdPOrt_codigo.text:=Q.fieldbyname('mped_port_codigo').AsString;
    EdPort_codigo.validfind;
  end;
// 06.02.19
  Edfpgt_codigo.text:=Q.FieldByName('mped_fpgt_codigo').AsString;
  if campocomissao.Tipo<>'' then begin

     Edvlrcomissao.setvalue(Q.fieldbyname('mped_vlrcomissao').AsCurrency);
     Edpercomissao.setvalue(Q.fieldbyname('mped_percomissao').AsCurrency);

  end;

// 09.04.10
  QP:=sqltoquery( FGeral.BuscaTransacao(Transacao,'pendencias','pend_transacao','pend_status','H','') );
  p:=1;
  GridParcelas.clear;
  while not Qp.eof do begin
    Gridparcelas.cells[Gridparcelas.Getcolumn('pend_valor'),p]:=Formatfloat(f_cr,Qp.fieldbyname('pend_valor').ascurrency);
    Gridparcelas.cells[Gridparcelas.Getcolumn('pend_datavcto'),p]:=Formatdatetime('dd/mm/yy',Qp.fieldbyname('pend_datavcto').asdatetime);
    inc(p);
    Qp.Next;
    if p>Gridparcelas.RowCount then
        Gridparcelas.RowCount:=p+1;
  end;
  FGeral.Fechaquery(qp);

end;

////////////////////////////////////////////////
procedure TFPedVenda.Campostogrid(Q: TSqlquery);
////////////////////////////////////////////////
var p:integer;
begin
  Grid.Clear;p:=1;Q.First;
  while not Q.Eof do begin

    Grid.Cells[grid.getcolumn('move_esto_codigo'),Abs(p)]:=Q.fieldbyname('mpdd_esto_codigo').Asstring;
    Grid.Cells[grid.getcolumn('esto_descricao'),Abs(p)]:=FEstoque.GetDescricao(Q.fieldbyname('mpdd_esto_codigo').Asstring);
    Grid.Cells[grid.getcolumn('tamanho'),Abs(p)]:=FTamanhos.getdescricao(Q.fieldbyname('mpdd_tama_codigo').Asinteger);
    Grid.Cells[grid.getcolumn('cor'),Abs(p)]:=FCores.getdescricao(Q.fieldbyname('mpdd_core_codigo').Asinteger);
// 12.08.14 - Devereda
    Grid.Cells[grid.getcolumn('mpdd_qtdeenviada'),Abs(p)]:=Transform(Q.fieldbyname('mpdd_qtdeenviada').ascurrency,f_cr);
    if (Global.Usuario.OutrosAcessos[0335]) and (Q.fieldbyname('mpdd_qtdeenviada').ascurrency>0) then begin
      Grid.Cells[grid.getcolumn('totalitem'),Abs(p)]:=TRansform((-1)*(Q.fieldbyname('mpdd_qtdeenviada').ascurrency)*Q.fieldbyname('mpdd_venda').Ascurrency,f_cr);
    end else begin
      Grid.Cells[grid.getcolumn('totalitem'),Abs(p)]:=TRansform(Q.fieldbyname('mpdd_qtde').Ascurrency*Q.fieldbyname('mpdd_venda').Ascurrency,f_cr);
    end;
    Grid.Cells[grid.getcolumn('qtde'),Abs(p)]:=TRansform(Q.fieldbyname('mpdd_qtde').Ascurrency,f_cr);
    Grid.Cells[grid.getcolumn('venda'),Abs(p)]:=TRansform(Q.fieldbyname('mpdd_venda').Ascurrency,f_cr);
    Grid.Cells[grid.getcolumn('vendabru'),Abs(p)]:=TRansform(Q.fieldbyname('mpdd_vendabru').Ascurrency,f_cr);
    Grid.Cells[grid.getcolumn('codtamanho'),Abs(p)]:=Q.fieldbyname('mpdd_tama_codigo').Asstring;
    Grid.Cells[grid.getcolumn('codcor'),Abs(p)]:=Q.fieldbyname('mpdd_core_codigo').Asstring;
    Grid.Cells[grid.getcolumn('vendabru'),Abs(p)]:=TRansform(Q.fieldbyname('mpdd_vendabru').Ascurrency,f_cr);
    Grid.Cells[grid.getcolumn('move_seq'),Abs(p)]:=strzero(Q.fieldbyname('mpdd_seq').Asinteger,3);
    Grid.Cells[grid.getcolumn('esto_sisvendas'),Abs(p)]:=Festoque.GetSistemaVendas(Q.fieldbyname('mpdd_esto_codigo').Asstring,Q.fieldbyname('mpdd_unid_codigo').Asstring);
    Grid.Cells[grid.getcolumn('copa'),Abs(p)]:=FCopas.getdescricao(Q.fieldbyname('mpdd_copa_codigo').Asinteger);
    Grid.Cells[grid.getcolumn('codcopa'),Abs(p)]:=Q.fieldbyname('mpdd_copa_codigo').Asstring;
// 01.02.07
    Grid.Cells[grid.getcolumn('mpdd_pacotes'),Abs(p)]:=Q.fieldbyname('mpdd_pacotes').Asstring;
    Grid.Cells[grid.getcolumn('mpdd_fardos'),Abs(p)]:=Q.fieldbyname('mpdd_fardos').Asstring;
    Grid.Cells[grid.getcolumn('mpdd_cubagem'),Abs(p)]:=Transform(Q.fieldbyname('mpdd_cubagem').Asfloat,f_cr3);
// 14.02.07
    Grid.Cells[grid.getcolumn('mpdd_perdescre'),Abs(p)]:=Transform(Q.fieldbyname('mpdd_perdescre').Asfloat,f_cr);
// 02.06.11
    if campopecas.tipo<>'' then
      Grid.Cells[grid.getcolumn('mpdd_pecas'),Abs(p)]:=Transform(Q.fieldbyname('mpdd_pecas').Asfloat,f_cr);
// 15.08.12 - Novi - Isonel
    Grid.Cells[grid.getcolumn('totalpeso'),Abs(p)]:=Transform(Q.fieldbyname('mpdd_pecas').Asfloat*Q.fieldbyname('mpdd_qtde').Ascurrency,f_cr);
// 18.06.13 - Metalforte
    Grid.Cells[grid.getcolumn('esto_referencia'),Abs(p)]:=FEstoque.GetReferencia(Q.fieldbyname('mpdd_esto_codigo').Asstring) ;
// 21.02.20
    if ProdutoGenerico( Q.fieldbyname('mpdd_esto_codigo').Asstring ) then
       Grid.Cells[grid.getcolumn('esto_descricao'),Abs(p)]:=Q.fieldbyname('mpdd_esto_descricao').Asstring;

    inc(p);
    Grid.AppendRow;
    Q.Next;
  end;
end;

procedure TFPedVenda.EdFpgt_codigoKeyPress(Sender: TObject; var Key: Char);
begin
   FGeral.LImpaEdit(Edfpgt_codigo,key);

end;

procedure TFPedVenda.EdFpgt_codigoValidate(Sender: TObject);
var nparcelas,n:integer;
    ListaPrazo:TStringlist;
    p:integer;
    valorparcela,valortotal,valoravista,acumulado:currency;

    function ChecaQMostruario:string;
    var p,pm,pc:integer;
        produto,sisvendas:string;
    begin
       pm:=0; pc:=0;
       for p:=1 to Grid.rowcount do begin
         produto:=Grid.cells[Grid.getcolumn('move_esto_codigo'),p];
         if trim(produto)<>'' then begin
            sisvendas:=Grid.cells[Grid.getcolumn('esto_sisvendas'),p];
            if pos( Global.SisVenMagazine,sisvendas ) >0 then
              inc(pm);
            if pos( Global.SisVenConsignado,sisvendas ) >0 then
              inc(pc);
         end;
       end;
       if pm>=pc then
         result:=global.CodPedVendaMostruario
       else
         result:=global.CodPedVendaMostruarioConsig;
       aviso('Produtos '+Global.CodPedVendaMostruario+' : '+inttostr(pm)+'  '+Global.CodPedVendaMostruarioConsig+' : '+inttostr(pc));
    end;

begin

  if not EdFpgt_codigo.validfind then exit;
  if (op='I') or (EdFpgt_codigo.text<>EdFpgt_codigo.OldValue) then
    GridParcelas.Clear;
  if ( (FCondPagto.GetAvPz(EdFpgt_codigo.text)='P') and (OP='I') ) or (EdFpgt_codigo.text<>EdFpgt_codigo.OldValue ) then begin
    ListaPrazo:=TStringlist.create;
    n:=FCondPagto.GetPrazos(EdFpgt_codigo.text,ListaPrazo);
    valoravista:=FGeral.GetValorAvista(Listaprazo);
    valorparteavista:=valoravista;
    nparcelas:=FCondPagto.GetNumeroParcelas(EdFpgt_codigo.text);
/////////////////////////////////////////////////////////////////
// 11.03.05 - reges pegou bug quando tem parte a vista e mais de duas parcelas
    valortotal:=EdTotalRemessa.AsCurrency- valoravista;
    acumulado:=0;
    for p:=1 to nparcelas do begin
      GridParcelas.cells[0,p]:=formatdatetime('dd/mm/yy',FGeral.GetProximoDiaUtil(EdDtEmissao.Asdate+Inteiro(ListaPrazo[p-1]),Inteiro(ListaPrazo[p-1]))  );
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
    if EdTotalremessa.ascurrency>0 then begin
      if OP='I' then begin
//        if Edtotalremessa.ascurrency>FGeral.getconfig1asfloat('valorpedidopac') then
//          EdFormaEnvio.text:='P'
//        else
//          EdFormaEnvio.text:='';
      end;
    end;
    Freeandnil(ListaPrazo);
  end;
  if pos( EdTipoped.text,Global.CodPedVendaMostruario+';'+Global.CodPedVendaMostruarioConsig ) >0 then begin
    EdTipoPed2.text:=ChecaQMostruario;
  end;
end;

procedure TFPedVenda.EdVencimentoExitEdit(Sender: TObject);
begin
  GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=DateToStr_(EdVencimento.AsDate);
  GridParcelas.SetFocus;
  EdVencimento.Visible:=False;

end;

procedure TFPedVenda.EdParcelaExitEdit(Sender: TObject);
begin
  GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=Transform(EdParcela.AsFloat,f_cr);
  GridParcelas.SetFocus;
  EdParcela.Visible:=False;

end;

procedure TFPedVenda.bocorrenciaClick(Sender: TObject);
begin
//  if (Edcliente.valid) or (OP='A') then
  if ( not Edcliente.isempty) or (OP='A') then
    FOcorrencias.Execute('C',EdCliente.asinteger,EdCliente.resultfind.fieldbyname('clie_nome').asstring,'',EdNumerodoc.asinteger);
end;

procedure TFPedVenda.bimpClick(Sender: TObject);
begin
  if EdNumerodoc.asinteger>0 then
    FImpressao.ImprimePedidoVenda(EdNumerodoc.asinteger,EdDtemissao.asdate,edunid_codigo.text,'N',Edtipoped.Text)
end;

procedure TFPedVenda.bcancpedidoClick(Sender: TObject);
begin
   if EdNumerodoc.asinteger<=0 then exit;
//   if not EdCliente.valid then exit;
   if EdCliente.isempty then exit;
   EdCaoc_codigo.enabled:=true;
   EdCaoc_codigo.visible:=true;
   EdCaoc_codigo.setfocus;

end;

function TFPedVenda.PedidoFaturado(Numerodoc:integer): boolean;
////////////////////////////////////////////////////////////////
var Q:Tsqlquery;
begin
  Q:=sqltoquery('select * from movped where mped_numerodoc='+inttostr(numerodoc)+' and mped_status=''E'' and mped_unid_codigo='+EdUnid_codigo.assql );
  if Q.eof then
    result:=false
  else
    result:=true;
  Q.close;
  Freeandnil(Q);

end;

procedure TFPedVenda.EdCodtamanhoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////
var posicao:integer;
    novounitario:currency;
begin
  posicao:=FGeral.ProcuraGrid(0,Edproduto.text,Grid,Grid.getcolumn('codtamanho'),EdCodtamanho.asinteger,Grid.getcolumn('codcor'),EdCodcor.asinteger);
  if posicao>0 then begin
// 10.01.06 - entrou em altera��o mas usou bot�o incluir e tentou alterar dai duplica o item - tania jamanta...
    if (Edproduto.enabled) and (OP='A') then begin
      if FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),Edproduto.text,Grid,Grid.getcolumn('codtamanho'),EdCodtamanho.asinteger,Grid.getcolumn('codcor'),EdCodcor.asinteger)>0 then begin
        EdCodtamanho.Invalid('Produto j� existente.  Usar a op��o Alterar');
      end;
    end;
  end else begin
    if ( Global.Usuario.OutrosAcessos[0506] )  and ( EdCodtamanho.asinteger>0 )then begin
      EdCubagem.Enabled:=true;
      EdCubagem.Title:='Un./Metro';
      EdCubagem.setvalue( EdUnitario.ascurrency );
    end else begin
      EdCubagem.Enabled:=false;
      EdCubagem.Title:='Cubagem';
      EdCubagem.setvalue( 0 );
    end;
    novounitario:=EdUnitario.ascurrency*FEstoque.GetPeso(Edproduto.text)*(FTamanhos.GetComprimento(EdCodtamanho.asinteger)/1000);
//    if edcodtamanho.asinteger>0 then Edunitario.setvalue(novounitario);
  end;
end;

procedure TFPedVenda.balterarClick(Sender: TObject);
begin
  if trim(Grid.cells[0,grid.row])='' then exit;
  PRemessa.Enabled:=false;
  OpBotao:='A';
  bGravar.Enabled:=false;
  bSair.Enabled:=false;
  bCancelar.Enabled:=false;
  PINs.Visible:=true;
  PINs.EnableEdits;
  LimpaEditsItens;
  EdProduto.text:=Grid.Cells[grid.getcolumn('move_esto_codigo'),Grid.row];
  Edcodcor.text:=Grid.Cells[grid.getcolumn('codcor'),Grid.row];
  EdCodtamanho.text:=Grid.Cells[grid.getcolumn('codtamanho'),Grid.row];
  SetEdEsto_descricao.text:=Grid.Cells[grid.getcolumn('esto_descricao'),Grid.row];
  SetEdtamanho.text:=Grid.Cells[grid.getcolumn('tamanho'),Grid.row];
  SetEdcor.text:=Grid.Cells[grid.getcolumn('cor'),Grid.row];
  EdQTde.text:=Grid.Cells[grid.getcolumn('qtde'),Grid.row];
  EdUnitario.setvalue( texttovalor(Grid.Cells[grid.getcolumn('venda'),Grid.row]) );
  EdPerdesconto.text:=Grid.Cells[grid.getcolumn('perdesconto'),Grid.row];
//    Grid.Cells[grid.getcolumn('move_seq'),Abs(x)]:=strzero(Seq,3);
// 19.06.06
  Edcodcopa.text:=Grid.Cells[grid.getcolumn('codcopa'),Grid.row];
  SetEdcopa_descricao.text:=Grid.Cells[grid.getcolumn('copa'),Grid.row];
// 26.03.12
  EdPecas.text:=trim(Grid.Cells[grid.getcolumn('mpdd_pecas'),Grid.row]);
  EdProduto.enabled:=false;
  EdCodcor.enabled:=false;
  EdCodcopa.enabled:=false;
  EdCodtamanho.enabled:=false;
  if EdPecas.enabled then EdPecas.setfocus
  else EdQtde.SetFocus;
end;

procedure TFPedVenda.EdFormaenvioExitEdit(Sender: TObject);
begin
   bgravarclick(FPedVenda);
end;

procedure TFPedVenda.EdContatoExitEdit(Sender: TObject);
begin
  bincluiritemclick(FPedVenda);

end;

procedure TFPedVenda.EdTipoPedValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////////
begin
  Tipomov:=EdTipoped.text;
  {  // retirado 17.04.18
  EdMoes_tabp_codigo.enabled:=true;
  if EdMoes_tabp_codigo.isempty then begin
    if pos(tipomov,Global.CodPedVendaMostruario+';'+Global.CodPedVendaMostruarioConsig)>0 then begin
      EdMoes_tabp_codigo.setvalue(FGeral.Getconfig1asinteger('tabmostruario'));
      EdMoes_tabp_codigo.enabled:=false;
    end else begin
      EdMoes_tabp_codigo.enabled:=true;
      EdMoes_tabp_codigo.setvalue(0);
    end;
  end;
  }
  EDTipoPed2.text:=EdTipoped.text;
// 09.05.06
  if (not EdRepr_codigo.validfind) or ( EdRepr_codigo.isempty ) then begin
    Avisoerro('Checar codigo do representante');
  end;
  if (EdTipoped.text<>EdTipoped.oldvalue) and ( pos(EdTipoped.text,Global.CodPedVendaMostruario+';'+Global.CodPedVendaMostruarioConsig)>0 ) then
    brecalculaclick(self);
end;

procedure TFPedVenda.Ativabotoes;
begin
   bgravar.enabled:=true;
//   bcancpedido.enabled:=true;
   bincluiritem.enabled:=true;
   bexcluiritem.enabled:=true;
   balterar.enabled:=true;
   bcancelaritem.enabled:=true;
//   bocorrencia.enabled:=true;
end;

procedure TFPedVenda.Desativabotoes;
begin
   bgravar.enabled:=false;
//   bcancpedido.enabled:=false;
   bincluiritem.enabled:=false;
   bexcluiritem.enabled:=false;
   balterar.enabled:=false;
   bcancelaritem.enabled:=false;
//   bocorrencia.enabled:=false;

end;

procedure TFPedVenda.bexclusaoClick(Sender: TObject);
var Q:TSqlquery;
begin
   if EdNumerodoc.asinteger<=0 then exit;
   Q:=sqltoquery(FGeral.Buscapedvenda(EdNumerodoc.asinteger));
   if (not Q.eof)  then begin
     if Q.fieldbyname('mped_situacao').asstring=sitbaixado then begin
       Avisoerro('Pedido j� baixado.   Exclus�o n�o permitida');
       Q.close;
       Freeandnil(Q);
       exit;
     end;
     if Confirma('Confirma exclus�o') then begin
       Sistema.beginprocess('Gravando');
       Sistema.Edit('movped');
       Sistema.Setfield('mped_status','C');
       Sistema.post('mped_transacao='+stringtosql(Q.fieldbyname('mped_transacao').asstring));
       Sistema.Edit('movpeddet');
       Sistema.Setfield('mpdd_status','C');
       Sistema.post('mpdd_transacao='+stringtosql(Q.fieldbyname('mpdd_transacao').asstring));
// 28.01.19
       Sistema.Edit('pendencias');
       Sistema.SetField('pend_status','C');
       Sistema.post('pend_transacao='+stringtosql(Q.fieldbyname('mped_transacao').asstring)+
                    ' and pend_status=''H''');

       Sistema.commit;
       FGeral.Gravalog(5,'excluido numero '+EdNumerodoc.text+' cliente '+Edcliente.text+' '+FGeral.GetNomeRazaoSocialEntidade(EdCliente.asinteger,'C','N'));
       Sistema.endprocess('');
       Grid.clear;
       EdNumerodoc.clearall(FPedVenda,99);
       EdNumerodoc.setfocus;
     end;

   end else
     Avisoerro('Pedido n�o encontrado');
   Q.close;
   Freeandnil(Q);
end;

//////////////////
procedure TFPedVenda.EdCaoc_codigoValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////////
var Q,QEstoqueQtde,QEstoqueGrade:TSqlquery;

    // 22.07.13  - Metalforte - OS baixa estoque
    //////////////////////////////////////////////
    procedure CancelaMovimentoEstoque;
    /////////////////////////////////////
    var QEstoqueQtde,QEstoqueGrade,QP:TSqlquery;
        xcodcor,xcodtamanho:integer;
        xsqlcor,xsqltamanho:string;
    begin
// retorna a qtde para o estoque
       QP:=Sqltoquery('select mpdd_qtde,mpdd_esto_codigo,mpdd_tama_codigo,mpdd_core_codigo,mpdd_unid_codigo from movpeddet'+
                      ' where mpdd_transacao='+stringtosql(Q.fieldbyname('mped_transacao').asstring) );
       while not Qp.eof do begin
          QEstoqueqtde:=sqltoquery('select * from estoqueqtde inner join estoque on ( esto_codigo=esqt_esto_codigo )'+
                                   ' where esqt_status=''N'' and esqt_unid_codigo='+stringtosql(QP.fieldbyname('mpdd_unid_codigo').asstring)+
                                   ' and esqt_esto_codigo='+stringtosql(QP.fieldbyname('mpdd_esto_codigo').asstring) );
          xcodcor:=QP.fieldbyname('mpdd_core_codigo').asinteger;
          xcodtamanho:=QP.fieldbyname('mpdd_tama_codigo').asinteger;
          xsqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
          xsqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
          if (xcodcor>0) and (xcodtamanho>0)  then begin
              xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
              xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
          end else if (xcodcor>0) then begin
              xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
          end else if (xcodtamanho>0) then begin
              xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
          end;
          FGeral.MovimentaQtdeEstoque(QP.fieldbyname('mpdd_esto_codigo').asstring,
                    QP.fieldbyname('mpdd_unid_codigo').asstring,'E',Global.CodOrdemdeServico,
                    QP.fieldbyname('mpdd_qtde').ascurrency,QEstoqueQtde );
          if (xcodcor>0) and (xcodtamanho>0)  then begin
            QEstoqueGrade:=sqltoquery('select * from Estgrades where esgr_status=''N'' and esgr_esto_codigo='+StringtoSql(QP.fieldbyname('mpdd_esto_codigo').asstring)+
                ' and esgr_unid_codigo='+Stringtosql(QP.fieldbyname('mpdd_unid_codigo').asstring)+
                xsqlcor+xsqltamanho );
            FGeral.MovimentaQtdeEstoqueGrade(QP.fieldbyname('mpdd_esto_codigo').asstring,
                    QP.fieldbyname('mpdd_unid_codigo').asstring,'E',Global.CodOrdemdeServico,
                    xcodcor , xcodtamanho , 0,
                    QP.fieldbyname('mpdd_qtde').ascurrency,QEstoqueGrade );
            FGeral.FechaQuery( QEstoqueGrade );
          end;
          FGeral.FechaQuery( QEstoqueQtde );
          QP.Next;
        end;
// cancela o movimento do estoque
        Sistema.Edit('movestoque');
        Sistema.Setfield('move_status','C');
        Sistema.post('move_transacao='+stringtosql(Q.fieldbyname('mped_transacao').asstring));
    end;

begin
////////////////////////
   pbotoes.enabled:=false;
   Q:=sqltoquery(FGeral.Buscapedvenda(EdNumerodoc.asinteger));
   if (not Q.eof)  then begin
     if Q.fieldbyname('mped_situacao').asstring=sitbaixado then begin
       Avisoerro('Pedido j� baixado.   Cancelamento n�o permitido');
       Q.close;
       Freeandnil(Q);
       exit;
     end;
     if Confirma('Confirma cancelamento') then begin
       Sistema.beginprocess('Gravando');
       if Q.fieldbyname('mped_tipomov').asstring=Global.CodOrdemdeServico then
         CancelaMovimentoEstoque;
       Sistema.Edit('movped');
       Sistema.Setfield('mped_status','X');
       Sistema.Setfield('mped_usua_cancela',Global.usuario.codigo);
       Sistema.post('mped_transacao='+stringtosql(Q.fieldbyname('mped_transacao').asstring));
       Sistema.Edit('movpeddet');
       Sistema.Setfield('mpdd_status','X');
       Sistema.Setfield('mpdd_usua_cancela',Global.usuario.codigo);
       Sistema.post('mpdd_transacao='+stringtosql(Q.fieldbyname('mped_transacao').asstring));
       Sistema.commit;
       FGeral.Gravalog(5,'cancelado numero '+EdNumerodoc.text+' cliente '+Edcliente.text+' '+FGeral.GetNomeRazaoSocialEntidade(EdCliente.asinteger,'C','N'));
//       FOcorrencias.Execute('C',EdCliente.asinteger,EdCliente.resultfind.fieldbyname('clie_nome').asstring,EdCaoc_codigo.text,EdNumerodoc.asinteger);
// 07.08.06
       Sistema.Insert('Ocorrencias');
       Sistema.Setfield('Ocor_CatEntidade','C');
       Sistema.Setfield('Ocor_CodEntidade',EdCliente.asinteger);
       Sistema.Setfield('Ocor_Data',Sistema.Hoje);
       Sistema.Setfield('Ocor_Unid_Codigo',Global.CodigoUnidade);
       Sistema.Setfield('Ocor_Usuario',Global.Usuario.Codigo);
       Sistema.Setfield('Ocor_Descricao','Pedido cancelado');
       Sistema.Setfield('ocor_numerodoc',EdNumerodoc.AsInteger);
       Sistema.Setfield('ocor_caoc_codigo',Edcaoc_codigo.asinteger);
       Sistema.Setfield('ocor_status','N');
       Sistema.Setfield('ocor_tipoocor',Edcaoc_codigo.asinteger);
       Sistema.Post;

       Sistema.commit;
       Sistema.endprocess('');
       Grid.clear;
       EdNumerodoc.clearall(FPedVenda,99);
       EdNumerodoc.setfocus;
     end;

   end else
     Avisoerro('Pedido n�o encontrado');
   Q.close;
   Freeandnil(Q);
   EdCaoc_codigo.enabled:=false;
   EdCaoc_codigo.visible:=false;
   pbotoes.enabled:=true;

end;

procedure TFPedVenda.EdTipoped2Validate(Sender: TObject);
begin

// 26.01.2021
   FPedVenda.bultimos.enabled := false;

   if not EdTipoped2.isempty then begin
     if Edtipoped2.text<>EdTipoped.text then
       tipomov:=edTipoped2.text;
     if (EdTipoped2.text<>EdTipoped2.oldvalue) and ( pos(EdTipoped2.text,Global.CodPedVendaMostruario+';'+Global.CodPedVendaMostruarioConsig)>0 ) then
       brecalculaclick(self);
   end;
// 17.11.11
   if not EdFpgt_codigo.enabled then
      EdFpgt_codigo.valid;


end;

procedure TFPedVenda.brecalculaClick(Sender: TObject);
var linha:integer;
    aliicms,unitario:currency;
    sittrib:string;
begin
// 03.04.06
  if EdCliente.isempty then exit;
  if not Confirma('Confirma rec�lculo') then exit;
  sistema.beginprocess('Recalculando itens');
  for linha:=1 to Grid.rowcount do begin
    if trim(Grid.cells[Grid.getcolumn('move_esto_codigo'),linha])<>'' then begin
      aliicms:= FEstoque.Getaliquotaicms(Grid.cells[Grid.getcolumn('move_esto_codigo'),linha],Edunid_codigo.text,EdCliente.resultfind.fieldbyname('clie_uf').asstring,EdCliente.asinteger,EdTipoPed.text) ;
      sittrib:=FEstoque.Getsituacaotributaria(Grid.cells[Grid.getcolumn('move_esto_codigo'),linha],Edunid_codigo.text,EdCliente.resultfind.fieldbyname('clie_uf').asstring,EdTipoPed.text);
      Vendabru:=EdUnitario.ascurrency;
      Unitario:=( FEstoque.GetPreco(Grid.cells[Grid.getcolumn('move_esto_codigo'),linha],
                           Global.Codigounidade,EdCliente.resultfind.fieldbyname('clie_uf').asstring,
                           aliicms,EdCliente.resultfind.fieldbyname('clie_tipo').asstring) );
      if EdMoes_tabp_codigo.asinteger>0 then begin
        if FTabela.gettipo(EdMoes_tabp_codigo.asinteger) = 'A' then
          Unitario:=( Unitario + (Unitario*(FTabela.GetAliquota(EdMoes_tabp_codigo.asinteger)/100) ) )
        else
          Unitario:= ( Unitario - (Unitario*(FTabela.GetAliquota(EdMoes_tabp_codigo.asinteger)/100) ) );
      end;
      Grid.Cells[grid.getcolumn('venda'),linha]:=TRansform(Unitario,f_cr);
      Grid.Cells[grid.getcolumn('totalitem'),linha]:=TRansform(Texttovalor(Grid.Cells[grid.getcolumn('qtde'),linha])*Unitario,f_cr);
      Grid.Cells[grid.getcolumn('vendabru'),linha]:=TRansform(vendabru,f_cr);
    end;
  end;
  calculatotal;
  sistema.endprocess('');
  EdFpgt_codigo.valid;
  EdFormaenvio.setfocus;

end;

procedure TFPedVenda.EdCodcopaValidate(Sender: TObject);
begin
// 10.01.06 - entrou em altera��o mas usou bot�o incluir e tentou alterar dai duplica o item - tania jamanta...
  if (Edproduto.enabled) and (OP='A') then begin
    if FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),Edproduto.text,Grid,Grid.getcolumn('codtamanho'),
       EdCodtamanho.asinteger,Grid.getcolumn('codcor'),EdCodcor.asinteger,
       Grid.getcolumn('codcopa'),EdCodcopa.asinteger)>0 then begin
      EdCodcopa.Invalid('Produto j� existente.  Usar a op��o Alterar');
    end;
  end;

end;

procedure TFPedVenda.EdQtdeValidate(Sender: TObject);
/////////////////////////////////////////////////////////
var emestoque,pesoestoque:currency;
begin
  if (EdFardos.asinteger>0) and (EdPacotes.asinteger>0) then
    EdCubagem.setvalue(EdFArdos.asinteger*EdPacotes.asinteger*EdQtde.ascurrency*FTamanhos.GetCubagem(EdCodtamanho.asinteger))
  else if (EdFardos.asinteger>0) then
    EdCubagem.setvalue(EdFArdos.asinteger*EdQtde.ascurrency*FTamanhos.GetCubagem(EdCodtamanho.asinteger))
  else if (EdPacotes.asinteger>0) then
    EdCubagem.setvalue(EdPacotes.asinteger*EdQtde.ascurrency*FTamanhos.GetCubagem(EdCodtamanho.asinteger))
  else if not Global.Usuario.OutrosAcessos[0506] then
    EdCubagem.setvalue(0);
  cubagem:=EdCubagem.ascurrency;
// 15.03.10
  if Global.Topicos[1404] then begin
    if Servico(EdProduto.text) then
      EdQtde.setvalue(  FGeral.ConverteHorasparaHorasDec(EdQtde.ascurrency) );
  end;
// 08.01.15
  if Global.Topicos[1417] then begin
//    if EdCodcor.asinteger+Edcodtamanho.asinteger>0 then
//      emestoque:=FEstoque.GetQtdeEmEstoque(EdUnid_codigo.text,EdProduto.text,EdCodcor.asinteger,EdCodtamanho.asinteger)
      emestoque:=FEstoque.GetQtdeEmEstoque(EdUnid_codigo.text,EdProduto.text,EdCodcor.asinteger,EdCodtamanho.asinteger);
    if EdQtde.ascurrency > emestoque then EdQtde.Invalid('Em estoque '+currtostr(emestoque));
  end;
// 08.09.15 - Iso...dianteiro ' + caro'  - retirado em 21.09.18 deixado somente na balan�a
{
  if Frigorifico then begin
    pesoestoque:=FEstoque.getpeso(EdProduto.text);
    if ( EdQtde.ascurrency>0 ) and (PesoEstoque>0) and (Edqtde.ascurrency>PesoEstoque) then begin
      EdQtde.invalid('Peso acima do permitido.  Checar para troca de codigo');
    end;
  end;
  }
end;

procedure TFPedVenda.EdDescubagemValidate(Sender: TObject);
begin
  if EdDescubagem.ascurrency>=0 then begin
    EdCubagem.setvalue(  Cubagem - (cubagem*(EdDEscubagem.ascurrency/100)) );
  end;
end;

procedure TFPedVenda.bpedidosemvalorClick(Sender: TObject);
begin
  if EdNumerodoc.asinteger>0 then begin
    if Global.Topicos[1420] then
      FImpressao.ImprimePedidoVenda(EdNumerodoc.asinteger,EdDtemissao.asdate,edunid_codigo.text,'S','OP')
    else
      FImpressao.ImprimePedidoVenda(EdNumerodoc.asinteger,EdDtemissao.asdate,edunid_codigo.text,'S',EdTipoPed.text);
  end;

end;

procedure TFPedVenda.bgerarequisicaoClick(Sender: TObject);
//////////////////////////////////////////////////////////////////
var produto,transacao,operacao:string;
    Q:TSqlquery;


    procedure GeraDetalhe;
    var p,codtam,codcor:integer;
        QEstoque:TSqlquery;
    begin
      for p:=1 to Grid.RowCount do begin
        produto:=Grid.Cells[Grid.getcolumn('move_esto_codigo'),p];
        codtam:=StrtoIntDef(Grid.Cells[Grid.getcolumn('codtamanho'),p],0);
        codcor:=StrtoIntDef(Grid.Cells[Grid.getcolumn('codcor'),p],0);
        if  (trim(produto)<>'') and (not Servico(produto)) then begin
          QEstoque:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(produto));
          Sistema.Insert('movestoque');
          Sistema.SetField('move_esto_codigo',produto);
          Sistema.SetField('move_tama_codigo',codtam);
          Sistema.SetField('move_core_codigo',codcor);
          Sistema.SetField('move_copa_codigo',0);
          Sistema.SetField('move_transacao',transacao);
          Sistema.SetField('move_operacao',FGeral.GetOperacao);
          Sistema.SetField('move_numerodoc',EdNumerodoc.Asinteger);
          Sistema.SetField('move_status','R');
          Sistema.SetField('move_tipomov',Global.CodRequisicaoAlmox);
          Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
          Sistema.SetField('move_tipo_codigo',edCliente.AsInteger);
          Sistema.SetField('move_tipocad','C');
          Sistema.SetField('move_repr_codigo',EdCliente.resultfind.fieldbyname('clie_Repr_codigo').asinteger);
          Sistema.SetField('move_qtde',Texttovalor(Grid.Cells[Grid.getcolumn('qtde'),p]));
          Sistema.SetField('move_datalcto',Sistema.Hoje);
          Sistema.SetField('move_datacont',Sistema.Hoje);
          Sistema.SetField('move_datamvto',Sistema.hoje);
          Sistema.SetField('move_qtderetorno',Texttovalor(Grid.Cells[Grid.getcolumn('qtde'),p]));
          Sistema.SetField('move_custo',Texttovalor(Grid.Cells[Grid.getcolumn('venda'),p]));
          Sistema.SetField('move_custoger',Texttovalor(Grid.Cells[Grid.getcolumn('venda'),p]));
          Sistema.SetField('move_customedio',Texttovalor(Grid.Cells[Grid.getcolumn('venda'),p]));
          Sistema.SetField('move_customeger',Texttovalor(Grid.Cells[Grid.getcolumn('venda'),p]));
  //        Sistema.SetField('move_cst',Grid.Cells[grid.getcolumn('move_cst'),linha]);
  //        Sistema.SetField('move_aliicms',texttovalor(Grid.Cells[grid.getcolumn('move_aliicms'),linha]));
          Sistema.SetField('move_venda',Texttovalor(Grid.Cells[Grid.getcolumn('venda'),p]));
          Sistema.SetField('move_grup_codigo',QEstoque.fieldbyname('esto_grup_codigo').AsInteger);
          Sistema.SetField('move_sugr_codigo',QEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
          Sistema.SetField('move_fami_codigo',QEstoque.fieldbyname('esto_fami_codigo').AsInteger);
          Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
          Sistema.SetField('move_pecas',0);
          Sistema.SetField('move_nroobra',0);
          Sistema.SetField('move_peso',0);
          Sistema.SetField('move_pesosobra',0);
  //        Sistema.SetField('move_perdesco',texttovalor(Grid.Cells[grid.getcolumn('move_perdesco'),linha]));
  //        Sistema.SetField('move_vendabru',texttovalor(Grid.Cells[grid.getcolumn('move_vendabru'),linha]));
  //        Sistema.SetField('move_aliipi',texttovalor(Grid.Cells[grid.getcolumn('move_aliipi'),linha]));
  //        Sistema.SetField('move_vendamin',texttovalor(Grid.Cells[grid.getcolumn('move_vendamin'),linha]));
  //        Sistema.SetField('move_redubase',texttovalor(Grid.Cells[grid.getcolumn('move_redubase'),linha]));
          Sistema.post;
          FGeral.FechaQuery(QEstoque);
        end;
      end;
    end;

    procedure GeraMestre;
    begin
        Sistema.Insert('movesto');
        Sistema.SetField('moes_transacao',Transacao);
        Sistema.SetField('moes_operacao',FGeral.GetOperacao);
        Sistema.SetField('moes_status','R');
        Sistema.SetField('moes_numerodoc',EdNumerodoc.AsInteger);
        Sistema.SetField('moes_romaneio',0);
        Sistema.SetField('moes_tipomov',Global.CodRequisicaoAlmox);
        Sistema.SetField('moes_comv_codigo',0);
        Sistema.SetField('moes_unid_codigo',EdUnid_codigo.text);
        Sistema.SetField('moes_tipo_codigo',Edcliente.asinteger);
        Sistema.SetField('moes_estado',EdCliente.ResultFind.fieldbyname('clie_uf').AsString);
        Sistema.SetField('moes_tipocad','C');
        Sistema.SetField('moes_repr_codigo',EdCliente.resultfind.fieldbyname('clie_Repr_codigo').asinteger);
//        Sistema.SetField('moes_cida_codigo',Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger);
        Sistema.SetField('moes_cida_codigo',EdCliente.ResultFind.fieldbyname('clie_cida_codigo_res').AsInteger);
        Sistema.SetField('moes_datalcto',Sistema.Hoje);
        Sistema.SetField('moes_datamvto',Sistema.hoje);
        Sistema.SetField('moes_DataCont',Sistema.hoje);
        Sistema.SetField('moes_dataemissao',Sistema.hoje);
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

    end;
/////////////////////////////////////////////////////////////////
begin
/////////////////////////////////////////////////////////////////
  produto:=Grid.Cells[Grid.getcolumn('move_esto_codigo'),1];
  if trim(produto)='' then exit;
  if EdNumerodoc.IsEmpty then exit;
  Q:=sqltoquery('select moes_numerodoc,moes_datamvto from movesto where moes_numerodoc='+EdNumerodoc.AsSql+
                ' and moes_status=''R'''+
                ' and moes_tipo_codigo='+EdCliente.AsSql+
                ' and moes_unid_codigo='+EdUnid_codigo.AsSql);
  if not Q.eof then begin
    Avisoerro('Requisi��o '+EdNumerodoc.text+' j� encontrada em '+FGeral.FormataData(Q.fieldbyname('moes_datamvto').asdatetime));
    FGeral.FechaQuery(Q);
    exit;
  end;
  FGeral.FechaQuery(Q);
  if not confirma('Gerar Requisi��o no almoxarifado ?') then exit;
  Sistema.BeginProcess('Gerando requisi��o');
  try
    Transacao:=FGeral.GetTransacao;
    GeraDetalhe;
    GeraMestre;
    Sistema.Commit;
    Sistema.endprocess('Requisi��o '+EdNumerodoc.text+' Gerada.');
  except
    Sistema.endprocess('Requisi��o n�o gerada.  Tente mais tarde');
  end;

end;

function TFPedVenda.Servico(produto: string): boolean;
var codigofis,tpimposto:string;
begin
  codigofis:=FEstoque.GetCodigoFiscal(produto,EdUnid_codigo.text,Global.UFUnidade);
  tpimposto:=FCodigosFiscais.GetQualImposto(codigofis);
  result:=tpimposto='S';
end;


procedure TFPedVenda.SetaPedidosemAberto(Ed: TSqled);
//////////////////////////////////////////////////////
var QPed:TSqlquery;
    Data:TDatetime;
    Lista:TStringlist;
    ctipomov:string;
begin
  Ed.Items.Clear;
  if FGeral.getconfig1asinteger('DIASPEDIDO') >0 then
    Data:=Sistema.hoje-FGeral.getconfig1asinteger('DIASPEDIDO')
  else
    Data:=Sistema.hoje-30;
{
  QPed:=sqltoquery( 'select * from movped '+
            ' inner join clientes on (clie_codigo=mped_tipo_codigo)'+
            ' where '+FGeral.Getin('mped_unid_codigo',Global.Usuario.UnidadesMvto,'C')+
            ' and '+FGeral.Getin('mped_status','N','C')+
            ' and mped_datamvto>='+Datetosql(Data)+
            ' and mped_situacao=''P'''+
            ' order by mped_datamvto');
}
// 08.08.12 - para nao mostrar no f12 pedidos sem itens
  ctipomov:=Global.CodPedVenda+';'+Global.CodPedVendaMostruario+';'+Global.CodPedVendaMostruarioConsig+';'+
           Global.CodPedVendaPE+';'+Global.CodOrdemdeServico;
  QPed:=sqltoquery( 'select * from movpeddet'+
            ' inner join movped on (mped_transacao=mpdd_transacao)'+
            ' inner join clientes on (clie_codigo=mped_tipo_codigo)'+
            ' where '+FGeral.Getin('mped_unid_codigo',Global.Usuario.UnidadesMvto,'C')+
            ' and '+FGeral.Getin('mped_status','N','C')+
            ' and '+FGeral.Getin('mpdd_status','N','C')+
            ' and '+FGeral.Getin('mpdd_tipomov',ctipomov,'C')+
            ' and mped_datamvto>='+Datetosql(Data)+
            ' and mped_situacao=''P'''+
            ' order by mped_datamvto');
  Lista:=TStringlist.create;
  while not QPed.Eof do begin
    if Lista.IndexOf(QPed.fieldbyname('mped_numerodoc').asstring)=-1 then begin
      Ed.Items.Add(spacestr(QPed.fieldbyname('mped_numerodoc').asstring,7)+' - '+QPed.fieldbyname('clie_nome').asstring);
      Lista.Add(QPed.fieldbyname('mped_numerodoc').asstring);
    end;
    QPed.Next;
  end;
  FGeral.FechaQuery(QPed);
  Lista.free;
end;

function TFPedVenda.CalculaPrecoVenda(valor: currency): currency;
var margem:currency;
begin
  result:=valor;
  if EdMoes_tabp_codigo.asinteger>0 then begin
    margem:= FTabela.GetAliquota(EdMoes_tabp_codigo.asinteger);
    if FTabela.gettipo(EdMoes_tabp_codigo.asinteger) = 'A' then
      result:= valor/ (1-(margem/100))  ;
  end;
end;

procedure TFPedVenda.AtivaEditsParcelas;
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

end;

procedure TFPedVenda.GridParcelasDblClick(Sender: TObject);
begin
  AtivaEditsParcelas;

end;

procedure TFPedVenda.GridParcelasKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
    GridParcelasDblClick(FPedVenda);

end;

procedure TFPedVenda.EdProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var sqlgrupos:string;
begin
{
  if (key=vk_F12) and ( FiltraF12 )  then  begin // #123  key_F12
    if FGeral.getconfig1asstring('GRUPOSPRECO')<>'' then
      sqlgrupos:=' where '+FGeral.GetIN('esto_grup_codigo',FGeral.getconfig1asstring('GRUPOSPRECO'),'N')
    else
      sqlgrupos:='';
    FConsulta.Execute('estoque','esto_codigo,esto_descricao','esto_codigo',sqlgrupos );
  end;
}
// 08.07.14
 if key = vk_f11 then bf11Click(self);

end;

procedure TFPedVenda.bposicaopedidoClick(Sender: TObject);
begin
  if not Sistema.Processando then  FPosicaoPedidoVenda.Execute;

end;

procedure TFPedVenda.ConfiguraEdits(xop: boolean);
///////////////////////////////////////////////////////
begin
   EdTipoPed.Enabled:=xop;
   EdPedidocliente.enabled:=xop;
   EdDataCliente.enabled:=xop;
   EdFormaPedido.enabled:=xop;
   EdPacotes.Visible:=xop;
   EdFardos.visible:=xop;
   EdCodtamanho.visible:=xop;
   SetEdTamanho.Visible:=xop;
   EdCodcor.Visible:=xop;
   SetEdcor.Visible:=xop;
   EdDescubagem.Visible:=xop;
   EdCubagem.Visible:=xop;
   EdPerDesconto.Enabled:=xop;
   EdPerDesconto.Visible:=xop;
   EdMoes_tabp_codigo.enabled:=xop;
   EdMoes_tabp_codigo.visible:=xop;
   SetEdEsto_descricao.width:=200;
   EdPecas.left:=302;

end;

procedure TFPedVenda.bMoveLeftClick(Sender: TObject);
begin
   Grid.MoveLeftColumn;

end;

procedure TFPedVenda.bMoveRightClick(Sender: TObject);
begin
   Grid.MoveRightColumn;

end;

procedure TFPedVenda.bLoadGridClick(Sender: TObject);
begin
   Grid.LoadGrid;
end;

procedure TFPedVenda.bmedicoesClick(Sender: TObject);
////////////////////////////////////////////////////////////
begin

  if ( EdNumerodoc.asinteger>0 ) and ( EdCliente.resultfind <> nil ) then

     FCalibracoes.Execute('C',EdCliente.asinteger,EdCliente.Resultfind.fieldbyname('clie_nome').asstring,'',EdNumerodoc.asinteger);


end;

procedure TFPedVenda.bSaveGridClick(Sender: TObject);
begin
   Grid.SaveGrid;
end;


// 26.01.2021
procedure TFPedVenda.bultimosClick(Sender: TObject);
///////////////////////////////////////////////////////
var Lista        : TStringList;
    ctransacoes  : string;
    QN           : TSqlquery;

begin

    if EdCliente.asinteger = 0 then exit;
    if not EdProduto.visible then  exit;

    Lista := TStringList.create;
    sistema.beginprocess('Buscando Ultimos Pedidos');
    GetListaPedidos( Lista,'S' );
    sistema.endprocess('');

    if (Lista.count>0) and (Lista[0]<>'') then begin

       ctransacoes:=SelecionaItems(Lista,'Pedidos do Cliente','',false);
       strtolista(Lista,ctransacoes,'|',true);

    end;

//    FPedVenda.bultimos.enabled := false;

    if ( copy(ctransacoes,1,11)<>'Codigo    |' ) and ( trim(ctransacoes)<>'' ) then begin

       EdProduto.text := trim(Lista[0]);
       EdQtde.text    := trim(Lista[2]);

    end;

end;

// 13.07.13
procedure TFPedVenda.EdCubagemValidate(Sender: TObject);
//////////////////////////////////////////////////////////
var novounitario:currency;
begin
   if Global.Usuario.OutrosAcessos[0506] then begin
// 21.07.13
//     novounitario:=Vendabru*EdCubagem.ascurrency*(FTamanhos.GetComprimento(EdCodtamanho.asinteger)/1000);
//     novounitario:=FEstoque.GetPeso(EdProduto.text)*EdCubagem.ascurrency*(FTamanhos.GetComprimento(EdCodtamanho.asinteger)/1000);
// 26.03.14
     novounitario:=EdCubagem.ascurrency*FEstoque.GetPeso(EdProduto.text)*(FTamanhos.GetComprimento(EdCodtamanho.asinteger)/1000);
     EdUnitario.setvalue(novounitario);
   end;
end;
// 06.07.18
procedure TFPedVenda.EddescricaoservicoValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin

  if not ProdutoGenerico( EdProduto.Text ) then begin

     EdQtde.Text:='1';

  end;

  Eddescricaoservico.Visible:=false;
  Eddescricaoservico.Enabled:=false;

end;

// 22.07.13
procedure TFPedVenda.EdcodcorValidate(Sender: TObject);
///////////////////////////////////////////////////////////
var unitario,xmargem,unitariograde,tamanho:currency;

    Function RegradoGrupo(xprod:string):integer;
    ////////////////////////////////////////////
    begin
// ver criar campo 'formula ou regra' no cadastro de grupos e retornar este novo campo
      result:=0;
      if FEstoque.GetGrupo(xprod)=1 then
        result:=1
      else if FEstoque.GetGrupo(xprod)=2 then
        result:=2;
    end;

begin
/////////
  if (EdCodcor.asinteger>0) and (EdCodtamanho.asinteger>0) then begin
    unitariograde:=( FEstoque.GetPrecoGrade(EdProduto.text,Global.CodigoUnidade,Edcodtamanho.asinteger,Edcodcor.asinteger ) );
    unitario:=QEstoque.fieldbyname('esqt_vendavis').ascurrency;
    EdUnitario.setvalue(unitariograde);
    if Global.Topicos[1411] then begin
      unitario:=QEstoque.fieldbyname('esqt_custo').ascurrency;
// se for ferro ..
// ver criar campo 'formula ou regra' no cadastro de grupos
      EdCubagem.setvalue(unitario);
      if regradogrupo(EdProduto.text)=1 then
        unitario:=(unitario)*FEstoque.GetPeso(EdProduto.text)
//        *(EdCodtamanho.ResultFind.fieldbyname('tama_comprimento').ascurrency/1000)
      else begin
// se for aluminio
        unitario:=QEstoque.fieldbyname('esqt_custo').ascurrency;
        EdCubagem.setvalue(unitario+ unitariograde);
        unitario:=(unitario + unitariograde)*FEstoque.GetPeso(EdProduto.text) ;
      end;
      tamanho:=(FEstoque.GetComprimentoPadrao(Global.CodigoUnidade,EdProduto.text)/1000);
      if tamanho=0 then
          unitario:=unitario*6  // ( caso nao tenha a grade informada multiplica por 6mts )
      else
          unitario:=unitario*tamanho;

      if EdTipoPed.text='PV' then
        xmargem:=QBusca.fieldbyname('grup_markup').AsCurrency
      else
        xmargem:=QBusca.fieldbyname('grup_margem').AsCurrency;
      if xmargem<=100 then begin
        unitario:=unitario/( (100-xmargem)/100 );
        EdCubagem.setvalue(EdCubagem.ascurrency/( (100-xmargem)/100 ) );
      end else
        unitario:=unitario*2;
// 19.08.14
      if unitario>0 then begin
        EdUnitario.setvalue(unitario);
      end;
    end else
      EdUnitario.setvalue(unitariograde);

// 26.11.13 - Metalforte - calcula pre�o de venda usando peso e depois aplicando a margem do grupo
  end else if (EdCodcor.asinteger=0) and (Global.Topicos[1411]) then begin
      unitario:=FEstoque.GetCusto(EdProduto.text,EdUnid_codigo.text,'custo')*Qbusca.fieldbyname('esto_peso').ascurrency;
      if EdTipoPed.text='PV' then
        xmargem:=QBusca.fieldbyname('grup_markup').AsCurrency
      else
        xmargem:=QBusca.fieldbyname('grup_margem').AsCurrency;
      if xmargem<=100 then
        unitario:=unitario/( (100-xmargem)/100 )
      else
        unitario:=unitario*2;
    if unitario>0 then EdUnitario.setvalue(unitario);
// 07.01.14 - metalforte = aluminios
  end else if (EdCodcor.asinteger>0) and (Global.Topicos[1411]) then begin
      unitario:=FEstoque.GetCusto(EdProduto.text,EdUnid_codigo.text,'custo') +
                FEstoque.GetPrecoGrade(EdProduto.text,Global.CodigoUnidade,Edcodtamanho.asinteger,Edcodcor.asinteger) ;
      if EdTipoPed.text='PV' then
        xmargem:=QBusca.fieldbyname('grup_markup').AsCurrency
      else
        xmargem:=QBusca.fieldbyname('grup_margem').AsCurrency;
      if xmargem<=100 then
        unitario:=unitario/( (100-xmargem)/100 )
      else
        unitario:=unitario*2;
    if unitario>0 then EdUnitario.setvalue(unitario);

  end;
end;

procedure TFPedVenda.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  global.UltimoFormAberto:='';

end;

// 03.02.14
procedure TFPedVenda.balteraclienteClick(Sender: TObject);
/////////////////////////////////////////////////////////////////
begin
   if EdNumerodoc.asinteger<=0 then exit;
   if OP<>'A' then exit;
   if (not QBusca.eof)  then begin
     if Qbusca.fieldbyname('mped_situacao').asstring=sitbaixado then begin
       Avisoerro('Pedido j� baixado.   Altera��o n�o permitida');
       exit;
     end;
     EdclienteNovo.Enabled:=true;
     EdclienteNovo.Visible:=true;
     EdclienteNOvo.SetFocus;
   end;
end;

// 03.02.14
procedure TFPedVenda.EdclientenovoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////
var cliatual:integer;
begin
  if Edclientenovo.IsEmpty then begin
       Edclientenovo.Enabled:=false;
       Edclientenovo.Visible:=false;
     exit;
  end;
  cliatual:=EdCliente.AsInteger;
  EdCliente.Text:=EdClientenovo.Text;
  restricao1:=true;restricao2:=true;restricao3:=true;restricao4:=true;

  EdCliente.Valid;
  if not restricao1 or not restricao2 or not restricao3 or not restricao4 then begin
     Edclientenovo.Enabled:=false;
     Edclientenovo.Visible:=false;
     EdCliente.Text:=inttostr(cliatual);
     exit;
  end;

//  if (restricao1) or (restricao2) or (restricao3) or (restricao4) then begin
//    Avisoerro('Cliente com restri��o de cr�dito.  Verificar.');
//    exit;
//  end;
  if Confirma('Confirma altera��o ?') then begin
       Sistema.beginprocess('Gravando');
       Sistema.Edit('movped');
       Sistema.Setfield('mped_tipo_codigo',EdClientenovo.asinteger);
       Sistema.post('mped_transacao='+stringtosql(QBusca.fieldbyname('mped_transacao').asstring));
       Sistema.Edit('movpeddet');
       Sistema.Setfield('mpdd_tipo_codigo',EdClientenovo.asinteger);
       Sistema.post('mpdd_transacao='+stringtosql(QBusca.fieldbyname('mpdd_transacao').asstring));
       Sistema.commit;
//       FGeral.Gravalog(5,'excluido numero '+EdNumerodoc.text+' cliente '+Edcliente.text+' '+FGeral.GetNomeRazaoSocialEntidade(EdCliente.asinteger,'C','N'));
       Sistema.endprocess('');
       Grid.clear;
       EdNumerodoc.clearall(FPedVenda,99);
       EdNumerodoc.setfocus;
       Edclientenovo.Enabled:=false;
       Edclientenovo.Visible:=false;
  end;

end;


procedure TFPedVenda.EdclientenovoKeyPress(Sender: TObject; var Key: Char);
//////////////////////////////////////////////////////////////////////////////
begin
  if Sistema.LastKey=27 then begin
       Edclientenovo.Enabled:=false;
       Edclientenovo.Visible:=false;
       Edclientenovo.text:='';
       Edclientenovo.Valid;
  end;
end;

procedure TFPedVenda.bf11Click(Sender: TObject);
begin
   bf11.Tag:=(-1)*bf11.Tag;

end;

procedure TFPedVenda.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key = vk_f11 then bf11Click(self);

end;

// 03.09.14
procedure TFPedVenda.EdPort_codigoExitEdit(Sender: TObject);
/////////////////////////////////////////////////////////////////
begin

   bgravarclick(FPedVenda);

end;
// 29.09.14
procedure TFPedVenda.EdUnitarioValidate(Sender: TObject);
/////////////////////////////////////////////////////////////
begin
  if not FEstoque.ValidaPrecoVenda( EdProduto.Text,EdUnid_codigo.text,EdUnitario.ascurrency,global.Usuario.codigo) then
     EdUnitario.Invalid('');

end;

// 26.02.15
procedure TFPedVenda.sbimportacemClick(Sender: TObject);
/////////////////////////////////////////////////////////////
begin
  if not opendialog1.execute then exit;
  if not FileExists( opendialog1.filename ) then begin
    Avisoerro('N�o encontrado arquivo '+opendialog1.filename );
    exit;
  end;
  LeXmlObra( opendialog1.FileName );
  Calculatotal;

end;

/////// 26.02.15
procedure TFPedVenda.LeXmlObra(xarq: string);
//////////////////////////////////////////////////////
type TObra=record
     codigo,nome,nomecliente,cnpj_cpf,end_logr,end_numero,end_compl,end_bairro,end_cidade,end_cep,end_uf:string;
     dataprevisao:TDatetime;
end;
type TPerfis=record
     ref,codigo,linha,trat,classe_id,descricao:string;
     qtde,tam:integer;
     peso,peso_sobra,custo,custo_trat:currency;
end;
type TProdutos=record
     codesqd,linha,tipo,descr,trat_perf,cor_comp,descr_vidros:string;
     qtde,largura,altura:integer;
     peso_unit,custo_unit:currency;
end;

var Listaobra,ListaPerfis,ListaProdutos:TList;
    Lista,ListaLinha:TStringList;
    NovaLista:TStringStream;
    PObra:^TObra;
    PPerfis:^TPerfis;
    PProdutos:^TProdutos;
    p,i:integer;
    w,y,xarquivo:widestring;
    Q:Tsqlquery;
    venda:currency;
    Dados:IxmlNode;


    function LeTexto( xTag:string ; xarquivo:widestring ):widestring;
    ////////////////////////////////////////////////////////////////////
    var posi,posf:integer;
    begin
      posf:=ansipos('</'+xTag+'>',xarquivo);
      posi:=ansipos('<'+xTag+'>',xarquivo);
      if posf>0 then result:=copy(xarquivo,posi,posf)
      else result:='';
    end;

    function LeTag( xTag:string ; xarquivo:widestring ):widestring;
    ////////////////////////////////////////////////////////////////////
    var posi,posf:integer;
    begin
      posf:=ansipos('</'+xTag+'>',xarquivo);
      posi:=ansipos('<'+xTag+'>',xarquivo)+2+length(xTag);
      if posf>0 then result:=copy(xarquivo,posi,posf-posi)
      else result:='';
    end;

    function RetiraTAGArquivo( xTag:string ; xarquivo:widestring ):widestring;
    ///////////////////////////////////////////////////////////////////////////
    var posf:integer;
    begin
      posf:=ansipos('</'+xTag+'>',xarquivo);
      if posf>0 then result:=copy(xarquivo,posf+2+length(xtag),length(xarquivo))
      else result:='';
    end;

    procedure ProdutostoGrid;
    ///////////////
    var i,seq,x:integer;
        QP,QT,QC:TSqlquery;
    begin
      Grid.clear;seq:=1;x:=1;
      for i:=0 to ListaProdutos.count-1 do begin
        PProdutos:=ListaProdutos[i];
        Grid.AppendRow;
        QP:=sqltoquery('select * from estoque where esto_referencia='+Stringtosql(PProdutos.codesqd));
        Grid.Cells[grid.getcolumn('move_seq'),Abs(x)]:=strzero(Seq,3);
        venda:=0;
        if not QP.eof then begin
          venda:=FEstoque.GetPreco(Qp.fieldbyname('esto_codigo').asstring,Global.CodigoUnidade);
          Grid.Cells[grid.getcolumn('move_esto_codigo'),Abs(x)]:=Qp.fieldbyname('esto_codigo').asstring;
          Grid.Cells[grid.getcolumn('esto_descricao'),Abs(x)]:=Qp.fieldbyname('esto_descricao').asstring;
          Qt:=sqltoquery('select * from tamanhos where tama_comprimento='+inttostr(PProdutos.largura));
          Qc:=sqltoquery('select * from cores where core_descricao='+stringtosql(PProdutos.cor_comp));
          if not Qt.eof then begin
            Grid.Cells[grid.getcolumn('tamanho'),Abs(x)]:=QT.fieldbyname('tama_codigo').asstring;
            Grid.Cells[grid.getcolumn('codtamanho'),Abs(x)]:=QT.fieldbyname('tama_descricao').asstring;
          end else begin
            Grid.Cells[grid.getcolumn('tamanho'),Abs(x)]:='N�O ENC.';
          end;
          if not Qc.Eof then begin
            Grid.Cells[grid.getcolumn('cor'),Abs(x)]:=QC.fieldbyname('core_descricao').asstring;
            Grid.Cells[grid.getcolumn('codcor'),Abs(x)]:=QC.fieldbyname('core_codigo').asstring;
          end else begin
            Grid.Cells[grid.getcolumn('cor'),Abs(x)]:='N�O ENC.';
          end;
          Qt.close;Qc.close;
          venda:=venda * ( (PProdutos.largura/1000)*(PProdutos.altura/1000 ) );
          Grid.Cells[grid.getcolumn('venda'),Abs(x)]:=TRansform(venda,f_cr);
          Grid.Cells[grid.getcolumn('totalitem'),Abs(x)]:=TRansform(PProdutos.qtde*venda,f_cr);
          Grid.Cells[grid.getcolumn('vendabru'),Abs(x)]:=TRansform(venda,f_cr);
          Grid.Cells[grid.getcolumn('esto_sisvendas'),Abs(x)]:=FEstoque.GetSistemaVendas(Qp.fieldbyname('esto_codigo').asstring,EdUnid_codigo.text);
        end else begin
          Grid.Cells[grid.getcolumn('move_esto_codigo'),Abs(x)]:='N�O ENCONTRADO';
          Grid.Cells[grid.getcolumn('esto_descricao'),Abs(x)]:=PProdutos.descr;
          Grid.Cells[grid.getcolumn('venda'),Abs(x)]:=TRansform(venda,f_cr);
        end;
//        Grid.Cells[grid.getcolumn('tamanho'),Abs(x)]:=SetEdtamanho.text;
//        Grid.Cells[grid.getcolumn('cor'),Abs(x)]:=SetEdcor.text;
//        Grid.Cells[grid.getcolumn('codtamanho'),Abs(x)]:=Edcodtamanho.text;
//        Grid.Cells[grid.getcolumn('codcor'),Abs(x)]:=Edcodcor.text;
//        Grid.Cells[grid.getcolumn('perdesconto'),Abs(x)]:=EdPerdesconto.AsSql;
//        Grid.Cells[grid.getcolumn('copa'),Abs(x)]:=SetEdcopa_descricao.text;
        Grid.Cells[grid.getcolumn('qtde'),Abs(x)]:=inttostr(PProdutos.qtde);
        Grid.Cells[grid.getcolumn('totalpeso'),Abs(x)]:=Transform(PProdutos.qtde*PProdutos.peso_unit,f_cr);
        Grid.Cells[grid.getcolumn('esto_referencia'),Abs(x)]:=PProdutos.codesqd ;
        inc(seq);
        inc(x);
      end;
    end;

begin
////////////////////
  Leitorxml:=TLeitor.Create;
  Leitorxml.Arquivo:=xarq;
  Leitorxml.CarregarArquivo(xarq);
  w:=Leitorxml.rExtrai(1,'DADOS_OBRA') ;
  xml.LoadFromFile(xarq);
  xml.Active:=true;
  Listaobra:=TList.create;
  ListaPerfis:=TList.create;
  ListaProdutos:=TList.create;
  w:=LeTexto('DADOS_OBRA',w);
  New(PObra);
  PObra.codigo:=LeTag('CODIGO',w);
  PObra.nome:=LeTag('NOME',W);
  PObra.dataprevisao:=TexttoDate( LeTag('DATAPREVISTA',W) );
  w:=Leitorxml.rExtrai(1,'DADOS_CLIENTE') ;
  w:=LeTexto('DADOS_CLIENTE',w);
  PObra.nomecliente:=LeTag('NOME',W);
  PObra.cnpj_cpf:=LeTag('CNPJ_CPF',w);
  PObra.end_logr:=LeTag('END_LOGR',w);
  PObra.end_numero:=LeTag('END_NUMERO',w);
  PObra.end_compl:=LeTag('END_COMPLE',w);
  PObra.end_bairro:=LeTag('END_BAIRRO',w);
  PObra.end_cidade:=LeTag('END_CIDADE',w);
  PObra.end_cep:=LeTag('END_CEP',w);
  PObra.end_uf:=LeTag('END_UF',w);
  ListaObra.Add(PObra);

{
  PObra.codigo:=Leitorxml.rcampo(tcstr,'CODIGO');
  PObra.nome:=Leitorxml.rcampo(tcstr,'NOME');
  PObra.dataprevisao:=TexttoDate( Leitorxml.rcampo(tcstr,'DATAPREVISTA') );
  w:=Leitorxml.rExtrai(1,'DADOS_CLIENTE') ;
  PObra.nomecliente:=Leitorxml.rcampo(tcstr,'NOME');
  PObra.cnpj_cpf:=Leitorxml.rcampo(tcstr,'CNPJ_CPF');
  PObra.end_logr:=Leitorxml.rcampo(tcstr,'END_LOGR');
  PObra.end_numero:=Leitorxml.rcampo(tcstr,'END_NUMERO');
  PObra.end_compl:=Leitorxml.rcampo(tcstr,'END_COMPLE');
  PObra.end_bairro:=Leitorxml.rcampo(tcstr,'END_BAIRRO');
  PObra.end_cidade:=Leitorxml.rcampo(tcstr,'END_CIDADE');
  PObra.end_cep:=Leitorxml.rcampo(tcstr,'END_CEP');
  PObra.end_uf:=Leitorxml.rcampo(tcstr,'END_UF');
  }

  {
  dados:=XML.DocumentElement.ChildNodes.FindNode('DADOS_OBRA');
  if dados <> nil then begin
    dados.ChildNodes.first;
    repeat
      PObra.codigo:=Dados.ChildValues['CODIGO'].text;
      PObra.nome:=Dados.ChildNodes['NOME'].TEXT;
      PObra.dataprevisao:=TexttoDate( Dados.ChildNodes['DATAPREVISTA'].TEXT );
//  w:=Leitorxml.rExtrai(1,'DADOS_CLIENTE') ;
      PObra.nomecliente:=Dados.ChildNodes['NOME'].TEXT;
      PObra.cnpj_cpf:=Dados.ChildNodes.Nodes['CNPJ_CPF'].TEXT;
      dados:=dados.nextsibling;
    until dados = nil;
  end;
}

{
  PObra.end_logr:=Leitorxml.rcampo(tcstr,'END_LOGR');
  PObra.end_numero:=Leitorxml.rcampo(tcstr,'END_NUMERO');
  PObra.end_compl:=Leitorxml.rcampo(tcstr,'END_COMPLE');
  PObra.end_bairro:=Leitorxml.rcampo(tcstr,'END_BAIRRO');
  PObra.end_cidade:=Leitorxml.rcampo(tcstr,'END_CIDADE');
  PObra.end_cep:=Leitorxml.rcampo(tcstr,'END_CEP');
  PObra.end_uf:=Leitorxml.rcampo(tcstr,'END_UF');
  ListaObra.Add(PObra);
}
  if not confirma('Confirma importa��o da obra '+PObra.codigo+' Cliente '+PObra.nomecliente+' ?') then exit;
  w:=Leitorxml.rExtrai(1,'TIPOLOGIAS') ;
  y:=Leitorxml.rExtrai(1,'TIPOLOGIA') ;
//  Leitorxml.arquivo:=y;
  NovaLista:=TStringStream.Create(w);
  Lista:=TStringList.create;
  w:=LeTexto('TIPOLOGIAS',w);
{
  for I := 0 to XML.DocumentElement.ChildNodes.Count - 1 do begin
    with XML.DocumentElement.ChildNodes[I] do begin
//     Para := ChildNodes['PARA'].Text; De := ChildNodes['DE'].Text;
//     Cabecalho := ChildNodes['CABECALHO'].Text;
      y:=ChildNodes['CODESQ'].Text+';'+ChildNodes['LINHA'].Text+';'+ChildNodes['TIPO'].Text;
      if y<>';;' then
        Lista.Add( y );
    end;
  end;
}
  Y:=LeTexto('TIPOLOGIA',w);  // primeiro produto
  while true do begin
    New(PProdutos);
    PProdutos.codesqd:=LeTag('CODESQD',Y);
    PProdutos.linha:=LeTag('LINHA',Y);
    PProdutos.tipo:=LeTag('PRODUTOS',Y);
    PProdutos.descr:=LeTag('DESCR',Y);;
    PProdutos.descr_vidros:=LeTag('VIDROS',Y);
    PProdutos.trat_perf:=LeTag('TRAT_PERF',Y);
    PProdutos.cor_comp:=LeTag('COR_COMP',Y);
    PProdutos.qtde:=STRTOINTDEF(LeTag('QTDE',Y),0);
    PProdutos.largura:=STRTOINTDEF( LeTag('LARGURA',Y),0 );
    PProdutos.peso_unit:=TEXTTOVALOR( LeTag('PESO_UNIT',Y) );
    PProdutos.CUSTO_unit:=TEXTTOVALOR( LeTag('CUSTO_UNIT',Y) );
    PProdutos.altura:=STRTOINTDEF( LeTag('ALTURA',Y),0 );

///////////////////////////////////
{
    PProdutos.codesqd:=Leitorxml.rcampo(tcstr,'CODESQD');
    PProdutos.linha:=Leitorxml.rcampo(tcstr,'LINHA');
    PProdutos.tipo:=Leitorxml.rcampo(tcstr,'TIPO');
    PProdutos.descr:=Leitorxml.rcampo(tcstr,'DESCR');
    PProdutos.descr_vidros:=Leitorxml.rcampo(tcstr,'DESCR_VIDROS');
    PProdutos.trat_perf:=Leitorxml.rcampo(tcstr,'TRAT_PERF');
    PProdutos.cor_comp:=Leitorxml.rcampo(tcstr,'COR_COMP');
    PProdutos.qtde:=STRTOINTDEF(Leitorxml.rcampo(tcstr,'QTDE'),0);
    PProdutos.largura:=STRTOINTDEF(Leitorxml.rcampo(tcstr,'LARGURA'),0);
    PProdutos.peso_unit:=TEXTTOVALOR(Leitorxml.rcampo(tcstr,'PESO_UNIT'));
    PProdutos.CUSTO_unit:=TEXTTOVALOR(Leitorxml.rcampo(tcstr,'CUSTO_UNIT'));
    }
///////////////////////////////////
    ListaProdutos.Add(PProdutos);
    w:=RetiraTagArquivo('TIPOLOGIA',w);

    Y:=LeTexto('TIPOLOGIA',w);
    if y='' then break;
  end;

//    w:=copy( w, pos('</TIPOLOGIA>',w)+12,length(w) ) ;
//}
  Edcliente.text:='';
  if length(trim(PObra.cnpj_cpf))>=11 then begin
    Q:=sqltoquery('select clie_codigo from clientes where clie_cnpjcpf='+Stringtosql(PObra.cnpj_cpf));
    if not Q.Eof then begin
       Edcliente.text:=Q.fieldbyname('clie_codigo').AsString;
       Edcliente.Next;
    end else begin
      Aviso('Cnpj/cpf '+Stringtosql(PObra.cnpj_cpf)+' n�o encontrado');
    end;
  end else Aviso('Cliente sem cnpj/cpf no CEM');
  Produtostogrid;
  EdCliente.setfocus;
end;

// 01.09.16
procedure TFPedVenda.bnfsaidaClick(Sender: TObject);
/////////////////////////////////////////////////////
begin
  if not Sistema.processando then FNotaSaida.Execute('I');
end;

// 02.12.16
function TFPedVenda.EstaCodigosNaoVenda(produto: string): boolean;
///////////////////////////////////////////////////////////////////////
var Lista:TStringlist;
    codigosnaovenda,GruposNaoVenda:string;
    p:integer;
    Q:TSqlquery;
begin
  codigosnaovenda:=FGeral.GetConfig1AsString('Produtosnaovenda');
  GruposNaoVenda:=FGeral.GetConfig1AsString('GRUPOSNAOVEN');
  result:=false;
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

// 16.12.16
procedure TFPedVenda.TimerTimer(Sender: TObject);
////////////////////////////////////////////////////
begin
  begin
    tempo:= tempo - 1;
    SetEdCLIE_NOME.text:='Falta '  +(INTTOSTR(tempo))+ ' segundos' + ' para o programa ser fechado';
    if tempo = 0 then begin
//      Timer.enabled:=false;
//      close;
      Aviso('teste');
      tempo:=10;
    end;
  end;
end;

procedure TFPedVenda.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin

//   timer.enabled:=true;
//   timer.enabled:=false;


end;

end.


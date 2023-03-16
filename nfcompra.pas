unit nfcompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr, DBGrids, SqlSis, ACBrNFe,
  Math, ACBrBase, ACBrDFe, ACBrCTe, FileCtrl, pcnNFe, pcnConversaoNfe, ComObj;


type
  TFNotaCompra = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    q: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    bIncluiritem: TSQLBtn;
    bExcluiritem: TSQLBtn;
    bCancelaritem: TSQLBtn;
    bconsultanfe: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    Painel4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PTotais: TSQLPanelGrid;
    EdBaseIcms: TSQLEd;
    EdValorIcms: TSQLEd;
    EdBasesubs: TSQLEd;
    EdValorsubs: TSQLEd;
    EdTotalprodutos: TSQLEd;
    EdTotalNota: TSQLEd;
    PFinan: TSQLPanelGrid;
    PParcelas: TSQLPanelGrid;
    GridParcelas: TSqlDtGrid;
    EdFpgt_codigo: TSQLEd;
    EdFpgt_descricao: TSQLEd;
    EdPort_codigo: TSQLEd;
    EdPort_descricao: TSQLEd;
    PRemessa: TSQLPanelGrid;
    Edunid_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    EdFornec: TSQLEd;
    SetEdFORN_NOME: TSQLEd;
    EdDtemissao: TSQLEd;
    EdNumeroDoc: TSQLEd;
    EdNatf_codigo: TSQLEd;
    EdNatf_descricao: TSQLEd;
    EdComv_codigo: TSQLEd;
    EdComv_descricao: TSQLEd;
    EdDtEntrada: TSQLEd;
    EdFrete: TSQLEd;
    EdSeguro: TSQLEd;
    EdEmides: TSQLEd;
    EdTran_codigo: TSQLEd;
    EdTran_nome: TSQLEd;
    PIns: TSQLPanelGrid;
    EdProduto: TSQLEd;
    SetEdESTO_DESCRICAO: TSQLEd;
    EdQtde: TSQLEd;
    EdUnitario: TSQLEd;
    EdConhecimento: TSQLEd;
    EdValoripi: TSQLEd;
    EdST: TSQLEd;
    SetEdSt: TSQLEd;
    Edcfis_codigo: TSQLEd;
    EdAliicms: TSQLEd;
    EdPeripi: TSQLEd;
    EdPerIcmsNota: TSQLEd;
    EdDigbicms: TSQLEd;
    EdDigvicms: TSQLEd;
    EdDigtotpro: TSQLEd;
    EdDigtotalnf: TSQLEd;
    EdValoruni: TSQLEd;
    EdQtdeprev: TSQLEd;
    EdTotal: TSQLEd;
    EdPeracre: TSQLEd;
    Edperdesco: TSQLEd;
    EdValortotal: TSQLEd;
    EdVlracre: TSQLEd;
    EdVlrdesco: TSQLEd;
    EdCodtamanho: TSQLEd;
    SQLEd2: TSQLEd;
    Edcodcor: TSQLEd;
    SQLEd3: TSQLEd;
    EdVencimento: TSQLEd;
    EdParcela: TSQLEd;
    EdPercipi: TSQLEd;
    EdDtMovimento: TSQLEd;
    Edqtdetotal: TSQLEd;
    SQLEd1: TSQLEd;
    EdUnidorigem: TSQLEd;
    EdDescoper: TSQLEd;
    EdDescovlr: TSQLEd;
    EdPericmsfrete: TSQLEd;
    Edmens_codigo: TSQLEd;
    EdMensagem: TSQLEd;
    EdSerie: TSQLEd;
    EdTipodoc: TSQLEd;
    PParcelas2: TSQLPanelGrid;
    GridParcelas2: TSqlDtGrid;
    EdVencimento2: TSQLEd;
    EdParcela2: TSQLEd;
    EdTotalservicos: TSQLEd;
    EdCodcopa: TSQLEd;
    SetEdcopa_descricao: TSQLEd;
    EdPedido: TSQLEd;
    EdOutrasdespesas: TSQLEd;
    SQLEd4: TSQLEd;
    EdTipo_codigoind: TSQLEd;
    EdPesoliq: TSQLEd;
    EdNfprodutor: TSQLEd;
    EdPecas: TSQLEd;
    EdFunrural: TSQLEd;
    edCotacapital: TSQLEd;
    EdMuni_codigo: TSQLEd;
    EdMuniRes_Nome: TSQLEd;
    EdPlan_conta: TSQLEd;
    EdPlan_descricao: TSQLEd;
    EdRomaneio: TSQLEd;
    Ednroobra: TSQLEd;
    EdValidadeform: TSQLEd;
    EdNotascompra: TSQLEd;
    PServicos: TSQLPanelGrid;
    StaticText1: TStaticText;
    bservicos: TSQLBtn;
    GridServicos: TSqlDtGrid;
    EdServico: TSQLEd;
    bfechaservicos: TSQLBtn;
    EdQtdenf: TSQLEd;
    EdCertificado: TSQLEd;
    EdGridtotal: TSQLEd;
    PVeiculo: TSQLPanelGrid;
    EdMoes_cola_codigo: TSQLEd;
    SetEdCOLA_NOME: TSQLEd;
    EdMoes_km: TSQLEd;
    bveiculos: TSQLBtn;
    bteste: TSQLBtn;
    EdNatf_codigoitem: TSQLEd;
    EdCodigoproduto: TSQLEd;
    EdArquivoxml: TSQLEd;
    bbuscaxml: TSQLBtn;
    od1: TOpenDialog;
    EdContacredito: TSQLEd;
    SetEdplan_descricao: TSQLEd;
    Pbotoesgrid: TSQLPanelGrid;
    bLoadGrid: TSQLBtn;
    bSaveGrid: TSQLBtn;
    bMoveLeft: TSQLBtn;
    bMoveRight: TSQLBtn;
    PImportacao: TSQLPanelGrid;
    EdNumerodi: TSQLEd;
    EdDatadi: TSQLEd;
    Edlocaldesembaraco: TSQLEd;
    babredi: TSQLBtn;
    bfechadi: TSQLBtn;
    Eddtdesen: TSQLEd;
    EdUfdesen: TSQLEd;
    EdNcm: TSQLEd;
    brelauditoriafiscal: TSQLBtn;
    EdCfopitem: TSQLEd;
    bbuscanfe: TSQLBtn;
    EdEmbalagem: TSQLEd;
    EdEmbalagemitem: TSQLEd;
    brestauragrid: TSQLBtn;
    Edmoes_tabp_codigo: TSQLEd;
    SetEdTABP_ALIQUOTA: TSQLEd;
    EdSeto_codigo: TSQLEd;
    Eddesctipo: TSQLEd;
    EdManutencao: TSQLEd;
    EdCodEqui: TSQLEd;
    PMuitasParcelas: TSQLPanelGrid;
    EdNparcelas: TSQLEd;
    eddiavencimento: TSQLEd;
    Edchavenfeacom: TSQLEd;
    Edvalorgta: TSQLEd;
    Edos: TSQLEd;
    EdQtdeos: TSQLEd;
    PRetencoes: TSQLPanelGrid;
    Edvlrinss: TSQLEd;
    Label1: TLabel;
    Edvlrir: TSQLEd;
    Edvlrpis: TSQLEd;
    Edvlrcofins: TSQLEd;
    Edvlrcsll: TSQLEd;
    ACBrCTe1: TACBrCTe;
    bnotascte: TSQLBtn;
    SQLPanelGrid2: TSQLPanelGrid;
    ListaArq: TFileListBox;
    Edvlriss: TSQLEd;
    PMensagem: TSQLPanelGrid;
    bvendabalcao: TSQLBtn;
    ACBrNFe1: TACBrNFe;
    blexcel: TSQLBtn;
    Od2: TOpenDialog;
    EdPesobru: TSQLEd;
    Edespecievol: TSQLEd;
    Edqtdevol: TSQLEd;
    bimpcpr: TSQLBtn;
    Edmoes_insumos: TSQLEd;
    bfichatecnica: TSQLBtn;
    PCodbarra: TSQLPanelGrid;
    Label2: TLabel;
    Gridcodbarra: TSqlDtGrid;
    Edcodbarra: TSQLEd;
    bcodbarra: TSQLBtn;
    EdVezesap: TSQLEd;
    bguiast: TSQLBtn;
    FileListBox1: TFileListBox;
    procedure bIncluiritemClick(Sender: TObject);
    procedure Edunid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure Edunid_codigoValidate(Sender: TObject);
    procedure EdNatf_codigoValidate(Sender: TObject);
    procedure EdPort_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdFpgt_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdFpgt_codigoValidate(Sender: TObject);
    procedure EdProdutoValidate(Sender: TObject);
    procedure EdSTExitEdit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure bExcluiritemClick(Sender: TObject);
    procedure EdDigbicmsValidate(Sender: TObject);
    procedure EdDigtotproValidate(Sender: TObject);
    procedure EdDtEntradaValidate(Sender: TObject);
    procedure EdDtemissaoValidate(Sender: TObject);
    procedure bCancelaritemClick(Sender: TObject);
    procedure EdComv_codigoValidate(Sender: TObject);
    procedure bSairClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EdNumeroDocValidate(Sender: TObject);
    procedure EdDigtotalnfValidate(Sender: TObject);
    procedure EdFreteValidate(Sender: TObject);
    procedure EdTran_codigoValidate(Sender: TObject);
    procedure EdQtdeValidate(Sender: TObject);
    procedure EdUnitarioValidate(Sender: TObject);
    procedure EdPeracreValidate(Sender: TObject);
    procedure EdperdescoValidate(Sender: TObject);
    procedure EdVlracreValidate(Sender: TObject);
    procedure EdVlrdescoValidate(Sender: TObject);
    procedure EdDigtotalnfExitEdit(Sender: TObject);
    procedure GridParcelasDblClick(Sender: TObject);
    procedure GridParcelasKeyPress(Sender: TObject; var Key: Char);
    procedure EdParcelaExitEdit(Sender: TObject);
    procedure EdVencimentoExitEdit(Sender: TObject);
    procedure EdPort_codigoValidate(Sender: TObject);
    procedure EdProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure EdDtMovimentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdFornecValidate(Sender: TObject);
    procedure EdDescoperValidate(Sender: TObject);
    procedure EdDescovlrValidate(Sender: TObject);
    procedure EdTran_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure Edmens_codigoValidate(Sender: TObject);
    procedure EdVencimento2ExitEdit(Sender: TObject);
    procedure EdParcela2ExitEdit(Sender: TObject);
    procedure GridParcelas2DblClick(Sender: TObject);
    procedure GridParcelas2KeyPress(Sender: TObject; var Key: Char);
    procedure EdTotalservicosValidate(Sender: TObject);
    procedure EdVencimentoValidate(Sender: TObject);
    procedure EdVencimento2Validate(Sender: TObject);
    procedure EdCodcopaValidate(Sender: TObject);
    procedure EdPedidoValidate(Sender: TObject);
    procedure EdFpgt_codigoExitEdit(Sender: TObject);
    procedure EdDescovlrExitEdit(Sender: TObject);
    procedure Edcfis_codigoValidate(Sender: TObject);
    procedure EdPlan_contaValidate(Sender: TObject);
    procedure EdRomaneioValidate(Sender: TObject);
    procedure EdNfprodutorValidate(Sender: TObject);
    procedure EdValidadeformValidate(Sender: TObject);
    procedure EdNotascompraValidate(Sender: TObject);
    procedure bservicosClick(Sender: TObject);
    procedure bfechaservicosClick(Sender: TObject);
    procedure EdServicoExitEdit(Sender: TObject);
    procedure GridServicosKeyPress(Sender: TObject; var Key: Char);
    procedure GridServicosDblClick(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure EdQtdenfExitEdit(Sender: TObject);
    procedure EdQtdenfValidate(Sender: TObject);
    procedure EdGridtotalExitEdit(Sender: TObject);
    procedure EdDtMovimentoValidate(Sender: TObject);
    procedure bveiculosClick(Sender: TObject);
    procedure EdMoes_kmExitEdit(Sender: TObject);
    procedure EdMoes_cola_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure btesteClick(Sender: TObject);
    procedure EdcodcorValidate(Sender: TObject);
    procedure EdSTValidate(Sender: TObject);
    procedure EdArquivoxmlValidate(Sender: TObject);
    procedure bbuscaxmlClick(Sender: TObject);
    procedure EdCodigoprodutoExitEdit(Sender: TObject);
    procedure EdCodigoprodutoValidate(Sender: TObject);
    procedure EdContacreditoValidate(Sender: TObject);
    procedure bMoveLeftClick(Sender: TObject);
    procedure bMoveRightClick(Sender: TObject);
    procedure bLoadGridClick(Sender: TObject);
    procedure bSaveGridClick(Sender: TObject);
    procedure bconsultanfeClick(Sender: TObject);
    procedure EdNatf_codigoitemValidate(Sender: TObject);
    procedure bfechadiClick(Sender: TObject);
    procedure babrediClick(Sender: TObject);
    procedure EdlocaldesembaracoExitEdit(Sender: TObject);
    procedure brelauditoriafiscalClick(Sender: TObject);
    procedure EdCfopitemExitEdit(Sender: TObject);
    procedure bbuscanfeClick(Sender: TObject);
    procedure EdMensagemValidate(Sender: TObject);
    procedure EdEmbalagemitemExitEdit(Sender: TObject);
    procedure brestauragridClick(Sender: TObject);
    procedure Edmoes_tabp_codigoValidate(Sender: TObject);
    procedure EdSeto_codigoExitEdit(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdManutencaoExitEdit(Sender: TObject);
    procedure EdManutencaoKeyPress(Sender: TObject; var Key: Char);
    procedure EdCodEquiExitEdit(Sender: TObject);
    procedure EdCodEquiChange(Sender: TObject);
    procedure eddiavencimentoValidate(Sender: TObject);
    procedure eddiavencimentoExitEdit(Sender: TObject);
    procedure EdTipodocValidate(Sender: TObject);
    procedure EdSeto_codigoValidate(Sender: TObject);
    procedure EdosExitEdit(Sender: TObject);
    procedure F(Sender: TObject; var Key: Char);
    procedure EdQtdeosValidate(Sender: TObject);
    procedure EdQtdeosExitEdit(Sender: TObject);
    procedure EdvlrcofinsChange(Sender: TObject);
    procedure EdvlrcsllExitEdit(Sender: TObject);
    procedure EdPort_codigoExit(Sender: TObject);
    procedure EdvlrcsllValidate(Sender: TObject);
    procedure EdValidadeformExitEdit(Sender: TObject);
    procedure bnotascteClick(Sender: TObject);
    procedure EdArquivoxmlKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bvendabalcaoClick(Sender: TObject);
    procedure blexcelClick(Sender: TObject);
    procedure bimpcprClick(Sender: TObject);
    procedure Edmoes_insumosValidate(Sender: TObject);
    procedure bfichatecnicaClick(Sender: TObject);
    procedure EdcodbarraExitEdit(Sender: TObject);
    procedure GridcodbarraDblClick(Sender: TObject);
    procedure bcodbarraClick(Sender: TObject);
    procedure GridcodbarraKeyPress(Sender: TObject; var Key: Char);
    procedure bguiastClick(Sender: TObject);
  private
    { Private declarations }
    procedure LimpaEditsItens;
    procedure Editstogrid;
    procedure RetornaQtdeCusto;
  public
    { Public declarations }
    procedure Execute(Acao:string;ctrans:string='');
    procedure SetaEditsValores;
    procedure AtivaEditsParcelas;
    procedure AtivaEditsParcelas2;
    function totalbruto(tipo:string='qtde'):currency;
    procedure Campostoedits(Q,Q1:TSqlquery);
    procedure Campostogrid(Q,Q1:TSqlquery);
    procedure CancelaTransacao(Transacao,Transacao1,xOP:string);
    function ProcuraGrid(Coluna: integer;  Pesquisa: string ; Colunatam:integer=0 ; tam:integer=0 ;
             colunacor:integer=0 ; cor:integer=0  ; colunacopa:integer=0 ; copa:integer=0 ) : integer;
    procedure ZeraGridServicos;
    procedure ChecaEditsDesabilitados(s:string);
    function TodostemComposicao(Grid:TSqlDtGrid;colunaproduto:integer):boolean;
    procedure SetaEditObra;
// 07.10.10
    function NotaAutorizada(XML:String):boolean;
    procedure ImportaDadosXML(NotaFiscal:TACbrNfe);
// 06.01.17
    procedure ImportaDadosXMLCte(NotaFiscal:TACbrCTe);
// 13.10.10
    procedure ItensXmltoGrid(Grid:TSqlDtGrid);
// 18.10.10
    function ConverteCodigo(xproduto:string ; Fornecedor:integer ; xcodbarra:string):string;
// 21.11.11
    procedure TrataNCM(xNCM,xdescricao,xproduto:string ; xaliipi:currency);
// 16.06.12
    function TrataCodigoProdutoXML(xcodigo:string  ; xr:integer):string;
// 01.08.12
    procedure GetListaNfe( TLista:TStringList ; xES:string ; qtipomov:string='' );
// 05.03.14 - A2z
    procedure ParcelamentoLongo;
// 21.03.18 - para alterar PA - entrada de servi�os
    procedure CampostoEditsII(Q:TSqlquery);

  end;


type TCustos=record
  produto,unidade:string;
  adataultcompra,dataultcompra:TdateTime;
  acusto,acustomedio,acustomedioger,acustoger,custo,custoger,customedio,customedioger,aqtde,aqtdeprev,qtde,
  qtdeprev,qtdeprevdig,dig,unitario,valoruni,pericms,peripi,perpis,percofins,precovenda,perdesc:currency;
  codcor,codtamanho,codcopa,embalagem:integer;
end;

const estados12:string='';
// 10.07.08
const estados18:string='PR;SP;RJ;RS';
const estados7:string='MS;MT;RO;PA;BA;RN;CE;SE';
const cfopdeservicos:string='1933/2933';


var
  FNotaCompra: TFNotaCompra;
  Op,campoufentidade,Moes_remessas,transacao1,transacaoant,campocodigoentidade,transacaobusca,
  TipoEntradaAbate,xcondicao,transacao2,NotaEstorno,XMLCTE:string;
  PCustos:^TCustos;
  PCustosT:^TCustos;
  ListaCustos,ListaCustosT:Tlist;
  perfrete,pericmsfrete,pericmsfreteprev,perfreteprev,Peracreprev,Perdescprev,valornotafinan:currency;
  QEstoque,QEstoqueQtde,QFornec,QRoma,QGrade:TSqlquery;
  Devolucao,Unidade,EntranoCusto,Transferencia,TipoEntidade,Especiais,NotasCompra,TransacoesCompra,TiposMuda,
  TiposNumeracaoSaida:string;
  vlrfreteliquido:currency;
  descpiscofins,FreteEmbutido:boolean;
  campo       :TDicionario;
  ListaCodigos:TStringList;
  CfopdeCombustivel : boolean;

implementation

uses Arquiv, Geral, conpagto, Sqlfun, Estoque, Transp, codigosfis,
  Sittribu, impressao, Natureza, portador, DB, cadcor, tamanhos, Pedvenda,
  cadcopa, plano, Mensnf, Unidades, Pedcomp, ConfMovi,
  ACBrNFeNotasFiscais, pcnConversao, consultawebsernfe, codigosipi, RelGerenciais,
  principal, tabela, grupos, rateio, cadcli, expnfetxt, pcteCTe,
  ACBrCTeConhecimentos, vendabalcao, fichatecnica, lenfeemail, fornece;

{$R *.dfm}

procedure TFNotaCompra.bIncluiritemClick(Sender: TObject);
/////////////////////////////////////////////////////////////////////

  procedure DesativaEdits(tipo:string);
  //////////////////////////////////////////
  begin
    if tipo='D' then begin
      EdUnitario.enabled:=false;
      EdValoruni.enabled:=false;
      EdSt.enabled:=false;
      EdCfis_codigo.enabled:=false;
// 13.04.11 - Clessi - Devolucao Dx
      if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoIgualVenda+';' ) >0 then
        EdPercipi.enabled:=true
      else
        EdPercipi.enabled:=false;
    end else begin
      EdUnitario.enabled:=true;
      EdValoruni.enabled:=true;
      EdSt.enabled:=true;
      EdCfis_codigo.enabled:=true;
      EdPercipi.enabled:=true;
    end;
  end;

begin
////////////////////////

  if ( Ansipos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodConhecimento+';'+Global.CodEntradaSemItens ) >0 )
//     and
//     ( trim(Grid.cells[Grid.GetColumn('move_esto_codigo'),1])<>'' )

   then begin

    Avisoerro('N�o permitido itens em Conhecimento de transporte OU tipos EI');
    EdPort_codigo.setfocus;
    exit;

  end;

  EdValoruni.Enabled:=Global.Usuario.OutrosAcessos[0010];
  EdValoruni.Visible:=Global.Usuario.OutrosAcessos[0010];
  EdQtdeprev.Enabled:=Global.Usuario.OutrosAcessos[0010];
  EdQtdeprev.Visible:=Global.Usuario.OutrosAcessos[0010];
  EdDescoper.Enabled:=Global.Usuario.OutrosAcessos[0010];
  EdDescoper.Visible:=Global.Usuario.OutrosAcessos[0010];

  PRemessa.Enabled:=false;
  bGravar.Enabled:=false;
  bSair.Enabled:=false;
//  bCancelar.Enabled:=false;
  PINs.Enabled:=true;
  PFinan.Enabled:=false;
  PINs.EnableEdits;
  LimpaEditsItens;
// 07.03.08
  DesativaEdits('A');
  if pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Devolucao ) > 0 then begin
// 31.08.05 - Marcia ctb
    if EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring<>global.CodDevolucaoRoman then
      DesativaEdits('D');
  end;
  EdProduto.SetFocus;

end;

// 15.10.18 - le planilha do excel com dados dos produtos somente para IMPORTACAO
procedure TFNotaCompra.blexcelClick(Sender: TObject);
///////////////////////////////////////////////////////////
var Excel,
    FileName,
    Password,
    Readonly,
    valor,
    celula                    : Variant;
    arqu,
    xcodigo                   : string;
    coluna,linhafim,linha,pos,
    p,posncm,
    posproduto                :integer;
    ListaCampos,
    ListaColunas,
    ListaProdutos,
    ListaC                    :TStringList;
    valorc,
    valorc1,
    valorc2,
    valorc3,
    valorc4,
    valorc5,
    unitario,
    valorc6                   :currency;

begin

  if EdNatf_codigo.IsEmpty then begin
     Aviso('Falta informar o CFOP');
     exit;
  end;
  if not Od2.Execute then exit;
  arqu:=Od2.FileName;
  if not FileExists( arqu ) then begin
    Avisoerro('Arquivo '+arqu+' n�o enconttrado');
    exit;
  end;
  try
    Excel := CreateOleObject('Excel.Application');
  except
    Avisoerro('N�o foi poss�vel executar o Excel');
    exit;
  end;
  Excel.Visible := false;
//  Excel.WorkBooks.Open( arqu );
  Excel.WorkBooks.Open(FileName := arqu, Password := '', ReadOnly := True);
  // procura pelas colunas

  ListaCampos:=TStringList.Create;
  ListaColunas:=TStringList.Create;
  ListaProdutos:=TStringList.Create;

  ListaCampos.Add('Produto');
  ListaCampos.Add('NCM');
  ListaCampos.Add('PESO LIQ');
//  ListaCampos.Add('Base II');
// 07.04.20
  ListaCampos.Add('Base PIS/COFINS');

  ListaCampos.Add('% IPI');
  ListaCampos.Add('% II');
// 23.11.20
  ListaCampos.Add('BASE ICMS');

  linhafim:=2;
  Linha:=1;
  Coluna:=1;
  posncm:=1;
  posproduto:=-1;

  for p:=0 to ListaCampos.Count-1do begin

//    While coluna < 30 Do begin
// 11.03.20 - polli mudou a planilha com mais colunas e nomes diferentes...
    While coluna < 50 Do begin

      if Uppercase( trim( Excel.Cells.Item[linha,coluna].Value2 ) ) = Uppercase( ListaCampos[p] ) then begin
         ListaColunas.Add( inttostr(coluna) );
         if Uppercase( ListaCampos[p] ) = 'NCM' then posncm:=coluna
         else if Uppercase( ListaCampos[p] ) = 'PRODUTO' then posproduto:=coluna;
         coluna:=1;
         break;
      end;
      inc(coluna);

    end;

  end;

  if ListaCampos.Count <> ListaColunas.Count then begin
     Avisoerro('N�o encontrado TODAS as colunas na linha 01.  '+ListaCampos.Text);
     Excel.quit;
     exit;
  end;

  Sistema.BeginProcess('Lendo planilha do excel');

  for p := 2 to 60 do begin


//     if trim( Excel.Cells.Item[ p,posncm ].Value ) <>'' then begin
//     valor:=Excel.Cells.Item[ p,posncm ].Value2;
     valor:=Excel.Cells.Item[ p,posproduto ].Value2;
     valorc:=-1;
     if  VarIsNumeric( valor ) then valorc:=valor
     else if VarIsFloat( valor ) then valorc:=valor
     else if VarIsStr( valor ) then valorc:=Texttovalor( valor );
//     else Aviso('C�lula ref. NCM com tipo n�o tratado');

     if Valorc>0 then begin

        celula:=Excel.Cells.Item[ p,strtoint(ListaColunas[1]) ].Value2;
        valorc:=-1;
        if  VarIsNumeric( celula ) then valorc:=celula
        else if VarIsFloat( celula ) then valorc:=celula
        else if VarIsStr( celula ) then valorc:=Texttovalor( celula )
        else Aviso('C�lula  coordernadas '+inttostr(p)+','+ListaColunas[1]+' com tipo n�o tratado');

        if valorc >0 then begin

          celula:=Excel.Cells.Item[ p,strtoint(ListaColunas[0]) ].Value2;
          xcodigo:=celula;
          celula:=Excel.Cells.Item[ p,strtoint(ListaColunas[2]) ].Value2;
          valorc1:=celula;
          celula:=Excel.Cells.Item[ p,strtoint(ListaColunas[3]) ].Value2;
          valorc2:=celula;
          celula:=Excel.Cells.Item[ p,strtoint(ListaColunas[4]) ].Value2;
          valorc3:=celula;
//          valorc3:=valorc3*100;
// 11.03.20 - % ipi informado 5 aos inves de 0,05 ( em % )
          celula:=Excel.Cells.Item[ p,strtoint(ListaColunas[5]) ].Value2;
          valorc4:=celula;
// 23.11.20 - base od icms quando vem de SP
          celula:=Excel.Cells.Item[ p,strtoint(ListaColunas[6]) ].Value2;
          valorc6:=celula;

// 11.03.20 - % ii informado 5 aos inves de 0,05 ( em % )
//          valorc4:=valorc4*100;
          ListaProdutos.Add(  xcodigo  + ';'+ currtostr( valorc  )+';'+currtostr( valorc1  )
                             +';'+currtostr( valorc2  )
                             +';'+currtostr( valorc3  )
                             +';'+currtostr( valorc4  )
                             +';'+currtostr( valorc6  ) // base icms
                               );
// 18.01.19
         if length(trim(xcodigo)) <> FGeral.GetConfig1AsInteger('TAMESTOQUE') then begin
            Sistema.EndProcess('Codigo '+xcodigo+' com numero errado de d�gitos');
            Excel.quit;
            exit;
         end;
         if length(trim(xcodigo)) =0 then begin
            Sistema.EndProcess('LInha '+inttostr(p)+' sem codigo do produto do Sac por�m com valor');
            Excel.quit;
            exit;
         end;

        end;
{
        ListaProdutos.Add( Excel.Cells.Item[ p,ListaColunas[1] ].Value2 );
        ListaProdutos.Add( Excel.Cells.Item[ p,ListaColunas[2] ].Value2 );
        ListaProdutos.Add( Excel.Cells.Item[ p,ListaColunas[3] ].Value2 );
        ListaProdutos.Add( Excel.Cells.Item[ p,ListaColunas[4] ].Value2 );
        ListaProdutos.Add( Excel.Cells.Item[ p,ListaColunas[5] ].Value2 );
}
     end else begin

        celula:=Excel.Cells.Item[ p,strtoint(ListaColunas[3]) ].Value2;
        if trim(celula)<>'' then begin

            Aviso('LInha '+inttostr(p)+' sem codigo do produto do Sac por�m com valores');
//            Sistema.EndProcess('LInha '+inttostr(p)+' sem codigo do produto do Sac por�m com valores');
//            Excel.quit;
//            exit;

         end;

     end;

  end;

  Sistema.endprocess('');
  Grid.Clear;
  linha:=1;
  ListaC:=TStringList.Create;

  for p := 0 to ListaProdutos.Count-1 do begin

      ListaC:=TStringList.Create;
      strtolista(ListaC,ListaProdutos[p],';',true);
      Grid.Cells[Grid.GetColumn('move_esto_codigo'),linha]:= ListaC[0];
      Grid.Cells[Grid.GetColumn('esto_descricao'),linha]:= FEstoque.GetDescricao( trim(ListaC[0]) ) ;
      Grid.Cells[Grid.GetColumn('ncmnfe'),linha]:= ListaC[1];
      Grid.Cells[Grid.GetColumn('move_qtde'),linha]:= ListaC[2];
      Grid.Cells[Grid.GetColumn('total'),linha]:= ListaC[3];
      unitario:=TextTovalor( Listac[3] ) / TextTovalor( ListaC[2] );
      Grid.Cells[Grid.GetColumn('move_venda'),linha]:= currtostr( unitario ) ;
      Grid.Cells[Grid.GetColumn('move_aliipi'),linha]:= ListaC[4];
      Grid.Cells[Grid.GetColumn('voutro'),linha]:= ListaC[5];
      Grid.Cells[Grid.GetColumn('codigosittrib'),linha]:=FSittributaria.GetCodigoCst('150','E');
      Grid.Cells[Grid.GetColumn('codigofis'),linha]:=FCodigosFiscais.GetCodigoFis('I',0,0);

      Grid.Cells[Grid.GetColumn('move_cst'),linha]:='150';
      Grid.Cells[Grid.GetColumn('move_aliicms'),linha]:= '0';

// 20.11.20 - ver quando � 150 ou 051... situa��o de exce��o quando vem de aviao e por SP...
{
      Grid.Cells[Grid.GetColumn('move_aliicms'),linha]:= '18';
      Grid.Cells[Grid.GetColumn('move_cst'),linha]:='051';
// 23.11.20 - base do icms
      Grid.Cells[Grid.GetColumn('descontouni'),linha] := currtostr( TexttoValor(Listac[6]) );
  }

//      Grid.Cells[Grid.GetColumn('produtonfe'),linha]:=inttostr( p+1 );
      Grid.Cells[Grid.GetColumn('move_natf_codigo'),linha]:=EdNatf_codigo.text;
      Grid.AppendRow;
      inc(linha);
      ListaC.free;

  end;

  ListaProdutos.free;
  ListaCampos.free;
  SetaEditsValores;


//  SelecionaItems(ListaProdutos,'teste','');


end;

procedure TFNotaCompra.Edunid_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.Limpaedit(EdUNid_codigo,key);

end;

procedure TFNotaCompra.Edunid_codigoValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////////////////////////////////////
begin

  IF EdFornec.AsInteger>0 then begin
//    if EdArquivoXml.isempty then begin  // 18.10.10 - 16.05.11 deixado o da conf. mov.
      if EdUnid_codigo.ResultFind.fieldbyname('unid_uf').asstring<>QFornec.fieldbyname(campoufentidade).asstring then
        EdNatf_codigo.text:=EdComv_codigo.resultfind.fieldbyname('comv_natf_foestado').asstring
      else
        EdNatf_codigo.text:=EdComv_codigo.resultfind.fieldbyname('comv_natf_estado').asstring;
//    end;
// 23.06.06 - manoel e 35 OU paulo e 34 cfop � final 925
//    if ( (EdFornec.asinteger=24) and (EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoInd) ) or
//       ( (EdFornec.asinteger=25) and (EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodRetornoInd) ) then
//      EdNatf_codigo.text:=copy(EdComv_codigo.resultfind.fieldbyname('comv_natf_estado').asstring,1,1)+'925';
/////////////////////
//    IF pos( EdFornec.resultfind.fieldbyname(campoufentidade).asstring,estados7 )>0 then
// 07.08.07
    if pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.codcompraprodutor+';'+Global.CodDevolucaoInd+';'+Global.CodRetornocomServicos)=0 then begin
{ - mudado em 29.07.08
      IF pos( QFornec.fieldbyname(campoufentidade).asstring,estados7 )>0 then
        EdPericmsnota.setvalue(7)
      else IF pos( QFornec.fieldbyname(campoufentidade).asstring,estados12 )>0 then
        EdPericmsnota.setvalue(12)
      else IF pos( QFornec.fieldbyname(campoufentidade).asstring,estados18 )>0 then
        EdPericmsnota.setvalue(18)
      else
        EdPericmsnota.setvalue(17);
}
      EdPerIcmsnota.setvalue( FEstoque.GetAliquotaIcmsEstado(QFornec.fieldbyname(campoufentidade).asstring,'J','E') )
    end;
    if OP='I' then begin
       if pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,TiposNumeracaoSaida)>0 then
         EdNUmerodoc.setvalue( FGeral.ConsultaContador('NFSAIDA'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade))+1 )
// 03.11.17
       else if pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.CodCedulaProdutoRural)>0 then
         EdNUmerodoc.setvalue( FGeral.ConsultaContador('CPR')+1 );
    end;
// 14.10.10 - para gravar os itens caso nao existir na unidade de entrada
    EdUnidorigem.text:=EdUnid_codigo.text;

  end;
// 21.05.2021 - Guiber - consistir o cnpj do destinatario da nf de entrada com o cnpj
//              da unidade informada

  if (AcbrNFe1.NotasFiscais.Count >0) and ( not EdArquivoxml.isempty ) then begin

    if (AcbrNFe1.NotasFiscais.Items[0].NFe.Dest.CNPJCPF <> '')
        and
       (AcbrNFe1.NotasFiscais.Items[0].NFe.Dest.CNPJCPF <> EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring)
        and
       (AcbrNFe1.NotasFiscais.Items[0].NFe.Ide.modelo = 55 )
        then begin

        EdUNid_codigo.invalid('Cnpj do destinat�rio da nota diferente do cnpj da unidade informada');

    end;

  end;

end;

//////////////////////////////////////////////////////////////////
procedure TFNotaCompra.EdNatf_codigoValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////
var iniciook:string;
    p:integer;
begin
  if EdFornec.asinteger>0 then begin
//    if EdFornec.resultfind.fieldbyname(campoufentidade).asstring<>Global.UFUnidade then
    if QFornec.fieldbyname(campoufentidade).asstring<>Global.UFUnidade then
      iniciook:='2,3'
    else
      iniciook:='1';
    if pos(copy(EdNatf_codigo.text,1,1),iniciook)=0 then
      EdNatf_codigo.Invalid('Natureza inv�lida para esta opera��o')
    else begin
      if EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodConhecimento then
        if EdNatf_codigo.resultfind.fieldbyname('natf_produtos').asstring<>'T' then
          EdNatf_codigo.Invalid('Natureza inv�lida para esta opera��o');
    end;
// 05.09.11 - Novi - 'respeita' o cfop informado e 'joga por cima' do que veio no XML
// para fazer tbem quando puxa da SEFa
// 18.11.13 - mudado para somente quando usa xml apos o OR - Abra cuiaba
    if ( ( not EdArquivoxml.IsEmpty ) and ( OP='I') )
       OR
//       ( (not EdArquivoxml.IsEmpty) and ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring<>Global.CodEstornoNFeSai ) )
// 11.12.13 - deixado cfop 'a escolha na nf de estorno'
       ( (not EdArquivoxml.IsEmpty) or ( (EdArquivoxml.IsEmpty) and ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodEstornoNFeSai+';'+Global.CodDevolucaoIgualVenda)>0 ) ) )

     then begin
      if pos( EdNatf_codigo.text,'1556;2556;1201;2201;1949;2949;1551;2551;1653;2653;1101;2101;1102;2102;1403;2403' ) > 0 then begin
        for p:=1 to Grid.RowCount do begin
//          if trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p])<>'' then
          if (trim(Grid.Cells[Grid.Getcolumn('move_qtde'),p])<>'')
             and ( pos(Grid.Cells[Grid.Getcolumn('move_natf_codigo'),p],'1403/1401/2403/2401')=0 )  then begin
            Grid.Cells[Grid.Getcolumn('move_natf_codigo'),p]:=EdNatf_codigo.text;
// 25.04.14 - Abra Cuiaba - escrito werlang
            if FGeral.GetConfig1AsString('cstpadraentrada')<>'' then Grid.Cells[Grid.Getcolumn('move_cst'),p]:=FGeral.GetConfig1AsString('cstpadraentrada');
            if (FGeral.GetConfig1AsString('cstpadraentrada1')<>'') and
               ( pos(EdNatf_codigo.text,'1924/2924/1923/2923/1101/2101')>0 ) then
    //           ( pos(trim(( Det[r].Prod.cfop )) ,'5924/6924/5923/6923/5101/6101')>0 ) then
              Grid.Cells[Grid.Getcolumn('move_cst'),p]:=FGeral.GetConfig1AsString('cstpadraentrada1');

// 24.03.14
          end else if (trim(Grid.Cells[Grid.Getcolumn('move_qtde'),p])<>'') then begin

             if EdNatf_codigo.text='1102' then
               Grid.Cells[Grid.Getcolumn('move_natf_codigo'),p]:='1403'
             else if EdNatf_codigo.text='2102' then
               Grid.Cells[Grid.Getcolumn('move_natf_codigo'),p]:='2403'
             else if EdNatf_codigo.text='1101' then
               Grid.Cells[Grid.Getcolumn('move_natf_codigo'),p]:='1401'
             else if EdNatf_codigo.text='2101' then
               Grid.Cells[Grid.Getcolumn('move_natf_codigo'),p]:='2401'
// 14.07.14 - Benato
             else if EdNatf_codigo.text='1403' then
// 06.06.15 - Novicarnes
             else  Grid.Cells[Grid.Getcolumn('move_natf_codigo'),p]:=EdNatf_codigo.text;
          end;
        end;
      end;
    end;
// 12.01.12
    babredi.Enabled:=copy(EdNatf_codigo.text,1,1)='3';
    bfechadi.Enabled:=copy(EdNatf_codigo.text,1,1)='3';;
    if op='I' then
      if copy(EdNatf_codigo.text,1,1)='3' then babrediclick(self);
///////////////
  end;

end;

procedure TFNotaCompra.EdPort_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.Limpaedit(EdPort_codigo,key);

end;
                                                                   
procedure TFNotaCompra.EdFpgt_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
   FGeral.LImpaEdit(Edfpgt_codigo,key);

end;

procedure TFNotaCompra.EdFpgt_codigoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////
var nparcelas,n,nparcelasxml:integer;
    ListaPrazo:TStringlist;
    p:integer;
    valorparcela,valortotal,acumulado,valoravista:currency;
    valorparcela2,valortotal2,acumulado2,valoravista2:currency;
begin

  if trim(EdFpgt_codigo.text)='' then exit;
  if not EdFpgt_codigo.validfind then exit;
// 05.03.14
  if pos('X',Uppercase(EdFpgt_codigo.resultfind.fieldbyname('fpgt_prazos').asstring))>0 then exit;

  if (FCondPagto.GetAvPz(EdFpgt_codigo.text)='V') or (Fcondpagto.Getprimeiroprazo(EdFpgt_codigo.text)=0) then begin
    if EdUnid_codigo.Resultfind <> nil then begin
      if EdUnid_codigo.Resultfind.fieldbyname('Unid_contacontabil').AsInteger=0 then begin
        EdFpgt_codigo.INvalid('Unidade sem conta caixa cadastrada para lan�amentos a vista');
        exit;
      end;
    end;
  end;
  if (op='I') or (EdFpgt_codigo.text<>EdFpgt_codigo.OldValue) then begin
      GridParcelas.Clear;
// 08.05.20 - Novicarnes
      Gridcodbarra.Clear;
      if GridParcelas2.visible then
        GridParcelas2.Clear;
  end;
  if ( (FCondPagto.GetAvPz(EdFpgt_codigo.text)='P') and (OP='I') ) or (EdFpgt_codigo.text<>EdFpgt_codigo.OldValue ) then begin

    ListaPrazo:=TStringlist.create;
    n:=FCondPagto.GetPrazos(EdFpgt_codigo.text,ListaPrazo);
    valoravista:=FGeral.GetValorAvista(Listaprazo);
    valoravista2:=valoravista;
    nparcelas:=FCondPagto.GetNumeroParcelas(EdFpgt_codigo.text);
/////////////////////////////////////////////////////////////////
// 11.03.05 - reges pegou bug quando tem parte a vista e mais de duas parcelas
    acumulado:=0;acumulado2:=0;
//    valortotal:=EdDigtotalnf.AsCurrency-valoravista-EdFunrural.ascurrency-EdCotacapital.ascurrency-Edvalorgta.ascurrency;
// 14.11.16
    valortotal:=EdDigtotalnf.AsCurrency-valoravista-EdFunrural.ascurrency-EdCotacapital.ascurrency-Edvalorgta.ascurrency-
                EdVlrinss.ascurrency-Edvlrir.ascurrency-Edvlrpis.ascurrency-EdVlrcofins.ascurrency-Edvlrcsll.AsCurrency-
                EdVlriss.AsCurrency-EdMoes_insumos.AsCurrency;
// 22.12.15 - eddigtotalnf ja vem descontado inss,cota e gta
//    valortotal:=EdDigtotalnf.AsCurrency-valoravista;
// 18.02.16 - revisando...unicafes
    valortotal2:=EdVAlortotal.AsCurrency-valoravista2 - valortotal;
// 05.06.06
    if ( (EdDtmovimento.asdate<1) and (EdValortotal.ascurrency=EdDigtotalnf.ascurrency) ) or
       ( (EdDtmovimento.asdate<1) and (EdValortotal.ascurrency=0) )
      then begin
      valortotal2:=valortotal;
//      valortotal:=0;
// 09.05.19 - retirado pra gerar o grid igual mesmo sendo sem movimento

    end;
// 27.03.06 - DI
    if (EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoInd) then begin
      valortotal:=EdTotalServicos.ascurrency;
      valortotal2:=0;
// 18.05.06
      if EdDtmovimento.asdate<1 then begin
        valortotal:=0;
        valortotal2:=EdTotalServicos.ascurrency;
      end;
// 09.05.06 - notas do paulo(dastyle) q s�o tipo1 mas geram financeiro tipo2...Leila+Grazi
      if pos( strzero(EdFornec.asinteger,7),FGEral.Getconfig1asstring('fornfinanceiro') )>0 then begin
        valortotal:=0;
        valortotal2:=EdVAlortotal.AsCurrency-valoravista2;
      end;
// 11.07.13 - Metalforte
    end else if (EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodRetornocomServicos) then begin
      valortotal:=valornotafinan;
    end else if (EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodRetornoInd) then begin
      valortotal:=EdTotalServicos.ascurrency;
      valortotal2:=EdVAlortotal.AsCurrency-valoravista2 - valortotal;
    end;
/////////////////
//    valortotal:=EdDigtotalnf.AsCurrency-valoravista;
// 15.08.05 - para poder lan�ar Dv sem produtos ( o famoso credito de pe�as )
    if ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoVenda+';'+Global.CodDevolucaoVendaConsig)>0) and ( valoravista=0 )
      then
      valoravista:=valortotal;
    nparcelasxml:=0;
    if not EdArquivoxml.IsEmpty then begin
      if Uppercase(copy(EdTipodoc.text,1,3))='CTE' then
        nparcelasxml:=ACbrCTe1.Conhecimentos.Items[0].CTe.infCTeNorm.cobr.Dup.count
      else
        nparcelasxml:=ACbrNfe1.NotasFiscais.Items[0].NFe.Cobr.Dup.count;
    end;
// 13.10.15 caso no xml vier numero de parcelas 'errado', diferente do que o o 'real feito' dai nao usa informacao
    if (nparcelasxml<>nparcelas) and (nparcelasxml>0) then nparcelasxml:=0;

    for p:=1 to nparcelas do begin

// 18.04.12
      if (not EdArquivoxml.IsEmpty) and (nparcelasxml>0) then begin
        if Uppercase(copy(EdTipodoc.text,1,3))='CTE' then
          GridParcelas.cells[0,p]:=formatdatetime('dd/mm/yy',ACbrCTe1.Conhecimentos.Items[0].CTe.infCTeNorm.Cobr.Dup.Items[p-1].dVenc )
// 29.05.20
        else if Global.Topicos[1466] then

          GridParcelas.cells[0,p]:=formatdatetime('dd/mm/yyyy',ACbrNfe1.NotasFiscais.Items[0].NFe.Cobr.Dup.Items[p-1].dVenc )

        else

          GridParcelas.cells[0,p]:=formatdatetime('dd/mm/yy',ACbrNfe1.NotasFiscais.Items[0].NFe.Cobr.Dup.Items[p-1].dVenc );

      end else if Global.Topicos[1466] then   // 13.08.20

          GridParcelas.cells[0,p]:=formatdatetime('dd/mm/yyyy',FGeral.GetProximoDiaUtil(EdDtEmissao.Asdate+Inteiro(ListaPrazo[p-1]),Inteiro(ListaPrazo[p-1]))  )

      else

        GridParcelas.cells[0,p]:=formatdatetime('dd/mm/yy',FGeral.GetProximoDiaUtil(EdDtEmissao.Asdate+Inteiro(ListaPrazo[p-1]),Inteiro(ListaPrazo[p-1]))  );


// 08.05.20
      if Global.Topicos[1513] then begin

         GridCodBarra.Cells[GridCodbarra.GetColumn('pend_codbarra'),p] := '';
         GridCodBarra.Cells[GridCodbarra.GetColumn('pend_parcela'),p]  := inttostr(p);
         GridCodbarra.AppendRow;

      end;

      if (p=nparcelas) and (valoravista=0) then
        valorparcela:=valortotal-acumulado  // para deixar na ultima parcelas "as d�zimas"
      else begin
        if (valoravista>0) then begin
          if nparcelas>1 then   // 15.08.05
            valorparcela:=FGeral.Arredonda(valortotal/(nparcelas-1),2)
          else
            valorparcela:=valoravista;
          if (p=nparcelas) then
            valorparcela:=valortotal+valoravista-acumulado  // para deixar na ultima parcelas "as d�zimas" - 01.06.05
        end else
          valorparcela:=FGeral.Arredonda((valortotal)/nparcelas,2);
      end;
      if (valoravista>0) and (p=1) then begin
// 18.04.12
        if (not EdArquivoxml.IsEmpty) and (nparcelasxml>0)  then begin
          if Uppercase( copy(EdTipodoc.text,1,3))='CTE' then
            GridParcelas.cells[1,p]:=Transform(ACbrCTe1.Conhecimentos.Items[0].CTe.infCTeNorm.Cobr.Dup.Items[p-1].vDup,f_cr )
          else
            GridParcelas.cells[1,p]:=Transform(ACbrNfe1.NotasFiscais.Items[0].NFe.Cobr.Dup.Items[p-1].vDup,f_cr );
        end else
          GridParcelas.cells[1,p]:=Transform(valoravista,f_cr);
        acumulado:=acumulado+valoravista;
      end else begin
// 18.04.12
        if (not EdArquivoxml.IsEmpty) and (nparcelasxml>0)  then begin
          if Uppercase(copy(EdTipodoc.text,1,3))='CTE' then
            GridParcelas.cells[1,p]:=Transform(ACbrCTe1.Conhecimentos.Items[0].CTe.infCTeNorm.Cobr.Dup.Items[p-1].vDup,f_cr )
          else
            GridParcelas.cells[1,p]:=Transform(ACbrNfe1.NotasFiscais.Items[0].NFe.Cobr.Dup.Items[p-1].vDup,f_cr );
        end else
          GridParcelas.cells[1,p]:=Transform(valorparcela,f_cr);
        acumulado:=acumulado+valorparcela;
      end;
      GridParcelas.RowCount:=GridParcelas.RowCount+1;
// 09.11.05
      if ((GridParcelas2.visible) and (EdVAlortotal.ascurrency>0)) or (valortotal2>0) then begin
        GridParcelas2.cells[0,p]:=formatdatetime('dd/mm/yy',FGeral.GetProximoDiaUtil(EdDtEmissao.Asdate+Inteiro(ListaPrazo[p-1]),Inteiro(ListaPrazo[p-1]))  );
        if (p=nparcelas) and (valoravista2=0) then
          valorparcela2:=valortotal2-acumulado2  // para deixar na ultima parcelas "as d�zimas"
        else begin
          if (valoravista2>0) then begin
            if nparcelas>1 then   // 15.08.05
              valorparcela2:=FGeral.Arredonda(valortotal2/(nparcelas-1),2)
            else
              valorparcela2:=valoravista2;
            if (p=nparcelas) then
              valorparcela2:=valortotal2+valoravista2-acumulado2  // para deixar na ultima parcelas "as d�zimas" - 01.06.05
          end else
            valorparcela2:=FGeral.Arredonda((valortotal2)/nparcelas,2);
        end;
        if (valoravista2>0) and (p=1) then begin
          GridParcelas2.cells[1,p]:=Transform(valoravista2,f_cr);
          acumulado2:=acumulado2+valoravista2;
        end else begin
          GridParcelas2.cells[1,p]:=Transform(valorparcela2,f_cr);
          acumulado2:=acumulado2+valorparcela2;
        end;
        GridParcelas2.RowCount:=GridParcelas2.RowCount+1;

      end;

    end;  // for do numero de parcelas

//////////////////////////////////////////////////////////////
    Freeandnil(ListaPrazo);
  end;

end;

procedure TFNotaCompra.EdProdutoValidate(Sender: TObject);
//////////////////////////////////////////////////////////
var QBusca,QDev:TSqlquery;
    custotrans:currency;
    codbarra:string;
begin
// 16.08.05
  if pos(Op,'A;F')>0 then
    Unidade:=EdUnid_codigo.text;

// 09.10.18
  EdNatf_codigoitem.Text:=EdNatf_codigo.Text;

  EdCodtamanho.enabled:=Global.Topicos[1314];
  EdCodcor.enabled:=Global.Topicos[1315];
  EdCodcopa.enabled:=true;

  EdCodtamanho.setvalue(0);
  EdCodcor.setvalue(0);
  EdCodcopa.setvalue(0);
  codigobarra:=false;

  if FGeral.CodigoBarra(EdProduto.Text,EdProduto) then begin
    QBusca:=sqltoquery('select * from estoque where esto_Codbarra='+stringtosql(EdProduto.Text));
    codbarra:=EdProduto.text;
    if not QBusca.Eof then begin
      EdProduto.Text:=QBusca.fieldbyname('esto_codigo').AsString;
      QEstoque:=sqltoquery('select * from EstoqueQtde inner join estoque on (esto_codigo=esqt_esto_codigo)'+
               ' where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
               ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
    end else begin
//      EdProduto.Invalid('Codigo de barra n�o encontrado');
//      exit;
    end;
//////////////////
//    19.11.12 - Vivan
    codigobarra:=true;
    EdQtde.Enabled:=false;
    EdQtde.SetValue(1);
    EdCodcor.enabled:=false;
    EdCodtamanho.enabled:=false;
    EdCodcopa.enabled:=false;
    EdCodcor.text:='';
    EdCodtamanho.text:='';
    EdCodcopa.text:='';
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
// 19.11.12 - Vivan
        if QGrade.fieldbyname('esgr_vendavis').ascurrency>0 then begin
          EdUnitario.setvalue( QGrade.fieldbyname('esgr_vendavis').ascurrency );
// 21.08.13 - ficava zerado nas DV
          EdValorUni.setvalue( QGrade.fieldbyname('esgr_vendavis').ascurrency );
        end;
        FGeral.Fechaquery(QEstoque);

//        QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
//                             ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
// 12.09.13
        QEstoque:=sqltoquery('select * from EstoqueQtde inner join estoque on (esto_codigo=esqt_esto_codigo)'+
               ' where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
               ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
// 19.11.12 - Vivan
//        if EdUnitario.ascurrency=0 then EdUnitario.setvalue( QEstoque.fieldbyname('esqt_vendavis').ascurrency );
// 24.06.13 - Vivan - 08.11.13 - Sandra ECF
        if Global.topicos[1362] then begin
           EdUnitario.setvalue( FEstoque.GetPreco(EdProduto.text,EdUnid_codigo.text) );
// 21.08.13 - ficava zerado nas DV
          EdValorUni.setvalue( EdUnitario.ascurrency );
        end;
        if EdMoes_tabp_codigo.asinteger>0 then begin
          if FTabela.gettipo(EdMoes_tabp_codigo.asinteger) = 'A' then
            EdUnitario.setvalue( EdUnitario.AsCurrency + (EdUnitario.ascurrency*(FTabela.GetAliquota(EdMoes_tabp_codigo.asinteger)/100) ) )
          else
            EdUnitario.setvalue( EdUnitario.AsCurrency - (EdUnitario.ascurrency*(FTabela.GetAliquota(EdMoes_tabp_codigo.asinteger)/100) ) );
// 21.08.13 - ficava zerado nas DV
          EdValorUni.setvalue( EdUnitario.ascurrency );
// 28.05.14 - vivan - Liane
        end else if FGeral.GetGeraFinanceiro(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring)='N' then begin
          EdUnitario.setvalue( FEstoque.GetCusto(EdProduto.text,EdUnid_codigo.text,'custo') ) ;
          EdValorUni.setvalue( EdUnitario.ascurrency );
          EdUnitario.enabled:=false;
          EdValoruni.enabled:=false;
          EdSt.enabled:=false;
          EdCfis_codigo.enabled:=false;
          EdSt.setvalue( FEstoque.GetCodigosituacaotributaria(EdProduto.text,Unidade,QFornec.fieldbyname( campoufentidade ).asstring) );
          Edcfis_codigo.text:=FEstoque.GetCodigoFiscal(EdProduto.text,Unidade,QFornec.fieldbyname( campoufentidade ).asstring);
          EdNatf_codigoitem.text:=FSittributaria.GetCfop(EdSt.AsInteger,EdNatf_codigo.text,EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring);
          EdNatf_codigoitem.Enabled:=false;
          EdPercipi.Enabled:=false;
        end;
        FGeral.Fechaquery(QBusca);
        QBusca:=sqltoquery('select * from estoque where esto_codigo='+EdProduto.assql);
      end else begin
        EdProduto.Invalid('Codigo de barra da grade n�o encontrado');
        exit;
      end;
    end;

//////////////////
    EdQtde.Enabled:=false;
    EdQtde.SetValue(1);
    EdQtdeprev.Enabled:=false;
    EdQtdeprev.SetValue(1);

//    if Qbusca.fieldbyname('esto_grad_codigo').asinteger>0 then begin
//      QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
//                       ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text))+
//                       ' and esqt_codbarra;
//      EdCodTanho.text:=
//    end else
//      EdCodTanho.text:='';
    EdCodTamanho.enabled:=false;
    EdCodcor.enabled:=false;
    EdCodcopa.enabled:=false;

  end else begin

    QEstoque:=sqltoquery('select * from EstoqueQtde inner join estoque on (esto_codigo=esqt_esto_codigo)'+
                         ' where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                         ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
    QBusca:=sqltoquery('select * from estoque where esto_Codigo='+EdProduto.Assql);
    if not QBusca.Eof then
      EdProduto.Text:=QBusca.fieldbyname('esto_codigo').AsString
    else begin
      EdProduto.Invalid('Codigo n�o encontrado');
      exit;
    end;
    EdQtde.Enabled:=true;
    EdQtde.SetValue(0);
    EdQtdeprev.Enabled:=Global.Usuario.OutrosAcessos[0010];
    EdQtdeprev.SetValue(0);
// 31.08.06 - Marcia Lizot
    if Global.CodDevolucaoConsigMerc=EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring then begin
      EdCodtamanho.enabled:=false;
      EdCodcor.enabled:=false;
      EdCodcopa.enabled:=false;
      EdCodtamanho.setvalue(0);
      EdCodcor.setvalue(0);
      EdCodcopa.setvalue(0);
    end;
  end;

  if QEstoque.eof then begin
      EdProduto.Invalid('Codigo ainda n�o cadastrado nesta unidade');
      exit;
  end;

//  EdCodtamanho.text:='0';
//  EdCodcor.text:='0';
//  if Qbusca.fieldbyname('esto_grad_codigo').asinteger>0 then begin
//    EdCodtamanho.enabled:=true;
//    EdCodcor.enabled:=true;
//  end else begin
//    EdCodtamanho.enabled:=false;
//    EdCodcor.enabled:=false;
//  end;
// 08.06.06 - deixar quando tiver grade no cadastro

//  if FGeral.ProcuraGrid(0,EdProduto.text,Grid,Grid.getcolumn('move_tama_codigo'),EdCodtamanho.asinteger,
//                        Grid.getcolumn('move_tama_codigo'),Edcodcor.asinteger) > 0 then begin
//    if pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Devolucao ) = 0 then
// criar esta funcao
//  if FGeral.ProcuraGridGrade(0,EdProduto.text,Grid) > 0 then
//      EdProduto.INvalid('Produto j� digitado.  Excluir e incluir');
//  end;

  SetEdEsto_descricao.text:=QBusca.fieldbyname('esto_descricao').asstring;
// 09.03.12
  EdNcm.text:='Codigo NCM : '+FEstoque.GetNCMipi(EdProduto.text);
// 14.09.06
  if QBusca.fieldbyname('esto_emlinha').asstring='N' then begin
    EdProduto.Invalid('Produto fora de linha ou deixado de usar');
    exit;
  end;
// 05.04.10 - Abra
  if (QEstoque.fieldbyname('esqt_customeger').ascurrency+QEstoque.fieldbyname('esqt_customedio').ascurrency)>999999.99  then begin
    EdProduto.invalid('Problemas no custo m�dio no estoque.  Checar');
    exit;
  end;
// 30.05.14 - vivan - liane
  if (FGeral.getconfig1asinteger('Diasdevolucao')>0) and ( pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Devolucao ) > 0 )
     then begin
    QDev:=sqltoquery('select move_transacao from movestoque where move_status=''N'''+
                      ' and move_datamvto>='+DatetoSql(Sistema.hoje-FGeral.getconfig1asinteger('Diasdevolucao'))+
                      ' and move_esto_codigo='+EdProduto.AsSql+
//                      ' and ( (move_tama_codigo='+EdCodTamanho.AsSql+') or (move_tama_codigo is null) )'+
//                      ' and ( (move_core_codigo='+EdCodCor.AsSql+') or (move_core_codigo is null) )'+
                      ' and move_unid_codigo='+EdUnid_codigo.assql+
// 28.05.15 - nao estava vendo as vendas do cliente...jamantaaaa..
                      ' and move_tipo_codigo='+EdFornec.assql+
                      ' and move_tipocad='+Stringtosql('C')+
                      ' and '+fGeral.GetIN('move_tipomov',Global.CodRemessaConsig+';'+
                      global.CodVendaDireta+';'+
                      Global.CodVendaConsig+';'+
                      Global.CodRemessaDemoClientes+';'+
                      Global.CodRemessaInd,'C') );
    if QDev.eof then begin
      EdProduto.invalid('N�o encontrado vendas deste produto no prazo permitido para devolu��es.  Verificar');
      exit;
    end;
  end;
// 24.02.05 - para usar na transf. entrada
   if (not codigobarra) then
     EdValoruni.Setvalue(QEstoque.fieldbyname('esqt_vendavis').AsCurrency);
// 05.09.12
//   Edembalagem.setvalue( QEstoque.fieldbyname('esto_embalagem').asinteger );
// 19.11.12
   Edembalagem.setvalue( QBusca.fieldbyname('esto_embalagem').asinteger );

// 12.11.12 - Vivan - reativado
  if (EdMoes_tabp_codigo.asinteger>0) and ( not codigobarra) then begin
    if FTabela.gettipo(EdMoes_tabp_codigo.asinteger) = 'A' then
      EdUnitario.setvalue( EdUnitario.AsCurrency + (EdUnitario.ascurrency*(FTabela.GetAliquota(EdMoes_tabp_codigo.asinteger)/100) ) )
    else
      EdUnitario.setvalue( EdUnitario.AsCurrency - (EdUnitario.ascurrency*(FTabela.GetAliquota(EdMoes_tabp_codigo.asinteger)/100) ) );
  end;

// 18.08.04
  if (pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Devolucao)>0) and (EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring<>global.CodDevolucaoRoman)
     then begin
//    EdUnitario.Setvalue(QEstoque.fieldbyname('esqt_vendavis').AsCurrency);
//    EdValoruni.Setvalue(QEstoque.fieldbyname('esqt_vendavis').AsCurrency);
// 14.09.05 - reges
// 19.11.12 - Vivan
    if not codigobarra then begin
      EdUnitario.setvalue(FEstoque.GetPreco(EdProduto.text,Global.unidadematriz));
      EdValoruni.Setvalue(FEstoque.GetPreco(EdProduto.text,Global.unidadematriz));
    end;
//    EdSt.setvalue( FEstoque.GetCodigosituacaotributaria(EdProduto.text,Unidade,EdFornec.resultfind.fieldbyname('clie_uf').asstring) );
    EdSt.setvalue( FEstoque.GetCodigosituacaotributaria(EdProduto.text,Unidade,QFornec.fieldbyname( campoufentidade ).asstring) );
//    Edcfis_codigo.text:=FEstoque.GetCodigoFiscal(EdProduto.text,Unidade,EdFornec.resultfind.fieldbyname('clie_uf').asstring);
    Edcfis_codigo.text:=FEstoque.GetCodigoFiscal(EdProduto.text,Unidade,QFornec.fieldbyname( campoufentidade ).asstring);
    Edpercipi.setvalue(0);
// 19.11.12 - Vivan
    if not codigobarra then begin
      EdSt.valid;
      EdCfis_codigo.valid;
    end;
// 28.09.05 - para as notas 'uisqui' do milan e lopes - fazer 'DV igual'----pessoa juridica  - pura viadagem
    if copy(Edproduto.text,1,5)=Global.Codestolib then begin
      EdUnitario.enabled:=true;
      EdValoruni.enabled:=true;
    end else
      EdUnitario.enabled:=Global.Usuario.OutrosAcessos[0035];  // 03.07.06
// 12.11.12 - Vivan - reativado
    EdUnitario.enabled:=(not codigobarra);
    EdNatf_codigoitem.enabled:=(not codigobarra);
    if (EdMoes_tabp_codigo.asinteger>0) and (not codigobarra) then begin
      if FTabela.gettipo(EdMoes_tabp_codigo.asinteger) = 'A' then
        EdUnitario.setvalue( EdUnitario.AsCurrency + (EdUnitario.ascurrency*(FTabela.GetAliquota(EdMoes_tabp_codigo.asinteger)/100) ) )
      else
        EdUnitario.setvalue( EdUnitario.AsCurrency - (EdUnitario.ascurrency*(FTabela.GetAliquota(EdMoes_tabp_codigo.asinteger)/100) ) );
    end;

  end else begin
// 03.06.05
///
    if codbarra='N' then begin
      EdSt.enabled:=true;
      EdSt.text:='';
    end;
// 30.01.14 - A2Z
    if pos( 'DocNFiscal', Edcomv_codigo.ResultFind.FieldByName('comv_editsnota').asstring ) >0 then begin
        EdST.enabled:=false;
//        Edst.text:='1';
// 14.09.18 - Giacomoni
        Edst.text:='4';
        Edst.ValidFind;
        Edcfis_codigo.enabled:=false;
//        Edcfis_codigo.text:='1';
// 14.09.18
        Edcfis_codigo.text:='4';
        Edcfis_codigo.ValidFind;
        EdPercipi.enabled:=false;
        EdQtdeprev.Enabled:=false;
        EdValoruni.Enabled:=false;
    end;

  end;  // 20.07.05

  if pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Transferencia)>0 then begin
    if EdDtmovimento.asdate>1 then
      custotrans:=FEstoque.GetCusto(EdProduto.text,global.unidadematriz,'medio')
    else
      custotrans:=FEstoque.GetCusto(EdProduto.text,global.unidadematriz,'gerencial');
    EdUnitario.Setvalue(custotrans);    // 14.06.05
    EdValoruni.Setvalue(custotrans);    // 14.06.05
//    if EdUnid_codigo.resultfind<>nil then begin
//      if trim(EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring)='S' then begin
//         EdSt.enabled:=false;
//         EdSt.text:='000'; // se for optante do simples � tributado mas n�o paga na nota e sim pela tabela
//      end;
//    end;
// 06.07.05
    EdSt.enabled:=false;
    EdSt.text:=Global.CstTransferencia; // transferencia sempre fica 000;
  end;
// 21.09.05
  if (EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=global.CodDevolucaoIgualVenda) then  begin
    EdUnitario.enabled:=true;
    EdValoruni.enabled:=true;
  end;
  if EdPercipi.ascurrency=0 then
    EdPercipi.setvalue(EdPeripi.ascurrency);
end;

procedure TFNotaCompra.EdSTExitEdit(Sender: TObject);
//////////////////////////////////////////////////////
var pervariacao:currency;
    tipomovx:string;

      procedure GuardaCustos(produto:string;pericms,perfrete,peripi,pericmsfrete,pericmsfreteprev,perpis,percofins:currency);
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      var p,embalagem:integer;
          achou:boolean;
          xsqlcor,xsqltamanho,xsqlcopa:string;
      begin
        achou:=false;
        for p:=0 to ListaCustos.count-1 do begin
          PCustos:=ListaCustos[p];
//          if (PCustos.produto=produto) and (PCustos.codcor=EdCodcor.AsInteger) and  (PCustos.codtamanho=EdCodtamanho.AsInteger)
//            and  (PCustos.codcopa=EdCodcopa.AsInteger) then begin
// 21.08.06 - depois rever como atualizar os custos 'simultaneamente' do codigo 'normal' e de sua grade se houver
          if (PCustos.produto=produto) then begin
            achou:=true;
            break;
          end;
        end;
        if not achou then begin
          New(Pcustos);
          PCustos.produto:=produto;
// 21.08.06
///////////
          PCustos.codcor:=Edcodcor.asinteger;
          PCustos.codtamanho:=Edcodtamanho.asinteger;
          PCustos.codcopa:=Edcodcopa.asinteger;
// 09.03.12
//          embalagem:=QEstoque.fieldbyname('esto_embalagem').asinteger;
// 09.03.12
          embalagem:=EdEmbalagem.AsInteger;
          if embalagem=0 then embalagem:=1;
           PCustos.embalagem:=embalagem;
//////////////
          if (PCustos.codtamanho+Pcustos.codcor>0) then begin
             if PCustos.codcor>0 then
               xsqlcor:=' and esgr_core_codigo='+inttostr(PCustos.codcor)
             else
               xsqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
             if PCustos.codtamanho>0 then
               xsqltamanho:=' and esgr_tama_codigo='+inttostr(PCustos.codtamanho)
             else
               xsqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
             if PCustos.codcopa>0 then
               xsqlcopa:=' and esgr_copa_codigo='+inttostr(PCustos.codcopa)
             else
               xsqlcopa:=' and ( esgr_copa_codigo=0 or esgr_copa_codigo is null )';
          end;
          PCustos.unidade:=EdUnid_codigo.text;
// 07.11.09
          if (PCustos.codtamanho+Pcustos.codcor>0) then begin
// 07.11.09 - aqtde era do produto e nao da grade dele
            QGrade:=sqltoquery('select * from estgrades '+
                 ' where esgr_esto_codigo='+stringtosql(PCustos.produto)+
                 ' and esgr_status=''N'' and esgr_unid_codigo='+EdUNid_codigo.Assql+
                 xsqlcor+xsqltamanho+xsqlcopa );
            if not QGrade.eof then begin
              PCustos.acusto:=QGrade.fieldbyname('esgr_custo').ascurrency;
              PCustos.acustoger:=QGrade.fieldbyname('esgr_custoger').ascurrency;
              PCustos.acustomedio:=QGrade.fieldbyname('esgr_customedio').ascurrency;
              PCustos.acustomedioger:=QGrade.fieldbyname('esgr_customeger').ascurrency;
              PCustos.aqtde:=QGrade.fieldbyname('esgr_qtde').asfloat;
              PCustos.aqtdeprev:=QGrade.fieldbyname('esgr_qtdeprev').asfloat;
              PCustos.adataultcompra:=QGrade.fieldbyname('esgr_dtultcompra').AsDatetime;
              PCustos.custo:=FGeral.Custo(EdUnitario.ascurrency,pericms,perfrete,peripi,pericmsfrete,0,0,perpis,percofins,0);
              PCustos.customedio:=FGeral.CustoMedio(QGrade.fieldbyname('esgr_customedio').ascurrency,PCustos.custo,QGrade.fieldbyname('esgr_qtde').asfloat,EdQtde.asFloat);
              PCustos.custoger:=FGeral.CustoGer(EdValorUni.ascurrency,EdValorUni.ascurrency*(pericms/100),
                     perfreteprev,EdValorUni.ascurrency*(peripi/100),EdValorUni.ascurrency*(pericmsfreteprev/100),0,0);
              PCustos.customedioger:=FGeral.CustoMedioGerencial(QGrade.fieldbyname('esgr_customeger').ascurrency,EdValoruni.ascurrency,QGrade.fieldbyname('esgr_qtdeprev').asfloat,edqtdeprev.asfloat);
              if FGrupos.GetPercentualMargem(QEstoque.fieldbyname('Esto_grup_codigo').asinteger)<>100 then
                PCustos.precovenda:=PCustos.custo/(1-(FGrupos.GetPercentualMargem(QEstoque.fieldbyname('Esto_grup_codigo').asinteger))/100 )
              else
                PCustos.precovenda:=0;
            end else begin  // 04.05.10 - Abra - Fran - entrada de grade nova...sem custos e qtde
              PCustos.acusto:=0;
              PCustos.acustoger:=0;
              PCustos.acustomedio:=0;
              PCustos.acustomedioger:=0;
              PCustos.aqtde:=0;
              PCustos.aqtdeprev:=0;
              PCustos.adataultcompra:=QEstoque.fieldbyname('esqt_dtultcompra').AsDatetime;
              PCustos.custo:=FGeral.Custo(EdUnitario.ascurrency,pericms,perfrete,peripi,pericmsfrete,0,0,perpis,percofins,0);
              PCustos.customedio:=FGeral.CustoMedio(0,PCustos.custo,0,EdQtde.asFloat);
              PCustos.custoger:=FGeral.CustoGer(EdValorUni.ascurrency,EdValorUni.ascurrency*(pericms/100),
                     perfreteprev,EdValorUni.ascurrency*(peripi/100),EdValorUni.ascurrency*(pericmsfreteprev/100),0,0);
              PCustos.customedioger:=FGeral.CustoMedioGerencial(0,EdValoruni.ascurrency,0,edqtdeprev.asfloat);
              if FGrupos.GetPercentualMargem(QEstoque.fieldbyname('Esto_grup_codigo').asinteger)<>100 then
                PCustos.precovenda:=PCustos.custo/(1-(FGrupos.GetPercentualMargem(QEstoque.fieldbyname('Esto_grup_codigo').asinteger))/100 )
              else
                PCustos.precovenda:=0;
            end;
            FGeral.FechaQuery(QGrade);
          end else begin
// 29.02.12
//            embalagem:=QEstoque.fieldbyname('esto_embalagem').asinteger;
//            if embalagem=0 then embalagem:=1;
//            PCustos.embalagem:=embalagem;
            PCustos.acusto:=QEstoque.fieldbyname('esqt_custo').ascurrency;
            PCustos.acustoger:=QEstoque.fieldbyname('esqt_custoger').ascurrency;
            PCustos.acustomedio:=QEstoque.fieldbyname('esqt_customedio').ascurrency;
            PCustos.acustomedioger:=QEstoque.fieldbyname('esqt_customeger').ascurrency;
            PCustos.aqtde:=QEstoque.fieldbyname('esqt_qtde').asfloat;
            PCustos.aqtdeprev:=QEstoque.fieldbyname('esqt_qtdeprev').asfloat;
            PCustos.adataultcompra:=QEstoque.fieldbyname('esqt_dtultcompra').AsDatetime;
            PCustos.custo:=FGeral.Custo(EdUnitario.ascurrency,pericms,perfrete,peripi,pericmsfrete,0,0,perpis,percofins,0);
            PCustos.custo:=PCustos.custo/embalagem;
            PCustos.customedio:=FGeral.CustoMedio(QEstoque.fieldbyname('esqt_customedio').ascurrency,PCustos.custo,QEstoque.fieldbyname('esqt_qtde').asfloat,EdQtde.asFloat*embalagem);
  //        PCustos.custoger:=FGeral.Custo(EdValorUni.ascurrency,pericms,perfrete,peripi,pericmsfrete);
            PCustos.custoger:=FGeral.CustoGer(EdValorUni.ascurrency,EdValorUni.ascurrency*(pericms/100),
                   perfreteprev,EdValorUni.ascurrency*(peripi/100),EdValorUni.ascurrency*(pericmsfreteprev/100),0,0);
            PCustos.custoger:=PCustos.custoger/embalagem;
//            PCustos.customedioger:=FGeral.CustoMedioGerencial(QEstoque.fieldbyname('esqt_customeger').ascurrency,EdValoruni.ascurrency,QEstoque.fieldbyname('esqt_qtdeprev').asfloat,edqtdeprev.asfloat);
// 01.03.12
            PCustos.customedioger:=FGeral.CustoMedioGerencial(QEstoque.fieldbyname('esqt_customeger').ascurrency,PCustos.custoger,QEstoque.fieldbyname('esqt_qtdeprev').asfloat,edqtdeprev.asfloat*embalagem);
            if FGrupos.GetPercentualMargem(QEstoque.fieldbyname('Esto_grup_codigo').asinteger)<>100 then
              PCustos.precovenda:=PCustos.custo/(1-(FGrupos.GetPercentualMargem(QEstoque.fieldbyname('Esto_grup_codigo').asinteger))/100 )
            else
              PCustos.precovenda:=0;
          end;
          PCustos.qtde:=edqtde.asfloat*embalagem;
          PCustos.qtdeprev:=edqtdeprev.asfloat*embalagem;
          PCustos.dataultcompra:=EdDtemissao.AsDate;
          PCustos.unitario:=EdUnitario.ascurrency;
          PCustos.valoruni:=EdValoruni.ascurrency;
          PCustos.qtdeprevdig:=edqtdeprev.asfloat*embalagem;
          PCustos.pericms:=EdAliicms.ascurrency;
          PCustos.peripi:=EdPeripi.ascurrency;
// 29.09.09 - Capeg
          PCustos.perpis:=perpis;
          PCustos.percofins:=percofins;
// 27.04.15
          PCustos.perdesc:=EdPerdesco.AsCurrency;
          ListaCustos.Add(PCustos);
       end else begin
// 09.06.06 - por enquanto assim at� q tenha a grade com custo tbem por tamanho , cor e copa
{ - retirado pois quando exclui item durante a inclusao elimina da listacustos
          PCustos.unidade:=EdUnid_codigo.text;
          PCustos.qtde:=PCustos.qtde+edqtde.asfloat;
          PCustos.qtdeprev:=PCustos.qtdeprev+edqtdeprev.asfloat;
          PCustos.valoruni:=EdValoruni.ascurrency;
          PCustos.qtdeprevdig:=PCustos.qtdeprevdig+edqtdeprev.asfloat;
          PCustos.custo:=FGeral.Custo(EdUnitario.ascurrency,pericms,perfrete,peripi,pericmsfrete,0,0,perpis,percofins);

          PCustos.customedio:=FGeral.CustoMedio(QEstoque.fieldbyname('esqt_customedio').ascurrency,PCustos.custo,QEstoque.fieldbyname('esqt_qtde').ascurrency,edqtde.asfloat);
          PCustos.custoger:=FGeral.CustoGer(EdValorUni.ascurrency,EdValorUni.ascurrency*(pericms/100),
                 perfreteprev,EdValorUni.ascurrency*(peripi/100),EdValorUni.ascurrency*(pericmsfreteprev/100),0,0);
          PCustos.customedioger:=FGeral.CustoMedioGerencial(QEstoque.fieldbyname('esqt_customeger').ascurrency,EdValoruni.ascurrency,QEstoque.fieldbyname('esqt_qtdeprev').asfloat,edqtdeprev.asfloat);
}
       end;
      end;


     function PedeConfirmacao:boolean;
     ////////////////////////////////
     begin
// 17.10.05 - para nao pedir confirmacao em devolu��o de venda
       if pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.CodDevolucaoVenda+';'+
              Global.CodDevolucaoVendaConsig+';'+Global.CodRetornoMostruario)>0 then
         result:=true
       else
         result:=confirma('Confirma item ?');
     end;


begin
///////////////////////////////////////////////////////

  if Pedeconfirmacao then begin
//    EditstoGrid;
    if (QEstoque.eof) and (EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring<>Global.CodTransfEntrada) then begin
      Avisoerro('N�o encontrado o custo deste produto.  NAO MOVIMENTADO');
      exit;
    end;
//      exit;
//    GuardaCustos(EdProduto.text,EdAliicms.AsCurrency,perfrete,Edperipi.ascurrency,pericmsfrete);
// 26.08.04 - colocado % ipi por item caso variar dentro da mesma nota
//      SetaEditsValores;
  // ver para mudar na fun��o para q quando tiver codigo de grade enviar tamanho e cor para atualizar tamb�m no
  // estgrades, al�m do estoqueqtde - ver se faz outra funcao para movimentar ...
    pervariacao:=0;
////////// - aqui em 29.09.09 - estava no botao incluir
    if descpiscofins then
      vlrfreteliquido:=EdFrete.ascurrency -( EdFrete.ascurrency*(EdPericmsFrete.ascurrency/100) ) -( EdFrete.ascurrency*(FCodigosFiscais.GetAliquotaPis(Edcfis_codigo.Text)/100) ) -( EdFrete.ascurrency*(FCodigosFiscais.GetAliquotaCofins(Edcfis_codigo.Text)/100) )
    else
      vlrfreteliquido:=EdFrete.ascurrency -( EdFrete.ascurrency*(EdPericmsFrete.ascurrency/100) )  ;


    if Eddigtotalnf.ascurrency>0 then begin
      pericmsfrete:=( ( EdFrete.ascurrency*(EdPericmsFrete.ascurrency/100) )/Eddigtotalnf.ascurrency )*100;
      perfrete:=(vlrfreteliquido/Eddigtotalnf.ascurrency)*100;
    end else begin
      perfrete:=0;
      pericmsfrete:=0;
    end;
    if EdValortotal.ascurrency>0 then begin
      pericmsfreteprev:=( ( EdFrete.ascurrency*(EdPericmsFrete.ascurrency/100) )/EdValortotal.ascurrency )*100;
    //    perfreteprev:=(EdFrete.ascurrency/EdValortotal.ascurrency)*100;
    //    perfreteprev:=(vlrfreteliquido/EdValortotal.ascurrency)*100;
    //  10.08.05
      perfreteprev:=(vlrfreteliquido/(EdValortotal.ascurrency-EdDigvicms.ascurrency))*100;
    end else begin
      pericmsfreteprev:=0;
      perfreteprev:=0;
    end;
////////////

    if (EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring<>Global.CodTransfEntrada) and (OP<>'A') then begin
        if descpiscofins then
          GuardaCustos(EdProduto.text,EdAliicms.AsCurrency,perfrete,Edpercipi.ascurrency,pericmsfrete,pericmsfreteprev,FCodigosFiscais.GetAliquotaPis(Edcfis_codigo.Text),FCodigosFiscais.GetAliquotaCofins(Edcfis_codigo.Text) )
        else
          GuardaCustos(EdProduto.text,EdAliicms.AsCurrency,perfrete,Edpercipi.ascurrency,pericmsfrete,pericmsfreteprev,0,0 );
///////// - 12.04.06
      if ( pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,EntranoCusto ) > 0 )  and
          ( EdNatf_codigo.text<>'3120' )  // 22.06.06
          then begin
          if Pcustos.acusto>0 then begin
            pervariacao:= ( abs( PCustos.acusto-PCustos.custo ) / Pcustos.acusto )*100;
          end else
            pervariacao:=0;
          if ( FGeral.Getconfig1asfloat('percaumcusto')>0 ) and (pervariacao>FGeral.Getconfig1asfloat('percaumcusto')) and (pervariacao>0) then begin
             Avisoerro('Custo Atual:'+floattostr(Pcustos.acusto)+
                      ';Custo Novo:'+floattostr(Pcustos.custo)+
                      ';Custo Cadastro'+floattostr(QEstoque.fieldbyname('esqt_custo').ascurrency) );
///////             exit; - ver se coloca usuario pra liberar...
          end;
      end;
/////////////
    end;
    EditstoGrid;
    SetaEditsValores;
// 19.08.05
    if ( pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,EntranoCusto ) = 0 ) then begin
      FGeral.MovimentaQtdeEstoque(Edproduto.text,EdUNid_codigo.text,'E',EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,edqtde.asfloat,QEstoque,edqtdeprev.asfloat,EdPecas.asfloat);
      Sistema.commit;
    end else if pos(Op,'A;F')>0 then begin // incluindo item na alteracao de nota - 28.10.09
      if EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=global.CodCompra then
        tipomovx:=Global.CodCompra100
      else
        tipomovx:=EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring;
      FGeral.MovimentaQtdeEstoque(Edproduto.text,EdUNid_codigo.text,'E',tipomovx,edqtde.asfloat,QEstoque,edqtdeprev.asfloat,EdPecas.asfloat);
      Sistema.commit;
    end;

  end;

  LimpaEditsItens;
  EdProduto.SetFocus;
  QEstoque.close;
  Freeandnil(QEstoque);

end;

procedure TFNotaCompra.LimpaEditsItens;
begin
  EdProduto.Clear;
  EdQtde.Clear;
  EdValoruni.clear;
  EdQtdeprev.clear;
  EdUnitario.Clear;
  SetedEsto_descricao.Clear;
  EdSt.clear;
  Edcfis_codigo.Clear;

end;

///////////////////////////////////////////
procedure TFNotaCompra.Editstogrid;
///////////////////////////////////////////
var x,codigosit:integer;
    aqtde,aliicms,margemlucro,reducaobase:currency;
    codigofis,codigoCST:string;

begin
//  x:=FGeral.ProcuraGrid(0,EdProduto.Text,Grid);
// 08.06.06
  x:=ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdProduto.Text,grid.getcolumn('move_tama_codigo'),EdCodtamanho.asinteger,
                        grid.getcolumn('move_core_codigo'),Edcodcor.asinteger,grid.getcolumn('move_copa_codigo'),Edcodcopa.asinteger);
//  aliicms:=FCodigosFiscais.GetAliquota(EdCfis_codigo.text) ;
// 21.09.05
  if pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Devolucao ) > 0 then
     aliicms:=FEstoque.Getaliquotaicms(EdProduto.text,Edunid_codigo.text,Qfornec.fieldbyname(campoufentidade).asstring,EdFornec.asinteger,Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring)
  else
    aliicms:=FCodigosFiscais.GetAliquota(EdCfis_codigo.text) ;
// 22.05.07
  reducaobase:=FCodigosFiscais.GetAliquotaRedBase(EdCfis_codigo.text) ;

// 23.02.05
  if EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodVendaConsigMercantil then
    aliicms:=0;

//  Arq.TSittributaria.Locate('sitt_codigo',FEstoque.Getsituacaotributaria(Edproduto.text,EdUnid_codigo.text,EdFornec.resultfind.fieldbyname(campoufentidade).asstring),[]);
  if pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Devolucao ) > 0 then begin

     margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(Edproduto.text,EdUnid_codigo.text,QFornec.fieldbyname(campoufentidade).asstring));
//     codigosit:=FEstoque.GetCodigosituacaotributaria(EdProduto.text,EdUnid_codigo.text,EdFornec.resultfind.fieldbyname('clie_uf').asstring)
     codigosit:=FEstoque.GetCodigosituacaotributaria(EdProduto.text,EdUnid_codigo.text,QFornec.fieldbyname(campoufentidade).asstring)

  end else begin

     margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(Edproduto.text,EdUnid_codigo.text,QFornec.fieldbyname(campoufentidade).asstring));
     codigosit:=FEstoque.GetCodigosituacaotributaria(EdProduto.text,EdUnid_codigo.text,QFornec.fieldbyname(campoufentidade).asstring);

  end;

// 24.02.05 - para as transf. de entrada
  if codigosit=0 then
    codigosit:=EdSt.asinteger;
  codigofis:=EdCfis_codigo.text;
// 10.02.05 - Reges
  if pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.TiposNaoCalcSubsTrib)>0 then
     margemlucro:=0;

  if EdSt.resultfind<>nil then
     codigoCST:=EdSt.resultfind.Fieldbyname('sitt_cst').asstring
  else begin
     Arq.TSittributaria.locate('sitt_codigo',codigosit,[]);
     codigoCST:=Arq.TSittributaria.Fieldbyname('sitt_cst').asstring;
  end;
// 16.01.12 - empresa do simples fazendo entrada com a 'propria nota'
  if pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,TiposNumeracaoSaida+';'+Global.codcompraprodutor) > 0 then begin
    if pos(EdUnid_codigo.ResultFind.Fieldbyname('unid_simples').asstring,'S;2')>0 then
      codigoCST:=Arq.TSittributaria.fieldbyname('sitt_cstme').AsString;
  end;
// 21.09.05
  if EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodDevolucaoIgualVenda then begin
    codigoCST:=FEstoque.Getsituacaotributaria(EdProduto.text,Edunid_codigo.text,Qfornec.fieldbyname(campoufentidade).asstring,Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring);
// 18.05.11 - Cenitech - nf de entrada emitidas 'com o bloco da empresa'
    if pos(EdUnid_codigo.ResultFind.Fieldbyname('unid_simples').asstring,'S;2')>0 then
      codigoCST:=Arq.TSittributaria.fieldbyname('sitt_cstme').AsString;
  end;
// 24.10.11 - Bavi...cst errado 'as vezes

/////////
//  if x<=0 then begin
  if x<0 then begin
{
    if (Grid.RowCount=2) and (Trim(Grid.Cells[0,1])='') then begin
       x:=1;
    end else begin
       Grid.RowCount:=Grid.RowCount+1;
       x:=Grid.RowCount-1;
    end;
}
    Grid.AppendRow;
    Grid.Cells[Grid.Getcolumn('move_esto_codigo'),Abs(x)]:=EdProduto.Text;
    Grid.Cells[grid.getcolumn('cor'),Abs(x)]:=FCores.getdescricao(EdCodcor.Asinteger);
    Grid.Cells[grid.getcolumn('tamanho'),Abs(x)]:=FTamanhos.getdescricao(EdCodtamanho.Asinteger);
    Grid.Cells[grid.getcolumn('copa'),Abs(x)]:=FCopas.getdescricao(EdCodcopa.Asinteger);
    Grid.Cells[Grid.Getcolumn('move_tama_codigo'),Abs(x)]:=EdCodtamanho.text;
    Grid.Cells[Grid.Getcolumn('move_core_codigo'),Abs(x)]:=EdCodcor.text;
    Grid.Cells[Grid.Getcolumn('move_copa_codigo'),Abs(x)]:=EdCodcopa.text;
    Grid.Cells[Grid.Getcolumn('esto_descricao'),Abs(x)]:=SetEdEsto_descricao.text;
//    Grid.Cells[2+2,Abs(x)]:=Arq.TSittributaria.Fieldbyname('sitt_cst').asstring;
//    Grid.Cells[2+2,Abs(x)]:=EdSt.resultfind.Fieldbyname('sitt_cst').asstring;
// 25.02.05
    Grid.Cells[Grid.Getcolumn('Move_cst'),Abs(x)]:=codigoCST;
    Grid.Cells[Grid.Getcolumn('Move_aliicms'),Abs(x)]:=currtostr(aliicms);
    Grid.Cells[Grid.Getcolumn('move_aliipi'),Abs(x)]:=EdPercipi.AsSql;
    Grid.Cells[Grid.Getcolumn('Esto_Unidade'),Abs(x)]:=Arq.TEstoque.fieldbyname('esto_unidade').asstring;
    Grid.Cells[Grid.Getcolumn('move_qtde'),Abs(x)]:=EdQTde.AsSql;
    Grid.Cells[Grid.Getcolumn('move_venda'),Abs(x)]:=EdUnitario.AsSql;
//    Grid.Cells[8+2,Abs(x)]:=TRansform(edqtde.asfloat*EdUnitario.AsCurrency,f_cr);
// 05.11.09 - ABra - conversao barras para metros
    Grid.Cells[Grid.Getcolumn('total'),Abs(x)]:=TRansform(edqtde.asfloat*EdUnitario.AsFloat,f_cr);
    Grid.Cells[Grid.Getcolumn('qtdeprev'),Abs(x)]:=EdQTdeprev.AsSql;
    Grid.Cells[Grid.Getcolumn('valoruni'),Abs(x)]:=EdVAloruni.AsSql;
    Grid.Cells[Grid.Getcolumn('margemlu'),Abs(x)]:=Transform(margemlucro,f_cr);
    Grid.Cells[Grid.Getcolumn('codigosittrib'),Abs(x)]:=inttostr(codigosit);
    Grid.Cells[Grid.Getcolumn('codigofis'),Abs(x)]:=codigofis;
    Grid.Cells[Grid.Getcolumn('move_pecas'),Abs(x)]:=EdPecas.assql;
    Grid.Cells[Grid.Getcolumn('move_redubase'),Abs(x)]:=Transform(reducaobase,'#0.000');
// 23.12.08
    Grid.Cells[Grid.Getcolumn('move_certificado'),Abs(x)]:=EdCertificado.text;
// 13.09.10
//    Grid.Cells[Grid.Getcolumn('move_natf_codigo'),Abs(x)]:=FSittributaria.GetCfop(codigosit,EdNatf_codigo.text);
    Grid.Cells[Grid.Getcolumn('move_natf_codigo'),Abs(x)]:=EdNatf_codigoitem.text;
// 05.09.12
    Grid.Cells[Grid.Getcolumn('move_unitarionota'),Abs(x)]:=EdUnitario.AsSql;
    Grid.Cells[Grid.Getcolumn('move_embalagem'),Abs(x)]:=EdEmbalagem.text;

  end else begin

    Grid.Cells[Grid.Getcolumn('move_core_codigo'),x]:=EdProduto.Text;
    Grid.Cells[grid.getcolumn('cor'),Abs(x)]:=FCores.getdescricao(EdCodcor.Asinteger);
    Grid.Cells[grid.getcolumn('tamanho'),Abs(x)]:=FTamanhos.getdescricao(EdCodtamanho.Asinteger);
    Grid.Cells[grid.getcolumn('copa'),Abs(x)]:=FCopas.getdescricao(EdCodcopa.Asinteger);
    Grid.Cells[Grid.Getcolumn('move_tama_codigo'),Abs(x)]:=EdCodtamanho.text;
    Grid.Cells[Grid.Getcolumn('move_core_codigo'),Abs(x)]:=EdCodcor.text;
    Grid.Cells[Grid.Getcolumn('move_copa_codigo'),Abs(x)]:=EdCodcopa.text;
    Grid.Cells[Grid.Getcolumn('esto_descricao'),Abs(x)]:=SetEdEsto_descricao.text;
//    Grid.Cells[2+2,x]:=Arq.TSittributaria.Fieldbyname('sitt_cst').asstring;
//////////////////////////////////////////
//    Grid.Cells[2+2,Abs(x)]:=codigoCST;
//    Grid.Cells[3+2,x]:=currtostr(aliicms);
//    Grid.Cells[4+2,x]:=Valortosql(EdPercipi.ascurrency);
//    Grid.Cells[5+2,x]:=Arq.TEstoque.fieldbyname('esto_unidade').asstring;
//    Grid.Cells[5,x]:=Transform(texttovalor(Grid.Cells[5,x])+edqtde.asfloat,f_cr);
//    Grid.Cells[6+2,x]:=Valortosql( texttovalor(Grid.Cells[6+2,x])+edqtde.asfloat );
//    Grid.Cells[7+2,x]:=Valortosql(EdUnitario.Ascurrency);
//    Grid.Cells[8+2,x]:=Valortosql( (aqtde)*EdUnitario.AsCurrency);
//    Grid.Cells[8+2,x]:=Valortosql( (aqtde)*EdUnitario.AsFloat);
//    Grid.Cells[9+2,x]:=Valortosql( texttovalor(Grid.Cells[9+2,x])+edqtdeprev.asfloat );
//    Grid.Cells[10+2,x]:=Valortosql(EdValoruni.Ascurrency);
//    Grid.Cells[11+2,x]:=Transform(margemlucro,f_cr);
//    Grid.Cells[12+2,x]:=inttostr(codigosit);
//    Grid.Cells[13+2,x]:=codigofis;
////////////////////////////////////
    aqtde:=texttovalor(Grid.Cells[Grid.Getcolumn('move_qtde'),x])+ edqtde.asfloat;
    Grid.Cells[Grid.Getcolumn('Move_cst'),Abs(x)]:=codigoCST;
    Grid.Cells[Grid.Getcolumn('Move_aliicms'),Abs(x)]:=currtostr(aliicms);
    Grid.Cells[Grid.Getcolumn('move_aliipi'),Abs(x)]:=EdPercipi.AsSql;
    Grid.Cells[Grid.Getcolumn('Esto_Unidade'),Abs(x)]:=Arq.TEstoque.fieldbyname('esto_unidade').asstring;
    Grid.Cells[Grid.Getcolumn('move_qtde'),Abs(x)]:=Valortosql( texttovalor(Grid.Cells[Grid.Getcolumn('move_qtde'),x])+edqtde.asfloat );
    Grid.Cells[Grid.Getcolumn('move_venda'),Abs(x)]:=EdUnitario.AsSql;
//    Grid.Cells[8+2,Abs(x)]:=TRansform(edqtde.asfloat*EdUnitario.AsCurrency,f_cr);
// 05.11.09 - ABra - conversao barras para metros
    Grid.Cells[Grid.Getcolumn('total'),Abs(x)]:=Valortosql( (aqtde)*EdUnitario.AsFloat);
    Grid.Cells[Grid.Getcolumn('qtdeprev'),Abs(x)]:=Valortosql( texttovalor(Grid.Cells[Grid.Getcolumn('qtdeprev'),x])+edqtdeprev.asfloat );
    Grid.Cells[Grid.Getcolumn('valoruni'),Abs(x)]:=EdVAloruni.AsSql;
    Grid.Cells[Grid.Getcolumn('margemlu'),Abs(x)]:=Transform(margemlucro,f_cr);
    Grid.Cells[Grid.Getcolumn('codigosittrib'),Abs(x)]:=inttostr(codigosit);
    Grid.Cells[Grid.Getcolumn('codigofis'),Abs(x)]:=codigofis;

////////////////////////////////

    Grid.Cells[Grid.Getcolumn('move_pecas'),x]:=EdPecas.assql;
    Grid.Cells[Grid.Getcolumn('move_redubase'),x]:=Transform(reducaobase,'#0.000');
// 23.12.08
    Grid.Cells[Grid.Getcolumn('move_certificado'),x]:=EdCertificado.text;
// 13.09.10
//    Grid.Cells[Grid.Getcolumn('move_natf_codigo'),Abs(x)]:=FSittributaria.GetCfop(codigosit,EdNatf_codigo.text);
    Grid.Cells[Grid.Getcolumn('move_natf_codigo'),Abs(x)]:=EdNatf_codigoitem.text;
// 05.09.12
    Grid.Cells[Grid.Getcolumn('move_unitarionota'),Abs(x)]:=EdUnitario.AsSql;
    Grid.Cells[Grid.Getcolumn('move_embalagem'),Abs(x)]:=EdEmbalagem.text;
  end;
  Grid.Refresh;

end;

//////////////////////////////////////////////////
procedure TFNotaCompra.Execute(Acao: string ;ctrans:string='');
///////////////////////////////////////////////////////////////////
var QT:TSqlquery;
    operacao:string;

begin

  if FNOtaCompra=nil then begin
    FGeral.CreateForm(TFNOtaCompra,FNOtaCompra);
  end;
  FNOtaCompra.bteste.Visible:=false; //Global.Usuario.Codigo=100;
  FNOtaCompra.bteste.Enabled:=false; // Global.Usuario.Codigo=100;
// 15.06.12
  FNOtaCompra.bbuscanfe.Visible:=Global.Usuario.OutrosAcessos[0332];
  FNOtaCompra.bbuscanfe.Enabled:=Global.Usuario.OutrosAcessos[0332];
// 05.09.12
  FNOtaCompra.EdEmbalagem.Enabled:=Global.Topicos[1356];
// 08.12.13
  global.UltimoFormAberto:=FNotaCompra.Name;
// 25.08.2022
  FNOtaCompra.EdBasesubs.Enabled:=Global.Usuario.OutrosAcessos[0355];
  FNOtaCompra.Edvalorsubs.Enabled:=Global.Usuario.OutrosAcessos[0355];


  if Global.Topicos[1466] then begin

     FNOtaCompra.EdVencimento.TypeValue := TTypeValue.tvDateLng  ;

  end else begin

     FNOtaCompra.EdVencimento.TypeValue:=TTypeValue.tvDate;

  end;
//  Devolucao:=Global.CodDevolucaoRoman+';'+Global.CodDevolucaoVenda+';'+Global.CodDevolucaoConsigMerc;
// 14.04.05
//  Devolucao:=Global.CodDevolucaoRoman+';'+Global.CodDevolucaoVenda+';'+Global.CodDevolucaoConsigMerc+';'+Global.CodRetornoMostruario;
// 21.09.04
//  Devolucao:=Global.CodDevolucaoRoman+';'+Global.CodDevolucaoVenda+';'+Global.CodDevolucaoConsigMerc+';'+
//             Global.CodRetornoMostruario+';'+Global.CodDevolucaoIgualVenda;
// 27.03.06
  Devolucao:=Global.CodDevolucaoRoman+';'+Global.CodDevolucaoVenda+';'+Global.CodDevolucaoConsigMerc+';'+
             Global.CodRetornoMostruario+';'+Global.CodDevolucaoIgualVenda+';'+Global.CodDevolucaoVendaConsig+';'+
             Global.CodDevolucaoSemFinan+';'+Global.CodDevolucaoBonificacao;
// 30.04.10
  TiposNumeracaoSaida:=Global.CodEntradaImobilizado+';'+Global.CodCompraConsignado+';'+Global.CodEstornoNFeSai+';'+
                       Global.CodDevolucaodeRemessa+';'+FGeral.GetConfig1AsString('TIPOSENUMSAIDA')+';'+
                       Global.CodCompraProdutorMerenda+';'+Global.CodNfeComplementoValorProdutor+';'+
                       Global.CodDevolucaoBonificacao;

//////////////////////////////////// 07.07.08 - vindos do activate do form
// 11.09.08
  FGeral.EstiloForm(FNotaCompra);
  Op:=Acao;
  if OP='A' then
    operacao:='Altera��o'
  else if OP='F' then
    operacao:='Altera��o FISCAL'
  else
    operacao:='Inclus�o';

  FNotaCompra.Caption:='Nota Fiscal de Entrada - '+operacao;
//  ShowModal;
// 26.10.10
  FGeral.ConfiguraTamanhoEditsEnabled(FNotaCompra,FGeral.GetConfig1AsInteger('tamanholetra'));
// 09.03.12
  FGeral.ConfiguraColorEditsNaoEnabled(FNotaCompra);

  FNotaCompra.PBotoesGrid.Enabled:=Global.Usuario.OutrosAcessos[0324];
  FNotaCompra.PBotoesGrid.Visible:=Global.Usuario.OutrosAcessos[0324];
// 23.09.13
  FNotaCompra.EdCodEqui.Visible:=Global.Topicos[1367];
  FNotaCompra.EdCodEqui.Enabled:=Global.Topicos[1367];
  FNotaCompra.EdCodEqui.clear;
// 11.05.20
  FNotaCompra.pcodbarra.Visible:=false;
  FNotaCompra.pcodbarra.Enabled:=false;
  FNotaCompra.Gridcodbarra.Clear;

  FNotaCompra.Show;
  Sistema.beginprocess('Abrindo tabelas');
  FNotaCompra.Grid.Clear;  // 15.10.10
  FNotaCompra.Gridparcelas.Clear;  // 08.02.11
  FNotaCompra.Gridparcelas2.Clear;  // 08.02.11
  FNotaCompra.EdPort_codigo.clearall(FNotaCompra,99); // 16.04.2021

  if not Arq.TTransp.Active then Arq.TTransp.Open;
  if not Arq.TEstoque.Active then Arq.TEstoque.Open;
  if not Arq.TEstoqueQtde.Active then Arq.TEstoqueQtde.Open;
  if not Arq.TFornec.Active then Arq.TFornec.Open;
//  Arq.TNatFisc.OpenWith('natf_es=''E''',Arq.TNatFisc.Ordenacao);
//  if not Arq.TConfMovimento.Active then Arq.TConfMovimento.Open;
//  Arq.TConfMovimento.SetFilter( FGeral.GetIN('comv_tipomovto',Global.TiposEntrada,'C') );
  Arq.TConfMovimento.OpenWith(FGeral.GetIN('comv_tipomovto',Global.TiposEntrada,'C'),Arq.TConfMovimento.Ordenacao);
  if not Arq.TFPgto.Active then Arq.TFPgto.Open;
  if not Arq.TPortadores.Active then Arq.TPortadores.Open;
  if not Arq.TSittributaria.Active then Arq.TSittributaria.Open;
  if not Arq.TCodigosFiscais.active then Arq.TCodigosFiscais.open;
//////////////  Op:='I';  // por enquanto fixo

  with FNotaCompra do begin

  EdComv_codigo.ClearAll(FNotaCompra,99);
// 27.10.09
  EdMoes_cola_codigo.ClearAll(FNotaCompra,99);
  EdUnid_codigo.Text:=Global.CodigoUnidade;
//  EdDtEmissao.SetDate(Sistema.hoje);
  EdDtEntrada.SetDate(Sistema.hoje);
  EdTotal.visible:=Global.Usuario.OutrosAcessos[0010];
  EdTotal.enabled:=Global.Usuario.OutrosAcessos[0010];
//  EdValorTotal.visible:=Global.Usuario.OutrosAcessos[0010];
//  EdValorTotal.enabled:=Global.Usuario.OutrosAcessos[0010];
// 27.10.09 - outro acesso pra controlar isto pra nao dar bostex nem bandeira
  EdValorTotal.visible:=Global.Usuario.OutrosAcessos[0050];
  EdValorTotal.enabled:=Global.Usuario.OutrosAcessos[0050];

  EdComv_codigo.setfocus;


//  ListaCustos:=TList.create;
//  FGeral.setamovimento(EdDtmovimento);
// 17.01.12 - retirado por ser 'mais util' nas saidas...
// 26.11.12  - recolocado - devolucoes da Vivan
  if ( Global.Usuario.OutrosAcessos[0321] ) then
    FGeral.setamovimento(EdDtmovimento)
  else
    EdDtmovimento.setdate(sistema.hoje);
  Sistema.endprocess('');

/////////////////////////////////////
  Transferencia:=Global.CodTransfEntrada+';'+Global.CodTransfSaida+';'+Global.CodTransfEnt+';'+Global.CodTransfSai;
// 16.05.06
  Especiais:=Global.CodRetornocomservicos+';'+Global.codretornoind+';'+Global.CodDevolucaoind;
//  EntranoCusto:=Global.CodCompra+';'+Global.CodCompra100+';'+Global.CodCompraX;
// 22.10.09
  EntranoCusto:=Global.CodCompra+';'+Global.CodCompra100+';'+Global.CodCompraX+';'+
                Global.CodCompraMatConsumo+';'+Global.CodCompraFutura;
// 25.03.08
//  EntranoCusto:=Global.CodCompra+';'+Global.CodCompra100+';'+Global.CodCompraX+';'+Global.CodDevolucaoInd;
  EdBaseicms.ClearAll(FNotaCompra,99);
  EdPeracre.clearall(FNotaCompra,99);
  Unidade:=Global.CodigoUnidade;
  transacao1:='';
  transacao2:='';
  transacaoant:='';
//  PParcelas2.visible:=Global.Usuario.OutrosAcessos[0010];
//  PParcelas2.enabled:=Global.Usuario.OutrosAcessos[0010];
// 27.10.09
  PParcelas2.visible:=Global.Usuario.OutrosAcessos[0050];
  PParcelas2.enabled:=Global.Usuario.OutrosAcessos[0050];
  EdTotalservicos.setvalue(0);

  EdDtemissao.setdate(sistema.hoje);
// 04.12.07
  FGeral.SetaSeriesValidas(EdSerie);
// 03.05.07
//  Show;
  EdPecas.Enabled:=Global.Topicos[1302];
  EdMuni_codigo.setvalue(0);
// 23.11.07 - mariane fez NP em unidade 999
  FUnidades.SetaItems(EdUnid_codigo,SetEdUNID_NOME,Global.Usuario.UnidadesMvto);
  if not EdPecas.enabled then
    EdPecas.setvalue(0);
// 06.03.08
  EdNroobra.Enabled:=Global.Topicos[1204];
  if Global.Topicos[1204] then
    SetaEditObra;

  Edtotalnota.Color:=clblack;
  pservicos.Visible:=false;
  pservicos.enabled:=false;
// 10.12.07
  transacaobusca:='';
// 04.06.08
  TipoEntradaAbate:='EA';
// 22.08.13
  EdSeto_codigo.enabled:=Global.Topicos[1365];
//
  if pos(acao,'A;F')>0 then begin
    transacaobusca:=ctrans;
    Input('Informe a transa��o a ser alterada ','Transa��o ',transacaobusca,12,true);
    if trim(transacaobusca)<>'' then begin
// 10.01.08  - em ordem de operacao para, no caso de NP, achar primeiro NP e nao a ME q � gerada junto...
      QT:=sqltoquery('select * from movesto where moes_transacao='+stringtosql(transacaobusca)+
          ' and moes_status<>''C'''+
          ' order by moes_operacao');
      if not Qt.eof then begin
        EdComv_codigo.Text:=Qt.fieldbyname('moes_comv_codigo').asstring;
        EdComv_codigo.valid;
        EdFornec.setvalue(Qt.fieldbyname('moes_tipo_codigo').asinteger);
        EdFornec.Valid;
        EdUnid_codigo.text:=Qt.fieldbyname('moes_unid_codigo').asstring;
        EdUnid_codigo.validfind;
        EdTran_codigo.text:=Qt.fieldbyname('moes_tran_codigo').asstring;
//        EdTran_codigo.validfind;
// 16.12.19 - Novicarnes - alterar KM
        EdTran_codigo.valid;
        EdNatf_codigo.text:=Qt.fieldbyname('moes_natf_codigo').asstring;
        EdNatf_codigo.validfind;
        EdDtemissao.SetDate(Qt.fieldbyname('moes_dataemissao').asdatetime);
        EdDtemissao.validfind;
        EdNumerodoc.setvalue(Qt.fieldbyname('moes_numerodoc').asinteger);
// 11.09.09
        EdDtEntrada.SetDate(Qt.fieldbyname('moes_datamvto').asdatetime);
// 21.03.18 - alteracao de entrada de servi�os
        CampostoeditsII(Qt);
// 16.12.19 - Novicarnes
        EdMoes_cola_codigo.text:=Qt.fieldbyname('moes_cola_codigo').asstring;
        EdMoes_cola_codigo.Validfind;
        EdMoes_km.text         :=Qt.fieldbyname('moes_km').asstring;
        EdNumerodoc.SetFocus;
      end else begin
        Avisoerro('Transa��o n�o encontrada ou cancelada');  // 03.10.08
        EdComv_codigo.ClearAll(FNotaCompra,99);
      end;
      FGeral.FechaQuery(Qt);
    end;
  end;
// 23.12.08
//  EdCertificado.enabled:=Global.Topicos[1326];
// 30.12.08 - deixado no fornecedor

// 01.08.07
//  FPlano.SetaItems(EdPlan_conta,EdPlan_descricao,'M');
// mais pratico a consulta do cadastro...
// 14.02.09 - Carli
  EdPlan_conta.Empty:=not Global.Topicos[1328];
// 24.02.10 - Abra
  EdPlan_conta.Enabled:=not Global.Topicos[1341];
// 05.08.10 - Abra
   if trim(FGeral.getconfig1asstring('CORESVALIDAS'))<>'' then
     FCores.SetaItems(EdCodcor,nil,FGeral.getconfig1asstring('CORESVALIDAS'),'');
// 13.09.10
   EdNatf_codigoitem.enabled:=Global.Topicos[1343];
// 14.10.10
   if op='I' then begin
     EdArquivoxml.Enabled:=Global.Topicos[1346];
     bbuscaxml.enabled:=Global.Topicos[1346];
   end else begin
     EdArquivoxml.Enabled:=false;
     EdArquivoxml.Text:='';
     bbuscaxml.enabled:=false;
   end;
   ACbrNfe1.NotasFiscais.Clear;
  end;  // with FNotaCompra
// 02.06.16
  NotaEstorno:='N';
// 13.02.18
  Global.CodContaDevVenda:=FGeral.GetConfig1AsInteger('CtaDevVenda');
// 24.03.2021
  if Global.usuario.codigo = 100 then begin

    FNotacompra.bguiast.Enabled := true;
    FNotacompra.bguiast.Visible := true;

  end;

end;

//////////////////////////////////////////////////////
procedure TFNotaCompra.SetaEditsValores;
//////////////////////////////////////////////////////////////////////////////////////////////////////
var baseicms,totalprodutos,totalnota,totalitem,aliicms,total,totalitemliq,basesubs,icmssubs,tqtde,
    margemlucro,icmssubsnota,perfunrural,percotacapital,totalitembase,totalipi,aliipi,ipiitem,
    baseicmssemreducao,
    totalservicos,
    baseII,
    percdif             :currency;
    rateioicmsimportacao,vlricms,icmsitem,vlrrateioicmsimportacao:extended;
    p,codigosit:integer;
    produto,produtonfe,cfopitem:string;
    TSittributaria:TSqlquery;  // 24.10.11

//    Lista:TStringlist;
begin

  baseicms:=0; vlricms:=0; totalprodutos:=0 ;basesubs:=0 ; icmssubs:=0 ; tqtde:=0; icmssubsnota:=0;
  baseicmssemreducao:=0;totalservicos:=0;
// percorrer o grid somando valores e montando base do icms normal e subst. tribut�ria
  perfunrural:=FGeral.Getconfig1asfloat('perfunrural');
  valornotafinan:=0;
// 26.12.09 - produtor rural pessoa fisica
  if Ansipos( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodCompraProdutor+';'+
              Global.CodCompraProdutorMerenda+';'+
// 22.02.2021 - Vida Nova
              Global.CodNfeComplementoValorProdutor)>0 then begin

    if QFornec.FieldByName('clie_tipo').AsString='J' then
      perfunrural:=FGeral.Getconfig1asfloat('perfunruraljur');
// 05.05.10 - produtor rural Nao empregador - Novi - vava
    if QFornec.FieldByName('clie_aliinsspro').Ascurrency=99 then
      perfunrural:=0
    else if QFornec.FieldByName('clie_aliinsspro').Ascurrency>0 then
      perfunrural:=QFornec.FieldByName('clie_aliinsspro').Ascurrency;

  end;
/////////////////////////////
  percotacapital:=FGeral.Getconfig1asfloat('percotacapital');
  totalipi:=0;
//  Lista:=TStringlist.create;
  cfopitem:='';

// 28.05.12
  rateioicmsimportacao:=0;
//////////////////////////////////////////////
{
  if ( EdDigtotalnf.ascurrency < EdDigBicms.ascurrency )
    and
   ( EdDigvicms.ascurrency>0 )
    and
   ( Acbrnfe1.NotasFiscais.Items[0].NFe.Dest.EnderDest.UF='EX' )
  then
//    rateioicmsimportacao:=FGeral.arredonda( 1 - Abs(EdDigtotalnf.ascurrency - EdDigBicms.ascurrency)/EdDigvicms.ascurrency ,3 ) ;
//    rateioicmsimportacao:=FGeral.arredonda( 100 *  (Abs(EdDigtotalnf.ascurrency - EdDigBicms.ascurrency)/EdDigvicms.ascurrency) ,2 ) ;
//    rateioicmsimportacao:=FGeral.arredonda( 100 *  (Abs(EdDigtotalnf.ascurrency - EdDigBicms.ascurrency)/EdDigvicms.ascurrency) ,3 ) ;
//    rateioicmsimportacao:=FGeral.arredonda( 100 *  (Abs(EdDigtotalnf.ascurrency - EdDigBicms.ascurrency)/EdDigvicms.ascurrency) ,4 ) ;
//    rateioicmsimportacao:=FGeral.arredonda( 100 *  (Abs(EdDigtotalnf.ascurrency - EdDigBicms.ascurrency)/EdDigvicms.ascurrency) ,6 ) ;
//    rateioicmsimportacao:= 100 *  (Abs(EdDigtotalnf.ascurrency - EdDigBicms.ascurrency)/EdDigvicms.ascurrency) ;
    rateioicmsimportacao:= (Abs(EdDigtotalnf.ascurrency - EdDigBicms.ascurrency)) ;
}
//////////////////////////////////////////////
// 25.09.19  - Empresas fazem a nota j� descontando o gta...
     if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodEntradaProdutor then begin

        EdVlrDesco.SetValue( EdValorgta.AsCurrency );
        EdValorgta.setvalue(0);
        Edperdesco.SetValue( (EdVlrdesco.ascurrency/EdDigtotpro.AsCurrency)*100 );

     end;

  for p:=1 to Grid.rowcount do begin
//    produto:=Grid.Cells[0,p];
// 06.07.09
    produto:=Grid.Cells[Grid.getcolumn('move_esto_codigo'),p];
// 15.10.10
    produtonfe:=Grid.Cells[Grid.getcolumn('produtonfe'),p];
    if ( trim(produto)<>''  ) or ( (trim(produto)='') and (trim(produtonfe)<>'' ) )
      then begin
//      totalitem:=Fgeral.Arredonda( texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]) * texttovalor(Grid.Cells[Grid.GetColumn('move_venda'),p]) ,2);
//      totalitemliq:=Fgeral.Arredonda( texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]) * texttovalor(Grid.Cells[Grid.GetColumn('move_venda'),p]) ,2);
// 16.01.08 - para evitar dif. com o romaneio e nota produtor
      if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodRetornocomServicos)>0 then begin

        totalitem:= texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]) * Fgeral.Arredonda( texttovalor(Grid.Cells[Grid.GetColumn('move_venda'),p]) ,5 ) ;
        totalitemliq:=texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]) * Fgeral.Arredonda( texttovalor(Grid.Cells[Grid.GetColumn('move_venda'),p]) ,5 ) ;
//        Lista.Add(produto+' = '+formatfloat(f_cr,totalitem) )

      end else if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodCompraProdutor+';'+Global.CodEntradaProdutor)=0 then begin

        totalitem:=Fgeral.Arredonda( texttovalor(Grid.Cells[Grid.GetColumn('total'),p]) ,4);
        totalitemliq:=Fgeral.Arredonda( texttovalor(Grid.Cells[Grid.GetColumn('total'),p]) ,4);

      end else begin

//        totalitem:=Fgeral.Arredonda( texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]) * texttovalor(Grid.Cells[Grid.GetColumn('move_venda'),p]) ,4);
//        totalitemliq:=Fgeral.Arredonda( texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]) * texttovalor(Grid.Cells[Grid.GetColumn('move_venda'),p]) ,4);
// 03.08.18
        totalitem:= texttovalor(Grid.Cells[Grid.GetColumn('total'),p]) ;
        totalitemliq:= texttovalor(Grid.Cells[Grid.GetColumn('total'),p]);

      end;
// 30.05.12 - Asatec
      cfopitem:=Grid.Cells[Grid.getcolumn('move_natf_codigo'),p];
      aliicms:=texttovalor(Grid.Cells[Grid.GetColumn('Move_aliicms'),p] );
/////////
// 11.07.13 - Metalforte
      if pos(cfopitem,'1915/2915') > 0 then
        valornotafinan:=valornotafinan+texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]) * Fgeral.Arredonda( texttovalor(Grid.Cells[Grid.GetColumn('move_venda'),p]) ,3 ) ;

      tqtde:=tqtde+texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]) ;
      if EdPerdesco.ascurrency>0 then begin
        totalitemliq:=totalitem-FGEral.Arredonda( totalitem*(EdPerdesco.ascurrency/100) ,4 );
      end;
      if (EdPeracre.ascurrency>0) and ( copy(cfopitem,1,1)<>'3' ) then begin
        totalitemliq:=totalitemliq+FGEral.Arredonda( totalitemliq*(EdPeracre.ascurrency/100) ,4  );
      end;
// 15.04.08
      if trim(Grid.Cells[Grid.GetColumn('codigosittrib'),p])='' then begin
        codigosit:=0;
        Avisoerro('Codigo da ST n�o encontrado');
      end else
// 28.08.04 - fazer o acrescimo ou desconto sobre o total dos itens e n�o em cada um..da� recalcular icms
        codigosit:=strtoint(Grid.Cells[Grid.GetColumn('codigosittrib'),p] );

//      if pos(Op,'A;F')>0 then begin
//        Arq.TSittributaria.first;
//        Arq.TSittributaria.Locate('sitt_codigo',inttostr(codigosit),[]);
//      end;

// 30.05.12 - 23.11.20 - retirado
//      if ( copy(cfopitem,1,1)='3' )  and ( aliicms>0 ) then
//         totalitemliq:= totalitemliq/(1-(aliicms/100)) ;

// retirado aqui e colocado dentro do if
// pois preenchia a base da subst. sem necessidade e ia no sped fiscal
// 21.08.12
//      baseicmssemreducao:=baseicmssemreducao + totalitemliq;

      if texttovalor( Grid.Cells[Grid.GetColumn('move_redubase'),p] )>0 then begin

        baseicmssemreducao:=baseicmssemreducao + totalitemliq;
// 01.02.12
        if not EdArquivoxml.IsEmpty then begin
//          if Grid.Cells[Grid.GetColumn('move_cst'),p]='020' then
//            totalitembase:=( totalitemliq*(texttovalor(Grid.Cells[Grid.GetColumn('move_redubase'),p])/100) )
//          else
            totalitembase:=( totalitemliq*((100-texttovalor(Grid.Cells[Grid.GetColumn('move_redubase'),p]))/100) );

        end else

          totalitembase:=( totalitemliq*(texttovalor(Grid.Cells[Grid.GetColumn('move_redubase'),p])/100) );

      end else

        totalitembase:=totalitemliq;

 // 23.11.20 - ver como parametrizar Seip - quando vem de SP tem icms...
     if ( copy(EdNatf_codigo.text,1,1)='3' )  then begin

          totalitembase    := Fgeral.Arredonda( texttovalor(Grid.Cells[Grid.GetColumn('descontouni'),p]) ,4);

     end;

// 06.07.12 - so pra nao somar nos produtos
      if Ansipos( cfopitem,cfopdeservicos )>0 then
        totalitembase:=0;
//////////////////////////
// 24.10.11 - retirado e recolocado como query pra ver se 'fica no ultimo usado..Bavi
      TSittributaria:=sqltoquery('select * from sittrib where sitt_codigo='+inttostr(codigosit));
//      Arq.TSittributaria.Locate('sitt_codigo',inttostr(codigosit),[]);

//      aliicms:=FEstoque.Getaliquotaicms(produto,EdUnid_codigo.text,Edcliente);

     percdif := 100- 33.3334;    // para reduzir o icms pelo diferimento

 // 23.11.20 - ver como parametrizar Seip - quando vem de SP tem icms...
     if ( copy(EdNatf_codigo.text,1,1)='3' )  then

         icmsitem:=FGeral.Arredonda( (totalitembase*(percdif/100))*(aliicms/100) ,2)

     else

         icmsitem:=FGeral.Arredonda( (totalitembase)*(aliicms/100) ,2) ;

// 23.01.17
      if Ansipos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodNfeComplementoIcmsE) > 0 then

        icmsitem:=0;

// 27.05.12 - Asatec - Importacao
//      icmsitem:=FGeral.Arredonda( (totalitembase+texttovalor(Grid.Cells[Grid.GetColumn('voutro'),p]))*(aliicms/100) ,2);

//      icmsitem:=icmsitem - ( icmsitem*(rateioicmsimportacao) );
//      icmsitem:=( icmsitem*(rateioicmsimportacao) );
//      icmsitem:=icmsitem - (icmsitem*rateioicmsimportacao)/100;
//      if (EdDigvicms.ascurrency>0) then
//        icmsitem:=icmsitem - (rateioicmsimportacao*icmsitem)/EdDigvicms.ascurrency; // 1917
//        icmsitem:=icmsitem - FGeral.Arredonda((rateioicmsimportacao*icmsitem)/EdDigvicms.ascurrency,2);  // 1917
//        icmsitem:=icmsitem - FGeral.Arredonda((rateioicmsimportacao*icmsitem)/EdDigvicms.ascurrency,4);  // 1917.15
//        icmsitem:=icmsitem - FGeral.Arredonda((rateioicmsimportacao*icmsitem)/EdDigvicms.ascurrency,6);  // 1917.15
//        icmsitem:=icmsitem - FGeral.Arredonda((rateioicmsimportacao*icmsitem)/EdDigvicms.ascurrency,1);  //   1917.16
//        icmsitem:=icmsitem - Trunc((rateioicmsimportacao*icmsitem)/EdDigvicms.ascurrency);  //  1921,16
//        icmsitem:=icmsitem - ((rateioicmsimportacao*icmsitem)/trunc(EdDigvicms.ascurrency));  //  1917,14
//        icmsitem:=icmsitem - (trunc(rateioicmsimportacao*icmsitem)/(EdDigvicms.ascurrency));  //  1917,15
//        vlrrateioicmsimportacao:=( Trunc((rateioicmsimportacao*icmsitem)/EdDigvicms.ascurrency) -
//                                  FGeral.Arredonda((rateioicmsimportacao*icmsitem)/EdDigvicms.ascurrency,2) ) +
//                                  FGeral.Arredonda((rateioicmsimportacao*icmsitem)/EdDigvicms.ascurrency,2);

//        icmsitem:=icmsitem - vlrrateioicmsimportacao;  //


// 15.04.08
      aliipi:=texttovalor(Grid.Cells[Grid.GetColumn('Move_aliipi'),p] );
// 18.10.18 - Seip - soma Imposto de Importa��o da base do IPI
      if EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring = Global.CodDrawBackEnt then begin

//         baseII   := totalitembase*(texttovalor(Grid.Cells[Grid.GetColumn('voutro'),p] ) /100);
//         ipiitem  := FGeral.Arredonda( (totalitembase+baseII)*(aliipi/100) ,2)
// 23.11.20 - seip - ver como parametrizar
         baseII   := totalitemliq*(texttovalor(Grid.Cells[Grid.GetColumn('voutro'),p] ) /100);
         ipiitem  := FGeral.Arredonda( (totalitemliq+baseII)*(aliipi/100) ,2)

      end else

//         ipiitem:=FGeral.Arredonda( totalitembase*(aliipi/100) ,2);
         ipiitem:=FGeral.Arredonda( totalitembase*(aliipi/100) ,4);

      if ipiitem>0 then
        totalipi:=totalipi+ipiitem;
///////////////////////////
      if icmsitem>0 then begin
//        baseicms:=baseicms+totalitem;
// 09.08.05
        baseicms:=baseicms+totalitembase;

        if Ansipos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodNfeComplementoValorProdutor ) > 0 then

           icmsitem := 0;

        vlricms:=vlricms+icmsitem;

      end;
// 06.07.12 - so pra nao somar nos produtos
      if Ansipos( cfopitem,cfopdeservicos )>0 then
        totalservicos:=totalservicos+totalitem

      else

        totalprodutos:=totalprodutos+totalitem;

        // 09.07.07 - 25.05.18 - retirado para prever descontos em copmras de produtor
//      else if (pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.CodCompraProdutor+';'+Global.CodEntradaProdutor)=0) then
//        totalprodutos:=totalprodutos+totalitem
//      else
// 09.08.05
//        totalprodutos:=totalprodutos+totalitemliq;

      if ( pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Devolucao ) > 0 ) and
         ( pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.TiposNaoCalcSubsTrib ) = 0 ) then begin   // 21.06.05
//        if Arq.TSittributaria.fieldbyname('sitt_cf').asstring=Global.CodigoSubsTrib then begin
// 24.10.11
        if TSittributaria.fieldbyname('sitt_cf').asstring=Global.CodigoSubsTrib then begin
// 14.09.05 - na alteracao tem q 'repegar' pois a margem nao e gravada no movestoque
          if pos(Op,'A;F')>0 then
            margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(produto,EdUnid_codigo.text,QFornec.fieldbyname('clie_uf').asstring))
          else
            margemlucro:=texttovalor(Grid.Cells[Grid.GetColumn('margemlu'),p] );
//          basesubs:=basesubs+( totalitem*(1+(margemlucro/100)) );
//          icmssubs:=(totalitem*(1+(margemlucro/100))) * (aliicms/100);
// 16.11.05
          basesubs:=basesubs+( totalitembase*(1+(margemlucro/100)) );
          icmssubs:=(totalitembase*(1+(margemlucro/100))) * (aliicms/100);
////////////////
          icmssubs:=icmssubs-icmsitem;
          icmssubsnota:=icmssubsnota+icmssubs;
        end;
      end;
      FGeral.FechaQuery(TSittributaria);
    end;

  end;  // percorre os itens da nota

  if EdDtmovimento.asdate<=1 then begin
    basesubs:=0;
    icmssubs:=0;
    icmssubsnota:=0;
  end;
/////////////
// 03.01.06 - retirado em 08.02.12 - era especifico para Toke
//    if TipoEntidade<>'F' then begin
//      basesubs:=0;
//      icmssubs:=0;
//      icmssubsnota:=0;
//      EdBasesubs.setvalue(0);
//      EdValorsubs.setvalue(0);
//    end else begin
// 28.01.13
    if pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Devolucao ) = 0 then begin
      if baseicmssemreducao>0 then
        EdBasesubs.setvalue(baseicmssemreducao)
// 15.05.17
      else if (EdBasesubs.ascurrency=0) and (OP='I') then
        EdBasesubs.setvalue(basesubs);
//      EdValorsubs.setvalue(icmssubs);
// 08.02.12
      if (EdValorsubs.ascurrency=0) and (OP='I') then
// 08.02.06
        EdValorsubs.setvalue(icmssubsnota);
//    end;
    end;

// 15.04.08 - retirado em 08.11.21 - recolocado em 01.02.23 - Mirvane..puxa valor 210 e nos items d� 205...
    if EdValoripi.AsCurrency=0 then begin

      if Ansipos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.CodDevolucaoInd+';'+Global.CodRetornocomServicos)=0 then
        EdValoripi.SetValue(totalipi);

    end;


//   Lista.SaveToFile( 'testepedido.txt' );
///////////
//  totalnota:=totalprodutos+EdFrete.Ascurrency+EdSeguro.ascurrency+EdValoripi.ascurrency+icmssubs;
// 20.06.05
//  totalnota:=totalprodutos+EdValoripi.ascurrency+icmssubsnota;
// 19.03.12
//  totalnota:=totalprodutos+EdValoripi.ascurrency+EdValorSubs.ascurrency;
// 06.07.12
//  totalnota:=totalprodutos+EdValoripi.ascurrency+EdValorSubs.ascurrency+TotalServicos;
// 06.07.12
//  totalnota:=totalprodutos+EdValoripi.ascurrency+EdValorSubs.ascurrency+TotalServicos;
// 25.05.18
//  totalnota:=totalprodutos+EdValoripi.ascurrency+EdValorSubs.ascurrency+TotalServicos-EdVlrDesco.AsCurrency;
// 04.07.2022 - Nilda - Simar - faltava somar o acrescimo financeiro
//  totalnota:=totalprodutos+EdValoripi.ascurrency+EdValorSubs.ascurrency+TotalServicos
//             -EdVlrDesco.AsCurrency+EdVlracre.AsCurrency;
// 01.02.2023 - nota mirvane q 'itens n�o bate com totais'....
  totalnota:=EdDigtotpro.AsCurrency+EdValoripi.ascurrency+EdValorSubs.ascurrency+TotalServicos
             -EdVlrDesco.AsCurrency+EdVlracre.AsCurrency;

  EdBaseicms.setvalue(baseicms);
// 23.01.17
  if ansipos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodNfeComplementoIcmsE)=0 then begin

    EdValoricms.setvalue(vlricms);
    Edtotalprodutos.setvalue(totalprodutos);
    Edtotalnota.setvalue(totalnota);

  end;

  Edqtdetotal.setvalue(tqtde);
//  EdTotalnota.enabled:=false;
//  PTotais.DisableEdits;
  total:=0;
  if ListaCustos<>nil then begin
    for p:=0 to ListaCustos.count-1 do begin
      PCustos:=LIstaCustos[p];
      total:=total+FGeral.Arredonda(PCustos.valoruni*Pcustos.qtdeprevdig,2);
    end;
  end;

/////////////  if OP='A' then    // 27.07.05
// recolocado em 16.08.05       // 27.03.06
    total:=totalbruto('prev') ;

//  EdTotal.setvalue(total+EdValorIpi.ascurrency+EDFrete.ascurrency-FGEral.Arredonda( total*(EdPerdesco.ascurrency/100) ,2  )+
//                   FGEral.Arredonda( total*(EdPeracre.ascurrency/100) ,2 )  );
// 20.06.05
//  EdTotal.setvalue(total+EdValorIpi.ascurrency-FGEral.Arredonda( total*(EdPerdesco.ascurrency/100) ,2  )+
//                   FGEral.Arredonda( total*(EdPeracre.ascurrency/100) ,2 )  );
// 20.07.05
  if total>0 then
    Peracreprev:=(EdVlracre.ascurrency/total)*100
  else
    Peracreprev:=0;

// 18.08.05
  if Eddescovlr.ascurrency=0 then
    EdTotal.setvalue(total+EdValorIpi.ascurrency - FGEral.Arredonda( total*(Eddescoper.ascurrency/100) ,2  ) )
//                   FGEral.Arredonda( total*(EdPeracre.ascurrency/100) ,2 )  )
  else begin

    if total>0 then
//      Perdescprev:=(EdVlrdesco.ascurrency/total)*100
// 18.08.05
      Perdescprev:=(Eddescovlr.ascurrency/total)*100
    else
      Perdescprev:=0;

    EdTotal.setvalue( total+EdValorIpi.ascurrency - Eddescovlr.ascurrency ) ;
//                   FGEral.Arredonda( total*(Peracreprev/100) ,2 )  );
//    EdTotal.setvalue(total+EdValorIpi.ascurrency );
  end;
  if EdVlracre.ascurrency=0 then
    EdTotal.setvalue( EdTotal.ascurrency + FGEral.Arredonda( total*(EdPeracre.ascurrency/100) ,2 )  )
  else
    EdTotal.setvalue(EdTotal.ascurrency + FGEral.Arredonda( total*(Peracreprev/100) ,2 )  );

  if ( pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Devolucao+';'+
       Global.CodCompraProdutor+';'+Global.CodRetornocomServicos+';'+Global.CodCompraRemessaFutura+';'+
       Global.CodEntradaProdutor+';'+Global.CodCompraSemfinan+';'+Global.codcompraprodutormerenda+';'+
       Global.CodDrawBackEnt+';'+Global.CodCedulaProdutoRural  ) > 0 ) or
     ( not EdPedido.IsEmpty )
     then begin

     EdDigbicms.setvalue(baseicms);
     EdDigvicms.setvalue(vlricms);
     if (EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodCompraRemessaFutura)
         and ( EdArquivoxml.IsEmpty ) then begin

         EdDigtotpro.setvalue(totalprodutos);
         EdDigtotalnf.setvalue(totalnota);

     end else begin
// 06.07.09 - DX - novicarnes so atualiza 'o primeiro'
       if ( pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.CodRetornocomServicos+';'+Global.CodCompraRemessaFutura ) > 0 ) then begin
         if Eddigtotpro.AsCurrency=0 then
            EdDigtotpro.setvalue(totalprodutos);
         if EdDigtotalnf.ascurrency=0 then
           EdDigtotalnf.setvalue(totalnota);

       end else begin

         EdDigtotpro.setvalue(totalprodutos);
         EdDigtotalnf.setvalue(totalnota-Eddescovlr.ascurrency+EdVlracre.ascurrency);

       end;

     end;

     if pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.CodDevolucaoInd+';'+Global.CodRetornocomServicos)=0 then
        EdValoripi.setvalue(totalipi);   // 15.04.08
  end;
// 03.05.07
//  if (EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodCompraProdutor) and
// 01.07.15
  if ( pos( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodCompraProdutor+';'+
//            Global.CodCompraProdutorMerenda+';'+Global.CodEntradaProdutor+'
           Global.CodNfeComplementoValorProdutor+';'+
// 02.08.19 - retirado a de complemento
// 22.02.2021 - recolocado a de complemento de entrada de produtor - C1
            Global.CodCompraProdutorMerenda+';'+Global.CodEntradaProdutor)>0 )
      and
     ( not EdDtmovimento.IsEmpty ) then begin
// 07.08.15 - ajuste em 12.08.15
//////////////////////////////////////
        if QFornec.FieldByName('clie_tipo').asstring='J' then
            perfunrural:=FGeral.Getconfig1asfloat('perfunruraljur');
      // 05.05.10 - produtor rural Nao empregador - Novi - vava
        if QFornec.FieldByName('clie_aliinsspro').Ascurrency=99 then
            perfunrural:=0
        else if QFornec.FieldByName('clie_aliinsspro').Ascurrency>0 then
            perfunrural:=QFornec.FieldByName('clie_aliinsspro').Ascurrency;
     EdFunrural.setvalue( EdTotalprodutos.ascurrency*(perfunrural/100) );
     if ( QFornec.FieldByName('clie_tipo').asstring='J' )
         or ( QFornec.FieldByName('clie_ativo').asstring='N' ) then
              percotacapital:=0;
      EdCotaCapital.setvalue( EdTotalprodutos.ascurrency*(percotacapital/100) );

/////////////////////////////////////
{
    if (EdFornec.resultfind.FieldByName('clie_tipo').asstring='F') and (EdFornec.resultfind.FieldByName('clie_ativo').asstring='S') then begin
      EdFunrural.setvalue( EdTotalprodutos.ascurrency*(perfunrural/100) );
      EdCotaCapital.setvalue( EdTotalprodutos.ascurrency*(percotacapital/100) )
    end else begin
      EdCotaCapital.setvalue(0);
      EdFunrural.setvalue( 0 );
    end;
}
    Edtotal.setvalue( Edtotal.ascurrency-EdCotaCapital.ascurrency-EdFunrural.ascurrency-EdValorgta.ascurrency-EdMoes_insumos.AsCurrency);
// 25.02.16 ver se e pro financeiro
    Edtotalnota.setvalue(Edtotalnota.ascurrency-EdCotaCapital.ascurrency-EdFunrural.ascurrency-EdValorgta.ascurrency-Edmoes_insumos.AsCurrency);
// 18.02.16 - ver se nao � desconto equivocado
// 22.12.15 - novicarnes - come�ou a nao autorizar
//    EdDigtotalnf.setvalue(Edtotalnota.ascurrency);
  end else begin

    EdFunrural.setvalue( 0 );
    EdCotaCapital.setvalue( 0 );
    EdMoes_insumos.SetValue( 0 );

  end;
// 01.04.08
  if EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodDevolucaoInd then begin
     if Eddigtotpro.AsCurrency=0 then
        EdDigtotpro.setvalue(totalprodutos);
     if EdDigtotalnf.ascurrency=0 then
        EdDigtotalnf.setvalue(totalnota);
  end;
// 11.07.13
  if EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodPrestacaoServicosE then
     EdtotalServicos.setvalue(totalservicos);
// 30.01.15 - novicarnes - angela
  if ( EdComv_codigo.asinteger=FGeral.GetConfig1AsInteger('NfCompleentrada') )
     and
     ( FGeral.GetConfig1AsInteger('NfCompleentrada')>0 )
     then begin
     EdDigtotpro.setvalue( 0 );
     EdDigtotalnf.setvalue( 0 );
     EdDigbicms.setvalue( 0 );
     EdDigvicms.setvalue( totalprodutos );
  end;
// 08.09.2021 - Clessi


end;

procedure TFNotaCompra.FormActivate(Sender: TObject);
/////////////////////////////////////////////////////////
//var operacao:string;
begin
{//////////////////////////////
  Sistema.beginprocess('Abrindo tabelas');
  if not Arq.TTransp.Active then Arq.TTransp.Open;
  if not Arq.TEstoque.Active then Arq.TEstoque.Open;
  if not Arq.TEstoqueQtde.Active then Arq.TEstoqueQtde.Open;
  if not Arq.TFornec.Active then Arq.TFornec.Open;
//  Arq.TNatFisc.OpenWith('natf_es=''E''',Arq.TNatFisc.Ordenacao);
//  if not Arq.TConfMovimento.Active then Arq.TConfMovimento.Open;
//  Arq.TConfMovimento.SetFilter( FGeral.GetIN('comv_tipomovto',Global.TiposEntrada,'C') );
  Arq.TConfMovimento.OpenWith(FGeral.GetIN('comv_tipomovto',Global.TiposEntrada,'C'),Arq.TConfMovimento.Ordenacao);
  if not Arq.TFPgto.Active then Arq.TFPgto.Open;
  if not Arq.TPortadores.Active then Arq.TPortadores.Open;
  if not Arq.TSittributaria.Active then Arq.TSittributaria.Open;
  if not Arq.TCodigosFiscais.active then Arq.TCodigosFiscais.open;
//////////////  Op:='I';  // por enquanto fixo
  EdComv_codigo.ClearAll(FNotaCompra,99);
  EdUnid_codigo.Text:=Global.CodigoUnidade;
//  EdDtEmissao.SetDate(Sistema.hoje);
  EdDtEntrada.SetDate(Sistema.hoje);
  EdTotal.visible:=Global.Usuario.OutrosAcessos[0010];
  EdTotal.enabled:=Global.Usuario.OutrosAcessos[0010];
  EdValorTotal.visible:=Global.Usuario.OutrosAcessos[0010];
  EdValorTotal.enabled:=Global.Usuario.OutrosAcessos[0010];
  EdComv_codigo.setfocus;
  if OP='A' then begin
    operacao:='Altera��o'
  end else begin
    operacao:='Inclus�o';
  end;
  FNotaCompra.Caption:='Nota Fiscal de Entrada - '+operacao;
  ListaCustos:=TList.create;
  EdDtmovimento.setdate(sistema.hoje);
  Sistema.endprocess('');
//////////////////////////////}
// 05.11.09 - acess violation quando gravava config. sistema e entrava em entradas
  if Listacustos=nil then
    ListaCustos:=TList.create;

end;

procedure TFNotaCompra.bGravarClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////
type TRecla=record
     produto:string;
     qtde,valor:currency;
end;

type TCodigosIguais=record

     codigo:string;
     qtde,
     qtdeultima  :currency;

end;


var Transacao,tipocad,tipomovM,tipomovN,tipodetalhe,cstrecla,unidades,chavecte:string;
    xEd,xEdRecla:TSqled;
    QVePendencia,QConfMov,QVeNfe,
    TEstoqueQtde                       :TSqlquery;
    valornf,DigBicms,digvicms,valornota:currency;
    Montabase,pr:string;
    Numerodoc,x,y,debito,credito,
    posicao,
    numerocte   :integer;
    fazernfrecla:boolean;
    PRecla:^TRecla;
    ListaEntrada:TList;
    restricao1,restricao2,restricao3,restricao4:boolean;
    ListaCodigosiguais:TList;
    PCodigosIguais    :^TCodigosiguais;

    // 22.06.17
    procedure ManifestaNota;
    ////////////////////////
    var idlote:integer;
        msg:string;
        campo:TDicionario;
    begin
       if EdArquivoxml.IsEmpty then exit;
       if Acbrnfe1.NotasFiscais.Count=0 then exit;
// 11.05.19 - para nao manifestar 'duas vezes'
//       if (not Global.Topicos[1450] ) or ( EdArquivoxml.IsEmpty ) then exit;
// 28.07.2022 - retirado pois foi desativo a manifestacao de notas pelo form 'nf destinadas'

       campo:=Sistema.GetDicionario('movesto','moes_datamanifesto');
       if campo.Tipo='' then exit;
       Sistema.BeginProcess('efetuando o manifesto da NF-e');
       if trim( FGeral.GetConfig1AsString('Pastaschemas') ) <> '' then
         Acbrnfe1.Configuracoes.Arquivos.PathSchemas:=FGeral.GetConfig1AsString('Pastaschemas')
       else
         Acbrnfe1.Configuracoes.Arquivos.PathSchemas:=ExtractFilePath( Application.ExeName )+'Schemas20';

       acbrnfe1.Configuracoes.Certificados.NumeroSerie:=FGeral.GetNroSerieCertificado(EdUnid_codigo.text);
       if trim(FGeral.GetConfig1AsString('Pastaretonfexml'))<>'' then begin
          acbrnfe1.Configuracoes.Arquivos.PathEvento:=FGeral.GetConfig1AsString('Pastaretonfexml');
          acbrnfe1.Configuracoes.Arquivos.PathSalvar:=FGeral.GetConfig1AsString('Pastaretonfexml');
       end;
       if FGeral.GetConfig1AsString('AmbienteNFe')='1' then
          acbrnfe1.Configuracoes.WebServices.Ambiente:=taProducao
       else
          acbrnfe1.Configuracoes.WebServices.Ambiente:=taHomologacao;
// 11.12.18 - aumentado de 5 para 10 segundos o timeout
//       AcbrNfe1.Configuracoes.WebServices.Timeout:=10000;
// 26.09.19 - aumentado de 10 para 30 segundos o timeout
       AcbrNfe1.Configuracoes.WebServices.Timeout:=30000;
       ACBrNFe1.EventoNFe.Evento.Clear;
       idlote:=FGeral.GetContador('LoteManifesto'+Global.CodigoUnidade,false,true);
       with ACBrNFe1.EventoNFe.Evento.Add do
         begin
           InfEvento.cOrgao   := 91;  // ambiente nacional
           infEvento.chNFe    := ACbrnfe1.NotasFiscais.Items[0].NFe.procNFe.chNFe;
           infEvento.CNPJ     := EdUnid_codigo.ResultFind.FieldByName('unid_cnpj').AsString;
           infEvento.dhEvento := now;
           infEvento.tpEvento := teManifDestConfirmacao;
         end;

       try
           ACBrNFe1.EnviarEvento(IDLote);

       except on E:exception do
           Sistema.EndProcess('Falha no envio do manifesto. '+E.message)

       end;

       with  AcbrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento do begin

          msg:=xMotivo;
          if cStat=135 then begin
             Sistema.Edit('movesto');
             Sistema.setfield('Moes_xmlmanifesto',ACBrNFe1.WebServices.EnvEvento.RetWS);
             Sistema.setfield('Moes_datamanifesto',Sistema.hoje);
             Sistema.setfield('Moes_retornomanifesto',xmotivo);
             Sistema.setfield('Moes_nfecommanifesto','S');
             Sistema.Post('moes_transacao='+Stringtosql(Global.UltimaTransacao)+
                          ' and moes_unid_codigo = '+EdUnid_codigo.AsSql);
             Sistema.Commit;
         end else begin
             Sistema.Edit('movesto');
             Sistema.setfield('Moes_xmlmanifesto',ACBrNFe1.WebServices.EnvEvento.RetWS);
             Sistema.setfield('Moes_datamanifesto',Sistema.hoje);
             Sistema.setfield('Moes_retornomanifesto',xmotivo);
             Sistema.Post('moes_transacao='+Stringtosql(Global.UltimaTransacao)+
                          ' and moes_unid_codigo = '+EdUnid_codigo.AsSql);
             Sistema.Commit;
             avisoerro( msg );
         end;

       end;

//       showmessage( ACBrNFe1.WebServices.EnvEvento.RetWS );

       Sistema.endProcess('');


    end;


    procedure GravaItensTransferidos;
    ////////////////////////////////
    var linha,x:integer;
        produto:string;
        QEstoqueQtde:TSqlquery;
    begin
      x:=0;
      for linha:=1 to Grid.rowcount do begin
        if trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),linha])<>'' then begin
          produto:=Grid.Cells[Grid.Getcolumn('move_esto_codigo'),linha];
          Arq.TEstoque.locate('esto_codigo',produto,[]);
// 26.06.06
          QEstoqueQtde:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+EdUnid_codigo.assql+
                                   ' and esqt_esto_codigo='+stringtosql(produto)+' and esqt_status=''N''');
//          if ( not Arq.TEstoqueqtde.Locate('esqt_unid_codigo;esqt_esto_codigo',Vararrayof([EdUnid_codigo.text,produto]),[]) )
          if QEstoqueQtde.eof then begin
//            Arq.TEstoqueqtde.Locate('esqt_unid_codigo;esqt_esto_codigo',Vararrayof([EdUnidOrigem.text,produto]),[]);

            FGeral.Fechaquery(QEstoqueqtde);
            QEstoqueQtde:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+EdUnidOrigem.assql+
                                     ' and esqt_esto_codigo='+stringtosql(produto)+' and esqt_status=''N''');
            inc(x);
            Sistema.Insert('EstoqueQtde');
            Sistema.Setfield('esqt_status','N');
            Sistema.Setfield('esqt_unid_codigo',EdUNid_codigo.text);
            Sistema.Setfield('esqt_esto_codigo',produto);
            Sistema.Setfield('esqt_qtde',texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
            Sistema.Setfield('esqt_qtdeprev',texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
            Sistema.Setfield('esqt_vendavis',Texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]));
            Sistema.Setfield('esqt_custo',QEstoqueQtde.fieldbyname('esqt_custo').ascurrency);
            Sistema.Setfield('esqt_custoger',QEstoqueQtde.fieldbyname('esqt_custoger').ascurrency);
            Sistema.Setfield('esqt_customedio',QEstoqueQtde.fieldbyname('esqt_customedio').ascurrency);
            Sistema.Setfield('esqt_customeger',QEstoqueQtde.fieldbyname('esqt_customeger').ascurrency);
  //          Sistema.Setfield('esqt_dtultvenda',emissao);
            Sistema.Setfield('esqt_dtultcompra',EdDtemissao.asdate);
            Sistema.Setfield('esqt_desconto',QEstoqueQtde.fieldbyname('esqt_desconto').ascurrency);
            Sistema.Setfield('esqt_basecomissao',QEstoqueQtde.fieldbyname('esqt_basecomissao').ascurrency);
            Sistema.Setfield('esqt_cfis_codigoest',Grid.Cells[grid.getcolumn('codigofis'),linha]);

            Sistema.Setfield('esqt_cfis_codigoforaest',QEstoqueQtde.fieldbyname('esqt_cfis_codigoforaest').asstring);
            Sistema.Setfield('esqt_sitt_codestado',strtoint(Grid.Cells[grid.getcolumn('codigosittrib'),linha]) );

            Sistema.Setfield('esqt_sitt_forestado',QEstoqueQtde.fieldbyname('esqt_sitt_forestado').asinteger);
            Sistema.Setfield('esqt_vendavis',QEstoqueQtde.fieldbyname('esqt_vendavis').ascurrency);
            Sistema.Setfield('esqt_usua_codigo',Global.Usuario.codigo);
            Sistema.Post('');
          end;
          FGeral.Fechaquery(QEstoqueqtde);
        end;
      end;
      if x>0 then
        Sistema.commit;
   end;


   function ValidaNota:boolean;
   ///////////////////////////
   var valor,vlrtolera,valorsubs:currency;
       Qx : TSqlquery;
       xsenha :  string;


      function Tolerancia(valor1,valor2:currency):boolean;
      /////////////////////////////////////////////////
      begin
         valor:=abs(valor1-valor2);
         if valor1>=1000 then
           vlrtolera:=valor1/1000
         else
//           vlrtolera:=valor1/100;
           vlrtolera:=0.03;
         if valor>vlrtolera then
           result:=false
         else
           result:=true;
      end;

   begin
   /////////////////////////

     result:=true;
     if EdComv_codigo.ResultFind=nil then begin
       Avisoerro('Problemas no tipo de entrada');
       result:=false;
       exit;
     end;
// 28.10.09 - 15.10.19 - Novicarnes - Sandro+Simone
     if ( EdTran_codigo.ResultFind<>nil ) and ( Cfopdecombustivel ) then begin
       if (EdMoes_cola_codigo.isempty) and (EdTran_codigo.ResultFind.FieldByName('tran_proprio').AsString='S')
// 18.11.16
         and      ( pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.codcompraprodutor+';'+Global.CodDevolucaoInd)=0 )
         then begin
          Avisoerro('Falta informar o codigo do colaborador');
         result:=false;
         exit;
       end;
     end;
// aqui em 19.03.14 - para ficar fora do if abaixo
     if Global.Topicos[1354] then begin
       if pos(EdUnid_codigo.ResultFind.Fieldbyname('unid_simples').asstring,'S;2')>0 then begin
         if (EdDigbicms.ascurrency+EdDigvicms.ascurrency)>0 then begin
           Avisoerro('Base Icms e Valor icms n�o pode ser informado em unidade do Simples');
           result:=false;
           exit;
         end;
       end;
     end;
// 19.12.19
     if OP = 'I' then begin

        Qx := sqltoquery('select moes_transacao from movesto where moes_status = ''N'''+
                      ' and moes_tipo_codigo = '+EdFornec.AsSql+
                      ' and moes_dataemissao = '+EdDtEmissao.AsSql+
                      ' and moes_numerodoc   = '+EdNumerodoc.AsSql+
                      ' and moes_unid_codigo = '+EdUNid_codigo.AsSql+
                      ' and moes_natf_codigo = '+EdNatf_codigo.AsSql);
        if not Qx.eof then begin

           Avisoerro('Nota encontrada na transa��o '+Qx.FieldByName('moes_transacao').AsString);
           if Input('Autoriza��o','Senha',xsenha,10,false) then begin
              if xsenha = 'asx45600' then result:=true else result:=false

           end else result:=false;

           exit;

        end;

     end;

// 09.12.19 - NOvicarnes - Simone
     if campoufentidade = 'forn_uf' then begin

        result:=true;
        if EdFornec.ResultFind.FieldByName('forn_contribuinte').AsString = 'R' then begin

           if ( EdVlrinss.AsCurrency+EdVlrCofins.AsCurrency+EdVlrir.AsCurrency+
              EdVlrcsll.AsCurrency+EdVlrpis.AsCurrency+EdVlriss.AsCurrency ) =0 then begin

              result:=false;
              Avisoerro('Fornecedor com RETEN��O mas sem valores informados');
              exit;

           end;

        end;

     end;

// aqui em 24.05.11 para validar 'fora do if abaixo'
     if (EdDigtotalnf.AsCurrency=0) and
        ( Ansipos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodNfeComplementoIcmsE+';'+
                   Global.CodNfeComplementoIcmsEcliente+';'+Global.CodEntradaNFPe)=0)
                   then begin
       Avisoerro('Total da nota n�o informado');
       result:=false;
       exit;

// 10.07.18 - aqui para nao deixar lan�ar entrada de servi�os sem o item servi�os
// 17.12.18 - adicionado compras na checagem
     end else if (EdDigtotalnf.AsCurrency>0) and ( pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodPrestacaoServicosE+';'+Global.CodNfeComplementoIcmsE+';'+Global.CodCompra)>0)
              and ( trim(Grid.Cells[0,1])='' )
       then begin
       Avisoerro('Informar ao menos um item na nota');
       result:=false;
       exit;

     end else if (EdDigtotpro.AsCurrency=0) and ( pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodPrestacaoServicosE+';'+Global.CodNfeComplementoIcmsE+';'+
                 Global.CodNfeComplementoIcmsECliente+';'+Global.CodEntradaNFPe)=0) then begin

       Avisoerro('Total de produtos n�o informado');
       result:=false;
       exit;

// 22.08.11
     end else if Global.Topicos[1351] then begin
// nao d� pra checar nf de produtor pois imprime total da nota menor que o de produtos
// mas grava ambos com o mesmo valor
       if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodCompraProdutor+';'+Global.codcompraprodutormerenda+';'+Global.CodEntradaProdutor+';'+Global.CodNfeComplementoIcmsE+';'+Global.CodNfeComplementoIcmsECliente) = 0 then begin
// 13.12.11
         if Freteembutido then begin
// 20.06.13 - Notas de entrada com icms ref. subst. tributaria informado e frete embutido jack novi
           if (EdDigtotpro.AsCurrency-EdVlrDesco.ascurrency+EdValoripi.ascurrency+EdFrete.ascurrency+EdValorsubs.ascurrency) <> EdDigtotalnf.AsCurrency then begin
              valorsubs:=0;
              if EdValorsubs.ascurrency=0 then begin
                FGeral.Getvalor(valorsubs,'Icms Subs.Tribut�ria');
                EdValorsubs.setvalue( valorsubs );
              end;
           end;
           if (EdDigtotpro.AsCurrency-EdVlrDesco.ascurrency+EdValoripi.ascurrency+EdValorsubs.ascurrency+EdFrete.ascurrency+EdVlracre.ascurrency) <> EdDigtotalnf.AsCurrency then begin
//              Avisoerro('Total da Nota e de produtos n�o confere com valor do desconto OU ipi informado OU frete OU Subst.Tribut�ria');
              Avisoerro('Total da Nota informado : '+Valortosql(EdDigtotalnf.AsCurrency)+' Total da Nota Calculado : '+Valortosql(EdDigtotpro.AsCurrency-EdVlrDesco.ascurrency+EdValoripi.ascurrency+EdValorsubs.ascurrency+EdFrete.ascurrency) );
              result:=false;
              exit;
           end;
         end else begin                                                          //08.02.12
           if ( (EdDigtotpro.AsCurrency+EdValoripi.ascurrency+EdValorsubs.ascurrency+EdVlracre.ascurrency-EdVlrDesco.ascurrency) <> EdDigtotalnf.AsCurrency )
// 12.09.16
               and
               ( pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodPrestacaoServicosE) = 0 )
              then begin
//              Avisoerro('Total da Nota e de produtos n�o confere com valor do desconto OU ipi informado OU Icms Subst.Tribut�ria');
              Avisoerro('Total da Nota informado : '+Valortosql(EdDigtotalnf.AsCurrency)+' Total da Nota Calculado : '+Valortosql(EdDigtotpro.AsCurrency+EdValoripi.ascurrency+EdValorsubs.ascurrency+EdVlracre.ascurrency-EdVlrDesco.ascurrency) );
              result:=false;
// 03.04.12 - Notas de entrada com icms ref. subst. tributaria informado
              valorsubs:=0;
              if EdValorsubs.ascurrency=0 then
                FGeral.Getvalor(valorsubs,'Icms Subs.Tribut�ria');
              if valorsubs>0 then
                EdValorsubs.setvalue( valorsubs );                                                            // 25.04.14
              if (EdDigtotpro.AsCurrency-EdVlrDesco.ascurrency+EdValoripi.ascurrency+EdValorsubs.ascurrency+EdVlracre.ascurrency+EdFrete.ascurrency) <> EdDigtotalnf.AsCurrency then begin
                Avisoerro('Total da Nota e de produtos AINDA n�o confere com valor do desconto OU ipi informado OU Icms Subst.Tribut�ria');
                result:=false;
              end else
                result:=true;
              exit;
          end;
         end;
       end;
     end;
////////////////////
     if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodConhecimento+';'+Global.CodCompraProdutor+';'+Global.CodDevolucaoInd+
             ';'+Global.CodEntradaSemItens+';'+Global.codcompraprodutormerenda+';'+Global.CodNfeComplementoIcmsE+';'+Global.CodPrestacaoServicosE+';'+Global.CodNfeComplementoIcmsECliente  )>0 then
       exit;
// 10.05.06
//     if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodRetornoInd)>0 then begin
//        if EdTotalservicos.ascurrency<=0 then begin
//          Avisoerro('Obrigat�rio digitar o valor dos servi�os');
//          result:=false;
//        end;
     if (EdBaseicms.ascurrency<>EdDigbicms.ascurrency)
        and ( not Tolerancia(EdBaseicms.ascurrency,EdDigbicms.ascurrency) )
// 05.09.19
        and ( EdBaseicms.Enabled )
        then begin
       Aviso('Base de icms n�o confere. Calculada '+floattostr(EdBaseicms.ascurrency)+' Informada '+floattostr(EdDigbicms.ascurrency)+' Tolerancia '+floattostr(vlrtolera) );
//       result:=false;
     end else if (EdVAloricms.ascurrency<>EdDigvicms.ascurrency)
              and ( not Tolerancia(EdVAloricms.ascurrency,EdDigvicms.ascurrency) )
// 05.09.19
        and ( EdValoricms.Enabled )
              then begin
       Aviso('Valor do icms n�o confere. Calculado '+floattostr(Edvaloricms.ascurrency)+' Informada '+floattostr(EdDigvicms.ascurrency)+' Tolerancia '+floattostr(vlrtolera) );
//       result:=false;

     end else if ( EdTotalprodutos.ascurrency<>EdDigtotpro.ascurrency ) and ( not Tolerancia(EdTotalprodutos.ascurrency,EdDigtotpro.ascurrency) ) then begin
       Aviso('Total dos produtos n�o confere. Calculado '+floattostr(Edtotalprodutos.ascurrency)+' Informada '+floattostr(EdDigtotpro.ascurrency)+' Tolerancia '+floattostr(vlrtolera) );
//       result:=false;
     end else if (EdTotal.ascurrency<>EdValortotal.ascurrency) and (EdValortotal.ascurrency>0) then
       Aviso('Valor Total da nota n�o confere.  Calculado '+floattostr(Edtotal.ascurrency)+' Informada '+floattostr(Edvalortotal.ascurrency)+' Tolerancia '+floattostr(vlrtolera) )
     else if (EdTotalNota.ascurrency<>EdDigtotalnf.ascurrency) and (EdBaseicms.ascurrency>0) then
       Aviso('Total da nota n�o confere   Calculada '+floattostr(EdTotalNota.ascurrency)+' Informada '+floattostr(EdDigtotalnf.ascurrency)+' Tolerancia '+floattostr(vlrtolera) )
// 01.09.10
//       result:=false;
//     end else if not EdFpgt_codigo.Valid then begin
//       EdFpgt_codigo.INvalid('Obrigat�rio preenchimento da condi��o de pagamento');
//       EdPort_codigo.SetFocus;
//       result:=false;

   end;

   procedure AtualizaCustos;
   /////////////////////////////////////////
   var p:integer;
       produto:string;
       unitario,custo:currency;
   begin
     sistema.setmessage('Calculando custo');
     for p:=0 to ListaCustos.count-1 do begin
       PCustos:=Listacustos[p];
//       PCustos.custo:=FGeral.Custo(PCustos.unitario,PCustos.pericms,perfrete,PCustos.peripi,pericmsfrete,EdPerdesco.ascurrency,EdPerAcre.ascurrency,PCustos.perpis,PCustos.percofins,0,EdUNid_codigo.ResultFind.fieldbyname('unid_simples').asstring);f
// 27.04.15 - prever usar desconto geral OU informado pro produto quando vem do xml
       PCustos.custo:=FGeral.Custo(PCustos.unitario,PCustos.pericms,perfrete,PCustos.peripi,pericmsfrete,PCustos.perdesc,EdPerAcre.ascurrency,PCustos.perpis,PCustos.percofins,0,EdUNid_codigo.ResultFind.fieldbyname('unid_simples').asstring);
       PCustos.custo:=PCustos.custo/PCustos.embalagem;
       PCustos.customedio:=FGeral.CustoMedio(PCustos.acustomedio,PCustos.custo,PCustos.aqtde,PCustos.qtde);
//       unitario:=PCustos.valoruni*((100-perdescprev))/100;
       unitario:=PCustos.valoruni*((100-EdDescoper.ascurrency))/100;
//       unitario:=unitario*((100+EdPeracre.ascurrency))/100;
       unitario:=unitario*((100+Peracreprev))/100;
       unitario:=unitario/PCustos.embalagem;
       custo:=PCustos.unitario*((100-EdDescoper.ascurrency))/100;
       custo:=custo*((100+EdPeracre.ascurrency))/100;
       custo:=custo/PCustos.embalagem;
       PCustos.custoger:=FGeral.CustoGer(unitario,custo*(PCustos.pericms/100),
               perfreteprev,custo*(PCustos.peripi/100),Unitario*(pericmsfreteprev/100),EdDescoper.ascurrency,EdPeracre.ascurrency,EdUNid_codigo.ResultFind.fieldbyname('unid_simples').asstring);
       PCustos.customedioger:=FGeral.CustoMedioGerencial(PCustos.acustomedioger,PCustos.custoger,PCustos.aqtdeprev,PCustos.qtdeprev);

////////////////////////////////////////////////////////////////////
{ -
       Sistema.Edit('estoqueqtde');
       Sistema.setfield('esqt_custo',PCustos.custo);
       Sistema.setfield('esqt_customedio',PCustos.customedio);
       sistema.setfield('esqt_qtde',PCustos.qtde+PCustos.aqtde);
       Sistema.setfield('esqt_dtultcompra',PCustos.dataultcompra);
       if Global.Usuario.OutrosAcessos[0010] then begin   // caso nao tiver acesso nao mexer nos custos
             Sistema.setfield('esqt_custoger',PCustos.custoger);
             Sistema.setfield('esqt_customeger',PCustos.customedioger);
             sistema.setfield('esqt_qtdeprev',PCustos.qtdeprev+PCustos.aqtdeprev);
       end;
       Sistema.Post('esqt_esto_codigo='+stringtosql(PCustos.produto)+' and esqt_unid_codigo='+EdUNid_codigo.Assql+
                     ' and esqt_status=''N'''  );
}
////////////////////////////////////////////////////////////////////
     end;

   end;

   function ValidaCustos:boolean;
   //////////////////////////////////
   var p:integer;
       totalnf,totalnfprev,vlrdesco,vlrdescoprev:currency;
       ret:boolean;
   begin
     ret:=true;
     sistema.setmessage('Validando custo');
     totalnf:=0;totalnfprev:=0;
     if EdPerdesco.ascurrency<100 then
       vlrdesco:=EdDigtotalnf.ascurrency/(100-EdPerdesco.ascurrency)
     else
       vlrdesco:=0;
     if EdDescoper.ascurrency<100 then
       vlrdescoprev:=EdDigtotalnf.ascurrency/(100-EdDescoper.ascurrency)
     else
       vlrdescoprev:=0;
     for p:=0 to ListaCustos.count-1 do begin
       PCustos:=Listacustos[p];
       totalnf:=totalnf+ (Pcustos.custo*PCustos.qtde) ;
       totalnfprev:=totalnfprev+ (Pcustos.custoger*PCustos.qtdeprev);
     end;
     totalnf:=totalnf + EdDigvicms.ascurrency - vlrfreteliquido + EdValoripi.ascurrency ;
     totalnfprev:=totalnfprev + EdDigvicms.ascurrency  - vlrfreteliquido + EdValoripi.ascurrency ;
{
     if totalnf<>EdDigtotalnf.ascurrency then begin
        Avisoerro('Checar custo '+floattostr(totalnf));
        ret:=false;
     end;
     if roundvalor(totalnfprev)<>Edtotal.ascurrency then begin
        Avisoerro('Checar custo gerencial '+floattostr(roundvalor(totalnfprev)));
        ret:=false;
     end;
}
     sistema.setmessage('');
     result:=ret;
   end;

   procedure GravaCustos;
   //////////////////////
   var p:integer;
       produto,xsqlcor,xsqltamanho,xsqlcopa:string;
       unitario,custo:currency;


       function AtualizaCus:boolean;
       //////////////////////////////
       begin
         result:=true;
         if ( ( pos( strzero( FEstoque.GetGrupo( PCustos.produto ) ,6 ) ,FGeral.GetConfig1AsString('GRUPOSNAOcus') ) > 0 )
                and
             ( trim(FGeral.GetConfig1AsString('GRUPOSNAOcus'))<>''  )  ) then
             result:=false;
             if ( ( pos( strzero( FEstoque.GetSubGrupo( PCustos.produto ) ,4 ) ,FGeral.GetConfig1AsString('subGRUPOScus') ) > 0 )
                and
                ( trim(FGeral.GetConfig1AsString('SubGRUPOScus'))<>'' ) ) then
                 result:=true;

       end;


   begin
   /////
     sistema.setmessage('Gravando custo');
     for p:=0 to ListaCustos.count-1 do begin
       PCustos:=Listacustos[p];
       Sistema.Edit('estoqueqtde');
       if EdDtmovimento.asdate>1 then begin  // 19.10.05
         if AtualizaCus then begin
           Sistema.setfield('esqt_custo',PCustos.custo);
           Sistema.setfield('esqt_customedio',PCustos.customedio);
         end;
         sistema.setfield('esqt_qtde',PCustos.qtde+PCustos.aqtde);
       end;
       Sistema.setfield('esqt_dtultcompra',PCustos.dataultcompra);
       if Global.Usuario.OutrosAcessos[0010] then begin   // caso nao tiver acesso nao mexer nos custos
         if AtualizaCus then begin
             Sistema.setfield('esqt_custoger',PCustos.custoger);
             Sistema.setfield('esqt_customeger',PCustos.customedioger);
         end;
         sistema.setfield('esqt_qtdeprev',PCustos.qtdeprev+PCustos.aqtdeprev);
       end;
       if (Global.Topicos[1366]) and (PCustos.precovenda>Pcustos.custo) then   // 09.09.13
         Sistema.SetField('esqt_vendavis',Pcustos.precovenda);
       Sistema.Post('esqt_esto_codigo='+stringtosql(PCustos.produto)+' and esqt_unid_codigo='+EdUNid_codigo.Assql+
                     ' and esqt_status=''N'''  );
// 21.08.06 - atualiza��o do custo na grade - rever como fazer
////////////////////////////////////////////////////////
// 22.10.09 - 'ativado'
//{
////////////////////////////////////////////////////////
// 29.06.15 - desativado
{
       if (PCustos.codcor>0) or (PCustos.codtamanho>0) then begin
         if PCustos.codcor>0 then
           xsqlcor:=' and esgr_core_codigo='+inttostr(PCustos.codcor)
         else
           xsqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
         if PCustos.codtamanho>0 then
           xsqltamanho:=' and esgr_tama_codigo='+inttostr(PCustos.codtamanho)
         else
           xsqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
         if PCustos.codcopa>0 then
           xsqlcopa:=' and esgr_copa_codigo='+inttostr(PCustos.codcopa)
         else
           xsqlcopa:=' and ( esgr_copa_codigo=0 or esgr_copa_codigo is null )';

           Sistema.Edit('Estgrades');
           if EdDtmovimento.asdate>1 then begin  // 19.10.05
             Sistema.Setfield('esgr_qtde',PCustos.qtde+PCustos.aqtde );
             if AtualizaCus then begin
               Sistema.Setfield('esgr_custo',PCustos.custo);
               Sistema.Setfield('esgr_customedio',PCustos.customedio);
             end;
           end;
           Sistema.Setfield('esgr_qtdeprev',PCustos.qtdeprev+PCustos.aqtdeprev );
           if AtualizaCus then begin
             Sistema.Setfield('esgr_custoger',PCustos.custoger);
             Sistema.Setfield('esgr_customeger',PCustos.customedioger);
           end;
           if (Global.Topicos[1366]) and (PCustos.precovenda>Pcustos.custo) then   // 09.09.13
             Sistema.SetField('esgr_vendavis',Pcustos.precovenda);
           Sistema.Post('esgr_esto_codigo='+stringtosql(PCustos.produto)+
                        ' and esgr_status=''N'' and esgr_unid_codigo='+EdUNid_codigo.Assql+
                         xsqlcor+xsqltamanho+xsqlcopa );
       end;
//}
////////////////////////////////////////////////////////
     end;

   end;

// 07.08.07
    function TotalParcela:currency;
    ///////////////////////////////
    var p:integer;
        valor:currency;
    begin
      valor:=0;
//      if EdDtmovimento.asdate>1 then begin
        for p:=1 to Gridparcelas.rowcount do begin
          valor:=valor+texttovalor(Gridparcelas.cells[1,p]);
        end;
// 31.05.17 - nao � mais usado o gridparcelas2
//      end else begin
//        for p:=1 to Gridparcelas2.rowcount do begin
//          valor:=valor+texttovalor(Gridparcelas2.cells[1,p]);
//        end;
//      end;
      result:=valor;
    end;

// 09.09.09
    procedure GeraListaEntrada(Grid:TSqlDtGrid;colunaproduto:integer);
    /////////////////////////////////////////////////////////////////
    var p,i:integer;
        produto:string;
        achou:boolean;
        Q:TSqlquery;
        qtde,valor,fator,totqtde,totvalor,qtdeanimais:currency;
    begin
      totvalor:=0;
      for p:=1 to Grid.RowCount do begin
        produto:=Grid.Cells[colunaproduto,p];

//        qtde:=TexttoValor( Grid.Cells[Grid.getcolumn('move_qtde'),p] );
        qtdeanimais:=TexttoValor( Grid.Cells[Grid.getcolumn('move_pecas'),p] );
        qtde:=TexttoValor( Grid.Cells[Grid.getcolumn('pesovivo'),p] ) - TexttoValor( Grid.Cells[Grid.getcolumn('pesocarcaca'),p] );
        valor:=TexttoValor( Grid.Cells[Grid.getcolumn('total'),p] );
        totvalor:=totvalor+valor;
        if trim(produto)<>'' then begin
           cstrecla:=Grid.Cells[Grid.getcolumn('Move_cst'),p];
           Q:=sqltoquery('select cust_esto_codigo,cust_esto_codigomat,cust_perqtde,cust_qtde from custos where cust_status='+Stringtosql('R')+
                    ' and cust_esto_codigo='+stringtosql(produto)+
                    ' and cust_tipo='+Stringtosql('R') );
           while not Q.eof do begin
             achou:=false;
             for i:=0 to ListaEntrada.Count-1 do begin
               PRecla:=ListaEntrada[i];
               if PRecla.produto=Q.fieldbyname('cust_esto_codigomat').AsString then begin
                 achou:=true;
                 break;
               end;
             end;
             if not Achou then begin
               New(PRecla);
               PRecla.produto:=Q.fieldbyname('cust_esto_codigomat').AsString;
// codigo da carca�a - colocar direto o peso da carcaca
// 06.01.10 - codigos na config. geral pra diferenciar tratamento de carca�a e do couro
               if (Q.fieldbyname('cust_perqtde').ascurrency=0) and (pos(PRecla.produto,FGeral.GetConfig1AsString('codigocarcaca'))>0 ) then
                 PRecla.qtde:=Texttovalor(Grid.cells[Grid.getcolumn('pesocarcaca'),p])
               else if (Q.fieldbyname('cust_perqtde').ascurrency=0)  then
                 PRecla.qtde:=qtdeanimais*Q.fieldbyname('cust_qtde').ascurrency
               else
                 PRecla.qtde:=qtdeanimais*(qtde*(Q.fieldbyname('cust_perqtde').ascurrency/100));
               PRecla.valor:=0;
               ListaEntrada.Add(PRecla);
             end else begin
// 08.01.10 - codigos na config. geral pra diferenciar tratamento de carca�a e do couro
               if (Q.fieldbyname('cust_perqtde').ascurrency=0) and (pos(PRecla.produto,FGeral.GetConfig1AsString('codigocarcaca'))>0 ) then
                 PRecla.qtde:=PRecla.qtde+Texttovalor(Grid.cells[Grid.getcolumn('pesocarcaca'),p])
               else if (Q.fieldbyname('cust_perqtde').ascurrency=0)  then
                 PRecla.qtde:=PRecla.qtde+(qtdeanimais*Q.fieldbyname('cust_qtde').ascurrency)
               else
                 PRecla.qtde:=PRecla.qtde+( qtdeanimais*(qtde*(Q.fieldbyname('cust_perqtde').ascurrency/100)) );
             end;
             Q.Next;
           end;
           Q.Close;
        end;
      end;
// 'calcula valor pra 'fechar' com a nota do produtor - 10.10.09
           totqtde:=0;
           for i:=0 to ListaEntrada.Count-1 do begin
             PRecla:=ListaEntrada[i];
             totqtde:=totqtde+PRecla.qtde;
           end;
           for i:=0 to ListaEntrada.Count-1 do begin
             PRecla:=ListaEntrada[i];
             PRecla.valor:=(totvalor/totqtde)*Precla.qtde;
           end;

    end;

    procedure GravaListaEntrada;
    /////////////////////////////
    var i:integer;
        QEstoque:TSqlquery;
    begin
       for i:=0 to ListaEntrada.Count-1 do begin
          PRecla:=ListaEntrada[i];
          Sistema.Insert('Movestoque');
          Sistema.SetField('move_esto_codigo',PRecla.produto);
          Sistema.SetField('move_tama_codigo',0);
          Sistema.SetField('move_core_codigo',0);
          Sistema.SetField('move_copa_codigo',0);
          Sistema.SetField('move_transacao',transacao);
          Sistema.SetField('move_operacao',FGeral.GetOperacao);
          Sistema.SetField('move_numerodoc',numerodoc);
          Sistema.SetField('move_status','N');
          Sistema.SetField('move_tipomov',Global.CodCompraProdutorReclassifica);
          Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
          Sistema.SetField('move_tipo_codigo',xEdRecla.AsInteger);
          Sistema.SetField('move_tipocad','C');
          Sistema.SetField('move_repr_codigo',xEdRecla.ResultFind.fieldbyname('clie_repr_codigo').AsInteger);
          if EdDtMovimento.AsDate>1 then begin
              Sistema.SetField('move_qtde',PRecla.qtde);
              Sistema.SetField('move_venda',roundvalor(PRecla.valor/PRecla.qtde));
              Sistema.SetField('move_datacont',EdDtEntrada.AsDate);
          end else begin
                Sistema.SetField('move_qtde',PRecla.qtde);
                Sistema.SetField('move_venda',roundvalor(PRecla.valor/PRecla.qtde));
          end;

          Sistema.SetField('move_datalcto',Sistema.Hoje);
          Sistema.SetField('move_datamvto',EdDtEntrada.asdate);
          Sistema.SetField('move_qtderetorno',0);
{
          Sistema.SetField('move_custo',Arq.TEstoqueQtde.fieldbyname('esqt_custo').ascurrency);
          Sistema.SetField('move_custoger',Arq.TEstoqueQtde.fieldbyname('esqt_custoger').ascurrency);
          Sistema.SetField('move_customedio',Arq.TEstoqueQtde.fieldbyname('esqt_customedio').ascurrency);
          Sistema.SetField('move_customeger',Arq.TEstoqueQtde.fieldbyname('esqt_customeger').ascurrency);
}
          Sistema.SetField('move_cst',Grid.Cells[grid.getcolumn('move_cst'),01]);
          Sistema.SetField('move_aliicms',0);
          Sistema.SetField('move_grup_codigo',FEstoque.GetGrupo(PRecla.produto));
          Sistema.SetField('move_sugr_codigo',FEstoque.GetSubGrupo(PRecla.produto));
          Sistema.SetField('move_fami_codigo',FEstoque.GetFamilia(PRecla.produto));
          Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
          Sistema.SetField('move_aliipi',0);
          Sistema.SetField('move_tipo_codigoind',0);
          Sistema.SetField('move_pecas',0);
          Sistema.SetField('move_redubase',0);
          Sistema.SetField('move_nroobra','');
          Sistema.Post('');
          QEstoque:=sqltoquery('select * from EstoqueQtde inner join estoque on (esto_codigo=esqt_esto_codigo)'+
                    ' where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(PRecla.produto)+
                    ' and esqt_unid_codigo='+Stringtosql(EdUNid_codigo.text));
          FGeral.MovimentaQtdeEstoque(PRecla.produto,EdUNid_codigo.text,'E',Global.CodCompraProdutorReclassifica,PRecla.qtde,QEstoque,PRecla.qtde,0);
          FGeral.FechaQuery(QEstoque);


       end;
    end;

// 20.01.10
    function ValidaTotalItens:boolean;
    ////////////////////////////////////////
    var x:integer;
        produto,produtonfe,produtossem:string;
        totalprodutos,valoritem:currency;
    begin
      result:=true;totalprodutos:=0;
      produtossem:='';
      if ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodRetornocomServicos+';'+Global.CodDevolucaoInd+
           ';'+Global.CodCompraIndustria+';'+Global.CodCompraProdutor )>0  )
        or
        ( not EdArquivoxml.isempty  )
        or // 22.08.11             // 18.10.11
        ( (Global.Topicos[1351]) and (pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodConhecimento+
           ';'+Global.CodEntradaSemItens+';'+Global.CodNfeComplementoIcmsE+';'+Global.CodNfeComplementoIcmsECliente)=0) )
        then begin
        for x:=1 to Grid.RowCount do begin
          produto:=Grid.Cells[Grid.getcolumn('move_esto_codigo'),x];
          produtonfe:=Grid.Cells[Grid.getcolumn('produtonfe'),x];
          if trim(produto)<>'' then begin
            valoritem:=Texttovalor( Grid.Cells[Grid.getcolumn('total'),x] );
            totalprodutos:=totalprodutos+valoritem
          end else if (trim(produtonfe)<>'') and ( trim(produto)='' ) then begin  // 15.10.10
            valoritem:=Texttovalor( Grid.Cells[Grid.getcolumn('total'),x] );
            totalprodutos:=totalprodutos+valoritem;
            produtossem:=produtossem+produtonfe+';';
            result:=false;
          end;
        end;
//        if Abs(totalprodutos-EdDigtotalnf.AsCurrency)>1 then begin
        if ( ( Abs(totalprodutos-EdDigtotpro.AsCurrency)>1 ) or (EdDigtotpro.AsCurrency=0) )
            and
             ( AnsiPos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodNfeComplementoIcmsE+';'+
               Global.CodPrestacaoServicosE+';'+Global.CodEntradaNFPE+';'+
               Global.CodNfeComplementoIcmsECliente)=0 )
         then begin
//          Avisoerro('Total somado itens '+floattostr(totalprodutos)+' Total Produtos '+floattostr(EdDigtotalnf.AsCurrency));
// 01.12.10 - fiasco na frente da Angela - Cenitech
          Avisoerro('Total somado itens '+floattostr(totalprodutos)+' Total Produtos '+floattostr(EdDigtotpro.AsCurrency));
          result:=false;
        end;
        if trim(produtossem)<>'' then
          Avisoerro('Produtos '+produtossem+' sem codigo do estoque do sistema');

      end;
    end;

    // 08.10.15
    procedure GeraOs;
    ////////////////////////////////////////////////////////////
    var QOs,TEstoque:TSqlquery;
        p,i:integer;
        xproduto,xtransacao,xgeraos:string;
        xvenda,xqtde:currency;
        ListaOP,ListaOS:TStringList;
    begin
      xgeraos:='N';
      for p:= 1 to Grid.rowcount do begin
        if trim( Grid.Cells[Grid.getcolumn('move_operacao'),p] ) <> ''  then begin
          ListaOP:=TStringList.create;
          strtolista(ListaOP,Grid.Cells[Grid.getcolumn('move_operacao'),p],'|',true);
          for i:=0 to ListaOP.count-1 do begin
            if trim(ListaOP[i])<>'' then begin ;
              ListaOS:=TStringList.create;
              strtolista(ListaOs,ListaOP[i],';',true);
  //            xtransacao:= trim( Grid.Cells[Grid.getcolumn('move_operacao'),p] );
              xtransacao:= trim( ListaOS[0] );
              QOs:=sqltoquery('select * from movped where mped_transacao='+Stringtosql(xtransacao)+
                              ' and mped_status=''N''');
              xproduto:=Grid.Cells[Grid.getcolumn('move_esto_codigo'),p];
  //            xqtde:= Texttovalor( Grid.cells[Grid.getcolumn('move_qtde'),p] );
              xqtde:= Texttovalor( ListaOS[1] );
              xvenda:= Texttovalor( Grid.cells[Grid.getcolumn('move_venda'),p] );
              if trim(xproduto)='' then begin
                xproduto:='DESP'+trim(EdComv_codigo.text);
//                xqtde:=1;
                xvenda:=EdDigtotalnf.ascurrency;
              end;
              if not Qos.eof then begin
                xgeraos:='S';
                TEstoque:=sqltoquery('select * from estoque where esto_codigo='+Stringtosql(xproduto));
                Sistema.Insert('movestoque');
                Sistema.SetField('move_esto_codigo',xProduto);
                Sistema.SetField('move_status','R');
                Sistema.SetField('move_transacao',transacao);
                Sistema.SetField('move_unid_codigo',EdUNid_codigo.text);
                Sistema.SetField('move_core_codigo',Texttovalor( Grid.Cells[Grid.Getcolumn('move_core_codigo'),p] ) );
                Sistema.SetField('move_tama_codigo',Texttovalor( Grid.Cells[Grid.Getcolumn('move_tama_codigo'),p] ) );
                Sistema.SetField('move_qtde',xqtde );
                Sistema.SetField('move_qtderetorno',xqtde);
                Sistema.SetField('move_operacao',xTransacao+strzero(p,2) );
                Sistema.SetField('move_tipo_codigo',QOs.fieldbyname('mped_tipo_codigo').asinteger);
                Sistema.SetField('move_tipocad','C');
                Sistema.SetField('move_numerodoc',QOs.fieldbyname('mped_numerodoc').asinteger);
                Sistema.SetField('move_tipomov',Global.CodOrdemdeServico);
                Sistema.SetField('move_datalcto',sistema.hoje);
                Sistema.SetField('move_datamvto',EdDtentrada.asdate);
                Sistema.SetField('move_datacont',EdDtentrada.asdate);
                Sistema.SetField('move_usua_codigo',Global.Usuario.Codigo);
                Sistema.SetField('move_grup_codigo',TEstoque.fieldbyname('esto_grup_codigo').asinteger);
                Sistema.SetField('move_sugr_codigo',TEstoque.fieldbyname('esto_sugr_codigo').asinteger);
                Sistema.SetField('move_fami_codigo',TEstoque.fieldbyname('esto_fami_codigo').asinteger);
                Sistema.SetField('move_locales','01');
                Sistema.SetField('move_nroobra',EdNumerodoc.text);
                Sistema.SetField('move_venda',xvenda);
                Sistema.post;
                FGeral.fechaquery(TEstoque);
              end;
            end;
          end;
        end;

      end;
      if xgeraos='S' then Sistema.commit;
    end;


    // 08.05.18
    function ValidaGridParcelas:boolean;
    ////////////////////////////////////
    var x:integer;
        xvencimento:String;
        xparcela:currency;
    begin

      result:=true;
      for x:=1 to GridParcelas.RowCount  do begin

         xvencimento:=GridParcelas.Cells[GridParcelas.GetColumn('pend_datavcto'),x] ;
         xparcela   :=Texttovalor( GridParcelas.Cells[GridParcelas.GetColumn('pend_valor'),x] );
         if ( trim(copy(xvencimento,1,2))='' )  and ( xparcela>0 ) then begin
           result:=false;
           break;
         end;
      end;

    end;


// 22.07.20
   procedure GravaApropriacao;
   ////////////////////////////
   var w     : integer;
       xdata : TDatetime;

   begin

      for w := 1 to EdVezesap.asinteger do  begin

         if w = 1 then

            xData := DateToUltimoDiaMes( EdDtentrada.asdate )

         else

            xData := DateToUltimoDiaMes( DateToDateMesPos(EdDtentrada.asdate,w-1) );

         Sistema.Insert('apropriacoes');
         Sistema.Setfield('APRO_COMV_CODIGO',EdComv_codigo.asinteger);
         Sistema.Setfield('APRO_DATA',xData);
         Sistema.Setfield('APRO_NVEZES',EdVezesap.asinteger);
         Sistema.Setfield('APRO_TIPOMOV',TipoMovM);
         Sistema.Setfield('APRO_TRANSACAO',Transacao);
         Sistema.Setfield('APRO_Status','N');
         Sistema.Setfield('APRO_VALOR',EdDigTotalNf.ascurrency/EdVezesap.asinteger);
         Sistema.Setfield('APRO_VEZ',w);
         Sistema.Setfield('APRO_numerodoc',EdNumerodoc.asinteger);
         Sistema.Setfield('APRO_plan_codigo',EdPlan_conta.asinteger);
         Sistema.Setfield('APRO_UNid_codigo',EdUnid_codigo.text);
         Sistema.post;

     end;

   end;


/////////////////////////////////////////
begin
/////////////////////////////////////////
// 30.01.15
  if ( EdComv_codigo.asinteger=FGeral.GetConfig1AsInteger('NfCompleentrada') )
     and
     ( FGeral.GetConfig1AsInteger('NfCompleentrada')>0 )
     then begin

     // s� para nao validar
     valornota:=0;

  end else begin

    if not ValidaNota then exit;
// 12.09.16
//   if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodPrestacaoServicosE+';'+
//            Global.CodConhecimento )=0  then
// 25.04.18
   if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodConhecimento )=0  then
// 20.01.10
      if not ValidaTotalItens then exit;

  end;
// 19.03.15
   unidades:=Global.Usuario.UnidadesMvto;
   restricao1:=true;
   restricao2:=true;
   restricao3:=true;
   restricao4:=true;
   if Global.Topicos[1255] then
     unidades:=Global.CodigoUnidade;

   if (OP='I') and (Global.Topicos[1406]) and (EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoVenda)  then begin

        restricao1:=FGeral.ValidaCliente( EdFornec,Global.CodPedVenda,'P','DUP',unidades );
        restricao2:=FGeral.ValidaCliente( EdFornec,Global.CodPedVenda,'P','BOL',unidades );
        restricao3:=FGeral.ValidaCliente( EdFornec,Global.CodPedVenda,'P','CHQ',unidades );
//        restricao4:=FGeral.ValidaCliente( EdFornec,Global.CodPedVenda,'P','LIM',unidades );
//- 18.03.15 - Cecilia pediu pra tirar daqui
   end;
    if not restricao1 then begin //fixo portador duplicata
          if not FGEral.ValidaLiberacaoFinan(Global.usuario.codigo,'DUP') then begin
            exit;
          end;
      end else if not restricao2  then begin //fixo portador boleto
          if not FGEral.ValidaLiberacaoFinan(Global.usuario.codigo,'DUP') then begin
            exit;
          end;
      end else if not restricao3  then begin //cheques devolvidos

          if not FGEral.ValidaLiberacaoFinan(Global.usuario.codigo,'DUP') then begin
            exit;
          end;
      end else if not restricao4  then begin // total em aberto versus limite de cr�dito
          if not FGEral.ValidaLiberacaoLimite(Global.usuario.codigo) then begin
            exit;
          end;
    end;


  if not EdDtmovimento.IsEmpty then begin
// 12.07.07
//    if not EdNatf_codigo.valid then exit;
// 15.03.23 - retirado para pode alterar o cfop de algum item durante a inclusao da nota
  end;
// 20.04.12 - 15.05.12 - cagadex pego na novi...caso alterou o vencimento/valor..'perde'..psss
  if ( FGeral.GetGeraFinanceiro(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring)='S' )  then begin
//     if not EdFpgt_codigo.valid then begin - 15.05.12
     if length( trim(EdFpgt_codigo.text) ) <> EdFpgt_codigo.MaxLength then begin
       Avisoerro('Checar campo Pagto (codigo da condi��o de pagamento)');
       EdFpgt_codigo.setfocus;
       exit;
     end;
  end;
// 11.06.08
   if ( (not EdDtmovimento.isempty) ) and (Global.Topicos[1319] ) then begin
     if campoufentidade='forn_uf' then begin
       if ( not FGeral.CnpjcpfOK(QFornec.fieldbyname('forn_cnpjcpf').AsString) ) then  begin
         Avisoerro('Obrigat�rio fornecedor com CNPJ/CPF v�lido');
         exit;
       end;
     end else begin
       if ( not FGeral.CnpjcpfOK(QFornec.fieldbyname('clie_cnpjcpf').AsString) ) then  begin
         Avisoerro('Obrigat�rio cliente com CNPJ/CPF v�lido');
         exit;
       end;
     end;
   end;
/////////////////
  if EdFornec.asinteger>0 then begin
     if uppercase(Edfornec.findtable)='FORNECEDORES' then
       tipocad:='F'
     else
       tipocad:='C';
     xEd:=EdFornec;
     xEdRecla:=TSqled.Create(Owner);
     xEdRecla.TypeValue:=xEd.TypeValue;
     xEdRecla.text:=EdFornec.text; // 09.09.09

  end else begin
     tipocad:='T';
     xEd:=EdTran_codigo;
  end;

//////////// - 30.10.09
   if (EdDtmovimento.isempty) and (not Global.Usuario.OutrosAcessos[0321]) then begin
       Avisoerro('Usu�rio sem permiss�o para este tipo de nota');
       exit;
   end;
  if ( pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,EntranoCusto ) > 0 )
     or
     ( pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.CodCompraProdutor ) > 0 )     then begin
    if EdFpgt_codigo.isempty then begin
       Avisoerro('Falta condi��o de pagamento');
       exit;
    end;
// 27.02.14 - retirado pois em lan�amentos sem movimento 'desalterava o vencimento...clari+raquel
//    if Texttovalor(GridParcelas.cells[GridParcelas.getcolumn('pend_valor'),1])=0 then begin  // 09.05.11
//      if not EdFpgt_codigo.valid then exit;
//    end;
// 02.03.06
    if not FGeral.ValidaGridVencimentos(GridParcelas) then exit;
    if not FGeral.ValidaGridVencimentos(GridParcelas2) then exit;

  end;
// 31.10.05
   if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring = Global.CodDevolucaoVenda then begin
      if trim(GridParcelas.cells[1,1])='' then begin  // 20.04.2010 - Novi - tiago
        if not EdFpgt_codigo.valid then exit;
      end;
// 06.11.14 - vivan
      if pos( EdFornec.ResultFind.FieldByName('clie_situacao').AsString,'B/R' )>0 then begin
        Avisoerro('Cliente com situa��o '+EdFornec.ResultFind.FieldByName('clie_situacao').AsString);
        exit;
      end;
// 11.11.14 - vivan  - lindacir
      if Global.Topicos[1413] then begin
          if (trim (EdFornec.ResultFind.fieldbyname('Clie_portadores').asstring)<>'') then begin
            if pos( EdPort_codigo.text,EdFornec.ResultFind.fieldbyname('Clie_portadores').asstring ) = 0 then begin
              Avisoerro('Cliente possui somente os seguintes portadores :'+EdFornec.ResultFind.fieldbyname('Clie_portadores').asstring);
              exit;
            end;
          end else begin;
            Avisoerro('Ainda n�o definido portador(es) neste cliente');
            exit
          end;
      end;
   end;
// 07.08.07
   if (FCondpagto.GetAvPz(EdFpgt_codigo.text)='P') and ( FGeral.GetGeraFinanceiro(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring)='S' ) then begin

// 22.06.20 - retirado Global.codentradaprodutor  - Novicarnes - VAgner
     if pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.CodCompraProdutor+';'+Global.CodCompraProdutorMerenda+';'+
            Global.CodNfeComplementoValorProdutor+';'+Global.CodPrestacaoServicosE)>0 then
       valornota:=EdTotalNota.ascurrency
     else
// 19.06.20 - novicarnes nota da guelen compra pessoa juridica com gta sempre os rolo deu diferen�a de 2 centavos...
       valornota:=EdDigtotalnf.ascurrency;

//     if valornota<>Totalparcela then begin
     if EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodRetornocomServicos then begin
//   11.07.13 - Metalforte
       if valornotafinan=0 then valornotafinan:=valornota;
       if (FGeral.Arredonda(valornotafinan,2)<>FGeral.Arredonda(Totalparcela,2))   then begin
         Avisoerro('Total do financeiro da nota :'+formatfloat(f_cr3,valornotafinan)+' difere do total de parcelas :'+formatfloat(f_cr3,Totalparcela));
        exit;
       end;
// 08.05.18 - Clessi - 'gorpe' no grid n�o gera financeiro
     end else if not ValidaGridParcelas then begin

        Avisoerro( 'Preencher corretamente data(s) de vencimento e parcela(s)');
        exit;

     end else begin
//   04.02.09 - Carli
// 16.04.2021 - Devereda
       if (valornota<>Totalparcela) and ( pos('F',EdSerie.text)=0)
          and (EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring<>Global.CodPrestacaoServicosE)
          then begin

         if (valornota > Totalparcela) then

           Aviso('ATEN��O !!! Total da nota :'+formatfloat(f_cr,valornota)+' MAIOR que o total de parcelas :'+formatfloat(f_cr,Totalparcela))

         else begin

           Avisoerro('Total da nota :'+formatfloat(f_cr,valornota)+' difere do total de parcelas :'+formatfloat(f_cr,Totalparcela));
           exit;

         end;

       end;

     end;

   end;

// 19.06.09 - Abra
   if (Global.Topicos[1330]) and ( not EdPlan_conta.IsEmpty ) and ( trim(FGeral.GetConfig1AsString('ContasBloq'))<>'' ) then begin
//     if pos( EdPlan_conta.Text,FGeral.GetConfig1AsString('ContasBloq') ) >0 then begin
// 08.06.10
     if FGeral.ContaBloqueada( EdPlan_conta.Asinteger,FGeral.GetConfig1AsString('ContasBloq') ) then begin
       Avisoerro('Conta '+EdPlan_conta.Text+' bloqueada para identificar despesas');
       exit;
     end;
   end;
////////////
// 06.08.12
   if (EdMensagem.IsEmpty) and ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodEstornoNFeSai)>0 ) then begin
     Avisoerro('Obrigat�rio informar a justificativa de estorno de NF-e');
     exit;
   end;
//////////////
// 04.12.13 - Patoterra - 20.07.18 - A2z - Thais fixou para sempre informar...
   if ( global.topicos[1367] ) and ( EdCodEqui.IsEmpty ) then begin
     Avisoerro('Ainda n�o informado o codigo do equipamento');
     exit;
   end;
// 16.07.19 - A2z...
   if ( global.topicos[1367] ) then begin

//     if EdCodEqui.ResultFind=nil then begin
//      if strtointdef( copy( Grid.Cells[grid.GetColumn('move_operacao'),1],14,4 ),0 ) = 0 then begin
      posicao:=AnsiPos(';',Grid.Cells[grid.GetColumn('move_operacao'),1]);
      if strtointdef( copy( Grid.Cells[grid.GetColumn('move_operacao'),1],posicao+1,4 ),0 ) = 0 then begin
        Avisoerro('N�o informado corretamente o codigo do equipamento');
        exit;
     end;

   end;

   if OP='A' then begin

        QVePendencia:=sqltoquery('select * from pendencias where '+FGeral.Getin('pend_status','B;P','C')+' and pend_numerodcto='+Stringtosql(EdNumerodoc.text)+
//                             ' and pend_datamvto>='+EdDtemissao.assql+' and pend_tipocad=''F'' and pend_tipo_codigo='+EdFornec.assql);
// 09.09.08 = retirado devido a nota de produtor que � cliente
                             ' and pend_datamvto>='+EdDtemissao.assql+' and pend_tipo_codigo='+EdFornec.assql);
        if (not QVePendencia.eof) and (xcondicao<>FGeral.getconfig1asstring('Fpgtoavista') ) then begin
             Avisoerro('Nota com pend�ncia financeira j� baixada.  Altera��o n�o permitida.');
             exit;
        end;
        qVePendencia.close;
// 08.11.2011 - deixar alterar nota de produtor NP
        if Global.UsaNfe='S' then begin
          campo:=Sistema.GetDicionario('movesto','moes_dtnfeauto');
          if campo.Tipo<>'' then begin
            QVeNfe:=sqltoquery('select moes_transacao,moes_dtnfeauto from movesto where moes_numerodoc='+EdNumerodoc.AsSql+
                               ' and moes_unid_codigo='+EdUnid_codigo.AsSql+
                               ' and moes_dataemissao='+EdDtEmissao.AsSql+
                               ' and moes_tipo_codigo='+EdFornec.AsSql+
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

   end;
// 12.10.09
   if (EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodCompraProdutor)
       and ( FGeral.getconfig1asinteger('ConfMovRecla')>0 )
       and ( FGeral.getconfig1asinteger('Clienfrecla')>0 ) and (OP<>'I')then begin
       Avisoerro('Nota de Produtor com nota de reclassifica��o.  Altera��o n�o permitida.');
       exit;
   end;
// 19.10.10
   if (op='I') and ( not EdArquivoxml.IsEmpty ) then begin
     if not EdNumerodoc.Valid then exit;
// 15.03.23 - retirado pra poder alterar o cfop na inclusao da nf de entrada q usou xml
     if not EdTran_codigo.Valid then exit;
   end;
  AtualizaCustos;
  if OP='I' then begin
    if (not ValidaCustos) then exit;
  end;
// 31.07.07
//  if not EdMuni_codigo.valid then begin
//    Avisoerro('Checar codigo da cidade');
//    exit;
//  end;

// 20.08.20 - Novicarnes
  if EdPlan_conta.asinteger <> 9999 then begin

// 01.08.07
      if not EdPlan_conta.Valid then begin
        Avisoerro('Checar conta');
        exit;
      end;

  end;

// 22.10.10
  if Global.Topicos[1347] then begin
    if not Edcontacredito.Valid then begin
      Avisoerro('Checar conta de cr�dito');
      exit;
    end;
  end;
// 18.03.10
  if (EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodCompraProdutor) and ( FGeral.getconfig1asinteger('ConfMovRecla')>0 )
     and ( FGeral.getconfig1asinteger('Clienfrecla')>0 ) and (Global.Topicos[1337])
     then begin
     if not TodostemComposicao(Grid,Grid.GetColumn('move_esto_codigo')) then begin
        Avisoerro('Aten��o.  Nota com produtos sem composi��o para Nota de Reclassifica��o');
        exit;
     end;
  end;
// 21.06.16
  if (Global.topicos[1043]) and ( EdDtMovimento.asdate > 1 )  then begin
     debito:=0;credito:=0;
     FGeral.GetContasExportacao(FCondPagto.GetAvPz(EdFpgt_codigo.text),'C',EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Tipocad,'',EdUnid_codigo.text,
                                EdComv_codigo.asinteger,EdFornec.asinteger,0,debito,credito);
     if (debito=0) then begin
       Avisoerro('Falta configurar a conta de d�bito');
       exit;
     end else if (credito=0) then begin
       Avisoerro('Falta configurar a conta de cr�dito');
       exit;
     end;
  end;

// 10.01.18
//   if (EdTipodoc.text='CTE') and ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodConhecimento)>0 )
// 05.04.2021 - Novicarnes
   if ( copy(EdTipodoc.text,1,3)='CTE') and ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodConhecimento)>0 )
      and ( not (Edarquivoxml.IsEmpty) ) then begin

      if Ansipos('Id="CTe',Xmlcte) > 0 then begin

        chavecte :=copy(xmlcte, Ansipos('Id="CTe',Xmlcte)+7 ,44);
        if Edchavenfeacom.Text<>chavecte then begin

          Avisoerro('Chave no XML = '+chavecte+'.  Chave '+EdChavenfeacom.Text);
          exit;

        end;
// 08.07.20
        numerocte:=AcbrCte1.Conhecimentos.Items[0].CTe.ide.nCT;
        if EdNumerodoc.Asinteger <> numerocte then begin

          Avisoerro('N�mero no XML = '+inttostr(numerocte)+'.  Numero '+EdNumerodoc.Text);
          exit;

        end;

      end else begin

         Avisoerro('N�o encontrado chave do CTE neste arquivo XML.  Verificar');
         exit;

      end;

   end else    if (copy(EdTipodoc.text,1,3)='CTE') and ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodConhecimento)>0 )
//        and ( (Edarquivoxml.IsEmpty) )
// 08.07.20 - checar com ou sem xml
// 12.11.2021 - Alutech
          and ( Global.Topicos[1470]  )
         then begin

        if (Edchavenfeacom.Text='') or ( length(trim(Edchavenfeacom.Text))<>44 ) then begin

          Avisoerro('Chave do Cte n�o informada ou com tamanho incorreto');
          exit;

        end;
        if copy(Edchavenfeacom.Text,21,02) <> '57' then begin

          Avisoerro('Chave do Cte n�o com modelo difernte de 57');
          exit;

        end;
// 08.07.20
        if strtointdef( copy(Edchavenfeacom.Text,26,09),0 ) <> EdNumerodoc.asinteger then begin

          Avisoerro('N�mero do Cte informado diferente do que est� na chave '+copy(Edchavenfeacom.Text,26,09));
          exit;

        end;


   end;

// 11.05.20
   if Global.Topicos[1513] then begin

     for x := 1 to GridParcelas.RowCount do begin

         if TextToValor(GridParcelas.Cells[GridParcelas.GetColumn('pend_valor'),x]) > 0 then begin

            GridParcelas.Cells[GridParcelas.GetColumn('pend_codbarra'),x] := Gridcodbarra.Cells[Gridcodbarra.GetColumn('pend_codbarra'),x];
            if trim( Gridcodbarra.Cells[Gridcodbarra.GetColumn('pend_codbarra'),x] ) = '' then
               Avisoerro('Aten��o - Parcela sem CODIGO DE BARRA do boleto');

         end;

     end;

  end;

// 09.07.20 - tentar evitar digitar numera��o errada mesmo usando xml
   if ( EdTipodoc.text='NFE') and ( not (Edarquivoxml.IsEmpty) )
      and ( Ansipos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodEstornoNFeSai) = 0 )
    then begin

      if Ansipos('Id="NFe',AcbrNFe1.NotasFiscais.Items[0].XML) > 0 then begin

        if EdNumerodoc.Asinteger <> AcbrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF then begin
          Avisoerro('N�mero no XML = '+inttostr(AcbrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF)+'.  Numero '+EdNumerodoc.Text);
          exit;
        end;

      end;

   end ;

// 20.08.2021 - nfpe
   if ( EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring = Global.CodEntradaNFPe )
      and ( Edarquivoxml.IsEmpty )
      then begin

          Avisoerro('Obrigat�rio usar arquivo XML em NFP-e');
          exit;


   end ;


  if confirma('Confirma grava��o ?') then begin

      if Listacustos<>nil then
//      if (Edtotal.ascurrency=EdTotalNota.ascurrency) and ( pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,global.CodCompra+';'+global.CodCompra100)>0 ) then begin
// 19.10.05 - alma gemea...edtotal fica com valor a menor....nf artef. metais rossoni ltda.
      if (EdValortotal.ascurrency<=0) and ( pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,global.CodCompra+';'+global.CodCompra100)>0 ) then begin
        tipomovM:=Global.CodCompra100;
        tipomovN:=Global.CodCompra100;
        tipodetalhe:=Global.CodCompra100;
      end else if (EdValortotal.ascurrency>0) and ( pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,global.CodCompra+';'+global.CodCompra100)>0 ) then begin
        tipomovM:=EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring;
        tipomovN:=EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring;
        tipodetalhe:=Global.CodCompraX;
      end else begin
        tipomovM:=EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring;
        tipomovN:=EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring;
        tipodetalhe:=EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring;;
      end;
      if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoSerie5 ) or
         ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoCompra ) or
         ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoVenda ) then begin
        tipomovM:=EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring;
        tipomovN:=EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring;
        tipodetalhe:=EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring;
      end;
// 20.06.05
      if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodConhecimento+';'+Global.CodEntradaSemItens) >0 then begin
        tipomovM:=EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring;
        tipomovN:=EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring;
        tipodetalhe:=EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring;
      end;
// 19.10.05
      if (pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,global.CodCompra+';'+global.CodCompra100)>0 ) and
         ( EdDtmovimento.asdate<1)  then begin
        tipomovM:=Global.CodCompraX;
        tipomovN:=Global.CodCompraX;
        tipodetalhe:=Global.CodCompraX;
      end;
      if pos(Op,'A;F')>0 then begin
        CancelaTransacao(Transacaoant,Transacao1,OP);
      end;

      if (OP='I') or (OP='A') or (OP='F') then begin

        Sistema.BeginTransaction('Gravando');
//        if pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Devolucao)>0 then begin
// 28.02.05 - retorno de consig. mercantil digita o numero....
// 01.03.05 - ret. consignacao digita o numero
        if ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoConsigMerc+';'+global.CodRetornoConsigMercanil)=0 ) and (OP='I') then begin

          if ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Devolucao+';'+TiposNumeracaoSaida)>0 ) then begin
// 21.06.07 - deixado DV para informar a numeracao
// 19.11.12 - Vivan - DV tem q ter numeracao automatica
//            if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring<>Global.CodDevolucaoVenda ) or
//               ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,TiposNumeracaoSaida)>0 ) then begin
// 05.02.13 - deixado DV para informar a numeracao - Novicarnes - mudar vivan pra DX
            if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring<>Global.CodDevolucaoVenda ) or
               ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,TiposNumeracaoSaida)>0 ) then begin
              if EdDtmovimento.asdate>1 then
  //              EdNumerodoc.setvalue( FGeral.GetContador('NFSAIDA'+Global.CodigoUnidade+EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,false) )
  //
                EdNumerodoc.setvalue( FGeral.GetContador('NFSAIDA'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false) )
              else
                EdNumerodoc.setvalue( FGeral.GetContador('SAIDA'+EdUnid_codigo.text+EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,false) );
            end;

          end;

        end;
// 24.11.20 - para evitar q pule a numeracao 1 a mais na nf de importacao
        {
// 21.06.06 - exporta�ao q agora importa...
        if ( EdComv_codigo.ResultFind.fieldbyname('comv_natf_foestado').asstring='3102' )  and (OP='I') then begin
          if EdDtmovimento.asdate>1 then
            EdNumerodoc.setvalue( FGeral.GetContador('NFSAIDA'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false) )
          else
            EdNumerodoc.setvalue( FGeral.GetContador('SAIDA'+EdUnid_codigo.text+EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,false) );
        end;
}

// 03.05.07 - nf produtor segue numeracao das saidas
       if ( pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.CodCompraProdutor+';'+Global.CodDrawBackEnt)>0 ) and
           ( not Global.Topicos[1301] ) and (OP='I')
          then begin
          if EdDtmovimento.asdate>1 then
            EdNumerodoc.setvalue( FGeral.GetContador('NFSAIDA'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false) )
          else
            EdNumerodoc.setvalue( FGeral.GetContador('SAIDA'+EdUnid_codigo.text+EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,false) );
       end;

// 04.05.07 -
       if  (Global.Topicos[1301]) and ( pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.CodCompraProdutor+';'+
                                        Global.CodDevolucaoIgualVenda+';'+
// 05.02.2021 - Vida Nova
                                        Global.CodDevolucaoConsigMerc )>0 ) and (OP='I')

        then begin

          if EdDtmovimento.asdate>1 then
            FGeral.AlteraContador('NFSAIDA'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.serieunidade),EdNumerodoc.asinteger)
          else
            FGeral.AlteraContador('SAIDA'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.serieunidade),EdNumerodoc.asinteger);

       end;
/////////////////////////
// 24.02.05
        if OP='I' then
          GravaItensTransferidos;
// 21.07.05 - ATENCAO - 13.10.09 - NOTAS COM OS ITENS 'PUXADOS' DIRETO DO PEDIDO
//            CALCULA O CUSTO NO GRAVAITENSNFCOMPRA
{  - 29.06.15 - deixado td no Geral.pas GRAVAITENSNFCOMPRA
        if ( pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,EntranoCusto ) > 0 ) and (OP='I')
           and (EdArquivoxml.IsEmpty) then begin
           GravaCustos;
          Sistema.Commit; // 06.11.09
        end;
}
// 15.06.11 - Novi - vava...
        if OP='F' then
          Transacao:=Transacaoant
        else
          Transacao:=FGeral.GetTransacao;
        valornf:=EdDigTotalNf.AsCurrency;
        if (EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodRetornoInd) then
          valornf:=EdDigTotalNf.AsCurrency;
// 22.06.06
        MontaBase:='S';
        if ( EdNatf_codigo.text='3102' ) then begin
          EdBaseicms.setvalue(EdDigbicms.ascurrency);
          EdValoricms.setvalue(EdDigvicms.ascurrency);
          MontaBase:='N';
          if EdDtmovimento.asdate>1 then
//            FGeral.GravaMovbase(Transacao,EdNumerodoc.asinteger,'000','I',EdDigbicms.ascurrency,Eddigvicms.ascurrency,EDPericmsnota.ascurrency,0,0,0,TipomovM);
              FGeral.GravaMovbase(Transacao,EdNumerodoc.asinteger,'000','I',EdDigbicms.ascurrency,Eddigvicms.ascurrency,EDPericmsnota.ascurrency,0,0,0,TipomovM,'I',EdUnid_codigo.text,EdNatf_codigo.text);
        end;
// 25.03.08
        if pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodCompraIndustria+';'+Global.CodDevolucaoInd+';'+Global.CodRetornocomServicos)>0 then begin
          MontaBase:='N';
          EdBaseicms.setvalue(EdDigbicms.ascurrency);
          EdValoricms.setvalue(EdDigvicms.ascurrency);
          if EdDtmovimento.asdate>1 then
            FGeral.GravaMovbase(Transacao,EdNumerodoc.asinteger,'000','I',EdDigbicms.ascurrency,Eddigvicms.ascurrency,EDPericmsnota.ascurrency,0,0,0,TipomovM,'I',EdUnid_codigo.text,EdNatf_codigo.text);
        end;
// 12.03.15
        if (copy(EdTipodoc.text,1,3)<>'CTE') and ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoIgualVenda+';'+
            Global.CodDevolucaoVenda+';'+
            Global.CodDevolucaoSemFinan+';'+
            Global.CodDevolucaoBonificacao+';'+
// 16.05.2022
            Global.CodCompraProdutor+';'+
            Global.CodNfeComplementoValorProdutor)=0 )
           then Edchavenfeacom.text:='';

        FGeral.GravaMestreNFCompra(EdDtEmissao.AsDate,EdDtEntrada.AsDate,xEd,tipocad,EdUnid_codigo.text,
               tipomovM,Transacao,EdFpgt_codigo.text,
               EdNatf_codigo.text,EdEmides.text,EdNumerodoc.asinteger,EdComv_codigo.asinteger,
               valornf,EdDigBicms.ascurrency,Eddigvicms.ascurrency,EdBasesubs.ascurrency,EdValorsubs.ascurrency,EdFrete.ascurrency,EdPeracre.AsCurrency,
               EdPerdesco.AsCurrency,EdDigtotpro.ascurrency,0,0,EdDtmovimento.asdate,Edmensagem.text,EdTipodoc.text,EdSerie.text,
               EdTotalservicos.ascurrency,EdFpgt_codigo.text,EdPedido.asinteger,Edvaloripi.ascurrency,EdSeguro.ascurrency,EdOutrasdespesas.ascurrency,
               EdTipo_codigoind.asinteger,EdPesoliq.ascurrency,EdNfprodutor.text,EdFunrural.ascurrency,EdCotacapital.ascurrency,EdPlan_conta.AsInteger,EdRomaneio.text,
               EdNroobra.text,EdMoes_Cola_codigo.text,EdMoes_km.asinteger,EdContaCredito.asinteger,AcBrNfe1,
               EdNUmerodi.text,EdDatadi.asdate,EdLocalDesembaraco.text,EdDtdesen.asdate,EdUfDesen.text,
               EdTran_codigo.text,EdSeto_codigo.text,Edchavenfeacom.text,FRateio.GridRateio,EdValorGTa.ascurrency,
               EdvlrINss.ascurrency,Edvlrpis.ascurrency,Edvlrcofins.ascurrency,Edvlrcsll.ascurrency,Edvlrir.ascurrency,EdVlriss.ascurrency,
               XMLCTE,EdPesoBru.AsCurrency,EdEspecievol.text,EdQTdevol.ascurrency,Edmoes_insumos.ascurrency,EdCodEqui.text );
/////////////// 09.09.09 - geracao nf reclassificacao
         fazernfrecla:=false;
         if (tipomovM=Global.CodCompraProdutor) and ( FGeral.getconfig1asinteger('ConfMovRecla')>0 )
            and ( FGeral.getconfig1asinteger('Clienfrecla')>0 ) and (Global.Topicos[1337])
            then begin
            if TodostemComposicao(Grid,Grid.GetColumn('move_esto_codigo')) then begin
              QConfMov:=sqltoquery('select * from confmov where comv_codigo='+inttostr(FGeral.getconfig1asinteger('ConfMovRecla')));
              if (OP='I') then begin
                if EdDtmovimento.asdate>1 then
                  Numerodoc:=( FGeral.GetContador('NFSAIDA'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false) )
                else
                  Numerodoc:=( FGeral.GetContador('SAIDA'+EdUnid_codigo.text+EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,false) );
              end;
              xEdREcla.SetValue(FGeral.getconfig1asinteger('Clienfrecla'));
              xEdRecla.ResultFind:=Sqltoquery('select * from clientes where clie_codigo='+xEdRecla.assql);
//              xEdREcla.SetValue(FGeral.GetConfig1AsFloat('Clienfrecla'));
              FGeral.GravaMestreNFCompra(EdDtEmissao.AsDate,EdDtEntrada.AsDate,xEdRecla,tipocad,EdUnid_codigo.text,
                 Global.CodCompraProdutorReclassifica,Transacao,EdFpgt_codigo.text,
                 QConfMov.fieldbyname('Comv_natf_estado').asstring,EdEmides.text,Numerodoc,FGeral.getconfig1asinteger('ConfMovRecla'),
                 valornf,EdDigBicms.ascurrency,Eddigvicms.ascurrency,EdBasesubs.ascurrency,EdValorsubs.ascurrency,EdFrete.ascurrency,EdPeracre.AsCurrency,
                 EdPerdesco.AsCurrency,EdDigtotpro.ascurrency,0,0,EdDtmovimento.asdate,Edmensagem.text,EdTipodoc.text,EdSerie.text,
                 EdTotalservicos.ascurrency,EdFpgt_codigo.text,EdPedido.asinteger,Edvaloripi.ascurrency,EdSeguro.ascurrency,EdOutrasdespesas.ascurrency,
                 EdTipo_codigoind.asinteger,EdPesoliq.ascurrency,EdNfprodutor.text,EdFunrural.ascurrency,EdCotacapital.ascurrency,EdPlan_conta.AsInteger,EdRomaneio.text,
                 EdNroobra.text);
              fazernfrecla:=true;
            end else
              Avisoerro('Aten��o.  Nota com produtos sem composi��o para Nota de Reclassifica��o');
//            end;
         end;
/////////////
// 26.03.07
        if EdDigBicms.ascurrency=EdBaseicms.ascurrency+EdValoripi.ascurrency then begin
          DigBicms:=EdDigBicms.ascurrency;
          digvicms:=Eddigvicms.ascurrency;
        end else begin
          DigBicms:=0;
          digvicms:=0;
        end;
// 19.09.07
       if EdDtmovimento.asdate<1 then
         Montabase:='N';

        ListaCodigosiguais:=TList.Create;

        if ( EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring<>Global.CodConhecimento ) or
           ( EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring<>Global.CodEntradaSemItens )
           then begin

            FGeral.GravaItensNFCompra(EdDtEmissao.AsDate,EdDtEntrada.AsDate,EdFornec,EdUnid_codigo.text,
                  tipomovM,Transacao,EdNumerodoc.asinteger,Grid,EdFRete.ascurrency,EdSEguro.ascurrency,EdPeracre.AsCurrency,EdPerdesco.ascurrency,0,EdDtmovimento.asdate,
                  EdPedido.asinteger,Montabase,EdTipo_codigoind.asinteger,EdDigBicms.ascurrency,Eddigvicms.ascurrency,EdNatf_codigo.text,
                  EdComv_codigo.asinteger,tipocad,EdNroobra.text,EdDigtotpro.ascurrency,tiposmuda,EdArquivoxml.text,EdValorsubs.ascurrency,
                  EdCodEqui.text,ListaCodigosiguais);
// 09.09.09
          if (fazernfrecla) and (Global.Topicos[1337]) then begin

             Listaentrada:=TList.create;
             GeraListaEntrada(Grid,Grid.GetColumn('move_esto_codigo'));
             GravaListaEntrada;
             if EdDtmovimento.asdate>1 then
                FGeral.GravaMovbase(Transacao,Numerodoc,cstrecla,'I',EdDigBicms.ascurrency,0,0,0,0,0,Global.CodCompraProdutorReclassifica,'I',EdUnid_codigo.text,EdNatf_codigo.text);
             Listaentrada.Free;

          end;
////////////
        end else begin

          if EdDtmovimento.asdate>1 then
            FGeral.GravaMovbase(Transacao,EdNumerodoc.asinteger,'000','I',EdDigbicms.ascurrency,Eddigvicms.ascurrency,EDPericmsnota.ascurrency,0,0,0,TipomovM,'I',EdUnid_codigo.text,EdNatf_codigo.text);

        end;

// 22.07.20 - Novicarnes - apropriacao de despesas...
       if ( Edvezesap.asinteger > 0 ) then begin

             GravaApropriacao;

       end;

/////////////////////////////////////////
// - 09.05.06

/////////////////////////////////////////
// 27.03.06 - grava��o ref. servicos - dados fiscais - DI
///////////////////////////////////////////////////
{
        if (EdTotalservicos.ascurrency>0) and (EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodDevolucaoInd) then begin
          FGeral.GravaMestreNFCompra(EdDtEmissao.AsDate,EdDtEntrada.AsDate,xEd,tipocad,EdUnid_codigo.text,
               EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Transacao+'9',EdFpgt_codigo.text,
               if_s(EdUnid_codigo.text=Global.CodigoUnidade,'1124','2124'),EdEmides.text,EdNumerodoc.asinteger,EdComv_codigo.asinteger,
               EdTotalServicos.AsCurrency,0,0,0,0,EdFrete.ascurrency,EdPeracre.AsCurrency,
               EdPerdesco.AsCurrency,0,0,0,EdDtmovimento.asdate,Edmensagem.text,EdTipodoc.text,EdSerie.text,0,EdFpgt_codigo.text,EdPedido.asinteger,
               Edvaloripi.ascurrency,EdSeguro.ascurrency,EdOutrasdespesas.ascurrency,EdTipo_codigoind.asinteger);
          if EdDtmovimento.asdate>1 then
            FGeral.GravaMovbase(Transacao+'9',EdNumerodoc.asinteger,'000','S',EdTotalServicos.ascurrency,0,0,0,0,0,EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring);
          if EdDtmovimento.asdate>1 then
              FGeral.GravaPendencia(EdDtemissao.asdate,EdDtentrada.asdate,xEd,tipocad,0,EdUNid_codigo.text,
                   EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Transacao+'9',EdFpgt_codigo.text,
                   'P',EdNumerodoc.asinteger,EdComv_codigo.asinteger,EdTotalServicos.ascurrency,0,'N',0,0,GridParcelas,'',EdPort_codigo.text)
          else
              FGeral.GravaPendencia(EdDtemissao.asdate,EdDtmovimento.asdate,xEd,tipocad,0,EdUNid_codigo.text,
                   EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Transacao+'9',EdFpgt_codigo.text,
                   'P',EdNumerodoc.asinteger,EdComv_codigo.asinteger,EdTotalServicos.ascurrency,0,'N',0,0,GridParcelas2,'',EdPOrt_codigo.text);
// 16.05.06
         if ( pos( strzero(EdFornec.asinteger,7),FGEral.Getconfig1asstring('fornfinanceiro') )>0 ) then begin
              FGeral.GravaPendencia(EdDtemissao.asdate,EdDtmovimento.asdate,xEd,tipocad,0,EdUNid_codigo.text,
                   EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Transacao,EdFpgt_codigo.text,
                   'P',EdNumerodoc.asinteger,EdComv_codigo.asinteger,EdValorTotal.ascurrency,0,'N',0,0,GridParcelas2,'',EdPOrt_codigo.text);
         end;

        end;
        }
//////////////////////////////////////////////

        pr:='P';     // 21.08.08 - carli
//        if pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodEntradaImobilizado)>0 then
//          pr:='R';
// 12.09.08 - entendi errado a fran...gera contas a pagar pro cliente...
        if ( pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.TiposGeraFinanceiro)>0 ) and
           ( OP<>'F' )  // 15.06.11
          then begin

          if (pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Devolucao)=0) then begin
// 19.05.06
            if EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.codretornocomservicos then begin

                FGeral.GravaPendencia(EdDtemissao.asdate,EdDtentrada.asdate,xEd,tipocad,0,EdUNid_codigo.text,
                     tipomovM,Transacao,EdFpgt_codigo.text,
                     pr,EdNumerodoc.asinteger,EdComv_codigo.asinteger,EdDigTotalnf.ascurrency,0,'N',0,EdPlan_conta.asinteger,GridParcelas,'',EdPort_codigo.text);
                FGeral.GravaPendencia(EdDtemissao.asdate,0,xEd,tipocad,0,EdUNid_codigo.text,
                     tipomovM,Transacao,EdFpgt_codigo.text,
                     pr,EdNumerodoc.asinteger,EdComv_codigo.asinteger,EdDigTotalnf.ascurrency,0,'N',0,EdPlan_conta.asinteger,GridParcelas2,'',EdPOrt_codigo.text);

            end else begin

              if EdDtmovimento.asdate>1 then begin
  // 17.05.06  - sempre envia os dois grids para gerar 1 ou 2  OU 1 e 2
  // 19.05.06  - dai fura as compras dobrando o tipo 2
                FGeral.GravaPendencia(EdDtemissao.asdate,EdDtentrada.asdate,xEd,tipocad,0,EdUNid_codigo.text,
                     tipomovM,Transacao,EdFpgt_codigo.text,
                     pr,EdNumerodoc.asinteger,EdComv_codigo.asinteger,EdDigTotalnf.ascurrency,0,'N',0,
                     EdPlan_conta.asinteger,GridParcelas,'',EdPort_codigo.text,'',EdSeto_codigo.text);
// 05.05.19 - Novicarnes - Gera contas a receber pra controlar o vencimento
                if EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodCedulaProdutoRural then

                  FGeral.GravaPendencia(EdDtemissao.asdate,EdDtentrada.asdate,xEd,tipocad,0,EdUNid_codigo.text,
                     tipomovM,Transacao,EdFpgt_codigo.text,
                     'R',EdNumerodoc.asinteger,EdComv_codigo.asinteger,EdDigTotalnf.ascurrency,0,'N',0,
                     EdPlan_conta.asinteger,GridParcelas,'',EdPort_codigo.text,'',EdSeto_codigo.text);


              end else

                FGeral.GravaPendencia(EdDtemissao.asdate,0,xEd,tipocad,0,EdUNid_codigo.text,
                     tipomovM,Transacao,EdFpgt_codigo.text,
                     pr,EdNumerodoc.asinteger,EdComv_codigo.asinteger,EdDigTotalnf.ascurrency,0,'N',0,
                     EdPlan_conta.asinteger,GridParcelas,'',EdPOrt_codigo.text,'',EdSeto_codigo.text);
            end;

          end else begin

//            FGeral.GravaPendencia(EdDtemissao.asdate,EdDtMovimento.asdate,xEd,tipocad,0,EdUNid_codigo.text,
//                   tipomovM,Transacao,EdFpgt_codigo.text,
//                   'P',EdNumerodoc.asinteger,EdComv_codigo.asinteger,EdDigTotalnf.ascurrency,0,'N',0,0,GridParcelas);
            if EdDtMovimento.Asdate>1 then
// 03.03.05 - gravava no caixa devolucoes de venda com valor zero
              FGeral.GravaPendencia(EdDtemissao.asdate,EdDtMovimento.asdate,xEd,tipocad,0,EdUNid_codigo.text,
                   tipomovM,Transacao,EdFpgt_codigo.text,
                   pr,EdNumerodoc.asinteger,EdComv_codigo.asinteger,EdTotalnota.ascurrency,0,'N',0,EdPlan_conta.asinteger,GridParcelas,'',EdPort_codigo.text)
            else  // 04.07.06
              FGeral.GravaPendencia(EdDtemissao.asdate,EdDtMovimento.asdate,xEd,tipocad,0,EdUNid_codigo.text,
                   tipomovM,Transacao,EdFpgt_codigo.text,
                   pr,EdNumerodoc.asinteger,EdComv_codigo.asinteger,EdTotalnota.ascurrency,0,'N',0,EdPlan_conta.asinteger,GridParcelas2,'',EdPort_codigo.text)
          end;
        end;
////////////////////// - 26.03.08
        if (transacoescompra<>'') and (OP='I') and
           (EdDtmovimento.asdate>1) and
           (Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodDevolucaoInd) then begin

          Sistema.Edit('Movesto');
          Sistema.SetField('moes_status','D');
          Sistema.SetField('moes_remessas',transacao);
          Sistema.Post( FGeral.getin('moes_tipomov',Global.CodCompraIndustria+';'+Global.CodRemessaInd,'C')+
//                       ' and '+FGeral.getin('moes_transacao',Transacoescompra,'C')+
                       ' and '+FGeral.getin('moes_transacao',EdNotasCompra.text,'C')+
//                       ' and moes_tipo_codigo='+EdFornec.Assql+' and moes_status=''N'''+
                       ' and moes_status=''N'''+
                       ' and moes_unid_codigo='+EdUnid_codigo.assql );
        end;
///////////////////
////////////////////// - 26.03.08
        if (transacoescompra<>'') and (OP='I') and
           (EdDtmovimento.asdate>1) and
           (Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodRetornocomServicos) then begin

          Sistema.Edit('Movesto');
          Sistema.SetField('moes_status','E');
          Sistema.SetField('moes_remessas',transacao);
          Sistema.Post( FGeral.getin('moes_tipomov',Global.CodCompraIndustria+';'+Global.CodRemessaInd,'C')+
//                       ' and '+FGeral.getin('moes_transacao',Transacoescompra,'C')+
                       ' and '+FGeral.getin('moes_transacao',EdNotasCompra.text,'C')+
//                       ' and moes_tipo_codigo='+EdFornec.Assql+' and moes_status=''N'''+
                       ' and moes_status=''D'''+
                       ' and moes_unid_codigo='+EdUnid_codigo.assql );
        end;
///////////////////
////////////////////// - 31.10.11    - RS X RD
        if (transacoescompra<>'') and (OP='I') and
           (EdDtmovimento.asdate>1) and
           (Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodRetornoRemessaConserto) then begin

          Sistema.Edit('Movesto');
          Sistema.SetField('moes_status','D');
          Sistema.SetField('moes_remessas',transacao);
          Sistema.Post( FGeral.getin('moes_tipomov',Global.CodRemessaConserto,'C')+
                       ' and '+FGeral.getin('moes_transacao',EdNotasCompra.text,'C')+
                       ' and moes_status=''N'''+
                       ' and moes_unid_codigo='+EdUnid_codigo.assql );
        end;
///////////////////
        if (Edtotal.ascurrency<>EdTotalNota.ascurrency) and (pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Devolucao+Transferencia+Especiais)=0)
           and (EdValortotal.ascurrency>0) and (EdDtmovimento.asdate>1) and (OP<>'F')
          then begin

          Sistema.commit;

          Transacao:=FGeral.GetTransacao;

          if pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.TiposGeraFinanceiro)>0 then
             FGeral.GravaPendencia(EdDtemissao.asdate,EdDtentrada.asdate,xEd,tipocad,0,EdUNid_codigo.text,
                   tipomovN,Transacao,EdFpgt_codigo.text,                                                                                       // 09.11.05
                   'P',EdNumerodoc.asinteger,EdComv_codigo.asinteger,EdDigTotalnf.ascurrency,0,'N',EdValorTotal.ascurrency-EdDigtotalnf.ascurrency,EdPlan_conta.asinteger,GridParcelas2,'',EdPort_codigo.text);
          FGeral.GravaMestreNFCompra(EdDtEmissao.AsDate,EdDtEntrada.AsDate,xEd,tipocad,EdUnid_codigo.text,
               tipodetalhe,Transacao,EdFpgt_codigo.text,
               EdNatf_codigo.text,EdEmides.text,EdNumerodoc.asinteger,EdComv_codigo.asinteger,
               EdDigTotalNf.AsCurrency,EdDigBicms.ascurrency,EdDigVicms.ascurrency,EdBasesubs.ascurrency,EdValorsubs.ascurrency,EdFrete.ascurrency,EdPeracre.AsCurrency,Edperdesco.AsCurrency,0,EdTotal.ascurrency,EdValortotal.ascurrency,0,
               EdMensagem.text,tipomovm,EdSerie.text,0,EdFpgt_codigo.text,EdPedido.asinteger,0,0,0,EdTipo_codigoind.asinteger,EdPesoliq.ascurrency,Ednfprodutor.text,
               EdFunrural.ascurrency,EdCotacapital.ascurrency,EdPlan_conta.asinteger,EdRomaneio.text,EdNroobra.text,EdMoes_Cola_codigo.text,EdMoes_km.asinteger);

          if (tipodetalhe<>Global.CodConhecimento) and (tipodetalhe<>Global.CodEntradaSemItens) then
            FGeral.GravaItensNFCompra(EdDtEmissao.AsDate,EdDtEntrada.AsDate,EdFornec,EdUnid_codigo.text,
                 tipodetalhe,Transacao,EdNumerodoc.asinteger,Grid,EdFRete.ascurrency,EdSEguro.ascurrency,EdPeracre.AsCurrency,EdPerdesco.AsCurrency,
                 Edtotal.ascurrency,0,EdPedido.asinteger,'N',EdTipo_codigoind.asinteger,EdDigBicms.ascurrency,Eddigvicms.ascurrency,'',Edcomv_codigo.asinteger,tipocad,EdNroobra.text,EdDigtotpro.ascurrency,tiposmuda)
        end;

// 04.04.19
          if EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring = Global.CodCedulaProdutoRural then

             FGeral.GravaMovfin(transacao,EdUnid_codigo.Text,'E','CPR '+SetEdFORN_NOME.Text,
                     EdDtemissao.AsDate,EdDtMovimento.AsDate,EdDtemissao.AsDate,
                     EdNumerodoc.AsInteger,0,0,EdPlan_conta.AsInteger,EdDigtotalnf.AsCurrency,
                     0,EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,
                     0,EdFornec.AsInteger,'C');


///////////////////////////////////////

        try
          Sistema.EndTransaction('');
// 10.08.17
          if (AnsiPos( Uppercase(EdTipoDoc.Text),'CTE;CPR')=0 ) and ( EdDigtotpro.AsCurrency>0 )
            then begin
            if Global.Usuario.codigo=100 then begin
              if confirma('Fazer o manifesto ? ') then
                ManifestaNota;

            end else if (Not EdDtMovimento.IsEmpty) and
                        ( Ansipos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodEntradaSemItens)=0 )
                        and
                        ( not Global.Topicos[1484])
                then
                   ManifestaNota;  // 22.06.17

          end;

        except
        end;

// 22.10.19 - Simar - quando tem o mesmo codigo de produto varias vezes na nota devido a
//            varios tamanhos ou cores ou medidas e tu tem q ficar dando entrada no mesmo codigo
// a ultima entrada do mesmo codigo vai pela 'via normal' e os demais por aqui...
        if ListaCodigosiguais.count >0 then begin

           for x := 0 to ListaCodigosiguais.count-1 do begin

               PCodigosIguais:=Listacodigosiguais[x];
               if Pcodigosiguais.qtde > PCodigosiguais.qtdeultima then begin

                  TEstoqueqtde:=sqltoquery('select * from estoqueqtde where esqt_status=''N'''+
                               ' and esqt_unid_codigo='+EdUNid_codigo.AsSql+
                               ' and esqt_esto_codigo='+stringtosql(PCodigosIguais.codigo) );

                  Sistema.Edit('estoqueqtde');
                  Sistema.setfield('esqt_qtde',TEstoqueQtde.fieldbyname('esqt_qtde').ascurrency + PCodigosIguais.qtde-PCodigosIguais.qtdeultima);
                  Sistema.setfield('esqt_qtdeprev',TEstoqueQtde.fieldbyname('esqt_qtdeprev').ascurrency +  + PCodigosIguais.qtde-PCodigosIguais.qtdeultima);
                  Sistema.Post(' esqt_esto_codigo = '+Stringtosql(PCodigosIguais.codigo)+
                               ' and esqt_unid_codigo = '+EdUNid_codigo.AsSql+
                               ' and esqt_status = ''N''');
                  Sistema.Commit;
                  FGeral.Fechaquery(TEstoqueqtde);

               end;

           end;

        end;
        Listacodigosiguais.Free;

// 22.07.05
        if ListaCustos<>nil then begin

// 26.06.15 - Vivan - gravacao de qtde quando tem cor e tamanho ( grade )
///////////////////////////////////////
{
          ListaCustosT:=TList.create;
          ListaCodigos:=TStringList.create;
          for x:=1 to Grid.rowcount do begin
            if ( trim( Grid.cells[Grid.getcolumn('move_esto_codigo'),x] )<>'' )
               and ( trim ( Grid.cells[Grid.getcolumn('move_core_codigo'),x] )<>'' )
               and ( trim ( Grid.cells[Grid.getcolumn('move_tama_codigo'),x] )<>'' ) then begin
               if ListaCodigos.indexof( Grid.cells[Grid.getcolumn('move_esto_codigo'),x] )=-1 then begin
                   New(PCustosT);
                   PCustosT.produto:=Grid.cells[Grid.getcolumn('move_esto_codigo'),x];
                   PCustosT.qtde:=TexttoValor(Grid.cells[Grid.getcolumn('move_qtde'),x]);
                   PCustosT.qtdeprev:=TexttoValor(Grid.cells[Grid.getcolumn('move_qtde'),x]);
                   ListaCustosT.add(PCustosT);
                   Listacodigos.add(Grid.cells[Grid.getcolumn('move_esto_codigo'),x]);
               end else begin
                 for y:=0 to ListaCustosT.count-1 do begin
                   PCustosT:=ListaCustosT[y];
                   if (PCustosT.produto=Grid.cells[Grid.getcolumn('move_esto_codigo'),x]) then begin
                     PCustosT.qtde:=PCustosT.qtde+PCustos.qtde;
                     PCustosT.qtdeprev:=PCustosT.qtdeprev+PCustos.qtdeprev;
                   end;
                 end;
               end;
            end;
          end;

          for x:=0 to ListacustosT.count-1 do begin
            PCustosT:=ListaCustosT[x];
            for y:=0 to ListaCustos.count-1 do begin
              PCustos:=ListaCustos[y];
              if PCustos.produto=Pcustost.produto then break;
            end;
            Sistema.edit('estoqueqtde');
            Sistema.setfield('esqt_qtde',PCustos.aqtde+PCustost.qtde);
            Sistema.setfield('esqt_qtdeprev',PCustos.aqtdeprev+PCustost.qtdeprev);
            Sistema.post('esqt_esto_codigo='+stringtosql(PCustosT.produto)+
                         ' and esqt_status=''N'' and esqt_unid_codigo='+stringtosql(EdUnid_codigo.text) );
            Sistema.Commit;
          end;
          ListacustosT.free;
          }
////////////////////////////
          if (Listacustos.count>0) and (Listacustos.count<10000) then
             Freeandnil(ListaCustos);
        end;
// 08.10.15 - Metallum - atualiza OS e gera e da saida do estoque
//        if ( (Global.Topicos[1385]) ) and ( OP='I' ) then begin
// 23.09.16 - caso precisar alterar o esquecer de ter lan�ado em qual os...
        if ( (Global.Topicos[1385]) ) then begin
           GeraOs;
        end;
        if ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Devolucao)>0 )
// 06.06.20
           and
           (  Global.UsaNfe <> 'S' )
           then begin

           if confirma('Imprime devolu��o agora ?') then
              FImpressao.ImprimeNotaSaida(EdNumerodoc.asinteger,EdDtEmissao.AsDate,EdUnid_codigo.text,EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring);

        end else if ( Ansipos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodCompraProdutor+';'+Global.CodDrawBackEnt+';'+TiposNumeracaoSaida)>0 ) then begin
//           if confirma('Imprime agora ?') then begin
//                FImpressao.ImprimeNotaSaida(EdNumerodoc.asinteger,EdDtEmissao.AsDate,EdUnid_codigo.text,EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring );
//           end;
// 06.06.16                         // 04.08.16 - Vida nova - nf com data 'pra tras
           if (Global.UsaNfe='S') and (EdDtemissao.AsDate=Sistema.Hoje) then begin

              if Ansipos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodCompraProdutor+';'+Global.CodDrawBackEnt) > 0  then begin

                 if Confirma('Autorizar a NF-e ?') then

                   FExpNfetxt.Execute(EdNumerodoc.asinteger)

              end else

                 FExpNfetxt.Execute(EdNumerodoc.asinteger);

           end;

        end else if ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Transferencia)>0 )
           then begin

           if confirma('Imprime transfer�ncia agora ?') then
              FImpressao.ImprimeNotaTransf(EdNumerodoc.asinteger,EdDtEmissao.AsDate,EdUnid_codigo.text);

        end;

        EdComv_codigo.ClearAll(FNotaCompra,99);
//        EdDtmovimento.setdate(sistema.hoje);
// 05.11.09 - retirado em 17.01.12
//        FGeral.setamovimento(EdDtmovimento);
// 26.11.12 - Vivan
        if ( Global.Usuario.OutrosAcessos[0321] ) then
          FGeral.setamovimento(EdDtmovimento)
        else
          EdDtmovimento.setdate(sistema.hoje);

        EdDtEntrada.SetDate(Sistema.hoje);   // 03.07.08
        EdUnid_codigo.Text:=Global.CodigoUnidade;

        if ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Devolucao)>0 ) then
           EdDtEntrada.setdate(sistema.hoje);  // 04.05.06

        EdProduto.clearall(FNotaCompra,99);
        Grid.Clear;
        if Arq.TTransp.Active then Arq.TTransp.Close;
        GridParcelas.clear;
        Gridcodbarra.clear;
        if GridParcelas2.visible then
          GridParcelas2.Clear;
        EdPort_codigo.ClearAll(FNotaCompra,99);
        EdBaseicms.ClearAll(FNotaCompra,99);
// 05.02.10
        EdMoes_cola_codigo.ClearAll(FNotaCompra,99);
        PVeiculo.Visible:=false;
        PVeiculo.enabled:=false;

      end;
  end;

  if global.Topicos[1513] then begin

     Pcodbarra.Enabled := false;
     Pcodbarra.Visible := false;

  end;

  if OP='F' then  // 14.07.11 - novi - vava
    Execute('F')
// 24.06.19 - A2z
  else if ( global.topicos[1367] ) and ( not EdCodEqui.IsEmpty )
// 03.12.19 - A2z - Thais - para chamar ficha tecnica 'somente no tipo de entrada 2'..
       and ( EdComv_codigo.ResultFind.FieldByName('Comv_plan_conta').AsInteger >0 )
       and ( EdComv_codigo.ResultFind.FieldByName('Comv_tipomovto').AsString = Global.CodCompra ) then

     bfichatecnicaClick(self)

  else

    EdComv_codigo.setfocus;

end;

procedure TFNotaCompra.bExcluiritemClick(Sender: TObject);
/////////////////////////////////////////////////////////////
var p:integer;
    codigoproduto,tipomovx:string;
    Qtdeprev,Qtde,Pecas:currency;
begin
// excluir da listacustos e retornar as qtdes e custos ao estoque usando o testoqueqtde
  if trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),Grid.row])='' then exit;

  if confirma('Confirma exclus�o ?') then begin

    codigoproduto:=Grid.cells[Grid.getcolumn('move_esto_codigo'),grid.row];
//    Qtdeprev:=strtofloat(Grid.cells[grid.getcolumn('move_qtde'),grid.row]);
//    Qtde:=strtofloat(Grid.cells[grid.getcolumn('move_qtde'),grid.row]);
//    Pecas:=strtofloat(Grid.cells[grid.getcolumn('move_pecas'),grid.row]);
// 11.02.08
    Qtdeprev:=texttovalor(Grid.cells[grid.getcolumn('move_qtde'),grid.row]);
    Qtde:=texttovalor(Grid.cells[grid.getcolumn('move_qtde'),grid.row]);
    Pecas:=texttovalor(Grid.cells[grid.getcolumn('move_pecas'),grid.row]);
    QEstoque:=sqltoquery('select * from EstoqueQtde inner join estoque on (esto_codigo=esqt_esto_codigo)'+
                         ' where esqt_status=''N'' and esqt_esto_codigo='+stringtosql(codigoProduto)+
                         ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
    if trim(codigoproduto)<>'' then begin
      Grid.DeleteRow(Grid.Row);
      if (ListaCustos.count>0) and (Op='I') then begin
////////////////////////////////// - 07.11.09 - recolocado exclusao de listacustos
        for p:=0 to Listacustos.count-1 do begin
          PCustos:=ListaCustos[p];
          if (Pcustos.produto=codigoproduto) and (PCustos.codcor=texttovalor(Grid.cells[grid.getcolumn('move_core_codigo'),grid.row]) ) and
             (PCustos.codtamanho=texttovalor(Grid.cells[grid.getcolumn('move_tama_codigo'),grid.row]))
              then begin
{
              Sistema.Edit('estoqueqtde');
              Sistema.setfield('esqt_qtde',PCustos.aqtde);
              Sistema.setfield('esqt_qtdeprev',PCustos.aqtdeprev);
              Sistema.setfield('esqt_custo',PCustos.acusto);
              Sistema.setfield('esqt_custoger',PCustos.acustoger);
              Sistema.setfield('esqt_customedio',PCustos.acustomedio);
              Sistema.setfield('esqt_customeger',PCustos.acustomedioger);
              Sistema.setfield('esqt_dtultcompra',PCustos.adataultcompra);
              Sistema.Post('esqt_esto_codigo='+stringtosql(PCustos.produto)+' and esqt_unid_codigo='+EdUNid_codigo.Assql+
                       ' and esqt_status=''N'''  );
}
            ListaCustos.Delete(p);  // 18.10.04
            break;
          end;
///////////////////////////
//}
        end;
//        Sistema.commit;

      end;
//      if (OP='A') and (not QEstoque.eof) then begin   // retorna ao estoque  // 11.07.05
      if (not QEstoque.eof) then begin   // retorna ao estoque  // 11.07.05
// 19.08.05
        if ( pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,EntranoCusto ) = 0 )  OR
           ( pos(Op,'A;F')>0 )  then begin   // retorna ao estoque  // 28.10.09
           if EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=global.CodCompra then
             tipomovx:=Global.CodCompra100
           else
             tipomovx:=EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring;
           FGeral.MovimentaQtdeEstoque(Codigoproduto,EdUNid_codigo.text,'S',tipomovx,Qtde,QEstoque,Qtdeprev,Pecas);
           Sistema.commit;
        end;
        SetaEditsvalores;
      end;
    end;
  end;
end;

procedure TFNotaCompra.EdDigbicmsValidate(Sender: TObject);
begin
  if EdArquivoxml.isempty then begin    // 18.10.10
    EdDigvicms.Setvalue( FGeral.Arredonda(EdDigbicms.ascurrency*(EdPericmsnota.ascurrency/100),2) );
    if (OP='I') and ( Ansipos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoInd+';'+
                      Global.CodCompraProdutor+';'+Global.CodNfeComplementoIcmsECliente)=0) then
      EdDigtotpro.setvalue(EdDigbicms.ascurrency);
  end;
//  EdValorIpi.setvalue(  FGeral.Arredonda(EdDigbicms.ascurrency*(EdPeripi.ascurrency/100),2) );
// 28.08.04 - por enquanto n�o calcula
end;

procedure TFNotaCompra.EdDigtotproValidate(Sender: TObject);
begin
  if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring<>Global.CodConhecimento ) and
      ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring<>Global.CodEntradaSemItens )
      then begin
//    EdDigtotalnf.setvalue(EdDigtotpro.ascurrency+EdValoripi.ascurrency+EdFrete.AsCurrency+EdSeguro.Ascurrency)
// 20.06.05
    if Op='I' then begin
      if freteembutido then
        EdDigtotalnf.setvalue(EdDigtotpro.ascurrency+EdValoripi.ascurrency+EdFrete.ascurrency)
      else
        EdDigtotalnf.setvalue(EdDigtotpro.ascurrency+EdValoripi.ascurrency);
    end;
  end else if EdDigtotalnf.AsCurrency=0 then
    EdDigtotalnf.setvalue(EdDigtotpro.ascurrency);
end;

procedure TFNotaCompra.EdDtEntradaValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////
var datai,dataf:TDatetime;
begin
  datai:=texttodate( '01'+strzero(datetomes(sistema.hoje),2)+strzero(datetoano(sistema.hoje,true),4) );
  dataf:=DAtetoultimodiames(datai);
  if OP<>'A' then begin   // 13.01.06

    if EdDtentrada.Asdate<EdDtEmissao.asdate then
      EDDtEntrada.INvalid('Data de entrada deve ser maior que a data de emiss�o')

    else if not FGeral.ValidaDentroPeriodo(EdDtentrada.asdate,datai,dataf)  then begin
      if not Global.Usuario.OutrosAcessos[0310] then
        EDDtEntrada.INvalid('Data de entrada deve ser no mes/ano atual')
      else
        Aviso('Aten��o !  Data de entrada fora do mes/ano atual');

    end else if  (EdDtentrada.Asdate-EdDtEmissao.asdate>30) and (EdDtentrada.Asdate-EdDtEmissao.asdate<=60)then
      Avisoerro('Aten��o !  Data de entrada com mais de 30 dias ap�s emiss�o')

    else if  EdDtentrada.Asdate-EdDtEmissao.asdate>60 then
//      EDDtEntrada.INvalid('Data de entrada deve ser no m�ximo 60 dias ap�s emiss�o');
// 23.10.07 - algumas notas ainda chegam atrasadas...
      Avisoerro('Data de entrada deve ser no m�ximo 60 dias ap�s emiss�o');

  end;
// Patoterra - recolocado em 23.09.13
  if not FGeral.ValidaMvto(EdDtentrada) then
      EdDtentrada.Invalid('')
  else if (EdDtEntrada.asdate>Sistema.hoje) then
      EdDtentrada.Invalid('Data de entrada deve ser no m�ximo igual a data atual');

end;

procedure TFNotaCompra.EdDtemissaoValidate(Sender: TObject);
begin
//  if not FGeral.ValidaMvto(EdDtemissao) then begin
// 18.11.09 - Abra
//    if (Sistema.hoje-EdDtEmissao.asdate)>60 then
//      EdDtemissao.Invalid('Data de emiss�o deve ser no m�ximo 60 dias antes da data atual')
// 29.03.10 - Abra
//    if not FGeral.ValidaDataFiscal(EdDtEmissao) then

end;

procedure TFNotaCompra.bCancelaritemClick(Sender: TObject);
//////////////////////////////////////////////////////////////
var codmens1,codmens2:integer;
    mens:string;
begin
  if EdFornec.AsInteger=0 then exit;
  bGravar.Enabled:=true;
  PFinan.Enabled:=true;
//  bCancelar.Enabled:=true;
  bSair.Enabled:=true;
//  PINs.Visible:=false;
  PINs.DisableEdits;
//  AtivaEdits;
  PRemessa.Enabled:=true;
 //  EdComv_codigo.SetFocus;
  if pos(Op,'A;F')=0 then begin   // 19.10.05
// 22.08.16
    if not EdMensagem.isempty then mens:=EdMensagem.text;
//    EdPort_codigo.clearall(FNotaCompra,99);
// 16.04.2021 - retirado para n�o tirar descontos/acrescimos puxados do xml
    Edmensagem.text:=mens;
    
// 24.02.10
    if (EdPlan_conta.isempty) and (OP='I') then
      Edplan_conta.setvalue(EdComv_codigo.ResultFind.fieldbyname('comv_plan_conta').asinteger);
//
// 22.04.08
//    Edplan_conta.setvalue(EdComv_codigo.ResultFind.fieldbyname('comv_plan_conta').asinteger);
/////
    if EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDrawBackEnt then begin
      codmens1:=FGeral.GetConfig1AsInteger('Codmendrawe1') ;
      codmens2:=FGeral.GetConfig1AsInteger('Codmendrawe2') ;
      EdMens_codigo.setvalue( codmens1 );
      EdMensagem.text:=FMensNotas.GetDescricao(codmens1);
      EdMensagem.text:=EdMensagem.text+' '+FMensNotas.GetDescricao(codmens2);
    end;
  end;

  EdPort_codigo.setfocus;

end;

///////////////////////////////////////////////////////////////////////////
procedure TFNotaCompra.EdComv_codigoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////////////
var ContasGrupo3,ctransacoes,xchaveref:string;
    Lista:TStringList;
    TNota:TStringStream;
    QN:TSqlQuery;
    buf:string;
begin

// 15.10.19
  CfopdeCombustivel:=false;
  if EdComv_codigo.resultfind<>nil then begin

     if copy( EdComv_codigo.resultfind.fieldbyname('Comv_natf_estado').asstring,2,3 ) = '653' then

        CfopdeCombustivel:=true;


  end;
// 22.07.20
  EdVezesap.enabled := false;
  EdVezesap.setvalue(0);


// 20.04.10 - Abra - aqui tbem devido ao tipo CI que ira abrir o campo
  EdPlan_conta.Enabled:=not Global.Topicos[1341];
  NotaEstorno:='N';
  campoufentidade:='forn_uf';
  campocodigoentidade:='forn_codigo';
  EdTotalservicos.enabled:=false;
  EdTotalservicos.setvalue(0);
//  EdValorTotal.enabled:=Global.Usuario.OutrosAcessos[0010];
  EdValorTotal.enabled:=Global.Usuario.OutrosAcessos[0050];
  if Edcomv_codigo.ResultFind=nil then exit;  // 05.05.06

// 05.04.06 - gravava serie 5 e nao serie do codigo da conf. de movimento
  Arq.TConfMovimento.locate('comv_codigo',Edcomv_codigo.Text,[]);
///////////
  if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.TiposEntrada)=0 then begin
    EdComv_codigo.invalid('Movimento inv�lido para entradas');
    exit;
  end;
  if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodConhecimento )  then begin
//     ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodEntradaSemItens ) then begin
    EdConhecimento.enabled:=false;
    EdConhecimento.text:='';
    EdSeguro.enabled:=false;
    EdSeguro.text:='';
    EdFrete.enabled:=false;
    EdFrete.text:='';
    EdFornec.Empty:=false;
    EdPericmsfrete.enabled:=false;
    EdPericmsfrete.setvalue(0);
//    EdFornec.Empty:=true;
//    EdFornec.enabled:=false;
// 29.07.10 - Clessi - Conhecimento eletronico
    if trim( EdComv_codigo.ResultFind.FieldByName('Comv_especie').asstring )='' then begin
      EdTipodoc.text:='CTRC';
      EdSerie.text:='U';
    end else begin
      EdTipodoc.text:=EdComv_codigo.ResultFind.FieldByName('Comv_especie').asstring;
      EdSerie.text:=EdComv_codigo.ResultFind.FieldByName('Comv_serie').asstring;
    end;

  end else if pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoInd+';'+Global.CodRetornoInd)>0 then begin

//    EdTotalservicos.enabled:=true;
// 26.03.08 - inibido
    if pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoInd+';'+Global.CodRetornocomServicos)>0 then begin
      EdValortotal.enabled:=false;
      EdValortotal.setvalue(0);
    end;

// 22.10.10
  end else if pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodCompraSemfinan)>0 then begin

     if Global.Topicos[1347] then begin

       EdContaCredito.Enabled:=true;
       EdContaCredito.Visible:=true;

     end else begin

       EdContaCredito.Enabled:=false;
       EdContaCredito.text:='';
       EdContaCredito.Visible:=false;

     end;

// 31.07.12 - Estorno de Nfe de Saida nao cancelada no prazo legal ( 24  horas )
  end else if ( Ansipos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodEstornoNFeSai+
                ';'+Global.CodDevolucaoIgualVenda+';'+Global.CodNfeComplementoValorProdutor+';'+
                Global.CodDevolucaoRoman+';'+Global.CodNfeComplementoIcmsECliente+';'+
                Global.CodComplementoValorE+';'+Global.CodDevolucaoBonificacao)>0 )
           and
              ( OP='I' ) then begin

    Lista:=TStringList.create;
// 08.08.16
    Sistema.beginprocess('Pesquisando notas');
    if EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodNfeComplementoValorProdutor then

      GetListaNfe( Lista,'E' )

    else if AnsiPos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodNfeComplementoICMsECliente+';'+
            Global.CodComplementoValorE ) > 0
        then

      GetListaNfe( Lista,'E',EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring )

    else

      GetListaNfe( Lista,'S' );

    Sistema.endprocess('');
    ctransacoes:='';
    if (Lista.count>0) and (Lista[0]<>'') then begin
       ctransacoes:=SelecionaItems(Lista,'NFe Autorizadas','',false);
       strtolista(Lista,ctransacoes,'|',true);
    end;
    if ( copy(ctransacoes,1,11)<>'Transa��o |' ) and ( trim(ctransacoes)<>'' ) then begin

       if EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodNfeComplementoValorProdutor then

         QN:=sqltoquery('select moes_xmlnfet,moes_tipocad,moes_numerodoc,moes_dataemissao,moes_tipo_codigo,moes_tipomov,moes_natf_codigo from movesto where moes_transacao='+Stringtosql(trim(Lista[0]))+
                        ' and '+FGeral.getin('moes_tipomov',Global.Codcompraprodutor,'C') )
// 16.05.18
       else if EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoRoman then

         QN:=sqltoquery('select moes_xmlnfet,moes_tipocad,moes_numerodoc,moes_dataemissao,moes_tipo_codigo,moes_tipomov,moes_natf_codigo from movesto where moes_transacao='+Stringtosql(trim(Lista[0]))+
                        ' and '+FGeral.getin('moes_tipomov',Global.CodConsigMercantil,'C') )
       else
//         QN:=sqltoquery('select moes_xmlnfet,moes_tipocad,moes_numerodoc,moes_dataemissao,moes_tipo_codigo,moes_tipomov,moes_natf_codigo from movesto where moes_transacao='+Stringtosql(trim(Lista[0]))+
//                        ' and '+FGeral.getin('moes_tipomov',Global.TiposRelVenda,'C') );
// 19.03.19
         QN:=sqltoquery('select moes_xmlnfet,moes_tipocad,moes_numerodoc,moes_dataemissao,moes_tipo_codigo,moes_tipomov,moes_natf_codigo from movesto where moes_transacao='+Stringtosql(trim(Lista[0]))+
                        ' and '+FGeral.getin('moes_status','N','C') );
       if not QN.eof then begin

         Acbrnfe1.NotasFiscais.Clear;
         buf:=QN.fieldbyname('moes_xmlnfet').asstring;
         TNota:=TStringStream.Create( buf );
  //       TNota.Read( buf,length(QN.fieldbyname('moes_xmlnfet').asstring) );
         Acbrnfe1.NotasFiscais.LoadFromStream( TNota );
//         Aviso( inttostr(ACbrnfe1.NotasFiscais.count) );
//         Aviso( ACbrnfe1.NotasFiscais.Items[0].NFe.Ide.natOp );
// 20.05.15
         if ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodEstornoNFeSai)>0 ) then
//           Acbrnfe1.NotasFiscais.Items[0].Alertas:='EstornoNFe';
// 31.12.15 - devido ao trunk2 do acbr
//           Acbrnfe1.NotasFiscais.Items[0].DisplayName:='EstornoNFe';
// 02.06.16
            NotaEstorno:='EstornoNFe';
// 10.12.13 para identificar o destinatario
//         Acbrnfe1.NotasFiscais.Items[0].Msg:=QN.fieldbyname('moes_tipocad').asstring;
// 31.12.15
         Acbrnfe1.NotasFiscais.Items[0].NomeArq:=QN.fieldbyname('moes_tipocad').asstring;
///////////////////////////
         Edmens_codigo.text:='';
         if Ansipos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoIgualVenda+';'+Global.codDevolucaoBonificacao)>0 then begin

            Edmensagem.text:='Devolu��o da NF '+QN.fieldbyname('moes_numerodoc').AsString+' de '+FGeral.formatadata(QN.fieldbyname('moes_dataemissao').Asdatetime)
// 16.05.18
         end else if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoRoman)>0 then begin
            Edmensagem.text:='Retorno da NF '+QN.fieldbyname('moes_numerodoc').AsString+' de '+FGeral.formatadata(QN.fieldbyname('moes_dataemissao').Asdatetime)

         end else if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodNfeComplementoValorProdutor)>0 then begin
            Edmensagem.text:='Complemento de valor da NF '+QN.fieldbyname('moes_numerodoc').AsString+' de '+FGeral.formatadata(QN.fieldbyname('moes_dataemissao').Asdatetime);
// 18.03.19
         end else if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodNfeComplementoIcmsECliente)>0 then begin
            Edmensagem.text:='Complemento de icms da NF '+QN.fieldbyname('moes_numerodoc').AsString+' de '+FGeral.formatadata(QN.fieldbyname('moes_dataemissao').Asdatetime);
// 19.03.19
         end else if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodComplementoValorE)>0 then begin
            Edmensagem.text:='Complemento de valor da NF '+QN.fieldbyname('moes_numerodoc').AsString+' de '+FGeral.formatadata(QN.fieldbyname('moes_dataemissao').Asdatetime);
    // 08.08.16
           EdNatf_codigo.text:=QN.fieldbyname('moes_natf_codigo').AsString;
         end;

           FGeral.SetaEdEntidade(EdFornec,'C');

           if Ansipos( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodComplementoValorE) > 0
//               Global.CodEstornoNFeSai )>0
// retirado em 23.11.20
                then begin

              campoufentidade    :='forn_uf';
              campocodigoentidade:='forn_codigo';

           end else begin

             campoufentidade:='clie_uf';
             campocodigoentidade:='clie_codigo';

           end;

           EdFornec.text:=QN.fieldbyname('moes_tipo_codigo').AsString;
           EdFornec.validfind;
           EdFornec.valid;
           EdUnid_codigo.validfind;
           Edchavenfeacom.text:= copy( QN.fieldbyname('moes_xmlnfet').AsString, pos('Id="NFe',QN.fieldbyname('moes_xmlnfet').AsString)+7,44 );
           if Edchavenfeacom.IsEmpty then begin
             Input('Infome chave da NFe a ser devolvida','Chave',xchaveref,44,false);
             EdChavenfeacom.text:=xchaveref;
           end;
           if length(Edchavenfeacom.text)<>44 then Avisoerro('Chave com tamanho diferente de 44');
           if ( pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoIgualVenda+
                      ';'+Global.CodDevolucaoRoman+';'+Global.CodDevolucaoBonificacao )>0 )
//                    Global.CodNfeComplementoValorProdutor)>0 )
              then begin
              QBusca:=sqltoquery(FGeral.buscanf(QN.fieldbyname('moes_numerodoc').AsInteger,QN.fieldbyname('moes_tipomov').asstring,
                                 QN.fieldbyname('moes_dataemissao').Asdatetime,EdUnid_codigo.text,EdFornec.asinteger));
              Campostogrid(QBusca,QBusca);
           end;
           FGeral.FechaQuery(QN);
////////////////////////////
//         EdArquivoxml.Next;
       end else begin

         Avisoerro('Transa��o '+trim(Lista[0])+'| n�o encontrada');
         EdArquivoxml.text:='N�o encontrado';

       end;

    end;
// 19.03.19
    if ( Lista.count=0 )  and ( Edchavenfeacom.IsEmpty ) then begin

           Input('Infome chave da NFe a ser devolvida/complementada','Chave',xchaveref,44,false);
           EdChavenfeacom.text:=xchaveref;
           if length(Edchavenfeacom.text)<>44 then Avisoerro('Chave com tamanho diferente de 44');

    end;

  end else begin

    EdConhecimento.enabled:=true;
//    EdSeguro.enabled:=true;
/////////////////
    EdFornec.Empty:=false;
    EdFornec.enabled:=true;
    EdFrete.enabled:=true;
    EdPericmsfrete.enabled:=true;
// 30.01.12
    if trim(EdComv_codigo.resultfind.fieldbyname('Comv_especie').asstring)='' then
      EdTipodoc.text:='NF'
    else
      EdTipodoc.text:=EdComv_codigo.resultfind.fieldbyname('Comv_especie').asstring;
//    EdSerie.text:='';   // 03.07.08 - elize novicarnes
  end;
//  if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoSerie5 ) or
//     ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoVenda ) then begin
// 21.02.05
  tiposmuda:=Global.CodDevolucaoSerie5+';'+Global.CodDevolucaoVenda+';'+Global.CodDevolucaoConsigMerc+';'+Global.CodRetornoConsigMercanil+';'+
             Global.CodRetornoMostruario+';'+Global.CodDevolucaoRoman+';'+Global.CodDevolucaoIgualVenda+';'+
             Global.CodDevolucaoVendaConsig+';'+Global.CodCompraProdutor+';'+Global.CodDrawBackEnt+';'+Global.CodEntradaImobilizado+';'+
             Global.CodDevolucaoImob+';'+Global.CodDevolucaoSemFinan+';'+Global.CodDevolucaodeRemessa+';'+Global.CodEntradaProdutor+
             ';'+Global.CodCompraProdutorMerenda+';'+Global.CodNfeComplementoValorProdutor+';'+
             Global.CodNfeComplementoIcmsECliente+';'+Global.CodCedulaProdutoRural+';'+
             Global.CodDevolucaoBonificacao+';'+Global.CodEntradaNFPe;
// 30.04.05 - colocado conf. movimento dev. romaneio (DA) retorno do represent. pois ainda pedia fornec. e nao cliente
  if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,tiposmuda) >0 then begin

    FGeral.SetaEdEntidade(EdFornec,'C');
    campoufentidade:='clie_uf';
    campocodigoentidade:='clie_codigo';
    if trim(FGeral.Getconfig1asstring('Fpgtoavista'))='' then
      EdComv_codigo.invalid('Falta configurar a forma de pagamento a vista nas configura��es')
    else
      EdFpgt_codigo.text:=FGeral.Getconfig1asstring('Fpgtoavista');
//  end else if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodConhecimento) >0 then begin
//    FGeral.SetaEdEntidade(EdFornec,'C');
//    campoufentidade:='tran_ufplaca';
// 06.10.05
    Edtipodoc.text:=EdComv_codigo.ResultFind.fieldbyname('comv_especie').asstring;
    EdSerie.text:=EdComv_codigo.ResultFind.fieldbyname('comv_serie').asstring;
// 04.05.07 - 21.06.07
    if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoVenda+';'+Global.CodRetornoMostruario) >0 then
      EdNumerodoc.enabled:=true
    else
      EdNumerodoc.enabled:=Global.Topicos[1301];
// 20.06.07
    EdDtemissao.setdate(sistema.hoje);

  end else

    FGeral.SetaEdEntidade(EdFornec,'F');

  EdNfprodutor.enabled:=false;

  EdRomaneio.Enabled:=false;
  EdValidadeform.Enabled:=false;
  ZeraGridServicos;
  EdPlan_conta.ShowForm:='FPlano';
//  EdPlan_conta.Empty:=true;
// 14.02.09
  EdPlan_conta.Empty:=not Global.Topicos[1328];

// 23.10.08
//  if (EdPlan_conta.isempty) and (OP='I') then
// 07.05.10 - pra ver se para de ficar com a conta errada...
  if (OP='I') then
    Edplan_conta.setvalue(EdComv_codigo.ResultFind.fieldbyname('comv_plan_conta').asinteger);

// 20.11.18 - Seip
  EdPesoBru.enabled:=( copy(EdComv_codigo.ResultFind.fieldbyname('comv_natf_foestado').asstring,1,1)='3');

  if OP='I' then begin

    EdOutrasdespesas.enabled:=EdComv_codigo.ResultFind.fieldbyname('comv_natf_foestado').asstring='3102';  // 22.06.06
    if ( (pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Devolucao ) > 0 )
       and ( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring<>Global.CodDevolucaoConsigMerc ) )
//       and ( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring<>Global.CodDevolucaoIgualVenda ) )
       or ( EdComv_codigo.ResultFind.fieldbyname('comv_natf_foestado').asstring='3102' )    // 21.06.06
       then begin
// 21.06.07
//      if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoVenda+';'+Global.CodRetornoMostruario) >0 then
// 19.11.12 - vivan
//      if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodRetornoMostruario) >0 then
// 05.02.13 - Novicarnes...usa DV informando numero...vivan ter� q usar DX...
      if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoVenda+';'+Global.CodRetornoMostruario) >0 then
        EdNumerodoc.enabled:=true
      else
        EdNumerodoc.enabled:=Global.Topicos[1301];
//
       EdDtemissao.enabled:=Global.Usuario.OutrosAcessos[0702];;
       EdDtemissao.setdate(sistema.hoje);
       EdDtmovimento.enabled:=true;
  //     EdDtmovimento.text:='';
//       EdDtmovimento.setdate(sistema.hoje);
       if ( Global.Usuario.OutrosAcessos[0321] ) then
         FGeral.setamovimento(EdDtmovimento)
       else
         EdDtmovimento.setdate(sistema.hoje);

// 03.05.07
    end else if ( pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.CodCompraProdutor+';'+Global.CodEntradaProdutor)>0 ) then begin

      EdNfprodutor.enabled:=true;
      EdNumerodoc.enabled:=Global.Topicos[1301];
// 06.03.08
      EdValidadeform.Enabled:=true;
// 18.05.14 - Novicarnes
      if ( pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.CodEntradaProdutor)>0 ) then begin
        EdNumerodoc.enabled:=true;
        EdNfprodutor.enabled:=false;
        EdValidadeform.Enabled:=false;
      end;
// 26.06.07
      EdDtemissao.enabled:=Global.Usuario.OutrosAcessos[0702];
      EdDtemissao.setdate(sistema.hoje);
// 17.09.07
      EdRomaneio.Enabled:=Global.Topicos[1305];
// 11.07.08 - Elize  - Novicarnes
      if trim(FGeral.getconfig1asstring('Contasnfprodutor'))<>'' then begin
         EdPlan_conta.ShowForm:='';
         EdPlan_conta.Empty:=false;
         FPlano.SetaItems(EdPlan_conta,EdPlan_descricao,FGeral.getconfig1asstring('Contasnfprodutor'))
      end;
// 13.12.11
      Freteembutido:=false;
// 16.05.2022 - Clessi
//    if ( Lista.count=0 )  and ( Edchavenfeacom.IsEmpty ) then begin

           Input('Infome chave da NFe a ser devolvida/complementada','Chave',xchaveref,44,false);
           EdChavenfeacom.text:=xchaveref;
           if length(Edchavenfeacom.text)<>44 then Avisoerro('Chave com tamanho diferente de 44');

//    end;
    end else begin
       EdNumerodoc.enabled:=true;
       EdDtemissao.enabled:=true;
// 21.08.08
       if pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,TiposNumeracaoSaida)>0 then begin
         EdNumerodoc.enabled:=false;
       end;
//////////////////////////
//       EdDtmovimento.enabled:=false;
//  19.10.05 - para pode indicar compra 100% tipo 2
       EdDtmovimento.enabled:=true;
       EdDtmovimento.setdate(sistema.hoje); // para ser feito 1 e 2 na 'forma de compras'
//       FGeral.setamovimento(EdDtmovimento);
// 07.12.09 - Abra - Paulo
       if trim(FGeral.getconfig1asstring('Contasnfentrada'))<>'' then begin
//          EdPlan_conta.ShowForm:='';
          Global.PlanoFiltrado:='S';
          EdPlan_conta.Empty:=false;
          ContasGrupo3:=FPlano.GetContasSubordinadasClassi('3','M');
//          FPlano.SetaItems(EdPlan_conta,EdPlan_descricao,FGeral.getconfig1asstring('Contasnfentrada')+';'+ContasGrupo3,'','');
// 02.02.10
          FPlano.AbrecomFiltro( FGeral.GetIN('plan_conta',FGeral.getconfig1asstring('Contasnfentrada')+';'+ContasGrupo3,'N') );
       end;

    end;

  end else begin  // alteracao de nota...

     EdNumerodoc.enabled:=true;
     EdDtemissao.enabled:=Global.Usuario.OutrosAcessos[0702];
     if ( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodCompraProdutor ) then
       EdNfprodutor.enabled:=true;

  end;
// 24.02.05
  if EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodTransfEntrada then begin
    EdUnidorigem.enabled:=true;
    EdDtmovimento.enabled:=true;   // 18.03.05
  end else begin
    EdUnidorigem.enabled:=false;
    EdUnidorigem.text:='';
  end;
// 27.06.06
//  if ( EdComv_codigo.resultfind.fieldbyname('comv_natf_foestado').asstring='2122' ) or
//     ( EdComv_codigo.resultfind.fieldbyname('comv_natf_estado').asstring='1122' ) then begin
// 25.03.08
  if pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoInd+';'+
        Global.CodRetornocomServicos+';'+Global.CodCompraRemessaFutura+';'+Global.CodRetornoMercDepo+';'+
        Global.CodDevolucaoCompra+';'+Global.CodRetornoRemessaConserto)>0 then begin
//    EdTipo_Codigoind.enabled:=true;
    EdNotasCompra.enabled:=true;
  end else begin
    EdTipo_Codigoind.enabled:=false;
    EdTipo_Codigoind.setvalue(0);
    EdNotasCompra.enabled:=false;
  end;
// 01.04.08
  bservicos.Enabled:=EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodRetornocomServicos;
  bfechaservicos.Enabled:=EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodRetornocomServicos;
// 27.10.09
  bveiculos.Enabled:=false;

  Peracreprev:=0;   // 20.07.05
  if ListaCustos=nil then   // 18.08.05
    ListaCustos:=TList.create;
// 31.07.07
//  EdMuni_codigo.enabled:=EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodCompraProdutor;
// 14.08.08
  ChecaEditsDesabilitados(Edcomv_codigo.ResultFind.FieldByName('comv_editsnota').asstring);
// 16.09.08
  if ansipos('EDPECAS',Uppercase(Edcomv_codigo.ResultFind.FieldByName('comv_editsnota').asstring))=0 then
    EdPecas.Enabled:=Global.Topicos[1302];

  if  not EdUnid_codigo.enabled then
      EdUnid_codigo.validfind;
// 29.09.09 - Capeg
  if ( pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,EntranoCusto ) > 0 )
     and ( Global.Topicos[1335] )
    then begin
    descpiscofins:=Confirma('Desconta pis e cofins do custo do produto ?');
  end;
// 20.04.10 - Abra - Ligiane
  if pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodCompraImobilizado)>0 then
    EdPlan_conta.Enabled:=true;
// 26.03.12
  if not Arq.TTransp.Active then Arq.TTransp.Open;
// 12.11.12 - vivan
  if pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Devolucao ) > 0 then begin
    EdMOes_tabp_codigo.Visible:=Global.Topicos[1357];
    EdMOes_tabp_codigo.Enabled:=Global.Topicos[1357];
    SetEdTABP_ALIQUOTA.Visible:=Global.Topicos[1357];
//    EdMoes_tabp_codigo.Enabled:=Global.Usuario.OutrosAcessos[0306];
// 12.11.12 - vivan - lindacir - liberar para todos
  end else begin
    EdMOes_tabp_codigo.Enabled:=false;
  end;
//////////////

end;

procedure TFNotaCompra.bSairClick(Sender: TObject);
begin
  Grid.Clear;
  Close;

end;

procedure TFNotaCompra.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var QMestre:TSqlquery;
begin

  Global.PlanoFiltrado:='N';
  if (EdFornec.AsInteger>0) then begin
    if OP='I' then begin
      QMestre:=Sqltoquery('select moes_status from movesto where moes_status=''N'''+
          ' and moes_tipomov='+Stringtosql(Arq.TConfMovimento.fieldbyname('comv_tipomovto').asstring)+
          ' and moes_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and moes_tipo_codigo='+EdFornec.AsSql+
          ' and moes_datamvto='+EdDtEntrada.AsSql+
          ' and moes_numerodoc='+EdNumerodoc.AsSql+
          ' and moes_tipocad='+Stringtosql('F') );
      if (QMestre.Eof) and (EdTotalnota.ascurrency>0) and (trim(Grid.cells[1,1])<>'') then begin
        if Confirma('� prov�vel que este documento ainda n�o foi gravado.  Gravar ?') then
          bgravarclick(Self)
        else
          RetornaQtdeCusto;
        if ListaCustos<>nil then
          if (ListaCustos.count>0) and (ListaCustos.count<10000) then
            Freeandnil(ListaCustos);
        Grid.Clear;   // 15.06.05
        GridParcelas.clear;     // 15.06.05
        Gridcodbarra.clear;     // 11.05.20
        if GridParcelas2.visible then
          GridParcelas2.Clear;
      end;
    end else begin
//      FGeral.GravaMestreConsignacao(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
//             Arq.TConfMovimento.fieldbyname('comv_tipomovto').asstring,Transacao,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger);
//      Sistema.Commit;
    end;
  end;

  Arq.TConfMovimento.SetFilter( '' );
  Arq.TNatFisc.close;
  if Arq.TTransp.Active then Arq.TTransp.Close;
  global.UltimoFormAberto:='';


end;

procedure TFNotaCompra.RetornaQtdeCusto;
var p:integer;
begin

  if FGeral.TipomovEntra(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring) then begin
    if (ListaCustos<>nil) and (ListaCustos.count>0) and (ListaCustos.count<10000) then begin
// 19.08.05
      if ( pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,EntranoCusto ) = 0 )  then begin

        for p:=0 to ListaCustos.count-1 do begin
          PCustos:=ListaCustos[p];
      // ver se retorna a quantidade e os custos
          Sistema.Edit('estoqueqtde');
          Sistema.setfield('esqt_qtde',PCustos.aqtde);
          Sistema.setfield('esqt_qtdeprev',PCustos.aqtdeprev);

  ////////////        Sistema.setfield('esqt_custo',PCustos.acusto);
  ////////////        Sistema.setfield('esqt_custoger',PCustos.acustoger);
  ///////////        Sistema.setfield('esqt_customedio',PCustos.acustomedio);
  /////////////        Sistema.setfield('esqt_customeger',PCustos.acustomedioger);
          Sistema.setfield('esqt_dtultcompra',PCustos.adataultcompra);
          Sistema.Post('esqt_esto_codigo='+stringtosql(pcustos.produto)+' and esqt_unid_codigo='+EdUNid_codigo.Assql+
                   ' and esqt_status=''N'''  )
        end;
        if Listacustos.count>0 then
          Sistema.Commit;
      end;
    end;
  end;

end;

procedure TFNotaCompra.EdNumeroDocValidate(Sender: TObject);
var Q,QBusca,QBusca1,QPendencia,QPedido:TSqlquery;
    Database:TDatetime;
    sqltipomov:string;
begin

  if OP='I' then begin
// 17.04.09
    sqltipomov:=' and moes_tipomov='+stringtosql(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring);
    if EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodCompra then
      sqltipomov:=' and '+FGeral.GetIN('moes_tipomov',Global.CodCompra+';'+Global.CodCompra100,'C');
    Q:=sqltoquery('select * from movesto where moes_status=''N'' and moes_tipocad=''F'''+
     ' and moes_numerodoc='+EdNumerodoc.AsSql+' and moes_tipo_codigo='+EdFornec.assql+
     sqltipomov );
//     ' and moes_datamvto='+EdDtEntrada.AsSql );
    if not Q.Eof then begin
      if (Q.fieldbyname('moes_natf_codigo').asstring=EdNatf_codigo.Text) and (Q.fieldbyname('moes_datamvto').AsDatetime=EdDtEntrada.Asdate) then  // 22.06.09
        EdNumerodoc.invalid('Numero j� encontrado na transa��o '+Q.fieldbyname('moes_transacao').asstring+' de '+Q.fieldbyname('moes_datamvto').asstring+' com mesmo CFOP')
// 23.06.09 - ajustado em 29.07.09 para pode desmembrar notas..
      else if (Q.fieldbyname('moes_natf_codigo').asstring=EdNatf_codigo.Text) and  (Q.fieldbyname('moes_datamvto').AsDatetime=EdDtEntrada.Asdate) then
        EdNumerodoc.invalid('Numero j� encontrado na transa��o '+Q.fieldbyname('moes_transacao').asstring+' de '+Q.fieldbyname('moes_datamvto').asstring)
      else if Q.fieldbyname('moes_datamvto').AsDatetime<>EdDtEntrada.Asdate then  // 23.06.09
        Avisoerro('Checar.  Numero j� encontrado na transa��o '+Q.fieldbyname('moes_transacao').asstring+' de '+Q.fieldbyname('moes_datamvto').asstring)
      else
        Avisoerro('Checar.  Numero j� encontrado na transa��o '+Q.fieldbyname('moes_transacao').asstring+' de '+Q.fieldbyname('moes_datamvto').asstring+' CFOP '+Q.fieldbyname('moes_natf_codigo').asstring)
    end else begin
//      if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoind+';'+Global.codretornoind) >0 then begin
        EdPedido.Items.Clear;
        Database:=sistema.hoje-90;
        QPedido:=sqltoquery('select mocm_numerodoc,mocm_datamvto from movcomp where mocm_tipo_codigo='+Edfornec.assql+
                            ' and mocm_datamvto>='+Datetosql(database)+
                            ' and mocm_datarecebido is null'+
                            ' and mocm_status=''N'' order by mocm_numerodoc' );
        while not QPedido.eof do begin
          EdPedido.Items.Add(strzero(QPedido.fieldbyname('mocm_numerodoc').asinteger,8)+' - '+FGeral.formatadata(QPedido.fieldbyname('mocm_datamvto').asdatetime));
          QPedido.Next;
        end;
        FGeral.fechaquery(QPedido);
//        if EdPedido.items.count>0 then
//          EdPedido.Empty:=false
//        else
//          EdPedido.Empty:=true;
//      end;
    end;

  end else begin

    if EdNumerodoc.AsInteger>0 then begin

         if EdDtemissao.isempty then
           EdDtemissao.setdate(Sistema.hoje);
         if EdDtEntrada.IsEmpty then  // 11.09.09
           QBusca:=sqltoquery(FGeral.buscanf(EdNumerodoc.AsInteger,Global.CodCompra+';'+Global.CodCompra100,EdDtemissao.asdate,EdUnid_codigo.text))
         else
           QBusca:=sqltoquery(FGeral.buscanf(EdNumerodoc.AsInteger,Global.CodCompra+';'+Global.CodCompra100,EdDtemissao.asdate,EdUnid_codigo.text,0,EdDtEntrada.AsDate,transacaobusca));
//         QBusca1:=sqltoquery('select * from pendencias where pend_status=''N'' and pend_numerodcto='+EdNumerodoc.AsSql+
//                             ' and pend_tipomov='+stringtosql(Global.CodCompraX)+' and pend_dataemissao='+EdDtemissao.assql);
         QBusca1:=sqltoquery('select * from movestoque inner join movesto on (moes_transacao=move_transacao) where move_status=''N'' and move_numerodoc='+EdNumerodoc.AsSql+
                             ' and move_tipomov='+stringtosql(Global.CodCompraX)+' and move_datamvto='+EdDtentrada.assql+
                             ' and move_unid_codigo='+EdUnid_codigo.assql+  // 11.09.09
                             ' and move_transacao = '+stringtosql(transacaobusca)+ // 28.07.2021
                             ' and move_datacont is null');
         if not Qbusca1.eof then begin
           transacao1:=QBusca1.fieldbyname('moes_transacao').asstring;
         end else begin
            QBusca1.close;
            Freeandnil(QBusca1);
            QBusca1:=sqltoquery('select * from movestoque inner join movesto on (moes_transacao=move_transacao) where move_status=''N'' and move_numerodoc='+EdNumerodoc.AsSql+
                             ' and move_tipomov='+stringtosql(Global.CodCompra)+
                             ' and move_datamvto='+EdDtentrada.assql+
                             ' and move_unid_codigo='+EdUnid_codigo.assql+  // 11.09.09
                             ' and move_transacao = '+stringtosql(transacaobusca)+ // 28.07.2021
                             ' and move_datacont is null');
            if not Qbusca1.eof then
              transacao1:=QBusca1.fieldbyname('moes_transacao').asstring
            else
              transacao1:='';
         end;
         if QBusca.eof then begin
           QBusca:=sqltoquery(FGeral.buscanf(EdNumerodoc.AsInteger,EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,EdDtemissao.asdate,EdUnid_codigo.text,0,0,transacaobusca));
           if QBusca.eof then begin
             QBusca.close;
             QBusca:=sqltoquery(FGeral.buscanf(EdNumerodoc.AsInteger,Global.CodCompra100,EdDtemissao.asdate,EdUnid_codigo.text,0,0,transacaobusca));
             if QBusca.eof then begin
               EdNUmerodoc.INvalid('Numero de nota n�o encontrado tipo '+EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring);
               EdNumerodoc.ClearAll(FNotaCompra,99);
               Grid.Clear;
             end else begin
               Transacao2:=QBusca.fieldbyname('moes_transacao').asstring;
               Campostoedits(Qbusca,QBusca1);
               Campostogrid(Qbusca,QBusca1);
               EdFornec.Valid;
               EdUnid_codigo.ValidFind;
               EdFpgt_codigo.ValidFind;
               EdComv_codigo.ValidFind;
               Arq.TConfMovimento.locate('comv_codigo',Edcomv_codigo.Text,[]);
             end;
           end else begin
             Transacao2:=QBusca.fieldbyname('moes_transacao').asstring;
             Campostoedits(Qbusca,QBusca1);
             Campostogrid(Qbusca,QBusca1);
             EdFornec.Valid;
             EdUnid_codigo.ValidFind;
             EdFpgt_codigo.ValidFind;
             EdComv_codigo.ValidFind;
             Arq.TConfMovimento.locate('comv_codigo',Edcomv_codigo.Text,[]);
           end;
         end else begin
// 27.05.15
           Transacao2:=QBusca.fieldbyname('moes_transacao').asstring;
           Campostoedits(Qbusca,QBusca1);
           Campostogrid(Qbusca,QBusca1);
           EdFornec.ValidFind;
           EdUnid_codigo.ValidFind;
           EdFpgt_codigo.ValidFind;
           EdComv_codigo.ValidFind;
           Arq.TConfMovimento.locate('comv_codigo',Edcomv_codigo.Text,[]);

         end;

         QPendencia:=sqltoquery('select * from pendencias where pend_status=''B'' and pend_numerodcto='+Stringtosql(EdNumerodoc.Text)+
                             ' and pend_datamvto>='+EdDtemissao.assql+' and pend_tipocad=''F'' and pend_tipo_codigo='+EdFornec.assql+
// 31.08.09
                             ' and pend_unid_codigo='+EdUNid_codigo.AsSql);
         if (not QPendencia.eof) and (OP<>'F') then begin
              EdNumerodoc.invalid('Nota com pend�ncia financeira j� baixada.  Altera��o n�o permitida.');
              exit;
         end;
// 07.08.07
       if QBusca.fieldbyname('moes_tipomov').asstring=Global.CodCompraProdutor then begin
              EdNumerodoc.invalid('Altera��o n�o permitida em Nota de compra de Produtor');
              exit;
         end;
       qPendencia.close;
       QBusca.close;
       QBusca1.close;
    end;
  end;
end;

procedure TFNotaCompra.EdDigtotalnfValidate(Sender: TObject);
begin
  if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodConhecimento ) or
     ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodEntradaSemItens ) then
    EdPort_codigo.SetFocus
  else if  EdComv_codigo.ResultFind.fieldbyname('comv_natf_foestado').asstring='3102' then  // 22.06.06
    EdOutrasDespesas.setvalue(EdDigtotalnf.ascurrency-EdDigbicms.ascurrency-EdValoripi.ascurrency);

  if EdValortotal.enabled then EdValortotal.SetValue(EdDigtotalnf.AsCurrency);


end;

procedure TFNotaCompra.EdFreteValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////////////
begin
  if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodConhecimento ) or
     ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodEntradaSemItens ) then
    EdDigbicms.SetValue(EdFrete.ascurrency);
// 13.12.11
  Freteembutido:=false;
  if EdFrete.ascurrency>0 then begin
    Freteembutido:=Confirma('Frete est� somado no total desta nota ?');
    EdEmides.text:='2';  // 03.07.14
  end else
    EdEmides.text:='1';  // 26.06.13

end;

procedure TFNotaCompra.EdTran_codigoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////////
var uf:string;
begin
  uf:=FTransp.GetUF(EdTRan_codigo.asinteger);
  if not Arq.TTransp.locate('tran_codigo',EdTran_codigo.Text,[]) then begin
    EdTran_codigo.invalid('Codigo n�o encontrado');
    exit;
  end;
  IF EdFornec.AsInteger=0 then begin
    if EdUnid_codigo.ResultFind.fieldbyname('unid_uf').asstring<>UF then
      EdNatf_codigo.text:=EdComv_codigo.resultfind.fieldbyname('comv_natf_foestado').asstring
    else
      EdNatf_codigo.text:=EdComv_codigo.resultfind.fieldbyname('comv_natf_estado').asstring;
// 31.03.08
    if pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.codcompraprodutor+';'+Global.CodDevolucaoInd)=0 then begin
      IF pos( UF,estados7 )>0 then
        EdPericmsnota.setvalue(7)
      else IF pos( UF,estados12 )>0 then
        EdPericmsnota.setvalue(12)
      else
        EdPericmsnota.setvalue(17);
    end;
  end;
// 04.05.07
  if (Global.Topicos[1301]) and ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodCompraProdutor)
     then
     EdNUmerodoc.setvalue( FGeral.ConsultaContador('NFSAIDA'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade))+1 );
// 28.10.09
  if EdTran_codigo.ResultFind<>nil then begin
    if ( EdTran_codigo.ResultFind.FieldByName('tran_proprio').AsString='S' ) and
       ( pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.codcompraprodutor+';'+Global.CodDevolucaoInd)=0 ) then begin
      bveiculos.Enabled:=true;
    end else
      bveiculos.Enabled:=false;
  end;

end;

procedure TFNotaCompra.EdQtdeValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
  function ValidaCompraGeral(codigo:integer;data:Tdatetime):boolean;
  begin
    result:=true;
  end;

begin
// 05.11.09 - Abra - Barras pra metros
  if ( pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,EntranoCusto ) > 0 )  and
     ( Global.Topicos[1338] ) and (EdCodTamanho.AsInteger>0) and (EdCodCor.AsInteger>0) then begin
    EdQtde.setvalue( (EdQtde.asfloat*FTamanhos.GetComprimento(EdCodTamanho.AsInteger))/1000 );
    EdQtdeprev.setvalue(edqtde.asfloat);
  end else begin
    EdQtdeprev.setvalue(edqtde.asfloat);
    if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodCompraRemessaFutura then begin
      if not ValidaCompraGeral(EdFornec.asinteger,EdDtentrada.asdate) then
        EdQTde.Invalid('');
    end;
  end;
end;

procedure TFNotaCompra.EdUnitarioValidate(Sender: TObject);
begin
//  EdValoruni.setvalue(EdUnitario.ascurrency);
// 15.09.06 - por causa das lokuragens da importa�ao...
// 05.11.09 - Abra - Barras pra metros
  if ( pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,EntranoCusto ) > 0 )  and
     ( Global.Topicos[1338] ) and (EdCodTamanho.AsInteger>0) and (EdCodCor.AsInteger>0) then begin
    EdUNitario.setvalue( EdUnitario.asfloat/(FTamanhos.GetComprimento(EdCodTamanho.AsInteger)/1000) );
    EdValoruni.setvalue(EdUnitario.asfloat);
  end else
    EdValoruni.setvalue(EdUnitario.asfloat);
end;

procedure TFNotaCompra.EdPeracreValidate(Sender: TObject);
begin
  if EdPeracre.ascurrency>0 then begin
//    EdPerdesco.enabled:=false;
//    EdPerdesco.setvalue(0);
    EdVlracre.enabled:=false;
    EdVlracre.setvalue(0);
  end else begin
    EdPerdesco.enabled:=true;
    EdVlracre.enabled:=true;
  end;
///////  SetaEditsvalores;

end;

procedure TFNotaCompra.EdperdescoValidate(Sender: TObject);
var totalitens:currency;
begin
  if Edperdesco.ascurrency>0 then begin
    EdVlrdesco.enabled:=false;
//    if (OP='I') then
//      EdVlrdesco.setvalue(0);
    totalitens:=totalbruto;
// 24.07.14
    if EdVlrdesco.ascurrency=0 then
      EdVlrdesco.setvalue(totalitens*(EdPerdesco.ascurrency/100));

//    EdVlracre.enabled:=false;
//    EdVlracre.setvalue(0);
    if pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Devolucao ) > 0 then begin
      bgravarclick(FNotaCompra);
    end;
  end else
    EdVlrdesco.enabled:=true;
  EdDescoper.setvalue(EdPerdesco.ascurrency);
// 18.01.06
  if pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Devolucao ) > 0 then
    SetaEditsvalores;
// 26.06.13 - vivan - Lindacir - criado topico geral pra ativar
  if Global.Topicos[1363] then begin
    if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoSerie5 ) or
       ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoCompra ) or
       ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoVenda ) or
       ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoVendaConsig ) then begin
      if trim(FGeral.Getconfig1asstring('Fpgtoavista'))='' then
        EdPerDesco.invalid('Falta configurar a forma de pagamento a vista nas configura��es')
      else begin
        EdFpgt_codigo.text:=FGeral.Getconfig1asstring('Fpgtoavista');
        EdFpgt_codigo.Valid;
        EdFpgt_codigo.enabled:=false;
      end;
    end;
  end;
////////////

end;

procedure TFNotaCompra.EdVlracreValidate(Sender: TObject);
////////////////////////////////////////////////////////
var peracre,totalitens,valor:currency;
begin
  if EdVlracre.ascurrency>0 then begin
//    EdVlrdesco.enabled:=false;
//    if Op='I' then
//      EdVlrdesco.setvalue(0);
    totalitens:=totalbruto-EdVlrdesco.ascurrency;
    valor:=FGEral.Arredonda(totalitens,2);
    if valor>0 then
      peracre:=(EdVlracre.ascurrency/valor)*100;

    peracre:=FGeral.Arredonda(peracre,4);
//    if EdPeracre.ascurrency=0 then
///////////    SetaEditsvalores;
    EdPeracre.setvalue(peracre);
// 15.08.05
//    if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoVenda ) then
//       EdFpgt_codigo.valid;

  end else begin
    EdVlrdesco.enabled:=true;
    EdPeracre.setvalue(0);
  end;
end;

procedure TFNotaCompra.EdVlrdescoValidate(Sender: TObject);
var perdesc,totalitens:currency;
begin
  if EdVlrdesco.ascurrency>0 then begin
    totalitens:=totalbruto;
    if totalitens>0 then
      perdesc:=(EdVlrdesco.ascurrency/totalitens)*100
    else begin
      Avisoerro('Total de itens est� zerado.  C�lculo n�o feito');
      perdesc:=0;
    end;
    perdesc:=FGeral.Arredonda(perdesc,4);
    EdPerdesco.setvalue(perdesc);
//////////    SetaEditsvalores;
    if pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Devolucao ) > 0 then begin
      SetaEditsvalores;  // 16.11.05
      EdDescoper.enabled:=false;
      EdDescovlr.enabled:=false;
//      EdFpgt_codigo.valid;
//      bgravarclick(FNotaCompra);
// 28.11.17 - retirado pois senao nao pede a conta e a condicao
    end else begin
      if EdValortotal.ascurrency>0 then begin
        EdDescoper.enabled:=true;
        EdDescovlr.enabled:=true;
      end else begin
        EdDescoper.enabled:=false;
        EdDescovlr.enabled:=false;
        EdDescoper.setvalue(0);
        EdDescovlr.setvalue(0);
      end;
    end;
  end else begin
    EdPerdesco.setvalue(0);
  end;

  EdDescovlr.setvalue(EdVlrdesco.ascurrency);

end;

procedure TFNotaCompra.EdDigtotalnfExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////
begin

  if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodRetornocomservicos) >0 then

    bservicosclick(self)
// 16.11.16
  else if ( (EdTran_codigo.resultfind<>nil) ) then begin
// 26.02.19
      if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodPrestacaoServicosE) >0 then begin

         if (EdTran_codigo.ResultFind.FieldByName('tran_proprio').AsString='S') and ( CfopdeCombustivel ) then
            bveiculosClick(self)
         else
            bincluiritemclick(FNotaCompra)

      end else if (EdTran_codigo.ResultFind.FieldByName('tran_proprio').AsString='S') and ( CfopdeCombustivel ) then

           bveiculosClick(self)

// 22.01.2021
      else if Ansipos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodConhecimento+';'+Global.CodEntradaSemItens) =0 then

         bincluiritemclick(FNotaCompra)

      else

         EdPort_codigo.setfocus;

  end else if Ansipos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodConhecimento+';'+Global.CodEntradaSemItens) =0 then

    bincluiritemclick(FNotaCompra)

  else

    EdPort_codigo.setfocus;

end;

procedure TFNotaCompra.GridParcelasDblClick(Sender: TObject);
begin
  AtivaEditsParcelas;

end;

procedure TFNotaCompra.AtivaEditsParcelas;
///////////////////////////////////////////////
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

procedure TFNotaCompra.GridParcelasKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#13 then
    GridParcelasDblClick(FNotaCompra);

end;

procedure TFNotaCompra.EdParcelaExitEdit(Sender: TObject);
begin
  GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=Transform(EdParcela.AsFloat,f_cr);
  GridParcelas.SetFocus;
  EdParcela.Visible:=False;
// 27.02.14
  if (EdDtMovimento.IsEmpty) and ( not PParcelas2.Visible ) then
     GridParcelas2.Cells[GridParcelas.Col,GridParcelas.Row]:=Transform(EdParcela.AsFloat,f_cr);

end;

procedure TFNotaCompra.EdVencimentoExitEdit(Sender: TObject);
begin

// 13.11.10
  if Global.Topicos[1466] then

     GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=FormatDatetime( 'dd/mm/yyyy',EdVencimento.AsDate)
  else

     GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=DateToStr_(EdVencimento.AsDate);

  GridParcelas.SetFocus;
// 27.02.14
  if (EdDtMovimento.IsEmpty) and ( not PParcelas2.Visible ) then
      GridParcelas2.Cells[GridParcelas.Col,GridParcelas.Row]:=DateToStr_(EdVencimento.AsDate);

  EdVencimento.Visible:=False;

end;

procedure TFNotaCompra.EdPort_codigoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
begin
// 24.10.07 - pedir cond. pagto nas devolucoes tbem
{
  EdFpgt_codigo.enabled:=true;
  if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoSerie5 ) or
     ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoCompra ) or
     ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoConsig ) or
     ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoVenda ) then begin
    if trim(FGeral.Getconfig1asstring('Fpgtoavista'))='' then
      EdComv_codigo.invalid('Falta configurar a forma de pagamento a vista nas configura��es')
    else begin
      EdFpgt_codigo.text:=FGeral.Getconfig1asstring('Fpgtoavista');
      EdFpgt_codigo.Valid;
      EdFpgt_codigo.enabled:=false;
    end;
  end;
}
  if (EdDigtotalnf.ascurrency-EdDigtotpro.ascurrency<0) and (EdValoripi.ascurrency=0) and (Edvalorsubs.AsCurrency=0)
     and (EdARquivoxml.isempty)
    then
    EdVlrdesco.setvalue(abs(EdDigtotalnf.ascurrency-EdDigtotpro.ascurrency))
  else if (EdARquivoxml.isempty) then
    EdVlrdesco.setvalue(0);
// 22.10.15 - pego de novo aqui pois os campos sao 'limpos'...
  if ( not EdRomaneio.isempty ) and ( EdRomaneio.enabled ) then
      EdFpgt_codigo.Text:=EdFornec.resultfind.fieldbyname('clie_fpgt_codigo').asstring;
// 21.11.17
    if (OP='I') and ( Uppercase(copy(EdTipodoc.text,1,3))='CTE' ) then begin
      if not Edarquivoxml.isempty then Edchavenfeacom.text:=copy(AcbrCte1.Conhecimentos.Items[0].CTe.infCTe.Id,4,44);
    end;
//////////////////
end;

function TFNotaCompra.totalbruto(tipo:string='qtde'): currency;
/////////////////////////////////////////////////////////////////////
var p:integer;
    produto:string;
    totalitens:currency;
begin
  totalitens:=0;
  for p:=1 to Grid.rowcount do begin
    produto:=Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p];
    if trim(produto)<>'' then begin
      if tipo='qtde' then
        totalitens:=totalitens+Fgeral.Arredonda( texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]) * texttovalor(Grid.Cells[Grid.GetColumn('move_venda'),p]) ,2)
      else
        totalitens:=totalitens+Fgeral.Arredonda( texttovalor(Grid.Cells[Grid.GetColumn('qtdeprev'),p]) * texttovalor(Grid.Cells[Grid.GetColumn('valoruni'),p]) ,2);
    end;
  end;
  result:=totalitens;
end;

procedure TFNotaCompra.EdProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#27 then
    bcancelaritemclick(FNotaCompra);

end;

procedure TFNotaCompra.EdDtMovimentoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FGeral.PoeData(EdDtMovimento,key);

end;

procedure TFNotaCompra.EdFornecValidate(Sender: TObject);
//////////////////////////////////////////////////////////
var QBusca:TSqlquery;
    sqlstatus,tipomovimento,sqltipocodigo,sqlcfop,sqlinner,cnome,crazaosocial,unidades:string;
    xData:TDatetime;
    restricao1,restricao2,restricao3,restricao4:boolean;
begin

  tipomovimento:='';
  EdCertificado.text:=' ';
  restricao1:=true;
  restricao2:=true;
  restricao3:=true;
  restricao4:=true;
  usuariolib:=0;
  obsliberacao:='';
  unidades:=Global.Usuario.UnidadesMvto;
  if Global.Topicos[1255] then
    unidades:=Global.CodigoUnidade;

  if Edfornec.asinteger>0 then begin

    if campoufentidade='clie_uf' then begin
 // 16.09.10
      campo:=Sistema.GetDicionario('clientes','clie_depojudi');
      QFornec:=sqltoquery('select * from clientes where clie_codigo='+Edfornec.assql);
      TipoEntidade:=QFornec.fieldbyname('clie_tipo').asstring;
// 31.07.07
      EdMuni_codigo.setvalue(QFornec.fieldbyname('Clie_cida_codigo_res').asinteger);
// 16.09.10
      if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodCompraProdutor )
                  and (campo.Tipo<>'') then begin
        if ( QFornec.fieldbyname('clie_depojudi').asstring='S' ) then begin
           if ( trim(QFornec.fieldbyname('clie_contadepojudi').asstring)='' ) then
             EdFornec.Invalid('Produtor com dep�sito judicial sem conta informada')
           else if QFornec.fieldbyname('clie_aliinssdepjud').ascurrency=0 then
             EdFornec.Invalid('Produtor com dep�sito judicial sem % para c�lculo do dep�sito');
        end;
      end;
// 20.06.11
      if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodCompraProdutor ) then begin
           if ( trim(QFornec.fieldbyname('Clie_rgie').asstring)='' )  and (QFornec.fieldbyname('Clie_tipo').asstring='J') then
             Avisoerro('Para nota de Produtor � preciso ter inscri��o estadual informada')
      end;
// 03.07.20
      if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodCompraProdutor )
         and ( trim(QFornec.fieldbyname('Clie_situacao').asstring)='B' )  then
             EdFornec.Invalid('Cadastro de Produtor foi bloqueado para fazer NFe');

// 25.04.14 - Vivan - restricao de credito
///////////////////////////////////////////

      if (OP='I') and (Global.Topicos[1406]) and (EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoVenda)  then begin
        restricao1:=FGeral.ValidaCliente( EdFornec,Global.CodPedVenda,'P','DUP',unidades );
        restricao2:=FGeral.ValidaCliente( EdFornec,Global.CodPedVenda,'P','BOL',unidades );
        restricao3:=FGeral.ValidaCliente( EdFornec,Global.CodPedVenda,'P','CHQ',unidades );
//        restricao4:=FGeral.ValidaCliente( EdFornec,Global.CodPedVenda,'P','LIM',unidades );
//- 18.03.15 - Cecilia pediu pra tirar daqui
      end;

      if not restricao1 then begin //fixo portador duplicata
          if not FGEral.ValidaLiberacaoFinan(Global.usuario.codigo,'DUP') then begin
            EdFornec.Invalid('');
            exit;
          end;
      end else if not restricao2  then begin //fixo portador boleto
          if not FGEral.ValidaLiberacaoFinan(Global.usuario.codigo,'DUP') then begin
            EdFornec.Invalid('');
            exit;
          end;
      end else if not restricao3  then begin //cheques devolvidos

          if not FGEral.ValidaLiberacaoFinan(Global.usuario.codigo,'DUP') then begin
            EdFornec.Invalid('');
            exit;
          end;
      end else if not restricao4  then begin // total em aberto versus limite de cr�dito
          if not FGEral.ValidaLiberacaoLimite(Global.usuario.codigo) then begin
            EdFornec.Invalid('');
            exit;
          end;
      end;
// 11.11.14 = vivan
      if (Global.Topicos[1413]) and (EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoVenda)  then begin
        if (trim (EdFornec.ResultFind.fieldbyname('Clie_portadores').asstring)<>'') then begin
          FPortadores.SetaItems(EdPort_codigo,EdFornec.ResultFind.fieldbyname('Clie_portadores').asstring );
          EdPort_codigo.ShowForm:='';
        end else begin;
          EdFornec.Invalid('Ainda n�o definido portador(es) neste cliente');
          exit
        end;
      end;

///////////////////////////////////////////
// 17.09.07
      if ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodCompraProdutor+';'+Global.CodEntradaProdutor)>0 )  and
        ( EdRomaneio.enabled )
        then begin
        QRoma:=sqltoquery('select * from movabate '+
                          ' where mova_tipo_codigo='+EdFornec.assql+' and mova_status=''N'''+
                          ' and ( mova_notagerada=0 or mova_notagerada is null )'+
                          ' and mova_situacao=''N'' and mova_tipomov='+stringtosql(TipoEntradaAbate)+
// 07.08.14 - Novicarnes - Angela
                          ' and '+FGeral.GetIN('mova_unid_codigo',Global.CodigoUnidade,'C')+
                          ' order by mova_dtabate');
        EdRomaneio.Items.Clear;
        while not QRoma.eof do begin
//          EdRomaneio.Items.Add( strzero(QRoma.fieldbyname('mova_numerodoc').asinteger,8)+' - '+FGeral.formatadata(QRoma.fieldbyname('mova_dtabate').asdatetime) );
          EdRomaneio.Items.Add( strzero(QRoma.fieldbyname('mova_numerodoc').asinteger,8)+' - '+FGeral.formatadata(QRoma.fieldbyname('mova_datacont').asdatetime) );
          QRoma.Next
        end;
        FGeral.FechaQuery(QRoma);
// 14.03.2012 - entradas/retorno de mercadoria enviada para deposito - pb logistica
      end;

    end else begin

      QFornec:=sqltoquery('select * from fornecedores where forn_codigo='+Edfornec.assql);
      TipoEntidade:='J';   // fornecedor fixo juridica - 18.01.06
// 31.07.07
      EdMuni_codigo.setvalue(QFornec.fieldbyname('Forn_cida_codigo').asinteger);
// 30.12.08
//      EdCertificado.text:=QFornec.fieldbyname('Forn_certificado').asstring;
// 11.04.09
//////////////////
       {
      if QFornec.fieldbyname('Forn_certificado').asstring='S' then begin
        EdCertificado.enabled:=true;
// 02.03.11  // Clessi pra agilizar lan�amento - FSC Puro
        EdCertificado.text:='1';
      end else
        EdCertificado.enabled:=false;
        }
///////////////////////
// 04.04.11 - capitulo 4 FSC - Volmar - fixo no fornecedor so vem automatico e nao pede
//////////////////
      if pos(QFornec.fieldbyname('Forn_certificado').asstring,'1;3') > 0 then begin
//        EdCertificado.enabled:=true;
        EdCertificado.text:=QFornec.fieldbyname('Forn_certificado').asstring;
      end else
        EdCertificado.text:=' ';

///////////////////////

/////////
// 25.03.08  - aqui em 01.04.08
      sqlstatus:=' moes_status=''N''';
      sqltipocodigo:='';
      sqlcfop:='';
// 06.02.2012 - junto com 'usar mais de uma vez a nota' para nao aparecer 'muito no f12'..
      xData:=Sistema.hoje-90;
      sqlinner:=' inner join fornecedores on ( forn_codigo=moes_tipo_codigo )';
      cnome:='forn_nome';
      crazaosocial:='forn_razaosocial';
      if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodRetornocomServicos ) then
//        sqlstatus:=' moes_status=''D''';                                                                     //
// 10.12.12 - Ju do compras
        sqlstatus:=' moes_status in (''D'',''N'')';                                                                     //

      if ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodCompraRemessaFutura)>0 ) then begin

        sqltipocodigo:=' and moes_tipo_codigo='+EdFornec.assql;
// 13.09.18 - Novicarnes
//        xData:=Sistema.hoje-180;
// 06.11.18 - Novicarnes  - nota da sollosul de entrega em 11.2018 ref. compra em 04.2018
        xData:=Sistema.hoje-360;

      end;

      if ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoInd+';'+
           Global.CodRetornocomServicos+';'+Global.CodCompraRemessaFutura+';'+Global.CodRetornoMercDepo+';'+
           Global.CodDevolucaoCompra+';'+Global.CodRetornoRemessaConserto)>0 ) then begin
//        sqlcfop:=' and '+FGeral.GetIN('moes_natf_codigo','1923;2923;5901;6902;1924;2924','C');
// 05.10.10 - Abra - robson+ligiane
//        sqlcfop:=' and '+FGeral.GetIN('moes_natf_codigo','1923;2923;5901;6901;1924;2924','C');
// 10.12.12 - Abra - Ju do compras
        sqlcfop:=' and '+FGeral.GetIN('moes_natf_codigo','1923;2923;5901;6901;1924;2924;2902;1902','C');
//        tipomovimento:=Global.CodCompraIndustria+';'+Global.CodRemessaInd;
// 17.02.11 - Abra - robson+andre retiraram pois nao � este tipo de 'triangulacao'
//        tipomovimento:=Global.CodCompraIndustria;
// 04.03.11 - Abra - robson pediu para recolocar RI pois tem um tipo de 'quadrigula��o'...
//        tipomovimento:=Global.CodCompraIndustria+';'+Global.CodRemessaInd;
// 10.12.12 - Abra - Ju do compras + DI
        tipomovimento:=Global.CodCompraIndustria+';'+Global.CodRemessaInd+';'+Global.CodDevolucaoInd;
        if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodCompraRemessaFutura then begin
          TipoMovimento:=Global.CodCompraFutura;
          sqlcfop:='';     // para poder usar a mesma nota mas q uma vezes
// 06.02.2012 - devolucoes 'parciais' da abra..s� pra 'quebrar as regras'...Amanda
        end else if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodDevolucaoInd then begin
          sqlstatus:=FGeral.Getin('moes_status','D;E;N','C');
// 16.03.12
        end else if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodRetornoMercDepo then begin
          sqlstatus:=FGeral.Getin('moes_status','N','C');
          sqlcfop:=' and '+FGeral.GetIN('moes_natf_codigo','5905;6905','C');
          TipoMovimento:=Global.CodSimplesRemessa;
          sqlinner:=' inner join clientes on ( clie_codigo=moes_tipo_codigo )';
          cnome:='clie_nome';
          crazaosocial:='clie_razaosocial';
        end else if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodRetornoRemessaConserto then begin
          TipoMovimento:=Global.CodRemessaConserto;
          sqlcfop:='';
          sqltipocodigo:=' and moes_tipo_codigo='+EdFornec.assql;
          sqlstatus:=FGeral.Getin('moes_status','D;N','C');                                                                     //
        end;
        QBusca:=sqltoquery('select moes_numerodoc,moes_transacao,moes_datamvto,moes_datacont,'+cnome+','+crazaosocial+',moes_tipo_codigo,moes_dataemissao from movesto '+
                           sqlinner+
//                          ' where
// 31.03.08
                          ' where '+sqlstatus+
                          sqltipocodigo+sqlcfop+
// 06.02.2012
                          ' and moes_datamvto >= '+Datetosql(xdata)+
                          ' and '+FGeral.GetIN('moes_tipomov',TipoMovimento,'C')+
//                          ' and moes_unid_codigo='+EdUnid_codigo.Assql+
// 05.11.2012 - Abra triangulacao com outra unidade..chapec�...Andressa+Juliana queriam usar o pedido
                          ' and '+fGeral.GetIN('moes_unid_codigo',Global.Usuario.UnidadesMvto,'C')+
                          ' order by moes_numerodoc');
        NotasCompra:='';TransacoesCompra:='';
        EdNotasCompra.Items.Clear;
        while not QBusca.eof do begin
//          NotasCompra:=NotasCompra+( strzero(QBusca.fieldbyname('moes_numerodoc').asinteger,8)+' - '+FGeral.formatadata(QBusca.fieldbyname('moes_datacont').asdatetime) );
          NotasCompra:=NotasCompra+strzero(QBusca.fieldbyname('moes_numerodoc').asinteger,8)+';';
          if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring<>Global.CodCompraRemessaFutura then
            TransacoesCompra:=TransacoesCompra+QBusca.fieldbyname('moes_transacao').asstring+';';
//          EdNotasCompra.Items.Add( strspace(QBusca.fieldbyname('moes_transacao').asstring,12)+' '+strzero(QBusca.fieldbyname('moes_numerodoc').asinteger,6)+'  '+QBusca.fieldbyname('moes_tipo_codigo').asstring+' '+
//                                  QBusca.fieldbyname('forn_nome').asstring+' '+QBusca.fieldbyname('forn_razaosocial').asstring );
          EdNotasCompra.Items.Add( copy(QBusca.fieldbyname('moes_transacao').asstring+space(12),1,12)+' '+
                                   strzero(QBusca.fieldbyname('moes_numerodoc').asinteger,6)+'  '+
                                   FGeral.FormataData(QBusca.fieldbyname('moes_dataemissao').asdatetime)+
                                   '  '+QBusca.fieldbyname('moes_tipo_codigo').asstring+' '+
                                   copy(QBusca.fieldbyname(cnome).asstring,1,35)+' '+
                                   copy(QBusca.fieldbyname(crazaosocial).asstring,1,35) );
          QBusca.Next
        end;
        FGeral.FechaQuery(QBusca);
      end;

    end;

    EdMuni_codigo.ValidFind;

// 09.05.06
{ - inibido em 25.03.08
    if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoInd ) then begin
      if ( pos( strzero(EdFornec.asinteger,7),FGEral.Getconfig1asstring('fornfinanceiro') )>0 ) then  begin
        EdValortotal.enabled:=true;
        EdTotalservicos.enabled:=false;
        EdTotalservicos.setvalue(0);
      end else begin
        EdValortotal.enabled:=false;
        EdTotalservicos.enabled:=true;
      end;
    end;
}
// 11.09.08
    if not EdUnid_codigo.Enabled then
      EdUnid_codigo.Valid;
  end;
end;

procedure TFNotaCompra.EdDescoperValidate(Sender: TObject);
///////////////////////////////////////////////////////////
begin
  if Eddescoper.ascurrency>0 then begin
    Eddescovlr.enabled:=false;
    Eddescovlr.setvalue(0);
  end else begin
    EdDescovlr.Visible:=Global.Usuario.OutrosAcessos[0010];
    EdDescovlr.Enabled:=Global.Usuario.OutrosAcessos[0010];
  end;
  SetaEditsvalores;
  if ( pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Devolucao ) > 0 ) and (pos(Op,'A;F')>0) then begin
      EdFpgt_codigo.valid;
  end;

end;

procedure TFNotaCompra.EdDescovlrValidate(Sender: TObject);
var perdesc,totalitens:currency;
begin
  if Eddescovlr.ascurrency>0 then begin
    totalitens:=totalbruto('valoruni');
    if totalitens>0 then
      perdesc:=(Eddescovlr.ascurrency/totalitens)*100
    else begin
      Avisoerro('Total de itens est� zerado.  C�lculo n�o feito');
      perdesc:=0;
    end;
    perdesc:=FGeral.Arredonda(perdesc,4);
    Eddescoper.setvalue(perdesc);
    SetaEditsvalores;
  end;
  if ( pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Devolucao ) > 0 ) and (pos(Op,'A;F')>0) then begin
      EdFpgt_codigo.valid;
  end;

end;

/////////////////////////////////////////////////////////////
procedure TFNotaCompra.Campostoedits(Q,Q1: TSqlquery);
/////////////////////////////////////////////////////////////
var QPendencia,QMovfin:TSqlquery;
    p:integer;
    Transacao:string;

    Function GetEquipamento( xoperacao:string ):string;
    ////////////////////////////////////////////////////
    begin
       if trim(xoperacao)<>'' then result:=copy( xoperacao,pos(';',xoperacao)+1,4 )
       else result:='';
    end;


begin
/////////
  if EdFornec.Text<>Q.fieldbyname('moes_tipo_codigo').AsString then begin

     if not confirma('Alterar codigo do fornecedor ?') then
       EdFornec.Text:=Q.fieldbyname('moes_tipo_codigo').AsString;

  end else
    EdFornec.Text:=Q.fieldbyname('moes_tipo_codigo').AsString;

  EdComv_codigo.text:=Q.fieldbyname('moes_comv_codigo').AsString;
  EdUnid_codigo.Text:=Q.fieldbyname('moes_unid_codigo').AsString;
  EdDtEmissao.SetDate(Q.fieldbyname('moes_dataemissao').AsDateTime);
  EdTotalNota.SetValue(Q.fieldbyname('moes_vlrtotal').AsCurrency);
  EdTotalProdutos.SetValue(Q.fieldbyname('moes_totprod').AsCurrency);
  EdNatf_codigo.text:=Q.fieldbyname('moes_natf_codigo').AsString;
  EdNatf_descricao.Text:=FNatureza.GetDescricao(Q.fieldbyname('moes_natf_codigo').Asstring);
  EdTran_codigo.text:=Q.fieldbyname('moes_tran_codigo').AsString;
  EdTran_nome.Text:=FTransp.GetNOme(Q.fieldbyname('moes_tran_codigo').Asstring);
  EdFrete.setvalue(Q.fieldbyname('moes_frete').AsCurrency);
  EdEmides.text:=Q.fieldbyname('moes_freteciffob').Asstring;
  Freteembutido:=(Q.fieldbyname('moes_freteciffob').Asstring='2');

//  EdSeguro.setvalue(Q.fieldbyname('moes_seguro').AsCurrency);
  EdSeguro.setvalue(0);   // esquecido de criar campo - rever se usa e tirar de vez
  EdDtMovimento.setdate(Q.fieldbyname('moes_datacont').Asdatetime);

  EdPeracre.setvalue(Q.fieldbyname('moes_peracres').ascurrency);
  EdPerdesco.setvalue(Q.fieldbyname('moes_perdesco').ascurrency);

  EdBaseicms.setvalue(Q.fieldbyname('moes_baseicms').AsCurrency);
  EdValoricms.setvalue(Q.fieldbyname('moes_valoricms').AsCurrency);
  EdBasesubs.setvalue(Q.fieldbyname('moes_basesubstrib').AsCurrency);
  EdValorsubs.setvalue(Q.fieldbyname('moes_valoricmssutr').AsCurrency);
  EdDtEntrada.SetDate(Q.fieldbyname('moes_datamvto').AsDateTime);
  if ( Q.fieldbyname('moes_tipomov').AsString=Global.CodConhecimento ) or
     ( Q.fieldbyname('moes_tipomov').AsString=Global.CodEntradaSemItens ) then begin
    if Q.fieldbyname('moes_baseicms').AsCurrency>0 then
      edpericmsnota.setvalue( (Q.fieldbyname('moes_valoricms').AsCurrency/Q.fieldbyname('moes_baseicms').AsCurrency)*100)
    else
      edpericmsnota.setvalue(0);
    edperipi.setvalue(0);
  end else begin
    edpericmsnota.setvalue(Q.fieldbyname('move_aliicms').AsCurrency);
    edperipi.setvalue(Q.fieldbyname('move_aliipi').AsCurrency);
  end;
  EdConhecimento.text:=Q.fieldbyname('moes_nroconhec').Asstring;
  EdDigbicms.setvalue(Q.fieldbyname('moes_baseicms').AsCurrency);
  Eddigvicms.setvalue(Q.fieldbyname('moes_valoricms').AsCurrency);
  EdValoripi.setvalue(Q.fieldbyname('moes_valoripi').AsCurrency);
  EdDigtotpro.setvalue(Q.fieldbyname('moes_totprod').AsCurrency);
  Eddigtotalnf.setvalue(Q.fieldbyname('moes_vlrtotal').AsCurrency);

  EdValortotal.setvalue(Q1.fieldbyname('moes_vlrtotal').AsCurrency);
  Edtotal.setvalue(Q1.fieldbyname('moes_vlrtotal').AsCurrency);

  Moes_remessas:=Q.fieldbyname('moes_remessas').Asstring;
  Transacaoant:=Q.fieldbyname('moes_transacao').asstring;
// 06.01.06
  Edtipodoc.text:=Q.fieldbyname('moes_especie').asstring;
  EdSerie.text:=Q.fieldbyname('moes_serie').asstring;
// 10.01.08
  EdFunrural.setvalue(Q.fieldbyname('moes_funrural').ascurrency);
  EdCotaCapital.setvalue(Q.fieldbyname('moes_cotacapital').ascurrency);
// 20.06.19
  if Global.Topicos[1462] then
     EdMoes_insumos.setvalue(Q.fieldbyname('moes_insumos').ascurrency);

// 03.09.15
  campo:=Sistema.GetDicionario('movesto','moes_vlrgta');
  if campo.Tipo<>'' then begin
// 30.07.15
    Edvalorgta.setvalue(Q.fieldbyname('moes_vlrgta').ascurrency);
    EdTotalnota.setvalue(EdTotalnota.ascurrency-(Q.fieldbyname('moes_funrural').ascurrency+Q.fieldbyname('moes_cotacapital').ascurrency+
                       Q.fieldbyname('moes_vlrgta').ascurrency));
  end else begin
    Edvalorgta.setvalue(0);
    EdTotalnota.setvalue(EdTotalnota.ascurrency-(Q.fieldbyname('moes_funrural').ascurrency+Q.fieldbyname('moes_cotacapital').ascurrency));
  end;
// 29.01.14 - A2Z
  if copy(Edtipodoc.text,1,3)<>'CTE' then
    EdCodEqui.text:=GetEquipamento( Q.fieldbyname('move_remessas').asstring );
// 12.03.15
  if copy(Edtipodoc.text,1,3)='CTE' then
    Edchavenfeacom.text:=Q.fieldbyname('moes_chavenfe').asstring
  else
    Edchavenfeacom.text:=Q.fieldbyname('moes_chavenferef').asstring;
// 15.09.16
  Edvlrinss.setvalue(Q.fieldbyname('moes_valorinss').ascurrency);
  Edvlrcofins.setvalue(Q.fieldbyname('moes_valorcofins').ascurrency);
  Edvlrpis.setvalue(Q.fieldbyname('moes_valorpis').ascurrency);
  Edvlrcsll.setvalue(Q.fieldbyname('moes_valorcsl').ascurrency);
  Edvlrir.setvalue(Q.fieldbyname('moes_valorir').ascurrency);
  Edvlriss.setvalue(Q.fieldbyname('moes_valoriss').ascurrency);
// 20.11.18
  EdPesobru.SetValue(Q.fieldbyname('moes_pesobru').ascurrency);
  EdQtdevol.SetValue( Q.fieldbyname('Moes_qtdevolume').ascurrency );
  EdEspecievol.text:=Q.fieldbyname('Moes_especievolume').asstring;
// 22.02.2021 - Vida Nova
  EdMensagem.text := Q.fieldbyname('Moes_mensagem').asstring;

  if copy(Q.fieldbyname('Moes_natf_codigo').asstring,1,1)='3' then begin
      campo:=Sistema.GetDicionario('movesto','moes_numerodi');
      if campo.Tipo<>'' then begin
        EdNumerodi.Text:= Q.fieldbyname('moes_numerodi').AsString;
        Eddatadi.Setdate( Q.fieldbyname('moes_dtregistro').AsDateTime);
        Edlocaldesembaraco.Text:=Q.fieldbyname('moes_localdesen').Asstring;
        EdUfdesen.Text:=Q.fieldbyname('moes_ufdesen').Asstring;
        Eddtdesen.setdate( Q.fieldbyname('moes_dtdesen').asDatetime);
//        Q.fieldbyname('moes_codexp',Fornecedor.text);
      end;
  end;
////////////////////
// 06.06.08
  EdNfprodutor.text:=Q.fieldbyname('moes_notapro').asstring;
  if Q.fieldbyname('moes_notapro2').asinteger>0 then
    EdNfprodutor.text:=EdNfprodutor.text+';'+Q.fieldbyname('moes_notapro2').asstring;
  if Q.fieldbyname('moes_notapro3').asinteger>0 then
    EdNfprodutor.text:=EdNfprodutor.text+';'+Q.fieldbyname('moes_notapro3').asstring;
  if Q.fieldbyname('moes_notapro4').asinteger>0 then
    EdNfprodutor.text:=EdNfprodutor.text+';'+Q.fieldbyname('moes_notapro4').asstring;
////////////////////
// 15.04.14 - Para nao perder a chave na alteracao de notas de entrada - 12.03.15 se nao vazio
  if trim(Q.fieldbyname('moes_xmlnfet').asstring)<>'' then
    AcBrNfe1.NotasFiscais.LoadFromString(Q.fieldbyname('moes_xmlnfet').asstring);
////////////////
  QMovfin:=sqltoquery( FGeral.BuscaTransacao(Transacaoant,'movfin','movf_transacao','movf_status','N','') );
  p:=1;
  if not QMovfin.eof then begin
    Gridparcelas.cells[Gridparcelas.Getcolumn('pend_valor'),p]:=Formatfloat(f_cr,QMovfin.fieldbyname('movf_valorger').ascurrency);
    Gridparcelas.cells[Gridparcelas.Getcolumn('pend_datavcto'),p]:=Formatdatetime('dd/mm/yy',QMovfin.fieldbyname('movf_datamvto').asdatetime);
    inc(p);
  end;
  QPendencia:=sqltoquery( FGeral.BuscaTransacao(Transacaoant,'pendencias','pend_transacao','pend_status','B','pend_datavcto') );
  if (not QPendencia.eof) and (OP<>'F') then begin
       EdNumerodoc.invalid('Nota com pend�ncia financeira j� baixada.  Altera��o n�o permitida.');
       exit;
  end;
  QPendencia.close; Freeandnil(QPendencia);
  if OP='F' then
    QPendencia:=sqltoquery( FGeral.BuscaTransacao(Transacaoant,'pendencias','pend_transacao','pend_status','N;B','pend_datavcto') )
  else
    QPendencia:=sqltoquery( FGeral.BuscaTransacao(Transacaoant,'pendencias','pend_transacao','pend_status','N','pend_datavcto') );
  if not QPendencia.eof then begin
    EdPort_codigo.text:=QPendencia.fieldbyname('pend_port_codigo').asstring;
    EdPort_descricao.Text:=FPortadores.GetDescricao(QPendencia.fieldbyname('pend_port_codigo').Asstring);
    EdFpgt_codigo.text:=QPendencia.fieldbyname('pend_fpgt_codigo').asstring;
    EdFpgt_descricao.text:=FCondpagto.GetDescricao(QPendencia.fieldbyname('pend_fpgt_codigo').asstring);
// 14.02.08
    EdPlan_conta.setvalue(QPendencia.fieldbyname('Pend_Plan_Conta').asinteger);
    if (Global.Topicos[1365]) then EdSeto_codigo.text:=QPendencia.fieldbyname('Pend_seto_Codigo').asstring
    else EdSeto_codigo.text:='';

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
    xcondicao:=EdFpgt_codigo.text;
  end;
// 30.10.09 - aqui em 22.10.10
  if EdPlan_conta.asinteger=0 then begin
    campo:=Sistema.GetDicionario('movesto','moes_plan_codigo');
    if campo.Tipo<>'' then
        EdPlan_conta.setvalue(Q.fieldbyname('Moes_Plan_Codigo').asinteger);
  end;
// 22.10.10
  campo:=Sistema.GetDicionario('movesto','moes_plan_codigocre');
  if campo.Tipo<>'' then
     EdContaCredito.setvalue(Q.fieldbyname('Moes_Plan_Codigocre').asinteger);
///////////////////////
// 16.06.11
  campo:=Sistema.GetDicionario('movesto','moes_cola_codigo');
  if campo.Tipo<>'' then begin
     EdMoes_cola_codigo.text:=Q.fieldbyname('Moes_cola_Codigo').asstring;
     EdMoes_km.setvalue( Q.fieldbyname('moes_km').asinteger );
  end;
  QPendencia.close;
  Freeandnil(QPendencia);
// 14.12.07
  if not Q1.eof then begin
// 21.11.05 -
//////////////////////////////////////////
    QPendencia:=sqltoquery( FGeral.BuscaTransacao(Q1.fieldbyname('moes_transacao').asstring,'pendencias','pend_transacao','pend_status','N','pend_datavcto') );
    p:=1;
    if not QPendencia.eof then begin
      while not QPendencia.eof do begin
        Gridparcelas2.cells[Gridparcelas.Getcolumn('pend_valor'),p]:=Formatfloat(f_cr,QPendencia.fieldbyname('pend_valor').ascurrency);
        Gridparcelas2.cells[Gridparcelas.Getcolumn('pend_datavcto'),p]:=Formatdatetime('dd/mm/yy',QPendencia.fieldbyname('pend_datavcto').asdatetime);
        inc(p);
        if p>Gridparcelas2.RowCount then
          Gridparcelas2.RowCount:=p+1;
        QPendencia.next;
      end;
    end;
  ///////////////////////
    QPendencia.close;
    Freeandnil(QPendencia);
  end;
  QMovfin.close;
  Freeandnil(QMovfin);
  EdUnid_codigo.ValidateEdit;
  EdFornec.ValidateEdit;

end;

// 21.03.18
procedure TFNotaCompra.CampostoEditsII(Q: TSqlquery);
//////////////////////////////////////////////////////
var QPendencia:TSqlquery;
    p:integer;
begin

  EdConhecimento.text:=Q.fieldbyname('moes_nroconhec').Asstring;
  EdDigbicms.setvalue(Q.fieldbyname('moes_baseicms').AsCurrency);
  Eddigvicms.setvalue(Q.fieldbyname('moes_valoricms').AsCurrency);
  EdValoripi.setvalue(Q.fieldbyname('moes_valoripi').AsCurrency);
  EdDigtotpro.setvalue(Q.fieldbyname('moes_totprod').AsCurrency);
  Eddigtotalnf.setvalue(Q.fieldbyname('moes_vlrtotal').AsCurrency);

  Moes_remessas:=Q.fieldbyname('moes_remessas').Asstring;
  Transacaoant:=Q.fieldbyname('moes_transacao').asstring;
  Edtipodoc.text:=Q.fieldbyname('moes_especie').asstring;
  EdSerie.text:=Q.fieldbyname('moes_serie').asstring;
  EdFunrural.setvalue(Q.fieldbyname('moes_funrural').ascurrency);
  EdCotaCapital.setvalue(Q.fieldbyname('moes_cotacapital').ascurrency);
  campo:=Sistema.GetDicionario('movesto','moes_vlrgta');
  if campo.Tipo<>'' then begin
    Edvalorgta.setvalue(Q.fieldbyname('moes_vlrgta').ascurrency);
    EdTotalnota.setvalue(EdTotalnota.ascurrency-(Q.fieldbyname('moes_funrural').ascurrency+Q.fieldbyname('moes_cotacapital').ascurrency+
                       Q.fieldbyname('moes_vlrgta').ascurrency));
  end else begin
    Edvalorgta.setvalue(0);
    EdTotalnota.setvalue(EdTotalnota.ascurrency-(Q.fieldbyname('moes_funrural').ascurrency+Q.fieldbyname('moes_cotacapital').ascurrency));
  end;
  Edtipodoc.text:=Q.fieldbyname('moes_especie').asstring;
  EdSerie.text:=Q.fieldbyname('moes_serie').asstring;
  Edvlrinss.setvalue(Q.fieldbyname('moes_valorinss').ascurrency);
  Edvlrcofins.setvalue(Q.fieldbyname('moes_valorcofins').ascurrency);
  Edvlrpis.setvalue(Q.fieldbyname('moes_valorpis').ascurrency);
  Edvlrcsll.setvalue(Q.fieldbyname('moes_valorcsl').ascurrency);
  Edvlrir.setvalue(Q.fieldbyname('moes_valorir').ascurrency);
  Edvlriss.setvalue(Q.fieldbyname('moes_valoriss').ascurrency);
  if AnsiPos( Q.FieldByName('moes_tipomov').AsString,Global.CodPrestacaoServicosE) > 0 then
    PRetencoes.Visible:=true;

  QPendencia:=sqltoquery( FGeral.BuscaTransacao(Transacaoant,'pendencias','pend_transacao','pend_status','B','pend_datavcto') );
  if (not QPendencia.eof) and (OP<>'F') then begin
       EdNumerodoc.invalid('Nota com pend�ncia financeira j� baixada.  Altera��o n�o permitida.');
//       exit;
  end;

  QPendencia.close; Freeandnil(QPendencia);
  if OP='F' then
    QPendencia:=sqltoquery( FGeral.BuscaTransacao(Transacaoant,'pendencias','pend_transacao','pend_status','N;B','pend_datavcto') )
  else
    QPendencia:=sqltoquery( FGeral.BuscaTransacao(Transacaoant,'pendencias','pend_transacao','pend_status','N','pend_datavcto') );
  if not QPendencia.eof then begin
    EdPort_codigo.text:=QPendencia.fieldbyname('pend_port_codigo').asstring;
    EdPort_descricao.Text:=FPortadores.GetDescricao(QPendencia.fieldbyname('pend_port_codigo').Asstring);
    EdFpgt_codigo.text:=QPendencia.fieldbyname('pend_fpgt_codigo').asstring;
    EdFpgt_descricao.text:=FCondpagto.GetDescricao(QPendencia.fieldbyname('pend_fpgt_codigo').asstring);
// 14.02.08
    EdPlan_conta.setvalue(QPendencia.fieldbyname('Pend_Plan_Conta').asinteger);
    if (Global.Topicos[1365]) then EdSeto_codigo.text:=QPendencia.fieldbyname('Pend_seto_Codigo').asstring
    else EdSeto_codigo.text:='';

    while not QPendencia.eof do begin
      Gridparcelas.cells[Gridparcelas.Getcolumn('pend_valor'),p]:=Formatfloat(f_cr,QPendencia.fieldbyname('pend_valor').ascurrency);
      Gridparcelas.cells[Gridparcelas.Getcolumn('pend_datavcto'),p]:=Formatdatetime('dd/mm/yy',QPendencia.fieldbyname('pend_datavcto').asdatetime);
      inc(p);
      if p>Gridparcelas.RowCount then
        Gridparcelas.RowCount:=p+1;
      QPendencia.next;
    end;
    xcondicao:=EdFpgt_codigo.text;
  end;


end;

////////////////////////////////////////////////////////////////
procedure TFNotaCompra.Campostogrid(Q,Q1: TSqlquery);
////////////////////////////////////////////////////////////////
var p,x,codigosit:integer;
    margemlucro,peso,unitario,totalitem:currency;
    codigofis,produto:string;
    totalitens:currency;
    multi:boolean;


begin

  Grid.Clear;p:=1;
//  Q.First;
// 10.12.07
  if ( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodConhecimento ) or
     ( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodEntradaSemItens ) then exit;
  multi:=false;
//  if Global.Usuario.Codigo=100 then
//    multi:=Confirma('Multiplicar pelo peso ?');
  while not Q.Eof do begin

    produto:=Q.fieldbyname('move_esto_codigo').Asstring;
//    Grid.Cells[00,p]:=Q.fieldbyname('move_esto_codigo').Asstring;
// 08.12.09
    Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p]:=Q.fieldbyname('move_esto_codigo').Asstring;
    Grid.Cells[Grid.Getcolumn('move_tama_codigo'),Abs(p)]:=Q.fieldbyname('move_tama_codigo').Asstring;
    Grid.Cells[Grid.Getcolumn('move_core_codigo'),Abs(p)]:=Q.fieldbyname('move_core_codigo').Asstring;
    Grid.Cells[Grid.Getcolumn('move_copa_codigo'),Abs(p)]:=Q.fieldbyname('move_copa_codigo').Asstring;
    Grid.Cells[Grid.Getcolumn('cor'),Abs(p)]:=FCores.GetDescricao(Q.fieldbyname('move_core_codigo').Asinteger);
    Grid.Cells[Grid.Getcolumn('tamanho'),Abs(p)]:=FTamanhos.Getdescricao(Q.fieldbyname('move_tama_codigo').Asinteger);
    Grid.Cells[Grid.Getcolumn('copa'),Abs(p)]:=FCopas.GetDescricao(Q.fieldbyname('move_copa_codigo').Asinteger);
    Grid.Cells[Grid.Getcolumn('esto_descricao'),p]:=FEstoque.GetDescricao(Q.fieldbyname('move_esto_codigo').Asstring);
    Grid.Cells[Grid.Getcolumn('move_cst'),p]:=Q.fieldbyname('move_cst').Asstring;
    Grid.Cells[Grid.Getcolumn('move_aliicms'),p]:=transform(Q.fieldbyname('move_aliicms').Ascurrency,'#0.00');
    Grid.Cells[Grid.Getcolumn('move_aliipi'),p]:=transform(Q.fieldbyname('move_aliipi').Ascurrency,'#0.00');
    Grid.Cells[Grid.Getcolumn('esto_unidade'),p]:=Arq.TEstoque.fieldbyname('esto_unidade').asstring;
    Grid.Cells[Grid.Getcolumn('move_qtde'),p]:=transform(Q.fieldbyname('move_qtde').Ascurrency,f_qtdestoque);
    if (Global.Usuario.Codigo=100) and ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodRetornocomServicos )
      and ( multi  )
      then begin
//      peso:=FGeral.Arredonda( FEstoque.GetPeso(produto),2 ) ;
      peso:=FEstoque.GetPeso(produto) ;
      if peso>0 then  begin
        unitario:=FGeral.Arredonda( Q.fieldbyname('move_venda').Ascurrency*peso,4) ;
        totalitem:=FGeral.Arredonda( Q.fieldbyname('move_qtde').Ascurrency*unitario,2) ;
        Grid.Cells[Grid.Getcolumn('move_venda'),p]:=TRansform( unitario ,f_cr5);
        Grid.Cells[Grid.Getcolumn('total'),p]:=TRansform(totalitem,f_cr3);
      end else begin
        Grid.Cells[Grid.Getcolumn('move_venda'),p]:=TRansform(Q.fieldbyname('move_venda').Ascurrency,f_cr);
        Grid.Cells[Grid.Getcolumn('total'),p]:=TRansform(Q.fieldbyname('move_qtde').Ascurrency*Q.fieldbyname('move_venda').Ascurrency,f_cr);
      end;

    end else begin
// 24.11.10 - alteracao de nota de produtor pode dar dif. devido ao numero de casas decimais
// 07.08.13 - mudado de ascurrency para asfloat
// 04.04.18 - mudado de 5 para 6 casas decimais
      if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodCompraProdutor+';'+Global.CodEntradaProdutor)>0 then begin
        Grid.Cells[Grid.Getcolumn('move_venda'),p]:=TRansform(Q.fieldbyname('move_venda').AsFloat,f_cr6);
        Grid.Cells[Grid.Getcolumn('total'),p]:=TRansform(Q.fieldbyname('move_qtde').Ascurrency*Q.fieldbyname('move_venda').AsFloat,f_cr);
      end else begin
        Grid.Cells[Grid.Getcolumn('move_venda'),p]:=TRansform(Q.fieldbyname('move_venda').Asfloat,f_cr5);
        Grid.Cells[Grid.Getcolumn('total'),p]:=TRansform(Q.fieldbyname('move_qtde').Ascurrency*Q.fieldbyname('move_venda').AsFloat,f_cr);
      end;

    end;
//    Grid.Cells[11,p]:=transform(Q.fieldbyname('move_qtde').Ascurrency,f_qtdestoque);
//    Grid.Cells[12,p]:=TRansform(Q.fieldbyname('move_venda').Ascurrency,f_cr);
    Grid.Cells[Grid.Getcolumn('qtdeprev'),p]:='';
    Grid.Cells[Grid.Getcolumn('valoruni'),p]:='';

//    if pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Devolucao+';'+Global.codcompraProdutor ) > 0 then begin
// 14.12.07
    if Q.fieldbyname('moes_tipocad').AsString='C' then begin
//       margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(produto,EdUnid_codigo.text,QFornec.fieldbyname(campoufentidade).asstring));
//       codigosit:=FEstoque.GetCodigosituacaotributaria(Produto,EdUnid_codigo.text,QFornec.fieldbyname(campoufentidade).asstring)
       margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(produto,EdUnid_codigo.text,QFornec.fieldbyname('clie_uf').asstring));
       codigosit:=FEstoque.GetCodigosituacaotributaria(Produto,EdUnid_codigo.text,QFornec.fieldbyname('clie_uf').asstring);
    end else begin
       margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(produto,EdUnid_codigo.text,QFornec.fieldbyname('forn_uf').asstring));
       codigosit:=FEstoque.GetCodigosituacaotributaria(Produto,EdUnid_codigo.text,QFornec.fieldbyname('forn_uf').asstring);
    end;
    Grid.Cells[Grid.Getcolumn('margemlu'),p]:=Transform(margemlucro,f_cr);
    Grid.Cells[Grid.Getcolumn('codigosittrib'),p]:=inttostr(codigosit);
    Grid.Cells[Grid.Getcolumn('codigofis'),p]:=codigofis;
    Grid.Cells[Grid.Getcolumn('move_pecas'),p]:=TRansform(Q.fieldbyname('move_pecas').Ascurrency,f_cr);
// 23.12.08
    Grid.Cells[Grid.Getcolumn('move_certificado'),p]:=Q.fieldbyname('move_certificado').AsString;
// 03.09.18
//    if  Q.fieldbyname('move_tipo_codigo').AsString=Global.CodDevolucaoRoman then
// 09.09.18
    if pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Devolucao ) > 0 then

       Grid.Cells[Grid.Getcolumn('move_natf_codigo'),p]:= EdNatf_codigo.Text

    else

       Grid.Cells[Grid.Getcolumn('move_natf_codigo'),p]:=(Q.fieldbyname('move_natf_codigo').AsString);


// 07.08.18
    if trim(copy(Q.fieldbyname('move_natf_codigo').AsString,1,1))='' then
       Grid.Cells[Grid.Getcolumn('move_natf_codigo'),p]:=EdNatf_codigo.text;


// 05.06.12
    Grid.Cells[Grid.Getcolumn('move_redubase'),p]:=TRansform(Q.fieldbyname('move_redubase').AsCurrency,f_cr3);
// 13.09.12
    if Global.Topicos[1356] then begin
      Grid.Cells[Grid.Getcolumn('move_unitarionota'),p]:=TRansform(Q.fieldbyname('move_unitarionota').AsCurrency,f_cr4);
      Grid.Cells[Grid.Getcolumn('move_embalagem'),p]:=TRansform(Q.fieldbyname('move_embalagem').AsCurrency,f_cr);
    end;
// 04.12.13
    Grid.Cells[Grid.Getcolumn('move_operacao'),p]:=Q.fieldbyname('move_remessas').Asstring;
    inc(p);
    Grid.AppendRow;
    Q.Next;
  end;

  while not Q1.Eof do begin
    produto:=Q1.fieldbyname('move_esto_codigo').asstring;
    for x:=1 to Grid.rowcount do begin
      if (produto=Grid.Cells[Grid.getcolumn('move_esto_codigo'),x]) and (Grid.Cells[Grid.getcolumn('move_esto_codigo'),x]<>'') then begin
        Grid.Cells[Grid.getcolumn('qtdeprev'),x]:=transform(Q1.fieldbyname('move_qtde').Ascurrency,f_qtdestoque);
        Grid.Cells[Grid.getcolumn('valoruni'),x]:=formatfloat(f_cr3,Q1.fieldbyname('move_venda').Ascurrency);
//        Grid.Cells[Grid.getcolumn('valoruni'),x]:='filho da puta';
//        Grid.Cells[12,x]:=TRansform(Q1.fieldbyname('move_venda').Ascurrency,f_cr);
        break;
      end;
    end;
    Q1.Next;
  end;

//  Grid.Update;
//  Grid.Refresh;
//  Grid.RePaint;
//  if (Global.Usuario.Codigo=100) and ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodRetornocomServicos ) then
//    SetaEditsValores;

  totalitens:=totalbruto;
//  if totalitens>0 then  begin
  if Eddigtotalnf.ascurrency>0 then  begin
    totalitens:=totalitens + ( (EdPeracre.ascurrency/100)*totalitens);
    totalitens:=totalitens - ( (EdPerdesco.ascurrency/100)*totalitens);
    if Eddigtotalnf.ascurrency=EdDigtotpro.ascurrency then begin
      EdVlrdesco.setvalue(Eddigtotalnf.ascurrency*(EdPerdesco.ascurrency/100));
      EdVlracre.setvalue(Eddigtotalnf.ascurrency*(EdPeracre.ascurrency/100));
    end else begin
      EdVlrdesco.setvalue(Eddigtotpro.ascurrency*(EdPerdesco.ascurrency/100));
      EdVlracre.setvalue(Eddigtotpro.ascurrency*(EdPeracre.ascurrency/100));
    end;
  end;

end;

//////////////////////////////////////////////////////////////////////////
procedure TFNotaCompra.CancelaTransacao(Transacao,transacao1,xOP: string);
//////////////////////////////////////////////////////////////////////////
var QMovestoque,QQtdeEstoque,QMovEsto:TSqlquery;
    Mov,transacaocontax:string;
begin

    Sistema.Beginprocess('Cancelando transa��o '+transacao);
    QMovestoque:=sqltoquery(FGeral.BuscaTransacao(Transacao,'movestoque','move_transacao'));
    if QMovestoque.fieldbyname('move_status').asstring='C' then begin
      Avisoerro('Transa��o j� est� cancelada');
      Sistema.Endprocess('');
      exit;
    end;
    if (Global.topicos[1043])  then begin
      QMovesto:=sqltoquery('select moes_transacerto from movesto where moes_transacao = '+Stringtosql(transacao)+
                           ' and moes_status = ''N''');
      if not QMovEsto.eof then
        transacaocontax:=QMovesto.fieldbyname('moes_transacerto').asstring
      else
        transacaocontax:='';
      FGeral.FechaQuery(QMovesto);
    end else
      transacaocontax:='';
    if pos(QMOvestoque.fieldbyname('move_tipomov').asstring,Global.TiposMovMovEstoque) > 0 then begin
      while not QMovestoque.eof do begin
        QQtdeEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(QMOvestoque.fieldbyname('move_esto_codigo').asstring)+
        ' and esqt_unid_codigo='+Stringtosql(QMOvestoque.fieldbyname('move_unid_codigo').asstring));
        if pos(QMOvestoque.fieldbyname('move_tipomov').asstring,Global.TiposMovMovEntrada) > 0 then
          Mov:='S'
        else
          Mov:='E';
        FGeral.MovimentaQtdeEstoque(QMOvestoque.fieldbyname('move_esto_codigo').asstring,
              QMOvestoque.fieldbyname('move_unid_codigo').asstring,Mov,QMOvestoque.fieldbyname('move_tipomov').asstring,
              QMOvestoque.fieldbyname('move_qtde').ascurrency,QQtdeEstoque,QMOvestoque.fieldbyname('move_qtde').ascurrency,
              QMOvestoque.fieldbyname('move_pecas').ascurrency );
        QQtdeEstoque.close;
        Freeandnil(QQtdeEstoque);
        QMovestoque.Next;
      end;
    end;
    Executesql('update movesto set moes_status=''C'' where moes_transacao='+stringtosql(Transacao));
    Executesql('update movestoque set move_status=''C'' where move_transacao='+stringtosql(Transacao));
    Executesql('update movbase set movb_status=''C'' where movb_transacao='+stringtosql(Transacao));
// 23.07.20 - - Novicarnes - apropriacao de despesas...
// 28.08.20
//    if ( Edvezesap.asinteger > 0 ) then
// 08.12.20
   campo := Sistema.Getdicionario('apropriacoes','APRO_COMV_CODIGO');
   if campo.Tipo<>'' then

       Executesql('update apropriacoes set apro_status=''C'' where apro_transacao='+stringtosql(Transacao));

// 15.06.11
    if OP='A' then begin
      Executesql('update pendencias set pend_status=''C'' where pend_transacao='+stringtosql(Transacao));
      Executesql('update movfin set movf_status=''C'' where movf_transacao='+stringtosql(Transacao));
    end;
    QMovestoque.close;
// c26.07.05 - checar se retorna o estoque somente da transacao e da transacao1 nao
    if trim(transacao1)<>'' then begin
      Executesql('update movesto set moes_status=''C'' where moes_transacao='+stringtosql(Transacao1));
      Executesql('update movestoque set move_status=''C'' where move_transacao='+stringtosql(Transacao1));
      Executesql('update movbase set movb_status=''C'' where movb_transacao='+stringtosql(Transacao1));
      Executesql('update pendencias set pend_status=''C'' where pend_transacao='+stringtosql(Transacao1));
      Executesql('update movfin set movf_status=''C'' where movf_transacao='+stringtosql(Transacao1));
    end;
// 20.06.16
    if (Global.topicos[1043]) and ( transacaocontax<>'' )  then begin
       FGeral.SistemaContax.ExecuteDirect('update movcon set mcon_status = ''C'' where mcon_transacao = '+Stringtosql(transacaocontax) );
    end;
    Freeandnil(QMovestoque);
    Sistema.Commit;
    Sistema.Endprocess('');

end;

procedure TFNotaCompra.EdTran_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
   FGeral.Limpaedit(EdTran_codigo,key);
end;

procedure TFNotaCompra.Edmens_codigoValidate(Sender: TObject);
begin
  if not Arq.TMensagensNF.active then Arq.TMensagensNF.open;
  if Edmens_codigo.asinteger>0 then begin
    if not Arq.Tmensagensnf.locate('mens_codigo',Edmens_codigo.text,[]) then
       Edmens_codigo.invalid('Codigo de mensagem n�o encontrado')
    else begin
       if (Edmensagem.isempty) or ( (Edmens_codigo.text<>EdMens_codigo.oldvalue) and (trim(EdMens_codigo.oldvalue)<>'') )then
         EdMensagem.text:=Arq.Tmensagensnf.fieldbyname('mens_descricao').asstring;
    end;
  end;

end;

procedure TFNotaCompra.EdVencimento2ExitEdit(Sender: TObject);
begin
  GridParcelas2.Cells[GridParcelas2.Col,GridParcelas2.Row]:=DateToStr_(EdVencimento2.AsDate);
  GridParcelas2.SetFocus;
  EdVencimento2.Visible:=False;

end;

procedure TFNotaCompra.EdParcela2ExitEdit(Sender: TObject);
begin
  GridParcelas2.Cells[GridParcelas2.Col,GridParcelas2.Row]:=Transform(EdParcela2.AsFloat,f_cr);
  GridParcelas2.SetFocus;
  EdParcela2.Visible:=False;

end;

procedure TFNotaCompra.GridParcelas2DblClick(Sender: TObject);
begin
  AtivaEditsParcelas2;

end;

procedure TFNotaCompra.AtivaEditsParcelas2;
begin
  if GridParcelas2.Col=0 then begin
     EdVencimento2.Top:=GridParcelas2.TopEdit;
     EdVencimento2.Left:=GridParcelas2.LeftEdit+5;
     EdVencimento2.Text:=StrToStrNumeros(GridParcelas2.Cells[GridParcelas2.Col,GridParcelas2.Row]);
//     EdVencimento.Text:=GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row];
     EdVencimento2.Visible:=True;
     EdVencimento2.SetFocus;
  end else if GridParcelas2.Col=1 then begin
     EdParcela2.Top:=GridParcelas2.TopEdit;
     EdParcela2.Left:=GridParcelas2.LeftEdit+6;
     EdParcela2.SetValue(TextToValor(GridParcelas2.Cells[GridParcelas2.Col,GridParcelas2.Row]));
     EdParcela2.Visible:=True;
     EdParcela2.SetFocus;
  end;

end;

procedure TFNotaCompra.GridParcelas2KeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#13 then
    GridParcelas2DblClick(FNotaCompra);

end;

procedure TFNotaCompra.EdTotalservicosValidate(Sender: TObject);
begin
// 10.05.06
//     if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodRetornoInd)>0 then begin
// 04.11.2021  - 04.11.2021
     if Ansipos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodRetornoInd+';'+
                 Global.codPrestacaoServicosE )>0 then begin

        if EdTotalservicos.ascurrency<=0 then begin

          EdTotalServicos.INvalid('Obrigat�rio digitar os valor dos servi�os');

        end;

     end;

end;

procedure TFNotaCompra.EdVencimentoValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin
   if not Global.Usuario.OutrosAcessos[0320] then begin
     if FCondpagto.GetAvPz(EdFpgt_codigo.text)='V' then begin
       if EdVencimento.AsDate>0 then begin
         if Edvencimento.asdate<Sistema.hoje then
            EdVencimento.invalid('Nota a vista somente com data atual');
       end;
     end;
   end;
// 22.07.20
   if Datetoano(EDvencimento.asdate,true) < ( Datetoano(sistema.hoje,true) - 20 ) then
            EdVencimento.invalid('Checar Vencimento informado');

end;

procedure TFNotaCompra.EdVencimento2Validate(Sender: TObject);
begin
   if not Global.Usuario.OutrosAcessos[0320] then begin
     if FCondpagto.GetAvPz(EdFpgt_codigo.text)='V' then begin
       if EdVencimento2.AsDate>0 then begin
         if Edvencimento2.asdate<Sistema.hoje then
            EdVencimento2.invalid('Nota a vista somente com data atual');
       end;
     end;
   end;  

end;

function TFNotaCompra.ProcuraGrid(Coluna: integer;  Pesquisa: string ; Colunatam:integer=0 ; tam:integer=0 ;
         colunacor:integer=0 ; cor:integer=0 ; colunacopa:integer=0 ; copa:integer=0): integer;
var p:integer;
begin
  result:=0;seq:=0;
  if (colunatam>0) and (colunacor>0) then begin
    if colunacopa=0 then begin
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

procedure TFNotaCompra.EdCodcopaValidate(Sender: TObject);
begin
//  if FGeral.ProcuraGrid(0,EdProduto.text,Grid,Grid.getcolumn('move_tama_codigo'),EdCodtamanho.asinteger,
//                        Grid.getcolumn('move_tama_codigo'),Edcodcor.asinteger) > 0 then begin
  if ProcuraGrid(0,EdProduto.text,Grid.getcolumn('move_tama_codigo'),EdCodtamanho.asinteger,
                        Grid.getcolumn('move_core_codigo'),Edcodcor.asinteger,grid.getcolumn('move_copa_codigo'),Edcodcopa.asinteger) > 0 then begin
    if pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Devolucao ) = 0 then
// criar esta funcao
//  if FGeral.ProcuraGridGrade(0,EdProduto.text,Grid) > 0 then
      Edcodcopa.INvalid('Produto j� digitado.  Excluir e incluir');
  end;

end;

procedure TFNotaCompra.EdPedidoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////
var QPedido:TSqlquery;

   procedure PedidotoGrid(Q:TSqlquery);
   ///////////////////////////////////
   var produto:string;
       p:integer;
       tamanho:extended;
       qtde:currency;
   begin
      Grid.Clear;p:=1;
      while not Q.Eof do begin
        produto:=Q.fieldbyname('moco_esto_codigo').Asstring;
        Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p]:=Q.fieldbyname('moco_esto_codigo').Asstring;
        Grid.Cells[Grid.Getcolumn('move_tama_codigo'),Abs(p)]:=Q.fieldbyname('moco_tama_codigo').Asstring;
        Grid.Cells[Grid.Getcolumn('move_core_codigo'),Abs(p)]:=Q.fieldbyname('moco_core_codigo').Asstring;
        Grid.Cells[Grid.Getcolumn('move_copa_codigo'),Abs(p)]:=''; //Q.fieldbyname('move_copa_codigo').Asstring;
        Grid.Cells[Grid.Getcolumn('cor'),Abs(p)]:=FCores.GetDescricao(Q.fieldbyname('moco_core_codigo').Asinteger);
        Grid.Cells[Grid.Getcolumn('tamanho'),Abs(p)]:=FTamanhos.Getdescricao(Q.fieldbyname('moco_tama_codigo').Asinteger);
        Grid.Cells[Grid.Getcolumn('copa'),Abs(p)]:='';  // FCopas.GetDescricao(Q.fieldbyname('move_copa_codigo').Asinteger);
        Grid.Cells[Grid.Getcolumn('esto_descricao'),p]:=FEstoque.GetDescricao(produto);
        Grid.Cells[Grid.Getcolumn('move_cst'),p]:=Q.fieldbyname('moco_cst').Asstring;
        Grid.Cells[Grid.Getcolumn('move_aliicms'),p]:=transform(Q.fieldbyname('moco_aliicms').Ascurrency,'#0.0');
        Grid.Cells[Grid.Getcolumn('move_aliipi'),p]:=transform(Q.fieldbyname('moco_aliipi').Ascurrency,'#0.0');
        Grid.Cells[Grid.Getcolumn('esto_unidade'),p]:=FEstoque.GetUnidade(produto);
//        Grid.Cells[Grid.Getcolumn('move_qtde'),p]:=transform(Q.fieldbyname('moco_qtde').Ascurrency,f_qtdestoque);
// 23.09.08 - multiplica qtde de barras pela metragem da barra
        if (Q.fieldbyname('moco_tama_codigo').AsInteger>0) then
          tamanho:=FTamanhos.GetComprimento(Q.fieldbyname('moco_tama_codigo').AsInteger)/1000
        else
          tamanho:=1;
// 05.08.09
        qtde:=Q.fieldbyname('moco_qtde').Ascurrency-Q.fieldbyname('moco_qtderecebida').Ascurrency;
//        if (Q.fieldbyname('moco_tama_codigo').AsInteger>0) and (EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodCompraIndustria)  then
// 24.10.09 - para fazer em qq compra de perfil
        if (Q.fieldbyname('moco_tama_codigo').AsInteger>0) and ( FEstoque.GetGrupo(Q.fieldbyname('moco_esto_codigo').Asstring)=FGeral.GetConfig1AsInteger('GRUPOPERF') )  then
          Grid.Cells[Grid.Getcolumn('move_qtde'),p]:=transform(qtde*Tamanho,f_qtdestoque)
        else
          Grid.Cells[Grid.Getcolumn('move_qtde'),p]:=transform(qtde,f_qtdestoque);
        Grid.Cells[Grid.Getcolumn('move_pecas'),p]:=transform(Q.fieldbyname('moco_pecas').Ascurrency,f_qtdestoque);
// 23.09.08 - multiplica qtde de barras pela metragem da barra
//        if (Q.fieldbyname('moco_tama_codigo').AsInteger>0) and (EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodCompraIndustria)  then begin
// 24.10.09 - para fazer em qq compra de perfil
        if (Q.fieldbyname('moco_tama_codigo').AsInteger>0) and (EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodCompraIndustria)  then begin
          Grid.Cells[Grid.Getcolumn('move_venda'),p]:=TRansform(Q.fieldbyname('moco_unitario').AsFloat/tamanho,'###0.00000');
          Grid.Cells[Grid.Getcolumn('valoruni'),p]:=TRansform(Q.fieldbyname('moco_unitario').AsFloat,'###0.00000');
          Grid.Cells[Grid.Getcolumn('total'),p]:=TRansform(Q.fieldbyname('moco_unitario').AsFloat*qtde,f_cr);
        end else begin
          Grid.Cells[Grid.Getcolumn('move_venda'),p]:=TRansform(Q.fieldbyname('moco_unitario').Ascurrency,f_cr);
          Grid.Cells[Grid.Getcolumn('valoruni'),p]:=TRansform(Q.fieldbyname('moco_unitario').Ascurrency,f_cr);
          Grid.Cells[Grid.Getcolumn('total'),p]:=TRansform(Q.fieldbyname('moco_unitario').Ascurrency*qtde,f_cr);
        end;
        Grid.Cells[Grid.Getcolumn('qtdeprev'),p]:=transform(qtde,f_qtdestoque);
//         margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(produto,EdUnid_codigo.text,QFornec.fieldbyname('forn_uf').asstring));
//         codigosit:=FEstoque.GetCodigosituacaotributaria(Produto,EdUnid_codigo.text,QFornec.fieldbyname('forn_uf').asstring);
        Grid.Cells[Grid.Getcolumn('margemlu'),p]:=''; // Transform(margemlucro,f_cr);
        Grid.Cells[Grid.Getcolumn('codigosittrib'),p]:=FSittributaria.GetCodigoCst(Q.fieldbyname('moco_cst').Asstring);
        Grid.Cells[Grid.Getcolumn('codigofis'),p]:='';  // codigofis;
// 16.04.08
        Grid.Cells[Grid.Getcolumn('moco_industrializa'),p]:=Q.fieldbyname('moco_industrializa').AsString;

        inc(p);
        Grid.AppendRow;
        Q.Next;
      end;

   end;

begin
/////////////////////////
   if( not EdPedido.isempty ) and (OP='I') then begin
      QPedido:=Sqltoquery( FGeral.Buscapedcompra(EdPedido.asinteger,'PU;PX;PB','','S') );
      if QPedido.eof then
        EdPedido.invalid('Pedido n�o encontrado')
      else if QPedido.fieldbyname('moco_tipo_codigo').asinteger=EdFornec.AsInteger then begin
// 17.02.11 - tipo DI nao buscar itens no pedido pois ja os itens nas notas escolhidas
       if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoInd ) =0 then
         PedidotoGrid(QPedido)
      end else
        EdPedido.invalid('Pedido pertence ao fornecedor de codigo '+QPedido.fieldbyname('moco_tipo_codigo').asstring);
      FGeral.Fechaquery(QPedido);
   end;
end;

procedure TFNotaCompra.EdFpgt_codigoExitEdit(Sender: TObject);
///////////////////////////////////////////////////////////////////////
begin

  if EdFpgt_codigo.ResultFind<>nil then begin


    if pos( 'X', Uppercase(EdFpgt_codigo.ResultFind.FieldByName('fpgt_prazos').AsString) )>0 then begin

      ParcelamentoLongo;

    // 20.11.19 - A2z - Thais
    end else if Global.Topicos[1367] then begin

        EdCodEqui.SetFocus;
        exit;


    end else

  // 11.05.20
      if (Global.Topicos[1513])
         and  ( Ansipos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.codcompraprodutor)=0)
         then begin

         bcodbarraClick(self);
         gridcodbarra.setfocus;

      end else

        bgravarclick( self );   // 06.06.07

  end;

end;

procedure TFNotaCompra.EdDescovlrExitEdit(Sender: TObject);
begin
   if EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoVenda then
     bgravarclick(self);

end;

procedure TFNotaCompra.Edcfis_codigoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////
begin
  if Edcfis_codigo.resultfind<>nil then begin
    if (Edcfis_codigo.resultfind.FieldByName('cfis_redubase').ascurrency>0 ) and
       ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodCompraProdutor+';'+Global.CodEntradaProdutor)>0) then
      Edcfis_codigo.Invalid('Tipo de movimento '+Global.CodCompraProdutor+' n�o pode ter redu��o de base de c�lculo')
// 20.04.12
    else if Global.Topicos[1354] then begin
       if pos(EdUnid_codigo.ResultFind.Fieldbyname('unid_simples').asstring,'S;2')>0 then begin
         if (Edcfis_codigo.resultfind.FieldByName('cfis_aliquota').ascurrency<>0 ) then
           Edcfis_codigo.Invalid('Al�quota de Icms n�o pode ser informada em unidade do Simples');
       end;
    end;
  end;
end;

procedure TFNotaCompra.EdPlan_contaValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////////
var Qp : Tsqlquery;
begin

//   if EdPlan_conta.ResultFind<>nil then begin

     if (EdPlan_conta.AsInteger=9999) and (EdDigtotpro.ascurrency>0) then begin

        if OP='I' then
          FRateio.Execute('Valores por Despesa','plano','Plan_conta',EdDigtotpro.ascurrency,'')
        else
          FRateio.Execute('Valores por Despesa','plano','Plan_conta',EdDigtotpro.ascurrency,transacao2)

     end else begin

       Qp := sqltoquery('select * from plano where plan_conta = '+EdPlan_conta.text);
       if Qp.eof then begin

          EdPlan_conta.invalid('Conta n�o encontrada');
          exit;

       end;
   // 24.11.17 - Novicarnes -thais sarna
       PMensagem.Caption     :=Qp.FieldByName('plan_descricao').AsString;
       EdPlan_descricao.text :=Qp.FieldByName('plan_descricao').AsString;

       if ( Qp.FieldByName('plan_tipo').asstring<>'M'  )
          and
          ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring<>Global.codcedulaprodutorural  ) then
         EdPlan_conta.invalid('Somente permitido contas tipo M')

       else if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.codcedulaprodutorural )
            and
               ( Qp.FieldByName('plan_tipo').asstring<>'P'  )
            then

         EdPlan_conta.invalid('Conta para CPR tem que ser tipo P');
  // 22.07.20
         campo := Sistema.GetDicionario('plano','plan_ctaapropriar01');

         if campo.Tipo<>'' then begin

            if Qp.fieldbyname('plan_ctaapropriar01').asinteger > 0 then begin

               EdVezesap.enabled := true;
               EdVezesap.Visible := true;

            end else begin

               EdVezesap.enabled := false;
               EdVezesap.Visible := false;
               EdVezesap.setvalue(0);

            end;
         end;

     end;

//   end;

end;

procedure TFNotaCompra.EdRomaneioValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
type TProdutos=record
  produto:string;
  pesocarcaca,pesovivo:currency;
  vlrunitario,valortotal:extended;
  pecas:integer;
end;

var p,x:integer;
    Lista:Tlist;
    PProdutos:^Tprodutos;
    pesovivozerado:boolean;
    ListaRo:TStringList;

     procedure AtualizaLista;
     //////////////////////////
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
       if QRoma.fieldbyname('movd_pesovivo').Ascurrency=0 then
         pesovivozerado:=true;

       if not achou then begin
          New(PProdutos);
          PProdutos.produto:=QRoma.fieldbyname('movd_esto_codigo').AsString;
          PProdutos.pesocarcaca:=QRoma.fieldbyname('movd_pesocarcaca').Ascurrency;
          PProdutos.pesovivo:=QRoma.fieldbyname('movd_pesovivo').Ascurrency;
//          PProdutos.vlrunitario:=QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15;
// 16.01.08
//          PProdutos.vlrunitario:=FGeral.Arredonda((QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15),6);
// 14.08.18
          PProdutos.vlrunitario:=QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15;
//          PProdutos.vlrunitario:=FGeral.Arredonda((QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15),5);

// 06.09.17 - para nao dar problema no sped de arredondamento
// 15.09.17 - desfeito pois nao fecha valores do Sac com  nfe
//          PProdutos.vlrunitario:=FGeral.Arredonda((QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15),4);
          PProdutos.valortotal:=QRoma.fieldbyname('movd_pesocarcaca').Ascurrency*
                                PProdutos.vlrunitario;
// 14.08.18
          PProdutos.valortotal:=FGeral.Arredonda( PProdutos.valortotal ,2 );
          PProdutos.pecas:=1;
          Lista.Add(PProdutos);

       end else begin

          PProdutos.pesovivo:=PProdutos.pesovivo+QRoma.fieldbyname('movd_pesovivo').Ascurrency;
          PProdutos.pesocarcaca:=PProdutos.pesocarcaca+QRoma.fieldbyname('movd_pesocarcaca').Ascurrency;
//          PProdutos.valortotal:=PProdutos.valortotal+(QRoma.fieldbyname('movd_pesocarcaca').Ascurrency*(QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15));
//          PProdutos.valortotal:=PProdutos.valortotal+(QRoma.fieldbyname('movd_pesocarcaca').Ascurrency*(QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15));
// 16.01.7
//          PProdutos.valortotal:=PProdutos.valortotal+(QRoma.fieldbyname('movd_pesocarcaca').Ascurrency*(FGeral.Arredonda((QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15),6)));
// 14.08.18
          PProdutos.valortotal:=PProdutos.valortotal+
                                ( QRoma.fieldbyname('movd_pesocarcaca').AsFloat*
                                (QRoma.fieldbyname('movd_vlrarroba').AsCurrency/15) ) ;

// 06.09.17 - para nao dar problema no sped de arredondamento
//          PProdutos.valortotal:=PProdutos.valortotal+(QRoma.fieldbyname('movd_pesocarcaca').Ascurrency*(FGeral.Arredonda((QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15),4)));
//          PProdutos.vlrunitario:=PProdutos.valortotal/PProdutos.pesocarcaca;
          PProdutos.vlrunitario:=FGeral.Arredonda( PProdutos.valortotal/PProdutos.pesocarcaca,6 );
          PProdutos.pecas:=PProdutos.pecas+1;
       end;
     end;

     procedure IncluiGrid(x:integer);
     //////////////////////////////////
     var codigosit:integer;
     begin
        Grid.Cells[Grid.Getcolumn('move_esto_codigo'),x]:=PProdutos.produto;
        Grid.Cells[Grid.Getcolumn('move_tama_codigo'),x]:='';
        Grid.Cells[Grid.Getcolumn('move_core_codigo'),x]:='';
        Grid.Cells[Grid.Getcolumn('move_copa_codigo'),x]:='';
        Grid.Cells[Grid.Getcolumn('cor'),Abs(x)]:='';
        Grid.Cells[Grid.Getcolumn('tamanho'),Abs(x)]:='';
        Grid.Cells[Grid.Getcolumn('copa'),Abs(x)]:='';
        Grid.Cells[Grid.Getcolumn('esto_descricao'),x]:=FEstoque.GetDescricao(PProdutos.produto);
//        Grid.Cells[Grid.Getcolumn('move_cst'),x]:='000';
// 03.12.08  - tributado a nfe exige aliquota e valor do icms
        Grid.Cells[Grid.Getcolumn('move_cst'),x]:='051';
        Grid.Cells[Grid.Getcolumn('move_aliicms'),x]:=transform(0,'#0.0');
        Grid.Cells[Grid.Getcolumn('move_aliipi'),x]:=transform(0,'#0.0');
        Grid.Cells[Grid.Getcolumn('esto_unidade'),x]:=FEstoque.GetUnidade(PProdutos.produto);
// 10.10.09 - se fizer nf reclassificacao muda o 'esquema'
        if (EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString=Global.CodCompraProdutor) and ( FGeral.getconfig1asinteger('ConfMovRecla')>0 )
            and ( FGeral.getconfig1asinteger('Clienfrecla')>0 ) and (Global.Topicos[1337] ) then begin
          Grid.Cells[Grid.Getcolumn('move_qtde'),x]:=transform(PProdutos.pesovivo,f_qtdestoque);
          Grid.Cells[Grid.Getcolumn('qtdeprev'),x]:=transform(PProdutos.pesovivo,f_qtdestoque);
          Grid.Cells[Grid.Getcolumn('valoruni'),x]:=transform(PProdutos.valortotal/PProdutos.pesovivo,'##,##0.000000');
          Grid.Cells[Grid.Getcolumn('move_venda'),x]:=TRansform(PProdutos.valortotal/PProdutos.pesovivo,'##,##0.000000');
          PProdutos.valortotal:=(PProdutos.valortotal/PProdutos.pesovivo)*PProdutos.pesovivo;
          Grid.Cells[Grid.Getcolumn('total'),x]:=TRansform(PProdutos.valortotal,f_cr);
        end else begin
          Grid.Cells[Grid.Getcolumn('move_qtde'),x]:=transform(PProdutos.pesocarcaca,f_qtdestoque);
          Grid.Cells[Grid.Getcolumn('qtdeprev'),x]:=transform(PProdutos.pesocarcaca,f_qtdestoque);

          Grid.Cells[Grid.Getcolumn('valoruni'),x]:=transform(PProdutos.vlrunitario,'##,##0.000000');
          Grid.Cells[Grid.Getcolumn('move_venda'),x]:=TRansform(PProdutos.vlrunitario,'##,##0.000000');
// 06.09.17 - 15.09.17
//          Grid.Cells[Grid.Getcolumn('valoruni'),x]:=transform(PProdutos.vlrunitario,'##,##0.0000');
//          Grid.Cells[Grid.Getcolumn('move_venda'),x]:=TRansform(PProdutos.vlrunitario,'##,##0.0000');
          Grid.Cells[Grid.Getcolumn('total'),x]:=TRansform(PProdutos.valortotal,f_cr);
        end;
        Grid.Cells[13,x]:=Transform(0,f_cr);  // margemlucro
//        margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(PProdutos.produto,EdUnid_codigo.text,QFornec.fieldbyname(campoufentidade).asstring));
        codigosit:=FEstoque.GetCodigosituacaotributaria(PProdutos.produto,EdUnid_codigo.text,QFornec.fieldbyname(campoufentidade).asstring);
        Grid.Cells[Grid.Getcolumn('codigosittrib'),x]:=inttostr(codigosit);
//        Grid.Cells[15,x]:='';
// 18.05.14
        Grid.Cells[Grid.Getcolumn('codigofis'),x]:='';
        Grid.Cells[Grid.Getcolumn('move_pecas'),x]:=INttostr(PProdutos.pecas);
// 10.10.09 - - NF Reclassificacao
        Grid.Cells[Grid.Getcolumn('pesovivo'),x]:=transform(PProdutos.pesovivo,f_qtdestoque);
        Grid.Cells[Grid.Getcolumn('pesocarcaca'),x]:=transform(PProdutos.pesocarcaca,f_qtdestoque);
        Grid.AppendRow;
     end;

     function ChecaRomaneios:boolean;
     /////////////////////////////////
     var i:integer;
         lista:tstringlist;
         Q:TSqlquery;
         comdata,semdata:boolean;
     begin
       lista:=Tstringlist.create;
       comdata:=false;semdata:=false;
       strtolista(lista,EdRomaneio.Text,';',true);
       result:=true;
       if Lista.count>1 then begin
          for i:=0 to Lista.count-1 do begin
            if trim(lista[i])<>'' then begin
              Q:=sqltoquery('select mova_datacont from movabate where mova_numerodoc='+lista[i]+' and mova_status=''N'''+
                            ' and mova_unid_codigo='+EdUnid_codigo.assql+' and mova_tipomov='+stringtosql(TipoEntradaAbate));
              if not Q.eof then begin
                if Q.fieldbyname('mova_datacont').asdatetime>1 then
                  comdata:=true
                else
                  semdata:=true;
              end;
              FGeral.FechaQuery(Q);
            end;
          end;
          if (comdata) and (semdata) then begin
            Avisoerro('N�o � permitido escolher entradas de tipos diferentes');
            result:=false;
          end;
       end;
       lista.free;
     end;

begin
////////////////////////////////////////////////////////////////////

   if( not EdRomaneio.isempty ) and (OP='I') then begin
      if not ChecaRomaneios then begin
        EdRomaneio.Invalid('');
        exit;
      end;
// 21.05.18 - novicarnes - compra de produtor juridica se usar xml 'vale o xml'
// 16.08.19 - novicarnes - compra de produtor juridica tem q usar xml E os romaneio pro itens
//            e o xml para poder fazer o manifesto da nota
//      if (not EdArquivoxml.IsEmpty) and (EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').AsString=Global.CodEntradaProdutor) then
//        exit;

      QRoma:=sqltoquery('select * from movabatedet inner join movabate on ( mova_transacao=movd_transacao ) '+
                          ' where '+FGeral.GetIN('mova_numerodoc',EdRomaneio.text,'N')+
                          ' and movd_status=''N'''+
                          ' and movd_tipomov='+stringtosql(TipoEntradaAbate)+
                          ' and mova_situacao=''N'''+
                          ' and mova_tipo_codigo='+EdFornec.assql+
// 07.08.14 - Novicarnes - Angela
                          ' and '+FGeral.GetIN('mova_unid_codigo',Global.CodigoUnidade,'C')+
                          ' and ( mova_notagerada=0 or mova_notagerada is null )'+
                          ' order by movd_esto_codigo');
      if QRoma.eof then
        EdRomaneio.invalid('Entrada n�o encontrada ou com nota de produtor j� feita')
      else begin
        Grid.clear;
        Lista:=TList.create;
        EdDtMovimento.SetDate(QRoma.fieldbyname('mova_datacont').asdatetime);
        pesovivozerado:=false;
// 30.07.15 - 07.08.15
//        if QRoma.fieldbyname('mova_datacont').asdatetime > Global.DataMenorBanco then
//          Edvalorgta.setvalue( Qroma.fieldbyname('mova_vlrgta').ascurrency);
        Edvalorgta.setvalue(0);
        ListaRo:=TStringList.create;
        while not QRoma.eof do begin
// 26.11.15 - pegava o gta somente de um romaneio quando escolhia mais de um para fazer a NP
          if ListaRo.indexof(QRoma.fieldbyname('mova_numerodoc').asstring)=-1 then begin
            if QRoma.fieldbyname('mova_datacont').asdatetime > Global.DataMenorBanco then
              Edvalorgta.setvalue( EdValorgta.ascurrency+ Qroma.fieldbyname('mova_vlrgta').ascurrency );
            ListaRo.Add(QRoma.fieldbyname('mova_numerodoc').asstring);
          end;
          AtualizaLista;
          QRoma.Next;
        end;
        ListaRo.free;
        if (pesovivozerado) and (Global.Topicos[1337] ) then
          EdRomaneio.Invalid('Produto com peso vivo zerado no romaneio.')
        else begin
//       ver se precisa para configurar o CST(codigo) e aliquota de icms(codigo) dentro e fora do estado para entrada de produtor
// joga no grid totalizando por codigo
          x:=1;
          for p:=0 to Lista.count-1 do begin
            PProdutos:=Lista[p];
            Incluigrid(p+1);
          end;
// 01.10.15 - busca a condicao de pagamento no cadastro do prodtuor/cliente
          EdFpgt_codigo.Text:=EdFornec.resultfind.fieldbyname('clie_fpgt_codigo').asstring;
  // atualiza os edits de valores totais da nota
          SetaEditsvalores;
        end;
        Lista.free;
      end;
      FGeral.Fechaquery(QRoma);
   end else if OP='I' then begin
// 18.03.10
      if (EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodCompraProdutor) and ( FGeral.getconfig1asinteger('ConfMovRecla')>0 )
         and ( FGeral.getconfig1asinteger('Clienfrecla')>0 ) and (Global.Topicos[1337])
         then begin
         if EdRomaneio.isempty then begin
            EdRomaneio.invalid('Est� Ativo nota de reclassifica��o.  Obrigat�rio informar romaneio');
         end;
      end;

   end;

end;

procedure TFNotaCompra.EdNfprodutorValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////
begin
   if EdNfprodutor.isempty then exit;
   if trim(copy(EdNfprodutor.text,9,3))<>'' then begin
      if ( pos(',',Ednfprodutor.text)=0 )
      and ( pos(';',Ednfprodutor.text)=0 )
      and ( pos('/',Ednfprodutor.text)=0 )
      and ( pos('.',Ednfprodutor.text)=0 ) then
        EdNfProdutor.invalid('Notas tem que ser separadas por v�rgula, ponto e v�rgula, barra ou ponto')
      else if ( pos(',',Ednfprodutor.text)>0 ) and ( pos(';',Ednfprodutor.text)>0 ) then
        EdNfProdutor.invalid('Permitido SOMENTE UM separador : v�rgula, ponto e v�rgula, barra OU ponto')
      else if ( pos('/',Ednfprodutor.text)>0 ) and ( pos('.',Ednfprodutor.text)>0 ) then
        EdNfProdutor.invalid('Permitido SOMENTE UM separador : v�rgula, ponto e v�rgula, barra OU ponto')
      else if ( pos(',',Ednfprodutor.text)>0 ) and ( pos('/',Ednfprodutor.text)>0 ) then
        EdNfProdutor.invalid('Permitido SOMENTE UM separador : v�rgula, ponto e v�rgula, barra OU ponto')
      else if ( pos(',',Ednfprodutor.text)>0 ) and ( pos('.',Ednfprodutor.text)>0 ) then
        EdNfProdutor.invalid('Permitido SOMENTE UM separador : v�rgula, ponto e v�rgula, barra OU ponto')
      else if ( pos(';',Ednfprodutor.text)>0 ) and ( pos('/',Ednfprodutor.text)>0 ) then
        EdNfProdutor.invalid('Permitido SOMENTE UM separador : v�rgula, ponto e v�rgula, barra OU ponto')
      else if ( pos(';',Ednfprodutor.text)>0 ) and ( pos('.',Ednfprodutor.text)>0 ) then
        EdNfProdutor.invalid('Permitido SOMENTE UM separador : v�rgula, ponto e v�rgula, barra OU ponto');
   end;
end;

procedure TFNotaCompra.EdValidadeformValidate(Sender: TObject);
begin
   if EdValidadeform.asdate<EdDtemissao.asdate then
     EdValidadeform.invalid('Validade do formul�rio deve ser maior que a emiss�o da nota');
end;

procedure TFNotaCompra.EdNotascompraValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////
var Q,QCL:TSqlquery;
    p,i,x,codigosit:integer;
    produto,codigofis:string;
    margemlucro,vlritem,unitario,aqtde:currency;
    DataInicio:TDatetime;

    procedure InicializaServicos;
    //////////////////////////////
    var i:integer;
        Lista:Tstringlist;
        Q:TSqlquery;
    begin
      Lista:=TStringlist.create;
      strtolista(Lista,EdNotascompra.text,';',true);
      GridServicos.Clear;
      for i:=0 to Lista.count-1 do begin
        if trim(Lista[i])<>'' then begin
          Q:=sqltoquery('select moes_numerodoc from movesto where moes_transacao='+stringtosql(lista[i]) );
          if not Q.Eof then begin
            GridServicos.Cells[Gridservicos.getcolumn('move_numerodoc'),i+1]:=Q.fieldbyname('moes_numerodoc').AsString;
            GridServicos.Appendrow;
          end;
          FGeral.fechaquery(Q);
        end;
      end;
      Lista.free;

    end;

    function GetQtdeJaRecebida(produto:string;codcor:integer;codtam:integer):currency;
    ///////////////////////////////////////////////////////////////////////////////
    var qtde:currency;
    begin
      qtde:=0;
//      if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring<>Global.CodCompraRemessaFutura ) then begin
// 31.10.11
      if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodCompraRemessaFutura+';'+Global.CodRetornoRemessaConserto )=0 then begin
         result:=qtde;
         exit;
      end;
      QCl.First;
      while not QCl.eof do begin
        if Qcl.fieldbyname('move_esto_codigo').asstring=produto then begin
          if (codcor>0) and (codtam>0) then begin
            if (codcor=Qcl.fieldbyname('move_core_codigo').asinteger) and
               (codtam=Qcl.fieldbyname('move_tama_codigo').asinteger) then
               qtde:=qtde+Qcl.fieldbyname('move_qtde').ascurrency;
          end else if (codcor>0) then begin
            if (codcor>0) and (codcor=Qcl.fieldbyname('move_core_codigo').asinteger) then
               qtde:=qtde+Qcl.fieldbyname('qtde').ascurrency;
          end else if (codtam>0) then begin
            if (codtam>0) and (codtam=Qcl.fieldbyname('move_tama_codigo').asinteger) then
               qtde:=qtde+Qcl.fieldbyname('qtde').ascurrency;
          end else
               qtde:=qtde+Qcl.fieldbyname('qtde').ascurrency;
        end;
        QCL.Next;
      end;
      result:=qtde;
    end;


begin
////////////////////////////////
  if OP<>'I' then exit;
  transacoescompra:=EdNotasCompra.text;
  if transacoescompra='' then exit;
// 21.10.16 - Novicarnes - Rose+Thais - para usar os dados do xmls q ja vem certinho
  if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodCompraRemessaFutura )
     and
     ( not EdArquivoxml.IsEmpty )
    then exit;

  if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoInd ) then
//    tipomov:=Global.CodCompraIndustria+';'+Global.CodRemessaInd
// 17.02.11  - Abra - Robson -
    tipomov:=Global.CodCompraIndustria
// 31.10.11 - Abra Aluminios
  else if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodRetornoRemessaConserto ) then
    tipomov:=Global.CodRemessaConserto
// 14.03.12 - Abra Aluminios - Amanda
  else if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodRetornoMercDepo ) then
    tipomov:=Global.CodSimplesRemessa
// 10.12.12 - Ju do compras
  else if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodRetornocomServicos ) then
    tipomov:=Global.CodDevolucaoInd
  else
    tipomov:=Global.CodCompraFutura;
  Datainicio:=Sistema.hoje-360;  //   90;  // revisar este prazo 90-360 em 11.03.09
  if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoInd ) or
     ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodDevolucaoCompra ) or
// 31.10.11
     ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodRetornoRemessaConserto ) or
// 16.03.12
     ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodRetornoMercDepo ) or
     ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodCompraRemessaFutura ) or
// 10.12.12 - Ju do compras
     ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodRetornocomServicos )
     then begin
//    Q:=sqltoquery('select move_esto_codigo,esto_unidade,move_tama_codigo,move_core_codigo,move_core_codigoind,move_cst,move_aliicms,move_aliipi,sum(move_qtde) as qtde,sum(move_qtde*move_venda) as totalitem,sum(move_pecas) as pecas'+
// 14.07.09
    Q:=sqltoquery('select move_esto_codigo,esto_unidade,move_tama_codigo,move_core_codigo,move_core_codigoind,move_cst,move_aliicms,move_aliipi,sum(move_qtde) as qtde,sum(move_qtde*move_venda) as totalitem,sum(move_pecas) as pecas'+
                  ' from movestoque inner join estoque on ( move_esto_codigo=esto_codigo ) where '+fGeral.GetIN('move_transacao',TransacoesCompra,'C')+
                  ' and move_status=''N'' and '+FGeral.GetIN('move_tipomov',tipomov,'C')+
                  ' group by move_esto_codigo,esto_unidade,move_tama_codigo,move_core_codigo,move_core_codigoind,move_cst,move_aliicms,move_aliipi');
    if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodCompraRemessaFutura ) then begin
// buscar as outras 'entradas de remessa futura' para ir deduzindo..
      QCL:=sqltoquery('select move_esto_codigo,esto_unidade,move_tama_codigo,move_core_codigo,move_cst,move_aliicms,move_aliipi,sum(move_qtde) as qtde,sum(move_qtde*move_venda) as totalitem,sum(move_pecas) as pecas'+
                  ' from movestoque inner join estoque on ( move_esto_codigo=esto_codigo ) '+
                  ' where move_tipo_codigo='+EdFornec.assql+' and move_datamvto>='+DatetoSql(Datainicio)+
                  ' and move_status=''N'' and move_tipomov='+Stringtosql(Global.CodCompraRemessaFutura)+
                  ' group by move_esto_codigo,esto_unidade,move_tama_codigo,move_core_codigo,move_cst,move_aliicms,move_aliipi');
// buscar as outros retorno de remessas de conserto deste fornecedor para ir deduzindo..
// que ja retornaram
    end else if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodRetornoRemessaConserto ) then begin
      Datainicio:=Sistema.hoje-90;
      QCL:=sqltoquery('select move_esto_codigo,esto_unidade,move_tama_codigo,move_core_codigo,move_cst,move_aliicms,move_aliipi,sum(move_qtde) as qtde,sum(move_qtde*move_venda) as totalitem,sum(move_pecas) as pecas'+
                  ' from movestoque inner join estoque on ( move_esto_codigo=esto_codigo ) '+
                  ' where move_tipo_codigo='+EdFornec.assql+' and move_datamvto>='+DatetoSql(Datainicio)+
                  ' and move_status=''N'' and move_tipomov='+Stringtosql(Global.CodRetornoRemessaConserto)+
                  ' group by move_esto_codigo,esto_unidade,move_tama_codigo,move_core_codigo,move_cst,move_aliicms,move_aliipi');
    end;
    Grid.Clear;p:=1;
    while not Q.Eof do begin
      produto:=Q.fieldbyname('move_esto_codigo').Asstring;
      aqtde:=GetQtdeJaRecebida(Q.fieldbyname('move_esto_codigo').Asstring,Q.fieldbyname('move_core_codigo').AsINteger,Q.fieldbyname('move_tama_codigo').AsInteger);
      if Q.fieldbyname('qtde').Ascurrency-aqtde>0 then begin
        Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p]:=Q.fieldbyname('move_esto_codigo').Asstring;
        Grid.Cells[Grid.Getcolumn('move_tama_codigo'),Abs(p)]:=Q.fieldbyname('move_tama_codigo').Asstring;
        if Q.fieldbyname('move_core_codigoind').AsInteger>0 then begin
          Grid.Cells[Grid.Getcolumn('move_core_codigo'),Abs(p)]:=Q.fieldbyname('move_core_codigoind').Asstring;
          Grid.Cells[Grid.Getcolumn('cor'),Abs(p)]:=FCores.GetDescricao(Q.fieldbyname('move_core_codigoind').Asinteger);
        end else begin
          Grid.Cells[Grid.Getcolumn('move_core_codigo'),Abs(p)]:=Q.fieldbyname('move_core_codigo').Asstring;
          Grid.Cells[Grid.Getcolumn('cor'),Abs(p)]:=FCores.GetDescricao(Q.fieldbyname('move_core_codigo').Asinteger);
        end;
        Grid.Cells[Grid.Getcolumn('move_copa_codigo'),Abs(p)]:=''; //Q.fieldbyname('move_copa_codigo').Asstring;
        Grid.Cells[Grid.Getcolumn('tamanho'),Abs(p)]:=FTamanhos.Getdescricao(Q.fieldbyname('move_tama_codigo').Asinteger);
        Grid.Cells[Grid.Getcolumn('copa'),Abs(p)]:='';  // FCopas.GetDescricao(Q.fieldbyname('move_copa_codigo').Asinteger);
        Grid.Cells[Grid.Getcolumn('esto_descricao'),p]:=FEstoque.GetDescricao(produto);
        Grid.Cells[Grid.Getcolumn('move_cst'),p]:=Q.fieldbyname('move_cst').Asstring;
        Grid.Cells[Grid.Getcolumn('move_aliicms'),p]:=transform(Q.fieldbyname('move_aliicms').Ascurrency,'#0.0');
        Grid.Cells[Grid.Getcolumn('move_aliipi'),p]:=transform(Q.fieldbyname('move_aliipi').Ascurrency,'#0.0');
        Grid.Cells[Grid.Getcolumn('esto_unidade'),p]:=Q.fieldbyname('esto_unidade').asstring;
        Grid.Cells[Grid.Getcolumn('move_qtde'),p]:=transform(Q.fieldbyname('qtde').Ascurrency-aqtde,f_qtdestoque);
        Grid.Cells[Grid.Getcolumn('move_pecas'),p]:=transform(Q.fieldbyname('pecas').Ascurrency,f_qtdestoque);

        Grid.Cells[Grid.Getcolumn('valoruni'),p]:=TRansform(Q.fieldbyname('totalitem').Ascurrency/(Q.fieldbyname('qtde').Ascurrency),'###0.00000');
        Grid.Cells[Grid.Getcolumn('move_venda'),p]:=TRansform(Q.fieldbyname('totalitem').Ascurrency/(Q.fieldbyname('qtde').Ascurrency),'###0.00000');

        Grid.Cells[Grid.Getcolumn('qtdeprev'),p]:=transform(Q.fieldbyname('qtde').Ascurrency-aqtde,f_qtdestoque);
//        Grid.Cells[Grid.Getcolumn('total'),p]:=TRansform(Q.fieldbyname('totalitem').Ascurrency,f_cr);
        Grid.Cells[Grid.Getcolumn('total'),p]:=TRansform( (Q.fieldbyname('totalitem').Ascurrency/(Q.fieldbyname('qtde').Ascurrency))*(Q.fieldbyname('qtde').Ascurrency-aqtde),f_cr);
        margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(produto,EdUnid_codigo.text,QFornec.fieldbyname(campoufentidade).asstring));
        codigosit:=FEstoque.GetCodigosituacaotributaria(Produto,EdUnid_codigo.text,QFornec.fieldbyname(campoufentidade).asstring);
        Grid.Cells[Grid.Getcolumn('margemlu'),p]:=Transform(margemlucro,f_cr);
        Grid.Cells[Grid.Getcolumn('codigosittrib'),p]:=inttostr(codigosit);
        Grid.Cells[Grid.Getcolumn('codigofis'),p]:=codigofis;
        inc(p);
        Grid.AppendRow;
      end;
      Q.Next;
    end;
// 10.12.2012
// 10.12.12 - Ju do compras
    if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodRetornocomServicos )then
      InicializaServicos;

  end else if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodRetornocomServicos ) then begin
// buscar cada nota para multiplicar pelo unitario do servico informado
// alimentar o grid , caso o produto ja tiver somar o valor total e ir 'recalculando o unitario'...
    InicializaServicos;
//    bservicosclick(self);
  end;
  SetaEditsValores;
end;

procedure TFNotaCompra.ZeraGridServicos;
var p:integer;
begin
  for p:=1 to GridServicos.rowcount-1 do begin
    Gridservicos.cells[GridServicos.GetColumn('move_numerodoc'),p]:='';
    Gridservicos.cells[GridServicos.GetColumn('move_venda'),p]:='';
  end;
end;

procedure TFNotaCompra.bservicosClick(Sender: TObject);
begin
   PServicos.Visible:=true;
   PServicos.Enabled:=true;
   GridServicos.SetFocus;
end;

procedure TFNotaCompra.bfechaservicosClick(Sender: TObject);
//////////////////////////////////////////////////////////////
var i,p,x,codigosit:integer;
    Q:TSqlquery;
    vlritem,margemlucro,totalpesometros:currency;
    produto,codigofis:string;
    unitario:extended;


    function TemnoGrid(codigo:string):integer;
    ////////////////////////////////////////////
    var c:integer;
    begin
      result:=-1;
//      for c:=1 to Grid.rowcount do begin
// 04.03.10
      for c:=1 to Grid.rowcount+1 do begin
        if trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),c])<>'' then begin
           if trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),c])=codigo then begin
// 01.03.10
//         if trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),c])=trim(codigo) then begin
             result:=c;
             break;
           end;
        end;
      end;
    end;

    function ValidaGridServicos:boolean;
    ///////////////////////////////////////////
    var i:integer;
    begin
      result:=true;
      for i:=1 to Gridservicos.rowcount do begin
        if trim(GridServicos.Cells[Gridservicos.getcolumn('move_numerodoc'),i])<>'' then begin
           if trim(GridServicos.Cells[Gridservicos.getcolumn('move_venda'),i])='' then begin
             Avisoerro('Nota '+GridServicos.Cells[Gridservicos.getcolumn('move_numerodoc'),i]+' sem servi�o digitado');
             result:=false;
             break;
           end;
        end;
      end;
    end;

    function GetValorServicos(nota:string):currency;
    //////////////////////////////////////////////////
    var i:integer;
    begin
      result:=0;
      for i:=1 to Gridservicos.rowcount do begin
        if trim(GridServicos.Cells[Gridservicos.getcolumn('move_numerodoc'),i])<>'' then begin
           if trim(GridServicos.Cells[Gridservicos.getcolumn('move_numerodoc'),i])=trim(nota) then begin
             result:=Texttovalor(GridServicos.Cells[Gridservicos.getcolumn('move_venda'),i]);
//             result:=strtofloat(GridServicos.Cells[Gridservicos.getcolumn('move_venda'),i]);
//             result:=strtofloatdef(GridServicos.Cells[Gridservicos.getcolumn('move_venda'),i],0.0,'###0.00000');
             break;
           end;
        end;
      end;
    end;

// 21.01.10 - viagem...somar os metros mesmo que � a unidade de controle do estoque de perfis
    function GetPesoMetro:currency;
    ////////////////////////////////
    var c:integer;
        peso,total:currency;
        Q2:TSqlquery;
    begin
      total:=0;
      Q2:=sqltoquery('select move_esto_codigo,esto_unidade,move_tama_codigo,move_core_codigo,move_cst,move_aliicms,move_aliipi,move_qtde as qtde,move_pecas as pecas,moes_pedido,esto_peso'+
                    ' from movestoque inner join estoque on ( move_esto_codigo=esto_codigo )'+
                    ' inner join movesto on ( moes_transacao=move_transacao )'+
                    ' where '+fGeral.GetIN('move_transacao',TransacoesCompra,'C')+
//                    ' and move_numerodoc='+stringtosql(GridServicos.Cells[GridServicos.getcolumn('move_numerodoc'),i])+
                    ' and move_status=''N'''+
//                   ' and '+FGeral.GetIN('move_tipomov',Global.CodCompraIndustria+';'+Global.CodRemessaInd,'C')+
// 10.12.12 - Ju do compras
                    ' and '+FGeral.GetIN('move_tipomov',Global.CodCompraIndustria+';'+Global.CodRemessaInd+';'+Global.CodDevolucaoInd,'C')+
                    ' order by move_numerodoc');
      while not Q2.eof do begin
//        peso:=FEstoque.GetPeso(Q2.fieldbyname('move_esto_codigo').asstring);
//        if peso>0 then
//          total:=total+(Q2.fieldbyname('qtde').ascurrency*peso)
//        else
          total:=total+Q2.fieldbyname('qtde').ascurrency;

        Q2.Next;
      end;
      FGeral.FechaQuery(Q2);
      result:=total;
    end;

begin
//////////////////////////////////////////////////////////////////////

  if ValidaGridServicos then begin
      Grid.Clear;
// 21.01.10 - rateio 'mais correto' do peso*metros do servi�os sobre os perfis...
      totalpesometros:=GetPesoMetro;

// esta 'viagem de peso metros' s� 'phode' as notas..somado em metros pra ratear certo
      if totalpesometros>0 then
//        unitario:=EdDigTotalnf.ascurrency/totalpesometros
        unitario:=fGEral.Arredonda( EdDigTotalnf.ascurrency/totalpesometros,6 )
      else begin
        Avisoerro('Total de metros vezes peso zerado.  Verificar');
        exit;
      end;

      p:=1;
      for i:=1 to GridServicos.RowCount do begin
//        if trim(GridServicos.cells[GridServicos.getcolumn('move_numerodoc'),i])='' then break;
// 04.03.10
        if strtointdef(GridServicos.cells[GridServicos.getcolumn('move_numerodoc'),i],0)=0 then break;
        Q:=sqltoquery('select move_esto_codigo,move_numerodoc,esto_unidade,move_tama_codigo,move_core_codigo,move_cst,move_aliicms,move_aliipi,move_qtde as qtde,move_pecas as pecas,moes_pedido,esto_peso'+
                    ' from movestoque inner join estoque on ( move_esto_codigo=esto_codigo )'+
                    ' inner join movesto on ( moes_transacao=move_transacao )'+
                    ' where '+fGeral.GetIN('move_transacao',TransacoesCompra,'C')+
                    ' and move_numerodoc='+stringtosql(GridServicos.Cells[GridServicos.getcolumn('move_numerodoc'),i])+
                    ' and move_status=''N'''+
//                    ' and '+FGeral.GetIN('move_tipomov',Global.CodCompraIndustria+';'+Global.CodRemessaInd,'C')+
// 10.12.12 - Ju do compras
                    ' and '+FGeral.GetIN('move_tipomov',Global.CodCompraIndustria+';'+Global.CodRemessaInd+';'+Global.CodDevolucaoInd,'C')+
                    ' order by move_numerodoc');
//        p:=1;
// 04.03.10 - Abra - Fran - em cada nota marcada 'inicializava o grid'..pss
        while not Q.Eof do begin
          produto:=Q.fieldbyname('move_esto_codigo').Asstring;
          x:=TemnoGrid(produto);
          if x=-1 then begin
            Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p]:=trim(Q.fieldbyname('move_esto_codigo').Asstring);
            Grid.Cells[Grid.Getcolumn('move_tama_codigo'),Abs(p)]:=Q.fieldbyname('move_tama_codigo').Asstring;
            Grid.Cells[Grid.Getcolumn('move_core_codigo'),Abs(p)]:=Q.fieldbyname('move_core_codigo').Asstring;
            Grid.Cells[Grid.Getcolumn('move_copa_codigo'),Abs(p)]:=''; //Q.fieldbyname('move_copa_codigo').Asstring;
            Grid.Cells[Grid.Getcolumn('cor'),Abs(p)]:=FCores.GetDescricao(Q.fieldbyname('move_core_codigo').Asinteger);
            Grid.Cells[Grid.Getcolumn('tamanho'),Abs(p)]:=FTamanhos.Getdescricao(Q.fieldbyname('move_tama_codigo').Asinteger);
            Grid.Cells[Grid.Getcolumn('copa'),Abs(p)]:='';  // FCopas.GetDescricao(Q.fieldbyname('move_copa_codigo').Asinteger);
            Grid.Cells[Grid.Getcolumn('esto_descricao'),p]:=FEstoque.GetDescricao(produto);
            Grid.Cells[Grid.Getcolumn('move_cst'),p]:=Q.fieldbyname('move_cst').Asstring;
            Grid.Cells[Grid.Getcolumn('move_aliicms'),p]:='';  //transform(Q.fieldbyname('move_aliicms').Ascurrency,'#0.0');
            Grid.Cells[Grid.Getcolumn('move_aliipi'),p]:='';  // transform(Q.fieldbyname('move_aliipi').Ascurrency,'#0.0');
            Grid.Cells[Grid.Getcolumn('esto_unidade'),p]:=Q.fieldbyname('esto_unidade').asstring;
            Grid.Cells[Grid.Getcolumn('move_qtde'),p]:=transform(Q.fieldbyname('qtde').Ascurrency,f_qtdestoque);
            Grid.Cells[Grid.Getcolumn('move_pecas'),p]:=transform(Q.fieldbyname('pecas').Ascurrency,f_qtdestoque);

//            unitario:=GetValorServicos(Q.fieldbyname('move_numerodoc').AsString);

// mudar aqui pra considerar o peso do metro de cada perfil
//            vlritem:=unitario*Q.fieldbyname('qtde').Ascurrency;
// 22.10.09
//            vlritem:=unitario*Q.fieldbyname('qtde').Ascurrency*Q.fieldbyname('esto_peso').Ascurrency;
// 08.12.09 - senao 'nao fica claro' na nota como chega no valor do item..
// 21.01.10  - refeito
            if Q.fieldbyname('esto_peso').Ascurrency>0 then
//              unitario:=unitario*Q.fieldbyname('esto_peso').Ascurrency;
//              vlritem:=unitario*Q.fieldbyname('qtde').Ascurrency*Q.fieldbyname('esto_peso').Ascurrency
              vlritem:=unitario*Q.fieldbyname('qtde').Ascurrency
            else
              vlritem:=unitario*Q.fieldbyname('qtde').Ascurrency;
            Grid.Cells[Grid.Getcolumn('move_venda'),p]:=TRansform(unitario,'###0.00000');
            Grid.Cells[Grid.Getcolumn('qtdeprev'),p]:=transform(Q.fieldbyname('qtde').Ascurrency,f_qtdestoque);
            Grid.Cells[Grid.Getcolumn('valoruni'),p]:=TRansform(unitario,'###0.00000');
            Grid.Cells[Grid.Getcolumn('total'),p]:=TRansform(vlritem,f_cr);
            margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(produto,EdUnid_codigo.text,QFornec.fieldbyname('forn_uf').asstring));
            codigosit:=FEstoque.GetCodigosituacaotributaria(Produto,EdUnid_codigo.text,QFornec.fieldbyname('forn_uf').asstring);
            Grid.Cells[Grid.Getcolumn('margemlu'),p]:=Transform(margemlucro,f_cr);
            Grid.Cells[Grid.Getcolumn('codigosittrib'),p]:=inttostr(codigosit);
            Grid.Cells[Grid.Getcolumn('codigofis'),p]:=codigofis;
            Grid.Cells[Grid.Getcolumn('moco_industrializa'),p]:=FPedcompra.GetSeIndustrializa(Q.fieldbyname('moes_pedido').asinteger,Q.fieldbyname('move_esto_codigo').Asstring,Q.fieldbyname('move_core_codigo').AsInteger);

//            Sistema.SetMessage('Incluindo codigo '+produto+' na linha '+inttostr(p));

            inc(p);
            Grid.AppendRow;
///            Grid.RowCount:=Grid.RowCount+1;

          end else begin  // ja tem no grid - somar e recalcular

            Grid.Cells[Grid.Getcolumn('move_qtde'),x]:=transform( texttovalor(Grid.Cells[Grid.Getcolumn('move_qtde'),x])+Q.fieldbyname('qtde').Ascurrency,f_qtdestoque);
            Grid.Cells[Grid.Getcolumn('move_pecas'),x]:=transform( texttovalor(Grid.Cells[Grid.Getcolumn('move_pecas'),x]) +Q.fieldbyname('pecas').Ascurrency,f_qtdestoque);
//            unitario:= GetValorServicos(Q.fieldbyname('move_numerodoc').AsString);
// 08.12.09 - senao 'nao fica claro' na nota como chega no valor do item..
//            if Q.fieldbyname('esto_peso').Ascurrency>0 then
//              unitario:=unitario*Q.fieldbyname('esto_peso').Ascurrency;
            Grid.Cells[Grid.Getcolumn('qtdeprev'),x]:=transform(Q.fieldbyname('qtde').Ascurrency,f_qtdestoque);
//            vlritem:=unitario*Q.fieldbyname('qtde').Ascurrency;                          // pois qtde no grid ja esta somada
            if Q.fieldbyname('esto_peso').Ascurrency>0 then
//              unitario:=unitario*Q.fieldbyname('esto_peso').Ascurrency;
//              vlritem:=unitario*Q.fieldbyname('qtde').Ascurrency*Q.fieldbyname('esto_peso').Ascurrency
              vlritem:=unitario*Q.fieldbyname('qtde').Ascurrency
            else
              vlritem:=unitario*Q.fieldbyname('qtde').Ascurrency;

//            unitario:=(texttovalor(Grid.Cells[Grid.Getcolumn('total'),x])+vlritem )/ (texttovalor(Grid.Cells[Grid.Getcolumn('move_qtde'),x]));
// 05.03.10 - deixar o unitario igual para todos

            Grid.Cells[Grid.Getcolumn('move_venda'),x]:=TRansform(unitario,'###0.0000');
            Grid.Cells[Grid.Getcolumn('valoruni'),x]:=TRansform(unitario,'###0.00000');
            Grid.Cells[Grid.Getcolumn('total'),x]:=TRansform( texttovalor(Grid.Cells[Grid.Getcolumn('total'),x])+vlritem,f_cr);
          end;
          Q.Next;
        end;  // select de cada nota
        FGeral.FechaQuery(Q);
      end;  // gridservicos

      SetaEditsvalores;
      EdPort_codigo.setfocus;


   end;
   PServicos.Visible:=false;
   PServicos.Enabled:=false;

end;

procedure TFNotaCompra.bfichatecnicaClick(Sender: TObject);
////////////////////////////////////////////////////////////////
begin

   FFichaTecnica.Execute('I',Global.UltimaTransacao,Edcodequi.Text);

end;

procedure TFNotaCompra.EdServicoExitEdit(Sender: TObject);
begin
  GridServicos.Cells[GridServicos.Col,GridServicos.Row]:=Transform(EdServico.AsFloat,'###0.000000');
  GridServicos.SetFocus;
  EdServico.Visible:=False;

end;

procedure TFNotaCompra.GridServicosKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#13 then
    GridServicosDblClick(FNotaCompra);

end;

procedure TFNotaCompra.GridServicosDblClick(Sender: TObject);
begin
  if GridServicos.col=1 then begin
     EdServico.Top:=GridServicos.TopEdit;
     EdServico.Left:=GridServicos.LeftEdit+6;
     if trim(GridServicos.Cells[GridServicos.Col,GridServicos.Row])<>'' then
       EdServico.SetValue(TextToValor(GridServicos.Cells[GridServicos.Col,GridServicos.Row]))
     else begin
       if EdQtdetotal.asinteger>0 then
         EdServico.SetValue(Eddigtotalnf.ascurrency/EdQtdetotal.asinteger)
       else
         EdServico.SetValue(0);
     end;
     EdServico.Visible:=True;
     EdServico.SetFocus;
  end;
end;

procedure TFNotaCompra.ChecaEditsDesabilitados(s:string);
/////////////////////////////////////////////////////////////
var s1:string;
    i:integer;
begin
  s1:=s;
  if trim(s)='' then begin
    FConfMovimento.SetaItemsEditsEntrada(EdFpgt_descricao);
    for i:=0 to EdFpgt_descricao.Items.Count-1 do begin
       s1:=s1+trim(copy(EdFpgt_descricao.Items.Strings[i],1,20))+';';
    end;
    for i:=0 to FNotaCompra.ComponentCount-1 do begin
      if FNotaCompra.Components[i] is TSqled then begin
        if pos( uppercase(FNotaCompra.Components[i].Name), uppercase(s1) ) >0 then
          TSqlEd( FNotaCompra.Components[i] ) .enabled:=true;
      end;
    end;
    EdFpgt_descricao.Items.clear;
  end else begin
    for i:=0 to FNotaCompra.ComponentCount-1 do begin
      if FNotaCompra.Components[i] is TSqled then begin
        if pos( uppercase(FNotaCompra.Components[i].Name), uppercase(s1) ) >0 then
          TSqlEd( FNotaCompra.Components[i] ) .enabled:=false;
      end;
    end;
// 22.01.2021
    EdTran_codigo.Enabled:=true;
// 30.01.14 - A2z
    if pos( 'DocNFiscal', (s1) ) >0 then begin

        EdArquivoxml.enabled:=false;
        EdTran_codigo.text:='001';
        EdTran_codigo.ValidFind;
        EdTran_codigo.Enabled:=false;
        EdNatf_codigo.Enabled:=false;
        EdNatf_codigo.ValidFind;
        EdPerIcmsNota.Enabled:=false;
        EdPeripi.Enabled:=false;
        EdEmides.Enabled:=false;
        EdEmides.text:='1';
        EdTipodoc.Enabled:=false;
//        EdSerie.Enabled:=false;
//        EdSerie.text:='1';
//        EdValoripi.Enabled:=false;
// 09.10.18 - retirado estes - Giacomoni
        EdPercipi.Enabled:=false;
    end;


  end;
end;


// 08.05.20
procedure TFNotaCompra.GridcodbarraDblClick(Sender: TObject);
///////////////////////////////////////////////////////////////
begin

  if GridCodbarra.Col = GridCodbarra.GetColumn('pend_codbarra') then begin
     EdCodbarra.Top:=GridCodbarra.TopEdit+33;
     EdCodbarra.Left:=GridCodbarra.LeftEdit;
     EdCodbarra.text := GridCodbarra.Cells[GridCodbarra.Col,GridCodBarra.Row];
     EdCodbarra.Visible:=True;
     EdCodbarra.SetFocus;
  end;

end;

procedure TFNotaCompra.GridcodbarraKeyPress(Sender: TObject; var Key: Char);
/////////////////////////////////////////////////////////////////////////////
begin

  if key=#13 then
    GridcodbarraDblClick(FNotaCompra);

end;

procedure TFNotaCompra.GridDblClick(Sender: TObject);
///////////////////////////////////////////////////////////////
var codigo,codigonfe:string;
    ListaProdutos:Tstringlist;
    QNcm:TSqlquery;
    p:integer;
begin
   codigo:=Grid.cells[Grid.getcolumn('move_esto_codigo'),Grid.row];
   codigonfe:=Grid.cells[Grid.getcolumn('produtonfe'),Grid.row];
// 22.03.12
//   if ( Grid.col=grid.getcolumn('move_natf_codigo') ) and ( OP='A') then begin
// 15.03.2023 - Devereda - Alterar cfop de itens q vem junto em bonifica��o
   if ( Grid.col=grid.getcolumn('move_natf_codigo') ) then begin
     EdCfopitem.Top:=Grid.TopEdit;
     EdCfopitem.Left:=Grid.LeftEdit+04;
     EdCfopitem.Enabled:=true;
     EdCfopitem.Visible:=true;
     EdCfopitem.text:=Grid.cells[grid.getcolumn('move_natf_codigo'),grid.row];
     EdCfopitem.setfocus;
// 13.09.12
   end else if ( Grid.col=grid.getcolumn('move_embalagem') ) then begin
     EdEmbalagemitem.Top:=Grid.TopEdit;
     EdEmbalagemitem.Left:=Grid.LeftEdit+04;
     EdEmbalagemitem.Enabled:=true;
     EdEmbalagemitem.Visible:=true;
//     EdEmbalagemitem.text:=Grid.cells[grid.getcolumn('move_embalagem'),grid.row];
     EdEmbalagemitem.setvalue( Texttovalor(Grid.cells[grid.getcolumn('move_embalagem'),grid.row]) );
     EdEmbalagemitem.setfocus;
   end;

   if (trim(codigo)='') and (EdArquivoxml.IsEmpty) then exit;
   if ( pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodCompraRemessaFutura ) =0 )
     and (EdArquivoxml.IsEmpty)
     then exit;
   if Grid.col=grid.getcolumn('move_qtde') then begin
     EdQTdeNf.Top:=Grid.TopEdit;
     EdQTdeNf.Left:=Grid.LeftEdit+16;
     EdQTdeNf.Enabled:=true;
     EdQTdeNf.Visible:=true;
     EdQTdeNf.setvalue( Texttovalor((Grid.cells[grid.getcolumn('move_qtde'),grid.row])) );
     EdQTdeNf.setfocus;
   end else if Grid.col=grid.getcolumn('total') then begin
     EdGridtotal.Top:=Grid.TopEdit;
     EdGridtotal.Left:=Grid.LeftEdit+16;
     EdGridtotal.Enabled:=true;
     EdGridtotal.Visible:=true;
     EdGridtotal.setvalue( Texttovalor((Grid.cells[grid.getcolumn('total'),grid.row])) );
     EdGridtotal.setfocus;
// 15.10.10
   end else if (Grid.col=grid.getcolumn('move_esto_codigo')) and
               ( not EdArquivoxml.isempty ) and ( trim(codigonfe)<>'' )
     then begin
// 11.05.11
     ListaProdutos:=Tstringlist.create;
     if trim(Grid.cells[Grid.getcolumn('ncmnfe'),Grid.row])<>'' then begin
       QNcm:=Sqltoquery('select esto_codigo from estoque inner join codigosipi on ( Cipi_codigo=esto_Cipi_codigo )'+
                        ' where Cipi_codfiscal='+Stringtosql(Grid.cells[Grid.getcolumn('ncmnfe'),Grid.row])+
                        ' order by esto_descricao' );
       While not QNcm.eof do begin
         if ListaProdutos.IndexOf( QNcm.fieldbyname('esto_codigo').asstring )=-1 then
           ListaProdutos.Add( QNcm.fieldbyname('esto_codigo').asstring );
         QNcm.Next;
       end;
       FGeral.FechaQuery(QNcm);
     end;
// 12.03.14 - checando pelo codigo de barra
//////////////////////////////////////////////////
     if trim(Grid.cells[Grid.getcolumn('codigobarra'),Grid.row])<>'' then begin
       QNcm:=Sqltoquery('select esto_codigo from estoque'+
                        ' where esto_codbarra='+Stringtosql(Grid.cells[Grid.getcolumn('codigobarra'),Grid.row]) +
                        ' order by esto_descricao' );
       if not QNcm.eof then ListaProdutos.Clear;
       While not QNcm.eof do begin
         if ListaProdutos.IndexOf( QNcm.fieldbyname('esto_codigo').asstring )=-1 then
           ListaProdutos.Add( QNcm.fieldbyname('esto_codigo').asstring );
         QNcm.Next;
       end;
       FGeral.FechaQuery(QNcm);
     end;
/////////////////////////////////////////////////
     EdCodigoProduto.Items.Clear;
     if Global.Usuario.OutrosAcessos[0334] then
        EdCodigoProduto.ShowForm:='FEstoque'
     else if ListaProdutos.Count>1 then begin
       EdCodigoProduto.ShowForm:='';
       for p:=0 to ListaProdutos.Count-1 do begin
         if trim(ListaProdutos[p])<>'' then begin
           if global.topicos[1206] then
             EdCodigoProduto.Items.Add( strspace(ListaProdutos[p],EdCodigoProduto.ItemsLength)+
                                      ' - '+FEstoque.GetReferencia(ListaProdutos[p])+' - '+FEstoque.GetDescricao( ListaProdutos[p] )  )
           else
             EdCodigoProduto.Items.Add( strspace(ListaProdutos[p],EdCodigoProduto.ItemsLength)+
                                      ' - '+FEstoque.GetDescricao( ListaProdutos[p] )  );
         end;
       end;
     end else if ListaProdutos.Count=1 then begin
       EdCodigoProduto.text:=ListaProdutos[p];
       EdCodigoProduto.ShowForm:='FEstoque';
     end else
       EdCodigoProduto.ShowForm:='FEstoque';

     EdCodigoProduto.Top:=Grid.TopEdit;
     EdCodigoProduto.Left:=Grid.LeftEdit+05;
     EdCodigoProduto.Enabled:=true;
     EdCodigoProduto.Visible:=true;
     EdCodigoProduto.setfocus;
     if ListaProdutos.Count=1 then
       EdCodigoProduto.Valid;
     ListaProdutos.Free;
   end;

end;

procedure TFNotaCompra.GridKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
     Grid.OnDblClick(self)
  else if key=#112 then begin
    Avisoerro('Busca manuten��o');
  end;
end;

procedure TFNotaCompra.EdQtdenfExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////////////////
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

procedure TFNotaCompra.EdQtdenfValidate(Sender: TObject);
begin
  if EdQtdeNf.ascurrency>Texttovalor(Grid.cells[grid.getcolumn('move_qtde'),grid.row]) then
//    EdQtdenf.invalid('Quantidade inv�lida');
    Avisoerro('Checar se a quantidade � v�lida');

end;

procedure TFNotaCompra.EdGridtotalExitEdit(Sender: TObject);
begin
  Grid.cells[grid.getcolumn('total'),grid.row]:=floattostr(EdGridtotal.ascurrency);
  EdGridtotal.Enabled:=false;
  EdGridtotal.Visible:=false;
  SetaEditsvalores;
  Grid.setfocus;

end;

function TFNotaCompra.TodostemComposicao(Grid: TSqlDtGrid;  colunaproduto: integer):boolean;
var p,prodok,prodnok:integer;
    produto:string;
    Q:TSqlquery;
begin
  prodok:=0;prodnok:=0;
  for p:=1 to Grid.RowCount do begin
    produto:=Grid.Cells[colunaproduto,p];
    if trim(produto)<>'' then begin
       Q:=sqltoquery('select cust_esto_codigo from custos where cust_status='+Stringtosql('R')+
                    ' and cust_esto_codigo='+stringtosql(produto)+
                    ' and cust_tipo='+Stringtosql('R') );
       if not Q.eof then
         inc(prodok);
       inc(prodnok);
       FGeral.FechaQuery(Q);
    end;
  end;
  if (prodok>0) and (prodok=prodnok) then
    result:=true
  else
    result:=false;
end;

procedure TFNotaCompra.EdDtMovimentoValidate(Sender: TObject);
begin
  if (EdDtmovimento.asdate<EdDtemissao.asdate) and (not EdDtmovimento.IsEmpty) then
    EdDtmovimento.Invalid('Movimento tem que ser maior que emiss�o');
// 20.06.11
  if (EdDtmovimento.isempty) and ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodCompraProdutor+';'+Global.CodEntradaProdutor)>0 ) then begin
    if ( trim(QFornec.fieldbyname('Clie_rgie').asstring)='' ) then
             EdDtmovimento.invalid('Para nota de Produtor � preciso ter inscri��o estadual informada')
  end;


end;

procedure TFNotaCompra.bveiculosClick(Sender: TObject);
///////////////////////////////////////////////////////////////////
begin
   PVeiculo.Visible:=true;
   PVeiculo.Enabled:=true;
   EdMoes_cola_codigo.SetFocus;

end;

// 01.08.18   - Benato - Mari
procedure TFNotaCompra.bvendabalcaoClick(Sender: TObject);
///////////////////////////////////////////////////////////
begin

   if not Sistema.processando then FVendaBalcao.execute;
   Arq.TConfMovimento.OpenWith(FGeral.GetIN('comv_tipomovto',Global.TiposEntrada,'C'),Arq.TConfMovimento.Ordenacao);

end;

procedure TFNotaCompra.EdMoes_kmExitEdit(Sender: TObject);
/////////////////////////////////////////////////////////////
begin
   PVeiculo.enabled:=false;
   PVeiculo.visible:=false;
   if (OP = 'A') and ( EdMOes_km.AsInteger<>0 ) then begin
      if Confirma('Somente gravar a KM ?') then begin

        Sistema.Edit('movesto');
        Sistema.SetField('moes_km',EdMoes_KM.Asinteger);
        Sistema.Post('moes_transacao = '+Stringtosql( transacaobusca ));
        Sistema.Commit;
        Grid.Clear;
        Close;

      end;
   end;
// 15.03.19
   if Ansipos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodPrestacaoServicosE+';' ) >0 then
      bIncluiritemClick(self)
   else
// 16.11.16
     EdPort_codigo.setfocus;
end;

procedure TFNotaCompra.EdMoes_cola_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
   FGeral.Limpaedit(EdMoes_cola_codigo,key);

end;

// 20.06.19
procedure TFNotaCompra.Edmoes_insumosValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin

      Edmoes_insumos.Enabled:=false;
      Edmoes_insumos.Visible:=false;

end;

procedure TFNotaCompra.btesteClick(Sender: TObject);
var p:integer;
    produto,sqlcor,sqltamanho:string;
    totalitem:currency;
    codtamanho,codcor:integer;
begin
// soma itens da nota multiplicando pelo pelo igual na inclusao
// atualizando o grid com o valor total ou mudando o unitario = vlr serv*peso ?
// regrava os itens
  if Op<>'A' then exit;
  if trim(transacaobusca)='' then exit;
  Sistema.BeginProcess('gravando novo valor unit�rio nos itens');
  for p:=1 to Grid.rowcount do begin
    produto:=Grid.Cells[Grid.getcolumn('move_esto_codigo'),p];
    if trim(produto)<>'' then begin
      if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodCompraProdutor+';'+Global.CodEntradaProdutor)=0 then begin
        totalitem:=Fgeral.Arredonda( texttovalor(Grid.Cells[Grid.GetColumn('total'),p]) ,4);
      end else begin
        totalitem:=Fgeral.Arredonda( texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]) * texttovalor(Grid.Cells[Grid.GetColumn('move_venda'),p]) ,4);
      end;
    end;
    codtamanho:=strtointdef(Grid.cells[Grid.getcolumn('move_tama_codigo'),p],0);
    codcor:=strtointdef(Grid.cells[Grid.getcolumn('move_core_codigo'),p],0);
    sqlcor:='';
    if codcor>0 then
      sqlcor:=' and move_core_codigo='+inttostr(codcor);
    sqltamanho:='';
    if codtamanho>0 then
      sqltamanho:=' and move_tama_codigo='+inttostr(codtamanho);
    Sistema.Edit('movestoque');
    Sistema.SetField('move_venda',texttovalor(Grid.Cells[Grid.GetColumn('move_venda'),p]) );
    Sistema.Post('move_transacao='+Stringtosql(transacaobusca)+
                 ' and move_esto_codigo='+Stringtosql(produto)+
                 sqlcor+sqltamanho+
                 ' and move_status=''N''' );
  end;
  try
    Sistema.Commit;
    Sistema.EndProcess('Grava��o Terminada');
  except
    Sistema.EndProcess('Problemas na grava��o. Tente mais  tarde');
  end;
end;

procedure TFNotaCompra.SetaEditObra;
///////////////////////////////////////
var Q:TSqlquery;
    Lista:TStringlist;
    sqlperiodo:string;
begin
     if Sistema.getperiodo('Periodo para pesquisa das obras') then
       sqlperiodo:=' and moes_datamvto>='+Datetosql(Sistema.datai)+' and moes_datamvto<='+Datetosql(Sistema.Dataf)
     else
       sqlperiodo:='';
     Q:=sqltoquery('select movesto.*,clie_razaosocial,clie_nome from movesto'+
                   ' inner join clientes on ( clie_codigo=moes_tipo_codigo )'+
                   ' where moes_status=''R'''+
                   ' and moes_unid_codigo='+stringtosql(Global.codigounidade)+
                   ' and moes_tipomov='+stringtosql(Global.CodRequisicaoAlmox)+
                   sqlperiodo+
                   ' order by clie_razaosocial');
     Lista:=TStringlist.create;
     while not Q.eof do begin
       if Lista.IndexOf(Q.fieldbyname('moes_numerodoc').AsString)=-1 then begin
         EdNroobra.Items.Add(strspace(Q.fieldbyname('moes_numerodoc').AsString,9)+' - '+FGeral.formatadata(Q.fieldbyname('moes_dataemissao').AsDatetime)+
                             ' - '+Q.fieldbyname('clie_razaosocial').AsString );
         Lista.Add(Q.fieldbyname('moes_numerodoc').AsString);
       end;
//                             ' - '+Q.fieldbyname('clie_nome').AsString );
       Q.Next;
     end;
   FGeral.FechaQuery(Q);
   Lista.free;

end;

procedure TFNotaCompra.EdcodcorValidate(Sender: TObject);
begin
   if not FCores.ValidaCor(EdCodcor) then
     EdCodcor.Invalid('');

end;

procedure TFNotaCompra.EdSTValidate(Sender: TObject);
begin
  if EdSt.ResultFind<>nil then begin
    if Global.Topicos[1343] then begin
      if ( EdSt.ResultFind.FieldByName('sitt_es').asstring<>'E' ) and
// 20.10.11 -Novicarnes - Jake       
         (  pos( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Devolucao ) = 0 )
        then
        EdSt.Invalid('Codigo de situa��o tribut�ria n�o permitido para entradas');
    end;
  end;
  EdNatf_codigoitem.text:=FSittributaria.GetCfop(EdSt.AsInteger,EdNatf_codigo.text,EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring)
end;

/////////////////////////////////////////////////////
procedure TFNotaCompra.ImportaDadosXML(NotaFiscal: TACbrNfe);
/////////////////////////////////////////////////////////////////////
type TMunicipios=record
     nome,uf,cep,codigoibge,codigopais,nomepais:string;
     codigo:integer;
end;

type TBaseporCfop=record
     TpImp,cfop,cfopsaida:string;
     Aliquota,Base,Reducao,Imposto:currency;
end;

var Q,Qt:Tsqlquery;
    ListaMunicipios,ListaBaseCfop:TList;
    PMunicipios:^TMunicipios;
    PBaseCfop:^TBaseporCfop;
    p,r,i,posplaca:integer;
    achou:boolean;
    EdTpImp,EdAl,EdBc,EdRedBc,EdImp,EdCfop:TSqlEd;
    Pesquisa:string;


    procedure LeMunicipios;
    ///////////////////////
    var Q:TSqlquery;
    begin
      Q:=sqltoquery('select * from cidades');
      ListaMunicipios:=Tlist.create;
      while not Q.eof do begin
        New(PMunicipios);
        PMunicipios.codigo:=Q.fieldbyname('cida_codigo').asinteger;
        PMunicipios.nome:=Ups(q.fieldbyname('cida_nome').asstring );
        PMunicipios.uf:=q.fieldbyname('cida_uf').asstring;
        ListaMunicipios.add( PMunicipios );
        Q.Next;
      end;
      Q.close;Freeandnil(q);
    end;

    procedure AdicionaMunicipio;
    ////////////////////////////
    var Q:TSqlquery;
        name:string;
    begin
        Q:=sqltoquery('select * from cidades where cida_codigo='+inttostr(PMUnicipios.codigo));
        if Q.eof then begin
          Sistema.Insert('cidades');
          Sistema.SetField('cida_codigo',PMUnicipios.codigo);
          Sistema.SetField('cida_nome',PMUnicipios.nome);
          Sistema.SetField('cida_uf',PMUnicipios.uf);
          Sistema.SetField('cida_regi_codigo','001');
          Sistema.SetField('cida_cep',PMunicipios.cep);
          Sistema.SetField('cida_codigoibge',PMunicipios.codigoibge);
          Sistema.SetField('cida_codigopais',PMunicipios.codigopais);
          Sistema.SetField('cida_nomepais',PMunicipios.nomepais);
          Sistema.post;
          Sistema.commit;
        end;
        Q.Close;
    end;


    function GetCodigoMunicipio(nomecidade,ufcidade:string):integer;
    ///////////////////////////////////////////////////////////////
    var p,codigo:integer;
        achou:boolean;

        function Maior:integer;
        var x,maior:integer;
        begin
          maior:=0;
          for x:=0 to LIstaMunicipios.count-1 do begin
            PMunicipios:=ListaMunicipios[x];
            if PMunicipios.codigo>maior then
              maior:=PMunicipios.codigo;
          end;
          result:=maior;
        end;

    begin
    /////////////////////////////////////////////
      achou:=false;
      for p:=0 to LIstaMunicipios.count-1 do begin
        PMunicipios:=ListaMunicipios[p];
//        if (PMunicipios.nome=ups(nomecidade) )  and (PMunicipios.uf=ufcidade )then begin
// 09.06.08
        if (ups(PMunicipios.nome)=ups(nomecidade) )  and (uppercase(PMunicipios.uf)=uppercase(ufcidade) )then begin
          result:=PMunicipios.codigo;
          achou:=true;
          break;
        end;
      end;
      if not achou then begin
//        Q:=sqltoquery('select max(muni_codigo) as ultimo from municipios');
        codigo:=Maior+1;
//        Q.close;Freeandnil(Q);
        New(PMunicipios);
        PMunicipios.codigo:=codigo;
        PMunicipios.nome:=nomecidade;
        PMunicipios.uf:=ufcidade;
        PMunicipios.cep:=inttostr( NotaFiscal.NotasFiscais.Items[0].NFe.Emit.EnderEmit.CEP );
        PMunicipios.codigoibge:=inttostr( NotaFiscal.NotasFiscais.Items[0].NFe.Emit.EnderEmit.cMun );
        PMunicipios.codigopais:=inttostr( NotaFiscal.NotasFiscais.Items[0].NFe.Emit.EnderEmit.cPais );
        PMunicipios.nomepais:= NotaFiscal.NotasFiscais.Items[0].NFe.Emit.EnderEmit.xPais ;
        ListaMunicipios.Add( PMunicipios );
// salva na lista para no final gravar tdos os novos municipios cadastrados
        result:=codigo;
      end;
    end;


    procedure IncluiCliente;
    ///////////////////////
    var sql,cod:string;
        Q:TSqlquery;
        Codigo:integer;
    begin
        Sql:='Select Max(Clie_Codigo) As Proximo From Clientes';
        Q:=SqlToQuery(Sql);
        if Q.FieldByName('Proximo').AsInteger>0 then begin
            Cod:=Trim(Q.FieldByName('Proximo').AsString);
            Cod:=LeftStr(Cod,Length(Cod)-1);
        end;
        Q.Close; FreeAndNil(Q);
        Codigo:=Inteiro(Cod)+1;
        Cod:=IntToStr(Codigo);
        Codigo:=Inteiro(Cod+GetDigito(Cod,'MOD'));
        with NotaFiscal.NotasFiscais.Items[0].NFe do begin
          Sistema.Insert('clientes');
          Sistema.SetField('clie_codigo',codigo);
          Sistema.SetField('clie_nome',copy(SpecialCase(Emit.xFant),1,40));
          Sistema.SetField('clie_razaosocial',copy(SpecialCase(Emit.xNome),1,40));
          if length(trim(Emit.CNPJCPF))=11 then
//          Sistema.SetField('clie_tipo',GetTipo(Emit.CNPJCPF));
            Sistema.SetField('clie_tipo','F')
          else
            Sistema.SetField('clie_tipo','J');
          Sistema.SetField('clie_cnpjcpf',Emit.cnpjcpf);
          Sistema.SetField('clie_rgie',Emit.IE);
          Sistema.SetField('clie_sexo','M');
  ////        Sistema.SetField('clie_uf',PClifor.forn_uf);
          Sistema.SetField('clie_endres',copy(SpecialCase(Emit.EnderEmit.xLgr)+', '+Emit.EnderEmit.nro,1,40));
  //        Sistema.SetField('clie_endrescompl',PClifor.forn_endereco);
          Sistema.SetField('clie_bairrores',SpecialCase(Emit.EnderEmit.xBairro));
          Sistema.SetField('clie_cida_codigo_res',GetCodigoMunicipio(Emit.EnderEmit.xMun,Emit.EnderEmit.UF));
          Sistema.SetField('clie_cepres',inttostr(Emit.EnderEmit.CEP));
          Sistema.SetField('clie_foneres',Emit.EnderEmit.fone);
//          Sistema.SetField('clie_email',Emit.EnderEmit....);
          Sistema.SetField('clie_endcom',copy(SpecialCase(Emit.EnderEmit.xLgr)+', '+Emit.EnderEmit.nro,1,50));
          Sistema.SetField('clie_bairrocom',SpecialCase(Emit.EnderEmit.xBairro));
          Sistema.SetField('clie_cida_codigo_com',GetCodigoMunicipio(Emit.EnderEmit.xMun,Emit.EnderEmit.UF));
          Sistema.SetField('clie_cepcom',inttostr(Emit.EnderEmit.CEP));
          Sistema.SetField('clie_fonecom',Emit.EnderEmit.fone);
//          Sistema.SetField('clie_contacontabil',PClifor.forn_contacontabil);
          Sistema.SetField('clie_situacao','N');
          Sistema.SetField('clie_dtcad',Sistema.hoje);
          Sistema.SetField('clie_unid_codigo',Edunid_codigo.text);
          Sistema.SetField('clie_usua_codigo',Global.Usuario.Codigo);
          Sistema.SetField('clie_contribuinte','S');
          Sistema.SetField('clie_obs','IMPXML NF '+inttostr(NotaFiscal.NotasFiscais.Items[0].NFe.Ide.nNF));
  //        Sistema.SetField('clie_caractrib varchar(1)
          Sistema.Post();
          Sistema.Commit;
          EdFornec.setvalue(codigo);
        end;
    end;

    procedure IncluiFornecedor;
    //////////////////////////
    var Q:TSqlquery;
        ProxCodigo:string;
        Codigo:integer;
    begin
        Codigo:=FGeral.GetProximoCodigoCadastro('Fornecedores','Forn_Codigo');
        with NotaFiscal.NotasFiscais.Items[0].NFe do begin
          Sistema.Insert('fornecedores');
          Sistema.SetField('forn_codigo',codigo);
// 01.02.17 - as vezes xfant fica em branco
          if trim( copy(SpecialCase(Emit.xFant),1,50) )  <>'' then
            Sistema.SetField('forn_nome',copy(SpecialCase(Emit.xFant),1,50))
          else
            Sistema.SetField('forn_nome',copy(SpecialCase(Emit.xNome),1,50));
          Sistema.SetField('forn_razaosocial',copy(SpecialCase(Emit.xNome),1,50));
          Sistema.SetField('forn_cnpjcpf',Emit.CNPJCPF);
          Sistema.SetField('forn_situacao','N');   // 10.02.12 - validapr
          Sistema.SetField('forn_inscricaoestadual',trim(Emit.IE));
          Sistema.SetField('forn_endereco',copy(SpecialCase(Emit.EnderEmit.xLgr)+', '+Emit.EnderEmit.nro,1,40));
          Sistema.SetField('forn_bairro',SpecialCase(copy(Emit.EnderEmit.xBairro,1,40)));
          Sistema.SetField('forn_cep',inttostr(Emit.EnderEmit.CEP));
          Sistema.SetField('forn_cida_codigo',GetCodigoMunicipio( Emit.EnderEmit.xMun, Emit.EnderEmit.UF));
          Sistema.SetField('forn_fone',copy(Emit.EnderEmit.fone,1,11));
//          Sistema.SetField('forn_fax',Emit.EnderEmit.forn_fax);
//          Sistema.SetField('forn_email',Pclifor.forn_email);
          Sistema.SetField('forn_percfunrural',0);
//          Sistema.SetField('forn_contacontabil',Pclifor.forn_contacontabil);
          Sistema.SetField('forn_datacad',Sistema.hoje);
          Sistema.SetField('forn_usua_codigo',global.Usuario.Codigo);
          Sistema.SetField('forn_contribuinte','S');
          Sistema.SetField('forn_uf',Emit.EnderEmit.UF);
          Sistema.SetField('forn_obspedidos','IMPXML NF '+inttostr(NotaFiscal.NotasFiscais.Items[0].NFe.Ide.nNF));
  //        Sistema.SetField('forn_uf',Pclifor.forn_uf);
          Sistema.Post();
          Sistema.Commit;
          EdFornec.setvalue(codigo);
       end;
    end;

    procedure MostraNota;
    ///////////////////////
    begin
       Aviso('Nome Fantasia:'+NotaFiscal.NotasFiscais.Items[0].NFe.Emit.xFant+';'+
             'Raz�o Social :'+NotaFiscal.NotasFiscais.Items[0].NFe.Emit.xNome+';'+
             'Nota         :'+inttostr(NotaFiscal.NotasFiscais.Items[0].NFe.Ide.nNF)+';'+
             'Emiss�o      :'+FGeral.Formatadata(NotaFiscal.NotasFiscais.Items[0].NFe.Ide.dEmi )+';'+
             'Valor        :'+Formatfloat(f_cr,NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vNF) );
    end;


//////////////////////////////////
begin
//////////////////////////////////
// dados do emitente - Cliente ou Fornecedor - checar cfe o tipo de movimento
// q t� na config. de movimento ou se usa o 'tipos muda' ...
  Sistema.Beginprocess('Lendo munic�pios');
  Edvaloripi.setvalue(0);
  LeMunicipios;
  Sistema.Endprocess('');
//  if NotaFiscal.NotasFiscais.Items[0].Alertas<>'EstornoNFe' then begin
// 31.12.15
  if NotaEstorno<>'EstornoNFe' then begin

    MostraNota;
    if (NotaFiscal.NotasFiscais.Items[0].NFe.Emit.CNPJCPF='')
       or
       (NotaFiscal.NotasFiscais.Items[0].NFe.Emit.CNPJCPF='00000000000000')  then begin
      Avisoerro('N�o foi poss�vel identificar o EMITENTE desta nota.  Checar XML');
      EdArquivoxml.Text:='';
      exit;

    end else if not confirma('Confirma nota') then begin

      EdArquivoxml.Text:='';
      exit;

    end;

  end;
  Sistema.Beginprocess('Lendo informa��es do arquivo XML');
//  if NotaFiscal.NotasFiscais.Items[0].Alertas='EstornoNFe' then begin
// 31.12.15
  if NotaEstorno='EstornoNFe' then begin
// 10.12.13
     if Acbrnfe1.NotasFiscais.Items[0].NomeArq='C' then begin
////////////
        FGeral.SetaEdEntidade(EdFornec,'C');
        campoufentidade:='clie_uf';
        campocodigoentidade:='clie_codigo';
// 23.10.20 - desfeito em 23.11'.20
//        campoufentidade:='forn_uf';
//        campocodigoentidade:='forn_codigo';
        if trim(FGeral.Getconfig1asstring('Fpgtoavista'))='' then
          EdComv_codigo.invalid('Falta configurar a forma de pagamento a vista nas configura��es')
        else
          EdFpgt_codigo.text:=FGeral.Getconfig1asstring('Fpgtoavista');
        Edtipodoc.text:=EdComv_codigo.ResultFind.fieldbyname('comv_especie').asstring;
        EdSerie.text:=EdComv_codigo.ResultFind.fieldbyname('comv_serie').asstring;
        if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoVenda+';'+Global.CodRetornoMostruario) >0 then
          EdNumerodoc.enabled:=true
        else
          EdNumerodoc.enabled:=Global.Topicos[1301];
        EdDtemissao.setdate(sistema.hoje);
///////////
       Q:=sqltoquery('select Clie_cnpjcpf,clie_codigo from clientes where Clie_cnpjcpf='+Stringtosql(NotaFiscal.NotasFiscais.Items[0].NFe.Dest.CNPJCPF));
       if not Q.eof then
         EdFornec.text:=Q.fieldbyname('clie_codigo').AsString
       else
         EdFornec.text:='';
       Q.close;
     end else begin
       FGeral.SetaEdEntidade(EdFornec,'F');
       Q:=sqltoquery('select forn_cnpjcpf,forn_codigo from fornecedores where forn_cnpjcpf='+Stringtosql(NotaFiscal.NotasFiscais.Items[0].NFe.Dest.CNPJCPF));
       if not Q.eof then
         EdFornec.text:=Q.fieldbyname('forn_codigo').AsString
       else
         EdFornec.text:='';
       Q.close;
     end;
     Q:=sqltoquery('select tran_codigo from transportadores where tran_cnpjcpf='+Stringtosql(NotaFiscal.NotasFiscais.Items[0].NFe.Transp.Transporta.CNPJCPF));
     EdTran_codigo.text:=Q.fieldbyname('tran_codigo').AsString;
  end else begin

    if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,tiposmuda) >0 then begin

       Q:=sqltoquery('select Clie_cnpjcpf,clie_codigo from clientes where Clie_cnpjcpf='+Stringtosql(NotaFiscal.NotasFiscais.Items[0].NFe.Emit.CNPJCPF));
       if Q.eof then begin
         IncluiCliente;
       end else
         EdFornec.text:=Q.fieldbyname('clie_codigo').AsString;
// 22.05.18
       QFornec:=sqltoquery('select * from clientes where clie_codigo='+Edfornec.assql);

    end else begin

       Q:=sqltoquery('select Forn_cnpjcpf,forn_codigo from fornecedores where Forn_cnpjcpf='+Stringtosql(NotaFiscal.NotasFiscais.Items[0].NFe.Emit.CNPJCPF));
       if Q.eof then begin
         IncluiFornecedor;
       end else
         EdFornec.text:=Q.fieldbyname('forn_codigo').AsString;
// 22.05.18
       QFornec:=sqltoquery('select * from clientes where clie_codigo='+Edfornec.assql);

    end;
  end;
// dados da nota como numero, serie, etc
//  if NotaFiscal.NotasFiscais.Items[0].Alertas='EstornoNFe' then begin
// 31.12.15
  if NotaEstorno='EstornoNFe' then begin
//    if copy(NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[0].Prod.CFOP,1,1)='5' then
//      Ednatf_codigo.text:='1'+copy(NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[0].Prod.CFOP,2,4)
//    else
//      Ednatf_codigo.text:='2'+copy(NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[0].Prod.CFOP,2,4);
//      EdNUmerodoc.setvalue( FGeral.ConsultaContador('NFSAIDA'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade))+1 );
    Eddtemissao.setdate( Sistema.Hoje );
  end else begin
      EdNumerodoc.text:=inttostr(NotaFiscal.NotasFiscais.Items[0].NFe.Ide.nNF);
      Eddtemissao.setdate( NotaFiscal.NotasFiscais.Items[0].NFe.Ide.dEmi );
  end;
// 16.05.11 - deixado cfop da config. de movimento pois pode ser 5656 entrar 1653...

  EdSerie.Text:=inttostr(NotaFiscal.NotasFiscais.Items[0].NFe.Ide.serie);
  EdTipodoc.text:='NFE';

  EdDigbicms.setvalue( NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vBC );
//  EdMfis_vlcontabilicms.setvalue( NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vBC );
  EdDigvicms.setvalue(NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vICMS);
  if NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vIPI>0 then begin
    EdValoripi.setvalue(NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vIPI);
  end;
// 20.10.11 - Silvano - contabilidade
  if (Global.Topicos[1352]) and
     (EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring<>Global.CodNfeComplementoIcmsE)
      and
     (EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring<>Global.CodNfeComplementoIcmsECliente)
  then begin

    EdDigbicms.setvalue( 0 );
    EdDigvicms.setvalue( 0 );

  end;
// 16.05.11 - tenta localizar o veiculo pela placa
  posplaca:= pos( 'PLACA:',uppercase(NotaFiscal.NotasFiscais.Items[0].NFe.InfAdic.infCpl) );
  if posplaca >0 then begin

    posplaca:=posplaca + 6;
    pesquisa:=copy(uppercase(NotaFiscal.NotasFiscais.Items[0].NFe.InfAdic.infCpl),1,20);
    posplaca:=pos(':',pesquisa);
    if copy(pesquisa,posplaca+1,1)=' ' then
      pesquisa:=copy(pesquisa,posplaca+2,7)
    else
      pesquisa:=Trim( UpperCase( copy(NotaFiscal.NotasFiscais.Items[0].NFe.InfAdic.infCpl,posplaca+1,7) ) );
//    if Arq.TTransp.locate('Tran_placa',pesquisa,[]) then begin
// cfe estava posicionado o clientdataset ora achava ora n�o achava a placa
    QT:=sqltoquery('select tran_codigo,tran_nome from transportadores where tran_placa='+Stringtosql(Pesquisa));
    if not Qt.eof then begin
      EdTran_codigo.text:=QT.Fieldbyname('tran_codigo').asstring;
      EdTran_nome.text:=QT.Fieldbyname('tran_nome').asstring;
    end;
    FGeral.FechaQuery(Qt);
//      Arq.TTransp.First; // 05.09.11 - Novi - as vezes nao encontrado...
  end;
// 29.03.12 - tenta localizar o veiculo pela placa escrito com ...
  posplaca:= pos( 'PLACA...:',uppercase(NotaFiscal.NotasFiscais.Items[0].NFe.InfAdic.infCpl) );
  if posplaca >0 then begin

    posplaca:=posplaca + 9;
    pesquisa:=UpperCase( copy(NotaFiscal.NotasFiscais.Items[0].NFe.InfAdic.infCpl,posplaca,10) );
//    if Arq.TTransp.locate('Tran_placa',pesquisa,[]) then begin
// cfe estava posicionado o clientdataset ora achava ora n�o achava a placa
    QT:=sqltoquery('select tran_codigo,tran_nome from transportadores where tran_placa='+Stringtosql(Pesquisa));
    if not Qt.eof then begin
      EdTran_codigo.text:=QT.Fieldbyname('tran_codigo').asstring;
      EdTran_nome.text:=QT.Fieldbyname('tran_nome').asstring;
    end;
    FGeral.FechaQuery(Qt);
  end;
// 01.02.17
  if posplaca=0 then begin

    posplaca:= pos( 'PLACA = ',uppercase(NotaFiscal.NotasFiscais.Items[0].NFe.InfAdic.infCpl) );
    if posplaca >0 then begin
      posplaca:=posplaca + 9;
      pesquisa:=UpperCase( copy(NotaFiscal.NotasFiscais.Items[0].NFe.InfAdic.infCpl,posplaca,10) );
      QT:=sqltoquery('select tran_codigo,tran_nome from transportadores where tran_placa='+Stringtosql(Pesquisa));
      if not Qt.eof then begin
        EdTran_codigo.text:=QT.Fieldbyname('tran_codigo').asstring;
        EdTran_nome.text:=QT.Fieldbyname('tran_nome').asstring;
      end;
      FGeral.FechaQuery(Qt);
    end;
  end;
// 16.11.16 - Km se informado
  posplaca:= pos( 'KM:',uppercase(NotaFiscal.NotasFiscais.Items[0].NFe.InfAdic.infCpl) );
  if posplaca >0 then begin
    EdMoes_km.Text:=strtostrNumeros(copy(uppercase(NotaFiscal.NotasFiscais.Items[0].NFe.InfAdic.infCpl),posplaca+4,6));
  end;
// 08.02.12 - notas com destaque do icms ref. subst. tributaria - Benato
//  EdValorsubs.setvalue( NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vST);
// 30.03.20 - notas com ST do FCP somar junto na ST para fechar os valore da nota
//            Devereda
  EdValorsubs.setvalue( NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vST +
                        NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vFCPST);
// 15.05.16 - notas com destaque do icms ref. subst. tributaria - devolucao Simar
  EdBasesubs.setvalue( NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vbCST);
// 25.04.14 - notas com acrescimo em outras despesas acessorias - Benato
  EdVlracre.SetValue(NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vOutro);

  Sistema.Beginprocess('Atualizando munic�pios');
  for p:=0 to ListaMunicipios.count-1 do begin
    PMunicipios:=ListaMunicipios[p];
    AdicionaMunicipio;
  end;
  EdDigtotpro.setvalue( NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vProd ) ;
  EdDigtotalnf.SetValue( NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vNF );
// 22.03.12
  EdVlrdesco.setvalue( NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vDesc );
// 25.05.18
  if NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vProd>0 then
    EdPerdesco.setvalue( ( NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vDesc/NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vProd)*100 );
// 06.07.12
  EdtotalServicos.setvalue( NotaFiscal.NotasFiscais.Items[0].NFe.Total.ISSQNtot.vServ );

// 20.08.2021
  if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring = Global.CodEntradaNFPe )
     and
     ( Global.Topicos[1479] )
    then begin

    EdDigtotpro.setvalue( 0 ) ;
    EdDigtotalnf.SetValue( 0  );
    EdDigbicms.setvalue( 0 );
    EdDigvicms.setvalue( 0 );

//     EdTipodoc.text:='NFP';

  end else if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring = Global.CodCompraMatConsumo )
     and
     ( Global.Topicos[1480] )
    then begin

      EdDigbicms.setvalue( 0 );
      EdDigvicms.setvalue( 0 );

 end;


  Sistema.EndProcess('');

// 02.09.10
// varrer os itens pra ver as bases e valor por cfop dai buscar qual
  ListaBaseCfop:=TList.Create;
  for p:=0 to NotaFiscal.NotasFiscais.Items[0].NFe.Det.Count-1 do begin
    achou:=false;
    with NotaFiscal.NotasFiscais.Items[0].NFe.Det[p] do begin
      for r:=0 to ListaBaseCfop.Count-1 do begin
        PBaseCfop:=ListaBaseCfop[r];
        if (PBasecfop.cfopSaida=Prod.CFOP) and (PBasecfop.Aliquota=Imposto.ICMS.pICMS)
           and (Imposto.ICMS.pICMS<>null )
           then begin
            achou:=true;
            break;
        end;
      end;
      if not achou then begin
        New(PBaseCfop);
        PBasecfop.TpImp:='C';  // icms
        if copy(Prod.Cfop,1,1)='5' then
          PBasecfop.cfop:='1'+copy(Prod.CFOP,2,4)
        else
          PBasecfop.cfop:='2'+copy(Prod.CFOP,2,4);
        PBasecfop.cfopsaida:=Prod.CFOP;
        PBasecfop.Aliquota:=Imposto.ICMS.pICMS;
        PBasecfop.Base:=Imposto.ICMS.vBC;
        PBasecfop.Reducao:=Imposto.ICMS.pRedBC;
        PBasecfop.Imposto:=Imposto.ICMS.vICMS;
// 20.10.11 - Silvano - contabilidade
        if Global.Topicos[1352] then begin
          PBasecfop.Aliquota:=0;
          PBasecfop.Base:=0;
          PBasecfop.Imposto:=0;
        end;
        ListaBaseCfop.Add(PBaseCfop);
      end else begin
        PBasecfop.Base:=PBasecfop.Base+Imposto.ICMS.vBC;
        PBasecfop.Imposto:=PBasecfop.Imposto+Imposto.ICMS.vICMS;
        if Global.Topicos[1352] then begin
          PBasecfop.Base:=0;
          PBasecfop.Imposto:=0;
        end;
      end;

    end;

  end;  // ref. for

// ver se ser� util esta lista de valores por cfop
  ListaBaseCfop.Clear;
  if NotaEstorno<>'EstornoNFe' then begin
// 18.04.12
    if NotaFiscal.NotasFiscais.Items[0].NFe.Ide.dSaiEnt > Global.DataMenorBanco then
      EdDtEntrada.SetDate( NotaFiscal.NotasFiscais.Items[0].NFe.Ide.dSaiEnt+1  )
    else
      EdDtEntrada.SetDate( Sistema.hoje );
  end else
      EdDtEntrada.SetDate( Sistema.hoje );

  EdFpgt_codigo.text:=FCondpagto.GetCodigoCfeParcelas(NotaFiscal.NotasFiscais.Items[0].NFe.Cobr.Dup.Count);
// 29.05.20  - retidao devido novicarnes e simar ( simone e julho )
{
  if EdFpgt_codigo.IsEmpty then begin

     Avisoerro('Obrigat�rio cadastrar nova condi��o de pagamento para lan�ar estar nota');
     exit;

  end;
  }
// 03.08.17
  if (Global.Topicos[1400]) and (EdFpgt_codigo.isempty  ) then
    EdFpgt_codigo.text:=FGeral.getconfig1asstring('Fpgtoavista');

// 03.10.14 - Mirvane
  EdFrete.setvalue(NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vFrete);
  EdEmides.Text:='1';
  if EdFrete.ascurrency>0 then begin
    EdEmides.Text:='2';
    FreteEmbutido:=true;
  end;
///////////
// 30.05.12 - Asatec
  if ( copy(NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[0].Prod.CFOP,1,1)='3' ) and
     (  NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vProd>0 )
    then
    EdPeracre.setvalue( 100 * ( NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vOutro/NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vProd ) );

  // 12.03.12 - pra poder checar se � do simples a unidade
  EdUnid_codigo.ValidFind;
  ItensXmltoGrid(Grid);
  SetaEditsValores;

end;

//////////////////////////////////////////////////////////////////
function TFNotaCompra.NotaAutorizada(XML: String): boolean;
//////////////////////////////////////////////////////////////////
var ret:string;
    re:boolean;

    function GetTag(ctag, xml: string): string;
    ////////////////////////////////////////////
    var cbuscai,cbuscaf:string;
        inicio,fim:integer;
    begin
    //  result:='N�o encontrado tag '+ctag;
      result:='';
      cbuscai:='<'+ctag+'>';
      cbuscaf:='</'+ctag+'>';
      inicio:=ansipos( Uppercase(cbuscai),Uppercase(XML) );
      fim:=ansipos( Uppercase(cbuscaf),Uppercase(XML) );
      if (inicio>0) and (fim>0) then
        result:=copy(xml,inicio+length(cbuscai),(fim)-(inicio+length(cbuscai)) );
    //  else
    //    AvisoErro('N�o encontrado tag '+ctag);

    end;

    function GetRetorno(xml: string):string;
    //////////////////////////////////////////////////////////
    const cautorizado:string='autorizado o uso de nf-e';
    const cautorizadooutro:string='autorizado o uso da nf-e';
    begin
      if ansipos(Uppercase(cautorizado),Uppercase(XML))>0 then
        result:='NF-e Autorizada'
    // 14.06.10
      else if ansipos(Uppercase(cautorizadooutro),Uppercase(XML))>0 then
        result:='NF-e Autorizada'
      else
        result:=GetTag('xMotivo',xml);
    end;


begin
//////////////////////////
   ret:=GetRetorno(xml);
   if ret='NF-e Autorizada' then
     re:=true
   else begin
     re:=false;
     if trim(ret)<>'' then
       Avisoerro(ret);
   end;                    
   result:=re;
end;

///////////////////////////////////////////////////////
procedure TFNotaCompra.ItensXmltoGrid(Grid: TSqlDtGrid);
///////////////////////////////////////////////////////
var r,p,codigosit,embala:integer;
    produto,codigofis,produtoaux:string;
    margemlucro,qualqtde,xmltotalitem,comprimento:currency;
    TEstoque:TSqlquery;
    qualunitario:extended;

    function GetOrigemMercadoria(xcst:TpcnOrigemMercadoria):string;
    /////////////////////////////////////////
    begin
      if xcst=oeNacional then
        result:='0'
      else if xcst=oeEstrangeiraImportacaoDireta then
        result:='1'
// 18.12.15
      else if xcst=oeEstrangeiraAdquiridaBrasil then
        result:='2'
      else if xcst=oeNacionalConteudoImportacaoSuperior40 then
        result:='3'
      else if xcst=oeNacionalProcessosBasicos then
        result:='4'
      else if xcst=oeNacionalConteudoImportacaoInferiorIgual40 then
        result:='5'
      else if xcst=oeEstrangeiraImportacaoDiretaSemSimilar then
        result:='6'
      else if xcst=oeEstrangeiraAdquiridaBrasilSemSimilar then
        result:='7'
///////////////////////////
      else
        result:='8';
    end;

    function GetCst(xcst:TpcnCSTIcms):string;
    /////////////////////////////////////////
    begin
      if xcst=cst00 then
       result:='00'
      else if xcst=cst10 then
        result:='10'
      else if xcst=cst20 then
        result:='20'
      else if xcst=cst30 then
        result:='30'
      else if xcst=cst40 then
        result:='40'
      else if xcst=cst41 then
        result:='41'
      else if xcst=cst50 then
        result:='50'
      else if xcst=cst51 then
        result:='51'
      else if xcst=cst60 then
        result:='60'
      else if xcst=cst70 then
        result:='70'
      else if xcst=cst80 then
        result:='80'
      else if xcst=cst81 then
        result:='81'
      else if xcst=cst90 then
        result:='90'; //80 e 81 apenas para CTe
    end;

// 11.05.11
    function GetCstSimples(xcst:TpcnCSOSNIcms):string;
    /////////////////////////////////////////
    begin
      if xcst=csosn101 then
       result:='100'
      else if xcst=csosn102 then
        result:='102'
      else if xcst=csosn103 then
        result:='103'
      else if xcst=csosn201 then
        result:='201'
      else if xcst=csosn202 then
        result:='202'
      else if xcst=csosn203 then
        result:='203'
      else if xcst=csosn300 then
        result:='300'
      else if xcst=csosn400 then
        result:='400'
      else if xcst=csosn500 then
        result:='500'
      else if xcst=csosn900 then
        result:='900'
      else
        result:='   ';
    end;

    function convertecfop(xcfop:string):string;
    /////////////////////////////////////////////
    begin
  // 13.02.12
        if pos( copy(xcfop,1,4),'5403/5401/') > 0 then
          result:='1403'
        else if pos( copy(xcfop,1,4),'5405') > 0 then begin
          result:='1401';
// 10.03.16
          if (EdUnid_codigo.resultfind.fieldbyname('Unid_identatividade').asstring='01') or
             (EdUnid_codigo.resultfind.fieldbyname('Unid_identatividade').asstring='') then
             result:='1403';
        end else if pos( copy(xcfop,1,4),'6403/6401/') > 0 then
          result:='2403'
        else if pos( copy(xcfop,1,4),'6404/') > 0 then begin
          result:='2401';
// 10.03.16
          if (EdUnid_codigo.resultfind.fieldbyname('Unid_identatividade').asstring='01') or
             (EdUnid_codigo.resultfind.fieldbyname('Unid_identatividade').asstring='') then
             result:='1403';
  // 15.02.12
        end else if ( pos( copy(xcfop,1,4),'5101/5104') > 0 )
            and ( pos(EdUnid_codigo.ResultFind.Fieldbyname('unid_simples').asstring,'S;2')>0 ) then
          result:='1102'
  // 15.02.12
        else if ( pos( copy(xcfop,1,4),'6101/6104') > 0 )
            and ( pos(EdUnid_codigo.ResultFind.Fieldbyname('unid_simples').asstring,'S;2')>0 ) then
          result:='2102'
  // 06.07.12
        else if ( pos( copy(xcfop,1,4),'5656/') > 0 ) then
          result:='1556'
        else if ( pos( copy(xcfop,1,4),'6656/') > 0 ) then
          result:='2556'
  // 09.08.12
        else if ( pos( copy(xcfop,1,4),'5929/5656;5667') > 0 ) then
          result:='1653'
        else if ( pos( copy(xcfop,1,4),'6929/6656;6667') > 0 ) then
          result:='2653'
  // 11.07.13  - Metalforte
        else if ( pos( copy(xcfop,1,4),'5925') > 0 ) then
          result:='1125'
        else if ( pos( copy(xcfop,1,4),'6925') > 0 ) then
          result:='2125'
        else if ( pos( copy(xcfop,1,4),'5125') > 0 ) then
          result:='1915'
        else if ( pos( copy(xcfop,1,4),'6125') > 0 ) then
          result:='2915'
//////////////
        else if copy(xcfop,1,1)='5' then
          result:='1'+copy(xcfop,2,4)
        else if copy(xcfop,1,1)='6' then
          result:='2'+copy(xcfop,2,4)
        else
          result:='3'+copy(xcfop,2,4);

    end;

    procedure IncluiProduto;
    //////////////////////////
    var xcod:string;
        QX:TSqlquery;

    begin

// 08.08.18  - Niver Andreia...para incluir somente uma vez para cada codigo do fornecedor
      if Global.Topicos[1051]  then begin

         QX:=Sqltoquery('select esto_codigo from estoque where esto_referencia='+Stringtosql(AcbrNfe1.NotasFiscais.Items[0].NFe.Det[r].Prod.cprod));
         if not Qx.Eof then begin
            Qx.Close;
            exit;
         end;

      end;

        with AcbrNfe1.NotasFiscais.Items[0].NFe do begin

// 04.02.2022 - caso bicheira Eticon e Benato compra de produtor rural fazer reinf
          if not Global.Topicos[1051]  then
            xcod:=FEstoque.GetProximoCodigo('estoque','esto_codigo','C')
          else
            xcod:=AcbrNfe1.NotasFiscais.Items[0].NFe.Det[r].Prod.cprod;

          Sistema.Insert('estoque');
          Sistema.setfield('esto_codigo',xcod);
  //        Sistema.setfield('esto_descricao',copy(SpecialCase( FGeral.TiraBarra( Det[r].Prod.xprod ) ),1,100));
  // 09.11.17
          Sistema.setfield('esto_descricao',copy(SpecialCase( FGeral.TiraBarra ( Det[r].Prod.xprod,'''' ) ),1,100));
          Sistema.setfield('esto_unidade',Det[r].Prod.uTrib);
          Sistema.setfield('esto_embalagem',1);
          Sistema.setfield('esto_peso',0);

          if Det[r].Prod.cEAN<>'SEM GTIN' then
//             Sistema.setfield('esto_codbarra',Det[r].Prod.cEAN);
// 09.08.18 - por enquanto pegar sempre do unitario e nao 'do pacote'
             Sistema.setfield('esto_codbarra',Det[r].Prod.cEANTrib);

          Sistema.setfield('esto_grup_codigo',1);
          Sistema.setfield('esto_sugr_codigo',1);
          Sistema.setfield('esto_fami_codigo',1);
          Sistema.setfield('esto_emlinha','S');
  //        Sistema.setfield('esto_mate_codigo',0);
          Sistema.setfield('esto_usua_codigo',Global.Usuario.Codigo);
          Sistema.setfield('esto_referencia',Det[r].Prod.cprod);
          Sistema.setfield('esto_precocompra',0);
          Sistema.setfield('esto_cipi_codigo',FCodigosipi.NcmtoCodigo(trim(Det[r].Prod.NCM)));
          Sistema.post;

          Sistema.Insert('estoqueqtde');
          Sistema.Setfield('esqt_status','N');
          Sistema.Setfield('esqt_unid_codigo',Global.CodigoUnidade);
          Sistema.Setfield('esqt_esto_codigo',xcod);
          Sistema.Setfield('esqt_qtde',0);
          Sistema.Setfield('esqt_qtdeprev',0);
          Sistema.Setfield('esqt_vendavis',0);
          Sistema.Setfield('esqt_custo',0);
          Sistema.Setfield('esqt_custoger',0);
          Sistema.Setfield('esqt_customedio',0);
          Sistema.Setfield('esqt_customeger',0);
          Sistema.Setfield('esqt_dtultvenda',Sistema.hoje);
          Sistema.Setfield('esqt_dtultcompra',Sistema.hoje);
          Sistema.Setfield('esqt_desconto',0);
          Sistema.Setfield('esqt_basecomissao',0);
          Sistema.Setfield('esqt_cfis_codigoest',FUnidades.GetFiscalDentro(Global.CodigoUnidade));
          Sistema.Setfield('esqt_cfis_codigoforaest',FUnidades.GetFiscalFora(Global.CodigoUnidade));
          Sistema.Setfield('esqt_sitt_codestado',FUnidades.GetSittDentro(Global.CodigoUnidade));
          Sistema.Setfield('esqt_sitt_forestado',FUnidades.GetSittFora(Global.CodigoUnidade));
          Sistema.Setfield('esqt_usua_codigo',Global.Usuario.codigo);
          Sistema.Setfield('esqt_vendamin',0);
          Sistema.Setfield('esqt_pecas',0);
          Sistema.Setfield('esqt_custoser',0);
          Sistema.Setfield('esqt_customedioser',0);
  //        campo:=Sistema.GetDicionario('estoqueqtde','esqt_cfis_codestsemie');
  //        if campo.Tipo<>'' then
  //          Sistema.Setfield('esqt_cfis_codestsemie',0);
          if Global.topicos[1226] then begin
            Sistema.Setfield('Esqt_cfis_codestnc',0);
            Sistema.Setfield('Esqt_cfis_codforaestnc',0);
            Sistema.Setfield('Esqt_sitt_codestadonc',0);
            Sistema.Setfield('Esqt_sitt_forestadonc',0);
          end;
          Sistema.post;
          Sistema.commit;

        end;  // with acbrnfe1...

    end;

// 22.07.2022
   function GetCustocomst(xtag:string):Currency;
   ///////////////////////////////////////////
   var npos:Integer;
       cvalor:string;
   begin
     result:=0;
      if trim(xtag)<>'' then begin
         npos := Ansipos('Preco Unitario Final:',xtag);
         if npos>0 then begin
            npos := npos + length('Preco Unitario Final:') ;
            cvalor := trim(copy(xtag,npos,12));
            if cvalor='' then result := 0 else result:=TextTovalor(cvalor);
         end;
     end;
   end;

//////////////////////////////////////
begin
//////////////////////////////////////
  Grid.Clear;p:=1;
  with AcbrNfe1.NotasFiscais.Items[0].NFe do begin

    for r:=0 to Det.Count-1 do begin

        produto:=Det[r].Prod.cProd;
        produtoaux:=ConverteCodigo(produto,EdFornec.asinteger,Det[r].Prod.cEAN); // 03.08.11
// 28.08.15
//        if (trim(produtoaux)='') and  (Det[r].Prod.cEAN<>'') and (Global.topicos[1042]) then begin
// 08.08.18
        if (trim(produtoaux)='') and  (Det[r].Prod.cEAN<>'') and (Global.topicos[1042])and ( Det[r].Prod.cEAN<>'SEM GTIN' )   then begin
          IncluiProduto;
          produtoaux:=ConverteCodigo(produto,EdFornec.asinteger,Det[r].Prod.cEAN);
        end else
// 08.08.18
          if (trim(produtoaux)='') and ( (Det[r].Prod.cEAN='') or ( Det[r].Prod.cEAN='SEM GTIN' )  ) and (Global.topicos[1051]) then begin
            IncluiProduto;
            produtoaux:=ConverteCodigo(produto,EdFornec.asinteger,Det[r].Prod.cEAN);
          end;

// 16.06.12
        if Global.topicos[1215] then
          Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p]:=TrataCodigoProdutoXML(produto,r)
// 03.08.12
        else if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodEstornoNFeSai then
          Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p]:=trim(produto)
        else
          Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p]:=produtoaux;
        Grid.Cells[Grid.Getcolumn('produtonfe'),p]:=produto;
// 11.05.11
        Grid.Cells[Grid.Getcolumn('ncmnfe'),p]:=trim(Det[r].Prod.NCM);
// 21.11.11
        TrataNCM(trim(Det[r].Prod.NCM),Det[r].Prod.xprod,produtoaux,Det[r].Imposto.IPI.pIPI);

//        Grid.Cells[Grid.Getcolumn('move_tama_codigo'),Abs(p)]:=Q.fieldbyname('move_tama_codigo').Asstring;
//        Grid.Cells[Grid.Getcolumn('move_core_codigo'),Abs(p)]:=Q.fieldbyname('move_core_codigo').Asstring;
//        Grid.Cells[Grid.Getcolumn('move_copa_codigo'),Abs(p)]:=Q.fieldbyname('move_copa_codigo').Asstring;
//        Grid.Cells[Grid.Getcolumn('cor'),Abs(p)]:=FCores.GetDescricao(Q.fieldbyname('move_core_codigo').Asinteger);
//        Grid.Cells[Grid.Getcolumn('tamanho'),Abs(p)]:=FTamanhos.Getdescricao(Q.fieldbyname('move_tama_codigo').Asinteger);
//        Grid.Cells[Grid.Getcolumn('copa'),Abs(p)]:=FCopas.GetDescricao(Q.fieldbyname('move_copa_codigo').Asinteger);
        embala:=1;  // 08.12.11
        if trim(produtoaux)<>'' then begin
// 29.08.14 - Abra Cuiba
          TEstoque:=sqltoquery('select esto_descricao,esto_embalagem from estoque where esto_codigo='+Stringtosql(produtoaux));
          if not TEstoque.eof then begin
//            Grid.Cells[Grid.Getcolumn('esto_descricao'),p]:=FEstoque.GetDescricao(produtoaux)
            Grid.Cells[Grid.Getcolumn('esto_descricao'),p]:=TEstoque.fieldbyname('esto_descricao').asstring;
            embala:=TEstoque.fieldbyname('esto_embalagem').asinteger;
          end else
            Grid.Cells[Grid.Getcolumn('esto_descricao'),p]:='N�o encontrado - NFe'
        end else begin
// 09.09.14 - so ficar no eof e nao der acess violation...
          TEstoque:=sqltoquery('select esto_descricao,esto_embalagem from estoque where esto_codigo='+Stringtosql('AAA'));
          Grid.Cells[Grid.Getcolumn('esto_descricao'),p]:=Det[r].Prod.xprod;
        end;
// 11.05.11
        if ( AcbrNfe1.NotasFiscais.Items[0].NFe.Emit.CRT=crtSimplesNacional )
//           or
//           ( AcbrNfe1.NotasFiscais.Items[0].NFe.Emit.CRT=crtSimplesExcessoReceita )
// 05.02.20 - quando em excessoreceita usa cst e nao csosn...seip brasil nf cipabra
          then
          Grid.Cells[Grid.Getcolumn('move_cst'),p]:= CSOSNIcmsToStr( Det[r].Imposto.ICMS.CSOSN )

        else

          Grid.Cells[Grid.Getcolumn('move_cst'),p]:= GetOrigemMercadoria(Det[r].Imposto.ICMS.orig) +
                                                     GetCst(Det[r].Imposto.ICMS.CST);
// 21.03.19  - Vida Nova - item com CST na tag ICMSST  dentro da tag ICMS..
          if Grid.Cells[Grid.Getcolumn('move_cst'),p] = '0' then
             Grid.Cells[Grid.Getcolumn('move_cst'),p]:= GetOrigemMercadoria(Det[r].Imposto.ICMS.orig) +
                                                        FExpNfeTxt.GetTag('cst', FExpNfeTxt.GetTag('icmsst', AcbrNfe1.NotasFiscais.Items[0].XML ) );
// 25.11.19 - Novicarnes - Simone+ketlen - NAO pegar cst padrao para NP e CP
        if AnsiPos( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodCompraProdutor+';'+
                    Global.CodEntradaProdutor ) = 0 then  begin

// 13.03.14 - Abra Cuiaba
            if FGeral.GetConfig1AsString('cstpadraentrada')<>'' then Grid.Cells[Grid.Getcolumn('move_cst'),p]:=FGeral.GetConfig1AsString('cstpadraentrada');
    // 25.03.14 - Abra Cuiaba
            if (FGeral.GetConfig1AsString('cstpadraentrada1')<>'') and
               ( pos(trim(ConverteCfop( Det[r].Prod.cfop )) ,'1924/2924/1923/2923/1101/2101')>0 ) then
    //           ( pos(trim(( Det[r].Prod.cfop )) ,'5924/6924/5923/6923/5101/6101')>0 ) then
              Grid.Cells[Grid.Getcolumn('move_cst'),p]:=FGeral.GetConfig1AsString('cstpadraentrada1');

        end;

// 06.07.12 - SM - NFe com sevi�os e produtos...
        if Ansipos( Det[r].Prod.cfop,cfopdeservicos) > 0 then
          Grid.Cells[Grid.Getcolumn('move_aliicms'),p]:=transform(Det[r].Imposto.ISSQN.vAliq,'#0.0')
        else
          Grid.Cells[Grid.Getcolumn('move_aliicms'),p]:=transform(Det[r].Imposto.ICMS.pICMS,'#0.0');
        Grid.Cells[Grid.Getcolumn('move_aliipi'),p]:=transform(Det[r].Imposto.IPI.pIPI,'#0.000');
// 25.04.14 - ipi em valor por produto e com aliquota zero - 'coca' benato
        if (Det[r].Imposto.IPI.pIPI=0) and (Det[r].Imposto.IPI.vIPI>0) then
          Grid.Cells[Grid.Getcolumn('move_aliipi'),p]:=transform((Det[r].Imposto.IPI.vIPI/Det[r].Prod.vProd)*100,'#0.000');
/////////////////////
//        Grid.Cells[Grid.Getcolumn('esto_unidade'),p]:=Arq.TEstoque.fieldbyname('esto_unidade').asstring;
        Grid.Cells[Grid.Getcolumn('esto_unidade'),p]:=Det[r].Prod.uTrib;
//        qualqtde:=Det[r].Prod.qTrib;
// 07.02.11 - Bavi qcom 6 CX e qunid 180 unid.
// 08.12.11 - embalagem multiplica pra entrar no estoque 'como vende'
// 01.03.12 - retirado pra deixar a qtde da nota - e acertado no movimento e quando grava a nota
//        qualunitario:=Det[r].Prod.vUnTrib;
// 19.03.12 - trato xml souza cruz - cigarros em milheiros
//        if (UpperCase( Det[r].Prod.uTrib ) = 'MIL') and ( Det[r].Prod.NCM='24022000' ) then begin
// 18.01.18 - mudaram no xml o uTrib para TH...
        if (UpperCase( Det[r].Prod.uCom ) = 'MIL') and ( Det[r].Prod.NCM='24022000' ) then begin
          qualqtde:= (1000*Det[r].Prod.qCom)/20;
          qualunitario:=(Det[r].Prod.vUnCom/1000);
// 24.06.13 - Metalforte
        end else if ( UpperCase( Det[r].Prod.uTrib ) = 'TON' ) and
                    ( FEstoque.GetUnidade(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p])='KG' ) and // 21.08.15
                    ( trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p])<>'' ) then begin
// 25.04.19 - Novicarnes - NOtas San Raphael e toneladas mas no produto peso zerado
          if FEstoque.GetPeso(trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p])) >0 then
             qualqtde:= (1000*Det[r].Prod.qCom)/FEstoque.GetPeso(trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p]))
          else
             qualqtde:= (1000*Det[r].Prod.qCom)/1;

          qualunitario:=(Det[r].Prod.vUnCom/1000);
// 02.07.13 - Metalforte - perfis de x metros em kilos para metros
// 14.11.13 - Metalforte - perfis de x metros em kilos para barras - Mari
        end else if ( UpperCase( Det[r].Prod.uTrib ) = 'KG' ) and
                    ( trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p])<>'' ) and
                    (  copy(Det[r].Prod.NCM,1,5)='76042' )
          then begin
          comprimento:=FEstoque.GetComprimentoPadrao(EdUnid_codigo.text ,trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p]));
//          qualqtde:= (Det[r].Prod.qCom)/(FEstoque.GetPeso(trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p]))*comprimento);
//          qualunitario:=( Det[r].Prod.vProd/qualqtde);
          qualqtde:=Det[r].Prod.qCom;
          if comprimento>0 then
            qualqtde:= (qualqtde/FEstoque.GetPeso(trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p])))
                       *(comprimento/1000)
          else
            Avisoerro('Comprimento zerado ou n�o encontrado na grade');
          qualunitario:= Det[r].Prod.vProd/qualqtde;
// 14.11.13 - Metalforte - telhas em kilos para metros - Mari+Preto
        end else if ( UpperCase( Det[r].Prod.uTrib ) = 'KG' ) and
                    ( trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p])<>'' ) and
                    (  copy(Det[r].Prod.NCM,1,8)='73089090' )
          then begin
          comprimento:=FEstoque.GetComprimentoPadrao(EdUnid_codigo.text ,trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p]));
//          qualqtde:= (Det[r].Prod.qCom)/(FEstoque.GetPeso(trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p]))*comprimento);
//          qualunitario:=( Det[r].Prod.vProd/qualqtde);
          qualqtde:=Det[r].Prod.qCom;
          if comprimento>0 then
            qualqtde:= (qualqtde/FEstoque.GetPeso(trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p])))/(comprimento/1000)
          else
            Avisoerro('Comprimento zerado ou n�o encontrado na grade');
          qualunitario:= Det[r].Prod.vProd/qualqtde;

        end else begin
          qualqtde:=Det[r].Prod.qCom;
          qualunitario:=Det[r].Prod.vUnCom;
        end;
// pra 'fechar' o total de produtos verifica se vprod=qcom*vcom senao recalcula unitario...
        xmltotalitem:=Det[r].Prod.vProd;
        if Abs( xmltotalitem-(qualqtde*Qualunitario) ) > 0.02 then
          qualunitario:=xmltotalitem/qualqtde;
// 20.08.2021
        if ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring = Global.CodEntradaNFPe )
           and
          ( Global.Topicos[1479] )
          then begin

             qualunitario := 0;
             xmltotalitem := 0;

        end;

        Grid.Cells[Grid.Getcolumn('move_qtde'),p]:=transform(qualqtde,f_qtdestoque);
//        Grid.Cells[Grid.Getcolumn('move_venda'),p]:=TRansform(qualunitario,f_cr);
// 22.09.11 - Novi - vava
        Grid.Cells[Grid.Getcolumn('move_venda'),p]:=TRansform(qualunitario,f_cr5);
        Grid.Cells[Grid.Getcolumn('total'),p]:=TRansform(qualqtde*Qualunitario,f_cr);
        Grid.Cells[Grid.Getcolumn('qtdeprev'),p]:=TRansform(qualqtde,f_cr);
//        Grid.Cells[Grid.Getcolumn('valoruni'),p]:=TRansform(qualunitario,f_cr);
        Grid.Cells[Grid.Getcolumn('valoruni'),p]:=TRansform(qualunitario,f_cr5);

        margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(produto,EdUnid_codigo.text,Emit.EnderEmit.UF));
        codigosit:=strtoint( FSittributaria.GetCodigoCst( Grid.Cells[Grid.Getcolumn('move_cst'),p] ,'E' ) );
// 20.10.11 - Silvano - contabilidade
// 08.09.2021 - clessi - zerar icms nf mat. de uso e consumo
        if ( Global.Topicos[1352] ) or  ( (Global.Topicos[1480]) and ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring = Global.CodCompraMatConsumo ) )
          then
          codigofis:=FCodigosFiscais.GetCodigoFis( 'I',0,0 )
        else
          codigofis:=FCodigosFiscais.GetCodigoFis( 'I',Det[r].Imposto.ICMS.pICMS,Det[r].Imposto.ICMS.pRedBC );

////////////////////        aviso( codigofis + 'p='+inttostr(p) );

        Grid.Cells[Grid.Getcolumn('margemlu'),p]:=Transform(margemlucro,f_cr);
        Grid.Cells[Grid.Getcolumn('codigosittrib'),p]:=inttostr(codigosit);
        Grid.Cells[Grid.Getcolumn('codigofis'),p]:=codigofis;
        Grid.Cells[Grid.Getcolumn('move_pecas'),p]:=TRansform(0,f_cr);
        Grid.Cells[Grid.Getcolumn('move_certificado'),p]:='N';
        Grid.Cells[Grid.Getcolumn('move_natf_codigo'),p]:=ConverteCfop( Det[r].Prod.cfop );
//        Grid.Cells[Grid.Getcolumn('move_redubase'),p]:=TRansform(Det[r].Imposto.icms.pRedBC,f_cr3);
// gravar o 'reducao do sac'...
        if Det[r].Imposto.ICMS.pRedBC>0 then
          Grid.Cells[Grid.Getcolumn('move_redubase'),p]:=TRansform(100-Det[r].Imposto.icms.pRedBC,f_cr3)
        else
          Grid.Cells[Grid.Getcolumn('move_redubase'),p]:=TRansform(Det[r].Imposto.icms.pRedBC,f_cr3);
//}
        if codigosit=0 then begin
//          if strtointdef(,0)>0 then
//            codigosit:=IncluiCSTEntrada(Grid.Cells[Grid.Getcolumn('move_cst'),p]
//          else begin
            aviso('Ver Cadastro de Sit. Tribut�ria.  N�o encontrado cadastro referente Entrada para o CST '+Grid.Cells[Grid.Getcolumn('move_cst'),p]);
            avisoerro('Importa��o de itens interrompida');
            break;
//          end;
        end;
// 20.10.11 - Silvano - contabilidade
// 08.09.2021 - clessi - zerar icms nf mat. de uso e consumo
        if ( Global.Topicos[1352] ) or  ( (Global.Topicos[1480]) and ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring = Global.CodCompraMatConsumo ) )
           then begin

           Grid.Cells[Grid.Getcolumn('move_aliicms'),p]:=transform(0,'#0.0');
           Grid.Cells[Grid.Getcolumn('move_redubase'),p]:=TRansform(0,f_cr3);

        end;
// 27.05.12 - Asatec
        Grid.Cells[Grid.Getcolumn('voutro'),p]:=TRansform( Det[r].Prod.vOutro,f_cr );
// 13.09.12 - Quantidade por Embaagem
        if Global.Topicos[1356] then begin
          Grid.Cells[Grid.Getcolumn('move_unitarionota'),p]:=TRansform(Det[r].Prod.vUnCom,f_cr4);
          Grid.Cells[Grid.Getcolumn('move_embalagem'),p]:=TRansform(embala,f_cr);
        end;
// 12.03.14 - Mirvane
        Grid.Cells[Grid.Getcolumn('codigobarra'),p]:=Det[r].Prod.cEAN;
// 27.04.15 - Devereda
        Grid.Cells[Grid.Getcolumn('descontouni'),p]:=currtostr(Det[r].Prod.vDesc);
// 22.07.2022 - Devereda
        if Global.Topicos[1483] then
           Grid.Cells[Grid.Getcolumn('custocomst'),p]:=currtostr( GetCustocomst(Det[r].infAdProd) );

// 08.09.14 - acess violation em algums xmls
        if TEstoque<>nil then
          if TEstoque.SQLConnection<>nil then
            FGeral.FechaQuery(TEstoque);

        if strtointdef(codigofis,0)=0 then begin
          if Det[r].Imposto.ICMS.pRedBC>0 then
            aviso('Ver cadastro de Codigos de Al�quotas.  N�o encontrado cadastro adequado para a al�quota de icms '+Grid.Cells[Grid.Getcolumn('move_aliicms'),p]+
                    ' e redu��o '+Valortosql(100-Det[r].Imposto.ICMS.pRedBC))
          else
            aviso('Ver cadastro de Codigos de Al�quotas.  N�o encontrado cadastro adequado para a al�quota de icms '+Grid.Cells[Grid.Getcolumn('move_aliicms'),p] );
          avisoerro('Importa��o de itens interrompida');
          break;
        end;
        inc(p);
        Grid.AppendRow;
    end;
  end;
end;




procedure TFNotaCompra.EdArquivoxmlKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_f12 then bbuscaxmlClick(Sender);

end;

procedure TFNotaCompra.EdArquivoxmlValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////////
var auxarqxml:TStringList;

begin

// 20.08.2021
  if (EdArquivoxml.IsEmpty) and ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodEntradaNFPe ) then begin

     EdArquivoxml.invalid('Obrigat�rio uso de XML para dar entrada em NPF-e')

  end;
  if (EdArquivoxml.IsEmpty) and ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring<>Global.CodEstornoNFeSai ) then begin

    Acbrnfe1.NotasFiscais.Clear; // 19.08.11 - pra evitar incluir chave de nota diferente
    exit;

  end;

  XMLCTE:='';
// 07.12.16
  if ( ANSIpos( 'XML',uppercase(EdArquivoxml.text) ) = 0) and ( trim(EdArquivoxml.text)<>'' )
     then EdArquivoxml.text:=EdArquivoxml.text+'.xml';

  if ( not FileExists(EdArquivoxml.text) ) and ( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring<>Global.CodEstornoNFeSai ) then

    EdArquivoxml.invalid('Arquivo '+EdArquivoxml.text+' n�o encontrado')

  else begin

// 24.09.20
   if EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring<>Global.CodEstornoNFeSai  then begin

      auxarqxml := TStringList.create;
      auxarqxml.LoadFromFile(EdArquivoxml.Text);

   end;
// 16.06.12
/////////////
    if EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodConhecimento  then begin

// 28.06.2021
      Acbrnfe1.NotasFiscais.Clear; // pra evitar lan�ar Cte com chave+xml de nfe

// 20.07.20
      if AnsiPos('<nfeProc',auxarqxml.text ) >0 then begin

         EdArquivoxml.invalid('Arquivo '+EdArquivoxml.text+' n�o se refere a CT-e');
         exit;

      end;

      Acbrcte1.Conhecimentos.Clear;
      Acbrcte1.Conhecimentos.LoadFromFile(EdArquivoxml.Text);
      XMLCTE:=AcbrCte1.Conhecimentos.Items[0].XMLAssinado;
      ImportaDadosXMLCTe(Acbrcte1);
      EdFornec.Next;

    end else begin

// 24.09.20
      if EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring<>Global.CodEstornoNFeSai  then begin

// 20.07.20
        if AnsiPos('<cteProc',auxarqxml.text ) >0 then begin

           EdArquivoxml.invalid('Arquivo '+EdArquivoxml.text+' n�o se refere a NF-e');
           exit;

        end;

      end;

      if ( Acbrnfe1.NotasFiscais.Count=1 )  then begin
        if ( NotaEstorno='BaixadaSefa' )  then begin
           ImportaDadosXML(Acbrnfe1);
           EdFornec.Next;
           exit;
        end else if  NotaEstorno='EstornoNFe'  then begin
           ImportaDadosXML(Acbrnfe1);
           EdFornec.Next;
           exit;
        end;
      end;
      Acbrnfe1.NotasFiscais.Clear;
// 21.05.21
      if (AnsiPos('<cteProc',auxarqxml.text ) >0 )
          or
         (AnsiPos('cteOSPro',auxarqxml.text ) >0 )
         then begin

           EdArquivoxml.invalid('Arquivo '+EdArquivoxml.text+' se refere a CT-e');
           exit;

      end;

      Acbrnfe1.NotasFiscais.LoadFromFile(EdArquivoxml.Text);
      if ( not NotaAutorizada(Acbrnfe1.NotasFiscais.Items[0].XML) )  and ( not Global.Usuario.OutrosAcessos[0330] ) then

        EdArquivoxml.invalid('Arquivo '+EdArquivoxml.text+' n�o autorizado pela Sefa')

      else if ( not NotaAutorizada(Acbrnfe1.NotasFiscais.Items[0].XML) )  and ( Global.Usuario.OutrosAcessos[0330]) then begin

        Aviso('Arquivo '+EdArquivoxml.text+' n�o autorizado pela Sefa.  Contactar fornecedor');
        ImportaDadosXML(Acbrnfe1);
        EdFornec.Next;

      end else begin

        ImportaDadosXML(Acbrnfe1);
        EdFornec.Next;

      end;
    end;

  end;


end;

procedure TFNotaCompra.bbuscaxmlClick(Sender: TObject);
///////////////////////////////////////////////////////
var pastaxmls:string;
    ListaNFe,
    ListaChavesNFe : TStringList;

     procedure LeXmls;
     ////////////////
     var p,
         mes    : integer;
         ycnpj,
         cchave : string;

     begin

        Sistema.beginprocess('Armazenando arquivos Xmls...');
        ListaArq.Directory:=PastaXmls;
        Sistema.beginprocess('Encontrado '+inttostr(ListaArq.Items.Count)+' Xmls');
        ListaNFe        := TStringList.create;
        ListaChavesNFe := TStringList.create;

        for p:=0 to ListaArq.Items.Count-1 do begin

//           filtrar somente do mes da data do sistema e anterior...
           mes :=  strtointdef( copy( ListaArq.Items[p],5,2 ),0 );
           if ( mes >=  ( Datetomes( Sistema.hoje )-1 ))
               and
              ( copy(ListaArq.Items[p],21,02) = '55' )
           then begin

              ycnpj := FFornece.GetNomepeloCnpj( copy(ListaArq.Items[p],7,14 ) );
              if trim(ycnpj)='' then ycnpj:=FGeral.Formatacnpj(copy(ListaArq.Items[p],7,14 ) );

              ListaNfe.add( copy(ListaArq.Items[p],26,09 ) + ' | '+ strspace(ycnpj,40) + ' > '+ListaArq.Items[p] );
              ListaChavesNFE.add( ListaArq.Items[p] );

           end;

        end;

        if ListaNFe.count>0 then begin

           ListaNFe.sort;
           cchave := SelecionaItems(ListaNFe,'N�mero de Notas dos XMLs','',false);
           if ( trim(cchave)<>'' ) and ( AnsiPos('>',cchave)>0 )  then cchave := copy(cchave, AnsiPos('>',cchave)+2,60);

           EdArquivoxml.Text:=cchave;
           EdArquivoxml.Next;

        end;
        ListaNfe.free;
        LIstaChavesNfe.free;
        Sistema.endprocess('');

     end;

begin

   if EdComv_codigo.ResultFind <> nil then begin

      if od1.Execute then begin

         if Global.Topicos[1478] then begin

            pastaxmls := ExtractFilePath( Od1.FileName );
            LeXmls;

          end else begin

           EdArquivoxml.Text:=od1.FileName;
           EdArquivoxml.Next;

          end;

      end;

   end;

end;

procedure TFNotaCompra.EdCodigoprodutoExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////

    procedure GravaItemFornec;
    //////////////////////////
    var QXml:TSqlQuery;
    begin
          QXml:=Sqltoquery('select * from movnfeestoque where mnfe_status=''N'''+
//                         ' and mnfe_esto_codigo='+Stringtosql(Grid.Cells[Grid.getcolumn('move_esto_codigo'),Grid.row])+
                         ' and mnfe_tipo_codigo='+Inttostr(EdFornec.AsInteger)+
                         ' and mnfe_forn_codigo='+Stringtosql(Grid.Cells[Grid.getcolumn('produtonfe'),Grid.row]) );
        if QXml.eof then begin
          Sistema.Insert('movnfeestoque');
          Sistema.SetField('mnfe_status','N');
          Sistema.SetField('mnfe_esto_codigo',trim(EdCodigoProduto.text) );
          Sistema.SetField('mnfe_tipo_codigo',EdFornec.asinteger);
          Sistema.SetField('mnfe_forn_codigo',copy(Grid.Cells[Grid.getcolumn('produtonfe'),Grid.row],1,20));
          Sistema.SetField('mnfe_data',EdDtMovimento.asdate);
          Sistema.Post();
        end else begin   // 24.04.12
          Sistema.Edit('movnfeestoque');
          Sistema.SetField('mnfe_esto_codigo',trim(EdCodigoProduto.text) );
          Sistema.SetField('mnfe_data',EdDtMovimento.asdate);
          Sistema.Post('mnfe_status=''N'' and mnfe_tipo_codigo='+Inttostr(EdFornec.AsInteger)+
                       ' and mnfe_forn_codigo='+Stringtosql(copy(Grid.Cells[Grid.getcolumn('produtonfe'),Grid.row],1,20) ) );
        end;
        Sistema.commit;
        FGeral.FechaQuery( QXml );

    end;

    // 24.06.13 - Metalforte
    // 03.03.16 - Devereda
    Procedure AcertaPesoeValor;
    ///////////////////////////
    var xqtde,xpeso,xvenda,comprimento:currency;
    begin
      xqtde:=Texttovalor(Grid.cells[grid.getcolumn('move_qtde'),grid.row]);
      xpeso:=FEstoque.GetPeso(trim(EdCodigoProduto.text));
      xvenda:=Texttovalor(Grid.cells[grid.getcolumn('move_venda'),grid.row]);
// 03.07.13 - Metalforte - perfis de x metros em kilos para metros
// 14.11.13 - Metalforte - perfis de x metros em kilos para barras - Mari
      if ( UpperCase( Grid.cells[grid.getcolumn('esto_unidade'),grid.row] ) = 'KG' ) and
                    ( trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),grid.row])<>'' ) and
                    (  copy( Grid.Cells[Grid.Getcolumn('ncmnfe'),grid.row] ,1,5)='76042' )
          then begin
          comprimento:=FEstoque.GetComprimentoPadrao( EdUnid_codigo.text,trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),grid.row]));
          if comprimento>0 then
            xqtde:= (xqtde/xpeso)*(comprimento/1000)
          else
            Avisoerro('Comprimento zerado ou n�o encontrado na grade');
          xvenda:= Texttovalor(Grid.cells[grid.getcolumn('total'),grid.row])/xqtde;

// 14.11.13 - Metalforte - telhas em kilos para metros - Mari+Preto
      end else if ( UpperCase( Grid.cells[grid.getcolumn('esto_unidade'),grid.row] ) = 'KG' ) and
                    ( trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),grid.row])<>'' ) and
                    (  copy( Grid.Cells[Grid.Getcolumn('ncmnfe'),grid.row] ,1,8)='73089090' )
          then begin
          comprimento:=FEstoque.GetComprimentoPadrao( EdUnid_codigo.text,trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),grid.row]));
          if comprimento>0 then
            xqtde:= (xqtde/xpeso)/(comprimento/1000)
          else
            Avisoerro('Comprimento zerado ou n�o encontrado na grade');
          xvenda:= Texttovalor(Grid.cells[grid.getcolumn('total'),grid.row])/xqtde;

      end else begin
        if xpeso>0 then begin
          xqtde:=(xqtde*1000)/xpeso;
          xvenda:=(Texttovalor(Grid.cells[grid.getcolumn('total'),grid.row]))/xqtde;
        end else begin
          xqtde:=xqtde;
//          Avisoerro('Falta informar o peso no cadastro do produto '+EdCodigoProduto.text);
          xvenda:=Texttovalor(Grid.cells[grid.getcolumn('move_venda'),grid.row]);
        end;
      end;
      Grid.cells[grid.getcolumn('move_qtde'),grid.row]:=Valortosql(xqtde);
      Grid.cells[grid.getcolumn('qtdeprev'),grid.row]:=Valortosql(xqtde);
      Grid.cells[grid.getcolumn('move_venda'),grid.row]:=Valortosql(xvenda);
      Grid.cells[grid.getcolumn('total'),grid.row]:=Valortosql(xvenda*xqtde);
      Grid.cells[grid.getcolumn('move_unitarionota'),grid.row]:=Valortosql(xvenda);
    end;

begin
///////////////////////
  Grid.cells[grid.getcolumn('move_esto_codigo'),grid.row]:=trim(EdCodigoProduto.text);
  EdCodigoProduto.Enabled:=false;
  EdCodigoProduto.Visible:=false;
  EdCodigoProduto.text:=trim(EdCodigoProduto.text);
  if not EdCodigoproduto.isempty then begin
    Grid.cells[grid.getcolumn('esto_descricao'),grid.row]:=FEstoque.GetDescricao(trim(EdCodigoProduto.text));
    GravaItemFornec;
    if ( Grid.cells[grid.getcolumn('esto_unidade'),grid.row]='TON' )  or
       ( (Grid.cells[grid.getcolumn('esto_unidade'),grid.row]='KG') and (copy(Grid.cells[grid.getcolumn('ncmnfe'),grid.row],1,5)='76042') )
       then
      AcertaPesoeValor;
// 03.03.16
    if Global.Topicos[1356] then
       Grid.cells[grid.getcolumn('move_embalagem'),grid.row]:=inttostr(FEstoque.GetEmbalagem(Edcodigoproduto.text));
  end;
  Grid.setfocus;
  EdCodigoProduto.Text:='';
end;

procedure TFNotaCompra.EdCodigoprodutoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
var QBusca,QEsto:TSqlquery;
    xproduto:string;

   function JatemnoGrid(xcodigo:string):boolean;
   //////////////////////////////////////////////
   var x:integer;
   begin
     x:=ProcuraGrid(Grid.getcolumn('move_esto_codigo'),xcodigo);
     if x>0 then
       result:=true
     else
       result:=false;
   end;

begin
///////////////
  if EdCodigoProduto.IsEmpty then exit;
  xproduto:=trim(EdCodigoProduto.text);
  QEsto:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+Stringtosql(xproduto)+
                     ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
  QBusca:=sqltoquery('select * from estoque where esto_Codigo='+Stringtosql(xproduto));
  if QBusca.Eof then
    EdCodigoProduto.Invalid('Codigo n�o encontrado no estoque')
  else  if QEsto.eof then
      EdCodigoProduto.Invalid('Codigo ainda n�o cadastrado na unidade '+EdUnid_codigo.text)
//      exit
  else if JatemnoGrid(EdCodigoproduto.text) then
      Aviso('Aten��o.  Codigo de produto j� usado nesta nota');
  if (EdCodigoProduto.Items.count>0) and ( not Qbusca.eof ) then
//    if EdCodigoProduto.Items.IndexOf(Edcodigoproduto.text)=-1 then
// 03.07.13 - Metalforte - Rosangela
    if pos(EdCodigoProduto.text, EdCodigoProduto.Items.Text)=0 then
      Aviso('Aten��o.  Codigo NCM da nota fiscal pode ser diferente do NCM no cadastro do produto');

  FGEral.FechaQuery(QBusca);
  FGEral.FechaQuery(QEsto);
end;

function TFNotaCompra.ConverteCodigo(xproduto: string; Fornecedor:integer ; xcodbarra:string): string;
//////////////////////////////////////////////////////////////////////////////////////////////////////
var QXml:TSqlquery;
begin

  QXml:=Sqltoquery('select * from movnfeestoque where mnfe_status=''N'''+
                   ' and mnfe_tipo_codigo='+Inttostr(Fornecedor)+
                   ' and mnfe_forn_codigo='+Stringtosql(xproduto) );
  if not QXml.eof then
    result:=QXml.fieldbyname('mnfe_esto_codigo').asstring
  else
    result:='';

// pesquisa SEMPRE pelo codigo de barra ( se vier no xml )
  if (  Global.Topicos[1059] ) and ( trim(xcodbarra)<>'' ) and ( xcodbarra<>'SEM GTIN' ) then begin

       FGEral.FechaQuery(QXml);
       QXml:=Sqltoquery('select esto_codigo from estoque'+
                            ' where esto_codbarra='+Stringtosql(xcodbarra) );
       if not QXml.eof then result:=QXml.fieldbyname('esto_codigo').asstring else result:='';

  end else begin

    // 12.03.14 - pesquisa pelo codigo de barra somente quando n�o encontra codigo j� digitado
      if ( result='' ) and ( trim(xcodbarra)<>'' ) and ( xcodbarra<>'SEM GTIN' ) then begin
           FGEral.FechaQuery(QXml);
           QXml:=Sqltoquery('select esto_codigo from estoque'+
                            ' where esto_codbarra='+Stringtosql(xcodbarra) );
           if not QXml.eof then result:=QXml.fieldbyname('esto_codigo').asstring;
      end;


  end;

  FGEral.FechaQuery(QXml);

end;


procedure TFNotaCompra.EdContacreditoValidate(Sender: TObject);
begin
   if Edcontacredito.ResultFind<>nil then begin
     if Edcontacredito.ResultFind.FieldByName('plan_tipo').asstring<>'M' then
       Edcontacredito.invalid('Somente permitido contas tipo M')
     else if EdContacredito.Asinteger=EdPlan_conta.asinteger then
       Edcontacredito.invalid('Conta cr�dito tem que ser diferente da conta')
   end;

end;

procedure TFNotaCompra.bMoveLeftClick(Sender: TObject);
begin
   Grid.MoveLeftColumn;

end;

procedure TFNotaCompra.bMoveRightClick(Sender: TObject);
begin
   Grid.MoveRightColumn;

end;

procedure TFNotaCompra.bLoadGridClick(Sender: TObject);
begin
   Grid.LoadGrid;

end;

procedure TFNotaCompra.bSaveGridClick(Sender: TObject);
begin
   Grid.SaveGrid;

end;

// 08.05.20
procedure TFNotaCompra.bcodbarraClick(Sender: TObject);
///////////////////////////////////////////////////////////
begin

    if not pcodbarra.Visible then begin

      pcodbarra.Visible:=true;
      pcodbarra.Enabled:=true;
      gridcodbarra.SetFocus;

    end else begin

      pcodbarra.Visible:=false;
      pcodbarra.Enabled:=false;

    end;

end;

procedure TFNotaCompra.bconsultanfeClick(Sender: TObject);
begin

 {
 if Acbrnfe1.NotasFiscais<>nil then begin
   if Acbrnfe1.NotasFiscais.Count=1 then begin
     FSiteWebservices.execute('C',copy(Acbrnfe1.NotasFiscais.Items[0].NFe.infNFe.ID,4,44) );

 end;
   }

  if Global.usuario.codigo=100 then  FLENFeEmail.show;

end;


procedure TFNotaCompra.EdNatf_codigoitemValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
begin

    if pos(copy(EdNatf_codigoitem.text,1,1),'1;2;3;')=0 then
      EdNatf_codigoitem.Invalid('Cfop inv�lido para nota de entrada')
    else if copy(EdNatf_codigoitem.text,1,1)<>copy(EdNatf_codigo.text,1,1) then
      EdNatf_codigoitem.Invalid('Checar Cfop dentro/fora do estado');
// 15.10.18 - Seip
    if copy( EdNatf_codigoitem.Text,1,1 ) = '3' then EdPercipi.SetValue( Fcodigosipi.GetPerIPI( FEstoque.GetNCMipi(EdProduto.text) ));

end;

// 21.11.11
/////////////////////////////////////////////////////////////////////////////////
procedure TFNotaCompra.TrataNCM(xNCM,xdescricao,xproduto: string ; xaliipi:currency);
/////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    proximo:integer;
    xdescri:string;
begin
  Q:=sqltoquery('select * from codigosipi where Cipi_codfiscal='+Stringtosql(xNCM));
  if Q.eof then begin
    Q.close;
    Q:=sqltoquery('select max(cipi_codigo) as maior from codigosipi');
    proximo:=Q.fieldbyname('maior').asinteger+1;
    xdescri:=FGeral.TiraBarra(xdescricao,chr(39));
    Sistema.Insert('codigosipi');
    Sistema.SetField('cipi_codigo',proximo);
    Sistema.SetField('cipi_descricao',SpecialCase(copy(xdescri,1,50)));
    Sistema.SetField('cipi_codfiscal',xNCM );
    Sistema.SetField('cipi_aliquota',xaliipi);
    Sistema.SetField('cipi_fabricap','N');  // fixo por enquanto
// deixado por enquanto...
//  cipi_cst character varying(3)
    Sistema.Post();
//    try
//      Sistema.Commit;
//    except
//      Avisoerro('N�o foi poss�vel incluir o NCM '+xNCM)
//    end;
  end else proximo:=Q.FieldByName('cipi_codigo').AsInteger;

  if (trim(xProduto)<>'') and (Global.Topicos[1482]) then begin
     Sistema.Edit('estoque');
     Sistema.SetField('esto_cipi_codigo',proximo);
     Sistema.Post( 'esto_codigo = '+StringToSql(xproduto));
  end;
// 11.07.2022
    try
      Sistema.Commit;
    except
      Avisoerro('N�o foi poss�vel incluir/atualizar o NCM '+xNCM)
    end;
  FGeral.FechaQuery(Q);
end;

procedure TFNotaCompra.bfechadiClick(Sender: TObject);
begin
   EdPort_codigo.setfocus;
   PImportacao.Visible:=false;
   PImportacao.Enabled:=false;
end;

procedure TFNotaCompra.babrediClick(Sender: TObject);
begin
   PImportacao.Visible:=true;
   PImportacao.Enabled:=true;
   EdNumerodi.SetFocus;

end;

procedure TFNotaCompra.EdlocaldesembaracoExitEdit(Sender: TObject);
begin
   PImportacao.Visible:=false;
   PImportacao.Enabled:=false;
   EdPort_codigo.setfocus;
end;

procedure TFNotaCompra.brelauditoriafiscalClick(Sender: TObject);
begin
  if OP='A' then
    if not Sistema.Processando then FRelGerenciais_AuditoriaFiscal;

end;

procedure TFNotaCompra.EdCfopitemExitEdit(Sender: TObject);
begin

  if not EdCfopitem.isempty then begin
    Grid.cells[grid.getcolumn('move_natf_codigo'),grid.row]:=EdCfopitem.text;
    EdCfopitem.Enabled:=false;
    EdCfopitem.Visible:=false;
  end;
  Grid.setfocus;

end;

procedure TFNotaCompra.EdcodbarraExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////
var xport:string;

     function GetPortadorpelobanco(xbanco:string):string;
     //////////////////////////////////////////////
     var QBanco,
         QPort:TSqlquery;
     begin

       QBanco:=sqltoquery('select * from plano where plan_codigobanco = '+stringtosql(xbanco));
       if QBanco.eof then begin
          Avisoerro('N�o encontrado conta com banco '+xbanco+' configurado nas contas gerenciais');
          result :='';

       end else begin

          QPort := sqltoquery('select * from portadores where port_plan_conta = '+
                               inttostr( QBanco.FieldByName('plan_conta').AsInteger ));
          if QPOrt.Eof then begin

            Avisoerro('N�o encontrado portador com  a conta '+inttostr( QBanco.FieldByName('plan_conta').AsInteger));
            result :='';

          end else begin

            result :=QPort.FieldByName('port_codigo').AsString;

          end;
          FGeral.FechaQuery(QPort);

       end;

       FGeral.FechaQuery(Qbanco);

     end;

begin

   GridCodBarra.Cells[GridCodBarra.Col,GridCodBarra.Row]:=(Edcodbarra.text);
   GridCodBarra.SetFocus;
   if length(trim(Edcodbarra.Text)) > 30 then begin

      xPort := GetPortadorpelobanco( copy(Edcodbarra.Text,01,3) );
      if trim(xport)<>'' then begin

//        EdPort_codigo.Text := GetPortadorpelobanco( copy(Edcodbarra.Text,18,3) );
        EdPort_codigo.Text := GetPortadorpelobanco( copy(Edcodbarra.Text,01,3) );
        EdPort_codigo.ValidFind;

      end;

   end;
   EdCodBarra.Visible:=False;

end;

procedure TFNotaCompra.bbuscanfeClick(Sender: TObject);
begin
  FBuscaXmlSefa.Execute;
// 24.01.15
//   FBuscaXmlSefa.show;
end;

//////////////////// 16.06.12
function TFNotaCompra.TrataCodigoProdutoXML(xcodigo: string ; xr:integer): string;
//////////////////////////////////////////////////////////////////////////////////////
var p:integer;
    QE:TSqlquery;
    ccodigo,desc:string;
begin
  result:=copy(xcodigo,length(xcodigo)-12+1,12);
  ccodigo:=trim(result);
//  for p:=1 to length(xcodigo) do begin
//    if xcodigo[p]='0' then result:=copy(result,
//  end;
// rever os zeros a esquerda que vem do html da sefa
   QE:=sqltoquery('select esto_codigo from estoque where esto_codigo='+Stringtosql(ccodigo));
   if Qe.Eof then begin
      Sistema.Insert('estoque');
      Sistema.SetField('esto_codigo',ccodigo);
      desc:=copy(AcbrNfe1.NotasFiscais.Items[0].NFe.Det[xr].Prod.xProd ,1,50);
      desc:=FGeral.TiraBarra(desc,chr(39));
      Sistema.SetField('esto_descricao',Specialcase(desc));
      Sistema.SetField('esto_unidade',copy(AcbrNfe1.NotasFiscais.Items[0].NFe.Det[xr].Prod.uTrib ,1,05));
      Sistema.SetField('esto_embalagem',1);
      Sistema.SetField('esto_peso',0);
      Sistema.SetField('esto_emlinha','S');
      Sistema.SetField('esto_usua_codigo',Global.usuario.codigo);
      Sistema.SetField('esto_sugr_codigo',1);
      Sistema.SetField('esto_fami_codigo',1);
      Sistema.SetField('esto_grup_codigo',1);
      Sistema.SetField('esto_cipi_codigo',FCodigosipi.NcmtoCodigo( AcbrNfe1.NotasFiscais.Items[0].NFe.Det[xr].Prod.NCM ));
//      Sistema.SetField('esto_REFERENCIA',trim(Tabela.FieldByName('CODIGO').AsString));
      Sistema.Post();
   end;
   FGeral.FechaQuery(Qe);
   QE:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+EdUnid_codigo.assql+
                  ' and esqt_esto_codigo='+stringtosql(ccodigo)+' and esqt_status=''N''');
   if Qe.eof then begin
            Sistema.Insert('EstoqueQtde');
            Sistema.Setfield('esqt_status','N');
            Sistema.Setfield('esqt_unid_codigo',EdUNid_codigo.text);
            Sistema.Setfield('esqt_esto_codigo',ccodigo);
            Sistema.Setfield('esqt_qtde',0);
            Sistema.Setfield('esqt_qtdeprev',0);
            Sistema.Setfield('esqt_vendavis',0);
            Sistema.Setfield('esqt_custo',0);
            Sistema.Setfield('esqt_custoger',0);
            Sistema.Setfield('esqt_customedio',0);
            Sistema.Setfield('esqt_customeger',0);
  //          Sistema.Setfield('esqt_dtultvenda',emissao);
//            Sistema.Setfield('esqt_dtultcompra',EdDtemissao.asdate);
//            Sistema.Setfield('esqt_desconto',QEstoqueQtde.fieldbyname('esqt_desconto').ascurrency);
//            Sistema.Setfield('esqt_basecomissao',QEstoqueQtde.fieldbyname('esqt_basecomissao').ascurrency);

            Sistema.Setfield('esqt_cfis_codigoest',GetSittDentro(Global.CodigoUnidade));
            Sistema.Setfield('esqt_cfis_codigoforaest',GetSittFora(Global.CodigoUnidade));
            Sistema.Setfield('esqt_sitt_codestado',GetSittDentro(Global.CodigoUnidade) );
            Sistema.Setfield('esqt_sitt_forestado',GetSittFora(Global.CodigoUnidade));
            Sistema.Setfield('esqt_usua_codigo',Global.Usuario.codigo);
            Sistema.Post('');
   end;
   FGeral.FechaQuery(Qe);
   Sistema.Commit;

end;

////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TFNotaCompra.GetListaNfe(TLista: TStringList; xES: string; qtipomov:string='' );
///////////////////////////////////////////////////////////////////////////////////////////
var Q:Tsqlquery;
    sqlconfmov,tiposnao,tiposdemovimento,sqlexp,
    sqles,
    sqltiposdemovimento  :string;
    Di,Df                :TDatetime;

begin
//  sqlexp:=' and extract( year from moes_dtnfeauto ) > '+Strzero(Datetoano(Sistema.hoje,true)-1,4);
// 09.01.18 - Giacomoni -
  sqlexp:=' and extract( year from moes_dtnfeauto ) >= '+Strzero(Datetoano(Sistema.hoje,true)-1,4);
// 22.08.16
  if FGeral.GetConfig1AsInteger('Diasdevolucao') > 0 then
    Di:=Sistema.Hoje-FGeral.GetConfig1AsInteger('Diasdevolucao')
  else
    Di:=Sistema.Hoje-60;
  Df:=Sistema.Hoje;
  sqlconfmov:='';
  if FGeral.ConfiguradoECF then
    sqlconfmov:=' and moes_comv_codigo <> '+inttostr(FGeral.GetConfig1AsInteger('ConfMovECF'));

  tiposdemovimento:=Global.TiposSaida+';'+Global.CodDevolucaoCompra+';'+Global.CodCompraProdutor+';'+
                    Global.CodDrawBackEnt+';'+Global.CodDevolucaoIgualVenda+';'+Global.CodEntradaImobilizado+';'+
                    Global.CodCompraProdutorReclassifica+';'+Global.CodDevolucaoSimbolicaConsig+';'+Global.CodVendasemFinan+';'+
                    Global.CodCompraConsignado+';'+Global.CodDevolucaodeRemessa+';'+Global.CodDevolucaoRoman+';'+
                    Global.CodNotaRemessaaOrdem+';'+
                    FGeral.GetConfig1AsString('TIPOSENUMSAIDA'); // 18.05.11

  sqltiposdemovimento :=' and '+FGeral.Getin('moes_tipomov',tiposdemovimento,'C');

  if xEs='S' then begin

    sqles:=' and '+FGeral.GetIN('moes_tipomov',Global.TiposSaida,'C');
    if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodDevolucaoRoman then begin
      sqles:=' and '+FGeral.GetIN('moes_tipomov',Global.CodConsigMercantil,'C');
      tiposdemovimento:=Global.CodConsigMercantil;
    end;

  end else begin

    sqles:=' and '+FGeral.GetIN('moes_tipomov',Global.TiposEntrada,'C');

  end;
// 18.03.19 - Novicarnes - complemento de icms de dev. de venda do cliente
  if qtipomov = Global.CodNfeComplementoIcmsECliente then begin

    sqles:=' and '+FGeral.GetIN('moes_tipomov',Global.CodDevolucaoVenda,'C');
    sqltiposdemovimento := '';
    sqlexp:=' and extract( year from moes_datamvto ) >= '+Strzero(Datetoano(Sistema.hoje,true)-1,4);

  end else if qtipomov = Global.CodComplementoValorE then begin

    sqles:=' and '+FGeral.GetIN('moes_tipomov',Global.CodCompra+';'+Global.CodCompra100,'C');
    sqltiposdemovimento := '';
    sqlexp:=' and extract( year from moes_datamvto ) >= '+Strzero(Datetoano(Sistema.hoje,true)-1,4);

  end;

  tiposnao:=Global.TiposNaoFiscal+';'+Global.CodPrestacaoServicos+';'+Global.CodVendaInterna;

  Q:=sqltoquery('select * from movesto'+
                ' where moes_datamvto>='+Datetosql(Di)+
                ' and '+FGeral.getin('moes_status','N;E;D','C')+
                ' and moes_datamvto<='+Datetosql(Df)+
                ' and moes_unid_codigo='+EdUnid_codigo.assql+
                 sqlconfmov+
                ' and '+FGeral.GetSqlDataNula('moes_datacont')+
                sqltiposdemovimento+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                sqlexp+sqles+
                ' order by moes_dataemissao,moes_numerodoc desc' );


  if not Q.eof then
    TLista.Add('Transa��o     | Emiss�o   | Numero |       Valor       | Raz�o Social'+space(25) );
  while not Q.eof do begin

    TLista.Add(strspace(Q.fieldbyname('moes_transacao').asstring,12)+' | '+
               FGeral.FormataData( Q.fieldbyname('moes_dataemissao').asdatetime )+' | '+
               strzero( Q.fieldbyname('moes_numerodoc').asinteger ,6)+' | '+
               FGeral.Formatavalor(Q.fieldbyname('moes_vlrtotal').ascurrency,f_cr)+' | '+
               FGeral.GetNomeRazaoSocialEntidade( Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asstring,'R') );
    Q.Next;

  end;
  FGeral.FechaQuery(Q);
end;

procedure TFNotaCompra.EdMensagemValidate(Sender: TObject);
///////////////////////////////////////////////////////////
begin
  if (EdMensagem.IsEmpty) and ( pos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodEstornoNFeSai)>0 ) then
     EdMensagem.Invalid('Obrigat�rio informar a justificativa de estorno de NF-e')
  else if ( Global.Topicos[1462] ) and ( Ansipos(EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodCompraProdutor)>0 )  then begin

      Edmoes_insumos.Enabled:=true;
      Edmoes_insumos.Visible:=true;

  end;

end;

procedure TFNotaCompra.EdEmbalagemitemExitEdit(Sender: TObject);
begin
  if not EdEmbalagemitem.isempty then begin
    Grid.cells[grid.getcolumn('move_embalagem'),grid.row]:=EdEmbalagemitem.text;
    EdEmbalagemitem.Enabled:=false;
    EdEmbalagemitem.Visible:=false;
  end;
  Grid.setfocus;


end;
// 13.09.12
procedure TFNotaCompra.brestauragridClick(Sender: TObject);
//////////////////////////////////////////////////////////
begin
   Grid.RestoreGrid;
end;

procedure TFNotaCompra.Edmoes_tabp_codigoValidate(Sender: TObject);
begin
  SetEdTabp_aliquota.text:=FTabela.GetDescAliquota(EdMoes_tabp_codigo.asinteger)

end;

procedure TFNotaCompra.EdSeto_codigoExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////////////
begin
  if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodRetornocomservicos) >0 then
    bservicosclick(self)
  else if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodConhecimento+';'+Global.CodEntradaSemItens) =0 then
    bincluiritemclick(FNotaCompra)
  else
    EdPort_codigo.setfocus;

end;

////////// 20.09.13
procedure TFNotaCompra.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
///////////////////////////////////////////////////////////////////////
var QM:TSqlquery;
//    codequi:string;
    Datainicial:TDatetime;
begin
//  if key=#112 then begin
////////////////////  if EdCodequi.IsEmpty then exit;
//  codequi:=EdCodEqui.text;
// 08.04.16
  if FGeral.getconfig1asinteger('DIASPEDIDO') >0 then
    Datainicial:=Sistema.hoje-FGeral.getconfig1asinteger('DIASPEDIDO')
  else
    Datainicial:=Sistema.hoje-40;

  if (key=vk_f11) and ( trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),Grid.row])<>'' ) and (Global.Topicos[1367]) then begin
    EdManutencao.Visible:=true;
    EdManutencao.Enabled:=true;
    EdManutencao.Clear;
//////////////////////////////////////
{
    QM:=sqltoquery('select * from movestoque inner join estoque on ( esto_codigo=move_esto_codigo )'+
                   ' where move_tipomov='+Stringtosql(Global.CodManutencaoEquipamento)+
                   ' and move_tipo_codigo='+codequi+
                   ' and move_datamvto >= '+Datetosql(Datainicial)+
                   ' and move_status='+Stringtosql('N'));
    EdManutencao.Items.Clear;
    if not Qm.Eof then begin
      EdManutencao.ShowForm:='';
      EdManutencao.Items.Add('OPera��o   Documento '+space(01)+'Produto/Servi�o');
      EdManutencao.TagStr:='M';
      while not QM.eof do begin
        EdManutencao.Items.Add(strspace(QM.fieldbyname('move_operacao').asstring,12)+' '+
                               strspace(QM.fieldbyname('move_numerodoc').asstring,08)+' '+
                               strspace(QM.fieldbyname('move_esto_codigo').asstring,08)+' - '+
                               QM.fieldbyname('esto_descricao').asstring );
        QM.Next;
      end;
      }
/////////////////////
//    end else begin

      QM:=sqltoquery('select * from equipamentos order by equi_descricao');
//      EdManutencao.Items.Add('Codigo  Equipamento');
      EdManutencao.TagStr:='E';
//      while not QM.eof do begin
//        EdManutencao.Items.Add(strspace(QM.fieldbyname('equi_codigo').asstring,04)+' '+
//                               QM.fieldbyname('equi_descricao').asstring );
//        QM.Next;
        EdManutencao.ShowForm:='FEquipamentos';
//      end;
//    end;
    FGeral.FechaQuery(QM);
    EdManutencao.setfocus;
    EdManutencao.Valid;
// 07.10.15
////////////////
//  end else if (key=vk_f11) and ( trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),Grid.row])<>'' ) and (Global.Topicos[1385]) then begin
// 27.01.16 - para prever  entradas sem itens
  end else if (key=vk_f11) and (Global.Topicos[1385]) then begin
    Edos.Visible:=true;
    Edos.Enabled:=true;
    Edos.Items.clear;
    QM:=sqltoquery('select * from movped '+
                   ' where mped_tipomov='+stringtosql(Global.CodOrdemdeServico)+
                   ' and mped_datamvto >= '+Datetosql(Datainicial)+
                   ' and '+fGeral.getin('mped_unid_codigo',EdUnid_codigo.text,'C')+
                   ' and mped_status='+Stringtosql('N'));
    while not QM.eof do begin
        EdOS.Items.Add(strspace(QM.fieldbyname('mped_transacao').asstring,12)+' | '+
                         strzero(QM.fieldbyname('mped_numerodoc').asinteger,06)+' | '+
                         FCadcli.getnome(QM.fieldbyname('mped_tipo_codigo').asinteger) );
        QM.Next;
//        EdOS.ShowForm:='FEquipamentos';
    end;
    FGeral.FechaQuery(QM);
    EdOS.setfocus;
    EdOs.clear;
    EdOS.Valid;
  end;

end;

procedure TFNotaCompra.EdManutencaoExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////////////////////////
begin
    EdManutencao.Visible:=false;
    EdManutencao.Enabled:=false;
    if EdManutencao.TagStr='M' then
      Grid.Cells[grid.GetColumn('move_operacao'),grid.Row]:=EdManutencao.text+';'+EdCodEqui.text
    else
      Grid.Cells[grid.GetColumn('move_operacao'),grid.Row]:=strzero(0,12)+';'+Edmanutencao.text;
    Grid.SetFocus;
end;

procedure TFNotaCompra.EdManutencaoKeyPress(Sender: TObject;  var Key: Char);
/////////////////////////////////////////////////////////////////////////////////
begin
  if key=#13 then begin
    EdManutencao.Visible:=false;
    EdManutencao.Enabled:=false;
  end;
end;

procedure TFNotaCompra.EdCodEquiExitEdit(Sender: TObject);
///////////////////////////////////////////////////////////////
var y:integer;
begin
  for y:=1 to Grid.RowCount do begin
    if ( trim(Grid.Cells[grid.GetColumn('move_esto_codigo'),y])<>'' )
 //      and ( trim(Grid.Cells[grid.GetColumn('move_operacao'),y])='' )
       then
      Grid.Cells[grid.GetColumn('move_operacao'),y]:=EdManutencao.text+';'+EdCodEqui.text
  end;
// 05.09.19
  bGravarClick(self);

end;

procedure TFNotaCompra.EdCodEquiChange(Sender: TObject);
////////////////////////////////////////////////////////////////
var y:integer;
begin

// 08.03.20
  if length(trim(EdCodequi.Text))=4 then begin

    for y:=1 to Grid.RowCount do begin
      if ( trim(Grid.Cells[grid.GetColumn('move_esto_codigo'),y])<>'' )
  //       and ( trim(Grid.Cells[grid.GetColumn('move_operacao'),y])='' )
         then
        Grid.Cells[grid.GetColumn('move_operacao'),y]:=strzero(0,12)+';'+EdCodEqui.text
    end;

  end;

end;

// 05.03.14
procedure TFNotaCompra.eddiavencimentoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////
var acumulado,valortotal,valorparcela,dif:currency;
    nparcelas,p,dias:integer;
    emissao,vencimento,vencanterior:Tdatetime;
begin
///////////////
  if (Eddiavencimento.asinteger>0) and ( not PParcelas2.Enabled ) then  begin
//{
    GridParcelas.Clear;
    Gridcodbarra.Clear; // 11.05.20
    nparcelas:=EdNparcelas.asinteger;
//    if nparcelas>6 then
//      nparcelas:=6;  // somente para limitar exibi��o no grid
    acumulado:=0;dias:=0;
    valortotal:=EdDigtotalnf.AsCurrency;
//    emissao:=EdDtemissao.AsDate;
// 08.05.08
    emissao:=Texttodate( strzero(Eddiavencimento.asinteger,2)+strzero(Datetomes(EdDtemissao.AsDate),2)+strzero(Datetoano(EdDtemissao.AsDate,true),4) );
    vencimento:=Texttodate( strzero(Eddiavencimento.asinteger,2)+strzero(Datetomes(emissao),2)+strzero(Datetoano(Emissao,true),4) );
    dif:=(nparcelas*valorparcela)-valortotal;
    for p:=1 to nparcelas do begin
      if (p=1) and (Texttodate( strzero(Eddiavencimento.asinteger,2)+strzero(Datetomes(emissao),2)+strzero(Datetoano(Emissao,true),4) )>emissao) and (Datetomes(vencimento)=Datetomes(emissao)) then
        vencimento:=Texttodate( strzero(Eddiavencimento.asinteger,2)+strzero(Datetomes(emissao),2)+strzero(Datetoano(Emissao,true),4) )
      else begin
        dias:=dias+30;
//        vencimento:=emissao+dias;
        vencimento:=DatetoDateMespos(Vencimento,1);
// 20.06.13
//        vencimento:=FGeral.GetProximoDiaUtil(vencimento);
        vencimento:=Texttodate( strzero(Eddiavencimento.asinteger,2)+strzero(Datetomes(vencimento),2)+strzero(Datetoano(vencimento,true),4) );
        if p>1 then
          vencanterior:=strtodate(GridParcelas.cells[0,p-1]);
        if Datetoano(Vencimento,true)<=1901 then
          vencimento:=Texttodate( '2802'+strzero(Datetoano(vencanterior,true),4) );

      end;
//      GridParcelas.cells[0,p]:=formatdatetime('dd/mm/yy',vencimento) ;
// 09.03.18
      GridParcelas.cells[0,p]:=formatdatetime('dd/mm/yyyy',vencimento) ;
      valorparcela:=FGeral.Arredonda( Valortotal/nparcelas,2 );
// 31.05.17
      if p=nparcelas then
        GridParcelas.cells[1,p]:=Transform( (valortotal-acumulado)   ,f_cr)
      else
        GridParcelas.cells[1,p]:=Transform(valorparcela,f_cr);
      acumulado:=acumulado+valorparcela;
      GridParcelas.RowCount:=GridParcelas.RowCount+1;
    end;  // for do numero de parcelas
// 31.05.17 - Mettalum
  end else if (Eddiavencimento.asinteger>0) and ( EdDtMovimento.IsEmpty ) then  begin
//{
    GridParcelas2.Clear;
    nparcelas:=EdNparcelas.asinteger;
//    if nparcelas>6 then
//      nparcelas:=6;  // somente para limitar exibi��o no grid
    acumulado:=0;dias:=0;
    valortotal:=EdDigtotalnf.AsCurrency;
//    emissao:=EdDtemissao.AsDate;
// 08.05.08
    emissao:=Texttodate( strzero(Eddiavencimento.asinteger,2)+strzero(Datetomes(EdDtemissao.AsDate),2)+strzero(Datetoano(EdDtemissao.AsDate,true),4) );
    vencimento:=Texttodate( strzero(Eddiavencimento.asinteger,2)+strzero(Datetomes(emissao),2)+strzero(Datetoano(Emissao,true),4) );
    dif:=(nparcelas*valorparcela)-valortotal;
    for p:=1 to nparcelas do begin
      if (p=1) and (Texttodate( strzero(Eddiavencimento.asinteger,2)+strzero(Datetomes(emissao),2)+strzero(Datetoano(Emissao,true),4) )>emissao) and (Datetomes(vencimento)=Datetomes(emissao)) then
        vencimento:=Texttodate( strzero(Eddiavencimento.asinteger,2)+strzero(Datetomes(emissao),2)+strzero(Datetoano(Emissao,true),4) )
      else begin
        dias:=dias+30;
//        vencimento:=emissao+dias;
        vencimento:=DatetoDateMespos(Vencimento,1);
// 20.06.13
//        vencimento:=FGeral.GetProximoDiaUtil(vencimento);
        vencimento:=Texttodate( strzero(Eddiavencimento.asinteger,2)+strzero(Datetomes(vencimento),2)+strzero(Datetoano(vencimento,true),4) );
        if p>1 then
          vencanterior:=strtodate(GridParcelas.cells[0,p-1]);
        if Datetoano(Vencimento,true)<=1901 then
          vencimento:=Texttodate( '2802'+strzero(Datetoano(vencanterior,true),4) );

      end;
//      GridParcelas2.cells[0,p]:=formatdatetime('dd/mm/yy',vencimento) ;
// 09.03.18
      GridParcelas2.cells[0,p]:=formatdatetime('dd/mm/yyyy',vencimento) ;
      valorparcela:=FGeral.Arredonda( Valortotal/nparcelas,2 );
// 31.05.17
      if p=nparcelas then
        GridParcelas2.cells[1,p]:=Transform( (valortotal-acumulado)   ,f_cr)
      else
        GridParcelas2.cells[1,p]:=Transform(valorparcela,f_cr);
      acumulado:=acumulado+valorparcela;
      GridParcelas2.RowCount:=GridParcelas2.RowCount+1;
    end;  // for do numero de parcelas
  end;

end;

// 05.03.14
procedure TFNotaCompra.ParcelamentoLongo;
///////////////////////////////////////////////////////////

     function GetNumParcelas(xprazos:string):string;
     ////////////////////////////////////////////////
     begin
       result:=trim(copy(xprazos,1,pos('X',Uppercase(xprazos))-1));
     end;

begin

    PMuitasParcelas.Enabled:=true;
    PMuitasParcelas.Visible:=true;
    EdNParcelas.text:=GetNumParcelas(EdFpgt_codigo.ResultFind.fieldbyname('fpgt_prazos').AsString);
    EdDiaVencimento.SetFocus;

end;

procedure TFNotaCompra.eddiavencimentoExitEdit(Sender: TObject);
///////////////////////////////////////////////////////////////////////
begin
  PMuitasParcelas.Enabled:=false;
  PMuitasParcelas.Visible:=false;
// 20.11.19 - A2z - Thais
  if Global.Topicos[1367] then begin
        EdCodEqui.SetFocus;
        exit;
  end;

  bgravarclick(self);
end;

// 12.03.15
procedure TFNotaCompra.EdTipodocValidate(Sender: TObject);
////////////////////////////////////////////////////////////
var chavenfeacom:string;
begin
  if copy(Edtipodoc.text,1,3)='CTE' then begin
    if OP<>'I' then chavenfeacom:=EdChavenfeacom.text;
    if not Edarquivoxml.isempty then chavenfeacom:=copy(AcbrCte1.Conhecimentos.Items[0].CTe.infCTe.Id,4,44);
    if trim(chavenfeacom)='' then begin
      Input('Informe a chave do CTE ','Chave ',chavenfeacom,44,true);
      if trim(chavenfeacom)='' then begin
        if not Global.Topicos[1470] then

          Aviso('Aten��o - Informar a chave em CT-e')

        else

          EdComv_codigo.invalid('Obrigat�rio informar a chave em CT-e');

      end;
    end;
    Edchavenfeacom.text:=chavenfeacom;
 end;
end;

// 25.05.15
procedure TFNotaCompra.EdSeto_codigoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////////////
begin
  if (EdSeto_codigo.AsInteger=9999) and (EdDigtotpro.ascurrency>0) then begin
    if OP='I' then
      FRateio.Execute('Valores por OBRA','setores','seto_codigo',EdDigtotpro.ascurrency,'')
    else
      FRateio.Execute('Valores por OBRA','setores','seto_codigo',EdDigtotpro.ascurrency,transacao2)
  end;

end;

procedure TFNotaCompra.EdosExitEdit(Sender: TObject);
begin
    EdOS.visible:=false;
    EdOS.Enabled:=false;
//    if not EdOs.isempty then Grid.Cells[grid.GetColumn('move_operacao'),grid.Row]:=EdOS.text;
// 04.08.16 - rateio pra varias os(obras)
    EdQtdeos.visible:=true;
    EdQtdeos.Enabled:=true;
    EdQtdeos.setvalue( Texttovalor( Grid.cells[Grid.getcolumn('move_qtde'),grid.row] ) );
    EdQtdeos.SetFocus;
end;

// 07.10.15
procedure TFNotaCompra.F(Sender: TObject; var Key: Char);
//////////////////////////////////////////////////////////////////////////
begin
  if (key=#13) or (key=#27)  then begin
    EdOS.Visible:=false;
    EdOS.Enabled:=false;
  end;

end;

// 04.08.16
procedure TFNotaCompra.EdQtdeosValidate(Sender: TObject);
/////////////////////////////////////////////////////////
begin
   if ( Edqtdeos.ascurrency > Texttovalor( Grid.cells[Grid.getcolumn('move_qtde'),grid.row] ) )
      and
      ( Texttovalor( Grid.cells[Grid.getcolumn('move_qtde'),grid.row] )>0 )
      then
     EdQtdeos.invalid('Quantidade n�o pode ser maior que a da nota');
end;

// 04.08.16
procedure TFNotaCompra.EdQtdeosExitEdit(Sender: TObject);
/////////////////////////////////////////////////////////////
begin
  EdQTdeos.Visible:=false;
  EdQTdeos.Enabled:=false;
  if not EdQtdeOs.isempty then Grid.Cells[grid.GetColumn('move_operacao'),grid.Row]:=Grid.Cells[grid.GetColumn('move_operacao'),grid.Row]+EdOS.text+';'+EdQtdeos.text+'|';
  Grid.SetFocus;

end;

procedure TFNotaCompra.EdvlrcofinsChange(Sender: TObject);
begin

end;

// 12.09.16
procedure TFNotaCompra.EdvlrcsllExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////////////////
begin
   PRetencoes.visible:=false;
   PRetencoes.enabled:=false;
   EdMens_codigo.setfocus;
end;

// 13.09.16
procedure TFNotaCompra.EdPort_codigoExit(Sender: TObject);
//////////////////////////////////////////////////////////////
begin
// 13.09.16
  if pos( EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodPrestacaoServicosE+';' ) >0 then begin
    PRetencoes.Visible:=true;
    PRetencoes.Enabled:=true;
    if OP='I' then begin
      EdVlrPis.setvalue( EdDigTotalNF.ascurrency*(FGeral.GetConfig1AsFloat('Perpis')/100) );
      EdVlrCofins.setvalue( EdDigTotalNF.ascurrency*(FGeral.GetConfig1AsFloat('Percofins')/100) );
      Edvlrcsll.setvalue( EdDigTotalNF.ascurrency*(FGeral.GetConfig1AsFloat('Percsl')/100) );
    end;
    Edvlrinss.setfocus;
  end else begin
    PRetencoes.Visible:=false;
    PRetencoes.Enabled:=false;
    EdVlrPis.setvalue( 0 );
    EdVlrIR.setvalue( 0 );
    EdVlrCofins.setvalue( 0 );
    Edvlrcsll.setvalue( 0 );
    Edvlriss.setvalue( 0 );
  end;
////////

end;

procedure TFNotaCompra.EdvlrcsllValidate(Sender: TObject);
//////////////////////////////////////////////////////////
begin
   if (Edvlrinss.ascurrency+Edvlrpis.ascurrency+Edvlrcofins.ascurrency+Edvlrcsll.ascurrency+EdVlrir.ascurrency+EdVlrIss.AsCurrency) > EdDigtotalnf.ascurrency then
      Edvlrcsll.invalid('Valor das reten��es n�o pode ser maior que o total da nota');
end;
// 16.11.16
procedure TFNotaCompra.EdValidadeformExitEdit(Sender: TObject);
begin
// 05.12.16
  if EdRomaneio.IsEmpty then bIncluiritemClick(self) else EdPort_codigo.setfocus;
end;

// 06.01.17
procedure TFNotaCompra.ImportaDadosXMLCTe(NotaFiscal: TACbrCTe);
//////////////////////////////////////////////////////////////
type TMunicipios=record
     nome,uf,cep,codigoibge,codigopais,nomepais:string;
     codigo:integer;
end;

type TBaseporCfop=record
     TpImp,cfop,cfopsaida:string;
     Aliquota,Base,Reducao,Imposto:currency;
end;

var Q,Qt:Tsqlquery;
    ListaMunicipios,ListaBaseCfop:TList;
    PMunicipios:^TMunicipios;
    PBaseCfop:^TBaseporCfop;
    p,r,i,posplaca:integer;
    achou:boolean;
    EdTpImp,EdAl,EdBc,EdRedBc,EdImp,EdCfop:TSqlEd;
    Pesquisa:string;


    procedure LeMunicipios;
    ///////////////////////
    var Q:TSqlquery;
    begin
      Q:=sqltoquery('select * from cidades');
      ListaMunicipios:=Tlist.create;
      while not Q.eof do begin
        New(PMunicipios);
        PMunicipios.codigo:=Q.fieldbyname('cida_codigo').asinteger;
        PMunicipios.nome:=Ups(q.fieldbyname('cida_nome').asstring );
        PMunicipios.uf:=q.fieldbyname('cida_uf').asstring;
        ListaMunicipios.add( PMunicipios );
        Q.Next;
      end;
      Q.close;Freeandnil(q);
    end;

    procedure AdicionaMunicipio;
    ////////////////////////////
    var Q:TSqlquery;
        name:string;
    begin
        Q:=sqltoquery('select * from cidades where cida_codigo='+inttostr(PMUnicipios.codigo));
        if Q.eof then begin
          Sistema.Insert('cidades');
          Sistema.SetField('cida_codigo',PMUnicipios.codigo);
          Sistema.SetField('cida_nome',PMUnicipios.nome);
          Sistema.SetField('cida_uf',PMUnicipios.uf);
          Sistema.SetField('cida_regi_codigo','001');
          Sistema.SetField('cida_cep',PMunicipios.cep);
          Sistema.SetField('cida_codigoibge',PMunicipios.codigoibge);
          Sistema.SetField('cida_codigopais',PMunicipios.codigopais);
          Sistema.SetField('cida_nomepais',PMunicipios.nomepais);
          Sistema.post;
          Sistema.commit;
        end;
        Q.Close;
    end;


    function GetCodigoMunicipio(nomecidade,ufcidade:string):integer;
    ///////////////////////////////////////////////////////////////
    var p,codigo:integer;
        achou:boolean;

        function Maior:integer;
        var x,maior:integer;
        begin
          maior:=0;
          for x:=0 to LIstaMunicipios.count-1 do begin
            PMunicipios:=ListaMunicipios[x];
            if PMunicipios.codigo>maior then
              maior:=PMunicipios.codigo;
          end;
          result:=maior;
        end;

    begin
    /////////////////////////////////////////////
      achou:=false;
      for p:=0 to LIstaMunicipios.count-1 do begin
        PMunicipios:=ListaMunicipios[p];
//        if (PMunicipios.nome=ups(nomecidade) )  and (PMunicipios.uf=ufcidade )then begin
// 09.06.08
        if (ups(PMunicipios.nome)=ups(nomecidade) )  and (uppercase(PMunicipios.uf)=uppercase(ufcidade) )then begin
          result:=PMunicipios.codigo;
          achou:=true;
          break;
        end;
      end;
      if not achou then begin
//        Q:=sqltoquery('select max(muni_codigo) as ultimo from municipios');
        codigo:=Maior+1;
//        Q.close;Freeandnil(Q);
        New(PMunicipios);
        PMunicipios.codigo:=codigo;
        PMunicipios.nome:=nomecidade;
        PMunicipios.uf:=ufcidade;
        PMunicipios.cep:=inttostr( NotaFiscal.Conhecimentos.Items[0].CTe.Emit.EnderEmit.CEP );
        PMunicipios.codigoibge:=inttostr( NotaFiscal.Conhecimentos.Items[0].CTe.Emit.EnderEmit.cMun );
//        PMunicipios.codigopais:=inttostr( NotaFiscal.Conhecimentos.Items[0].CTe.Emit.EnderEmit.cPais );
//        PMunicipios.nomepais:= NotaFiscal.Conhecimentos.Items[0].CTe.Emit.EnderEmit.xPais ;
        ListaMunicipios.Add( PMunicipios );
// salva na lista para no final gravar tdos os novos municipios cadastrados
        result:=codigo;
      end;
    end;


    procedure IncluiCliente;
    ///////////////////////
    var sql,cod:string;
        Q:TSqlquery;
        Codigo:integer;
    begin
        Sql:='Select Max(Clie_Codigo) As Proximo From Clientes';
        Q:=SqlToQuery(Sql);
        if Q.FieldByName('Proximo').AsInteger>0 then begin
            Cod:=Trim(Q.FieldByName('Proximo').AsString);
            Cod:=LeftStr(Cod,Length(Cod)-1);
        end;
        Q.Close; FreeAndNil(Q);
        Codigo:=Inteiro(Cod)+1;
        Cod:=IntToStr(Codigo);
        Codigo:=Inteiro(Cod+GetDigito(Cod,'MOD'));
        with NotaFiscal.Conhecimentos.Items[0].CTe do begin
          Sistema.Insert('clientes');
          Sistema.SetField('clie_codigo',codigo);
          Sistema.SetField('clie_nome',copy(SpecialCase(Emit.xFant),1,40));
          Sistema.SetField('clie_razaosocial',copy(SpecialCase(Emit.xNome),1,40));
          if length(trim(Emit.CNPJ))=11 then
//          Sistema.SetField('clie_tipo',GetTipo(Emit.CNPJCPF));
            Sistema.SetField('clie_tipo','F')
          else
            Sistema.SetField('clie_tipo','J');
          Sistema.SetField('clie_cnpjcpf',Emit.cnpj);
          Sistema.SetField('clie_rgie',Emit.IE);
          Sistema.SetField('clie_sexo','M');
  ////        Sistema.SetField('clie_uf',PClifor.forn_uf);
          Sistema.SetField('clie_endres',copy(SpecialCase(Emit.EnderEmit.xLgr)+', '+Emit.EnderEmit.nro,1,40));
  //        Sistema.SetField('clie_endrescompl',PClifor.forn_endereco);
          Sistema.SetField('clie_bairrores',SpecialCase(Emit.EnderEmit.xBairro));
          Sistema.SetField('clie_cida_codigo_res',GetCodigoMunicipio(Emit.EnderEmit.xMun,Emit.EnderEmit.UF));
          Sistema.SetField('clie_cepres',inttostr(Emit.EnderEmit.CEP));
          Sistema.SetField('clie_foneres',Emit.EnderEmit.fone);
//          Sistema.SetField('clie_email',Emit.EnderEmit....);
          Sistema.SetField('clie_endcom',copy(SpecialCase(Emit.EnderEmit.xLgr)+', '+Emit.EnderEmit.nro,1,50));
          Sistema.SetField('clie_bairrocom',SpecialCase(Emit.EnderEmit.xBairro));
          Sistema.SetField('clie_cida_codigo_com',GetCodigoMunicipio(Emit.EnderEmit.xMun,Emit.EnderEmit.UF));
          Sistema.SetField('clie_cepcom',inttostr(Emit.EnderEmit.CEP));
          Sistema.SetField('clie_fonecom',Emit.EnderEmit.fone);
//          Sistema.SetField('clie_contacontabil',PClifor.forn_contacontabil);
          Sistema.SetField('clie_situacao','N');
          Sistema.SetField('clie_dtcad',Sistema.hoje);
          Sistema.SetField('clie_unid_codigo',Edunid_codigo.text);
          Sistema.SetField('clie_usua_codigo',Global.Usuario.Codigo);
          Sistema.SetField('clie_contribuinte','S');
          Sistema.SetField('clie_obs','IMPXML NF '+inttostr(NotaFiscal.Conhecimentos.Items[0].CTe.Ide.nCT));
  //        Sistema.SetField('clie_caractrib varchar(1)
          Sistema.Post();
          Sistema.Commit;
          EdFornec.setvalue(codigo);
        end;
    end;

    procedure IncluiFornecedor;
    //////////////////////////
    var Q:TSqlquery;
        ProxCodigo:string;
        Codigo:integer;
    begin
        Codigo:=FGeral.GetProximoCodigoCadastro('Fornecedores','Forn_Codigo');
        with NotaFiscal.Conhecimentos.Items[0].CTe do begin
          Sistema.Insert('fornecedores');
          Sistema.SetField('forn_codigo',codigo);
          Sistema.SetField('forn_nome',copy(SpecialCase(Emit.xFant),1,50));
          Sistema.SetField('forn_razaosocial',copy(SpecialCase(Emit.xNome),1,50));
          Sistema.SetField('forn_cnpjcpf',Emit.CNPJ);
          Sistema.SetField('forn_situacao','N');   // 10.02.12 - validapr
          Sistema.SetField('forn_inscricaoestadual',trim(Emit.IE));
          Sistema.SetField('forn_endereco',copy(SpecialCase(Emit.EnderEmit.xLgr)+', '+Emit.EnderEmit.nro,1,40));
          Sistema.SetField('forn_bairro',SpecialCase(copy(Emit.EnderEmit.xBairro,1,40)));
          Sistema.SetField('forn_cep',inttostr(Emit.EnderEmit.CEP));
          Sistema.SetField('forn_cida_codigo',GetCodigoMunicipio( Emit.EnderEmit.xMun, Emit.EnderEmit.UF));
          Sistema.SetField('forn_fone',copy(Emit.EnderEmit.fone,1,11));
//          Sistema.SetField('forn_fax',Emit.EnderEmit.forn_fax);
//          Sistema.SetField('forn_email',Pclifor.forn_email);
          Sistema.SetField('forn_percfunrural',0);
//          Sistema.SetField('forn_contacontabil',Pclifor.forn_contacontabil);
          Sistema.SetField('forn_datacad',Sistema.hoje);
          Sistema.SetField('forn_usua_codigo',global.Usuario.Codigo);
          Sistema.SetField('forn_contribuinte','S');
          Sistema.SetField('forn_uf',Emit.EnderEmit.UF);
          Sistema.SetField('forn_obspedidos','IMPXML NF '+inttostr(NotaFiscal.Conhecimentos.Items[0].CTe.Ide.nCT));
  //        Sistema.SetField('forn_uf',Pclifor.forn_uf);
          Sistema.Post();
          Sistema.Commit;
          EdFornec.setvalue(codigo);
       end;
    end;

    procedure MostraNota;
    ///////////////////////
    begin
       Aviso('Nome Fantasia:'+NotaFiscal.Conhecimentos.Items[0].Cte.Emit.xFant+';'+
             'Raz�o Social :'+NotaFiscal.Conhecimentos.Items[0].CTe.Emit.xNome+';'+
             'Conhecimento :'+inttostr(NotaFiscal.Conhecimentos.Items[0].CTe.Ide.nCT)+';'+
             'Emiss�o      :'+FGeral.Formatadata(NotaFiscal.Conhecimentos.Items[0].CTe.Ide.dhEmi )+';'+
             'Valor        :'+Formatfloat(f_cr,NotaFiscal.Conhecimentos.Items[0].CTe.vPrest.vTPrest) );
    end;


//////////////////////////////////
begin
//////////////////////////////////
  Sistema.Beginprocess('Lendo munic�pios');
  Edvaloripi.setvalue(0);
  LeMunicipios;
  Sistema.Endprocess('');

    MostraNota;
    if not confirma('Confirma conhecimento ?') then begin
      EdArquivoxml.Text:='';
      exit;
    end;

   Sistema.Beginprocess('Lendo informa��es do arquivo XML');

   Q:=sqltoquery('select Forn_cnpjcpf,forn_codigo from fornecedores where Forn_cnpjcpf='+Stringtosql(NotaFiscal.Conhecimentos.Items[0].CTe.Emit.CNPJ));
   if Q.eof then begin
     IncluiFornecedor;
   end else
     EdFornec.text:=Q.fieldbyname('forn_codigo').AsString;

  EdNumerodoc.text:=inttostr(NotaFiscal.Conhecimentos.Items[0].CTe.Ide.nCT);
  Eddtemissao.setdate( NotaFiscal.Conhecimentos.Items[0].Cte.Ide.dhEmi );

  EdSerie.Text:=inttostr(NotaFiscal.Conhecimentos.Items[0].CTe.Ide.serie);
  EdTipodoc.text:='CTE';
// aqui ver qual icms pegar cfe o cst talvezs
  EdDigbicms.setvalue( NotaFiscal.Conhecimentos.Items[0].CTe.imp.ICMS.ICMS00.vBC );
  EdDigvicms.setvalue(NotaFiscal.Conhecimentos.Items[0].CTe.imp.ICMS.ICMS00.vICMS);
  if Global.Topicos[1352] then begin
    EdDigbicms.setvalue( 0 );
    EdDigvicms.setvalue( 0 );
  end;
  EdValorsubs.setvalue( 0 );
  EdVlracre.SetValue( 0 );

  Sistema.Beginprocess('Atualizando munic�pios');
  for p:=0 to ListaMunicipios.count-1 do begin
    PMunicipios:=ListaMunicipios[p];
    AdicionaMunicipio;
  end;
  EdDigtotpro.setvalue( NotaFiscal.Conhecimentos.Items[0].CTe.vPrest.vTPrest ) ;
  EdDigtotalnf.SetValue( NotaFiscal.Conhecimentos.Items[0].CTe.vPrest.vTPrest );
  EdVlrdesco.setvalue( 0 );
  EdtotalServicos.setvalue( 0 );
  Sistema.EndProcess('');

// ver registro 71


  if NotaFiscal.Conhecimentos.Items[0].CTe.Ide.dhEmi > Global.DataMenorBanco then
    EdDtEntrada.SetDate( NotaFiscal.Conhecimentos.Items[0].CTe.Ide.dhEmi+1  )
  else
    EdDtEntrada.SetDate( Sistema.hoje );

  EdFpgt_codigo.text:=FCondpagto.GetCodigoCfeParcelas(NotaFiscal.Conhecimentos.Items[0].CTe.infCTeNorm.cobr.dup.Count);
  EdFrete.setvalue(0);
  EdEmides.Text:='1';

  EdUnid_codigo.ValidFind;
  SetaEditsValores;
end;

// 07.01.17
procedure TFNotaCompra.bnotascteClick(Sender: TObject);
/////////////////////////////////////////////////////////
var p:integer;
begin
  if not od1.execute then exit;
  if od1.FileName='' then exit;
  Sistema.beginprocess('Armazenando arquivos Xmls...');
  ListaArq.Directory:=ExtractFilePath( Od1.FileName );
  for p:=0 to ListaArq.Items.Count-1 do begin
    AcbrNfe1.NotasFiscais.Clear;
    try
      AcbrNfe1.NotasFiscais.LoadFromFile( ListaArq.Items[p] );

    except
      Avisoerro('N�o foi poss�vel ler o arquivo '+ListaArq.Items[p]);
    end;
  end;
  Sistema.endprocess('');

end;

// 09.04.19
procedure TFNotaCompra.bimpcprClick(Sender: TObject);
//////////////////////////////////////////////////////

var   QU,
      QP     :TSqlquery;
      WordApp: Variant;
      Documento: Olevariant;
      xcomando,nomearquivo,xtransacao,xnome:string;
      p : byte;
      ListaComandos:TStringList;
      vencimento:TDatetime;

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
        else if xcom='@NOME' then result:=QU.FieldByName('clie_razaosocial').AsString
        else if xcom='@CPF' then result:=FGeral.Formatacnpjcpf( QU.FieldByName('clie_cnpjcpf').AsString)
        else if xcom='@ENDERECOFORNEC' then result:=QU.FieldByName('clie_endres').AsString
        else if xcom='@CIDADEFORNEC' then result:=QU.FieldByName('clie_CIDADE').AsString
        else if xcom='@VENCIFORNEC' then result:= strzero(Datetodia(vencimento),2)+' de '+
                                                  FGeral.Mes( Datetomes(vencimento) )+
                                                  ' de '+strzero(Datetoano(vencimento,true),4) ;

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
//                     ' inner join fornecedores on ( forn_codigo = move_tipo_codigo )'+
                     ' inner join clientes on ( clie_codigo = move_tipo_codigo )'+
                     ' and move_status = ''N'''+
                     ' and move_transacao = '+Stringtosql(xtransacao)+
                     ' and move_tipomov = '+Stringtosql(Global.CodCedulaProdutoRural)+
                     ' and move_unid_codigo = '+Stringtosql(Global.CodigoUnidade) );
      if Qu.Eof then begin
         Avisoerro('Transa��o n�o encontrada');
         exit;
      end;

      QP:=sqltoquery('select pend_datavcto from pendencias where pend_transacao = '+
                      Stringtosql(xtransacao));
      vencimento:=QP.FieldByName('pend_datavcto').asdatetime;
      Qp.Close;

      WordApp:= CreateOleObject('Word.Application');
      xnome:=QU.FieldByName('clie_razaosocial').asstring;

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
        ListaComandos.add('@CIDADEFORNEC');
        ListaComandos.add('@VENCIFORNEC');

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

// 24.03.2021
procedure TFNotaCompra.bguiastClick(Sender: TObject);
//////////////////////////////////////////////////////
var p                : integer;
    valorSt,
    tvalorSt,
    aliqicmsdestino,
    aliqicmsorigem,
    tbasest          : currency;
    ncmmvazero       : TStringList;
    simples          : string;

    function CalculaST( xncm:string; xvalor:currency ):currency;
    /////////////////////////////////////////////////////////////
    var xpermva,
        icms,
        icmsst,
        basest     : currency;

    begin

       xpermva         := FCodigosIPI.GetPerMva(xncm,simples );
       basest := 0;
       if xpermva = 0 then begin

        if ncmmvazero.IndexOf(xncm) = -1 then ncmmvazero.add( xncm );
        result := 0;

       end else begin

          basest := xvalor * ( 1 + (xpermva/100) );
          tbasest:= tbasest + basest;
          icmsst := basest * ( aliqicmsdestino/100 );
          icms   := xvalor * ( aliqicmsorigem/100 );
          result := icmsst - icms;

       end;

    end;

begin

   if AcbrNFe1.NotasFiscais.Count=0 then begin

      Avisoerro('XML n�o lido');
      exit;

   end;

   tvalorST := 0;
   tbaseSt  := 0;
   ncmmvazero := TStringList.create;
   simples    := '1';  // icms simples
   simples    := CRTToStr( Acbrnfe1.NotasFiscais.Items[0].NFe.Emit.CRT );
   aliqicmsdestino := FGeral.GetAliquotaIcmsEstadoEntradas(Global.UFUnidade);
   aliqicmsorigem  := FGeral.GetAliquotaIcmsEstadoEntradas( Acbrnfe1.NotasFiscais.Items[0].NFe.Emit.EnderEmit.UF  );

   if simples = '2' then

      simples    := '3';  // icms normal
   if Simples = '3' then simples := 'N' else simples := 'S';
   

   for p := 0 to  Acbrnfe1.NotasFiscais.Items[0].NFe.Det.Count-1 do begin

      valorST  := CalculaSt( Acbrnfe1.NotasFiscais.Items[0].NFe.Det[p].Prod.NCM,Acbrnfe1.NotasFiscais.Items[0].NFe.Det[p].Prod.vProd );
      tvalorSt := tvalorst + valorST;

   end;

   Aviso('NCMs sem MVA  ou n�o encontrado:'+ncmmvazero.text );

   Aviso('Valor da Guia = '+FGeral.formatavalor(tvalorst,f_cr) );
//   Aviso('Base de calculo da Guia = '+FGeral.formatavalor(tbasest,f_cr) );

end;

end.




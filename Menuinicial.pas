unit Menuinicial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, Buttons, SQLBtn, SqlExpr,
  SQLGrid, Kr_Hint, MidasLib, SqlEd,
  RLConsts, Registry, ZAbstractConnection, ZConnection , SqlSis, ACBrBase,
  ACBrDFe, ACBrMDFe,  Data.DB, Vcl.Grids, Vcl.DBGrids,ShellApi,Printers;


type
  TFMain = class(TForm)
    PMsgSistema: TPanel;
    Menu: TMainMenu;
    Cadastros: TMenuItem;
    CadHistoricos: TMenuItem;
    Sair: TMenuItem;
    Feriados: TMenuItem;
    CadPortadores: TMenuItem;
    CadFormasDePagamento: TMenuItem;         
    CadImpressos: TMenuItem;
    ContasGerenciais: TMenuItem;
    CadFornecedores: TMenuItem;
    CadClientes: TMenuItem;
    CadProdutos: TMenuItem;
    CadOutros: TMenuItem;
    N1: TMenuItem;
    CadFinanceiro: TMenuItem;
    Movimentos: TMenuItem;
    Relatorios: TMenuItem;
    Configuracoes: TMenuItem;
    Utilitarios: TMenuItem;
    Financeiro2: TMenuItem;
    PMsg: TPanel;
    SubstituioDeUsurio1: TMenuItem;
    ConfiguracaoGeral: TMenuItem;
    CadEstoque: TMenuItem;
    CadMotivosdeBloqueio: TMenuItem;
    Panel1: TPanel;
    PData: TPanel;
    PUsuario: TPanel;
    PUnidade: TPanel;
    Financeiro3: TMenuItem;
    ConfiguraoDaUnidade1: TMenuItem;
    ContaaPagar1: TMenuItem;
    ContasaReceber1: TMenuItem;
    RelaoIncluidas1: TMenuItem;
    RelaoIncluidas2: TMenuItem;
    MovimentoBancrio1: TMenuItem;
    ExtratoConta: TMenuItem;
    AlterarPendencias1: TMenuItem;
    AlteraoDeSenha1: TMenuItem;
    ReorganizarBancoDados1: TMenuItem;
    PAlerta: TPanel;
    UsuriosAtivos1: TMenuItem;
    PFinalizar: TPanel;
    Consignacaomenu: TMenuItem;
    PedidosCompra1: TMenuItem;
    Estoque1: TMenuItem;
    Acertos1: TMenuItem;
    Consignao1: TMenuItem;
    Regies1: TMenuItem;
    Cidades1: TMenuItem;
    NaturezasFiscais1: TMenuItem;
    SituaesTributrias1: TMenuItem;
    Estoque2: TMenuItem;
    Representantes1: TMenuItem;
    GrupoUsurios1: TMenuItem;
    Usurios1: TMenuItem;
    Unidades1: TMenuItem;
    Empresas1: TMenuItem;
    Cores1: TMenuItem;
    amanhos1: TMenuItem;
    Grupos1: TMenuItem;
    SubGrupos1: TMenuItem;
    Grades1: TMenuItem;
    Familias1: TMenuItem;
    AlteraoConsignao1: TMenuItem;
    ExtratodoProduto1: TMenuItem;
    CodigosdeAlquotas1: TMenuItem;
    abelasPreo1: TMenuItem;
    RetornoConsigAcerto1: TMenuItem;
    Gerenciais1: TMenuItem;
    ransao1: TMenuItem;
    GerenciaisMov: TMenuItem;
    CancelamentoTransao1: TMenuItem;
    ConfiguraodeMovimentos1: TMenuItem;
    NotasFiscais1: TMenuItem;
    Saida1: TMenuItem;
    Entrada1: TMenuItem;
    Transferncia1: TMenuItem;
    ransportadores1: TMenuItem;
    AuditoriaFiscal1: TMenuItem;
    ransfernciaMensal1: TMenuItem;
    CotasporRepres1: TMenuItem;
    MaterialPredominante1: TMenuItem;
    LanarCaixaBancos1: TMenuItem;
    LancarPendencia: TMenuItem;
    ransfernciaMensal2: TMenuItem;
    BaixarPendncias1: TMenuItem;
    RelaoPendentes1: TMenuItem;
    RelaoBaixadas1: TMenuItem;
    RelaoPendentes2: TMenuItem;
    RelaoBaixadas2: TMenuItem;
    ChequesRecebidos1: TMenuItem;
    ChequesRecebidos2: TMenuItem;
    AuditoriaCustos1: TMenuItem;
    PosioFinanceira1: TMenuItem;
    PosioFinanceira2: TMenuItem;
    BaixarCheques1: TMenuItem;
    Vendas1: TMenuItem;
    NotasFiscais2: TMenuItem;
    Saidas1: TMenuItem;
    ransferncia1: TMenuItem;
    ProntaEntrega1: TMenuItem;
    Remessa1: TMenuItem;
    AlteraodeRemessa1: TMenuItem;
    Incluso1: TMenuItem;
    Alterao1: TMenuItem;
    VendasQtde1: TMenuItem;
    PedidosdeVenda1: TMenuItem;
    ExportaoCaixaBancos1: TMenuItem;
    ExportaoComprasVendas1: TMenuItem;
    Faturamento1: TMenuItem;
    AlteraoSaida1: TMenuItem;
    RomaneioRetorno1: TMenuItem;
    RetornoRomaneio1: TMenuItem;
    PosioEstoque1: TMenuItem;
    PosioCliente1: TMenuItem;
    AjustesSaldosMensais1: TMenuItem;
    ReceitasDespesas1: TMenuItem;
    FluxodeCaixa1: TMenuItem;
    SequnciaSaida1: TMenuItem;
    Itens: TMenuItem;
    InventrioConsignado1: TMenuItem;
    InventrioProntaEntrega1: TMenuItem;
    Compras1: TMenuItem;
    InventrioRegimeEspecial1: TMenuItem;
    Vendas2: TMenuItem;
    ConfernciaDescontos1: TMenuItem;
    ImpressoRemessa1: TMenuItem;
    Sintegra1: TMenuItem;
    Inventrio1: TMenuItem;
    DevoluoRomaneio1: TMenuItem;
    RemMagazine1: TMenuItem;
    ExportaoFiscalWindows1: TMenuItem;
    ImpressoRemessaPE1: TMenuItem;
    AlterarCaixaBancos1: TMenuItem;
    transfernciaRemessa1: TMenuItem;
    Cadastros1: TMenuItem;
    Clientes1: TMenuItem;
    FichaCadastral1: TMenuItem;
    Auditorias1: TMenuItem;
    TransaesCanceladas1: TMenuItem;
    TransfCorrigidas1: TMenuItem;
    ExtratoSinttico1: TMenuItem;
    Aniversariantes1: TMenuItem;
    AtendimentoRepr1: TMenuItem;
    InventrioRetroativoConsignado1: TMenuItem;
    MensagensNotasFiscais1: TMenuItem;
    AlteraoEntrada1: TMenuItem;
    ClientesNovos1: TMenuItem;
    ClientesNovosResumo1: TMenuItem;
    Antecipaes1: TMenuItem;
    AjustesdeSaldos1: TMenuItem;
    Compras2: TMenuItem;
    CMV1: TMenuItem;
    PedidosVenda1: TMenuItem;
    PedidodeVendaInc: TMenuItem;
    Alterao2: TMenuItem;
    Etiquetas1: TMenuItem;
    CadastroOcorrncias1: TMenuItem;
    VendaProduto1: TMenuItem;
    PendentesRepr1: TMenuItem;
    ResumoVencerVencidos1: TMenuItem;
    PosioPedido1: TMenuItem;
    Contagem1: TMenuItem;
    PosRepresentante1: TMenuItem;
    PedidoVenda2: TMenuItem;
    ReprCliente1: TMenuItem;
    MontagemKits1: TMenuItem;
    Contagem2: TMenuItem;
    PeasPendente1: TMenuItem;
    PedidosVenda2: TMenuItem;
    BaixaMatriaPrima1: TMenuItem;
    Pesquisas1: TMenuItem;
    Pesquisa011: TMenuItem;
    MaisVendiso1: TMenuItem;
    ProdutosPedidos: TMenuItem;
    ProdutoRepresentante1: TMenuItem;
    BxMensalVendaTemporria1: TMenuItem;
    RemTrocaCredito: TMenuItem;
    EvoluoCusto1: TMenuItem;
    ReprProduto1: TMenuItem;
    iposdeMovimento1: TMenuItem;
    RelImpPedidos1: TMenuItem;
    ComparativoInventrios1: TMenuItem;
    ChecaSaldo1: TMenuItem;
    ExtratoProntaEntrega1: TMenuItem;
    ExtratoRegimeEspecial1: TMenuItem;
    PrPedidos1: TMenuItem;
    Atendimento1: TMenuItem;
    PrPedidos2: TMenuItem;
    Atendimento2: TMenuItem;
    ExtratoConsignado1: TMenuItem;
    Relacaoprepedidos: TMenuItem;
    Comisso1: TMenuItem;
    ExtratoProdutoFora1: TMenuItem;
    NovoPedidosdeVenda1: TMenuItem;
    Copas1: TMenuItem;
    CustosdeMateriais1: TMenuItem;
    Compras3: TMenuItem;
    ImpressoPedido1: TMenuItem;
    Recebimento1: TMenuItem;
    ExtratoMatriaPrima1: TMenuItem;
    RelLogs1: TMenuItem;
    Bloqueto1: TMenuItem;
    Malote1: TMenuItem;
    ChequesRecebidos3: TMenuItem;
    IntruesCobrana1: TMenuItem;
    PendentesRepr2: TMenuItem;
    ClassificaoIPI1: TMenuItem;
    Oramento1: TMenuItem;
    BaixaPedCompra1: TMenuItem;
    ExtratoMatPrimaResumido1: TMenuItem;
    ContagemRecebimento1: TMenuItem;
    VendasInativos1: TMenuItem;
    EtiquetaVendasInativos1: TMenuItem;
    Ocorrencias1: TMenuItem;
    Oramento2: TMenuItem;
    BaixaCobrana1: TMenuItem;
    CadastroEmitentes1: TMenuItem;
    FluxodeCaixa2: TMenuItem;
    ConciliaoBancria1: TMenuItem;
    Precos1: TMenuItem;
    ListaPreos1: TMenuItem;
    NotascomFinanceiro1: TMenuItem;
    ExtratoSinttico2: TMenuItem;
    VendasAbaixoMnimo1: TMenuItem;
    AlteraoNotas1: TMenuItem;
    EntradaAbate1: TMenuItem;
    IncusaoAbate: TMenuItem;
    AlteracaoAbate: TMenuItem;
    EntradadeAbate1: TMenuItem;
    PosioCheques1: TMenuItem;
    Desossa1: TMenuItem;
    BaixaAlmox: TMenuItem;
    BaixaProcessoparaAlmox1: TMenuItem;
    Produo1: TMenuItem;
    Cortes1: TMenuItem;
    Barras1: TMenuItem;
    ItensdaObra1: TMenuItem;
    Oramentos1: TMenuItem;
    ImpviaSintegra1: TMenuItem;
    CortescomEstoque1: TMenuItem;
    SaidaAbate1: TMenuItem;
    SaidaAbateInclusao: TMenuItem;
    SaidaAbateAlteracao: TMenuItem;
    ImpEstoqueDbf1: TMenuItem;
    SaidaAbate2: TMenuItem;
    Similares1: TMenuItem;
    ConsumoMaterial1: TMenuItem;
    CurvaABCConsumo1: TMenuItem;
    CurvaABCEstoque1: TMenuItem;
    SemMovimento1: TMenuItem;
    ExportacaoNFElet1: TMenuItem;
    Setores1: TMenuItem;
    NaoConformidades1: TMenuItem;
    AtaPlanosdeAo1: TMenuItem;
    RegistroNoConformidade1: TMenuItem;
    AlteracaoPlanoacao1: TMenuItem;
    RelNaoConformidade1: TMenuItem;
    RelPlanodeAcao1: TMenuItem;
    AlteracaoRegNaoConf1: TMenuItem;
    PlanosPendentes1: TMenuItem;
    RNCPendentes1: TMenuItem;
    VendasComissoporGrupo1: TMenuItem;
    CreditoMCbicos1: TMenuItem;
    GeraoBoletos1: TMenuItem;
    ModeObra1: TMenuItem;
    TiposNota1: TMenuItem;
    MaodeObraSaida1: TMenuItem;
    PrevistoRealizado1: TMenuItem;
    ImpEstoqueviaTexto1: TMenuItem;
    ComissaoobreRecebido1: TMenuItem;
    Indicadores1: TMenuItem;
    IndicadoresdeResultado1: TMenuItem;
    PontoRessuprimento1: TMenuItem;
    IndicadoresdeResultado2: TMenuItem;
    ComissoVendedores1: TMenuItem;
    ManutInventario: TMenuItem;
    ComposicaoEstoque1: TMenuItem;
    NotadeReclassificao1: TMenuItem;
    RenumeraNotas1: TMenuItem;
    AuditoriaFisItens1: TMenuItem;
    ReservaAlmox1: TMenuItem;
    SaldoaEntregar1: TMenuItem;
    EntradaProdutoAcabado1: TMenuItem;
    Colaboradores1: TMenuItem;
    Veiculos1: TMenuItem;
    GerenciarNFe1: TMenuItem;
    AuditoriaBaseItens1: TMenuItem;
    RelCarga1: TMenuItem;
    ImpContasGerenciais1: TMenuItem;
    ConsignaoemAberto1: TMenuItem;
    ProntaEntregaemaberto1: TMenuItem;
    InssNotaProdutor1: TMenuItem;
    GeracaoSpedFiscal1: TMenuItem;
    ComissoAbate1: TMenuItem;
    CodigoBarra1: TMenuItem;
    InfNutricionais1: TMenuItem;
    Ingredientes1: TMenuItem;
    Conservacao1: TMenuItem;
    PesagemPedido1: TMenuItem;
    AlteraoFiscal1: TMenuItem;
    ECF1: TMenuItem;
    OpcoesEcf: TMenuItem;
    CupomFiscal1: TMenuItem;
    ReducaoZ: TMenuItem;
    LeituraX1: TMenuItem;
    ImpClientesTexto1: TMenuItem;
    CancelaCupom1: TMenuItem;
    ConfiguraDemonstrativo1: TMenuItem;
    DRE1: TMenuItem;
    DetalheVendaConsig1: TMenuItem;
    GeracaoSpedPisCofins1: TMenuItem;
    AuditoriaFiscalCFOP1: TMenuItem;
    FaixasdeValores1: TMenuItem;
    BaixarCarto1: TMenuItem;
    ContagemcomLeitor1: TMenuItem;
    ImportaCTe1: TMenuItem;
    VendaBalco1: TMenuItem;
    ChequesEmitidos1: TMenuItem;
    ChequeRecebidos1: TMenuItem;
    ChequeEmitidos1: TMenuItem;
    LimiteDisponvel1: TMenuItem;
    Transacoesduplicadas: TMenuItem;
    RemCompraGarantida1: TMenuItem;
    ImpaReceberTexto1: TMenuItem;
    Equipamentos1: TMenuItem;
    ManutencaoEquipamento1: TMenuItem;
    Inclusaomanutencao: TMenuItem;
    Alteracaomanutencao: TMenuItem;
    Fazenda1: TMenuItem;
    Fazendainclusao: TMenuItem;
    Fazendaalteracao: TMenuItem;
    Fazenda2: TMenuItem;
    Equipamentos: TMenuItem;
    Notasequipamentos: TMenuItem;
    Fichatecnica: TMenuItem;
    PrximasTrocas1: TMenuItem;
    PosicaoEstoqueporPeso1: TMenuItem;
    MediaConsumo1: TMenuItem;
    cmvproducao: TMenuItem;
    BaixarporConta1: TMenuItem;
    GerenciarCTe1: TMenuItem;
    AnliseVendaCliente1: TMenuItem;
    ExportaEstoqueMovel1: TMenuItem;
    ExportaPortadoresCondPagto1: TMenuItem;
    ExportaClientesMovel1: TMenuItem;
    ImportaPedidosMvel1: TMenuItem;
    PagamentoLeite: TMenuItem;
    PagamentoMerenda1: TMenuItem;
    ImportaNFes1: TMenuItem;
    ResumoDiario1: TMenuItem;
    Pesagem1: TMenuItem;
    PedidosFaturados1: TMenuItem;
    ImportaContagemEstoque1: TMenuItem;
    KrHint1: KrHint;
    Cargas1: TMenuItem;
    Montagem1: TMenuItem;
    PesagemCaminhao2: TMenuItem;
    ImpClientesFornecFB1: TMenuItem;
    PesagemCortes1: TMenuItem;
    RastreamentoProdutos1: TMenuItem;
    VerificaoPeso1: TMenuItem;
    Brincos1: TMenuItem;
    GeracaoCTe1: TMenuItem;
    PesagemProdutor1: TMenuItem;
    Agenda1: TMenuItem;
    GeraoNFServios1: TMenuItem;
    NFeDestinadas1: TMenuItem;
    Carregamento1: TMenuItem;
    Carregados1: TMenuItem;
    RastreamentoVendas1: TMenuItem;
    PesagemDevoluo1: TMenuItem;
    SaidaDesossa: TMenuItem;
    ChecagenPisCofins1: TMenuItem;
    Periodos1: TMenuItem;
    Processos1: TMenuItem;
    Infopesagem: TMenuItem;
    PesagemporCarga1: TMenuItem;
    EntradaDesossa: TMenuItem;
    PesagemVivos: TMenuItem;
    ImportaEstoqueXML1: TMenuItem;
    ImpostosRetidos1: TMenuItem;
    TeleVendas1: TMenuItem;
//    ConexaoZeos: TZConnection;
    ImportaNFSe1: TMenuItem;
    LeitedaCrianca1: TMenuItem;
    Baias1: TMenuItem;
    LotesBaia1: TMenuItem;
    AlteraoLotesBaia1: TMenuItem;
    Registros1100e15001: TMenuItem;
    GerenciaMDFe1: TMenuItem;
    LotesFazenda1: TMenuItem;
    ComissoBoiadeiros1: TMenuItem;
    PorSetor1: TMenuItem;
    Transformacao: TMenuItem;
    InformeIRProdutor1: TMenuItem;
    MontagemcomCTe1: TMenuItem;
    ConfAcrescimos1: TMenuItem;
    GeraoADRCST1: TMenuItem;
    ComissaoMotoristas1: TMenuItem;
    PagamentoEletrnico1: TMenuItem;
    BaixaPagEletrnico1: TMenuItem;
    CentrosdeCusto1: TMenuItem;
    ValoresCentrosdeCusto1: TMenuItem;
    EntradadeCupim1: TMenuItem;
    PAtalhos: TSQLPanelGrid;
    batalho01: TSQLBtn;
    batalho02: TSQLBtn;
    batalho03: TSQLBtn;
    batalho04: TSQLBtn;
    batalho05: TSQLBtn;
    batalho06: TSQLBtn;
    JuntaPagamentos1: TMenuItem;
    MDFecomCte1: TMenuItem;
    PosicaoApropriacoes1: TMenuItem;
    LotesFazResumo1: TMenuItem;
    EtiquetasMiudos1: TMenuItem;
    Contratos1: TMenuItem;
    EstoqueCamaraFria1: TMenuItem;
    ExclusoEtiquetas1: TMenuItem;
    GeracaoDmed1: TMenuItem;
    Balanca: TMenuItem;
    AvisodeCobranca: TMenuItem;
    TimerVendasCelular: TTimer;
    ImportacaoOFX: TMenuItem;
    tributacaoNCM: TMenuItem;
    ChecatributacaoNCM: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure SairClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ConfiguraoDaUnidade1Click(Sender: TObject);
    procedure AlteraoDeSenha1Click(Sender: TObject);
    procedure UsuriosAtivos1Click(Sender: TObject);
    procedure Calendrio1Click(Sender: TObject);
    procedure ReorganizarBancoDados1Click(Sender: TObject);
    procedure Ediodetabelas1Click(Sender: TObject);
    procedure GrupoUsurios1Click(Sender: TObject);
    procedure Regies1Click(Sender: TObject);
    procedure Cidades1Click(Sender: TObject);
    procedure Usurios1Click(Sender: TObject);
    procedure Unidades1Click(Sender: TObject);
    procedure Empresas1Click(Sender: TObject);
    procedure SubstituioDeUsurio1Click(Sender: TObject);
    procedure CadHistoricosClick(Sender: TObject);
    procedure NaturezasFiscais1Click(Sender: TObject);
    procedure SituaesTributrias1Click(Sender: TObject);
    procedure Representantes1Click(Sender: TObject);
    procedure ConfiguracaoGeralClick(Sender: TObject);
    procedure ContasGerenciaisClick(Sender: TObject);
    procedure CadClientesClick(Sender: TObject);
    procedure CadFornecedoresClick(Sender: TObject);
    procedure CadFormasDePagamentoClick(Sender: TObject);
    procedure CadPortadoresClick(Sender: TObject);
    procedure FeriadosClick(Sender: TObject);
    procedure CadImpressosClick(Sender: TObject);
    procedure CadMotivosdeBloqueioClick(Sender: TObject);
    procedure Cores1Click(Sender: TObject);
    procedure amanhos1Click(Sender: TObject);
    procedure Grupos1Click(Sender: TObject);
    procedure SubGrupos1Click(Sender: TObject);
    procedure Grades1Click(Sender: TObject);
    procedure CadProdutosClick(Sender: TObject);
    procedure Familias1Click(Sender: TObject);
    procedure Consignao1Click(Sender: TObject);
    procedure AlteraoConsignao1Click(Sender: TObject);
    procedure DevoluodeConsignao1Click(Sender: TObject);
    procedure ExtratodoProduto1Click(Sender: TObject);
    procedure Acertos1Click(Sender: TObject);
    procedure CodigosdeAlquotas1Click(Sender: TObject);
    procedure abelasPreo1Click(Sender: TObject);
    procedure RetornoConsigAcerto1Click(Sender: TObject);
    procedure ransao1Click(Sender: TObject);
    procedure CancelamentoTransao1Click(Sender: TObject);
    procedure ConfiguraodeMovimentos1Click(Sender: TObject);
    procedure ransportadores1Click(Sender: TObject);
    procedure Saida1Click(Sender: TObject);
    procedure AuditoriaFiscal1Click(Sender: TObject);
    procedure Entrada1Click(Sender: TObject);
    procedure LancarPendenciaClick(Sender: TObject);
    procedure ransfernciaMensal1Click(Sender: TObject);
    procedure MaterialPredominante1Click(Sender: TObject);
    procedure LanarCaixaBancos1Click(Sender: TObject);
    procedure ExtratoContaClick(Sender: TObject);
    procedure ransfernciaMensal2Click(Sender: TObject);
    procedure AlterarPendencias1Click(Sender: TObject);
    procedure BaixarPendncias1Click(Sender: TObject);
    procedure RelaoIncluidas1Click(Sender: TObject);
    procedure RelaoIncluidas2Click(Sender: TObject);
    procedure RelaoPendentes1Click(Sender: TObject);
    procedure RelaoBaixadas1Click(Sender: TObject);
    procedure RelaoPendentes2Click(Sender: TObject);
    procedure RelaoBaixadas2Click(Sender: TObject);
    procedure ChequesRecebidos1Click(Sender: TObject);
    procedure ChequesRecebidos2Click(Sender: TObject);
    procedure AuditoriaCustos1Click(Sender: TObject);
    procedure Transferncia1Click(Sender: TObject);
    procedure PosioFinanceira1Click(Sender: TObject);
    procedure PosioFinanceira2Click(Sender: TObject);
    procedure BaixarCheques1Click(Sender: TObject);
    procedure CotasporRepres1Click(Sender: TObject);
    procedure Vendas1Click(Sender: TObject);
    procedure Saidas1Click(Sender: TObject);
    procedure ransferncia1Click(Sender: TObject);
    procedure Remessa1Click(Sender: TObject);
    procedure AlteraodeRemessa1Click(Sender: TObject);
    procedure Incluso1Click(Sender: TObject);
    procedure Alterao1Click(Sender: TObject);
    procedure VendasQtde1Click(Sender: TObject);
    procedure PedidosdeVenda1Click(Sender: TObject);
    procedure ExportaoCaixaBancos1Click(Sender: TObject);
    procedure ExportaoComprasVendas1Click(Sender: TObject);
    procedure Faturamento1Click(Sender: TObject);
    procedure SaidaECF1Click(Sender: TObject);
    procedure AlteraoSaida1Click(Sender: TObject);
    procedure ExportaoLivroFiscal1Click(Sender: TObject);
    procedure RomaneioRetorno1Click(Sender: TObject);
    procedure RetornoRomaneio1Click(Sender: TObject);
    procedure PosioEstoque1Click(Sender: TObject);
    procedure Consignaesemaberto1Click(Sender: TObject);
    procedure PosioCliente1Click(Sender: TObject);
    procedure ProntaEntregaemaberto1Click(Sender: TObject);
    procedure AjustesSaldosMensais1Click(Sender: TObject);
    procedure ReceitasDespesas1Click(Sender: TObject);
    procedure FluxodeCaixa1Click(Sender: TObject);
    procedure SequnciaSaida1Click(Sender: TObject);
    procedure ItensClick(Sender: TObject);
    procedure InventrioConsignado1Click(Sender: TObject);
    procedure InventrioProntaEntrega1Click(Sender: TObject);
    procedure InventrioRegimeEspecial1Click(Sender: TObject);
    procedure Compras1Click(Sender: TObject);
    procedure Vendas2Click(Sender: TObject);
    procedure ConfernciaDescontos1Click(Sender: TObject);
    procedure ImpressoRemessa1Click(Sender: TObject);
    procedure Sintegra1Click(Sender: TObject);
    procedure Inventrio1Click(Sender: TObject);
    procedure DevoluoRomaneio1Click(Sender: TObject);
    procedure RemMagazine1Click(Sender: TObject);
    procedure DetalheVendaConsig1Click(Sender: TObject);
    procedure ExportaoFiscalWindows1Click(Sender: TObject);
    procedure ResumoConsigAberto1Click(Sender: TObject);
    procedure ImpressoRemessaPE1Click(Sender: TObject);
    procedure AlterarCaixaBancos1Click(Sender: TObject);
    procedure ConferePE1Click(Sender: TObject);
    procedure transfernciaRemessa1Click(Sender: TObject);
    procedure FichaCadastral1Click(Sender: TObject);
    procedure UnidadeProduto1Click(Sender: TObject);
    procedure RepresProduto1Click(Sender: TObject);
    procedure RepresCliente1Click(Sender: TObject);
    procedure UnidadeRepres1Click(Sender: TObject);
    procedure TransaesCanceladas1Click(Sender: TObject);
    procedure ConfereRC1Click(Sender: TObject);
    procedure TransfCorrigidas1Click(Sender: TObject);
    procedure ExtratoSinttico1Click(Sender: TObject);
    procedure Aniversariantes1Click(Sender: TObject);
    procedure AtendimentoRepr1Click(Sender: TObject);
    procedure InventrioRetroativoConsignado1Click(Sender: TObject);
    procedure MensagensNotasFiscais1Click(Sender: TObject);
    procedure AlteraoEntrada1Click(Sender: TObject);
    procedure ClientesNovos1Click(Sender: TObject);
    procedure ClientesNovosResumo1Click(Sender: TObject);
    procedure ResumoRegEspAbertp1Click(Sender: TObject);
    procedure Antecipaes1Click(Sender: TObject);
    procedure UnidadeProduto2Click(Sender: TObject);
    procedure AjustesdeSaldos1Click(Sender: TObject);
    procedure Compras2Click(Sender: TObject);
    procedure CMV1Click(Sender: TObject);
    procedure Etiquetas1Click(Sender: TObject);
    procedure PedidodeVendaIncClick(Sender: TObject);
    procedure Alterao2Click(Sender: TObject);
    procedure UnidadeProduto3Click(Sender: TObject);
    procedure RepresProduto3Click(Sender: TObject);
    procedure CadastroOcorrncias1Click(Sender: TObject);
    procedure InadimplnciaCheques1Click(Sender: TObject);
    procedure RepresProduto2Click(Sender: TObject);
    procedure VendaProduto1Click(Sender: TObject);
    procedure RepresCliente2Click(Sender: TObject);
    procedure UnidadeRepres2Click(Sender: TObject);
    procedure PendentesRepr1Click(Sender: TObject);
    procedure ResumoVencerVencidos1Click(Sender: TObject);
    procedure PosioPedido1Click(Sender: TObject);
    procedure Novaforma1Click(Sender: TObject);
    procedure RepresCliente3Click(Sender: TObject);
    procedure Contagem1Click(Sender: TObject);
    procedure PosRepresentante1Click(Sender: TObject);
    procedure ReprCliente1Click(Sender: TObject);
    procedure MontagemKits1Click(Sender: TObject);
    procedure Contagem2Click(Sender: TObject);
    procedure PeasPendente1Click(Sender: TObject);
    procedure PedidosVenda2Click(Sender: TObject);
    procedure BaixaMatriaPrima1Click(Sender: TObject);
    procedure Pesquisa011Click(Sender: TObject);
    procedure BxMensalVendaTemporria1Click(Sender: TObject);
    procedure ProdutosPedidosClick(Sender: TObject);
    procedure ProdutoRepresentante1Click(Sender: TObject);
    procedure RemTrocaCreditoClick(Sender: TObject);
    procedure EvoluoCusto1Click(Sender: TObject);
    procedure ReprProduto1Click(Sender: TObject);
    procedure iposdeMovimento1Click(Sender: TObject);
    procedure RelImpPedidos1Click(Sender: TObject);
    procedure ComparativoInventrios1Click(Sender: TObject);
    procedure ConfereRE1Click(Sender: TObject);
    procedure ChecaSaldo1Click(Sender: TObject);
    procedure ExtratoProntaEntrega1Click(Sender: TObject);
    procedure ExtratoRegimeEspecial1Click(Sender: TObject);
    procedure RemessasMagazine1Click(Sender: TObject);
    procedure Atendimento1Click(Sender: TObject);
    procedure Atendimento2Click(Sender: TObject);
    procedure ExtratoConsignado1Click(Sender: TObject);
    procedure RelacaoprepedidosClick(Sender: TObject);
    procedure Comisso1Click(Sender: TObject);
    procedure ExtratoProdutoFora1Click(Sender: TObject);
    procedure NovoPedidosdeVenda1Click(Sender: TObject);
    procedure Copas1Click(Sender: TObject);
    procedure Recebimento1Click(Sender: TObject);
    procedure ImpressoPedido1Click(Sender: TObject);
    procedure ExtratoMatriaPrima1Click(Sender: TObject);
    procedure RelLogs1Click(Sender: TObject);
    procedure Bloqueto1Click(Sender: TObject);
    procedure ChequesRecebidos3Click(Sender: TObject);
    procedure IntruesCobrana1Click(Sender: TObject);
    procedure PendentesRepr2Click(Sender: TObject);
    procedure ClassificaoIPI1Click(Sender: TObject);
    procedure Oramento1Click(Sender: TObject);
    procedure BaixaPedCompra1Click(Sender: TObject);
    procedure ExtratoMatPrimaResumido1Click(Sender: TObject);
    procedure ContagemRecebimento1Click(Sender: TObject);
    procedure VendasInativos1Click(Sender: TObject);
    procedure EtiquetaVendasInativos1Click(Sender: TObject);
    procedure Oramento2Click(Sender: TObject);
    procedure BaixaCobrana1Click(Sender: TObject);
    procedure CadastroEmitentes1Click(Sender: TObject);
    procedure FluxodeCaixa2Click(Sender: TObject);
    procedure ConciliaoBancria1Click(Sender: TObject);
    procedure Precos1Click(Sender: TObject);
    procedure ListaPreos1Click(Sender: TObject);
    procedure NotascomFinanceiro1Click(Sender: TObject);
    procedure ExtratoSinttico2Click(Sender: TObject);
    procedure VendasAbaixoMnimo1Click(Sender: TObject);
    procedure AlteraoNotas1Click(Sender: TObject);
    procedure IncusaoAbateClick(Sender: TObject);
    procedure AlteracaoAbateClick(Sender: TObject);
    procedure EntradadeAbate1Click(Sender: TObject);
    procedure Desossa1Click(Sender: TObject);
    procedure BaixaAlmoxClick(Sender: TObject);
    procedure ExtratoCamarafriaClick(Sender: TObject);
    procedure BaixaProcessoparaAlmox1Click(Sender: TObject);
    procedure Cortes1Click(Sender: TObject);
    procedure Barras1Click(Sender: TObject);
    procedure ItensdaObra1Click(Sender: TObject);
    procedure Oramentos1Click(Sender: TObject);
    procedure ImpviaSintegra1Click(Sender: TObject);
    procedure CortescomEstoque1Click(Sender: TObject);
    procedure SaidaAbateInclusaoClick(Sender: TObject);
    procedure SaidaAbateAlteracaoClick(Sender: TObject);
    procedure ImpEstoqueDbf1Click(Sender: TObject);
    procedure SaidaAbate2Click(Sender: TObject);
    procedure Similares1Click(Sender: TObject);
    procedure ConsumoMaterial1Click(Sender: TObject);
    procedure CurvaABCConsumo1Click(Sender: TObject);
    procedure CurvaABCEstoque1Click(Sender: TObject);
    procedure SemMovimento1Click(Sender: TObject);
    procedure Setores1Click(Sender: TObject);
    procedure AtaPlanosdeAo1Click(Sender: TObject);
    procedure ExportacaoNFElet1Click(Sender: TObject);
    procedure AlteracaoPlanoacao1Click(Sender: TObject);
    procedure RelPlanodeAcao1Click(Sender: TObject);
    procedure RegistroNoConformidade1Click(Sender: TObject);
    procedure AlteracaoRegNaoConf1Click(Sender: TObject);
    procedure PlanosPendentes1Click(Sender: TObject);
    procedure RNCPendentes1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure VendasComissoporGrupo1Click(Sender: TObject);
    procedure CreditoMCbicos1Click(Sender: TObject);
    procedure GeraoBoletos1Click(Sender: TObject);
    procedure ModeObra1Click(Sender: TObject);
    procedure TiposNota1Click(Sender: TObject);
    procedure MaodeObraSaida1Click(Sender: TObject);
    procedure PrevistoRealizado1Click(Sender: TObject);
    procedure ImpEstoqueviaTexto1Click(Sender: TObject);
    procedure ComissaoobreRecebido1Click(Sender: TObject);
    procedure Indicadores1Click(Sender: TObject);
    procedure IndicadoresdeResultado1Click(Sender: TObject);
    procedure PontoRessuprimento1Click(Sender: TObject);
    procedure IndicadoresdeResultado2Click(Sender: TObject);
    procedure ComissoVendedores1Click(Sender: TObject);
    procedure ManutInventarioClick(Sender: TObject);
    procedure ComposicaoEstoque1Click(Sender: TObject);
    procedure NotadeReclassificao1Click(Sender: TObject);
    procedure RenumeraNotas1Click(Sender: TObject);
    procedure AuditoriaFisItens1Click(Sender: TObject);
    procedure ReservaAlmox1Click(Sender: TObject);
    procedure SaldoaEntregar1Click(Sender: TObject);
    procedure EntradaProdutoAcabado1Click(Sender: TObject);
    procedure Colaboradores1Click(Sender: TObject);
    procedure Veiculos1Click(Sender: TObject);
    procedure GerenciarNFe1Click(Sender: TObject);
    procedure AuditoriaBaseItens1Click(Sender: TObject);
    procedure NoConformidadePendente1Click(Sender: TObject);
    procedure RelCarga1Click(Sender: TObject);
    procedure ImpContasGerenciais1Click(Sender: TObject);
    procedure ConsignaoemAberto1Click(Sender: TObject);
    procedure InssNotaProdutor1Click(Sender: TObject);
    procedure GeracaoSpedFiscal1Click(Sender: TObject);
    procedure ComissoAbate1Click(Sender: TObject);
    procedure CodigoBarra1Click(Sender: TObject);
    procedure InfNutricionais1Click(Sender: TObject);
    procedure Ingredientes1Click(Sender: TObject);
    procedure Conservacao1Click(Sender: TObject);
    procedure PesagemPedido1Click(Sender: TObject);
    procedure AlteraoFiscal1Click(Sender: TObject);
    procedure OpcoesEcfClick(Sender: TObject);
    procedure CupomFiscal1Click(Sender: TObject);
    procedure LeituraX1Click(Sender: TObject);
    procedure ReducaoZClick(Sender: TObject);
    procedure ImpClientesTexto1Click(Sender: TObject);
    procedure CancelaCupom1Click(Sender: TObject);
    procedure ConfiguraDemonstrativo1Click(Sender: TObject);
    procedure DRE1Click(Sender: TObject);
    procedure GeracaoSpedPisCofins1Click(Sender: TObject);
    procedure ConfigImpPadro1Click(Sender: TObject);
    procedure AuditoriaFiscalCFOP1Click(Sender: TObject);
    procedure batalho01Click(Sender: TObject);
    procedure MeuClick01(Sender: TObject);
// 20.06.12
    procedure AtivaAtalho( natalho:string ; qual:TMenuItem);
    function DivideCaption( xCaption:string ):string;
// 28.06.12
    function AchaCaption( s:string ; xMenu:TMenuItem):TMenuItem;
    procedure MeuClick02(Sender: TObject);
    procedure MeuClick03(Sender: TObject);
    procedure MeuClick04(Sender: TObject);
    procedure MeuClick05(Sender: TObject);
    procedure MeuClick06(Sender: TObject);
    procedure batalho02Click(Sender: TObject);
    procedure batalho03Click(Sender: TObject);
    procedure batalho04Click(Sender: TObject);
    procedure batalho05Click(Sender: TObject);
    procedure batalho06Click(Sender: TObject);
    procedure FaixasdeValores1Click(Sender: TObject);
    procedure BaixarCarto1Click(Sender: TObject);
    procedure ContagemcomLeitor1Click(Sender: TObject);
    procedure ImportaCTe1Click(Sender: TObject);
    procedure VendaBalco1Click(Sender: TObject);
    procedure ChequesEmitidos1Click(Sender: TObject);
    procedure ChequeRecebidos1Click(Sender: TObject);
    procedure ChequeEmitidos1Click(Sender: TObject);
    procedure LimiteDisponvel1Click(Sender: TObject);
    procedure TransacoesduplicadasClick(Sender: TObject);
    procedure RemCompraGarantida1Click(Sender: TObject);
    procedure ImpaReceberTexto1Click(Sender: TObject);
    procedure Equipamentos1Click(Sender: TObject);
    procedure InclusaomanutencaoClick(Sender: TObject);
    procedure AlteracaomanutencaoClick(Sender: TObject);
    procedure FazendainclusaoClick(Sender: TObject);
    procedure FazendaalteracaoClick(Sender: TObject);
    procedure Fazenda2Click(Sender: TObject);
    procedure NotasequipamentosClick(Sender: TObject);
    procedure FichatecnicaClick(Sender: TObject);
    procedure PrximasTrocas1Click(Sender: TObject);
    procedure PosicaoEstoqueporPeso1Click(Sender: TObject);
    procedure MediaConsumo1Click(Sender: TObject);
    procedure ConsignacaomenuDrawItem(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; Selected: Boolean);
    procedure cmvproducaoClick(Sender: TObject);
    procedure BaixarporConta1Click(Sender: TObject);
    procedure GerenciarCTe1Click(Sender: TObject);
    procedure AnliseVendaCliente1Click(Sender: TObject);
    procedure ExportaEstoqueMovel1Click(Sender: TObject);
    procedure ExportaPortadoresCondPagto1Click(Sender: TObject);
    procedure ExportaClientesMovel1Click(Sender: TObject);
    procedure ImportaPedidosMvel1Click(Sender: TObject);
    procedure PagamentoLeiteClick(Sender: TObject);
    procedure PagamentoMerenda1Click(Sender: TObject);
    procedure ImportaNFes1Click(Sender: TObject);
    procedure ResumoDiario1Click(Sender: TObject);
    procedure Pesagem1Click(Sender: TObject);
    procedure PedidosFaturados1Click(Sender: TObject);
    procedure ImportaContagemEstoque1Click(Sender: TObject);
    procedure MovimentosMeasureItem(Sender: TObject; ACanvas: TCanvas;
      var Width, Height: Integer);
    procedure Montagem1Click(Sender: TObject);
    procedure PesagemCaminhao2Click(Sender: TObject);
    procedure ImpClientesFornecFB1Click(Sender: TObject);
    procedure EntradaAbate1Click(Sender: TObject);
    procedure PesagemCortes1Click(Sender: TObject);
    procedure RastreamentoProdutos1Click(Sender: TObject);
    procedure VerificaoPeso1Click(Sender: TObject);
    procedure Brincos1Click(Sender: TObject);
    procedure GeracaoCTe1Click(Sender: TObject);
    procedure PesagemProdutor1Click(Sender: TObject);
    procedure Agenda1Click(Sender: TObject);
    procedure GeraoNFServios1Click(Sender: TObject);
    procedure NFeDestinadas1Click(Sender: TObject);
    procedure Carregados1Click(Sender: TObject);
    procedure RastreamentoVendas1Click(Sender: TObject);
    procedure PesagemDevoluo1Click(Sender: TObject);
    procedure DesossaSaidaClick(Sender: TObject);
    procedure ChecagenPisCofins1Click(Sender: TObject);
    procedure SaidaDesossaClick(Sender: TObject);
    procedure Periodos1Click(Sender: TObject);
    procedure Processos1Click(Sender: TObject);
    procedure InfopesagemClick(Sender: TObject);
    procedure PesagemporCarga1Click(Sender: TObject);
    procedure EntradaDesossaClick(Sender: TObject);
    procedure PesagemvivoincClick(Sender: TObject);
    procedure PesagemVivosClick(Sender: TObject);
    procedure ImportaEstoqueXML1Click(Sender: TObject);
    procedure ImpostosRetidos1Click(Sender: TObject);
    procedure TeleVendas1Click(Sender: TObject);
    procedure PMsgClick(Sender: TObject);
    function GetDicionario(Tabela,Campo:String):boolean;
    procedure ImportaNFSe1Click(Sender: TObject);
    procedure LeitedaCrianca1Click(Sender: TObject);
    procedure Baias1Click(Sender: TObject);
    procedure LotesBaia1Click(Sender: TObject);
    procedure AlteraoLotesBaia1Click(Sender: TObject);
    procedure Registros1100e15001Click(Sender: TObject);
    procedure GerenciaMDFe1Click(Sender: TObject);
    procedure LotesFazenda1Click(Sender: TObject);
    procedure ComissoBoiadeiros1Click(Sender: TObject);
    procedure PorSetor1Click(Sender: TObject);
    procedure TransformacaoClick(Sender: TObject);
    procedure InformeIRProdutor1Click(Sender: TObject);
    procedure MontagemcomCTe1Click(Sender: TObject);
    procedure ConfAcrescimos1Click(Sender: TObject);
    procedure GeraoADRCST1Click(Sender: TObject);
    procedure ComissaoMotoristas1Click(Sender: TObject);
    procedure PagamentoEletrnico1Click(Sender: TObject);
    procedure BaixaPagEletrnico1Click(Sender: TObject);
    procedure CentrosdeCusto1Click(Sender: TObject);
    procedure ValoresCentrosdeCusto1Click(Sender: TObject);
    procedure EntradadeCupim1Click(Sender: TObject);
    procedure JuntaPagamentos1Click(Sender: TObject);
    procedure MDFecomCte1Click(Sender: TObject);
    procedure PosicaoApropriacoes1Click(Sender: TObject);
    procedure LotesFazResumo1Click(Sender: TObject);
    procedure EtiquetasMiudos1Click(Sender: TObject);
    procedure Contratos1Click(Sender: TObject);
    procedure EstoqueCamaraFria1Click(Sender: TObject);
    procedure ExclusoEtiquetas1Click(Sender: TObject);
    procedure GeracaoDmed1Click(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure BalancaClick(Sender: TObject);
    procedure AvisodeCobrancaClick(Sender: TObject);
    procedure TimerVendasCelularTimer(Sender: TObject);
    procedure ImportacaoOFXClick(Sender: TObject);
    procedure tributacaoNCMClick(Sender: TObject);
    procedure ChecatributacaoNCMClick(Sender: TObject);

  private
    procedure x(Sender: TObject; var Key: Word; Shift: TShiftState);
    { Private declarations }
  public
    { Public declarations }
    procedure AbreForm( nome:string );
  end;

var
  FMain: TFMain;
  MeuAtalho01,MeuAtalho02,MeuAtalho03,MeuAtalho04,MeuAtalho05,MeuAtalho06:TMenuItem;

implementation

uses Hist, Regioes, Munic, Arquiv,Init,Geral, Sqlfun,
     Calendar, moedas, GrUsu, Usuarios, Empresas, Diversos, Unidades,
     Natureza, Sittribu, represen, Configura, plano, cadcli, fornece, conpagto,
     portador, Feriados, Cadimp, motivobl, cadcor, tamanhos, grupos,
     Subgrupos, Grades, Estoque, familias, RelEstoque, acertoses,
     codigosfis, tabela, RetConsi, RelGerenciais , Canctrans, ConfMovi,
     Transp, nfsaida, nfcompra, Lancapen, transfes, material, lancamfin, RelCxBan,
     transfcon, Alterapen, BaixaPen, RelFinan, Cadcheq, nftransf, Baixache,
     Cotarepr, Remproen, Pedcomp, expcxban, expnfpra, explivrofis,
     retroman, Ajsalfin, sintegra, expfiswin, alteracxa, Transrem, relcadas, relaudit,
     Mensnf, Ajustees, Pedvenda, cadocor, Pospedi, Montakit,
     pesquisa, BxMenTem, prepedido, retproennovo, cadcopa, custos,
     rel_compras, Relmalote, codigosipi, Orcamento, Ocorrenc, baixacob,
     Emitentes, Fluxocaixa, concbanc, precos, alteranota, entabate, desossa,
     requisicao, RelProducao, cadorcam, impsintegra , remessa, similares,
     setores, ataspacao, expnfetxt, RelNaoConfor, regnaoconf,
  planospendentes, regnaoconfpend, boletos, cadservicos, tiposnotas,
  nfsaidamo, indicadores, movindicadores, tabcomissao, saldoestoque,
  EntradaAcabado, pendenciaspendentes, colaboradores, gerencianfe,
  spedfiscal, nutricionais, ingredientes, conservacao, pesagemsaida,
  ecfteste1,
  gerenciaecf,
  configdemo, spedpiscofins, HttpSend, faixas,
  ImportaCte, vendabalcao, ajuda, equipamentos, fichatecnica  ,
  mostravalorafaturar, pagamentoleite, importanfe,
  pesagementrada, montagemcarga, pesagemcaminhao, vencervalidade,
  pesagemcamarafria, brincos, gerenciacte, expcte, pesagemcaminhao2, agenda,
  expnfse, nfedestinadas, pesagemdevolucao, EmbalagemDesossa, Periodos,
  pesagemporcarga, estoque2, saidadesossa, telemarketing,
 // estoquez,
  importanfse,
  consulta, baias, creditosspedcontirb, gerenciamdfe, montagemcargacte,
  checabalanca, adrcst, pagamentos, baixapagamentos, cadccustos, centroscusto,
  entradadecupim, juntapagamentos, gerenciawhats, contratos, exclusaoetiq,
  verificasessaots, geradmed, emailcobranca, importaofx,
  tributacaoncm;

  procedure DesabilitaMenu;
  //////////////////////////
  var i:integer;
  begin
    for i:=0 to FMain.Menu.Items.Count-1 do begin
      if pos('SAIR',uppercase(FMain.Menu.Items[i].Caption))=0 then
        FMain.Menu.Items[i].Enabled:=false;
    end;
  end;

{$R *.dfm}

////////////////////////////////////////////////
procedure TFMain.FormActivate(Sender: TObject);
////////////////////////////////////////////////
var mesano,nomeformulario:string;
    Lista:TStringlist;
    p:integer;
    Host, IP, Err: string;

/////////////////////////////////////////////////////

    function PegaIpNet:string;
    //////////////////////
    var
      lcHttp : THTTPSend;  //synapse
      lcLista: TStringList;
      x,y,z:integer;
      ip:string;
    begin
      try
        lcHttp := THTTPSend.Create;
        lcLista:= TStringList.Create;
        lcHttp.HTTPMethod('GET', 'http://www.meuip.com.br');
//        lcHttp.HTTPMethod('GET','http://meuip.datahouse.com.br');
        lcLista.LoadFromStream(lcHttp.Document);
        ip:='';
        for x:=0 to lcLista.count-1 do begin
          y:=pos('Meu IP:',lcLista[x]);
//          z:=pos('</',lcLista[x]);
// 03.12.14
          z:=pos('-->',lcLista[x]);
          if (y>0) and (z>0) then begin
//            Showmessage('Numero IP '+ copy(lclista[x],y+07,z-y) );
//            ip:=copy(lclista[x],y+07,z-(y+7));
            ip:=copy(lclista[x],z+3,14);
            break;
          end;
        end;
      finally
        FreeAndNil(lcHttp);
        FreeAndNil(lcLista);
        result:=ip;
      end;
    end;
/////////////////////////////////////////////////////
    procedure ConfiguraCorForms;
    /////////////////////////////
    var p:integer;
    begin
      for p:=0 to  Screen.FormCount-1 do begin
         Screen.Forms[p].Color:=clsilver;
// 17.jan.2023 - ver com leilinha uma cor..
//         Screen.Forms[p].Color:=clSkyBlue;
         Screen.Forms[p].Color:=clInfoBk;   // 13.02.2023
      end;
    end;


    procedure ChecaNfenaoautorizadas;
    /////////////////////////////////
    var Q:TSqlquery;
        tiposdemovimento,tiposnao:string;
        Lista:TStringList;
    begin
      tiposdemovimento:=Global.TiposSaida+';'+Global.CodDevolucaoCompra+';'+Global.CodCompraProdutor+';'+
                    Global.CodDrawBackEnt+';'+Global.CodDevolucaoIgualVenda+';'+Global.CodEntradaImobilizado+';'+
                    Global.CodCompraProdutorReclassifica+';'+Global.CodDevolucaoSimbolicaConsig+';'+Global.CodVendasemFinan+';'+
                    Global.CodCompraConsignado+';'+Global.CodDevolucaodeRemessa+';'+Global.CodDevolucaoRoman+';'+
                    Global.CodNotaRemessaaOrdem+';'+Global.CodEstornoNFeSai+';'+Global.CodDevolucaoTributada+';'+
                    Global.CodRemessaConserto+';'+Global.CodNfeComplementoQtde+';'+
                    FGeral.GetConfig1AsString('TIPOSENUMSAIDA');
      tiposnao:=Global.TiposNaoFiscal+';'+Global.CodPrestacaoServicos+';'+Global.CodVendaInterna;
      Q:=sqltoquery('select moes_numerodoc,moes_dataemissao,moes_tipo_codigo,moes_tipocad from movesto where moes_status<>''C'''+
                    ' and moes_unid_codigo='+Stringtosql(Global.codigounidade)+
//                    ' and ( (moes_nfeexp is null) or (moes_nfeexp<>''S'') )'+
// 04.04.16
                    ' and ( (moes_dtnfeauto is null) or (moes_nfeexp<>''S'') )'+
                    ' and '+FGeral.GetSqlDataNula('moes_dtnfeauto')+
                    ' and '+FGeral.GetNOTIN('moes_status','I/X/Y','C')+
                    ' and moes_especie <> '+Stringtosql('CF')+
                    ' and moes_datamvto>='+Datetosql(Sistema.Hoje-30)+
                    ' and '+FGeral.Getin('moes_tipomov',tiposdemovimento,'C')+
                    ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C') );
      Lista:=TStringList.create;
      if not Q.eof then Lista.Add('Notas a autorizar OU n�meros a inutilizar');
      while not Q.eof do begin
        Lista.add('NF-e : '+Q.fieldbyname('moes_numerodoc').asstring+' - Data:'+FGeral.formatadata(Q.fieldbyname('moes_dataemissao').asdatetime));
        Q.Next;
      end;
      FGeral.FechaQuery(Q);
      if LIsta.count>0 then Showmessage( Lista.Text );

    end;

const margin:integer=125;
      tampaineldireito:integer=300;

var  ArqIni   : TRegIniFile;
     arqimp   : TextFile;
     ximp,
     PastaSac,
     idsessao,
     user,
     idsessaots,
     cIMPNFE,
     cIMPNFCE,
     c1IMPNFE,
     c1IMPNFCE :string;
     ListaIMp  : TStringList;
     i         : Dword;
     h: hwnd;
     hpr, hth: longint;
     Buffer: Pointer;
     NumberOfBytes: Integer;

     Function PegaNomeImpressora( s,idts:string ) : string;
     /////////////////////////////////////////////////
     var u,
         y,
         m:integer;

     begin

//         u := AnsiPos( '('+idts+' redirecionada',s);
         u := AnsiPos( 'redirecionada',s);
         if u > 0 then begin

            y := u -5;
            result := trim(copy( s,1,y )) ;
            for m := y to y+5 do begin

               if copy( result,m,1) = '(' then begin

                  result := copy( result,1,m-1);

//                  showmessage('achou '+result);

                  break;

               end;

            end;

         end else begin

//           showmessage(s+' n�o achou '+'('+idts+' redirecionada');
           result:= s;

         end;

     end;


     function  ValidaImpressoraUsuario( s,idts:string ) : string;
     ///////////////////////////////////////////////////////////////
     var u:integer;
     begin

         u := AnsiPos( 'redirecionada',s);
         if u > 0 then

            result := 'S'

         else begin

//           showmessage(s+' n�o achou '+'('+idts+' redirecionada');
           result:= 'N';

         end;

     end;



begin
///////////////////////////////////////////////

  if not Sistema.Inicializado then begin

// 13.01.2021
     if FGerenciaWhats <> nil then

       Global.VersaoSistema:='1.92v2w'

     else

       Global.VersaoSistema:='1.92v2';

     Arq.Ambiente.Version:=Global.VersaoSistema;
     FInit.Inicializar;

     if Global.usuario.codigo=100 then begin
{
        ArqIni := TRegIniFile.Create('SACD');
        SistemaZeos.NameSystem:='SAC';
        SistemaZeos.Host:=ArqIni.ReadString('Config' ,'EnderecoServidor','');
        SistemaZeos.UserDataBase:=Lowercase(ArqIni.ReadString( 'Config' ,'NomeBanco',''));
        SistemaZeos.UserName:='sac';
        ArqIni.Free;

        ConexaoZeos.HostName:=SistemaZeos.Host;
        ConexaoZeos.Database:=SistemaZeos.UserDataBase;
        ConexaoZeos.User    :=SistemaZeos.UserName;

      //  Sistema.UserPassword:='ctx'+IntToStr(357357);
//        SistemaZeos.Connection:=ConexaoZeos.Connection;

         try
//          SistemaZeos.Connect('S','127.0.0.1');
          ConexaoZeos.Connect;
          try
             SistemaZeos.Connect('S',SistemaZeos.Host);
          except
             Avisoerro('N�o foi poss�vel conectar o base de dados '+SistemaZeos.UserDataBase);
          end;
        except
          Avisoerro('N�o foi poss�vel conectar o banco de dados '+ConexaoZeos.Database+' em '+ConexaoZeos.HostName);
        end;
}

     end;

     mesano:=strzero(Datetomes(Sistema.hoje),2)+strzero(Datetoano(Sistema.hoje,true),4);
     if FTransSaldos=nil then FGeral.CreateForm(TFTransSaldos,FTransSaldos);
// 30.01.08
     if Global.Usuario.OutrosAcessos[0311] then begin
       if FOrcamentos=nil then FGeral.CreateForm(TFOrcamentos,FOrcamentos);
         FOrcamentos.ChecaRetornos;
     end;
// 20.10.08
     if Global.Usuario.OutrosAcessos[0402] then begin
       if FPlanosPendentes=nil then FGeral.CreateForm(TFPlanosPendentes,FPlanosPendentes);
         FPlanosPendentes.ChecaPlanosPendentes;
     end;
// 12.11.08
     if Global.Usuario.OutrosAcessos[0403] then begin
       if FRegNaoConfPendentes=nil then FGeral.CreateForm(TFRegNaoConfPendentes,FRegNaoConfPendentes);
         FRegNaoConfPendentes.ChecaRegNaoConformidadesPendentes;
     end;
// 19.05.09 = ver se cria acesso no cad. de usuarios
     if FMovIndicadores=nil then FGeral.CreateForm(TFMovIndicadores,FMovIndicadores);
         FMovIndicadores.ChecaIndicadores;
// 19.10.09 - Mama
     if Global.Usuario.OutrosAcessos[0714] then begin
//       if FPendenciasPendentes=nil then FGeral.CreateForm(TFPendenciasPendentes,FPendenciasPendentes);
         FGeral.CreateForm(TFPendenciasPendentes,FPendenciasPendentes);
         FPendenciasPendentes.ChecaPendenciasPendentes;
     end;
// 16.06.16 - Alutech
     if Global.Usuario.OutrosAcessos[0724] then begin
//       if FPendenciasPendentes=nil then FGeral.CreateForm(TFPendenciasPendentes,FPendenciasPendentes);
         FGeral.CreateForm(TFPendenciasPendentes,FPendenciasPendentes);
         FPendenciasPendentes.ChecaPendenciasPendentes('R');
     end;
// 13.06.11
     if Global.Usuario.OutrosAcessos[0054] then begin
       if FPesagemSaida=nil then FGeral.CreateForm(TFPesagemSaida,FPesagemSaida);
         FPesagemSaida.Execute;
     end;
// 13.09.15
     if Global.Usuario.OutrosAcessos[0057] then begin
       if FPesagemEntrada=nil then FGeral.CreateForm(TFPesagemEntrada,FPesagemEntrada);
         FPesagemEntrada.Execute;
     end;
// 13.05.16 - Benato
     if Global.Usuario.OutrosAcessos[0059] then begin
       if FValidadeVencendo=nil then FGeral.CreateForm(TFValidadeVencendo,FValidadeVencendo);
         FValidadeVencendo.Execute;
     end;
// 19.07.16
     if Global.Usuario.OutrosAcessos[0060] then begin
       if FPesagemCaminhao=nil then FGeral.CreateForm(TFPesagemCaminhao,FPesagemCaminhao);
         FPesagemCaminhao.Execute;
     end;
// 03.03.17
     if Global.Usuario.OutrosAcessos[0064] then begin
       if FPesagemCaminhao2=nil then FGeral.CreateForm(TFPesagemCaminhao2,FPesagemCaminhao2);
         FPesagemCaminhao2.Execute;
     end;

// 09.09.2021
     if Global.Usuario.OutrosAcessos[0069] then begin

       if FTeleMarketing=nil then FGeral.CreateForm(TFTeleMarketing,FTeleMarketing);
       FTeleMarketing.Execute('P');

     end;


// 05.03.20
     if Global.Usuario.OutrosAcessos[0519] then begin

       if Global.Usuario.codigo <> 100 then begin

          if FChecaBalanca=nil then FGeral.CreateForm(TFChecaBalanca,FChecaBalanca);
            FChecaBalanca.Execute('S');

       end else begin

          if confirma('Usar balan�a ?') then begin

            if FChecaBalanca=nil then FGeral.CreateForm(TFChecaBalanca,FChecaBalanca);
              FChecaBalanca.Execute('S');

          end;

       end;

     end;
// 11.11.2022 - Pedidos via celular
   if Global.Topicos[1419] then TimerVendasCelular.enabled:=true else TimerVendasCelular.enabled:=false;

// 15.02.2021 - impressoras validas - por enquanto windows server ?
    ximp := LeArquivoINI(Global.NomeSistema,'Impressoras','TS');
    PastaSac := ExtractFileDir( Application.exename );
    idsessao := '';
//    comando  := 'Impressoras.bat';

    if ximp = 'S' then begin
{
      h:= getforegroundwindow;
      GetWindowThreadProcessID(h, @hpr);
      hth:= OpenProcess(STANDARD_RIGHTS_REQUIRED OR PROCESS_TERMINATE, false, hpr);
      ShowMessage('id= '+IntToStr(hpr)+ 'ou= '+IntToStr(hth));
}
       I := 255;
       SetLength(user, I);
       Windows.GetUserName(PChar(user), I);
       user := string(PChar(user));
       idsessaots := Checa( user );

//       Aviso('user='+user+' |idsessaots='+idsessaots);

       cIMPNFE  := LeArquivoINI(Global.NomeSistema,'Impressoras','IMPNFE');
 //      aviso( 'cIMPNFE='+cIMPNFE+'|');

       c1IMPNFE := PegaNomeImpressora( cIMPNFE,idsessaots);

 //      aviso( 'c1IMPNFE='+c1IMPNFE+'|');

       cIMPNFCE := LeArquivoINI(Global.NomeSistema,'Impressoras','IMPNFCE');
       c1IMPNFCE := trim(PegaNomeImpressora( cIMPNFCE,idsessaots));

       if trim(cimpnfe) <> '' then begin

         for p := 0 to  Printer.Printers.count-1 do begin

//             Aviso( 'atual='+c1IMPNFE +'x|x'+PegaNomeImpressora(Printer.Printers[p],idsessaots)+'x|' );

             if trim(c1IMPNFE) = trim(PegaNomeImpressora(Printer.Printers[p],idsessaots)) then begin

//                Aviso( 'configurada='+cIMPNFE +' | sac.ini='+Printer.Printers[p] );

                cIMPNFE := Printer.Printers[p];
//                Aviso(' Atualizando Sac.ini' );
                CriaArquivoINI(Global.NomeSistema,'Impressoras','IMPNFE',cImpnfe);
                break;

             end;

         end;

      end;

       if trim(cimpnfCe) <> '' then begin

         for p := 0 to  Printer.Printers.count-1 do begin


             if trim(c1IMPNFCE) = trim(PegaNomeImpressora(Printer.Printers[p],idsessaots) ) then begin

                cIMPNFCE := Printer.Printers[p];
                CriaArquivoINI(Global.NomeSistema,'Impressoras','IMPNFCE',cIMPNFCE);
                break;

             end;

         end;

      end;



    {
        if not FileExists( 'IMPRESSORAS.BAT' ) then begin

          AssignFile ( arqimp, 'IMPRESSORAS.BAT' );
          Rewrite ( arqimp );
          Writeln ( arqimp, 'query session ' +' > ' + 'Sessoes.txt' );
          CloseFile ( arqimp );

        end;
        ShellExecute(handle,'open',PWideChar('impressoras.bat'),'',nil,sw_hide  );
        if FileExists( 'sessoes.txt' ) then begin

           ListaIMp := TStringList.create;
           ListaIMp.loadfromfile( 'sessoes.txt' );
           I := 255;
           SetLength(user, I);
           Windows.GetUserName(PChar(user), I);
           user := string(PChar(user));

           for p := 0 to ListaIMp.count-1 do begin

              if AnsiPos( User,ListaImp[p] ) > 0 then  begin

                 idsessao := trim( copy( ListaImp[p],45,2) );

              end;

           end;
        //   Aviso('User='+user+' idsessao='+idsessao );
           ListaImp.free;
       end;
    }
   end;

// 06.12.18
     if GetIni('SACD','Config','TerminalCaixa') = 'S'  then begin

       if FVendaBalcao=nil then FGeral.CreateForm(TFVendaBalcao,FVendaBalcao);

         FVendaBalcao.WindowState:=wsMaximized;
         FVendaBalcao.SQLPanelGrid2.Width:=FVendaBalcao.SQLPanelGrid2.Width+tampaineldireito;

         FVendaBalcao.bgravar.Height:=FVendaBalcao.bgravar.Height + 10;
         FVendaBalcao.bgeranfe.Height:=FVendaBalcao.bgeranfe.Height + 10;
         FVendaBalcao.bcupom.Height:=FVendaBalcao.bcupom.Height + 10;
         FVendaBalcao.bgeraboleto.Height:=FVendaBalcao.bgeraboleto.Height + 10;
         FVendaBalcao.bsair.Height:=FVendaBalcao.bsair.Height + 10;
         FVendaBalcao.bf11.Height:=FVendaBalcao.bf11.Height + 10;
         FVendaBalcao.bIncluiritem.Height:=FVendaBalcao.bIncluiritem.Height + 10;
         FVendaBalcao.bExcluiritem.Height:=FVendaBalcao.bExcluiritem.Height + 10;
         FVendaBalcao.bafaturar.Height:=FVendaBalcao.bafaturar.Height + 10;
         FVendaBalcao.bCancelaritem.Height:=FVendaBalcao.bCancelaritem.Height + 10;


         FVendaBalcao.bgravar.Width:=FVendaBalcao.bgravar.Width + tampaineldireito;
         FVendaBalcao.bgeranfe.Width:=FVendaBalcao.bgeranfe.Width + tampaineldireito;
         FVendaBalcao.bcupom.Width:=FVendaBalcao.bcupom.Width + tampaineldireito;
         FVendaBalcao.bgeraboleto.Width:=FVendaBalcao.bgeraboleto.Width + tampaineldireito;
         FVendaBalcao.bsair.Width:=FVendaBalcao.bsair.Width + tampaineldireito;
         FVendaBalcao.bf11.Width:=FVendaBalcao.Width + tampaineldireito;
         FVendaBalcao.bIncluiritem.Width:=FVendaBalcao.bIncluiritem.Width + tampaineldireito;
         FVendaBalcao.bExcluiritem.Width:=FVendaBalcao.bExcluiritem.Width + tampaineldireito;
         FVendaBalcao.bafaturar.Width:=FVendaBalcao.bafaturar.Width + tampaineldireito;
         FVendaBalcao.bCancelaritem.Width:=FVendaBalcao.bCancelaritem.Width + tampaineldireito;

         FVendaBalcao.bgravar.Font.Size:=FVendaBalcao.bgravar.Font.Size + 15;
         FVendaBalcao.bgeranfe.Font.Size:=FVendaBalcao.bgeranfe.Font.Size + 15;
         FVendaBalcao.bcupom.Font.Size:=FVendaBalcao.bcupom.Font.Size + 15;
         FVendaBalcao.bgeraboleto.Font.Size:=FVendaBalcao.bgeraboleto.Font.Size + 15;
         FVendaBalcao.bsair.Font.Size:=FVendaBalcao.bsair.Font.Size + 15;
         FVendaBalcao.bf11.Font.Size:=FVendaBalcao.Font.Size + 15;

         FVendaBalcao.bIncluiritem.Font.Size:=FVendaBalcao.bIncluiritem.Font.Size + 15;
         FVendaBalcao.bExcluiritem.Font.Size:=FVendaBalcao.bExcluiritem.Font.Size + 15;
         FVendaBalcao.bafaturar.Font.Size:=FVendaBalcao.bafaturar.Font.Size + 15;
         FVendaBalcao.bCancelaritem.Font.Size:=FVendaBalcao.bCancelaritem.Font.Size + 15;

         FVendaBalcao.bgravar.Margin:=FVendaBalcao.bgravar.Margin + margin;
         FVendaBalcao.bgeranfe.Margin:=FVendaBalcao.bgeranfe.Margin + margin;
         FVendaBalcao.bcupom.Margin:=FVendaBalcao.bcupom.Margin + margin;
         FVendaBalcao.bgeraboleto.Margin:=FVendaBalcao.bgeraboleto.Margin + margin;
         FVendaBalcao.bsair.Margin:=FVendaBalcao.bsair.Margin + margin;
         FVendaBalcao.bf11.Margin:=FVendaBalcao.bf11.Margin + margin;
         FVendaBalcao.bIncluiritem.Margin:=FVendaBalcao.bIncluiritem.Margin + margin;
         FVendaBalcao.bExcluiritem.Margin:=FVendaBalcao.bExcluiritem.Margin + margin;
         FVendaBalcao.bafaturar.Margin:=FVendaBalcao.bafaturar.Margin + margin;
         FVendaBalcao.bCancelaritem.Margin:=FVendaBalcao.bCancelaritem.Margin + margin;

         FVendaBalcao.bgravar.Transparent:=False;
         FVendaBalcao.bgeranfe.Transparent:=False;
         FVendaBalcao.bcupom.Transparent:=False;
         FVendaBalcao.bgeraboleto.Transparent:=False;
         FVendaBalcao.bsair.Transparent:=False;
         FVendaBalcao.bf11.Transparent:=False;
         FVendaBalcao.bIncluiritem.Transparent:=False;
         FVendaBalcao.bExcluiritem.Transparent:=False;
         FVendaBalcao.bafaturar.Transparent:=False;
         FVendaBalcao.bCancelaritem.Transparent:=False;

//         FVendaBalcao.bgravar.Top:=FVendaBalcao.bgravar.Top + 35;
         FVendaBalcao.bgeranfe.Top:=FVendaBalcao.bgeranfe.Top + 15;
         FVendaBalcao.bcupom.Top:=FVendaBalcao.bcupom.Top + 30;
         FVendaBalcao.bgeraboleto.Top:=FVendaBalcao.bgeraboleto.Top +   45;
         FVendaBalcao.bsair.Top:=FVendaBalcao.bsair.Top + 58;
         FVendaBalcao.bf11.Top:=FVendaBalcao.bf11.Top + 10;
         FVendaBalcao.bIncluiritem.Top:=FVendaBalcao.bIncluiritem.Top + 25 ;
         FVendaBalcao.bExcluiritem.Top:=FVendaBalcao.bExcluiritem.Top + 40;

         FVendaBalcao.bafaturar.Top:=FVendaBalcao.bafaturar.Top-80 ;
         FVendaBalcao.bCancelaritem.Top:=FVendaBalcao.bCancelaritem.Top + 50;

         FVendaBalcao.blebalanca1.visible:=False;
         FVendaBalcao.blebalanca2.visible:=False;
         FVendaBalcao.brelpendentes.visible:=False;
         FVendaBalcao.bbaixa.visible:=False;
         FVendaBalcao.bvalidade.visible:=False;
         FVendaBalcao.bimpressao.visible:=False;

         FVendaBalcao.Grid.Columns[FVendaBalcao.Grid.getcolumn('esto_descricao')].widthcolumn:=630;
         FVendaBalcao.Grid.Columns[FVendaBalcao.Grid.getcolumn('move_esto_codigo')].widthcolumn:=100;
         FVendaBalcao.Grid.Columns[FVendaBalcao.Grid.getcolumn('move_venda')].widthcolumn:=145;
         FVendaBalcao.Grid.Columns[FVendaBalcao.Grid.getcolumn('total')].widthcolumn:=175;
         FVendaBalcao.Grid.Font.Size:=17;

         FVendaBalcao.EdTotalNota.Left:=FVendaBalcao.EdTotalNota.Left+290;
         FVendaBalcao.EdTotalNota.Width:=FVendaBalcao.EdTotalNota.width+50;
         FVendaBalcao.EdTotalNota.Height:=FVendaBalcao.EdTotalNota.Height+10;
         FVendaBalcao.EdTotalNota.Font.Size:=28;
         FVendaBalcao.EdTotalNota.Top:=FVendaBalcao.EdTotalNota.Top-05;


//         FVendaBalcao.PParcelas.Left:=FVendaBalcao.PParcelas.Left+200;
{
         FVendaBalcao.EdValorrecebido.Left:=FVendaBalcao.EdValorrecebido.Left+100;
         FVendaBalcao.EdValortroco.Left:=FVendaBalcao.EdValortroco.Left+100;
}
{
         for p:= 0 to FVendaBalcao.ComponentCount-1 do begin

            if FVendaBalcao.Components[p] is TSqlEd then begin

               if TSqlEd( FVendaBalcao.Components[p] ).left > 12 then begin

                  TSqlEd( FVendaBalcao.Components[p] ).left :=
                  TSqlEd( FVendaBalcao.Components[p] ).left + 150;
//                  TSqlEd( FVendaBalcao.Components[p] ).Width :=
//                  TSqlEd( FVendaBalcao.Components[p] ).Width + 020;

               end;

            end;

         end;
}
         FVendaBalcao.Execute;

     end;

// 10.03.08
    if trim( FGeral.Getconfig1asstring('TIPOSRELFATURA') )<>'' then
      Global.TiposRelVenda:=Global.TiposRelVenda+';'+FGeral.Getconfig1asstring('TIPOSRELFATURA');
// 28.03.08
    if trim( FGeral.Getconfig1asstring('TIPOSRELCOMPRAS') )<>'' then
      Global.TiposRelCompra:=Global.TiposRelCompra+';'+FGeral.Getconfig1asstring('TIPOSRELCOMPRAS');
// 05.01.10
//    if trim(FGeral.Getconfig1asstring('NumSerieCert'))<>'' then
//      Global.UsaNfe:='S'
//    else
//      Global.UsaNfe:='N';
// 07.10.10
    if ( trim(FGeral.Getconfig1asstring('NumSerieCert'))<>'' ) or
//       ( trim(FGeral.Getconfig1asstring('NumSerieCert'))='1' ) then
// 06.04.11
       ( trim(FGeral.Getconfig1asstring('AmbienteNFe'))='1' ) then

      Global.UsaNfe:='S'
    else
      Global.UsaNfe:='N';
// 10.12.15
    if ( trim(FGeral.Getconfig1asstring('NumSerieCert'))<>'' ) or
       ( trim(FGeral.Getconfig1asstring('idtoken'))<>'' ) then
      Global.UsaNfCe:='S'
    else
      Global.UsaNfCe:='N';
//////////////////////////

// 20.06.12
//    if Global.Topicos[1027] then AtivaAtalho( '01');
//    if Global.Topicos[1027] then AtivaAtalho(  '01' , BaixarPendncias1 );
    if Global.Topicos[1027] then begin
      if trim(FGeral.Getconfig1asstring('atalhosmenu'))<>'' then begin
        Lista:=TStringList.create;
        strtolista(Lista,FGeral.Getconfig1asstring('atalhosmenu'),';',true);
        for p:=0 to Lista.count-1 do begin

          if trim(Lista[p])<>'' then begin
// 25.04.18
            if Lista[p]='RelaoPendentes2' then
              AtivaAtalho( strzero( (p+1),2 ) , FMain.RelaoPendentes2 )
            else
              AtivaAtalho( strzero( (p+1),2 ) , AchaCaption(Lista[p],Menu.Items ) );

          end;
        end;
//        AtivaAtalho(  '01' , AchaCaption('Cidades1',Menu.Items ) );
      end;
    end;

//  if FGeral.GetIPInternet( Host, IP, Err ) then
//       Pusuario.Caption:=Host+' | '+ip
//    else
//       Pusuario.Caption:=Err;

    if not Global.Topicos[1034] then
      Pusuario.Caption:=Pusuario.caption+' | IP '+PegaIPNet;
// 03.03.14
    if ( Global.Usuario.OutrosAcessos[0337] ) and ( Datetodia(Sistema.hoje)>20 )  then
      FValoraFAturar.Execute;
// 06.02.15 - Vivan
    ConfiguraCorForms;
// 04.07.15 - Coorlaf
     if Global.Usuario.OutrosAcessos[0342] then begin
       if Global.UsaNfe='S' then
         ChecaNfenaoautorizadas;
     end;
// 15.06.16 - Cristina com ciencia liane+vande
     if pos('PAGUSAT',Uppercase(FGeral.GetNomeRazaoSocialEntidade( strtoint(Global.CodigoUnidade),'U','R')))>0 then
       Global.unidadematriz:='002';
// 09.06.20 - Fama - pre�o dif. entre 002 e 003...
   if FGeral.getconfig1asstring( 'UNIDADEmatriz' ) <>'' then
      global.unidadematriz:=FGeral.getconfig1asstring( 'UNIDADEmatriz' ) ;
// 09.02.2023
    Global.UnidadesNCm:=FGeral.GetConfig1AsString('unidadesncm');

// 20.06.16
    if  (Global.topicos[1043]) or (Global.topicos[1045]) then
      if not FGeral.ConectaContax then begin
        Avisoerro('N�o foi poss�vel conectar banco de dados do Contax');
        exit;
      end;

///    Pusuario.Caption:=Pusuario.caption;
  end else begin
//    AbreForm( 'FNotaSaida' );
//    FNotaSaida.BringToFront;
    nomeformulario:=( Global.UltimoFormAberto );
    if trim(nomeformulario)<>'' then begin
//      showmessage( FMain.classname );
//      if FindWindow( FGeral.StrToPChar(FMain.classname) ,PAnsichar( nomeformulario ) ) >0 then
        AbreForm( nomeformulario );
    end;
  end;
 ////////////////////////////////////////////////////

end;


procedure TFMain.SairClick(Sender: TObject);
/////////////////////////////////////////////
begin

  if FGerenciaWhats <> nil then begin

    with FGerenciaWhats do begin

      if TINject1.IsConnected then begin

         TInject1.Logtout;
         TInject1.Disconnect;

      end;

    end;

  end;

  Close;

end;



procedure TFMain.Ediodetabelas1Click(Sender: TObject);
begin
//  if Global.CodigosEspecificos[1314] then begin
//     if not Sistema.Processando then FERPEdit_Execute;
//  end;
end;


procedure TFMain.ConfiguraoDaUnidade1Click(Sender: TObject);
begin
  if not Sistema.Processando then FDiversos.ConfUnidade;
end;

// 11.08.2021
procedure TFMain.FormClick(Sender: TObject);
////////////////////////////////////////////////
begin

{
   if (Global.Usuario.codigo = 100)  then begin

   if confirma('Executa ?') then begin


      FDiversos.TransacaoDuplicada('movesto','moes_transacao','moes_tipomov');
      FDiversos.TransacaoDuplicada('movestoque','move_operacao','move_tipomov');
      FDiversos.TransacaoDuplicada('movbase','movb_transacao','movb_tipomov');
      FDiversos.TransacaoDuplicada('movbase','movb_operacao','movb_tipomov');
      FDiversos.TransacaoDuplicada('pendencias','pend_operacao','pend_parcela');
      FDiversos.TransacaoDuplicada('movfin','movf_operacao','movf_tipomov');


   end;

   end;
}

end;

procedure TFMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
///////////////////////////////////////////////////////////////////////////

    Function FezReducaoZ:boolean;
    ////////////////////////////
    var Q:TSqlquery;
    begin
      Q:=Sqltoquery('select mecf_data from movleituraecf where mecf_status=''N'''+
                    ' and mecf_tipo='+Stringtosql('Z')+
                    ' and mecf_data='+Datetosql(Sistema.Hoje)+
                    ' and mecf_unid_codigo='+Stringtosql(Global.CodigoUnidade) );
      Result:=not Q.eof;
      FGeral.FechaQuery(Q);
    end;

begin
  CanClose:=True;
  if (not Global.Usuario.Desenvolvimento) and (not Sistema.Finalizando) then begin
// 08.01.12- Benatto - Reducao Z
     if ( FGeral.ConfiguradoECF ) then begin
       if ( not FezReducaoZ ) then begin
         Avisoerro('Aten��o ! Redu��o Z n�o encontrada no banco de dados');
         CanClose:=Confirma('Sair do sistema mesmo assim ?');
       end else
         CanClose:=Confirma('Confirma a finaliza��o do sistema');
     end else
       CanClose:=Confirma('Confirma a finaliza��o do sistema');

  end;
  Sistema.Finalizando:=False;
end;


procedure TFMain.AlteraoDeSenha1Click(Sender: TObject);
begin
  if not Sistema.Processando then FUsuarios.AlteraSenha;
end;


procedure TFMain.ReorganizarBancoDados1Click(Sender: TObject);
begin
  if not Sistema.Processando then FGeral.OrganizarBanco;
end;


procedure TFMain.UsuriosAtivos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FDiversos.UsuariosAtivos;
end;


procedure TFMain.Calendrio1Click(Sender: TObject);
begin
//  if not Sistema.Processando then FCalendario.Show;
end;


procedure TFMain.GrupoUsurios1Click(Sender: TObject);
begin
  if not Sistema.Processando then FGrUsuarios.ShowModal;

end;

procedure TFMain.Regies1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRegioes.Showmodal;

end;

procedure TFMain.Cidades1Click(Sender: TObject);
begin
  if not Sistema.Processando then FCidades.ShowModal;

end;

procedure TFMain.Usurios1Click(Sender: TObject);
begin
  if not Sistema.Processando then FUsuarios.Showmodal;

end;

procedure TFMain.Unidades1Click(Sender: TObject);
begin
  if not Sistema.Processando then FUnidades.Showmodal;

end;

procedure TFMain.Empresas1Click(Sender: TObject);
begin
  if not Sistema.Processando then FEmpresas.showmodal;

end;

procedure TFMain.SubstituioDeUsurio1Click(Sender: TObject);
begin
  FInit.InicializaUsuario(False);

end;

procedure TFMain.CadHistoricosClick(Sender: TObject);
begin
  if not Sistema.Processando then FHistoricos.ShowModal;

end;

procedure TFMain.NaturezasFiscais1Click(Sender: TObject);
begin
  if not Sistema.Processando then FNatureza.Execute;

end;

procedure TFMain.NFeDestinadas1Click(Sender: TObject);
begin
  if not Sistema.Processando then FNfeDestinadas.Execute;

end;

procedure TFMain.SituaesTributrias1Click(Sender: TObject);
begin
  if not Sistema.Processando then FSittributaria.ShowModal;

end;

procedure TFMain.Representantes1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRepresentantes.ShowModal;

end;

procedure TFMain.ConfiguracaoGeralClick(Sender: TObject);
begin
  if not Sistema.Processando then FConfigura.Execute;
end;

procedure TFMain.ContasGerenciaisClick(Sender: TObject);
begin
  if not Sistema.Processando then FPlano.Execute;

end;

// 23.09.20
procedure TFMain.Contratos1Click(Sender: TObject);
///////////////////////////////////////////////////////////////
begin

  if not Sistema.Processando then FContratos.Execute;

end;

procedure TFMain.CadClientesClick(Sender: TObject);
begin
  if not Sistema.Processando then FCadcli.Execute;

end;

procedure TFMain.CadFornecedoresClick(Sender: TObject);
begin
  if not Sistema.Processando then FFornece.Execute;

end;

procedure TFMain.CadFormasDePagamentoClick(Sender: TObject);
begin
  if not Sistema.Processando then FCondPagto.Execute;

end;

procedure TFMain.CadPortadoresClick(Sender: TObject);
begin
  if not Sistema.Processando then FPortadores.Execute;

end;

procedure TFMain.FeriadosClick(Sender: TObject);
begin
  if not Sistema.Processando then FFeriados.Execute;

end;

procedure TFMain.CadImpressosClick(Sender: TObject);
begin
  if not Sistema.Processando then FCadImp.Execute;
end;

procedure TFMain.CadMotivosdeBloqueioClick(Sender: TObject);
begin
  if not Sistema.Processando then FMotivosBloq.Execute;

end;

procedure TFMain.Cores1Click(Sender: TObject);
begin
  if not Sistema.Processando then FCores.Execute;

end;

procedure TFMain.amanhos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FTamanhos.Execute;

end;


procedure TFMain.Grupos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FGrupos.Execute;

end;

procedure TFMain.SubGrupos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FSubGrupos.Execute;

end;

procedure TFMain.Grades1Click(Sender: TObject);
begin
  if not Sistema.Processando then FGrades.Execute;

end;

procedure TFMain.CadProdutosClick(Sender: TObject);
begin
  if not Sistema.Processando then FEstoque.Execute;

end;

procedure TFMain.Familias1Click(Sender: TObject);
begin
  if not Sistema.Processando then FFamilias.Execute;

end;

procedure TFMain.Consignao1Click(Sender: TObject);
begin
  if not Sistema.Processando then Remessa_Execute('I');

end;

procedure TFMain.AlteraoConsignao1Click(Sender: TObject);
begin
  if not Sistema.Processando then Remessa_Execute('A');

end;

procedure TFMain.DevoluodeConsignao1Click(Sender: TObject);
begin
  if not Sistema.Processando then Remessa_Execute('D');

end;

procedure TFMain.ExtratodoProduto1Click(Sender: TObject);
begin
//  if not Sistema.Processando then FRelEstoque_Extrato;
  if not Sistema.Processando then FRelEstoque_ExtratoColunas;

end;

procedure TFMain.Acertos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FAcertos.Execute(Global.CodAcertoEsEnt);

end;

procedure TFMain.CodigosdeAlquotas1Click(Sender: TObject);
begin
  if not Sistema.Processando then FCodigosFiscais.Execute;
end;

procedure TFMain.abelasPreo1Click(Sender: TObject);
begin
  if not Sistema.Processando then FTabela.Execute;
end;

procedure TFMain.RetornoConsigAcerto1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRetConsig.Execute;
end;

procedure TFMain.ransao1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelGerenciais_Transacao;

end;

procedure TFMain.CancelamentoTransao1Click(Sender: TObject);
begin
  if not Sistema.Processando then FCancTransacao.Execute;

end;

procedure TFMain.ConfiguraodeMovimentos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FConfMovimento.Execute;

end;

procedure TFMain.ransportadores1Click(Sender: TObject);
begin
  if not Sistema.Processando then FTransp.Execute;

end;

procedure TFMain.Saida1Click(Sender: TObject);
begin

  if not Sistema.Processando then FNotaSaida.Execute('I');

end;

procedure TFMain.AuditoriaFiscal1Click(Sender: TObject);
begin    
  if not Sistema.Processando then FRelGerenciais_AuditoriaFiscal;

end;

procedure TFMain.Entrada1Click(Sender: TObject);
begin
  if not Sistema.Processando then FNotaCompra.Execute('I');

end;

procedure TFMain.LancarPendenciaClick(Sender: TObject);
begin
  if not Sistema.Processando then FLancaPendencia.Execute;

end;

procedure TFMain.ransfernciaMensal1Click(Sender: TObject);
begin
  if not Sistema.Processando then FTransSaldos.Execute;

end;

procedure TFMain.MaterialPredominante1Click(Sender: TObject);
begin
  if not Sistema.Processando then FMaterial.Execute;

end;

procedure TFMain.MDFecomCte1Click(Sender: TObject);
begin
     if not Sistema.Processando then FPesagemporCarga.execute('CTE');

end;

procedure TFMain.LanarCaixaBancos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FLancaMovfin.Execute;

end;

procedure TFMain.ExtratoContaClick(Sender: TObject);
begin
  if not Sistema.Processando then FRelCxBancos_Extrato;

end;

procedure TFMain.ransfernciaMensal2Click(Sender: TObject);
begin
  if not Sistema.Processando then FTransContas.Execute;

end;

procedure TFMain.AlterarPendencias1Click(Sender: TObject);
begin
  if not Sistema.Processando then FAlteraPendencia.Execute;

end;

procedure TFMain.BaixarPendncias1Click(Sender: TObject);
begin
  if not Sistema.Processando then FBaixaPendencia.Execute;

end;

procedure TFMain.RelaoIncluidas1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_Incluidas('P'); ;

end;

procedure TFMain.RelaoIncluidas2Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_Incluidas('R'); ;

end;

procedure TFMain.RelaoPendentes1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_Pendentes('P'); ;

end;

procedure TFMain.RelaoBaixadas1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_Baixadas('P'); ;

end;

procedure TFMain.RelaoPendentes2Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_Pendentes('R'); ;

end;

procedure TFMain.RelaoBaixadas2Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_Baixadas('R'); ;

end;

procedure TFMain.ChequesRecebidos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FCadcheques.Execute;;
//  if not Sistema.Processando then FCadcheques2.Execute;;

end;

procedure TFMain.ChequesRecebidos2Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelGerenciais_ChequesRecebidos;

end;

procedure TFMain.AuditoriaCustos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelGerenciais_AuditoriaCustos;

end;

procedure TFMain.Transferncia1Click(Sender: TObject);
begin
  if not Sistema.Processando then FNotaTransf.Execute('I');
end;

procedure TFMain.PosioFinanceira1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_Posicao('P');

end;

procedure TFMain.PosioFinanceira2Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_Posicao('R');

end;

procedure TFMain.BaixarCheques1Click(Sender: TObject);
begin
  if not Sistema.Processando then FBaixacheques.Execute;

end;

procedure TFMain.CotasporRepres1Click(Sender: TObject);
begin
  if not Sistema.Processando then FCotasRepr.Execute;

end;

procedure TFMain.Vendas1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelGerenciais_Comissoes;

end;

procedure TFMain.Saidas1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_IMpnfsaida;

end;

procedure TFMain.ransferncia1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_IMpnftransf;

end;

procedure TFMain.Remessa1Click(Sender: TObject);
begin
  if not Sistema.Processando then RemessaPE_Execute('I');

end;

procedure TFMain.AlteraodeRemessa1Click(Sender: TObject);
begin
  if not Sistema.Processando then RemessaPE_Execute('A');

end;

procedure TFMain.Incluso1Click(Sender: TObject);
begin
  if not Sistema.Processando then PedidoCompra_Execute('I');

end;

procedure TFMain.Alterao1Click(Sender: TObject);
begin
  if not Sistema.Processando then PedidoCompra_Execute('A');

end;

procedure TFMain.VendasQtde1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelGerenciais_VendasQtde;

end;

procedure TFMain.PedidosdeVenda1Click(Sender: TObject);
begin
//  if not Sistema.Processando then FRetprontaentrega.Execute;
// 06.07.06
//  if not Sistema.Processando then FRetprontaentregaNovo.Execute;

end;

procedure TFMain.ExportaoCaixaBancos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FExpcaixaban.Execute;

end;

procedure TFMain.ExportaoComprasVendas1Click(Sender: TObject);
begin
  if not Sistema.Processando then FExpNFprazo.Execute;

end;

procedure TFMain.Faturamento1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_Faturamento;     //

end;

procedure TFMain.SaidaECF1Click(Sender: TObject);
begin
  if not Sistema.Processando then FNotaSaida.Execute('I','S');

end;

procedure TFMain.AlteraoSaida1Click(Sender: TObject);
begin
  if not Sistema.Processando then FNotaSaida.Execute('A');

end;

procedure TFMain.ExportaoLivroFiscal1Click(Sender: TObject);
begin
////////////  if not Sistema.Processando then FExpLivFiscal.Execute;

end;

procedure TFMain.RomaneioRetorno1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_IMpromaneio;

end;

procedure TFMain.RetornoRomaneio1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRetRomaneio.Execute;

end;

procedure TFMain.PosioEstoque1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelEstoque_Posicao;
end;

procedure TFMain.Consignaesemaberto1Click(Sender: TObject);
begin
//  if not Sistema.Processando then FRelGerenciais_ConsigAberto;

end;

procedure TFMain.PosioCliente1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelGerenciais_PosicaoCliente;

end;

procedure TFMain.ProntaEntregaemaberto1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelGerenciais_ProntaEntregaAberto;

end;

procedure TFMain.AjustesSaldosMensais1Click(Sender: TObject);
begin
  if not Sistema.Processando then FAjusteSaldosFin.execute;

end;

procedure TFMain.ReceitasDespesas1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelCxBancos_DespRece;

end;

procedure TFMain.FluxodeCaixa1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelCxBancos_FluxoCaixa;

end;

procedure TFMain.SequnciaSaida1Click(Sender: TObject);
begin
  if not Sistema.Processando then FNotaSaida.Execute('S');

end;

procedure TFMain.ItensClick(Sender: TObject);
begin
  if not Sistema.Processando then FRelEstoque_Cadastro;

end;

procedure TFMain.InventrioConsignado1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelEstoque_InventaConsig('Consignado','N');

end;

procedure TFMain.InventrioProntaEntrega1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelEstoque_InventaConsig('Prontaentrega','N');

end;

procedure TFMain.InventrioRegimeEspecial1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelEstoque_InventaConsig('Regimeespecial','N');

end;

procedure TFMain.Compras1Click(Sender: TObject);
begin
if not Sistema.Processando then FRelGerenciais_Compras;

end;

procedure TFMain.Vendas2Click(Sender: TObject);
begin
   if not Sistema.Processando then FRelGerenciais_Vendas;
end;

procedure TFMain.ConfernciaDescontos1Click(Sender: TObject);
begin
if not Sistema.Processando then FRelGerenciais_ConfDescontos;

end;

procedure TFMain.ImpressoRemessa1Click(Sender: TObject);
begin
// retornado em 07.06.10
  if not Sistema.Processando then Remessa_Execute('X');

end;

procedure TFMain.Sintegra1Click(Sender: TObject);
begin
  if not Sistema.Processando then FSintegra.Execute;

end;

procedure TFMain.Inventrio1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelEstoque_Inventario;

end;

procedure TFMain.DevoluoRomaneio1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_ImpNFDevolucao;

end;

procedure TFMain.RemMagazine1Click(Sender: TObject);
begin
// 16.11.12 - Vivan - Lindacir - recolocado
  if not Sistema.Processando then Remessa_Execute('I','S');

end;

procedure TFMain.DetalheVendaConsig1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelGerenciais_DetalheVC ;

end;

procedure TFMain.ExportaoFiscalWindows1Click(Sender: TObject);
begin
  if not Sistema.Processando then FExpFiscalWin.Execute;

end;

procedure TFMain.ResumoConsigAberto1Click(Sender: TObject);
begin
//  if not Sistema.Processando then FRelGerenciais_ConsigAbertoRes;

end;

procedure TFMain.ImpressoRemessaPE1Click(Sender: TObject);
begin
  if not Sistema.Processando then RemessaPE_Execute('X');

end;

procedure TFMain.AlterarCaixaBancos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FAlteracaixa.Execute;

end;

procedure TFMain.ConfAcrescimos1Click(Sender: TObject);
//////////////////////////////////////////////////////////
begin

   if not Sistema.Processando then FRelGerenciais_ConfAcrescimos;

end;

procedure TFMain.ConferePE1Click(Sender: TObject);
begin
//  if not Sistema.Processando then FRelGerenciais_ConfereProntaEntregaAberto('RP');

end;

procedure TFMain.transfernciaRemessa1Click(Sender: TObject);
begin
  if not Sistema.Processando then FTransfrem.Execute;

end;

// 09.08.19
procedure TFMain.TransformacaoClick(Sender: TObject);
////////////////////////////////////////////////////////
begin

  if not Sistema.Processando then FPesagemCamaraFria.Execute('T');

end;

procedure TFMain.tributacaoNCMClick(Sender: TObject);
begin
  if not Sistema.Processando then FTributacaoNCM.Execute;

end;

procedure TFMain.FichaCadastral1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelCadastros_FichaCadastral;

end;

procedure TFMain.UnidadeProduto1Click(Sender: TObject);
begin
//  if not Sistema.Processando then FRelGerenciais_MediaVendas('1',Global.CodVendaConsig);

end;

procedure TFMain.RepresProduto1Click(Sender: TObject);
begin
//  if not Sistema.Processando then FRelGerenciais_MediaVendas('2',Global.CodVendaConsig);

end;

procedure TFMain.RepresCliente1Click(Sender: TObject);
begin
//  Avisoerro('Op��o em desenvolvimento');
//  if not Sistema.Processando then FRelGerenciais_MediaVendas('3',Global.CodVendaConsig);

end;

procedure TFMain.UnidadeRepres1Click(Sender: TObject);
begin
//  if not Sistema.Processando then FRelGerenciais_MediaVendas('4',Global.CodVendaConsig);
  Avisoerro('Op��o em desenvolvimento');

end;

procedure TFMain.TransaesCanceladas1Click(Sender: TObject);
begin
  if not Sistema.Processando then  FRelAuditorias_Canceladas;

end;

procedure TFMain.ConfereRC1Click(Sender: TObject);
begin
//  if not Sistema.Processando then FRelGerenciais_ConfereProntaEntregaAberto('RC');

end;

procedure TFMain.TransfCorrigidas1Click(Sender: TObject);
begin
  if not Sistema.Processando then  FRelGerenciais_CorrecaoTransferencias;              // 17

end;

procedure TFMain.ExtratoSinttico1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelEstoque_ExtratoSintetico;

end;

procedure TFMain.Aniversariantes1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelCadastros_Aniversariantes;

end;

procedure TFMain.AtendimentoRepr1Click(Sender: TObject);
begin
  if not Sistema.Processando then  FRelGerenciais_AtendimentosRepre;              // 18

end;

procedure TFMain.InventrioRetroativoConsignado1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelEstoque_InventaConsig('Consignado','S');

end;

procedure TFMain.MensagensNotasFiscais1Click(Sender: TObject);
begin
  if not Sistema.Processando then FMensNotas.Execute;

end;

procedure TFMain.AlteraoEntrada1Click(Sender: TObject);
begin
  if not Sistema.Processando then FNotaCompra.Execute('A');

end;

procedure TFMain.ClientesNovos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelCadastros_CliNovos;

end;

procedure TFMain.ClientesNovosResumo1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelCadastros_CliNovosRes;

end;

procedure TFMain.ResumoRegEspAbertp1Click(Sender: TObject);
begin
//  if not Sistema.Processando then FRelGerenciais_RegEspecialAbertoRes;

end;

procedure TFMain.Antecipaes1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_Antecipacoes;

end;

procedure TFMain.UnidadeProduto2Click(Sender: TObject);
begin
//  if not Sistema.Processando then FRelGerenciais_MediaVendas('1',Global.CodVendaProntaEntregaFecha);

end;

procedure TFMain.AjustesdeSaldos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FAjustesaldos.Execute('AJ');;

end;

procedure TFMain.Compras2Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelfinan_Compras;

end;

procedure TFMain.CMV1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelGerenciais_CMV;

end;

procedure TFMain.Etiquetas1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelCadastros_Etiqueta;
end;

// 10.09.20
procedure TFMain.EtiquetasMiudos1Click(Sender: TObject);
///////////////////////////////////////////////////////////
begin

  if not Sistema.Processando then FSaidaDesossa.Execute('MI');

end;

procedure TFMain.PedidodeVendaIncClick(Sender: TObject);
begin
  if not Sistema.Processando then PedidoVenda_Execute('I');

end;

procedure TFMain.Alterao2Click(Sender: TObject);
begin
  if not Sistema.Processando then PedidoVenda_Execute('A');

end;

procedure TFMain.UnidadeProduto3Click(Sender: TObject);
begin
//  if not Sistema.Processando then FRelGerenciais_MediaVendas('1',Global.CodVendaREFinal);

end;

procedure TFMain.RepresProduto3Click(Sender: TObject);
begin
//  if not Sistema.Processando then FRelGerenciais_MediaVendas('2',Global.CodVendaREFinal);

end;

procedure TFMain.CadastroOcorrncias1Click(Sender: TObject);
begin
  if not Sistema.Processando then FCadocorrencias.Execute;

end;

procedure TFMain.InadimplnciaCheques1Click(Sender: TObject);
begin
//  if not Sistema.Processando then  FRelGerenciais_InadimplenciaCheques;  // 21

end;

procedure TFMain.RepresProduto2Click(Sender: TObject);
begin
//  if not Sistema.Processando then FRelGerenciais_MediaVendas('2',Global.CodVendaProntaEntregaFecha);

end;

procedure TFMain.VendaProduto1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelGerenciais_VendasProdutoQtde;          // 22

end;

procedure TFMain.RepresCliente2Click(Sender: TObject);
begin
   Avisoerro('Op��o n�o dispon�vel para Pronta Entrega');
//  if not Sistema.Processando then FRelGerenciais_MediaVendas('3',Global.CodVendaProntaEntregaFecha);
end;

procedure TFMain.UnidadeRepres2Click(Sender: TObject);
begin
   Avisoerro('Op��o em desenvolvimento');

end;

procedure TFMain.PendentesRepr1Click(Sender: TObject);
begin
    if not Sistema.Processando then FRelFinan_PendentesRepre;     // 12

end;

procedure TFMain.ResumoVencerVencidos1Click(Sender: TObject);
begin
    if not Sistema.Processando then  FRelFinan_ResumoAberto('R');

end;

procedure TFMain.PosioPedido1Click(Sender: TObject);
begin
  if not Sistema.Processando then  FPosicaoPedidoVenda.Execute;

end;

procedure TFMain.Novaforma1Click(Sender: TObject);
begin
//  if not Sistema.Processando then FRelGerenciais_MediaVendasOutra('1',Global.CodVendaProntaEntregaFecha);

end;

procedure TFMain.RepresCliente3Click(Sender: TObject);
begin
//  if not Sistema.Processando then FRelGerenciais_MediaVendas('3',Global.CodVendaREFinal);

end;

procedure TFMain.Contagem1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelEstoque_Contagem;

end;

procedure TFMain.PosRepresentante1Click(Sender: TObject);
begin
  if not Sistema.Processando then  FPosicaoPedidoVenda.Execute('R');

end;

procedure TFMain.ReprCliente1Click(Sender: TObject);
begin
    if not Sistema.Processando then  FRelGerenciais_AtendimentoPedidos;         // 24
end;

procedure TFMain.MontagemKits1Click(Sender: TObject);
begin
  if not Sistema.Processando then  FMontagemkit.Execute;

end;

procedure TFMain.Contagem2Click(Sender: TObject);
begin
  if not Sistema.Processando then FAcertos.Execute(Global.CodContagemBalancoE);
end;

procedure TFMain.PeasPendente1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelGerenciais_PecasPendentes;         // 25
end;

procedure TFMain.PedidosVenda2Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelGerenciais_PedidosVenda; 
end;

procedure TFMain.BaixaMatriaPrima1Click(Sender: TObject);
begin
  if not Sistema.Processando then FAjustesaldos.Execute('BX');;

end;

procedure TFMain.Pesquisa011Click(Sender: TObject);
begin
    if not Sistema.Processando then FPesquisa01.Execute;

end;

procedure TFMain.BxMensalVendaTemporria1Click(Sender: TObject);
begin
    if not Sistema.Processando then FBaixaVendaTemporaria.Execute;

end;

procedure TFMain.ProdutosPedidosClick(Sender: TObject);
begin
  if not Sistema.Processando then  FRelGerenciais_PedidosProdutos('P');      // 27

end;

// 06.04.18
procedure TFMain.Processos1Click(Sender: TObject);
////////////////////////////////////////////////////
begin
  if not Sistema.Processando then FComposicao.Execute('P');;

end;

procedure TFMain.ProdutoRepresentante1Click(Sender: TObject);
begin
  if not Sistema.Processando then  FRelGerenciais_PedidosProdutos('RP');      // 27

end;

procedure TFMain.RemTrocaCreditoClick(Sender: TObject);
begin
//  if not Sistema.Processando then Remessa_Execute('I','J');
// 15.05.13
  if not Sistema.Processando then Remessa_Execute('I','T');

end;

procedure TFMain.EvoluoCusto1Click(Sender: TObject);
begin
   if not Sistema.Processando then FRelAuditorias_EvolucaoCusto;           // 2

end;

procedure TFMain.ReprProduto1Click(Sender: TObject);
begin
    if not Sistema.Processando then  FRelGerenciais_AtendimentoPedidosProdutos;         // 28

end;

procedure TFMain.iposdeMovimento1Click(Sender: TObject);
begin
  if not Sistema.Processando then  FRelcadastros_TiposdeMovimento;         // 6

end;

procedure TFMain.RelImpPedidos1Click(Sender: TObject);
begin
    if not Sistema.Processando then  FRelGerenciais_ImpressaoPedidos;         // 29

end;

procedure TFMain.ComparativoInventrios1Click(Sender: TObject);
begin
   if not Sistema.Processando then FRelAuditorias_ComparaInventario;           // 3

end;

procedure TFMain.ConfereRE1Click(Sender: TObject);
begin
//  if not Sistema.Processando then FRelGerenciais_ConfereProntaEntregaAberto('RE');

end;

// 14.12.17
procedure TFMain.ChecagenPisCofins1Click(Sender: TObject);
//////////////////////////////////////////////////////////////
begin
  if not Sistema.Processando then  FRelAuditorias_ChecaPisCofins;

end;

procedure TFMain.ChecaSaldo1Click(Sender: TObject);
begin
  if not Sistema.Processando then  FRelAuditorias_ChecaSaldo;

end;

procedure TFMain.ChecatributacaoNCMClick(Sender: TObject);
begin
  if not Sistema.Processando then  FRelAuditorias_ChecaTributacaoVendas;

end;

procedure TFMain.ExtratoProntaEntrega1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelEstoque_ExtratoEstoqueFora(Global.CodRemessaProntaEntrega);

end;

procedure TFMain.ExtratoRegimeEspecial1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelEstoque_ExtratoEstoqueFora(Global.CodVendaSerie4);

end;

procedure TFMain.RemessasMagazine1Click(Sender: TObject);
begin
///  if not Sistema.Processando then FRelGerenciais_RemessasMagazine;

end;

procedure TFMain.Atendimento1Click(Sender: TObject);
begin
  if not Sistema.Processando then FPrepedidos.Execute;

end;

procedure TFMain.Atendimento2Click(Sender: TObject);
begin
  if not Sistema.Processando then  FRelFinan_AtendePrePedidos;

end;

procedure TFMain.ExtratoConsignado1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelEstoque_ExtratoEstoqueFora(Global.CodRemessaConsig);

end;

procedure TFMain.RelacaoprepedidosClick(Sender: TObject);
begin

  if not Sistema.Processando then  FRelFinan_RelacaoPrePedidos;

end;

procedure TFMain.Comisso1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelCxBancos_ResumoComissoes;

end;



procedure TFMain.ExtratoProdutoFora1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelEstoque_ExtratoFora;

end;

procedure TFMain.NovoPedidosdeVenda1Click(Sender: TObject);
begin
// recolocado em 20.05.10
 if not Sistema.Processando then FRetprontaentregaNovo.Execute;

end;

procedure TFMain.Copas1Click(Sender: TObject);
begin
  if not Sistema.Processando then FCopas.Execute;

end;

procedure TFMain.Recebimento1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelCompras_Recebimento;

end;

procedure TFMain.ImpressoPedido1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelCompras_ImprimePedido;

end;

procedure TFMain.ExtratoMatriaPrima1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelCompras_ExtratoMateriaPrima;

end;

procedure TFMain.RelLogs1Click(Sender: TObject);
begin
  if not Sistema.Processando then FGeral.Relacaologs;

end;

procedure TFMain.Bloqueto1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_IMpBloqueto;

end;

procedure TFMain.ChequesRecebidos3Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelMalote_ChequesRecebidos;

end;

procedure TFMain.IntruesCobrana1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelCadastros_Testelayout;

end;

procedure TFMain.PendentesRepr2Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelMalote_PendentesRepre;

end;

procedure TFMain.Periodos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FPeriodos.ShowModal;

end;

procedure TFMain.ClassificaoIPI1Click(Sender: TObject);
begin
  if not Sistema.Processando then FCodigosIpi.execute;

end;

procedure TFMain.Oramento1Click(Sender: TObject);
begin
  if not Sistema.Processando then FOrcamento.execute;

end;

procedure TFMain.BaixaPagEletrnico1Click(Sender: TObject);
begin

    if not Sistema.Processando then  FBaixaPagamentos.Execute;

end;

procedure TFMain.BaixaPedCompra1Click(Sender: TObject);
begin
  if not Sistema.Processando then PedidoCompra_Execute('B');

end;

procedure TFMain.ExtratoMatPrimaResumido1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelCompras_ExtratoMateriaPrimaREsumido;

end;

procedure TFMain.ContagemRecebimento1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelCompras_RecebimentoContagem;

end;

procedure TFMain.VendasInativos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelCadastros_VendasInativos;

end;

procedure TFMain.EtiquetaVendasInativos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelCadastros_EtqVendasInativos;

end;

procedure TFMain.Oramento2Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_Orcamento;

end;

procedure TFMain.BaixaCobrana1Click(Sender: TObject);
begin
  if not Sistema.Processando then FBaixacobranca.execute;

end;

procedure TFMain.CadastroEmitentes1Click(Sender: TObject);
begin
  if not Sistema.Processando then FEmitentes.execute;

end;

procedure TFMain.FluxodeCaixa2Click(Sender: TObject);
begin
  if not Sistema.Processando then FFluxoCaixa.execute;

end;

procedure TFMain.ConciliaoBancria1Click(Sender: TObject);
begin
  if not Sistema.Processando then FConcbancaria.execute;

end;

procedure TFMain.Precos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FPrecos.execute;

end;

procedure TFMain.ListaPreos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelEstoque_ListaPreco;

end;

procedure TFMain.LotesBaia1Click(Sender: TObject);
/////////////////////////////////////////////////////////
begin

  if not Sistema.Processando then EntradaAbate_Execute('I',0,'LO');

end;

// 13.06.19
procedure TFMain.LotesFazenda1Click(Sender: TObject);
///////////////////////////////////////
begin

  if not Sistema.Processando then FRelGerenciais_Lotes;

end;

procedure TFMain.LotesFazResumo1Click(Sender: TObject);
/////////////////////////////////////////////////////////
begin

  if not Sistema.Processando then FRelGerenciais_LotesResumo;

end;

procedure TFMain.NotascomFinanceiro1Click(Sender: TObject);
begin
  if not Sistema.Processando then  FRelAuditorias_ChecaNotasFinan;

end;

procedure TFMain.ExtratoSinttico2Click(Sender: TObject);
begin
  if not Sistema.Processando then  FRelcxbancos_ExtratoSintetico;

end;

procedure TFMain.VendasAbaixoMnimo1Click(Sender: TObject);
begin
  if not Sistema.Processando then  FRelEstoque_VendasMinimo;

end;

procedure TFMain.AlteraoNotas1Click(Sender: TObject);
begin
  if not Sistema.Processando then  FAlteracaonotas.Execute;

end;

procedure TFMain.IncusaoAbateClick(Sender: TObject);
begin
  if not Sistema.Processando then EntradaAbate_Execute('I');

end;

procedure TFMain.AlteracaoAbateClick(Sender: TObject);
begin
  if not Sistema.Processando then EntradaAbate_Execute('A');

end;

procedure TFMain.EntradadeAbate1Click(Sender: TObject);
begin
    if not Sistema.Processando then FRelGerenciais_EntradadeAbate;

end;

procedure TFMain.EntradadeCupim1Click(Sender: TObject);
begin

  if not Sistema.Processando then FEntradadecupim.Execute;


end;

// 03.05.18
procedure TFMain.EntradaDesossaClick(Sender: TObject);
///////////////////////////////////////////////////////
begin

//  if not Sistema.Processando then FPesagemSaida.Execute('D');
  if not Sistema.Processando then FPesagemCamaraFria.Execute('D');

end;

procedure TFMain.Desossa1Click(Sender: TObject);
begin
//  if not Sistema.Processando then FDesossa.Execute;

end;

// 22.11.17
procedure TFMain.DesossaSaidaClick(Sender: TObject);
/////////////////////////////////////////////////////
begin

//  if not Sistema.Processando then FDesossa.Execute();
//  if not Sistema.Processando then FPesagemCamaraFria.Execute('D');

end;

procedure TFMain.Baias1Click(Sender: TObject);
//////////////////////////////////////////////////
begin

   if not Sistema.Processando then FBaias.Execute;

end;

procedure TFMain.BaixaAlmoxClick(Sender: TObject);
begin
  if not Sistema.Processando then FRequisicao.Execute;

end;

procedure TFMain.ExtratoCamarafriaClick(Sender: TObject);
begin
  if not Sistema.Processando then FRelEstoque_ExtratoCamarafria;

end;

procedure TFMain.BaixaProcessoparaAlmox1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRequisicao.Execute('E');

end;

procedure TFMain.Cortes1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelProducao_Cortes;

end;

procedure TFMain.Barras1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelProducao_Barras;

end;

procedure TFMain.ItensdaObra1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelProducao_ItensdaObra;

end;

procedure TFMain.JuntaPagamentos1Click(Sender: TObject);
//////////////////////////////////////////////////////////////
begin

    if not Sistema.Processando then  FJuntaPagamentos.Execute;


end;

procedure TFMain.Oramentos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FOrcamentos.Execute;

end;

procedure TFMain.ImpviaSintegra1Click(Sender: TObject);
begin
  if not Sistema.Processando then FImpsintegra.Execute;

end;

procedure TFMain.CortescomEstoque1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelProducao_CortescomEstoque;

end;

procedure TFMain.SaidaAbateInclusaoClick(Sender: TObject);
begin
  if not Sistema.Processando then EntradaAbate_Execute('I',0,'SA');

end;

procedure TFMain.SaidaAbateAlteracaoClick(Sender: TObject);
begin
  if not Sistema.Processando then EntradaAbate_Execute('A',0,'SA');

end;

procedure TFMain.ImpEstoqueDbf1Click(Sender: TObject);
begin
  if not Sistema.Processando then FDiversos.ImportaEstoqueDbf;

end;

procedure TFMain.SaidaAbate2Click(Sender: TObject);
begin
    if not Sistema.Processando then FRelGerenciais_EntradadeAbate(0,'','SA');

end;

procedure TFMain.Similares1Click(Sender: TObject);
begin
    if not Sistema.Processando then FSimilares.Execute;

end;

procedure TFMain.ConsumoMaterial1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelEstoque_Consumo;

end;

procedure TFMain.CurvaABCConsumo1Click(Sender: TObject);
begin
    if not Sistema.Processando then  FRelEstoque_ConsumoABC('C');

end;

procedure TFMain.CurvaABCEstoque1Click(Sender: TObject);
begin
    if not Sistema.Processando then  FRelEstoque_ConsumoABC('E');

end;

procedure TFMain.SemMovimento1Click(Sender: TObject);
begin
    if not Sistema.Processando then  FRelEstoque_SemMovimento;

end;

procedure TFMain.Setores1Click(Sender: TObject);
begin
  if not Sistema.Processando then FSetores.execute;

end;

procedure TFMain.AtaPlanosdeAo1Click(Sender: TObject);
begin
  if not Sistema.Processando then FAtaplanoacao.execute;

end;

procedure TFMain.ExclusoEtiquetas1Click(Sender: TObject);
//////////////////////////////////////////////////////////
begin

  if not Sistema.Processando then FExclusaoEtiqueta.execute;

end;

procedure TFMain.ExportacaoNFElet1Click(Sender: TObject);
begin
  if not Sistema.Processando then FExpNfetxt.execute;

end;

procedure TFMain.AlteracaoPlanoacao1Click(Sender: TObject);
begin
  if not Sistema.Processando then FAtaplanoacao.execute('A');

end;

procedure TFMain.RelPlanodeAcao1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelNaoConforme_PlanosdeAcao('A');

end;

procedure TFMain.RegistroNoConformidade1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRegNaoConformidade.execute('I');

end;

procedure TFMain.Registros1100e15001Click(Sender: TObject);
begin

  if not Sistema.Processando then FCreditosSped.execute;

end;

procedure TFMain.AlteracaoRegNaoConf1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRegNaoConformidade.execute('A');

end;

procedure TFMain.PlanosPendentes1Click(Sender: TObject);
begin
  if not Sistema.Processando then FPlanosPendentes.execute;

end;

procedure TFMain.PMsgClick(Sender: TObject);
begin
//  if global.Usuario.Codigo=100 then
//     if not Sistema.Processando then FEstoquez.Execute;

end;

procedure TFMain.RNCPendentes1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRegNaoConfPendentes.execute;

end;

procedure TFMain.FormCreate(Sender: TObject);
///////////////////////////////////////////////
begin
///////////////////
   Desabilitamenu;
end;
////////////////////

procedure TFMain.VendasComissoporGrupo1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelGerenciais_ComissoesporGrupo;

end;

procedure TFMain.CreditoMCbicos1Click(Sender: TObject);
begin
    if not Sistema.Processando then  FRelEstoque_CreditoMadeira;

end;

procedure TFMain.GeraoADRCST1Click(Sender: TObject);
/////////////////////////////////////////////////////
begin

  if not Sistema.Processando then FADRCST.Execute ;

end;

procedure TFMain.GeraoBoletos1Click(Sender: TObject);
begin
    if not Sistema.Processando then  FBoletos.Execute;

end;

// 27.06.17
procedure TFMain.GeraoNFServios1Click(Sender: TObject);
/////////////////////////////////////////////////////////
begin
  if not Sistema.processando then FExpNFSe.Execute;

end;

procedure TFMain.ModeObra1Click(Sender: TObject);
begin
    if not Sistema.Processando then  FCadServicos.Execute;

end;

procedure TFMain.TeleVendas1Click(Sender: TObject);
begin

    if not Sistema.Processando then  FTeleMarketing.Execute;

end;

procedure TFMain.TimerVendasCelularTimer(Sender: TObject);
////////////////////////////////////////////////////////////////
begin

   Sistema.beginprocess('Verificando pedidos m�vel');
   PMsg.Caption := 'Verificando pedidos m�vel';
   FDiversos.ImportaPedidos( Sistema.hoje,'S',PMsg );
// 02.02.23
   FDiversos.ImportaPedidos( Sistema.hoje-1,'S',PMsg );
   Delay(2500);
   Sistema.endprocess('');

end;

procedure TFMain.TiposNota1Click(Sender: TObject);
begin
    if not Sistema.Processando then  FTiposNotas.Execute;

end;

procedure TFMain.MaodeObraSaida1Click(Sender: TObject);
begin
    if not Sistema.Processando then  FNotaSaidaMo.Execute('I');

end;

procedure TFMain.PrevistoRealizado1Click(Sender: TObject);
begin
    if not Sistema.Processando then  FRelEstoque_PrevistoRealizado;           // 16

end;

procedure TFMain.ImpEstoqueviaTexto1Click(Sender: TObject);
begin
  if not Sistema.Processando then FDiversos.ImportaEstoqueTexto;

end;

procedure TFMain.ComissaoobreRecebido1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_Comissao;

end;

procedure TFMain.Indicadores1Click(Sender: TObject);
begin
  if not Sistema.Processando then FIndicadores.Execute;

end;

procedure TFMain.IndicadoresdeResultado1Click(Sender: TObject);
begin
  if not Sistema.Processando then FMovIndicadores.Execute;

end;

procedure TFMain.PontoRessuprimento1Click(Sender: TObject);
begin
  if not Sistema.Processando then  FRelEstoque_PontoRessuprimento;

end;

// 05.08.19
procedure TFMain.PorSetor1Click(Sender: TObject);
//////////////////////////////////////////////////////
begin
   if not Sistema.Processando then  FRelFinan_PorSetor
end;

procedure TFMain.IndicadoresdeResultado2Click(Sender: TObject);
begin
  if not Sistema.Processando then  FRelNaoConforme_IndicadorResultado;

end;

procedure TFMain.ComissoVendedores1Click(Sender: TObject);
begin
  if not Sistema.Processando then FTabelaComissao.Execute;

end;

procedure TFMain.ManutInventarioClick(Sender: TObject);
begin
  if not Sistema.Processando then FSaldoEstoque.Execute;

end;

procedure TFMain.ComposicaoEstoque1Click(Sender: TObject);
begin
  if not Sistema.Processando then FComposicao.Execute;

end;

procedure TFMain.NotadeReclassificao1Click(Sender: TObject);
begin
  if not Sistema.Processando then FComposicao.Execute('R');;

end;

procedure TFMain.RenumeraNotas1Click(Sender: TObject);
var sen:string;
begin
  if not input('Senha','Senha',sen,4,true) then exit;
  if sen<>'9598' then exit;
  if not Sistema.Processando then FDiversos.RenumeraNotasSaidaPeriodo;

end;

procedure TFMain.AuditoriaFisItens1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelGerenciais_AuditoriaFiscalItens;

end;

procedure TFMain.AvisodeCobrancaClick(Sender: TObject);
begin
  if not Sistema.Processando then  FEmailCobranca.Execute;

end;

procedure TFMain.ReservaAlmox1Click(Sender: TObject);
begin
  if not Sistema.Processando then  FRelEstoque_ReservaemObra;

end;

procedure TFMain.SaldoaEntregar1Click(Sender: TObject);
begin
  if not Sistema.Processando then  FRelFinan_SaldoaEntregar;       // 20

end;

procedure TFMain.EntradaProdutoAcabado1Click(Sender: TObject);
begin
  if not Sistema.Processando then FEntradaAcabado.Execute;

end;

procedure TFMain.Colaboradores1Click(Sender: TObject);
begin
  if not Sistema.Processando then FColaboradores.Execute;

end;

procedure TFMain.ValoresCentrosdeCusto1Click(Sender: TObject);
////////////////////////////////////////////////////////////////
begin

  if not Sistema.Processando then FCentroscusto.Execute;

end;

procedure TFMain.Veiculos1Click(Sender: TObject);
begin
    if not Sistema.Processando then FRelGerenciais_DespesasVeiculos;

end;

procedure TFMain.GerenciarNFe1Click(Sender: TObject);
begin
    if not Sistema.Processando then FGerenciaNfe.Execute;

end;

// 11.12.18
function TFMain.GetDicionario(Tabela, Campo: String): boolean;
//////////////////////////////////////////////////////////////////////
//var Q:TzQ;
begin
  {
  result:=false;
  Q:=SistemaZeos.sqltoquery('select * from dicionario where tabela = '+stringtosql(tabela)+
                            ' and campo = '+stringtosql(campo));
  result:= not Q.eof;
   Q.close;
  }

end;

procedure TFMain.AuditoriaBaseItens1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelGerenciais_AuditoriaFiscalBaseItens;

end;

procedure TFMain.NoConformidadePendente1Click(Sender: TObject);
begin
//  if not Sistema.Processando then FRelNaoConforme_Rncs;

end;

procedure TFMain.RelCarga1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelGerenciais_Carga;

end;

procedure TFMain.ImpContasGerenciais1Click(Sender: TObject);
begin
  if not Sistema.Processando then FDiversos.ImportaPlanoTexto;

end;

procedure TFMain.ConsignaoemAberto1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelGerenciais_ConsigAberto;

end;

procedure TFMain.InssNotaProdutor1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_InssNfProdutor;

end;

procedure TFMain.GeracaoSpedFiscal1Click(Sender: TObject);
begin
  if not Sistema.Processando then FSpedFiscal.Execute ;

end;

procedure TFMain.ComissoAbate1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelGerenciais_ComissoesEntradaAbate;

end;

// 17.06.19
procedure TFMain.ComissoBoiadeiros1Click(Sender: TObject);
///////////////////////////////////////////////////////////////////////////////
begin
  if not Sistema.Processando then FRelGerenciais_ComissoesBoiadeiros;

end;

// - 29.04.20
procedure TFMain.ComissaoMotoristas1Click(Sender: TObject);
/////////////////////////////////////////////////////////////
begin

  if not Sistema.Processando then FRelFinan_CargasKM;

end;

procedure TFMain.CodigoBarra1Click(Sender: TObject);
begin
  if not Sistema.Processando then FDiversos.CriaCodigoBarra;

end;

procedure TFMain.InfNutricionais1Click(Sender: TObject);
begin
  if not Sistema.Processando then FNutricionais.Execute ;

end;

procedure TFMain.Ingredientes1Click(Sender: TObject);
begin
  if not Sistema.Processando then FIngredientes.Execute ;

end;

procedure TFMain.Conservacao1Click(Sender: TObject);
begin
  if not Sistema.Processando then FConservacao.Execute ;

end;

procedure TFMain.PesagemPedido1Click(Sender: TObject);
begin
  if not Sistema.Processando then  FPesagemSaida.Execute();

end;

procedure TFMain.PesagemporCarga1Click(Sender: TObject);
begin

    if not Sistema.Processando then FPesagemporCarga.Execute;


end;

procedure TFMain.PesagemProdutor1Click(Sender: TObject);
begin
  if not Sistema.Processando then FPesagemCaminhao2.Execute;

end;

// 18.05.18
procedure TFMain.PesagemvivoincClick(Sender: TObject);
////////////////////////////////////////////////////////
begin
  if not Sistema.Processando then FPesagemEntrada.Execute('FA');   // pesagem vivo fazenda

end;

// 23.05.18
procedure TFMain.PesagemVivosClick(Sender: TObject);
///////////////////////////////////////////////////////
begin
   if not Sistema.Processando then FPesagemEntrada.Execute('FA');

end;

procedure TFMain.AlteraoFiscal1Click(Sender: TObject);
begin
  Avisoerro('Op��o Desativada');
//  if not Sistema.Processando then FNotaCompra.Execute('F');

end;

// 14.05.19
procedure TFMain.AlteraoLotesBaia1Click(Sender: TObject);
/////////////////////////////////////////////////////////////
begin

  if not Sistema.Processando then EntradaAbate_Execute('A',0,'LO');

end;

procedure TFMain.OpcoesEcfClick(Sender: TObject);
begin
  if not Sistema.Processando then Form1.ShowModal;

end;

procedure TFMain.CupomFiscal1Click(Sender: TObject);
begin
  if not Global.Topicos[1021] then
    Avisoerro('Sistema n�o habilitado para imprimir cupom fiscal')
 else if not Sistema.Processando then FGerenciaECF.Execute;

end;

procedure TFMain.LeitedaCrianca1Click(Sender: TObject);
/////////////////////////////////////////////////////////
var campos:string;
begin

    campos := 'clie_codigo,clie_nome,clie_cidade,clie_qtdediaria,clie_vezessegunda,'+
              'clie_vezesterca,clie_vezesquarta,clie_vezesquinta,clie_vezessexta';
    FConsulta.execute( 'clientes',campos,
                      'clie_codigo','where clie_tipo = ''J''  and clie_rgie = ''''' ,
                      'order by clie_nome','Litros para Entrega do Leite da Crian�a',
                      ' select '+campos+' from'+
                      ' clientes where clie_tipo = ''J'' and clie_codigo > 25000 and clie_rgie = '''''+
                      ' and clie_cnpjcpf <> '''''+
                      ' and clie_tran_codigo <> '''''+
                      ' order by clie_tran_codigo,clie_nome','L');

end;

procedure TFMain.LeituraX1Click(Sender: TObject);
begin
//  if not Sistema.Processando then FECFGeral.LeituraX;
  if not Sistema.Processando then Form1.LeituraX;

end;

procedure TFMain.ReducaoZClick(Sender: TObject);
///////////////////////////////////////////////////////////////
begin

  if not Global.Topicos[1021] then
    Avisoerro('Sistema n�o habilitado para imprimir cupom fiscal')
  else if not Sistema.Processando then Form1.ReducaoZ;

end;

procedure TFMain.ImpClientesTexto1Click(Sender: TObject);
begin
  if not Sistema.Processando then FDiversos.ImportaClientesTexto;

end;

procedure TFMain.CancelaCupom1Click(Sender: TObject);
begin

  if not Sistema.Processando then Form1.CancelaCupom;

end;

procedure TFMain.ConfiguraDemonstrativo1Click(Sender: TObject);
begin
  if not Sistema.Processando then FConfigDemo.Execute;

end;

procedure TFMain.DRE1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_DRE;

end;

procedure TFMain.GeracaoSpedPisCofins1Click(Sender: TObject);
begin
  if not Sistema.Processando then FSpedPisCofins.Execute ;

end;

procedure TFMain.ConfigImpPadro1Click(Sender: TObject);
begin
  if not Sistema.Processando then FDiversos.ConfImpressoraPadrao;

end;

procedure TFMain.AuditoriaFiscalCFOP1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelGerenciais_AuditoriaFiscalporCfop;

end;

procedure TFMain.batalho01Click(Sender: TObject);
//////////////////////////////////////////////////////
begin

//   BaixarPendncias1.Click
//  FBaixaPendencia.Execute;
//   Sender.Click
   batalho01.onclick:=Meuclick01;
end;

procedure TFMain.AtivaAtalho(natalho: string ; qual:TMenuItem);
////////////////////////////////////////////////
begin
   Patalhos.Visible:=true;
   Patalhos.Enabled:=true;
   if natalho='01' then begin
      MeuAtalho01:=qual;
      batalho01.Enabled:=true;
      batalho01.Caption:=DivideCaption( Qual.Caption );
   end else if natalho='02' then begin
      MeuAtalho02:=qual;
      batalho02.Enabled:=true;
      batalho02.Caption:=DivideCaption( Qual.Caption );
   end else if natalho='03' then begin
      MeuAtalho03:=qual;
      batalho03.Enabled:=true;
      batalho03.Caption:=DivideCaption( Qual.Caption );
   end else if natalho='04' then begin
      MeuAtalho04:=qual;
      batalho04.Enabled:=true;
      batalho04.Caption:=DivideCaption( Qual.Caption );
   end else if natalho='05' then begin
      MeuAtalho05:=qual;
      batalho05.Enabled:=true;
      batalho05.Caption:=DivideCaption( Qual.Caption );
   end else if natalho='06' then begin
      MeuAtalho06:=qual;
      batalho06.Enabled:=true;
      batalho06.Caption:=DivideCaption( Qual.Caption );
   end;
end;

// 25.06.12
function TFMain.DivideCaption(xCaption: string): string;
/////////////////////////////////////////////////////////////////
var p,x:integer;
    s,r:string;
begin
  s:=xCaption;r:='';
  for p:=1 to length(s) do begin
    x:=pos(' ',s);
    if x>0 then r:=r+copy(s,1,x-1)+#13
    else begin
      r:=r+s;
      break;
    end;
    s:=copy(s,x+1,length(s));
  end;
  result:=r;
end;

procedure TFMain.MeuClick01(Sender:TObject);
//////////////////////////////////////////////
begin
    MeuAtalho01.Click;
end;

function TFMain.AchaCaption(s: string; xMenu: TMenuItem) : TMenuItem;
///////////////////////////////////////////////////////////////////////
var p,r,i:integer;
begin

  result:=xMenu.Items[0];
  for p:=0 to xMenu.Count-1 do begin
    for r:=0 to xMenu.Items[p].Count-1 do begin
      for i:=0 to xMenu.Items[p].Items[r].Count-1 do begin
        if s=xMenu.Items[p].Items[r].Items[i].Name then begin
          result:=xMenu.Items[p].Items[r].Items[i];
          break;
        end;
      end;
    end;
  end;
end;


procedure TFMain.Agenda1Click(Sender: TObject);
begin
  if not Sistema.Processando then FAgendamento.Execute;

end;

procedure TFMain.MeuClick02(Sender: TObject);
begin
    MeuAtalho02.Click;

end;

procedure TFMain.MeuClick03(Sender: TObject);
begin
    MeuAtalho03.Click;

end;

procedure TFMain.MeuClick04(Sender: TObject);
begin
    MeuAtalho04.Click;

end;

procedure TFMain.MeuClick05(Sender: TObject);
begin
    MeuAtalho05.Click;

end;

procedure TFMain.MeuClick06(Sender: TObject);
begin
    MeuAtalho06.Click;

end;

procedure TFMain.batalho02Click(Sender: TObject);
begin
   batalho02.onclick:=Meuclick02;

end;

procedure TFMain.batalho03Click(Sender: TObject);
begin
   batalho03.onclick:=Meuclick03;

end;

procedure TFMain.batalho04Click(Sender: TObject);
begin
   batalho04.onclick:=Meuclick04;

end;

procedure TFMain.batalho05Click(Sender: TObject);
begin
   batalho05.onclick:=Meuclick05;

end;

procedure TFMain.batalho06Click(Sender: TObject);
begin
   batalho06.onclick:=Meuclick06;

end;

procedure TFMain.FaixasdeValores1Click(Sender: TObject);
begin
  if not Sistema.Processando then FFaixas.Execute;

end;

procedure TFMain.BaixarCarto1Click(Sender: TObject);
begin
  if not Sistema.Processando then FBaixaPendencia.Execute('Cartao');

end;

procedure TFMain.ContagemcomLeitor1Click(Sender: TObject);
begin
  if not Sistema.Processando then FAcertos.Execute(Global.CodContagemBalancoE,true);

end;

procedure TFMain.ImportaCTe1Click(Sender: TObject);
begin
  if not Sistema.Processando then FImportaXmlsCte.Execute;

end;

procedure TFMain.ImportaEstoqueXML1Click(Sender: TObject);
// 27.08.18
begin

  if not Sistema.Processando then FDiversos.ImportaXml;

end;

procedure TFMain.VendaBalco1Click(Sender: TObject);
begin
  if not Sistema.Processando then FVendaBalcao.Execute;

end;

procedure TFMain.ChequesEmitidos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FCadcheques.Execute('',0,0,0,0,'E');

end;

procedure TFMain.ChequeRecebidos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_PosicaoCheques('R'); ;

end;

procedure TFMain.ChequeEmitidos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_PosicaoCheques('E'); ;

end;

// 04.05.13
procedure TFMain.LimiteDisponvel1Click(Sender: TObject);
/////////////////////////////////////////////////////////
begin
  if not Sistema.Processando then FRelCadastros_LimiteDisponivel;

end;

procedure TFMain.TransacoesduplicadasClick(Sender: TObject);
begin
  if not Sistema.Processando then FDiversos.TransacoesDuplicadas;

end;

procedure TFMain.x(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

end;

procedure TFMain.RemCompraGarantida1Click(Sender: TObject);
begin
// 17.06.13
  if not Sistema.Processando then Remessa_Execute('I','G');

end;

procedure TFMain.ImpaReceberTexto1Click(Sender: TObject);
begin
  if not Sistema.Processando then FDiversos.ImportaAReceberTexto;

end;

procedure TFMain.Equipamentos1Click(Sender: TObject);
/////////////////////////////////////////////////////////
begin
    if not Sistema.Processando then FEquipamentos.Execute;
end;

// 16.11.20
procedure TFMain.EstoqueCamaraFria1Click(Sender: TObject);
///////////////////////////////////////////////////////////////
begin

  if not Sistema.Processando then FRelEstoque_EstoqueCamarafria;

end;

procedure TFMain.InclusaomanutencaoClick(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin
  if not Sistema.Processando then FFichaTecnica.Execute('I');

end;

procedure TFMain.AlteracaomanutencaoClick(Sender: TObject);
///////////////////////////////////////////////////////////////
begin
  if not Sistema.Processando then FFichaTecnica.Execute('A');

end;

// 30.09.13
procedure TFMain.FazendainclusaoClick(Sender: TObject);
///////////////////////////////////////////////////////
begin
  if not Sistema.Processando then EntradaAbate_Execute('I',0,'FA');

end;

procedure TFMain.FazendaalteracaoClick(Sender: TObject);
/////////////////////////////////////////////////////////
begin
  if not Sistema.Processando then EntradaAbate_Execute('A',0,'FA');

end;

procedure TFMain.Fazenda2Click(Sender: TObject);
////////////////////////////////////////////////////
begin
    if not Sistema.Processando then FRelGerenciais_EntradadeAbate(0,'','FA');

end;

procedure TFMain.NotasequipamentosClick(Sender: TObject);
begin
///////////////////////////////////////
      if not Sistema.Processando then FRelProducao_NotasFichaTecnica;
end;

procedure TFMain.FichatecnicaClick(Sender: TObject);
///////////////////////////////////////////////////////////
begin
      if not Sistema.Processando then FRelProducao_FichaTecnica;

end;

procedure TFMain.PrximasTrocas1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelProducao_ProximasTrocas;

end;

procedure TFMain.PosicaoApropriacoes1Click(Sender: TObject);
///////////////////////////////////////////////////////////////////
begin

  if not Sistema.Processando then FRelFinan_PosicaoApro;


end;

procedure TFMain.PosicaoEstoqueporPeso1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelEstoque_PosicaoEstoqueemPeso;

end;

procedure TFMain.AbreForm(nome: string);
///////////////////////////////////////////////
var i:integer;
begin
  if Global.UltimoFormAberto='' then exit;
  for i := 0 to Screen.FormCount - 1 do  // qtde de form na tela.
  begin
//    if AnsiLowerCase(Screen.Forms[i].Name) = AnsiLowerCase(nome) then  // se o form estiver na tela.
    if AnsiLowerCase(Screen.Forms[i].Name) = AnsiLowerCase(Global.UltimoFormAberto) then begin
//    if Screen.Forms[i].Focused then  // se o form estiver visivel
//      if FindWindow( FGeral.StrToPChar(Screen.Forms[i].classname) ,PAnsichar( Global.UltimoFormAberto ) ) >0 then
      if FindWindow( FGeral.StrToPChar(Screen.Forms[i].classname) ,nil ) >0 then begin
          ( Screen.Forms[i] ).BringToFront;
      end;
    end;
  end;
end;


procedure TFMain.MediaConsumo1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelProducao_MediaConsumo;

end;

procedure TFMain.ConsignacaomenuDrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
//////////////////////////////////////////////////////////////////////////////
var M: TMenuItem;
begin

  if not Sistema.Processando then begin
    M := TMenuItem(Sender);
    with ACanvas do
    begin
  //    if Selected then
  //    begin
  //    Brush.Color := clHighLight;
  //    Brush.Color := clBtnShadow;
     // 13.10.2021 - ver se usar arquivo texto para 'personalizar' o menu
     //              colocando nele o 'name' e o caption q se queria colocar
      if Sender is TMenuItem then begin

//         if TMenuItem( Sender ).Name = 'PedidosVenda1' then  TMenuItem( Sender ).Caption := 'Teste';

      end;


      if Fgeral.getconfig1asinteger('TAMMENU')=0 then
        Font.Size := Font.Size + 06 // increase font size
      else
        Font.Size := Font.Size + Fgeral.getconfig1asinteger('TAMMENU');
      Font.Name := 'Comic Sans';
      if Fgeral.getconfig1asstring('CORMENU')='' then
        Font.Color := clblue
      else
        Font.Color := StringToColor( Fgeral.getconfig1asstring('CORMENU') );

      FillRect(ARect);
      inc(ARect.Left,6);
  //    DrawText(Handle, PChar(M.Caption), Length(M.Caption), ARect,DT_SINGLELINE+ DT_LEFT+DT_VCENTER);
      DrawText(Handle, PChar(M.Caption), Length(M.Caption), ARect,DT_SINGLELINE+ DT_LEFT+DT_VCENTER );
    end;
  end;
end;

procedure TFMain.cmvproducaoClick(Sender: TObject);
///////////////////////////////////////////////////////////
begin
  if not Sistema.Processando then FRelProducao_CMVporPVOS;

end;

procedure TFMain.BaixarporConta1Click(Sender: TObject);
///////////////////////////////////////////////////////////
begin
  if not Sistema.Processando then FBaixaPendencia.Execute('Conta');

end;

procedure TFMain.BalancaClick(Sender: TObject);
///////////////////////////////////////////////////
begin

   if FChecaBalanca=nil then FGeral.CreateForm(TFChecaBalanca,FChecaBalanca) ;

      FChecaBalanca.Execute('S');

end;

procedure TFMain.GerenciaMDFe1Click(Sender: TObject);
////////////////////////////////////////////////////////////
begin

     if not Sistema.Processando then FGerenciaMdf.execute;;

end;

procedure TFMain.GerenciarCTe1Click(Sender: TObject);
begin
    if not Sistema.Processando then FGerenciaCTe.Execute;

end;

procedure TFMain.AnliseVendaCliente1Click(Sender: TObject);
begin

    if not Sistema.Processando then FRelGerenciais_AnaliseVendasporCliente;

end;

procedure TFMain.ExportaEstoqueMovel1Click(Sender: TObject);
begin
    if not Sistema.Processando then  FDiversos.ExpCadastroMovelEstoque;
end;

procedure TFMain.ExportaPortadoresCondPagto1Click(Sender: TObject);
begin
    if not Sistema.Processando then  FDiversos.ExpCadastroMovelPortadores;

end;

procedure TFMain.ExportaClientesMovel1Click(Sender: TObject);
begin
  if not Sistema.Processando then  FDiversos.ExpCadastroMovelClientes;

end;

procedure TFMain.ImportaPedidosMvel1Click(Sender: TObject);
begin
    if not Sistema.Processando then FDiversos.ImpPedidosMovel;

end;

procedure TFMain.ImpostosRetidos1Click(Sender: TObject);
begin
// 02.10.18
  if not Sistema.Processando then FRelFinan_ImpostosRetidosNFServicos;

end;

// 30.04.20
procedure TFMain.PagamentoEletrnico1Click(Sender: TObject);
////////////////////////////////////////////////////////////
begin

    if not Sistema.Processando then  FPagamentos.Execute;

end;

procedure TFMain.PagamentoLeiteClick(Sender: TObject);
/////////////////////////////////////////////////////////
begin
  if not Sistema.Processando then FPagamentoleite.Execute;

end;

// 13.05.15
procedure TFMain.PagamentoMerenda1Click(Sender: TObject);
//////////////////////////////////////////////////////////
begin
  if not Sistema.Processando then FPagamentoleite.Execute(Global.codcompraprodutormerenda);

end;

procedure TFMain.ImportaNFes1Click(Sender: TObject);
begin
  if not Sistema.Processando then FImportaNfe.Execute;

end;


// 12.03.19
procedure TFMain.ImportaNFSe1Click(Sender: TObject);
//////////////////////////////////////////////////////
begin
  if not Sistema.Processando then FImportaNfSe.Execute;

end;

// 08.02.2023
procedure TFMain.ImportacaoOFXClick(Sender: TObject);
begin

   if not Sistema.Processando then FImportaofx.Execute;

end;

procedure TFMain.ResumoDiario1Click(Sender: TObject);
begin
   if not Sistema.Processando then FRelCxBancos_RecebimentoDiario;
end;

procedure TFMain.Pesagem1Click(Sender: TObject);
////////////////////////////////////////////////
begin
   FPesagemEntrada.Execute;
end;

// 06.04.18 - inclui novo romaneio informando por brinco nova pesagem
procedure TFMain.InfopesagemClick(Sender: TObject);
/////////////////////////////////////////////////
begin

  if not Sistema.Processando then EntradaAbate_Execute('I',0,'FM');

end;

procedure TFMain.InformeIRProdutor1Click(Sender: TObject);
////////////////////////////////////////////////////////
begin

  if not Sistema.Processando then FRelFinan_InformeIRProdutor;

end;

procedure TFMain.PedidosFaturados1Click(Sender: TObject);
/////////////////////////////////////////////////////////////
begin
  if not Sistema.Processando then FRelFinan_PedidosFaturados;

end;


// 10.10.15 - versao do Fortes Report

procedure TFMain.ImportaContagemEstoque1Click(Sender: TObject);
begin
  if not Sistema.Processando then FDiversos.ImportaContagemTexto;

end;

// 22.02.16 - para melhor visualizar o menu...
procedure TFMain.MovimentosMeasureItem(Sender: TObject; ACanvas: TCanvas;
  var Width, Height: Integer);
//////////////////////////////////////////////////////////////////////////////////////
begin


    with ACanvas.Font do
    begin
  //    Name := 'Times New Roman';
  //    Name := 'Comic Sans';
  //    Color := clBlue;
  //    Size := 20;
      Size := Size + 05 ;
      Style := [fsItalic, fsBold];
    end;

    Width := ACanvas.TextWidth((Sender as TMenuItem).Caption) + 10;
    Height := ACanvas.TextHeight((Sender as TMenuItem).Caption) + 5;


end;

procedure TFMain.Montagem1Click(Sender: TObject);
/////////////////////////////////////////////////////
begin
  if not Sistema.Processando then FMontaCarga.Execute('M');

end;

// 22.10.19
procedure TFMain.MontagemcomCTe1Click(Sender: TObject);
//////////////////////////////////////////////////////////
begin
  if not Sistema.Processando then FMontaCargaCte.Execute('X');

end;

procedure TFMain.PesagemCaminhao2Click(Sender: TObject);
begin
/////////////////////////////////////////////////////
  if not Sistema.Processando then FPesagemCaminhao.Execute;

end;

// 20.03.16
procedure TFMain.ImpClientesFornecFB1Click(Sender: TObject);
////////////////////////////////////////////////////////////////
begin
  if not Sistema.Processando then FDiversos.ImportaFireBird;

end;

procedure TFMain.EntradaAbate1Click(Sender: TObject);
begin

end;

// 07.06.16
procedure TFMain.PesagemCortes1Click(Sender: TObject);
//////////////////////////////////////////////////////////
begin
   FPesagemCamaraFria.Execute;

end;

procedure TFMain.PesagemDevoluo1Click(Sender: TObject);
begin
  if not Sistema.Processando then FPesagemDevolucao.Execute;

end;

procedure TFMain.SaidaDesossaClick(Sender: TObject);
begin

//  if not Sistema.Processando then FEmbalagemDesossa.Execute;

  if not Sistema.Processando then FSaidaDesossa.Execute;

end;

procedure TFMain.RastreamentoProdutos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelEstoque_RastreamentoProduto;          // 20

end;

procedure TFMain.RastreamentoVendas1Click(Sender: TObject);
/////////////////////////////////////////////////////////////
begin
  if not Sistema.Processando then FRelEstoque_RastreamentoVendas;          // 21

end;

procedure TFMain.Carregados1Click(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_Carregados;

end;

// 22.05.20
procedure TFMain.CentrosdeCusto1Click(Sender: TObject);
///////////////////////////////////////////////////////////
begin

  if not Sistema.Processando then FCcustos.Execute;

end;

// 04.07.16
procedure TFMain.VerificaoPeso1Click(Sender: TObject);
////////////////////////////////////////////////////////
begin
  if not Sistema.Processando then FMontaCarga.Execute('V');

end;

procedure TFMain.Brincos1Click(Sender: TObject);
begin
  if not Sistema.Processando then FBrincos.Execute;
end;

// 24.10.16
procedure TFMain.GeracaoCTe1Click(Sender: TObject);
////////////////////////////////////////////////////
begin
  if not Sistema.processando then FExpCte.Execute;
end;

// 17.02.2021
procedure TFMain.GeracaoDmed1Click(Sender: TObject);
///////////////////////////////////////////////////////
begin

  if not Sistema.processando then FGeraDmed.Execute;

end;

Initialization
//RLConsts.SetVersion(3,72,'B');

end.


program Sacxe7;
// 12.08.20 - 02.02.2022
{$I Sac.inc}
//{$DEFINE WHATSAPP}

uses
  Forms,
  uTInject.ConfigCEF,
  acertoses in 'acertoses.pas' {FAcertos},
  Ajsalfin in 'Ajsalfin.pas' {FAjusteSaldosFin},
  Ajustees in 'Ajustees.pas' {FAjustesaldos},
  alteracxa in 'alteracxa.pas' {FAlteracaixa},
  Alterapen in 'Alterapen.pas' {FAlteraPendencia},
  sqlrel in 'C:\Delphi\VCL101\sql\sqlrel.pas' {FRel},
  SQLExpr in 'C:\Delphi\VCL101\sql\SQLExpr.pas',
  SqlFun in 'C:\Delphi\VCL101\sql\SqlFun.pas',
  sqlgrid in 'C:\Delphi\VCL101\sql\sqlgrid.pas',
  Confdcto in 'C:\Delphi\VCL101\sql\Confdcto.pas' {FConfDcto},
  TextRel in 'C:\Delphi\VCL101\sql\TextRel.pas' {FTextRel},
  sqled in 'C:\Delphi\VCL101\sql\sqled.pas',
  Arquiv in 'Arquiv.pas' {Arq: TDataModule},
  Baixache in 'Baixache.pas' {FBaixacheques},
  baixacob in 'baixacob.pas' {FBaixaCobranca},
  BaixaPen in 'BaixaPen.pas' {FBaixaPendencia},
  BxMenTem in 'BxMenTem.pas' {FBaixaVendaTemporaria},
  Cadcheq in 'Cadcheq.pas' {FCadcheques},
  cadcli in 'cadcli.pas' {FCadcli},
  cadcopa in 'cadcopa.pas' {FCopas},
  cadcor in 'cadcor.pas' {FCores},
  Cadimp in 'Cadimp.pas' {FCadimp},
  cadocor in 'cadocor.pas' {FCadOcorrencias},
  Canctrans in 'Canctrans.pas' {FCanctransacao},
  codigosfis in 'codigosfis.pas' {FCodigosFiscais},
  codigosipi in 'codigosipi.pas' {FCodigosipi},
  Configura in 'Configura.PAS' {FConfigura},
  ConfMovi in 'ConfMovi.pas' {FConfMovimento},
  confplano in 'confplano.pas' {FConfPlano},
  conpagto in 'conpagto.pas' {FCondpagto},
  Cotarepr in 'Cotarepr.pas' {FCotasRepr},
  custos in 'custos.pas' {FComposicao},
  dadosgrade in 'dadosgrade.pas' {FDadosgrade},
  diversos in 'diversos.pas' {FDiversos},
  Emitentes in 'Emitentes.pas' {FEmitentes},
  EMPRESAS in 'EMPRESAS.PAS' {FEmpresas},
  Estoque in 'Estoque.pas' {FEstoque},
  expcxban in 'expcxban.pas' {FExpcaixaban},
  expfiswin in 'expfiswin.pas' {FExpFiscalWin},
  expnfpra in 'expnfpra.pas' {FExpNFprazo},
  familias in 'familias.pas' {FFamilias},
  feriados in 'feriados.pas' {FFeriados},
  fornece in 'fornece.pas' {FFornece},
  geral in 'geral.pas' {FGeral},
  Grades in 'Grades.pas' {FGrades},
  grupos in 'grupos.pas' {FGrupos},
  GrUsu in 'GrUsu.pas' {FGrUsuarios},
  Hist in 'Hist.pas' {FHistoricos},
  impressao in 'impressao.pas' {FImpressao},
  INIT in 'INIT.PAS' {FInit},
  lancamfin in 'lancamfin.pas' {FLancaMovfin},
  Lancapen in 'Lancapen.pas' {FLancaPendencia},
  material in 'material.pas' {FMaterial},
  Mensnf in 'Mensnf.pas' {FMensNotas},
  Menuinicial in 'Menuinicial.pas' {FMain},
  Moedas in 'Moedas.pas' {FMoedas},
  Montakit in 'Montakit.pas' {FMontagemkit},
  motivobl in 'motivobl.pas' {FMotivosBloq},
  munic in 'munic.pas' {FCidades},
  Natureza in 'Natureza.PAS' {FNatureza},
  nfcompra in 'nfcompra.pas' {FNotaCompra},
  nfsaidamo in 'nfsaidamo.pas' {FNotaSaidaMo},
  nftransf in 'nftransf.pas' {FNotaTransf},
  OCORRENC in 'OCORRENC.PAS' {FOcorrencias},
  Orcamento in 'Orcamento.pas' {FOrcamento},
  Pedcomp in 'Pedcomp.pas' {FPedcompra},
  Pedvenda in 'Pedvenda.pas' {FPedVenda},
  pesquisa in 'pesquisa.pas' {FPesquisa01},
  plano in 'plano.pas' {FPlano},
  portador in 'portador.pas' {FPortadores},
  Pospedi in 'Pospedi.pas' {FPosicaoPedidoVenda},
  prepedido in 'prepedido.pas' {FPrepedidos},
  Regioes in 'Regioes.pas' {FRegioes},
  rel_compras in 'rel_compras.pas' {FRelcompras},
  relaudit in 'relaudit.pas' {FRelAuditorias},
  relcadas in 'relcadas.pas' {FRelcadastros},
  relcxban in 'relcxban.pas' {FRelcxbancos},
  relestoque in 'relestoque.pas' {FRelEstoque},
  relfinan in 'relfinan.pas' {FRelFinan},
  RelGerenciais in 'RelGerenciais.pas' {FRelGerenciais},
  Relmalote in 'Relmalote.pas' {FRelMalote},
  Remproen in 'Remproen.pas' {FRemProntaEntrega},
  represen in 'represen.pas' {FRepresentantes},
  retroman in 'retroman.pas' {FRetRomaneio},
  sintegra in 'sintegra.pas' {FSintegra},
  Sittribu in 'Sittribu.pas' {FSittributaria},
  Subgrupos in 'Subgrupos.pas' {FSubgrupos},
  tabela in 'tabela.pas' {FTabela},
  tamanhos in 'tamanhos.pas' {FTamanhos},
  transfcon in 'transfcon.pas' {FTransContas},
  transfes in 'transfes.pas' {FTransSaldos},
  Transp in 'Transp.pas' {FTransp},
  Transrem in 'Transrem.pas' {FTransfrem},
  Unidades in 'Unidades.pas' {FUnidades},
  usuarios in 'usuarios.pas' {FUsuarios},
  Fluxocaixa in 'Fluxocaixa.pas' {FFluxoCaixa},
  concbanc in 'concbanc.pas' {FConcbancaria},
  precos in 'precos.pas' {FPrecos},
  alteranota in 'alteranota.pas' {FAlteracaonotas},
  entabate in 'entabate.pas' {FEntradaabate},
  desossa in 'desossa.pas' {FDesossa},
  requisicao in 'requisicao.pas' {FRequisicao},
  relproducao in 'relproducao.pas' {FRelProducao},
  cadorcam in 'cadorcam.pas' {FOrcamentos},
  impsintegra in 'impsintegra.pas' {FImpSintegra},
  remessa in 'remessa.pas' {FRemessa},
  similares in 'similares.pas' {FSimilares},
  reciboavulso in 'reciboavulso.pas' {FReciboavulso},
  expnfetxt in 'expnfetxt.pas' {FExpNfetxt},
  gerencianfe in 'gerencianfe.pas' {FGerenciaNfe},
  setores in 'setores.pas' {FSetores},
  ataspacao in 'ataspacao.pas' {FAtaplanoacao},
  relnaoconfor in 'relnaoconfor.pas' {FRelNaoConf},
  regnaoconf in 'regnaoconf.pas' {FRegNaoConformidade},
  formacaopreco in 'formacaopreco.pas' {FFormacaoPreco},
  planospendentes in 'planospendentes.pas' {FPlanosPendentes},
  regnaoconfpend in 'regnaoconfpend.pas' {FRegNaoConfPendentes},
  cadservicos in 'cadservicos.pas' {FCadServicos},
  tiposnotas in 'tiposnotas.pas' {FTiposNotas},
  nfsaida in 'nfsaida.pas' {FNotaSaida},
  indicadores in 'indicadores.pas' {FIndicadores},
  movindicadores in 'movindicadores.pas' {FMovIndicadores},
  tabcomissao in 'tabcomissao.pas' {FTabelaComissao},
  saldoestoque in 'saldoestoque.pas' {FSaldoEstoque},
  EntradaAcabado in 'EntradaAcabado.pas' {FEntradaAcabado},
  pendenciaspendentes in 'pendenciaspendentes.pas' {FPendenciasPendentes},
  colaboradores in 'colaboradores.pas' {FColaboradores},
  Mostraxml in 'Mostraxml.pas' {FMostraXml},
  RetConsi in 'RetConsi.pas' {FRetConsig},
  retproennovo in 'retproennovo.pas' {FRetprontaentreganovo},
  listaimagens in 'listaimagens.pas' {FListaFiguras},
  nutricionais in 'nutricionais.pas' {FNutricionais},
  ingredientes in 'ingredientes.pas' {FIngredientes},
  conservacao in 'conservacao.pas' {FConservacao},
  consulta in 'consulta.pas' {FConsulta},
  pesagemsaida in 'pesagemsaida.pas' {FPesagemSaida},
  consultawebsernfe in 'consultawebsernfe.pas' {FSiteWebservices},
  spedfiscal in 'spedfiscal.pas' {FSpedFiscal},
  configdemo in 'configdemo.pas' {FConfigDemo},
  spedpiscofins in 'spedpiscofins.pas' {FSpedPisCofins},
  faixas in 'faixas.pas' {FFaixas},
  vendabalcao in 'vendabalcao.pas' {FVendaBalcao},
  equipamentos in 'equipamentos.pas' {FEquipamentos},
  fichatecnica in 'fichatecnica.pas' {FFichatecnica},
  mostravalorafaturar in 'mostravalorafaturar.pas' {FValoraFaturar},
  pagamentoleite in 'pagamentoleite.pas' {FPagamentoLeite},
  principal in 'ACbr\RecuperarXML\principal.pas' {FBuscaXmlSefa},
  ACBrHTMLtoXML in 'ACbr\RecuperarXML\ACBrHTMLtoXML.pas',
  boletos in 'boletos.pas' {FBoletos},
  rateio in 'rateio.pas' {FRateio},
  importanfe in 'importanfe.pas' {FImportaNfe},
  pesagementrada in 'pesagementrada.pas' {FPesagemEntrada},
  ACBrDANFCeFortesFrA4 in 'ACbr\ACBrDANFCeFortesFrA4.pas' {frmACBrDANFCeFortesFrA4},
  TBPRN in 'Funcoes\TBPRN.PAS',
  pesagemcaminhao in 'pesagemcaminhao.pas' {FPesagemCaminhao},
  vencervalidade in 'vencervalidade.pas' {FValidadeVencendo},
  pesagemcamarafria in 'pesagemcamarafria.pas' {FPesagemCamaraFria},
  ACBrDANFCeFortesFrETQEA in 'ACbr\ACBrDANFCeFortesFrETQEA.pas' {frmACBrDANFCeFortesFrETQEA},
  ImportaCte in 'ImportaCte.pas' {FImportaXmlsCte},
  brincos in 'brincos.pas' {FBrincos},
  gerenciacte in 'gerenciacte.pas' {FGerenciaCte},
  expcte in 'expcte.pas' {FExpCte},
  pesagemcaminhao2 in 'pesagemcaminhao2.pas' {FPesagemCaminhao2},
  ACBrDANFCeFortesFrPC in 'ACbr\ACBrDANFCeFortesFrPC.pas' {frmACBrDANFCeFortesFrPC},
  ACBrDANFCeFortesFrEA in 'ACbr\ACBrDANFCeFortesFrEA.pas' {frmACBrDANFCeFortesFrEA},
  agenda in 'agenda.pas' {FAgendamento},
  expnfse in 'expnfse.pas' {FExpNfse},
  nfedestinadas in 'nfedestinadas.pas' {FNfeDestinadas},
  pesagemdevolucao in 'pesagemdevolucao.pas' {FPesagemDevolucao},
  ECFTeste1 in 'ACbr\Ecf\ECFTeste1.pas' {Form1},
  VendeItem in 'ACbr\Ecf\VendeItem.pas' {frVendeItem},
  EfetuaPagamento in 'ACbr\Ecf\EfetuaPagamento.pas' {frPagamento},
  Relatorio in 'ACbr\Ecf\Relatorio.pas' {frRelatorio},
  ConfiguraSerial in 'ACbr\Ecf\ConfiguraSerial.pas' {frConfiguraSerial},
  RelatorioGerencialFormatado in 'ACbr\Ecf\RelatorioGerencialFormatado.pas' {frmGerencialFormatado},
  uDAV in 'ACbr\Ecf\uDAV.pas' {frmDAV},
  uDAVOS in 'ACbr\Ecf\uDAVOS.pas' {frmDAVOS},
  gerenciaecf in 'gerenciaecf.pas' {FGerenciaECF},
  EmbalagemDesossa in 'EmbalagemDesossa.pas' {FEmbalagemDesossa},
  Periodos in 'Periodos.pas' {FPeriodos},
  pesagemporcarga in 'pesagemporcarga.pas' {FPesagemporCarga},
  impressaoop in 'impressaoop.pas' {FImpressaoOP},
  saidadesossa in 'saidadesossa.pas' {FSaidaDesossa},
  ACBrDANFCeFortesFrETQdes in 'ACbr\ACBrDANFCeFortesFrETQdes.pas' {frmACBrDANFCeFortesFrETQdes},
  telemarketing in 'telemarketing.pas' {FTeleMarketing},
  importanfse in 'importanfse.pas' {fImportaNFSe},
  baias in 'baias.pas' {FBaias},
  creditosspedcontirb in 'creditosspedcontirb.pas' {FCreditosSped},
  gerenciamdfe in 'gerenciamdfe.pas' {FGerenciaMdf},
  ACBrDANFCeFortesFrETQEST in 'ACbr\ACBrDANFCeFortesFrETQEST.pas' {frmACBrDANFCeFortesFrETQEST},
  montagemcarga in 'montagemcarga.pas' {FMontaCarga},
  ACBrDANFCeFortesFrETQFATadapar in 'ACbr\ACBrDANFCeFortesFrETQFATadapar.pas' {frmACBrDANFCeFortesFrETQFATadapar},
  ACBrDANFCeFortesFrETQFAT in 'ACbr\ACBrDANFCeFortesFrETQFAT.pas' {frmACBrDANFCeFortesFrETQFAT},
  montagemcargacte in 'montagemcargacte.pas' {FMontaCargaCte},
  checabalanca in 'checabalanca.pas' {FChecabalanca},
  gerapdf in 'gerapdf.pas' {FGeraPdf},
  adrcst in 'adrcst.pas' {Fadrcst},
  pagamentos in 'pagamentos.pas' {FPagamentos},
  baixapagamentos in 'baixapagamentos.pas' {FBaixaPagamentos},
  centroscusto in 'centroscusto.pas' {FCentrosCusto},
  cadccustos in 'cadccustos.pas' {FCCustos},
  visualizaimp in 'visualizaimp.pas' {FVisualizaImpressao},
  entradadecupim in 'entradadecupim.pas' {FEntradadecupim},
  {$IFDEF WHATSAPP}
  gerenciawhats in 'gerenciawhats.pas',
  {$ENDIF }
  juntapagamentos in 'juntapagamentos.pas' {FJuntaPagamentos},
  contratos in 'contratos.pas' {FContratos},
  geramdfe in 'geramdfe.pas' {FGeraMdfe},
  exclusaoetiq in 'exclusaoetiq.pas' {FExclusaoEtiqueta},
  lenfeemail in 'lenfeemail.pas' {FLenfeemail},
  verificasessaots in 'verificasessaots.pas',
  geradmed in 'geradmed.pas' {FGeraDmed},
  calibracoes in 'calibracoes.pas' {FCalibracoes},
  contratosatu in 'contratosatu.pas' {FContratoatu},
  emailcobranca in 'emailcobranca.pas' {FEmailcobranca},
  importaofx in 'importaofx.pas' {FImportaOFX},
  tributacaoncm in 'tributacaoncm.pas' {FTributacaoncm};

///  ACBrNFeDANFeRLRetratorm in 'ACbr\ACBrNFeDANFeRLRetratorm.pas',
//  ACBrNFeDANFeRLClass in 'ACbr\ACBrNFeDANFeRLClass.pas';

{$R *.res}

begin

// 12.08.20
//  if FileExists( 'ConfTInject.ini' ) then begin
  {$IFDEF WHATSAPP}

     If not GlobalCEFApp.StartMainProcess then
        Exit;

  {$ENDIF};


  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TArq, Arq);
  Application.CreateForm(TFInit, FInit);
  Application.CreateForm(TFGeral, FGeral);
  Application.CreateForm(TFRel, FRel);
  Application.CreateForm(TFConfDcto, FConfDcto);
  Application.CreateForm(TFTextRel, FTextRel);
  Application.CreateForm(TFAcertos, FAcertos);
  Application.CreateForm(TFAjusteSaldosFin, FAjusteSaldosFin);
  Application.CreateForm(TFAjustesaldos, FAjustesaldos);
  Application.CreateForm(TFAlteracaixa, FAlteracaixa);
  Application.CreateForm(TFAlteraPendencia, FAlteraPendencia);
  Application.CreateForm(TFBaixaCobranca, FBaixaCobranca);
  Application.CreateForm(TFBaixaPendencia, FBaixaPendencia);
  Application.CreateForm(TFBaixaVendaTemporaria, FBaixaVendaTemporaria);
  Application.CreateForm(TFCadcheques, FCadcheques);
  Application.CreateForm(TFCadcli, FCadcli);
  Application.CreateForm(TFCopas, FCopas);
  Application.CreateForm(TFCores, FCores);
  Application.CreateForm(TFCadimp, FCadimp);
  Application.CreateForm(TFCadOcorrencias, FCadOcorrencias);
  Application.CreateForm(TFCanctransacao, FCanctransacao);
  Application.CreateForm(TFCodigosFiscais, FCodigosFiscais);
  Application.CreateForm(TFCodigosipi, FCodigosipi);
  Application.CreateForm(TFConfigura, FConfigura);
  Application.CreateForm(TFConfMovimento, FConfMovimento);
  Application.CreateForm(TFConfPlano, FConfPlano);
  Application.CreateForm(TFCondpagto, FCondpagto);
  Application.CreateForm(TFCotasRepr, FCotasRepr);
  Application.CreateForm(TFComposicao, FComposicao);
  Application.CreateForm(TFDadosgrade, FDadosgrade);
  Application.CreateForm(TFDiversos, FDiversos);
  Application.CreateForm(TFEmitentes, FEmitentes);
  Application.CreateForm(TFEmpresas, FEmpresas);
  Application.CreateForm(TFEstoque, FEstoque);
  Application.CreateForm(TFExpcaixaban, FExpcaixaban);
  Application.CreateForm(TFExpFiscalWin, FExpFiscalWin);
  Application.CreateForm(TFExpNFprazo, FExpNFprazo);
  Application.CreateForm(TFFamilias, FFamilias);
  Application.CreateForm(TFFeriados, FFeriados);
  Application.CreateForm(TFFornece, FFornece);
  Application.CreateForm(TFGrades, FGrades);
  Application.CreateForm(TFGrupos, FGrupos);
  Application.CreateForm(TFGrUsuarios, FGrUsuarios);
  Application.CreateForm(TFHistoricos, FHistoricos);
  Application.CreateForm(TFImpressao, FImpressao);
  Application.CreateForm(TFLancaMovfin, FLancaMovfin);
  Application.CreateForm(TFLancaPendencia, FLancaPendencia);
  Application.CreateForm(TFMaterial, FMaterial);
  Application.CreateForm(TFMensNotas, FMensNotas);
  Application.CreateForm(TFMoedas, FMoedas);
  Application.CreateForm(TFMontagemkit, FMontagemkit);
  Application.CreateForm(TFMotivosBloq, FMotivosBloq);
  Application.CreateForm(TFCidades, FCidades);
  Application.CreateForm(TFNatureza, FNatureza);
  Application.CreateForm(TFOcorrencias, FOcorrencias);
  Application.CreateForm(TFOrcamento, FOrcamento);
  Application.CreateForm(TFPedcompra, FPedcompra);
  Application.CreateForm(TFPedVenda, FPedVenda);
  Application.CreateForm(TFPesquisa01, FPesquisa01);
  Application.CreateForm(TFPlano, FPlano);
  Application.CreateForm(TFPortadores, FPortadores);
  Application.CreateForm(TFPosicaoPedidoVenda, FPosicaoPedidoVenda);
  Application.CreateForm(TFRegioes, FRegioes);
  Application.CreateForm(TFRelcompras, FRelcompras);
  Application.CreateForm(TFRelAuditorias, FRelAuditorias);
  Application.CreateForm(TFRelcadastros, FRelcadastros);
  Application.CreateForm(TFRelcxbancos, FRelcxbancos);
  Application.CreateForm(TFRelEstoque, FRelEstoque);
  Application.CreateForm(TFRelFinan, FRelFinan);
  Application.CreateForm(TFRelGerenciais, FRelGerenciais);
  Application.CreateForm(TFRemProntaEntrega, FRemProntaEntrega);
  Application.CreateForm(TFRepresentantes, FRepresentantes);
  Application.CreateForm(TFRetRomaneio, FRetRomaneio);
  Application.CreateForm(TFSittributaria, FSittributaria);
  Application.CreateForm(TFSubgrupos, FSubgrupos);
  Application.CreateForm(TFTabela, FTabela);
  Application.CreateForm(TFTamanhos, FTamanhos);
  Application.CreateForm(TFTransContas, FTransContas);
  Application.CreateForm(TFTransSaldos, FTransSaldos);
  Application.CreateForm(TFTransp, FTransp);
  Application.CreateForm(TFTransfrem, FTransfrem);
  Application.CreateForm(TFUnidades, FUnidades);
  Application.CreateForm(TFUsuarios, FUsuarios);
  Application.CreateForm(TFFluxoCaixa, FFluxoCaixa);
  Application.CreateForm(TFPrecos, FPrecos);
  Application.CreateForm(TFAlteracaonotas, FAlteracaonotas);
  Application.CreateForm(TFRequisicao, FRequisicao);
  Application.CreateForm(TFRelProducao, FRelProducao);
  Application.CreateForm(TFOrcamentos, FOrcamentos);
  Application.CreateForm(TFImpSintegra, FImpSintegra);
  Application.CreateForm(TFRemessa, FRemessa);
  Application.CreateForm(TFSimilares, FSimilares);
  Application.CreateForm(TFReciboavulso, FReciboavulso);
  Application.CreateForm(TFSetores, FSetores);
  Application.CreateForm(TFAtaplanoacao, FAtaplanoacao);
  Application.CreateForm(TFRelNaoConf, FRelNaoConf);
  Application.CreateForm(TFRegNaoConformidade, FRegNaoConformidade);
  Application.CreateForm(TFFormacaoPreco, FFormacaoPreco);
  Application.CreateForm(TFPlanosPendentes, FPlanosPendentes);
  Application.CreateForm(TFRegNaoConfPendentes, FRegNaoConfPendentes);
  Application.CreateForm(TFCadServicos, FCadServicos);
  Application.CreateForm(TFTiposNotas, FTiposNotas);
  Application.CreateForm(TFNotaSaida, FNotaSaida);
  Application.CreateForm(TFIndicadores, FIndicadores);
  Application.CreateForm(TFMovIndicadores, FMovIndicadores);
  Application.CreateForm(TFTabelaComissao, FTabelaComissao);
  Application.CreateForm(TFSaldoEstoque, FSaldoEstoque);
  Application.CreateForm(TFEntradaAcabado, FEntradaAcabado);
  Application.CreateForm(TFPendenciasPendentes, FPendenciasPendentes);
  Application.CreateForm(TFColaboradores, FColaboradores);
  Application.CreateForm(TFMostraXml, FMostraXml);
  Application.CreateForm(TFRetConsig, FRetConsig);
  Application.CreateForm(TFRetprontaentreganovo, FRetprontaentreganovo);
  Application.CreateForm(TFEntradaabate, FEntradaabate);
  Application.CreateForm(TFNotaSaidaMo, FNotaSaidaMo);
  Application.CreateForm(TFNotaTransf, FNotaTransf);
  Application.CreateForm(TFPrepedidos, FPrepedidos);
  Application.CreateForm(TFRelMalote, FRelMalote);
  Application.CreateForm(TFSintegra, FSintegra);
  Application.CreateForm(TFConcbancaria, FConcbancaria);
  Application.CreateForm(TFDesossa, FDesossa);
  Application.CreateForm(TFListaFiguras, FListaFiguras);
  Application.CreateForm(TFNutricionais, FNutricionais);
  Application.CreateForm(TFIngredientes, FIngredientes);
  Application.CreateForm(TFConservacao, FConservacao);
  Application.CreateForm(TFConsulta, FConsulta);
  Application.CreateForm(TFPesagemSaida, FPesagemSaida);
  Application.CreateForm(TFPesagemCaminhao2, FPesagemCaminhao2);
  Application.CreateForm(TFAgendamento, FAgendamento);
  Application.CreateForm(TFExpNfetxt, FExpNfetxt);
  Application.CreateForm(TFExpNfse, FExpNfse);
  Application.CreateForm(TFNfeDestinadas, FNfeDestinadas);
  Application.CreateForm(TFPagamentos, FPagamentos);
  Application.CreateForm(TFBaixaPagamentos, FBaixaPagamentos);
  Application.CreateForm(TFBaixaPagamentos, FBaixaPagamentos);
  Application.CreateForm(TFCentrosCusto, FCentrosCusto);
  Application.CreateForm(TFCCustos, FCCustos);
  Application.CreateForm(TFCCustos, FCCustos);
  Application.CreateForm(TFVisualizaImpressao, FVisualizaImpressao);
  Application.CreateForm(TFEntradadecupim, FEntradadecupim);
  Application.CreateForm(TFEntradadecupim, FEntradadecupim);
  Application.CreateForm(TFJuntaPagamentos, FJuntaPagamentos);
  Application.CreateForm(TFContratos, FContratos);
  Application.CreateForm(TFContratos, FContratos);
  Application.CreateForm(TFGeraMdfe, FGeraMdfe);
  Application.CreateForm(TFExclusaoEtiqueta, FExclusaoEtiqueta);
  Application.CreateForm(TFExclusaoEtiqueta, FExclusaoEtiqueta);
  Application.CreateForm(TFLenfeemail, FLenfeemail);
  Application.CreateForm(TFGeraDmed, FGeraDmed);
  Application.CreateForm(TFGeraDmed, FGeraDmed);
  Application.CreateForm(TFCalibracoes, FCalibracoes);
  Application.CreateForm(TFCalibracoes, FCalibracoes);
  Application.CreateForm(TFContratoatu, FContratoatu);
  Application.CreateForm(TFEmailcobranca, FEmailcobranca);
  Application.CreateForm(TFImportaOFX, FImportaOFX);
  Application.CreateForm(TFTributacaoncm, FTributacaoncm);
  // 12.08.20
  {$IFDEF WHATSAPP}

     Application.CreateForm(TFGerenciaWhats, FGerenciaWhats);

  {$ENDIF}

  //  Application.CreateForm(TFGerenciaWhats, FGerenciaWhats);
  //  Application.CreateForm(TFNfeDestinadas, FNfeDestinadas);
  Application.CreateForm(TFPesagemDevolucao, FPesagemDevolucao);
//  Application.CreateForm(TFPesagemDevolucao, FPesagemDevolucao);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrVendeItem, frVendeItem);
  Application.CreateForm(TfrPagamento, frPagamento);
  Application.CreateForm(TfrRelatorio, frRelatorio);
  Application.CreateForm(TfrConfiguraSerial, frConfiguraSerial);
  Application.CreateForm(TfrmGerencialFormatado, frmGerencialFormatado);
  Application.CreateForm(TfrmDAV, frmDAV);
  Application.CreateForm(TfrmDAVOS, frmDAVOS);
  Application.CreateForm(TFGerenciaECF, FGerenciaECF);
  Application.CreateForm(TFEmbalagemDesossa, FEmbalagemDesossa);
//  Application.CreateForm(TFEmbalagemDesossa, FEmbalagemDesossa);
  Application.CreateForm(TFPeriodos, FPeriodos);
  Application.CreateForm(TFPesagemporCarga, FPesagemporCarga);
  Application.CreateForm(TFImpressaoOP, FImpressaoOP);
  Application.CreateForm(TFSaidaDesossa, FSaidaDesossa);
  Application.CreateForm(TFTeleMarketing, FTeleMarketing);
//  Application.CreateForm(TFTeleMarketing, FTeleMarketing);
//  Application.CreateForm(TFEstoquez, FEstoquez);
  Application.CreateForm(TfImportaNFSe, fImportaNFSe);
//  Application.CreateForm(TfImportaNFSe, fImportaNFSe);
  Application.CreateForm(TFBaias, FBaias);
//  Application.CreateForm(TFBaias, FBaias);
  Application.CreateForm(TFCreditosSped, FCreditosSped);
//  Application.CreateForm(TFCreditosSped, FCreditosSped);
  Application.CreateForm(TFGerenciaMdf, FGerenciaMdf);
  Application.CreateForm(TFMontaCarga, FMontaCarga);
  Application.CreateForm(TFMontaCargaCte, FMontaCargaCte);
  Application.CreateForm(TFChecabalanca, FChecabalanca);
//  Application.CreateForm(TFChecabalanca, FChecabalanca);
  Application.CreateForm(TFGeraPdf, FGeraPdf);
//  Application.CreateForm(TFGeraPdf, FGeraPdf);
  Application.CreateForm(TFadrcst, Fadrcst);
  //  Application.CreateForm(TfrVendeItem, frVendeItem);
//  Application.CreateForm(TfrPagamento, frPagamento);
//  Application.CreateForm(TfrRelatorio, frRelatorio);
//  Application.CreateForm(TfrConfiguraSerial, frConfiguraSerial);
//  Application.CreateForm(TFGerenciaECF, FGerenciaECF);
  Application.CreateForm(TFSiteWebservices, FSiteWebservices);
  Application.CreateForm(TFSpedFiscal, FSpedFiscal);
//  Application.CreateForm(TfrmGerencialFormatado, frmGerencialFormatado);
  Application.CreateForm(TFConfigDemo, FConfigDemo);
  Application.CreateForm(TFSpedPisCofins, FSpedPisCofins);
//  Application.CreateForm(TfrmDAVOS, frmDAVOS);
  Application.CreateForm(TFFaixas, FFaixas);
  Application.CreateForm(TFMontaCarga, FMontaCarga);
  Application.CreateForm(TFPesagemCaminhao, FPesagemCaminhao);
  Application.CreateForm(TFValidadeVencendo, FValidadeVencendo);
  Application.CreateForm(TFPesagemCamaraFria, FPesagemCamaraFria);
  Application.CreateForm(TFImportaXmlsCte, FImportaXmlsCte);
  Application.CreateForm(TFBrincos, FBrincos);
  Application.CreateForm(TFGerenciaCte, FGerenciaCte);
  Application.CreateForm(TFExpCte, FExpCte);
  //  Application.CreateForm(TFBuscaXMLCTe, FBuscaXMLCTe);
//  Application.CreateForm(TFImportaXmlsCte, FImportaXmlsCte);
  Application.CreateForm(TFVendaBalcao, FVendaBalcao);
  Application.CreateForm(TFValoraFaturar, FValoraFaturar);
  Application.CreateForm(TFEquipamentos, FEquipamentos);
  Application.CreateForm(TFFichatecnica, FFichatecnica);
  Application.CreateForm(TFBoletos, FBoletos);
  Application.CreateForm(TFPagamentoLeite, FPagamentoLeite);
/////  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFBuscaXmlSefa, FBuscaXmlSefa);
  Application.CreateForm(TFRateio, FRateio);

  // 25.05.17 - duas vezes cria o form ?
  ///////////////////////  Application.CreateForm(TFExpNfetxt, FExpNfetxt);

  Application.CreateForm(TFGerenciaNfe, FGerenciaNfe);
//////////////  Application.CreateForm(TFExpCte, FExpCte);
  Application.CreateForm(TFPagamentoLeite, FPagamentoLeite);
  //  Application.CreateForm(TFGerenciaCte, FGerenciaCte);
////////////////////  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFBoletos, FBoletos);
  Application.CreateForm(TFBuscaXmlSefa, FBuscaXmlSefa);
  Application.CreateForm(TFRateio, FRateio);
  Application.CreateForm(TFImportaNfe, FImportaNfe);
  Application.CreateForm(TFPesagemEntrada, FPesagemEntrada);
  Application.Run;

end.

object FMain: TFMain
  Left = 567
  Top = 319
  Align = alClient
  AutoSize = True
  Caption = 'SAC'
  ClientHeight = 416
  ClientWidth = 864
  Color = clInfoBk
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = Menu
  OldCreateOrder = False
  Position = poOwnerFormCenter
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClick = FormClick
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PMsgSistema: TPanel
    Left = 0
    Top = 393
    Width = 864
    Height = 23
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvLowered
    TabOrder = 0
    object PMsg: TPanel
      Left = 1
      Top = 1
      Width = 688
      Height = 21
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = PMsgClick
    end
    object PAlerta: TPanel
      Left = 794
      Top = 1
      Width = 69
      Height = 21
      Align = alRight
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object PFinalizar: TPanel
      Left = 689
      Top = 1
      Width = 105
      Height = 21
      Align = alRight
      BevelOuter = bvLowered
      Caption = 'Finalizar Sistema'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      Visible = False
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 370
    Width = 864
    Height = 23
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 1
    object PData: TPanel
      Left = 794
      Top = 1
      Width = 69
      Height = 21
      Align = alRight
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object PUsuario: TPanel
      Left = 470
      Top = 1
      Width = 324
      Height = 21
      Align = alRight
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object PUnidade: TPanel
      Left = 1
      Top = 1
      Width = 469
      Height = 21
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
  end
  object PAtalhos: TSQLPanelGrid
    Left = 0
    Top = 0
    Width = 406
    Height = 42
    Align = alCustom
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    Visible = False
    HeightLimite = 0
    WidthLimite = 0
    FixedVisible = False
    object batalho01: TSQLBtn
      Left = -3
      Top = 3
      Width = 66
      Height = 38
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = MeuClick01
      Operation = fbNone
      Processing = False
      AutoAction = False
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object batalho02: TSQLBtn
      Left = 69
      Top = 3
      Width = 66
      Height = 38
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = MeuClick02
      Operation = fbNone
      Processing = False
      AutoAction = False
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object batalho03: TSQLBtn
      Left = 136
      Top = 3
      Width = 66
      Height = 38
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = MeuClick03
      Operation = fbNone
      Processing = False
      AutoAction = False
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object batalho04: TSQLBtn
      Left = 204
      Top = 3
      Width = 66
      Height = 38
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = MeuClick04
      Operation = fbNone
      Processing = False
      AutoAction = False
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object batalho05: TSQLBtn
      Left = 270
      Top = 3
      Width = 66
      Height = 38
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = MeuClick05
      Operation = fbNone
      Processing = False
      AutoAction = False
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object batalho06: TSQLBtn
      Left = 336
      Top = 3
      Width = 66
      Height = 38
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = MeuClick06
      Operation = fbNone
      Processing = False
      AutoAction = False
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
  end
  object Menu: TMainMenu
    AutoLineReduction = maManual
    BiDiMode = bdLeftToRight
    OwnerDraw = True
    ParentBiDiMode = False
    Left = 352
    Top = 128
    object Cadastros: TMenuItem
      Caption = '&Cadastros'
      OnDrawItem = ConsignacaomenuDrawItem
      OnMeasureItem = MovimentosMeasureItem
      object GrupoUsurios1: TMenuItem
        Caption = 'Grupo Usu'#225'rios'
        OnClick = GrupoUsurios1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object Usurios1: TMenuItem
        Caption = 'Usu'#225'rios'
        OnClick = Usurios1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object Regies1: TMenuItem
        Caption = 'Regi'#245'es'
        OnClick = Regies1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object Cidades1: TMenuItem
        Tag = 1
        Caption = 'Cidades'
        OnClick = Cidades1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object Empresas1: TMenuItem
        Caption = 'Empresas'
        OnClick = Empresas1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object Unidades1: TMenuItem
        Caption = 'Unidades'
        OnClick = Unidades1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object CodigosdeAlquotas1: TMenuItem
        Caption = 'Codigos de Al'#237'quotas'
        OnClick = CodigosdeAlquotas1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object NaturezasFiscais1: TMenuItem
        Caption = 'Naturezas Fiscais'
        OnClick = NaturezasFiscais1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object SituaesTributrias1: TMenuItem
        Caption = 'Situa'#231#245'es Tribut'#225'rias'
        OnClick = SituaesTributrias1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object Representantes1: TMenuItem
        Caption = 'Representantes'
        OnClick = Representantes1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object ContasGerenciais: TMenuItem
        Caption = 'Contas Gerenciais'
        OnClick = ContasGerenciaisClick
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object CadClientes: TMenuItem
        Caption = 'Clientes'
        OnClick = CadClientesClick
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object CadProdutos: TMenuItem
        Caption = 'Produtos'
        OnClick = CadProdutosClick
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object Precos1: TMenuItem
        Caption = 'Pre'#231'os'
        OnClick = Precos1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object CustosdeMateriais1: TMenuItem
        Caption = 'Composi'#231#227'o de Produtos'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object ComposicaoEstoque1: TMenuItem
          Caption = 'Estoque'
          OnClick = ComposicaoEstoque1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object NotadeReclassificao1: TMenuItem
          Caption = 'Nota de Reclassifica'#231#227'o'
          OnClick = NotadeReclassificao1Click
        end
        object Processos1: TMenuItem
          Caption = 'Processos'
          OnClick = Processos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object Oramento1: TMenuItem
        Caption = 'Or'#231'amento'
        OnClick = Oramento1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object CadFornecedores: TMenuItem
        Caption = 'Fornecedores'
        ShortCut = 16503
        OnClick = CadFornecedoresClick
        OnDrawItem = ConsignacaomenuDrawItem
      end
      object Equipamentos1: TMenuItem
        Caption = 'Equipamentos'
        OnClick = Equipamentos1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object Setores1: TMenuItem
        Caption = 'Setores'
        OnClick = Setores1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object ModeObra1: TMenuItem
        Caption = 'M'#227'o de Obra'
        OnClick = ModeObra1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object Ocorrencias1: TMenuItem
        Caption = 'Ocorrencias'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object Baias1: TMenuItem
        Caption = 'Baias'
        OnClick = Baias1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object Colaboradores1: TMenuItem
        Caption = 'Colaboradores'
        OnClick = Colaboradores1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object N1: TMenuItem
        Tag = 1
        Caption = '-'
      end
      object CadFinanceiro: TMenuItem
        Caption = 'Financeiro'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object CadFormasDePagamento: TMenuItem
          Caption = 'Formas De Pagamento'
          OnClick = CadFormasDePagamentoClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object CadPortadores: TMenuItem
          Caption = 'Portadores'
          OnClick = CadPortadoresClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ConfiguraDemonstrativo1: TMenuItem
          Caption = 'Configura Demonstrativo'
          OnClick = ConfiguraDemonstrativo1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object CentrosdeCusto1: TMenuItem
          Caption = 'Centros de Custo'
          OnClick = CentrosdeCusto1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ValoresCentrosdeCusto1: TMenuItem
          Caption = 'Valores Centros de Custo'
          OnClick = ValoresCentrosdeCusto1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object CadEstoque: TMenuItem
        Caption = 'Estoque'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object Cores1: TMenuItem
          Caption = 'Cores'
          OnClick = Cores1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object amanhos1: TMenuItem
          Caption = 'Tamanhos'
          OnClick = amanhos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Copas1: TMenuItem
          Caption = 'Copas'
          OnClick = Copas1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Grupos1: TMenuItem
          Caption = 'Grupos'
          OnClick = Grupos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object SubGrupos1: TMenuItem
          Caption = 'SubGrupos'
          OnClick = SubGrupos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Familias1: TMenuItem
          Caption = 'Familias'
          OnClick = Familias1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Grades1: TMenuItem
          Caption = 'Grades'
          OnClick = Grades1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object abelasPreo1: TMenuItem
          Caption = 'Tabelas Pre'#231'o'
          OnClick = abelasPreo1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object MaterialPredominante1: TMenuItem
          Caption = 'Material Predominante'
          OnClick = MaterialPredominante1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ClassificaoIPI1: TMenuItem
          Caption = 'NCM(Classifica'#231#227'o IPI)'
          OnClick = ClassificaoIPI1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Similares1: TMenuItem
          Caption = 'Similares'
          OnClick = Similares1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ManutInventario: TMenuItem
          Caption = 'Invent'#225'rio'
          OnClick = ManutInventarioClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object InfNutricionais1: TMenuItem
          Caption = 'Inf. Nutricionais'
          OnClick = InfNutricionais1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Ingredientes1: TMenuItem
          Caption = 'Ingredientes'
          OnClick = Ingredientes1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Conservacao1: TMenuItem
          Caption = 'Conserva'#231#227'o'
          OnClick = Conservacao1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object tributacaoNCM: TMenuItem
          Caption = 'Tributa'#231#227'o NCM'
          OnClick = tributacaoNCMClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object CadOutros: TMenuItem
        Caption = 'Outros'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object CadHistoricos: TMenuItem
          Caption = 'Hist'#243'ricos'
          OnClick = CadHistoricosClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Feriados: TMenuItem
          Caption = 'Feriados'
          OnClick = FeriadosClick
          OnMeasureItem = MovimentosMeasureItem
        end
        object CadImpressos: TMenuItem
          Caption = 'Impressos'
          OnClick = CadImpressosClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object CadMotivosdeBloqueio: TMenuItem
          Caption = 'Motivos de &Bloqueio'
          OnClick = CadMotivosdeBloqueioClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ConfiguraodeMovimentos1: TMenuItem
          Caption = 'Configura'#231#227'o de Movimentos'
          OnClick = ConfiguraodeMovimentos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ransportadores1: TMenuItem
          Caption = 'Transportadores'
          OnClick = ransportadores1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object CotasporRepres1: TMenuItem
          Caption = 'Cotas por Repres.'
          OnClick = CotasporRepres1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object MensagensNotasFiscais1: TMenuItem
          Caption = 'Mensagens Notas Fiscais'
          OnClick = MensagensNotasFiscais1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object CadastroOcorrncias1: TMenuItem
          Caption = 'Cadastro Ocorr'#234'ncias'
          OnClick = CadastroOcorrncias1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object CadastroEmitentes1: TMenuItem
          Caption = 'Cadastro Emitentes'
          OnClick = CadastroEmitentes1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object TiposNota1: TMenuItem
          Caption = 'Tipos Nota'
          OnClick = TiposNota1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Indicadores1: TMenuItem
          Caption = 'Indicadores'
          OnClick = Indicadores1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ComissoVendedores1: TMenuItem
          Caption = 'Comiss'#227'o Vendedores'
          OnClick = ComissoVendedores1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object FaixasdeValores1: TMenuItem
          Caption = 'Faixas de Valores'
          OnClick = FaixasdeValores1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
    end
    object Movimentos: TMenuItem
      Caption = '&Movimentos'
      OnDrawItem = ConsignacaomenuDrawItem
      OnMeasureItem = MovimentosMeasureItem
      object Consignacaomenu: TMenuItem
        Caption = 'Consigna'#231#227'o'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object Consignao1: TMenuItem
          Caption = 'Remessa'
          OnClick = Consignao1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object AlteraoConsignao1: TMenuItem
          Caption = 'Altera'#231#227'o Remessa'
          OnClick = AlteraoConsignao1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object RetornoConsigAcerto1: TMenuItem
          Caption = 'Retorno Consig.(Acerto)'
          OnClick = RetornoConsigAcerto1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ImpressoRemessa1: TMenuItem
          Caption = 'Impress'#227'o Remessa'
          OnClick = ImpressoRemessa1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object RemMagazine1: TMenuItem
          Caption = 'Rem. Magazine'
          OnClick = RemMagazine1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object RemTrocaCredito: TMenuItem
          Caption = 'Troca Cr'#233'dito'
          OnClick = RemTrocaCreditoClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object RemCompraGarantida1: TMenuItem
          Caption = 'Compra Garantida'
          OnClick = RemCompraGarantida1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object ProntaEntrega1: TMenuItem
        Caption = 'Pronta Entrega'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object Remessa1: TMenuItem
          Caption = 'Remessa'
          OnClick = Remessa1Click
          OnDrawItem = ConsignacaomenuDrawItem
        end
        object AlteraodeRemessa1: TMenuItem
          Caption = 'Altera'#231#227'o de Remessa'
          OnClick = AlteraodeRemessa1Click
          OnDrawItem = ConsignacaomenuDrawItem
        end
        object PedidosdeVenda1: TMenuItem
          Caption = 'Desuso(Pedidos de Venda)'
          OnClick = PedidosdeVenda1Click
        end
        object ImpressoRemessaPE1: TMenuItem
          Caption = 'Impress'#227'o Remessa PE'
          OnClick = ImpressoRemessaPE1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object NovoPedidosdeVenda1: TMenuItem
          Caption = 'Pedidos de Venda'
          OnClick = NovoPedidosdeVenda1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object PedidosVenda1: TMenuItem
        Caption = 'Pedidos Venda'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object PedidodeVendaInc: TMenuItem
          Caption = 'Pedido Inclus'#227'o'
          OnClick = PedidodeVendaIncClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Alterao2: TMenuItem
          Caption = 'Pedido Altera'#231#227'o'
          OnClick = Alterao2Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object PosioPedido1: TMenuItem
          Caption = 'Posi'#231#227'o Pedido'
          OnClick = PosioPedido1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object PosRepresentante1: TMenuItem
          Caption = 'Posi'#231#227'o Geral'
          OnClick = PosRepresentante1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object PesagemPedido1: TMenuItem
          Caption = 'Pesagem Pedido'
          OnClick = PesagemPedido1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object PedidosCompra1: TMenuItem
        Caption = 'Pedidos Compra'
        OnDrawItem = ConsignacaomenuDrawItem
        object Incluso1: TMenuItem
          Caption = 'Inclus'#227'o'
          OnClick = Incluso1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Alterao1: TMenuItem
          Caption = 'Altera'#231#227'o'
          OnClick = Alterao1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object BaixaPedCompra1: TMenuItem
          Caption = 'Baixa'
          OnClick = BaixaPedCompra1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object NotasFiscais1: TMenuItem
        Caption = 'Notas Fiscais'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object Saida1: TMenuItem
          Caption = 'Saida'
          OnClick = Saida1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Entrada1: TMenuItem
          Caption = 'Entrada'
          OnClick = Entrada1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Transferncia1: TMenuItem
          Caption = 'Transfer'#234'ncia'
          OnClick = Transferncia1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object AlteraoSaida1: TMenuItem
          Caption = 'Altera'#231#227'o Saida'
          OnClick = AlteraoSaida1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object SequnciaSaida1: TMenuItem
          Caption = 'Sequ'#234'ncia Saida'
          OnClick = SequnciaSaida1Click
        end
        object RetornoRomaneio1: TMenuItem
          Caption = 'Retorno Romaneio'
          OnClick = RetornoRomaneio1Click
        end
        object AlteraoEntrada1: TMenuItem
          Caption = 'Altera'#231#227'o Entrada'
          OnClick = AlteraoEntrada1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ExportacaoNFElet1: TMenuItem
          Caption = 'Gera'#231#227'o NF Eletr'#244'nica'
          OnClick = ExportacaoNFElet1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object MaodeObraSaida1: TMenuItem
          Caption = 'M'#227'o de Obra - Saida'
          OnClick = MaodeObraSaida1Click
        end
        object GerenciarNFe1: TMenuItem
          Caption = 'Impress'#227'o NFe / NFC-e'
          OnClick = GerenciarNFe1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object AlteraoFiscal1: TMenuItem
          Caption = 'Altera'#231#227'o Fiscal Entrada'
          OnClick = AlteraoFiscal1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object VendaBalco1: TMenuItem
          Caption = 'Venda Balc'#227'o'
          OnClick = VendaBalco1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object GeracaoCTe1: TMenuItem
          Caption = 'Gera'#231#227'o CTe'
          OnClick = GeracaoCTe1Click
          OnDrawItem = ConsignacaomenuDrawItem
        end
        object GerenciarCTe1: TMenuItem
          Caption = 'Gerenciar CTe'
          OnClick = GerenciarCTe1Click
          OnDrawItem = ConsignacaomenuDrawItem
        end
        object GeraoNFServios1: TMenuItem
          Caption = 'Gera'#231#227'o NF Servi'#231'os'
          OnClick = GeraoNFServios1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object Financeiro3: TMenuItem
        Caption = 'Financeiro'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object LancarPendencia: TMenuItem
          Caption = 'Lan'#231'ar Pend'#234'ncias'
          OnClick = LancarPendenciaClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object AlterarPendencias1: TMenuItem
          Caption = 'Alterar Pendencias'
          OnClick = AlterarPendencias1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object BaixarPendncias1: TMenuItem
          Caption = 'Baixar Pend'#234'ncias'
          OnClick = BaixarPendncias1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object BaixarCarto1: TMenuItem
          Caption = 'Baixar Cart'#227'o'
          OnClick = BaixarCarto1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object BaixarporConta1: TMenuItem
          Caption = 'Baixar por Conta'
          OnClick = BaixarporConta1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ChequesRecebidos1: TMenuItem
          Caption = 'Cheques Recebidos'
          OnClick = ChequesRecebidos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object BaixarCheques1: TMenuItem
          Caption = 'Baixar Cheques'
          OnClick = BaixarCheques1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object LanarCaixaBancos1: TMenuItem
          Caption = 'Lan'#231'ar Caixa/Bancos'
          OnClick = LanarCaixaBancos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object AlterarCaixaBancos1: TMenuItem
          Caption = 'Alterar Caixa/Bancos'
          OnClick = AlterarCaixaBancos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ransfernciaMensal2: TMenuItem
          Caption = 'Transfer'#234'ncia Mensal'
          OnClick = ransfernciaMensal2Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object AjustesSaldosMensais1: TMenuItem
          Caption = 'Ajuste Saldo Mensal'
          OnClick = AjustesSaldosMensais1Click
        end
        object GeraoBoletos1: TMenuItem
          Caption = 'Gera'#231#227'o Boletos'
          OnClick = GeraoBoletos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object BaixaCobrana1: TMenuItem
          Caption = 'Baixa Cobran'#231'a'
          OnClick = BaixaCobrana1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object FluxodeCaixa2: TMenuItem
          Caption = 'Fluxo de Caixa'
          OnClick = FluxodeCaixa2Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ConciliaoBancria1: TMenuItem
          Caption = 'Concilia'#231#227'o Banc'#225'ria'
          OnClick = ConciliaoBancria1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ChequesEmitidos1: TMenuItem
          Caption = 'Cheques Emitidos'
          OnClick = ChequesEmitidos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object PagamentoLeite: TMenuItem
          Caption = 'Pagamento Leite'
          OnClick = PagamentoLeiteClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object PagamentoMerenda1: TMenuItem
          Caption = 'Pagamento Merenda'
          OnClick = PagamentoMerenda1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object PagamentoEletrnico1: TMenuItem
          Caption = 'Pagamento Eletr'#244'nico'
          OnClick = PagamentoEletrnico1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object BaixaPagEletrnico1: TMenuItem
          Caption = 'Baixa Pag.Eletr'#244'nico'
          OnClick = BaixaPagEletrnico1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object JuntaPagamentos1: TMenuItem
          Caption = 'Junta Pagamentos'
          OnClick = JuntaPagamentos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object AvisodeCobranca: TMenuItem
          Caption = 'Lembrete de Vencimento'
          OnClick = AvisodeCobrancaClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ImportacaoOFX: TMenuItem
          Caption = 'Importa'#231#227'o OFX'
          OnClick = ImportacaoOFXClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object Estoque1: TMenuItem
        Caption = 'Estoque'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object Acertos1: TMenuItem
          Caption = 'Acertos'
          OnClick = Acertos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Contagem2: TMenuItem
          Caption = 'Contagem Estoque'
          OnClick = Contagem2Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object AjustesdeSaldos1: TMenuItem
          Caption = 'Ajustes de Saldos'
          OnClick = AjustesdeSaldos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object BaixaMatriaPrima1: TMenuItem
          Caption = 'Baixa Mat'#233'ria Prima'
          OnClick = BaixaMatriaPrima1Click
        end
        object ransfernciaMensal1: TMenuItem
          Caption = 'Transfer'#234'ncia Mensal'
          OnClick = ransfernciaMensal1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object MontagemKits1: TMenuItem
          Caption = 'Montagem Kits'
          OnClick = MontagemKits1Click
        end
        object BxMensalVendaTemporria1: TMenuItem
          Caption = 'Baixa Mensal Estoque Venda Tempor'#225'ria'
          OnClick = BxMensalVendaTemporria1Click
        end
        object BaixaAlmox: TMenuItem
          Caption = 'Baixa Almox. para Processo'
          OnClick = BaixaAlmoxClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object BaixaProcessoparaAlmox1: TMenuItem
          Caption = 'Baixa Processo para Almox.'
          OnClick = BaixaProcessoparaAlmox1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object EntradaProdutoAcabado1: TMenuItem
          Caption = 'Entrada Produto Acabado'
          OnClick = EntradaProdutoAcabado1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ContagemcomLeitor1: TMenuItem
          Caption = 'Contagem Acumulando com Leitor'
          OnClick = ContagemcomLeitor1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object GerenciaisMov: TMenuItem
        Caption = 'Gerenciais'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object CancelamentoTransao1: TMenuItem
          Caption = 'Cancelamento Transa'#231#227'o'
          OnClick = CancelamentoTransao1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ExportaoCaixaBancos1: TMenuItem
          Caption = 'Exporta'#231#227'o Caixa/Bancos'
          OnClick = ExportaoCaixaBancos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ExportaoComprasVendas1: TMenuItem
          Caption = 'Exporta'#231#227'o Compras/Vendas'
          OnClick = ExportaoComprasVendas1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ExportaoFiscalWindows1: TMenuItem
          Caption = 'Exporta'#231#227'o Fiscal'
          OnClick = ExportaoFiscalWindows1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Sintegra1: TMenuItem
          Caption = 'Gera'#231#227'o Sintegra'
          OnClick = Sintegra1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object transfernciaRemessa1: TMenuItem
          Caption = 'Transfer'#234'ncia Remessa'
          OnClick = transfernciaRemessa1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object AlteraoNotas1: TMenuItem
          Caption = 'Altera'#231#227'o Notas'
          OnClick = AlteraoNotas1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Oramentos1: TMenuItem
          Caption = 'Or'#231'amentos'
          OnClick = Oramentos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Registros1100e15001: TMenuItem
          Caption = 'Registros 1100 e 1500'
          OnClick = Registros1100e15001Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object GeracaoSpedFiscal1: TMenuItem
          Caption = 'Gera'#231#227'o Sped Fiscal'
          OnClick = GeracaoSpedFiscal1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object GeracaoSpedPisCofins1: TMenuItem
          Caption = 'Gera'#231#227'o Sped Pis Cofins'
          OnClick = GeracaoSpedPisCofins1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object GeraoADRCST1: TMenuItem
          Caption = 'Gera'#231#227'o ADRC-ST'
          OnClick = GeraoADRCST1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ImportaCTe1: TMenuItem
          Caption = 'Importa CTe'
          OnClick = ImportaCTe1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ImportaNFes1: TMenuItem
          Caption = 'Importa NFe'
          OnClick = ImportaNFes1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object NFeDestinadas1: TMenuItem
          Caption = 'NFe Destinadas'
          OnClick = NFeDestinadas1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ImportaNFSe1: TMenuItem
          Caption = 'Importa NFSe'
          OnClick = ImportaNFSe1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object GeracaoDmed1: TMenuItem
          Caption = 'Gera'#231#227'o Dmed'
          OnClick = GeracaoDmed1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object Pesquisas1: TMenuItem
        Caption = 'Pesquisas'
        OnDrawItem = ConsignacaomenuDrawItem
        object Pesquisa011: TMenuItem
          Caption = 'Pesquisa 01'
          OnClick = Pesquisa011Click
        end
      end
      object PrPedidos1: TMenuItem
        Caption = 'Pr'#233'-Pedidos'
        OnDrawItem = ConsignacaomenuDrawItem
        object Atendimento1: TMenuItem
          Caption = 'Atendimento'
          OnClick = Atendimento1Click
        end
      end
      object EntradaAbate1: TMenuItem
        Caption = 'Entrada Abate'
        OnClick = EntradaAbate1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object IncusaoAbate: TMenuItem
          Caption = 'Inclus'#227'o'
          OnClick = IncusaoAbateClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object AlteracaoAbate: TMenuItem
          Caption = 'Altera'#231#227'o'
          OnClick = AlteracaoAbateClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Brincos1: TMenuItem
          Caption = 'Brincos'
          OnClick = Brincos1Click
          OnDrawItem = ConsignacaomenuDrawItem
        end
        object Pesagem1: TMenuItem
          Caption = 'Pesagem'
          OnClick = Pesagem1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object PesagemCortes1: TMenuItem
          Caption = 'Pesagem Cortes'
          OnClick = PesagemCortes1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object Desossa1: TMenuItem
        Caption = 'Desossa'
        OnClick = Desossa1Click
        OnDrawItem = ConsignacaomenuDrawItem
        object EntradaDesossa: TMenuItem
          Caption = 'Entrada Desossa'
          OnClick = EntradaDesossaClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object SaidaDesossa: TMenuItem
          Caption = 'Saida Desossa'
          OnClick = SaidaDesossaClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Transformacao: TMenuItem
          Caption = 'Transforma'#231#227'o'
          OnClick = TransformacaoClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object EntradadeCupim1: TMenuItem
          Caption = 'Entrada de Cupim'
          OnClick = EntradadeCupim1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object EtiquetasMiudos1: TMenuItem
          Caption = 'Etiquetas Mi'#250'dos'
          OnClick = EtiquetasMiudos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ExclusoEtiquetas1: TMenuItem
          Caption = 'Exclus'#227'o Etiquetas'
          OnClick = ExclusoEtiquetas1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object SaidaAbate1: TMenuItem
        Caption = 'Pedido de Venda'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object SaidaAbateInclusao: TMenuItem
          Caption = 'Inclus'#227'o'
          OnClick = SaidaAbateInclusaoClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object SaidaAbateAlteracao: TMenuItem
          Caption = 'Altera'#231#227'o'
          OnClick = SaidaAbateAlteracaoClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object NaoConformidades1: TMenuItem
        Caption = 'N'#227'o Conformidades'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object AtaPlanosdeAo1: TMenuItem
          Caption = 'Planos de A'#231#227'o'
          OnClick = AtaPlanosdeAo1Click
        end
        object AlteracaoPlanoacao1: TMenuItem
          Caption = 'Altera'#231#227'o Plano a'#231#227'o'
          OnClick = AlteracaoPlanoacao1Click
        end
        object PlanosPendentes1: TMenuItem
          Caption = 'Planos Pendentes'
          OnClick = PlanosPendentes1Click
        end
        object RegistroNoConformidade1: TMenuItem
          Caption = 'Registro N'#227'o Conformidade'
          OnClick = RegistroNoConformidade1Click
        end
        object AlteracaoRegNaoConf1: TMenuItem
          Caption = 'Altera'#231#227'o Reg. N'#227'o Conf.'
          OnClick = AlteracaoRegNaoConf1Click
        end
        object RNCPendentes1: TMenuItem
          Caption = 'RNC Pendentes'
          OnClick = RNCPendentes1Click
        end
        object IndicadoresdeResultado1: TMenuItem
          Caption = 'Indicadores de Resultado'
          OnClick = IndicadoresdeResultado1Click
        end
      end
      object ManutencaoEquipamento1: TMenuItem
        Caption = 'Manuten'#231#227'o Equipamento'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object Inclusaomanutencao: TMenuItem
          Caption = 'Inclus'#227'o'
          OnClick = InclusaomanutencaoClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Alteracaomanutencao: TMenuItem
          Caption = 'Altera'#231#227'o'
          OnClick = AlteracaomanutencaoClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object Fazenda1: TMenuItem
        Caption = 'Fazenda'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object Fazendainclusao: TMenuItem
          Caption = 'Inclus'#227'o'
          OnClick = FazendainclusaoClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Fazendaalteracao: TMenuItem
          Caption = 'Altera'#231#227'o'
          OnClick = FazendaalteracaoClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object PesagemVivos: TMenuItem
          Caption = 'Pesagem '
          OnClick = PesagemVivosClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Infopesagem: TMenuItem
          Caption = 'Dig.Pesagem'
          OnClick = InfopesagemClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object LotesBaia1: TMenuItem
          Caption = 'Lotes Baia'
          OnClick = LotesBaia1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object AlteraoLotesBaia1: TMenuItem
          Caption = 'Altera'#231#227'o Lotes Baia'
          OnClick = AlteraoLotesBaia1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object Cargas1: TMenuItem
        Caption = 'Cargas'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object Montagem1: TMenuItem
          Caption = 'Montagem'
          OnClick = Montagem1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object MontagemcomCTe1: TMenuItem
          Caption = 'Montagem com CT-e'
          OnClick = MontagemcomCTe1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object PesagemCaminhao2: TMenuItem
          Caption = 'Pesagem Caminh'#227'o'
          OnClick = PesagemCaminhao2Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object VerificaoPeso1: TMenuItem
          Caption = 'Fechamento Carga'
          OnClick = VerificaoPeso1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object PesagemProdutor1: TMenuItem
          Caption = 'Pesagem Produtor'
          OnClick = PesagemProdutor1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object PesagemDevoluo1: TMenuItem
          Caption = 'Pesagem Devolu'#231#227'o '
          OnClick = PesagemDevoluo1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object PesagemporCarga1: TMenuItem
          Caption = 'Pesagem por Carga'
          OnClick = PesagemporCarga1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object MDFecomCte1: TMenuItem
          Caption = 'MDFe com Cte'
          OnClick = MDFecomCte1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object GerenciaMDFe1: TMenuItem
          Caption = 'Gerencia MDFe'
          OnClick = GerenciaMDFe1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object Agenda1: TMenuItem
        Caption = 'Agenda'
        OnClick = Agenda1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object TeleVendas1: TMenuItem
        Caption = 'TeleMarketing'
        OnClick = TeleVendas1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object LeitedaCrianca1: TMenuItem
        Caption = 'Leite da Crian'#231'a'
        OnClick = LeitedaCrianca1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object Contratos1: TMenuItem
        Caption = 'Contratos'
        OnClick = Contratos1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object Balanca: TMenuItem
        Caption = 'Balan'#231'a'
        OnClick = BalancaClick
        OnDrawItem = ConsignacaomenuDrawItem
      end
    end
    object ECF1: TMenuItem
      Caption = '&ECF/NFC-e'
      OnDrawItem = ConsignacaomenuDrawItem
      OnMeasureItem = MovimentosMeasureItem
      object CupomFiscal1: TMenuItem
        Caption = 'Cupom Fiscal / NFC-e'
        OnClick = CupomFiscal1Click
        OnDrawItem = ConsignacaomenuDrawItem
      end
      object LeituraX1: TMenuItem
        Caption = 'Leitura X'
        OnClick = LeituraX1Click
        OnDrawItem = ConsignacaomenuDrawItem
      end
      object ReducaoZ: TMenuItem
        Caption = 'Redu'#231#227'o Z'
        OnClick = ReducaoZClick
        OnDrawItem = ConsignacaomenuDrawItem
      end
      object CancelaCupom1: TMenuItem
        Caption = 'Cancela Cupom'
        OnClick = CancelaCupom1Click
        OnDrawItem = ConsignacaomenuDrawItem
      end
      object OpcoesEcf: TMenuItem
        Caption = '&Op'#231#245'es'
        OnClick = OpcoesEcfClick
        OnDrawItem = ConsignacaomenuDrawItem
      end
    end
    object Relatorios: TMenuItem
      Caption = '&Relat'#243'rios'
      OnDrawItem = ConsignacaomenuDrawItem
      OnMeasureItem = MovimentosMeasureItem
      object Cadastros1: TMenuItem
        Caption = 'Cadastros'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object Clientes1: TMenuItem
          Caption = 'Clientes'
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
          object FichaCadastral1: TMenuItem
            Caption = 'Ficha Cadastral'
            OnClick = FichaCadastral1Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
          object Aniversariantes1: TMenuItem
            Caption = 'Aniversariantes'
            OnClick = Aniversariantes1Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
          object ClientesNovos1: TMenuItem
            Caption = 'Clientes Geral'
            OnClick = ClientesNovos1Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
          object ClientesNovosResumo1: TMenuItem
            Caption = 'Clientes Resumo'
            OnClick = ClientesNovosResumo1Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
          object Etiquetas1: TMenuItem
            Caption = 'Etiquetas'
            OnClick = Etiquetas1Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
          object VendasInativos1: TMenuItem
            Caption = 'Vendas Inativos'
            OnClick = VendasInativos1Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
          object EtiquetaVendasInativos1: TMenuItem
            Caption = 'Etiqueta Vendas Inativos'
            OnClick = EtiquetaVendasInativos1Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
          object LimiteDisponvel1: TMenuItem
            Caption = 'Limite Dispon'#237'vel'
            OnClick = LimiteDisponvel1Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
        end
        object iposdeMovimento1: TMenuItem
          Caption = 'Tipos de Movimento'
          OnClick = iposdeMovimento1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object IntruesCobrana1: TMenuItem
          Caption = 'Etiqueta Composi'#231#227'o'
          OnClick = IntruesCobrana1Click
        end
      end
      object Financeiro2: TMenuItem
        Caption = 'Financeiro'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object ContaaPagar1: TMenuItem
          Caption = 'Contas a Pagar'
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
          object RelaoIncluidas1: TMenuItem
            Caption = 'Rela'#231#227'o Inclu'#237'das'
            OnClick = RelaoIncluidas1Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
          object RelaoPendentes1: TMenuItem
            Caption = 'Rela'#231#227'o Pendentes'
            OnClick = RelaoPendentes1Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
          object RelaoBaixadas1: TMenuItem
            Caption = 'Rela'#231#227'o Baixadas'
            OnClick = RelaoBaixadas1Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
          object PosioFinanceira1: TMenuItem
            Caption = 'Posi'#231#227'o Financeira'
            OnClick = PosioFinanceira1Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
          object PosicaoApropriacoes1: TMenuItem
            Caption = 'Posi'#231#227'o Apropria'#231#245'es'
            OnClick = PosicaoApropriacoes1Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
        end
        object ContasaReceber1: TMenuItem
          Caption = 'Contas a Receber'
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
          object RelaoIncluidas2: TMenuItem
            Caption = 'Rela'#231#227'o Inclu'#237'das'
            OnClick = RelaoIncluidas2Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
          object RelaoPendentes2: TMenuItem
            Caption = 'Rela'#231#227'o Pendentes'
            OnClick = RelaoPendentes2Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
          object RelaoBaixadas2: TMenuItem
            Caption = 'Rela'#231#227'o Baixadas'
            OnClick = RelaoBaixadas2Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
          object PosioFinanceira2: TMenuItem
            Caption = 'Posi'#231#227'o Financeira'
            OnClick = PosioFinanceira2Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
          object PendentesRepr1: TMenuItem
            Caption = 'Pendentes Repr.'
            OnClick = PendentesRepr1Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
          object ResumoVencerVencidos1: TMenuItem
            Caption = 'Resumo Vencer/Vencidos'
            OnClick = ResumoVencerVencidos1Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
        end
        object MovimentoBancrio1: TMenuItem
          Caption = 'Movimento Caixa/Bancos'
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
          object ExtratoConta: TMenuItem
            Caption = 'Extrato'
            OnClick = ExtratoContaClick
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
          object ExtratoSinttico2: TMenuItem
            Caption = 'Extrato Sint'#233'tico'
            OnClick = ExtratoSinttico2Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
          object ReceitasDespesas1: TMenuItem
            Caption = 'Receitas/Despesas'
            OnClick = ReceitasDespesas1Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
          object FluxodeCaixa1: TMenuItem
            Caption = 'Fluxo de Caixa'
            OnClick = FluxodeCaixa1Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
          object Comisso1: TMenuItem
            Caption = 'Comiss'#227'o'
            OnClick = Comisso1Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
          object ResumoDiario1: TMenuItem
            Caption = 'Resumo Di'#225'rio'
            OnClick = ResumoDiario1Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
        end
        object ChequesRecebidos2: TMenuItem
          Caption = 'Cheques Recebidos'
          OnClick = ChequesRecebidos2Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object PosioCheques1: TMenuItem
          Caption = 'Posi'#231#227'o Cheques'
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
          object ChequeRecebidos1: TMenuItem
            Caption = 'Recebidos'
            OnClick = ChequeRecebidos1Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
          object ChequeEmitidos1: TMenuItem
            Caption = 'Emitidos'
            OnClick = ChequeEmitidos1Click
            OnDrawItem = ConsignacaomenuDrawItem
            OnMeasureItem = MovimentosMeasureItem
          end
        end
        object Antecipaes1: TMenuItem
          Caption = 'Antecipa'#231#245'es'
          OnClick = Antecipaes1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Oramento2: TMenuItem
          Caption = 'Or'#231'amento'
          OnClick = Oramento2Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ComissaoobreRecebido1: TMenuItem
          Caption = 'Comiss'#227'o sobre Recebido'
          OnClick = ComissaoobreRecebido1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object DRE1: TMenuItem
          Caption = 'DRE Gerencial'
          OnClick = DRE1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object Estoque2: TMenuItem
        Caption = 'Estoque'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object PosioEstoque1: TMenuItem
          Caption = 'Posi'#231#227'o Estoque'
          OnClick = PosioEstoque1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ExtratodoProduto1: TMenuItem
          Caption = 'Extrato do Produto'
          OnClick = ExtratodoProduto1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ExtratoSinttico1: TMenuItem
          Caption = 'Extrato Sint'#233'tico'
          OnClick = ExtratoSinttico1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ExtratoCamarafria: TMenuItem
          Caption = 'Extrato Camara Fria'
          OnClick = ExtratoCamarafriaClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object EstoqueCamaraFria1: TMenuItem
          Caption = 'Estoque Camara Fria'
          OnClick = EstoqueCamaraFria1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ExtratoConsignado1: TMenuItem
          Caption = 'Extrato Consignado'
          OnClick = ExtratoConsignado1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ExtratoProntaEntrega1: TMenuItem
          Caption = 'Extrato Pronta Entrega'
          OnClick = ExtratoProntaEntrega1Click
        end
        object ExtratoRegimeEspecial1: TMenuItem
          Caption = 'Extrato Regime Especial'
          OnClick = ExtratoRegimeEspecial1Click
        end
        object ExtratoProdutoFora1: TMenuItem
          Caption = 'Extrato Produto Fora'
          OnClick = ExtratoProdutoFora1Click
        end
        object Itens: TMenuItem
          Caption = 'Itens'
          OnClick = ItensClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Inventrio1: TMenuItem
          Caption = 'Invent'#225'rio'
          OnClick = Inventrio1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object InventrioConsignado1: TMenuItem
          Caption = 'Invent'#225'rio Consignado'
          OnClick = InventrioConsignado1Click
        end
        object InventrioProntaEntrega1: TMenuItem
          Caption = 'Invent'#225'rio Pronta Entrega'
          OnClick = InventrioProntaEntrega1Click
        end
        object InventrioRegimeEspecial1: TMenuItem
          Caption = 'Invent'#225'rio Regime Especial'
          OnClick = InventrioRegimeEspecial1Click
        end
        object InventrioRetroativoConsignado1: TMenuItem
          Caption = 'Invent'#225'rio Retroativo Consignado'
          OnClick = InventrioRetroativoConsignado1Click
        end
        object Contagem1: TMenuItem
          Caption = 'Contagem'
          OnClick = Contagem1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ListaPreos1: TMenuItem
          Caption = 'Lista Pre'#231'os'
          OnClick = ListaPreos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object VendasAbaixoMnimo1: TMenuItem
          Caption = 'Vendas Abaixo M'#237'nimo'
          OnClick = VendasAbaixoMnimo1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ConsumoMaterial1: TMenuItem
          Caption = 'Consumo Material'
          OnClick = ConsumoMaterial1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object CurvaABCConsumo1: TMenuItem
          Caption = 'Curva ABC Consumo'
          OnClick = CurvaABCConsumo1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object CurvaABCEstoque1: TMenuItem
          Caption = 'Curva ABC Estoque'
          OnClick = CurvaABCEstoque1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object SemMovimento1: TMenuItem
          Caption = 'Sem Movimento'
          OnClick = SemMovimento1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object CreditoMCbicos1: TMenuItem
          Caption = 'Cr'#233'dito M.C'#250'bicos'
          OnClick = CreditoMCbicos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object PrevistoRealizado1: TMenuItem
          Caption = 'Previsto/Realizado'
          OnClick = PrevistoRealizado1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object PontoRessuprimento1: TMenuItem
          Caption = 'Ponto Ressuprimento'
          OnClick = PontoRessuprimento1Click
        end
        object ReservaAlmox1: TMenuItem
          Caption = 'Reserva Almox.'
          OnClick = ReservaAlmox1Click
        end
        object PosicaoEstoqueporPeso1: TMenuItem
          Caption = 'Posi'#231#227'o Estoque por Peso'
          OnClick = PosicaoEstoqueporPeso1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object RastreamentoProdutos1: TMenuItem
          Caption = 'Rastreamento Produtos'
          OnClick = RastreamentoProdutos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object RastreamentoVendas1: TMenuItem
          Caption = 'Rastreamento Vendas'
          OnClick = RastreamentoVendas1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object NotasFiscais2: TMenuItem
        Caption = 'Notas Fiscais'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object Saidas1: TMenuItem
          Caption = 'Saida'
          OnClick = Saidas1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ransferncia1: TMenuItem
          Caption = 'Transfer'#234'ncia'
          OnClick = ransferncia1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object DevoluoRomaneio1: TMenuItem
          Caption = 'Devolu'#231#227'o'
          OnClick = DevoluoRomaneio1Click
          OnDrawItem = ConsignacaomenuDrawItem
        end
        object RomaneioRetorno1: TMenuItem
          Caption = 'Romaneio Retorno'
          OnClick = RomaneioRetorno1Click
        end
        object Bloqueto1: TMenuItem
          Caption = 'Duplicata'
          OnClick = Bloqueto1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Faturamento1: TMenuItem
          Caption = 'Faturamento'
          OnClick = Faturamento1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Compras2: TMenuItem
          Caption = 'Compras'
          OnClick = Compras2Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object SaldoaEntregar1: TMenuItem
          Caption = 'Saldo a Entregar'
          OnClick = SaldoaEntregar1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object InssNotaProdutor1: TMenuItem
          Caption = 'Inss Nota Produtor'
          OnClick = InssNotaProdutor1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object PedidosFaturados1: TMenuItem
          Caption = 'Pedidos Faturados'
          OnClick = PedidosFaturados1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ImpostosRetidos1: TMenuItem
          Caption = 'Impostos Retidos'
          OnClick = ImpostosRetidos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object PorSetor1: TMenuItem
          Caption = 'Por Setor'
          OnClick = PorSetor1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object InformeIRProdutor1: TMenuItem
          Caption = 'Informe IR Produtor'
          OnClick = InformeIRProdutor1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object Gerenciais1: TMenuItem
        Caption = 'Gerenciais'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object ransao1: TMenuItem
          Caption = 'Transa'#231#227'o'
          ShortCut = 16468
          OnClick = ransao1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object PosioCliente1: TMenuItem
          Caption = 'Posi'#231#227'o Cliente'
          OnClick = PosioCliente1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object AuditoriaFiscal1: TMenuItem
          Caption = 'Auditoria Fiscal'
          OnClick = AuditoriaFiscal1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object AuditoriaFiscalCFOP1: TMenuItem
          Caption = 'Auditoria Fiscal CFOP'
          OnClick = AuditoriaFiscalCFOP1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object AuditoriaFisItens1: TMenuItem
          Caption = 'Auditoria Fis.Itens'
          OnClick = AuditoriaFisItens1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object AuditoriaBaseItens1: TMenuItem
          Caption = 'Auditoria Base Itens'
          OnClick = AuditoriaBaseItens1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object AuditoriaCustos1: TMenuItem
          Caption = 'Auditoria Custos'
          OnClick = AuditoriaCustos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object CMV1: TMenuItem
          Caption = 'CMV'
          OnClick = CMV1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Vendas1: TMenuItem
          Caption = 'Vendas / Comiss'#227'o'
          OnClick = Vendas1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object VendasComissoporGrupo1: TMenuItem
          Caption = 'Vendas / Comiss'#227'o por Grupo'
          OnClick = VendasComissoporGrupo1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object VendasQtde1: TMenuItem
          Caption = 'Vendas / Qtde'
          OnClick = VendasQtde1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Vendas2: TMenuItem
          Caption = 'Vendas'
          OnClick = Vendas2Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object VendaProduto1: TMenuItem
          Caption = 'Venda Produto'
          OnClick = VendaProduto1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ConfernciaDescontos1: TMenuItem
          Caption = 'Confer'#234'ncia Descontos'
          OnClick = ConfernciaDescontos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Compras1: TMenuItem
          Caption = 'Entradas'
          OnClick = Compras1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object TransfCorrigidas1: TMenuItem
          Caption = 'Transf. Corrigidas'
          OnClick = TransfCorrigidas1Click
        end
        object AtendimentoRepr1: TMenuItem
          Caption = 'Atendimento Repr.'
          OnClick = AtendimentoRepr1Click
        end
        object EntradadeAbate1: TMenuItem
          Caption = 'Entrada de Abate'
          OnClick = EntradadeAbate1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object SaidaAbate2: TMenuItem
          Caption = 'Romaneio Saida'
          OnClick = SaidaAbate2Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Veiculos1: TMenuItem
          Caption = 'Ve'#237'culos'
          OnClick = Veiculos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object RelCarga1: TMenuItem
          Caption = 'Carga'
          OnClick = RelCarga1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ConsignaoemAberto1: TMenuItem
          Caption = 'Consigna'#231#227'o em Aberto'
          OnClick = ConsignaoemAberto1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object DetalheVendaConsig1: TMenuItem
          Caption = 'Detalhamento Acerto VC'
          OnClick = DetalheVendaConsig1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ProntaEntregaemaberto1: TMenuItem
          Caption = 'Pronta Entrega em Aberto'
          OnClick = ProntaEntregaemaberto1Click
        end
        object ComissoAbate1: TMenuItem
          Caption = 'Comiss'#227'o Abate'
          OnClick = ComissoAbate1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Fazenda2: TMenuItem
          Caption = 'Fazenda'
          OnClick = Fazenda2Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object AnliseVendaCliente1: TMenuItem
          Caption = 'An'#225'lise Vendas Cliente'
          OnClick = AnliseVendaCliente1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object LotesFazenda1: TMenuItem
          Caption = 'Lotes Fazenda'
          OnClick = LotesFazenda1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ComissoBoiadeiros1: TMenuItem
          Caption = 'Comiss'#227'o Boiadeiros'
          OnClick = ComissoBoiadeiros1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ConfAcrescimos1: TMenuItem
          Caption = 'Conf. Acr'#233'scimos'
          OnClick = ConfAcrescimos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object LotesFazResumo1: TMenuItem
          Caption = 'Lotes Faz.Resumo'
          OnClick = LotesFazResumo1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object Auditorias1: TMenuItem
        Caption = 'Auditorias'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object TransaesCanceladas1: TMenuItem
          Caption = 'Transa'#231#245'es Canceladas'
          OnClick = TransaesCanceladas1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object EvoluoCusto1: TMenuItem
          Caption = 'Evolu'#231#227'o Custo'
          OnClick = EvoluoCusto1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ComparativoInventrios1: TMenuItem
          Caption = 'Comparativo Invent'#225'rios'
          OnClick = ComparativoInventrios1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ChecaSaldo1: TMenuItem
          Caption = 'Checa Saldo'
          OnClick = ChecaSaldo1Click
        end
        object NotascomFinanceiro1: TMenuItem
          Caption = 'Notas com Financeiro'
          OnClick = NotascomFinanceiro1Click
        end
        object ChecagenPisCofins1: TMenuItem
          Caption = 'Checagem Pis/Cofins'
          OnClick = ChecagenPisCofins1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ChecatributacaoNCM: TMenuItem
          Caption = 'Tributa'#231#227'o NCM'
          OnClick = ChecatributacaoNCMClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object PedidoVenda2: TMenuItem
        Caption = 'Pedido Venda'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object ReprCliente1: TMenuItem
          Caption = 'Repr./Cliente'
          OnClick = ReprCliente1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ReprProduto1: TMenuItem
          Caption = 'Repr./Produto'
          OnClick = ReprProduto1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object PeasPendente1: TMenuItem
          Caption = 'Pe'#231'as Pendentes'
          OnClick = PeasPendente1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object PedidosVenda2: TMenuItem
          Caption = 'Pedidos Venda'
          OnClick = PedidosVenda2Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object RelImpPedidos1: TMenuItem
          Caption = 'Rel.Imp.Pedidos'
          OnClick = RelImpPedidos1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object MaisVendiso1: TMenuItem
          Caption = 'Mais Vendidos'
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
          object ProdutosPedidos: TMenuItem
            Caption = 'Produto'
            OnClick = ProdutosPedidosClick
          end
          object ProdutoRepresentante1: TMenuItem
            Caption = 'Produto+Representante'
            OnClick = ProdutoRepresentante1Click
          end
        end
        object cmvproducao: TMenuItem
          Caption = 'CMV Produ'#231#227'o'
          OnClick = cmvproducaoClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object PrPedidos2: TMenuItem
        Caption = 'Pr'#233'-Pedidos'
        OnDrawItem = ConsignacaomenuDrawItem
        object Atendimento2: TMenuItem
          Caption = 'Atendimento'
          OnClick = Atendimento2Click
        end
        object Relacaoprepedidos: TMenuItem
          Caption = 'Rela'#231#227'o Pr'#233'-Pedidos'
          OnClick = RelacaoprepedidosClick
        end
      end
      object Compras3: TMenuItem
        Caption = 'Compras'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object ImpressoPedido1: TMenuItem
          Caption = 'Impress'#227'o Pedido'
          OnClick = ImpressoPedido1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Recebimento1: TMenuItem
          Caption = 'Recebimento'
          OnClick = Recebimento1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ExtratoMatriaPrima1: TMenuItem
          Caption = 'Extrato Mat.Prima Detalhado'
          OnClick = ExtratoMatriaPrima1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ExtratoMatPrimaResumido1: TMenuItem
          Caption = 'Extrato Mat. Prima Resumido'
          OnClick = ExtratoMatPrimaResumido1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ContagemRecebimento1: TMenuItem
          Caption = 'Contagem Recebimento'
          OnClick = ContagemRecebimento1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object Malote1: TMenuItem
        Caption = 'Malote'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object ChequesRecebidos3: TMenuItem
          Caption = 'Cheques Recebidos'
          OnClick = ChequesRecebidos3Click
        end
        object PendentesRepr2: TMenuItem
          Caption = 'Pendentes Repr.'
          OnClick = PendentesRepr2Click
        end
      end
      object Produo1: TMenuItem
        Caption = 'Produ'#231#227'o'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object Cortes1: TMenuItem
          Caption = 'Cortes'
          OnClick = Cortes1Click
        end
        object Barras1: TMenuItem
          Caption = 'Barras'
          OnClick = Barras1Click
        end
        object ItensdaObra1: TMenuItem
          Caption = 'Itens da Obra'
          OnClick = ItensdaObra1Click
        end
        object CortescomEstoque1: TMenuItem
          Caption = 'Cortes com Estoque'
          OnClick = CortescomEstoque1Click
        end
      end
      object RelNaoConformidade1: TMenuItem
        Caption = 'N'#227'o Conformidade'
        OnDrawItem = ConsignacaomenuDrawItem
        object RelPlanodeAcao1: TMenuItem
          Caption = 'Plano de A'#231#227'o'
          OnClick = RelPlanodeAcao1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object IndicadoresdeResultado2: TMenuItem
          Caption = 'Indicadores de Resultado'
          OnClick = IndicadoresdeResultado2Click
        end
      end
      object Equipamentos: TMenuItem
        Caption = 'Equipamentos'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object Fichatecnica: TMenuItem
          Caption = 'Ficha T'#233'cnica'
          OnClick = FichatecnicaClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object Notasequipamentos: TMenuItem
          Caption = 'Notas X Equipamentos'
          OnClick = NotasequipamentosClick
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object PrximasTrocas1: TMenuItem
          Caption = 'Pr'#243'ximas Trocas'
          OnClick = PrximasTrocas1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object MediaConsumo1: TMenuItem
          Caption = 'M'#233'dia Consumo'
          OnClick = MediaConsumo1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
      object Carregamento1: TMenuItem
        Caption = 'Carregamento'
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
        object Carregados1: TMenuItem
          Caption = 'Carregados'
          OnClick = Carregados1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
        object ComissaoMotoristas1: TMenuItem
          Caption = 'Comiss'#227'o Motoristas'
          OnClick = ComissaoMotoristas1Click
          OnDrawItem = ConsignacaomenuDrawItem
          OnMeasureItem = MovimentosMeasureItem
        end
      end
    end
    object Configuracoes: TMenuItem
      Caption = 'Confi&gura'#231#245'es'
      OnDrawItem = ConsignacaomenuDrawItem
      OnMeasureItem = MovimentosMeasureItem
      object ConfiguracaoGeral: TMenuItem
        Caption = 'Configura'#231#227'o Geral'
        OnClick = ConfiguracaoGeralClick
      end
      object Periodos1: TMenuItem
        Caption = 'Per'#237'odos'
        OnClick = Periodos1Click
      end
      object ConfiguraoDaUnidade1: TMenuItem
        Caption = 'Configura'#231#227'o Da Unidade'
        OnClick = ConfiguraoDaUnidade1Click
      end
    end
    object Utilitarios: TMenuItem
      Caption = '&Utilit'#225'rios'
      OnDrawItem = ConsignacaomenuDrawItem
      OnMeasureItem = MovimentosMeasureItem
      object SubstituioDeUsurio1: TMenuItem
        Tag = 1
        Caption = 'Troca De Usu'#225'rio'
        ShortCut = 16469
        OnClick = SubstituioDeUsurio1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object AlteraoDeSenha1: TMenuItem
        Tag = 1
        Caption = 'Altera'#231#227'o De Senha'
        OnClick = AlteraoDeSenha1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object UsuriosAtivos1: TMenuItem
        Tag = 1
        Caption = 'Usu'#225'rios Ativos'
        OnClick = UsuriosAtivos1Click
      end
      object ReorganizarBancoDados1: TMenuItem
        Caption = 'Reorganizar Banco Dados'
        OnClick = ReorganizarBancoDados1Click
      end
      object RelLogs1: TMenuItem
        Caption = 'Logs'
        OnClick = RelLogs1Click
      end
      object ImpviaSintegra1: TMenuItem
        Caption = 'Imp via Sintegra'
        OnClick = ImpviaSintegra1Click
      end
      object ImpEstoqueDbf1: TMenuItem
        Caption = 'Imp Estoque Dbf'
        OnClick = ImpEstoqueDbf1Click
      end
      object ImpEstoqueviaTexto1: TMenuItem
        Caption = 'Imp Estoque via Texto'
        OnClick = ImpEstoqueviaTexto1Click
      end
      object ImpClientesFornecFB1: TMenuItem
        Caption = 'Imp Clientes/Fornec. FB'
        OnClick = ImpClientesFornecFB1Click
      end
      object RenumeraNotas1: TMenuItem
        Caption = 'Renumera Notas'
        OnClick = RenumeraNotas1Click
      end
      object ImpContasGerenciais1: TMenuItem
        Caption = 'Imp Contas Gerenciais'
        OnClick = ImpContasGerenciais1Click
      end
      object CodigoBarra1: TMenuItem
        Caption = 'Codigo Barra'
        OnClick = CodigoBarra1Click
      end
      object ImpClientesTexto1: TMenuItem
        Caption = 'Imp Clientes Texto'
        OnClick = ImpClientesTexto1Click
      end
      object Transacoesduplicadas: TMenuItem
        Caption = 'Transa'#231#245'es Duplicadas'
        OnClick = TransacoesduplicadasClick
      end
      object ImpaReceberTexto1: TMenuItem
        Caption = 'Imp a Receber Texto'
        OnClick = ImpaReceberTexto1Click
      end
      object ExportaEstoqueMovel1: TMenuItem
        Caption = 'Exporta Estoque M'#243'vel'
        OnClick = ExportaEstoqueMovel1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object ExportaPortadoresCondPagto1: TMenuItem
        Caption = 'Exporta Portadores+Cond.Pagto'
        OnClick = ExportaPortadoresCondPagto1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object ExportaClientesMovel1: TMenuItem
        Caption = 'Exporta Clientes M'#243'vel'
        OnClick = ExportaClientesMovel1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object ImportaPedidosMvel1: TMenuItem
        Caption = 'Importa Pedidos M'#243'vel'
        OnClick = ImportaPedidosMvel1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
      object ImportaContagemEstoque1: TMenuItem
        Caption = 'Importa Contagem Estoque'
        OnClick = ImportaContagemEstoque1Click
      end
      object ImportaEstoqueXML1: TMenuItem
        Caption = 'Importa Estoque XML'
        OnClick = ImportaEstoqueXML1Click
        OnDrawItem = ConsignacaomenuDrawItem
        OnMeasureItem = MovimentosMeasureItem
      end
    end
    object Sair: TMenuItem
      Tag = 1
      Caption = '&Sair'
      OnClick = SairClick
      OnDrawItem = ConsignacaomenuDrawItem
      OnMeasureItem = MovimentosMeasureItem
    end
  end
  object KrHint1: KrHint
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Left = 328
    Top = 192
  end
  object TimerVendasCelular: TTimer
    Enabled = False
    Interval = 36000000
    OnTimer = TimerVendasCelularTimer
    Left = 488
    Top = 56
  end
end

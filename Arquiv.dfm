object Arq: TArq
  OldCreateOrder = False
  Height = 665
  Width = 789
  object Ambiente: TSQLEnv
    ShowException = True
    OnMessage = AmbienteMessage
    Btns.FontColorBlack = clBlack
    Btns.FontColorRed = clRed
    Btns.FontColorWhite = clWhite
    Btns.Transparent = True
    Btns.Flat = True
    Btns.ShowHint = True
    Btns.LayOut = blGlyphLeft
    Btns.Active = False
    Btns.Margin = 5
    Btns.Height = 25
    Btns.Width = 95
    Btns.Spacing = 2
    Btns.HintEdit = 'Altera o campo selecionado'
    Btns.HintInsert = 'Inclui um novo registro'
    Btns.HintReports = 'Emite o relat'#243'rio'
    Btns.HintFind = 'Pesquisa pelo campo selecionado'
    Btns.HintFilter = 'Ativa um filtro para o campo selecionado/Retira filtro'
    Btns.HintIndex = 'Ordena pelo campo selecionado'
    Btns.HintDelete = 'Insere marca'#231#227'o para exclus'#227'o do registro'
    Btns.HintCancel = 'Cancela a opera'#231#227'o em andamento'
    Btns.HintExit = 'Abandona a tela'
    Btns.HintPost = 'Efetiva a grava'#231#227'o'
    Btns.HintNext = 'Seleciona o pr'#243'ximo registro'
    Btns.HintPrior = 'Seleciona o registro anterior'
    Btns.HintColor = 'Acesso '#224' configura'#231#227'o de cores'
    Btns.HintFirst = 'Seleciona o primeiro registro'
    Btns.HintSaveGrid = 'Grava o formato atual da grade'
    Btns.HintLoadGrid = 'Restaura o formato padr'#227'o para a grade'
    Btns.HintLast = 'Seleciona o '#250'ltimo registro'
    Btns.HintEditAll = 'Edita o registro selecionado'
    Btns.HintConfirm = 'Efetiva o procedimento'
    Btns.HintExpColumn = 'Expande a coluna selecionada'
    Btns.HintRedColumn = 'Reduz a coluna selecionada'
    Btns.HintDelColumn = 'Apaga a coluna selecionada'
    Btns.HintRestColumn = 'Restaura todas as colunas'
    Btns.HintRestColor = 'Restaura padr'#227'o de cores'
    Btns.HintMoveLeftColumn = 'Move para a esquerda a coluna selecionda'
    Btns.HintMoveRightColumn = 'Move para a direita a coluna selecionada'
    Btns.HintRestaurar = 'Recupera todos os registros do servidor'
    Btns.CaptionEdit = '&Alterar'
    Btns.CaptionInsert = '&Incluir'
    Btns.CaptionReports = '&Relat'#243'rio'
    Btns.CaptionFind = '&Pesquisar'
    Btns.CaptionFilter = '&Filtrar'
    Btns.CaptionIndex = '&Ordenar'
    Btns.CaptionDelete = '&Excluir'
    Btns.CaptionCancel = '&Cancelar'
    Btns.CaptionExit = '&Sair'
    Btns.CaptionPost = '&Gravar'
    Btns.CaptionNext = 'Pro&ximo'
    Btns.CaptionPrior = 'A&nterior'
    Btns.CaptionFirst = 'Pri&meiro'
    Btns.CaptionLast = '&Ultimo'
    Btns.CaptionEditAll = 'E&ditar'
    Btns.CaptionConfirm = 'Confir&mar'
    Btns.CaptionRestaurar = 'Res&taurar'
    Btns.Font.Charset = DEFAULT_CHARSET
    Btns.Font.Color = clWindowText
    Btns.Font.Height = -11
    Btns.Font.Name = 'MS Sans Serif'
    Btns.Font.Style = [fsBold]
    PanelMessages = FMain.PMsg
    Version = '1.00'
    NameSystem = 'SAC'
    RegistrySystem = 'SAC'
    DuplicityInstance = False
    SQLUserName = 'sac'
    TypeServer = tsPostGreSQL
    Conexao = Ambiente.Conexao
    Left = 32
    Top = 376
  end
  object THistoricos: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 
      'SELECT HISTORICOS.* FROM HISTORICOS ORDER BY HISTORICOS.HIST_COD' +
      'IGO'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 10000
    Params = <>
    BeforeOpen = TRegioesBeforeOpen
    AfterApplyUpdates = TRegioesAfterApplyUdates
    TableName = 'HISTORICOS'
    TableFields = 'HISTORICOS.*'
    Ordenacao = 'HISTORICOS.HIST_CODIGO'
    CommandText = 
      'SELECT HISTORICOS.* FROM HISTORICOS ORDER BY HISTORICOS.HIST_COD' +
      'IGO'
    DBConnection = Ambiente.Conexao
    Left = 384
    Top = 8
  end
  object TEspecies: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT ESPECIES.* FROM ESPECIES'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 10000
    Params = <>
    BeforeOpen = TRegioesBeforeOpen
    AfterApplyUpdates = TRegioesAfterApplyUdates
    TableName = 'ESPECIES'
    TableFields = 'ESPECIES.*'
    CommandText = 'SELECT ESPECIES.* FROM ESPECIES'
    DBConnection = Ambiente.Conexao
    Left = 320
    Top = 8
  end
  object TRegioes: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT REGIOES.* FROM REGIOES'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 10000
    Params = <>
    TableName = 'REGIOES'
    TableFields = 'REGIOES.*'
    CommandText = 'SELECT REGIOES.* FROM REGIOES'
    DBConnection = Ambiente.Conexao
    Left = 16
    Top = 8
  end
  object TMunicipios: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 
      'SELECT * FROM cidades inner join regioes on regi_codigo = cida_r' +
      'egi_codigo ORDER BY CIDADES.CIDA_CODIGO'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 10000
    Params = <>
    BeforeOpen = TRegioesBeforeOpen
    AfterApplyUpdates = TRegioesAfterApplyUdates
    TableName = 'CIDADES'
    TableFields = '*'
    Ordenacao = 'CIDADES.CIDA_CODIGO'
    CommandText = 
      'SELECT * FROM cidades inner join regioes on regi_codigo = cida_r' +
      'egi_codigo ORDER BY CIDADES.CIDA_CODIGO'
    DBConnection = Ambiente.Conexao
    Left = 144
    Top = 72
  end
  object TFeriados: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT FERIADOS.* FROM FERIADOS ORDER BY FERIADOS.FERI_DATA'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 10000
    Params = <>
    BeforeOpen = TRegioesBeforeOpen
    AfterApplyUpdates = TRegioesAfterApplyUdates
    TableName = 'FERIADOS'
    TableFields = 'FERIADOS.*'
    Ordenacao = 'FERIADOS.FERI_DATA'
    CommandText = 'SELECT FERIADOS.* FROM FERIADOS ORDER BY FERIADOS.FERI_DATA'
    DBConnection = Ambiente.Conexao
    Left = 440
    Top = 8
  end
  object TXXInflacao: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT INFLACAO.* FROM INFLACAO ORDER BY INFLACAO.INFL_ANOMES'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 10000
    Params = <>
    BeforeOpen = TRegioesBeforeOpen
    AfterApplyUpdates = TRegioesAfterApplyUdates
    TableName = 'INFLACAO'
    TableFields = 'INFLACAO.*'
    Ordenacao = 'INFLACAO.INFL_ANOMES'
    CommandText = 'SELECT INFLACAO.* FROM INFLACAO ORDER BY INFLACAO.INFL_ANOMES'
    DBConnection = Ambiente.Conexao
    Left = 600
    Top = 16
  end
  object TNatFisc: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM NATUREZA ORDER BY NATF_CODIGO'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 10000
    Params = <>
    BeforeOpen = TRegioesBeforeOpen
    AfterApplyUpdates = TRegioesAfterApplyUdates
    TableName = 'NATUREZA'
    TableFields = '*'
    Ordenacao = 'NATF_CODIGO'
    CommandText = 'SELECT * FROM NATUREZA ORDER BY NATF_CODIGO'
    DBConnection = Ambiente.Conexao
    Left = 656
    Top = 16
  end
  object TPortadores: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT PORTADORES.* FROM PORTADORES'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 10000
    Params = <>
    BeforeOpen = TRegioesBeforeOpen
    AfterApplyUpdates = TRegioesAfterApplyUdates
    TableName = 'PORTADORES'
    TableFields = 'PORTADORES.*'
    CommandText = 'SELECT PORTADORES.* FROM PORTADORES'
    Left = 528
    Top = 72
  end
  object TLPgto: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT LPGTO.* FROM LPGTO'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 10000
    Params = <>
    TableName = 'LPGTO'
    TableFields = 'LPGTO.*'
    CommandText = 'SELECT LPGTO.* FROM LPGTO'
    DBConnection = Ambiente.Conexao
    Left = 64
    Top = 8
  end
  object TVendedores: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT VENDEDORES.* FROM VENDEDORES'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 10000
    Params = <>
    TableName = 'VENDEDORES'
    TableFields = 'VENDEDORES.*'
    CommandText = 'SELECT VENDEDORES.* FROM VENDEDORES'
    DBConnection = Ambiente.Conexao
    Left = 200
    Top = 8
  end
  object TMoedas: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT MOEDAS.* FROM MOEDAS'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 10000
    Params = <>
    BeforeOpen = TRegioesBeforeOpen
    AfterApplyUpdates = TRegioesAfterApplyUdates
    TableName = 'MOEDAS'
    TableFields = 'MOEDAS.*'
    CommandText = 'SELECT MOEDAS.* FROM MOEDAS'
    DBConnection = Ambiente.Conexao
    Left = 496
    Top = 16
  end
  object TFPgto: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT FPGTO.* FROM FPGTO'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 10000
    Params = <>
    BeforeOpen = TRegioesBeforeOpen
    AfterApplyUpdates = TRegioesAfterApplyUdates
    TableName = 'FPGTO'
    TableFields = 'FPGTO.*'
    CommandText = 'SELECT FPGTO.* FROM FPGTO'
    DBConnection = Ambiente.Conexao
    Left = 544
    Top = 8
  end
  object TImpressos: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT IMPRESSOS.* FROM IMPRESSOS'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 10000
    Params = <>
    TableName = 'IMPRESSOS'
    TableFields = 'IMPRESSOS.*'
    CommandText = 'SELECT IMPRESSOS.* FROM IMPRESSOS'
    DBConnection = Ambiente.Conexao
    Left = 16
    Top = 72
  end
  object TUnidades: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT UNIDADES.* FROM unidades ORDER BY unid_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 1000
    Params = <>
    TableName = 'UNIDADES'
    TableFields = 'UNIDADES.*'
    Ordenacao = 'unid_codigo'
    CommandText = 'SELECT UNIDADES.* FROM unidades ORDER BY unid_codigo'
    DBConnection = Ambiente.Conexao
    Left = 704
    Top = 16
  end
  object TGrUsuarios: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM GRUPOUSU'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    BeforeOpen = TRegioesBeforeOpen
    AfterApplyUpdates = TRegioesAfterApplyUdates
    TableName = 'GRUPOUSU'
    TableFields = '*'
    CommandText = 'SELECT * FROM GRUPOUSU'
    DBConnection = Ambiente.Conexao
    Left = 208
    Top = 72
  end
  object TUsuarios: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT USUARIOS.* FROM USUARIOS ORDER BY USUARIOS.USUA_CODIGO'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    TableName = 'USUARIOS'
    TableFields = 'USUARIOS.*'
    Ordenacao = 'USUARIOS.USUA_CODIGO'
    CommandText = 'SELECT USUARIOS.* FROM USUARIOS ORDER BY USUARIOS.USUA_CODIGO'
    DBConnection = Ambiente.Conexao
    Left = 272
    Top = 72
  end
  object TPlano: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 
      'SELECT PLANO.* FROM plano WHERE plan_tipo<>'#39'D'#39' ORDER BY PLANO.Pl' +
      'an_CLASSIFICACAO'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 10000
    Params = <>
    BeforeOpen = TRegioesBeforeOpen
    AfterApplyUpdates = TRegioesAfterApplyUdates
    TableName = 'PLANO'
    TableFields = 'PLANO.*'
    Condicao = 'plan_tipo<>'#39'D'#39
    Ordenacao = 'PLANO.Plan_CLASSIFICACAO'
    CommandText = 
      'SELECT PLANO.* FROM plano WHERE plan_tipo<>'#39'D'#39' ORDER BY PLANO.Pl' +
      'an_CLASSIFICACAO'
    DBConnection = Ambiente.Conexao
    Left = 464
    Top = 72
  end
  object TPlanoCon: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 
      'SELECT PLANOCON.* FROM PLANOCON ORDER BY PLANOCON.PCON_CLASSIFIC' +
      'ACAO'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    BeforeOpen = TRegioesBeforeOpen
    AfterOpen = TPlanoConAfterOpen
    TableName = 'PLANOCON'
    TableFields = 'PLANOCON.*'
    Ordenacao = 'PLANOCON.PCON_CLASSIFICACAO'
    CommandText = 
      'SELECT PLANOCON.* FROM PLANOCON ORDER BY PLANOCON.PCON_CLASSIFIC' +
      'ACAO'
    DBConnection = Ambiente.Conexao
    Left = 464
    Top = 136
  end
  object TCCustos: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 
      'SELECT ccst_codigo,ccst_descricao,ccst_reduzido FROM ccustos ORD' +
      'ER BY CCUSTOS.CCST_CODIGO'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 1000
    Params = <>
    BeforeOpen = TRegioesBeforeOpen
    AfterOpen = TCCustosAfterOpen
    AfterApplyUpdates = TRegioesAfterApplyUdates
    TableName = 'CCUSTOS'
    TableFields = 'ccst_codigo,ccst_descricao,ccst_reduzido'
    Ordenacao = 'CCUSTOS.CCST_CODIGO'
    CommandText = 
      'SELECT ccst_codigo,ccst_descricao,ccst_reduzido FROM ccustos ORD' +
      'ER BY CCUSTOS.CCST_CODIGO'
    DBConnection = Ambiente.Conexao
    Left = 328
    Top = 72
  end
  object TCodBancarios: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT CODBANCARIOS.* FROM CODBANCARIOS'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 10000
    Params = <>
    TableName = 'CODBANCARIOS'
    TableFields = 'CODBANCARIOS.*'
    CommandText = 'SELECT CODBANCARIOS.* FROM CODBANCARIOS'
    DBConnection = Ambiente.Conexao
    Left = 128
    Top = 8
  end
  object TEmpresas: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT EMPRESAS.* FROM EMPRESAS'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 10000
    Params = <>
    BeforeOpen = TRegioesBeforeOpen
    AfterApplyUpdates = TRegioesAfterApplyUdates
    TableName = 'EMPRESAS'
    TableFields = 'EMPRESAS.*'
    CommandText = 'SELECT EMPRESAS.* FROM EMPRESAS'
    DBConnection = Ambiente.Conexao
    Left = 80
    Top = 72
  end
  object TTransp: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM transportadores ORDER BY tran_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 10000
    Params = <>
    BeforeOpen = TRegioesBeforeOpen
    AfterApplyUpdates = TRegioesAfterApplyUdates
    TableName = 'TRANSPORTADORES'
    TableFields = '*'
    Ordenacao = 'tran_codigo'
    CommandText = 'SELECT * FROM transportadores ORDER BY tran_codigo'
    DBConnection = Ambiente.Conexao
    Left = 408
    Top = 72
  end
  object TFornec: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM FORNECEDORES ORDER BY FORNECEDORES.FORN_CODIGO'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    BeforeOpen = TRegioesBeforeOpen
    AfterOpen = TFornecAfterOpen
    BeforeApplyUpdates = TFornecBeforeApplyUpdates
    TableName = 'FORNECEDORES'
    TableFields = '*'
    Ordenacao = 'FORNECEDORES.FORN_CODIGO'
    CommandText = 'SELECT * FROM FORNECEDORES ORDER BY FORNECEDORES.FORN_CODIGO'
    DBConnection = Ambiente.Conexao
    Left = 680
    Top = 136
  end
  object TClientes: TSQLDs
    Aggregates = <>
    DataSet.BeforeOpen = TClientesInternalDataSetBeforeOpen
    DataSet.CommandText = 'SELECT CLIENTES.* FROM CLIENTES ORDER BY CLIENTES.CLIE_CODIGO'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 500
    Params = <>
    BeforeOpen = TRegioesBeforeOpen
    AfterOpen = TClientesAfterOpen
    TableName = 'CLIENTES'
    TableFields = 'CLIENTES.*'
    Ordenacao = 'CLIENTES.CLIE_CODIGO'
    CommandText = 'SELECT CLIENTES.* FROM CLIENTES ORDER BY CLIENTES.CLIE_CODIGO'
    DBConnection = Ambiente.Conexao
    Left = 608
    Top = 144
  end
  object TBloqueios: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 
      'SELECT MOTBLOQUEIOS.* FROM motbloqueios ORDER BY MOTBLOQUEIOS.mo' +
      'bl_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 20
    Params = <>
    TableName = 'motbloqueios'
    TableFields = 'MOTBLOQUEIOS.*'
    Ordenacao = 'MOTBLOQUEIOS.mobl_codigo'
    CommandText = 
      'SELECT MOTBLOQUEIOS.* FROM motbloqueios ORDER BY MOTBLOQUEIOS.mo' +
      'bl_codigo'
    DBConnection = Ambiente.Conexao
    Left = 272
    Top = 152
  end
  object TDepartamentos: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM DEPARTAMENTOS'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 1000
    Params = <>
    BeforeOpen = TRegioesBeforeOpen
    AfterApplyUpdates = TRegioesAfterApplyUdates
    TableName = 'DEPARTAMENTOS'
    TableFields = '*'
    CommandText = 'SELECT * FROM DEPARTAMENTOS'
    DBConnection = Ambiente.Conexao
    Left = 696
    Top = 72
  end
  object TCNAB: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT CNAB.* FROM CNAB'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 10000
    Params = <>
    AfterApplyUpdates = TRegioesAfterApplyUdates
    TableName = 'CNAB'
    TableFields = 'CNAB.*'
    CommandText = 'SELECT CNAB.* FROM CNAB'
    DBConnection = Ambiente.Conexao
    Left = 344
    Top = 152
  end
  object TPlanoGer2: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 
      'SELECT PLANO.PLAN_CLASSIFICACAO,PLANO.PLAN_DESCRICAO,PLANO.PLAN_' +
      'CONTA,PLANO.PLAN_TIPO FROM PLANO ORDER BY PLANO.PLAN_CLASSIFICAC' +
      'AO'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    BeforeOpen = TRegioesBeforeOpen
    AfterOpen = TPlanoGer2AfterOpen
    AfterApplyUpdates = TRegioesAfterApplyUdates
    TableName = 'PLANO'
    TableFields = 
      'PLANO.PLAN_CLASSIFICACAO,PLANOGER.PGER_DESCRICAO,PLANOGER.PGER_C' +
      'ONTA,PLANOGER.PGER_TIPO,PLANOGER.PGER_CONTACONTABIL'
    Ordenacao = 'PLANO.PLAN_CLASSIFICACAO'
    CommandText = 
      'SELECT PLANO.PLAN_CLASSIFICACAO,PLANO.PLAN_DESCRICAO,PLANO.PLAN_' +
      'CONTA,PLANO.PLAN_TIPO FROM PLANO ORDER BY PLANO.PLAN_CLASSIFICAC' +
      'AO'
    DBConnection = Ambiente.Conexao
    Left = 536
    Top = 140
  end
  object TImpedimentos: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM IMPEDIMENTOS'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 100
    Params = <>
    AfterOpen = TImpedimentosAfterOpen
    TableName = 'IMPEDIMENTOS'
    TableFields = '*'
    CommandText = 'SELECT * FROM IMPEDIMENTOS'
    DBConnection = Ambiente.Conexao
    Left = 600
    Top = 72
  end
  object TSittributaria: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM SITTRIB ORDER BY SITT_CODIGO'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 100
    Params = <>
    TableName = 'SITTRIB'
    TableFields = '*'
    Ordenacao = 'SITT_CODIGO'
    CommandText = 'SELECT * FROM SITTRIB ORDER BY SITT_CODIGO'
    DBConnection = Ambiente.Conexao
    Left = 16
    Top = 152
  end
  object TchuRepresentantes: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM representantes ORDER BY REPR_CODIGO'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 10000
    Params = <>
    TableName = 'REPRESENTANTES'
    TableFields = '*'
    Ordenacao = 'REPR_CODIGO'
    CommandText = 'SELECT * FROM representantes ORDER BY REPR_CODIGO'
    DBConnection = Ambiente.Conexao
    Left = 104
    Top = 152
  end
  object TReferencias: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM referencias ORDER BY REFERENCIAS.refc_chave'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 20
    Params = <>
    TableName = 'referencias'
    TableFields = '*'
    Ordenacao = 'REFERENCIAS.refc_chave'
    CommandText = 'SELECT * FROM referencias ORDER BY REFERENCIAS.refc_chave'
    DBConnection = Ambiente.Conexao
    Left = 192
    Top = 152
  end
  object TCores: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM cores ORDER BY CORES.core_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 500
    Params = <>
    TableName = 'cores'
    TableFields = '*'
    Ordenacao = 'CORES.core_codigo'
    CommandText = 'SELECT * FROM cores ORDER BY CORES.core_codigo'
    DBConnection = Ambiente.Conexao
    Left = 16
    Top = 216
  end
  object TTamanhos: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM tamanhos ORDER BY TAMANHOS.tama_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 100
    Params = <>
    TableName = 'tamanhos'
    TableFields = '*'
    Ordenacao = 'TAMANHOS.tama_codigo'
    CommandText = 'SELECT * FROM tamanhos ORDER BY TAMANHOS.tama_codigo'
    DBConnection = Ambiente.Conexao
    Left = 72
    Top = 216
  end
  object TGrupos: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT GRUPOS.* FROM grupos ORDER BY GRUPOS.grup_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 200
    Params = <>
    TableName = 'grupos'
    TableFields = 'GRUPOS.*'
    Ordenacao = 'GRUPOS.grup_codigo'
    CommandText = 'SELECT GRUPOS.* FROM grupos ORDER BY GRUPOS.grup_codigo'
    DBConnection = Ambiente.Conexao
    Left = 176
    Top = 216
  end
  object TSubgrupos: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT SUBGRUPOS.* FROM subgrupos ORDER BY SUBGRUPOS.sugr_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 200
    Params = <>
    TableName = 'subgrupos'
    TableFields = 'SUBGRUPOS.*'
    Ordenacao = 'SUBGRUPOS.sugr_codigo'
    CommandText = 'SELECT SUBGRUPOS.* FROM subgrupos ORDER BY SUBGRUPOS.sugr_codigo'
    DBConnection = Ambiente.Conexao
    Left = 240
    Top = 216
  end
  object TGrades: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT GRADES.* FROM grades ORDER BY GRADES.grad_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 100
    Params = <>
    TableName = 'GRADES'
    TableFields = 'GRADES.*'
    Ordenacao = 'GRADES.grad_codigo'
    CommandText = 'SELECT GRADES.* FROM grades ORDER BY GRADES.grad_codigo'
    DBConnection = Ambiente.Conexao
    Left = 312
    Top = 216
  end
  object TEstoque: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM estoque ORDER BY ESTOQUE.esto_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 5000
    Params = <>
    TableName = 'estoque'
    TableFields = '*'
    Ordenacao = 'ESTOQUE.esto_codigo'
    CommandText = 'SELECT * FROM estoque ORDER BY ESTOQUE.esto_codigo'
    DBConnection = Ambiente.Conexao
    Left = 376
    Top = 216
  end
  object TFamilias: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT FAMILIAS.* FROM familias ORDER BY familias.fami_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 200
    Params = <>
    TableName = 'familias'
    TableFields = 'FAMILIAS.*'
    Ordenacao = 'familias.fami_codigo'
    CommandText = 'SELECT FAMILIAS.* FROM familias ORDER BY familias.fami_codigo'
    DBConnection = Ambiente.Conexao
    Left = 456
    Top = 216
  end
  object TCodigosFiscais: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM codigosfis ORDER BY cfis_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 100
    Params = <>
    TableName = 'codigosfis'
    TableFields = '*'
    Ordenacao = 'cfis_codigo'
    CommandText = 'SELECT * FROM codigosfis ORDER BY cfis_codigo'
    DBConnection = Ambiente.Conexao
    Left = 536
    Top = 216
  end
  object TTabelaPreco: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT TABELAPRECO.* FROM tabelapreco ORDER BY tabp_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 100
    Params = <>
    TableName = 'tabelapreco'
    TableFields = 'TABELAPRECO.*'
    Ordenacao = 'tabp_codigo'
    CommandText = 'SELECT TABELAPRECO.* FROM tabelapreco ORDER BY tabp_codigo'
    DBConnection = Ambiente.Conexao
    Left = 616
    Top = 216
  end
  object TEstoqueQtde: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 
      'SELECT * FROM ESTOQUEQTDE WHERE esqt_status='#39'N'#39' ORDER BY esqt_un' +
      'id_codigo,esqt_esto_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'ESQT_UNID_CODIGO;ESQT_ESTO_CODIGO'
    Params = <>
    StoreDefs = True
    TableName = 'EstoqueQtde'
    TableFields = '*'
    Condicao = 'esqt_status='#39'N'#39
    Ordenacao = 'esqt_unid_codigo,esqt_esto_codigo'
    CommandText = 
      'SELECT * FROM ESTOQUEQTDE WHERE esqt_status='#39'N'#39' ORDER BY esqt_un' +
      'id_codigo,esqt_esto_codigo'
    DBConnection = Ambiente.Conexao
    Left = 395
    Top = 264
  end
  object TConfMovimento: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT Confmov.* FROM CONFMOV ORDER BY comv_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    TableName = 'Confmov'
    TableFields = 'Confmov.*'
    Ordenacao = 'comv_codigo'
    CommandText = 'SELECT Confmov.* FROM CONFMOV ORDER BY comv_codigo'
    DBConnection = Ambiente.Conexao
    Left = 699
    Top = 216
  end
  object TSalEstoque: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 
      'SELECT saes_status,saes_mesano,saes_unid_codigo,saes_esto_codigo' +
      ',saes_tama_codigo,saes_core_codigo,saes_custo,saes_custoger,saes' +
      '_customedio,saes_customeger,saes_entradas,saes_saidas,saes_qtde,' +
      'saes_qtdeprev,saes_qtdeconsig,saes_qtdepronta,saes_qtderegesp,sa' +
      'es_usua_codigo,saes_vendavis,saes_copa_codigo,saes_pecas FROM sa' +
      'lestoque WHERE saes_status='#39'N'#39' ORDER BY saes_mesano,saes_unid_co' +
      'digo,saes_esto_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    FieldDefs = <
      item
        Name = 'saes_status'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'saes_mesano'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'saes_unid_codigo'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'saes_esto_codigo'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'saes_tama_codigo'
        DataType = ftFMTBcd
        Precision = 5
        Size = 4
      end
      item
        Name = 'saes_core_codigo'
        DataType = ftFMTBcd
        Precision = 3
        Size = 4
      end
      item
        Name = 'saes_custo'
        DataType = ftFMTBcd
        Precision = 12
        Size = 2
      end
      item
        Name = 'saes_custoger'
        DataType = ftFMTBcd
        Precision = 12
        Size = 2
      end
      item
        Name = 'saes_customedio'
        DataType = ftFMTBcd
        Precision = 12
        Size = 2
      end
      item
        Name = 'saes_customeger'
        DataType = ftFMTBcd
        Precision = 12
        Size = 2
      end
      item
        Name = 'saes_entradas'
        DataType = ftFMTBcd
        Precision = 12
        Size = 3
      end
      item
        Name = 'saes_saidas'
        DataType = ftFMTBcd
        Precision = 12
        Size = 3
      end
      item
        Name = 'saes_qtde'
        DataType = ftFMTBcd
        Precision = 12
        Size = 3
      end
      item
        Name = 'saes_qtdeprev'
        DataType = ftFMTBcd
        Precision = 12
        Size = 3
      end
      item
        Name = 'saes_qtdeconsig'
        DataType = ftFMTBcd
        Precision = 12
        Size = 3
      end
      item
        Name = 'saes_qtdepronta'
        DataType = ftFMTBcd
        Precision = 12
        Size = 3
      end
      item
        Name = 'saes_qtderegesp'
        DataType = ftFMTBcd
        Precision = 12
        Size = 3
      end
      item
        Name = 'saes_usua_codigo'
        DataType = ftFMTBcd
        Precision = 3
        Size = 4
      end
      item
        Name = 'saes_vendavis'
        DataType = ftFMTBcd
        Precision = 12
        Size = 2
      end
      item
        Name = 'saes_copa_codigo'
        DataType = ftFMTBcd
        Precision = 3
        Size = 4
      end
      item
        Name = 'saes_pecas'
        DataType = ftFMTBcd
        Precision = 12
        Size = 3
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    TableName = 'Salestoque'
    TableFields = 
      'saes_status,saes_mesano,saes_unid_codigo,saes_esto_codigo,saes_t' +
      'ama_codigo,saes_core_codigo,saes_custo,saes_custoger,saes_custom' +
      'edio,saes_customeger,saes_entradas,saes_saidas,saes_qtde,saes_qt' +
      'deprev,saes_qtdeconsig,saes_qtdepronta,saes_qtderegesp,saes_usua' +
      '_codigo,saes_vendavis,saes_copa_codigo,saes_pecas'
    Condicao = 'saes_status='#39'N'#39
    Ordenacao = 'saes_mesano,saes_unid_codigo,saes_esto_codigo'
    CommandText = 
      'SELECT saes_status,saes_mesano,saes_unid_codigo,saes_esto_codigo' +
      ',saes_tama_codigo,saes_core_codigo,saes_custo,saes_custoger,saes' +
      '_customedio,saes_customeger,saes_entradas,saes_saidas,saes_qtde,' +
      'saes_qtdeprev,saes_qtdeconsig,saes_qtdepronta,saes_qtderegesp,sa' +
      'es_usua_codigo,saes_vendavis,saes_copa_codigo,saes_pecas FROM sa' +
      'lestoque WHERE saes_status='#39'N'#39' ORDER BY saes_mesano,saes_unid_co' +
      'digo,saes_esto_codigo'
    DBConnection = Ambiente.Conexao
    Left = 451
    Top = 272
  end
  object TMaterial: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM MATERIAL ORDER BY mate_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    FieldDefs = <
      item
        Name = 'mate_codigo'
        DataType = ftFMTBcd
        Precision = 4
        Size = 4
      end
      item
        Name = 'mate_descricao'
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    TableName = 'material'
    TableFields = '*'
    Ordenacao = 'mate_codigo'
    CommandText = 'SELECT * FROM MATERIAL ORDER BY mate_codigo'
    DBConnection = Ambiente.Conexao
    Left = 19
    Top = 272
  end
  object TCotasRepr: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM SALESTOQUE ORDER BY core_mesano,coes_repr_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    FieldDefs = <
      item
        Name = 'saes_status'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'saes_mesano'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'saes_unid_codigo'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'saes_esto_codigo'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'saes_custo'
        DataType = ftFMTBcd
        Precision = 12
        Size = 2
      end
      item
        Name = 'saes_custoger'
        DataType = ftFMTBcd
        Precision = 12
        Size = 2
      end
      item
        Name = 'saes_customedio'
        DataType = ftFMTBcd
        Precision = 12
        Size = 2
      end
      item
        Name = 'saes_customeger'
        DataType = ftFMTBcd
        Precision = 12
        Size = 2
      end
      item
        Name = 'saes_entradas'
        DataType = ftFMTBcd
        Precision = 12
        Size = 3
      end
      item
        Name = 'saes_saidas'
        DataType = ftFMTBcd
        Precision = 12
        Size = 3
      end
      item
        Name = 'saes_qtde'
        DataType = ftFMTBcd
        Precision = 12
        Size = 3
      end
      item
        Name = 'saes_qtdeprev'
        DataType = ftFMTBcd
        Precision = 12
        Size = 3
      end
      item
        Name = 'saes_usua_codigo'
        DataType = ftFMTBcd
        Precision = 3
        Size = 4
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    TableName = 'Salestoque'
    TableFields = '*'
    Ordenacao = 'core_mesano,coes_repr_codigo'
    CommandText = 'SELECT * FROM SALESTOQUE ORDER BY core_mesano,coes_repr_codigo'
    DBConnection = Ambiente.Conexao
    Left = 515
    Top = 272
  end
  object TMensagensNF: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM mensagensnf ORDER BY mens_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    FieldDefs = <
      item
        Name = 'mate_codigo'
        DataType = ftFMTBcd
        Precision = 4
        Size = 4
      end
      item
        Name = 'mate_descricao'
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    TableName = 'mensagensnf'
    TableFields = '*'
    Ordenacao = 'mens_codigo'
    CommandText = 'SELECT * FROM mensagensnf ORDER BY mens_codigo'
    DBConnection = Ambiente.Conexao
    Left = 91
    Top = 272
  end
  object TCadocorrencias: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM cadocorrencias ORDER BY caoc_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    FieldDefs = <
      item
        Name = 'caoc_codigo'
        DataType = ftFMTBcd
        Precision = 3
        Size = 4
      end
      item
        Name = 'caoc_descricao'
        DataType = ftWideString
        Size = 80
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    TableName = 'cadocorrencias'
    TableFields = '*'
    Ordenacao = 'caoc_codigo'
    CommandText = 'SELECT * FROM cadocorrencias ORDER BY caoc_codigo'
    DBConnection = Ambiente.Conexao
    Left = 195
    Top = 272
  end
  object TCheques: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM cheques ORDER BY cheq_predata'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    FieldDefs = <
      item
        Name = 'cheq_status'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'cheq_emirec'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'cheq_bcoemitente'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'cheq_cheque'
        DataType = ftString
        Size = 12
      end
      item
        Name = 'cheq_emitente'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'cheq_emissao'
        DataType = ftDate
      end
      item
        Name = 'cheq_predata'
        DataType = ftDate
      end
      item
        Name = 'cheq_valor'
        DataType = ftFMTBcd
        Precision = 12
        Size = 2
      end
      item
        Name = 'cheq_datacont'
        DataType = ftDate
      end
      item
        Name = 'cheq_repr_codigo'
        DataType = ftFMTBcd
        Precision = 4
        Size = 4
      end
      item
        Name = 'cheq_repr_codigoant'
        DataType = ftFMTBcd
        Precision = 4
        Size = 4
      end
      item
        Name = 'cheq_unid_codigo'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'cheq_deposito'
        DataType = ftDate
      end
      item
        Name = 'cheq_prorroga'
        DataType = ftDate
      end
      item
        Name = 'cheq_lancto'
        DataType = ftDate
      end
      item
        Name = 'cheq_obs'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'cheq_devolvido'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'cheq_tipo_codigo'
        DataType = ftFMTBcd
        Precision = 7
        Size = 4
      end
      item
        Name = 'cheq_tipocad'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'cheq_emit_banco'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'cheq_emit_agencia'
        DataType = ftFMTBcd
        Precision = 10
        Size = 4
      end
      item
        Name = 'cheq_emit_conta'
        DataType = ftFMTBcd
        Precision = 15
        Size = 4
      end
      item
        Name = 'cheq_rc'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'cheq_cmc7'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'cheq_plan_contadep'
        DataType = ftFMTBcd
        Precision = 8
        Size = 4
      end
      item
        Name = 'cheq_remessa'
        DataType = ftFMTBcd
        Precision = 8
        Size = 4
      end
      item
        Name = 'cheq_dtremessa'
        DataType = ftDate
      end
      item
        Name = 'cheq_valorrec'
        DataType = ftFMTBcd
        Precision = 12
        Size = 2
      end
      item
        Name = 'cheq_bancocustodia'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'cheq_cnpjcpf'
        DataType = ftString
        Size = 14
      end>
    IndexDefs = <>
    PacketRecords = 500
    Params = <>
    StoreDefs = True
    TableName = 'cheques'
    TableFields = '*'
    Ordenacao = 'cheq_predata'
    CommandText = 'SELECT * FROM cheques ORDER BY cheq_predata'
    DBConnection = Ambiente.Conexao
    Left = 91
    Top = 328
  end
  object TCopas: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM copas ORDER BY COPAS.copa_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 500
    Params = <>
    TableName = 'copas'
    TableFields = '*'
    Ordenacao = 'COPAS.copa_codigo'
    CommandText = 'SELECT * FROM copas ORDER BY COPAS.copa_codigo'
    DBConnection = Ambiente.Conexao
    Left = 123
    Top = 216
  end
  object TCodigosipi: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM codigosipi ORDER BY cipi_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    PacketRecords = 1000
    Params = <>
    TableName = 'codigosipi'
    TableFields = '*'
    Ordenacao = 'cipi_codigo'
    CommandText = 'SELECT * FROM codigosipi ORDER BY cipi_codigo'
    DBConnection = Ambiente.Conexao
    Left = 272
    Top = 277
  end
  object TEmitentes: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT EMITENTES.* FROM emitentes ORDER BY emit_agencia'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    FieldDefs = <
      item
        Name = 'emit_banco'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'emit_agencia'
        DataType = ftFMTBcd
        Precision = 10
        Size = 4
      end
      item
        Name = 'emit_conta'
        DataType = ftFMTBcd
        Precision = 15
        Size = 4
      end
      item
        Name = 'emit_descricao'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'emit_cheq_cnpjcpf'
        DataType = ftString
        Size = 14
      end>
    IndexDefs = <>
    PacketRecords = 10000
    Params = <>
    StoreDefs = True
    TableName = 'emitentes'
    TableFields = 'EMITENTES.*'
    Ordenacao = 'emit_agencia'
    CommandText = 'SELECT EMITENTES.* FROM emitentes ORDER BY emit_agencia'
    DBConnection = Ambiente.Conexao
    Left = 163
    Top = 328
  end
  object TOrcamentos: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM orcamentos ORDER BY orca_dataretorno'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    FieldDefs = <
      item
        Name = 'orca_numerodoc'
        DataType = ftFMTBcd
        Precision = 8
        Size = 4
      end
      item
        Name = 'orca_status'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'orca_situacao'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'orca_unid_codigo'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'orca_tipo_codigo'
        DataType = ftFMTBcd
        Precision = 7
        Size = 4
      end
      item
        Name = 'orca_tipocad'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'orca_repr_codigo'
        DataType = ftFMTBcd
        Precision = 4
        Size = 4
      end
      item
        Name = 'orca_datalcto'
        DataType = ftDate
      end
      item
        Name = 'orca_datamvto'
        DataType = ftDate
      end
      item
        Name = 'orca_dataretorno'
        DataType = ftDate
      end
      item
        Name = 'orca_cliente1'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'orca_cliente2'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'orca_obra'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'orca_linha'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'orca_area'
        DataType = ftFMTBcd
        Precision = 12
        Size = 3
      end
      item
        Name = 'orca_peso'
        DataType = ftFMTBcd
        Precision = 12
        Size = 3
      end
      item
        Name = 'orca_valor'
        DataType = ftFMTBcd
        Precision = 12
        Size = 3
      end
      item
        Name = 'orca_datafecha'
        DataType = ftDate
      end
      item
        Name = 'orca_obs'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'orca_usua_codigo'
        DataType = ftFMTBcd
        Precision = 3
        Size = 4
      end
      item
        Name = 'orca_fone'
        DataType = ftString
        Size = 11
      end
      item
        Name = 'orca_celular'
        DataType = ftString
        Size = 11
      end
      item
        Name = 'orca_nroobra'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'orca_dtprevisaoent'
        DataType = ftDate
      end
      item
        Name = 'orca_dtentrega'
        DataType = ftDate
      end>
    IndexDefs = <>
    PacketRecords = 500
    Params = <>
    StoreDefs = True
    TableName = 'orcamentos'
    TableFields = '*'
    Ordenacao = 'orca_dataretorno'
    CommandText = 'SELECT * FROM orcamentos ORDER BY orca_dataretorno'
    DBConnection = Ambiente.Conexao
    Left = 259
    Top = 328
  end
  object TSetores: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 
      'SELECT seto_codigo,seto_descricao,seto_usua_codigo FROM setores ' +
      'ORDER BY seto_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    FieldDefs = <
      item
        Name = 'seto_codigo'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'seto_descricao'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'seto_usua_codigo'
        DataType = ftFMTBcd
        Precision = 3
        Size = 4
      end>
    IndexDefs = <>
    PacketRecords = 500
    Params = <>
    StoreDefs = True
    TableName = 'setores'
    TableFields = 'seto_codigo,seto_descricao,seto_usua_codigo'
    Ordenacao = 'seto_codigo'
    CommandText = 
      'SELECT seto_codigo,seto_descricao,seto_usua_codigo FROM setores ' +
      'ORDER BY seto_codigo'
    DBConnection = Ambiente.Conexao
    Left = 323
    Top = 320
  end
  object TServicos: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM cadmobra ORDER BY cadm_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    FieldDefs = <
      item
        Name = 'cadm_codigo'
        DataType = ftFMTBcd
        Precision = 5
        Size = 4
      end
      item
        Name = 'cadm_descricao'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'cadm_unitario'
        DataType = ftFMTBcd
        Precision = 12
        Size = 4
      end
      item
        Name = 'cadm_unidade'
        DataType = ftWideString
        Size = 5
      end
      item
        Name = 'cadm_somatotal'
        DataType = ftWideString
        Size = 1
      end
      item
        Name = 'cadm_incideinss'
        DataType = ftWideString
        Size = 1
      end
      item
        Name = 'cadm_pulalinha'
        DataType = ftFMTBcd
        Precision = 2
        Size = 4
      end>
    IndexDefs = <>
    PacketRecords = 500
    Params = <>
    StoreDefs = True
    TableName = 'cadmobra'
    TableFields = '*'
    Ordenacao = 'cadm_codigo'
    CommandText = 'SELECT * FROM cadmobra ORDER BY cadm_codigo'
    DBConnection = Ambiente.Conexao
    Left = 379
    Top = 328
  end
  object TTiposNota: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM tiposnota ORDER BY tipn_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    FieldDefs = <
      item
        Name = 'tipn_codigo'
        DataType = ftFMTBcd
        Precision = 5
        Size = 4
      end
      item
        Name = 'tipn_descricao'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'tipn_incidencias'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    PacketRecords = 500
    Params = <>
    StoreDefs = True
    TableName = 'tiposnota'
    TableFields = '*'
    Ordenacao = 'tipn_codigo'
    CommandText = 'SELECT * FROM tiposnota ORDER BY tipn_codigo'
    DBConnection = Ambiente.Conexao
    Left = 435
    Top = 328
  end
  object TIndicadores: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 
      'SELECT indi_codigo,indi_descricao,indi_usua_codigo,indi_usua_res' +
      'p,indi_diainfo,indi_unidade FROM indicadores ORDER BY indi_codig' +
      'o'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    FieldDefs = <
      item
        Name = 'indi_codigo'
        DataType = ftFMTBcd
        Precision = 5
        Size = 4
      end
      item
        Name = 'indi_descricao'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'indi_usua_codigo'
        DataType = ftFMTBcd
        Precision = 3
        Size = 4
      end
      item
        Name = 'indi_usua_resp'
        DataType = ftFMTBcd
        Precision = 3
        Size = 4
      end
      item
        Name = 'indi_diainfo'
        DataType = ftFMTBcd
        Precision = 2
        Size = 4
      end
      item
        Name = 'indi_unidade'
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    PacketRecords = 500
    Params = <>
    StoreDefs = True
    TableName = 'indicadores'
    TableFields = 
      'indi_codigo,indi_descricao,indi_usua_codigo,indi_usua_resp,indi_' +
      'diainfo,indi_unidade'
    Ordenacao = 'indi_codigo'
    CommandText = 
      'SELECT indi_codigo,indi_descricao,indi_usua_codigo,indi_usua_res' +
      'p,indi_diainfo,indi_unidade FROM indicadores ORDER BY indi_codig' +
      'o'
    DBConnection = Ambiente.Conexao
    Left = 491
    Top = 328
  end
  object TRepresentantes: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT REPRESENTANTES.* FROM representantes ORDER BY REPR_CODIGO'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    TableName = 'REPRESENTANTES'
    TableFields = 'REPRESENTANTES.*'
    Ordenacao = 'REPR_CODIGO'
    CommandText = 'SELECT REPRESENTANTES.* FROM representantes ORDER BY REPR_CODIGO'
    DBConnection = Ambiente.Conexao
    Left = 576
    Top = 328
  end
  object TabelaComissao: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 
      'SELECT * FROM tabcomissao WHERE tabc_status='#39'N'#39' ORDER BY tabc_se' +
      'q,Tabc_Repr_TipoRepr'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    FieldDefs = <
      item
        Name = 'tabc_status'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'tabc_seq'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'tabc_inicio'
        DataType = ftFMTBcd
        Precision = 11
        Size = 2
      end
      item
        Name = 'tabc_fim'
        DataType = ftFMTBcd
        Precision = 11
        Size = 2
      end
      item
        Name = 'tabc_faixa'
        DataType = ftFMTBcd
        Precision = 11
        Size = 2
      end
      item
        Name = 'tabc_usua_codigo'
        DataType = ftFMTBcd
        Precision = 3
        Size = 4
      end
      item
        Name = 'tabc_dtlancto'
        DataType = ftDate
      end
      item
        Name = 'tabc_repr_tiporepr'
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    PacketRecords = 500
    Params = <>
    StoreDefs = True
    TableName = 'tabcomissao'
    TableFields = '*'
    Condicao = 'tabc_status='#39'N'#39
    Ordenacao = 'tabc_seq,Tabc_Repr_TipoRepr'
    CommandText = 
      'SELECT * FROM tabcomissao WHERE tabc_status='#39'N'#39' ORDER BY tabc_se' +
      'q,Tabc_Repr_TipoRepr'
    DBConnection = Ambiente.Conexao
    Left = 587
    Top = 272
  end
  object TColaboradores: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM colaboradores ORDER BY cola_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    FieldDefs = <
      item
        Name = 'cola_codigo'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'cola_descricao'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'cola_usua_codigo'
        DataType = ftFMTBcd
        Precision = 3
        Size = 4
      end
      item
        Name = 'cola_seto_codigo'
        DataType = ftString
        Size = 4
      end>
    IndexDefs = <>
    PacketRecords = 500
    Params = <>
    StoreDefs = True
    TableName = 'colaboradores'
    TableFields = '*'
    Ordenacao = 'cola_codigo'
    CommandText = 'SELECT * FROM colaboradores ORDER BY cola_codigo'
    DBConnection = Ambiente.Conexao
    Left = 659
    Top = 328
  end
  object TNutricionais: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM nutricionais ORDER BY nutr_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    FieldDefs = <
      item
        Name = 'nutr_codigo'
        DataType = ftFMTBcd
        Precision = 8
        Size = 4
      end
      item
        Name = 'nutr_nomebalanca'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'nutr_porcaocaseira'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'nutr_qtdeporcao'
        DataType = ftFMTBcd
        Precision = 10
        Size = 3
      end
      item
        Name = 'nutr_unporcao'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'nutr_balanca'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'nutr_fator'
        DataType = ftFMTBcd
        Precision = 10
        Size = 3
      end
      item
        Name = 'nutr_calorias'
        DataType = ftFMTBcd
        Precision = 10
        Size = 3
      end
      item
        Name = 'nutr_carboidratos'
        DataType = ftFMTBcd
        Precision = 10
        Size = 3
      end
      item
        Name = 'nutr_proteinas'
        DataType = ftFMTBcd
        Precision = 10
        Size = 3
      end
      item
        Name = 'nutr_gordtotais'
        DataType = ftFMTBcd
        Precision = 10
        Size = 3
      end
      item
        Name = 'nutr_gordsaturadas'
        DataType = ftFMTBcd
        Precision = 10
        Size = 3
      end
      item
        Name = 'nutr_fibras'
        DataType = ftFMTBcd
        Precision = 10
        Size = 3
      end
      item
        Name = 'nutr_colesterol'
        DataType = ftFMTBcd
        Precision = 10
        Size = 3
      end
      item
        Name = 'nutr_calcio'
        DataType = ftFMTBcd
        Precision = 10
        Size = 3
      end
      item
        Name = 'nutr_ferro'
        DataType = ftFMTBcd
        Precision = 10
        Size = 3
      end
      item
        Name = 'nutr_sodio'
        DataType = ftFMTBcd
        Precision = 10
        Size = 3
      end
      item
        Name = 'nutr_qtde'
        DataType = ftFMTBcd
        Precision = 10
        Size = 3
      end
      item
        Name = 'nutr_validade'
        DataType = ftFMTBcd
        Precision = 5
        Size = 4
      end>
    IndexDefs = <>
    PacketRecords = 500
    Params = <>
    StoreDefs = True
    TableName = 'nutricionais'
    TableFields = '*'
    Ordenacao = 'nutr_codigo'
    CommandText = 'SELECT * FROM nutricionais ORDER BY nutr_codigo'
    DBConnection = Ambiente.Conexao
    Left = 195
    Top = 376
  end
  object TIngredientes: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM ingredientes ORDER BY ingr_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    FieldDefs = <
      item
        Name = 'ingr_codigo'
        DataType = ftFMTBcd
        Precision = 8
        Size = 4
      end
      item
        Name = 'ingr_linha1'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ingr_linha2'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ingr_linha3'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ingr_linha4'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ingr_linha5'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ingr_linha6'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ingr_linha7'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ingr_linha8'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ingr_linha9'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ingr_linha10'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    PacketRecords = 500
    Params = <>
    StoreDefs = True
    TableName = 'ingredientes'
    TableFields = '*'
    Ordenacao = 'ingr_codigo'
    CommandText = 'SELECT * FROM ingredientes ORDER BY ingr_codigo'
    DBConnection = Ambiente.Conexao
    Left = 267
    Top = 376
  end
  object TConservacao: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM conservacao ORDER BY cons_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    FieldDefs = <
      item
        Name = 'cons_codigo'
        DataType = ftFMTBcd
        Precision = 6
        Size = 4
      end
      item
        Name = 'cons_linha1'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'cons_linha2'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'cons_linha3'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'cons_linha4'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'cons_linha5'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'cons_linha6'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    PacketRecords = 500
    Params = <>
    StoreDefs = True
    TableName = 'conservacao'
    TableFields = '*'
    Ordenacao = 'cons_codigo'
    CommandText = 'SELECT * FROM conservacao ORDER BY cons_codigo'
    DBConnection = Ambiente.Conexao
    Left = 339
    Top = 376
  end
  object TFaixas: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 
      'SELECT * FROM faixas WHERE faix_status='#39'N'#39' ORDER BY faix_codigo,' +
      'faix_seq'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    FieldDefs = <
      item
        Name = 'faix_status'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'faix_codigo'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'faix_seq'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'faix_inicio'
        DataType = ftFMTBcd
        Precision = 11
        Size = 3
      end
      item
        Name = 'faix_fim'
        DataType = ftFMTBcd
        Precision = 11
        Size = 3
      end
      item
        Name = 'faix_usua_codigo'
        DataType = ftFMTBcd
        Precision = 3
        Size = 4
      end
      item
        Name = 'faix_valor'
        DataType = ftFMTBcd
        Precision = 10
        Size = 5
      end>
    IndexDefs = <>
    PacketRecords = 500
    Params = <>
    StoreDefs = True
    TableName = 'faixas'
    TableFields = '*'
    Condicao = 'faix_status='#39'N'#39
    Ordenacao = 'faix_codigo,faix_seq'
    CommandText = 
      'SELECT * FROM faixas WHERE faix_status='#39'N'#39' ORDER BY faix_codigo,' +
      'faix_seq'
    DBConnection = Ambiente.Conexao
    Left = 451
    Top = 384
  end
  object TEquipamentos: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM equipamentos ORDER BY equi_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    FieldDefs = <
      item
        Name = 'equi_codigo'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'equi_descricao'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'equi_numserie'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'equi_oleomotor'
        DataType = ftFMTBcd
        Precision = 12
        Size = 4
      end
      item
        Name = 'equi_oleohidra'
        DataType = ftFMTBcd
        Precision = 12
        Size = 4
      end
      item
        Name = 'equi_oleodiesel'
        DataType = ftFMTBcd
        Precision = 12
        Size = 4
      end
      item
        Name = 'equi_oleotransmissao'
        DataType = ftFMTBcd
        Precision = 12
        Size = 4
      end
      item
        Name = 'equi_filtromotor'
        DataType = ftFMTBcd
        Precision = 12
        Size = 4
      end
      item
        Name = 'equi_filtrohidra'
        DataType = ftFMTBcd
        Precision = 12
        Size = 4
      end
      item
        Name = 'equi_filtrodiesel'
        DataType = ftFMTBcd
        Precision = 12
        Size = 4
      end
      item
        Name = 'equi_filtroar'
        DataType = ftFMTBcd
        Precision = 12
        Size = 4
      end
      item
        Name = 'equi_horimetro'
        DataType = ftFMTBcd
        Precision = 12
        Size = 4
      end
      item
        Name = 'equi_datahorimetro'
        DataType = ftDate
      end
      item
        Name = 'equi_usua_codigo'
        DataType = ftFMTBcd
        Precision = 3
        Size = 4
      end>
    IndexDefs = <>
    PacketRecords = 200
    Params = <>
    StoreDefs = True
    TableName = 'equipamentos'
    TableFields = '*'
    Ordenacao = 'equi_codigo'
    CommandText = 'SELECT * FROM equipamentos ORDER BY equi_codigo'
    DBConnection = Ambiente.Conexao
    Left = 195
    Top = 429
  end
  object ConexaoFB: TSQLConnection
    ConnectionName = 'IBConnection'
    DriverName = 'Interbase'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      'Database=D:\Clientes\Markito\consisanet.fdb'
      'RoleName=RoleName'
      'User_Name=SYSDBA'
      'Password=1010'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=False')
    Left = 320
    Top = 432
  end
  object SDCliefor: TSimpleDataSet
    Aggregates = <>
    Connection = ConexaoFB
    DataSet.CommandText = 
      'select * from clifor inner join cliforend on (cliforend.cd_clifo' +
      'r=clifor.cd_clifor)'
    DataSet.DataSource = DSClifor
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    Left = 376
    Top = 432
  end
  object DSClifor: TDataSource
    DataSet = SDCliefor
    Left = 568
    Top = 432
  end
  object SDMunicipios: TSimpleDataSet
    Aggregates = <>
    Connection = ConexaoFB
    DataSet.CommandText = 'select * from municipio'
    DataSet.DataSource = DSClifor
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    Left = 437
    Top = 432
  end
  object DSMunicpios: TDataSource
    DataSet = SDMunicipios
    Left = 625
    Top = 432
  end
  object SDEstados: TSimpleDataSet
    Aggregates = <>
    Connection = ConexaoFB
    DataSet.CommandText = 'select * from estado'
    DataSet.DataSource = DSEstados
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    Left = 498
    Top = 424
  end
  object DSEstados: TDataSource
    DataSet = SDEstados
    Left = 684
    Top = 432
  end
  object Q: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM custos'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    FieldDefs = <
      item
        Name = 'cust_status'
        DataType = ftWideString
        Size = 1
      end
      item
        Name = 'cust_esto_codigo'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'cust_tama_codigo'
        DataType = ftFMTBcd
        Precision = 5
        Size = 4
      end
      item
        Name = 'cust_core_codigo'
        DataType = ftFMTBcd
        Precision = 3
        Size = 4
      end
      item
        Name = 'cust_copa_codigo'
        DataType = ftFMTBcd
        Precision = 3
        Size = 4
      end
      item
        Name = 'cust_esto_codigomat'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'cust_tama_codigomat'
        DataType = ftFMTBcd
        Precision = 5
        Size = 4
      end
      item
        Name = 'cust_core_codigomat'
        DataType = ftFMTBcd
        Precision = 3
        Size = 4
      end
      item
        Name = 'cust_qtde'
        DataType = ftFMTBcd
        Precision = 12
        Size = 5
      end
      item
        Name = 'cust_usua_codigo'
        DataType = ftFMTBcd
        Precision = 3
        Size = 4
      end
      item
        Name = 'cust_perqtde'
        DataType = ftFMTBcd
        Precision = 12
        Size = 5
      end
      item
        Name = 'cust_percusto'
        DataType = ftFMTBcd
        Precision = 12
        Size = 5
      end
      item
        Name = 'cust_tipo'
        DataType = ftWideString
        Size = 1
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    TableName = 'custos'
    TableFields = '*'
    CommandText = 'SELECT * FROM custos'
    DBConnection = Ambiente.Conexao
    Left = 99
    Top = 421
  end
  object TBaias: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM baias ORDER BY baia_codigo'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    FieldDefs = <
      item
        Name = 'equi_codigo'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'equi_descricao'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'equi_numserie'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'equi_oleomotor'
        DataType = ftFMTBcd
        Precision = 12
        Size = 4
      end
      item
        Name = 'equi_oleohidra'
        DataType = ftFMTBcd
        Precision = 12
        Size = 4
      end
      item
        Name = 'equi_oleodiesel'
        DataType = ftFMTBcd
        Precision = 12
        Size = 4
      end
      item
        Name = 'equi_oleotransmissao'
        DataType = ftFMTBcd
        Precision = 12
        Size = 4
      end
      item
        Name = 'equi_filtromotor'
        DataType = ftFMTBcd
        Precision = 12
        Size = 4
      end
      item
        Name = 'equi_filtrohidra'
        DataType = ftFMTBcd
        Precision = 12
        Size = 4
      end
      item
        Name = 'equi_filtrodiesel'
        DataType = ftFMTBcd
        Precision = 12
        Size = 4
      end
      item
        Name = 'equi_filtroar'
        DataType = ftFMTBcd
        Precision = 12
        Size = 4
      end
      item
        Name = 'equi_horimetro'
        DataType = ftFMTBcd
        Precision = 12
        Size = 4
      end
      item
        Name = 'equi_datahorimetro'
        DataType = ftDate
      end
      item
        Name = 'equi_usua_codigo'
        DataType = ftFMTBcd
        Precision = 3
        Size = 4
      end>
    IndexDefs = <>
    PacketRecords = 200
    Params = <>
    StoreDefs = True
    TableName = 'baias'
    TableFields = '*'
    Ordenacao = 'baia_codigo'
    CommandText = 'SELECT * FROM baias ORDER BY baia_codigo'
    DBConnection = Ambiente.Conexao
    Left = 187
    Top = 493
  end
end

object FPesagemCaminhao2: TFPesagemCaminhao2
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Pesagem Caminh'#227'o'
  ClientHeight = 405
  ClientWidth = 750
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PCadastro: TPanel
    Left = 0
    Top = 0
    Width = 750
    Height = 405
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    object PBotoes: TSQLPanelGrid
      Left = 540
      Top = 1
      Width = 209
      Height = 376
      Align = alRight
      BevelOuter = bvLowered
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
      object APHeadLabel1: TAPHeadLabel
        Left = 1
        Top = 1
        Width = 207
        Height = 374
        Align = alClient
        AutoBounds = False
        BoundLines = []
        Gradient.EndColor = clGray
        Gradient.StartColor = clSilver
        SubCaption.Ellipsis = False
        SubCaption.Style = []
        ExplicitHeight = 422
      end
      object bSair: TSQLBtn
        Left = 2
        Top = 282
        Width = 250
        Height = 52
        Hint = 'Abandona a tela'
        Caption = 'F6   SAIR'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 5
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        OnClick = bSairClick
        Operation = fbExit
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bpesoinicial: TSQLBtn
        Left = 1
        Top = 108
        Width = 250
        Height = 52
        Hint = 'Le o peso inicial'
        Caption = 'F4  PESO INICIAL'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 5
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        OnClick = bpesoinicialClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bpesofinal: TSQLBtn
        Left = 1
        Top = 161
        Width = 250
        Height = 52
        Hint = 'Le o peso final'
        Caption = 'F5 PESO FINAL'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 5
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        OnClick = bpesofinalClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bimpromaneio: TSQLBtn
        Left = 2
        Top = 219
        Width = 250
        Height = 52
        Hint = 'Imprime romaneio com os pesos'
        Caption = 'F3 Romaneio'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 5
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        OnClick = bimpromaneioClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
    end
    object PMens: TSQLPanelGrid
      Left = 1
      Top = 377
      Width = 748
      Height = 27
      Align = alBottom
      Alignment = taLeftJustify
      BevelInner = bvLowered
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 539
      Height = 376
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 2
      object Edunidade: TSQLEd
        Left = 593
        Top = 56
        Width = 116
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        Color = clGray
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        Text = ''
        Visible = False
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        TitlePos = tppInvisible
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        TypeValue = tvString
        ValueNegative = False
        Decimals = 0
        CharUpperLower = False
        ItemsMultiples = False
        ItemsValid = True
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 0
        Duplicity = 0
        MinLength = 0
        Group = 0
      end
      object EdUnid_codigo: TSQLEd
        Left = 556
        Top = 56
        Width = 32
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 5
        Text = ''
        Visible = False
        Empty = False
        CloseForm = False
        CloseFormEsc = False
        ShowForm = 'FUnidades'
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Unidade'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'Cod. do local de trabalho'
        TypeValue = tvString
        ValueNegative = False
        Decimals = 0
        ValueFormat = '000'
        CharUpperLower = True
        ItemsMultiples = False
        ItemsValid = True
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 0
        Duplicity = 0
        MinLength = 0
        FindTable = 'UNIDADES'
        FindField = 'UNID_CODIGO'
        FindSetField = 'UNID_NOME'
        FindSetEdt = Edunidade
        Group = 0
        PanelMessages = PMens
      end
      object Edtermino: TSQLEd
        Left = 426
        Top = 84
        Width = 58
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        Color = clGray
        Enabled = False
        EditMask = '99/99/99;0;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 8
        ParentFont = False
        TabOrder = 4
        Text = ''
        Visible = False
        Empty = False
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'T'#233'rmino'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'T'#233'rmino do per'#237'odo de exporta'#231#227'o'
        TypeValue = tvDate
        ValueNegative = False
        Decimals = 0
        CharUpperLower = False
        ItemsMultiples = False
        ItemsValid = True
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 0
        Duplicity = 0
        MinLength = 0
        Group = 0
      end
      object EdInicio: TSQLEd
        Left = 352
        Top = 84
        Width = 58
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        Color = clGray
        Enabled = False
        EditMask = '99/99/99;0;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 8
        ParentFont = False
        TabOrder = 3
        Text = ''
        Visible = False
        Empty = False
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Inicio'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'Inicio do per'#237'odo de exporta'#231#227'o'
        TypeValue = tvDate
        ValueNegative = False
        Decimals = 0
        CharUpperLower = False
        ItemsMultiples = False
        ItemsValid = True
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 0
        Duplicity = 0
        MinLength = 0
        Group = 0
      end
      object EdTran_codigo: TSQLEd
        Left = 25
        Top = 20
        Width = 86
        Height = 50
        TabStop = False
        Alignment = taLeftJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -41
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 0
        Text = ''
        Visible = True
        OnKeyDown = EdTran_codigoKeyDown
        Empty = False
        CloseForm = False
        CloseFormEsc = False
        OnValidate = EdTran_codigoValidate
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'C'#243'digo Ve'#237'culo/PLACA'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'C'#243'digo do transportador'
        TypeValue = tvString
        ValueNegative = False
        Decimals = 0
        ValueFormat = '000'
        CharUpperLower = False
        OpGrids = [ogFilter, ogFind]
        ItemsMultiples = False
        ItemsValid = True
        ItemsWidth = 0
        ItemsHeight = 600
        ItemsLength = 3
        Duplicity = 0
        MinLength = 0
        FindTable = 'transportadores'
        FindField = 'tran_codigo'
        FindSetField = 'tran_placa'
        FindSetEdt = EdTran_nome
        Group = 0
        PanelMessages = PMens
      end
      object EdTran_nome: TSQLEd
        Left = 117
        Top = 20
        Width = 215
        Height = 50
        TabStop = False
        Alignment = taLeftJustify
        AutoSize = False
        Color = clGray
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -41
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 40
        ParentFont = False
        TabOrder = 7
        Text = ''
        Visible = True
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Nome Do Transportador'
        TitlePos = tppInvisible
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'Nome do transportador'
        TypeValue = tvString
        ValueNegative = False
        Decimals = 0
        CharUpperLower = True
        ItemsMultiples = False
        ItemsValid = True
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 0
        Duplicity = 2
        MinLength = 0
        Group = 0
        PanelMessages = PMens
      end
      object SetEdCOLA_NOME: TSQLEd
        Left = 546
        Top = 8
        Width = 106
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        Color = clGray
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 40
        ParentFont = False
        TabOrder = 8
        Text = ''
        Visible = False
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Transportador'
        TitlePos = tppInvisible
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'Nome do transportador'
        TypeValue = tvString
        ValueNegative = False
        Decimals = 0
        CharUpperLower = True
        ItemsMultiples = False
        ItemsValid = True
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 0
        Duplicity = 2
        MinLength = 0
        Group = 0
        PanelMessages = PMens
      end
      object EdMoes_cola_codigo01: TSQLEd
        Left = 475
        Top = 30
        Width = 43
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        Color = clGray
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 4
        ParentFont = False
        TabOrder = 2
        Text = ''
        Visible = False
        Empty = False
        CloseForm = False
        CloseFormEsc = False
        ShowForm = 'FColaboradores'
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Motorista 1'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'C'#243'digo do colaborador'
        TypeValue = tvString
        ValueNegative = False
        Decimals = 0
        ValueFormat = '0000'
        CharUpperLower = True
        OpGrids = [ogFilter, ogFind]
        ItemsMultiples = False
        ItemsValid = False
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 0
        Duplicity = 0
        MinLength = 0
        Group = 0
        PanelMessages = PMens
      end
      object EdMoes_cola_codigo02: TSQLEd
        Left = 463
        Top = 57
        Width = 43
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        Color = clGray
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 4
        ParentFont = False
        TabOrder = 9
        Text = ''
        Visible = False
        Empty = False
        CloseForm = False
        CloseFormEsc = False
        ShowForm = 'FColaboradores'
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Motorista 2'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'C'#243'digo do colaborador'
        TypeValue = tvString
        ValueNegative = False
        Decimals = 0
        ValueFormat = '0000'
        CharUpperLower = True
        OpGrids = [ogFilter, ogFind]
        ItemsMultiples = False
        ItemsValid = False
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 0
        Duplicity = 0
        MinLength = 0
        Group = 0
        PanelMessages = PMens
      end
      object EdPesoInicial: TSQLEd
        Left = 27
        Top = 169
        Width = 305
        Height = 45
        TabStop = False
        Alignment = taRightJustify
        Color = clGray
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -32
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        Text = ''
        Visible = True
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clWindow
        ColorTextNotEnabled = clWhite
        Title = 'PESO INICIAL'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -16
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        TypeValue = tvFloat
        ValueNegative = False
        Decimals = 2
        ValueFormat = '###,###,##0.00'
        CharUpperLower = False
        ItemsMultiples = False
        ItemsValid = True
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 0
        Duplicity = 0
        MinLength = 0
        Group = 0
      end
      object Eddif: TSQLEd
        Left = 610
        Top = 96
        Width = 226
        Height = 45
        TabStop = False
        Alignment = taRightJustify
        Color = clGray
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -32
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
        Text = ''
        Visible = False
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clWindow
        ColorTextNotEnabled = clWhite
        Title = 'Diferen'#231'a'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        TypeValue = tvFloat
        ValueNegative = False
        Decimals = 2
        ValueFormat = '###,###,##0.00'
        CharUpperLower = False
        ItemsMultiples = False
        ItemsValid = True
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 0
        Duplicity = 0
        MinLength = 0
        Group = 0
      end
      object EdCarga: TSQLEd
        Left = 441
        Top = 151
        Width = 43
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        Color = clGray
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 8
        ParentFont = False
        TabOrder = 1
        Text = ''
        Visible = False
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Carga'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'Numero da Carga'
        TypeValue = tvInteger
        ValueNegative = False
        Decimals = 0
        CharUpperLower = True
        OpGrids = [ogFilter, ogFind]
        ItemsMultiples = False
        ItemsValid = False
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 8
        Duplicity = 0
        MinLength = 0
        Group = 0
        PanelMessages = PMens
      end
      object EdPesoFinal: TSQLEd
        Left = 27
        Top = 256
        Width = 305
        Height = 45
        TabStop = False
        Alignment = taRightJustify
        Color = clGray
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -32
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        Text = ''
        Visible = True
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        OnExitEdit = EdPesoFinalExitEdit
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clWindow
        ColorTextNotEnabled = clWhite
        Title = 'PESO FINAL'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -16
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        TypeValue = tvFloat
        ValueNegative = False
        Decimals = 2
        ValueFormat = '###,###,##0.00'
        CharUpperLower = False
        ItemsMultiples = False
        ItemsValid = True
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 0
        Duplicity = 0
        MinLength = 0
        Group = 0
      end
      object EdPesada: TSQLEd
        Left = 352
        Top = 20
        Width = 86
        Height = 50
        TabStop = False
        Alignment = taRightJustify
        AutoSize = False
        Color = clGray
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -41
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 13
        Text = ''
        Visible = True
        Empty = False
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Pesada'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'C'#243'digo do transportador'
        TypeValue = tvInteger
        ValueNegative = False
        Decimals = 0
        ValueFormat = '000'
        CharUpperLower = False
        OpGrids = [ogFilter, ogFind]
        ItemsMultiples = False
        ItemsValid = True
        ItemsWidth = 0
        ItemsHeight = 600
        ItemsLength = 3
        Duplicity = 0
        MinLength = 0
        Group = 0
        PanelMessages = PMens
      end
    end
  end
  object ACBrBAL1: TACBrBAL
    Porta = 'COM1'
    OnLePeso = ACBrBAL1LePeso
    Left = 393
    Top = 129
  end
  object ACBrNFe1: TACBrNFe
    Configuracoes.Geral.SSLLib = libNone
    Configuracoes.Geral.SSLCryptLib = cryNone
    Configuracoes.Geral.SSLHttpLib = httpNone
    Configuracoes.Geral.SSLXmlSignLib = xsNone
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Geral.VersaoQRCode = veqr000
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Configuracoes.RespTec.IdCSRT = 0
    Left = 385
    Top = 177
  end
end

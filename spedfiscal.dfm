object FSpedFiscal: TFSpedFiscal
  Left = 405
  Top = 166
  BorderStyle = bsDialog
  Caption = 'Gera'#231#227'o do Sped Fiscal'
  ClientHeight = 416
  ClientWidth = 577
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object PCadastro: TPanel
    Left = 0
    Top = 0
    Width = 577
    Height = 416
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    object PBotoes: TSQLPanelGrid
      Left = 476
      Top = 1
      Width = 100
      Height = 387
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
        Width = 98
        Height = 385
        Align = alClient
        AutoBounds = False
        BoundLines = []
        Gradient.EndColor = clGray
        Gradient.StartColor = clSilver
        SubCaption.Ellipsis = False
        SubCaption.Style = []
      end
      object bExecutar: TSQLBtn
        Left = 3
        Top = 3
        Width = 95
        Height = 25
        Hint = 'Inclui um novo registro'
        Caption = '&Executar'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 5
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        OnClick = bExecutarClick
        Operation = fbNone
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bSair: TSQLBtn
        Left = 3
        Top = 29
        Width = 95
        Height = 25
        Hint = 'Abandona a tela'
        Caption = '&Sair'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 5
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        Operation = fbExit
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
    end
    object PMens: TSQLPanelGrid
      Left = 1
      Top = 388
      Width = 575
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
      Width = 475
      Height = 387
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 2
      object Edunidade: TSQLEd
        Left = 173
        Top = 28
        Width = 99
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
        Left = 135
        Top = 28
        Width = 34
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
        TabOrder = 2
        Text = ''
        Visible = True
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
      object Texto: TRichEdit
        Left = 10
        Top = 118
        Width = 386
        Height = 185
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 8
        Zoom = 100
      end
      object Edinicio: TSQLEd
        Left = 10
        Top = 28
        Width = 55
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        EditMask = '99/99/99;0;_'
        MaxLength = 8
        TabOrder = 0
        Text = ''
        Visible = True
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
        PanelMessages = PMens
      end
      object Edtermino: TSQLEd
        Left = 72
        Top = 28
        Width = 55
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        EditMask = '99/99/99;0;_'
        MaxLength = 8
        TabOrder = 1
        Text = ''
        Visible = True
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
        PanelMessages = PMens
      end
      object EdUnidades: TSQLEd
        Left = 273
        Top = 28
        Width = 124
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 50
        ParentFont = False
        TabOrder = 3
        Text = ''
        Visible = True
        Empty = False
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Unidades para Gera'#231#227'o'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'Unidades a serem utilizadas'
        TypeValue = tvString
        ValueNegative = False
        Decimals = 0
        CharUpperLower = True
        ItemsMultiples = True
        ItemsValid = True
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 3
        Duplicity = 0
        MinLength = 0
        Group = 0
        PanelMessages = PMens
      end
      object Edfinalidade: TSQLEd
        Left = 344
        Top = 69
        Width = 53
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 9
        Text = ''
        Visible = True
        Empty = False
        CloseForm = False
        CloseFormEsc = False
        OnExitEdit = bExecutarClick
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Finalidade'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'Finalidade do arquivo magn'#233'tico'
        TypeValue = tvString
        ValueNegative = False
        Decimals = 0
        CharUpperLower = False
        Items.Strings = (
          '0 - Remessa do Arquivo Original'
          '1 - Remessa do Arquivo Substituto')
        ItemsMultiples = False
        ItemsValid = True
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 1
        Duplicity = 0
        MinLength = 0
        Group = 0
        PanelMessages = PMens
      end
      object EdMesano: TSQLEd
        Left = 10
        Top = 69
        Width = 50
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = clWhite
        EditMask = '99/9999;0;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 7
        ParentFont = False
        TabOrder = 4
        Text = ''
        Visible = True
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Mes/ano'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'Mes/ano do invent'#225'rio ( em branco se n'#227'o for informar )'
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
        PanelMessages = PMens
      end
      object EdEsto_sugr_codigo: TSQLEd
        Left = 72
        Top = 69
        Width = 40
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        MaxLength = 4
        TabOrder = 5
        Text = ''
        Visible = True
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        ShowForm = 'FSubgrupos'
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Sub.Uso e Consumo'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 
          'C'#243'digo do subgrupo para considerar produto como material de uso ' +
          'e consumo'
        TypeValue = tvInteger
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
        FindTable = 'subgrupos'
        FindField = 'sugr_codigo'
        FindSetField = 'sugr_descricao'
        FindSetEdt = SetEdsugr_descricao
        Group = 0
        PanelMessages = PMens
      end
      object SetEdsugr_descricao: TSQLEd
        Left = 115
        Top = 69
        Width = 55
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
        MaxLength = 50
        ParentFont = False
        TabOrder = 10
        Text = ''
        Visible = True
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Nome do Produto'
        TitlePos = tppInvisible
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'Nome do produto'
        TypeValue = tvString
        ValueNegative = False
        Decimals = 0
        CharUpperLower = True
        OpGrids = []
        ItemsMultiples = False
        ItemsValid = True
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 0
        Duplicity = 0
        MinLength = 0
        Group = 0
        PanelMessages = PMens
      end
      object EdSugr_codigoacabado: TSQLEd
        Left = 173
        Top = 69
        Width = 40
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        MaxLength = 4
        TabOrder = 6
        Text = ''
        Visible = True
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        ShowForm = 'FSubgrupos'
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Produto Acabado'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'C'#243'digo do subgrupo para considerar produto como produto acabado'
        TypeValue = tvInteger
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
        FindTable = 'subgrupos'
        FindField = 'sugr_codigo'
        FindSetField = 'sugr_descricao'
        FindSetEdt = SQLEd2
        Group = 0
        PanelMessages = PMens
      end
      object SQLEd2: TSQLEd
        Left = 216
        Top = 69
        Width = 55
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
        MaxLength = 50
        ParentFont = False
        TabOrder = 11
        Text = ''
        Visible = True
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Nome do Produto'
        TitlePos = tppInvisible
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'Nome do produto'
        TypeValue = tvString
        ValueNegative = False
        Decimals = 0
        CharUpperLower = True
        OpGrids = []
        ItemsMultiples = False
        ItemsValid = True
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 0
        Duplicity = 0
        MinLength = 0
        Group = 0
        PanelMessages = PMens
      end
    end
  end
  object ACBrSPEDFiscal1: TACBrSPEDFiscal
    Path = 'D:\Program Files (x86)\Embarcadero\Studio\15.0\bin\'
    Delimitador = '|'
    ReplaceDelimitador = False
    TrimString = True
    CurMascara = '#0.00'
    Left = 433
    Top = 41
  end
end

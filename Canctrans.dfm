object FCanctransacao: TFCanctransacao
  Left = 422
  Top = 173
  BorderStyle = bsDialog
  Caption = 'Cancelamento de Transa'#231#227'o'
  ClientHeight = 361
  ClientWidth = 488
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
  object PRel: TSQLPanelGrid
    Left = 0
    Top = 0
    Width = 488
    Height = 361
    Align = alClient
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
    object SQLPanelGrid2: TSQLPanelGrid
      Left = 386
      Top = 1
      Width = 101
      Height = 332
      Align = alRight
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
        Left = -8
        Top = 1
        Width = 108
        Height = 330
        Align = alRight
        AutoBounds = False
        BoundLines = []
        SubCaption.Ellipsis = False
        SubCaption.Style = []
      end
      object baplicar: TSQLBtn
        Left = 2
        Top = 0
        Width = 95
        Height = 23
        Hint = 'Abandona a tela'
        Caption = '&Aplicar'
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
        Spacing = 2
        OnClick = baplicarClick
        Operation = fbNone
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bSair: TSQLBtn
        Left = 3
        Top = 55
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
        Spacing = 2
        Operation = fbExit
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object brelauditoriafiscal: TSQLBtn
        Left = 3
        Top = 29
        Width = 95
        Height = 25
        Hint = 'Relat. Auditoria Fiscal'
        Caption = 'Auditoria Fiscal'
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
        Spacing = 2
        OnClick = brelauditoriafiscalClick
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
      Top = 333
      Width = 486
      Height = 27
      Align = alBottom
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
    end
    object EdTransacao: TSQLEd
      Left = 4
      Top = 17
      Width = 90
      Height = 21
      TabStop = False
      Alignment = taLeftJustify
      MaxLength = 12
      TabOrder = 2
      Text = ''
      Visible = True
      Empty = False
      CloseForm = False
      CloseFormEsc = False
      OnExitEdit = EdTransacaoExitEdit
      OnValidate = EdTransacaoValidae
      ColorFocus = clBlack
      ColorTextFocus = clWhite
      ColorNotEnabled = clGray
      ColorTextNotEnabled = clWhite
      Title = 'Transa'#231#227'o'
      TitlePos = tppTop
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      TitlePixels = 0
      MessageStr = 'N'#250'mero da transa'#231#227'o'
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
    object PIns: TSQLPanelGrid
      Left = 1
      Top = 55
      Width = 384
      Height = 278
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 3
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
      object Texto: TMemo
        Left = 1
        Top = 1
        Width = 382
        Height = 276
        Align = alClient
        TabOrder = 0
      end
    end
    object EdDatavazia: TSQLEd
      Left = 338
      Top = 29
      Width = 44
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
      TabOrder = 4
      Text = ''
      Visible = False
      Empty = True
      CloseForm = False
      CloseFormEsc = False
      ColorFocus = clBlack
      ColorTextFocus = clWhite
      ColorNotEnabled = clGray
      ColorTextNotEnabled = clWhite
      TitlePos = tppTop
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
    object EdUsua_codigo: TSQLEd
      Left = 100
      Top = 17
      Width = 47
      Height = 21
      TabStop = False
      Alignment = taRightJustify
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 5
      Text = ''
      Visible = True
      Empty = False
      CloseForm = False
      CloseFormEsc = False
      ShowForm = 'FUsuarios'
      ColorFocus = clBlack
      ColorTextFocus = clWhite
      ColorNotEnabled = clGray
      ColorTextNotEnabled = clWhite
      Title = 'C'#243'digo'
      TitlePos = tppTop
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      TitlePixels = 0
      MessageStr = 'C'#243'digo do usu'#225'rio'
      TypeValue = tvInteger
      ValueNegative = False
      Decimals = 0
      CharUpperLower = False
      OpGrids = [ogFilter, ogFind]
      ItemsMultiples = False
      ItemsValid = True
      ItemsWidth = 0
      ItemsHeight = 0
      ItemsLength = 0
      Duplicity = 0
      MinLength = 0
      ValueMax = '4000'
      FindTable = 'usuarios'
      FindField = 'usua_codigo'
      FindSetField = 'usua_nome'
      FindSetEdt = EdUsua_nome
      Group = 0
      PanelMessages = PMens
    end
    object EdUsua_nome: TSQLEd
      Left = 152
      Top = 17
      Width = 75
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
      TabOrder = 6
      Text = ''
      Visible = True
      Empty = False
      CloseForm = False
      CloseFormEsc = False
      ColorFocus = clBlack
      ColorTextFocus = clWhite
      ColorNotEnabled = clGray
      ColorTextNotEnabled = clWhite
      Title = 'Nome Usu'#225'rio'
      TitlePos = tppInvisible
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      TitlePixels = 0
      MessageStr = 'Nome do usu'#225'rio'
      TypeValue = tvString
      ValueNegative = False
      Decimals = 0
      CharUpperLower = True
      ItemsMultiples = False
      ItemsValid = True
      ItemsWidth = 0
      ItemsHeight = 0
      ItemsLength = 0
      Duplicity = 0
      MinLength = 0
      Group = 0
      Table = Arq.TUsuarios
      TableName = 'USUARIOS'
      TableField = 'Usua_nome'
      PanelMessages = PMens
    end
    object EdMotivo: TSQLEd
      Left = 231
      Top = 17
      Width = 149
      Height = 21
      TabStop = False
      Alignment = taLeftJustify
      MaxLength = 200
      TabOrder = 7
      Text = ''
      Visible = True
      Empty = True
      CloseForm = False
      CloseFormEsc = False
      OnExitEdit = EdTransacaoExitEdit
      ColorFocus = clBlack
      ColorTextFocus = clWhite
      ColorNotEnabled = clGray
      ColorTextNotEnabled = clWhite
      Title = 'Motivo'
      TitlePos = tppTop
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      TitlePixels = 0
      MessageStr = 'motivo do cancelamento da transa'#231#227'o'
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
    object EdDataMov: TSQLEd
      Left = 200
      Top = 40
      Width = 52
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
      TitlePos = tppTop
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      TitlePixels = 0
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
  end
end

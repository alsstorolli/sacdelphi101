object FMostraXml: TFMostraXml
  Left = 245
  Top = 67
  BorderStyle = bsDialog
  Caption = 'Mostra XML'
  ClientHeight = 601
  ClientWidth = 862
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pbase: TSQLPanelGrid
    Left = 0
    Top = 0
    Width = 762
    Height = 601
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
    object WebBrowser: TWebBrowser
      Left = 1
      Top = 1
      Width = 760
      Height = 599
      Align = alClient
      TabOrder = 0
      ControlData = {
        4C000000C5640000903F00000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
  object PBotoes: TSQLPanelGrid
    Left = 762
    Top = 0
    Width = 100
    Height = 601
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
    TabOrder = 1
    HeightLimite = 0
    WidthLimite = 0
    FixedVisible = False
    object APHeadLabel1: TAPHeadLabel
      Left = 1
      Top = 1
      Width = 98
      Height = 599
      Align = alClient
      AutoBounds = False
      BoundLines = []
      Gradient.EndColor = clGray
      Gradient.StartColor = clSilver
      SubCaption.Ellipsis = False
      SubCaption.Style = []
    end
    object bSair: TSQLBtn
      Left = 3
      Top = 54
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
  object XML1: TXMLDocument
    ParseOptions = [poValidateOnParse]
    Left = 296
    Top = 56
    DOMVendorDesc = 'MSXML'
  end
end

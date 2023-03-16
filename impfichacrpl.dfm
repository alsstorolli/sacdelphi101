object FImpressaoCRPL: TFImpressaoCRPL
  Left = 472
  Top = 178
  Width = 494
  Height = 480
  Caption = 'Impress'#227'o Fichas CRPL'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object SQLPanelGrid1: TSQLPanelGrid
    Left = 0
    Top = 0
    Width = 478
    Height = 442
    Align = alClient
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    HeightLimite = 0
    WidthLimite = 0
    FixedVisible = False
    object zBtn1: TzBtn
      Left = 287
      Top = 121
      Width = 23
      Height = 22
      ParentShowHint = False
      ShowHint = True
      OnClick = zBtn1Click
      Operation = fbNone
      Processing = False
      AutoAction = True
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object Earquivomodelo: TzEd
      Left = 56
      Top = 72
      Width = 121
      Height = 21
      TabStop = False
      TabOrder = 0
      Text = 'modelocrpl.doc'
      Visible = True
      Alignment = taLeftJustify
      Empty = True
      CloseForm = False
      CloseFormEsc = False
      ColorFocus = clBlack
      ColorTextFocus = clWhite
      ColorNotEnabled = clWhite
      ColorTextNotEnabled = clWhite
      Title = 'Modelo Word'
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
    object Edarquivolista: TzEd
      Left = 56
      Top = 121
      Width = 221
      Height = 21
      TabStop = False
      TabOrder = 1
      Visible = True
      Alignment = taLeftJustify
      Empty = True
      CloseForm = False
      CloseFormEsc = False
      ColorFocus = clBlack
      ColorTextFocus = clWhite
      ColorNotEnabled = clWhite
      ColorTextNotEnabled = clWhite
      Title = 'Arquivo com Lista'
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
    object texto: TRichEdit
      Left = 40
      Top = 168
      Width = 377
      Height = 249
      ScrollBars = ssVertical
      TabOrder = 2
    end
    object StaticText1: TStaticText
      Left = 40
      Top = 149
      Width = 200
      Height = 20
      Caption = 'N'#227'o encontrados no Sisleite'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
  end
  object OD: TOpenDialog
    Filter = 'Arquivos CSV|*.CSV|Todos|*.*'
    Left = 344
    Top = 48
  end
end

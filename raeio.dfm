object FRateio: TFRateio
  Left = 411
  Top = 252
  Width = 351
  Height = 264
  Caption = 'FRateio'
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
  object SQLPanelGrid1: TSQLPanelGrid
    Left = 0
    Top = 0
    Width = 335
    Height = 225
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
    object SQLPanelGrid2: TSQLPanelGrid
      Left = 260
      Top = 1
      Width = 74
      Height = 223
      Align = alRight
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
      object bSair: TSQLBtn
        Left = 0
        Top = 2
        Width = 73
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
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
    end
    object GridRateio: TSqlDtGrid
      Left = 1
      Top = 1
      Width = 259
      Height = 223
      Align = alClient
      ColCount = 3
      DefaultRowHeight = 20
      RowCount = 8
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
      TabOrder = 1
      Columns = <
        item
          WidthColumn = 64
        end
        item
          WidthColumn = 64
        end
        item
          WidthColumn = 64
        end>
      RowCountMin = 0
      SelectedIndex = 1
      Version = '2.0'
    end
    object EdCodigo: TSQLEd
      Left = 64
      Top = 160
      Width = 58
      Height = 21
      TabStop = False
      Color = clGray
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Visible = False
      Alignment = taLeftJustify
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
    object Edvalor: TSQLEd
      Left = 168
      Top = 160
      Width = 64
      Height = 21
      TabStop = False
      Color = clGray
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Visible = False
      Alignment = taLeftJustify
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
  end
end

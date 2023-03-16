object FPlanosPendentes: TFPlanosPendentes
  Left = 299
  Top = 164
  Width = 950
  Height = 542
  Caption = 'Planos de A'#231#227'o Pendentes'
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
    Width = 934
    Height = 504
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
    object pbotoes: TSQLPanelGrid
      Left = 837
      Top = 1
      Width = 96
      Height = 475
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
      object APHeadLabel1: TAPHeadLabel
        Left = 1
        Top = 1
        Width = 94
        Height = 473
        Align = alClient
        AutoBounds = False
        BoundLines = []
        SubCaption.Ellipsis = False
        SubCaption.Style = []
      end
      object bSair: TSQLBtn
        Left = 1
        Top = 31
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
      object bimpressao: TSQLBtn
        Left = 1
        Top = 3
        Width = 95
        Height = 27
        Hint = 'Impress'#227'o planos de a'#231#227'o'
        Caption = '&Relat'#243'rio'
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
        OnClick = bimpressaoClick
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
      Top = 476
      Width = 932
      Height = 27
      Align = alBottom
      Caption = 
        'Teclar Enter na coluna Enc. para informar o encerramento da tare' +
        'fa'
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
    end
    object SQLPanelGrid3: TSQLPanelGrid
      Left = 1
      Top = 1
      Width = 836
      Height = 475
      Align = alClient
      Caption = 'SQLPanelGrid3'
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
      object SQLPanelGrid4: TSQLPanelGrid
        Left = 1
        Top = 1
        Width = 834
        Height = 473
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
        object PInicial: TSQLPanelGrid
          Left = 1
          Top = 1
          Width = 832
          Height = 374
          Align = alClient
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          HeightLimite = 0
          WidthLimite = 0
          FixedVisible = False
          object Grid: TSqlDtGrid
            Left = 1
            Top = 1
            Width = 830
            Height = 372
            Align = alClient
            ColCount = 13
            DefaultRowHeight = 15
            FixedCols = 0
            RowCount = 2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
            ParentFont = False
            TabOrder = 0
            OnDblClick = GridDblClick
            OnDrawCell = GridDrawCell
            OnKeyPress = GridKeyPress
            Columns = <
              item
                Title.Caption = 'Numero'
                WidthColumn = 65
                FieldName = 'paca_numeroata'
              end
              item
                Title.Caption = 'Resp.'
                WidthColumn = 50
                FieldName = 'paca_usua_resp'
              end
              item
                Title.Caption = 'Setor'
                WidthColumn = 70
                FieldName = 'paca_seto_codigo'
              end
              item
                Alignment = taCenter
                Title.Alignment = taCenter
                Title.Caption = 'O Que Fazer ?'
                WidthColumn = 90
                FieldName = 'paca_oque'
              end
              item
                Title.Alignment = taCenter
                Title.Caption = 'Como ?'
                WidthColumn = 250
                FieldName = 'paca_como'
              end
              item
                Title.Caption = 'Sit'
                WidthColumn = 90
                FieldName = 'situacao'
              end
              item
                Title.Caption = 'Quem ?'
                WidthColumn = 70
                FieldName = 'paca_quem'
              end
              item
                Alignment = taRightJustify
                Format = cfDate
                Title.Alignment = taCenter
                Title.Caption = 'Enc.'
                WidthColumn = 65
                FieldName = 'paca_dtencerra'
              end
              item
                Title.Alignment = taCenter
                Title.Caption = 'Quando ?'
                WidthColumn = 60
                FieldName = 'paca_quando'
              end
              item
                Title.Caption = 'Por que ?'
                WidthColumn = 170
                FieldName = 'paca_porque'
              end
              item
                Alignment = taRightJustify
                Title.Alignment = taRightJustify
                Title.Caption = 'Quanto Custa ?'
                WidthColumn = 80
                FieldName = 'paca_valor'
              end
              item
                Title.Caption = 'Seq.'
                WidthColumn = 30
                FieldName = 'paca_seq'
              end
              item
                Title.Caption = 'Tipo'
                WidthColumn = 20
                FieldName = 'paca_tipoplano'
              end>
            RowCountMin = 1
            SelectedIndex = 0
            Version = '2.0'
            OnNewLine = GridNewLine
            ColWidths = (
              50
              70
              90
              178
              160
              70
              65
              60
              61
              80
              30
              20
              65)
          end
          object Edencerramento: TSQLEd
            Left = 628
            Top = 19
            Width = 62
            Height = 21
            TabStop = False
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
            TabOrder = 1
            Visible = False
            Alignment = taLeftJustify
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            OnExitEdit = EdencerramentoExitEdit
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
        object PIns: TSQLPanelGrid
          Left = 1
          Top = 375
          Width = 832
          Height = 97
          Align = alBottom
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
          object Edpaca_oque: TSQLEd
            Left = 13
            Top = 25
            Width = 161
            Height = 21
            TabStop = False
            MaxLength = 500
            TabOrder = 0
            Visible = True
            Alignment = taLeftJustify
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'O que Fazer ?'
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
            PanelMessages = PMens
          end
          object Edpaca_como: TSQLEd
            Left = 193
            Top = 24
            Width = 350
            Height = 21
            TabStop = False
            MaxLength = 500
            TabOrder = 1
            Visible = True
            Alignment = taLeftJustify
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Como ?'
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
            PanelMessages = PMens
          end
          object Edpaca_quem: TSQLEd
            Left = 556
            Top = 24
            Width = 89
            Height = 21
            TabStop = False
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 500
            ParentFont = False
            TabOrder = 2
            Visible = True
            Alignment = taLeftJustify
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clWindow
            ColorTextNotEnabled = clWhite
            Title = 'Quem ?'
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
            PanelMessages = PMens
          end
          object Edpaca_quando: TSQLEd
            Left = 681
            Top = 24
            Width = 65
            Height = 21
            TabStop = False
            EditMask = '99/99/99;0;_'
            MaxLength = 8
            TabOrder = 3
            Visible = True
            Alignment = taLeftJustify
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'At'#233' Quando ?'
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
            PanelMessages = PMens
          end
          object Edpaca_porque: TSQLEd
            Left = 194
            Top = 66
            Width = 350
            Height = 21
            TabStop = False
            MaxLength = 500
            TabOrder = 4
            Visible = True
            Alignment = taLeftJustify
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Por Que ?'
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
            PanelMessages = PMens
          end
          object Edpaca_valor: TSQLEd
            Left = 556
            Top = 65
            Width = 77
            Height = 21
            TabStop = False
            MaxLength = 10
            TabOrder = 5
            Visible = True
            Alignment = taRightJustify
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Valor'
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
            ValueFormat = '###,##0.00'
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
        end
      end
    end
  end
end

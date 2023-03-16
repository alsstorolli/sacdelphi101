object FImpSintegra: TFImpSintegra
  Left = 179
  Top = 184
  BorderStyle = bsDialog
  Caption = 'l'
  ClientHeight = 446
  ClientWidth = 956
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
    Width = 956
    Height = 446
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
      Left = 859
      Top = 1
      Width = 96
      Height = 407
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
        Top = 5
        Width = 93
        Height = 425
        AutoBounds = False
        BoundLines = []
        SubCaption.Ellipsis = False
        SubCaption.Style = []
      end
      object bimporta: TSQLBtn
        Left = 1
        Top = 2
        Width = 95
        Height = 25
        Hint = 'Baixa os t'#237'tulos do retorno escolhido'
        Caption = 'en'
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
        OnClick = EdArquivoValidate
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bSair: TSQLBtn
        Left = 1
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
        Spacing = 2
        Operation = fbExit
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bcheca5054: TSQLBtn
        Left = 1
        Top = 28
        Width = 95
        Height = 25
        Hint = 'Checa valores 50 e 54'
        Caption = 'Compara 50/54'
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
        OnClick = bcheca5054Click
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
      Top = 408
      Width = 954
      Height = 37
      Align = alBottom
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
      object EdBase50: TSQLEd
        Left = 598
        Top = 14
        Width = 71
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
        TabOrder = 0
        Visible = True
        Alignment = taRightJustify
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Base 50'
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
        PanelMessages = PMens
      end
      object EdBase54: TSQLEd
        Left = 681
        Top = 14
        Width = 71
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
        TabOrder = 1
        Visible = True
        Alignment = taRightJustify
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Base 54'
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
        PanelMessages = PMens
      end
      object Eddifbase5054: TSQLEd
        Left = 756
        Top = 14
        Width = 71
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
        Visible = True
        Alignment = taRightJustify
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Dif. 50/54'
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
        PanelMessages = PMens
      end
    end
    object SQLPanelGrid3: TSQLPanelGrid
      Left = 1
      Top = 1
      Width = 858
      Height = 407
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
        Width = 856
        Height = 405
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
          Top = 57
          Width = 854
          Height = 347
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
            Width = 852
            Height = 345
            Align = alClient
            ColCount = 11
            DefaultRowHeight = 15
            FixedCols = 0
            RowCount = 2
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
            TabOrder = 0
            Columns = <
              item
                Title.Caption = 'E/S'
                WidthColumn = 45
                FieldName = 'es'
              end
              item
                Alignment = taCenter
                Title.Alignment = taCenter
                Title.Caption = 'Documento'
                WidthColumn = 70
                FieldName = 'moes_numerodoc'
              end
              item
                Title.Caption = 'Emiss'#227'o'
                WidthColumn = 60
                FieldName = 'moes_dataemissao'
              end
              item
                Format = cfNumber
                Title.Alignment = taCenter
                Title.Caption = 'Valor'
                WidthColumn = 70
                FieldName = 'moes_vlrtotal'
              end
              item
                Title.Caption = 'Destinat'#225'rio'
                WidthColumn = 150
                FieldName = 'clie_nome'
              end
              item
                Title.Caption = 'Cfop'
                WidthColumn = 40
                FieldName = 'moes_natf_codigo'
              end
              item
                Title.Caption = 'Movimento'
                WidthColumn = 60
                FieldName = 'moes_datamvto'
              end
              item
                Title.Caption = 'Cnpf/Cpf'
                WidthColumn = 90
                FieldName = 'cnpj'
              end
              item
                Title.Caption = 'Base 50'
                WidthColumn = 75
                FieldName = 'base50'
              end
              item
                Title.Caption = 'Base 54'
                WidthColumn = 75
                FieldName = 'base54'
              end
              item
                Title.Caption = 'Dif.Base'
                WidthColumn = 70
                FieldName = 'difbase5054'
              end>
            RowCountMin = 1
            SelectedIndex = 0
            Version = '2.0'
            ColWidths = (
              45
              70
              60
              70
              150
              40
              60
              90
              75
              75
              70)
          end
        end
        object PAcerto: TSQLPanelGrid
          Left = 1
          Top = 1
          Width = 854
          Height = 56
          Align = alTop
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
          object bprocurar: TSQLBtn
            Left = 216
            Top = 20
            Width = 51
            Height = 22
            Caption = '&Procurar'
            OnClick = bprocurarClick
            Operation = fbNone
            Processing = False
            AutoAction = True
            GlyphSqlEnv = True
            IntervalRepeat = 0
            DownUp = False
          end
          object EdArquivo: TSQLEd
            Left = 16
            Top = 20
            Width = 189
            Height = 21
            TabStop = False
            TabOrder = 0
            Visible = True
            Alignment = taLeftJustify
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            OnValidate = EdArquivoValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Arquivo Sintegra'
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
          object EdTipo50: TSQLEd
            Left = 315
            Top = 32
            Width = 53
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
            TabOrder = 1
            Visible = True
            Alignment = taRightJustify
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Tipo 50 Saidas'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            TypeValue = tvInteger
            ValueNegative = False
            Decimals = 0
            ValueFormat = '###,##0'
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
          object EdEntradas: TSQLEd
            Left = 544
            Top = 32
            Width = 65
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
            Visible = True
            Alignment = taRightJustify
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Entradas'
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
            PanelMessages = PMens
          end
          object EdTipo54: TSQLEd
            Left = 378
            Top = 32
            Width = 53
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
            Visible = True
            Alignment = taRightJustify
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Tipo 54 Saidas'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            TypeValue = tvInteger
            ValueNegative = False
            Decimals = 0
            ValueFormat = '###,##0'
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
          object EdSaidas: TSQLEd
            Left = 618
            Top = 32
            Width = 66
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
            TabOrder = 4
            Visible = True
            Alignment = taRightJustify
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Saidas'
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
            PanelMessages = PMens
          end
          object Edcnpjnaoenc: TSQLEd
            Left = 442
            Top = 32
            Width = 53
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
            Title = 'CNPJ/CPF n'#227'o enc.'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            TypeValue = tvInteger
            ValueNegative = False
            Decimals = 0
            ValueFormat = '#,##0'
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
  object OpenDialog1: TOpenDialog
    DefaultExt = 'TXT'
    Filter = 'Texto|*.TXT|Todos|*.*'
    Left = 283
    Top = 19
  end
end

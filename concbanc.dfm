object FConcbancaria: TFConcbancaria
  Left = 279
  Top = 160
  BorderStyle = bsDialog
  Caption = 'Concilia'#231#227'o Banc'#225'ria'
  ClientHeight = 504
  ClientWidth = 751
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
    Width = 751
    Height = 504
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
      Left = 654
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
      ParentBackground = False
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
      object bconcilia: TSQLBtn
        Left = 1
        Top = 253
        Width = 95
        Height = 25
        Hint = 'Concilia os documentos marcados'
        Caption = '&Concilia'
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
        OnClick = bconciliaClick
        Operation = fbNone
        Grid = Grid
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bSair: TSQLBtn
        Left = 1
        Top = 2
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
        Grid = Grid
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object StaticText1: TStaticText
        Left = 2
        Top = 132
        Width = 90
        Height = 28
        AutoSize = False
        Caption = 'Banco'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -20
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object StaticText2: TStaticText
        Left = 2
        Top = 368
        Width = 90
        Height = 22
        AutoSize = False
        Caption = 'A Conferir'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
    end
    object PMens: TSQLPanelGrid
      Left = 1
      Top = 476
      Width = 749
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
    object SQLPanelGrid3: TSQLPanelGrid
      Left = 1
      Top = 1
      Width = 653
      Height = 475
      Align = alClient
      Caption = 'SQLPanelGrid3'
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
      object SQLPanelGrid4: TSQLPanelGrid
        Left = 1
        Top = 1
        Width = 651
        Height = 473
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
        object PInicial: TSQLPanelGrid
          Left = 1
          Top = 57
          Width = 649
          Height = 223
          Align = alTop
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
          object Grid: TSqlDtGrid
            Left = 1
            Top = 1
            Width = 647
            Height = 221
            Align = alClient
            ColCount = 7
            DefaultRowHeight = 15
            FixedCols = 0
            RowCount = 2
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
            TabOrder = 0
            OnClick = GridClick
            Columns = <
              item
                Title.Caption = 'Conf'
                WidthColumn = 40
                FieldName = 'conferido'
              end
              item
                Alignment = taCenter
                Format = cfDate
                Title.Alignment = taCenter
                Title.Caption = 'Data'
                WidthColumn = 65
                FieldName = 'Data'
              end
              item
                Alignment = taRightJustify
                Title.Alignment = taRightJustify
                Title.Caption = 'Valor'
                WidthColumn = 75
                FieldName = 'Valor'
              end
              item
                Alignment = taCenter
                Title.Alignment = taCenter
                Title.Caption = 'E/S'
                WidthColumn = 40
                FieldName = 'es'
              end
              item
                Title.Caption = 'Tipo Lan'#231'amento'
                WidthColumn = 110
                FieldName = 'categoria'
              end
              item
                Format = cfDate
                Title.Caption = 'Hist'#243'rico'
                WidthColumn = 170
                FieldName = 'historico'
              end
              item
                Title.Caption = 'Doc.Banco'
                WidthColumn = 110
                FieldName = 'documento'
              end>
            RowCountMin = 1
            SelectedIndex = 0
            Version = '2.0'
            ColWidths = (
              40
              65
              75
              40
              110
              170
              110)
          end
        end
        object PAcerto: TSQLPanelGrid
          Left = 1
          Top = 1
          Width = 649
          Height = 56
          Align = alTop
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
          object bprocurar: TSQLBtn
            Left = 531
            Top = 20
            Width = 51
            Height = 22
            Caption = 'Procurar'
            OnClick = bprocurarClick
            Operation = fbNone
            Processing = False
            AutoAction = True
            GlyphSqlEnv = True
            IntervalRepeat = 0
            DownUp = False
          end
          object EdArquivo: TSQLEd
            Left = 336
            Top = 20
            Width = 189
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            TabOrder = 3
            Text = ''
            Visible = True
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            OnValidate = EdArquivoValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Arquivo do Extrato Banc'#225'rio'
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
          object Edbanco: TSQLEd
            Left = 8
            Top = 20
            Width = 40
            Height = 21
            TabStop = False
            Alignment = taRightJustify
            TabOrder = 0
            Text = ''
            Visible = True
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            ShowForm = 'FPlano'
            OnValidate = EdbancoValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Conta'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'C'#243'digo da conta a ser conciliada'
            TypeValue = tvInteger
            ValueNegative = False
            Decimals = 0
            CharUpperLower = True
            OpGrids = [ogFilter, ogFind]
            ItemsMultiples = False
            ItemsValid = True
            ItemsWidth = 0
            ItemsHeight = 0
            ItemsLength = 0
            Duplicity = 0
            MinLength = 0
            FindTable = 'plano'
            FindField = 'plan_conta'
            FindSetField = 'plan_descricao'
            FindSetEdt = EdBanco_descricao
            Group = 0
            PanelMessages = PMens
          end
          object EdBanco_descricao: TSQLEd
            Left = 52
            Top = 20
            Width = 151
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Color = clGray
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 20
            ParentFont = False
            TabOrder = 4
            Text = ''
            Visible = True
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Descri'#231#227'o'
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
            CharUpperLower = True
            Items.Strings = (
              'BRASIL'
              'BRADESCO'
              'BESC'
              'ITAU'
              'UNIBANCO'
              'JUROS')
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
          object EdDatai: TSQLEd
            Left = 207
            Top = 20
            Width = 60
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
            Title = 'Inicio'
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
          object EdDataf: TSQLEd
            Left = 272
            Top = 20
            Width = 60
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            EditMask = '99/99/99;0;_'
            MaxLength = 8
            TabOrder = 2
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
        object PConfere: TSQLPanelGrid
          Left = 1
          Top = 281
          Width = 649
          Height = 191
          Align = alBottom
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 2
          HeightLimite = 0
          WidthLimite = 0
          FixedVisible = False
          object GridConfere: TSqlDtGrid
            Left = 1
            Top = 1
            Width = 647
            Height = 189
            Align = alClient
            ColCount = 7
            DefaultRowHeight = 15
            FixedCols = 0
            RowCount = 2
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
            TabOrder = 0
            OnClick = GridConfereClick
            Columns = <
              item
                Title.Caption = 'Conf'
                WidthColumn = 40
                FieldName = 'conferido'
              end
              item
                Alignment = taCenter
                Format = cfDate
                Title.Alignment = taCenter
                Title.Caption = 'Data'
                WidthColumn = 65
                FieldName = 'movf_datamvto'
              end
              item
                Alignment = taRightJustify
                Title.Alignment = taRightJustify
                Title.Caption = 'Valor'
                WidthColumn = 75
                FieldName = 'movf_valorger'
              end
              item
                Title.Alignment = taCenter
                Title.Caption = 'E/S'
                WidthColumn = 60
                FieldName = 'movf_es'
              end
              item
                Title.Caption = 'Hist'#243'rico'
                WidthColumn = 150
                FieldName = 'movf_complemento'
              end
              item
                Alignment = taCenter
                Title.Alignment = taCenter
                Title.Caption = 'Documento'
                WidthColumn = 70
                FieldName = 'movf_numerodcto'
              end
              item
                Title.Caption = 'Opera'#231#227'o'
                WidthColumn = 90
                FieldName = 'movf_operacao'
              end>
            RowCountMin = 1
            SelectedIndex = 0
            Version = '2.0'
            ColWidths = (
              40
              65
              75
              60
              150
              70
              90)
          end
        end
      end
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'BBT'
    Filter = 'Extrato Registro|*.BBT|Arquivos Texto|*.TXT|Todos|*.*'
    Left = 587
    Top = 19
  end
end

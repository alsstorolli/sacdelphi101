object FPesagemEntrada: TFPesagemEntrada
  Left = 124
  Top = 112
  BorderStyle = bsDialog
  ClientHeight = 667
  ClientWidth = 1208
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object SQLPanelGrid1: TSQLPanelGrid
    Left = 0
    Top = 0
    Width = 1208
    Height = 667
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
    object pbotoes: TSQLPanelGrid
      Left = 1010
      Top = 1
      Width = 197
      Height = 638
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
        Width = 195
        Height = 636
        Align = alClient
        AutoBounds = False
        BoundLines = []
        SubCaption.Ellipsis = False
        SubCaption.Style = []
      end
      object bSair: TSQLBtn
        Left = 1
        Top = 1
        Width = 280
        Height = 100
        Hint = 'Abandona a tela'
        Caption = 'F6 - Sair'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 5
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 2
        OnClick = bSairClick
        Operation = fbExit
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object blebalanca: TSQLBtn
        Left = 1
        Top = 381
        Width = 280
        Height = 100
        Hint = 'le o peso da balan'#231'a'
        Caption = 'F4 - Le Peso'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Arial Black'
        Font.Style = [fsBold]
        Margin = 5
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 2
        OnClick = blebalancaClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bretnropedido: TSQLBtn
        Left = 2
        Top = 281
        Width = 280
        Height = 100
        Hint = 'retorna ao numero do pedido'
        Caption = 'F3 - Pedido'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 5
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 2
        OnClick = bretnropedidoClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bromaneio: TSQLBtn
        Left = 3
        Top = 99
        Width = 280
        Height = 100
        Hint = 'Impress'#227'o de Romaneio'
        Caption = 'F11 - Romaneio'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 5
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 2
        OnClick = bromaneioClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bimpetq: TSQLBtn
        Left = -1
        Top = 200
        Width = 197
        Height = 47
        Hint = 'Impress'#227'o de Etiqueta'
        Caption = 'F5 - Etiqueta'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 5
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 2
        OnClick = bimpetqClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object EdSeqi: TSQLEd
        Left = 36
        Top = 255
        Width = 34
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        TabOrder = 0
        Text = ''
        Visible = True
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Inicio'
        TitlePos = tppLeft
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 30
        TypeValue = tvInteger
        ValueNegative = False
        Decimals = 2
        ValueFormat = '###0'
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
      object EdSeqf: TSQLEd
        Left = 110
        Top = 254
        Width = 34
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        TabOrder = 1
        Text = ''
        Visible = True
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        OnExitEdit = EdSeqfExitedit
        OnValidate = EdSeqfValidate
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Fim'
        TitlePos = tppLeft
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 30
        TypeValue = tvInteger
        ValueNegative = False
        Decimals = 2
        ValueFormat = '###0'
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
    object PMens: TSQLPanelGrid
      Left = 1
      Top = 639
      Width = 1206
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
      OnClick = PMensClick
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
    end
    object SQLPanelGrid3: TSQLPanelGrid
      Left = 1
      Top = 1
      Width = 1009
      Height = 638
      Align = alClient
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
        Width = 1007
        Height = 636
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
        object PRemessa: TSQLPanelGrid
          Left = 1
          Top = 1
          Width = 1005
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
          object Label6: TLabel
            Left = 212
            Top = 12
            Width = 208
            Height = 37
            Caption = 'F12 - Pedidos'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -32
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object EdNumeroDOC: TSQLEd
            Left = 69
            Top = 11
            Width = 137
            Height = 40
            TabStop = False
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -27
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 8
            ParentFont = False
            TabOrder = 0
            Text = ''
            Visible = True
            OnKeyDown = FormKeyDown
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            OnValidate = EdNumeroDOCValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Pedido'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -16
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = [fsBold]
            TitlePixels = 60
            TypeValue = tvInteger
            ValueNegative = False
            Decimals = 0
            CharUpperLower = False
            ItemsMultiples = False
            ItemsValid = False
            ItemsWidth = 0
            ItemsHeight = 300
            ItemsLength = 0
            Duplicity = 0
            MinLength = 0
            Group = 0
          end
          object pnomecliente: TSQLPanelGrid
            Left = 423
            Top = -5
            Width = 578
            Height = 61
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -21
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 1
            HeightLimite = 0
            WidthLimite = 0
            FixedVisible = False
          end
        end
        object PIns: TSQLPanelGrid
          Left = 1
          Top = 329
          Width = 1005
          Height = 306
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
          object Label3: TLabel
            Left = 884
            Top = 1
            Width = 120
            Height = 304
            Align = alRight
            Caption = 'Peso '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -45
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
            ExplicitHeight = 53
          end
          object Label7: TLabel
            Left = 601
            Top = 12
            Width = 223
            Height = 37
            Caption = 'F12 - Produtos'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -32
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object EdPeso: TSQLEd
            Left = 464
            Top = 245
            Width = 64
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
            ParentFont = False
            TabOrder = 0
            Text = ''
            Visible = True
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            OnValidate = EdPesoValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Peso '
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 30
            TypeValue = tvFloat
            ValueNegative = False
            Decimals = 3
            ValueFormat = '###,##0.000'
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
          object PPeso: TSQLPanelGrid
            Left = 648
            Top = 1
            Width = 236
            Height = 304
            Align = alRight
            Alignment = taRightJustify
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -61
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 1
            HeightLimite = 0
            WidthLimite = 0
            FixedVisible = False
          end
          object pNomeProduto: TSQLPanelGrid
            Left = 2
            Top = 2
            Width = 415
            Height = 167
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -43
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 2
            HeightLimite = 0
            WidthLimite = 0
            FixedVisible = False
          end
          object EdProduto: TSQLEd
            Left = 464
            Top = 11
            Width = 121
            Height = 54
            TabStop = False
            Alignment = taLeftJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -43
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 12
            ParentFont = False
            TabOrder = 3
            Text = ''
            Visible = True
            OnKeyDown = FormKeyDown
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            OnExitEdit = EdProdutoExitEdit
            OnValidate = EdProdutoValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Codigo'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 40
            TypeValue = tvString
            ValueNegative = False
            Decimals = 0
            CharUpperLower = False
            ItemsMultiples = False
            ItemsValid = True
            ItemsWidth = 0
            ItemsHeight = 600
            ItemsLength = 12
            Duplicity = 0
            MinLength = 0
            Group = 0
          end
          object Edidade: TSQLEd
            Left = 464
            Top = 70
            Width = 53
            Height = 54
            TabStop = False
            Alignment = taLeftJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -43
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 1
            ParentFont = False
            TabOrder = 4
            Text = ''
            Visible = True
            OnKeyDown = FormKeyDown
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            OnExitEdit = EdProdutoExitEdit
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Idade'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 40
            TypeValue = tvString
            ValueNegative = False
            Decimals = 0
            CharUpperLower = False
            Items.Strings = (
              '+'
              '-')
            ItemsMultiples = False
            ItemsValid = True
            ItemsWidth = 0
            ItemsHeight = 400
            ItemsLength = 1
            Duplicity = 0
            MinLength = 0
            Group = 0
          end
          object EdBrinco: TSQLEd
            Left = 464
            Top = 185
            Width = 121
            Height = 54
            TabStop = False
            Alignment = taLeftJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -43
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 8
            ParentFont = False
            TabOrder = 6
            Text = ''
            Visible = True
            OnKeyDown = FormKeyDown
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            OnExitEdit = EdProdutoExitEdit
            OnValidate = EdBrincoValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Brinco'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 40
            TypeValue = tvString
            ValueNegative = False
            Decimals = 0
            CharUpperLower = False
            ItemsMultiples = False
            ItemsValid = True
            ItemsWidth = 0
            ItemsHeight = 400
            ItemsLength = 1
            Duplicity = 0
            MinLength = 0
            Group = 0
            PanelMessages = PMens
          end
          object EdCupim: TSQLEd
            Left = 464
            Top = 128
            Width = 53
            Height = 54
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -43
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 1
            ParentFont = False
            TabOrder = 5
            Text = ''
            Visible = True
            OnKeyDown = FormKeyDown
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            OnExitEdit = EdProdutoExitEdit
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Cupim'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 40
            TypeValue = tvString
            ValueNegative = False
            Decimals = 0
            CharUpperLower = False
            Items.Strings = (
              'N - Sem cupim'
              'S - Com cupim ')
            ItemsMultiples = False
            ItemsValid = True
            ItemsWidth = 0
            ItemsHeight = 400
            ItemsLength = 1
            Duplicity = 0
            MinLength = 0
            Group = 0
          end
        end
        object PPedidos: TSQLPanelGrid
          Left = 1
          Top = 57
          Width = 1005
          Height = 156
          Align = alClient
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
          object GridPedido: TSqlDtGrid
            Left = 1
            Top = 1
            Width = 1003
            Height = 154
            Align = alClient
            ColCount = 4
            DefaultRowHeight = 25
            FixedCols = 0
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -20
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            GridLineWidth = 3
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
            ParentFont = False
            TabOrder = 0
            OnKeyDown = FormKeyDown
            Columns = <
              item
                Alignment = taRightJustify
                Format = cfNumber
                Title.Caption = 'Seq'
                WidthColumn = 55
                FieldName = 'movd_seq'
              end
              item
                Title.Caption = 'Codigo'
                WidthColumn = 64
                FieldName = 'mpdd_esto_codigo'
              end
              item
                Title.Caption = 'Descri'#231#227'o do Produto'
                WidthColumn = 300
                FieldName = 'esto_descricao'
              end
              item
                Alignment = taRightJustify
                Title.Alignment = taRightJustify
                Title.Caption = 'Peso'
                WidthColumn = 90
                FieldName = 'movd_pesocarcaca'
              end>
            RowCountMin = 0
            SelectedIndex = 0
            Version = '2.0'
            PermitePesquisa = True
            ColWidths = (
              55
              79
              392
              90)
            RowHeights = (
              25
              25
              25
              25
              25)
          end
        end
        object PTotais: TSQLPanelGrid
          Left = 1
          Top = 43
          Width = 1005
          Height = 286
          Align = alBottom
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
          object Label1: TLabel
            Left = 300
            Top = 121
            Width = 160
            Height = 37
            Caption = 'Peso Total'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -32
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label2: TLabel
            Left = 6
            Top = 121
            Width = 126
            Height = 37
            Caption = 'Animais'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -32
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
          end
          object Label4: TLabel
            Left = 842
            Top = 164
            Width = 94
            Height = 53
            Align = alCustom
            Caption = 'Tara'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -45
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
          end
          object Label5: TLabel
            Left = 843
            Top = 3
            Width = 171
            Height = 53
            Align = alCustom
            Caption = 'Balan'#231'a'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -45
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
          end
          object ppesobalanca: TLabel
            Left = 844
            Top = 56
            Width = 218
            Height = 72
            Align = alCustom
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -61
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
          end
          object ptara: TLabel
            Left = 888
            Top = 282
            Width = 194
            Height = 72
            Align = alCustom
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -61
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
          end
          object Bevel1: TBevel
            Left = 920
            Top = 159
            Width = 235
            Height = 125
          end
          object Bevel2: TBevel
            Left = 840
            Top = 3
            Width = 235
            Height = 157
          end
          object PTotalPesado: TSQLPanelGrid
            Left = 471
            Top = 3
            Width = 312
            Height = 282
            Alignment = taRightJustify
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -61
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 0
            HeightLimite = 0
            WidthLimite = 0
            FixedVisible = False
          end
          object panimaispesados: TSQLPanelGrid
            Left = 153
            Top = 4
            Width = 123
            Height = 281
            Alignment = taRightJustify
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -61
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 1
            HeightLimite = 0
            WidthLimite = 0
            FixedVisible = False
          end
        end
      end
    end
  end
  object AcbrBal1: TACBrBAL
    Modelo = balDigitron
    Porta = 'COM1'
    ArqLOG = 'EntradaAbate.txt'
    OnLePeso = AcbrBal1LePeso
    Left = 691
    Top = 27
  end
  object ACBrETQ1: TACBrETQ
    Porta = 'LPT1'
    Ativo = False
    Left = 675
    Top = 301
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
    Left = 504
    Top = 184
  end
end

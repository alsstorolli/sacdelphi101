object FPagamentos: TFPagamentos
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Gera'#231#227'o de Pagamentos Eletr'#244'nicos'
  ClientHeight = 476
  ClientWidth = 916
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
  object SQLPanelGrid1: TSQLPanelGrid
    Left = 0
    Top = 0
    Width = 916
    Height = 476
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
      Left = 819
      Top = 1
      Width = 96
      Height = 447
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
        Height = 445
        Align = alClient
        AutoBounds = False
        BoundLines = []
        SubCaption.Ellipsis = False
        SubCaption.Style = []
        ExplicitHeight = 439
      end
      object bSair: TSQLBtn
        Left = 4
        Top = 69
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
      object bgeraremessa: TSQLBtn
        Left = 4
        Top = 4
        Width = 95
        Height = 25
        Hint = 'Gera o arquivo remessa dos boletos'
        Caption = '&Gera Remessa'
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
        OnClick = bgeraremessaClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object brelatorio: TSQLBtn
        Left = 4
        Top = 35
        Width = 95
        Height = 25
        Hint = 'Rela'#231#227'o dos boletos marcados'
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
        OnClick = brelatorioClick
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
      Top = 448
      Width = 914
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
      Width = 818
      Height = 447
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
        Width = 816
        Height = 445
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
          Top = 122
          Width = 586
          Height = 285
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
        object PRemessa: TSQLPanelGrid
          Left = 1
          Top = 1
          Width = 814
          Height = 443
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
          object bmarcatodos: TSQLBtn
            Left = 434
            Top = 45
            Width = 105
            Height = 22
            Caption = 'Marcar todos'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            OnClick = bmarcatodosClick
            Operation = fbNone
            Processing = False
            AutoAction = False
            GlyphSqlEnv = True
            IntervalRepeat = 0
            DownUp = False
          end
          object bdesmarcatodos: TSQLBtn
            Left = 434
            Top = 72
            Width = 105
            Height = 22
            Caption = 'Desmarcar todos'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            OnClick = bdesmarcatodosClick
            Operation = fbNone
            Processing = False
            AutoAction = False
            GlyphSqlEnv = True
            IntervalRepeat = 0
            DownUp = False
          end
          object Edunid_codigo: TSQLEd
            Left = 18
            Top = 18
            Width = 33
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
            TabOrder = 1
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
            FindTable = 'unidades'
            FindField = 'unid_codigo'
            FindSetField = 'unid_razaosocial'
            FindSetEdt = SetEdUNID_NOME
            Group = 0
            PanelMessages = PMens
          end
          object SetEdUNID_NOME: TSQLEd
            Left = 55
            Top = 18
            Width = 212
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
          object EdDtinicio: TSQLEd
            Left = 18
            Top = 56
            Width = 53
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            Color = clWhite
            EditMask = '99/99/99;0;_'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 8
            ParentFont = False
            TabOrder = 5
            Text = ''
            Visible = True
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Venc.Inicial'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'Inicio do periodo para emiss'#227'o'
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
          object EdDtFim: TSQLEd
            Left = 76
            Top = 56
            Width = 54
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            Color = clWhite
            EditMask = '99/99/99;0;_'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 8
            ParentFont = False
            TabOrder = 6
            Text = ''
            Visible = True
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            OnExitEdit = EdDtFimExitEdit
            OnValidate = EdDtFimValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Venc. Final'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'T'#233'rmino do per'#237'odo para emiss'#227'o'
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
          object PCheques: TSQLPanelGrid
            Left = 1
            Top = 110
            Width = 812
            Height = 332
            Align = alBottom
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentBackground = False
            ParentFont = False
            TabOrder = 11
            HeightLimite = 0
            WidthLimite = 0
            FixedVisible = False
            object GridPedidos: TSqlDtGrid
              Left = 1
              Top = 1
              Width = 810
              Height = 330
              Align = alClient
              ColCount = 11
              DefaultRowHeight = 15
              FixedCols = 0
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
              TabOrder = 0
              OnClick = GridPedidosClick
              Columns = <
                item
                  Title.Caption = 'Marcado'
                  WidthColumn = 45
                  FieldName = 'marcado'
                end
                item
                  Title.Caption = 'Documento'
                  WidthColumn = 66
                  FieldName = 'pend_numerodcto'
                end
                item
                  Title.Caption = 'Fornec.'
                  WidthColumn = 45
                  FieldName = 'pend_tipo_codigo'
                end
                item
                  Title.Caption = 'Descri'#231#227'o'
                  WidthColumn = 150
                  FieldName = 'clie_descricao'
                end
                item
                  Title.Caption = 'Portador'
                  WidthColumn = 100
                  FieldName = 'portador'
                end
                item
                  Title.Caption = 'Emiss'#227'o'
                  WidthColumn = 56
                  FieldName = 'pend_dataemissao'
                end
                item
                  Title.Caption = 'Vencimento'
                  WidthColumn = 60
                  FieldName = 'pend_datavcto'
                end
                item
                  Alignment = taRightJustify
                  Title.Alignment = taCenter
                  Title.Caption = 'Valor'
                  WidthColumn = 60
                  FieldName = 'pend_valor'
                end
                item
                  Title.Caption = 'Opera'#231#227'o'
                  WidthColumn = 80
                  FieldName = 'pend_operacao'
                end
                item
                  Title.Caption = 'Codigo de Barra'
                  WidthColumn = 100
                  FieldName = 'pend_codbarra'
                end
                item
                  Title.Caption = 'Nosso N'#250'mero'
                  WidthColumn = 100
                  FieldName = 'pend_opantecipa'
                end>
              RowCountMin = 0
              SelectedIndex = 0
              Version = '2.0'
              PermitePesquisa = True
              ColWidths = (
                45
                66
                45
                150
                100
                56
                60
                60
                80
                100
                100)
              RowHeights = (
                15
                15
                15
                15
                15)
            end
          end
          object Edtotalmarcado: TSQLEd
            Left = 687
            Top = 46
            Width = 65
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
            TabOrder = 12
            Text = ''
            Visible = True
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Marcado'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = [fsBold]
            TitlePixels = 65
            MessageStr = 'Total dos pedidos'
            TypeValue = tvFloat
            ValueNegative = False
            Decimals = 2
            ValueFormat = '###,##0.00'
            CharUpperLower = False
            OpGrids = [ogFilter, ogFind]
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
          object EdValorpedidos: TSQLEd
            Left = 687
            Top = 72
            Width = 65
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
            Title = 'Total Valor'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = [fsBold]
            TitlePixels = 65
            MessageStr = 'Total dos pedidos'
            TypeValue = tvFloat
            ValueNegative = False
            Decimals = 2
            ValueFormat = '###,##0.00'
            CharUpperLower = False
            OpGrids = [ogFilter, ogFind]
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
          object EdCheq_bcoemitente: TSQLEd
            Left = 473
            Top = 18
            Width = 98
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
            TabOrder = 14
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
          object EdPort_codigo: TSQLEd
            Left = 427
            Top = 18
            Width = 40
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            MaxLength = 3
            TabOrder = 3
            Text = ''
            Visible = True
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            ShowForm = 'FPortadores'
            OnValidate = EdPort_codigoValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Portador'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'C'#243'digo do portador do titulo'
            TypeValue = tvString
            ValueNegative = False
            Decimals = 0
            ValueFormat = '000'
            CharUpperLower = True
            OpGrids = [ogFilter, ogFind]
            ItemsMultiples = False
            ItemsValid = True
            ItemsWidth = 0
            ItemsHeight = 0
            ItemsLength = 3
            Duplicity = 0
            MinLength = 0
            FindTable = 'portadores'
            FindField = 'port_codigo'
            FindSetField = 'port_descricao'
            FindSetEdt = EdCheq_bcoemitente
            Group = 0
            PanelMessages = PMens
          end
          object Edbanco: TSQLEd
            Left = 582
            Top = 18
            Width = 40
            Height = 21
            TabStop = False
            Alignment = taRightJustify
            MaxLength = 8
            TabOrder = 4
            Text = ''
            Visible = True
            OnKeyPress = EdbancoKeyPress
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            OnValidate = EdbancoValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clWhite
            ColorTextNotEnabled = clWhite
            Title = 'Banco'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'C'#243'digo da conta do banco do cheque'
            TypeValue = tvInteger
            ValueNegative = False
            Decimals = 0
            CharUpperLower = True
            OpGrids = [ogFilter, ogFind]
            ItemsMultiples = False
            ItemsValid = True
            ItemsWidth = 0
            ItemsHeight = 0
            ItemsLength = 8
            Duplicity = 0
            MinLength = 0
            Group = 0
            PanelMessages = PMens
          end
          object EdBanco_descricao: TSQLEd
            Left = 625
            Top = 18
            Width = 127
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
            TabOrder = 15
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
          object EdInstrucaoCob: TSQLEd
            Left = 209
            Top = 56
            Width = 155
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
            MaxLength = 2
            ParentFont = False
            TabOrder = 9
            Text = '01'
            Visible = True
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Instru'#231#227'o Cobran'#231'a'
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
            Items.Strings = (
              '01 - Cadastro de T'#237'tulo'
              '02 - Pedido de Baixa'
              '04 - Concess'#227'o de Abatimento'
              '05 - Cancelamento de Abatimento Concedido'
              '06 - Altera'#231#227'o de Vencimento'
              '08 - Altera'#231#227'o do seu N'#250'mero'
              '09 - Pedido de Protesto'
              '18 - Sustar protesto e baixar t'#237'tulo'
              '19 - Sustar protesto e manter carteira '
              '31 - Altera'#231#227'o de Outros Dados')
            ItemsMultiples = False
            ItemsValid = True
            ItemsWidth = 0
            ItemsHeight = 0
            ItemsLength = 2
            Duplicity = 0
            MinLength = 0
            Group = 0
          end
          object EdSoma: TSQLEd
            Left = 176
            Top = 56
            Width = 30
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
            MaxLength = 1
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
            Title = 'Soma'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'S - Soma as notas em UM boleto    N - um boleto por nota'
            TypeValue = tvString
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
            Group = 0
            PanelMessages = PMens
          end
          object EdTodos: TSQLEd
            Left = 336
            Top = 18
            Width = 30
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 1
            TabOrder = 2
            Text = 'N'
            Visible = True
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Todos'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'S - Todos  N-N'#227'o enviados    B - Baixados'
            TypeValue = tvString
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
            Group = 0
            PanelMessages = PMens
          end
          object EdNumeros: TSQLEd
            Left = 16
            Top = 84
            Width = 348
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
            MaxLength = 200
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
            TypeValue = tvString
            ValueNegative = False
            Decimals = 0
            CharUpperLower = False
            Items.Strings = (
              '01 - Cadastro de T'#237'tulo'
              '02 - Pedido de Baixa'
              '04 - Concess'#227'o de Abatimento'
              '05 - Cancelamento de Abatimento Concedido'
              '06 - Altera'#231#227'o de Vencimento'
              '08 - Altera'#231#227'o do seu N'#250'mero'
              '09 - Pedido de Protesto'
              '18 - Sustar protesto e baixar t'#237'tulo'
              '19 - Sustar protesto e manter carteira '
              '31 - Altera'#231#227'o de Outros Dados')
            ItemsMultiples = False
            ItemsValid = False
            ItemsWidth = 0
            ItemsHeight = 0
            ItemsLength = 0
            Duplicity = 0
            MinLength = 0
            Group = 0
          end
          object EdVencimento: TSQLEd
            Left = 367
            Top = 57
            Width = 54
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
            TabOrder = 10
            Text = ''
            Visible = True
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Vencimento'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'T'#233'rmino do per'#237'odo para emiss'#227'o'
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
        end
      end
    end
  end
  object Salvar: TSaveDialog
    Left = 703
    Top = 75
  end
  object ACBrMail1: TACBrMail
    Host = '127.0.0.1'
    Port = '25'
    SetSSL = False
    SetTLS = False
    Attempts = 3
    DefaultCharset = UTF_8
    IDECharset = UTF_8
    Left = 679
    Top = 203
  end
end

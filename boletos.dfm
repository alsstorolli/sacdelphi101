object FBoletos: TFBoletos
  Left = 286
  Top = 200
  BorderStyle = bsDialog
  Caption = 'Emiss'#227'o de Boletos de Cobran'#231'a Banc'#225'ria'
  ClientHeight = 470
  ClientWidth = 869
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object SQLPanelGrid1: TSQLPanelGrid
    Left = 0
    Top = 0
    Width = 869
    Height = 470
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
      Left = 772
      Top = 1
      Width = 96
      Height = 441
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
        Height = 439
        Align = alClient
        AutoBounds = False
        BoundLines = []
        SubCaption.Ellipsis = False
        SubCaption.Style = []
        ExplicitLeft = 2
        ExplicitTop = -4
      end
      object bimprimir: TSQLBtn
        Left = 4
        Top = 3
        Width = 95
        Height = 25
        Hint = 'Imprime os boletos'
        Caption = '&Imprime Boleto'
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
        OnClick = bimprimirClick
        Operation = fbNone
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bSair: TSQLBtn
        Left = 4
        Top = 178
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
        Left = 2
        Top = 30
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
        Left = 2
        Top = 87
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
      object bemail: TSQLBtn
        Left = 2
        Top = 56
        Width = 95
        Height = 25
        Hint = 'Enviar boletos via email'
        Caption = '&Enviar Email'
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
        OnClick = bemailClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object benviabolpix: TSQLBtn
        Left = 2
        Top = 116
        Width = 95
        Height = 25
        Hint = 'Registra boleto online com PIX'
        Caption = 'E&nvia Bol. Pix'
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
        OnClick = benviabolpixClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object brecnossonumero: TSQLBtn
        Left = 2
        Top = 147
        Width = 95
        Height = 25
        Hint = 'Recalcula Nosso Numero'
        Caption = 'Rec.Nosso Num.'
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
        OnClick = brecnossonumeroClick
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
      Top = 442
      Width = 867
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
      Width = 771
      Height = 441
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
        Width = 769
        Height = 439
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
          Width = 767
          Height = 437
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
            OnValidate = Edunid_codigoValidate
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
            Left = 61
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
            TabOrder = 9
            Text = ''
            Visible = True
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Data Inicio'
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
            Left = 119
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
            TabOrder = 10
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
            Title = 'Data Final'
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
          object Edcheq_repr_codigo: TSQLEd
            Left = 157
            Top = 18
            Width = 48
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
            MaxLength = 4
            ParentFont = False
            TabOrder = 7
            Text = ''
            Visible = True
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            ShowForm = 'FRepresentantes'
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Representante'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'Codigo do representante'
            TypeValue = tvInteger
            ValueNegative = False
            Decimals = 0
            ValueFormat = '###0'
            CharUpperLower = False
            ItemsMultiples = False
            ItemsValid = True
            ItemsWidth = 0
            ItemsHeight = 0
            ItemsLength = 0
            Duplicity = 0
            MinLength = 0
            FindTable = 'representantes'
            FindField = 'repr_codigo'
            FindSetField = 'repr_nome'
            FindSetEdt = SetEdRepr_nome
            Group = 0
            PanelMessages = PMens
          end
          object SetEdRepr_nome: TSQLEd
            Left = 208
            Top = 18
            Width = 109
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
            TabOrder = 8
            Text = ''
            Visible = True
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Representante'
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
            PanelMessages = PMens
          end
          object PCheques: TSQLPanelGrid
            Left = 1
            Top = 104
            Width = 765
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
            TabOrder = 15
            HeightLimite = 0
            WidthLimite = 0
            FixedVisible = False
            object GridPedidos: TSqlDtGrid
              Left = 1
              Top = 1
              Width = 763
              Height = 330
              Align = alClient
              ColCount = 9
              DefaultRowHeight = 15
              FixedCols = 0
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
              TabOrder = 0
              OnClick = GridPedidosClick
              OnKeyPress = GridPedidosKeyPress
              Columns = <
                item
                  Title.Caption = 'Marcado'
                  WidthColumn = 55
                  FieldName = 'marcado'
                end
                item
                  Title.Caption = 'Documento'
                  WidthColumn = 66
                  FieldName = 'pend_numerodcto'
                end
                item
                  Title.Caption = 'Cliente'
                  WidthColumn = 70
                  FieldName = 'pend_tipo_codigo'
                end
                item
                  Title.Caption = 'Descri'#231#227'o'
                  WidthColumn = 150
                  FieldName = 'clie_descricao'
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
                  Title.Caption = 'Nosso N'#250'mero'
                  WidthColumn = 90
                  FieldName = 'pend_opantecipa'
                end>
              RowCountMin = 0
              SelectedIndex = 0
              Version = '2.0'
              PermitePesquisa = True
              ColWidths = (
                55
                66
                70
                150
                56
                60
                60
                80
                90)
              RowHeights = (
                15
                15
                15
                15
                15)
            end
          end
          object Edtotalmarcado: TSQLEd
            Left = 611
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
            TabOrder = 16
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
            Left = 611
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
            TabOrder = 17
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
            Left = 515
            Top = 17
            Width = 63
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
            TabOrder = 18
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
            Left = 474
            Top = 18
            Width = 40
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            MaxLength = 3
            TabOrder = 4
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
            Top = 17
            Width = 40
            Height = 21
            TabStop = False
            Alignment = taRightJustify
            MaxLength = 8
            TabOrder = 5
            Text = ''
            Visible = True
            OnKeyPress = EdbancoKeyPress
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            OnValidate = EdbancoValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
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
            Top = 17
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
            TabOrder = 19
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
          object EdCarteira: TSQLEd
            Left = 16
            Top = 56
            Width = 41
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            MaxLength = 3
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
            Title = 'Carteira'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'Tipo de Carteira'
            TypeValue = tvString
            ValueNegative = False
            Decimals = 0
            CharUpperLower = False
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
            MaxLength = 2
            TabOrder = 13
            Text = '01'
            Visible = True
            OnChange = EdInstrucaoCobChange
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            OnExitEdit = EdDtFimExitEdit
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
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 1
            ParentFont = False
            TabOrder = 11
            Text = ''
            Visible = True
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            OnValidate = EdSomaValidate
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
            Left = 319
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
            OnValidate = EdTodosValidate
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
          object EdCliente: TSQLEd
            Left = 351
            Top = 18
            Width = 35
            Height = 21
            TabStop = False
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 7
            ParentFont = False
            TabOrder = 3
            Text = ''
            Visible = True
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            ShowForm = 'FCadcli'
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Cliente'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'Codigo do cliente'
            TypeValue = tvInteger
            ValueNegative = False
            Decimals = 0
            ValueFormat = '#####0'
            CharUpperLower = False
            OpGrids = [ogFilter, ogFind]
            ItemsMultiples = False
            ItemsValid = True
            ItemsWidth = 0
            ItemsHeight = 0
            ItemsLength = 0
            Duplicity = 0
            MinLength = 0
            FindTable = 'CLIENTES'
            FindField = 'CLIE_CODIGO'
            FindSetField = 'CLIE_NOME'
            FindSetEdt = SetEdCLIE_NOME
            Group = 0
            TableName = 'movesto'
            TableField = 'Moes_tipo_codigo'
          end
          object SetEdCLIE_NOME: TSQLEd
            Left = 387
            Top = 18
            Width = 87
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            Color = clGray
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 20
            Text = ''
            Visible = True
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clLime
            ColorNotEnabled = clNavy
            ColorTextNotEnabled = clRed
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
          object EdNumeros: TSQLEd
            Left = 16
            Top = 81
            Width = 348
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            MaxLength = 200
            TabOrder = 12
            Text = ''
            Visible = True
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
            TabOrder = 14
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
    Left = 707
    Top = 75
  end
  object AcbrBoleto1: TACBrBoleto
    MAIL = ACBrMail1
    Banco.Numero = 1
    Banco.TamanhoMaximoNossoNum = 0
    Banco.TipoCobranca = cobBancoDoBrasil
    Banco.LayoutVersaoArquivo = 0
    Banco.LayoutVersaoLote = 0
    Banco.CasasDecimaisMoraJuros = 2
    Cedente.TipoInscricao = pJuridica
    Cedente.IdentDistribuicao = tbBancoDistribui
    Cedente.PIX.TipoChavePIX = tchNenhuma
    NumeroArquivo = 0
    ACBrBoletoFC = ACBrBoletoFCFortes1
    Configuracoes.Arquivos.LogRegistro = False
    Configuracoes.WebService.SSLHttpLib = httpOpenSSL
    Configuracoes.WebService.StoreName = 'My'
    Configuracoes.WebService.Ambiente = taHomologacao
    Configuracoes.WebService.Operacao = tpInclui
    Configuracoes.WebService.VersaoDF = '1.2'
    Left = 689
    Top = 137
  end
  object TMovesto: TSQLDs
    Aggregates = <>
    DataSet.CommandText = 'SELECT * FROM movesto ORDER BY moes_transacao'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    TableName = 'movesto'
    TableFields = '*'
    Ordenacao = 'moes_transacao'
    CommandText = 'SELECT * FROM movesto ORDER BY moes_transacao'
    Left = 65
    Top = 113
  end
  object datas: TDataSource
    DataSet = TMovesto
    Left = 89
    Top = 41
  end
  object BoletoImagem: TFreeBoletoImagem
    DestruirBoletos = False
    TrackBarDelay = 0
    DrawLogotipo = False
    Left = 283
    Top = 91
  end
  object sdpdf: TSaveDialog
    DefaultExt = 'PDF'
    Filter = '*.DPF'
    Left = 683
    Top = 51
  end
  object ACBrMail1: TACBrMail
    Host = '127.0.0.1'
    Port = '25'
    SetSSL = False
    SetTLS = False
    Attempts = 3
    DefaultCharset = UTF_8
    IDECharset = UTF_8
    Left = 588
    Top = 155
  end
  object ACBrBoletoFCFortes1: TACBrBoletoFCFortes
    Left = 476
    Top = 155
  end
end

object FFluxoCaixa: TFFluxoCaixa
  Left = 243
  Top = 107
  BorderStyle = bsDialog
  Caption = 'Fluxo de Caixa'
  ClientHeight = 573
  ClientWidth = 868
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
    Width = 868
    Height = 573
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
      Left = 771
      Top = 1
      Width = 96
      Height = 544
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
        Height = 542
        Align = alClient
        AutoBounds = False
        BoundLines = []
        SubCaption.Ellipsis = False
        SubCaption.Style = []
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
      object bfechar: TSQLBtn
        Left = 1
        Top = 278
        Width = 95
        Height = 25
        Caption = '&Fechar'
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
        OnClick = bfecharClick
        Operation = fbNone
        Grid = Grid
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bimpressao: TSQLBtn
        Left = 1
        Top = 303
        Width = 95
        Height = 25
        Caption = '&Imprimir'
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
        Grid = Grid
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
    end
    object PMens: TSQLPanelGrid
      Left = 1
      Top = 545
      Width = 866
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
      Width = 770
      Height = 544
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
        Width = 768
        Height = 542
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
          Top = 41
          Width = 766
          Height = 500
          Align = alClient
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
            Width = 764
            Height = 469
            Align = alClient
            ColCount = 11
            DefaultRowHeight = 14
            FixedCols = 0
            RowCount = 2
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
            TabOrder = 0
            OnClick = GridClick
            Columns = <
              item
                Alignment = taCenter
                Title.Alignment = taCenter
                Title.Caption = 'dia'
                WidthColumn = 50
                FieldName = 'Dia'
              end
              item
                Alignment = taRightJustify
                Title.Caption = 'Cheques Rec.'
                WidthColumn = 70
                FieldName = 'chequesre'
              end
              item
                Alignment = taRightJustify
                Format = cfNumber
                Title.Alignment = taCenter
                Title.Caption = 'Recebimentos'
                WidthColumn = 70
                FieldName = 'cr'
              end
              item
                Format = cfNumber
                Title.Caption = 'Ped.Venda'
                WidthColumn = 60
                FieldName = 'pv'
              end
              item
                Alignment = taRightJustify
                Title.Caption = 'Total Receb.'
                WidthColumn = 70
                FieldName = 'totalcr'
              end
              item
                Alignment = taRightJustify
                Format = cfDate
                Title.Alignment = taCenter
                Title.Caption = 'Ch. Emit.'
                WidthColumn = 50
                FieldName = 'chequesemi'
              end
              item
                Alignment = taRightJustify
                Title.Caption = 'Pagamentos'
                WidthColumn = 70
                FieldName = 'cp'
              end
              item
                Alignment = taRightJustify
                Format = cfNumber
                Title.Caption = 'Ped. Compra'
                WidthColumn = 70
                FieldName = 'pc'
              end
              item
                Alignment = taRightJustify
                Format = cfNumber
                Title.Caption = 'Total Pag.'
                WidthColumn = 70
                FieldName = 'totalcp'
              end
              item
                Alignment = taRightJustify
                Format = cfNumber
                Title.Caption = 'Saldo Di'#225'rio'
                WidthColumn = 62
                FieldName = 'saldodia'
              end
              item
                Alignment = taRightJustify
                Title.Caption = 'Saldo'
                WidthColumn = 68
                FieldName = 'saldo'
              end>
            RowCountMin = 1
            SelectedIndex = 0
            Version = '2.0'
            PermitePesquisa = True
            ColWidths = (
              50
              70
              70
              60
              70
              63
              70
              70
              70
              62
              68)
          end
          object PDetalhe: TSQLPanelGrid
            Left = 302
            Top = 183
            Width = 462
            Height = 287
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentBackground = False
            ParentFont = False
            TabOrder = 1
            Visible = False
            HeightLimite = 0
            WidthLimite = 0
            FixedVisible = False
            object GridDetalhe: TSqlDtGrid
              Left = 1
              Top = 18
              Width = 459
              Height = 241
              DefaultRowHeight = 15
              FixedCols = 0
              RowCount = 2
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
              TabOrder = 0
              Columns = <
                item
                  Title.Caption = 'Numero'
                  WidthColumn = 64
                  FieldName = 'numero'
                end
                item
                  Alignment = taRightJustify
                  Format = cfNumber
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Valor'
                  WidthColumn = 64
                  FieldName = 'valor'
                end
                item
                  Title.Caption = 'Descricao'
                  WidthColumn = 160
                  FieldName = 'descricao'
                end
                item
                  WidthColumn = 100
                  FieldName = 'varia'
                end
                item
                  Title.Caption = 'Prazo'
                  WidthColumn = 40
                  FieldName = 'prazomedio'
                end>
              RowCountMin = 0
              SelectedIndex = 0
              Version = '2.0'
              PermitePesquisa = True
              ColWidths = (
                64
                64
                160
                100
                40)
            end
            object St: TStaticText
              Left = 4
              Top = 3
              Width = 180
              Height = 14
              AutoSize = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
            end
            object Edtotal: TSQLEd
              Left = 68
              Top = 262
              Width = 67
              Height = 21
              TabStop = False
              Alignment = taRightJustify
              TabOrder = 2
              Text = ''
              Visible = True
              Empty = True
              CloseForm = False
              CloseFormEsc = False
              ColorFocus = clBlack
              ColorTextFocus = clWhite
              ColorNotEnabled = clGray
              ColorTextNotEnabled = clWhite
              Title = 'Total Dia'
              TitlePos = tppLeft
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              TitlePixels = 60
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
            object EdPrazodia: TSQLEd
              Left = 397
              Top = 262
              Width = 40
              Height = 21
              TabStop = False
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              Text = ''
              Visible = True
              Empty = True
              CloseForm = False
              CloseFormEsc = False
              ColorFocus = clBlack
              ColorTextFocus = clWhite
              ColorNotEnabled = clGray
              ColorTextNotEnabled = clWhite
              Title = 'Atraso M'#233'dio'
              TitlePos = tppLeft
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = [fsBold]
              TitlePixels = 80
              TypeValue = tvInteger
              ValueNegative = False
              Decimals = 2
              ValueFormat = '##0'
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
          object PTotais: TSQLPanelGrid
            Left = 1
            Top = 470
            Width = 764
            Height = 29
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
            object EdChequesre: TSQLEd
              Left = 49
              Top = 4
              Width = 71
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
            object EdRecebe: TSQLEd
              Left = 123
              Top = 4
              Width = 72
              Height = 21
              TabStop = False
              Alignment = taRightJustify
              TabOrder = 1
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
            object Edpedvenda: TSQLEd
              Left = 199
              Top = 4
              Width = 54
              Height = 21
              TabStop = False
              Alignment = taRightJustify
              TabOrder = 2
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
            object EdTotalre: TSQLEd
              Left = 255
              Top = 4
              Width = 69
              Height = 21
              TabStop = False
              Alignment = taRightJustify
              TabOrder = 3
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
            object EdChequesemi: TSQLEd
              Left = 329
              Top = 4
              Width = 62
              Height = 21
              TabStop = False
              Alignment = taRightJustify
              TabOrder = 4
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
            object EdPagamentos: TSQLEd
              Left = 398
              Top = 4
              Width = 70
              Height = 21
              TabStop = False
              Alignment = taRightJustify
              TabOrder = 5
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
            object EdPedcompra: TSQLEd
              Left = 477
              Top = 4
              Width = 62
              Height = 21
              TabStop = False
              Alignment = taRightJustify
              TabOrder = 6
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
            object EdTotalpa: TSQLEd
              Left = 546
              Top = 4
              Width = 69
              Height = 21
              TabStop = False
              Alignment = taRightJustify
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
            object EdAtrasomedio: TSQLEd
              Left = 700
              Top = 4
              Width = 45
              Height = 21
              TabStop = False
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
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
              Title = 'Atraso Receb.'
              TitlePos = tppLeft
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = [fsBold]
              TitlePixels = 80
              TypeValue = tvInteger
              ValueNegative = False
              Decimals = 2
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
          end
        end
        object PAcerto: TSQLPanelGrid
          Left = 1
          Top = 1
          Width = 766
          Height = 40
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
          object EdDtinicio: TSQLEd
            Left = 18
            Top = 16
            Width = 52
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
            TabOrder = 0
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
            MessageStr = 'Inicio do periodo para baixa'
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
            Left = 85
            Top = 16
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
            TabOrder = 1
            Text = ''
            Visible = True
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            OnValidate = EdDtFimValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Fim'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'T'#233'rmino do per'#237'odo de baixa'
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
          object Edunid_codigo: TSQLEd
            Left = 152
            Top = 16
            Width = 272
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            Text = ''
            Visible = True
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            OnValidate = Edunid_codigoValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Unidade(s)'
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
            CharUpperLower = True
            ItemsMultiples = True
            ItemsValid = True
            ItemsWidth = 0
            ItemsHeight = 0
            ItemsLength = 3
            Duplicity = 0
            MinLength = 0
            Group = 0
            PanelMessages = PMens
          end
          object EdSaldoanterior: TSQLEd
            Left = 434
            Top = 16
            Width = 121
            Height = 21
            TabStop = False
            Alignment = taRightJustify
            TabOrder = 3
            Text = ''
            Visible = True
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Saldo Anterior'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            TypeValue = tvFloat
            ValueNegative = True
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
          end
          object Edescolha: TSQLEd
            Left = 604
            Top = 14
            Width = 69
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            MaxLength = 15
            TabOrder = 5
            Text = '1;2;3;4;5;6'
            Visible = True
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            OnExitEdit = EdescolhaExitEdit
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Op'#231#245'es'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'Escolha os valores a serem considerados no fluxo de caixa'
            TypeValue = tvString
            ValueNegative = False
            Decimals = 0
            CharUpperLower = False
            Items.Strings = (
              '1 - Cheques a Receber'
              '2 - Contas a Receber'
              '3 - Cheques Emitidos'
              '4 - Contas a Pagar'
              '5 - Pedidos de Compras'
              '6 - Pedidos de Venda')
            ItemsMultiples = True
            ItemsValid = True
            ItemsWidth = 0
            ItemsHeight = 0
            ItemsLength = 1
            Duplicity = 0
            MinLength = 0
            Group = 0
            PanelMessages = PMens
          end
          object EdAtraso: TSQLEd
            Left = 562
            Top = 16
            Width = 36
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 1
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
            Title = 'Atraso'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'S - considerar atraso de clientes  N - n'#227'o considerar'
            TypeValue = tvString
            ValueNegative = False
            Decimals = 0
            CharUpperLower = False
            Items.Strings = (
              'N - n'#227'o considerar'
              'S - considerar')
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

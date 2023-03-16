object FEntradaAcabado: TFEntradaAcabado
  Left = 301
  Top = 197
  BorderStyle = bsDialog
  Caption = 'Entrada Produto Acabado'
  ClientHeight = 446
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
  object SQLPanelGrid1: TSQLPanelGrid
    Left = 0
    Top = 0
    Width = 862
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
    object pbotoes: TSQLPanelGrid
      Left = 765
      Top = 1
      Width = 96
      Height = 417
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
        Height = 415
        Align = alClient
        AutoBounds = False
        BoundLines = []
        SubCaption.Ellipsis = False
        SubCaption.Style = []
      end
      object bSair: TSQLBtn
        Left = 1
        Top = 242
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
      object bExcluir: TSQLBtn
        Left = 1
        Top = 28
        Width = 95
        Height = 27
        Hint = 'Estorno de qtde produzida'
        Caption = '&Estorno Produ'#231#227'o'
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
        OnClick = bExcluirClick
        Operation = fbNone
        Grid = Grid
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bbaixar: TSQLBtn
        Left = 1
        Top = 1
        Width = 95
        Height = 27
        Hint = 'Grava a produ'#231#227'o dos itens marcados'
        Caption = '&Gravar Prod.'
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
        OnClick = bbaixarClick
        Operation = fbNone
        Grid = Grid
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
    end
    object PMens: TSQLPanelGrid
      Left = 1
      Top = 418
      Width = 860
      Height = 27
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
    end
    object SQLPanelGrid3: TSQLPanelGrid
      Left = 1
      Top = 1
      Width = 764
      Height = 417
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
        Width = 762
        Height = 415
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
          Top = 76
          Width = 760
          Height = 281
          Align = alClient
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
          object Grid: TSqlDtGrid
            Left = 1
            Top = 1
            Width = 758
            Height = 279
            Align = alClient
            ColCount = 12
            DefaultRowHeight = 15
            FixedCols = 0
            RowCount = 2
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
            TabOrder = 0
            OnDblClick = GridDblClick
            OnKeyPress = GridKeyPress
            Columns = <
              item
                Alignment = taCenter
                Title.Alignment = taCenter
                Title.Caption = 'Produto'
                WidthColumn = 60
                FieldName = 'move_esto_codigo'
              end
              item
                Title.Caption = 'Referencia'
                WidthColumn = 80
                FieldName = 'esto_referencia'
              end
              item
                Title.Alignment = taCenter
                Title.Caption = 'Descri'#231#227'o do Produto'
                WidthColumn = 170
                FieldName = 'esto_descricao'
              end
              item
                Alignment = taCenter
                Title.Caption = 'Un'
                WidthColumn = 25
                FieldName = 'esto_unidade'
              end
              item
                EditMask = '##0.000'
                Alignment = taRightJustify
                Format = cfNumber
                Title.Alignment = taCenter
                Title.Caption = 'Qtde OP'
                WidthColumn = 60
                FieldName = 'move_qtderetorno'
              end
              item
                EditMask = '##0.000'
                Alignment = taRightJustify
                Format = cfNumber
                Title.Caption = 'Dig.Produ'#231#227'o'
                WidthColumn = 65
                FieldName = 'move_qtde'
              end
              item
                Title.Caption = 'Produzido'
                WidthColumn = 60
                FieldName = 'qtdejabaixada'
              end
              item
                Title.Caption = 'Marcado'
                WidthColumn = 50
                FieldName = 'marcado'
              end
              item
                Title.Caption = 'OPera'#231#227'o'
                WidthColumn = 65
                FieldName = 'move_operacao'
              end
              item
                Title.Caption = 'Transa'#231#227'o'
                WidthColumn = 65
                FieldName = 'move_transacao'
              end
              item
                WidthColumn = 50
                FieldName = 'move_core_codigo'
              end
              item
                WidthColumn = 50
                FieldName = 'move_tama_codigo'
              end>
            RowCountMin = 1
            SelectedIndex = 0
            Version = '2.0'
            PanelMessages = PMens
            ColWidths = (
              60
              80
              170
              25
              60
              65
              60
              50
              65
              65
              50
              50)
          end
          object edqtdeproduzida: TSQLEd
            Left = 443
            Top = 18
            Width = 58
            Height = 21
            TabStop = False
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Visible = False
            Alignment = taRightJustify
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            OnExitEdit = edqtdeproduzidaExitEdit
            OnValidate = edqtdeproduzidaValidate
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
          object psaidas: TSQLPanelGrid
            Left = 408
            Top = 96
            Width = 352
            Height = 185
            Color = clSilver
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            Visible = False
            HeightLimite = 0
            WidthLimite = 0
            FixedVisible = False
            object Grids: TSqlDtGrid
              Left = 1
              Top = 1
              Width = 289
              Height = 183
              Align = alClient
              DefaultRowHeight = 15
              FixedCols = 0
              RowCount = 2
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
              TabOrder = 0
              Columns = <
                item
                  Title.Caption = 'Tipo Mov.'
                  WidthColumn = 50
                  FieldName = 'move_tipomov'
                end
                item
                  Title.Caption = 'Data'
                  WidthColumn = 60
                  FieldName = 'move_datamvto'
                end
                item
                  Alignment = taRightJustify
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Quantidade'
                  WidthColumn = 63
                  FieldName = 'move_qtde'
                end
                item
                  Title.Caption = 'OPera'#231#227'o'
                  WidthColumn = 65
                  FieldName = 'move_operacao'
                end
                item
                  Title.Caption = 'Transa'#231#227'o'
                  WidthColumn = 64
                  FieldName = 'move_transacao'
                end>
              RowCountMin = 0
              SelectedIndex = 0
              Version = '2.0'
              ColWidths = (
                50
                60
                63
                65
                64)
            end
            object SQLPanelGrid2: TSQLPanelGrid
              Left = 290
              Top = 1
              Width = 61
              Height = 183
              Align = alRight
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
              object bapagasaida: TSQLBtn
                Left = 3
                Top = 2
                Width = 56
                Height = 27
                Hint = 'Exclus'#227'o de movimento de produ'#231#227'o de prod. acabado'
                Caption = '&Estornar'
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
                OnClick = bapagasaidaClick
                Operation = fbNone
                Processing = False
                AutoAction = False
                GlyphSqlEnv = True
                IntervalRepeat = 0
                DownUp = False
              end
              object bfechasaida: TSQLBtn
                Left = 3
                Top = 29
                Width = 56
                Height = 27
                Hint = 'Fecha tela de saidas'
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
                OnClick = bfechasaidaClick
                Operation = fbNone
                Processing = False
                AutoAction = False
                GlyphSqlEnv = True
                IntervalRepeat = 0
                DownUp = False
              end
            end
          end
        end
        object PAcerto: TSQLPanelGrid
          Left = 1
          Top = 1
          Width = 760
          Height = 75
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
          object bmarcatodos: TSQLBtn
            Left = 476
            Top = 49
            Width = 71
            Height = 22
            Caption = 'Marcar todos'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            Operation = fbNone
            Processing = False
            AutoAction = False
            GlyphSqlEnv = True
            IntervalRepeat = 0
            DownUp = False
          end
          object bdesmarcatodos: TSQLBtn
            Left = 550
            Top = 49
            Width = 92
            Height = 22
            Caption = 'Desmarcar todos'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            Operation = fbNone
            Processing = False
            AutoAction = False
            GlyphSqlEnv = True
            IntervalRepeat = 0
            DownUp = False
          end
          object Edunid_codigo: TSQLEd
            Left = 6
            Top = 23
            Width = 35
            Height = 21
            TabStop = False
            Color = clGray
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 3
            ParentFont = False
            TabOrder = 0
            Visible = True
            Alignment = taLeftJustify
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
            FindTable = 'UNIDADES'
            FindField = 'UNID_CODIGO'
            FindSetField = 'UNID_NOME'
            FindSetEdt = SetEdUNID_NOME
            Group = 0
            PanelMessages = PMens
          end
          object SetEdUNID_NOME: TSQLEd
            Left = 45
            Top = 23
            Width = 52
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
            Alignment = taLeftJustify
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
          object EdData: TSQLEd
            Left = 100
            Top = 23
            Width = 56
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
            TabOrder = 2
            Visible = True
            Alignment = taLeftJustify
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Data'
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
          object EdNumeroDoc: TSQLEd
            Left = 293
            Top = 23
            Width = 60
            Height = 21
            TabStop = False
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            Visible = True
            Alignment = taRightJustify
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            OnValidate = EdNumeroDocValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Numero'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'N'#250'mero da requisi'#231#227'o/contrato'
            TypeValue = tvInteger
            ValueNegative = False
            Decimals = 0
            ValueFormat = '#####0'
            CharUpperLower = False
            ItemsMultiples = False
            ItemsValid = False
            ItemsWidth = 0
            ItemsHeight = 0
            ItemsLength = 9
            Duplicity = 0
            MinLength = 0
            Group = 0
            PanelMessages = PMens
          end
          object EdtipoEstoque: TSQLEd
            Left = 159
            Top = 23
            Width = 44
            Height = 21
            TabStop = False
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
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
            Title = 'Tipo Est.'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'Tipo de estoque'
            ValueDefault = '02'
            TypeValue = tvString
            ValueNegative = False
            Decimals = 0
            ValueFormat = '00'
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
          object Ednroobra: TSQLEd
            Left = 356
            Top = 23
            Width = 64
            Height = 21
            TabStop = False
            CharCase = ecUpperCase
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 15
            ParentFont = False
            TabOrder = 5
            Visible = True
            Alignment = taLeftJustify
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Nro Obra'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'Numero da obra'
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
          object Edtipo_codigo: TSQLEd
            Left = 421
            Top = 23
            Width = 40
            Height = 21
            TabStop = False
            MaxLength = 7
            TabOrder = 6
            Visible = True
            Alignment = taRightJustify
            Empty = False
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
          end
          object SetEdCLIE_NOME: TSQLEd
            Left = 462
            Top = 23
            Width = 179
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
            TabOrder = 7
            Visible = True
            Alignment = taLeftJustify
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
        end
        object PIns: TSQLPanelGrid
          Left = 1
          Top = 357
          Width = 760
          Height = 57
          Align = alBottom
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Visible = False
          HeightLimite = 0
          WidthLimite = 0
          FixedVisible = False
          object EdProduto: TSQLEd
            Left = 8
            Top = 21
            Width = 71
            Height = 21
            TabStop = False
            MaxLength = 15
            TabOrder = 0
            Visible = True
            Alignment = taLeftJustify
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            ShowForm = 'FEstoque'
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'C'#243'digo'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'C'#243'digo do produto'
            TypeValue = tvString
            ValueNegative = False
            Decimals = 0
            CharUpperLower = False
            OpGrids = []
            ItemsMultiples = False
            ItemsValid = True
            ItemsWidth = 0
            ItemsHeight = 0
            ItemsLength = 0
            Duplicity = 0
            MinLength = 0
            FindTable = 'ESTOQUE'
            FindField = 'ESTO_CODIGO'
            FindSetField = 'ESTO_DESCRICAO'
            FindSetEdt = SetEdESTO_DESCRICAO
            Group = 0
          end
          object SetEdESTO_DESCRICAO: TSQLEd
            Left = 83
            Top = 21
            Width = 172
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
            Alignment = taLeftJustify
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
          object EdQtde: TSQLEd
            Left = 503
            Top = 22
            Width = 57
            Height = 21
            TabStop = False
            MaxLength = 8
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
            Title = 'Qtde Produzida'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'Quantidade usada'
            TypeValue = tvFloat
            ValueNegative = False
            Decimals = 3
            ValueFormat = '###,##0.000'
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
          end
          object Edcodcor: TSQLEd
            Left = 258
            Top = 21
            Width = 34
            Height = 21
            TabStop = False
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 3
            ParentFont = False
            TabOrder = 1
            Visible = False
            Alignment = taRightJustify
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            ShowForm = 'FCores'
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Cor'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'C'#243'digo da cor'
            TypeValue = tvInteger
            ValueNegative = False
            Decimals = 0
            CharUpperLower = False
            OpGrids = [ogFilter, ogFind]
            ItemsMultiples = False
            ItemsValid = False
            ItemsWidth = 0
            ItemsHeight = 0
            ItemsLength = 3
            Duplicity = 0
            MinLength = 0
            FindTable = 'cores'
            FindField = 'core_codigo'
            FindSetField = 'core_descricao'
            FindSetEdt = Setedcor
            Group = 0
            PanelMessages = PMens
          end
          object Setedcor: TSQLEd
            Left = 295
            Top = 21
            Width = 79
            Height = 21
            TabStop = False
            Color = clGray
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 50
            ParentFont = False
            TabOrder = 5
            Visible = False
            Alignment = taLeftJustify
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
            MessageStr = 'Descri'#231#227'o da cor'
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
          object EdCodtamanho: TSQLEd
            Left = 376
            Top = 22
            Width = 34
            Height = 21
            TabStop = False
            MaxLength = 5
            TabOrder = 2
            Visible = False
            Alignment = taRightJustify
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            ShowForm = 'FTamanhos'
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Tamanho'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'C'#243'digo do tamanho'
            TypeValue = tvInteger
            ValueNegative = False
            Decimals = 0
            CharUpperLower = False
            OpGrids = [ogFilter, ogFind]
            ItemsMultiples = False
            ItemsValid = False
            ItemsWidth = 0
            ItemsHeight = 0
            ItemsLength = 5
            Duplicity = 0
            MinLength = 0
            FindTable = 'tamanhos'
            FindField = 'tama_codigo'
            FindSetField = 'tama_descricao'
            FindSetEdt = Setedtamanho
            Group = 0
            PanelMessages = PMens
          end
          object Setedtamanho: TSQLEd
            Left = 414
            Top = 22
            Width = 80
            Height = 21
            TabStop = False
            Color = clGray
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 50
            ParentFont = False
            TabOrder = 6
            Visible = False
            Alignment = taLeftJustify
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
            MessageStr = 'Descri'#231#227'o do tamanho'
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
        end
      end
    end
  end
end
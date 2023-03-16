object FTransfrem: TFTransfrem
  Left = 263
  Top = 148
  BorderStyle = bsDialog
  Caption = 'Transfer'#234'ncia de Remessa entre Clientes'
  ClientHeight = 462
  ClientWidth = 578
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object SQLPanelGrid1: TSQLPanelGrid
    Left = 0
    Top = 0
    Width = 578
    Height = 462
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
      Left = 481
      Top = 1
      Width = 96
      Height = 433
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
        Top = 5
        Width = 93
        Height = 425
        AutoBounds = False
        BoundLines = []
        SubCaption.Ellipsis = False
        SubCaption.Style = []
      end
      object bGravar: TSQLBtn
        Left = 1
        Top = 2
        Width = 95
        Height = 25
        Hint = 'Grava a rescisao'
        Caption = '&Gravar'
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
        OnClick = bGravarClick
        Operation = fbNone
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bSair: TSQLBtn
        Left = 1
        Top = 27
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
        OnClick = bSairClick
        Operation = fbExit
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
    end
    object PMens: TSQLPanelGrid
      Left = 1
      Top = 434
      Width = 576
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
      Width = 480
      Height = 433
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
        Width = 478
        Height = 431
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
          Top = 153
          Width = 476
          Height = 277
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
            Width = 474
            Height = 275
            Align = alClient
            ColCount = 7
            DefaultRowHeight = 15
            FixedCols = 0
            RowCount = 14
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
            TabOrder = 0
            Columns = <
              item
                Alignment = taCenter
                Title.Alignment = taCenter
                Title.Caption = 'Produto'
                WidthColumn = 64
              end
              item
                Title.Alignment = taCenter
                Title.Caption = 'Descri'#231#227'o do Produto'
                WidthColumn = 64
              end
              item
                EditMask = '##0.00'
                Alignment = taRightJustify
                Format = cfNumber
                Title.Alignment = taCenter
                Title.Caption = 'Quantidade'
                WidthColumn = 64
              end
              item
                EditMask = '###,##0.00'
                Alignment = taRightJustify
                Format = cfNumber
                Title.Alignment = taCenter
                Title.Caption = 'Unit'#225'rio'
                WidthColumn = 64
              end
              item
                EditMask = '###,##0.00'
                Alignment = taRightJustify
                Format = cfNumber
                Title.Alignment = taCenter
                Title.Caption = 'Total'
                WidthColumn = 64
              end
              item
                WidthColumn = 64
                FieldName = 'move_vendabru'
              end
              item
                Format = cfNumber
                WidthColumn = 64
                FieldName = 'move_perdesco'
              end>
            RowCountMin = 1
            SelectedIndex = 0
            Version = '2.0'
            PermitePesquisa = True
            ColWidths = (
              45
              204
              62
              68
              81
              64
              64)
          end
        end
        object PRemessa: TSQLPanelGrid
          Left = 1
          Top = 1
          Width = 476
          Height = 152
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
          object EdCliente: TSQLEd
            Left = 108
            Top = 16
            Width = 37
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
            MaxLength = 7
            ParentFont = False
            TabOrder = 0
            Text = ''
            Visible = True
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            ShowForm = 'FCadcli'
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Cliente Origem'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'Codigo do cliente que ficar'#225' sem a remessa'
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
            Left = 155
            Top = 16
            Width = 182
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
          object EdDtemissao: TSQLEd
            Left = 359
            Top = 16
            Width = 60
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
            TabOrder = 3
            Text = ''
            Visible = True
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Emiss'#227'o'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'Data de emiss'#227'o'
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
            TableName = 'movesto'
            TableField = 'Moes_dataemissao'
          end
          object EdTotalRemessa: TSQLEd
            Left = 395
            Top = 128
            Width = 77
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
            Title = 'Total Remessa'
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
          end
          object EdNumeroDoc: TSQLEd
            Left = 17
            Top = 16
            Width = 60
            Height = 21
            TabStop = False
            Alignment = taRightJustify
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = ''
            Visible = True
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
          object Edtotalqtde: TSQLEd
            Left = 252
            Top = 130
            Width = 63
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
            Title = 'Total Qtde'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            TypeValue = tvInteger
            ValueNegative = False
            Decimals = 2
            ValueFormat = '#####0'
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
          object EdClidesti: TSQLEd
            Left = 108
            Top = 61
            Width = 37
            Height = 21
            TabStop = False
            Alignment = taRightJustify
            MaxLength = 7
            TabOrder = 6
            Text = ''
            Visible = True
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            ShowForm = 'FCadcli'
            OnValidate = EdClidestiValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Cliente Destino'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'Codigo do cliente que ficar'#225' com remessa'
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
            FindSetEdt = SQLEd2
            Group = 0
            TableName = 'movesto'
            TableField = 'Moes_tipo_codigo'
          end
          object SQLEd2: TSQLEd
            Left = 155
            Top = 61
            Width = 182
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
      end
    end
  end
end
object FPosicaoPedidoVenda: TFPosicaoPedidoVenda
  Left = 473
  Top = 162
  BorderStyle = bsDialog
  Caption = 'Posi'#231#227'o de Pedido de Venda'
  ClientHeight = 548
  ClientWidth = 896
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
    Width = 896
    Height = 548
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
      Left = 799
      Top = 1
      Width = 96
      Height = 519
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
        Height = 517
        Align = alClient
        AutoBounds = False
        BoundLines = []
        SubCaption.Ellipsis = False
        SubCaption.Style = []
        ExplicitTop = -4
      end
      object bSair: TSQLBtn
        Left = 1
        Top = 258
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
      object bemail: TSQLBtn
        Left = 0
        Top = 5
        Width = 95
        Height = 25
        Hint = 'envia email de pedido escolhido para o cliente'
        Caption = 'E&mail'
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
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bocorrencia: TSQLBtn
        Left = 1
        Top = 29
        Width = 95
        Height = 25
        Hint = 'digita'#231#227'o de ocorr'#234'ncia'
        Caption = '&Ocorr'#234'ncia'
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
        OnClick = bocorrenciaClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bimp: TSQLBtn
        Left = 1
        Top = 55
        Width = 95
        Height = 25
        Hint = 'impress'#227'o do pedido'
        Caption = '&Imp.Ped/OS'
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
        OnClick = bimpClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bautoriza: TSQLBtn
        Left = 1
        Top = 103
        Width = 95
        Height = 25
        Hint = 'autoriza'#231#227'o para faturamento'
        Caption = 'Autoriz. &Fatur.'
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
        OnClick = bautorizaClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bfatura: TSQLBtn
        Left = 1
        Top = 152
        Width = 95
        Height = 25
        Hint = 'Faturamento das pe'#231'as'
        Caption = '&Baixa Item/Retorno'
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
        OnClick = bfaturaClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bbaixapedido: TSQLBtn
        Left = 1
        Top = 177
        Width = 95
        Height = 25
        Hint = 'Baixa do pedido todo'
        Caption = 'B&aixa Pedido'
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
        OnClick = bbaixapedidoClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bmontagem: TSQLBtn
        Left = 6
        Top = 485
        Width = 95
        Height = 25
        Hint = 'data montagem '
        Caption = '&Montagem'
        Enabled = False
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
        Visible = False
        OnClick = bmontagemClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bautorizaproducao: TSQLBtn
        Left = 1
        Top = 128
        Width = 95
        Height = 25
        Hint = 'autoriza'#231#227'o para almoxarifado'
        Caption = 'Autoriz. &Prod'
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
        OnClick = bautorizaproducaoClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object balterapedido: TSQLBtn
        Left = 1
        Top = 202
        Width = 95
        Height = 25
        Hint = 'Atalho para altera'#231#227'o do pedido'
        Caption = 'Altera P&edido'
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
        OnClick = balterapedidoClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bimpcomcusto: TSQLBtn
        Left = 1
        Top = 78
        Width = 95
        Height = 25
        Hint = 'impress'#227'o do pedido com custo'
        Caption = 'Imp.com C&usto'
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
        OnClick = bimpcomcustoClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bimpop: TSQLBtn
        Left = 1
        Top = 228
        Width = 95
        Height = 25
        Hint = 'impress'#227'o da ordem de produ'#231#227'o'
        Caption = 'I&mp.OP'
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
        OnClick = bimpopClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bcancelareserva: TSQLBtn
        Left = 1
        Top = 312
        Width = 95
        Height = 25
        Hint = 'Cancela pedido reservado'
        Caption = 'Cancela Res.'
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
        OnClick = bcancelareservaClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object balteracor: TSQLBtn
        Left = 1
        Top = 341
        Width = 95
        Height = 25
        Hint = 'Coloca n'#250'mero do espeto'
        Caption = 'Informar Espeto'
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
        OnClick = balteracorClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object breserva: TSQLBtn
        Left = 1
        Top = 400
        Width = 95
        Height = 25
        Hint = 'Reserva carne para venda'
        Caption = 'Reserva Espeto'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 1
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 2
        OnClick = breservaClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bwhatsapp: TSQLBtn
        Left = 1
        Top = 286
        Width = 95
        Height = 25
        Hint = 'Envio de Danfe(PDF) via whatsapp'
        Caption = 'Whatsapp'
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
        Spacing = 5
        OnClick = bwhatsappClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bbuscacontato: TSQLBtn
        Left = 1
        Top = 459
        Width = 95
        Height = 25
        Hint = 'Pesquisa os pedidos pelo contato'
        Caption = 'Busca Contato'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 1
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 2
        OnClick = bbuscacontatoClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object Setedcor2: TSQLEd
        Left = 34
        Top = 371
        Width = 54
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
        MaxLength = 50
        ParentFont = False
        TabOrder = 0
        Text = ''
        Visible = False
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
      object Edcodespeto: TSQLEd
        Left = 2
        Top = 371
        Width = 29
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
        MaxLength = 3
        ParentFont = False
        TabOrder = 1
        Text = ''
        Visible = False
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        ShowForm = 'FCores'
        OnExitEdit = EdcodespetoExitEdit
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
        MessageStr = 'Codigo do espeto'
        TypeValue = tvInteger
        ValueNegative = False
        Decimals = 0
        CharUpperLower = False
        OpGrids = [ogFilter, ogFind]
        ItemsMultiples = False
        ItemsValid = True
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 0
        Duplicity = 0
        MinLength = 0
        FindTable = 'cores'
        FindField = 'core_codigo'
        FindSetField = 'core_descricao'
        FindSetEdt = Setedcor2
        Group = 0
        PanelMessages = PMens
      end
      object EdContato: TSQLEd
        Left = 3
        Top = 431
        Width = 87
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 50
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
        Title = 'Contato'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'Pessoa que fez o pedido'
        TypeValue = tvString
        ValueNegative = False
        Decimals = 0
        CharUpperLower = True
        ItemsMultiples = False
        ItemsValid = True
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 0
        Duplicity = 0
        MinLength = 0
        Group = 1
        PanelMessages = PMens
      end
    end
    object PMens: TSQLPanelGrid
      Left = 1
      Top = 520
      Width = 894
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
      Width = 798
      Height = 519
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
        Width = 796
        Height = 517
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
          Top = 248
          Width = 794
          Height = 243
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
          object GridItens: TSqlDtGrid
            Left = 1
            Top = 3
            Width = 790
            Height = 240
            ColCount = 17
            DefaultRowHeight = 15
            FixedCols = 0
            RowCount = 14
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
            TabOrder = 0
            Columns = <
              item
                Title.Caption = 'Ordem'
                WidthColumn = 40
                FieldName = 'move_seq'
              end
              item
                Title.Alignment = taCenter
                Title.Caption = 'Produto'
                WidthColumn = 64
                FieldName = 'mpdd_esto_codigo'
              end
              item
                Title.Alignment = taCenter
                Title.Caption = 'Descri'#231#227'o do Produto'
                WidthColumn = 300
                FieldName = 'esto_descricao'
              end
              item
                Title.Caption = 'Cor'
                WidthColumn = 50
                FieldName = 'core_descricao'
              end
              item
                Title.Caption = 'Tamanho'
                WidthColumn = 50
                FieldName = 'tama_descricao'
              end
              item
                EditMask = '##0.000'
                Alignment = taRightJustify
                Format = cfNumber
                Title.Alignment = taCenter
                Title.Caption = 'Quantidade'
                WidthColumn = 70
                FieldName = 'mpdd_qtde'
              end
              item
                EditMask = '###,##0.00'
                Alignment = taRightJustify
                Format = cfNumber
                Title.Alignment = taCenter
                Title.Caption = 'Unit'#225'rio'
                WidthColumn = 65
                FieldName = 'mpdd_venda'
              end
              item
                EditMask = '###,##0.00'
                Alignment = taRightJustify
                Format = cfNumber
                Title.Alignment = taCenter
                Title.Caption = 'Total'
                WidthColumn = 64
                FieldName = 'total'
              end
              item
                Format = cfDate
                Title.Caption = 'Montagem'
                WidthColumn = 64
                FieldName = 'mpdd_datamontagem'
              end
              item
                Format = cfDate
                Title.Caption = 'Previs'#227'o'
                WidthColumn = 64
                FieldName = 'mpdd_dataprevista'
              end
              item
                Format = cfDate
                Title.Caption = 'Baixa'
                WidthColumn = 64
                FieldName = 'mpdd_dataenviada'
              end
              item
                Alignment = taRightJustify
                Format = cfNumber
                Title.Caption = 'Qtde Entregue'
                WidthColumn = 64
                FieldName = 'mpdd_qtdeenviada'
              end
              item
                Title.Caption = 'Motivo N'#227'o Entrega'
                WidthColumn = 64
                FieldName = 'caoc_descricao'
              end
              item
                WidthColumn = 64
                FieldName = 'mpdd_core_codigo'
              end
              item
                WidthColumn = 64
                FieldName = 'mpdd_tama_codigo'
              end
              item
                WidthColumn = 64
                FieldName = 'mpdd_copa_codigo'
              end
              item
                Title.Caption = 'Copa'
                WidthColumn = 40
                FieldName = 'copa_descricao'
              end>
            RowCountMin = 1
            SelectedIndex = 0
            Version = '2.0'
            PermitePesquisa = True
            ColWidths = (
              40
              64
              300
              50
              50
              70
              65
              64
              64
              64
              64
              64
              64
              64
              64
              64
              40)
            RowHeights = (
              15
              15
              15
              15
              15
              15
              15
              15
              15
              15
              15
              15
              15
              15)
          end
        end
        object PRemessa: TSQLPanelGrid
          Left = 1
          Top = 1
          Width = 794
          Height = 93
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
          object Edunid_codigo: TSQLEd
            Left = 11
            Top = 52
            Width = 36
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
            MaxLength = 3
            ParentFont = False
            TabOrder = 5
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
            FindTable = 'UNIDADES'
            FindField = 'UNID_CODIGO'
            FindSetField = 'UNID_NOME'
            FindSetEdt = SetEdUNID_NOME
            Group = 0
            PanelMessages = PMens
          end
          object SetEdUNID_NOME: TSQLEd
            Left = 53
            Top = 52
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
          object Edcliente: TSQLEd
            Left = 10
            Top = 15
            Width = 37
            Height = 21
            TabStop = False
            Alignment = taRightJustify
            MaxLength = 7
            TabOrder = 0
            Text = ''
            Visible = True
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            ShowForm = 'FCadcli'
            OnValidate = EdclienteValidate
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
            ValueFormat = '####0'
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
            Left = 53
            Top = 15
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
          object EdRepr_codigo: TSQLEd
            Left = 248
            Top = 52
            Width = 35
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
            TabOrder = 3
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
            ValueFormat = '####0'
            CharUpperLower = False
            OpGrids = [ogFilter, ogFind]
            ItemsMultiples = False
            ItemsValid = True
            ItemsWidth = 0
            ItemsHeight = 0
            ItemsLength = 0
            Duplicity = 0
            MinLength = 0
            FindTable = 'REPRESENTANTES'
            FindField = 'REPR_CODIGO'
            FindSetField = 'REPR_NOME'
            FindSetEdt = SQLEd3
            Group = 0
          end
          object SQLEd3: TSQLEd
            Left = 286
            Top = 52
            Width = 153
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
          object EdValorpedidos: TSQLEd
            Left = 406
            Top = 72
            Width = 69
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
            Title = 'Total Valor'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
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
          object Edtodos: TSQLEd
            Left = 443
            Top = 15
            Width = 29
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 1
            TabOrder = 4
            Text = 'A'
            Visible = True
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            OnValidate = EdtodosValidate
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
            MessageStr = 'T-Todos      A-somente n'#227'o faturados'
            TypeValue = tvString
            ValueNegative = False
            Decimals = 0
            CharUpperLower = False
            Items.Strings = (
              'A - Aberto'
              'T - Todos')
            ItemsMultiples = False
            ItemsValid = True
            ItemsWidth = 0
            ItemsHeight = 0
            ItemsLength = 1
            Duplicity = 0
            MinLength = 0
            FindSetEdt = EdCaoc_codigo
            Group = 0
            PanelMessages = PMens
          end
          object PFinanceiro: TSQLPanelGrid
            Left = 477
            Top = 1
            Width = 316
            Height = 91
            Align = alRight
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentBackground = False
            ParentFont = False
            TabOrder = 10
            HeightLimite = 0
            WidthLimite = 0
            FixedVisible = False
            object GridFinan: TSqlDtGrid
              Left = 1
              Top = 4
              Width = 312
              Height = 120
              ColCount = 6
              DefaultRowHeight = 15
              FixedCols = 0
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
              TabOrder = 0
              Columns = <
                item
                  Format = cfDate
                  Title.Caption = 'Emiss'#227'o'
                  WidthColumn = 50
                  FieldName = 'pend_dataemissao'
                end
                item
                  Format = cfDate
                  Title.Caption = 'Vencim.'
                  WidthColumn = 54
                  FieldName = 'pend_datavcto'
                end
                item
                  Alignment = taRightJustify
                  Title.Alignment = taCenter
                  Title.Caption = 'Valor'
                  WidthColumn = 64
                  FieldName = 'pend_valor'
                end
                item
                  Alignment = taCenter
                  Title.Alignment = taCenter
                  Title.Caption = 'Numero'
                  WidthColumn = 58
                  FieldName = 'pend_numerodcto'
                end
                item
                  Title.Caption = 'P'
                  WidthColumn = 15
                  FieldName = 'pend_parcela'
                end
                item
                  Title.Caption = 'Port.'
                  WidthColumn = 50
                  FieldName = 'port_descricao'
                end>
              RowCountMin = 0
              SelectedIndex = 0
              Version = '2.0'
              PermitePesquisa = True
              ColWidths = (
                50
                54
                64
                58
                15
                50)
              RowHeights = (
                15
                15
                15
                15
                15)
            end
          end
          object EdDatai: TSQLEd
            Left = 248
            Top = 15
            Width = 69
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            EditMask = '99/99/9999;0;_'
            MaxLength = 10
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
            Title = 'Inicio'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            TitlePixels = 0
            TypeValue = tvDateLng
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
            Left = 344
            Top = 15
            Width = 69
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            EditMask = '99/99/9999;0;_'
            MaxLength = 10
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
            Title = 'T'#233'rmino'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            TitlePixels = 0
            TypeValue = tvDateLng
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
          Left = 5
          Top = 445
          Width = 789
          Height = 45
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
          object EdQtde: TSQLEd
            Left = 670
            Top = 16
            Width = 55
            Height = 21
            TabStop = False
            Alignment = taRightJustify
            MaxLength = 8
            TabOrder = 2
            Text = ''
            Visible = True
            OnKeyPress = EdQtdeKeyPress
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            OnValidate = EdQtdeValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Quantidade'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'Quantidade a ser enviada'
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
          object EdCaoc_codigo: TSQLEd
            Left = 352
            Top = 16
            Width = 40
            Height = 21
            TabStop = False
            Alignment = taRightJustify
            MaxLength = 3
            TabOrder = 0
            Text = ''
            Visible = True
            OnKeyPress = EdCaoc_codigoKeyPress
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            ShowForm = 'FCadOcorrencias'
            OnValidate = EdCaoc_codigoValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'C'#243'digo '
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'C'#243'digo da ocorr'#234'ncia'
            TypeValue = tvInteger
            ValueNegative = False
            Decimals = 0
            ValueFormat = '##0'
            CharUpperLower = False
            OpGrids = [ogFilter, ogFind]
            ItemsMultiples = False
            ItemsValid = True
            ItemsWidth = 0
            ItemsHeight = 0
            ItemsLength = 0
            Duplicity = 0
            MinLength = 0
            FindTable = 'cadocorrencias'
            FindField = 'caoc_codigo'
            FindSetField = 'caoc_descricao'
            FindSetEdt = EdCaoc_descricao
            Group = 0
            PanelMessages = PMens
          end
          object EdCaoc_descricao: TSQLEd
            Left = 399
            Top = 16
            Width = 186
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
            MaxLength = 50
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
            Title = 'Descri'#231#227'o da ocorr'#234'ncia'
            TitlePos = tppInvisible
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'Descri'#231#227'o da ocorr'#234'ncia'
            TypeValue = tvString
            ValueNegative = False
            Decimals = 0
            CharUpperLower = True
            ItemsMultiples = False
            ItemsValid = True
            ItemsWidth = 0
            ItemsHeight = 0
            ItemsLength = 0
            Duplicity = 2
            MinLength = 0
            Group = 0
            Table = Arq.TCadocorrencias
            TableName = 'cadocorrencias'
            TableField = 'Caoc_descricao'
            PanelMessages = PMens
          end
          object PMontagem: TSQLPanelGrid
            Left = 1
            Top = 2
            Width = 287
            Height = 41
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentBackground = False
            ParentFont = False
            TabOrder = 4
            Visible = False
            HeightLimite = 0
            WidthLimite = 0
            FixedVisible = False
            object EdDtMontagem: TSQLEd
              Left = 24
              Top = 15
              Width = 57
              Height = 21
              TabStop = False
              Alignment = taLeftJustify
              EditMask = '99/99/99;0;_'
              MaxLength = 8
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
              Title = 'Montagem'
              TitlePos = tppTop
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              TitlePixels = 0
              MessageStr = 'Data da montagem '
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
            object EdPrevisao: TSQLEd
              Left = 141
              Top = 15
              Width = 57
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
              OnExitEdit = EdPrevisaoExitEdit
              OnValidate = EdPrevisaoValidate
              ColorFocus = clBlack
              ColorTextFocus = clWhite
              ColorNotEnabled = clGray
              ColorTextNotEnabled = clWhite
              Title = 'Previs'#227'o'
              TitlePos = tppTop
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              TitlePixels = 0
              MessageStr = 'Data de previs'#227'o de entrega'
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
          object EdBaixa: TSQLEd
            Left = 592
            Top = 15
            Width = 57
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
            OnValidate = EdBaixaValidate
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
            MessageStr = 'Data da baixa'
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
        object PPedidos: TSQLPanelGrid
          Left = 1
          Top = 95
          Width = 793
          Height = 123
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
          object GridPedidos: TSqlDtGrid
            Left = 1
            Top = 1
            Width = 791
            Height = 121
            Align = alClient
            ColCount = 15
            DefaultRowHeight = 15
            FixedCols = 0
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
            TabOrder = 0
            OnClick = GridPedidosClick
            OnDblClick = GridPedidosDblClick
            OnDrawCell = GridPedidosDrawCell
            OnKeyPress = GridPedidosKeyPress
            Columns = <
              item
                Title.Caption = 'Pedido'
                WidthColumn = 64
                FieldName = 'mped_numerodoc'
              end
              item
                Title.Caption = 'PV/OS'
                WidthColumn = 64
                FieldName = 'mped_tipomov'
              end
              item
                Title.Caption = 'Nro Cliente'
                WidthColumn = 64
                FieldName = 'mped_pedcliente'
              end
              item
                Title.Caption = 'Cliente'
                WidthColumn = 100
                FieldName = 'clie_nome'
              end
              item
                Title.Caption = 'Data'
                WidthColumn = 56
                FieldName = 'mped_dataemissao'
              end
              item
                Title.Caption = 'Forma contato'
                WidthColumn = 64
                FieldName = 'mped_formaped'
              end
              item
                Title.Caption = 'Envio'
                WidthColumn = 64
                FieldName = 'mped_envio'
              end
              item
                Title.Caption = 'Contato'
                WidthColumn = 70
                FieldName = 'mped_contatopedido'
              end
              item
                Alignment = taRightJustify
                Title.Caption = 'Valor Pedido'
                WidthColumn = 64
                FieldName = 'mped_vlrtotal'
              end
              item
                Title.Caption = 'Condi'#231#227'o'
                WidthColumn = 50
                FieldName = 'mped_fpgt_prazos'
              end
              item
                Title.Caption = 'Autorizado'
                WidthColumn = 55
                FieldName = 'financeiro'
              end
              item
                Title.Caption = 'Pend/Entr.'
                WidthColumn = 55
                FieldName = 'mped_situacao'
              end
              item
                Title.Caption = 'Digitado'
                WidthColumn = 70
                FieldName = 'mped_usua_codigo'
              end
              item
                Title.Caption = 'Marcado'
                WidthColumn = 64
                FieldName = 'marcado'
              end
              item
                WidthColumn = 64
                FieldName = 'mped_tipo_codigo'
              end>
            RowCountMin = 0
            SelectedIndex = 0
            Version = '2.0'
            PermitePesquisa = True
            ColWidths = (
              64
              64
              64
              100
              56
              64
              64
              70
              64
              50
              55
              55
              70
              64
              64)
            RowHeights = (
              15
              15
              15
              15
              15)
          end
        end
        object PTotais: TSQLPanelGrid
          Left = 3
          Top = 219
          Width = 791
          Height = 30
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 4
          HeightLimite = 0
          WidthLimite = 0
          FixedVisible = False
          object Label1: TLabel
            Left = 7
            Top = 5
            Width = 42
            Height = 20
            Caption = 'Filtro'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Edqtdeprod: TSQLEd
            Left = 425
            Top = 7
            Width = 55
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
            Title = 'Total Qtde Pedida'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 90
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
          object EdQtdeenviada: TSQLEd
            Left = 636
            Top = 6
            Width = 55
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
            Title = 'Total Qtde Entregue'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 100
            MessageStr = 'Quantidade a ser enviada'
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
          object cbtipos: TComboBox
            Left = 52
            Top = 2
            Width = 266
            Height = 24
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            OnClick = cbtiposClick
          end
        end
      end
    end
  end
  object ACBrMail1: TACBrMail
    Host = '127.0.0.1'
    Port = '25'
    SetSSL = False
    SetTLS = False
    Attempts = 3
    DefaultCharset = UTF_8
    IDECharset = UTF_8
    Left = 324
    Top = 67
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 15000
    OnTimer = Timer1Timer
    Left = 491
    Top = 59
  end
end

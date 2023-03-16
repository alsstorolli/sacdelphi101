object FGerenciaNfe: TFGerenciaNfe
  Left = 206
  Top = 120
  BorderStyle = bsDialog
  Caption = 'Gerenciamento de NF Eletronica'
  ClientHeight = 447
  ClientWidth = 898
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
  object PCadastro: TPanel
    Left = 0
    Top = 0
    Width = 898
    Height = 447
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    object PBotoes: TSQLPanelGrid
      Left = 797
      Top = 1
      Width = 100
      Height = 418
      Align = alRight
      BevelOuter = bvLowered
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
        Width = 98
        Height = 416
        Align = alClient
        AutoBounds = False
        BoundLines = []
        Gradient.EndColor = clGray
        Gradient.StartColor = clSilver
        SubCaption.Ellipsis = False
        SubCaption.Style = []
        OnClick = APHeadLabel1Click
      end
      object bconsultar: TSQLBtn
        Left = 3
        Top = 3
        Width = 95
        Height = 25
        Hint = 'Consulta situa'#231#227'o das notas'
        Caption = '&Consultar'
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
        OnClick = bconsultarClick
        Operation = fbNone
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bSair: TSQLBtn
        Left = 3
        Top = 293
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
        Spacing = 5
        OnClick = bSairClick
        Operation = fbExit
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bvexml: TSQLBtn
        Left = 5
        Top = 29
        Width = 95
        Height = 25
        Hint = 'Consulta XML da nota'
        Caption = '&Ver XML'
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
        OnClick = bvexmlClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bimpdanfe: TSQLBtn
        Left = 3
        Top = 54
        Width = 95
        Height = 25
        Hint = 'Imprime o Danfe'
        Caption = '&Imp.Danfe'
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
        OnClick = bimpdanfeClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bcancelanfe: TSQLBtn
        Left = 4
        Top = 79
        Width = 95
        Height = 25
        Hint = 'Cancela NFe'
        Caption = 'C&ancelar NFe'
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
        OnClick = bcancelanfeClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object binutiliza: TSQLBtn
        Left = 3
        Top = 105
        Width = 95
        Height = 25
        Hint = 'Inutiliza numera'#231#227'o da NFe'
        Caption = 'Inutili&zar Num.'
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
        OnClick = binutilizaClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bemail: TSQLBtn
        Left = 3
        Top = 130
        Width = 95
        Height = 25
        Hint = 'Envio Nota Fiscal ( XML ) para o cliente'
        Caption = '&Email XML NFe'
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
        OnClick = bemailClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bconsultasefa: TSQLBtn
        Left = 3
        Top = 385
        Width = 44
        Height = 25
        Hint = 'Consulta situa'#231#227'o das notas na Sefa'
        Caption = 'Consulta Se&fa'
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
        Spacing = 5
        Visible = False
        OnClick = bconsultasefaClick
        Operation = fbNone
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bimpdanfexml: TSQLBtn
        Left = 3
        Top = 325
        Width = 95
        Height = 25
        Hint = 'Impress'#227'o de Danfe via XML do fornecedor'
        Caption = '&Danfe via XML'
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
        OnClick = bimpdanfexmlClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bcartacorrecao: TSQLBtn
        Left = 3
        Top = 155
        Width = 95
        Height = 25
        Hint = 'Carta de Corre'#231#227'o'
        Caption = 'Carta Corre'#231#227'o'
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
        OnClick = bcartacorrecaoClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bgeraxml: TSQLBtn
        Left = 3
        Top = 205
        Width = 95
        Height = 28
        Hint = 'Geral arquivos xmls  e envia via email para o contador'
        Caption = '&XMLs Contador'
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
        OnClick = bgeraxmlClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bimpcce: TSQLBtn
        Left = 4
        Top = 180
        Width = 95
        Height = 25
        Hint = 'Imp.ess'#227'o de Aviso  de Carta de Corre'#231#227'o'
        Caption = 'Imp.Carta Cor.'
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
        OnClick = bimpcceClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bimpnfce: TSQLBtn
        Left = 3
        Top = 232
        Width = 95
        Height = 25
        Hint = 'Imprime o Danfe NFC-e'
        Caption = 'I&mp.NFC-e'
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
        OnClick = bimpnfceClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bxmlcanc: TSQLBtn
        Left = 3
        Top = 263
        Width = 95
        Height = 25
        Hint = 'envia email com XML do cancelamento'
        Caption = 'XML Cancelada'
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
        OnClick = bxmlcancClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bwhatsapp: TSQLBtn
        Left = 3
        Top = 354
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
    end
    object PMens: TSQLPanelGrid
      Left = 1
      Top = 419
      Width = 896
      Height = 27
      Align = alBottom
      Alignment = taLeftJustify
      BevelInner = bvLowered
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 796
      Height = 418
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 2
      object sbchecanumeracao: TSpeedButton
        Left = 484
        Top = 46
        Width = 56
        Height = 26
        Caption = 'Num.NFC-e'
        OnClick = sbchecanumeracaoClick
      end
      object sbchecanumeracaonfe: TSpeedButton
        Left = 420
        Top = 46
        Width = 56
        Height = 26
        Caption = 'Num.NF-e'
        OnClick = sbchecanumeracaonfeClick
      end
      object Edunidade: TSQLEd
        Left = 329
        Top = 19
        Width = 88
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
      object EdUnid_codigo: TSQLEd
        Left = 296
        Top = 19
        Width = 32
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
        TabOrder = 5
        Text = ''
        Visible = True
        OnKeyPress = EdUnid_codigoKeyPress
        Empty = False
        CloseForm = False
        CloseFormEsc = False
        ShowForm = 'FUnidades'
        OnExitEdit = EdUnid_codigoExitEdit
        OnValidate = EdUnid_codigoValidate
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
        FindSetEdt = Edunidade
        Group = 0
        PanelMessages = PMens
      end
      object Edtermino: TSQLEd
        Left = 62
        Top = 19
        Width = 55
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
        Title = 'T'#233'rmino'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'T'#233'rmino do per'#237'odo de exporta'#231#227'o'
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
      object EdInicio: TSQLEd
        Left = 5
        Top = 19
        Width = 55
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
        Title = 'Inicio'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'Inicio do per'#237'odo de exporta'#231#227'o'
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
      object pgrid: TSQLPanelGrid
        Left = 1
        Top = 74
        Width = 794
        Height = 343
        Align = alBottom
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 7
        HeightLimite = 0
        WidthLimite = 0
        FixedVisible = False
        object Grid: TSqlDtGrid
          Left = 1
          Top = 1
          Width = 792
          Height = 341
          Align = alClient
          ColCount = 12
          DefaultRowHeight = 18
          DrawingStyle = gdsClassic
          FixedCols = 0
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
          TabOrder = 0
          OnClick = GridClick
          OnKeyDown = GridKeyDown
          Columns = <
            item
              Title.Caption = 'Numero'
              WidthColumn = 50
              FieldName = 'moes_numerodoc'
            end
            item
              Title.Caption = 'Emiss'#227'o'
              WidthColumn = 55
              FieldName = 'moes_dataemissao'
            end
            item
              Title.Caption = 'Movimento'
              WidthColumn = 55
              FieldName = 'moes_datamvto'
            end
            item
              Alignment = taRightJustify
              Title.Alignment = taCenter
              Title.Caption = 'Valor'
              WidthColumn = 65
              FieldName = 'moes_vlrtotal'
            end
            item
              Alignment = taRightJustify
              Title.Alignment = taCenter
              Title.Caption = 'Codigo'
              WidthColumn = 50
              FieldName = 'moes_tipo_codigo'
            end
            item
              Title.Caption = 'Destinat'#225'rio'
              WidthColumn = 130
              FieldName = 'clie_razaosocial'
            end
            item
              Title.Caption = 'Situa'#231#227'o'
              WidthColumn = 180
              FieldName = 'Situacao'
            end
            item
              Title.Caption = 'Marcado'
              WidthColumn = 50
              FieldName = 'marcado'
            end
            item
              Title.Caption = 'Retorno da Receita'
              WidthColumn = 150
              FieldName = 'retornows'
            end
            item
              Title.Caption = 'Chave NFe'
              WidthColumn = 200
              FieldName = 'moes_chavenfe'
            end
            item
              Title.Caption = 'Transacao'
              WidthColumn = 80
              FieldName = 'moes_transacao'
            end
            item
              Title.Caption = 'Modelo'
              WidthColumn = 64
              FieldName = 'especie'
            end>
          RowCountMin = 0
          SelectedIndex = 0
          Version = '2.0'
          PermitePesquisa = True
          ColWidths = (
            50
            55
            55
            65
            50
            130
            180
            50
            150
            200
            80
            64)
          RowHeights = (
            18
            18)
        end
        object PCartacorrecao: TSQLPanelGrid
          Left = 1
          Top = 183
          Width = 383
          Height = 158
          Align = alCustom
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
          object MemoResp: TMemo
            Left = 1
            Top = 1
            Width = 381
            Height = 156
            Align = alClient
            TabOrder = 0
          end
        end
        object Pcartacorrecao1: TSQLPanelGrid
          Left = 384
          Top = 182
          Width = 409
          Height = 161
          Align = alCustom
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 2
          Visible = False
          HeightLimite = 0
          WidthLimite = 0
          FixedVisible = False
          object MemoRespWs: TMemo
            Left = 1
            Top = 1
            Width = 407
            Height = 159
            Align = alClient
            TabOrder = 0
          end
        end
      end
      object SQLPanelGrid1: TSQLPanelGrid
        Left = 539
        Top = 1
        Width = 256
        Height = 72
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 8
        HeightLimite = 0
        WidthLimite = 0
        FixedVisible = False
        object ComboBox1: TComboBox
          Left = 7
          Top = 32
          Width = 240
          Height = 21
          TabOrder = 0
        end
        object StaticText1: TStaticText
          Left = 8
          Top = 11
          Width = 90
          Height = 20
          Caption = 'Impressoras'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
        end
      end
      object EdNumeroi: TSQLEd
        Left = 420
        Top = 19
        Width = 56
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
        TabOrder = 9
        Text = ''
        Visible = True
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        OnValidate = EdNumeroiValidate
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Num.Inicial'
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
      object listaarquivos: TFileListBox
        Left = 261
        Top = 49
        Width = 142
        Height = 17
        ItemHeight = 300
        Mask = '*.xml'
        TabOrder = 10
        Visible = False
      end
      object Edtipomov: TSQLEd
        Left = 119
        Top = 18
        Width = 31
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 2
        Text = 'T'
        Visible = True
        Empty = False
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'S'#243' NP'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'Somente notas de produtor'
        TypeValue = tvString
        ValueNegative = False
        Decimals = 0
        CharUpperLower = False
        Items.Strings = (
          'T - todos os tipos de movimento'
          'S - somente Notas de Produtor'
          'A - somente autorizadas')
        ItemsMultiples = False
        ItemsValid = True
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 1
        Duplicity = 0
        MinLength = 0
        Group = 0
        PanelMessages = PMens
      end
      object SetEdCLIE_NOME: TSQLEd
        Left = 220
        Top = 18
        Width = 74
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
        TabOrder = 11
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
      object EdCliente: TSQLEd
        Left = 177
        Top = 18
        Width = 42
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
        TabOrder = 4
        Text = ''
        Visible = True
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        OnValidate = EdClienteValidate
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
        MessageStr = 'Codigo do cliente/transportador'
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
        FindSetEdt = SetEdCLIE_NOME
        Group = 0
      end
      object EdTipocad: TSQLEd
        Left = 153
        Top = 18
        Width = 20
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
        TabOrder = 3
        Text = ''
        Visible = True
        Empty = False
        CloseForm = False
        CloseFormEsc = False
        OnValidate = EdTipocadValidate
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Tipo'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'Tipo de cadastro que ser'#225' usado'
        TypeValue = tvString
        ValueNegative = False
        Decimals = 0
        CharUpperLower = False
        Items.Strings = (
          'C - Clientes'
          'T - Transportadores')
        ItemsMultiples = False
        ItemsValid = True
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 1
        Duplicity = 0
        MinLength = 0
        Group = 0
        PanelMessages = PMens
      end
      object EdNumerof: TSQLEd
        Left = 482
        Top = 19
        Width = 56
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
        TabOrder = 12
        Text = ''
        Visible = True
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        OnExitEdit = EdNumerofExitEdit
        OnValidate = EdNumerofValidate
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Final'
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
  object PrintDialogBoleto: TPrintDialog
    Left = 169
    Top = 41
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'XML'
    Filter = 'Arquivo XML|*.XML'
    Left = 644
    Top = 193
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
    Left = 41
    Top = 41
  end
  object datas: TDataSource
    DataSet = TMovesto
    Left = 89
    Top = 41
  end
  object ACBrNFe1: TACBrNFe
    MAIL = ACBrMail1
    Configuracoes.Geral.SSLLib = libWinCrypt
    Configuracoes.Geral.SSLCryptLib = cryWinCrypt
    Configuracoes.Geral.SSLHttpLib = httpWinHttp
    Configuracoes.Geral.SSLXmlSignLib = xsLibXml2
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Arquivos.Salvar = False
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Configuracoes.RespTec.IdCSRT = 0
    Left = 514
    Top = 123
  end
  object ACBrNFeDANFeRL1: TACBrNFeDANFeRL
    Sistema = 'SAC - Sistema Administrativo Comercial'
    MargemInferior = 0.700000000000000000
    MargemSuperior = 0.700000000000000000
    MargemEsquerda = 0.700000000000000000
    MargemDireita = 0.700000000000000000
    ExpandeLogoMarcaConfig.Altura = 0
    ExpandeLogoMarcaConfig.Esquerda = 0
    ExpandeLogoMarcaConfig.Topo = 0
    ExpandeLogoMarcaConfig.Largura = 0
    ExpandeLogoMarcaConfig.Dimensionar = False
    ExpandeLogoMarcaConfig.Esticar = True
    CasasDecimais.Formato = tdetInteger
    CasasDecimais.qCom = 2
    CasasDecimais.vUnCom = 2
    CasasDecimais.MaskqCom = ',0.00'
    CasasDecimais.MaskvUnCom = ',0.00'
    ExibeCampoFatura = False
    Left = 594
    Top = 123
  end
  object ACBrNFeDANFCeFortes1: TACBrNFeDANFCeFortes
    Sistema = 'Sistema Sac - Storolli Cia Ltda'
    MargemInferior = 0.800000000000000000
    MargemSuperior = 0.800000000000000000
    MargemEsquerda = 0.600000000000000000
    MargemDireita = 0.510000000000000000
    ExpandeLogoMarcaConfig.Altura = 0
    ExpandeLogoMarcaConfig.Esquerda = 0
    ExpandeLogoMarcaConfig.Topo = 0
    ExpandeLogoMarcaConfig.Largura = 0
    ExpandeLogoMarcaConfig.Dimensionar = False
    ExpandeLogoMarcaConfig.Esticar = True
    CasasDecimais.Formato = tdetInteger
    CasasDecimais.qCom = 2
    CasasDecimais.vUnCom = 2
    CasasDecimais.MaskqCom = ',0.00'
    CasasDecimais.MaskvUnCom = ',0.00'
    FonteLinhaItem.Charset = DEFAULT_CHARSET
    FonteLinhaItem.Color = clWindowText
    FonteLinhaItem.Height = -9
    FonteLinhaItem.Name = 'Lucida Console'
    FonteLinhaItem.Style = []
    Left = 386
    Top = 131
  end
  object ACBrMail1: TACBrMail
    Host = '127.0.0.1'
    Port = '25'
    SetSSL = False
    SetTLS = False
    Attempts = 3
    DefaultCharset = UTF_8
    IDECharset = CP1252
    Left = 682
    Top = 123
  end
end

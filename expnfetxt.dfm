object FExpNfetxt: TFExpNfetxt
  Left = 369
  Top = 195
  BorderStyle = bsDialog
  Caption = 'Envio XML da Nota Fiscal Eletronica '
  ClientHeight = 457
  ClientWidth = 984
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
  object PCadastro: TPanel
    Left = 0
    Top = 0
    Width = 984
    Height = 457
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    object PBotoes: TSQLPanelGrid
      Left = 879
      Top = 1
      Width = 104
      Height = 428
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
      OnClick = PBotoesClick
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
      object bExecutar: TSQLBtn
        Left = 3
        Top = 3
        Width = 100
        Height = 25
        Hint = 'Executa a exporta'#231#227'o'
        Caption = '&Exportar'
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
        OnClick = bExecutarClick
        Operation = fbNone
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bSair: TSQLBtn
        Left = 3
        Top = 54
        Width = 100
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
        Operation = fbExit
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bexportados: TSQLBtn
        Left = 3
        Top = 28
        Width = 100
        Height = 25
        Hint = 'relat'#243'rio da exporta'#231#227'o'
        Caption = '&Rel.Endere'#231'os'
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
        OnClick = bexportadosClick
        Operation = fbNone
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bexpxml: TSQLBtn
        Left = 2
        Top = 133
        Width = 100
        Height = 25
        Hint = 'Envia arquivo XML pra Sefa'
        Caption = '&Enviar SEFA'
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
        OnClick = bexpxmlClick
        Operation = fbNone
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bgerenciar: TSQLBtn
        Left = 2
        Top = 164
        Width = 100
        Height = 25
        Hint = 'atalho para gerenciamento das NFe'
        Caption = '&Gerenciar NFe'
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
        OnClick = bgerenciarClick
        Operation = fbNone
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bconsultasefa: TSQLBtn
        Left = 2
        Top = 189
        Width = 100
        Height = 25
        Hint = 'Consulta situa'#231#227'o das notas na Sefa'
        Caption = 'Cons&ulta Sefa'
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
        OnClick = bconsultasefaClick
        Operation = fbNone
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bconsutawebser: TSQLBtn
        Left = 1
        Top = 341
        Width = 100
        Height = 25
        Hint = 'Consulta situa'#231#227'o dos webservices no Portal Nacional da NFe'
        Caption = 'R&ecep'#231#227'o NFe'
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
        OnClick = bconsutawebserClick
        Operation = fbNone
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bimpnfprodutor: TSQLBtn
        Left = 2
        Top = 315
        Width = 100
        Height = 25
        Hint = 'Importa notas de produtor do Sisleite'
        Caption = 'Imp.NF Sisleite'
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
        OnClick = bimpnfprodutorClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bconsultarecibo: TSQLBtn
        Left = 1
        Top = 366
        Width = 100
        Height = 25
        Hint = 'Consulta recibo da nfe'
        Caption = 'Consulta Recibo'
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
        OnClick = bconsultareciboClick
        Operation = fbNone
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object Bevel1: TBevel
        Left = 4
        Top = 311
        Width = 92
        Height = 2
        Shape = bsTopLine
      end
      object bpreviewxml: TSQLBtn
        Left = 2
        Top = 215
        Width = 100
        Height = 25
        Hint = 'Mostra Espelho da Nota'
        Caption = '&Preview Danfe'
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
        OnClick = bpreviewxmlClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object baltentrada: TSQLBtn
        Left = 1
        Top = 390
        Width = 100
        Height = 25
        Hint = 'Altera'#231#227'o NF Entrada'
        Caption = 'Alt.NF Entrada'
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
        OnClick = baltentradaClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bgnre: TSQLBtn
        Left = 3
        Top = 274
        Width = 100
        Height = 25
        Hint = 'Guia Nacional de Recolhimento de Tributos Estaduai'
        Caption = 'GNRE'
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
        OnClick = bgnreClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bgeramdfe: TSQLBtn
        Left = 3
        Top = 243
        Width = 100
        Height = 25
        Hint = 'Gera um mdfe ref. a nfe escolhida'
        Caption = 'Gera &Mdfe'
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
        OnClick = bgeramdfeClick
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
      Top = 429
      Width = 982
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
      Width = 878
      Height = 428
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 2
      object Edunidade: TSQLEd
        Left = 210
        Top = 19
        Width = 208
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
        TabOrder = 9
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
        Left = 173
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
        TabOrder = 2
        Text = ''
        Visible = True
        OnKeyPress = EdUnid_codigoKeyPress
        Empty = False
        CloseForm = False
        CloseFormEsc = False
        ShowForm = 'FUnidades'
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
        Left = 101
        Top = 19
        Width = 58
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
        OnValidate = EdterminoValidate
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
        Left = 27
        Top = 19
        Width = 58
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
      object EdPasta: TSQLEd
        Left = 410
        Top = 63
        Width = 148
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
        TabOrder = 10
        Text = ''
        Visible = True
        Empty = False
        CloseForm = False
        CloseFormEsc = False
        OnExitEdit = EdPastaExitEdit
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Drive + Pasta ( Ex.: C:\Temp )'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'Local onde ser'#225' gerado o arquivo texto'
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
      object EdTran_codigo: TSQLEd
        Left = 26
        Top = 63
        Width = 63
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        TabOrder = 5
        Text = ''
        Visible = True
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        OnValidate = EdTran_codigoValidate
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'C'#243'digo(s) Transportador(es)'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'C'#243'digo do transportador'
        TypeValue = tvString
        ValueNegative = False
        Decimals = 0
        CharUpperLower = True
        OpGrids = [ogFilter, ogFind]
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
      object EdTran_nome: TSQLEd
        Left = 93
        Top = 63
        Width = 111
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
        MaxLength = 40
        ParentFont = False
        TabOrder = 11
        Text = ''
        Visible = True
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Nome Do Transportador'
        TitlePos = tppInvisible
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'Nome do transportador'
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
        PanelMessages = PMens
      end
      object pgrid: TSQLPanelGrid
        Left = 1
        Top = 139
        Width = 876
        Height = 288
        Align = alBottom
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 12
        HeightLimite = 0
        WidthLimite = 0
        FixedVisible = False
        object Grid: TSqlDtGrid
          Left = 1
          Top = 1
          Width = 874
          Height = 286
          Align = alClient
          ColCount = 10
          DefaultRowHeight = 18
          FixedCols = 0
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
          TabOrder = 0
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
              Title.Caption = 'Endere'#231'o'
              WidthColumn = 165
              FieldName = 'clie_endres'
            end
            item
              Title.Caption = 'Ver'
              WidthColumn = 25
              FieldName = 'clie_uf'
            end
            item
              Title.Caption = 'Retorno Sefa'
              WidthColumn = 200
              FieldName = 'retorno'
            end
            item
              Title.Caption = 'Transa'#231#227'o'
              WidthColumn = 80
              FieldName = 'moes_transacao'
            end
            item
              Title.Caption = 'Esp'#233'cie'
              WidthColumn = 60
              FieldName = 'moes_especie'
            end>
          RowCountMin = 0
          SelectedIndex = 0
          Version = '2.0'
          PermitePesquisa = True
          ColWidths = (
            50
            55
            65
            50
            130
            165
            25
            200
            80
            60)
          RowHeights = (
            18
            18)
        end
      end
      object Edformaemissao: TSQLEd
        Left = 359
        Top = 63
        Width = 46
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        MaxLength = 1
        TabOrder = 8
        Text = ''
        Visible = True
        Empty = False
        CloseForm = False
        CloseFormEsc = False
        OnExitEdit = EdPastaExitEdit
        OnValidate = EdformaemissaoValidate
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
        MessageStr = '1 - Normal   2 - Conting'#234'ncia'
        TypeValue = tvString
        ValueNegative = False
        Decimals = 0
        CharUpperLower = False
        Items.Strings = (
          '1 - Normal'
          '2 - Conting'#234'ncia FS'
          '7 - SVC-RS'
          '8 - Conting'#234'ncia Offline')
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
      object EdNumeronotas: TSQLEd
        Left = 26
        Top = 100
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
        TabOrder = 13
        Text = ''
        Visible = True
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clWindow
        ColorTextNotEnabled = clWhite
        Title = 'Nro. Notas'
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
      object EdAmbiente: TSQLEd
        Left = 511
        Top = 19
        Width = 46
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        MaxLength = 1
        TabOrder = 4
        Text = '1'
        Visible = True
        Empty = False
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Ambiente'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = '1 - Produ'#231#227'o   2 - Homologa'#231#227'o'
        TypeValue = tvString
        ValueNegative = False
        Decimals = 0
        CharUpperLower = False
        Items.Strings = (
          '1 - Produ'#231#227'o'
          '2 - Homologa'#231#227'o')
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
      object EdExportadas: TSQLEd
        Left = 303
        Top = 63
        Width = 46
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 7
        Text = ''
        Visible = True
        Empty = False
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Exportadas'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'Envia notas n'#227'o exportadas, exportadas ou ambas'
        TypeValue = tvString
        ValueNegative = False
        Decimals = 0
        CharUpperLower = False
        Items.Strings = (
          'N - somente N'#227'o exportadas'
          'S - somente exportadas'
          'A - ambas'
          'X - n'#227'o autorizadas')
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
      object EdNotas: TSQLEd
        Left = 206
        Top = 63
        Width = 94
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        MaxLength = 50
        TabOrder = 6
        Text = ''
        Visible = True
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        OnValidate = EdNotasValidate
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Notas a exportar'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'Notas a serem exportadas'
        TypeValue = tvString
        ValueNegative = False
        Decimals = 0
        CharUpperLower = False
        ItemsMultiples = True
        ItemsValid = True
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 6
        Duplicity = 0
        MinLength = 0
        Group = 0
        PanelMessages = PMens
      end
      object Edtipomov: TSQLEd
        Left = 432
        Top = 19
        Width = 46
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 3
        Text = 'T'
        Visible = True
        Empty = False
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Tipos NF'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'Filtra as notas de v'#225'rias formas'
        TypeValue = tvString
        ValueNegative = False
        Decimals = 0
        CharUpperLower = False
        Items.Strings = (
          'T - todos os tipos de movimento'
          'S - somente Notas de Produtor'
          'N - NFC-e'
          'I - Inutilizadas'
          'X - Canceladas'
          'D - somente Danfe(NFe)')
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
      object EdRecibo: TSQLEd
        Left = 584
        Top = 116
        Width = 201
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        TabOrder = 14
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
        ItemsMultiples = False
        ItemsValid = True
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 0
        Duplicity = 0
        MinLength = 0
        Group = 15
      end
      object MemoDAdos: TMemo
        Left = 584
        Top = 12
        Width = 287
        Height = 102
        ScrollBars = ssBoth
        TabOrder = 15
        Visible = False
      end
    end
  end
  object od1: TOpenDialog
    Filter = 'Arquivos TXT|*.TXT'
    Left = 347
    Top = 11
  end
  object ACBrNFe1: TACBrNFe
    MAIL = ACBrMail1
    Configuracoes.Geral.SSLLib = libWinCrypt
    Configuracoes.Geral.SSLCryptLib = cryWinCrypt
    Configuracoes.Geral.SSLHttpLib = httpWinHttp
    Configuracoes.Geral.SSLXmlSignLib = xsLibXml2
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Configuracoes.RespTec.IdCSRT = 0
    DANFE = ACBrNFeDANFeRL1
    Left = 457
    Top = 105
  end
  object ACBrGNRE1: TACBrGNRE
    Configuracoes.Geral.SSLLib = libNone
    Configuracoes.Geral.SSLCryptLib = cryNone
    Configuracoes.Geral.SSLHttpLib = httpNone
    Configuracoes.Geral.SSLXmlSignLib = xsNone
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.Arquivos.SalvarTXT = True
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    GNREGuia = ACBrGNREGuiaRL1
    Left = 114
    Top = 204
  end
  object ACBrGNREGuiaRL1: TACBrGNREGuiaRL
    ACBrGNRE = ACBrGNRE1
    MostrarPreview = True
    MostrarStatus = True
    TamanhoPapel = tpA4
    NumCopias = 1
    MargemInferior = 0.800000000000000000
    MargemSuperior = 0.800000000000000000
    MargemEsquerda = 0.600000000000000000
    MargemDireita = 0.510000000000000000
    PrintDialog = True
    Left = 234
    Top = 212
  end
  object ACBrNFeDANFeRL1: TACBrNFeDANFeRL
    Sistema = 'Sac - Storolli & Cia Ltda'
    MargemInferior = 8.000000000000000000
    MargemSuperior = 8.000000000000000000
    MargemEsquerda = 6.000000000000000000
    MargemDireita = 5.099999999999999000
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
    ACBrNFe = ACBrNFe1
    Left = 305
    Top = 105
  end
  object ACBrNFeDANFCeFortes1: TACBrNFeDANFCeFortes
    Sistema = 'SAC - Sistema Administrativo Comercial'
    MargemInferior = 8.000000000000000000
    MargemSuperior = 8.000000000000000000
    MargemEsquerda = 6.000000000000000000
    MargemDireita = 5.099999999999999000
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
    ImprimeCodigoEan = True
    FonteLinhaItem.Charset = DEFAULT_CHARSET
    FonteLinhaItem.Color = clWindowText
    FonteLinhaItem.Height = -9
    FonteLinhaItem.Name = 'Lucida Console'
    FonteLinhaItem.Style = []
    Left = 377
    Top = 105
  end
  object ACBrNFeDANFCeFortesA41: TACBrNFeDANFCeFortesA4
    Sistema = 'Projeto ACBr - www.projetoacbr.com.br'
    MargemInferior = 8.000000000000000000
    MargemSuperior = 8.000000000000000000
    MargemEsquerda = 6.000000000000000000
    MargemDireita = 5.099999999999999000
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
    Left = 521
    Top = 113
  end
  object ACBrMail1: TACBrMail
    Host = '127.0.0.1'
    Port = '25'
    SetSSL = False
    SetTLS = False
    Attempts = 3
    DefaultCharset = UTF_8
    IDECharset = CP1252
    Left = 554
    Top = 180
  end
end

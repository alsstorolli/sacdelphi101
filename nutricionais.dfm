object FNutricionais: TFNutricionais
  Left = 180
  Top = 121
  BorderStyle = bsDialog
  Caption = 'Informa'#231#245'es Nutricionais'
  ClientHeight = 461
  ClientWidth = 862
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
  object PCadastro: TPanel
    Left = 0
    Top = 0
    Width = 862
    Height = 461
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    object PBotoes: TSQLPanelGrid
      Left = 761
      Top = 1
      Width = 100
      Height = 432
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
      SQLGrid = Grid
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
      object APHeadLabel1: TAPHeadLabel
        Left = 1
        Top = 1
        Width = 98
        Height = 430
        Align = alClient
        AutoBounds = False
        BoundLines = []
        Gradient.EndColor = clGray
        Gradient.StartColor = clSilver
        SubCaption.Ellipsis = False
        SubCaption.Style = []
      end
      object bIncluir: TSQLBtn
        Left = 3
        Top = 3
        Width = 95
        Height = 25
        Hint = 'Inclui um novo registro'
        Caption = '&Incluir'
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
        OnClick = bIncluirClick
        Operation = fbInsert
        Grid = Grid
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bAlterar: TSQLBtn
        Left = 3
        Top = 28
        Width = 95
        Height = 25
        Hint = 'Altera o campo selecionado'
        Caption = '&Alterar'
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
        Operation = fbEdit
        Grid = Grid
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bExcluir: TSQLBtn
        Left = 3
        Top = 53
        Width = 95
        Height = 25
        Hint = 'Exclui o registro selecionado'
        Caption = '&Excluir'
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
        OnClick = bExcluirClick
        Operation = fbDelete
        Grid = Grid
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bCancelar: TSQLBtn
        Left = 3
        Top = 78
        Width = 95
        Height = 25
        Hint = 'Cancela a opera'#231#227'o em andamento'
        Caption = '&Cancelar'
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
        Operation = fbCancel
        Grid = Grid
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bFiltrar: TSQLBtn
        Left = 3
        Top = 103
        Width = 95
        Height = 25
        Hint = 'Aplica um filtro para o campo selecionado/Retira filtro'
        Caption = '&Filtrar'
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
        Operation = fbFilter
        Grid = Grid
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bOrdenar: TSQLBtn
        Left = 3
        Top = 128
        Width = 95
        Height = 25
        Hint = 'Ordena pelo campo selecionado'
        Caption = '&Ordenar'
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
        Operation = fbIndex
        Grid = Grid
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bPesquisar: TSQLBtn
        Left = 3
        Top = 153
        Width = 95
        Height = 25
        Hint = 'Pesquisa pelo campo selecionado'
        Caption = '&Pesquisar'
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
        Operation = fbFind
        Grid = Grid
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bRelatorio: TSQLBtn
        Left = 3
        Top = 203
        Width = 95
        Height = 25
        Hint = 'Emite o relat'#243'rio do cadastro'
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
        Spacing = 5
        OnClick = bRelatorioClick
        Operation = fbReports
        Grid = Grid
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bSair: TSQLBtn
        Left = 3
        Top = 228
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
        Operation = fbExit
        Grid = Grid
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bExpColumn: TSQLBtn
        Left = 4
        Top = 371
        Width = 23
        Height = 22
        Hint = 'Expande a coluna selecionada'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsItalic]
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777777777C777777700777777CC77777700777777CCC7777700777777CCCC77
          7700777777CCCCC77700777777CCCCCC7700777777CCCCCCC700777777CCCCCC
          7700777777CCCCC77700777777CCCC777700777777CCC7777700777777CC7777
          7700777777C77777770077777777777777777777777777777777}
        Margin = 0
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        Operation = fbExpColumn
        Grid = Grid
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 50
        DownUp = False
      end
      object Bevel1: TBevel
        Left = 4
        Top = 366
        Width = 92
        Height = 2
        Shape = bsTopLine
      end
      object bRedColumn: TSQLBtn
        Left = 27
        Top = 371
        Width = 23
        Height = 22
        Hint = 'Reduz a coluna selecionada'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsItalic]
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          77777777007777777C77777700777777CC7777770077777CCC777777007777CC
          CC77777700777CCCCC7777770077CCCCCC777777007CCCCCCC7777770077CCCC
          CC77777700777CCCCC777777007777CCCC7777770077777CCC77777700777777
          CC777777007777777C7777777777777777777777777777777777}
        Margin = 0
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        Operation = fbRedColumn
        Grid = Grid
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 50
        DownUp = False
      end
      object bMoveLeft: TSQLBtn
        Left = 50
        Top = 371
        Width = 23
        Height = 22
        Hint = 'Move para a esquerda a coluna selecionda'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsItalic]
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777777777777777777777777777777777777777777777777777777777777778
          4777774444477777487777444477777774777744477777777477774474777777
          7477774777487777487777777778444487777777777777777777777777777777
          7777777777777777777777777777777777777777777777777777}
        Margin = 0
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        Operation = fbMoveLeftColumn
        Grid = Grid
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bMoveRight: TSQLBtn
        Left = 73
        Top = 371
        Width = 23
        Height = 22
        Hint = 'Move para a direita a coluna selecionada'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsItalic]
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777777777777777777777777777777777777777777777777777777487777777
          7777778477777444447777477777774444777747777777744477774777777747
          4477778477778477747777784444877777777777777777777777777777777777
          7777777777777777777777777777777777777777777777777777}
        Margin = 0
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        Operation = fbMoveRightColumn
        Grid = Grid
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bDelColumn: TSQLBtn
        Left = 4
        Top = 393
        Width = 23
        Height = 22
        Hint = 'Apaga a coluna selecionada'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsItalic]
        Glyph.Data = {
          66010000424D6601000000000000760000002800000014000000140000000100
          040000000000F0000000120B0000120B00001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777777700007778448777777844877700007784774877778477487700007784
          7774777747774877000077847774777747774877000077784774877847748777
          0000777784444884444877770000777777444444447777770000777777748FF8
          47777777000077777778F00F0777777700007777778F77F07077777700007777
          78F7708F77077777000077778F770778F770777700007778F77077778F770777
          0000778F7707777778F770770000778F70777777778F70770000778F07777777
          7778F07700007788777777777777887700007777777777777777777700007777
          77777777777777770000}
        Margin = 0
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        Operation = fbDelColumn
        Grid = Grid
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bRestColumn: TSQLBtn
        Left = 27
        Top = 393
        Width = 23
        Height = 22
        Hint = 'Restaura todas as colunas'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsItalic]
        Glyph.Data = {
          4E010000424D4E01000000000000760000002800000012000000120000000100
          040000000000D800000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00744777777777
          7777770000004774774477777777770000004774747747777777770000004774
          7477477777777700000074447477477777777700000077747444777777777700
          0000777404777744447777000000777707777477774777000000777000774777
          7774770000007770707747777774770000007700700747777774770000007707
          7707477777747700000077077707777477747700000077077707774477477700
          0000777777777444447777000000777777777744777777000000777777777774
          777777000000777777777777777777000000}
        Margin = 0
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        Operation = fbRestColumn
        Grid = Grid
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bLoadGrid: TSQLBtn
        Left = 50
        Top = 393
        Width = 23
        Height = 22
        Hint = 'Restaura o formato padr'#227'o para a grade'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsItalic]
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
          DDDDDDDDD0000000000000DD0887787870F0600087770000077060F7F7F17707
          7F70E0FFFFFF78FFFF70F08888888FFFFF70C0FFFFFFFF0F0070D8FFFFFFFFFF
          FF70D8F00F000F0F0070D8FFFFFFFFFFFF70D8F00F000F0F0070D8FFFFFFFFFF
          FF70D444444444444444DC6C6C6C6C6C6C6CDCCCCCCCCCCCCCCC}
        Margin = 0
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        Operation = fbLoadGrid
        Grid = Grid
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bSaveGrid: TSQLBtn
        Left = 73
        Top = 393
        Width = 23
        Height = 22
        Hint = 'Grava o formato atual da grade'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsItalic]
        Glyph.Data = {
          66010000424D6601000000000000760000002800000014000000140000000100
          040000000000F0000000CE0E0000C40E00001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777777700007777777777777777777700007777000000000000077700007770
          CC07447770CC077700007770CC07447770CC077700007770CC07447770CC0777
          00007770CCC777777CCC077700007770CCCCCCCCCCCC077700007770CC000000
          00CC077700007770C0FFFFFFFF0C077700007770C0FFFFFFFF0C077700007770
          C0F888888F0C077700007770C0FFFFFFFF0C07770000777070F888888F000777
          00007770C0FFFFFFFF0C07770000777000000000000007770000777777777777
          7777777700007777777777777777777700007777777777777777777700007777
          77777777777777770000}
        Margin = 0
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        Operation = fbSaveGrid
        Grid = Grid
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bRestaurar: TSQLBtn
        Left = 3
        Top = 178
        Width = 95
        Height = 25
        Hint = 'Recupera todos os registros do servidor'
        Caption = 'Res&taurar'
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
        Operation = fbRestaurar
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
      Top = 433
      Width = 860
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
      SQLGrid = Grid
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 760
      Height = 432
      Align = alClient
      BevelOuter = bvLowered
      Caption = 'Panel1'
      TabOrder = 2
      object PEdits: TSQLPanelGrid
        Left = 1
        Top = 324
        Width = 758
        Height = 107
        Align = alBottom
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
        Visible = False
        SQLGrid = Grid
        HeightLimite = 0
        WidthLimite = 0
        FixedVisible = False
        object EdNutr_codigo: TSQLEd
          Left = 5
          Top = 30
          Width = 80
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
          Title = 'C'#243'digo'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'C'#243'digo da tabela nutricional'
          TypeValue = tvInteger
          ValueNegative = False
          Decimals = 0
          ValueFormat = '#######0'
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
          Table = Arq.TNutricionais
          TableName = 'nutricionais'
          TableField = 'Nutr_codigo'
          PanelMessages = PMens
        end
        object EdNutr_porcaocaseira: TSQLEd
          Left = 95
          Top = 30
          Width = 149
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 30
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
          Title = 'Por'#231#227'o Caseira'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Descri'#231#227'o da por'#231#227'o caseira do produto'
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
          Group = 0
          Table = Arq.TNutricionais
          TableName = 'nutricionais'
          TableField = 'Nutr_porcaocaseira'
          PanelMessages = PMens
        end
        object EdNutr_qtdeporcao: TSQLEd
          Left = 252
          Top = 30
          Width = 61
          Height = 21
          TabStop = False
          Alignment = taRightJustify
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
          Title = 'Quantidade'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Quantidade do produto na por'#231#227'o caseira'
          TypeValue = tvFloat
          ValueNegative = False
          Decimals = 3
          ValueFormat = '####0.000'
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          Group = 0
          Table = Arq.TNutricionais
          TableName = 'nutricionais'
          TableField = 'Nutr_qtdeporcao'
          PanelMessages = PMens
        end
        object EdNutr_unporcao: TSQLEd
          Left = 404
          Top = 30
          Width = 50
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 5
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
          Title = 'Unid'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Unidade da por'#231#227'o caseira do produto'
          TypeValue = tvString
          ValueNegative = False
          Decimals = 0
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = False
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 2
          Duplicity = 0
          MinLength = 0
          Group = 0
          Table = Arq.TNutricionais
          TableName = 'nutricionais'
          TableField = 'Nutr_unporcao'
          PanelMessages = PMens
        end
        object EdNutr_balanca: TSQLEd
          Left = 431
          Top = 6
          Width = 25
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
          MaxLength = 1
          ParentFont = False
          TabOrder = 6
          Text = ''
          Visible = False
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Bal'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Indica se a informa'#231#227'o nutricional ser'#225' enviada para balan'#231'a'
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
          Group = 0
          Table = Arq.TNutricionais
          TableName = 'nutricionais'
          TableField = 'Nutr_balanca'
          PanelMessages = PMens
        end
        object EdNutr_fator: TSQLEd
          Left = 554
          Top = 6
          Width = 80
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
          MaxLength = 10
          ParentFont = False
          TabOrder = 7
          Text = ''
          Visible = False
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Fator'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Fator de multiplica'#231#227'o para industrializa'#231#227'o'
          TypeValue = tvFloat
          ValueNegative = False
          Decimals = 3
          ValueFormat = '####0.000'
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          Group = 0
          Table = Arq.TNutricionais
          TableName = 'nutricionais'
          TableField = 'Nutr_fator'
          PanelMessages = PMens
        end
        object EdNutr_calorias: TSQLEd
          Left = 580
          Top = 30
          Width = 80
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          MaxLength = 10
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
          Title = 'Calorias'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Quantidade de calorias (Kcal) de uma por'#231#227'o do produto'
          TypeValue = tvFloat
          ValueNegative = False
          Decimals = 3
          ValueFormat = '####0.000'
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          Group = 0
          Table = Arq.TNutricionais
          TableName = 'nutricionais'
          TableField = 'Nutr_calorias'
          PanelMessages = PMens
        end
        object EdNutr_carboidratos: TSQLEd
          Left = 670
          Top = 30
          Width = 80
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          MaxLength = 10
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
          Title = 'Carboidratos'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Quantidade de carbohidratos (g) de uma por'#231#227'o do produto'
          TypeValue = tvFloat
          ValueNegative = False
          Decimals = 3
          ValueFormat = '####0.000'
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          Group = 0
          Table = Arq.TNutricionais
          TableName = 'nutricionais'
          TableField = 'Nutr_carboidratos'
          PanelMessages = PMens
        end
        object EdNutr_proteinas: TSQLEd
          Left = 5
          Top = 70
          Width = 80
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          MaxLength = 10
          TabOrder = 10
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Proteinas'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Quantidade de prote'#237'nas (g) de uma por'#231#227'o do produto'
          TypeValue = tvFloat
          ValueNegative = False
          Decimals = 3
          ValueFormat = '####0.000'
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          Group = 0
          Table = Arq.TNutricionais
          TableName = 'nutricionais'
          TableField = 'Nutr_proteinas'
          PanelMessages = PMens
        end
        object EdNutr_gordtotais: TSQLEd
          Left = 104
          Top = 70
          Width = 80
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          MaxLength = 10
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
          Title = 'Gorduras Totais'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Quantidade de gorduras totais (g) de uma por'#231#227'o do produto'
          TypeValue = tvFloat
          ValueNegative = False
          Decimals = 3
          ValueFormat = '####0.000'
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          Group = 0
          Table = Arq.TNutricionais
          TableName = 'nutricionais'
          TableField = 'Nutr_gordtotais'
          PanelMessages = PMens
        end
        object EdNutr_gordsaturadas: TSQLEd
          Left = 194
          Top = 70
          Width = 80
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          MaxLength = 10
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
          Title = 'Gord. Saturadas'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Quantidade de gorduras saturadas (g) de uma por'#231#227'o do produto'
          TypeValue = tvFloat
          ValueNegative = False
          Decimals = 3
          ValueFormat = '####0.000'
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          Group = 0
          Table = Arq.TNutricionais
          TableName = 'nutricionais'
          TableField = 'Nutr_gordsaturadas'
          PanelMessages = PMens
        end
        object EdNutr_fibras: TSQLEd
          Left = 376
          Top = 70
          Width = 80
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          MaxLength = 10
          TabOrder = 14
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Fibras Aliment.'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Quantidade de fibras alimentares (g) de uma por'#231#227'o do produto'
          TypeValue = tvFloat
          ValueNegative = False
          Decimals = 3
          ValueFormat = '####0.000'
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          Group = 0
          Table = Arq.TNutricionais
          TableName = 'nutricionais'
          TableField = 'Nutr_fibras'
          PanelMessages = PMens
        end
        object EdNutr_colesterol: TSQLEd
          Left = 285
          Top = 70
          Width = 80
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          MaxLength = 10
          TabOrder = 13
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Colesterol'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Quantidade de colesterol (mg) de uma por'#231#227'o do produto'
          TypeValue = tvFloat
          ValueNegative = False
          Decimals = 3
          ValueFormat = '####0.000'
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          Group = 0
          Table = Arq.TNutricionais
          TableName = 'nutricionais'
          TableField = 'Nutr_colesterol'
          PanelMessages = PMens
        end
        object EdNutr_calcio: TSQLEd
          Left = 471
          Top = 70
          Width = 80
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          MaxLength = 10
          TabOrder = 15
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'C'#225'lcio'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Quantidade de c'#225'lcio (mg) de uma por'#231#227'o do produto'
          TypeValue = tvFloat
          ValueNegative = False
          Decimals = 3
          ValueFormat = '####0.000'
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          Group = 0
          Table = Arq.TNutricionais
          TableName = 'nutricionais'
          TableField = 'Nutr_calcio'
          PanelMessages = PMens
        end
        object EdNutr_ferro: TSQLEd
          Left = 568
          Top = 70
          Width = 80
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          MaxLength = 10
          TabOrder = 16
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Ferro'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Quantidade de ferro (mg) de uma por'#231#227'o do produto'
          TypeValue = tvFloat
          ValueNegative = False
          Decimals = 3
          ValueFormat = '####0.000'
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          Group = 0
          Table = Arq.TNutricionais
          TableName = 'nutricionais'
          TableField = 'Nutr_ferro'
          PanelMessages = PMens
        end
        object EdNutr_sodio: TSQLEd
          Left = 669
          Top = 70
          Width = 80
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          MaxLength = 10
          TabOrder = 17
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          OnExitEdit = EdNutr_sodioExitEdit
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'S'#243'dio'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Quantidade de s'#243'dio (mg) de uma por'#231#227'o do produto'
          TypeValue = tvFloat
          ValueNegative = False
          Decimals = 3
          ValueFormat = '####0.000'
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          Group = 0
          Table = Arq.TNutricionais
          TableName = 'nutricionais'
          TableField = 'Nutr_sodio'
          PanelMessages = PMens
        end
        object EdNutr_nomebalanca: TSQLEd
          Left = 519
          Top = 6
          Width = 25
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
          MaxLength = 1
          ParentFont = False
          TabOrder = 18
          Text = ''
          Visible = False
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Bal'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Nome da balan'#231'a usada'
          TypeValue = tvString
          ValueNegative = False
          Decimals = 0
          CharUpperLower = True
          OpGrids = []
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          Group = 0
          Table = Arq.TNutricionais
          TableName = 'nutricionais'
          TableField = 'Nutr_nomebalanca'
          PanelMessages = PMens
        end
        object EdNutr_qtde: TSQLEd
          Left = 326
          Top = 30
          Width = 61
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          MaxLength = 10
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
          Title = 'Unidades'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Quantidade de unidades'
          TypeValue = tvFloat
          ValueNegative = False
          Decimals = 3
          ValueFormat = '####0.000'
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          Group = 0
          Table = Arq.TNutricionais
          TableName = 'nutricionais'
          TableField = 'Nutr_qtde'
          PanelMessages = PMens
        end
        object EdNutr_validade: TSQLEd
          Left = 488
          Top = 30
          Width = 61
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          MaxLength = 5
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
          Title = 'Validade'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Validade em dias do produto'
          TypeValue = tvInteger
          ValueNegative = False
          Decimals = 0
          ValueFormat = '####0'
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          Group = 0
          Table = Arq.TNutricionais
          TableName = 'nutricionais'
          TableField = 'Nutr_validade'
          PanelMessages = PMens
        end
      end
      object Grid: TSQLGrid
        Left = 1
        Top = 1
        Width = 758
        Height = 323
        Align = alClient
        Color = clWhite
        DataSource = Dts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        ColumnInitial = 0
        Reduce = 0
        FieldTransport = 'nutr_codigo'
        OnNewRecord = GridNewRecord
        PanelInsert = PEdits
        PanelMessage = PMens
        PanelButtons = PBotoes
        Columns = <
          item
            Expanded = False
            FieldName = 'nutr_codigo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nutr_porcaocaseira'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nutr_qtdeporcao'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nutr_qtde'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nutr_unporcao'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nutr_calorias'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nutr_carboidratos'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nutr_proteinas'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nutr_gordtotais'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nutr_gordsaturadas'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nutr_fibras'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nutr_colesterol'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nutr_calcio'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nutr_ferro'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nutr_sodio'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nutr_nomebalanca'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nutr_validade'
            Visible = True
          end>
      end
    end
  end
  object Dts: TDataSource
    DataSet = Arq.TNutricionais
    Left = 216
    Top = 128
  end
end

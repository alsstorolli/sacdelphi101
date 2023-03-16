object FTamanhos: TFTamanhos
  Left = 346
  Top = 165
  BorderStyle = bsDialog
  Caption = 'Cadastro de Tamanhos'
  ClientHeight = 454
  ClientWidth = 614
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
    Width = 614
    Height = 454
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    object PBotoes: TSQLPanelGrid
      Left = 513
      Top = 1
      Width = 100
      Height = 425
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
        Height = 423
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
        Top = 379
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
        Top = 373
        Width = 92
        Height = 2
        Shape = bsTopLine
      end
      object bRedColumn: TSQLBtn
        Left = 27
        Top = 379
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
        Top = 379
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
        Top = 379
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
        Top = 401
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
        Top = 401
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
        Top = 401
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
        Top = 401
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
      Top = 426
      Width = 612
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
      Width = 512
      Height = 425
      Align = alClient
      BevelOuter = bvLowered
      Caption = 'Panel1'
      TabOrder = 2
      object PEdits: TSQLPanelGrid
        Left = 1
        Top = 379
        Width = 510
        Height = 45
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
        object EdTama_codigo: TSQLEd
          Left = 5
          Top = 17
          Width = 40
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          MaxLength = 3
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
          MessageStr = 'C'#243'digo do tamanho'
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
          Duplicity = 2
          MinLength = 0
          Group = 0
          Table = Arq.TTamanhos
          TableName = 'tamanhos'
          TableField = 'Tama_codigo'
          PanelMessages = PMens
        end
        object EdTama_reduzido: TSQLEd
          Left = 49
          Top = 17
          Width = 60
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 10
          TabOrder = 1
          Text = ''
          Visible = True
          Empty = False
          CloseForm = False
          CloseFormEsc = False
          OnValidate = EdTama_reduzidoValidate
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Forma red.'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Descri'#231#227'o reduzida do tamanho'
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
          Table = Arq.TTamanhos
          TableName = 'tamanhos'
          TableField = 'Tama_reduzido'
          PanelMessages = PMens
        end
        object EdTama_descricao: TSQLEd
          Left = 112
          Top = 17
          Width = 209
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 50
          TabOrder = 2
          Text = ''
          Visible = True
          Empty = False
          CloseForm = False
          CloseFormEsc = False
          OnExitEdit = EdTama_descricaoExitEdit
          OnValidate = EdTama_descricaoValidate
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Descri'#231#227'o do tamanho'
          TitlePos = tppTop
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
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          Group = 0
          Table = Arq.TTamanhos
          TableName = 'tamanhos'
          TableField = 'Tama_descricao'
          PanelMessages = PMens
        end
        object EdTama_comprimento: TSQLEd
          Left = 323
          Top = 17
          Width = 63
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          MaxLength = 11
          TabOrder = 3
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          OnExitEdit = EdTama_descricaoExitEdit
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Comprimento'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Comprimento '
          TypeValue = tvFloat
          ValueNegative = False
          Decimals = 4
          ValueFormat = '##,##0.0000'
          CharUpperLower = True
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          Group = 0
          Table = Arq.TTamanhos
          TableName = 'tamanhos'
          TableField = 'Tama_comprimento'
          PanelMessages = PMens
        end
        object EdTama_largura: TSQLEd
          Left = 388
          Top = 17
          Width = 55
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          MaxLength = 11
          TabOrder = 4
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          OnExitEdit = EdTama_descricaoExitEdit
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Largura'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Largura '
          TypeValue = tvFloat
          ValueNegative = False
          Decimals = 4
          ValueFormat = '##,##0.0000'
          CharUpperLower = True
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          Group = 0
          Table = Arq.TTamanhos
          TableName = 'tamanhos'
          TableField = 'Tama_largura'
          PanelMessages = PMens
        end
        object EdTama_espessura: TSQLEd
          Left = 447
          Top = 17
          Width = 55
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          MaxLength = 11
          TabOrder = 5
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          OnExitEdit = EdTama_descricaoExitEdit
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Espes.'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Espessura'
          TypeValue = tvFloat
          ValueNegative = False
          Decimals = 4
          ValueFormat = '##,##0.0000'
          CharUpperLower = True
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          Group = 0
          Table = Arq.TTamanhos
          TableName = 'tamanhos'
          TableField = 'Tama_espessura'
          PanelMessages = PMens
        end
      end
      object Grid: TSQLGrid
        Left = 1
        Top = 1
        Width = 510
        Height = 378
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
        FieldTransport = 'tama_codigo'
        PanelInsert = PEdits
        PanelMessage = PMens
        PanelButtons = PBotoes
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'tama_codigo'
            Title.Alignment = taCenter
            Title.Caption = 'C'#243'digo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tama_reduzido'
            Title.Caption = 'Forma Reduzida'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tama_descricao'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tama_comprimento'
            Title.Caption = 'Comprimento'
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tama_largura'
            Title.Caption = 'Largura'
            Width = 65
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tama_espessura'
            Title.Caption = 'Espessura'
            Width = 65
            Visible = True
          end>
      end
    end
  end
  object Dts: TDataSource
    DataSet = Arq.TTamanhos
    Left = 216
    Top = 128
  end
end

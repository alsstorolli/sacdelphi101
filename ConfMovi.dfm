object FConfMovimento: TFConfMovimento
  Left = 273
  Top = 166
  BorderStyle = bsDialog
  Caption = 'Configura'#231#227'o de Movimentos'
  ClientHeight = 463
  ClientWidth = 605
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object PCadastro: TPanel
    Left = 0
    Top = 0
    Width = 605
    Height = 463
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    object PBotoes: TSQLPanelGrid
      Left = 504
      Top = 1
      Width = 100
      Height = 434
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
        Height = 432
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
        AutoAction = False
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
        OnClick = bCancelarClick
        Operation = fbCancel
        Grid = Grid
        Processing = False
        AutoAction = False
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
        Top = 253
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
        Top = 366
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
        Top = 362
        Width = 92
        Height = 2
        Shape = bsTopLine
      end
      object bRedColumn: TSQLBtn
        Left = 27
        Top = 366
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
        Top = 366
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
        Top = 366
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
        Top = 388
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
        Top = 388
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
        Top = 388
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
        Top = 388
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
      object bEditar: TSQLBtn
        Left = 3
        Top = 28
        Width = 95
        Height = 25
        Hint = 'Edita o registro selecionado'
        Caption = 'E&ditar'
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
        OnClick = bEditarClick
        Operation = fbEditAll
        Grid = Grid
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bcopiacampos: TSQLBtn
        Left = 3
        Top = 228
        Width = 95
        Height = 25
        Hint = 'Copia os campos das nota'
        Caption = 'Copia Campos'
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
        OnClick = bcopiacamposClick
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
      Top = 435
      Width = 603
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
      Width = 503
      Height = 434
      Align = alClient
      BevelOuter = bvLowered
      Caption = 'Panel1'
      TabOrder = 2
      object PEdits: TSQLPanelGrid
        Left = 1
        Top = 256
        Width = 501
        Height = 177
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
        object EdComv_codigo: TSQLEd
          Left = 5
          Top = 24
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
          Title = 'Codigo'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Codigo da configura'#231#227'o'
          TypeValue = tvInteger
          ValueNegative = False
          Decimals = 0
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 2
          MinLength = 0
          Group = 0
          Table = Arq.TConfMovimento
          TableName = 'Confmov'
          TableField = 'Comv_codigo'
          PanelMessages = PMens
        end
        object EdComv_descricao: TSQLEd
          Left = 55
          Top = 24
          Width = 200
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 50
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
          Title = 'Descri'#231#227'o'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Descri'#231#227'o da configura'#231#227'o'
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
          Table = Arq.TConfMovimento
          TableName = 'Confmov'
          TableField = 'Comv_descricao'
          PanelMessages = PMens
        end
        object EdComv_especie: TSQLEd
          Left = 5
          Top = 62
          Width = 40
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 4
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
          Title = 'Esp'#233'cie'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Esp'#233'cie do documento'
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
          Table = Arq.TConfMovimento
          TableName = 'Confmov'
          TableField = 'Comv_especie'
          PanelMessages = PMens
        end
        object EdComv_serie: TSQLEd
          Left = 55
          Top = 62
          Width = 40
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 4
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
          Title = 'S'#233'rie'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'S'#233'rie do documento'
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
          Table = Arq.TConfMovimento
          TableName = 'Confmov'
          TableField = 'Comv_serie'
          PanelMessages = PMens
        end
        object EdComv_natf_estado: TSQLEd
          Left = 105
          Top = 62
          Width = 49
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          EditMask = '#.####;0;_'
          MaxLength = 6
          TabOrder = 6
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ShowForm = 'FNatureza'
          OnValidate = EdComv_natf_estadoValidate
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Cfop Est.'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'C'#243'd. da natureza fiscal no estado'
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
          FindTable = 'NATUREZA'
          FindField = 'NATF_CODIGO'
          Group = 0
          Table = Arq.TConfMovimento
          TableName = 'Confmov'
          TableField = 'Comv_natf_estado'
          PanelMessages = PMens
        end
        object EdComv_natf_foestado: TSQLEd
          Left = 164
          Top = 62
          Width = 49
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          EditMask = '#.####;0;_'
          MaxLength = 6
          TabOrder = 7
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ShowForm = 'FNatureza'
          OnExitEdit = EdComv_natf_foestadoExitEdit
          OnValidate = EdComv_natf_foestadoValidate
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Cfop F.Est.'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'C'#243'digo da natureza fiscal fora do estado'
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
          FindTable = 'NATUREZA'
          FindField = 'NATF_CODIGO'
          Group = 0
          Table = Arq.TConfMovimento
          TableName = 'Confmov'
          TableField = 'Comv_natf_foestado'
          PanelMessages = PMens
        end
        object EdComv_tipomovto: TSQLEd
          Left = 270
          Top = 24
          Width = 30
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 2
          TabOrder = 2
          Text = ''
          Visible = True
          Empty = False
          CloseForm = False
          CloseFormEsc = False
          OnValidate = EdComv_tipomovtoValidate
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Tipo Movto'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Tipo de movimento'
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
          Table = Arq.TConfMovimento
          TableName = 'Confmov'
          TableField = 'Comv_tipomovto'
          PanelMessages = PMens
        end
        object EdComv_usua_codigo: TSQLEd
          Left = 445
          Top = 6
          Width = 50
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
          TabOrder = 8
          Text = ''
          Visible = False
          Empty = False
          CloseForm = False
          CloseFormEsc = False
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Usu'#225'rio'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Usu'#225'rio respons'#225'vel'
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
          Group = 0
          Table = Arq.TConfMovimento
          TableName = 'Confmov'
          TableField = 'Comv_usua_codigo'
          PanelMessages = PMens
        end
        object Eddesctipomovto: TSQLEd
          Left = 328
          Top = 23
          Width = 164
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
          MessageStr = 'Descri'#231#227'o do tipo de movimento'
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
        object EdComv_natf_estadoipi: TSQLEd
          Left = 222
          Top = 62
          Width = 55
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          EditMask = '#.####;0;_'
          MaxLength = 6
          TabOrder = 9
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ShowForm = 'FNatureza'
          OnValidate = EdComv_natf_estadoValidate
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Cfop Est.IPI'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'C'#243'd. da natureza fiscal no estado ref. IPI'
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
          FindTable = 'NATUREZA'
          FindField = 'NATF_CODIGO'
          Group = 0
          Table = Arq.TConfMovimento
          TableName = 'Confmov'
          TableField = 'Comv_natf_estadoipi'
          PanelMessages = PMens
        end
        object EdComv_natf_foestadoipi: TSQLEd
          Left = 283
          Top = 62
          Width = 67
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          EditMask = '#.####;0;_'
          MaxLength = 6
          TabOrder = 10
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ShowForm = 'FNatureza'
          OnExitEdit = EdComv_natf_foestadoExitEdit
          OnValidate = EdComv_natf_foestadoValidate
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Cfop F.Est. IPI'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'C'#243'digo da natureza fiscal fora do estado ref. IPI'
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
          FindTable = 'NATUREZA'
          FindField = 'NATF_CODIGO'
          Group = 0
          Table = Arq.TConfMovimento
          TableName = 'Confmov'
          TableField = 'Comv_natf_foestadoipi'
          PanelMessages = PMens
        end
        object Edcomv_natf_estadoser: TSQLEd
          Left = 356
          Top = 62
          Width = 55
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          EditMask = '#.####;0;_'
          MaxLength = 6
          TabOrder = 11
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ShowForm = 'FNatureza'
          OnValidate = EdComv_natf_estadoValidate
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Cfop Est.Ser.'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'C'#243'd. da natureza fiscal no estado ref. servi'#231'os'
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
          FindTable = 'NATUREZA'
          FindField = 'NATF_CODIGO'
          Group = 0
          Table = Arq.TConfMovimento
          TableName = 'Confmov'
          TableField = 'comv_natf_estadoser'
          PanelMessages = PMens
        end
        object Edcomv_natf_foestadoser: TSQLEd
          Left = 417
          Top = 62
          Width = 55
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          EditMask = '#.####;0;_'
          MaxLength = 6
          TabOrder = 12
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ShowForm = 'FNatureza'
          OnValidate = EdComv_natf_estadoValidate
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Cfop F.Est.Ser.'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'C'#243'd. da natureza fiscal fora do estado ref. servi'#231'os'
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
          FindTable = 'NATUREZA'
          FindField = 'NATF_CODIGO'
          Group = 0
          Table = Arq.TConfMovimento
          TableName = 'Confmov'
          TableField = 'comv_natf_foestadoser'
          PanelMessages = PMens
        end
        object EdSTServicos: TSQLEd
          Left = 7
          Top = 99
          Width = 26
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          MaxLength = 2
          TabOrder = 13
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ShowForm = 'FSittributaria'
          OnExitEdit = EdComv_natf_foestadoExitEdit
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'ST Servi'#231'os'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Situa'#231#227'o tribut'#225'ria ref. servi'#231'os'
          TypeValue = tvInteger
          ValueNegative = False
          Decimals = 0
          ValueFormat = '#0'
          CharUpperLower = False
          OpGrids = [ogFilter, ogFind]
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          FindTable = 'sittrib'
          FindField = 'sitt_codigo'
          FindSetField = 'sitt_cst'
          FindSetEdt = SetEdSt
          Group = 0
          Table = Arq.TConfMovimento
          TableName = 'Confmov'
          TableField = 'Comv_sitt_codigo'
          PanelMessages = PMens
        end
        object SetEdSt: TSQLEd
          Left = 36
          Top = 99
          Width = 95
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
          Title = 'Nome do Produto'
          TitlePos = tppInvisible
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Nome do produto'
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
          PanelMessages = PMens
        end
        object EdComv_debito: TSQLEd
          Left = 145
          Top = 99
          Width = 46
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          MaxLength = 6
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
          Title = 'D'#233'bito'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Conta reduzida de d'#233'bito para contabiliza'#231#227'o'
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
          Group = 0
          Table = Arq.TConfMovimento
          TableName = 'Confmov'
          TableField = 'Comv_debito'
          PanelMessages = PMens
        end
        object EdComv_credito: TSQLEd
          Left = 200
          Top = 99
          Width = 46
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          MaxLength = 6
          TabOrder = 16
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          OnExitEdit = EdComv_natf_foestadoExitEdit
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Cr'#233'dito'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Conta reduzida de cr'#233'dito para contabiliza'#231#227'o'
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
          Group = 0
          Table = Arq.TConfMovimento
          TableName = 'Confmov'
          TableField = 'Comv_credito'
          PanelMessages = PMens
        end
        object EdComv_plan_conta: TSQLEd
          Left = 252
          Top = 99
          Width = 50
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          MaxLength = 6
          TabOrder = 17
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ShowForm = 'FPlano'
          OnExitEdit = EdComv_natf_foestadoExitEdit
          OnValidate = EdComv_plan_contaValidate
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Conta Despesa'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Conta de despesa do plano gerencial'
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
          FindTable = 'plano'
          FindField = 'plan_conta'
          FindSetField = 'plan_descricao'
          FindSetEdt = SetEdplan_descricao
          Group = 0
          Table = Arq.TConfMovimento
          TableName = 'Confmov'
          TableField = 'Comv_plan_conta'
          PanelMessages = PMens
        end
        object SetEdplan_descricao: TSQLEd
          Left = 311
          Top = 99
          Width = 169
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
          TabOrder = 18
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
          PanelMessages = PMens
        end
        object EdEditsentrada: TSQLEd
          Left = 8
          Top = 136
          Width = 473
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          TabOrder = 19
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          OnExitEdit = EdComv_natf_foestadoExitEdit
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Campos Nota Entrada'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Campos da nota de entrada sem uso'
          TypeValue = tvString
          ValueNegative = False
          Decimals = 0
          CharUpperLower = False
          ItemsMultiples = True
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 15
          Duplicity = 0
          MinLength = 0
          Group = 0
          Table = Arq.TConfMovimento
          TableName = 'Confmov'
          TableField = 'comv_editsnota'
          PanelMessages = PMens
        end
      end
      object Grid: TSQLGrid
        Left = 1
        Top = 1
        Width = 501
        Height = 255
        Align = alClient
        Color = clWhite
        DataSource = DSCadastro
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
        FieldTransport = 'Comv_Codigo'
        OnNewRecord = GridNewRecord
        PanelMessage = PMens
        PanelButtons = PBotoes
        Columns = <
          item
            Expanded = False
            FieldName = 'comv_codigo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'comv_descricao'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'comv_especie'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'comv_serie'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'comv_natf_estado'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'comv_natf_foestado'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'comv_tipomovto'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'comv_debito'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'comv_credito'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'comv_plan_conta'
            Visible = True
          end>
      end
    end
  end
  object DSCadastro: TDataSource
    DataSet = Arq.TConfMovimento
    Left = 208
    Top = 88
  end
end

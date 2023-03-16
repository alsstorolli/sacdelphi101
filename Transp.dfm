object FTransp: TFTransp
  Left = 359
  Top = 163
  BorderStyle = bsDialog
  Caption = 'Cadastro de Transportadores'
  ClientHeight = 472
  ClientWidth = 696
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
    Width = 696
    Height = 472
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    object PBotoes: TSQLPanelGrid
      Left = 595
      Top = 1
      Width = 100
      Height = 443
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
        Height = 441
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
        Top = 127
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
        Top = 397
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
        Top = 391
        Width = 92
        Height = 2
        Shape = bsTopLine
      end
      object bRedColumn: TSQLBtn
        Left = 27
        Top = 397
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
        Top = 397
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
        Top = 397
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
        Top = 419
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
        Top = 419
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
        Top = 419
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
        Top = 419
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
    end
    object PMens: TSQLPanelGrid
      Left = 1
      Top = 444
      Width = 694
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
      Width = 594
      Height = 443
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 2
      object PEdits: TSQLPanelGrid
        Left = 1
        Top = 210
        Width = 592
        Height = 232
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
        object EdTran_codigo: TSQLEd
          Left = 5
          Top = 30
          Width = 33
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 3
          TabOrder = 0
          Text = ''
          Visible = True
          OnKeyPress = EdTran_codigoKeyPress
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
          MessageStr = 'C'#243'digo do transportador'
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
          ItemsLength = 0
          Duplicity = 2
          MinLength = 0
          Group = 0
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'Tran_codigo'
          PanelMessages = PMens
        end
        object EdTran_nome: TSQLEd
          Left = 45
          Top = 30
          Width = 250
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 40
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
          Title = 'Nome Do Transportador'
          TitlePos = tppTop
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
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'Tran_nome'
          PanelMessages = PMens
        end
        object EdTran_razaosocial: TSQLEd
          Left = 301
          Top = 30
          Width = 280
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 50
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
          Title = 'Raz'#227'o Social Transportador'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Raz'#227'o Social do transportador'
          TypeValue = tvString
          ValueNegative = False
          Decimals = 0
          CharUpperLower = True
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 1
          MinLength = 0
          Group = 0
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'Tran_razaosocial'
          PanelMessages = PMens
        end
        object EdTran_cnpjcpf: TSQLEd
          Left = 4
          Top = 70
          Width = 95
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 14
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
          Title = 'CNPJ/CPF'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'C.N.P.J./C.P.F. do transportador'
          TypeValue = tvString
          ValueNegative = False
          Decimals = 0
          CharUpperLower = True
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 1
          MinLength = 0
          Group = 0
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'Tran_cnpjcpf'
          PanelMessages = PMens
        end
        object EdTran_inscricaoestadual: TSQLEd
          Left = 103
          Top = 70
          Width = 95
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 20
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
          Title = 'Inscr. Estadual'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Inscri'#231#227'o Estadual do transportador'
          TypeValue = tvString
          ValueNegative = False
          Decimals = 0
          CharUpperLower = True
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 1
          MinLength = 0
          Group = 0
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'Tran_inscricaoestadual'
          PanelMessages = PMens
        end
        object EdTran_inscricaomunicipal: TSQLEd
          Left = 201
          Top = 70
          Width = 88
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 20
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
          Title = 'Inscr. Municipal'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Inscri'#231#227'o Municipal do transportador'
          TypeValue = tvString
          ValueNegative = False
          Decimals = 0
          CharUpperLower = True
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 1
          MinLength = 0
          Group = 0
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'Tran_inscricaomunicipal'
          PanelMessages = PMens
        end
        object EdTran_regjuntacomercial: TSQLEd
          Left = 293
          Top = 70
          Width = 82
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 20
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
          Title = 'Reg. Junta Com.'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'N'#250'mero do registro do transportador na Junta Comercial'
          TypeValue = tvString
          ValueNegative = False
          Decimals = 0
          CharUpperLower = True
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 1
          MinLength = 0
          Group = 0
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'Tran_regjuntacomercial'
          PanelMessages = PMens
        end
        object EdTran_endereco: TSQLEd
          Left = 4
          Top = 110
          Width = 250
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 40
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
          Title = 'Endere'#231'o'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Endere'#231'o do transportador'
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
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'Tran_endereco'
          PanelMessages = PMens
        end
        object EdTran_bairro: TSQLEd
          Left = 397
          Top = 110
          Width = 187
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 40
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
          Title = 'Bairro'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Bairro do endere'#231'o do transportador'
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
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'Tran_bairro'
          PanelMessages = PMens
        end
        object EdTran_cep: TSQLEd
          Left = 5
          Top = 150
          Width = 64
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          EditMask = '##.###-###;0;_'
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
          Title = 'Cep'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'N'#250'mero do CEP do endere'#231'o do transportador'
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
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'Tran_cep'
          PanelMessages = PMens
        end
        object EdTran_cxpostal: TSQLEd
          Left = 72
          Top = 150
          Width = 64
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          EditMask = '##.###-###;0;_'
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
          Title = 'Caixa Postal'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'N'#250'mero da caixa postal do transportador'
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
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'Tran_cxpostal'
          PanelMessages = PMens
        end
        object EdTran_cida_codigo: TSQLEd
          Left = 139
          Top = 150
          Width = 60
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          MaxLength = 5
          TabOrder = 16
          Text = ''
          Visible = True
          Empty = False
          CloseForm = False
          CloseFormEsc = False
          ShowForm = 'FCidades'
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'C'#243'd. Cidade'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'C'#243'digo da cidade'
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
          FindTable = 'cidades'
          FindField = 'cida_codigo'
          FindSetField = 'cida_nome'
          FindSetEdt = SetEdcida_nome
          Group = 0
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'Tran_cida_codigo'
          PanelMessages = PMens
        end
        object EdTran_fone: TSQLEd
          Left = 399
          Top = 150
          Width = 88
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          EditMask = '(##) #####-####;0;_'
          MaxLength = 15
          TabOrder = 17
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Fone'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'N'#250'mero do telefone do transportador'
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
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'Tran_fone'
          PanelMessages = PMens
        end
        object EdTran_fax: TSQLEd
          Left = 499
          Top = 150
          Width = 83
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          EditMask = '(##) #####-####;0;_'
          MaxLength = 15
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
          Title = 'Fax'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'N'#250'mero do fax do transportador'
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
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'Tran_fax'
          PanelMessages = PMens
        end
        object EdTran_email: TSQLEd
          Left = 5
          Top = 190
          Width = 157
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecLowerCase
          MaxLength = 40
          TabOrder = 19
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'E-Mail'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'E-Mail do transportador'
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
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'Tran_email'
          PanelMessages = PMens
        end
        object EdTran_placa: TSQLEd
          Left = 347
          Top = 190
          Width = 56
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 10
          TabOrder = 21
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          OnValidate = EdTran_placaValidate
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Placa'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Placa do ve'#237'culo transportador ( XXX-9999 )'
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
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'Tran_placa'
          PanelMessages = PMens
        end
        object EdTran_ufplaca: TSQLEd
          Left = 531
          Top = 190
          Width = 50
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 2
          TabOrder = 24
          Text = ''
          Visible = True
          Empty = False
          CloseForm = False
          CloseFormEsc = False
          OnExitEdit = EdTran_ufplacaExitEdit
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'UF Placa'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'UF da placa do ve'#237'culo transportador'
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
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'Tran_ufplaca'
          PanelMessages = PMens
        end
        object EdTran_usua_codigo: TSQLEd
          Left = 507
          Top = 208
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
          TabOrder = 25
          Text = ''
          Visible = False
          Empty = True
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
          MessageStr = 'C'#243'digo do usu'#225'rio respons'#225'vel pelo cadastramento'
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
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'Tran_usua_codigo'
          PanelMessages = PMens
        end
        object SetEdcida_nome: TSQLEd
          Left = 202
          Top = 150
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
          TabOrder = 26
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
        object EdNomCtaGerencial: TSQLEd
          Left = 228
          Top = 190
          Width = 118
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
          TabOrder = 27
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
        object EdTran_contagerencial: TSQLEd
          Left = 167
          Top = 190
          Width = 55
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 20
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ShowForm = 'FPlano'
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Cta Gerencial'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Conta gerencial do transportador'
          TypeValue = tvInteger
          ValueNegative = False
          Decimals = 0
          ValueFormat = '######0'
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          FindTable = 'PLANO'
          FindField = 'PLAN_CONTA'
          FindSetField = 'PLAN_DESCRICAO'
          FindSetEdt = EdNomCtaGerencial
          Group = 0
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'tran_contagerencial'
          PanelMessages = PMens
        end
        object EdTran_proprio: TSQLEd
          Left = 257
          Top = 110
          Width = 28
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 1
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
          Title = 'Frota'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Se '#233' o ve'#237'culo pertence a frota da empresa'
          TypeValue = tvString
          ValueNegative = False
          Decimals = 0
          CharUpperLower = False
          Items.Strings = (
            'S - pertence a frota da empresa'
            'N - N'#227'o pertence a frota da empresa')
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 1
          Duplicity = 0
          MinLength = 0
          Group = 0
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'Tran_proprio'
          PanelMessages = PMens
        end
        object EdTran_cola_codigo: TSQLEd
          Left = 287
          Top = 110
          Width = 34
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 3
          TabOrder = 12
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ShowForm = 'FColaboradores'
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'C'#243'digo Colaborador'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'C'#243'digo do colaborador'
          TypeValue = tvString
          ValueNegative = False
          Decimals = 0
          ValueFormat = '0000'
          CharUpperLower = True
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          FindTable = 'COLABORADORES'
          FindField = 'COLA_CODIGO'
          FindSetField = 'COLA_DESCRICAO'
          FindSetEdt = SetEdCOLA_NOME
          Group = 0
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'tran_cola_codigo'
          PanelMessages = PMens
        end
        object SetEdCOLA_NOME: TSQLEd
          Left = 325
          Top = 111
          Width = 68
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
          TabOrder = 28
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Transportador'
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
        object edTran_tara: TSQLEd
          Left = 405
          Top = 190
          Width = 58
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 22
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Tara'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Tara do caminh'#227'o'
          TypeValue = tvFloat
          ValueNegative = False
          Decimals = 2
          ValueFormat = '###,##0.00'
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          Group = 7
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'tran_tara'
          PanelMessages = PMens
        end
        object Edtran_pesomaximo: TSQLEd
          Left = 467
          Top = 190
          Width = 62
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 23
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Peso M'#225'ximo'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Peso M'#225'ximo'
          TypeValue = tvFloat
          ValueNegative = False
          Decimals = 2
          ValueFormat = '###,##0.00'
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          Group = 7
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'tran_pesomaximo'
          PanelMessages = PMens
        end
        object EdTran_rntrc: TSQLEd
          Left = 379
          Top = 70
          Width = 61
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 8
          TabOrder = 7
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          OnValidate = EdTran_placaValidate
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'RNTRC'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Numero do registro na ANTT'
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
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'Tran_rntrc'
          PanelMessages = PMens
        end
        object EdTran_renavan: TSQLEd
          Left = 445
          Top = 70
          Width = 71
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 11
          TabOrder = 8
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          OnValidate = EdTran_placaValidate
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Renavam'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Numero do renavam do ve'#237'culo'
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
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'Tran_renavan'
          PanelMessages = PMens
        end
        object Edtran_volume: TSQLEd
          Left = 523
          Top = 70
          Width = 58
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 10
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
          Title = 'Volume(M3)'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Volume em metros c'#250'bicos'
          TypeValue = tvFloat
          ValueNegative = False
          Decimals = 2
          ValueFormat = '##0.00'
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          Group = 7
          Table = Arq.TTransp
          TableName = 'TRANSPORTADORES'
          TableField = 'tran_volume'
          PanelMessages = PMens
        end
      end
      object Grid: TSQLGrid
        Left = 1
        Top = 1
        Width = 592
        Height = 209
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
        FieldTransport = 'Tran_Codigo'
        OnNewRecord = GridNewRecord
        PanelInsert = PEdits
        PanelMessage = PMens
        PanelButtons = PBotoes
        Columns = <
          item
            Expanded = False
            FieldName = 'tran_codigo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tran_nome'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tran_razaosocial'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tran_cnpjcpf'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tran_inscricaoestadual'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tran_inscricaomunicipal'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tran_regjuntacomercial'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tran_endereco'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tran_bairro'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tran_cep'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tran_cxpostal'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tran_cida_codigo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tran_fone'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tran_fax'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tran_email'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tran_placa'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tran_ufplaca'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tran_proprio'
            Title.Caption = 'Frota'
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tran_tara'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tran_pesomaximo'
            Visible = True
          end>
      end
    end
  end
  object DSCadastro: TDataSource
    DataSet = Arq.TTransp
    Left = 208
    Top = 88
  end
end
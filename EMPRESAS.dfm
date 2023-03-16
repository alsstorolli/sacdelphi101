object FEmpresas: TFEmpresas
  Left = 13
  Top = 92
  BorderStyle = bsDialog
  Caption = 'Cadastro De Empresas'
  ClientHeight = 473
  ClientWidth = 782
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object PCadastro: TPanel
    Left = 0
    Top = 0
    Width = 782
    Height = 473
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    object PBotoes: TSQLPanelGrid
      Left = 681
      Top = 1
      Width = 100
      Height = 444
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
        Height = 442
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
    end
    object PMens: TSQLPanelGrid
      Left = 1
      Top = 445
      Width = 780
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
      Width = 680
      Height = 444
      Align = alClient
      BevelOuter = bvLowered
      Caption = 'Panel1'
      TabOrder = 2
      object PEdits: TSQLPanelGrid
        Left = 1
        Top = 181
        Width = 678
        Height = 262
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
        SQLGrid = Grid
        HeightLimite = 0
        WidthLimite = 0
        FixedVisible = False
        object EdEmpr_codigo: TSQLEd
          Left = 77
          Top = 5
          Width = 28
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          EditMask = '99;0; '
          MaxLength = 2
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
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 70
          MessageStr = 'C'#243'digo da empresa'
          TypeValue = tvString
          ValueNegative = False
          Decimals = 0
          ValueFormat = '00'
          CharUpperLower = True
          OpGrids = [ogFilter, ogFind]
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 2
          MinLength = 0
          ValueMin = '01'
          ValueMax = '99'
          Group = 0
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_codigo'
          PanelMessages = PMens
        end
        object EdEmpr_nome: TSQLEd
          Left = 77
          Top = 30
          Width = 250
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 40
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
          Title = 'Nome'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 70
          MessageStr = 'Nome da empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_nome'
          PanelMessages = PMens
        end
        object EdEmpr_reduzido: TSQLEd
          Left = 227
          Top = 5
          Width = 100
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 15
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
          Title = 'Reduzido'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 50
          MessageStr = 'Nome reduzido para a empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_reduzido'
          PanelMessages = PMens
        end
        object EdEmpr_razaosocial: TSQLEd
          Left = 77
          Top = 55
          Width = 250
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 50
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
          Title = 'Raz'#227'o Social'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 70
          MessageStr = 'Raz'#227'o Social da empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_razaosocial'
          PanelMessages = PMens
        end
        object EdEmpr_cnpj: TSQLEd
          Left = 77
          Top = 80
          Width = 108
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          EditMask = '99\.999\.999\/9999\-99;0;_'
          MaxLength = 18
          TabOrder = 4
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          OnValidate = EdEmpr_cnpjValidate
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'CNPJ'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 70
          MessageStr = 'CNPJ da empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_cnpj'
          PanelMessages = PMens
        end
        object EdEmpr_inscricaoestadual: TSQLEd
          Left = 217
          Top = 80
          Width = 110
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
          Title = 'I.E.'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 25
          MessageStr = 'Inscri'#231#227'o Estadual da empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_inscricaoestadual'
          PanelMessages = PMens
        end
        object EdEmpr_inscricaomunicipal: TSQLEd
          Left = 77
          Top = 105
          Width = 108
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
          Title = 'Inscr. Munic.'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 70
          MessageStr = 'Inscri'#231#227'o Municipal da empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_inscricaomunicipal'
          PanelMessages = PMens
        end
        object EdEmpr_regjuntacomercial: TSQLEd
          Left = 77
          Top = 130
          Width = 108
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 20
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
          Title = 'Junta Cial'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 70
          MessageStr = 'N'#250'mero do registro da empresa na Junta Comercial'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_regjuntacomercial'
          PanelMessages = PMens
        end
        object EdEmpr_atividade: TSQLEd
          Left = 77
          Top = 155
          Width = 170
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 40
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
          Title = 'Ramo Ativid.'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 70
          MessageStr = 'Ramo de atividade da empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_atividade'
          PanelMessages = PMens
        end
        object EdEmpr_identatividade: TSQLEd
          Left = 296
          Top = 155
          Width = 31
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 2
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
          Title = 'Ativ'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 20
          MessageStr = 'Identifica'#231#227'o do ramo de atividade da empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_identatividade'
          PanelMessages = PMens
        end
        object EdEmpr_responsavel: TSQLEd
          Left = 77
          Top = 180
          Width = 250
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 40
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
          Title = 'Respons'#225'vel'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 70
          MessageStr = 'Nome do respons'#225'vel pela empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_responsavel'
          PanelMessages = PMens
        end
        object EdEmpr_cargo: TSQLEd
          Left = 77
          Top = 205
          Width = 250
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 40
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
          Title = 'Cargo'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 70
          MessageStr = 'Cargo do respons'#225'vel pela empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_cargo'
          PanelMessages = PMens
        end
        object EdEmpr_contador: TSQLEd
          Left = 424
          Top = 5
          Width = 250
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 40
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
          Title = 'Contador'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 70
          MessageStr = 'Nome do contador da empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_contador'
          PanelMessages = PMens
        end
        object EdEmpr_endereco: TSQLEd
          Left = 424
          Top = 55
          Width = 250
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 40
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
          Title = 'Endereco'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 70
          MessageStr = 'Endereco da empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_endereco'
          PanelMessages = PMens
        end
        object EdEmpr_bairro: TSQLEd
          Left = 424
          Top = 80
          Width = 250
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 40
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
          Title = 'Bairro'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 70
          MessageStr = 'Bairro do endere'#231'o da empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_bairro'
          PanelMessages = PMens
        end
        object EdEmpr_cep: TSQLEd
          Left = 424
          Top = 130
          Width = 69
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          EditMask = '##.###-###;0;_'
          MaxLength = 10
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
          Title = 'CEP'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 70
          MessageStr = 'N'#250'mero do CEP do endere'#231'o da empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_cep'
          PanelMessages = PMens
        end
        object EdEmpr_cxpostal: TSQLEd
          Left = 612
          Top = 130
          Width = 62
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 10
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
          Title = 'Caixa Postal'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 60
          MessageStr = 'N'#250'mero da caixa postal da empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_cxpostal'
          PanelMessages = PMens
        end
        object EdEmpr_muni_codigo: TSQLEd
          Left = 424
          Top = 105
          Width = 50
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          MaxLength = 5
          TabOrder = 19
          Text = ''
          Visible = True
          Empty = False
          CloseForm = False
          CloseFormEsc = False
          ShowForm = 'FCidades'
          OnValidate = EdEmpr_muni_codigoValidate
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Cidade'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 70
          MessageStr = 'C'#243'digo da cidade'
          TypeValue = tvInteger
          ValueNegative = False
          Decimals = 0
          ValueFormat = '###,##0'
          CharUpperLower = False
          OpGrids = [ogFilter, ogFind]
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          FindTable = 'CIDADES'
          FindField = 'Cida_Codigo'
          FindSetField = 'CIDA_NOME'
          FindSetEdt = EdEmpr_municipio
          Group = 0
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_cida_codigo'
          PanelMessages = PMens
        end
        object EdEmpr_municipio: TSQLEd
          Left = 477
          Top = 105
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
          MaxLength = 40
          ParentFont = False
          TabOrder = 20
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Munic'#237'pio'
          TitlePos = tppInvisible
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 70
          MessageStr = 'Nome do munic'#237'pio da empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_municipio'
          PanelMessages = PMens
        end
        object EdEmpr_uf: TSQLEd
          Left = 644
          Top = 105
          Width = 30
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
          MaxLength = 2
          ParentFont = False
          TabOrder = 21
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'UF'
          TitlePos = tppInvisible
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 70
          MessageStr = 'UF do munic'#237'pio da empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_uf'
          PanelMessages = PMens
        end
        object EdEmpr_fone: TSQLEd
          Left = 424
          Top = 155
          Width = 79
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          EditMask = '(##) ####-####;0;_'
          MaxLength = 14
          TabOrder = 24
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
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 70
          MessageStr = 'N'#250'mero do telefone da empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_fone'
          PanelMessages = PMens
        end
        object EdEmpr_fax: TSQLEd
          Left = 596
          Top = 155
          Width = 78
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          EditMask = '(##) ####-####;0;_'
          MaxLength = 14
          TabOrder = 25
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
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 20
          MessageStr = 'N'#250'mero do fax da empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_fax'
          PanelMessages = PMens
        end
        object EdEmpr_email: TSQLEd
          Left = 424
          Top = 180
          Width = 250
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 40
          TabOrder = 26
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          OnExitEdit = EdEmpr_emailExitEdit
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'E-Mail'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 70
          MessageStr = 'E-Mail da empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_email'
          PanelMessages = PMens
        end
        object EdEmpr_dtdespachojunta: TSQLEd
          Left = 268
          Top = 130
          Width = 59
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          EditMask = '99/99/99;0;_'
          MaxLength = 8
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
          Title = 'Despacho'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 70
          MessageStr = 'Data de despacho na Junta Comercial'
          TypeValue = tvDate
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_dtdespachojunta'
          PanelMessages = PMens
        end
        object EdEmpr_cpfresponsavel: TSQLEd
          Left = 77
          Top = 230
          Width = 85
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          EditMask = '###.###.###-##;0;_'
          MaxLength = 14
          TabOrder = 13
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          OnValidate = EdEmpr_cnpjValidate
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'CPF Respons.'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 70
          MessageStr = 'CPF do respons'#225'vel pela empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_cpfresponsavel'
          PanelMessages = PMens
        end
        object EdEmpr_cpfcontador: TSQLEd
          Left = 424
          Top = 30
          Width = 85
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          EditMask = '###.###.###-##;0;_'
          MaxLength = 14
          TabOrder = 15
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          OnValidate = EdEmpr_cnpjValidate
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'CPF Contador'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 70
          MessageStr = 'CPF do contador da empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_cpfcontador'
          PanelMessages = PMens
        end
        object EdEmpr_crccontador: TSQLEd
          Left = 544
          Top = 30
          Width = 130
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 20
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
          Title = 'CRC'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 30
          MessageStr = 'CRC do contador da empresa'
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
          Table = Arq.TEmpresas
          TableName = 'EMPRESAS'
          TableField = 'Empr_crccontador'
          PanelMessages = PMens
        end
      end
      object Grid: TSQLGrid
        Left = 1
        Top = 1
        Width = 678
        Height = 180
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
        FieldTransport = 'Empr_Codigo'
        OnNewRecord = GridNewRecord
        PanelMessage = PMens
        PanelButtons = PBotoes
        Columns = <
          item
            Expanded = False
            FieldName = 'EMPR_CODIGO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_NOME'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_REDUZIDO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_RAZAOSOCIAL'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_CNPJ'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_INSCRICAOESTADUAL'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_INSCRICAOMUNICIPAL'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_REGJUNTACOMERCIAL'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_DTDESPACHOJUNTA'
            Title.Caption = 'Despacho'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_ATIVIDADE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_IDENTATIVIDADE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_RESPONSAVEL'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_CARGO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_CPFRESPONSAVEL'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_CONTADOR'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_CPFCONTADOR'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_CRCCONTADOR'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_ENDERECO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_BAIRRO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_CEP'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_CXPOSTAL'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_CIDA_CODIGO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_MUNICIPIO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_UF'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_FONE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_FAX'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPR_EMAIL'
            Visible = True
          end>
      end
    end
  end
  object DSCadastro: TDataSource
    DataSet = Arq.TEmpresas
    Left = 168
    Top = 80
  end
end

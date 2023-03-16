object FConsulta: TFConsulta
  Left = 250
  Top = 168
  BorderStyle = bsDialog
  Caption = 'FConsulta'
  ClientHeight = 453
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
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object PCadastro: TPanel
    Left = 0
    Top = 0
    Width = 862
    Height = 453
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    object PMens: TSQLPanelGrid
      Left = 1
      Top = 425
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
      TabOrder = 0
      SQLGrid = Grid
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 860
      Height = 424
      Align = alClient
      BevelOuter = bvLowered
      Caption = 'Panel1'
      TabOrder = 1
      object Grid: TSQLGrid
        Left = 0
        Top = 208
        Width = 758
        Height = 188
        Align = alCustom
        Color = clWhite
        DataSource = DsConsulta
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        OnKeyPress = GridKeyPress
        ColumnInitial = 0
        Reduce = 0
        PanelMessage = PMens
        PanelButtons = PBotoes
        Columns = <
          item
            Expanded = False
            Visible = True
          end
          item
            Expanded = False
            Visible = True
          end
          item
            Expanded = False
            Visible = True
          end
          item
            Expanded = False
            Visible = True
          end>
      end
      object PBotoes: TSQLPanelGrid
        Left = 759
        Top = 1
        Width = 100
        Height = 422
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
        TabOrder = 1
        SQLGrid = Grid
        HeightLimite = 0
        WidthLimite = 0
        FixedVisible = False
        object APHeadLabel1: TAPHeadLabel
          Left = 1
          Top = 1
          Width = 98
          Height = 420
          Align = alClient
          AutoBounds = False
          BoundLines = []
          Gradient.EndColor = clGray
          Gradient.StartColor = clSilver
          SubCaption.Ellipsis = False
          SubCaption.Style = []
          OnDblClick = APHeadLabel1DblClick
          ExplicitLeft = 3
          ExplicitTop = -3
        end
        object bPesquisar: TSQLBtn
          Left = 3
          Top = 1
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
          OnClick = bPesquisarClick
          Operation = fbFind
          Processing = False
          AutoAction = False
          GlyphSqlEnv = True
          IntervalRepeat = 0
          DownUp = False
        end
        object bExpColumn: TSQLBtn
          Left = 4
          Top = 472
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
          Top = 467
          Width = 92
          Height = 2
          Shape = bsTopLine
        end
        object bRedColumn: TSQLBtn
          Left = 27
          Top = 472
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
          Top = 472
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
          Top = 472
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
          Top = 494
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
          Top = 494
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
          Top = 494
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
          Top = 494
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
        object bdigitargrade: TSQLBtn
          Left = 11
          Top = 449
          Width = 27
          Height = 25
          Caption = '&Digitar Grade'
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
          Operation = fbNone
          Grid = Grid
          Processing = False
          AutoAction = False
          GlyphSqlEnv = True
          IntervalRepeat = 0
          DownUp = False
        end
        object bterminargrade: TSQLBtn
          Left = 60
          Top = 450
          Width = 27
          Height = 25
          Caption = '&Terminar Grade'
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
          Operation = fbNone
          Grid = Grid
          Processing = False
          AutoAction = False
          GlyphSqlEnv = True
          IntervalRepeat = 0
          DownUp = False
        end
        object bgeralitros: TSQLBtn
          Left = 3
          Top = 32
          Width = 95
          Height = 25
          Hint = 'Calcula quantidade de litros para cada dia'
          Caption = '&Calcula Litros'
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
          OnClick = bgeralitrosClick
          Operation = fbFind
          Processing = False
          AutoAction = False
          GlyphSqlEnv = True
          IntervalRepeat = 0
          DownUp = False
        end
        object bgeraromaneios: TSQLBtn
          Left = 3
          Top = 63
          Width = 95
          Height = 25
          Hint = 'Gera os romaneios para entrega'
          Caption = '&Gera Romaneios'
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
          OnClick = bgeraromaneiosClick
          Operation = fbFind
          Processing = False
          AutoAction = False
          GlyphSqlEnv = True
          IntervalRepeat = 0
          DownUp = False
        end
        object EdNroclientes: TSQLEd
          Left = 7
          Top = 224
          Width = 85
          Height = 28
          TabStop = False
          Alignment = taRightJustify
          Color = clGray
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Escolas'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -19
          TitleFont.Name = 'Tahoma'
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
          PanelMessages = PMens
        end
        object Edtotqtde: TSQLEd
          Left = 7
          Top = 277
          Width = 85
          Height = 28
          TabStop = False
          Alignment = taRightJustify
          Color = clGray
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
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
          Title = 'Litros'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -19
          TitleFont.Name = 'Tahoma'
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
          PanelMessages = PMens
        end
        object EdNumeroinicial: TSQLEd
          Left = 5
          Top = 335
          Width = 85
          Height = 28
          TabStop = False
          Alignment = taRightJustify
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
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
          Title = 'Rom.Inicial'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -19
          TitleFont.Name = 'Tahoma'
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
          PanelMessages = PMens
        end
        object EdClie_tran_codigo: TSQLEd
          Left = 7
          Top = 376
          Width = 39
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 3
          TabOrder = 3
          Text = ''
          Visible = True
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ShowForm = 'FTransp'
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Motorista/Transp.'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Codigo do motorista / transportador'
          TypeValue = tvString
          ValueNegative = False
          Decimals = 0
          ValueFormat = '000'
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          FindTable = 'transportadores'
          FindField = 'tran_codigo'
          FindSetField = 'tran_nome'
          FindSetEdt = SetEdtran_nome
          Group = 0
          Table = Arq.TClientes
          TableName = 'CLIENTES'
          PanelMessages = PMens
        end
        object SetEdtran_nome: TSQLEd
          Left = 7
          Top = 398
          Width = 74
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
          Title = 'Representante'
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
      end
      object Edcamponome: TSQLEd
        Left = 130
        Top = 402
        Width = 288
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
        TabOrder = 2
        Text = ''
        Visible = False
        OnKeyPress = EdcamponomeKeyPress
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        OnExitEdit = EdcamponomeExitEdit
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
        OpGrids = [ogFilter, ogFind]
        ItemsMultiples = False
        ItemsValid = True
        ItemsWidth = 0
        ItemsHeight = 0
        ItemsLength = 0
        Duplicity = 0
        MinLength = 0
        Group = 0
        Table = TConsulta
      end
      object DtGrid: TSqlDtGrid
        Left = 0
        Top = -1
        Width = 756
        Height = 186
        ColCount = 10
        DefaultRowHeight = 20
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
        TabOrder = 3
        OnDblClick = DtGridDblClick
        OnKeyPress = DtGridKeyPress
        Columns = <
          item
            WidthColumn = 64
          end
          item
            WidthColumn = 64
          end
          item
            WidthColumn = 64
          end
          item
            WidthColumn = 64
          end
          item
            WidthColumn = 64
          end
          item
            WidthColumn = 64
          end
          item
            WidthColumn = 64
          end
          item
            WidthColumn = 64
          end
          item
            WidthColumn = 64
          end
          item
            WidthColumn = 64
          end>
        RowCountMin = 0
        SelectedIndex = 0
        Version = '2.0'
        PermitePesquisa = True
      end
      object EdCampo1: TSQLEd
        Left = 492
        Top = 19
        Width = 58
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
        Visible = False
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        OnExitEdit = EdCampo1ExitEdit
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
        TypeValue = tvInteger
        ValueNegative = False
        Decimals = 0
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
      end
    end
  end
  object DsConsulta: TDataSource
    DataSet = TConsulta
    Left = 321
    Top = 33
  end
  object TConsulta: TSQLDs
    Aggregates = <>
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    TableFields = '*'
    CommandText = ''
    DBConnection = Ambiente.Conexao
    Left = 217
    Top = 33
  end
  object Od2: TOpenDialog
    Ctl3D = False
    DefaultExt = 'XLSX'
    Filter = 'Arquivos Excel|*.XLSX'
    Left = 787
    Top = 163
  end
end

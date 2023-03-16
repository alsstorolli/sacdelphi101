object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 439
  ClientWidth = 611
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object SQLPanelGrid2: TSQLPanelGrid
    Left = 512
    Top = 0
    Width = 99
    Height = 439
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
    ExplicitTop = -263
    ExplicitHeight = 563
    object APHeadLabel1: TAPHeadLabel
      Left = 1
      Top = 1
      Width = 97
      Height = 391
      Align = alClient
      AutoBounds = False
      BoundLines = []
      SubCaption.Ellipsis = False
      SubCaption.Style = []
      ExplicitHeight = 515
    end
    object bSair: TSQLBtn
      Left = 1
      Top = 111
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
      AutoAction = False
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object bgeranfe: TSQLBtn
      AlignWithMargins = True
      Left = 1
      Top = 28
      Width = 95
      Height = 27
      Hint = 'Gera'#231#227'o NFe'
      Caption = 'Gera'#231#227'o N&Fe'
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
      Operation = fbNone
      Processing = False
      AutoAction = True
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object bgravar: TSQLBtn
      AlignWithMargins = True
      Left = 1
      Top = 2
      Width = 95
      Height = 25
      Hint = 'grava a nota fiscal'
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
      OnClick = bgravarClick
      Operation = fbNone
      Processing = False
      AutoAction = False
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object bgeraboleto: TSQLBtn
      Left = 1
      Top = 82
      Width = 95
      Height = 27
      Hint = 'Gera boleto de cobran'#231'a'
      Caption = 'Bole&to'
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
      Operation = fbNone
      Processing = False
      AutoAction = True
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object bcupom: TSQLBtn
      Left = 1
      Top = 55
      Width = 95
      Height = 27
      Hint = 'Imprime NF-e / NFC-e'
      Caption = 'NFC-e / NF-e'
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
      Operation = fbNone
      Processing = False
      AutoAction = True
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object bbaixa: TSQLBtn
      Left = 1
      Top = 389
      Width = 95
      Height = 25
      Hint = 'baixa de pendencia financeira'
      Caption = 'Baixa Recebimentos'
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
      Operation = fbNone
      Processing = False
      AutoAction = False
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object bimpressao: TSQLBtn
      Left = 1
      Top = 440
      Width = 95
      Height = 25
      Hint = 'Impress'#227'o da nota'
      Caption = 'Impress'#227'o'
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
      Operation = fbNone
      Processing = False
      AutoAction = False
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object bvalidade: TSQLBtn
      Left = 1
      Top = 414
      Width = 95
      Height = 25
      Hint = 'lista produtos pr'#243'ximos da passar a validade'
      Caption = 'Validade'
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
      Operation = fbNone
      Processing = False
      AutoAction = False
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object bafaturar: TSQLBtn
      Left = 3
      Top = 471
      Width = 95
      Height = 25
      Hint = 'Impress'#227'o da nota'
      Caption = 'A Faturar'
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
      Operation = fbNone
      Processing = False
      AutoAction = False
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object Pbotoesgrid: TSQLPanelGrid
      Left = 1
      Top = 392
      Width = 97
      Height = 46
      Align = alBottom
      Color = clMoneyGreen
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
      ExplicitTop = 516
      object bLoadGrid: TSQLBtn
        Left = 49
        Top = 13
        Width = 23
        Height = 22
        Hint = 'Restaura o '#250'ltimo formato salvo para a grade'
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
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bSaveGrid: TSQLBtn
        Left = 72
        Top = 13
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
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bMoveLeft: TSQLBtn
        Left = 3
        Top = 13
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
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bMoveRight: TSQLBtn
        Left = 26
        Top = 13
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
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
    end
  end
  object SQLPanelGrid1: TSQLPanelGrid
    Left = 0
    Top = 0
    Width = 512
    Height = 439
    Align = alClient
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    HeightLimite = 0
    WidthLimite = 0
    FixedVisible = False
    ExplicitLeft = 88
    ExplicitTop = 104
    ExplicitWidth = 185
    ExplicitHeight = 41
  end
  object pop: TIdPOP3
    AutoLogin = True
    SASLMechanisms = <>
    Left = 96
    Top = 24
  end
end

object Form1: TForm1
  Left = 192
  Top = 113
  Width = 696
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object SQLPanelGrid1: TSQLPanelGrid
    Left = 0
    Top = 0
    Width = 688
    Height = 446
    Align = alClient
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    HeightLimite = 0
    WidthLimite = 0
    FixedVisible = False
    object SQLPanelGrid2: TSQLPanelGrid
      Left = 591
      Top = 1
      Width = 96
      Height = 417
      Align = alRight
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
      object APHeadLabel1: TAPHeadLabel
        Left = 1
        Top = 1
        Width = 94
        Height = 415
        Align = alClient
        AutoBounds = False
        BoundLines = []
        SubCaption.Ellipsis = False
        SubCaption.Style = []
      end
      object bIncluir: TSQLBtn
        Left = 1
        Top = 2
        Width = 95
        Height = 25
        Hint = 'Inclui o cheque'
        Caption = 'Incluir'
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
      object bSair: TSQLBtn
        Left = 1
        Top = 178
        Width = 95
        Height = 25
        Hint = 'Abandona a tela'
        Caption = 'Sair'
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
      object bAlterar: TSQLBtn
        Left = 1
        Top = 27
        Width = 95
        Height = 25
        Hint = 'Altera o cheque'
        Caption = 'Alterar'
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
      object bExcluir: TSQLBtn
        Left = 1
        Top = 52
        Width = 95
        Height = 25
        Hint = 'Exclui o cheque'
        Caption = 'Excluir'
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
      object bcancelar: TSQLBtn
        Left = 1
        Top = 77
        Width = 95
        Height = 25
        Hint = 'Cancela a opera'#231#227'o em andamento'
        Caption = 'Cancelar'
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
      object bbaixados: TSQLBtn
        Left = 1
        Top = 102
        Width = 95
        Height = 25
        Hint = 'Mostra somente cheques baixados'
        Caption = 'Baixados'
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
      object bemaberto: TSQLBtn
        Left = 1
        Top = 127
        Width = 95
        Height = 25
        Hint = 'Mostra somente cheques em aberto'
        Caption = 'Em Aberto'
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
      object bbaixa: TSQLBtn
        Left = 1
        Top = 153
        Width = 95
        Height = 25
        Hint = 'Baixa um cheque'
        Caption = 'Baixa'
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
      object EdJuros: TSQLEd
        Left = 9
        Top = 333
        Width = 62
        Height = 21
        TabStop = False
        Color = clGray
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Visible = False
        Alignment = taRightJustify
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Juros'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'Valor dos juros'
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
        Group = 0
        PanelMessages = PMens
      end
    end
    object PMens: TSQLPanelGrid
      Left = 1
      Top = 418
      Width = 686
      Height = 27
      Align = alBottom
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
    end
    object SQLPanelGrid3: TSQLPanelGrid
      Left = 1
      Top = 1
      Width = 590
      Height = 417
      Align = alClient
      Caption = 'SQLPanelGrid3'
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
      object SQLPanelGrid4: TSQLPanelGrid
        Left = 1
        Top = 1
        Width = 588
        Height = 415
        Align = alClient
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        HeightLimite = 0
        WidthLimite = 0
        FixedVisible = False
        object PInicial: TSQLPanelGrid
          Left = 1
          Top = 144
          Width = 586
          Height = 263
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          HeightLimite = 0
          WidthLimite = 0
          FixedVisible = False
        end
        object PGrid: TSQLPanelGrid
          Left = 3
          Top = 1
          Width = 675
          Height = 413
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          HeightLimite = 0
          WidthLimite = 0
          FixedVisible = False
          object Grid: TSqlDtGrid
            Left = 1
            Top = 1
            Width = 310
            Height = 255
            ColCount = 12
            DefaultRowHeight = 15
            FixedCols = 0
            RowCount = 2
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
            TabOrder = 0
            Columns = <
              item
                Title.Caption = 'Banco Emitente'
                WidthColumn = 64
                FieldName = 'cheq_bcoemitente'
              end
              item
                Title.Caption = 'Codigo'
                WidthColumn = 64
                FieldName = 'cheq_repr_codigo'
              end
              item
                Title.Caption = 'Representante'
                WidthColumn = 64
                FieldName = 'repr_nome'
              end
              item
                Title.Caption = 'Numero'
                WidthColumn = 64
                FieldName = 'cheq_cheque'
              end
              item
                Title.Caption = 'Emitente'
                WidthColumn = 64
                FieldName = 'cheq_emitente'
              end
              item
                Title.Caption = 'Emiss'#227'o'
                WidthColumn = 64
                FieldName = 'cheq_emissao'
              end
              item
                Title.Caption = 'Bom Para'
                WidthColumn = 64
                FieldName = 'cheq_predata'
              end
              item
                Alignment = taRightJustify
                Title.Alignment = taRightJustify
                Title.Caption = 'Valor'
                WidthColumn = 64
                FieldName = 'cheq_valor'
              end
              item
                Title.Caption = 'Dep'#243'sito'
                WidthColumn = 64
                FieldName = 'cheq_deposito'
              end
              item
                Title.Caption = 'Prorroga'#231#227'o'
                WidthColumn = 64
                FieldName = 'cheq_prorroga'
              end
              item
                Title.Caption = 'Observa'#231#227'o'
                WidthColumn = 64
                FieldName = 'cheq_obs'
              end
              item
                Title.Caption = 'Unidade'
                WidthColumn = 64
                FieldName = 'cheq_unid_codigo'
              end>
            RowCountMin = 0
            SelectedIndex = 0
            Version = '2.0'
            ColWidths = (
              88
              41
              121
              64
              108
              64
              55
              64
              51
              64
              161
              64)
          end
          object PEdits: TSQLPanelGrid
            Left = 1
            Top = 256
            Width = 673
            Height = 156
            Align = alBottom
            Color = clSilver
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Visible = False
            HeightLimite = 0
            WidthLimite = 0
            FixedVisible = False
            object EdCheq_cheque: TSQLEd
              Left = 300
              Top = 32
              Width = 84
              Height = 21
              TabStop = False
              MaxLength = 12
              TabOrder = 1
              Visible = True
              Alignment = taLeftJustify
              Empty = False
              CloseForm = False
              CloseFormEsc = False
              ColorFocus = clBlack
              ColorTextFocus = clWhite
              ColorNotEnabled = clGray
              ColorTextNotEnabled = clWhite
              Title = 'Cheque'
              TitlePos = tppTop
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              TitlePixels = 0
              MessageStr = 'N'#250'mero do cheque'
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
            object EdCheq_emissao: TSQLEd
              Left = 416
              Top = 32
              Width = 55
              Height = 21
              TabStop = False
              EditMask = '99/99/99;0;_'
              MaxLength = 8
              TabOrder = 2
              Visible = True
              Alignment = taLeftJustify
              Empty = False
              CloseForm = False
              CloseFormEsc = False
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
              MessageStr = 'Data de emiss'#227'o'
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
            object EdCheq_bcoemitente: TSQLEd
              Left = 513
              Top = 32
              Width = 121
              Height = 21
              TabStop = False
              CharCase = ecUpperCase
              MaxLength = 20
              TabOrder = 3
              Visible = True
              Alignment = taLeftJustify
              Empty = False
              CloseForm = False
              CloseFormEsc = False
              ColorFocus = clBlack
              ColorTextFocus = clWhite
              ColorNotEnabled = clGray
              ColorTextNotEnabled = clWhite
              Title = 'Banco emitente'
              TitlePos = tppTop
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              TitlePixels = 0
              MessageStr = 'Banco que emitiu o cheque'
              TypeValue = tvString
              ValueNegative = False
              Decimals = 0
              CharUpperLower = False
              Items.Strings = (
                'BRASIL'
                'BRADESCO'
                'BESC'
                'ITAU'
                'UNIBANCO')
              ItemsMultiples = False
              ItemsValid = False
              ItemsWidth = 0
              ItemsHeight = 0
              ItemsLength = 0
              Duplicity = 0
              MinLength = 0
              Group = 0
              PanelMessages = PMens
            end
            object Edcheq_emitente: TSQLEd
              Left = 18
              Top = 72
              Width = 265
              Height = 21
              TabStop = False
              MaxLength = 50
              TabOrder = 4
              Visible = True
              Alignment = taLeftJustify
              Empty = False
              CloseForm = False
              CloseFormEsc = False
              ColorFocus = clBlack
              ColorTextFocus = clWhite
              ColorNotEnabled = clGray
              ColorTextNotEnabled = clWhite
              Title = 'Emitente'
              TitlePos = tppTop
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              TitlePixels = 0
              MessageStr = 'Emitente do cheque'
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
              PanelMessages = PMens
            end
            object Edcheq_predata: TSQLEd
              Left = 300
              Top = 72
              Width = 54
              Height = 21
              TabStop = False
              EditMask = '99/99/99;0;_'
              MaxLength = 8
              TabOrder = 5
              Visible = True
              Alignment = taLeftJustify
              Empty = False
              CloseForm = False
              CloseFormEsc = False
              ColorFocus = clBlack
              ColorTextFocus = clWhite
              ColorNotEnabled = clGray
              ColorTextNotEnabled = clWhite
              Title = 'Bom Para'
              TitlePos = tppTop
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              TitlePixels = 0
              MessageStr = 'Data programada para dep'#243'sito'
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
            object Edcheq_valor: TSQLEd
              Left = 513
              Top = 72
              Width = 62
              Height = 21
              TabStop = False
              TabOrder = 7
              Visible = True
              Alignment = taRightJustify
              Empty = False
              CloseForm = False
              CloseFormEsc = False
              ColorFocus = clBlack
              ColorTextFocus = clWhite
              ColorNotEnabled = clGray
              ColorTextNotEnabled = clWhite
              Title = 'Valor'
              TitlePos = tppTop
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              TitlePixels = 0
              MessageStr = 'Valor do cheque'
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
              Group = 0
              PanelMessages = PMens
            end
            object Edcheq_obs: TSQLEd
              Left = 18
              Top = 112
              Width = 265
              Height = 21
              TabStop = False
              MaxLength = 60
              TabOrder = 8
              Visible = True
              Alignment = taLeftJustify
              Empty = True
              CloseForm = False
              CloseFormEsc = False
              ColorFocus = clBlack
              ColorTextFocus = clWhite
              ColorNotEnabled = clGray
              ColorTextNotEnabled = clWhite
              Title = 'Observa'#231#227'o'
              TitlePos = tppTop
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              TitlePixels = 0
              MessageStr = 'Observa'#231#227'o sobre o cheque ou emitente'
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
              PanelMessages = PMens
            end
            object Edcheq_prorroga: TSQLEd
              Left = 417
              Top = 112
              Width = 55
              Height = 21
              TabStop = False
              EditMask = '99/99/99;0;_'
              MaxLength = 8
              TabOrder = 10
              Visible = True
              Alignment = taLeftJustify
              Empty = True
              CloseForm = False
              CloseFormEsc = False
              ColorFocus = clBlack
              ColorTextFocus = clWhite
              ColorNotEnabled = clGray
              ColorTextNotEnabled = clWhite
              Title = 'Prorroga'#231#227'o'
              TitlePos = tppTop
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              TitlePixels = 0
              MessageStr = 'Data da prorroga'#231#227'o para dep'#243'sito do cheque'
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
            object Edcheq_repr_codigo: TSQLEd
              Left = 18
              Top = 32
              Width = 48
              Height = 21
              TabStop = False
              MaxLength = 4
              TabOrder = 0
              Visible = True
              Alignment = taRightJustify
              Empty = False
              CloseForm = False
              CloseFormEsc = False
              ShowForm = 'FRepresentantes'
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
              MessageStr = 'Codigo do representante'
              TypeValue = tvInteger
              ValueNegative = False
              Decimals = 0
              ValueFormat = '###0'
              CharUpperLower = False
              ItemsMultiples = False
              ItemsValid = True
              ItemsWidth = 0
              ItemsHeight = 0
              ItemsLength = 0
              Duplicity = 0
              MinLength = 0
              FindTable = 'representantes'
              FindField = 'repr_codigo'
              FindSetField = 'repr_nome'
              FindSetEdt = SetEdRepr_nome
              Group = 0
              PanelMessages = PMens
            end
            object Edcheq_deposito: TSQLEd
              Left = 515
              Top = 112
              Width = 56
              Height = 21
              TabStop = False
              EditMask = '99/99/99;0;_'
              MaxLength = 8
              TabOrder = 11
              Visible = True
              Alignment = taLeftJustify
              Empty = True
              CloseForm = False
              CloseFormEsc = False
              ColorFocus = clBlack
              ColorTextFocus = clWhite
              ColorNotEnabled = clGray
              ColorTextNotEnabled = clWhite
              Title = 'Dep'#243'sito'
              TitlePos = tppTop
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              TitlePixels = 0
              MessageStr = 'Data do efetivo dep'#243'sito em conta corrente'
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
            object SetEdRepr_nome: TSQLEd
              Left = 74
              Top = 32
              Width = 209
              Height = 21
              TabStop = False
              Color = clGray
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 12
              Visible = True
              Alignment = taLeftJustify
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
            object EdMovimento: TSQLEd
              Left = 416
              Top = 72
              Width = 55
              Height = 21
              TabStop = False
              EditMask = '99/99/99;0;_'
              MaxLength = 8
              TabOrder = 6
              Visible = True
              Alignment = taLeftJustify
              Empty = True
              CloseForm = False
              CloseFormEsc = False
              ColorFocus = clBlack
              ColorTextFocus = clWhite
              ColorNotEnabled = clGray
              ColorTextNotEnabled = clWhite
              Title = 'Movimento'
              TitlePos = tppTop
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              TitlePixels = 0
              MessageStr = 'Data de movimento'
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
            object EdCheq_unid_codigo: TSQLEd
              Left = 300
              Top = 112
              Width = 44
              Height = 21
              TabStop = False
              MaxLength = 3
              TabOrder = 9
              Visible = True
              Alignment = taLeftJustify
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
              MessageStr = 'Unidade que recebeu o cheque'
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
              FindTable = 'unidades'
              FindField = 'unid_codigo'
              FindSetField = 'unid_reduzido'
              Group = 0
              PanelMessages = PMens
            end
          end
          object XGrid: TSQLGrid
            Left = 323
            Top = 24
            Width = 320
            Height = 201
            Color = clWhite
            DataSource = DSCheques
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = [fsBold]
            ColumnInitial = 0
            Reduce = 0
            Columns = <
              item
                Expanded = False
                FieldName = 'cheq_emirec'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'cheq_bcoemitente'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'cheq_cheque'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'cheq_emitente'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'cheq_emissao'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'cheq_predata'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'cheq_valor'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'cheq_datacont'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'cheq_repr_codigo'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'cheq_repr_codigoant'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'cheq_unid_codigo'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'cheq_deposito'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'cheq_prorroga'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'cheq_lancto'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'cheq_obs'
                Visible = True
              end>
          end
        end
      end
    end
  end
  object DSCheques: TDataSource
    DataSet = Arq.TCheques
    Left = 541
    Top = 83
  end
end

object FDiversos: TFDiversos
  Left = 238
  Top = 161
  BorderStyle = bsDialog
  Caption = 'FDiversos'
  ClientHeight = 415
  ClientWidth = 759
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PBotoes: TSQLPanelGrid
    Left = 659
    Top = 0
    Width = 100
    Height = 388
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
      Height = 386
      Align = alClient
      AutoBounds = False
      BoundLines = []
      Gradient.EndColor = clGray
      Gradient.StartColor = clSilver
      SubCaption.Ellipsis = False
      SubCaption.Style = []
      ExplicitHeight = 284
    end
    object bSair: TSQLBtn
      Left = 2
      Top = 2
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
      AutoAction = False
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object bAltCtaContab: TSQLBtn
      Left = 2
      Top = 83
      Width = 95
      Height = 25
      Hint = 'Altera a conta cont'#225'bil para a unidade selecionada'
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
      Spacing = 2
      Visible = False
      OnClick = bAltCtaContabClick
      Operation = fbDefault
      Processing = False
      AutoAction = True
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object bGravarContab: TSQLBtn
      Left = 2
      Top = 107
      Width = 95
      Height = 25
      Hint = 'Grava as contas cont'#225'beis por unidade'
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
      Visible = False
      OnClick = bGravarContabClick
      Operation = fbDefault
      Processing = False
      AutoAction = True
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object bTodas: TSQLBtn
      Left = 2
      Top = 143
      Width = 95
      Height = 25
      Hint = 'Seleciona todas as unidades'
      Caption = '&Todas'
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
      OnClick = bTodasClick
      Operation = fbDefault
      Processing = False
      AutoAction = False
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object bConfirmar: TSQLBtn
      Left = 2
      Top = 27
      Width = 95
      Height = 25
      Hint = 'Confirma e abandona a tela'
      Caption = 'Con&firmar'
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
      OnClick = bConfirmarClick
      Operation = fbDefault
      Processing = False
      AutoAction = False
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object bTodos: TSQLBtn
      Left = 2
      Top = 173
      Width = 95
      Height = 25
      Hint = 'Seleciona todos'
      Caption = '&Todos'
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
      OnClick = bTodosClick
      Operation = fbDefault
      Processing = False
      AutoAction = False
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 659
    Height = 388
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 1
    object Page: TPageControl
      Left = 1
      Top = 1
      Width = 657
      Height = 386
      ActivePage = PgConfUnidade
      Align = alClient
      TabOrder = 0
      object PgContabUn: TTabSheet
        Caption = 'PgContabUn'
        TabVisible = False
        object GridContabUn: TSqlDtGrid
          Left = 0
          Top = 0
          Width = 649
          Height = 376
          Align = alClient
          ColCount = 3
          DefaultRowHeight = 20
          FixedCols = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goRowSelect]
          ScrollBars = ssNone
          TabOrder = 0
          Columns = <
            item
              Title.Caption = 'C'#243'digo'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              WidthColumn = 45
            end
            item
              Title.Caption = 'Unidade'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              WidthColumn = 180
            end
            item
              Alignment = taRightJustify
              Title.Alignment = taRightJustify
              Title.Caption = 'Conta Cont'#225'bil'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              WidthColumn = 90
            end>
          RowCountMin = 0
          SelectedIndex = 0
          Version = '2.0'
          PermitePesquisa = True
          ColWidths = (
            45
            180
            90)
          RowHeights = (
            20
            20
            20
            20
            20)
        end
        object EContaContab: TSQLEd
          Left = 230
          Top = 65
          Width = 90
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          ParentShowHint = False
          ShowHint = False
          TabOrder = 1
          Text = ''
          Visible = False
          OnExit = EContaContabExit
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ShowForm = 'FPlanoCon'
          OnExitEdit = EContaContabExitEdit
          OnValidate = EContaContabValidate
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
          MessageStr = 'Conta cont'#225'bil para a unidade selecionada'
          TypeValue = tvInteger
          ValueNegative = False
          Decimals = 0
          ValueFormat = '#######0'
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
      object PgGetOperacao: TTabSheet
        Caption = 'PgGetOperacao'
        ImageIndex = 1
        TabVisible = False
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 649
          Height = 376
          Align = alClient
          BevelOuter = bvLowered
          TabOrder = 0
          object EOperacao: TSQLEd
            Left = 128
            Top = 10
            Width = 100
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            MaxLength = 16
            TabOrder = 0
            Text = ''
            Visible = True
            Empty = True
            CloseForm = True
            CloseFormEsc = True
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'N'#250'mero Da Opera'#231#227'o'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 110
            MessageStr = 'Informe o n'#250'mero da opera'#231#227'o'
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
      end
      object PgConfUnidade: TTabSheet
        ImageIndex = 2
        TabVisible = False
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 649
          Height = 376
          Align = alClient
          BevelOuter = bvLowered
          TabOrder = 0
          object EUnidade: TSQLEd
            Left = 160
            Top = 10
            Width = 35
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            EditMask = '999;0; '
            MaxLength = 3
            TabOrder = 0
            Text = ''
            Visible = True
            Empty = False
            CloseForm = True
            CloseFormEsc = True
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'C'#243'digo Da Unidade'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 110
            MessageStr = 'C'#243'digo da unidade '#224' que pertence esta esta'#231#227'o de trabalho'
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
            Group = 0
            PanelMessages = PMens
          end
        end
      end
      object PgConfBancoDados: TTabSheet
        Caption = 'PgConfBancoDados'
        ImageIndex = 3
        TabVisible = False
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 649
          Height = 376
          Align = alClient
          BevelOuter = bvLowered
          TabOrder = 0
          object EServidor: TSQLEd
            Left = 162
            Top = 30
            Width = 181
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            TabOrder = 1
            Text = ''
            Visible = True
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            OnExitEdit = EServidorExitEdit
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Identifica'#231#227'o Do Servidor'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 150
            MessageStr = 'Identifica'#231#227'o do servidor'
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
          object EBancoDados: TSQLEd
            Left = 162
            Top = 5
            Width = 181
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
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
            Title = 'Identifica'#231#227'o Banco De Dados'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 150
            MessageStr = 'Identifica'#231#227'o do banco de dados utilizado'
            TypeValue = tvString
            ValueNegative = False
            Decimals = 0
            CharUpperLower = False
            Items.Strings = (
              'ORACLE'
              'SQLSERVER'
              'INTERBASE'
              'POSTGRESQL'
              'FIREBIRD')
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
          object EdNomeBanco: TSQLEd
            Left = 162
            Top = 56
            Width = 181
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            TabOrder = 2
            Text = ''
            Visible = True
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            OnExitEdit = EServidorExitEdit
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Identifica'#231#227'o Do Banco'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 150
            MessageStr = 'Identifica'#231#227'o do banco de dados'
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
      end
      object PgGetMesAno: TTabSheet
        Caption = 'PgGetMesAno'
        ImageIndex = 4
        TabVisible = False
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 649
          Height = 376
          Align = alClient
          BevelOuter = bvLowered
          TabOrder = 0
          object EMesAno: TSQLEd
            Left = 75
            Top = 6
            Width = 50
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            EditMask = '99\/9999;0;_'
            MaxLength = 7
            TabOrder = 0
            Text = ''
            Visible = True
            Empty = True
            CloseForm = True
            CloseFormEsc = True
            OnValidate = EMesAnoValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'M'#234's/Ano'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 50
            MessageStr = 'informe o m'#234's e o ano'
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
      end
      object PgGetUnidades: TTabSheet
        Caption = 'PgGetUnidades'
        ImageIndex = 5
        TabVisible = False
        object Panel6: TPanel
          Left = 0
          Top = 0
          Width = 649
          Height = 376
          Align = alClient
          BevelOuter = bvLowered
          Caption = 'Panel6'
          TabOrder = 0
          object CBUnidades: TCheckListBox
            Left = 1
            Top = 1
            Width = 647
            Height = 374
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ItemHeight = 13
            ParentFont = False
            TabOrder = 0
            OnKeyPress = CBUnidadesKeyPress
          end
        end
      end
      object PgGetOpTrans: TTabSheet
        Caption = 'PgGetOpTrans'
        ImageIndex = 6
        TabVisible = False
        object Panel7: TPanel
          Left = 0
          Top = 0
          Width = 649
          Height = 376
          Align = alClient
          BevelOuter = bvLowered
          TabOrder = 0
          object EOperacao2: TSQLEd
            Left = 128
            Top = 5
            Width = 100
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            MaxLength = 20
            TabOrder = 0
            Text = ''
            Visible = True
            Empty = True
            CloseForm = False
            CloseFormEsc = True
            OnValidate = EOperacao2Validate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'N'#250'mero Da Opera'#231#227'o'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 120
            MessageStr = 'Informe o n'#250'mero da opera'#231#227'o '
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
          object ETransacao2: TSQLEd
            Left = 128
            Top = 30
            Width = 100
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            MaxLength = 20
            TabOrder = 1
            Text = ''
            Visible = True
            OnKeyPress = ETransacao2KeyPress
            Empty = True
            CloseForm = True
            CloseFormEsc = True
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'N'#250'mero Da Transa'#231#227'o'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 120
            MessageStr = 'N'#250'mero da transa'#231#227'o ("Barra de Espa'#231'os" obt'#233'm '#250'ltima)'
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
      end
      object PgExportaMovel: TTabSheet
        Caption = 'PgExportaMovel'
        ImageIndex = 7
        TabVisible = False
        object Panel8: TPanel
          Left = 0
          Top = 0
          Width = 649
          Height = 376
          Align = alClient
          BevelOuter = bvLowered
          TabOrder = 0
          object btexportar: TSQLBtn
            Left = 130
            Top = 68
            Width = 69
            Height = 33
            Caption = '&Exporta'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            OnClick = btexportarClick
            Operation = fbNone
            Processing = False
            AutoAction = False
            GlyphSqlEnv = True
            IntervalRepeat = 0
            DownUp = False
          end
          object bimportar: TSQLBtn
            Left = 119
            Top = 128
            Width = 99
            Height = 33
            Caption = '&Importar'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            OnClick = bimportarClick
            Operation = fbNone
            Processing = False
            AutoAction = False
            GlyphSqlEnv = True
            IntervalRepeat = 0
            DownUp = False
          end
          object EBaixaParcial: TSQLEd
            Left = 130
            Top = 10
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
            ParentFont = False
            TabOrder = 0
            Text = ''
            Visible = False
            Empty = False
            CloseForm = True
            CloseFormEsc = True
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Valor Da Baixa Parcial'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 120
            MessageStr = 'Valor da baixa parcial da pend'#234'ncia'
            TypeValue = tvFloat
            ValueNegative = False
            Decimals = 2
            ValueFormat = '###,###,##0.00'
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
          object EdFiltro: TSQLEd
            Left = 130
            Top = 41
            Width = 163
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            MaxLength = 100
            TabOrder = 1
            Text = ''
            Visible = True
            Empty = True
            CloseForm = True
            CloseFormEsc = True
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Filtro a aplicar'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 120
            MessageStr = 'filtro para o cadastro a ser exportado'
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
          object EdData: TSQLEd
            Left = 24
            Top = 104
            Width = 68
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            EditMask = '99/99/9999;0;_'
            MaxLength = 10
            TabOrder = 2
            Text = ''
            Visible = True
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Data Venda'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            TypeValue = tvDateLng
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
          object EdCodcliente: TSQLEd
            Left = 142
            Top = 104
            Width = 85
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            TabOrder = 3
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
            FindTable = 'clientes'
            FindField = 'clie_codigo'
            FindSetField = 'clie_nome'
            Group = 0
          end
          object cblocal: TCheckBox
            Left = 64
            Top = 140
            Width = 49
            Height = 17
            Caption = 'Local'
            TabOrder = 4
            Visible = False
          end
          object EdTablet: TSQLEd
            Left = 98
            Top = 104
            Width = 38
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            MaxLength = 1
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
            Title = 'Tablet'
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
            MinLength = 1
            Group = 0
          end
          object Texto: TMemo
            Left = 11
            Top = 167
            Width = 294
            Height = 181
            ScrollBars = ssBoth
            TabOrder = 6
          end
        end
      end
      object PgGerRel: TTabSheet
        Caption = 'PgGerRel'
        ImageIndex = 8
        TabVisible = False
        object Panel9: TPanel
          Left = 0
          Top = 0
          Width = 649
          Height = 376
          Align = alClient
          BevelOuter = bvLowered
          Caption = 'Panel9'
          TabOrder = 0
          object LBRelatorios: TListBox
            Left = 1
            Top = 1
            Width = 647
            Height = 374
            Align = alClient
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ItemHeight = 13
            ParentFont = False
            TabOrder = 0
            OnKeyPress = LBRelatoriosKeyPress
          end
        end
      end
      object PgVincPendFin: TTabSheet
        Caption = 'PgVincPendFin'
        ImageIndex = 9
        TabVisible = False
        object GridVinc: TSqlDtGrid
          Left = 0
          Top = 0
          Width = 649
          Height = 376
          Align = alClient
          ColCount = 7
          DefaultRowHeight = 20
          FixedCols = 0
          RowCount = 50
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goRowSelect]
          TabOrder = 0
          OnKeyPress = GridVincKeyPress
          Columns = <
            item
              Alignment = taCenter
              Title.Caption = 'Vincular'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              WidthColumn = 50
              FieldName = '(Vincular)'
            end
            item
              Title.Caption = 'Opera'#231#227'o'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              WidthColumn = 90
              FieldName = 'Pfin_Operacao'
            end
            item
              Title.Caption = 'Conta'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              WidthColumn = 50
              FieldName = 'Pfin_Pger_Conta'
            end
            item
              Title.Caption = 'Descri'#231#227'o Conta'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              WidthColumn = 250
              FieldName = '(DescricaoConta)'
            end
            item
              Alignment = taCenter
              Format = cfDate
              Title.Alignment = taCenter
              Title.Caption = 'Vcto'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              WidthColumn = 55
              FieldName = 'Pfin_DataVcto'
            end
            item
              Alignment = taCenter
              Format = cfDate
              Title.Alignment = taCenter
              Title.Caption = 'Emiss'#227'o'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              WidthColumn = 55
              FieldName = 'Pfin_DataEmissao'
            end
            item
              EditMask = '###,###,##0.00'
              Alignment = taRightJustify
              Format = cfNumber
              Title.Alignment = taRightJustify
              Title.Caption = 'Valor'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              WidthColumn = 80
              FieldName = 'Pfin_Valor'
            end>
          RowCountMin = 0
          SelectedIndex = 0
          Version = '2.0'
          PermitePesquisa = True
          ColWidths = (
            50
            90
            50
            250
            55
            55
            80)
          RowHeights = (
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20)
        end
      end
      object PgEscolha: TTabSheet
        Caption = 'PgEscolha'
        ImageIndex = 10
        TabVisible = False
        object Panel10: TPanel
          Left = 0
          Top = 0
          Width = 649
          Height = 376
          Align = alClient
          BevelOuter = bvLowered
          Caption = 'Panel10'
          TabOrder = 0
          object LBEscolha: TListBox
            Left = 1
            Top = 1
            Width = 647
            Height = 374
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ItemHeight = 13
            ParentFont = False
            TabOrder = 0
            OnKeyPress = LBEscolhaKeyPress
          end
        end
      end
      object PgContabCC: TTabSheet
        Caption = 'PgContabCC'
        ImageIndex = 11
        TabVisible = False
        object GridContabCC: TSqlDtGrid
          Left = 0
          Top = 0
          Width = 649
          Height = 376
          Align = alClient
          ColCount = 3
          DefaultRowHeight = 20
          FixedCols = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goRowSelect]
          ScrollBars = ssNone
          TabOrder = 1
          Columns = <
            item
              Title.Caption = 'C'#243'digo'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              WidthColumn = 70
            end
            item
              Title.Caption = 'Centro De Custos'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              WidthColumn = 300
            end
            item
              Alignment = taRightJustify
              Title.Alignment = taRightJustify
              Title.Caption = 'Conta Cont'#225'bil'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              WidthColumn = 90
            end>
          RowCountMin = 0
          SelectedIndex = 0
          Version = '2.0'
          PermitePesquisa = True
          ColWidths = (
            70
            300
            90)
          RowHeights = (
            20
            20
            20
            20
            20)
        end
        object EContaContabCC: TSQLEd
          Left = 374
          Top = 64
          Width = 90
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          ParentShowHint = False
          ShowHint = False
          TabOrder = 0
          Text = ''
          Visible = False
          OnExit = EContaContabCCExit
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          ShowForm = 'FPlanoCon'
          OnExitEdit = EContaContabCCExitEdit
          OnValidate = EContaContabCCValidate
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
          MessageStr = 'Conta cont'#225'bil para a unidade selecionada'
          TypeValue = tvInteger
          ValueNegative = False
          Decimals = 0
          ValueFormat = '#######0'
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
      object PgGetContaGerencial: TTabSheet
        Caption = 'PgGetContaGerencial'
        ImageIndex = 12
        TabVisible = False
        object Panel11: TPanel
          Left = 0
          Top = 0
          Width = 649
          Height = 376
          Align = alClient
          BevelOuter = bvLowered
          TabOrder = 0
          object EdContaGerencial: TSQLEd
            Left = 112
            Top = 10
            Width = 80
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            TabOrder = 0
            Text = ''
            Visible = True
            Empty = True
            CloseForm = True
            CloseFormEsc = True
            ShowForm = 'FPlanoGer'
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Conta Gerencial'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 100
            MessageStr = 'Informe o c'#243'digo da conta gerencial'
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
      end
      object PgGetDataAutPgto: TTabSheet
        Caption = 'PgGetDataAutPgto'
        ImageIndex = 13
        TabVisible = False
        object Panel12: TPanel
          Left = 0
          Top = 0
          Width = 649
          Height = 376
          Align = alClient
          BevelOuter = bvLowered
          Color = 12615680
          TabOrder = 0
          object EDataAutPgto: TSQLEd
            Left = 149
            Top = 8
            Width = 63
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            EditMask = '99/99/99;0;_'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            MaxLength = 8
            ParentFont = False
            TabOrder = 0
            Text = ''
            Visible = True
            Empty = True
            CloseForm = True
            CloseFormEsc = True
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Data Autoriza'#231#227'o Pgto'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = [fsBold]
            TitlePixels = 135
            MessageStr = 'Data para pagamento da(s) pend'#234'ncia(s)'
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
        end
      end
      object PgGetTransacao: TTabSheet
        Caption = 'PgGetTransacao'
        ImageIndex = 14
        TabVisible = False
        object Panel13: TPanel
          Left = 0
          Top = 0
          Width = 649
          Height = 376
          Align = alClient
          BevelOuter = bvLowered
          TabOrder = 0
          object ETransacao: TSQLEd
            Left = 128
            Top = 10
            Width = 100
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            MaxLength = 16
            TabOrder = 0
            Text = ''
            Visible = True
            Empty = True
            CloseForm = True
            CloseFormEsc = True
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'N'#250'mero Da Transa'#231#227'o'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 110
            MessageStr = 'Informe o n'#250'mero da transa'#231#227'o'
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
      end
      object PgAltDataTrans: TTabSheet
        Caption = 'PgAltDataTrans'
        ImageIndex = 15
        TabVisible = False
        object Panel14: TPanel
          Left = 0
          Top = 0
          Width = 649
          Height = 376
          Align = alClient
          BevelOuter = bvLowered
          TabOrder = 0
          object ETransacao3: TSQLEd
            Left = 117
            Top = 5
            Width = 100
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            MaxLength = 16
            TabOrder = 0
            Text = ''
            Visible = True
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            OnValidate = ETransacao3Validate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'N'#250'mero Da Transa'#231#227'o'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 110
            MessageStr = 'Informe o n'#250'mero da transa'#231#227'o para altera'#231#227'o de datas'
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
          object EDataMvto: TSQLEd
            Left = 117
            Top = 30
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
            OnExitEdit = EDataMvtoExitEdit
            OnValidate = EDataMvtoValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Data Movimento'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 110
            MessageStr = 'Data de movimento da transa'#231#227'o'
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
          object EDataContabil: TSQLEd
            Left = 117
            Top = 55
            Width = 55
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            EditMask = '99/99/99;0;_'
            MaxLength = 8
            TabOrder = 2
            Text = ''
            Visible = True
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            OnExitEdit = EDataMvtoExitEdit
            OnValidate = EDataContabilValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Data Cont'#225'bil'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 110
            MessageStr = 'Data cont'#225'bil da transa'#231#227'o'
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
          object EDataEscritaFiscal: TSQLEd
            Left = 117
            Top = 80
            Width = 55
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            EditMask = '99/99/99;0;_'
            MaxLength = 8
            TabOrder = 3
            Text = ''
            Visible = True
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            OnExitEdit = EDataMvtoExitEdit
            OnValidate = EDataEscritaFiscalValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Data Escrita Fiscal'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 110
            MessageStr = 'Data da escrita fiscal'
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
        end
      end
      object PgUsuAtivos: TTabSheet
        Caption = 'PgUsuAtivos'
        ImageIndex = 16
        TabVisible = False
        object GridUsuAtivos: TSqlDtGrid
          Left = 0
          Top = 0
          Width = 649
          Height = 376
          Align = alClient
          Color = 15794173
          ColCount = 3
          DefaultRowHeight = 20
          FixedCols = 0
          Options = [goFixedVertLine, goFixedHorzLine, goDrawFocusSelected, goColSizing, goRowSelect]
          TabOrder = 0
          Columns = <
            item
              Alignment = taRightJustify
              Title.Alignment = taRightJustify
              Title.Caption = 'C'#243'digo'
              WidthColumn = 55
            end
            item
              Title.Caption = 'Nome Do Usu'#225'rio'
              WidthColumn = 300
            end
            item
              Alignment = taCenter
              Title.Caption = 'Unidade'
              WidthColumn = 45
            end>
          RowCountMin = 0
          SelectedIndex = 0
          Version = '2.0'
          PermitePesquisa = True
          ColWidths = (
            55
            300
            45)
          RowHeights = (
            20
            20
            20
            20
            20)
        end
      end
      object PgGetCodigoLog: TTabSheet
        Caption = 'PgGetCodigoLog'
        ImageIndex = 17
        TabVisible = False
        object LBLogs: TCheckListBox
          Left = 0
          Top = 0
          Width = 649
          Height = 376
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
        end
      end
      object PgCancDctoBco: TTabSheet
        Caption = 'PgCancDctoBco'
        ImageIndex = 18
        TabVisible = False
        object Panel15: TPanel
          Left = 0
          Top = 0
          Width = 649
          Height = 376
          Align = alClient
          BevelOuter = bvLowered
          Caption = 'Panel15'
          TabOrder = 0
          object ENumeroOperacao: TSQLEd
            Left = 96
            Top = 5
            Width = 120
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            TabOrder = 0
            Text = ''
            Visible = True
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            OnValidate = ENumeroOperacaoValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'N'#250'mero Opera'#231#227'o'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 90
            MessageStr = 'N'#250'mero da opera'#231#227'o do documento banc'#225'rio a cancelar'
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
            Group = 258
            PanelMessages = PMens
          end
          object ECodDcto: TSQLEd
            Left = 96
            Top = 30
            Width = 37
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
            Title = 'Tipo Documento'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 90
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
            Group = 258
            PanelMessages = PMens
          end
          object EDescDctoBco: TSQLEd
            Left = 138
            Top = 30
            Width = 233
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
            Group = 258
          end
          object EDataMvto3: TSQLEd
            Left = 96
            Top = 55
            Width = 55
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            Color = clGray
            Enabled = False
            EditMask = '99/99/99;0;_'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 8
            ParentFont = False
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
            Title = 'Data Movimento'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 90
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
            Group = 258
            PanelMessages = PMens
          end
          object EValor3: TSQLEd
            Left = 291
            Top = 55
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
            Title = 'Valor'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 30
            TypeValue = tvFloat
            ValueNegative = False
            Decimals = 2
            ValueFormat = '###,###,##0.00'
            CharUpperLower = False
            ItemsMultiples = False
            ItemsValid = True
            ItemsWidth = 0
            ItemsHeight = 0
            ItemsLength = 0
            Duplicity = 0
            MinLength = 0
            Group = 258
            PanelMessages = PMens
          end
        end
      end
      object PgCtOper: TTabSheet
        ImageIndex = 19
        TabVisible = False
        object GridCtOper: TSqlDtGrid
          Left = 0
          Top = 0
          Width = 649
          Height = 376
          Align = alClient
          DefaultRowHeight = 20
          FixedCols = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
          TabOrder = 0
          OnKeyPress = GridCtOperKeyPress
          Columns = <
            item
              Title.Caption = 'C'#243'd'
              WidthColumn = 30
            end
            item
              Title.Caption = 'Departamento'
              WidthColumn = 200
            end
            item
              WidthColumn = 70
            end
            item
              WidthColumn = 70
            end
            item
              WidthColumn = 70
            end>
          RowCountMin = 0
          SelectedIndex = 2
          Version = '2.0'
          PermitePesquisa = True
          ColWidths = (
            30
            200
            70
            70
            70)
          RowHeights = (
            20
            20
            20
            20
            20)
        end
        object ECtOper: TSQLEd
          Left = 232
          Top = 112
          Width = 64
          Height = 18
          TabStop = False
          Alignment = taRightJustify
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          TabOrder = 1
          Text = ''
          Visible = False
          OnExit = ECtOperExit
          OnKeyPress = ECtOperKeyPress
          Empty = True
          CloseForm = False
          CloseFormEsc = False
          OnExitEdit = ECtOperExitEdit
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
          TypeValue = tvFloat
          ValueNegative = False
          Decimals = 3
          ValueFormat = '##0.000%'
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
      object PgGetEscopo: TTabSheet
        Caption = 'PgGetEscopo'
        ImageIndex = 20
        TabVisible = False
        object Panel16: TPanel
          Left = 0
          Top = 0
          Width = 649
          Height = 376
          Align = alClient
          BevelOuter = bvLowered
          TabOrder = 0
          object ECodDpto: TSQLEd
            Left = 75
            Top = 5
            Width = 35
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            EditMask = '999;0; '
            MaxLength = 3
            TabOrder = 0
            Text = ''
            Visible = True
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            ShowForm = 'FDptos'
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Departamento'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 70
            MessageStr = 'C'#243'digo do departamento a considerar'
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
            FindTable = 'Departamentos'
            FindField = 'Dpto_Codigo'
            FindSetField = 'Dpto_Descricao'
            FindSetEdt = EDescrDpto
            Group = 125
            PanelMessages = PMens
          end
          object EDescrDpto: TSQLEd
            Left = 113
            Top = 5
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
            Group = 125
          end
          object EGrupo: TSQLEd
            Left = 75
            Top = 30
            Width = 202
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
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
            Title = 'Grupo'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 70
            MessageStr = 'Grupo a considerar'
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
            Group = 125
            PanelMessages = PMens
          end
          object EMarca: TSQLEd
            Left = 75
            Top = 55
            Width = 202
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
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
            Title = 'Marca'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 70
            MessageStr = 'Marca a considerar'
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
            Group = 125
            PanelMessages = PMens
          end
          object ESetor: TSQLEd
            Left = 75
            Top = 80
            Width = 50
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 5
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
            Title = 'Setor'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 70
            MessageStr = 'Setor a considerar'
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
            Group = 125
            PanelMessages = PMens
          end
          object ESetorDep: TSQLEd
            Left = 227
            Top = 80
            Width = 50
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
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
            Title = 'Setor Dep.'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 55
            MessageStr = 'Setor do dep'#243'sito a considerar'
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
            Group = 125
            PanelMessages = PMens
          end
          object EClasse: TSQLEd
            Left = 75
            Top = 105
            Width = 70
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 10
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
            Title = 'Classe'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 70
            MessageStr = 'Classe do produtos a considerar'
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
            Group = 125
            PanelMessages = PMens
          end
          object ETipo: TSQLEd
            Left = 227
            Top = 105
            Width = 50
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 5
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
            Title = 'Tipo'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 28
            MessageStr = 'Tipo dos produtos a considerar'
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
            Group = 125
            PanelMessages = PMens
          end
          object EFornec: TSQLEd
            Left = 75
            Top = 130
            Width = 70
            Height = 21
            TabStop = False
            Alignment = taRightJustify
            TabOrder = 8
            Text = ''
            Visible = True
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            ShowForm = 'FFornec'
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Fornecedor'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 70
            MessageStr = 'C'#243'digo do fornecedor dos produtos a considerar'
            TypeValue = tvInteger
            ValueNegative = False
            Decimals = 0
            ValueFormat = '#######0'
            CharUpperLower = False
            ItemsMultiples = False
            ItemsValid = True
            ItemsWidth = 0
            ItemsHeight = 0
            ItemsLength = 0
            Duplicity = 0
            MinLength = 0
            FindField = 'Forn_codigo'
            Group = 125
            PanelMessages = PMens
          end
          object EAtivos: TSQLEd
            Left = 256
            Top = 130
            Width = 20
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 1
            TabOrder = 9
            Text = ''
            Visible = True
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            OnExitEdit = EAtivosExitEdit
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Ativos'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 35
            MessageStr = 'Considerar somente itens ativos/inativos/geral'
            ValueDefault = 'A'
            TypeValue = tvString
            ValueNegative = False
            Decimals = 0
            CharUpperLower = False
            Items.Strings = (
              'A - Ativos'
              'I - Inativos'
              'G - Geral')
            ItemsMultiples = False
            ItemsValid = True
            ItemsWidth = 0
            ItemsHeight = 0
            ItemsLength = 1
            Duplicity = 0
            MinLength = 0
            Group = 125
            PanelMessages = PMens
          end
        end
      end
      object PgHistorico: TTabSheet
        ImageIndex = 21
        TabVisible = False
        object EContaHist: TSQLEd
          Left = 55
          Top = 5
          Width = 70
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          TabOrder = 0
          Text = ''
          Visible = True
          Empty = False
          CloseForm = False
          CloseFormEsc = False
          ShowForm = 'FPlanoGer'
          OnValidate = EContaHistValidate
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Conta'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 50
          MessageStr = 'Conta cont'#225'bil que sofrer'#225' altera'#231#227'o dos hist'#243'ricos'
          TypeValue = tvInteger
          ValueNegative = False
          Decimals = 0
          ValueFormat = '########0'
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          FindTable = 'PlanoGer'
          FindField = 'Pger_Conta'
          Group = 0
          PanelMessages = PMens
        end
        object EDescrCtaHist: TSQLEd
          Left = 128
          Top = 5
          Width = 329
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
          Group = 0
        end
        object ECodHist: TSQLEd
          Left = 55
          Top = 30
          Width = 45
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          EditMask = '9999;0; '
          MaxLength = 4
          TabOrder = 2
          Text = ''
          Visible = True
          Empty = False
          CloseForm = False
          CloseFormEsc = False
          ShowForm = 'FHistoricos'
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Hist'#243'rico'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 50
          MessageStr = 'C'#243'digo do hist'#243'rico para altera'#231#227'o'
          TypeValue = tvString
          ValueNegative = False
          Decimals = 0
          ValueFormat = '0000'
          CharUpperLower = False
          ItemsMultiples = False
          ItemsValid = True
          ItemsWidth = 0
          ItemsHeight = 0
          ItemsLength = 0
          Duplicity = 0
          MinLength = 0
          FindTable = 'Historicos'
          FindField = 'Hist_Codigo'
          Group = 0
          PanelMessages = PMens
        end
        object EComplemento: TSQLEd
          Left = 128
          Top = 30
          Width = 329
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          TabOrder = 3
          Text = ''
          Visible = True
          OnEnter = EComplementoEnter
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
          MessageStr = 'Complemento do hist'#243'rico'
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
        object EDataIHist: TSQLEd
          Left = 55
          Top = 55
          Width = 55
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          EditMask = '99/99/99;0;_'
          MaxLength = 8
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
          Title = 'Per'#237'odo'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 50
          MessageStr = 'Data inicial do per'#237'odo a considerar'
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
        object EDataFHist: TSQLEd
          Left = 128
          Top = 55
          Width = 55
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          EditMask = '99/99/99;0;_'
          MaxLength = 8
          TabOrder = 5
          Text = ''
          Visible = True
          Empty = False
          CloseForm = False
          CloseFormEsc = False
          OnExitEdit = EDataFHistExitEdit
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'a '
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 12
          MessageStr = 'Data final do per'#237'odo a considerar'
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
      end
      object PgBaixaPendEst: TTabSheet
        Caption = 'PgBaixaPendEst'
        ImageIndex = 22
        TabVisible = False
        object GridBxPendEst: TSqlDtGrid
          Left = 0
          Top = 0
          Width = 649
          Height = 376
          Align = alClient
          ColCount = 11
          DefaultRowHeight = 20
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
          ScrollBars = ssNone
          TabOrder = 0
          OnKeyPress = GridBxPendEstKeyPress
          Columns = <
            item
              Title.Caption = 'Baixar'
              WidthColumn = 45
            end
            item
              Alignment = taRightJustify
              Title.Alignment = taRightJustify
              Title.Caption = 'C'#243'digo'
              WidthColumn = 60
            end
            item
              Title.Caption = 'Descri'#231#227'o'
              WidthColumn = 305
            end
            item
              Alignment = taRightJustify
              Title.Alignment = taRightJustify
              Title.Caption = 'Q.Emb'
              WidthColumn = 50
            end
            item
              Alignment = taRightJustify
              Title.Alignment = taRightJustify
              Title.Caption = 'Quantidade'
              WidthColumn = 70
            end
            item
              Title.Caption = 'Cod. Barras'
              WidthColumn = 110
            end
            item
              Title.Caption = 'Operacao'
              WidthColumn = 0
            end
            item
              Title.Caption = 'Seq'
              WidthColumn = 0
            end
            item
              Title.Caption = 'CodTrib'
              WidthColumn = 0
            end
            item
              Title.Caption = 'Peso'
              WidthColumn = 0
            end
            item
              Title.Caption = 'Valor'
              WidthColumn = 0
            end>
          RowCountMin = 0
          SelectedIndex = 1
          Version = '2.0'
          PermitePesquisa = True
          ColWidths = (
            45
            60
            305
            50
            70
            110
            0
            0
            0
            0
            0)
          RowHeights = (
            20
            20
            20
            20
            20)
        end
      end
      object PgImportaEstoque: TTabSheet
        Caption = 'Importa Estoque'
        ImageIndex = 23
        TabVisible = False
        object bqualdbf: TSQLBtn
          Left = 287
          Top = 24
          Width = 90
          Height = 22
          Caption = 'Procura Arquivo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          OnClick = bqualdbfClick
          Operation = fbNone
          Processing = False
          AutoAction = True
          GlyphSqlEnv = True
          IntervalRepeat = 0
          DownUp = False
        end
        object bqualtexto: TSQLBtn
          Left = 343
          Top = 112
          Width = 90
          Height = 22
          Caption = 'Procura Arquivo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          OnClick = bqualtextoClick
          Operation = fbNone
          Processing = False
          AutoAction = True
          GlyphSqlEnv = True
          IntervalRepeat = 0
          DownUp = False
        end
        object EdArquivodbf: TSQLEd
          Left = 161
          Top = 24
          Width = 121
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 100
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
          Title = 'Arquivo a ser importado'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 150
          MessageStr = 'Arquivo DBF a ser acrescentado ao estoque'
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
        object EdArquivotexto: TSQLEd
          Left = 217
          Top = 112
          Width = 121
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 100
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
          Title = 'Arquivo a ser importado'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 150
          MessageStr = 'Arquivo TXT a ser acrescentado ao estoque'
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
        object EdNumerosaFrente: TSQLEd
          Left = 72
          Top = 184
          Width = 92
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          MaxLength = 4
          TabOrder = 2
          Text = ''
          Visible = True
          Empty = False
          CloseForm = False
          CloseFormEsc = False
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Numeros a frente'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Numeros a frente do maior numero de nota encontrado no periodo'
          TypeValue = tvInteger
          ValueNegative = False
          Decimals = 0
          ValueFormat = '###,##0'
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
        object Edsobrepoe: TSQLEd
          Left = 192
          Top = 184
          Width = 92
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 1
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
          Title = 'Sobrep'#245'e codigo'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'S - sobrep'#245'e codigos de barras j'#225' digitados'
          TypeValue = tvString
          ValueNegative = False
          Decimals = 0
          CharUpperLower = False
          Items.Strings = (
            'N - N'#227'o regrava codigos j'#225' gravados'
            'S - regrava todos os codigos')
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
        object EdInclusos: TSQLEd
          Left = 179
          Top = 136
          Width = 51
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
          Title = 'Incluidos'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 50
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
        object Edalterados: TSQLEd
          Left = 288
          Top = 136
          Width = 51
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
          Title = 'Alterados'
          TitlePos = tppLeft
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 50
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
        object Memo1: TMemo
          Left = 409
          Top = 131
          Width = 257
          Height = 140
          Lines.Strings = (
            'Memo1')
          ScrollBars = ssBoth
          TabOrder = 6
        end
      end
      object PgImpressoraPadrao: TTabSheet
        ImageIndex = 24
        TabVisible = False
        object Edimpressorapadrao: TSQLEd
          Left = 46
          Top = 16
          Width = 418
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          MaxLength = 300
          TabOrder = 0
          Text = ''
          Visible = True
          Empty = True
          CloseForm = True
          CloseFormEsc = True
          ColorFocus = clBlack
          ColorTextFocus = clWhite
          ColorNotEnabled = clGray
          ColorTextNotEnabled = clWhite
          Title = 'Impressora Padr'#227'o'
          TitlePos = tppTop
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitlePixels = 0
          MessageStr = 'Seleciona a impressora padr'#227'o a ser usada no sistema'
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
    end
  end
  object PMens: TSQLPanelGrid
    Left = 0
    Top = 388
    Width = 759
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
    TabOrder = 2
    HeightLimite = 0
    WidthLimite = 0
    FixedVisible = False
  end
  object Imagens: TImageList
    Left = 313
    Top = 216
    Bitmap = {
      494C010102000400540110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BDBDC600000000000000000000000000BDBDC6000000
      000000000000BDBDC60000000000000000000000000000000000000000000000
      00000000000000000000C6C6BD00000000000000000000000000C6C6BD000000
      000000000000C6C6BD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BDBDC600000000000000000000000000BDBDC600000000000000
      0000BDBDC6000000000000000000000000000000000000000000000000000000
      000000000000C6C6BD00000000000000000000000000C6C6BD00000000000000
      0000C6C6BD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      C60000000000947BC6003110730018005A0018005A0031107300634A9C00BDBD
      C60000000000000000000000000000000000000000000000000000000000C6C6
      BD000000000084C67B0018731000085A0000085A000018731000529C4A00C6C6
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008463CE0021006B0021006B0018005A0018004A0018004A0018004A004A31
      8C00000000000000000000000000000000000000000000000000000000000000
      000073CE6300086B0000086B0000085A0000084A0000084A0000084A0000398C
      3100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000947B
      C6002900940029009C002900940029008400210073001800630010004A001800
      4A00634A9C0000000000000000000000000000000000000000000000000084C6
      7B0010940000109C000010940000108400000873000010630000084A0000084A
      0000529C4A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006B42
      CE003900BD003900BD003100BD003100AD0029009C002900840021005A001800
      4A0031107300BDBDC600000000000000000000000000000000000000000052CE
      420018BD000018BD000018BD000018AD0000109C000010840000085A0000084A
      000018731000C6C6BD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004A10
      CE004200DE004200E7004200DE003900CE003100B50029009C00290084001800
      630018005A0000000000BDBDC6000000000000000000000000000000000029CE
      100018DE000018E7000018DE000018CE000018B50000109C0000108400001063
      0000085A000000000000C6C6BD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004A10
      CE004A00FF005208FF007B31FF006321FF004208D6003900BD0029009C002900
      840018005A0000000000000000000000000000000000000000000000000029CE
      100021FF000029FF080042FF310039FF210021D6080018BD0000109C00001084
      0000085A00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006B42
      CE005200FF005208FF00D68CFF00EFA5FF005210FF004200D6003900BD002900
      94003110840000000000000000000000000000000000000000000000000052CE
      420018FF000029FF08008CFF9400A5FFB50031FF100018D6000018BD00001094
      0000188410000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000947B
      C6003900CE005200FF005A10FF007B31FF005208FF004200E7003900C6002900
      9C00947BC60000000000000000000000000000000000000000000000000084C6
      7B0018CE000018FF000031FF100042FF310029FF080018E7000018C60000109C
      000084C67B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B63CE004200D6005200FF005200FF004A00FF004200EF003900C6007B63
      CE00000000000000000000000000000000000000000000000000000000000000
      000073CE630018D6000018FF000018FF000021FF000021EF000018C6000073CE
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008C7BC6006B42CE004A10CE004A10CE006B42CE008C7BC6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084C67B0052CE420029CE100029CE100052CE420084C67B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FDDBFDDB00000000
      FBB7FBB700000000E80FE80F00000000F00FF00F00000000E007E00700000000
      E003E00300000000E005E00500000000E007E00700000000E007E00700000000
      E007E00700000000F00FF00F00000000F81FF81F00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object QualDbf: TOpenDialog
    DefaultExt = 'dbf'
    Filter = 'Arquivos DBF|*.DBF|Todos os arquivos|*.*'
    Left = 253
    Top = 73
  end
  object QualTexto: TOpenDialog
    DefaultExt = 'CSV'
    Filter = 
      'Arquivos TXT|*.TXT|Arquivos CSV ( ; )|*.CSV|Arquivos XML|*.XML|T' +
      'odos os arquivos|*.*'
    Left = 309
    Top = 169
  end
  object chuftp: TIdFTP
    IPVersion = Id_IPv4
    ConnectTimeout = 0
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    OnAfterClientLogin = chuftpAfterClientLogin
    OnAfterGet = chuftpAfterGet
    ReadTimeout = 10000
    Left = 317
    Top = 31
  end
  object Tabela: TSimpleDataSet
    Aggregates = <>
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    Left = 437
    Top = 55
  end
  object ACBrIBGE1: TACBrIBGE
    ProxyPort = '8080'
    CacheArquivo = 'ACBrIBGE.txt'
    Left = 437
    Top = 127
  end
  object ACBrCNIEE1: TACBrCNIEE
    ProxyPort = '8080'
    URLDownload = 'http://www.fazenda.mg.gov.br/empresas/ecf/files/Tabela_CNIEE.bin'
    Left = 525
    Top = 55
  end
  object XMLDocument1: TXMLDocument
    Left = 533
    Top = 135
  end
  object ACBrCEP1: TACBrCEP
    ProxyPort = '8080'
    WebService = wsRepublicaVirtual
    PesquisarIBGE = True
    Left = 341
    Top = 103
  end
end

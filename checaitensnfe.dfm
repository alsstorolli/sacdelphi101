object FChecaItensNfe: TFChecaItensNfe
  Left = 301
  Top = 102
  BorderStyle = bsDialog
  Caption = 'Checagem Itens NFe'
  ClientHeight = 555
  ClientWidth = 802
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object SQLPanelGrid1: TSQLPanelGrid
    Left = 0
    Top = 0
    Width = 802
    Height = 555
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
      Left = 705
      Top = 1
      Width = 96
      Height = 526
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
        Height = 524
        Align = alClient
        AutoBounds = False
        BoundLines = []
        SubCaption.Ellipsis = False
        SubCaption.Style = []
      end
      object bGravar: TSQLBtn
        Left = 1
        Top = 2
        Width = 95
        Height = 25
        Hint = 'Grava a rescisao'
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
        Operation = fbNone
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bSair: TSQLBtn
        Left = 1
        Top = 28
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
    end
    object PMens: TSQLPanelGrid
      Left = 1
      Top = 527
      Width = 800
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
      Width = 704
      Height = 526
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
        Width = 702
        Height = 524
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
          Top = 129
          Width = 716
          Height = 325
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
            Top = 8
            Width = 710
            Height = 234
            ColCount = 9
            DefaultRowHeight = 15
            FixedCols = 0
            RowCount = 8
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
            TabOrder = 0
            Columns = <
              item
                Alignment = taCenter
                Title.Alignment = taCenter
                Title.Caption = 'Produto'
                WidthColumn = 70
                FieldName = 'move_esto_codigo'
              end
              item
                Title.Caption = 'Cod.Produto NFe'
                WidthColumn = 90
                FieldName = 'produtonfe'
              end
              item
                Title.Caption = 'Descri'#231#227'o'
                WidthColumn = 150
                FieldName = 'descricaonfe'
              end
              item
                Title.Caption = 'Un.'
                WidthColumn = 35
                FieldName = 'Esto_Unidade'
              end
              item
                Alignment = taCenter
                Title.Alignment = taCenter
                Title.Caption = '% Icms'
                WidthColumn = 45
                FieldName = 'Move_aliicms'
              end
              item
                EditMask = '##0.00'
                Alignment = taRightJustify
                Title.Alignment = taCenter
                Title.Caption = 'Quantidade'
                WidthColumn = 65
                FieldName = 'move_qtde'
              end
              item
                EditMask = '###,##0.0000'
                Alignment = taRightJustify
                Format = cfNumber
                Title.Alignment = taCenter
                Title.Caption = 'Unit'#225'rio'
                WidthColumn = 64
                FieldName = 'move_venda'
              end
              item
                EditMask = '###,##0.00'
                Alignment = taRightJustify
                Format = cfNumber
                Title.Alignment = taCenter
                Title.Caption = 'Total'
                WidthColumn = 64
                FieldName = 'total'
              end
              item
                Title.Caption = 'CFOP'
                WidthColumn = 64
                FieldName = 'move_natf_codigo'
              end>
            RowCountMin = 1
            SelectedIndex = 0
            Version = '2.0'
            ColWidths = (
              70
              90
              150
              45
              35
              65
              64
              64
              64)
          end
          object PTotais: TSQLPanelGrid
            Left = 1
            Top = 283
            Width = 714
            Height = 41
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
            object EdBaseIcms: TSQLEd
              Left = 11
              Top = 16
              Width = 70
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
              Visible = True
              Alignment = taRightJustify
              Empty = True
              CloseForm = False
              CloseFormEsc = False
              ColorFocus = clBlack
              ColorTextFocus = clWhite
              ColorNotEnabled = clWhite
              ColorTextNotEnabled = clWhite
              Title = 'Base Icms'
              TitlePos = tppTop
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              TitlePixels = 0
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
            end
            object EdValorIcms: TSQLEd
              Left = 88
              Top = 16
              Width = 70
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
              TabOrder = 1
              Visible = True
              Alignment = taRightJustify
              Empty = True
              CloseForm = False
              CloseFormEsc = False
              ColorFocus = clBlack
              ColorTextFocus = clWhite
              ColorNotEnabled = clWhite
              ColorTextNotEnabled = clWhite
              Title = 'Valor Icms'
              TitlePos = tppTop
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              TitlePixels = 0
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
            end
            object EdTotalprodutos: TSQLEd
              Left = 468
              Top = 16
              Width = 70
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
              TabOrder = 2
              Visible = True
              Alignment = taRightJustify
              Empty = True
              CloseForm = False
              CloseFormEsc = False
              ColorFocus = clBlack
              ColorTextFocus = clWhite
              ColorNotEnabled = clWhite
              ColorTextNotEnabled = clWhite
              Title = 'Total Produtos'
              TitlePos = tppTop
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              TitlePixels = 0
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
            end
            object EdTotalNota: TSQLEd
              Left = 627
              Top = 16
              Width = 70
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
              TabOrder = 3
              Visible = True
              Alignment = taRightJustify
              Empty = True
              CloseForm = False
              CloseFormEsc = False
              ColorFocus = clBlack
              ColorTextFocus = clWhite
              ColorNotEnabled = clWhite
              ColorTextNotEnabled = clWhite
              Title = 'Total Nota'
              TitlePos = tppTop
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              TitlePixels = 0
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
            end
          end
        end
        object PRemessa: TSQLPanelGrid
          Left = 1
          Top = 1
          Width = 700
          Height = 128
          Align = alTop
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
          object EdFornec: TSQLEd
            Left = 163
            Top = 14
            Width = 39
            Height = 21
            TabStop = False
            MaxLength = 7
            TabOrder = 1
            Visible = True
            Alignment = taRightJustify
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            ShowForm = 'FFornece'
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Fornec.'
            TitlePos = tppTop
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 0
            MessageStr = 'Codigo do fornecedore'
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
            FindSetEdt = SetEdFORN_NOME
            Group = 0
            TableName = 'movesto'
            TableField = 'Moes_tipo_codigo'
          end
          object SetEdFORN_NOME: TSQLEd
            Left = 208
            Top = 15
            Width = 97
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
            TabOrder = 2
            Visible = True
            Alignment = taLeftJustify
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
          object EdComv_codigo: TSQLEd
            Left = 11
            Top = 14
            Width = 40
            Height = 21
            TabStop = False
            MaxLength = 3
            TabOrder = 0
            Visible = True
            Alignment = taRightJustify
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            ShowForm = 'FConfMovimento'
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
            MessageStr = 'Codigo da configura'#231#227'o do movimento'
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
            FindTable = 'confmov'
            FindField = 'comv_codigo'
            FindSetField = 'comv_descricao'
            FindSetEdt = EdComv_descricao
            Group = 0
            PanelMessages = PMens
          end
          object EdComv_descricao: TSQLEd
            Left = 60
            Top = 14
            Width = 100
            Height = 21
            TabStop = False
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
            Visible = True
            Alignment = taLeftJustify
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Descri'#231#227'o'
            TitlePos = tppInvisible
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
        end
      end
    end
  end
  object ACBrNFe1: TACBrNFe
    Configuracoes.Geral.PathSalvar = 'D:\Arquivos de programas\Borland\Delphi7\Bin\'
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.IntervaloTentativas = 0
    Configuracoes.WebServices.AjustaAguardaConsultaRet = False
    Left = 419
    Top = 99
  end
end

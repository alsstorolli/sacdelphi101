object FPesagemCamaraFria: TFPesagemCamaraFria
  Left = 49
  Top = 55
  BorderStyle = bsDialog
  Caption = 'Etiquetas Camara Fria'
  ClientHeight = 609
  ClientWidth = 1128
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object SQLPanelGrid1: TSQLPanelGrid
    Left = 0
    Top = 0
    Width = 1128
    Height = 609
    Align = alClient
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
    object pbotoes: TSQLPanelGrid
      Left = 930
      Top = 1
      Width = 197
      Height = 580
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
      object APHeadLabel1: TAPHeadLabel
        Left = 1
        Top = 1
        Width = 195
        Height = 578
        Align = alClient
        AutoBounds = False
        BoundLines = []
        SubCaption.Ellipsis = False
        SubCaption.Style = []
        ExplicitLeft = 2
        ExplicitTop = -4
      end
      object bSair: TSQLBtn
        Left = 1
        Top = -2
        Width = 280
        Height = 100
        Hint = 'Abandona a tela'
        Caption = 'F6 - Sair'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 5
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 2
        OnClick = bSairClick
        Operation = fbExit
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bretnropedido: TSQLBtn
        Left = 2
        Top = 281
        Width = 280
        Height = 100
        Hint = 'retorna ao numero da etiqueta'
        Caption = 'F3 - Codigo '
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 5
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 2
        OnClick = bretnropedidoClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bimpetq: TSQLBtn
        Left = -1
        Top = 200
        Width = 197
        Height = 47
        Hint = 'Impress'#227'o de Etiqueta'
        Caption = 'F5 - Etiqueta'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 5
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 2
        OnClick = bimpetqClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bexcluipesagem: TSQLBtn
        Left = 1
        Top = 139
        Width = 180
        Height = 35
        Hint = 'Exclui Pesagem'
        Caption = 'F2 - Exclui Impress'#227'o'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 5
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 2
        OnClick = bexcluipesagemClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object EdSeqi: TSQLEd
        Left = 36
        Top = 255
        Width = 34
        Height = 21
        TabStop = False
        Alignment = taRightJustify
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
        Title = 'Inicio'
        TitlePos = tppLeft
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 30
        TypeValue = tvInteger
        ValueNegative = False
        Decimals = 2
        ValueFormat = '###0'
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
      object EdSeqf: TSQLEd
        Left = 116
        Top = 253
        Width = 34
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        TabOrder = 1
        Text = ''
        Visible = True
        Empty = True
        CloseForm = False
        CloseFormEsc = False
        OnExitEdit = EdSeqfExitEdit
        OnValidate = EdSeqfValidate
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'Fim'
        TitlePos = tppLeft
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 30
        TypeValue = tvInteger
        ValueNegative = False
        Decimals = 2
        ValueFormat = '###0'
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
    object PMens: TSQLPanelGrid
      Left = 1
      Top = 581
      Width = 1126
      Height = 27
      Align = alBottom
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
    end
    object SQLPanelGrid3: TSQLPanelGrid
      Left = 1
      Top = 1
      Width = 929
      Height = 580
      Align = alClient
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
      object SQLPanelGrid4: TSQLPanelGrid
        Left = 1
        Top = 1
        Width = 927
        Height = 578
        Align = alClient
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
        object PRemessa: TSQLPanelGrid
          Left = 1
          Top = 1
          Width = 925
          Height = 56
          Align = alTop
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
          object EdNumeroDOC: TSQLEd
            Left = 153
            Top = 11
            Width = 209
            Height = 40
            TabStop = False
            Alignment = taLeftJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -27
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 14
            ParentFont = False
            TabOrder = 0
            Text = ''
            Visible = True
            OnChange = EdNumeroDOCChange
            OnKeyDown = EdNumeroDOCKeyDown
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            OnValidate = EdNumeroDOCValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Codigo Etiqueta'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -16
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = [fsBold]
            TitlePixels = 150
            TypeValue = tvString
            ValueNegative = False
            Decimals = 0
            CharUpperLower = False
            ItemsMultiples = False
            ItemsValid = True
            ItemsWidth = 0
            ItemsHeight = 300
            ItemsLength = 0
            Duplicity = 0
            MinLength = 0
            Group = 0
          end
          object pnomecliente: TSQLPanelGrid
            Left = 431
            Top = -5
            Width = 578
            Height = 61
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -21
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 1
            HeightLimite = 0
            WidthLimite = 0
            FixedVisible = False
          end
        end
        object PIns: TSQLPanelGrid
          Left = 1
          Top = 204
          Width = 925
          Height = 373
          Align = alBottom
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
          HeightLimite = 0
          WidthLimite = 0
          FixedVisible = False
          object Label3: TLabel
            Left = 568
            Top = 1
            Width = 120
            Height = 53
            Align = alRight
            Caption = 'Peso '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -45
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
          end
          object Label7: TLabel
            Left = 736
            Top = 12
            Width = 223
            Height = 37
            Caption = 'F12 - Produtos'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -32
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object EdPeso: TSQLEd
            Left = 600
            Top = 73
            Width = 64
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
            Empty = True
            CloseForm = False
            CloseFormEsc = False
            OnValidate = EdPesoValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Peso '
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 30
            TypeValue = tvFloat
            ValueNegative = False
            Decimals = 3
            ValueFormat = '###,##0.000'
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
          object PPeso: TSQLPanelGrid
            Left = 688
            Top = 1
            Width = 236
            Height = 204
            Align = alRight
            Alignment = taRightJustify
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -61
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 1
            HeightLimite = 0
            WidthLimite = 0
            FixedVisible = False
          end
          object pNomeProduto: TSQLPanelGrid
            Left = 2
            Top = 2
            Width = 567
            Height = 202
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -43
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 2
            HeightLimite = 0
            WidthLimite = 0
            FixedVisible = False
            object Diretorio: TFileListBox
              Left = 24
              Top = 24
              Width = 145
              Height = 97
              Enabled = False
              ItemHeight = 51
              TabOrder = 0
              Visible = False
            end
          end
          object EdProduto: TSQLEd
            Left = 599
            Top = 11
            Width = 121
            Height = 54
            TabStop = False
            Alignment = taLeftJustify
            Color = clGray
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -43
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 12
            ParentFont = False
            TabOrder = 3
            Text = ''
            Visible = False
            OnChange = EdProdutoChange
            OnKeyDown = EdProdutoKeyDown
            Empty = False
            CloseForm = False
            CloseFormEsc = False
            OnValidate = EdProdutoValidate
            ColorFocus = clBlack
            ColorTextFocus = clWhite
            ColorNotEnabled = clGray
            ColorTextNotEnabled = clWhite
            Title = 'Codigo'
            TitlePos = tppLeft
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitlePixels = 40
            TypeValue = tvString
            ValueNegative = False
            Decimals = 0
            CharUpperLower = False
            ItemsMultiples = False
            ItemsValid = True
            ItemsWidth = 0
            ItemsHeight = 600
            ItemsLength = 12
            Duplicity = 0
            MinLength = 0
            Group = 0
          end
          object PCortes: TSQLPanelGrid
            Left = 1
            Top = 205
            Width = 923
            Height = 167
            Align = alBottom
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -43
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 4
            HeightLimite = 0
            WidthLimite = 0
            FixedVisible = False
            object GridCortes: TSqlDtGrid
              Left = 1
              Top = 1
              Width = 921
              Height = 165
              Align = alClient
              ColCount = 4
              DefaultRowHeight = 25
              FixedCols = 0
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -20
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              GridLineWidth = 3
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
              ParentFont = False
              TabOrder = 0
              Columns = <
                item
                  Alignment = taRightJustify
                  Format = cfNumber
                  Title.Caption = 'Seq'
                  WidthColumn = 55
                  FieldName = 'movd_seq'
                end
                item
                  Title.Caption = 'Codigo'
                  WidthColumn = 64
                  FieldName = 'mpdd_esto_codigo'
                end
                item
                  Title.Caption = 'Descri'#231#227'o do Produto'
                  WidthColumn = 300
                  FieldName = 'esto_descricao'
                end
                item
                  Alignment = taRightJustify
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Peso'
                  WidthColumn = 90
                  FieldName = 'movd_pesocarcaca'
                end>
              RowCountMin = 0
              SelectedIndex = 0
              Version = '2.0'
              PermitePesquisa = True
              ColWidths = (
                55
                79
                392
                90)
              RowHeights = (
                25
                25
                25
                25
                25)
            end
          end
        end
        object PPedidos: TSQLPanelGrid
          Left = 1
          Top = 57
          Width = 925
          Height = 98
          Align = alClient
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 2
          HeightLimite = 0
          WidthLimite = 0
          FixedVisible = False
          object GridPedido: TSqlDtGrid
            Left = 1
            Top = 1
            Width = 923
            Height = 96
            Align = alClient
            ColCount = 4
            DefaultRowHeight = 25
            FixedCols = 0
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -20
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            GridLineWidth = 3
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
            ParentFont = False
            TabOrder = 0
            Columns = <
              item
                Alignment = taRightJustify
                Format = cfNumber
                Title.Caption = 'Seq'
                WidthColumn = 55
                FieldName = 'movd_seq'
              end
              item
                Title.Caption = 'Codigo'
                WidthColumn = 64
                FieldName = 'mpdd_esto_codigo'
              end
              item
                Title.Caption = 'Descri'#231#227'o do Produto'
                WidthColumn = 300
                FieldName = 'esto_descricao'
              end
              item
                Alignment = taRightJustify
                Title.Alignment = taRightJustify
                Title.Caption = 'Peso'
                WidthColumn = 90
                FieldName = 'movd_pesocarcaca'
              end>
            RowCountMin = 0
            SelectedIndex = 0
            Version = '2.0'
            PermitePesquisa = True
            ColWidths = (
              55
              79
              392
              90)
            RowHeights = (
              25
              25
              25
              25
              25)
          end
        end
        object PTotais: TSQLPanelGrid
          Left = 1
          Top = 23
          Width = 925
          Height = 181
          Align = alBottom
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 3
          HeightLimite = 0
          WidthLimite = 0
          FixedVisible = False
          object Label1: TLabel
            Left = 300
            Top = 121
            Width = 160
            Height = 37
            Caption = 'Peso Total'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -32
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label4: TLabel
            Left = 842
            Top = 164
            Width = 94
            Height = 53
            Align = alCustom
            Caption = 'Tara'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -45
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
          end
          object Label5: TLabel
            Left = 843
            Top = 3
            Width = 171
            Height = 53
            Align = alCustom
            Caption = 'Balan'#231'a'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -45
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
          end
          object ppesobalanca: TLabel
            Left = 844
            Top = 56
            Width = 218
            Height = 72
            Align = alCustom
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -61
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
          end
          object ptara: TLabel
            Left = 843
            Top = 210
            Width = 194
            Height = 72
            Align = alCustom
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -61
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
          end
          object Bevel1: TBevel
            Left = 840
            Top = 111
            Width = 235
            Height = 102
          end
          object Bevel2: TBevel
            Left = 840
            Top = 3
            Width = 235
            Height = 107
          end
          object Label2: TLabel
            Left = -4
            Top = 125
            Width = 102
            Height = 37
            Caption = 'Cortes'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -32
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object PTotalPesado: TSQLPanelGrid
            Left = 471
            Top = 3
            Width = 312
            Height = 282
            Alignment = taRightJustify
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -61
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 0
            HeightLimite = 0
            WidthLimite = 0
            FixedVisible = False
          end
          object panimaispesados: TSQLPanelGrid
            Left = 153
            Top = 4
            Width = 123
            Height = 281
            Alignment = taRightJustify
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -61
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 1
            HeightLimite = 0
            WidthLimite = 0
            FixedVisible = False
          end
        end
      end
    end
  end
  object ACBrBAL1: TACBrBAL
    Porta = 'COM1'
    OnLePeso = ACBrBAL1LePeso
    Left = 522
    Top = 100
  end
  object ACBrETQ1: TACBrETQ
    Porta = 'LPT1'
    Ativo = False
    Left = 419
    Top = 73
  end
  object ACBrNFe1: TACBrNFe
    Configuracoes.Geral.SSLLib = libNone
    Configuracoes.Geral.SSLCryptLib = cryNone
    Configuracoes.Geral.SSLHttpLib = httpNone
    Configuracoes.Geral.SSLXmlSignLib = xsNone
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Geral.VersaoQRCode = veqr000
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Configuracoes.RespTec.IdCSRT = 0
    Left = 594
    Top = 76
  end
  object ACBrBAL2: TACBrBAL
    Porta = 'COM1'
    OnLePeso = ACBrBAL2LePeso
    Left = 594
    Top = 124
  end
end

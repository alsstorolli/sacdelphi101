object FGerenciaMdf: TFGerenciaMdf
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Gerenciamento de MFDe'
  ClientHeight = 465
  ClientWidth = 1060
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PCadastro: TPanel
    Left = 0
    Top = 0
    Width = 1060
    Height = 465
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    object PBotoes: TSQLPanelGrid
      Left = 946
      Top = 1
      Width = 113
      Height = 436
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
        Width = 111
        Height = 434
        Align = alClient
        AutoBounds = False
        BoundLines = []
        Gradient.EndColor = clGray
        Gradient.StartColor = clSilver
        SubCaption.Ellipsis = False
        SubCaption.Style = []
        ExplicitLeft = 2
        ExplicitWidth = 164
      end
      object bimpdanfe: TSQLBtn
        Left = 0
        Top = 48
        Width = 119
        Height = 25
        Hint = 'Imprime o Manifesto'
        Caption = '&Imprime Manifesto'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 0
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        OnClick = bimpdanfeClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bcancelamdfe: TSQLBtn
        Left = 0
        Top = 79
        Width = 119
        Height = 25
        Hint = 'Cancela MDFe'
        Caption = 'C&ancelar Manifesto'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 0
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        OnClick = bcancelamdfeClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bSair: TSQLBtn
        Left = 0
        Top = 231
        Width = 119
        Height = 25
        Hint = 'Abandona a tela'
        Caption = '&Sair'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 0
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        OnClick = bSairClick
        Operation = fbExit
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bencerramdf: TSQLBtn
        Left = 0
        Top = 19
        Width = 119
        Height = 25
        Hint = 'Encerra o manifesto'
        Caption = '&Encerrar Manifesto'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 0
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        OnClick = bencerramdfClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bconsultamdfe: TSQLBtn
        Left = 0
        Top = 111
        Width = 119
        Height = 25
        Hint = 'consutla situa'#231#227'o manifesto'
        Caption = 'C&onsultar Manifesto'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 0
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        OnClick = bconsultamdfeClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bverxml: TSQLBtn
        Left = 0
        Top = 195
        Width = 119
        Height = 25
        Hint = 'Mostra o XML do MDFe'
        Caption = '&Ver XML'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 0
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        OnClick = bverxmlClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bnaoencerrados: TSQLBtn
        Left = 0
        Top = 147
        Width = 119
        Height = 25
        Hint = 'Mostra mdfes n'#227'o encerrados'
        Caption = '&Ver N'#227'o Encerrados'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Margin = 0
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        OnClick = bnaoencerradosClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
    end
    object PMens: TSQLPanelGrid
      Left = 1
      Top = 437
      Width = 1058
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
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 945
      Height = 436
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 2
      object pgrid: TSQLPanelGrid
        Left = 1
        Top = 110
        Width = 943
        Height = 325
        Align = alBottom
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
        object Grid: TSqlDtGrid
          Left = 1
          Top = 1
          Width = 941
          Height = 323
          Align = alClient
          ColCount = 10
          DefaultRowHeight = 18
          FixedCols = 0
          RowCount = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
          ParentFont = False
          TabOrder = 0
          OnClick = GridClick
          Columns = <
            item
              Title.Caption = 'Numero'
              WidthColumn = 60
              FieldName = 'moes_numerodoc'
            end
            item
              Title.Caption = 'Emiss'#227'o'
              WidthColumn = 70
              FieldName = 'moes_dataemissao'
            end
            item
              Alignment = taRightJustify
              Title.Alignment = taCenter
              Title.Caption = 'Peso'
              WidthColumn = 80
              FieldName = 'moes_vlrtotal'
            end
            item
              Alignment = taRightJustify
              Title.Alignment = taCenter
              Title.Caption = 'Codigo'
              WidthColumn = 50
              FieldName = 'moes_tipo_codigo'
            end
            item
              Title.Caption = 'Ve'#237'culo / Placa'
              WidthColumn = 200
              FieldName = 'clie_razaosocial'
            end
            item
              Title.Caption = 'Motorista'
              WidthColumn = 120
              FieldName = 'motorista'
            end
            item
              Title.Caption = 'Situa'#231#227'o'
              WidthColumn = 100
              FieldName = 'situacao'
            end
            item
              Format = cfNumber
              Title.Caption = 'Data Autoriza'#231#227'o MDF'
              WidthColumn = 120
              FieldName = 'pesopedido'
            end
            item
              Title.Caption = 'Chave'
              WidthColumn = 100
              FieldName = 'chavemdfe'
            end
            item
              Title.Caption = 'Protocolo de Envio'
              WidthColumn = 140
              FieldName = 'numeronfe'
            end>
          RowCountMin = 0
          SelectedIndex = 0
          Version = '2.0'
          PermitePesquisa = True
          ColWidths = (
            60
            70
            80
            50
            200
            120
            100
            120
            140
            100)
          RowHeights = (
            18
            18)
        end
      end
      object Edinicio: TSQLEd
        Left = 24
        Top = 35
        Width = 80
        Height = 27
        TabStop = False
        Alignment = taLeftJustify
        EditMask = '99/99/99;0;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 8
        ParentFont = False
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
        Title = 'Inicio'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'Inicio do per'#237'odo de exporta'#231#227'o'
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
      object EdTermino: TSQLEd
        Left = 121
        Top = 35
        Width = 80
        Height = 27
        TabStop = False
        Alignment = taLeftJustify
        EditMask = '99/99/99;0;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 8
        ParentFont = False
        TabOrder = 2
        Text = ''
        Visible = True
        Empty = False
        CloseForm = False
        CloseFormEsc = False
        OnExitEdit = EdTerminoExitEdit
        OnValidate = EdTerminoExitEdit
        ColorFocus = clBlack
        ColorTextFocus = clWhite
        ColorNotEnabled = clGray
        ColorTextNotEnabled = clWhite
        Title = 'T'#233'rmino'
        TitlePos = tppTop
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitlePixels = 0
        MessageStr = 'T'#233'rmino do per'#237'odo de exporta'#231#227'o'
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
      object Memo1: TMemo
        Left = 328
        Top = 1
        Width = 616
        Height = 109
        Align = alRight
        TabOrder = 3
      end
    end
  end
  object ACBrMDFe1: TACBrMDFe
    Configuracoes.Geral.SSLLib = libNone
    Configuracoes.Geral.SSLCryptLib = cryNone
    Configuracoes.Geral.SSLHttpLib = httpNone
    Configuracoes.Geral.SSLXmlSignLib = xsNone
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.Arquivos.SepararPorAno = True
    Configuracoes.Arquivos.SepararPorMes = True
    Configuracoes.WebServices.UF = 'PR'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Configuracoes.RespTec.IdCSRT = 0
    DAMDFE = ACBrMDFeDAMDFeRL1
    Left = 241
    Top = 9
  end
  object ACBrMDFeDAMDFeRL1: TACBrMDFeDAMDFeRL
    Sistema = 'Projeto ACBr - www.projetoacbr.com.br'
    MargemInferior = 0.800000000000000000
    MargemSuperior = 0.800000000000000000
    MargemEsquerda = 0.600000000000000000
    MargemDireita = 0.510000000000000000
    ExpandeLogoMarcaConfig.Altura = 0
    ExpandeLogoMarcaConfig.Esquerda = 0
    ExpandeLogoMarcaConfig.Topo = 0
    ExpandeLogoMarcaConfig.Largura = 0
    ExpandeLogoMarcaConfig.Dimensionar = False
    ExpandeLogoMarcaConfig.Esticar = True
    CasasDecimais.Formato = tdetInteger
    CasasDecimais.qCom = 2
    CasasDecimais.vUnCom = 2
    CasasDecimais.MaskqCom = ',0.00'
    CasasDecimais.MaskvUnCom = ',0.00'
    ACBrMDFe = ACBrMDFe1
    ImprimeHoraSaida = False
    TipoDAMDFe = tiSemGeracao
    TamanhoPapel = tpA4
    Cancelada = False
    Encerrado = False
    ImprimeDadosExtras = [deValorTotal, deRelacaoDFe]
    PrintDialog = True
    Left = 233
    Top = 49
  end
end

object FNfeDestinadas: TFNfeDestinadas
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'NF-e Destinadas'
  ClientHeight = 491
  ClientWidth = 1215
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
  object PBotoes: TSQLPanelGrid
    Left = 1115
    Top = 0
    Width = 100
    Height = 491
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
      Height = 489
      Align = alClient
      AutoBounds = False
      BoundLines = []
      Gradient.EndColor = clGray
      Gradient.StartColor = clSilver
      SubCaption.Ellipsis = False
      SubCaption.Style = []
      ExplicitLeft = 4
      ExplicitTop = 3
      ExplicitHeight = 411
    end
    object bSair: TSQLBtn
      Left = 3
      Top = 6
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
      Processing = False
      AutoAction = True
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object bmanifesta: TSQLBtn
      Left = 1
      Top = 129
      Width = 95
      Height = 25
      Hint = 'Manifesta NF-e na receita'
      Caption = 'Manifesto Se&fa'
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
      OnClick = bmanifestaClick
      Operation = fbNone
      Processing = False
      AutoAction = True
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object bbaixaxmls: TSQLBtn
      Left = 2
      Top = 189
      Width = 95
      Height = 25
      Hint = 'Baixa xml das NF-e manifestadas'
      Caption = 'Baixa XMLS'
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
      Spacing = 5
      Visible = False
      OnClick = bbaixaxmlsClick
      Operation = fbNone
      Processing = False
      AutoAction = True
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object btiramanifesto: TSQLBtn
      Left = 2
      Top = 161
      Width = 95
      Height = 25
      Hint = 'Manifesta Desconhecimento da  NF-e na receita'
      Caption = '&Tira Manifesto '
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
      OnClick = btiramanifestoClick
      Operation = fbNone
      Processing = False
      AutoAction = True
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1115
    Height = 491
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 1
    object Edunidade: TSQLEd
      Left = 315
      Top = 19
      Width = 208
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
    object EdUnid_codigo: TSQLEd
      Left = 277
      Top = 19
      Width = 32
      Height = 21
      TabStop = False
      Alignment = taLeftJustify
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 4
      Text = ''
      Visible = True
      OnKeyPress = EdUnid_codigoKeyPress
      Empty = False
      CloseForm = False
      CloseFormEsc = False
      ShowForm = 'FUnidades'
      OnExitEdit = EdIndicadoremissorExitEdit
      OnValidate = EdUnid_codigoValidate
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
      MessageStr = 'Cod. do local de trabalho'
      TypeValue = tvString
      ValueNegative = False
      Decimals = 0
      ValueFormat = '000'
      CharUpperLower = True
      ItemsMultiples = False
      ItemsValid = True
      ItemsWidth = 0
      ItemsHeight = 0
      ItemsLength = 0
      Duplicity = 0
      MinLength = 0
      FindTable = 'UNIDADES'
      FindField = 'UNID_CODIGO'
      FindSetField = 'UNID_NOME'
      FindSetEdt = Edunidade
      Group = 0
    end
    object Edtermino: TSQLEd
      Left = 127
      Top = 19
      Width = 58
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
      OnValidate = EdterminoValidate
      ColorFocus = clBlack
      ColorTextFocus = clWhite
      ColorNotEnabled = clGray
      ColorTextNotEnabled = clWhite
      Title = 'T'#233'rmino'
      TitlePos = tppTop
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
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
    object EdInicio: TSQLEd
      Left = 66
      Top = 19
      Width = 58
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
      ColorFocus = clBlack
      ColorTextFocus = clWhite
      ColorNotEnabled = clGray
      ColorTextNotEnabled = clWhite
      Title = 'Inicio'
      TitlePos = tppTop
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
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
    object pgrid: TSQLPanelGrid
      Left = 1
      Top = 70
      Width = 1113
      Height = 420
      Align = alBottom
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 6
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
      object Grid: TSqlDtGrid
        Left = 1
        Top = 1
        Width = 1111
        Height = 418
        Align = alClient
        ColCount = 11
        DefaultRowHeight = 18
        DrawingStyle = gdsGradient
        FixedCols = 0
        RowCount = 2
        GradientStartColor = clAqua
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
        TabOrder = 0
        Columns = <
          item
            Title.Caption = 'Chave NFe'
            WidthColumn = 260
            FieldName = 'moes_chavenfe'
          end
          item
            Title.Caption = 'Emiss'#227'o'
            WidthColumn = 55
            FieldName = 'moes_dataemissao'
          end
          item
            Title.Caption = 'Movimento'
            WidthColumn = 55
            FieldName = 'moes_datamvto'
          end
          item
            Alignment = taRightJustify
            Title.Alignment = taCenter
            Title.Caption = 'Valor'
            WidthColumn = 65
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
            Title.Caption = 'Emitente'
            WidthColumn = 200
            FieldName = 'clie_razaosocial'
          end
          item
            Title.Caption = 'CNPJ'
            WidthColumn = 100
            FieldName = 'cnpjemitente'
          end
          item
            Title.Caption = 'Sit.Manifesto'
            WidthColumn = 75
            FieldName = 'sitmanifesto'
          end
          item
            Title.Caption = 'Numero'
            WidthColumn = 64
            FieldName = 'moes_numerodoc'
          end
          item
            Title.Caption = 'NSU'
            WidthColumn = 110
            FieldName = 'nsu'
          end
          item
            Title.Caption = 'Transa'#231#227'o'
            WidthColumn = 100
            FieldName = 'moes_transacao'
          end>
        RowCountMin = 0
        SelectedIndex = 0
        Version = '2.0'
        PermitePesquisa = True
        ColWidths = (
          260
          55
          55
          65
          50
          200
          100
          75
          64
          110
          100)
        RowHeights = (
          18
          18)
      end
    end
    object Edtipoconsulta: TSQLEd
      Left = 21
      Top = 19
      Width = 39
      Height = 21
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = clGray
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 1
      ParentFont = False
      TabOrder = 0
      Text = '1'
      Visible = True
      Empty = False
      CloseForm = False
      CloseFormEsc = False
      OnValidate = EdtipoconsultaValidate
      ColorFocus = clBlack
      ColorTextFocus = clWhite
      ColorNotEnabled = clGray
      ColorTextNotEnabled = clWhite
      Title = 'Tipo '
      TitlePos = tppTop
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      TitlePixels = 0
      MessageStr = '1 - Notas da receita   2 - Notas digitadas no sistema'
      TypeValue = tvString
      ValueNegative = False
      Decimals = 0
      CharUpperLower = False
      Items.Strings = (
        '1 - Notas da receita'
        '2 - Notas digitadas no sistema')
      ItemsMultiples = False
      ItemsValid = True
      ItemsWidth = 0
      ItemsHeight = 0
      ItemsLength = 1
      Duplicity = 0
      MinLength = 0
      Group = 0
    end
    object EdNsu: TSQLEd
      Left = 189
      Top = 19
      Width = 77
      Height = 21
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = '0'
      Visible = True
      Empty = True
      CloseForm = False
      CloseFormEsc = False
      ColorFocus = clBlack
      ColorTextFocus = clWhite
      ColorNotEnabled = clGray
      ColorTextNotEnabled = clWhite
      Title = 'NSU'
      TitlePos = tppTop
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      TitlePixels = 0
      MessageStr = 'NSU para iniciar consulta'
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
    end
  end
  object ACBrNFe1: TACBrNFe
    Configuracoes.Geral.SSLLib = libWinCrypt
    Configuracoes.Geral.SSLCryptLib = cryWinCrypt
    Configuracoes.Geral.SSLHttpLib = httpWinHttp
    Configuracoes.Geral.SSLXmlSignLib = xsLibXml2
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Geral.VersaoQRCode = veqr000
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'PR'
    Configuracoes.WebServices.Ambiente = taProducao
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Configuracoes.RespTec.IdCSRT = 0
    Left = 352
    Top = 72
  end
end

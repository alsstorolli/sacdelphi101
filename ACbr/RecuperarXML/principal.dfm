object FBuscaXmlSefa: TFBuscaXmlSefa
  Left = 302
  Top = 209
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Baixa XML da Distribui'#231#227'o NF-e'
  ClientHeight = 542
  ClientWidth = 506
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblStatus: TLabel
    Left = 1
    Top = 232
    Width = 506
    Height = 24
    Align = alCustom
    Alignment = taCenter
    AutoSize = False
    Caption = 'Conectando a Receita Federal'
    FocusControl = ProgressBar1
    Visible = False
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 262
    Width = 510
    Height = 40
    Align = alCustom
    TabOrder = 0
    Visible = False
  end
  object Panel2: TPanel
    Left = 0
    Top = -3
    Width = 506
    Height = 229
    Align = alCustom
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 155
      Height = 13
      Caption = 'Chave de acesso da nota fiscal: '
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 169
      Height = 13
      Caption = 'Digite o c'#243'digo da imagem ao lado: '
      Visible = False
    end
    object edtChaveNFe: TEdit
      Left = 8
      Top = 24
      Width = 329
      Height = 21
      TabOrder = 0
    end
    object edtCaptcha: TEdit
      Left = 9
      Top = 67
      Width = 73
      Height = 21
      TabOrder = 1
      Visible = False
      OnChange = edtCaptchaChange
    end
    object cbnfce: TCheckBox
      Left = 231
      Top = 57
      Width = 106
      Height = 17
      Caption = 'NF Consumidor'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      Visible = False
    end
  end
  object Panel3: TPanel
    Left = 1
    Top = 104
    Width = 503
    Height = 49
    TabOrder = 2
    object btnPegarHTML: TButton
      Left = 114
      Top = 14
      Width = 76
      Height = 27
      Caption = 'Pegar HTML'
      Enabled = False
      TabOrder = 0
      Visible = False
      OnClick = btnPegarHTMLClick
    end
    object btnNovaConsulta: TButton
      Left = 192
      Top = 14
      Width = 76
      Height = 27
      Caption = 'Nova Consulta'
      TabOrder = 1
      OnClick = btnNovaConsultaClick
    end
    object btnGerarXML: TButton
      Left = 270
      Top = 14
      Width = 76
      Height = 27
      Caption = 'Gerar XML'
      Enabled = False
      TabOrder = 2
      Visible = False
      OnClick = btnGerarXMLClick
    end
    object Button1: TButton
      Left = 5
      Top = 14
      Width = 76
      Height = 27
      Caption = 'Salvar XML'
      TabOrder = 3
      OnClick = Button1Click
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 304
    Width = 510
    Height = 238
    ActivePage = TabSheet1
    Align = alCustom
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = 'Dados HTML'
      object Memo2: TMemo
        Left = 0
        Top = 0
        Width = 502
        Height = 210
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Dados XML'
      ImageIndex = 1
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 502
        Height = 210
        Align = alClient
        TabOrder = 0
        object WBXML: TWebBrowser
          Left = 1
          Top = 1
          Width = 500
          Height = 208
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 341
          ExplicitHeight = 177
          ControlData = {
            4C000000AD3300007F1500000000000000000000000000000000000000000000
            000000004C000000000000000000000001000000E0D057007335CF11AE690800
            2B2E126208000000000000004C0000000114020000000000C000000000000046
            8000000000000000000000000000000000000000000000000000000000000000
            00000000000000000100000000000000000000000000000000000000}
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Sobre'
      ImageIndex = 2
      object Label4: TLabel
        Left = 0
        Top = 0
        Width = 502
        Height = 158
        Align = alClient
        Caption = 
          #13#10'Este projeto '#233' mantido pela comunidade de desenvolvedores do A' +
          'CBr.'#13#10#13#10'Seu uso tem por objetivo fornecer os dados de NF-e utili' +
          'zando busca basedo no layout do site da NF-e. Este site sofre mo' +
          'difica'#231#245'es constantes o que na maioria das vezes faz com que est' +
          'e projeto se torne incompat'#237'vel, portanto n'#227'o h'#225' garantias de co' +
          'ntinuidade e manuten'#231#227'o deste projeto, use-o por conta e risco.'#13 +
          #10#13#10
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
        ExplicitWidth = 342
        ExplicitHeight = 156
      end
      object Label5: TLabel
        Left = 0
        Top = 158
        Width = 502
        Height = 52
        Align = alBottom
        Caption = 
          'OS ARQUIVOS GERADOS POR ESTE PROGRAMA N'#195'O SUBSTITUEM O XML ORIGI' +
          'NAL DA NF-E! Solicite aos fornecedores o envio do xml original, ' +
          'al'#233'm de obrigat'#243'rio, '#233' mais seguro.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
        ExplicitWidth = 341
      end
    end
    object XMLRetorno: TTabSheet
      Caption = 'XML de Retorno'
      ImageIndex = 3
      object Memoxmlretorno: TMemo
        Left = 0
        Top = 0
        Width = 502
        Height = 210
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
  end
  object EdUltimoNsu: TEdit
    Left = 0
    Top = 180
    Width = 100
    Height = 21
    TabOrder = 4
    TextHint = 'Ultimo Nsu'
    Visible = False
  end
  object Edmaximonsu: TEdit
    Left = 407
    Top = 180
    Width = 100
    Height = 21
    TabOrder = 5
    TextHint = 'M'#225'ximo Nsu'
    Visible = False
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 464
    Top = 16
  end
  object ACBrNFe1: TACBrNFe
    Configuracoes.Geral.SSLLib = libWinCrypt
    Configuracoes.Geral.SSLCryptLib = cryWinCrypt
    Configuracoes.Geral.SSLHttpLib = httpWinHttp
    Configuracoes.Geral.SSLXmlSignLib = xsLibXml2
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.TimeOut = 30000
    Configuracoes.WebServices.QuebradeLinha = '|'
    Configuracoes.RespTec.IdCSRT = 0
    Left = 296
    Top = 80
  end
  object ACBrCTe1: TACBrCTe
    Configuracoes.Geral.SSLLib = libNone
    Configuracoes.Geral.SSLCryptLib = cryNone
    Configuracoes.Geral.SSLHttpLib = httpNone
    Configuracoes.Geral.SSLXmlSignLib = xsNone
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.TimeOut = 20000
    Configuracoes.WebServices.QuebradeLinha = '|'
    Configuracoes.RespTec.IdCSRT = 0
    Left = 168
    Top = 72
  end
end

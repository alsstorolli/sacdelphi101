object FBuscaXMLCTe: TFBuscaXMLCTe
  Left = 324
  Top = 168
  BorderStyle = bsDialog
  Caption = 'Busca XML CTe no site nacional'
  ClientHeight = 399
  ClientWidth = 652
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
  object lblStatus: TLabel
    Left = 0
    Top = 158
    Width = 649
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Conectando a SEFA'
    FocusControl = ProgressBar1
    Visible = False
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 176
    Width = 649
    Height = 17
    TabOrder = 0
    Visible = False
  end
  object WebBrowser1: TWebBrowser
    Left = 280
    Top = 8
    Width = 0
    Height = 0
    TabStop = False
    TabOrder = 1
    ControlData = {
      4C00000000000000000000000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E12620A000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 351
    Height = 101
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 225
      Height = 13
      Caption = 'Chave de acesso do Conhecimento Eletr'#244'nico: '
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 169
      Height = 13
      Caption = 'Digite o c'#243'digo da imagem ao lado: '
    end
    object edtChaveNFe: TEdit
      Left = 8
      Top = 24
      Width = 329
      Height = 21
      TabOrder = 0
    end
    object edtCaptcha: TEdit
      Left = 8
      Top = 63
      Width = 73
      Height = 21
      TabOrder = 1
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 104
    Width = 351
    Height = 49
    TabOrder = 3
    object btnNovaConsulta: TButton
      Left = 133
      Top = 14
      Width = 76
      Height = 27
      Caption = 'Nova Consulta'
      Enabled = False
      TabOrder = 0
    end
    object btnGerarXML: TButton
      Left = 270
      Top = 14
      Width = 76
      Height = 27
      Caption = 'Gerar XML'
      Enabled = False
      TabOrder = 1
    end
    object Button1: TButton
      Left = 4
      Top = 14
      Width = 76
      Height = 27
      Caption = 'Salvar XML'
      TabOrder = 2
      OnClick = Button1Click
    end
  end
  object Panel4: TPanel
    Left = 352
    Top = -3
    Width = 297
    Height = 156
    TabOrder = 4
    object Image1: TImage
      Left = 18
      Top = 18
      Width = 262
      Height = 105
      Center = True
    end
    object Label3: TLabel
      Left = 1
      Top = 130
      Width = 291
      Height = 25
      Cursor = crHandPoint
      Alignment = taCenter
      AutoSize = False
      Caption = 'Clique aqui caso n'#227'o consiga visualizar a imagem'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 200
    Width = 649
    Height = 193
    ActivePage = TabSheet3
    TabOrder = 5
    object TabSheet1: TTabSheet
      Caption = 'Dados HTML'
      object Memo2: TMemo
        Left = 0
        Top = 0
        Width = 641
        Height = 165
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
        Width = 641
        Height = 165
        Align = alClient
        TabOrder = 0
        object WBXML: TWebBrowser
          Left = 1
          Top = 1
          Width = 639
          Height = 163
          Align = alClient
          TabOrder = 0
          ControlData = {
            4C0000000B420000D91000000000000000000000000000000000000000000000
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
        Width = 641
        Height = 165
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
      end
    end
  end
end

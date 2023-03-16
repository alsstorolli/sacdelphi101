object FGerenciaWhats: TFGerenciaWhats
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Envio de mensagems/arquivos via Whatsapp'
  ClientHeight = 242
  ClientWidth = 680
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 680
    Height = 242
    Align = alClient
    TabOrder = 0
    object Pmens: TPanel
      Left = 1
      Top = 192
      Width = 678
      Height = 49
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object TInject1: TInject
    InjectJS.AutoUpdateTimeOut = 10
    Config.AutoDelay = 30
    AjustNumber.LengthPhone = 8
    AjustNumber.DDIDefault = 55
    FormQrCodeType = Ft_Http
    Left = 496
    Top = 64
  end
end

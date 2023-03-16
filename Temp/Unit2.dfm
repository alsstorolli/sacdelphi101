object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 289
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 80
    Top = 136
    Width = 23
    Height = 22
    OnClick = SpeedButton1Click
  end
  object Inject1: TInject
    InjectJS.AutoUpdateTimeOut = 10
    Config.AutoDelay = 1000
    AjustNumber.LengthPhone = 8
    AjustNumber.DDIDefault = 55
    FormQrCodeType = Ft_Http
    Left = 216
    Top = 56
  end
end

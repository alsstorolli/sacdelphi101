object Form1: TForm1
  Left = 262
  Top = 131
  Width = 870
  Height = 450
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object PFigura: TSQLPanelGrid
    Left = 744
    Top = -8
    Width = 113
    Height = 416
    Align = alCustom
    Color = clSilver
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Visible = False
    HeightLimite = 0
    WidthLimite = 0
    FixedVisible = False
    object babrir: TSQLBtn
      Left = 21
      Top = 64
      Width = 55
      Height = 22
      Caption = 'Abrir'
      Operation = fbNone
      Processing = False
      AutoAction = True
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object bfechaimagem: TSQLBtn
      Left = 22
      Top = 113
      Width = 55
      Height = 22
      Caption = 'Fechar'
      Operation = fbNone
      Processing = False
      AutoAction = True
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
    object bgravaimagem: TSQLBtn
      Left = 21
      Top = 88
      Width = 55
      Height = 22
      Caption = 'Gravar'
      Operation = fbNone
      Processing = False
      AutoAction = True
      GlyphSqlEnv = True
      IntervalRepeat = 0
      DownUp = False
    end
  end
end

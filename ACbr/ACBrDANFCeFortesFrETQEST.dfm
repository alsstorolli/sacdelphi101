object frmACBrDANFCeFortesFrETQEST: TfrmACBrDANFCeFortesFrETQEST
  Left = 358
  Top = 34
  Margins.Right = 0
  Margins.Bottom = 0
  Caption = 'frmACBrDANFCeFortesFrETQEST'
  ClientHeight = 591
  ClientWidth = 708
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object rlReportA4: TRLReport
    Left = 92
    Top = 39
    Width = 378
    Height = 113
    Margins.LeftMargin = 0.000000000000000000
    Margins.TopMargin = 0.000000000000000000
    Margins.RightMargin = 0.000000000000000000
    Margins.BottomMargin = 0.000000000000000000
    AdjustableMargins = True
    Borders.Style = bsClear
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    PageSetup.PaperSize = fpCustom
    PageSetup.PaperWidth = 100.000000000000000000
    PageSetup.PaperHeight = 30.000000000000000000
    object labelFibraalimentar: TRLLabel
      Left = 9
      Top = 360
      Width = 60
      Height = 14
      AutoSize = False
      Caption = 'Fibra Alimentar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -8
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Layout = tlCenter
      ParentFont = False
      BeforePrint = labelFibraalimentarBeforePrint
    end
    object labelfibra: TRLLabel
      Left = 70
      Top = 360
      Width = 30
      Height = 12
      AutoSize = False
      Caption = 'valorfibra'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -8
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Layout = tlBottom
      ParentFont = False
      BeforePrint = labelfibraBeforePrint
    end
    object labelsodio: TRLLabel
      Left = 9
      Top = 374
      Width = 56
      Height = 10
      AutoSize = False
      Caption = 'S'#243'dio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -8
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Layout = tlCenter
      ParentFont = False
      BeforePrint = labelsodioBeforePrint
    end
    object valorsodio: TRLLabel
      Left = 68
      Top = 371
      Width = 30
      Height = 12
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -8
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Layout = tlBottom
      ParentFont = False
      BeforePrint = valorsodioBeforePrint
    end
    object rlnomeproduto: TRLLabel
      Left = 117
      Top = 26
      Width = 156
      Height = 26
      Alignment = taCenter
      Caption = 'Nome Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -24
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      Layout = tlCenter
      ParentFont = False
      BeforePrint = rlnomeprodutoBeforePrint
    end
    object rlprecovenda: TRLLabel
      Left = 85
      Top = 59
      Width = 184
      Height = 30
      Alignment = taCenter
      Caption = 'Preco de venda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Layout = tlCenter
      ParentFont = False
      BeforePrint = rlprecovendaBeforePrint
    end
    object rlpercgordurastotais: TRLLabel
      Left = 98
      Top = 337
      Width = 30
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -8
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Layout = tlBottom
      ParentFont = False
      BeforePrint = rlpercgordurastotaisBeforePrint
    end
    object rlpercfibraalimentar: TRLLabel
      Left = 98
      Top = 361
      Width = 30
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -8
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Layout = tlBottom
      ParentFont = False
      BeforePrint = rlpercfibraalimentarBeforePrint
    end
    object rlpercsodio: TRLLabel
      Left = 98
      Top = 372
      Width = 30
      Height = 11
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -8
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Layout = tlBottom
      ParentFont = False
      BeforePrint = rlpercsodioBeforePrint
    end
    object rlgordsaturadas: TRLLabel
      Left = 98
      Top = 348
      Width = 30
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -8
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Layout = tlBottom
      ParentFont = False
      BeforePrint = rlgordsaturadasBeforePrint
    end
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 'Storolli e Cia Ltda'
    DisplayName = 'Documento PDF'
    Left = 132
    Top = 207
  end
  object RLHTMLFilter1: TRLHTMLFilter
    DocumentStyle = dsCSS2
    DisplayName = 'HTML'
    Left = 220
    Top = 215
  end
end

object frmACBrDANFCeFortesFrETQdes: TfrmACBrDANFCeFortesFrETQdes
  Left = 500
  Top = 134
  Caption = 'frmACBrDANFCeFortesFrETQdes'
  ClientHeight = 483
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
    Left = 1
    Top = 2
    Width = 302
    Height = 416
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
    PageSetup.Orientation = poLandscape
    PageSetup.PaperWidth = 110.000000000000000000
    PageSetup.PaperHeight = 80.000000000000000000
    AfterPrint = rlReportA4AfterPrint
    OnDataRecord = rlReportA4DataRecord
    object RLBand1: TRLBand
      Left = 15
      Top = 11
      Width = 272
      Height = 275
      AutoExpand = False
      BandType = btTitle
      object RLBarcode1: TRLBarcode
        Left = 10
        Top = 69
        Width = 209
        Height = 39
        Margins.LeftMargin = 1.000000000000000000
        Margins.RightMargin = 1.000000000000000000
        AutoSize = False
        BarcodeType = bcCode128C
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Module = 2
        ParentFont = False
        ShowText = boCode
        BeforePrint = RLBarcode1BeforePrint
      end
      object RNomeFantasia: TRLLabel
        Left = 3
        Top = 27
        Width = 100
        Height = 15
        Caption = 'RCarneResfriada'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        BeforePrint = RNomeFantasiaBeforePrint
      end
      object RCodigo: TRLLabel
        Left = 3
        Top = 149
        Width = 53
        Height = 16
        Layout = tlJustify
        BeforePrint = RCodigoBeforePrint
      end
      object RTara: TRLLabel
        Left = 3
        Top = 215
        Width = 38
        Height = 16
        BeforePrint = RTaraBeforePrint
      end
      object RDescricaoProduto: TRLLabel
        Left = 3
        Top = 44
        Width = 187
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        BeforePrint = RDescricaoProdutoBeforePrint
      end
      object RPeso: TRLLabel
        Left = 154
        Top = 117
        Width = 65
        Height = 22
        Alignment = taRightJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        BeforePrint = RPesoBeforePrint
      end
      object RLpecas: TRLLabel
        Left = 3
        Top = 237
        Width = 91
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        BeforePrint = RLpecasBeforePrint
      end
      object RLLabel1: TRLLabel
        Left = 3
        Top = 193
        Width = 38
        Height = 16
        BeforePrint = RLLabel1BeforePrint
      end
      object RLLabel2: TRLLabel
        Left = 3
        Top = 4
        Width = 64
        Height = 16
        Alignment = taJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        BeforePrint = RLLabel2BeforePrint
      end
      object RLLabel3: TRLLabel
        Left = 3
        Top = 171
        Width = 38
        Height = 16
        BeforePrint = RLLabel3BeforePrint
      end
    end
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 'Projeto ACBr'
    DisplayName = 'Documento PDF'
    Left = 818
    Top = 79
  end
  object RLHTMLFilter1: TRLHTMLFilter
    DocumentStyle = dsCSS2
    DisplayName = 'HTML'
    Left = 821
    Top = 131
  end
end

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
    Left = 0
    Top = 2
    Width = 280
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
    PageSetup.PaperHeight = 74.000000000000000000
    AfterPrint = rlReportA4AfterPrint
    OnDataRecord = rlReportA4DataRecord
    object RLBand1: TRLBand
      Left = 15
      Top = 11
      Width = 250
      Height = 275
      AutoExpand = False
      BandType = btTitle
      object RLBarcode1: TRLBarcode
        Left = 21
        Top = 153
        Width = 209
        Height = 44
        Margins.LeftMargin = 1.000000000000000000
        Margins.RightMargin = 1.000000000000000000
        AutoSize = False
        BarcodeType = bcCode128C
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Font.Quality = fqDraft
        Module = 2
        ParentFont = False
        ShowText = boCode
      end
      object RNomeFantasia: TRLLabel
        Left = 6
        Top = 27
        Width = 104
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        BeforePrint = RNomeFantasiaBeforePrint
      end
      object RLote: TRLLabel
        Left = 6
        Top = 44
        Width = 143
        Height = 16
        BeforePrint = RLoteBeforePrint
      end
      object REndereco: TRLLabel
        Left = 3
        Top = 89
        Width = 199
        Height = 16
        BeforePrint = REnderecoBeforePrint
      end
      object RDescricaoProduto: TRLLabel
        Left = 3
        Top = 66
        Width = 125
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        BeforePrint = RDescricaoProdutoBeforePrint
      end
      object RPeso: TRLLabel
        Left = 175
        Top = 24
        Width = 55
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        BeforePrint = RPesoBeforePrint
      end
      object RLpecas: TRLLabel
        Left = 175
        Top = 64
        Width = 72
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        BeforePrint = RLpecasBeforePrint
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
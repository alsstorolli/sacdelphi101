object FImpressaoOP: TFImpressaoOP
  Left = 0
  Top = 0
  Caption = 'FImpressaoOP'
  ClientHeight = 451
  ClientWidth = 844
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RLReport1: TRLReport
    Left = 32
    Top = 32
    Width = 794
    Height = 1123
    Margins.LeftMargin = 5.000000000000000000
    Margins.RightMargin = 5.000000000000000000
    DataSource = ds
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    BeforePrint = RLReport1BeforePrint
    object RLBand1: TRLBand
      Left = 19
      Top = 38
      Width = 756
      Height = 67
      BandType = btHeader
      Borders.Sides = sdAll
      Borders.Style = bsBDiagonal
      object RLLabel1: TRLLabel
        Left = 1
        Top = 1
        Width = 31
        Height = 16
        Align = faLeftTop
        Caption = 'SAC'
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 278
        Top = 1
        Width = 199
        Height = 19
        Align = faCenterTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Info = itTitle
        ParentFont = False
        Text = 'Ordem de Produ'#231#227'o'
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 616
        Top = 1
        Width = 139
        Height = 16
        Align = faRightTop
        Info = itPageNumber
        Text = 'P'#225'gina : '
      end
      object rlProdutoAcabado: TRLDBText
        Left = 1
        Top = 50
        Width = 107
        Height = 16
        Align = faLeftBottom
        Text = ''
        BeforePrint = rlProdutoAcabadoBeforePrint
      end
      object rlnomecliente: TRLDBText
        Left = 674
        Top = 50
        Width = 81
        Height = 16
        Align = faRightBottom
        Text = ''
        BeforePrint = RLnomeclienteBeforePrint
      end
      object rlpecas: TRLDBText
        Left = 204
        Top = 50
        Width = 46
        Height = 16
        Align = faBottomOnly
        Text = ''
        BeforePrint = rlpecasBeforePrint
      end
      object RLLabel7: TRLLabel
        Left = 151
        Top = 50
        Width = 49
        Height = 16
        Align = faBottomOnly
        Caption = 'Pe'#231'as :'
      end
      object lbqtde: TRLLabel
        Left = 274
        Top = 50
        Width = 33
        Height = 16
        Align = faBottomOnly
        Caption = 'Kilos'
      end
      object rlqtde: TRLDBText
        Left = 313
        Top = 50
        Width = 36
        Height = 16
        Align = faBottomOnly
        Text = ''
        BeforePrint = rlqtdeBeforePrint
      end
      object rldataop: TRLDBText
        Left = 410
        Top = 50
        Width = 50
        Height = 16
        Align = faBottomOnly
        Text = ''
        BeforePrint = rldataopBeforePrint
      end
      object rlcodigoacabado: TRLLabel
        Left = 63
        Top = 29
        Width = 133
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        BeforePrint = rlcodigoacabadoBeforePrint
      end
      object rlreferencia: TRLLabel
        Left = 323
        Top = 29
        Width = 90
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        BeforePrint = rlreferenciaBeforePrint
      end
      object RLLabel9: TRLLabel
        Left = 4
        Top = 29
        Width = 56
        Height = 16
        Caption = 'Codigo : '
      end
      object RLLabel10: TRLLabel
        Left = 275
        Top = 29
        Width = 44
        Height = 16
        Caption = 'Lacre :'
      end
    end
    object RLBand2: TRLBand
      Left = 19
      Top = 105
      Width = 756
      Height = 56
      BandType = btTitle
      object rldescricaoproduto: TRLLabel
        Left = 227
        Top = 37
        Width = 100
        Height = 16
        Caption = 'Descri'#231#227'o do Produto'
      end
      object RLnomeprocesso: TRLLabel
        Left = 72
        Top = 34
        Width = 66
        Height = 16
        Caption = 'Processos'
      end
      object RLLabel2: TRLLabel
        Left = 393
        Top = 35
        Width = 31
        Height = 16
        Caption = 'Nivel'
      end
      object RLLabel3: TRLLabel
        Left = 514
        Top = 36
        Width = 73
        Height = 16
        Caption = 'Quantidade'
      end
      object RLLabel4: TRLLabel
        Left = 474
        Top = 35
        Width = 16
        Height = 16
        Caption = '%'
      end
      object RLLabel5: TRLLabel
        Left = 600
        Top = 37
        Width = 39
        Height = 16
        Caption = 'Graus'
      end
      object RLLabel6: TRLLabel
        Left = 651
        Top = 37
        Width = 29
        Height = 16
        Caption = 'Min.'
      end
      object RLLabel8: TRLLabel
        Left = 685
        Top = 37
        Width = 64
        Height = 16
        Caption = 'Ass.Func.'
      end
    end
    object RLBand3: TRLBand
      Left = 19
      Top = 213
      Width = 756
      Height = 48
      BandType = btFooter
      object RLSystemInfo3: TRLSystemInfo
        Left = 682
        Top = 0
        Width = 74
        Height = 16
        Align = faRightTop
        Text = 'Data :'
      end
      object RLSystemInfo4: TRLSystemInfo
        Left = 604
        Top = 0
        Width = 78
        Height = 16
        Align = faRightTop
        Info = itHour
        Text = 'Hora : '
      end
    end
    object RLBand4: TRLBand
      Left = 19
      Top = 161
      Width = 756
      Height = 32
      Borders.Sides = sdAll
      object Ordem: TRLDBText
        Left = 14
        Top = 1
        Width = 48
        Height = 16
        Align = faTopOnly
        DataField = 'cust_ordem'
        DataSource = ds
        Text = ''
        BeforePrint = OrdemBeforePrint
      end
      object nomeprocesso: TRLDBText
        Left = 68
        Top = 1
        Width = 99
        Height = 16
        Align = faTopOnly
        DataField = 'cadm_descricao'
        DataSource = ds
        Text = ''
      end
      object Nivel: TRLDBText
        Left = 393
        Top = 1
        Width = 68
        Height = 16
        Align = faTopOnly
        DataField = 'cadm_nivel'
        DataSource = ds
        Text = ''
      end
      object descricaoproduto: TRLDBText
        Left = 227
        Top = 1
        Width = 92
        Height = 16
        Align = faTopOnly
        DataField = 'esto_descricao'
        DataSource = ds
        Text = ''
      end
      object RLDBText1: TRLDBText
        Left = 474
        Top = 1
        Width = 79
        Height = 16
        Align = faTopOnly
        DataField = 'cust_perqtde'
        DataSource = ds
        DisplayMask = '##0.00'
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 535
        Top = 1
        Width = 119
        Height = 16
        Align = faTopOnly
        DataFormula = 'cust_perqtde*kilos'
        DataSource = ds
        Text = ''
        BeforePrint = RLDBText2BeforePrint
      end
      object RLDBText3: TRLDBText
        Left = 600
        Top = 1
        Width = 112
        Height = 16
        Align = faTopOnly
        DataField = 'cadm_temperatura'
        DataSource = ds
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 656
        Top = 1
        Width = 79
        Height = 16
        Align = faTopOnly
        DataField = 'cadm_tempo'
        DataSource = ds
        Text = ''
      end
    end
    object BandTotais: TRLBand
      Left = 19
      Top = 193
      Width = 756
      Height = 20
      HelpType = htKeyword
      BandType = btSummary
      Degrade.Direction = ddHorizontal
      Degrade.OppositeColor = clSilver
      object totaltempo: TRLDBResult
        Left = 551
        Top = 0
        Width = 201
        Height = 16
        DataField = 'cadm_tempo'
        DataSource = ds
        DisplayMask = '#####'
        Info = riSum
        ResetAfterPrint = True
        Text = 'Tempo Total : '
        OnCompute = totaltempoCompute
      end
    end
  end
  object ds: TDataSource
    DataSet = Arq.Q
    Left = 192
    Top = 8
  end
  object RLExpressionParser1: TRLExpressionParser
    Options = []
    Left = 288
  end
end

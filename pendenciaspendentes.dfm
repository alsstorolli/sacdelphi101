object FPendenciasPendentes: TFPendenciasPendentes
  Left = 365
  Top = 150
  Caption = 'Checagem de Pagamentos Pendentes'
  ClientHeight = 515
  ClientWidth = 698
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object SQLPanelGrid1: TSQLPanelGrid
    Left = 0
    Top = 0
    Width = 698
    Height = 515
    Align = alClient
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
    object pbotoes: TSQLPanelGrid
      Left = 601
      Top = 1
      Width = 96
      Height = 486
      Align = alRight
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
        Width = 94
        Height = 484
        Align = alClient
        AutoBounds = False
        BoundLines = []
        SubCaption.Ellipsis = False
        SubCaption.Style = []
      end
      object bSair: TSQLBtn
        Left = 1
        Top = 60
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
        Spacing = 2
        Operation = fbExit
        Processing = False
        AutoAction = True
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bimpressao: TSQLBtn
        Left = 1
        Top = 3
        Width = 95
        Height = 27
        Hint = 'Baixa de pendencias'
        Caption = '&Baixa'
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
        Spacing = 2
        OnClick = bimpressaoClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
      object bemail: TSQLBtn
        Left = 1
        Top = 31
        Width = 95
        Height = 25
        Hint = 'Envia email de lembrete cobran'#231'a'
        Caption = '&Email'
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
        Spacing = 2
        OnClick = bemailClick
        Operation = fbNone
        Processing = False
        AutoAction = False
        GlyphSqlEnv = True
        IntervalRepeat = 0
        DownUp = False
      end
    end
    object PMens: TSQLPanelGrid
      Left = 1
      Top = 487
      Width = 696
      Height = 27
      Align = alBottom
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
    end
    object SQLPanelGrid3: TSQLPanelGrid
      Left = 1
      Top = 1
      Width = 600
      Height = 486
      Align = alClient
      Caption = 'SQLPanelGrid3'
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
      object SQLPanelGrid4: TSQLPanelGrid
        Left = 1
        Top = 1
        Width = 598
        Height = 484
        Align = alClient
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
        object PInicial: TSQLPanelGrid
          Left = 1
          Top = 1
          Width = 596
          Height = 347
          Align = alClient
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
          HeightLimite = 0
          WidthLimite = 0
          FixedVisible = False
          object Grid: TSqlDtGrid
            Left = 1
            Top = 1
            Width = 594
            Height = 345
            Align = alClient
            ColCount = 7
            DefaultRowHeight = 15
            FixedCols = 0
            RowCount = 2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
            ParentFont = False
            TabOrder = 0
            OnDrawCell = GridDrawCell
            Columns = <
              item
                Title.Caption = 'Vencimento'
                WidthColumn = 70
                FieldName = 'pend_datavcto'
              end
              item
                Title.Caption = 'Documento'
                WidthColumn = 70
                FieldName = 'pend_numerodcto'
              end
              item
                Title.Caption = 'Codigo'
                WidthColumn = 60
                FieldName = 'pend_tipo_codigo'
              end
              item
                Alignment = taCenter
                Title.Alignment = taCenter
                Title.Caption = 'Raz'#227'o Social'
                WidthColumn = 180
                FieldName = 'razaosocial'
              end
              item
                Title.Alignment = taCenter
                Title.Caption = 'Parcela'
                WidthColumn = 55
                FieldName = 'pend_parcela'
              end
              item
                Alignment = taRightJustify
                Title.Alignment = taCenter
                Title.Caption = 'Valor'
                WidthColumn = 90
                FieldName = 'pend_valor'
              end
              item
                Alignment = taCenter
                Title.Alignment = taCenter
                Title.Caption = 'Atraso'
                WidthColumn = 50
                FieldName = 'atraso'
              end>
            RowCountMin = 1
            SelectedIndex = 0
            Version = '2.0'
            PermitePesquisa = True
            ColWidths = (
              70
              70
              60
              180
              55
              90
              50)
          end
        end
        object PIns: TSQLPanelGrid
          Left = 1
          Top = 348
          Width = 596
          Height = 135
          Align = alBottom
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          Visible = False
          HeightLimite = 0
          WidthLimite = 0
          FixedVisible = False
          object GridCheques: TSqlDtGrid
            Left = 1
            Top = 28
            Width = 594
            Height = 107
            Align = alCustom
            ColCount = 6
            DefaultRowHeight = 15
            FixedCols = 0
            RowCount = 2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
            ParentFont = False
            TabOrder = 0
            Columns = <
              item
                Title.Caption = 'Vencimento'
                WidthColumn = 70
                FieldName = 'pend_datavcto'
              end
              item
                Title.Caption = 'Documento'
                WidthColumn = 70
                FieldName = 'pend_numerodcto'
              end
              item
                Title.Caption = 'Codigo'
                WidthColumn = 60
                FieldName = 'pend_tipo_codigo'
              end
              item
                Alignment = taCenter
                Title.Alignment = taCenter
                Title.Caption = 'Raz'#227'o Social'
                WidthColumn = 180
                FieldName = 'razaosocial'
              end
              item
                Title.Alignment = taCenter
                Title.Caption = 'Parcela'
                WidthColumn = 55
                FieldName = 'pend_parcela'
              end
              item
                Alignment = taRightJustify
                Title.Alignment = taCenter
                Title.Caption = 'Valor'
                WidthColumn = 90
                FieldName = 'pend_valor'
              end>
            RowCountMin = 1
            SelectedIndex = 0
            Version = '2.0'
            PermitePesquisa = True
            ColWidths = (
              70
              70
              60
              180
              55
              90)
          end
          object SQLPanelGrid2: TSQLPanelGrid
            Left = 1
            Top = 1
            Width = 594
            Height = 28
            Align = alTop
            Caption = 'Lembrete de Cheques Emitidos Compensados ou N'#227'o'
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 1
            HeightLimite = 0
            WidthLimite = 0
            FixedVisible = False
          end
        end
      end
    end
  end
end

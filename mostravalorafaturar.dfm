object FValoraFaturar: TFValoraFaturar
  Left = 424
  Top = 272
  BorderStyle = bsDialog
  Caption = 'Valor Estimado de Faturamento'
  ClientHeight = 190
  ClientWidth = 441
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clYellow
  Font.Height = -16
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 20
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 441
    Height = 190
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    object Grid: TSqlDtGrid
      Left = 1
      Top = 1
      Width = 439
      Height = 188
      Align = alClient
      ColCount = 2
      DefaultRowHeight = 40
      FixedCols = 0
      RowCount = 4
      FixedRows = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
      ParentFont = False
      TabOrder = 0
      Columns = <
        item
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -27
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          WidthColumn = 200
          FieldName = 'desc'
        end
        item
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -27
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          WidthColumn = 250
          FieldName = 'valor'
        end>
      RowCountMin = 0
      SelectedIndex = 0
      Version = '2.0'
      PermitePesquisa = True
      ColWidths = (
        200
        250)
      RowHeights = (
        40
        40
        40
        40)
    end
  end
end

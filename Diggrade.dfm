object FGrade: TFGrade
  Left = 327
  Top = 245
  BorderStyle = bsDialog
  Caption = 'Grade do Produto'
  ClientHeight = 303
  ClientWidth = 476
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
  object SQLPanelGrid1: TSQLPanelGrid
    Left = 0
    Top = 0
    Width = 476
    Height = 303
    Align = alClient
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    HeightLimite = 0
    WidthLimite = 0
    FixedVisible = False
    object PGrade: TSQLPanelGrid
      Left = 1
      Top = 0
      Width = 474
      Height = 302
      Align = alBottom
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      HeightLimite = 0
      WidthLimite = 0
      FixedVisible = False
      object GridGrade: TSqlDtGrid
        Left = 1
        Top = 1
        Width = 472
        Height = 300
        Align = alClient
        ColCount = 10
        DefaultColWidth = 45
        DefaultRowHeight = 20
        RowCount = 10
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
        TabOrder = 0
        Visible = False
        Columns = <
          item
            WidthColumn = 64
          end
          item
            WidthColumn = 64
          end
          item
            WidthColumn = 64
          end
          item
            WidthColumn = 64
          end
          item
            WidthColumn = 64
          end
          item
            WidthColumn = 64
          end
          item
            WidthColumn = 64
          end
          item
            WidthColumn = 64
          end
          item
            WidthColumn = 64
          end
          item
            WidthColumn = 64
          end>
        RowCountMin = 0
        SelectedIndex = 1
        Version = '2.0'
        RowHeights = (
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20)
      end
    end
  end
end

object FListaFiguras: TFListaFiguras
  Left = 247
  Top = 90
  BorderStyle = bsDialog
  Caption = 'Lista de Pre'#231'o'
  ClientHeight = 560
  ClientWidth = 862
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object APHeadLabel1: TAPHeadLabel
    Left = 737
    Top = 0
    Width = 125
    Height = 560
    Align = alClient
    AutoBounds = False
    BoundLines = []
    Gradient.EndColor = clGray
    Gradient.StartColor = clSilver
    SubCaption.Ellipsis = False
    SubCaption.Style = []
  end
  object bexecutar: TSQLBtn
    Left = 752
    Top = 16
    Width = 89
    Height = 25
    Caption = 'Executar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = bexecutarClick
    Operation = fbNone
    Processing = False
    AutoAction = False
    GlyphSqlEnv = True
    IntervalRepeat = 0
    DownUp = False
  end
  object bimprimir: TSQLBtn
    Left = 752
    Top = 64
    Width = 89
    Height = 25
    Caption = 'Imprimir'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = bimprimirClick
    Operation = fbNone
    Processing = False
    AutoAction = False
    GlyphSqlEnv = True
    IntervalRepeat = 0
    DownUp = False
  end
  object SQLPanelGrid1: TSQLPanelGrid
    Left = 0
    Top = 0
    Width = 737
    Height = 560
    Align = alLeft
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
    object dbg: TSQLGrid
      Left = -7
      Top = 400
      Width = 735
      Height = 135
      Align = alCustom
      Color = clWhite
      DataSource = ds
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      OnDrawColumnCell = DBGDrawColumnCell
      ColumnInitial = 0
      Reduce = 0
      Columns = <
        item
          Expanded = False
          FieldName = 'esto_codigo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'esto_descricao'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'esto_imagem'
          Width = 226
          Visible = True
        end>
    end
    object dbg2: TSqlDtGrid
      Left = 0
      Top = 8
      Width = 721
      Height = 377
      ColCount = 3
      DefaultRowHeight = 120
      FixedCols = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
      TabOrder = 1
      OnDrawCell = dbg2DrawCell
      Columns = <
        item
          WidthColumn = 75
          FieldName = 'esto_codigo'
        end
        item
          WidthColumn = 150
          FieldName = 'esto_descricao'
        end
        item
          Title.Caption = 'Imagem'
          WidthColumn = 300
          FieldName = 'esto_imagem'
        end>
      RowCountMin = 0
      SelectedIndex = 0
      Version = '2.0'
      ColWidths = (
        75
        150
        217)
    end
  end
  object SQLPanelGrid2: TSQLPanelGrid
    Left = 603
    Top = 153
    Width = 256
    Height = 72
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    HeightLimite = 0
    WidthLimite = 0
    FixedVisible = False
    object ComboBox1: TComboBox
      Left = 7
      Top = 32
      Width = 240
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
    object StaticText1: TStaticText
      Left = 8
      Top = 11
      Width = 90
      Height = 20
      Caption = 'Impressoras'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
  end
  object Ds1: TDataSource
    Left = 264
    Top = 64
  end
  object ds: TDataSource
    DataSet = Arq.TEstoque
    Left = 136
    Top = 128
  end
  object Pd: TPrintDialog
    Left = 776
    Top = 120
  end
end

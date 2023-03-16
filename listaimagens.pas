unit listaimagens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, alabel, ExtCtrls, SQLGrid, Buttons, SQLBtn,
  DBGrids, DB, DBClient, SimpleDS, SqlSis, SqlDtg, SqlExpr;

type
  TFListaFiguras = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bexecutar: TSQLBtn;
    dbg: TSQLGrid;
    Ds1: TDataSource;
    ds: TDataSource;
    dbg2: TSqlDtGrid;
    bimprimir: TSQLBtn;
    SQLPanelGrid2: TSQLPanelGrid;
    ComboBox1: TComboBox;
    StaticText1: TStaticText;
    Pd: TPrintDialog;
    procedure bexecutarClick(Sender: TObject);
    procedure dbg2DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dbgDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormActivate(Sender: TObject);
    procedure bimprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FListaFiguras: TFListaFiguras;
  TFiguras:TSqlquery;

implementation

uses Arquiv, SqlFun, Jpeg, Printers, SQLRel;

{$R *.dfm}

procedure TFListaFiguras.bexecutarClick(Sender: TObject);
var p:integer;
begin
//{
//  if not Arq.TFiguras.Active then Arq.TFiguras.Open;
//  if not Arq.TFiguras1.Active then Arq.TFiguras1.Open;
  TFiguras:=sqltoquery('select esto_codigo,esto_descricao,esto_imagem from estoque'+
                ' order by esto_codigo');
//  dbg2.QueryToGrid(TFiguras);
  p:=1;
  dbg2.clear;
  while not TFiguras.eof do begin
    dbg2.Cells[0,p]:=TFiguras.fieldbyname('esto_codigo').asstring;
    dbg2.Cells[1,p]:=TFiguras.fieldbyname('esto_descricao').asstring;
    dbg2.Cells[2,p]:=TFiguras.fieldbyname('esto_imagem').asstring;
    inc(p);
    dbg2.AppendRow;
    Tfiguras.Next;
  end;
//}

end;

{
procedure TFListaFiguras.DBGDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);

var
  Bmp: TBitmap;
  s:String;
  Buf:Array[1..2] of Char;
  i:Integer;
  Str:TMemoryStream;

begin
  if (not (gdFixed in State)) and
     (UpperCase(Column.FieldName) = 'ESTO_IMAGEM') then
  begin
//    if Arq.TFiguras.FieldByName('ESTO_IMAGEM').AsString<>'' then begin
      s:=Arq.TFiguras.FieldByName('ESTO_IMAGEM').AsString;
      Bmp := TBitmap.Create;
      Str := TMemoryStream.Create;
      Str.Clear;
      Str.Position:=0;
      for i:=1 to Length(s) do begin
          if i mod 2 = 0 then begin
             Buf[1]:=Chr(HexToInt(s[i-1]+s[i]));
             Str.Write(Buf,1);
          end;
      end;
      Str.Position:=0;
      try
//        Bmp.Assign(Arq.TFiguras.FieldByName('ESTO_IMAGEM'));
        Bmp.LoadFromStream(Str);
        DBG.Canvas.StretchDraw(Rect, Bmp);
      finally
        Bmp.Free;
      end;
//    end;
  end;
end;
}

procedure TFListaFiguras.dbg2DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  Bmp: TBitmap;
  s:String;
  Buf:Array[1..2] of Char;
  i:Integer;
  Str:TMemoryStream;
  Fig:TJPEGImage;

begin

  if TFiguras=nil then exit;
  if TFiguras.SQL.Text='' then exit;
  if (not (gdFixed in State)) and
     ( Dbg2.GetColumn('ESTO_IMAGEM')=Acol ) then
  begin
//     {
//    if TFiguras.FieldByName('ESTO_IMAGEM').AsString<>'' then begin
    if DBg2.Cells[Acol,Arow]<>'' then begin
//      s:=TFiguras.FieldByName('ESTO_IMAGEM').AsString;
      s:=DBg2.Cells[Acol,Arow];
      Bmp := TBitmap.Create;
      Fig := TJPEGImage.Create;
      Str := TMemoryStream.Create;
      Str.Clear;
      Str.Position:=0;
      for i:=1 to Length(s) do begin
          if i mod 2 = 0 then begin
             Buf[1]:=Chr(HexToInt(s[i-1]+s[i]));
             Str.Write(Buf,1);
          end;
      end;
      Str.Position:=0;
      try
//        Bmp.Assign(Arq.TFiguras.FieldByName('ESTO_IMAGEM'));
//        Bmp.LoadFromStream(Str);
        Fig.LoadFromStream(Str);
//        DBG2.Canvas.StretchDraw(Rect, Bmp);
        DBG2.Canvas.StretchDraw(Rect, Fig);
      finally
//        Bmp.Free;
        Fig.Free;
      end;
    end;
//    }
  end;
end;


procedure TFListaFiguras.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
//   Arq.TFiguras.Close;
//   Arq.TFiguras1.Close;
end;

procedure TFListaFiguras.dbgDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  Bmp: TBitmap;
  s:String;
  Buf:Array[1..2] of Char;
  i:Integer;
  Str:TMemoryStream;

begin
{
  if (not (gdFixed in State)) and
     (UpperCase(Column.FieldName) = 'ESTO_IMAGEM') then
  begin
//    if Arq.TFiguras.FieldByName('ESTO_IMAGEM').AsString<>'' then begin
      s:=Arq.TFiguras.FieldByName('ESTO_IMAGEM').AsString;
      Bmp := TBitmap.Create;
      Str := TMemoryStream.Create;
      Str.Clear;
      Str.Position:=0;
      for i:=1 to Length(s) do begin
          if i mod 2 = 0 then begin
             Buf[1]:=Chr(HexToInt(s[i-1]+s[i]));
             Str.Write(Buf,1);
          end;
      end;
      Str.Position:=0;
      try
//        Bmp.Assign(Arq.TFiguras.FieldByName('ESTO_IMAGEM'));
        Bmp.LoadFromStream(Str);
        DBG.Canvas.StretchDraw(Rect, Bmp);
      finally
        Bmp.Free;
      end;
//    end;
  end;
  }
end;

procedure TFListaFiguras.FormActivate(Sender: TObject);
begin
  Combobox1.Items.Assign(Printer.Printers);
  Combobox1.ItemIndex:=Printer.PrinterIndex;

end;

procedure TFListaFiguras.bimprimirClick(Sender: TObject);
var p:integer;
begin
//   if not pd.Execute then exit;
   Printer.PrinterIndex := ComboBox1.ItemIndex;
//   FRel.Init('ImagemEstoque',100);
   FRel.Init('ImagemEstoque');
   FREl.AddCol(080,3,'C','','','Codigo','','',false);
   FREl.AddCol(200,2,'C','','','Imagem','','',false);
   for p:=1 to dbg2.RowCount do begin
     if trim(dbg2.Cells[2,p])<>'' then begin
       FRel.AddCel(dbg2.Cells[0,p]);
       FRel.AddCel(dbg2.Cells[2,p]);
     end;
//     dbg2.Cells[0,p]:=TFiguras.fieldbyname('esto_codigo').asstring;
//     dbg2.Cells[1,p]:=TFiguras.fieldbyname('esto_descricao').asstring;
//     dbg2.Cells[2,p]:=TFiguras.fieldbyname('esto_imagem').asstring;
   end;
   FRel.Video();

//   ACBrNFeDANFERave1.Impressora:=Combobox1.Items.Strings[ComboBox1.ItemIndex];
end;

end.

unit visualizaimp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, alabel, ExtCtrls, SQLGrid, ComCtrls, Buttons, SQLBtn,
  Mask, SQLEd, NicePreview, Sqlfun, OleCtrls, SHDocVw, RLPreview, RLReport,
  RLRichText, RLBarcode, RlTypes;

type
  TFVisualizaImpressao = class(TForm)
    PImagem: TSQLPanelGrid;
    Imagem: TImage;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bImpressaoant: TSQLBtn;
    PrintDlg: TPrintDialog;
    bimprimetexto: TSQLBtn;
    bsair: TSQLBtn;
    Fontes: TFontDialog;
    bfonte: TSQLBtn;
    ComboFontes: TComboBox;
    NP: TNicePreview;
//    wb: TWebBrowser;
//    RLPreview1: TRLPreview;
//    RC: TRichEdit;
//    RLReport1: TRLReport;
//    RLBand1: TRLBand;
//    RLBand2: TRLBand;
//    RTTitulo: TRLRichText;
//    RCFortes: TRLMemo;
//    RLMemoNomeColunas: TRLMemo;
//    RLPagina: TRLLabel;
    procedure bImpressaoantClick(Sender: TObject);
    procedure bimprimetextoClick(Sender: TObject);
    procedure bsairClick(Sender: TObject);
    procedure bfonteClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RLPreview1Click(Sender: TObject);
    procedure RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLReport1NeedData(Sender: TObject; var MoreData: Boolean);
    procedure RCFortesBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLPaginaBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLPaginaAfterPrint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(xImagem:TImage);
    procedure ImprimeTexto(Memo:TRichedit);
// 08.06.15
    procedure ImprimeTextoLista(Texto:TStringList; NomeImpressora:string);
//    procedure Execute(yTexto:TStringList; NomeImpressora:string);
    procedure ImprimeviaWord(xTexto:TStringList; NomeImpressora:string);
    procedure ImprimeviaWordMemo(xTexto:TRichEdit);
    var YCanvas   : TCanvas;

  end;

var
  FVisualizaImpressao: TFVisualizaImpressao;
  xtexto:TStringList;
  LinhasaImprimir,p,npag:integer;

implementation

{$R *.dfm}

uses Printers, Geral, relfinan, ConfDcto, impressao, ComObj, ShellApi,
  SQLRel;

{ TFVisualizaImpressao }

procedure TFVisualizaImpressao.Execute(xImagem:TImage);
//procedure TFVisualizaImpressao.Execute(yTexto:TStringList; NomeImpressora:string);
//////////////////////////////////////////////////////////////////////////////////////
var i,x,y,th,j,h:integer;
    ACanvas: TCanvas;
begin

   xTexto:=TStringList.Create;
//   xTexto.Assign(yTexto);
//   Courier New
//  EdNOmefonte.Text:=Texto.Font.Name;

  ComboFontes.Items.Clear;
//  if Printer.Fonts.IndexOf('Draft 10cpi') >= 0 then begin
  if Printer.Fonts.IndexOf('Draft 12cpi') >= 0 then begin
//    Printer.PrinterIndex:=Printer.Fonts.IndexOf('Draft 12cpi');
    for i:=0 to Printer.Fonts.Count-1 do ComboFontes.Items.Add(Printer.Fonts[i]);
  end;

//  NP.ViewActualSize;

  NP.ViewFitToWidth;

  with NP do
  begin
    th := PageHeight - MarginTop - MarginBottom;
  end;

  i := 0;
  j := -1;
  h := 0;
  ACanvas := nil;
//{
  repeat

    if (j < h) then
    begin
      if (ACanvas <> nil)
        then NP.EndPage;
      ACanvas := NP.BeginPage;
      with ACanvas do
      begin
//        Font.Name := 'Draft 12cpi';
        Font.Name := 'Draft 10cpi';
//        Font.Name := 'Lucida Console';
//        Font.Name := 'Courier';
//        Font.Name := 'Times New Roman';
        Font.Size := 8;
        h := TextHeight('A');
      end;
      j := th;
    end;

    ACanvas.TextOut(NP.MarginLeft, NP.MarginTop + (th - j), xtexto[i]);

    Inc(i);
    Dec(j, h);

  until (i >= xtexto.Count);


  NP.EndPage;

  NP.Assign( xImagem.Canvas );
  NP.PrintPage(0);

//  ImprimeTextoLista(xtexto,Nomeimpressora);


//  BringToFront;
//  Texto:=xTexto;
end;

procedure TFVisualizaImpressao.bImpressaoantClick(Sender: TObject);
//////////////////////////////////////////////////////////////////////////
var  PrintRect,imgRect:TRect;
begin

  PrintDlg.Options := [poPageNums, poSelection];
  PrintDlg.FromPage := 1;
  PrintDlg.MinPage := 1;
  PrintDlg.ToPage := 1;
  PrintDlg.MaxPage := 1;
  if not PrintDlg.Execute then exit;

    with Printer do
    begin
      Printer.Orientation := poPortrait;
      BeginDoc;
      try
//armazena o tamanho do ret�ngulo da tela de impressora
        PrintRect:=rect(Imagem.Left,Imagem.Top,Imagem.Width,Imagem.Height);
//pega o tamanho do ret�ngulo da tela de impressora
        imgrect:=rect(0,0,imagem.width,imagem.height);
        printer.canvas.copyrect(printrect, Imagem.canvas,imgrect);
      finally
        EndDoc;
      end;
    end;

end;

procedure TFVisualizaImpressao.ImprimeTexto(Memo: TRichedit);
////////////////////////////////////////////////////////////////////
const
  cEspacoLinha = 3;   // 5;
  cMargemSuperior = 10;  // 50
  cMargemEsquerda = 10;  // 30
var
  AlturaLinha, Y, I: integer;
  nomefont:string;
begin
  nomefont:='Draft 10cpi';
  Printer.Canvas.Font.Name:=nomefont;
{
  if Printer.Fonts.IndexOf(nomefont) >= 0 then begin
//    showmessage('tem o '+nomefont);
    if trim(ComboFontes.Text)<>'' then
      Printer.Canvas.Font.Name:=ComboFontes.Text
    else
      Printer.Canvas.Font.Name:=nomefont;
//    Printer.Canvas.Font.Name:='Elite';
  end else
    Printer.Canvas.Font.Assign(Memo.Font);
}
  Printer.BeginDoc;
  try
    { Usa na impressora a mesma fonte do memo }
//    if FConfDcto.ETpImpressora.Text='V' then
//    if Printer.Fonts.IndexOf('Draft10')<>-1 then
//      Printer.Canvas.Font.Name:='Draft10';
//    else
//      Printer.Canvas.Font.Assign(Memo.Font);

//    AlturaLinha := Printer.Canvas.TextHeight('Tg');
    AlturaLinha := Printer.Canvas.TextHeight('A');

    Y := cMargemSuperior;
//    if Printer.Fonts.IndexOf('Draft 10cpi') >= 0 then
//      Printer.Canvas.TextOut(cMargemEsquerda, Y, '#15');

     Printer.Canvas.Font.Name:='Draft 12cpi';

    for I := 0 to Memo.Lines.Count -1 do begin

      if Y > Printer.PageHeight then begin
        Printer.NewPage;
        Y := cMargemSuperior;
      end;

      Printer.Canvas.TextOut(cMargemEsquerda, Y, Memo.Lines[I]);

      Y := Y + AlturaLinha + cEspacoLinha;
    end;
  finally
    Printer.EndDoc;
  end;
end;



procedure TFVisualizaImpressao.bimprimetextoClick(Sender: TObject);
///////////////////////////////////////////////////////////////////////////
begin
  if not PrintDlg.Execute then exit;

  NP.PrintAll;

//  if FRelFinan.Active then begin
//  if FRelFinan.Active then
//    FImpressao.ImprimeNotaSaida(FRElFinan.EdNumeroDoc.AsInteger,FRelFinan.EdDtemissao.AsDate,copy(FRelFinan.Edunid_codigo.text,1,3),FRelFinan.EdTipomov.Text)
//  else

end;

procedure TFVisualizaImpressao.bsairClick(Sender: TObject);
begin
   Close;
end;

procedure TFVisualizaImpressao.bfonteClick(Sender: TObject);
/////////////////////////////////////////////////////////////////
var th,i,h,j:integer;
    ACanvas:TCanvas;
begin
  if Fontes.Execute then begin
//    Texto.Font.Name:=Fontes.Font.Name;
//   Courier New
//  EdNOmefonte.Text:=Texto.Font.Name;

    NP.clear;
    with NP do
    begin
      th := PageHeight - MarginTop - MarginBottom;
    end;

    i := 0;
    j := -1;
    h := 0;
    ACanvas := nil;

    repeat

      if (j < h) then
      begin
        if (ACanvas <> nil)
          then NP.EndPage;
        ACanvas := NP.BeginPage;
        with ACanvas do
        begin
          Font.Name := Fontes.Font.Name;
          Font.Size := Fontes.Font.Size;
          h := TextHeight('A');
        end;
        j := th;
      end;

      ACanvas.TextOut(NP.MarginLeft, NP.MarginTop + (th - j), xtexto[i]);

      Inc(i);
      Dec(j, h);

    until (i >= xtexto.Count);//    EdNOmefonte.Text:=Fontes.Font.Name;

    NP.EndPage;
  end;

end;

procedure TFVisualizaImpressao.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  NP.Clear;

end;

// 08.06.15
procedure TFVisualizaImpressao.ImprimeTextoLista(Texto: TStringList; NomeImpressora:string);
////////////////////////////////////////////////////////////////////////////////////////////////
const
  cEspacoLinha = 3;   // 5;
  cMargemSuperior = 10;  // 50
  cMargemEsquerda = 10;  // 30
var
  AlturaLinha, Y, I: integer;
  nomefont:string;
begin
//  nomefont:='Draft 10cpi';
  nomefont:='Draft 12cpi';
//  if  Printer.Printers.IndexOfName(Nomeimpressora) >=0 then
//  Printer.PrinterIndex:= ( Printer.Printers.IndexOfName(Nomeimpressora) );

  FConfdcto.setimpressora( NomeImpressora );
{
  for i:=0 to Printer.Printers.Count-1 do begin
    if pos(Nomeimpressora,Printer.Printers.Names[i])>0 then begin
      Printer.PrinterIndex:=  pos(Nomeimpressora,Printer.Printers.Names[i]);
      break;
    end;
  end;
}
  Printer.BeginDoc;

  PRINTER.CANVAS.Font.Handle := GETSTOCKOBJECT(DEVICE_DEFAULT_FONT);

  Printer.Canvas.Font.Name:=nomefont;
  try
    AlturaLinha := Printer.Canvas.TextHeight('A');
    Y := cMargemSuperior;
    for I := 0 to Texto.Count -1 do begin

      if Y > Printer.PageHeight then begin
        Printer.NewPage;
        Y := cMargemSuperior;
      end;

      Printer.Canvas.TextOut(cMargemEsquerda, Y, SpecialCase(Texto[I]) );

      Y := Y + AlturaLinha + cEspacoLinha;
    end;
  finally
    Printer.EndDoc;
  end;

end;

// 09.06.15
procedure TFVisualizaImpressao.ImprimeviaWord(xTexto: TStringList ; NomeImpressora:string);
//////////////////////////////////////////////////////////////////////////
var
    ArquivoSalvar:olevariant; //local e nome para salvar arquivo
    s,msword:variant; //facilitar trabalho
    back : olevariant;
    linhas,colunas,p:integer;
    xarq:PAnsichar;
begin
/////////////////////////////

        msword := createoleobject('word.application'); //abre aplicativo
        msword.documents.add; //adiciona novo documento
        s := msword.selection; //variavel para facilitar trabalho
//        msword.activewindow.activepane.view.seekview := 10; //habilita o rodap�

        msword.activewindow.activepane.view.seekview := 0; //habilita o texto

        s.Font.Size := 10;    //tamanho de letra
//        s.Font.Name := 'Verdana'; //tipo de letra
//        s.Font.Name := 'Arial';
//        s.Font.Name := 'Times New Roman';
//        s.Font.Name := 'Draft 10cpi'; //tipo de letra
        s.Font.Name := 'Draft 12cpi'; //tipo de letra
//        s.Font.Name := 'Arial'; //tipo de letra
//        s.Font.Bold := True;    //negrito
        s.PageSetup.rightMargin := 50; //margem direita  -  16,30
        s.PageSetup.TopMargin := 5;  //margem superior
        s.PageSetup.leftMargin := 20; //margem esquerda
        s.PageSetup.BottomMargin := 5; //margem abaixo
        for p:=0 to xTexto.count-1 do begin
//          s.typetext( '*'+strspace(xTexto[p],78)+'*' );
          s.typetext(copy(xTexto[p]+space(500),1,146));
//          s.typetext( xTexto[p] );
//          s.typeparagraph;
        end;
        ArquivoSalvar := 'IMP'+inttostr(global.usuario.codigo)+'.DOC';
/////////////////////////////
//         }

//        ArquivoSalvar := 'IMP'+inttostr(global.usuario.codigo)+'.TXT';

//        xTexto.SaveToFile(ArquivoSalvar);
//        MSWORD.ActiveDocument.SaveAs(ArquivoSalvar); //salva sem perguntar

        xarq:=PAnsichar('IMP'+inttostr(global.usuario.codigo)+'.TXT');
      //  ShellExecute(0,'open', xarq ,nil,nil,SW_SHOWNORMAL);
//        WinExec( pchar('NotePad.exe /p '+'IMP'+inttostr(global.usuario.codigo)+'.TXT'),SW_SHOWMINIMIZED);
//        WinExec( pchar('NotePad.exe /pt '+'"IMP'+inttostr(global.usuario.codigo)+'.TXT"'+'"'+nomeimpressora+'"' ),SW_SHOWMINIMIZED);
//        WinExec( pchar('WordPad.exe /pt '+'"IMP'+inttostr(global.usuario.codigo)+'.DOC"'+'"'+nomeimpressora+'"' ),SW_SHOWNORMAL);


//      msword.documents.save; //abre janela para salvar

//       msword.ActiveDocument.PrintOut(false); //imprime direto, sem perguntar

        msword.application.visible :=true; //mantem visivel o documento word
//        msword.ActiveDocument.PrintPreview; //vizualizar impress�o

//      msWord.ActiveDocument.Close(SaveChanges := 0);
//      msword.Quit;


end;

// 09.06.15
procedure TFVisualizaImpressao.ImprimeviaWordMemo(xTexto: TRichEdit);
////////////////////////////////////////////////////////////////////
var
    ArquivoSalvar:olevariant; //local e nome para salvar arquivo
    msword:variant; //facilitar trabalho
    s:TRichEdit;
    back : olevariant;
    linhas,colunas,p:integer;
begin
{
        msword := createoleobject('word.application'); //abre aplicativo
        msword.documents.add; //adiciona novo documento
}
//        s := msword.selection; //variavel para facilitar trabalho
//        msword.activewindow.activepane.view.seekview := 10; //habilita o rodap�

//        msword.activewindow.activepane.view.seekview := 0; //habilita o texto

        s:=TRichEdit.Create( xTexto );
        s.Font.Size := 10;    //tamanho de letra
//        s.Font.Name := 'Verdana'; //tipo de letra
//        s.Font.Name := 'Arial'; //tipo de letra
        s.Font.Name := 'Draft 12cpi'; //tipo de letra
//        s.Font.Bold := True;    //negrito
{
        s.PageSetup.rightMargin := 0; //margem direita  -  16,30
        s.PageSetup.TopMargin := 0;  //margem superior
        s.PageSetup.leftMargin := 0; //margem esquerda
        s.PageSetup.BottomMargin := 0; //margem abaixo
}
//        for p:=0 to xTexto.Lines.count-1 do begin
//          s.typetext( xTexto.Lines.Strings[p] );
//        end;

//        msword.application.visible :=true; //mantem visivel o documento word

        ArquivoSalvar := 'IMP'+inttostr(global.usuario.codigo)+'.DOC';


//        MSWORD.ActiveDocument.SaveAs(arquivosalvar); //salva sem perguntar
//      msword.documents.save; //abre janela para salvar
//      msword.ActiveDocument.PrintOut(false); //imprime direto, sem perguntar
//      msword.ActiveDocument.PrintPreview; //vizualizar impress�o
//      msword.quit;
end;

procedure TFVisualizaImpressao.RLPreview1Click(Sender: TObject);
begin
//    RlReport1.Preview;
end;

procedure TFVisualizaImpressao.RLReport1BeforePrint(Sender: TObject;  var PrintIt: Boolean);
///////////////////////////////////////////////////////////////////////////////////////////////////
var poPortrait,poLandScape: TRLPageOrientation ;
begin
{
  LinhasaImprimir:=RC.Lines.Count;
  p:=0;
  if FREl.Orientacao.ItemIndex=0 then
    RLReport1.PageSetup.Orientation:=poPortrait
  else
    RLReport1.PageSetup.Orientation:=poLandScape;
  RLReport1.PageSetup.PaperSize:=fpA4;
  RLReport1.PageSetup.PaperWidth:=297;
  RLReport1.PageSetup.PaperHeight:=210;
   npag:=1;
}
// para tentar formatarr como esta no rel

//  RLBand2.Width:=FREl.Altura.Value;
//  RLBand2.Height:=FREl.Largura.Value;
//  RLBand2.RealBounds.Width:=FREl.Altura.Value;
//  RLBand2.RealBounds.Height:=FREl.Largura.Value;
//  300 dpi dividido por 2,54    ( ccm por polegada ) = 118
//   RLReport1.PageSetup.PaperWidth:=(FREl.Largura.Value/118)*10;
//   RLReport1.PageSetup.PaperHeight:=(FREl.Altura.Value/118)*10;

end;

procedure TFVisualizaImpressao.RLReport1NeedData(Sender: TObject;
  var MoreData: Boolean);
begin
   inc(p);
//////////////   if P > 70 then RLReport1.NewPage;
   MoreData:=( p <= LinhasaImprimir );
end;

procedure TFVisualizaImpressao.RCFortesBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//   x:=trunc(RLReport1.PageSetup.PaperHeight/2.80999);
//   Text:=copy( RC.Lines.Strings[p],1, 90 );
//   Text:=RC.Lines.Strings[p];
end;

procedure TFVisualizaImpressao.RLPaginaBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
 //  Text:='P�gina : '+ IntToStr(npag);

end;

procedure TFVisualizaImpressao.RLPaginaAfterPrint(Sender: TObject);
begin
//   inc(npag);
end;

end.

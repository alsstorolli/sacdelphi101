unit buscaxmlcte;

interface

uses
  GifImage ,UrlMon, MSHtml, ACBrUtil, pcnAuxiliar,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw, ExtCtrls, ComCtrls, WinInet, Menus,
  Geral;

type
  TFBuscaXMLCTe = class(TForm)
    lblStatus: TLabel;
    ProgressBar1: TProgressBar;
    WebBrowser1: TWebBrowser;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtChaveNFe: TEdit;
    edtCaptcha: TEdit;
    Panel3: TPanel;
    btnNovaConsulta: TButton;
    btnGerarXML: TButton;
    Button1: TButton;
    Panel4: TPanel;
    Image1: TImage;
    Label3: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Memo2: TMemo;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    WBXML: TWebBrowser;
    TabSheet3: TTabSheet;
    Label4: TLabel;
    procedure btnPegarHTMLClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure WebBrowser1DocumentComplete(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure WebBrowser1ProgressChange(Sender: TObject; Progress,
      ProgressMax: Integer);
    procedure btnNovaConsultaClick(Sender: TObject);
    procedure btnGerarXMLClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
    function DownloadFile(SourceFile, DestFile: string): Boolean;
    function StripHTML(S: string): string;
    procedure DeleteIECache;
    procedure PegarHTML;
    procedure GeraXml;
    procedure NovaConsulta;

  public
    { Public declarations }
    FPath: string;
    procedure Execute;

  end;

var
  FBuscaXmlCTe: TFBuscaXmlCTe;

implementation

uses ACBrHTMLtoXML, nfcompra;

{$R *.dfm}


procedure TFBuscaXmlCte.DeleteIECache;
var
  lpEntryInfo: PInternetCacheEntryInfo;
  hCacheDir: LongWord;
  dwEntrySize: LongWord;
begin { DeleteIECache }
  dwEntrySize := 0;

  FindFirstUrlCacheEntry(nil, TInternetCacheEntryInfo(nil^), dwEntrySize);

  GetMem(lpEntryInfo, dwEntrySize);

  if dwEntrySize>0 then
    lpEntryInfo^.dwStructSize := dwEntrySize;

  hCacheDir := FindFirstUrlCacheEntry(nil, lpEntryInfo^, dwEntrySize);

  if hCacheDir<>0 then
  begin
    repeat
      DeleteUrlCacheEntry(lpEntryInfo^.lpszSourceUrlName);
      FreeMem(lpEntryInfo, dwEntrySize);
      dwEntrySize := 0;
      FindNextUrlCacheEntry(hCacheDir, TInternetCacheEntryInfo(nil^), dwEntrySize);
      GetMem(lpEntryInfo, dwEntrySize);
      if dwEntrySize>0 then
        lpEntryInfo^.dwStructSize := dwEntrySize;
    until not FindNextUrlCacheEntry(hCacheDir, lpEntryInfo^, dwEntrySize)
  end; { hCacheDir<>0 }
  FreeMem(lpEntryInfo, dwEntrySize);

  FindCloseUrlCache(hCacheDir)
end; { DeleteIECache }


function TFBuscaXmlCTe.DownloadFile(SourceFile, DestFile: string): Boolean;
const BufferSize = 1024;
var
  hSession, hURL: HInternet;
  Buffer: array[1..BufferSize] of Byte;
  BufferLen: DWORD;
  f: File;
  sAppName: string;
begin
 sAppName := ExtractFileName(Application.ExeName);
 hSession := InternetOpen(PChar(sAppName),INTERNET_OPEN_TYPE_PRECONFIG,nil, nil, 0);
 try
   hURL := InternetOpenURL(hSession,PChar(SourceFile),nil,0,0,0);
   try
     AssignFile(f, DestFile);
     Rewrite(f,1);
     repeat
       InternetReadFile(hURL, @Buffer,SizeOf(Buffer), BufferLen);
       BlockWrite(f, Buffer, BufferLen)
     until BufferLen = 0;
     CloseFile(f);
     Result := True;
   finally
     InternetCloseHandle(hURL)
   end
 finally
   InternetCloseHandle(hSession)
 end;
end;
{begin
  try
    Result := UrlDownloadToFile(nil, PChar(SourceFile), PChar(DestFile), 0,
      nil) = 0;
  except
    Result := False;
  end;
end;   }

function TFBuscaXmlCTe.StripHTML(S: string): string;
var
  TagBegin, TagEnd, TagLength: integer;
begin
  TagBegin := Pos( '<', S);      // search position of first <

  while (TagBegin > 0) do begin  // while there is a < in S
    TagEnd    := Pos('>', S);              // find the matching >
    TagLength := TagEnd - TagBegin + 1;
    Delete(S, TagBegin, TagLength);     // delete the tag
    TagBegin := Pos( '<', S);            // search for next <
  end;

  Result := S;                   // give the result
end;

procedure TFBuscaXmlCTe.btnPegarHTMLClick(Sender: TObject);
begin
  PegarHTML;
end;

/////////////////////////////////////
procedure TFBuscaXmlCTe.PegarHTML;
/////////////////////////////////////
begin
  edtChaveNFe.Text := OnlyNumber(edtChaveNFe.Text);

  if not ValidarChave('CTe'+edtChaveNFe.Text) then
   begin
     MessageDlg('Chave Inválida.',mtError,[mbok],0);
     edtChaveNFe.SetFocus;
     exit;
   end;

  if trim(edtCaptcha.Text) = '' then
   begin
     MessageDlg('Digite o valor da imagem.',mtError,[mbok],0);
     edtCaptcha.SetFocus;
     exit;
   end;

  Memo2.Lines.Clear;

  Button1.Enabled         := False;
//  btnPegarHTML.Enabled    := False;
  btnNovaConsulta.Enabled := False;
  btnGerarXML.Enabled     := False;
  try
     WebBrowser1.OleObject.Document.all.Item('ctl00$ContentPlaceHolder1$txtChaveAcessoCompleta', 0).value := edtChaveNFe.Text;
     WebBrowser1.OleObject.Document.all.Item('ctl00$ContentPlaceHolder1$txtCaptcha', 0).value := edtCaptcha.Text;
     WebBrowser1.OleObject.Document.all.Item('ctl00$ContentPlaceHolder1$btnConsultar', 0).click;
  except
     btnNovaConsulta.Enabled := True;
     raise;
  end;
  PageControl1.ActivePageIndex := 0;
end;

procedure TFBuscaXmlCTe.FormCreate(Sender: TObject);
begin
//  NovaConsulta;
end;

procedure TFBuscaXmlCTe.WebBrowser1DocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
  k, i: Integer;
  Source, dest: string;
  textoNFe : IHTMLDocument2;
begin
  Application.ProcessMessages;
  if WebBrowser1.LocationURL = 'http://www.nfe.fazenda.gov.br/portal/consulta.aspx?tipoConsulta=completa&tipoConteudo=XbSeqxE8pl8=' then
  begin
    for k := 0 to WebBrowser1.OleObject.Document.Images.Length - 1 do
     begin
       Source := WebBrowser1.OleObject.Document.Images.Item(k).Src;
       if (Source = 'http://www.nfe.fazenda.gov.br/scripts/srf/intercepta/captcha.aspx?opt=image') then
       begin
         dest := ExtractFilePath(ParamStr(0)) + 'captcha.gif';
         DownloadFile(Source, dest);
       end;
     end;
     Image1.Picture.LoadFromFile(dest);
//     btnPegarHTML.Enabled := True;
  end
  else if WebBrowser1.LocationURL = 'https://www.nfe.fazenda.gov.br/portal/visualizacaoNFe/completa/Default.aspx' then
  begin
    WebBrowser1.Navigate('https://www.nfe.fazenda.gov.br/PORTAL/visualizacaoNFe/completa/impressao.aspx');
  end
  else if WebBrowser1.LocationURL = 'http://www.nfe.fazenda.gov.br/portal/consultaCompleta.aspx?tipoConteudo=XbSeqxE8pl8=' then
  begin
    textoNFe := WebBrowser1.Document as IHTMLDocument2;
    repeat
       Application.ProcessMessages;
    until Assigned(textoNFe.body);
    Memo2.Lines.Text := StripHTML(textoNFe.body.innerHTML);
    Memo2.Lines.Text := StringReplace(Memo2.Lines.Text,'&nbsp;','',[rfReplaceAll, rfIgnoreCase]);

    i := 0;
    while i < memo2.Lines.Count-1 do
    begin
      if trim(Memo2.Lines[i]) = '' then
      begin
        Memo2.Lines.Delete(i);
        i := i - 1;
      end;
      if pos('function',Memo2.lines[i])>0 then
      begin
        Memo2.Lines.Delete(i);
        i := i - 1;
      end;
      if pos('document',Memo2.lines[i])>0 then
      begin
        Memo2.Lines.Delete(i);
        i := i - 1;
      end;
      if pos('{',Memo2.lines[i])>0 then
      begin
        Memo2.Lines.Delete(i);
        i := i - 1;
      end;
      if pos('}',Memo2.lines[i])>0 then
      begin
        Memo2.Lines.Delete(i);
        i := i - 1;
      end;

      i := i + 1;
    end;
    Image1.Picture      := nil;
    btnGerarXML.Enabled := True;
    GeraXml;
  end
  else if WebBrowser1.LocationURL = 'https://www.nfe.fazenda.gov.br/portal/inexistente_completa.aspx' then
  begin
    MessageDlg('NF-e INEXISTENTE na base nacional, favor consultar esta NF-e no site da SEFAZ de origem.',mtError,[mbok],0);
    Image1.Picture          := nil;
    btnGerarXML.Enabled     := True;
    btnNovaConsulta.Enabled := True;
  end
  else
  begin
    MessageDlg('Erro carregando URL: '+WebBrowser1.LocationURL,mtError,[mbok],0);
    Image1.Picture          := nil;
    btnGerarXML.Enabled     := True;
    btnNovaConsulta.Enabled := True;
  end;
end;

procedure TFBuscaXmlCTe.WebBrowser1ProgressChange(Sender: TObject; Progress,
  ProgressMax: Integer);
begin
 if ProgressMax = 0 then
  begin
    ProgressBar1.Visible := False;
    lblStatus.Visible    := False;
    exit;
  end
 else
  begin
    ProgressBar1.Visible := True;
    lblStatus.Visible    := True;
    try
       ProgressBar1.Max := ProgressMax;
       if (Progress <> -1) and (Progress <= ProgressMax) then
          ProgressBar1.Position := Progress
       else
        begin
          ProgressBar1.Visible := False;
          lblStatus.Visible    := False;
        end;
    except
       on EDivByZero do
         exit;
    end;
  end;
end;

procedure TFBuscaXmlCTe.btnNovaConsultaClick(Sender: TObject);
begin
  NovaConsulta;
end;

procedure TFBuscaXmlCTe.NovaConsulta;
begin
  btnNovaConsulta.Enabled := False;
  btnGerarXML.Enabled     := False;
  edtcaptcha.Text:='';
  Button1.Enabled         := True;
  DeleteIECache;
  Memo2.Lines.Clear;
  WebBrowser1.Navigate('http://www.nfe.fazenda.gov.br/portal/consulta.aspx?tipoConsulta=completa&tipoConteudo=XbSeqxE8pl8=');
end;

procedure TFBuscaXmlCTe.btnGerarXMLClick(Sender: TObject);
begin
  GeraXML;
end;

procedure TFBuscaXmlCTe.GeraXml;
///////////////////////////////////
var arqxml,xdir,caminho:string;
begin
  xdir:=copy(GetCurrentdir(),1,2)+'\Nfesac\Baixadas';
  if trim(FGeral.GetConfig1AsString('PastaSEFAxml'))<>'' then
    xdir:=FGeral.GetConfig1AsString('PastaSEFAxml');
  if not DirectoryExists( xdir ) then
      ForceDirectories( xdir );
  caminho:=xdir+'\';
//  FPath:=GerarXML(Memo2.Lines.Text,caminho);
// 24.01.15
  FPath:=GerarXML(Memo2.Lines.Text);
  WBXML.Navigate(FPath);
//  MessageBox(0,PChar('XML '+FPath+' gerado com sucesso!'),'Informação',
//    MB_ICONINFORMATION+MB_TASKMODAL);
  btnNovaConsulta.Enabled := True;
//  btnPegarHTML.Enabled    := True;
////////////  13.06.12
//  if Stxml=nil then STxml:=TStream.Create;
//  Stxml.
//  Memo2.Lines.GetText;
//  FNotaCompra.ACBrNFe1.NotasFiscais.Add.XML:=xml;
  FNotaCompra.Acbrnfe1.NotasFiscais.Clear;
// 20.09.12
  if pos('INEXISTENTE',Memo2.Lines.Text) >0 then
   ShowMessage('Provável que esta nota ainda não foi enviada ao Portal Nacional de NFe OU problemas no site da receita')
  else begin
    MessageBox(0,PChar('XML '+FPath+' gerado com sucesso!'),'Informação',MB_ICONINFORMATION+MB_TASKMODAL);
    FNotaCompra.ACBrNFe1.NotasFiscais.LoadFromFile( FPath );
//    FNotaCompra.Acbrnfe1.NotasFiscais.Items[0].Alertas:='BaixadaSefa';
    showmessage('ver  como identificar baixadas sefa');
    FNotaCompra.EdArquivoxml.Text:=FPath;
  end;

end;

procedure TFBuscaXmlCTe.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=vk_escape then
  Close;
end;

procedure TFBuscaXmlCTe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  Action := caFree;
  Action := caHide;
//  Close;
end;

procedure TFBuscaXmlCTe.Button1Click(Sender: TObject);
begin
  PegarHTML;
end;

procedure TFBuscaXmlCTe.Label3Click(Sender: TObject);
begin
  NovaConsulta;
end;

procedure TFBuscaXmlCTe.FormActivate(Sender: TObject);
begin
  if TFBuscaXmlCTe=nil then FGeral.CreateForm(TFBuscaXmlCTe,FBuscaXmlCTe);
  NovaConsulta;

end;

procedure TFBuscaXmlCTe.Execute;
begin
   edtChaveNFe.clear;
   Show;
end;

end.


unit principal;

interface

uses
//    GifImage ,    // 14.08.20
  UrlMon, MSHtml, ACBrUtil, pcnAuxiliar,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw, ExtCtrls, ComCtrls, WinInet, Menus,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, ACBrBase,
  ACBrDFe, ACBrNFe,pcnconversao, blcksock, ACBrCTe, Registry;


type
  TFBuscaXmlSefa = class(TForm)
    ProgressBar1: TProgressBar;
    lblStatus: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    btnPegarHTML: TButton;
    btnNovaConsulta: TButton;
    btnGerarXML: TButton;
    Label1: TLabel;
    edtChaveNFe: TEdit;
    Label2: TLabel;
    edtCaptcha: TEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Memo2: TMemo;
    Panel1: TPanel;
    WBXML: TWebBrowser;
    Button1: TButton;
    TabSheet3: TTabSheet;
    Label4: TLabel;
    Label5: TLabel;
    cbnfce: TCheckBox;
    IdHTTP1: TIdHTTP;
    ACBrNFe1: TACBrNFe;
    XMLRetorno: TTabSheet;
    Memoxmlretorno: TMemo;
    ACBrCTe1: TACBrCTe;
    EdUltimoNsu: TEdit;
    Edmaximonsu: TEdit;
    procedure btnPegarHTMLClick(Sender: TObject);

    procedure WebBrowser1ProgressChange(Sender: TObject; Progress,
      ProgressMax: Integer);
    procedure btnNovaConsultaClick(Sender: TObject);
    procedure btnGerarXMLClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure WebBrowser1DocumentComplete(ASender: TObject;
      const pDisp: IDispatch; const URL: OleVariant);
    procedure edtCaptchaChange(Sender: TObject);
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
    function FillForm(WebBrowser: TWebBrowser; FieldName: string; Value: string): Boolean;
    function WebFormFields(const document: IHTMLDocument2; const formName : string): TStringList;
    function WebFormGet(const formNumber: integer; const document: IHTMLDocument2): IHTMLFormElement;
  end;

var
  FBuscaXmlSefa: TFBuscaXmlSefa;
  pagina,pagina1:Widestring;
  xmodelo:string;

implementation

//uses ACBrNFeUtil, ACBrHTMLtoXML, Sqlsis, nfcompra;
uses ACBrHTMLtoXML, Sqlsis, nfcompra, Geral,SqlFun;

{$R *.dfm}


procedure TFBuscaXmlSefa.DeleteIECache;
//////////////////////////////////////////////
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


function TFBuscaXmlSefa.DownloadFile(SourceFile, DestFile: string): Boolean;
//////////////////////////////////////////////////////////////////////////////////
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
procedure TFBuscaXmlSefa.edtCaptchaChange(Sender: TObject);
begin

end;

{begin
  try
    Result := UrlDownloadToFile(nil, PChar(SourceFile), PChar(DestFile), 0,
      nil) = 0;
  except
    Result := False;
  end;
end;   }

function TFBuscaXmlSefa.StripHTML(S: string): string;
///////////////////////////////////////////////////////////////
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

procedure TFBuscaXmlSefa.btnPegarHTMLClick(Sender: TObject);
//////////////////////////////////////////////////////////////////////////////
begin
  PegarHTML;
end;

// 21.04.16
function TFBuscaXmlSefa.WebFormGet(const formNumber: integer; const document: IHTMLDocument2): IHTMLFormElement;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
var
forms : IHTMLElementCollection;
begin
forms := document.Forms as IHTMLElementCollection;
result := forms.Item(formNumber,'') as IHTMLFormElement
end;

// 21.04.16
function TFBuscaXmlSefa.WebFormFields(const document: IHTMLDocument2; const formName : string): TStringList;
/////////////////////////////////////////////////////////////////////////////////////////////////////
var
form : IHTMLFormElement;
field : IHTMLElement;
fName : string;
idx : integer;
begin
//form := WebFormGet(0, WebBrowser1.Document AS IHTMLDocument2) ;

result := TStringList.Create;
for idx := 0 to -1 + form.length do
begin
field := form.item(idx, '') as IHTMLElement;

if field = nil then Continue;
fName := field.id;

if field.tagName = 'INPUT' then fName := (field as IHTMLInputElement).name;
if field.tagName = 'SELECT' then fName := (field as IHTMLSelectElement).name;
if field.tagName = 'TEXTAREA' then fName := (field as IHTMLTextAreaElement).name;

Memo2.lines.add( fname );

result.Add(fName) ;
end;
end;


// 21.04.16
function TFBuscaXmlSefa.FillForm(WebBrowser: TWebBrowser; FieldName: string; Value: string): Boolean;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
var
i, j: Integer;
FormItem: Variant;
begin
Result := False;
//no form on document
if WebBrowser.OleObject.Document.all.tags('FORM').Length = 0 then
begin
Exit;
end;
//count forms on document
for I := 0 to WebBrowser.OleObject.Document.forms.Length - 1 do
begin
FormItem := WebBrowser.OleObject.Document.forms.Item(I);
for j := 0 to FormItem.Length - 1 do
begin
  try
  //when the fieldname is found, try to fill out
    if FormItem.Item(j).Name = FieldName then begin
       FormItem.Item(j).Value := Value;
       Result := True;
    end else
      Memo2.Lines.Add( 'Campo = '+FormItem.Item(j).Name )

  except
    Exit;
  end;
end;

end;
end;


procedure TFBuscaXmlSefa.PegarHTML;
/////////////////////////////////////////////////
var  textoNFe : IHTMLDocument2;
begin
  edtChaveNFe.Text := OnlyNumber(edtChaveNFe.Text);

  if not ValidarChave('NFe'+edtChaveNFe.Text) then
   begin
     MessageDlg('Chave Inv�lida.',mtError,[mbok],0);
     edtChaveNFe.SetFocus;
     exit;
   end;
{
  if trim(edtCaptcha.Text) = '' then
   begin
     MessageDlg('Digite o valor da imagem.',mtError,[mbok],0);
     edtCaptcha.SetFocus;
     exit;
   end;
}

  Memo2.Lines.Clear;

  Button1.Enabled         := False;
  btnPegarHTML.Enabled    := False;
//  btnNovaConsulta.Enabled := False;
// 20.04.16
  btnNovaConsulta.Enabled := True;
  btnGerarXML.Enabled     := False;
//  textoNFe := WebBrowser1.Document as IHTMLDocument2;
  try
     if cbnfce.Checked then begin

//     if FillForm(WebBrowser1, 'eChDFe', edtChaveNFe.Text ) = False then
//        ShowMessage('Erro. Campo n�o dispon�vel.')
//      else
//        WebFormFields(textoNFe ,webbrowser1.Name);

//          Memo2.Lines.Text := IdHTTP1.Get(pagina);

//          textoNFe := WebBrowser1.Document as IHTMLDocument2;
          repeat
             Application.ProcessMessages;
          until Assigned(textoNFe.body);
          Memo2.Lines.Text := StripHTML(textoNFe.body.innerHTML);
          Memo2.Lines.Text := StringReplace(Memo2.Lines.Text,'&nbsp;','',[rfReplaceAll, rfIgnoreCase]);


//       WebBrowser1.OleObject.Document.all.Item('eChDFe', 0).value := edtChaveNFe.Text;
//       WebBrowser1.OleObject.Document.all.Item('eNumImage', 0).value := edtCaptcha.Text;
//       WebBrowser1.OleObject.Document.all.Item('btConsultar', 0).click;

     end else begin

//       WebBrowser1.OleObject.Document.all.Item('ctl00$ContentPlaceHolder1$txtChaveAcessoCompleta', 0).value := edtChaveNFe.Text;
// 12.08.20
////       WebBrowser1.OleObject.Document.all.Item('ctl00$ContentPlaceHolder1$txtChaveAcessoResumo', 0).value := edtChaveNFe.Text;
//       WebBrowser1.OleObject.Document.all.Item('ctl00$ContentPlaceHolder1$txtCaptcha', 0).value := edtCaptcha.Text;
//       WebBrowser1.OleObject.Document.all.Item('recaptcha-checkbox-checked', 0).click;
//       WebBrowser1.OleObject.Document.all.Item('ctl00$ContentPlaceHolder1$btnConsultar', 0).click;

     end;

  except
     btnNovaConsulta.Enabled := True;
     raise;
  end;

  PageControl1.ActivePageIndex := 0;
end;


////////////////////////////////////////////////////////////////////////////

procedure TFBuscaXmlSefa.WebBrowser1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
  /////////////////////////////////////////////////////////////////////////////////////
var
  k, i: Integer;
  Source, dest: string;
  textoNFe : IHTMLDocument2;
begin

{
  Application.ProcessMessages;
  if WebBrowser1.LocationURL = 'http://www.nfe.fazenda.gov.br/portal/consulta.aspx?tipoConsulta=completa&tipoConteudo=XbSeqxE8pl8=' then

  //  pagina:='http://www.nfe.fazenda.gov.br/portal/consulta.aspx?tipoConsulta=completa&tipoConteudo=XbSeqxE8pl8=' ;
//  pagina:='https://www.sped.fazenda.pr.gov.br/modules/conteudo/conteudo.php?conteudo=100' ;
//  if WebBrowser1.LocationURL = pagina then
//  begin
    {
    for k := 0 to WebBrowser1.OleObject.Document.Images.Length - 1 do
     begin
       Source := WebBrowser1.OleObject.Document.Images.Item(k).Src;
       if (Source = 'http://www.nfe.fazenda.gov.br/scripts/srf/intercepta/captcha.aspx?opt=image') then
       begin
         dest := ExtractFilePath(ParamStr(0)) + 'captcha.gif';
         DownloadFile(Source, dest);
       end;
     end;
     }
//     Image1.Picture.LoadFromFile(dest);
//     btnPegarHTML.Enabled := True;
//  end

{
// 12.08.20
  else if WebBrowser1.LocationURL = 'http://www.nfe.fazenda.gov.br/portal/consultaResumo.aspx?tipoConteudo=d09fwabTnLk=' then begin

    WebBrowser1.Navigate('http://www.nfe.fazenda.gov.br/portal/consultaResumo.aspx?tipoConteudo=d09fwabTnLk=');

  end
  else if WebBrowser1.LocationURL = 'https://www.nfe.fazenda.gov.br/portal/visualizacaoNFe/completa/Default.aspx' then
  begin

    WebBrowser1.Navigate('https://www.nfe.fazenda.gov.br/PORTAL/visualizacaoNFe/completa/impressao.aspx');

  end

  else if ( WebBrowser1.LocationURL = 'http://www.nfe.fazenda.gov.br/portal/consultaCompleta.aspx?tipoConteudo=XbSeqxE8pl8=' )
       or
          ( WebBrowser1.LocationURL =  'http://www.dfeportal.fazenda.pr.gov.br/dfe-portal/rest/servico/consultaCompletaDFe?modelo=65&tpAmbiente=1' )
//          &chaveAcesso=41160407115580000101650020000003711000003711&captcha=pddszb
       then
// ver aqui a pagina do PR da nfce
//  else if WebBrowser1.LocationURL = pagina then
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

//     if pos('}
{
',Memo2.lines[i])>0 then
      begin
        Memo2.Lines.Delete(i);
        i := i - 1;
      end;

      i := i + 1;
    end;
//    Image1.Picture      := nil;
    btnGerarXML.Enabled := True;
    GeraXml;
  end
  else if WebBrowser1.LocationURL = 'https://www.nfe.fazenda.gov.br/portal/inexistente_completa.aspx' then
  begin
    MessageDlg('NF-e INEXISTENTE na base nacional, favor consultar esta NF-e no site da SEFAZ de origem.',mtError,[mbok],0);
  //  Image1.Picture          := nil;
    btnGerarXML.Enabled     := True;
    btnNovaConsulta.Enabled := True;
  end
  else
  begin
    MessageDlg('Erro carregando URL: '+WebBrowser1.LocationURL,mtError,[mbok],0);
//    Image1.Picture          := nil;
    btnGerarXML.Enabled     := True;
    btnNovaConsulta.Enabled := True;
  end;
}

end;

////////////////////////////////////////////////////////////////////////////

procedure TFBuscaXmlSefa.WebBrowser1ProgressChange(Sender: TObject; Progress,
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

procedure TFBuscaXmlSefa.btnNovaConsultaClick(Sender: TObject);
//////////////////////////////////////////////////////////////////////////////////
begin
  NovaConsulta;
end;

procedure TFBuscaXmlSefa.NovaConsulta;
/////////////////////////////////////////
begin
//  btnNovaConsulta.Enabled := False;
  btnGerarXML.Enabled     := False;
  edtcaptcha.Text:='';
  Button1.Enabled         := True;
  DeleteIECache;
  Memo2.Lines.Clear;
  pagina1:='';
  if cbnfce.Checked then begin
    if Global.UFUnidade='PR' then begin
//      pagina:='http://www.sped.fazenda.pr.gov.br/modules/conteudo/conteudo.php?conteudo=100'
//      pagina:='http://www.dfeportal.fazenda.pr.gov.br/dfe-portal/rest/servico/consultaCompletaNFCe?chaveAcesso=41170676760271000107650030000117951000117958&tpAmbiente=1&captcha=p2u7h6'
      pagina:='http://www.dfeportal.fazenda.pr.gov.br/dfe-portal/rest/servico/consultaNFCe?chNFe=41170676760271000107650030000117951000117958&nVersao=100';
      pagina1:='&tpAmb=1&dhEmi=323031372d30362d31305431323a33313a35362d30333a3030&vNF=37.49&vICMS=0.00&digVal=656452657764505a313967635649556439454b37334b5734796d553d&cIdToken=000001&cHashQRCode=1F78FF64F69EE6C8A2BB2C276D7BCB0F67A48E42';
    end else
      pagina:='N�o tem site';
  end else
//    pagina:='http://www.nfe.fazenda.gov.br/portal/consulta.aspx?tipoConsulta=completa&tipoConteudo=XbSeqxE8pl8=' ;
// 17.11.17
//   pagina:='http://www.nfe.fazenda.gov.br/portal/consultaRecaptcha.aspx?tipoConsulta=completa&tipoConteudo=XbSeqxE8pl8=';
// 14.11.18
//   pagina:='http://www.nfe.fazenda.gov.br/portal/consultaResumoCompletaAntiga.aspx?tipoConsulta=completa&tipoConteudo=XbSeqxE8pl8=';
// 02.05.19
//   pagina:='http://www.nfe.fazenda.gov.br/portal/listaSubMenu.aspx?Id=nIzMon5clGU=';
// 12.08.20
    pagina:= 'http://www.nfe.fazenda.gov.br/portal/consultaRecaptcha.aspx?tipoConsulta=resumo&tipoConteudo=d09fwabTnLk=';

//  WebBrowser1.Navigate( pagina );
// 05.10.2022
end;

procedure TFBuscaXmlSefa.btnGerarXMLClick(Sender: TObject);
begin
  GeraXML;
end;

procedure TFBuscaXmlSefa.GeraXml;
///////////////////////////////////
begin
  FPath:=GerarXML(Memo2.Lines.Text,EdtChavenfe.text);
  if Fpath<>'' then begin
    WBXML.Navigate(FPath);
    MessageBox(0,PChar('XML '+FPath+' gerado com sucesso!'),'Informa��o',
    MB_ICONINFORMATION+MB_TASKMODAL);
  end;
  btnNovaConsulta.Enabled := True;
  btnPegarHTML.Enabled    := True;
end;

procedure TFBuscaXmlSefa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=vk_escape then
  Close;
end;

procedure TFBuscaXmlSefa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFBuscaXmlSefa.Button1Click(Sender: TObject);
//////////////////////////////////////////////////////////////
var idlote:integer;
    sNSU  :string;


    // 17.06.20
    procedure ManifestaCte;
    ////////////////////////
    var w   : integer;
        nsu : string;

    begin

    if (trim(acbrcte1.Configuracoes.Certificados.NumeroSerie)<>'') and ( not Global.Topicos[1450] )then begin

     if ( ACBrCTe1.SSL.CertDataVenc > Sistema.hoje ) and  ( trunc(ACBrCTe1.SSL.CertDataVenc-Sistema.Hoje)<=30 )
        then begin
        Aviso('Certificado digital '+copy(ACBrCTe1.SSL.CertSubjectName,1,40)+' VENCE em '+Datetostr(ACBrCTe1.SSL.CertDataVenc));
     end;

     if ACBrCTe1.SSL.CertDataVenc<Sistema.hoje then begin
        Avisoerro('Certificado digital '+copy(ACBrCTe1.SSL.CertSubjectName,1,40)+' VENCIDO em '+Datetostr(ACBrCTe1.SSL.CertDataVenc));
        exit;
     end;

     Sistema.BeginProcess('Baixando os �ltimos 50 CT-e dispon�veis' );
{
       idlote:=FGeral.GetContador('LoteManifesto'+Global.CodigoUnidade,false,true);
       ACBrcte1.Eventocte.Evento.Clear;
       with ACBrcte1.Eventocte.Evento.Add do
       begin
             InfEvento.cOrgao   := 91;  // ambiente nacional
             infEvento.chcTe    := Edtchavenfe.text;
             infEvento.CNPJ     := FGeral.GetCnpjCpfTipoCad(strtoint(Global.CodigoUnidade),'U');
             infEvento.dhEvento := now;
             infEvento.tpEvento := teManifDestConfirmacao;
       end;

       ACBrCTe1.EnviarEvento(IDLote);
}

//       ACBrCTe1.WebServices.Consulta.CTeChave := Edtchavenfe.text;
// puxa os ultimos 50 cte disponiveis e neles busca a chave do cte
       AcbrCTe1.DistribuicaoDFePorUltNSU(ACBrCTe1.Configuracoes.WebServices.UFcodigo,FGeral.GetCnpjCpfTipoCad(strtoint(Global.CodigoUnidade),'U'),'0');
       if ACBrCTe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Count = 0 then begin

          Sistema.endProcess( 'Distribui��o vazio' );
          exit;

       end;

       nsu := '0';
       for w := 0 to ACBrCTe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Count-1 do  begin

          if Edtchavenfe.text =  ACBrCTe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[ w ].resDFe.chDFe then begin

             NSU  := ACBrCTe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[ w ].NSU;
             break;

          end;

       end;

       if nsu = '0' then begin

          Sistema.endProcess( 'Chave n�o encontrada nos CT-e dispon�veis' );
          exit;

       end;

       try

          AcbrCTe1.DistribuicaoDFePorNSU(ACBrCTe1.Configuracoes.WebServices.UFcodigo,FGeral.GetCnpjCpfTipoCad(strtoint(Global.CodigoUnidade),'U'),nsu);

       except on e:exception do Avisoerro('Erro : '+E.Message );

       end;



       Memo2.Lines.Text         :=ACBrCTe1.WebServices.Retorno.xMotivo;
       Memoxmlretorno.Lines.Text:=ACBrcte1.WebServices.Retorno.RetWS;


       Sistema.BeginProcess('Baixando xml do CT-e com timeout '+currtostr(Acbrcte1.Configuracoes.WebServices.TimeOut/1000));

       if AnsiPos('o encontrado',Memoxmlretorno.Lines.Text ) >0  then begin

          Sistema.endProcess( 'Chave n�o encontrada na receita' );
          exit;

       end else if AnsiPos('Inoperante',Memoxmlretorno.Lines.Text ) >0  then begin

          Sistema.endProcess( 'Site da receita ocupado ou indispon�vel' );
          exit;

       end;

       {
       if trim( ACBrCTe1.WebServices.Retorno.xMotivo ) <> '' then begin

         Memo2.Lines.Text:=ACBrCTe1.WebServices.Retorno.RetCTeDFe.docZip.Items[0].XML;
         Sistema.endProcess('Download do XML efetuado');

       end else

         Sistema.endProcess('Download do XML N�O efetuado. '+ACBrCTe1.WebServices.DistribuicaoDFe.retDistDFeInt.xMotivo );

         }

        Sistema.endProcess('');

  end else

    end;

begin


  xmodelo:=copy(EdtChavenfe.text,21,2);

  if xmodelo = '57' then begin

     ManifestaCte;
     exit;

  end;

  if xmodelo<>'55' then begin
    Avisoerro('Op��o v�lida somente para NF-e modelo 55.  Esta chave � de nota modelo '+xmodelo);
    exit;
  end;
// 29.08.17
   if (trim(acbrnfe1.Configuracoes.Certificados.NumeroSerie)<>'') and ( not Global.Topicos[1450] )then begin

     if ( ACBrNFe1.SSL.CertDataVenc > Sistema.hoje ) and  ( trunc(ACBrNFe1.SSL.CertDataVenc-Sistema.Hoje)<=30 )
        then begin
        Aviso('Certificado digital '+copy(ACBrNFe1.SSL.CertSubjectName,1,40)+' VENCE em '+Datetostr(ACBrNFe1.SSL.CertDataVenc));
     end;

     if ACBrNFe1.SSL.CertDataVenc<Sistema.hoje then begin
        Avisoerro('Certificado digital '+copy(ACBrNFe1.SSL.CertSubjectName,1,40)+' VENCIDO em '+Datetostr(ACBrNFe1.SSL.CertDataVenc));
        exit;
     end;

 {
     Sistema.BeginProcess('Pesquisando chave');
     try

        Acbrnfe1.DistribuicaoDFePorChaveNFe(ACBrNFe1.Configuracoes.WebServices.UFcodigo,FGeral.GetCnpjCpfTipoCad(strtoint(Global.CodigoUnidade),'U'),Edtchavenfe.Text);

     except on E:exception do

        begin

          Sistema.endprocess( E.message );
          exit;

        end;

     end;

    }

    {
     if Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.cStat = 137 then begin

       Acbrnfe1.DistribuicaoDFePorUltNSU(ACBrNFe1.Configuracoes.WebServices.UFcodigo,FGeral.GetCnpjCpfTipoCad(strtoint(Global.CodigoUnidade),'U'),'0');
       Edultimonsu.text :=Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.ultNSU;
       Edmaximonsu.text :=Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.maxNSU;

     end;
    }
     snsu := '';
{
     if Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.cStat <> 138 then begin

        Sistema.endProcess('Chave n�o encontrada para fazer o manifesto.  Tentar daqui 1 hora');
        exit;

     end;
}

//    sNSU  := Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[0].NSU;


//       Aviso( 'Status Retorno = '+inttostr(Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.cStat) ) ;

//       Memo2.Lines.Text:=ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[0].XML;
//       Aviso( ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[0].XML) ;

       Sistema.BeginProcess('Manifestando nota pela chave com timeout '+currtostr(Acbrnfe1.Configuracoes.WebServices.TimeOut/1000));

       idlote:=FGeral.GetContador('LoteManifesto'+Global.CodigoUnidade,false,true);
       ACBrNFe1.EventoNFe.Evento.Clear;
       with ACBrNFe1.EventoNFe.Evento.Add do
       begin
             InfEvento.cOrgao   := 91;  // ambiente nacional
             infEvento.chNFe    := Edtchavenfe.text;
             infEvento.CNPJ     := FGeral.GetCnpjCpfTipoCad(strtoint(Global.CodigoUnidade),'U');
             infEvento.dhEvento := now;
             infEvento.tpEvento := teManifDestConfirmacao;
       end;

       ACBrNFe1.EnviarEvento(IDLote);

       Memo2.Lines.Text:=ACBrNFe1.WebServices.Retorno.xMotivo;
       try

          if trim(snsu)<>'' then

             Acbrnfe1.DistribuicaoDFePorNSU(ACBrNFe1.Configuracoes.WebServices.UFcodigo,FGeral.GetCnpjCpfTipoCad(strtoint(Global.CodigoUnidade),'U'),snsu )

          else

             Acbrnfe1.DistribuicaoDFePorChaveNFe(ACBrNFe1.Configuracoes.WebServices.UFcodigo,FGeral.GetCnpjCpfTipoCad(strtoint(Global.CodigoUnidade),'U'),Edtchavenfe.Text);

       except on e:exception do Avisoerro('Erro : '+E.Message );

       end;

       Memoxmlretorno.Lines.Text:=ACBrNFe1.WebServices.DistribuicaoDFe.RetWS;

       if AnsiPos('Inoperante',Memoxmlretorno.Lines.Text ) >0  then begin

          Sistema.endProcess( 'Site da receita ocupado ou indispon�vel' );
          exit;

//       end else if AnsiPos( FGeral.GetCnpjCpfTipoCad(strtoint(Global.CodigoUnidade),'U'),Memoxmlretorno.Lines.Text ) = 0 then begin
//
//          Sistema.endProcess( 'Cnpj da Unidade em uso diferente do destinat�rio ?' );
 //         exit;

       end;

// 21.08.19
//       Aviso( ACBrNFe1.WebServices.DistribuicaoDFe.RetornoWS );

       if ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Count > 0 then begin

         Memo2.Lines.Text:=ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[0].XML;
         if Ansipos('infNFe Id',Memo2.Lines.text ) >0 then

            Sistema.endProcess('Download do XML efetuado')

         else if Ansipos('LOCALIZADO',Uppercase(Memo2.Lines.text) ) >0 then begin

            Acbrnfe1.DistribuicaoDFePorChaveNFe(ACBrNFe1.Configuracoes.WebServices.UFcodigo,FGeral.GetCnpjCpfTipoCad(strtoint(Global.CodigoUnidade),'U'),Edtchavenfe.Text);
            if ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Count > 0 then

                Memoxmlretorno.Lines.Text:=ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[0].XML

            else

                Memoxmlretorno.Lines.Text:=ACBrNFe1.WebServices.DistribuicaoDFe.RetWS;

            Sistema.endProcess('Retorno 03 : '+Memoxmlretorno.Lines.Text )

         end else  Sistema.endProcess( 'Retorno 04 : '+Memo2.Lines.Text );


       end else if AnsiPos('o encontrado',Memoxmlretorno.Lines.Text ) >0  then begin

          Sistema.endProcess( 'Chave n�o encontrada no ambiente de manifesta��o da receita' );
          exit;

       end else begin
// 28.07.20 - tentando baixa novamente...
          Acbrnfe1.DistribuicaoDFePorChaveNFe(ACBrNFe1.Configuracoes.WebServices.UFcodigo,FGeral.GetCnpjCpfTipoCad(strtoint(Global.CodigoUnidade),'U'),Edtchavenfe.Text);
          Memoxmlretorno.Lines.Text:=ACBrNFe1.WebServices.DistribuicaoDFe.RetWS;

          if ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Count > 0 then begin

            Memo2.Lines.Text:=ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[0].XML;
            if Ansipos('infNFe Id',Memo2.Lines.text)>0 then

               Sistema.endProcess('Download do XML efetuado')

            else

               Sistema.endProcess( 'Retorno 02 : '+Memo2.Lines.text );

          end else Sistema.endProcess('Retorno 01 :'+Memoxmlretorno.Lines.text )

       end;

      if AnsiPos('Nenhum',Memoxmlretorno.Lines.Text ) >0  then begin

            Sistema.endProcess( 'Tentar mais tarde. Chave ainda n�o dispon�vel no ambiente de manifesta��o da receita para CNPJ '+FGeral.GetCnpjCpfTipoCad(strtoint(Global.CodigoUnidade),'U') );
            exit;

      end else if ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Count = 0 then

//          Sistema.endprocess( Memoxmlretorno.Lines.Text );

       Sistema.endProcess('Download do XML N�O efetuado. Motivo : '+ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.xMotivo );

//     end else if Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.cStat = 137 then begin
//
//         Sistema.endProcess('Chave n�o encontrada.');
//
//     end else begin
//////////////////////////
{
       Aviso( AcbrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.xmotivo );
//     if AcbrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat=135 then
       Sistema.BeginProcess('Manifestando nota pela chave');

       idlote:=FGeral.GetContador('LoteManifesto'+Global.CodigoUnidade,false,true);
       ACBrNFe1.EventoNFe.Evento.Clear;
       with ACBrNFe1.EventoNFe.Evento.Add do
       begin
             InfEvento.cOrgao   := 91;  // ambiente nacional
             infEvento.chNFe    := Edtchavenfe.text;
             infEvento.CNPJ     := FGeral.GetCnpjCpfTipoCad(strtoint(Global.CodigoUnidade),'U');
             infEvento.dhEvento := now;
             infEvento.tpEvento := teManifDestConfirmacao;
       end;
       ACBrNFe1.EnviarEvento(IDLote);
     Sistema.endProcess('Feito manifesta��o da nota.  Download do XML dispon�vel.');
     end;
}
//}

//     Memo2.Lines.Text:=Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.XML ;
  end else

    PegarHTML;

end;

procedure TFBuscaXmlSefa.Label3Click(Sender: TObject);
begin
  NovaConsulta;
end;


procedure TFBuscaXmlSefa.Execute;
///////////////////////////////////////////////
var site,
    pastaxmlbaixados,
    pastaregistro:string;
    Registro : TRegistry;

begin
// 12.08.20
        {
        Registro := TRegistry.Create;
        Registro.RootKey := HKEY_CURRENT_USER;
        pastaregistro := 'Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION\SACXE7.EXE';
        if Registro.OpenKey( pastaregistro,true ) then

           Registro.CreateKey('Sacxe7.exe');


        if  Registro.OpenKey( pastaregistro,true ) then

            Registro.writestring('Sacxe7.exe','1100');

        Registro.Free;
        }

// "Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION"; ValueType: dword; ValueName: NomedoExecutavel; ValueData: 9999;
// "SOFTWARE\WOW6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION"; ValueType: dword; ValueName: NomedoExecutavel; ValueData: 9999;

// 29.08.17
  acbrnfe1.Configuracoes.Certificados.NumeroSerie:=FGeral.GetNroSerieCertificado(Global.CodigoUnidade);
  if trim(Global.UFUnidade)<>'' then
    ACBrNFe1.Configuracoes.WebServices.UF:=Global.UFUnidade
  else
    ACBrNFe1.Configuracoes.WebServices.UF:='PR';

  if trim( FGeral.GetConfig1AsString('Pastaschemas') ) <> '' then
    Acbrnfe1.Configuracoes.Arquivos.PathSchemas:=FGeral.GetConfig1AsString('Pastaschemas')
  else
    Acbrnfe1.Configuracoes.Arquivos.PathSchemas:=ExtractFilePath( Application.ExeName )+'Schemas20';

  acbrnfe1.Configuracoes.WebServices.Ambiente:=taProducao;
  if trim(FGeral.GetConfig1AsString('Pastaretonfexml'))<>'' then begin
    acbrnfe1.Configuracoes.Arquivos.PathEvento:=FGeral.GetConfig1AsString('Pastaretonfexml');
    acbrnfe1.Configuracoes.Arquivos.PathSalvar:=FGeral.GetConfig1AsString('Pastaretonfexml');
    acbrnfe1.Configuracoes.Arquivos.PathNFe:=FGeral.GetConfig1AsString('Pastaexpnfexml');
  end;
// 11.05.19
  pastaxmlbaixados:=ExtractFilePath(Application.ExeName)+'\XmlsBaixados\';

  acbrnfe1.Configuracoes.Arquivos.PathEvento:=pastaxmlbaixados;
  acbrnfe1.Configuracoes.Arquivos.PathSalvar:=pastaxmlbaixados;

 if not DirectoryExists( acbrnfe1.Configuracoes.Arquivos.PathEvento ) then
      ForceDirectories( acbrnfe1.Configuracoes.Arquivos.PathEvento );

  acbrnfe1.Configuracoes.WebServices.Ambiente:=taProducao;
// 02.05.19
  acbrnfe1.SSL.SSLType := LT_TLSv1;

// 17.06.20
///////////////////////////////////////////////////
  FGeral.configuracriptografiaacbrcte(Acbrcte1);
  acbrcte1.Configuracoes.Arquivos.PathEvento:=pastaxmlbaixados;
  acbrcte1.Configuracoes.Arquivos.PathSalvar:=pastaxmlbaixados;
  acbrcte1.Configuracoes.WebServices.Ambiente:=taProducao;
  acbrcte1.SSL.SSLType := LT_TLSv1;
  acbrCTe1.Configuracoes.Certificados.NumeroSerie:=FGeral.GetNroSerieCertificado(Global.CodigoUnidade);
  if trim(Global.UFUnidade)<>'' then
    ACBrCTe1.Configuracoes.WebServices.UF:=Global.UFUnidade
  else
    ACBrCTe1.Configuracoes.WebServices.UF:='PR';

//  if trim( FGeral.GetConfig1AsString('Pastaschemas') ) <> '' then
//    AcbrCTe1.Configuracoes.Arquivos.PathSchemas:=FGeral.GetConfig1AsString('Pastaschemas')
//  else
    AcbrCTe1.Configuracoes.Arquivos.PathSchemas:=ExtractFilePath( Application.ExeName )+'SchemasCTe20';

  acbrCTe1.Configuracoes.WebServices.Ambiente:=taProducao;
  if trim(FGeral.GetConfig1AsString('Pastaretonfexml'))<>'' then begin
    acbrCTe1.Configuracoes.Arquivos.PathEvento:=FGeral.GetConfig1AsString('Pastaretonfexml');
    acbrCTe1.Configuracoes.Arquivos.PathSalvar:=FGeral.GetConfig1AsString('Pastaretonfexml');
    acbrCTe1.Configuracoes.Arquivos.PathCTe:=FGeral.GetConfig1AsString('Pastaexpnfexml');
  end;
///////////////////////////
///
// 28.01.15
//   site:='http://www.nfe.fazenda.gov.br/portal/consulta.aspx?tipoConsulta=completa&tipoConteudo=XbSeqxE8pl8=';
//   site:='http://www.nfe.fazenda.gov.br/portal/consulta.aspx?tipoConsulta=completa';
   if (trim(acbrnfe1.Configuracoes.Certificados.NumeroSerie)='') and ( Global.Topicos[1450] ) then
     Sistema.beginprocess('Acessando consulta da NF-e Completa Portal Nacional')
   else
     Sistema.beginprocess('Acessando NF-e Destinadas');

   Show;
// 28.01.15
//   WebBrowser1.Navigate(site);

//  if xmodelo='55' then
//    pagina:='http://www.nfe.fazenda.gov.br/portal/consulta.aspx?tipoConsulta=completa&tipoConteudo=XbSeqxE8pl8=';
// 17.11.17
//     pagina:='http://www.nfe.fazenda.gov.br/portal/consultaRecaptcha.aspx?tipoConsulta=completa&tipoConteudo=XbSeqxE8pl8=';
// 02.05.19
//     pagina:='http://www.nfe.fazenda.gov.br/portal/listaSubMenu.aspx?Id=nIzMon5clGU=';
//    pagina:='http://www.sped.fazenda.pr.gov.br/modules/conteudo/conteudo.php?conteudo=100' ;
//    pagina:='http://www.dfeportal.fazenda.pr.gov.br/dfe-portal/rest/servico/consultaCompletaNFCe?chaveAcesso=41170676760271000107650030000117951000117958&tpAmbiente=1&captcha=p2u7h6';
// 12.08.20
    pagina:= 'http://www.nfe.fazenda.gov.br/portal/consultaRecaptcha.aspx?tipoConsulta=resumo&tipoConteudo=d09fwabTnLk=';
    btnnovaconsulta.Visible:=true;
    edtChaveNFe.Text:='';
    if  not ( Global.Topicos[1450] ) then btnnovaconsulta.Visible:=false;
    NovaConsulta;

  edtCaptcha.enabled:=(Global.Topicos[1450]);
  label2.visible:=(Global.Topicos[1450]);


  Sistema.endprocess('');
end;

procedure TFBuscaXmlSefa.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
/////////////////////////////////////////////////
var caminhoxml:string;
begin
    CaminhoXML := PathWithDelim(ExtractFilePath(Application.ExeName));
// 29.01.15
    CaminhoXML := Caminhoxml+'XmlsBaixados\'+
                  copy(edtchavenfe.text,1, 44)+'-nfe.xml';
   if not Global.Topicos[01450] then
     if Memo2.Lines.Count>0 then Memo2.Lines.SaveToFile( caminhoxml );

   FNotaCompra.EdArquivoxml.Text:=caminhoxml;

end;

end.



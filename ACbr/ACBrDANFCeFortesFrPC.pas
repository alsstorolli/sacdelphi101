unit ACBrDANFCeFortesFrPC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ACBrNFeDANFEClass, RLReport, pcnNFe, ACBrNFe,
  RLHTMLFilter, RLFilters, RLPDFFilter, ACBrUtil, pcnConversao, ACBrDFeUtil, ACBrValidador,
  ACBrDelphiZXingQRCode,Geral;
//  ACBrNfeUtil;

type
  TACBrNFeDANFCeFortesA4Filtro = (fiNenhum, fiPDF, fiHTML ) ;

  TACBrNFeDANFCeFortesPC = class(TACBrNFeDANFEClass)
  private
    FpNFe: TNFe;
    procedure Imprimir(const DanfeResumido : Boolean = False; const AFiltro : TACBrNFeDANFCeFortesA4Filtro = fiNenhum);
  public
    procedure ImprimirDANFE(NFE : TNFe = nil); override ;
    procedure ImprimirDANFEResumido(NFE : TNFe = nil); override ;
    procedure ImprimirDANFEPDF(NFE : TNFe = nil); override;
    procedure ImprimirDANFEResumidoPDF(NFE : TNFe = nil);override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TfrmACBrDANFCeFortesFrPC = class(TForm)
    rlReportA4: TRLReport;
    RLBand1: TRLBand;
    imgLogo: TRLImage;
    RLBand2: TRLBand;
    RLLabel6: TRLLabel;
    RLBand3: TRLBand;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    subItens: TRLSubDetail;
    RLBand4: TRLBand;
    RLPDFFilter1: TRLPDFFilter;
    RLBand5: TRLBand;
    RLLabel22: TRLLabel;
    RLSubDetail2: TRLSubDetail;
    RLBand10: TRLBand;
    RLBand11: TRLBand;
    RLLabel34: TRLLabel;
    RLHTMLFilter1: TRLHTMLFilter;
    RLLabel12: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel1: TRLLabel;
    RLLabel3: TRLLabel;
    procedure lNomeFantasiaBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel1BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel2BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure RLLabel4BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel5BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure imgLogoBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLLabel13BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLMemo1BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel17BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel18BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel19BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel20BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rlReportA4DataRecord(Sender: TObject; RecNo, CopyNo: Integer;
      var Eof: Boolean; var RecordAction: TRLRecordAction);
    procedure RLLabel22BeorePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel23BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure subItensDataRecord(Sender: TObject; RecNo, CopyNo: Integer;
      var Eof: Boolean; var RecordAction: TRLRecordAction);
    procedure RLSubDetail1DataRecord(Sender: TObject; RecNo, CopyNo: Integer;
      var Eof: Boolean; var RecordAction: TRLRecordAction);
    procedure RLLabel27BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel28BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel30BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLBand8BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLSubDetail2DataRecord(Sender: TObject; RecNo, CopyNo: Integer;
      var Eof: Boolean; var RecordAction: TRLRecordAction);
    procedure RLLabel31BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLBand10BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLMemo2BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel33BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel37BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLMemo3BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rlbConsumidorBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rlbRodapeBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure lSistemaBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel35BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel32BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rldescontodanfBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel9BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel10BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel11BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel14BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel15BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel12BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RlDescontoBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel24BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel25BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel26BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel29BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rlReportA4AfterPrint(Sender: TObject);
    procedure lEnderecoConsumidorBeforePrint(Sender: TObject;
      var Text: String; var PrintIt: Boolean);
    procedure RLLabel8BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel7BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel3BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel16BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
  private
    FNumItem: Integer;
    FNumPag: Integer;
    FACBrNFeDANFCeFortesA4: TACBrNFeDANFCeFortesPC;
    FFiltro: TACBrNFeDANFCeFortesA4Filtro;
    FResumido: Boolean;
    function CompoemEnderecoCFe: String ;
    procedure PintarQRCode(QRCodeData: String; APict: TPicture);
  protected
    property Filtro   : TACBrNFeDANFCeFortesA4Filtro read FFiltro write FFiltro default fiNenhum ;
    property Resumido : Boolean read FResumido write FResumido;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses RLPrinters, StrUtils, Printers, Estoque;

// 21.10.15
var colunasamenos:integer;

function TfrmACBrDANFCeFortesFrPC.CompoemEnderecoCFe: String;
var
  Endereco, CEP: String;
begin
  with self.FACBrNFeDANFCeFortesA4.FpNFe do
  begin
    // Definindo dados do Cliche //
    Endereco := Emit.EnderEmit.xLgr ;
    if (Emit.EnderEmit.nro <> '') then
      Endereco := Endereco + ', '+Emit.EnderEmit.nro;
    if (Emit.EnderEmit.xCpl <> '') then
      Endereco := Endereco + ' - '+Emit.EnderEmit.xCpl;
    if (Emit.EnderEmit.xBairro <> '') then
      Endereco := Endereco + ' - '+Emit.EnderEmit.xBairro;
    if (Emit.EnderEmit.xMun <> '') then
      Endereco := Endereco + ' - '+Emit.EnderEmit.xMun;
    if (Emit.EnderEmit.UF <> '') then
      Endereco := Endereco + ' - '+Emit.EnderEmit.UF;
    if (Emit.EnderEmit.CEP <> 0) then
    begin
      CEP := IntToStr(Emit.EnderEmit.CEP);
      Endereco := Endereco + ' - '+copy(CEP,1,5)+'-'+copy(CEP,6,3);
    end;
    if (Emit.EnderEmit.fone <> '') then
      Endereco := Endereco + ' - FONE: '+Emit.EnderEmit.fone;
  end;

  Result := Endereco;
end;

procedure TfrmACBrDANFCeFortesFrPC.FormCreate(Sender: TObject);
begin
  FACBrNFeDANFCeFortesA4          := TACBrNFeDANFCeFortesPC(Owner) ;  // Link para o Pai

  //Pega as marges que for defina na classe pai.
  // 03.02.17 - retirado pra pegar o q veio definido no componente em tempo de
  // projeto
//  rlReportA4.Margins.LeftMargin    := FACBrNFeDANFCeFortesA4.MargemEsquerda ;
//  rlReportA4.Margins.RightMargin   := FACBrNFeDANFCeFortesA4.MargemDireita ;
//  rlReportA4.Margins.TopMargin     := FACBrNFeDANFCeFortesA4.MargemSuperior ;
//  rlReportA4.Margins.BottomMargin  := FACBrNFeDANFCeFortesA4.MargemInferior ;
// 21.10.15
  colunasamenos:=FGeral.GetConfig1asinteger('colunaesqnfcea4');   // 50
end;

procedure TfrmACBrDANFCeFortesFrPC.lNomeFantasiaBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.xFant;
end;

procedure TfrmACBrDANFCeFortesFrPC.lSistemaBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  if trim(self.FACBrNFeDANFCeFortesA4.Sistema) <> '' then
    Text := self.FACBrNFeDANFCeFortesA4.Sistema ;
end;

procedure TfrmACBrDANFCeFortesFrPC.PintarQRCode(QRCodeData: String;
  APict: TPicture);
var
  QRCode: TDelphiZXingQRCode;
  QRCodeBitmap: TBitmap;
  Row, Column: Integer;
begin
  QRCode       := TDelphiZXingQRCode.Create;
  QRCodeBitmap := TBitmap.Create;
  try
    QRCode.Data      := QRCodeData;
    QRCode.Encoding  := qrUTF8NoBOM;
    QRCode.QuietZone := 1;

    //QRCodeBitmap.SetSize(QRCode.Rows, QRCode.Columns);
    QRCodeBitmap.Width  := QRCode.Columns;
    QRCodeBitmap.Height := QRCode.Rows;

    for Row := 0 to QRCode.Rows - 1 do
    begin
      for Column := 0 to QRCode.Columns - 1 do
      begin
        if (QRCode.IsBlack[Row, Column]) then
          QRCodeBitmap.Canvas.Pixels[Column, Row] := clBlack
        else
          QRCodeBitmap.Canvas.Pixels[Column, Row] := clWhite;
      end;
    end;

    APict.Assign(QRCodeBitmap);
  finally
    QRCode.Free;
    QRCodeBitmap.Free;
  end;
end;

procedure TfrmACBrDANFCeFortesFrPC.imgLogoBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  PrintIt := self.FACBrNFeDANFCeFortesA4.Logo <> '';
  if PrintIt then
    imgLogo.Picture.LoadFromFile(self.FACBrNFeDANFCeFortesA4.Logo);
end;

procedure TfrmACBrDANFCeFortesFrPC.RLBand10BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  PrintIt := Trim(self.FACBrNFeDANFCeFortesA4.FpNFe.InfAdic.infCpl) <> '';
//  self.memDadosAdc.Lines.Clear;
//  self.memDadosAdc.Lines.Add(self.FACBrNFeDANFCeFortesA4.FpNFe.InfAdic.infCpl);
end;

procedure TfrmACBrDANFCeFortesFrPC.RLBand8BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
///  PrintIt := self.FACBrNFeDANFCeFortesA4.FpNFe.Total.ICMSTot.vBC > 0;
end;

procedure TfrmACBrDANFCeFortesFrPC.rlbConsumidorBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
{
  with self.FACBrNFeDANFCeFortesA4.FpNFe do
  begin
    if (Dest.idEstrangeiro = '') and
       (Dest.CNPJCPF = '') then
     begin
        lCPF_CNPJ_ID.Lines.Text := 'CONSUMIDOR N�O IDENTIFICADO';
     end
    else if Dest.idEstrangeiro <> '' then
     begin
       lCPF_CNPJ_ID.Lines.Text  := 'CNPJ/CPF/ID Estrangeiro -'+Dest.idEstrangeiro+' '+Dest.xNome;
     end
    else
     begin
       if Length(trim(Dest.CNPJCPF)) > 11 then
          lCPF_CNPJ_ID.Lines.Text  := 'CNPJ/CPF/ID Estrangeiro -'+FGeral.Formatacnpjcpf(Dest.CNPJCPF)
       else
          lCPF_CNPJ_ID.Lines.Text  := 'CNPJ/CPF/ID Estrangeiro -'+FGeral.Formatacnpjcpf(Dest.CNPJCPF);

       lCPF_CNPJ_ID.Lines.Text  := lCPF_CNPJ_ID.Caption+' '+Dest.xNome;
     end;
     lEnderecoConsumidor.Lines.Text := Trim(Dest.EnderDest.xLgr)+' '+
                                       Trim(Dest.EnderDest.nro)+' '+
                                       Trim(Dest.EnderDest.xCpl)+' '+
                                       Trim(Dest.EnderDest.xBairro)+' '+
                                       Trim(Dest.EnderDest.xMun);
  end;
  }
end;

procedure TfrmACBrDANFCeFortesFrPC.rlbRodapeBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
var
  qrcode: String;
begin
  with self.FACBrNFeDANFCeFortesA4.FpNFe do
  begin
//  {
    qrcode := TACBrNFe(self.FACBrNFeDANFCeFortesA4.ACBrNFe).GetURLQRCode( ide.cUF, ide.tpAmb,
                                     OnlyNumber(InfNFe.ID),  //correcao para pegar somente numeros, estava indo junto o NFE
                                     ifthen(Dest.idEstrangeiro <> '',Dest.idEstrangeiro, OnlyNumber(Dest.CNPJCPF)),
                                     ide.dEmi,
                                     Total.ICMSTot.vNF, Total.ICMSTot.vICMS,
                                     signature.DigestValue,0);
//                                     }
                                     {
    qrcode := NotaUtil.GetURLQRCode( ide.cUF, ide.tpAmb,
                                     OnlyNumber(InfNFe.ID),  //correcao para pegar somente numeros, estava indo junto o NFE
                                     DFeUtil.SeSenao(Dest.idEstrangeiro <> '',Dest.idEstrangeiro, OnlyNumber(Dest.CNPJCPF)),
                                     ide.dEmi,
                                     Total.ICMSTot.vNF, Total.ICMSTot.vICMS,
                                     signature.DigestValue,
                                     '',
                                     '');
                                      }
//    PintarQRCode( qrcode, imgQRCode.Picture );

//    lProtocolo.Caption := ACBrStr('Protocolo de Autoriza��o: '+procNFe.nProt+
//                           ' '+ifthen(procNFe.dhRecbto<>0,DateTimeToStr(procNFe.dhRecbto),''));
  end;
end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel13BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  Text := self.FACBrNFeDANFCeFortesA4.FpNFe.Det[self.FNumItem].Prod.cProd;
  Text := FormatFloat(',0.00##', self.FACBrNFeDANFCeFortesA4.FpNFe.Total.ICMSTot.vBC);
end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel17BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//   if self.FACBrNFeDANFCeFortesA4.FpNFe.pag.count>3 then
//     Text:=FEstoque.GetDescricao(self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Items[3].cAut);
end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel18BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//   if self.FACBrNFeDANFCeFortesA4.FpNFe.pag.count>4 then
//     Text:=FEstoque.GetDescricao(self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Items[4].cAut);
end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel19BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
 //  if self.FACBrNFeDANFCeFortesA4.FpNFe.pag.count>4 then
 //    Text := FormatFloat(',0.00##', self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Items[4].vPag);
end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel1BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  Text := FormatFloat(',0.00##',   self.FACBrNFeDANFCeFortesA4.FpNFe.Total.ICMSTot.vProd -
 //                                 self.FACBrNFeDANFCeFortesA4.FpNFe.Total.ICMSTot.vBC);

end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel20BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  RlLabel20.Left:=RlLabel20.Left-colunasamenos;
 // Text := FormatFloat('R$ ,0.00##', self.FACBrNFeDANFCeFortesA4.FpNFe.Det[self.FNumItem].Prod.vProd);
end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel22BeorePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  Text := FormatFloat(',0', self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Count);
  Text := FormatFloat(' ,0.00; -,0.00', self.FACBrNFeDANFCeFortesA4.FpNFe.Total.ICMSTot.vBC);
end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel23BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  RlLabel23.Left:=Rllabel23.Left-colunasamenos;
  Text := FormatFloat('R$ ,0.00;R$ -,0.00', self.FACBrNFeDANFCeFortesA4.FpNFe.Total.ICMSTot.vNF);
end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel27BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  RlLabel27.Left:=Rllabel27.Left-colunasamenos;
 // Text := ACBrStr(FormaPagamentoToDescricao(self.FACBrNFeDANFCeFortesA4.FpNFe.pag[self.FNumPag].tPag));
end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel28BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  RlLabel28.Left:=Rllabel28.Left-colunasamenos;
//  Text := FormatFloat('R$ ,0.00', self.FACBrNFeDANFCeFortesA4.FpNFe.pag[self.FNumPag].vPag);
end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel2BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.xNome;
end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel30BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  RlLabel30.Left:=Rllabel30.Left-colunasamenos;
//  Text := FormatFloat('R$ ,0.00', self.FACBrNFeDANFCeFortesA4.vTroco);
end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel31BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  RlLabel31.Left:=Rllabel31.Left-colunasamenos;

//  Text := Text + ' ' + FormatFloat('R$ ,0.00', self.FACBrNFeDANFCeFortesA4.FpNFe.Total.ICMSTot.vTotTrib);
//  if Trim(self.FACBrNFeDANFCeFortesA4.FonteTributos) <> '' then
//    Text := Text + ' - ' + self.FACBrNFeDANFCeFortesA4.FonteTributos
end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel32BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
   {
  if self.FACBrNFeDANFCeFortesA4.FpNFe.Ide.tpAmb = taHomologacao then
    Text := ACBrStr('EMITIDA EM AMBIENTE DE HOMOLOGA��O - SEM VALOR FISCAL')
  else
    begin
      if self.FACBrNFeDANFCeFortesA4.FpNFe.Ide.tpEmis <> teNormal then
         Text := ACBrStr('EMITIDA EM CONTING�NCIA')
      else
         Text := ACBrStr('�REA DE MENSAGEM FISCAL');
    end;
    }
end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel33BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  Text := 'N�mero '   + FormatFloat(',0', self.FACBrNFeDANFCeFortesA4.FpNFe.Ide.cNF) +
//         '  - ' + FormatDateTime('dd/MM/yyyy', self.FACBrNFeDANFCeFortesA4.FpNFe.Ide.dEmi);
end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel35BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  ACBrStr('Consulte pela Chave de Acesso em '+ TACBrNFe(self.FACBrNFeDANFCeFortesA4.ACBrNFe).GetURLConsultaNFCe(self.FACBrNFeDANFCeFortesA4.FpNFe.Ide.cUF,self.FACBrNFeDANFCeFortesA4.FpNFe.Ide.tpAmb));
end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel37BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  Text := FormatarChaveAcesso(OnlyNumber(self.FACBrNFeDANFCeFortesA4.FpNFe.infNFe.ID));
  Text := (OnlyNumber(self.FACBrNFeDANFCeFortesA4.FpNFe.infNFe.ID));
end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel3BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := FormatFloat(' ,0.00; -,0.00', Abs(  self.FACBrNFeDANFCeFortesA4.FpNFe.Total.ICMSTot.vProd -
                                  self.FACBrNFeDANFCeFortesA4.FpNFe.Total.ICMSTot.vBC ) );

end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel4BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  RlLabel4.Left:=Rllabel4.Left-colunasamenos;

//  PrintIt := Trim(self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.IM) <> '';
//  Text    := 'Inscri��o Municipal: ' + self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.IM;
//   Text := FormatFloat(',0.00##', self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Items[0].vPag);
end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel5BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//   if self.FACBrNFeDANFCeFortesA4.FpNFe.pag.count>1 then
//     Text:=FEstoque.GetDescricao(self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Items[1].cAut);

end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel7BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.CNPJCPF;

end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel8BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
     Text := FGeral.FormataData( self.FACBrNFeDANFCeFortesA4.FpNFe.Ide.demi );

end;

procedure TfrmACBrDANFCeFortesFrPC.RLMemo1BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  RlMemo1.Width:=RlMemo1.Width-colunasamenos;
//  Text := self.FACBrNFeDANFCeFortesA4.FpNFe.Det[self.FNumItem].Prod.xProd;
end;

procedure TfrmACBrDANFCeFortesFrPC.RLMemo2BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := self.FACBrNFeDANFCeFortesA4.FpNFe.InfAdic.infCpl;
end;

procedure TfrmACBrDANFCeFortesFrPC.RLMemo3BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  Text := CompoemEnderecoCFe;
end;

procedure TfrmACBrDANFCeFortesFrPC.rlReportA4DataRecord(Sender: TObject; RecNo,
  CopyNo: Integer; var Eof: Boolean; var RecordAction: TRLRecordAction);
begin
  Eof := (RecNo > 1);
  RecordAction := raUseIt;
end;

procedure TfrmACBrDANFCeFortesFrPC.RLSubDetail1DataRecord(Sender: TObject;
  RecNo, CopyNo: Integer; var Eof: Boolean; var RecordAction: TRLRecordAction);
begin
  FNumPag := RecNo - 1 ;

  Eof := (RecNo > self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Count) ;
  RecordAction := raUseIt ;
end;

procedure TfrmACBrDANFCeFortesFrPC.RLSubDetail2DataRecord(Sender: TObject;
  RecNo, CopyNo: Integer; var Eof: Boolean; var RecordAction: TRLRecordAction);
begin
  Eof := (RecNo > 1);
  RecordAction := raUseIt ;
end;

procedure TfrmACBrDANFCeFortesFrPC.subItensDataRecord(Sender: TObject; RecNo,
  CopyNo: Integer; var Eof: Boolean; var RecordAction: TRLRecordAction);
begin
  FNumItem := RecNo - 1 ;

  Eof := (RecNo > self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Count) ;
  RecordAction := raUseIt ;
end;

{ TACBrNFeDANFCeFortesA4 }

constructor TACBrNFeDANFCeFortesPC.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  self.MargemEsquerda := 10;
  self.MargemEsquerda := 01;
  self.MargemDireita  := 25;
  self.MargemSuperior := 10;
  self.MargemInferior := 02;

//  self.MargemSuperior := 05;
//  self.MargemInferior := 05;
end;

destructor TACBrNFeDANFCeFortesPC.Destroy;
begin

  inherited;
end;

procedure TACBrNFeDANFCeFortesPC.Imprimir(const DanfeResumido: Boolean; const AFiltro: TACBrNFeDANFCeFortesA4Filtro);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var
  frACBrNFeDANFCeFortesFr: TfrmACBrDANFCeFortesFrPC;
  RLLayout: TRLReport;
  RLFiltro: TRLCustomSaveFilter;
  p:byte;
  xfontename:string;
begin
  {$IFDEF FPC}
   LoadPortugueseStrings;
  {$ENDIF}

  frACBrNFeDANFCeFortesFr := TfrmACBrDANFCeFortesFrPC.Create(Self);
  try
    with frACBrNFeDANFCeFortesFr do
    begin
      Filtro := AFiltro;
      RLLayout := rlReportA4;
      Resumido := DanfeResumido;

      RLPrinter.Copies     := NumCopias ;
// 27.10.15 - nao 'fununcia'
///      FACBrNFeDANFCeFortesA4.ProdutosPorPagina:=50;

      if FACBrNFeDANFCeFortesA4.Impressora <> '' then
        RLPrinter.PrinterName := FACBrNFeDANFCeFortesA4.Impressora;

      RLLayout.PrintDialog := FACBrNFeDANFCeFortesA4.MostraPreview;
      RLLayout.ShowProgress:= False ;
// 17.10.15
/////////////////////////////
      if Printer.Fonts.IndexOf('Arial') >=0 then
         xfontename:='Arial'
      else if Printer.Fonts.IndexOf('Comic Sans MS') >=0 then
         xfontename:='Comic Sans MS'
      else if Printer.Fonts.IndexOf('Courier') >= 0 then
         xfontename:='Courier';
////      showmessage( 'Fonte � '+xfontename );
/////////////////////////////////////////////////
      if FGeral.GetConfig1asinteger('nfcemargemdir') > 0 then rlReportA4.Margins.RightMargin:=FGeral.GetConfig1asinteger('nfcemargemdir');
      if FGeral.GetConfig1asinteger('nfcemargemesq') > 0  then rlReportA4.Margins.LeftMargin:=FGeral.GetConfig1asinteger('nfcemargemesq');
      if FGeral.GetConfig1asinteger('tamfontenfcea4') > 0 then begin
        for p:=0 to frACBrNFeDANFCeFortesFr.ComponentCount-1 do begin
          if  frACBrNFeDANFCeFortesFr.Components[p] is TRLLabel then begin
            TRLLabel(frACBrNFeDANFCeFortesFr.Components[p]).Font.Size:=FGeral.GetConfig1asinteger('tamfontenfcea4');
            TRLLabel(frACBrNFeDANFCeFortesFr.Components[p]).Font.Name:=xfontename;
          end else if frACBrNFeDANFCeFortesFr.Components[p] is TRLMemo then begin
            TRLMemo(frACBrNFeDANFCeFortesFr.Components[p]).Font.Size:=FGeral.GetConfig1asinteger('tamfontenfcea4');
            TRLMemo(frACBrNFeDANFCeFortesFr.Components[p]).Font.Name:=xfontename;
          end;
        end;
      end;
/////////////////////////////

      if Filtro = fiNenhum then
      begin
        if MostraPreview then
          RLLayout.PreviewModal
        else
          RLLayout.Print;
      end
      else
      begin
        if RLLayout.Prepare then
        begin
          case Filtro of
            fiPDF  : RLFiltro := RLPDFFilter1;
            fiHTML : RLFiltro := RLHTMLFilter1;
          else
            exit ;
          end ;

          {$IFDEF FPC}
          RLFiltro.Copies := NumCopias ;
          {$ENDIF}

          RLFiltro.ShowProgress := FACBrNFeDANFCeFortesA4.MostraStatus;
          RLFiltro.FileName := FACBrNFeDANFCeFortesA4.PathPDF + OnlyNumber(FACBrNFeDANFCeFortesA4.FpNFe.infNFe.ID) + '-nfe.pdf';

          {$IFDEF FPC}
          RLFiltro.Pages := RLLayout.Pages ;
          RLFiltro.FirstPage := 1;
          RLFiltro.LastPage := RLLayout.Pages.PageCount;
          RLFiltro.Run;
          {$ELSE}
          RLFiltro.FilterPages( RLLayout.Pages );
          {$ENDIF}
        end;
      end;
// 24.10.15
//      corte do papel
    end;
  finally
    frACBrNFeDANFCeFortesFr.Free ;
  end;
end;

procedure TACBrNFeDANFCeFortesPC.ImprimirDANFE(NFE: TNFe);
begin
  if NFe = nil then
   begin
     if not Assigned(ACBrNFe) then
        raise Exception.Create('Componente ACBrNFe n�o atribu��do');

     FpNFe := TACBrNFe(ACBrNFe).NotasFiscais.Items[0].NFe;
   end
  else
    FpNFe := NFE;

  Imprimir(False);
end;

procedure TACBrNFeDANFCeFortesPC.ImprimirDANFEPDF(NFE: TNFe);
begin
  if NFe = nil then
   begin
     if not Assigned(ACBrNFe) then
        raise Exception.Create('Componente ACBrNFe n�o atribu��do');

     FpNFe := TACBrNFe(ACBrNFe).NotasFiscais.Items[0].NFe;
   end
  else
    FpNFe := NFE;
  Imprimir(False, fiPDF);
end;

procedure TACBrNFeDANFCeFortesPC.ImprimirDANFEResumido(NFE: TNFe);
begin
  if NFe = nil then
   begin
     if not Assigned(ACBrNFe) then
        raise Exception.Create('Componente ACBrNFe n�o atribu��do');

     FpNFe := TACBrNFe(ACBrNFe).NotasFiscais.Items[0].NFe;
   end
  else
    FpNFe := NFE;

  Imprimir(True);
end;

procedure TACBrNFeDANFCeFortesPC.ImprimirDANFEResumidoPDF(NFE: TNFe);
begin
  if NFe = nil then
   begin
     if not Assigned(ACBrNFe) then
        raise Exception.Create('Componente ACBrNFe n�o atribu��do');

     FpNFe := TACBrNFe(ACBrNFe).NotasFiscais.Items[0].NFe;
   end
  else
    FpNFe := NFE;

  Imprimir(True, fiPDF);
end;

procedure TfrmACBrDANFCeFortesFrPC.rldescontodanfBeforePrint(Sender: TObject; var Text: String; var PrintIt: Boolean);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
begin
//  RlDescontodanf.Left:=RlDescontodanf.Left-colunasamenos;
  Text := FormatFloat('R$ ,0.00;R$ -,0.00', self.FACBrNFeDANFCeFortesA4.FpNFe.Total.ICMSTot.vDesc);

//    'rldescontodanf'
end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel9BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  Rllabel9.Left:=RlLabel9.Left-colunasamenos;

end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel10BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  Rllabel10.Left:=RlLabel10.Left-colunasamenos;
  Text := FormatFloat(',0.00##',   self.FACBrNFeDANFCeFortesA4.FpNFe.Total.ICMSTot.vProd );


end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel11BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
   if self.FACBrNFeDANFCeFortesA4.FpNFe.pag.count>2 then
     Text:=FEstoque.GetDescricao(self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Items[2].cAut);

end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel14BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  Rllabel14.Left:=RlLabel14.Left-colunasamenos;
   if self.FACBrNFeDANFCeFortesA4.FpNFe.pag.count>2 then
     Text := FormatFloat(',0.00##', self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Items[2].vPag);

end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel15BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
   if self.FACBrNFeDANFCeFortesA4.FpNFe.pag.count>3 then
     Text := FormatFloat(',0.00##', self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Items[3].vPag);

end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel16BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin

  Text := FormatFloat( ',0.00##', self.FACBrNFeDANFCeFortesA4.FpNFe.Total.ICMSTot.vProd  );

end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel12BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  Rllabel12.Left:=RlLabel12.Left-colunasamenos;
//  Text := FormatFloat(',0.00##', self.FACBrNFeDANFCeFortesA4.FpNFe.Total.ICMSTot.vNF);
  Text := FormatFloat(' ,0.00; -,0.00', self.FACBrNFeDANFCeFortesA4.FpNFe.Total.ICMSTot.vProd);

end;

procedure TfrmACBrDANFCeFortesFrPC.RlDescontoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  RlDesconto.Left:=RlDesconto.Left-colunasamenos;

end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel24BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  RlLabel24.Left:=Rllabel24.Left-colunasamenos;

end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel25BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  RlLabel25.Left:=Rllabel25.Left-colunasamenos;

end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel26BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  RlLabel26.Left:=Rllabel26.Left-colunasamenos;

end;

procedure TfrmACBrDANFCeFortesFrPC.RLLabel29BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  RlLabel29.Left:=Rllabel29.Left-colunasamenos;

end;

procedure TfrmACBrDANFCeFortesFrPC.rlReportA4AfterPrint(Sender: TObject);
begin
//     #27+'w'
//  #27 + #119;   w

end;

procedure TfrmACBrDANFCeFortesFrPC.lEnderecoConsumidorBeforePrint(
  Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
   Text:=#27 + #119;
end;

end.

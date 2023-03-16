unit ACBrDANFCeFortesFrETQEA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ACBrNFeDANFEClass, RLReport, pcnNFe, ACBrNFe,
  RLHTMLFilter, RLFilters, RLPDFFilter, ACBrUtil, pcnConversao, ACBrDFeUtil, ACBrValidador,
  ACBrDelphiZXingQRCode,Geral, RLBarcode;
//  ACBrNfeUtil;

type
  TACBrNFeDANFCeFortesA4Filtro = (fiNenhum, fiPDF, fiHTML ) ;

  TACBrNFeDANFCeFortesETQEA = class(TACBrNFeDANFEClass)
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

  TfrmACBrDANFCeFortesFrETQEA = class(TForm)
    rlReportA4: TRLReport;
    RLBand1: TRLBand;
    RLPDFFilter1: TRLPDFFilter;
    RLHTMLFilter1: TRLHTMLFilter;
    RLBarcode1: TRLBarcode;
    RNomeFantasia: TRLLabel;
    RLote: TRLLabel;
    REndereco: TRLLabel;
    RDescricaoProduto: TRLLabel;
    RPeso: TRLLabel;
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
    procedure RLLabel16BeforePrint(Sender: TObject; var Text: string;
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
    procedure RLLabel3Beforerint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RNomeFantasia1BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLoteBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RDescricaoProdutoBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RTextoPesoBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RPesoBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure REnderecoBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RNomeFantasiaBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLpecasBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
  private
    FNumItem: Integer;
    FNumPag: Integer;
    FACBrNFeDANFCeFortesA4: TACBrNFeDANFCeFortesETQEA;
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

function TfrmACBrDANFCeFortesFrETQEA.CompoemEnderecoCFe: String;
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

procedure TfrmACBrDANFCeFortesFrETQEA.FormCreate(Sender: TObject);
begin
  FACBrNFeDANFCeFortesA4          := TACBrNFeDANFCeFortesETQEA(Owner) ;  // Link para o Pai

  //Pega as marges que for defina na classe pai.
  rlReportA4.Margins.LeftMargin    := FACBrNFeDANFCeFortesA4.MargemEsquerda ;
  rlReportA4.Margins.RightMargin   := FACBrNFeDANFCeFortesA4.MargemDireita ;
  rlReportA4.Margins.TopMargin     := FACBrNFeDANFCeFortesA4.MargemSuperior ;
  rlReportA4.Margins.BottomMargin  := FACBrNFeDANFCeFortesA4.MargemInferior ;

// 21.10.15
  colunasamenos:=FGeral.GetConfig1asinteger('colunaesqnfcea4');   // 50
end;

procedure TfrmACBrDANFCeFortesFrETQEA.lNomeFantasiaBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.xFant;
end;

procedure TfrmACBrDANFCeFortesFrETQEA.lSistemaBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  if trim(self.FACBrNFeDANFCeFortesA4.Sistema) <> '' then
    Text := self.FACBrNFeDANFCeFortesA4.Sistema ;
end;

procedure TfrmACBrDANFCeFortesFrETQEA.PintarQRCode(QRCodeData: String;
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

procedure TfrmACBrDANFCeFortesFrETQEA.imgLogoBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  PrintIt := self.FACBrNFeDANFCeFortesA4.Logo <> '';
//  if PrintIt then
//    imgLogo.Picture.LoadFromFile(self.FACBrNFeDANFCeFortesA4.Logo);
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLBand10BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  PrintIt := Trim(self.FACBrNFeDANFCeFortesA4.FpNFe.InfAdic.infCpl) <> '';
//  self.memDadosAdc.Lines.Clear;
//  self.memDadosAdc.Lines.Add(self.FACBrNFeDANFCeFortesA4.FpNFe.InfAdic.infCpl);
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLBand8BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
////  PrintIt := self.FACBrNFeDANFCeFortesA4.vTroco > 0;
end;

procedure TfrmACBrDANFCeFortesFrETQEA.rlbConsumidorBeforePrint(Sender: TObject;
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

procedure TfrmACBrDANFCeFortesFrETQEA.rlbRodapeBeforePrint(Sender: TObject;
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

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel13BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := self.FACBrNFeDANFCeFortesA4.FpNFe.Det[self.FNumItem].Prod.cProd;
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel16BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  RlLabel16.Left:=RlLabel16.Left-colunasamenos;
  Text := FormatFloat(',0.00##', self.FACBrNFeDANFCeFortesA4.FpNFe.Det[self.FNumItem].Prod.qCom);
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel17BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
   if self.FACBrNFeDANFCeFortesA4.FpNFe.pag.count>3 then
     Text:=FEstoque.GetDescricao(self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Items[3].cAut);
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel18BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
   if self.FACBrNFeDANFCeFortesA4.FpNFe.pag.count>4 then
     Text:=FEstoque.GetDescricao(self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Items[4].cAut);
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel19BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//   if self.FACBrNFeDANFCeFortesA4.FpNFe.pag.count>4 then
//     Text := FormatFloat(',0.00##', self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Items[4].vPag);
end;

// 07.06.16
procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel1BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
////////////////////////////////////////////////////////////////////////////////////
begin
///////  Text := inttostr( self.FACBrNFeDANFCeFortesA4.FpNFe.Det[self.FNumItem].Prod.vseg );
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel20BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  RlLabel20.Left:=RlLabel20.Left-colunasamenos;
  Text := FormatFloat('R$ ,0.00##', self.FACBrNFeDANFCeFortesA4.FpNFe.Det[self.FNumItem].Prod.vProd);
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel22BeorePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := FormatFloat(',0', self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Count);
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel23BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  RlLabel23.Left:=Rllabel23.Left-colunasamenos;
  Text := FormatFloat('R$ ,0.00;R$ -,0.00', self.FACBrNFeDANFCeFortesA4.FpNFe.Total.ICMSTot.vNF);
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel27BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  RlLabel27.Left:=Rllabel27.Left-colunasamenos;
  Text := ACBrStr(FormaPagamentoToDescricao(self.FACBrNFeDANFCeFortesA4.FpNFe.pag[self.FNumPag].tPag));
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel28BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  RlLabel28.Left:=Rllabel28.Left-colunasamenos;
//  Text := FormatFloat('R$ ,0.00', self.FACBrNFeDANFCeFortesA4.FpNFe.pag[self.FNumPag].vPag);
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel2BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  Text := 'CNPJ: ' + FGeral.FormataCNPJ(self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.CNPJCPF);
  if trim(self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.CNPJCPF)<>'' then
//    Text := 'CPF: ' + FGeral.FormataCPF(self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.CNPJCPF);
    Text := FGeral.FormataCPF(self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.CNPJCPF);
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel30BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  RlLabel30.Left:=Rllabel30.Left-colunasamenos;
///////////////  Text := FormatFloat('R$ ,0.00', self.FACBrNFeDANFCeFortesA4.vTroco);
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel31BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  RlLabel31.Left:=Rllabel31.Left-colunasamenos;

//  Text := Text + ' ' + FormatFloat('R$ ,0.00', self.FACBrNFeDANFCeFortesA4.FpNFe.Total.ICMSTot.vTotTrib);
  if Trim(self.FACBrNFeDANFCeFortesA4.FonteTributos) <> '' then
    Text := Text + ' - ' + self.FACBrNFeDANFCeFortesA4.FonteTributos
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel32BeforePrint(Sender: TObject;
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

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel33BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := 'Lote '   + FormatFloat(',0', self.FACBrNFeDANFCeFortesA4.FpNFe.Ide.cNF) +
         '  - ' + FormatDateTime('dd/MM/yyyy', self.FACBrNFeDANFCeFortesA4.FpNFe.Ide.dEmi);
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel35BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  ACBrStr('Consulte pela Chave de Acesso em '+ TACBrNFe(self.FACBrNFeDANFCeFortesA4.ACBrNFe).GetURLConsultaNFCe(self.FACBrNFeDANFCeFortesA4.FpNFe.Ide.cUF,self.FACBrNFeDANFCeFortesA4.FpNFe.Ide.tpAmb));
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel37BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  Text := FormatarChaveAcesso(OnlyNumber(self.FACBrNFeDANFCeFortesA4.FpNFe.infNFe.ID));
  Text := (OnlyNumber(self.FACBrNFeDANFCeFortesA4.FpNFe.infNFe.ID));
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel4BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  RlLabel4.Left:=Rllabel4.Left-colunasamenos;

//  PrintIt := Trim(self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.IM) <> '';
//  Text    := 'Inscri��o Municipal: ' + self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.IM;
//   Text := FormatFloat(',0.00##', self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Items[0].vPag);
   Text := FormatFloat(',0.00##', self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[0].Prod.qCom);
//   RLBarcode1.Caption:= OnlyNumber(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[0].Prod.cEAN);
   RLBarcode1.Caption:= OnlyNumber(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[0].Prod.xped);
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel5BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
   if self.FACBrNFeDANFCeFortesA4.FpNFe.pag.count>1 then
     Text:=FEstoque.GetDescricao(self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Items[1].cAut);

end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLMemo1BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  RlMemo1.Width:=RlMemo1.Width-colunasamenos;
  Text := self.FACBrNFeDANFCeFortesA4.FpNFe.Det[self.FNumItem].Prod.xProd;
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLMemo2BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := self.FACBrNFeDANFCeFortesA4.FpNFe.InfAdic.infCpl;
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLMemo3BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := CompoemEnderecoCFe;
end;

procedure TfrmACBrDANFCeFortesFrETQEA.rlReportA4DataRecord(Sender: TObject; RecNo,
  CopyNo: Integer; var Eof: Boolean; var RecordAction: TRLRecordAction);
begin
  Eof := (RecNo > 1);
  RecordAction := raUseIt;
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLSubDetail1DataRecord(Sender: TObject;
  RecNo, CopyNo: Integer; var Eof: Boolean; var RecordAction: TRLRecordAction);
begin
  FNumPag := RecNo - 1 ;

  Eof := (RecNo > self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Count) ;
  RecordAction := raUseIt ;
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLSubDetail2DataRecord(Sender: TObject;
  RecNo, CopyNo: Integer; var Eof: Boolean; var RecordAction: TRLRecordAction);
begin
  Eof := (RecNo > 1);
  RecordAction := raUseIt ;
end;

procedure TfrmACBrDANFCeFortesFrETQEA.subItensDataRecord(Sender: TObject; RecNo,
  CopyNo: Integer; var Eof: Boolean; var RecordAction: TRLRecordAction);
begin
  FNumItem := RecNo - 1 ;

  Eof := (RecNo > self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Count) ;
  RecordAction := raUseIt ;
end;

{ TACBrNFeDANFCeFortesA4 }

constructor TACBrNFeDANFCeFortesETQEA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  self.MargemEsquerda := 10;
//  self.MargemEsquerda := 01;
//  self.MargemDireita  := 25;
//  self.MargemSuperior := 10;
//  self.MargemInferior := 02;

//  self.MargemSuperior := 05;
//  self.MargemInferior := 05;
end;

destructor TACBrNFeDANFCeFortesETQEA.Destroy;
begin

  inherited;
end;

procedure TACBrNFeDANFCeFortesETQEA.Imprimir(const DanfeResumido: Boolean; const AFiltro: TACBrNFeDANFCeFortesA4Filtro);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var
  frACBrNFeDANFCeFortesFr: TfrmACBrDANFCeFortesFrETQEA;
  RLLayout: TRLReport;
  RLFiltro: TRLCustomSaveFilter;
  p:byte;
  xfontename:string;
begin
  {$IFDEF FPC}
   LoadPortugueseStrings;
  {$ENDIF}

  frACBrNFeDANFCeFortesFr := TfrmACBrDANFCeFortesFrETQEA.Create(Self);
  try
    with frACBrNFeDANFCeFortesFr do
    begin
      Filtro := AFiltro;
      RLLayout := rlReportA4;
      Resumido := DanfeResumido;

      RLPrinter.Copies     := NumCopias ;
// 27.10.15 - nao 'fununcia'
//      FACBrNFeDANFCeFortesA4.ProdutosPorPagina:=50;

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
    end;
  finally
    frACBrNFeDANFCeFortesFr.Free ;
  end;
end;

procedure TACBrNFeDANFCeFortesETQEA.ImprimirDANFE(NFE: TNFe);
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

procedure TACBrNFeDANFCeFortesETQEA.ImprimirDANFEPDF(NFE: TNFe);
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

procedure TACBrNFeDANFCeFortesETQEA.ImprimirDANFEResumido(NFE: TNFe);
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

procedure TACBrNFeDANFCeFortesETQEA.ImprimirDANFEResumidoPDF(NFE: TNFe);
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

procedure TfrmACBrDANFCeFortesFrETQEA.rldescontodanfBeforePrint(Sender: TObject; var Text: String; var PrintIt: Boolean);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
begin
//  RlDescontodanf.Left:=RlDescontodanf.Left-colunasamenos;
  Text := FormatFloat('R$ ,0.00;R$ -,0.00', self.FACBrNFeDANFCeFortesA4.FpNFe.Total.ICMSTot.vDesc);

//    'rldescontodanf'
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel9BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  Rllabel9.Left:=RlLabel9.Left-colunasamenos;

end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel10BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  Rllabel10.Left:=RlLabel10.Left-colunasamenos;

end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel11BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
   if self.FACBrNFeDANFCeFortesA4.FpNFe.pag.count>2 then
     Text:=FEstoque.GetDescricao(self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Items[2].cAut);

end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel14BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  Rllabel14.Left:=RlLabel14.Left-colunasamenos;
//   if self.FACBrNFeDANFCeFortesA4.FpNFe.pag.count>2 then
//     Text := FormatFloat(',0.00##', self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Items[2].vPag);

end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel15BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//   if self.FACBrNFeDANFCeFortesA4.FpNFe.pag.count>3 then
//     Text := FormatFloat(',0.00##', self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Items[3].vPag);

end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel12BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  Rllabel12.Left:=RlLabel12.Left-colunasamenos;
  Text := FormatFloat(',0.00##', self.FACBrNFeDANFCeFortesA4.FpNFe.Total.ICMSTot.vNF);

end;

procedure TfrmACBrDANFCeFortesFrETQEA.RlDescontoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  RlDesconto.Left:=RlDesconto.Left-colunasamenos;

end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel24BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  RlLabel24.Left:=Rllabel24.Left-colunasamenos;

end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel25BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  RlLabel25.Left:=Rllabel25.Left-colunasamenos;

end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel26BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  RlLabel26.Left:=Rllabel26.Left-colunasamenos;

end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel29BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  RlLabel29.Left:=Rllabel29.Left-colunasamenos;

end;

procedure TfrmACBrDANFCeFortesFrETQEA.rlReportA4AfterPrint(Sender: TObject);
begin
//     #27+'w'
//  #27 + #119;   w

end;

procedure TfrmACBrDANFCeFortesFrETQEA.lEnderecoConsumidorBeforePrint(
  Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
   Text:=#27 + #119;
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLLabel3Beforerint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//   Text:=FEstoque.GetDescricao(self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Items[0].cAut);
   Text:=self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[0].Prod.xProd;
end;

// 07.06.16
procedure TfrmACBrDANFCeFortesFrETQEA.RNomeFantasia1BeforePrint(
  Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
  Text := self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.xFant;

end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLoteBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Lote '   + FormatFloat(',0', self.FACBrNFeDANFCeFortesA4.FpNFe.Ide.cNF) +
         '  - ' + FormatDateTime('dd/MM/yyyy', self.FACBrNFeDANFCeFortesA4.FpNFe.Ide.dEmi);

end;

procedure TfrmACBrDANFCeFortesFrETQEA.RLpecasBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
// 20.12.17 - somente pra etiqueta na embalagem desossa
  if self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[0].Prod.nItem>1 then
    Text := FormatFloat(',0.00##', self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[0].Prod.nItem)+' pe�as';


end;

procedure TfrmACBrDANFCeFortesFrETQEA.RDescricaoProdutoBeforePrint(
  Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
   Text:=self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[0].Prod.xProd;

end;

procedure TfrmACBrDANFCeFortesFrETQEA.RTextoPesoBeforePrint(
  Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
   Text:='Peso';
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RPesoBeforePrint(
  Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
//   Text := FormatFloat(',0.00##', self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[0].Prod.qCom);
// 12.07.18
   Text := FormatFloat('###0', self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[0].Prod.qCom);
//   RLBarcode1.Caption:= OnlyNumber(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[0].Prod.cEAN);
   RLBarcode1.Caption:= OnlyNumber(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[0].Prod.xped);

end;

procedure TfrmACBrDANFCeFortesFrETQEA.REnderecoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
   Text := self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.EnderEmit.xLgr;
end;

procedure TfrmACBrDANFCeFortesFrETQEA.RNomeFantasiaBeforePrint(
  Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
  Text := self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.xFant;

end;

end.

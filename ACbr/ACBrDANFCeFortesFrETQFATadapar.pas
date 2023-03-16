unit ACBrDANFCeFortesFrETQFATadapar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ACBrNFeDANFEClass, RLReport, pcnNFe, ACBrNFe,
  RLHTMLFilter, RLFilters, RLPDFFilter, ACBrUtil, pcnConversao, ACBrDFeUtil, ACBrValidador,
  ACBrDelphiZXingQRCode,Geral, RLBarcode, Sqlfun, Vcl.Imaging.jpeg, AcbrDFeReport,
  ACBrImage;
//  ACBrNfeUtil;

type
  TACBrNFeDANFCeFortesA4Filtro = (fiNenhum, fiPDF, fiHTML ) ;

  TACBrNFeDANFCeFortesETQFATAdapar = class(TACBrNFeDANFEClass)
  private
    FpNFe : TNFe;
    procedure Imprimir(const DanfeResumido : Boolean = False; const AFiltro : TACBrNFeDANFCeFortesA4Filtro = fiNenhum);
  public
    procedure ImprimirDANFE(NFE : TNFe = nil ); override ;
    procedure ImprimirDANFEResumido(NFE : TNFe = nil); override ;
    procedure ImprimirDANFEPDF(NFE : TNFe = nil); override;
    procedure ImprimirDANFEResumidoPDF(NFE : TNFe = nil);override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TfrmACBrDANFCeFortesFrETQFATadapar = class(TForm)
    rlReportA4: TRLReport;
    RLPDFFilter1: TRLPDFFilter;
    RLSubDetail2: TRLSubDetail;
    RLHTMLFilter1: TRLHTMLFilter;
    rlbConsumidor: TRLBand;
    RLBarcode1: TRLBarcode;
    Labelingr01: TRLLabel;
    LabelIngr02: TRLLabel;
    Labelingr03: TRLLabel;
    LabelIngr04: TRLLabel;
    LabelIngr05: TRLLabel;
    valorproteina: TRLLabel;
    valorgordtotais: TRLLabel;
    labelFibraalimentar: TRLLabel;
    labelfibra: TRLLabel;
    labelsodio: TRLLabel;
    valorsodio: TRLLabel;
    Labelvalidade: TRLLabel;
    LabelData: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLPanel1: TRLPanel;
    RLLabel3: TRLLabel;
    Rllote: TRLLabel;
    rlpercproteira: TRLLabel;
    rlpercgordurastotais: TRLLabel;
    rlpercfibraalimentar: TRLLabel;
    rlpercsodio: TRLLabel;
    rlperccarboidratos: TRLLabel;
    rlpercvalorenergetico: TRLLabel;
    rlvalorgordsaturadas: TRLLabel;
    rlgordurassat: TRLLabel;
    rlgordsaturadas: TRLLabel;
    RlImageqrcode: TRLImage;
    rlnomeprodutor: TRLLabel;
    rlabelprodutor: TRLLabel;
    RLLabel8: TRLLabel;
    rlpesopeca: TRLLabel;
    rlpeso: TRLLabel;
    rllabelproduto: TRLLabel;
    rlpesoemba: TRLLabel;
    rlnroadapar: TRLLabel;
    RLBarcode2: TRLBarcode;
    RLPanel2: TRLPanel;
    RLLabel5: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel17: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel22: TRLLabel;
    RLLabel23: TRLLabel;
    RLLabel24: TRLLabel;
    RLLabel25: TRLLabel;
    RLLabel26: TRLLabel;
    RLLabel27: TRLLabel;
    RLLabel28: TRLLabel;
    RLLabel29: TRLLabel;
    RLLabel30: TRLLabel;
    RLLabel31: TRLLabel;
    RLLabel32: TRLLabel;
    RLLabel33: TRLLabel;
    RLLabel34: TRLLabel;
    RLLabel35: TRLLabel;
    RLLabel36: TRLLabel;
    RLImage1: TRLImage;
    RLLabel37: TRLLabel;
    RLLabel1: TRLLabel;
    RLLabel38: TRLLabel;
    RLLabel39: TRLLabel;
    RLLabel40: TRLLabel;
    RLLabel41: TRLLabel;
    rlordem: TRLLabel;
    RLLabel42: TRLLabel;
    procedure lNomeFantasiaBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
// 17.07.18
    procedure pesochupeta(Sender: TObject;
       var Text: string; var PrintIt: Boolean);
    procedure pesopeca(Sender: TObject;
       var Text: string; var PrintIt: Boolean);

    procedure Labelingr03BeforePrint(Sender: TObject; var Text: string;
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
    procedure Labelingr01BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure LabelIngr02BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure LabelIngr04BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure LabelIngr05BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure valorproteinaBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure valorgordtotaisBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure labelFibraalimentarBeforePrint(Sender: TObject;
      var Text: String; var PrintIt: Boolean);
    procedure labelfibraBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure labelsodioBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure valorsodioBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure LabelvalidadeBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure LabelDataBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLMatadouroBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel6BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel7BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel8BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RlloteBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rlpercproteiraBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rlpercgordurastotaisBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rlpercfibraalimentarBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rlpercsodioBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rlperccarboidratosBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rlpercvalorenergeticoBeforePrint(Sender: TObject;
      var Text: string; var PrintIt: Boolean);
    procedure rlgordurassatBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rlvalorgordsaturadasBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rlgordsaturadasBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RlImageqrcodeBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RltitulorastreamentoBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLAnglerastreamentoBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rlpesoBeforePrint(Sender: TObject; var AText: string;
      var PrintIt: Boolean);
    procedure rlabelprodutorBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rldesossaBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllabelprodutoBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rlnroadaparBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel1BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel1AfterPrint(Sender: TObject);
    procedure RLLabel14AfterPrint(Sender: TObject);
    procedure RLLabel17AfterPrint(Sender: TObject);
    procedure RLLabel21BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel22BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel30AfterPrint(Sender: TObject);
    procedure RLLabel34BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLImage1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLImage1AfterPrint(Sender: TObject);
    procedure rlordemBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel42AfterPrint(Sender: TObject);
    procedure RLLabel42BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
  private
    FNumItem: Integer;
    FNumPag: Integer;
    FACBrNFeDANFCeFortesA4: TACBrNFeDANFCeFortesETQFATAdapar;
    FFiltro: TACBrNFeDANFCeFortesA4Filtro;
    FResumido: Boolean;
    function CompoemEnderecoCFe: String ;
// 10.02.20
    function Ebovino( xdescricao:string ):boolean;

    //    procedure PintarQRCode(QRCodeData: String; APict: TPicture);

  protected
    property Filtro   : TACBrNFeDANFCeFortesA4Filtro read FFiltro write FFiltro default fiNenhum ;
    property Resumido : Boolean read FResumido write FResumido;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses RLPrinters, StrUtils, Printers, Estoque, grupos;

// 21.10.15
var colunasamenos:integer;
// 31.12.19
    FItem    : Integer;

function TfrmACBrDANFCeFortesFrETQFATadapar.CompoemEnderecoCFe: String;
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

// 10.02.20
function TfrmACBrDANFCeFortesFrETQFATadapar.Ebovino(  xdescricao: string): boolean;
/////////////////////////////////////////////////////////////////////////////////////////////
begin
  result:=true;
  if ( AnsiPos( 'BORREGO',Uppercase( xdescricao ) ) > 0 )
      or
     ( AnsiPos( 'OVELHA',Uppercase( xdescricao ) ) > 0  )
      or
     ( AnsiPos( 'CABRITO',Uppercase( xdescricao ) ) > 0 )
     or
     ( AnsiPos( 'SUINA',Uppercase( xdescricao ) ) > 0  )
     then
     result:=false;

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.FormCreate(Sender: TObject);
begin
  FACBrNFeDANFCeFortesA4          := TACBrNFeDANFCeFortesETQFATAdapar(Owner) ;  // Link para o Pai

  //Pega as marges que for definida na classe pai.
  rlReportA4.Margins.LeftMargin    := FACBrNFeDANFCeFortesA4.MargemEsquerda ;
  rlReportA4.Margins.RightMargin   := FACBrNFeDANFCeFortesA4.MargemDireita ;
  rlReportA4.Margins.TopMargin     := FACBrNFeDANFCeFortesA4.MargemSuperior ;
  rlReportA4.Margins.BottomMargin  := FACBrNFeDANFCeFortesA4.MargemInferior ;

// 21.10.15
  colunasamenos:=FGeral.GetConfig1asinteger('colunaesqnfcea4');   // 50
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.lNomeFantasiaBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  Text := copy(self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.xFant,1,25);
// 20.07.18 - 23.08.19
  if Self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.ncm<>'' then begin

     if strtointdef( Self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.ncm,0) >0 then

        Text := 'Validade :'+FormatDatetime('dd/mm/yy',Date()+strtoint(Self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.ncm)  )

     else

        Text := 'Validade  :'+FormatDatetime('dd/mm/yy',Date()+10 );

  end else

     Text := 'Validade  :'+FormatDatetime('dd/mm/yy',Date()+10);

end;

// 17.07.18
procedure TfrmACBrDANFCeFortesFrETQFATadapar.pesochupeta(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin

//  Text := copy(self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.xFant,1,25);
  Text := inttostr( self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.nitem);

end;

// 17.07.18
procedure TfrmACBrDANFCeFortesFrETQFATadapar.pesopeca(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin

// 21.09.18
  if ( AnsiPos( 'BORREGO',Uppercase(FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd) ) = 0 )
      and
     ( AnsiPos( 'OVELHA',Uppercase(FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd) ) = 0  )
      and
     ( AnsiPos( 'CABRITO',Uppercase(FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd) ) = 0 )
     and
     ( AnsiPos( 'SUINA',Uppercase(FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd) ) = 0  )
     then

     Text := '/'+inttostr( trunc(FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.qcom) )

  else

     Text := '';

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.lSistemaBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin

//  if trim(self.FACBrNFeDANFCeFortesA4.Sistema) <> '' then
//    Text := self.FACBrNFeDANFCeFortesA4.Sistema ;
// 23.08.19
    Text := 'Sistema SAC - Storolli Cia Ltda';

end;

// 11.12.17
{
procedure TfrmACBrDANFCeFortesFrETQFATadapar.PintarQRCode(QRCodeData: String;  APict: TPicture);
/////////////////////////////////////////////////////////////////////////////////////////////
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

    QRCodeBitmap.SetSize(QRCode.Rows, QRCode.Columns);
    QRCodeBitmap.Width  := QRCode.Columns;
    QRCodeBitmap.Height := QRCode.Rows;

  // 11.12.17
//    QRCodeBitmap.Width  := QRCode.Columns*10;
//    QRCodeBitmap.Height := QRCode.Rows*10;

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
}

procedure TfrmACBrDANFCeFortesFrETQFATadapar.rlabelprodutorBeforePrint(
  Sender: TObject; var Text: string; var PrintIt: Boolean);
begin

  Text := copy(self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.xFant,1,25);

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.imgLogoBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
//  PrintIt := self.FACBrNFeDANFCeFortesA4.Logo <> '';
//  if PrintIt then
//    imgLogo.Picture.LoadFromFile(self.FACBrNFeDANFCeFortesA4.Logo);
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLAnglerastreamentoBeforePrint(
  Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  Text:='RASTREAMENTO';
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLBand10BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  PrintIt := Trim(self.FACBrNFeDANFCeFortesA4.FpNFe.InfAdic.infCpl) <> '';
//  self.memDadosAdc.Lines.Clear;
//  self.memDadosAdc.Lines.Add(self.FACBrNFeDANFCeFortesA4.FpNFe.InfAdic.infCpl);
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLBand8BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
////  PrintIt := self.FACBrNFeDANFCeFortesA4.vTroco > 0;
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.rlbConsumidorBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
{
  with self.FACBrNFeDANFCeFortesA4.FpNFe do
  begin
    if (Dest.idEstrangeiro = '') and
       (Dest.CNPJCPF = '') then
     begin
        lCPF_CNPJ_ID.Lines.Text := 'CONSUMIDOR NÃO IDENTIFICADO';
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

procedure TfrmACBrDANFCeFortesFrETQFATadapar.rlbRodapeBeforePrint(Sender: TObject;
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

//    lProtocolo.Caption := ACBrStr('Protocolo de Autorização: '+procNFe.nProt+
//                           ' '+ifthen(procNFe.dhRecbto<>0,DateTimeToStr(procNFe.dhRecbto),''));
  end;
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel13BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := self.FACBrNFeDANFCeFortesA4.FpNFe.Det[self.FNumItem].Prod.cProd;
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel16BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin

   if (FItem+1<=self.FACBrNFeDANFCeFortesA4.FpNFe.Det.count-1)
      and
     ( EBovino(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd) ) then

       Text:=strspace('Vlr Energético',15)+FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.vUnTrib)+' Kcal'

    else

       Text:=strspace('Vlr Energético',15)+FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vUnTrib)+' Kcal';

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel17AfterPrint(
  Sender: TObject);
begin

end;

// 03.01.29
procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel17BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin

   if (FItem+1<=self.FACBrNFeDANFCeFortesA4.FpNFe.Det.count-1)
      and
      ( EBovino(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd) ) then

      Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.vUnTrib/2000*100)

    else

      Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vUnTrib/2000*100);

end;

// 03.01.20
procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel18BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin

   if (FItem+1<=self.FACBrNFeDANFCeFortesA4.FpNFe.Det.count-1)
      and
      ( EBovino(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd) ) then

      Text:=strspace('Carboidratos',20)+FormatFloat('##0.00',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.vfrete)+' g'

   else

      Text:=strspace('Carboidratos',20)+FormatFloat('##0.00',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vfrete)+' g';

end;

// 03.01.20
procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel19BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin

   if (FItem+1<=self.FACBrNFeDANFCeFortesA4.FpNFe.Det.count-1)
      and
     ( EBovino(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd) ) then

      Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.vfrete/300*100)

   else

      Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vfrete/300*100);

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel1AfterPrint(
  Sender: TObject);
begin

end;

// 31.12.19
procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel1BeforePrint(
  Sender: TObject; var Text: string; var PrintIt: Boolean);
//////////////////////////////////////////////////////////////////////////
begin

   if (FItem+1<=self.FACBrNFeDANFCeFortesA4.FpNFe.Det.count-1)
//      and
//     ( EBovino(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd) )
// 15.05.20
      then begin

       RLBarcode2.Caption:= OnlyNumber(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.xped);
       Text:=self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.xProd;

   end else begin

       RLBarcode2.Caption:= OnlyNumber(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xped);
       Text:=self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd;

   end;

     if length(trim(text))>24 then
       RlLabel1.Font.Size:=10;
     if AnsiPos( 'MEIA CARCAÇA', Uppercase( Text ) ) > 0 then
        Text := 'MEIA CARCAÇA'
     else if AnsiPos( 'QUARTO TRASEIRO', Uppercase( Text ) ) > 0 then
        Text := 'QUARTO TRASEIRO'
     else if AnsiPos( 'QUARTO DIANTEIRO', Uppercase( Text ) ) > 0 then
        Text := 'QUARTO DIANTEIRO'
     else if AnsiPos( 'COSTELA DO TRASEIRO', Uppercase( Text ) ) > 0 then
        Text := 'COSTELA DO TRASEIRO'
     else if AnsiPos( 'LOMBO', Uppercase( Text ) ) > 0 then
        Text := 'LOMBO'
     else if AnsiPos( 'TRASEIRO SERROTE', Uppercase( Text ) ) > 0 then
        Text := 'TRASEIRO SERROTE'
     else if AnsiPos( 'DIANTEIRO SEM PALETA', Uppercase( Text ) ) > 0 then
        Text := 'DIANTEIRO SEM PALETA'
     else if AnsiPos( 'PALETA', Uppercase( Text ) ) > 0 then
        Text := 'PALETA'
     else if AnsiPos( 'PONTA DE AGULHA', Uppercase( Text ) ) > 0 then
        Text := 'PONTA DE AGULHA'
     else if AnsiPos( 'LOMBO-ALCATRA', Uppercase( Text ) ) > 0 then
        Text := 'LOMBO-ALCATRA'
     else if AnsiPos( 'COXÃO BOLA', Uppercase( Text ) ) > 0 then
        Text := 'COXÃO BOLA';


end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLMatadouroBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
   Text:='Matadouro de bovinos, suínos, ovinos e caprinos'
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.LabelDataBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
   Text:='Produção:'+FormatDatetime('dd/mm/yy',Date());

end;

// 07.06.16
procedure TfrmACBrDANFCeFortesFrETQFATadapar.Labelingr03BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
////////////////////////////////////////////////////////////////////////////////////
begin
   Text:=strspace('Carboidratos',20)+FormatFloat('##0.00',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vfrete)+' g';
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel20BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  RlLabel20.Left:=RlLabel20.Left-colunasamenos;
  Text := FormatFloat('R$ ,0.00##', self.FACBrNFeDANFCeFortesA4.FpNFe.Det[self.FNumItem].Prod.vProd);
end;

// 03.01.20
procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel21BeforePrint(
  Sender: TObject; var Text: string; var PrintIt: Boolean);
begin

   if (FItem+1<=self.FACBrNFeDANFCeFortesA4.FpNFe.Det.count-1)
      and
     ( EBovino(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd) ) then

     Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.vfrete/300*100)

   else

     Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vfrete/300*100);

end;

// 03.01.20
procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel22BeforePrint(
  Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
      Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vdesc/75*100);

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel22BeorePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := FormatFloat(',0', self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Count);
end;

// 03.01.20
procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel23BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin

   if (FItem+1<=self.FACBrNFeDANFCeFortesA4.FpNFe.Det.count-1)
      and
     ( EBovino(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd) ) then


     Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.vOUTRO/55*100)

   else

     Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vOUTRO/55*100);

end;

// 03.01.20
procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel27BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin

   if (FItem+1<=self.FACBrNFeDANFCeFortesA4.FpNFe.Det.count-1)
      and
     ( EBovino(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd) ) then

     Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.vUncom)+' g'

   else

     Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vUncom)+' g';

end;

// 03.01.20
procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel28BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin

   if (FItem+1<=self.FACBrNFeDANFCeFortesA4.FpNFe.Det.count-1)
      and
     ( EBovino(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd) ) then

     Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.vUncom/22*100)

   else

     Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vUncom/22*100);

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel2BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  Text := 'CNPJ: ' + FGeral.FormataCNPJ(self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.CNPJCPF);
//  Text := 'CPF: ' + FGeral.FormataCPF(self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.CNPJCPF);
   Text:='DEVE SER PESADO NA PRESENÇA DO CONSUMIDOR';
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel30AfterPrint(
  Sender: TObject);
begin

end;

// 03.01.20
procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel30BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin

   if (FItem+1<=self.FACBrNFeDANFCeFortesA4.FpNFe.Det.count-1)
      and
     ( EBovino(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd) ) then

     Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.qtrib)+' mg'

   else

     Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.qtrib)+' mg';

end;

// 03.01.20
procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel31BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  if Trim(self.FACBrNFeDANFCeFortesA4.FonteTributos) <> '' then
//    Text := Text + ' - ' + self.FACBrNFeDANFCeFortesA4.FonteTributos

   if (FItem+1<=self.FACBrNFeDANFCeFortesA4.FpNFe.Det.count-1)
      and
     ( EBovino(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd) ) then

       Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.vseg)+' g'

   else

      Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vseg)+' g';

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel32BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
   {
  if self.FACBrNFeDANFCeFortesA4.FpNFe.Ide.tpAmb = taHomologacao then
    Text := ACBrStr('EMITIDA EM AMBIENTE DE HOMOLOGAÇÃO - SEM VALOR FISCAL')
  else
    begin
      if self.FACBrNFeDANFCeFortesA4.FpNFe.Ide.tpEmis <> teNormal then
         Text := ACBrStr('EMITIDA EM CONTINGÊNCIA')
      else
         Text := ACBrStr('ÁREA DE MENSAGEM FISCAL');
    end;
    }
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel33BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := 'Número '   + FormatFloat(',0', self.FACBrNFeDANFCeFortesA4.FpNFe.Ide.cNF) +
         '  - ' + FormatDateTime('dd/MM/yyyy', self.FACBrNFeDANFCeFortesA4.FpNFe.Ide.dEmi);
end;

// 03.01.20
procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel34BeforePrint(
  Sender: TObject; var Text: string; var PrintIt: Boolean);
var destaque:string;

begin

// 04.02.20
   if AnsiPos( 'SUPER',Uppercase(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.CFOP) ) > 0
      then  destaque := ' S' else destaque := '';

   if (FItem+1<=self.FACBrNFeDANFCeFortesA4.FpNFe.Det.count-1)
      and
     ( EBovino(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd) ) then begin

      Text:=self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.xProd;
      if AnsiPos('QUARTO TRASEIRO',Uppercase(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.xProd) ) > 0 then

         Text:=copy(text,16,40) + destaque

      else if AnsiPos('QUARTO DIANTEIRO',Uppercase(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.xProd) ) > 0 then

        Text:=copy(text,17,40) + destaque;

   end else

      Text:=self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd;



//   if length(trim(text))>24 then
//     RlLabel3.Font.Size:=10; // para imprimir menor...

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel35BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  ACBrStr('Consulte pela Chave de Acesso em '+ TACBrNFe(self.FACBrNFeDANFCeFortesA4.ACBrNFe).GetURLConsultaNFCe(self.FACBrNFeDANFCeFortesA4.FpNFe.Ide.cUF,self.FACBrNFeDANFCeFortesA4.FpNFe.Ide.tpAmb));
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel37BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  Text := FormatarChaveAcesso(OnlyNumber(self.FACBrNFeDANFCeFortesA4.FpNFe.infNFe.ID));
  Text := (OnlyNumber(self.FACBrNFeDANFCeFortesA4.FpNFe.infNFe.ID));
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel42AfterPrint(
  Sender: TObject);
begin

end;

// 28.01.20
procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel42BeforePrint(
  Sender: TObject; var Text: string; var PrintIt: Boolean);
begin

   if (FItem+1 <= self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Count-1)
      and
      ( EBovino(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd) )
     then

      Text:=' - '+self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.cest

   else

      Text:=' - '+self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.cest;


end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel4BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  RlLabel4.Left:=Rllabel4.Left-colunasamenos;

//  PrintIt := Trim(self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.IM) <> '';
//  Text    := 'Inscrição Municipal: ' + self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.IM;
//   Text := FormatFloat(',0.00##', self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Items[0].vPag);
//   Text := FormatFloat(',0.00##', self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[0].Prod.qCom);
//   RLBarcode1.Caption:= OnlyNumber(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[0].Prod.cEAN);
//   RLBarcode1.Caption:= OnlyNumber(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[0].Prod.xped);
   Text:='Produto destinado ao Mercado Institucional';
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.rlnroadaparBeforePrint(
  Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
//   Text := '0001 / 0043 - F'; // ver se pega do grupo de produtos
   Text :=  self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].prod.ceantrib+
            '/ 0043 - F'; // ver se pega do grupo de produtos
end;

// 28.01.20
procedure TfrmACBrDANFCeFortesFrETQFATadapar.rlordemBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin

   Text:=' - '+self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.cest;

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.rlperccarboidratosBeforePrint(
  Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
   Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vfrete/300*100);

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel5BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//   if self.FACBrNFeDANFCeFortesA4.FpNFe.pag.count>1 then
//     Text:=FEstoque.GetDescricao(self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Items[1].cAut);
    Text:='INFORMAÇÃO NUTRICIONAL';

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel6BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  if self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.arma.Count>=1 then
    Text:='Porção de '+self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.arma.Items[0].nCano+' gr.'
  else
    Text:='Porção de 100 gr.';
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel7BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
var especie,sexo:string;
begin

//   especie:=FGrupos.GetDescricao( FEstoque.GetGrupo(self.FACBrNFeDANFCeFortesA4.FpNFe.Det[self.FNumItem].Prod.cProd) );
// 29.01.19
   especie:='BOVINO';
   if AnSiPos( 'SUIN',uppercase( self.FACBrNFeDANFCeFortesA4.FpNFe.Det[self.FNumItem].Prod.xProd) ) >0   then
      especie := 'SUINO'
   else if AnSiPos( 'OVELH',uppercase( self.FACBrNFeDANFCeFortesA4.FpNFe.Det[self.FNumItem].Prod.xProd) ) >0   then
      especie := 'OVINO'
   else if AnSiPos( 'BORREG',uppercase( self.FACBrNFeDANFCeFortesA4.FpNFe.Det[self.FNumItem].Prod.xProd) ) >0   then
// 29.10.19
      especie := 'OVINO'
   else if AnSiPos( 'CABRIT',uppercase( self.FACBrNFeDANFCeFortesA4.FpNFe.Det[self.FNumItem].Prod.xProd) ) >0   then
      especie := 'CAPRINO';


//   sexo:=FEstoque.GetCategoria( FEstoque.GetCustoOrigem( self.FACBrNFeDANFCeFortesA4.FpNFe.Det[self.FNumItem].Prod.cProd ) );
// 21.09.18 - pega da proprioa peça devido a mudança na impressao das etiquetas
   sexo:=FEstoque.GetCategoria( self.FACBrNFeDANFCeFortesA4.FpNFe.Det[self.FNumItem].Prod.cProd  );
// 28.10.17
//   sexo:=FEstoque.GetCategoria( self.FACBrNFeDANFCeFortesA4.FpNFe.Det[self.FNumItem].Prod.nItemPed  );

   Text:='Espécie animal :'+especie+'    Sexo: '+sexo;
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel8BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
   Text:=self.FACBrNFeDANFCeFortesA4.FpNFe.Det[self.FNumItem].Prod.uCom;
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLMemo1BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
//  RlMemo1.Width:=RlMemo1.Width-colunasamenos;
  Text := self.FACBrNFeDANFCeFortesA4.FpNFe.Det[self.FNumItem].Prod.xProd;
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLMemo2BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := self.FACBrNFeDANFCeFortesA4.FpNFe.InfAdic.infCpl;
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLMemo3BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := CompoemEnderecoCFe;
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.rlReportA4DataRecord(Sender: TObject; RecNo,
  CopyNo: Integer; var Eof: Boolean; var RecordAction: TRLRecordAction);
begin
  Eof := (RecNo > 1);
  RecordAction := raUseIt;
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLSubDetail1DataRecord(Sender: TObject;
  RecNo, CopyNo: Integer; var Eof: Boolean; var RecordAction: TRLRecordAction);
begin
  FNumPag := RecNo - 1 ;

  Eof := (RecNo > self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Count) ;
  RecordAction := raUseIt ;
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLSubDetail2DataRecord(Sender: TObject;
  RecNo, CopyNo: Integer; var Eof: Boolean; var RecordAction: TRLRecordAction);
begin
  Eof := (RecNo > 1);
  RecordAction := raUseIt ;
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RltitulorastreamentoBeforePrint(
  Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
   Text:='RASTREAMENTO';
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.rlvalorgordsaturadasBeforePrint(
  Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
   Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vUncom)+' g';

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.subItensDataRecord(Sender: TObject; RecNo,
  CopyNo: Integer; var Eof: Boolean; var RecordAction: TRLRecordAction);
begin
  FNumItem := RecNo - 1 ;

  Eof := (RecNo > self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Count) ;
  RecordAction := raUseIt ;
end;


{ TACBrNFeDANFCeFortesA4 }

constructor TACBrNFeDANFCeFortesETQFATAdapar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  self.MargemEsquerda := 10;
{  // 18.08.17 - retirado pois aqui e etiqueta
  self.MargemEsquerda := 01;
  self.MargemDireita  := 25;
  self.MargemSuperior := 10;
  self.MargemInferior := 02;
}
//  self.MargemSuperior := 05;
//  self.MargemInferior := 05;
end;

destructor TACBrNFeDANFCeFortesETQFATAdapar.Destroy;
begin

  inherited;
end;

procedure TACBrNFeDANFCeFortesETQFATAdapar.Imprimir(const DanfeResumido: Boolean; const AFiltro: TACBrNFeDANFCeFortesA4Filtro);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var
  frACBrNFeDANFCeFortesFr: TfrmACBrDANFCeFortesFrETQFATAdapar;
  RLLayout: TRLReport;
  RLFiltro: TRLCustomSaveFilter;
  p:byte;
  xfontename:string;
begin
  {$IFDEF FPC}
   LoadPortugueseStrings;
  {$ENDIF}


  frACBrNFeDANFCeFortesFr := TfrmACBrDANFCeFortesFrETQFATAdapar.Create(Self);
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
////      showmessage( 'Fonte é '+xfontename );
/////////////////////////////////////////////////
       {  // 18.08.17 - retirado pois aqui é pra etiqueta camara fria...
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
      }
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

procedure TACBrNFeDANFCeFortesETQFAtAdapar.ImprimirDANFE(NFE: TNFe );
////////////////////////////////////////////////////////////////////////////////////////////////////////////
var p,
    i,
    inicio,
    fim,
    item0,item1,
    item2,
    fimetq,
    r           :integer;
    primeira    :boolean;

begin

  if NFe = nil then
   begin
     if not Assigned(ACBrNFe) then
        raise Exception.Create('Componente ACBrNFe nÃo atribuído');

     FpNFe := TACBrNFe(ACBrNFe).NotasFiscais.Items[0].NFe;
   end
  else
    FpNFe := NFE;

  primeira := true;

  item0 := 0 ;
  item1 := 0 ;
  item2 := 0 ;
  Fitem := 0 ;
  Fimetq := 2;
  r      := 1;  // 'razao'

  inicio := strtointdef(TACBrNFe(ACBrNFe).NotasFiscais.Items[0].NFe.Transp.vagao,0);
  if inicio = 0 then inicio:=1;
  if Strtointdef( TACBrNFe(ACBrNFe).NotasFiscais.Items[0].NFe.Transp.balsa,0 ) > 0 then

      fim := Strtointdef( TACBrNFe(ACBrNFe).NotasFiscais.Items[0].NFe.Transp.balsa,0)

  else

      fim:=  Strtointdef( TACBrNFe(ACBrNFe).NotasFiscais.Items[0].NFe.InfAdic.infCpl,0);

     if ( AnsiPos( 'BORREGO',Uppercase(FpNFe.Det.Items[FItem].Prod.xProd) ) > 0 )
      or
     ( AnsiPos( 'OVELHA',Uppercase(FpNFe.Det.Items[FItem].Prod.xProd) ) > 0  )
      or
     ( AnsiPos( 'CABRITO',Uppercase(FpNFe.Det.Items[FItem].Prod.xProd) ) > 0 )
     or
     ( AnsiPos( 'SUINA',Uppercase(FpNFe.Det.Items[FItem].Prod.xProd) ) > 0  )
     then begin

     Fimetq := 0;

  //   inicio :=0 ;
  // 15.05.20
//     fim    :=  TACBrNFe(ACBrNFe).NotasFiscais.Items[0].NFe.Det.Count-1;
// 14.03.20
//    fim    :=  0;

  end;  // se nao for bovino

  for i := inicio to fim do begin

    for p := 0 to fimetq do begin

//      if  (i = 1 ) or ( inicio = fim ) then begin
// 24.01.20
      if  ( primeira ) or ( inicio = fim ) then begin

        if p = 0 then begin

          FItem := p;
          item0 := p;
// 10.02.20
//          FItem := i;
//          item0 := i;
          if fimetq = 0 then primeira := false;

        end else if p = 1 then begin

           FItem := 2;
           item1 := 2;

        end else if p = 2 then begin

           FItem := 4;
           item2 := 4;
           primeira :=false;

        end;
                             // 12.02.20
      end else if (i >= 2) or ( fimetq=0 ) then  begin

        if p = 0 then begin
// 28.01.20
           if Fimetq = 0 then begin

// 28.05.20
             if i >=3 then begin

               FItem := i + r ;
               item0 := i + r ;
               r := r + 1;

             end else begin

               FItem := i ;
               item0 := i ;

             end;

           end else begin

             FItem := item0 + 6;
             item0 := item0 + 6;

           end;

        end else if p = 1 then begin

           FItem := item1 + 6;
           item1 := item1 + 6;

        end else if p = 2 then begin

           FItem := item2 + 6;
           item2 := item2 + 6;

        end;

      end;


         Imprimir(False);

    end;

  end;

end;

procedure TACBrNFeDANFCeFortesETQFATAdapar.ImprimirDANFEPDF(NFE: TNFe);
begin
  if NFe = nil then
   begin
     if not Assigned(ACBrNFe) then
        raise Exception.Create('Componente ACBrNFe nÃo atribuí­do');

     FpNFe := TACBrNFe(ACBrNFe).NotasFiscais.Items[0].NFe;
   end
  else
    FpNFe := NFE;
  Imprimir(False, fiPDF);
end;

procedure TACBrNFeDANFCeFortesETQFATAdapar.ImprimirDANFEResumido(NFE: TNFe);
begin
  if NFe = nil then
   begin
     if not Assigned(ACBrNFe) then
        raise Exception.Create('Componente ACBrNFe não atribuí­do');

     FpNFe := TACBrNFe(ACBrNFe).NotasFiscais.Items[0].NFe;
   end
  else
    FpNFe := NFE;

  Imprimir(True);
end;

procedure TACBrNFeDANFCeFortesETQFATAdapar.ImprimirDANFEResumidoPDF(NFE: TNFe);
begin
  if NFe = nil then
   begin
     if not Assigned(ACBrNFe) then
        raise Exception.Create('Componente ACBrNFe nÃo atribuí­do');

     FpNFe := TACBrNFe(ACBrNFe).NotasFiscais.Items[0].NFe;
   end
  else
    FpNFe := NFE;

  Imprimir(True, fiPDF);
end;


procedure TfrmACBrDANFCeFortesFrETQFATadapar.rldescontodanfBeforePrint(Sender: TObject; var Text: String; var PrintIt: Boolean);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
begin
//  RlDescontodanf.Left:=RlDescontodanf.Left-colunasamenos;
  Text := FormatFloat('R$ ,0.00;R$ -,0.00', self.FACBrNFeDANFCeFortesA4.FpNFe.Total.ICMSTot.vDesc);

//    'rldescontodanf'
end;

// 26.09.18
procedure TfrmACBrDANFCeFortesFrETQFATadapar.rldesossaBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin

  if self.FACBrNFeDANFCeFortesA4.FpNFe.Emit.CNPJCPF='DE' then text:='DESOSSA'

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.rlgordsaturadasBeforePrint(
  Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
   Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vUncom/22*100);

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.rlgordurassatBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
   Text:='Gorduras Saturadas';

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel9BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin

//  Text := inttostr( self.FACBrNFeDANFCeFortesA4.FpNFe.Ide.modelo);
  Text := inttostr( self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.nitem);

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.rllabelprodutoBeforePrint(
          Sender: TObject; var Text: string; var PrintIt: Boolean);
var destaque:string;

begin
// 04.01.19
   Text:=self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd;
// 04.02.20
   if AnsiPos( 'SUPER',Uppercase(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.CFOP) ) > 0
      then  destaque := ' S' else destaque := '';

// 29.01.19
   if AnsiPos('QUARTO TRASEIRO',Uppercase(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd) ) > 0 then

      Text:=copy(text,16,40)+destaque

   else if AnsiPos('QUARTO DIANTEIRO',Uppercase(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd) ) > 0 then

      Text:=copy(text,17,40)+destaque;

//   if length(trim(text))>24 then
     RlLabel3.Font.Size:=10; // para imprimir menor...

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RlloteBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
   Text:='Lote         :'+inttostr(self.FACBrNFeDANFCeFortesA4.FpNFe.Ide.cNF);
end;

// 03.01.20
procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLImage1AfterPrint(
  Sender: TObject);
begin

end;

// 03.01.20
procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLImage1BeforePrint(
  Sender: TObject; var PrintIt: Boolean);
begin

    if  ( EBovino(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd) )
        and  ( FItem+1 <= FACBrNFeDANFCeFortesA4.FpNFe.Det.Count-1 )
        then

//       PintarQRCode( self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.cean, RLImage1.Picture, qrUTF8NoBOM )
// 28.07.20
       PintarQRCode( self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.cean,TBitMap( RLImage1.Picture ), qrUTF8NoBOM )

    else

       PintarQRCode( self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.cean, TBitMap(RLImage1.Picture), qrUTF8NoBOM );

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RlImageqrcodeBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin


   PintarQRCode( self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.cean, TBitMap( RLImageQRCode.Picture ), qrUTF8NoBOM );

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel10BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin

  Text := '';
  if FItem+1 <= FACBrNFeDANFCeFortesA4.FpNFe.Det.Count-1 then begin

    if ( AnsiPos( 'BORREGO',Uppercase(FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.xProd) ) = 0 )
        and
       ( AnsiPos( 'OVELHA',Uppercase(FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.xProd) ) = 0  )
        and
       ( AnsiPos( 'CABRITO',Uppercase(FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.xProd) ) = 0 )
       and
       ( AnsiPos( 'SUINA',Uppercase(FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.xProd) ) = 0  )
       then

       Text := '/'+inttostr( trunc(FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.qcom) )

    else

       Text := '';
  end;

end;

// 31.12.19
procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel11BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin

  if FItem+1 <=  self.FACBrNFeDANFCeFortesA4.FpNFe.Det.count-1 then begin

    if self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.uCom='Carne Congelada de Bovino Com Osso' then

      Text:='Manter congelado a -18 graus'

    else

      Text:='Manter resfriado de 0 a 7 graus';

  end else begin

    if self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.uCom='Carne Congelada de Bovino Com Osso' then

      Text:='Manter congelado a -18 graus'

    else

      Text:='Manter resfriado de 0 a 7 graus';

  end;

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel14AfterPrint(
  Sender: TObject);
begin

end;

// 03.01.20
procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel14BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin

  if FItem+1 <=  self.FACBrNFeDANFCeFortesA4.FpNFe.Det.count-1 then begin

    if self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.arma.Count>=1 then

       Text:='Porção de '+self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.arma.Items[0].nCano+' gr.'

    else

      Text:='Porção de 100 gr.';

  end else

      Text:='Porção de 100 gr.';

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel15BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin

    Text:=strspace('Qtde. por porção      %VD(*)',30);

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel12BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  Rllabel12.Left:=RlLabel12.Left-colunasamenos;
  Text := FormatFloat(',0.00##', self.FACBrNFeDANFCeFortesA4.FpNFe.Total.ICMSTot.vNF);

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RlDescontoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  RlDesconto.Left:=RlDesconto.Left-colunasamenos;

end;
// 03.01.20
procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel24BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin

   if  ( EBovino(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd) )
       and
       ( FItem+1 <=  self.FACBrNFeDANFCeFortesA4.FpNFe.Det.count-1 )
   then

      Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.vOUTRO)+' g'

   else

      Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vOUTRO)+' g';

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel25BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  RlLabel25.Left:=Rllabel25.Left-colunasamenos;

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel26BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  RlLabel26.Left:=Rllabel26.Left-colunasamenos;

end;

// 03.01.20
procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel29BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin

  if  ( EBovino(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd) )
        and  ( FItem+1 <= FACBrNFeDANFCeFortesA4.FpNFe.Det.Count-1 )
        then

      Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem+1].Prod.qtrib)+' mg'

   else

      Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.qtrib)+' mg';

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.rlpercfibraalimentarBeforePrint(
  Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
   Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vseg/25/100);

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.rlpercgordurastotaisBeforePrint(
  Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
   Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vOUTRO/55*100);

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.rlpercproteiraBeforePrint(
  Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
   Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vdesc/75*100);
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.rlpercsodioBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
   Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.qtrib/2400*100);

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.rlpercvalorenergeticoBeforePrint(
  Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
    Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vUnTrib/2000*100);

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.rlpesoBeforePrint(Sender: TObject;
  var AText: string; var PrintIt: Boolean);
begin

   Text:=inttostr( self.FACBrNFeDANFCeFortesA4.FpNFe.Ide.modelo );

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.rlReportA4AfterPrint(Sender: TObject);
begin
//     #27+'w'
//  #27 + #119;   w

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.lEnderecoConsumidorBeforePrint(
  Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
   Text:=#27 + #119;
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.RLLabel3Beforerint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//   Text:=FEstoque.GetDescricao(self.FACBrNFeDANFCeFortesA4.FpNFe.pag.Items[0].cAut);
   Text:=self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xProd;
// 26.09.17
   if length(trim(text))>24 then
     RlLabel3.Font.Size:=10;
// 04.01.19
   if AnsiPos( 'MEIA CARCAÇA', Uppercase( Text ) ) > 0 then
      Text := 'MEIA CARCAÇA'
   else if AnsiPos( 'QUARTO TRASEIRO', Uppercase( Text ) ) > 0 then
      Text := 'QUARTO TRASEIRO'
   else if AnsiPos( 'QUARTO DIANTEIRO', Uppercase( Text ) ) > 0 then
      Text := 'QUARTO DIANTEIRO'
   else if AnsiPos( 'COSTELA DO TRASEIRO', Uppercase( Text ) ) > 0 then
      Text := 'COSTELA DO TRASEIRO'
   else if AnsiPos( 'LOMBO', Uppercase( Text ) ) > 0 then
      Text := 'LOMBO'
   else if AnsiPos( 'TRASEIRO SERROTE', Uppercase( Text ) ) > 0 then
      Text := 'TRASEIRO SERROTE'
   else if AnsiPos( 'DIANTEIRO SEM PALETA', Uppercase( Text ) ) > 0 then
      Text := 'DIANTEIRO SEM PALETA'
   else if AnsiPos( 'PALETA', Uppercase( Text ) ) > 0 then
      Text := 'PALETA'
   else if AnsiPos( 'PONTA DE AGULHA', Uppercase( Text ) ) > 0 then
      Text := 'PONTA DE AGULHA'
   else if AnsiPos( 'LOMBO-ALCATRA', Uppercase( Text ) ) > 0 then
      Text := 'LOMBO-ALCATRA'
   else if AnsiPos( 'COXÃO BOLA', Uppercase( Text ) ) > 0 then
      Text := 'COXÃO BOLA';


   RLBarcode1.Caption:= OnlyNumber(self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.xped);


end;

// 07.06.16
procedure TfrmACBrDANFCeFortesFrETQFATadapar.Labelingr01BeforePrint(
  Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
//  if self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.arma.Count>=1 then
    Text:=strspace('Qtde. por porção      %VD(*)',30);
//   +self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.arma.Items[0].nCano;

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.LabelIngr02BeforePrint(
  Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
//  if self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.arma.Count>=2 then
//     Text:=strspace('Valor Energético',28)+self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.arma.Items[1].nCano;
    Text:=strspace('Vlr Energético',15)+FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vUnTrib)+' Kcal';
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.LabelIngr04BeforePrint(
  Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
   Text:='Proteínas';
//   +FormatFloat('##0.00',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vdesc);
//   Text:=FormatFloat('##0.00',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vdesc);

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.LabelIngr05BeforePrint(
  Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
//   Text:='Gorduras Totais '+FormatFloat('##0.00',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.voutro);
   Text:='Gorduras Totais';
//   Text:=FormatFloat('##0.00',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.voutro);

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.valorproteinaBeforePrint(
  Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
   Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vdesc)+' g';

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.valorgordtotaisBeforePrint(
  Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
   Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vOUTRO)+' g';

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.labelFibraalimentarBeforePrint(
  Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
   Text:='Fibra Alimentar';

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.labelfibraBeforePrint(
  Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
   Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.vseg)+' g';

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.labelsodioBeforePrint(
  Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
   Text:='Sódio';
end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.LabelvalidadeBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin

//  Text:='Manter resfriado de 0 a 7 graus ou MAIS FRIO. Validade '+self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.NCM+' dias';
// 23.08.19
  if self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.uCom='Carne Congelada de Bovino Com Osso' then

    Text:='Manter congelado a -18 graus'

  else

    Text:='Manter resfriado de 0 a 7 graus';

end;

procedure TfrmACBrDANFCeFortesFrETQFATadapar.valorsodioBeforePrint(
  Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
   Text:=FormatFloat('##0.0',self.FACBrNFeDANFCeFortesA4.FpNFe.Det.Items[FItem].Prod.qtrib)+' mg';

end;

end.

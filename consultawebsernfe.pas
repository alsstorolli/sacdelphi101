unit consultawebsernfe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, Buttons, SQLBtn, SQLGrid, ExtCtrls, ACBrBase,
  ACBrDFe, ACBrNFe, pcnConversaoNfe, pcnNFe, pcnConversao, Vcl.StdCtrls,
  Vcl.ComCtrls;

type
  TFSiteWebservices = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    bSair: TSQLBtn;
    Panel1: TPanel;
    WebBrowser: TWebBrowser;
    bpreenche: TSQLBtn;
    ACBrNFe1: TACBrNFe;
    procedure bpreencheClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(OP:string ; chavenfe:string='');
  end;

var
  FSiteWebservices: TFSiteWebservices;
  xOP,xchavenfe:string;

implementation

{$R *.dfm}

uses SqlSis, SqlFun , geral;

{ TFSiteWebservices }

procedure TFSiteWebservices.Execute(OP:string;chavenfe:string='');
///////////////////////////////////////////////////
var  Site:widestring;
begin
   xOP:=OP;
   xchavenfe:=chavenfe;
   if OP='D' then begin
     site:='http://www.nfe.fazenda.gov.br/portal/disponibilidade.aspx?versao=2.00&tipoConteudo=Skeuqr8PQBY=';
     Sistema.beginprocess('Acessando portal Nacional da NF-e');
     Caption:='Consulta Situação para envio da NFe';
   end else if OP='C' then begin
     site:='http://www.cte.fazenda.gov.br/portal/disponibilidade.aspx?versao=1.00&tipoConteudo=XbSeqxE8pl8=';
     Sistema.beginprocess('Acessando portal Nacional do CT-e');
     Caption:='Consulta Situação para envio do CTe';
   end else begin
     site:='http://www.nfe.fazenda.gov.br/portal/consulta.aspx?tipoConsulta=completa&tipoConteudo=XbSeqxE8pl8=';
     Sistema.beginprocess('Acessando consulta da NF-e Completa Portal Nacional');
     Caption:='Consulta NF-e Completa - Portal Nacional';
{
      if trim( FGeral.GetConfig1AsString('Pastaschemas') ) <> '' then
        Acbrnfe1.Configuracoes.Arquivos.PathSchemas:=FGeral.GetConfig1AsString('Pastaschemas')
      else
        Acbrnfe1.Configuracoes.Arquivos.PathSchemas:=ExtractFilePath( Application.ExeName )+'Schemas20';
      Acbrnfe1.Configuracoes.Geral.VersaoDF:=ve310;
      AcbrNfe1.Configuracoes.Geral.ModeloDF:= monfe;
      acbrnfe1.Configuracoes.WebServices.Ambiente:=taProducao;
      acbrnfe1.Configuracoes.Certificados.NumeroSerie:=FGeral.GetNroSerieCertificado(Global.CodigoUnidade);

      ACbrnfe1.Consultar(chavenfe);
      site:='';
}
//      Aviso(ACBrNFe1.WebServices.Consulta.Protocolo+' ][ '+
//                  UTF8Encode(ACBrNFe1.WebServices.Consulta.RetWS) );
   end;
   Show;
   WebBrowser.Navigate(site);

   Sistema.endprocess('');

end;

procedure TFSiteWebservices.bpreencheClick(Sender: TObject);
var
	FormItem: Variant;
	Field: Variant;
	FieldName: String;
	I,J: Integer;
//  Lista:TStringlist;

///////////////////////////////////////////
begin
///////////////////////////////////////////
  if xop<>'C' then exit;
	if WebBrowser.OleObject.Document.all.tags('FORM').Length = 0 then
		Exit;
	for I := 0 to WebBrowser.OleObject.Document.forms.Length - 1 do
	begin
		FormItem := WebBrowser.OleObject.Document.forms.Item(I);

//    Lista:=TStringlist.create;
//  	for j := 0 to FormItem.Length - 1 do begin
//			Field := FormItem.Item(j);
//			FieldName := Field.Name;
//			Lista.Add( FieldName );
//    end;
//    SelecionaItems(Lista,'Campos do Form');

		try
			for j := 0 to FormItem.Length - 1 do
			begin
				//Identifica o campo e seu nome no formulário
				Field := FormItem.Item(j);
//				FieldName := Uppercase( Field.Name );
				FieldName := Field.Name;

// txtChaveAcesso
//ctl00$ContentPlaceHolder1$txtChaveAcessoCompleta
//				if FieldName = 'TXTCHAVEACESSO' then // nome do input para o campo CNPJ
//				if FieldName = 'ctl00$ContentPlaceHolder1$txtChaveAcessoCompleta' then // nome do input para o campo
//				if FieldName = 'ContentPlaceHolder1_txtChaveAcessoCompleta' then
//				if FieldName = 'ContentPlaceHolder1_refChaveAcessoCompleta' then
//				if FieldName = 'txtChaveAcesso' then
				if FieldName = 'ctl00$ContentPlaceHolder1$txtChaveAcessoCompleta' then 
					Field.Value := xchavenfe;
			end
		except
			ShowMessage('Não foi possível identificar os campos para atribuir os valores');
		end;
	end;
end;

end.

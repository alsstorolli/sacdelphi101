unit Mostraxml;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, SQLGrid, Buttons, SQLBtn, alabel, xmldom,
  XMLIntf, msxmldom, XMLDoc, ComCtrls,
  //oxmldom,
  OleCtrls, SHDocVw;

type
  TFMostraXml = class(TForm)
    pbase: TSQLPanelGrid;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    XML1: TXMLDocument;
    WebBrowser: TWebBrowser;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(cxml:Widestring);
//    procedure Execute(cxml:TMemoryStream);
  end;

var
  FMostraXml: TFMostraXml;

implementation

{$R *.dfm}

{ TFMostraXml }

procedure TFMostraXml.Execute(cxml: Widestring);
//procedure TFMostraXml.Execute(cxml: TMemoryStream);
var
//Lista:TStringList;
//    p,tam:integer;
//    vXMLDoc: TXMLDocument;
//    NodePai,NodeSec,NodeTmp: IXMLNode;
//    nome, codigo: WideString;
    site,temp:string;

begin

   xml1.XML.Clear;
   Xml1.XML.Append(trim(cxml));
//  XML1.XML.LoadFromFile('\Nfesac\41100711595894000126550010000000010000000017-nfe.xml' );
//  XML1.XML.LoadFromFile( cxml );
//    XML1.XML.LoadFromStream( cxml );
// tam:=400;
// Lista:=TStringList.Create;

//   for p:=0 to xml1.XML.Count-1 do begin
//     Lista.Add(xml1.XML.Strings[p] );
 //  end;

// for p:=1 to 100000 do begin
//   Lista.Add( copy(xml1.XML.Strings[0],((p-1)*tam)+1,tam) );
//   if trim( copy(xml1.XML.Strings[0],((p-1)*tam)+1,tam) )='' then break;
// end;

// com richedit mais campo blob dava erro 'out of resources'...
// dai mudado para memo
//   Texto.Lines.Clear;
//   Texto.Lines.Assign(Xml1.XML);

{
   for p:=0 to Lista.Count-1 do begin
     Texto.Lines.Add( Lista[p] );
   end;
}
   temp:=ExtractFilePath( Application.ExeName ) + 'xmltemp.xml';
   xml1.Active:=true;
   xml1.SaveToFile( temp );
   site:=temp;
   webbrowser.Navigate(site);


///////////////////////
{
  // Cria a variável baseada no TXMLDocument
  vXMLDoc := TXMLDocument.Create(self);

  // Le conteúdo do arquivo XML informado
//  vXMLDoc.LoadFromFile('EnviNFe.xml');
//  vXMLDoc.XML.Append( cxml );
//  vXMLDoc.Active := True;

//  XML1.Encoding := 'UTF-8';
//  XML1.XML.Append( cxml );

  XML1.XML.LoadFromFile('\Nfesac\41100711595894000126550010000000010000000017-nfe.xml' );
  XML1.Active := True;

  // Poderia ser uma URL como abaixo:
  //vXMLDoc.FileName := 'http://www.caiooliveira.com.br/?feed=rss2';
  //vXMLDoc.Active := True;

  // Vou colocar os dados no memo apenas como exemplo
  Texto.lines.Add( '-------------------------------------------------');
  Texto.lines.Add( 'NFe numero tal cliente tal...');

  // Aqui eu peço para encontrar a primeira ocorrencia da Tag <det>>
//  NodePai := vXMLDoc.DocumentElement.childNodes.First.ChildNodes.FindNode('det');
  NodePai := XML1.DocumentElement.ChildNodes.FindNode('det');
  // Esse nó vai ser usado no LOOP
  NodeSec := NodePai;
  // Posiciona o primeiro elemento encontrado
  NodeSec.ChildNodes.First;
  repeat
    // referencia a tag <prod> dentro de <det>
    NodeTmp  := NodeSec.ChildNodes['prod'];
//    NodeTmp  := NodeSec.ChildNodes['ide'];
    // da pra ver que é um XML resumido da NFe (so temos uma tag <prod> para cada <det> então não precisaria da linha abaixo
    // agora se tivéssemos mais de uma seria o caso de posicionar também na primeira ocorrencia.
    NodeTmp.ChildNodes.First;
    repeat
      // pega os dados que vc quiser dentro da tag <prod>
      nome := NodeTmp.ChildNodes['xProd'].text;     // posso ler assim
//      codigo := NodeTmp.ChildValues['cEan'];        // ou assim
      codigo := NodeTmp.ChildValues['cProd'];        // ou assim
//      nome := NodeTmp.ChildNodes['natOp'].text;     // posso ler assim
//      codigo := NodeTmp.ChildValues['dEmi'];        // ou assim

      // vamos inserir no Memo os dados
      Texto.Lines.Add( nome+' ---- '+codigo );

      // vai para a proxima ocorrência </prod><prod> (se houvesse)
      NodeTmp := NodeTmp.NextSibling;
    until NodeTmp = nil;
    // vai para a proxima ocorrência <det>
    NodeSec := NodeSec.NextSibling;
  until NodeSec = nil;

}
//////////////////////

   Show;

end;


end.

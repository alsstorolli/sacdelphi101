unit ajuda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, SQLBtn, ExtCtrls, SQLGrid, ComObj, StdCtrls, ComCtrls,
  SqlFun, SHDocVw, SqlSis, ShellApi;

type
  TFMostraHelp = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    Memo1: TRichEdit;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
  end;

var
  FMostraHelp: TFMostraHelp;

implementation

{$R *.dfm}

procedure TFMostraHelp.Execute;
//////////////////////////////
var //xflags:OleVariant;
//    ZipStream : TZipStream;
//    ZipStream : TMemoryStream;
//    i,tamlinha,tamxml:integer;
//    XmlNode : IXMLNode;
    localarquivo:PWidechar;
begin
  Show;
  localarquivo:='IT-GQ.02.01-00 Preenchimento de Relatorio de Nao Conformidades.PDF';
  if FileExists(trim(localarquivo)) then begin
//        try
//          Wb.Navigate(localarquivo);
//          OleContainer1.CreateObjectFromFile(trim(localarquivo),TRUE);
//          OleContainer1.DoVerb(0);
//          ShellExecute(Handle, nil, localarquivo , nil, nil, SW_SHOWMAXIMIZED);

          ShellExecute(Handle, nil, localarquivo , nil, nil, SW_SHOWNORMAL);


           {
          ZipMaster1.ZipFileName := LocalArquivo;
//          ZipStream := ZipMaster1.ExtractFileToStream( '_rels\.rels');
          ZipStream := ZipMaster1.ExtractFileToStream( 'word\document.xml');
          ZipStream.Position := 0;
          XMLDocument1.LoadFromStream(ZipStream);
          Memo1.Lines.Clear;
          tamxml:=Length(XMLDocument1.XML.Text);
          tamlinha:=100;
          }
//        except
//            Avisoerro('Erro ao abrir arquivo.');
//        end;

  end else
      Avisoerro('Arquivo '+localarquivo+' não encontrado !!' );

end;

end.

unit impfichacrpl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, zEd, ExtCtrls, SQLGrid, Buttons, zBtn, ComCtrls;

type
  TFImpressaoCRPL = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    Earquivomodelo: TzEd;
    OD: TOpenDialog;
    Edarquivolista: TzEd;
    zBtn1: TzBtn;
    texto: TRichEdit;
    StaticText1: TStaticText;
    procedure zBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure CriaWord;
  end;

var
  FImpressaoCRPL: TFImpressaoCRPL;

implementation

{$R *.dfm}

uses ZFun, ZEnv, ComObj, CMunicipios, Geral;

procedure TFImpressaoCRPL.Execute;
/////////////////////////////////////////
begin
  Show;
end;

procedure TFImpressaoCRPL.zBtn1Click(Sender: TObject);
//////////////////////////////////////////////////////
begin
   if Od.Execute then begin
     Edarquivolista.text:=Od.FileName;
     criaword;
   end;
end;

////////////////////////////////////////////////////////
procedure TFImpressaoCRPL.CriaWord;
//////////////////////////////////////////////////////////
var p:integer;
    Lista,ListaLinha,LComandos:TStringlist;
    Q:TzQ;
    WinWord, Doc: Variant;
    PathWord:string;


    Function Retorno( comando:string ):string;
    /////////////////////////////////////////////////
    begin
      result:='';
      if comando='@pro_descricao' then result:=Q.fieldbyname('pro_descricao').AsString
      else if comando='@pro_estadocivil' then result:=Q.fieldbyname('pro_estadocivil').AsString
      else if comando='@pro_municipiodesc' then result:=FMunicipios.GetDescricao( Q.fieldbyname('pro_municipio').AsString )
      else if comando='@pro_pmunicipiodesc' then result:=FMunicipios.GetDescricao( Q.fieldbyname('pro_pmunicipio').AsString )
      else if comando='@pro_endereco' then result:=Q.fieldbyname('pro_endereco').AsString
      else if comando='@pro_rginscricao' then result:=Q.fieldbyname('pro_rginscricao').AsString
      else if comando='@pro_cnpjcpf' then result:=Q.fieldbyname('pro_cnpjcpf').AsString;
    end;

    procedure CriaArquivoWord;
    //////////////////////////
    var i:integer;
        nomearquivo:string;
    begin
//      WinWord.Visible := True; // Abrir arquivo para edição
      Doc:= WinWord.Documents.Open(ExtractFilePath(Application.ExeName)+'modeloCRPL.doc');
      for i:=0 to LComandos.count-1 do begin
        Doc.Content.Find.Execute(FindText := Lcomandos[i] , ReplaceWith := Retorno(Lcomandos[i]) );
      end;
      nomearquivo:=FGeral.TiraCaracter( Q.fieldbyname('pro_descricao').AsString,'/' );
      Doc.SaveAs( PathWord  + '\'+ trim(strspace(nomearquivo,40)) + '.doc');
      Doc.Close;
    end;


begin
////////////////////
    Lista:=TStringlist.create;
    LComandos:=TStringlist.create;
    LComandos.Add('@pro_descricao');
    LComandos.Add('@pro_estadocivil');
    LComandos.Add('@pro_municipiodesc');
    LComandos.Add('@pro_pmunicipiodesc');
    LComandos.Add('@pro_endereco');
    LComandos.Add('@pro_rginscricao');
    LComandos.Add('@pro_cnpjcpf');
    WinWord := CreateOleObject('Word.Application');
    WinWord.visible:=true;
    Lista.LoadFromFile( Edarquivolista.text );
    PathWord:=ExtractFilePath(Application.ExeName) + '\Propostas';
    if not DirectoryExists( PathWord ) then
      ForceDirectories( PathWord );
    for p:=0 to Lista.Count-1 do begin
      ListaLinha:=TStringlist.create;
      strtolista(ListaLinha,Lista[p],';',true);
      if LIstaLInha.Count>=4 then begin
        if strtointdef(ListaLinha[3],0) > 0 then begin
          Q:=Sistema.SqlToQuery('select * from produtores where pro_codigo='+Stringtosql(ListaLinha[3]));
          Sistema.BeginProcess('Criando proposta produtor '+ListaLinha[4] );
          if not Q.eof then
            CriaArquivoWord
          else
            Texto.Lines.add('Codigo '+ListaLinha[3]+' - '+ListaLinha[4]);
        end;
      end;
      ListaLinha.free;
    end;
    Sistema.endProcess('Terminado');
    Winword.quit;
    Lcomandos.Free;
    Lista.free;
end;

end.

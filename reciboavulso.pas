unit reciboavulso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, SQLGrid, Buttons, SQLBtn,
  Mimemess, mimepart, Mask, SQLEd;
type
  TFReciboavulso = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    Texto: TRichEdit;
    EscolheImp: TPrintDialog;
    pbotoes: TSQLPanelGrid;
    bImprecibo: TSQLBtn;
    bfechar: TSQLBtn;
    bemail: TSQLBtn;
    EdModelos: TSQLEd;
    bsalvamodelo: TSQLBtn;
    procedure bImpreciboClick(Sender: TObject);
    procedure bfecharClick(Sender: TObject);
    procedure bemailClick(Sender: TObject);
    procedure bsalvamodeloClick(Sender: TObject);
    procedure EdModelosExitEdit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(tipocad:string;codigo:integer;rp:string; xvalor:currency;duasvias:boolean);
    procedure InsereLInhas(n:integer);
    procedure PrintMemo;
    procedure ImprimeMatricial;
// 18.11.15
    procedure LeModelos;
    procedure LeDiretorio;
  end;

const extensao:string='.rec';

var
  FReciboavulso: TFReciboavulso;
  verbo,qpagou,qrecebeu:string;
  xduasvias:boolean;

const margem:string='          ' ; paragrafo:string='                  ';
      tamtraco:integer=80;

implementation

uses Geral, Sqlsis, Printers, Unidades, Sqlfun, ConfDcto, TextRel, Shellapi;

{$R *.dfm}

{ TFReciboavulso }

procedure TFReciboavulso.Execute(tipocad: string; codigo: integer;  rp: string ; xvalor:currency;duasvias:boolean);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var xcodigo:integer;
    cnpjcpf,ext1,ext2,ext:string;
    largura:integer;
begin

//   FGeral.EstiloForm(FReciboavulso);
//   Texto.Font.Style:=
   Texto.lines.clear;
   EdModelos.text:='';
   LeModelos;

   xcodigo:=codigo;
//   largura:=75;
// 30.10.12 - Simar
   largura:=69;
   ext:=Extenso(xvalor);
   ext1:=copy(ext,1,largura);
   ext2:=copy(ext,largura+1,largura);
   xduasvias:=duasvias;

     Inserelinhas(04);
     Texto.lines.add(margem+replicate('-',largura));
     Inserelinhas(01);
     Texto.lines.add(margem+'R E C I B O');
     Inserelinhas(01);
     Texto.lines.add(margem+replicate('-',largura));
     verbo:='Recebemos de : ';
     if rp='P' then begin
       cnpjcpf:=FGeral.GetCnpjCpfTipoCad(codigo,tipocad);
       qpagou:=FUnidades.GetRazaoSocial(Global.CodigoUnidade);
       qrecebeu:=FGeral.GetNomeRazaoSocialEntidade(codigo,tipocad,'R');
     end else begin
  //     verbo:='Pagamos a :';
       cnpjcpf:=FUnidades.GetCnpjcpf(Global.CodigoUnidade);
       qpagou:=FGeral.GetNomeRazaoSocialEntidade(codigo,tipocad,'R');
       qrecebeu:= FUnidades.GetRazaoSocial(Global.CodigoUnidade);
     end;
  //   Texto.lines.add(margem+replicate('-',tamtraco));
  //   Texto.lines.add(margem+FUnidades.GetRazaoSocial(Global.CodigoUnidade)+' '+Formatocgccpf( FUnidades.GetCnpjcpf(Global.CodigoUnidade) ));
  //   Texto.lines.add(margem+replicate('-',tamtraco));
     Inserelinhas(02);
     Texto.lines.add(margem+verbo+' '+qpagou);
     Inserelinhas(01);
  //   Texto.lines.add(margem+qpagou);
  //   Inserelinhas(01);
     Texto.lines.add(margem+'Valor  : '+formatfloat(f_cr,xvalor));
     Inserelinhas(01);
     Texto.lines.add(margem+'Extenso: '+ext1);
     Inserelinhas(01);
     Texto.lines.add(margem+'Proveniente de: ');
     Inserelinhas(01);
     if trim(ext2)<>'' then begin
       Texto.lines.add(margem+'         '+ext2);
       Inserelinhas(01);
     end;
     Texto.lines.add(margem+'Data    : '+FGeral.FormataData(sistema.hoje));
     Inserelinhas(02);
     Texto.lines.add(margem+'--------------------------------------------');
     Texto.lines.add(margem+qrecebeu);
     Inserelinhas(01);   // 05.04.13
     Texto.lines.add(margem+'Cpf/Cnpj : '+Formatocgccpf(cnpjcpf));
     Inserelinhas(02);
     Texto.lines.add(margem+replicate('-',largura));
     if duasvias then
       Inserelinhas(14);
// 21.03.17 - posiciona o texto no inicio
     Texto.SelStart := Perform(EM_LINEINDEX, 1, 0);
   Show;
   EdModelos.setfocus;

end;

procedure TFReciboavulso.InsereLInhas(n: integer);
var x:integer;
begin
   for x:=1 to n do begin
     Texto.Lines.Add( ' ' );
   end;
end;

procedure TFReciboavulso.bImpreciboClick(Sender: TObject);
var copias,i,tamfonte:integer;
    s,p:string;
const  nomearquivo='Recibo.doc';
begin
  tamfonte:=12;
  if FGeral.getconfig1asinteger('TAMFONTERECAVU')>0 then tamfonte:=FGeral.getconfig1asinteger('TAMFONTERECAVU');
  
//  if not escolheimp.Execute then exit;
   if not Global.Topicos[1268] then begin
//     FTExtRel.Init();
// 26.11.12 - para ter op��o de imprimir em laser
//     FTextRel.Init(90,nil,nil,0,Global.Usuario.OutrosAcessos[3309],12,60);
//
     FTextRel.Init(90,nil,nil,0,Global.Usuario.OutrosAcessos[3309]);
     FTExtRel.MargemEsquerda:=1;
  //   FTExtRel.Rel.Lines.Assign(Texto.Lines);
// 26.11.13
     if xduasvias then
          FTExtRel.AddLinha(space(10)+'Primeira via',false,false,false);
     for i:=0 to Texto.Lines.count-1 do begin
       FTExtRel.AddLinha(Texto.Lines.Strings[i],false,false,false);
     end;
// 29.11.11 - Capeg - Mari
     if xduasvias then begin
       if xduasvias then
          FTExtRel.AddLinha(space(10)+'Segunda via',false,false,false);
       for i:=0 to Texto.Lines.count-1 do begin
         FTExtRel.AddLinha(Texto.Lines.Strings[i],false,false,false);
       end;
     end;
     FTExtrel.Video('',tamfonte);

   end else begin

//      Texto.Lines.SaveToFile(nomearquivo);
// 08.01.2013
     for i:=0 to Texto.Lines.count-1 do begin
       FTExtRel.AddLinha(Texto.Lines.Strings[i],false,false,false);
     end;
// 29.11.11 - Capeg - Mari
     if xduasvias then begin
       for i:=0 to Texto.Lines.count-1 do begin
         FTExtRel.AddLinha(Texto.Lines.Strings[i],false,false,false);
       end;
     end;

//      WinExec('WordPad.exe '+nomearquivo, SW_SHOW);
//      WinExec('WordPad.exe '+'Recibo.doc', SW_SHOW);
//      WinExec('Notepad.exe '+nomearquivo, SW_SHOW);
// antes checar se existe o wordpad no path senao avisar
//      WinExec('Wordpad.exe '+nomearquivo, SW_SHOW);
      Sistema.beginprocess('Abrindo o programa '+s);
      s:='Wordpad.exe';
//      p:=nomearquivo;
      p:='Recibo.doc';
      Sistema.beginprocess('Abrindo o programa '+s);
      ShellExecute(Handle, 'open', PChar(s), PChar(p), nil, SW_SHOW);
      Sistema.endprocess('');
   end;
{
  escolheimp.Copies:=1;
  Printer.Orientation:=poPortrait;
//  if Horizontal then Printer.Orientation:=poLandscape;
  if escolheimp.Execute then begin
     Copias:=escolheimp.Copies;
     Printer.Printers.Strings[Printer.PrinterIndex];
//     for i:=1 to Copias do Texto.Print('Imprimindo Relat�rio');
//     for i:=1 to Copias do PrintMemo;
     for i:=1 to Copias do ImprimeMatricial;
  end;
//  PrintMemo;
}
end;

procedure TFReciboavulso.PrintMemo;

var i,col,lin:integer;

begin

  col:=0; // posi��o da coluna
  lin:=0; // posi��o da linha
  printer.begindoc;
  for i := 0 to Texto.Lines.Count-1 do begin

    printer.Canvas.TextOut(col,lin, Texto.Lines[i]);
    lin := lin + 30;

  end;

  printer.Enddoc;

end;


procedure TFReciboavulso.bfecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFReciboavulso.ImprimeMatricial;
var linha,nomeimpressora:string;
    linhap:pchar;
    i:integer;
    Arquivo : TextFile;
begin
  nomeimpressora:='\\Andreia\epson';
  for i := 0 to Texto.Lines.Count-1 do begin
    linha:=Texto.Lines.Strings[i];
    linhap:=Pchar(linha);
//    AssignFile(Arquivo,'LPT1');
    AssignFile(Arquivo,nomeimpressora);
    Rewrite(Arquivo);
    Writeln(Arquivo,linha);
//    Writeln(Arquivo,#27#15+'Teste de Impress�o - Linha 2');
//    Writeln(Arquivo,#27#18+'Teste de Impress�o - Linha 4');
//    Writeln(Arquivo,#12); // Ejeta a p�gina
  end;
  CloseFile(Arquivo);

end;

// 26.11.14
procedure TFReciboavulso.bemailClick(Sender: TObject);
////////////////////////////////////////////////////////
var Corpo:TMimeMess;
    Parte1:TMimePart;
    endereco:string;
    Lista:TStringList;
    p:integer;

begin
      if Input('Destinat�rio de e-mail','E-Mail',Endereco,0,False) and (Endereco<>'') then begin
        Corpo:=TMimeMess.Create;
        Parte1:=TMimePart.Create;
        Parte1 := Corpo.AddPartMultipart('mixed', nil);
        Lista:=TStringList.create;
        for p:=1 to Texto.Lines.Count do begin
          Lista.Add(texto.Lines.Strings[p])
        end;
        Lista.SaveToFile('recibo.txt');
        Corpo.AddPartTextFromFile( 'Recibo.txt' , Parte1);
        Corpo.Header.From:=FGeral.GetConfig1AsString('EMAILORIGEM');
        Corpo.Header.ToList.Text:=Endereco;
        Corpo.Header.Subject:='Quita��o de valores';
        Corpo.EncodeMessage;
        Sistema.BeginProcess('Enviando email');
        FGeral.SendMime( FGeral.GetConfig1AsString('SMTP'),FGeral.GetConfig1AsString('USUARIOSMTP'),FGeral.GetConfig1AsString('SENHASMTP'),Corpo );
        Sistema.EndProcess('');
        Corpo.Free;
        Lista.Free;

      end;

end;

// 18.11.15
procedure TFReciboavulso.LeModelos;
/////////////////////////////////////
begin

  LeDiretorio;
end;

procedure TFReciboavulso.LeDiretorio;
///////////////////////////////////////
var
  SR: TSearchRec;
  I: integer;
  diret:string;
begin
//  I := FindFirst('C:*', faAnyFile, SR);
  diret:=ExtractFilePath( Application.exename )+'*.rec';
  I := FindFirst(diret, faAnyFile, SR);
  EdModelos.Items.clear;
  while I = 0 do
  begin
    EdModelos.Items.Add( copy(sr.Name,1,pos('.',sr.Name)-1) );
    I := FindNext(SR);
  end;
end;


procedure TFReciboavulso.bsalvamodeloClick(Sender: TObject);
///////////////////////////////////////////////////////////////
begin
   if EdModelos.isempty then exit;
   if confirma('Salvar o modelo atual como '+EdModelos.text) then begin
     TExto.Lines.SaveToFile( EdModelos.text+'.rec' );
     Aviso('Modelo '+EdModelos.text+' salvo');
   end;
end;
// 18.11.15
procedure TFReciboavulso.EdModelosExitEdit(Sender: TObject);
///////////////////////////////////////////////////////////////////
begin
    if not EdModelos.isempty then Texto.Lines.LoadFromFile( EdModelos.text + extensao )
end;

end.

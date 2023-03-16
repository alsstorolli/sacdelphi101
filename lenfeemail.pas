unit lenfeemail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.OleCtrls, SHDocVw, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Buttons, IdExplicitTLSClientServerBase,
  IdMessageClient, IdIMAP4, IdPOP3, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdMessage;

type
  TFLenfeemail = class(TForm)
    Panel2: TPanel;
    IdIMAP41: TIdIMAP4;
    BitBtn1: TBitBtn;
    IdPOP31: TIdPOP3;
    idpop3ssl: TIdSSLIOHandlerSocketOpenSSL;
    IdMessage1: TIdMessage;
    Texto: TRichEdit;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FLenfeemail: TFLenfeemail;

implementation

uses  IdAttachment, IdMessageParts, Sqlfun, SqlSis ;

{$R *.dfm}

procedure TFLenfeemail.BitBtn1Click(Sender: TObject);
////////////////////////////////////////////////////////////////
var iMap :TIdIMAP4;
    IdPOP3 : TIdPOP3;
    rec : array of TIdIMAP4SearchRec;
    Msg : TIdMessage;
    contMsg, i, idMsg ,
    j,
    inId,
    Idcomxml : Integer;
    Part : TIdMessagePart;
    Att  : TIdAttachment;
    Body,
    AttExt ,
    AttPath,
    Pasta,
    ano,
    mes : string;


begin

  Pasta := ExtractFilePath( application.exename );

  ano  := strzero( Datetoano(Sistema.hoje,true) ,4);
  mes  := strzero( Datetomes(Sistema.hoje) ,2);
  Texto.Lines.clear;
  Texto.Lines.Add('Configurando a conex�o ao email');

  iMap := TIdIMAP4.Create (Nil);
  iMap.Port := 993;
  iMap.Host     := 'mail.novicarnes.com.br';  //  Endere�o do servidor
  iMap.Username := 'financeiro@novicarnes.com.br';
  iMap.Password := '@ab322cd';

{
  iMap.Host := 'imap.gmail.com';  //  Endere�o do servidor
  iMap.Username := 'andreluis779@gmail.com';
  iMap.Password := '951503';
}

{
  IdPOP3 := TIdPOP3.Create (Nil);
  IdPOP3.Host := 'mail.novicarnes.com.br';
  IdPOP3.Port := 995;
  IdPOP3.Username := 'financeiro@novicarnes.com.br';
  IdPOP3.Password := '@ab322cd';
  }

{

        IdPOP3.ConnectTimeout := 30000;
        IdPOP3.UseTLS := utUseImplicitTLS;
}

//        IdPOP3SSL.Destination := 'mail.gmail.com' + ':993';     // 'seudominio.com.br:995'
//        IdPOP3SSL.Host := 'pop.gmail.com';
        IdPOP3SSL.Destination := 'mail.novicarnes.com' + ':993';     // 'seudominio.com.br:995'
        IdPOP3SSL.Host := 'pop.novicarnes.com';
        IdPOP3SSL.Port := 993;
//        IdPOP3SSL.SSLOptions.Method := sslvTLSv1;
//        IdPOP3SSL.SSLOptions.Mode := sslmUnassigned;

  iMap.IOHandler := idpop3ssl;
  iMap.UseTLS := utUseImplicitTLS;


//  if Imap.ConnectionState = csAuthenticated  then begin

//     Imap.CloseMailBox;
//     Imap.Disconnect();

//  end;
  Texto.Lines.Add('Conectando no email '+iMap.Username);


  try

    iMap.Connect(true);
//    IdPOP3.Connect();
//    showmessage('conectou no email');

  except on E:exception do Showmessage(E.message);
  end;

//{ Realiza aqui algumas tarefas com o IMAP conectado}{

   if (not iMap.SelectMailBox ( 'INBOX') ) then
       showmessage('Erro na sele��o da caixa postal INBOX');

//   else
//       showmessage('selecionado caixa INBOX');}

  SetLength(rec,1);
  rec[0].SearchKey := skUnseen;
//  IMAP.UIDSearchMailBox(rec);
  Texto.Lines.Add('Iniciando pesquisa no email');

  if not iMap.SearchMailBox(rec) then
  raise Exception.Create('Erro na pesquisa da caixa postal');

{ Quantas mensagens foram encontradas ? }

 // contMsg := idPOP3.CheckMessages;

  contMsg := High(IMAP.MailBox.SearchResult);

//  Showmessage('encontrado '+inttostr(contmsg)+' n�o lidas');
  inId := 1;
  Idcomxml := 0;
  if contmsg<0 then Texto.Lines.add('Nenhuma msg lida no email');

  for i := 0 to contMsg  do begin

    Msg := TIdMessage.Create(Nil);

{ Obtem a identifica��o da mensagem ... }
    idMsg := iMap.MailBox.SearchResult[i];
    { ... e a usa para recuperar o email completo }
    iMap.Retrieve (idMsg, Msg);
//    idPOP3.Retrieve(I, Msg);

    if (Pos('multipart', Lowercase(Msg.ContentType))) > 0 then begin

        for J := 0 to Msg.MessageParts.Count - 1 do begin

            Part := Msg.MessageParts.Items[J];
            // Texto
//            if (Part is TIdText) then begin
//                Body := (Part as TIdText).Body.Text;
//            end;
            // Anexo (salva no disco)
            if (Part is TIdAttachment) then begin

                Att := (Part as TIdAttachment);
                AttExt := Lowercase(ExtractFileExt(Att.FileName));
//                AttPath := Pasta + 'inbox\' + IntToStr(inId) + '\';
                AttPath := Pasta + 'inbox\'+ano+mes+'\';
//                if (AttExt = '.xml') or (AttExt = '.pdf') then begin
                if (AttExt = '.xml') then begin

                    if (not DirectoryExists(AttPath)) then begin
                       ForceDirectories(AttPath);
                    end;
                    Att.SaveToFile(AttPath + Att.FileName);
                    Texto.Lines.Add('Salvo anexo '+AttPath + Att.FileName);
                    inc( Idcomxml );

                end;

            end;

           inc( inID );

        end;

//        Texto.Lines.Add('01 msg lida');

    end;

  end;

{ ... }
{ Descarta a conex�o e outros recursos qdo n�o forem mais necess�rios }
  iMap.Disconnect();
  iMap.Free ();
  Texto.Lines.Add('TERMINADO');

//  idPOP3.Disconnect;
//  idpop3.Free;

end;

end.

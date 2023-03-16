unit leemailxml;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient,
  IdPOP3, Vcl.Buttons, SQLBtn, Vcl.StdCtrls, alabel, Vcl.ExtCtrls, SQLGrid;

type
  TForm2 = class(TForm)
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    bgeranfe: TSQLBtn;
    bgravar: TSQLBtn;
    bgeraboleto: TSQLBtn;
    bcupom: TSQLBtn;
    bbaixa: TSQLBtn;
    bimpressao: TSQLBtn;
    bvalidade: TSQLBtn;
    bafaturar: TSQLBtn;
    Pbotoesgrid: TSQLPanelGrid;
    bLoadGrid: TSQLBtn;
    bSaveGrid: TSQLBtn;
    bMoveLeft: TSQLBtn;
    bMoveRight: TSQLBtn;
    SQLPanelGrid1: TSQLPanelGrid;
    pop: TIdPOP3;
    procedure bgravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Receive;

  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.bgravarClick(Sender: TObject);
//////////////////////////////////////////////////////////
begin

  Receive;

end;



 procedure Tform2.Receive;
var
    I, J, MsgCount, inId: Integer;
    Body, AttExt, AttPath: string;
    Msg: TIdMessage;
    Part: TIdMessagePart;
    Att: TIdAttachment;

begin
    try

        if (POP3.Connected) then POP3.Disconnect;

        // Configura os parâmetros de comunicação via POP3/SSL
        POP3.Host := GetMailHost();   // 'seudominio.com.br'
        POP3.Port := 995;
        POP3.Username := GetMailUsr();
        POP3.Password := GetMailPwd();
        POP3.ConnectTimeout := 30000;
        POP3.UseTLS := utUseImplicitTLS;
        POP3SSL.Destination := GetMailHost() + ':995';   // 'seudominio.com.br:995'
        POP3SSL.Host := GetMailHost();
        POP3SSL.Port := 995;
        POP3SSL.SSLOptions.Method := sslvTLSv1;
        POP3SSL.SSLOptions.Mode := sslmUnassigned;

        // Conecta com a conta de e-mail
        POP3.Connect;

        MsgCount := POP3.CheckMessages;
        Msg := TIdMessage.Create(nil);
        for I := 1 to MsgCount do begin   // para cada e-mail na caixa de entrada

            // Obtem novo Id para gravar no banco de dados
            inId := DBA.GetNextID('rk_inbox');

            // Baixa o e-mail
            POP3.Retrieve(I, Msg);

            // Testa tipo de conteúdo para obter corpo do e-mail e anexos
            if (Pos('multipart', Lowercase(Msg.ContentType))) > 0 then begin
                for J := 0 to Msg.MessageParts.Count - 1 do begin
                    Part := Msg.MessageParts.Items[J];
                    // Texto
                    if (Part is TIdText) then begin
                        Body := (Part as TIdText).Body.Text;
                    end;
                    // Anexo (salva no disco)
                    if (Part is TIdAttachment) then begin
                        Att := (Part as TIdAttachment);
                        AttExt := Lowercase(ExtractFileExt(Att.FileName));
                        AttPath := GetPasta + '\inbox\' + IntToStr(inId) + '\';
                        if (AttExt = '.xml') or (AttExt = '.pdf') then begin
                            if (not DirectoryExists(AttPath)) then begin
                                CreateDir(AttPath);
                            end;
                            Att.SaveToFile(AttPath + Att.FileName);
                        end;
                    end;
                end;
            end else begin
                // Texto
                Body := Msg.Body.Text;
            end;

            // Grava o e-mail (alguns atributos) no banco de dados
            DBA.StoreMailMessage(inId,
                Msg.From.Address,
                Msg.Subject,
                Body,
                Msg.Date);

            // Marca o e-mail para exclusão na caixa de entrada
            POP3.Delete(I);

        end;
        Msg.Free;

    finally
        // Exclui os e-mails marcados da caixa de entrada e disconecta da conta de e-mail
        POP3.Disconnect;
    end;

end;



end.

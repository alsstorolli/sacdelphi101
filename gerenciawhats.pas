{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE ON}
{$WARN UNSAFE_CODE ON}
{$WARN UNSAFE_CAST ON}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR ON}
{$WARN CVT_WIDENING_STRING_LOST ON}
{$WARN NON_PORTABLE_TYPECAST ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
{$WARN IMMUTABLE_STRINGS OFF}
// 12.08.20
// Envio de mensagens e arquivos via whatsapp

unit gerenciawhats;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTInject, Vcl.ExtCtrls, Vcl.Buttons,
  Sqlfun ;


type
  TFGerenciaWhats = class(TForm)
    Panel1: TPanel;
    TInject1: TInject;
    Pmens: TPanel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Login:boolean;
    procedure Logout;
    procedure Execute(  xfone,xnomearq,xmensagem:string  );
    procedure EnviaArquivo( fone,nomearq,mensagem:string );

  end;

var
  FGerenciaWhats: TFGerenciaWhats;
  fone,
  nomearq,
  mensagem,
  xtransacao    : string;

implementation

{$R *.dfm}

{ TFGerenciaWhats }

procedure TFGerenciaWhats.EnviaArquivo(fone, nomearq, mensagem: string);
//////////////////////////////////////////////////////////////////////////////
begin

{
     try

        if not  login then begin

//     if not TInject1.Auth then begin
          Avisoerro('Não foi possível conectar no serviço do Whatssap.  Tente mais tarde');
          Close;

        end;

     except on E:exception do

         Avisoerro( E.Message )

     end;
}

    try

//      aviso('esperando fazer login no serviço');
      show;
      PMens.caption := 'Enviando arquivo '+nomearq;
      PMens.Update;
      Delay(1000);
      TInject1.SendFile('55'+fone+'@c.us', nomearq, mensagem);
      PMens.caption := '';
      PMens.Update;
      Close;

    except on E:exception do
         Avisoerro( E.Message )
    end;

end;

procedure TFGerenciaWhats.Execute(  xfone,xnomearq,xmensagem:string );
/////////////////////////////////////////////////////// ///////////////
begin

    if not login then begin
        Avisoerro('Não foi possível conectar no serviço do Whatssap.  Tente mais tarde');
        Close;
    end;

    fone     := xfone;
    nomearq  := xnomearq;
    mensagem := xmensagem;

end;

procedure TFGerenciaWhats.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
/////////////////////////////////////////////////////////////////////////////////
begin

//    Logout;

end;

function TFGerenciaWhats.Login: boolean;
////////////////////////////////////////////
begin

//   if FGerenciaWhats=nil then Application.CreateForm(TFGerenciaWhats,FGerenciaWhats);

    result := false;
    if not TINject1.Authenticated then begin
// 12.01.2021
//    if not TINject1.IsConnected then begin
// o formulario ainda 'nao existe'..ver os autocreate...
//    if not TInject1.tag = 0 then begin

      if not TINject1.Authenticated then begin

          Show;
          PMens.caption := 'Conectando ao serviço do whatsapp' ;

          if not TInject1.Auth(false) then
          Begin

    //        TInject1.FormQrCodeType := (ft_http);
              TInject1.FormQrCodeStart;
              result:=true;
              TINject1.tag := 1;

          End;

          if not TInject1.FormQrCodeShowing then
             TInject1.FormQrCodeShowing := True;
          Close;

      end;

    end else result :=true;

end;


procedure TFGerenciaWhats.Logout;
////////////////////////////////////
begin

   TInject1.Logtout;
   TInject1.Disconnect;

end;

procedure TFGerenciaWhats.SpeedButton1Click(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin

      EnviaArquivo('55'+fone+'@c.us',nomearq,mensagem);


end;

end.

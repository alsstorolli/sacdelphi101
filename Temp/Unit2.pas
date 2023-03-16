unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTInject, Vcl.Buttons;

type
  TForm2 = class(TForm)
    Inject1: TInject;
    SpeedButton1: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.SpeedButton1Click(Sender: TObject);
begin

    if not TInject1.Auth(false) then
    Begin
//      TInject1.FormQrCodeType := (Ft_Http);
      TInject1.FormQrCodeStart;
    End;

    if not TInject1.FormQrCodeShowing then
       TInject1.FormQrCodeShowing := True;
end;

end.

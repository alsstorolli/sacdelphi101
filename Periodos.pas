// 23.01.18
// para pode mudar somente os periodos sem acessar a configuracao geral do sistema

unit Periodos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, SQLGrid, Vcl.StdCtrls,
  Vcl.Mask, SQLEd, Vcl.Buttons, SQLBtn, alabel;

type
  TFPeriodos = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    StaticText5: TStaticText;
    EdDttermino: TSQLEd;
    EdDtterminotas: TSQLEd;
    EdDtinicionotas: TSQLEd;
    EdDtinicio: TSQLEd;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    bGravar: TSQLBtn;
    procedure FormActivate(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPeriodos: TFPeriodos;

implementation

{$R *.dfm}

uses geral, SqlFun;

procedure TFPeriodos.bGravarClick(Sender: TObject);
///////////////////////////////////////////////////////
begin

  if EdDtTermino.asdate<EdDtINicio.AsDate then begin
    Avisoerro('Data de término deve ser maior que a de inicio na digitação' );
    exit;
  end else if EdDtTerminotas.asdate<EdDtINicionotas.AsDate then begin
    Avisoerro('Data de término deve ser maior que a de inicio ref. notas' );
    exit;
  end;
  FGeral.SetFieldsConfig1(Self);
  Close;

end;

procedure TFPeriodos.FormActivate(Sender: TObject);
////////////////////////////////////////////////////
begin

  FGeral.GetFieldsConfig1(Self);
  EdDtinicio.SetFocus;

end;

end.

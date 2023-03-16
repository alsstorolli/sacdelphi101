unit MostraImagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, SQLBtn, ExtCtrls, SQLGrid;

type
  TForm1 = class(TForm)
    PFigura: TSQLPanelGrid;
    babrir: TSQLBtn;
    bfechaimagem: TSQLBtn;
    bgravaimagem: TSQLBtn;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Estoque;

{$R *.dfm}

procedure TForm1.FormActivate(Sender: TObject);
var Str:TMemoryStream;
    arquivo:string;
begin
{
  Str:=TMemoryStream.Create;
  FEstoque.EdEsto_Codigo.GetFields(FEstoque,99);
  LoadBlob('estoque','esto_imagem','esto_codigo='+FEstoque.EdEsto_codigo.AsSql,Str);
  arquivo:='LoadImagem'+inttostr(global.Usuario.codigo)+'.fig';
  if Str.Size>1 then begin
    Str.SaveToFile(arquivo);
//    if EdEsto_codigo.text='047' then
//      Image1.Picture.Bitmap.LoadFromStream(str)
//    else
//      Image1.Picture.LoadFromFile(arquivo);
    Deletefile(arquivo);
  end;
  Str.Free;
  }
end;


end.

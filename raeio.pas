unit raeio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, SqlDtg, Buttons, SQLBtn, ExtCtrls, SQLGrid, StdCtrls,
  Mask, SQLEd;

type
  TFRateio = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    bSair: TSQLBtn;
    GridRateio: TSqlDtGrid;
    EdCodigo: TSQLEd;
    Edvalor: TSQLEd;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRateio: TFRateio;

implementation

{$R *.dfm}

end.

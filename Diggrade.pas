unit Diggrade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, SqlDtg, ExtCtrls, SQLGrid ;
//  DataGrid;

type
  TFGrade = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    PGrade: TSQLPanelGrid;
    GridGrade: TSqlDtGrid;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(Unidade,CodigoProduto:string;Codigograde:integer);
  end;

var
  FGrade: TFGrade;

implementation

{$R *.dfm}


procedure TFGrade.Execute(Unidade, CodigoProduto: string;
  Codigograde: integer);
begin
  Showmodal;
end;

end.

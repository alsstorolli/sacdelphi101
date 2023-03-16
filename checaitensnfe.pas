unit checaitensnfe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ACBrNFe, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn,
  alabel, ExtCtrls, SQLGrid;

type
  TFChecaItensNfe = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PTotais: TSQLPanelGrid;
    EdBaseIcms: TSQLEd;
    EdValorIcms: TSQLEd;
    EdTotalprodutos: TSQLEd;
    EdTotalNota: TSQLEd;
    PRemessa: TSQLPanelGrid;
    EdFornec: TSQLEd;
    SetEdFORN_NOME: TSQLEd;
    EdComv_codigo: TSQLEd;
    EdComv_descricao: TSQLEd;
    ACBrNFe1: TACBrNFe;
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  FChecaItensNfe: TFChecaItensNfe;

implementation

{$R *.dfm}

end.

unit Arquivos;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.PG, FireDAC.Phys.PGDef,
  SqlSis;

type
  TArq = class(TDataModule)
    Conexao: TFDConnection;
    Transacao: TFDTransaction;
    TPortadores: TFDTable;
    DriverLink: TFDPhysPgDriverLink;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Arq: TArq;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.

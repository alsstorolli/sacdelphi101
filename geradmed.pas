// 17.02.2021
// Gera��o de arquivo texto para ser importado nda Dmed

unit geradmed;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Mask,
  SQLEd, Vcl.Buttons, SQLBtn, alabel, SQLGrid, Vcl.ExtCtrls, SqlFun, SqlSis, SqlExpr;

type
  TFGeraDmed = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bExecutar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    Edunidade: TSQLEd;
    EdUnid_codigo: TSQLEd;
    Texto: TRichEdit;
    Edinicio: TSQLEd;
    Edtermino: TSQLEd;
    procedure EdterminoValidate(Sender: TObject);
    procedure EdUnid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure bExecutarClick(Sender: TObject);
    procedure EdUnid_codigoExitEdit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;

  end;

type TRPPSS = record

     codigo,
     nome   : string;
     valor  : currency;

end;

var
  FGeraDmed  : TFGeraDmed;
  ano        : integer;
  codigocnes : string;

const sep  :string = '|';

implementation

uses geral;


{$R *.dfm}

{ TFGeraDmed }

procedure TFGeraDmed.bExecutarClick(Sender: TObject);
//////////////////////////////////////////////////////////////
var Q : TSqlquery;
    ListaRPPSS   : TList;
    PRPPSS       : ^TRPPSS;
    linha,
    arquivo      : string;
    i            : integer;
    ListaPSS,
    ListaGeral   : Tstringlist;


    procedure AtualizaLista;
    //////////////////////////
    var p     : integer;
        achou : boolean;

    begin

        achou := false;
        for p := 0 to ListaRPPSS.count-1 do begin

           PRPPSS := ListaRPPSS[p];
           if prppss.codigo = trim(Q.fieldbyname('clie_cnpjcpf').asstring) then begin

             Prppss.valor := Prppss.valor + Q.fieldbyname('moes_vlrtotal').ascurrency;
             achou := true;

           end;

        end;

        if not achou then begin

             New(prppss);
             Prppss.codigo := trim(Q.fieldbyname('clie_cnpjcpf').asstring);
             Prppss.nome   := Q.fieldbyname('clie_nome').asstring;
             Prppss.valor  := Q.fieldbyname('moes_vlrtotal').ascurrency;
             ListaRPPSS.add( pRPPSS );

        end;

    end;


begin

  if not EdUnid_codigo.validfind then exit;
  if not EdUnid_codigo.valid then exit;
  if not EdTermino.valid then exit;
  if not confirma('Confirma exporta��o ?') then exit;

  ano := Datetoano( EdTermino.asdate,true )+1;
  texto.clear;

  codigocnes := '7134312';  // ver se precisa criar campo no cadastro de unidades...
                            // este � do Marcio Santos
  Sistema.beginprocess('Lendo movimento do per�odo');
  Q:=sqltoquery('select moes_tipo_codigo,moes_vlrtotal,clie_tipo,clie_cnpjcpf,clie_nome,moes_numerodoc from movesto'+
                ' inner join clientes on ( clie_codigo = moes_tipo_codigo )'+
                ' where '+FGeral.Getin('moes_status','N;X;E;D','C')+
                ' and moes_dataemissao >= '+EdInicio.assql+
                ' and moes_dataemissao <= '+EdTermino.assql+
                ' and moes_tipomov = '+stringtosql( global.CodPrestacaoServicos )+
                ' and '+FGeral.GetNOTIN('moes_serie','D;D ','C')+
                ' and '+FGeral.GetNOTIN('moes_especie','CF;CF ;','C')+
                ' and moes_unid_codigo='+EdUnid_codigo.assql+
                ' and moes_datacont is not null'+
                ' and '+FGeral.GetNOTIN('moes_tipomov',Global.TiposNaoFiscal,'C')+
                ' order by clie_cnpjcpf');
  if Q.eof then begin

     Sistema.endprocess('N�o encontrado notas de servi�o neste per�odo');
     exit;

  end;

  ListaRPPSS   := TList.create;

  while not Q.eof do begin

     if Q.fieldbyname('clie_tipo').asstring = 'F' then  begin

        AtualizaLista;

     end else Texto.Lines.Add(' J - NF '+Q.fieldbyname('moes_numerodoc').asstring+
                              ' Cliente '+copy(Q.fieldbyname('clie_nome').asstring,1,30)+
                              ' - '+Q.fieldbyname('moes_tipo_codigo').asstring);
     Q.Next;

  end;

  ListaPSS     := Tstringlist.create;
  ListaGeral   := Tstringlist.create;

  for i := 0 to LIstaRPPSS.count-1 do begin

      pRPPSS := ListaRPPSS[i];
        linha := 'RPPSS'+sep;
        linha := linha + copy(pRPPSS.codigo,1,11) +  sep;
        linha := linha + pRPPSS.nome +  sep;
        linha := linha + FormatFloat('#######',int(pRPPSS.valor)) + FormatFloat('00',pRPPSS.valor - int(pRPPSS.valor) )  +  sep;
      ListaPSS.add( linha );

  end;

  if ListaPSS.count > 0 then  begin

    linha := 'Dmed' + sep;
    linha := linha + strzero(ano,4) + sep;
    linha := linha + strzero(ano-1,4) + sep;
    linha := linha + 'N' + sep;
    linha := linha + '' + sep;  // no de recibo se for retificadora...
    linha := linha + space(06) + sep;  // identificador da estrutura do layout
    ListaGeral.add( linha );

    linha := 'RESPO' + sep;
    linha := linha + copy(EdUnid_codigo.resultfind.fieldbyname('unid_cpfresponsavel').asstring,1,11) + sep;
    linha := linha + copy(EdUnid_codigo.resultfind.fieldbyname('unid_nome').asstring,1,60) + sep;
    linha := linha + copy(EdUnid_codigo.resultfind.fieldbyname('unid_fone').asstring,1,02) + sep;
    linha := linha + copy(EdUnid_codigo.resultfind.fieldbyname('unid_fone').asstring,03,09) + sep;
    linha := linha + '' + sep;  // ramal
    linha := linha + '' + sep;  // fax
    linha := linha + copy(EdUnid_codigo.resultfind.fieldbyname('unid_email').asstring,1,60) + sep;
    ListaGeral.add( linha );

    linha := 'DECPJ' + sep;
    linha := linha + copy(EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring,1,14) + sep;
    linha := linha + copy(EdUnid_codigo.resultfind.fieldbyname('unid_razaosocial').asstring,1,60) + sep;
    linha := linha + '1' + sep ;  // tipo de declarante 1-prestador de servi�o
    linha := linha + '' + sep;  // registro ANS quando for operador plano de saude
    linha := linha + codigocnes + sep;  // cnes
    linha := linha + copy(EdUnid_codigo.resultfind.fieldbyname('unid_cpfresponsavel').asstring,1,11) + sep;
    linha := linha + 'N' + sep ;  // indicador de situa��o especial
    linha := linha + '' + sep;  // data do evento da sit. especial
    linha := linha + '' + sep ;  // indicador se possui registro na ANS
    ListaGeral.add( linha );

    linha := 'PSS' + sep;
    ListaGeral.add( linha );

    for I := 0 to ListaPSS.count-1 do  begin

       ListaGeral.add( LIstaPSS[i] );

    end;

    linha := 'FIMDmed' + sep;
    ListaGeral.add( linha );

    arquivo :='DMed'+strzero(ano,4)+'.TXT';
    ListaGeral.SaveToFile( arquivo );
    Sistema.endprocess('Arquivo '+arquivo+' gerado na pasta do sistema');

  end else

    Sistema.endprocess('NADA GERADO');

  ListaPSS.free;
  ListaGeral.free;
  ListaRPPSS.free;

end;

procedure TFGeraDmed.EdterminoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////
begin
   if EdTermino.asdate<EdInicio.Asdate then
     EdTermino.INvalid('T�rmino tem que ser posterior ao inicio');

end;

procedure TFGeraDmed.EdUnid_codigoExitEdit(Sender: TObject);
/////////////////////////////////////////////////////////////////////
begin

   bExecutarClick(self);

end;

procedure TFGeraDmed.EdUnid_codigoKeyPress(Sender: TObject; var Key: Char);
/////////////////////////////////////////////////////////////////////
begin
  FGeral.Limpaedit(EdUNid_codigo,key);

end;

procedure TFGeraDmed.Execute;
/////////////////////////////
begin

   Edinicio.Setdate(Sistema.Hoje);
   EdTermino.setdate(Datetoultimodiames(Sistema.hoje));
   texto.clear;
   FGeral.ConfiguraColorEditsNaoEnabled( FGeradmed );
   Show;
   EdInicio.setfocus;

end;

end.

// 31.05.19
// Gerenciamento do MDF-e

unit gerenciamdfe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ACBrDFeReport, ACBrMDFeDAMDFeClass,
  ACBrMDFeDAMDFeRLClass, ACBrBase, ACBrDFe, ACBrMDFe, Vcl.Grids, SqlDtg,
  Vcl.StdCtrls, Vcl.Mask, SQLEd, Vcl.Buttons, SQLBtn, alabel, SQLGrid,
  Vcl.ExtCtrls, SqlExpr;

type
  TFGerenciaMdf = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    pgrid: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    ACBrMDFe1: TACBrMDFe;
    ACBrMDFeDAMDFeRL1: TACBrMDFeDAMDFeRL;
    bimpdanfe: TSQLBtn;
    bcancelamdfe: TSQLBtn;
    bSair: TSQLBtn;
    Edinicio: TSQLEd;
    EdTermino: TSQLEd;
    bencerramdf: TSQLBtn;
    bconsultamdfe: TSQLBtn;
    bverxml: TSQLBtn;
    bnaoencerrados: TSQLBtn;
    Memo1: TMemo;
    procedure EdTerminoExitEdit(Sender: TObject);
    procedure bencerramdfClick(Sender: TObject);
    procedure bimpdanfeClick(Sender: TObject);
    procedure bcancelamdfeClick(Sender: TObject);
    procedure bconsultamdfeClick(Sender: TObject);
    procedure bSairClick(Sender: TObject);
    procedure bverxmlClick(Sender: TObject);
    procedure bnaoencerradosClick(Sender: TObject);
    procedure GridClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(xcarga:integer=0);
    function GetSituacao( xretorno : string ):string;
    function GetSituacaoMFDe( xQ:Tsqlquery ):string;

  end;

var
  FGerenciaMdf: TFGerenciaMdf;
  Unidade,
  PathEnviados,
  PathRetorno,
  PathSchemas      : String;
  NumeroCarga      : integer;


implementation

uses SqlFun, Geral, SqlSis, pcnconversao,pmdfeConversaoMDFe, Transp,
  Unidades, expnfetxt, Mostraxml, munic;

{$R *.dfm}

{ TFGerenciaMdf }

procedure TFGerenciaMdf.bimpdanfeClick(Sender: TObject);
/////////////////////////////////////////////////////////////
var Q         : Tsqlquery;
    Datamvto  : TDatetime;
    p,
    Numlote   : integer;
    carga,
    tran,
    retorno   : string;

begin

  p:=Grid.Row;
  datamvto := TextToDate( Fgeral.TiraBarra( Grid.Cells[Grid.GetColumn('moes_dataemissao'),p] ));
  carga    := trim(Grid.Cells[Grid.GetColumn('moes_numerodoc'),p] );
  tran     := trim(Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),p] );

  Q:=sqltoquery('select movc_xmlmdfeenc,movc_xmlmdfe from movcargas where movc_status = ''N'''+
                ' and movc_datamvto = '+Datetosql( datamvto )+
                ' and movc_numero   = '+carga+
                ' and movc_tran_codigo = '+stringtosql(tran)+
                ' and movc_unid_codigo = '+Stringtosql(Unidade) ) ;

  if Q.Eof then begin
     Avisoerro('Carga '+carga+' de '+FGeral.FormataData(datamvto)+' n�o encontrada');
     exit;
  end;

  if length(trim(Q.FieldByName('movc_xmlmdfe').AsString)) <= 10 then begin

     Avisoerro('Manifesto ainda n�o autorizado');
     exit;

  end;

    ACBrMDFe1.Manifestos.Clear;
    ACBrMDFe1.Manifestos.LoadFromString( Q.FieldByName('movc_xmlmdfe').AsString );
    if NumeroCarga>0 then ACBrMDFeDAMDFeRL1.MostraPreview:=false
    else ACBrMDFeDAMDFeRL1.MostraPreview:=true;
// 13.05.2022
    ACBrMDFeDAMDFeRL1.MargemEsquerda:=5;
    ACBrMDFe1.Manifestos.Imprimir;

end;

// 09.07.19
procedure TFGerenciaMdf.bnaoencerradosClick(Sender: TObject);
/////////////////////////////////////////////////////////////
var vcnpj,
    vchave :string;
    p,
    i      :integer;

begin

  vCNPJ :=  FUnidades.GetCnpjcpf( Global.CodigoUnidade );
//  memo1.Visible:=true;
//  memo1.Clear;
  try
    ACBrMDFe1.WebServices.ConsultaMDFeNaoEnc( vCNPJ );
  finally

    Grid.Clear;
    p:=1;
    for i := 0 to ACBrMDFe1.WebServices.ConsMDFeNaoEnc.InfMDFe.Count-1 do begin

      Grid.Cells[Grid.GetColumn('chavemdfe'),p]:=ACBrMDFe1.WebServices.ConsMDFeNaoEnc.InfMDFe.Items[i].chMDFe ;
      Grid.Cells[Grid.GetColumn('numeronfe'),p]:=ACBrMDFe1.WebServices.ConsMDFeNaoEnc.InfMDFe.Items[i].nProt ;
      Grid.AppendRow;
      inc(p);

    end;

//    Aviso(  ''  );

//    Memo1.Lines.Text :=(  (ACBrMDFe1.WebServices.ConsMDFeNaoEnc.RetornoWS) );
//    Aviso(  ''  );

  end;
//  memo1.Visible:=false;


end;

procedure TFGerenciaMdf.bSairClick(Sender: TObject);
begin

end;

// 28.06.19
procedure TFGerenciaMdf.bverxmlClick(Sender: TObject);
///////////////////////////////////////////////////////
var Q         : Tsqlquery;
    Datamvto  : TDatetime;
    p,
    Numlote   : integer;
    carga,
    tran,
    retorno   : string;
    wxml      :AnsiString;
    Lista     :TStringList;

begin

  p:=Grid.Row;
  datamvto := TextToDate( Fgeral.TiraBarra( Grid.Cells[Grid.GetColumn('moes_dataemissao'),p] ));
  carga    := trim(Grid.Cells[Grid.GetColumn('moes_numerodoc'),p] );
  tran     := trim(Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),p] );

  Q:=sqltoquery('select movc_xmlmdfeenc,movc_xmlmdfe from movcargas where movc_status = ''N'''+
                ' and movc_datamvto = '+Datetosql( datamvto )+
                ' and movc_numero   = '+carga+
                ' and movc_tran_codigo = '+stringtosql(tran)+
                ' and movc_unid_codigo = '+Stringtosql(Unidade) ) ;

  if Q.Eof then begin
     Avisoerro('Carga '+carga+' de '+FGeral.FormataData(datamvto)+' n�o encontrada');
     exit;
  end;

   if length(trim(Q.FieldByName('movc_xmlmdfe').AsString)) <= 10 then begin

     Avisoerro('Manifesto ainda n�o autorizado');
     exit;

  end;

     wxml:=Q.fieldbyname('movc_xmlmdfe').asstring;
{
     if trim(wxml)='' then begin
        Lista:=TStringList.Create;
        arqxml:= acbrnfe1.Configuracoes.Arquivos.PathNFe+'\'+
                strzero(Datetoano(Q.fieldbyname('moes_dataemissao').AsDateTime,true),4)+
                strzero(Datetomes(Q.fieldbyname('moes_dataemissao').AsDateTime),2)+'\'+
                inttostr(Q.FieldByName('moes_numerodoc').AsInteger)+
                strzero(Datetodia(Q.fieldbyname('moes_dataemissao').AsDateTime),2)+
                strzero(Datetomes(Q.fieldbyname('moes_dataemissao').AsDateTime),2)+
                strzero(Datetoano(Q.fieldbyname('moes_dataemissao').AsDateTime,false),2)+
                '-NFe.xml';
        if FileExists( arqxml ) then begin
           Lista.LoadFromFile(arqxml);
           wxml:=Lista.Strings[0];
           Lista.Free;
        end;
     end;
     }
     if trim(wxml)<>'' then
       FMostraXml.Execute(  wxml )
     else
       Avisoerro('N�o foi poss�vel encontrar o xml desta nota');

   FGeral.FechaQuery(Q);

end;

procedure TFGerenciaMdf.EdTerminoExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////
var Q,
    Q1       :TSqlquery;
    p        :integer;
    sqlcarga : string;

begin

  sqlcarga:='';
  if NUmerocarga>0 then  sqlcarga:=' and movc_numero = '+inttostr(Numerocarga);

  Q:=sqltoquery('select *,cola_descricao from movcargas '+
                ' inner join colaboradores on ( movc_cola_codigo01=cola_codigo )'+
                ' where movc_status = ''N'''+
                ' and movc_datamvto >= '+EdInicio.AsSql+
                sqlcarga+
                ' and movc_datamvto <= '+EdTermino.AsSql+
                ' and movc_unid_codigo = '+Stringtosql(Unidade)+
                ' order by movc_datamvto' ) ;
  Grid.Clear;
  p:=1;

  while not Q.Eof do begin

// 20.07.20 - para nao mostrar 'cargas sem notas'...
// 29.04.2022 - desativado pois 'sem novicarnes'
//    Q1:=sqltoquery('select mped_numerodoc from movped where mped_nftrans = '+Q.FieldByName('movc_numero').AsString+
//                   ' and mped_unid_codigo = '+Stringtosql(Unidade));

                      // 10.12.20
//    if (not Q1.eof) or ( NumeroCarga>0 ) or ( Global.Topicos[1058] ) then begin
//    if ( NumeroCarga>0 ) or ( Global.Topicos[1058] ) then begin
// 13.05.2022 - Sicare - mdfe 'do fornecedor'

        Grid.Cells[Grid.GetColumn('moes_numerodoc'),p]:=Q.FieldByName('movc_numero').AsString;
        Grid.Cells[Grid.GetColumn('moes_dataemissao'),p]:=FGeral.FormataData( Q.fieldbyname('movc_datamvto').asdatetime );
        Grid.Cells[Grid.GetColumn('moes_vlrtotal'),p]:=Q.FieldByName('movc_pesonotas').AsString;
        Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),p]:=Q.FieldByName('movc_tran_codigo').AsString;
        Grid.Cells[Grid.GetColumn('clie_razaosocial'),p]:=FTransp.GetNome( Q.FieldByName('movc_tran_codigo').AsString ) ;
        Grid.Cells[Grid.GetColumn('numeronfe'),p]:=Q.FieldByName('movc_protocolo').AsString ;
    //    Grid.Cells[Grid.GetColumn('transacao'),p]:=Q.FieldByName('movc_transacao').AsString ;
        Grid.Cells[Grid.GetColumn('pesopedido'),p]:=Q.FieldByName('movc_dtauto').AsString ;
        Grid.Cells[Grid.GetColumn('motorista'),p]:=Q.FieldByName('cola_descricao').AsString ;
        Grid.Cells[Grid.GetColumn('situacao'),p]:=GetSituacaoMFDe( Q ) ;
        inc(p);
        Grid.AppendRow;

//    end;
    Q.Next;
//    FGeral.FechaQuery( Q1 );

  end;
  FGeral.FechaQuery(Q);

end;

//////////////////////////////////////////////////////
procedure TFGerenciaMdf.Execute(xcarga:integer=0);
//////////////////////////////////////////////////////
begin

    EdInicio.ClearAll(Self,0);
    Grid.Clear;
    EdInicio.SetDate(Sistema.hoje-1);
    NumeroCarga:=xcarga;

    if Global.Usuario.Codigo=100 then
       EdInicio.SetDate(Sistema.hoje-32);

    EdTermino.setdate(sistema.hoje);
    unidade:=Global.CodigoUnidade;

    PathSchemas :=ExtractFilePath( Application.ExeName ) + 'SchemasMdfe';
    PathEnviados:=ExtractFilePath( Application.ExeName ) + 'EnviadosMdfe';
    PathRetorno :=ExtractFilePath( Application.ExeName ) + 'Retornos';

    AcbrMdfe1.Configuracoes.Arquivos.PathSchemas:=PathSchemas;

    AcbrMdfe1.Configuracoes.Arquivos.Salvar:=true;
    AcbrMdfe1.Configuracoes.Geral.VersaoDF:=ve300;

    if trim(FGeral.GetConfig1AsString('Pastaimagemdanfe'))<>'' then begin

        if FileExists( FGeral.GetConfig1AsString('Pastaimagemdanfe') ) then begin
            ACBrMDFeDAMDFeRL1.Logo:=FGeral.GetConfig1AsString('Pastaimagemdanfe');
        end else if FileExists( ExtractFilePath( Application.ExeName ) + FGeral.GetConfig1AsString('Pastaimagemdanfe') ) then begin
            ACBrMDFeDAMDFeRL1.Logo:=ExtractFilePath( Application.ExeName )+ FGeral.GetConfig1AsString('Pastaimagemdanfe');
        end else begin
          ACBrMDFeDAMDFeRL1.Logo:='';
          if AcbrMdFe1.DAMDFE<>nil then
            AcbrMdFe1.DAMDFE.Logo:='';
        end;

    end else begin

       ACBrMDFeDAMDFeRL1.Logo:='';

    end;

    if trim(FGeral.GetConfig1AsString('Pastaexpnfexml'))<>'' then

    acbrmdfe1.Configuracoes.Arquivos.PathMDFe:=PathEnviados;

    acbrmdfe1.Configuracoes.Certificados.NumeroSerie:=FGeral.GetNroSerieCertificado(Unidade);
    if trim(FGeral.GetConfig1AsString('Pastaretonfexml'))<>'' then begin
      acbrmdfe1.Configuracoes.Arquivos.PathEvento:=FGeral.GetConfig1AsString('Pastaretonfexml');
      acbrmdfe1.Configuracoes.Arquivos.PathSalvar:=FGeral.GetConfig1AsString('Pastaretonfexml');
    end;

    FGeral.ConfiguraCriptografiaAcbrMdfe( AcbrMdfe1 );
    AcbrMdfe1.Configuracoes.RespTec.IdCSRT:=0;
    AcbrMdfe1.Configuracoes.RespTec.CSRT  :='';
    if trim( FGeral.GetConfig1AsString('AmbienteNFe') )<>'' then  begin
        if FGeral.GetConfig1AsString('AmbienteNFe') = '1' then
           AcbrMdfe1.Configuracoes.WebServices.Ambiente:=taproducao
        else
           AcbrMdfe1.Configuracoes.WebServices.Ambiente:=tahomologacao;
    end else

        AcbrMdfe1.Configuracoes.WebServices.Ambiente:=tahomologacao;

    Show;
    FGeral.ConfiguraColorEditsNaoEnabled(Self);

    if NumeroCarga >0  then begin

       EdTermino.DoValidate;
       bimpdanfeClick(self);
       Close;

    end else EdInicio.SetFocus;

end;

function TFGerenciaMdf.GetSituacao(xretorno: string): string;
//////////////////////////////////////////////////////////////
begin

   if AnsiPos('Cancelado',xretorno) > 0 then  result:='C'
   else if AnsiPos('Encerrado',xretorno) > 0 then result:='E'
   else result:='A';


end;

function TFGerenciaMdf.GetSituacaoMFDe(xQ: Tsqlquery): string;
//////////////////////////////////////////////////////////////
begin

   if length(trim(xQ.FieldByName('movc_xmlmdfe').AsString)) <= 10 then
      result:='N�o autorizado'
   else if length(trim(xQ.FieldByName('movc_xmlcancmdfe').AsString)) >= 10 then
      result:='Cancelado'
   else if length(trim(xQ.FieldByName('movc_xmlmdfeenc').AsString)) >= 10 then
      result:='Encerrado'
   else
      result:='Autorizado';


end;

procedure TFGerenciaMdf.GridClick(Sender: TObject);
begin

end;

// 10.06.19
procedure TFGerenciaMdf.bcancelamdfeClick(Sender: TObject);
/////////////////////////////////////////////////////////////////////
var Q         : Tsqlquery;
    Datamvto  : TDatetime;
    p,
    Numlote   : integer;
    carga,
    tran,
    retorno,
    justificativa,
    xarq   : string;

begin

  p:=Grid.Row;
  datamvto := TextToDate( Fgeral.TiraBarra( Grid.Cells[Grid.GetColumn('moes_dataemissao'),p] ));
  carga    := trim(Grid.Cells[Grid.GetColumn('moes_numerodoc'),p] );
  tran     := trim(Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),p] );

// 21.07.20
  if trim(carga)<>'' then begin

      Q:=sqltoquery('select movc_xmlmdfeenc,movc_xmlmdfe,movc_dtenc from movcargas where movc_status = ''N'''+
                    ' and movc_datamvto = '+Datetosql( datamvto )+
                    ' and movc_numero   = '+carga+
                    ' and movc_tran_codigo = '+stringtosql(tran)+
                    ' and movc_unid_codigo = '+Stringtosql(Unidade) ) ;

      if Q.Eof then begin
         Avisoerro('Carga '+carga+' de '+FGeral.FormataData(datamvto)+' n�o encontrada');
         exit;
      end;

      if not Global.Usuario.OutrosAcessos[0303] then begin
         Avisoerro('Usu�rio sem permiss�o para cancelar documentos fiscais');
         exit;
      end;

      if trim(Q.FieldByName('movc_xmlmdfeenc').AsString)<>'' then begin

         Avisoerro('Proibido cancelar, manifesto j� encerrado dia '+FGeral.FormataData(Q.FieldByName('movc_dtenc').AsDateTime));
         exit;

      end else if length(trim(Q.FieldByName('movc_xmlmdfe').AsString)) <= 10 then begin

         Avisoerro('Manifesto ainda n�o autorizado');
         exit;

      end;

  end;

  if not Input('Justificativa ( m�nimo 15 caracteres )','Motivo Cancelamento',justificativa,150,true) then exit;

    if trim(justificativa)='' then begin
      Avisoerro('Campo de preenchimento obrigat�rio');
      exit;
    end;
    if length(trim(justificativa))<15 then begin
      Avisoerro('Minimo de 15 caracteres para justificativa');
      exit;
    end;

    ACBrMDFe1.Manifestos.Clear;

  // 21.07.20
    if trim(carga)<>'' then

       ACBrMDFe1.Manifestos.LoadFromString( Q.FieldByName('movc_xmlmdfe').AsString )

    else  begin

       xarq := 'D:\Clientes\PedroStaMaria\xmlDfe-41200729587833000182580010000000021000000029.xml';
       ACBrMDFe1.Manifestos.LoadFromFile( xarq )

    end;

    Numlote:=FGEral.GetContador('LOTEMDFECANC'+Global.CodigoUnidade,false);
    ACBrMDFe1.Cancelamento(trim(justificativa), Numlote);
    retorno   := ACBrMDFe1.WebServices.EnvEvento.Retws;

    if AnsiPos( 'Evento registrado e vinculado', retorno ) > 0 then begin

     Sistema.Edit('movcargas');
     Sistema.SetField('movc_dtcanc',Sistema.Hoje);
     Sistema.SetField('movc_xmlcancmdfe',ACBrMDFe1.WebServices.EnvEvento.RetWS);
     Sistema.Post('movc_status = ''N'''+
                ' and movc_datamvto = '+Datetosql( datamvto )+
                ' and movc_numero   = '+carga+
                ' and movc_tran_codigo = '+stringtosql(tran)+
                ' and movc_unid_codigo = '+Stringtosql(Unidade) ) ;
     Sistema.Commit;
     Aviso('Manifesto cancelado com sucesso');

    end else

       showmessage( 'Manifesto n�o cancelado. Verificar '+retorno );


end;


// 11.06.19
procedure TFGerenciaMdf.bconsultamdfeClick(Sender: TObject);
/////////////////////////////////////////////////////////////
var Q         : Tsqlquery;
    Datamvto  : TDatetime;
    p,
    Numlote   : integer;
    carga,
    tran,
    retorno,
    vchave,
    protocolo,
    vcnpj     : string;

begin

  vCNPJ :=  FUnidades.GetCnpjcpf( Global.CodigoUnidade );

  p:=Grid.Row;
  datamvto := TextToDate( Fgeral.TiraBarra( Grid.Cells[Grid.GetColumn('moes_dataemissao'),p] ));
  carga    := trim(Grid.Cells[Grid.GetColumn('moes_numerodoc'),p] );
  tran     := trim(Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),p] );
  vchave   := trim(Grid.Cells[Grid.GetColumn('chavemdfe'),p] );
  protocolo:= trim(Grid.Cells[Grid.GetColumn('numeronfe'),p] );

  if carga<>'' then begin

      Q:=sqltoquery('select movc_xmlmdfeenc,movc_xmlmdfe from movcargas where movc_status = ''N'''+
                    ' and movc_datamvto = '+Datetosql( datamvto )+
                    ' and movc_numero   = '+carga+
                    ' and movc_tran_codigo = '+stringtosql(tran)+
                    ' and movc_unid_codigo = '+Stringtosql(Unidade) ) ;

      if Q.Eof then begin
         Avisoerro('Carga '+carga+' de '+FGeral.FormataData(datamvto)+' n�o encontrada');
         exit;
      end;

//       if length(trim(Q.FieldByName('movc_xmlmdfe').AsString)) <= 10 then begin
//
//         Avisoerro('Manifesto ainda n�o autorizado');
//         exit;
//
//      end;
// 17.08.20
       if (trim(vchave)) = '' then begin

         Avisoerro('Manifesto sem chave de acesso');
         exit;

      end;

  end else begin

// 17.08.20
      Q:=sqltoquery('select movc_xmlmdfeenc,movc_xmlmdfe from movcargas where movc_status = ''N'''+
//                    ' and movc_datamvto = '+Datetosql( datamvto )+
                    ' and movc_protocolo   = '+stringtosql(protocolo)+
//                    ' and movc_tran_codigo = '+stringtosql(tran)+
                    ' and movc_unid_codigo = '+Stringtosql(Unidade) ) ;

      if Q.Eof then begin
         Avisoerro('Protocolo '+protocolo+' n�o encontrado');
         exit;
      end;


  end;

    ACBrMDFe1.Manifestos.Clear;
    if (carga<>'') and ( length(trim(Q.FieldByName('movc_xmlmdfe').AsString)) >50 )  then begin

      ACBrMDFe1.Manifestos.LoadFromString( Q.FieldByName('movc_xmlmdfe').AsString );
      ACBrMDFe1.Consultar;

    end else begin

     ACBrMDFe1.WebServices.Consulta.MDFeChave := vChave;
     ACBrMDFe1.WebServices.Consulta.Executar;
// 17.08.20 - ainda nao implementado processo distribuicao para mdfe na receita
//     ACBrMDFe1.DistribuicaoDFePorChaveMDFe(vCNPJ, vChave)

    end;

    retorno   := FExpNfetxt.GetTag('xmotivo',ACBrMDFe1.WebServices.Consulta.RetWS);
    Memo1.Clear;
    Memo1.Lines.Text :=ACBrMDFe1.WebServices.Consulta.RetWS;

    showmessage('Situa��o manifesto : '+retorno);

    if GetSituacao( retorno ) = 'E' then begin

       Aviso('Situacao = E - Encerrado');
       if length(trim(Q.FieldByName('movc_xmlmdfeenc').AsString)) <= 10 then begin

          Sistema.Edit('movcargas');
          Sistema.Setfield('movc_xmlmdfeenc',ACBrMDFe1.WebServices.Consulta.RetWS);
          Sistema.Post('movc_status = ''N'''+
                ' and movc_datamvto = '+Datetosql( datamvto )+
                ' and movc_numero   = '+carga+
                ' and movc_tran_codigo = '+stringtosql(tran)+
                ' and movc_unid_codigo = '+Stringtosql(Unidade) ) ;
          sistema.Commit;

       end;

    end else if GetSituacao( retorno ) = 'C' then begin

       Aviso('Situacao = C - Cancelado');

       if length(trim(Q.FieldByName('movc_xmlcancmdfe').AsString)) <= 10 then begin

          Sistema.Edit('movcargas');
          Sistema.Setfield('movc_xmlcancmdfe',ACBrMDFe1.WebServices.Consulta.RetWS);
          Sistema.Post('movc_status = ''N'''+
                ' and movc_datamvto = '+Datetosql( datamvto )+
                ' and movc_numero   = '+carga+
                ' and movc_tran_codigo = '+stringtosql(tran)+
                ' and movc_unid_codigo = '+Stringtosql(Unidade) ) ;
          sistema.Commit;

// 17.08.20 - autorizado - feito aqui devido a 'evento' de 15.08 que ficou mdfe autorizado na receita
//            porem nada registro no banco de dados
       end

    end else if (Q.FieldByName('movc_xmlmdfe').AsString='') and ( trim(carga)<>'')  then begin

{
          Sistema.Edit('movcargas');
          Sistema.Setfield('movc_xmlmdfe',ACBrMDFe1.WebServices.Consulta.RetWS);
          Sistema.Post('movc_status = ''N'''+
                ' and movc_datamvto = '+Datetosql( datamvto )+
                ' and movc_numero   = '+carga+
                ' and movc_tran_codigo = '+stringtosql(tran)+
                ' and movc_unid_codigo = '+Stringtosql(Unidade) ) ;
          sistema.Commit;
}
          Aviso('N�o atualizado xml no banco de dados ref. carga '+carga);

//    end else if (Q.FieldByName('movc_xmlmdfe').AsString='') and ( trim(carga) ='')  then begin
    end else if ( trim(carga) ='')  then begin

{
          Sistema.Edit('movcargas');
          Sistema.Setfield('movc_xmlmdfe',ACBrMDFe1.WebServices.DistribuicaoDFe.RetornoWS);
          Sistema.Post('movc_status = ''N'''+
//                ' and movc_datamvto = '+Datetosql( datamvto )+
                ' and movc_protocolo  = '+stringtosql(protocolo)+
//                ' and movc_tran_codigo = '+stringtosql(tran)+
                ' and movc_unid_codigo = '+Stringtosql(Unidade) ) ;
          sistema.Commit;
}
          Aviso('N�o atualizado xml no banco de dados ref. protocolo '+protocolo);


    end else Aviso(' Situa��o '+GetSituacao( retorno )+' por�m sem atualiza��o no banco de dados');

    Memo1.Clear;


end;

procedure TFGerenciaMdf.bencerramdfClick(Sender: TObject);
///////////////////////////////////////////////////////
var Q         : Tsqlquery;
    Datamvto  : TDatetime;
    p,
    Numlote   : integer;
    carga,
    tran,
    retorno,
    vchave,
    vprotocolo   : string;

begin

  p:=Grid.Row;
  datamvto   := TextToDate( Fgeral.TiraBarra( Grid.Cells[Grid.GetColumn('moes_dataemissao'),p] ));
  carga      := trim(Grid.Cells[Grid.GetColumn('moes_numerodoc'),p] );
  tran       := trim(Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),p] );
  vchave     := trim(Grid.Cells[Grid.GetColumn('chavemdfe'),p] );
  vprotocolo := trim(Grid.Cells[Grid.GetColumn('numeronfe'),p] );

  if carga<>'' then begin

      Q:=sqltoquery('select * from movcargas where movc_status = ''N'''+
                    ' and movc_datamvto = '+Datetosql( datamvto )+
                    ' and movc_numero   = '+carga+
                    ' and movc_tran_codigo = '+stringtosql(tran)+
                    ' and movc_unid_codigo = '+Stringtosql(Unidade) ) ;

      if Global.Usuario.codigo=100 then Aviso('Datamvto='+FGeral.formatadata(datamvto,true)+'|'+q.sql.text );

      if Q.Eof then begin
         Avisoerro('Carga '+carga+' de '+FGeral.FormataData(datamvto)+' n�o encontrada');
         exit;
      end;
      if trim(Q.FieldByName('movc_xmlmdfeenc').AsString)<>'' then begin

         Avisoerro('Manifesto j� encerrado dia '+FGeral.FormataData(Q.FieldByName('movc_dtenc').AsDateTime));
         exit;

      end else if length(trim(Q.FieldByName('movc_xmlmdfe').AsString)) <= 10 then begin

         Avisoerro('Manifesto ainda n�o autorizado');
         exit;

      end;

  end;

  if not confirma('Confirma encerramento') then exit;

  Sistema.BeginProcess('Enviando encerramento');

    Numlote:=FGEral.GetContador('LOTEMDFE'+Global.CodigoUnidade,false)+1;

    ACBrMDFe1.Manifestos.Clear;
    if carga<>'' then

       ACBrMDFe1.Manifestos.LoadFromString( Q.FieldByName('movc_xmlmdfe').AsString );

    ACBrMDFe1.EventoMDFe.Evento.Clear;


    with ACBrMDFe1.EventoMDFe.Evento.Add do
    begin

      if carga<>'' then
         infEvento.chMDFe   := Copy(ACBrMDFe1.Manifestos.Items[0].MDFe.infMDFe.ID, 5, 44)
      else
         infEvento.chMDFe   := vchave;

  //    Aviso(  'chave mdfe = '+infEvento.chMDFe );

      infEvento.CNPJCPF  := FUnidades.GetCnpjcpf( Global.CodigoUnidade );
      infEvento.dhEvento := now;
//  TpcnTpEvento = (teCCe, teCancelamento, teManifDestConfirmacao, teManifDestCiencia,
//                  teManifDestDesconhecimento, teManifDestOperNaoRealizada,
//                  teEncerramento);
      infEvento.tpEvento   := teEncerramento;
      infEvento.nSeqEvento := 1;
      infEvento.detEvento.dtEnc := Date;
      if carga<>'' then begin

        infEvento.detEvento.nProt := ACBrMDFe1.Manifestos.Items[0].MDFe.procMDFe.nProt;
        infEvento.detEvento.cUF   := StrToInt(Copy(IntToStr(ACBrMDFe1.Manifestos.Items[0].MDFe.infDoc.infMunDescarga.Items[0].cMunDescarga),1,2));
        infEvento.detEvento.cMun  := ACBrMDFe1.Manifestos.Items[0].MDFe.infDoc.infMunDescarga.Items[0].cMunDescarga;

      end else begin

        infEvento.detEvento.nProt := vprotocolo;

        Q:=sqltoquery('select movc_xmlmdfe from movcargas where movc_status = ''N'''+
                      ' and movc_protocolo = '+Stringtosql(vprotocolo)+
                      ' and movc_unid_codigo = '+Stringtosql(Unidade) ) ;
        if not Q.Eof then begin

            ACBrMDFe1.Manifestos.LoadFromString( Q.FieldByName('movc_xmlmdfe').AsString );
            infEvento.detEvento.cMun  := ACBrMDFe1.Manifestos.Items[0].MDFe.infDoc.infMunDescarga.Items[0].cMunDescarga;
            infEvento.detEvento.cUF   := StrToInt(Copy(IntToStr(ACBrMDFe1.Manifestos.Items[0].MDFe.infDoc.infMunDescarga.Items[0].cMunDescarga),1,2));

        end else begin

           Avisoerro('Protocolo n�o encontrado no arquivo de cargas');
// 09.11.20  - pra encerrar mdf q por algum motivo n�o gravou no sac..enviado codigo de pato branco
            infEvento.detEvento.cMun  := StrToInt(FCidades.GetCodigoIBGE( FUnidades.GetCidaCodigo(UNidade) ));
            infEvento.detEvento.cUF   := StrToInt(Copy(IntToStr(infEvento.detEvento.cMun),1,2));

        end;

      end;

    end;

    ACBrMDFe1.EnviarEvento(  Numlote  ); //  Numero do Lote

//    retorno   := ACBrUTF8ToAnsi(ACBrMDFe1.WebServices.EnvEvento.RetWS);
    retorno   := ACBrMDFe1.WebServices.EnvEvento.xMotivo;

//    showmessage( 'retornoWS = '+ACBrMDFe1.WebServices.EnvEvento.RetWS );

// cfe o retorno grava o xml do encerramento ( se tiver ) e a data do encerramento
  if AnsiPos( 'Evento registrado e vinculado', retorno ) > 0 then begin

     Sistema.Edit('movcargas');
     Sistema.SetField('movc_dtenc',Sistema.Hoje);
     Sistema.SetField('movc_xmlmdfeenc',ACBrMDFe1.WebServices.EnvEvento.RetWS);
     if carga<>'' then

        Sistema.Post('movc_status = ''N'''+
                ' and movc_datamvto = '+Datetosql( datamvto )+
                ' and movc_numero   = '+carga+
                ' and movc_tran_codigo = '+stringtosql(tran)+
                ' and movc_unid_codigo = '+Stringtosql(Unidade) )
     else
        Sistema.Post('movc_status = ''N'''+
                     ' and movc_protocolo = '+Stringtosql(vprotocolo)+
                     ' and movc_unid_codigo = '+Stringtosql(Unidade) ) ;

     Sistema.Commit;
     Aviso('Manifesto encerrado com sucesso');

  end else begin

    AvisoErro( 'Manifesto n�o encerrado. '+retorno );

  end;

  Sistema.EndProcess('');
  Q.Close;

end;

end.

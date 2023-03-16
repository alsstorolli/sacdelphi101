// 11.06.15
// Importa xmls a partir de uma pasta
// para novo cliente do SM - FAma

unit importanfe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, ComCtrls, Mask, SQLEd, Buttons, SQLBtn,
  alabel, SQLGrid, ExtCtrls, ACBrNFe, SqlFun,SqlExpr,SqlSis, ACBrBase,
  ACBrDFe, PcnConversaoNFe, pcnConversao;

type
  TFImportaNfe = class(TForm)
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
    SQLPanelGrid1: TSQLPanelGrid;
    ListaArq: TFileListBox;
    OpenDialog1: TOpenDialog;
    pb1: TProgressBar;
    lbcontador: TLabel;
    ACBrNFe1: TACBrNFe;
    procedure bExecutarClick(Sender: TObject);
    procedure EdUnid_codigoExitEdit(Sender: TObject);
    procedure EdterminoValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
  end;

var
  FImportaNfe: TFImportaNfe;

implementation

uses Geral;

{$R *.dfm}

{ TFImportaNfe }

procedure TFImportaNfe.Execute;
///////////////////////////////////
begin
  FGeral.ConfiguraColorEditsNaoEnabled(FImportaNfe);
  Show;
  Texto.Lines.Clear;
  Edinicio.setfocus;
  pb1.Position:=0;
end;

procedure TFImportaNfe.bExecutarClick(Sender: TObject);
///////////////////////////////////////////////////////////////////////////

type TMunicipios=record
     nome,uf,cep,codigoibge,codigopais,nomepais:string;
     codigo:integer;
end;

var p:integer;
    achou:boolean;
    Q:TSqlquery;
    ProcurarArquivo : TSearchRec;
    TamanhoArquivo  : Longint;
    F               : File of Byte;
    ListaTAmArq     : TStringList;
    LIstaMunicipios : TList;
    PMunicipios     :^TMunicipios;

    procedure LeMunicipios;
    ///////////////////////
    var Q:TSqlquery;
    begin
      Q:=sqltoquery('select * from cidades');
      ListaMunicipios:=Tlist.create;
      while not Q.eof do begin
        New(PMunicipios);
        PMunicipios.codigo:=Q.fieldbyname('cida_codigo').asinteger;
        PMunicipios.nome:=Ups(q.fieldbyname('cida_nome').asstring );
        PMunicipios.uf:=q.fieldbyname('cida_uf').asstring;
        ListaMunicipios.add( PMunicipios );
        Q.Next;
      end;
      Q.close;Freeandnil(q);
    end;


begin
  if EdUnid_codigo.isempty then exit;

  Texto.Lines.Clear;
  Texto.Font.Size:=10;
  Texto.Font.Style:=[fsbold];
  Texto.Lines.Add('Abrindo pastas...');
//  if not OpenDialog1.Execute then exit;
  OpenDialog1.Execute;
  pb1.Position:=0;
  pb1.Step:=1;
  Sistema.beginprocess('Iniciando importa��o');
  if confirma('Apagar importa��o anterior deste periodo ?') then begin

    Texto.Lines.Add('Eliminando importa��o anterior ');
    Q:=Sqltoquery( 'select moes_transacao from movesto where moes_unid_codigo='+EdUNid_codigo.Assql+
                   ' and moes_datamvto >= '+EdInicio.assql+
                   ' and moes_datamvto <= '+EdTermino.assql+
                   ' and moes_status<>''C'''+
                   ' and moes_obs = '+Stringtosql('Importado XML NFe') );
    achou:=false;
    while not Q.eof do begin

      Sistema.Edit('movbase');
      Sistema.SetField('movb_status','C');
      Sistema.Post('movb_transacao='+Stringtosql(Q.fieldbyname('moes_transacao').AsString));
      Sistema.Edit('movestoque');
      Sistema.SetField('move_status','C');
      Sistema.Post('move_transacao='+Stringtosql(Q.fieldbyname('moes_transacao').AsString));
      Sistema.Edit('movesto');
      Sistema.SetField('moes_status','C');
      Sistema.Post('moes_transacao='+Stringtosql(Q.fieldbyname('moes_transacao').AsString));
      achou:=true;
      Q.Next;

    end;
    Q.close;
    if achou then Sistema.commit;
  end;
  Texto.Lines.Add('Verificando pasta dos arquivos Xmls...');
  Texto.Lines.Add('Armazenando arquivos Xmls...');
  ListaArq.Directory:=ExtractFilePath( Opendialog1.FileName );
  Texto.Lines.Add('Encontrado '+inttostr(ListaArq.Items.Count)+' Xmls');
  pb1.Max:=ListaArq.Items.Count;
  lbcontador.caption:='';
 // 05.12.2021
  LeMunicipios;
  for p:=0 to ListaArq.Items.Count-1 do begin

    AcbrNfe1.NotasFiscais.Clear;
    try
      AcbrNfe1.NotasFiscais.LoadFromFile( ListaArq.Items[p] );
    except
      Avisoerro('N�o foi poss�vel ler o arquivo '+ListaArq.Items[p]);
      exit;
    end;

//    Texto.Lines.Add(Strzero(p,4)+'-'+ListaArq.Items[p]);

    pb1.Position:=p;
    lbcontador.caption:=strzero((p+1),4);
//    Texto.Perform(EM_LINESCROLL,0,Texto.Lines.Count);
    ListaArq.Items[p];
//    if FindFirst(ListaArq.Items[p], FaAnyFile, ProcurarArquivo) = 0 then begin
//       TamanhoArquivo := Int64(ProcurarArquivo.FindData.nFileSizeHigh) SHL Int64(32) +
//                         Int64(ProcurarArquivo.FindData.nFileSizeLow);
//    end;
// 14.10.16 - de repente o esquema acima voltou 0 de tamanho e tinha 8 Kbytes normal os xmls
//    AssignFile(F,ListaArq.Items[p]);
//    Reset(F);
//    TamanhoArquivo:=FileSize( F );
//
// e este tbem mas s� no servidor do SM....
    ListaTAmArq:=TStringList.create;
    ListaTamArq.LoadFromFile( ListaArq.Items[p] );
    TAmanhoArquivo:=ListaTamArq.Count;
// 02.03.17
//    if AcbrNFe1.IdentificaSchema(ListaArq.Items[p])=schEnvEventoCancNFe then
//    if Acbrnfe1.NotasFiscais.Count=0 then
    if Ansipos('TPEVENTO',uppercase(ListaTamArq.Text))>0 then
         Texto.Lines.Add('Arquivo '+ListaArq.Items[p]+' de cancelamento')
    else if Ansipos('INUTILIZACAO',uppercase(ListaTamArq.Text))>0 then
         Texto.Lines.Add('Arquivo '+ListaArq.Items[p]+' de inutiliza��o')
//        Fgeral.GravaNotaCancelada( ListaTamArq.Text,EdUNid_codigo.text,true )
//    else if Ansipos('INFNFE',uppercase(ListaTamArq.Text))=0 then
//         Texto.Lines.Add('Arquivo '+ListaArq.Items[p]+' n�o � de NF-e')
// 06.07.17
    else if Ansipos('INFCTE',uppercase(ListaTamArq.Text))>0 then
         Texto.Lines.Add('Arquivo '+ListaArq.Items[p]+' � de CT-e')
// 23.10.17
    else if Acbrnfe1.NotasFiscais.Count=0 then
       // nada a fazer
    else if (Acbrnfe1.NotasFiscais.Items[0].NFe.ide.modelo=65)
        and
        (FGeral.GetConfig1AsInteger('clieconsumidor')=0) then begin
         Texto.Lines.Add('XML de NFC-e.  Necess�rio configurar o cliente consumidor');

    end else begin

      if (TamanhoArquivo>0) and ( Ansipos('NFE',uppercase(ListaTamArq.Text))>0 ) then begin

         if  Acbrnfe1.NotasFiscais.Items[0].NFe.Ide.tpNF=tnSaida then begin

            if ( Trunc(Acbrnfe1.NotasFiscais.Items[0].NFe.Ide.dEmi)>=EdInicio.AsDate ) and
               ( Trunc(Acbrnfe1.NotasFiscais.Items[0].NFe.Ide.dEmi)<=EdTermino.AsDate ) then
                  FGeral.GravaNotacomxml( ACBrNFe1 ,ListaArq.Items[p],EdUNid_codigo.text,ListaMunicipios,true,true )
            else
               Texto.Lines.add('Arquivo '+ListaArq.Items[p]+' fora do per�odo '+FGeral.FormataData(Acbrnfe1.NotasFiscais.Items[0].NFe.Ide.dEmi) )

         end else

           FGeral.GravaNotacomxml( ACBrNFe1 ,ListaArq.Items[p],EdUNid_codigo.text,ListaMunicipios,true,true );

      end else begin

         Texto.Lines.Add('Arquivo '+ListaArq.Items[p]+' com tamanho zerado.  Verificar');

      end;
    end;

//  CloseFile(F);
    ListaTamArq.Free;
    {
    if ( p mod 30 = 0 ) and (P>=30) then begin
       Texto.Lines.Add('Gravando a cada 30...');
       Sistema.Commit;
    end;
    }
    if ACBrnfe1.NotasFiscais.Count>0 then
      AcbrNfe1.NotasFiscais.Items[0].DisposeOf;

  end;

//  Texto.Lines.Add('Gravando ultimos XMLS');
//  Sistema.Commit;

// vendo xmls de cancelamento
  Texto.Lines.Add('Verificando Xmls de cancelamento/inutiliza��o...');
  for p:=0 to ListaArq.Items.Count-1 do begin
    ListaTAmArq:=TStringList.create;
    ListaTamArq.LoadFromFile( ListaArq.Items[p] );
// 23.10.17
    if ( Ansipos('TPEVENTO',uppercase(ListaTamArq.Text))>0 ) and
       ( Ansipos('210200',uppercase(ListaTamArq.Text))=0 ) then
        Fgeral.GravaNotaCancelada( ListaTamArq.Text,EdUNid_codigo.text,true )
    else if Ansipos('INUTILIZACAO',uppercase(ListaTamArq.Text))>0 then
        Fgeral.GravaNotaCancelada( ListaTamArq.Text,EdUNid_codigo.text,true);
    ListaTamArq.Free;
  end;
  pb1.position:=0;
  ListaArq.FreeOnRelease;
  Texto.Lines.Add('Importa��o Terminada');
  Sistema.endprocess('Importa��o Terminada');

end;

procedure TFImportaNfe.EdUnid_codigoExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////////////////////
begin
   bexecutarclick(self);

end;

procedure TFImportaNfe.EdterminoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////
begin
  if EdTermino.asdate < EdInicio.asdate then EdTermino.invalid('Data final deve ser maior que inicial');

end;

end.

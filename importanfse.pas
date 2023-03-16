unit importanfse;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ACBrBase, ACBrDFe, ACBrNFSe,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.FileCtrl, Vcl.Mask, SQLEd, Vcl.Buttons,
  SQLBtn, alabel, SQLGrid, Vcl.ExtCtrls, Geral, Sqlsis, SqlExpr, SqlFun,
  ACBrNFSeX,ACBrNFSeXConversao, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc;

type
  TfImportaNFSe = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bExecutar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    lbcontador: TLabel;
    Edunidade: TSQLEd;
    EdUnid_codigo: TSQLEd;
    Texto: TRichEdit;
    Edinicio: TSQLEd;
    Edtermino: TSQLEd;
    SQLPanelGrid1: TSQLPanelGrid;
    ListaArq: TFileListBox;
    pb1: TProgressBar;
    OpenDialog1: TOpenDialog;
    ACBrNFSe1: TACBrNFSe;
    ACBrNFSeX1: TACBrNFSeX;
    XMLDocument1: TXMLDocument;
    procedure EdterminoValidate(Sender: TObject);
    procedure EdUnid_codigoExitEdit(Sender: TObject);
    procedure bExecutarClick(Sender: TObject);
    procedure APHeadLabel1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure GravaNotacomxml( NotaFiscal:TACBrNFse );
    procedure LeMunicipios;

//    procedure TrataCliente;

  end;

  type TMunicipios=record
     nome,uf,cep,codigoibge,codigopais,nomepais:string;
     codigo:integer;
  end;

var
  fImportaNFSe: TfImportaNFSe;
  ListaMunicipios:Tlist;
  PMunicipios     :^TMunicipios;

implementation



    procedure AdicionaMunicipio;
    ////////////////////////////
    var Q:TSqlquery;
        name:string;
    begin
        Q:=sqltoquery('select * from cidades where cida_codigo='+inttostr(PMUnicipios.codigo));
        if Q.eof then begin
          Sistema.Insert('cidades');
          Sistema.SetField('cida_codigo',PMUnicipios.codigo);
          Sistema.SetField('cida_nome',PMUnicipios.nome);
          Sistema.SetField('cida_uf',PMUnicipios.uf);
          Sistema.SetField('cida_regi_codigo','001');
          Sistema.SetField('cida_cep',PMunicipios.cep);
          Sistema.SetField('cida_codigoibge',PMunicipios.codigoibge);
          Sistema.SetField('cida_codigopais',PMunicipios.codigopais);
          Sistema.SetField('cida_nomepais',PMunicipios.nomepais);
          Sistema.post;
          Sistema.commit;
        end;
        Q.Close;
    end;



{$R *.dfm}

procedure TfImportaNFSe.APHeadLabel1DblClick(Sender: TObject);
var ListaUMXML : TStringList;

begin

    if Global.Usuario.codigo = 100 then begin

       AcbrNfsex1.NotasFiscais.clear;
       OPendialog1.execute;
       ListaArq.Directory:=ExtractFilePath( Opendialog1.FileName );
       ListaUMXML := TStringList.create;
       ListaUMXML.LoadFromFile( Opendialog1.FileName );
       if AnsiPos( 'ListaNfse', ListaUMXML.Text ) > 0 then begin

        AcbrNfsex1.LerCidades;
        AcbrNfsex1.Configuracoes.Geral.CodigoMunicipio := 4118501;
        AcbrNfsex1.SetProvedor;

//        aviso( 'Provedor ' + ProvedorToStr( AcbrNfsex1.Configuracoes.Geral.Provedor ) );

        AcbrNfsex1.NotasFiscais.LoadFromLoteNfse( Opendialog1.FileName );

        Texto.Lines.add( 'Componente :'+inttostr(AcbrNfsex1.NotasFiscais.count));
        Texto.Lines.add( 'Nota :'+AcbrNfsex1.NotasFiscais.Items[0].NFSe.Numero);
        Texto.Lines.add( 'Nota :'+AcbrNfsex1.NotasFiscais.Items[1].NFSe.Numero);
        Texto.Lines.add( 'Nota :'+AcbrNfsex1.NotasFiscais.Items[2].NFSe.Numero);

       end;

    end;

end;

procedure TfImportaNFSe.bExecutarClick(Sender: TObject);
/////////////////////////////////////////////////////////
var p,
    i               : integer;
    achou           : boolean;
    Q               : TSqlquery;
    ProcurarArquivo : TSearchRec;
    TamanhoArquivo  : Longint;
    F               : File of Byte;
    ListaTAmArq,
    ListaumXML,
    Lista           : TStringList;
    xmlstream       : TStream;
    xmlnfses        : widestring;
    xmlnfse,
    LotedeXML       : string;
    inicionf,
    fimnf,
    tamnfe          : integer;
    EntryNode,
    EntryType       :IXmlNode;

begin

  if EdUnid_codigo.isempty then exit;

  if FGeral.GetConfig1AsInteger('ConfMovSer') = 0 then begin

     Avisoerro('Falta configurar o codigo de movimento de presta��o de servi�os');
     exit;
  end;

  Texto.Lines.Clear;
  Texto.Font.Size:=10;
  Texto.Font.Style:=[fsbold];
  Texto.Lines.Add('Abrindo pastas...');
  OpenDialog1.Execute;
  pb1.Position:=0;
  pb1.Step:=1;
  tamnfe := 9500;
  ListaumXML      := TStringList.create;
  Lista           := TStringList.create;
  LotedeXml      := 'N';

  Sistema.beginprocess('Iniciando importa��o');

  if confirma('Apagar importa��o anterior deste periodo ?') then begin

    Texto.Lines.Add('Eliminando importa��o anterior ');
    Q:=Sqltoquery( 'select moes_transacao from movesto where moes_unid_codigo='+EdUNid_codigo.Assql+
                   ' and moes_datamvto >= '+EdInicio.assql+
                   ' and moes_datamvto <= '+EdTermino.assql+
                   ' and moes_tipomov = '+stringtosql( Global.CodPrestacaoServicos )+
                   ' and moes_status<>''C'''+
                   ' and moes_obs = '+Stringtosql('Importado XML NFSe') );
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
  ListaArq.Clear;
  ListaArq.Items.Clear;  // 05.05.2022..se fizer duas vezes seguidas de outra empresa diz
//      0 xmls encontrados no items.count do listaarq...
// vamos ver se assim 'funga'
  ListaArq.Directory:=ExtractFilePath( Opendialog1.FileName );
  LIstaArq.ApplyFilePath( ExtractFilePath( Opendialog1.FileName ) );
  Texto.Lines.Add('Encontrado '+inttostr(ListaArq.Items.Count)+' Xmls');
  pb1.Max:=ListaArq.Items.Count;
  lbcontador.caption:='';
// 08.10.2021 - um xml q contem lista de xmls
  AcbrNfsex1.NotasFiscais.Clear;
  AcbrNfse1.NotasFiscais.Clear;

  if ListaArq.Items.Count = 1 then begin

//     AcbrNfse1.NotasFiscais.LoadFromFile( ListaArq.Items[0] );
     ListaUMXML.LoadFromFile( ListaArq.Items[0] );
     if AnsiPos( 'ListaNfse', ListaUMXML.Text ) > 0 then begin

        LotedeXml := 'S';
//        AcbrNfsex1.Configuracoes.LerParams(  ExtractFilePath( Application.Exename ) + 'Cidades.ini' );
        AcbrNfsex1.LerCidades;
        AcbrNfsex1.Configuracoes.Geral.CodigoMunicipio := 4118501;
        AcbrNfsex1.SetProvedor;

//        aviso( 'Provedor ' + ProvedorToStr( AcbrNfsex1.Configuracoes.Geral.Provedor ) );

// 09.10.2021 - n�o deu boa....por enquanto
//        AcbrNfsex1.NotasFiscais.LoadFromLoteNfse( ListaArq.Items[0] );
        XMLDocument1.LoadFromFile( opendialog1.filename );
        XMLDocument1.Active := True;
        EntryNode := xmldocument1.DocumentElement;
        EntryType := EntryNode.ChildNodes.First;
        for i := 0 to EntryNode.ChildNodes.Count -1 do begin

               if (EntryType.NodeName = 'CompNfse') then begin

                    Lista.Add(EntryType.xml);
                    Lista.SaveToFile(ExtractFilePath( Opendialog1.FileName )+ 'nfse'+strzero(i,3)+'.xml');
//                    Texto.Lines.Add( 'Salvando arquivo '+strzero(i,3));
                    Sistema.Beginprocess('Salvando arquivo '+strzero(i,3));
                    AcbrNfse1.NotasFiscais.LoadFromString( EntryType.xml );
                    Lista.clear;

               end else

                  Texto.Lines.Add( EntryType.NodeName );

               EntryType := EntryType.NextSibling;

//               a100viso('proxima...');

        end;

           Sistema.endprocess(  '' );
           ListaArq.Mask := 'nfse*.xml';
           ListaArq.Clear;
           ListaArq.Directory:=ExtractFilePath( Opendialog1.FileName );
           ListaArq.Update;
           pb1.Max := ListaArq.Items.Count;

           Texto.Lines.Add('Encontrado '+inttostr(ListaArq.Items.Count)+' Xmls');

//           aviso(' confere quantos na lista ');

//        Texto.LInes.add( 'nfse = '+xmlnfse );
//        Texto.LInes.add( 'quantas notas = '+inttostr(AcbrNfsex1.NotasFiscais.count) );

//        Sistema.endprocess('');
//
//        exit;

     end;

  end;

  p := 0;
// 05.12.2021 - colocaqui aqui lemunipios pra n�o ler em toda vez q for gravar a nota
  LeMunicipios;

  for p:=0 to ListaArq.Items.Count-1 do begin

      if LotedeXml = 'N' then begin

          AcbrNfse1.NotasFiscais.Clear;
          try

            AcbrNfse1.NotasFiscais.LoadFromFile( ListaArq.Items[p] );

          except

            Avisoerro('N�o foi poss�vel ler o arquivo '+ListaArq.Items[p]);
            exit;

          end;

      end;

    pb1.Position:=p;
    lbcontador.caption:=strzero((p+1),4);

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
// 08.10.2021 - Eticon - Leila - um xml com 'n' xmls
//    if LotedeXml = 'N'  then

       ListaTamArq.LoadFromFile( ListaArq.Items[p] );

//    else

//       ListaTamArq.Add( AcbrNFse1.NotasFiscais.Items[p].XML );

//    else begin

//       xmlstream  := TStream.Create ;
//       AcbrNfsex1.NotasFiscais.Items[p].GravarStream( xmlstream );
//       AcbrNfse1.NotasFiscais.Items[p].GravarStream( xmlstream );
//       ListaTamArq.LoadFromStream( xmlstream );
//       AcbrNfse1.NotasFiscais.Items[p].GravarXML( 'nfse'+strzero(p,3)+'.XML',ExtractFilePath( Opendialog1.FileName ) );
//       ListaTamArq.LoadFromFile( 'nfse'+strzero(p,3)+'.XML' );

//       AcbrNfse1.NotasFiscais.Items[p].GravarXML( 'nfse'+copy(AcbrNfse1.NotasFiscais.Items[p].NFSe.Numero,11,06)+'.XML',
//                                                  ExtractFilePath( Opendialog1.FileName ) );
//       ListaTamArq.LoadFromFile( 'nfse'+copy(AcbrNfse1.NotasFiscais.Items[p].NFSe.Numero,11,06)+'.XML' );
//       xmlstream.Free;

//    end;

    TAmanhoArquivo := ListaTamArq.Count;

    if Ansipos('TPEVENTO',uppercase(ListaTamArq.Text))>0 then
         Texto.Lines.Add('Arquivo '+ListaArq.Items[p]+' de cancelamento')
    else if Ansipos('INUTILIZACAO',uppercase(ListaTamArq.Text))>0 then
         Texto.Lines.Add('Arquivo '+ListaArq.Items[p]+' de inutiliza��o')
    else if Ansipos('INFCTE',uppercase(ListaTamArq.Text))>0 then
         Texto.Lines.Add('Arquivo '+ListaArq.Items[p]+' � de CT-e')
    else if Acbrnfse1.NotasFiscais.Count=0 then begin
       // nada a fazer
         Texto.Lines.Add('XML '+ListaArq.Items[p]+' n�o importado');

    end else begin

      if (TamanhoArquivo>0) and ( Ansipos('NFSE',uppercase(ListaTamArq.Text))>0 ) then begin

            if ( Trunc(Acbrnfse1.NotasFiscais.Items[0].NFSe.DataEmissao)>=EdInicio.AsDate ) and
               ( Trunc(Acbrnfse1.NotasFiscais.Items[0].NFSe.DataEmissao)<=EdTermino.AsDate ) then

                  GravaNotacomxml( ACBrNFse1 )
            else

               Texto.Lines.add('Arquivo '+ListaArq.Items[p]+' fora do per�odo '+FGeral.FormataData(Acbrnfse1.NotasFiscais.Items[0].NFse.DataEmissao) );


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
    if ACBrnfse1.NotasFiscais.Count>0 then
      AcbrNfse1.NotasFiscais.Items[0].DisposeOf;

  end;

// 05.12.2021 - colocado aqui pra nao fazer em toda gravacao de nota..
      for p:=0 to ListaMunicipios.count-1 do begin

      PMunicipios:=ListaMunicipios[p];
      AdicionaMunicipio;

    end;

//  Texto.Lines.Add('Gravando ultimos XMLS');
//  Sistema.Commit;

// vendo xmls de cancelamento
{
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
}

  pb1.position:=0;
  ListaArq.FreeOnRelease;
  Texto.Lines.Add('Importa��o Terminada');
  Sistema.endprocess('Importa��o Terminada');


end;

procedure TfImportaNFSe.EdterminoValidate(Sender: TObject);
begin
  if EdTermino.asdate < EdInicio.asdate then EdTermino.invalid('Data final deve ser maior que inicial');

end;

procedure TfImportaNFSe.EdUnid_codigoExitEdit(Sender: TObject);
begin

   bexecutarclick(self);

end;

procedure TfImportaNFSe.Execute;
/////////////////////////////////
begin

  FGeral.ConfiguraColorEditsNaoEnabled(FImportaNfse);
  Show;
  Texto.Lines.Clear;
  Edinicio.setfocus;
  pb1.Position:=0;

end;

procedure TfImportaNFSe.GravaNotacomxml(NotaFiscal: TACBrNFse);
//////////////////////////////////////////////////////////////
var Q,
    TEstoque   :TSqlquery;
    cnumeronf,
    xunidade,
    transacao,
    tomador,
    tipomov,
    moes_tipocad,
    moes_estado,
    codigoservico      :string;
    moes_tipo_codigo,
    moes_cida_codigo,
    p                  :integer;
    comita             :boolean;


     function GetCodigoMunicipio(xcodigomuni:string):integer;
    ///////////////////////////////////////////////////////////////
    var p,codigo:integer;
        achou:boolean;

        function Maior:integer;
        /////////////////////
        var x,maior:integer;
        begin
          maior:=0;
          for x:=0 to LIstaMunicipios.count-1 do begin
            PMunicipios:=ListaMunicipios[x];
            if PMunicipios.codigo>maior then
              maior:=PMunicipios.codigo;
          end;
          result:=maior;
        end;

    begin
    /////////////////////////////////////////////
      achou:=false;
      for p:=0 to LIstaMunicipios.count-1 do begin
        PMunicipios:=ListaMunicipios[p];
        if ( (PMunicipios.codigoibge ) = (xcodigomuni) )then begin
          result:=PMunicipios.codigo;
          achou:=true;
          break;
        end;
      end;
      if not achou then begin
//        Q:=sqltoquery('select max(muni_codigo) as ultimo from municipios');
        codigo:=Maior+1;
//        Q.close;Freeandnil(Q);
        New(PMunicipios);
        PMunicipios.codigo:=codigo;
        PMunicipios.nome  :=NotaFiscal.NotasFiscais.Items[0].NFse.Tomador.Endereco.xMunicipio;
        PMunicipios.uf    :=NotaFiscal.NotasFiscais.Items[0].NFse.Tomador.Endereco.UF;
        PMunicipios.cep   :=( NotaFiscal.NotasFiscais.Items[0].NFse.Tomador.Endereco.CEP );
        PMunicipios.codigoibge:=xcodigomuni;
        PMunicipios.codigopais:=Inttostr( NotaFiscal.NotasFiscais.Items[0].NFse.Tomador.Endereco.codigopais );
        PMunicipios.nomepais  := NotaFiscal.NotasFiscais.Items[0].NFse.Tomador.Endereco.xPais ;
        ListaMunicipios.Add( PMunicipios );
// salva na lista para no final gravar tdos os novos municipios cadastrados
        result:=codigo;
      end;
    end;


    procedure IncluiFornec;
    ///////////////////////
    var sql,cod:string;
        Q:TSqlquery;
        Codigo:integer;

    begin

        Sql:='Select Max(Forn_Codigo) As Proximo From Fornecedores';
        Q:=SqlToQuery(Sql);
        if Q.FieldByName('Proximo').AsInteger>0 then begin
            Cod:=Trim(Q.FieldByName('Proximo').AsString);
            Cod:=LeftStr(Cod,Length(Cod)-1);
        end;
        Q.Close; FreeAndNil(Q);
        Codigo:=Inteiro(Cod)+1;
        Cod:=IntToStr(Codigo);
        Codigo:=Inteiro(Cod+GetDigito(Cod,'MOD'));

        with NotaFiscal.NotasFiscais.Items[0].NFse do begin

          Sistema.Insert('fornecedores');
          Sistema.SetField('forn_codigo',codigo);

            Sistema.SetField('forn_nome',copy(SpecialCase(PrestadorServico.NomeFantasia),1,40));
            Sistema.SetField('forn_razaosocial',copy(SpecialCase(PrestadorServico.NomeFantasia),1,40));
            Sistema.SetField('forn_cnpjcpf',PrestadorServico.IdentificacaoPrestador.Cnpj);
            Sistema.SetField('Forn_inscricaoestadual',PrestadorServico.IdentificacaoPrestador.InscricaoEstadual);
            Sistema.SetField('forn_uf',PrestadorServico.Endereco.UF);
            Sistema.SetField('forn_endereco',copy(SpecialCase(PrestadorServico.Endereco.Endereco)+', '+PrestadorServico.Endereco.Numero,1,40));
    //        Sistema.SetField('clie_endrescompl',PClifor.forn_endereco);
            Sistema.SetField('forn_bairro',SpecialCase(PrestadorServico.Endereco.Bairro));
            Sistema.SetField('forn_cida_codigo',GetCodigoMunicipio(PrestadorServico.Endereco.CodigoMunicipio));
            Sistema.SetField('forn_cep',(PrestadorServico.Endereco.CEP));
            if length(PrestadorServico.Contato.Telefone)>11 then
              Sistema.SetField('forn_foneres',copy(PrestadorServico.Contato.Telefone,2,11))
            else if copy(PrestadorServico.Contato.Telefone,1,1)='4' then
              Sistema.SetField('forn_fone','0'+copy(PrestadorServico.Contato.Telefone,1,10))
            else
              Sistema.SetField('forn_fone',copy(PrestadorServico.Contato.Telefone,1,11));
            Sistema.SetField('Forn_enderecoind',copy(SpecialCase(PrestadorServico.endereco.Endereco)+', '+PrestadorServico.Endereco.Numero,1,50));
            Sistema.SetField('Forn_cidaind_codigo',GetCodigoMunicipio(PrestadorServico.Endereco.CodigoMunicipio));
            if length(PrestadorServico.Contato.Telefone)>11 then
              Sistema.SetField('forn_foneindustria',copy(PrestadorServico.Contato.Telefone,2,11))
            else if copy(PrestadorServico.Contato.Telefone,1,1)='4' then
              Sistema.SetField('Forn_foneindustria','0'+copy(PrestadorServico.Contato.Telefone,1,10))
            else
              Sistema.SetField('Forn_foneindustria',copy(PrestadorServico.Contato.Telefone,1,11));
  //          Sistema.SetField('clie_contacontabil',PClifor.forn_contacontabil);

          Sistema.SetField('Forn_datacad',Sistema.hoje);
////////////////////////          Sistema.SetField('forn_unid_codigo',xUnidade);
          Sistema.SetField('forn_usua_codigo',Global.Usuario.Codigo);
          Sistema.SetField('forn_contribuinte','S');
          Sistema.SetField('Forn_obstrocas','IMPXML NF '+(IdentificacaoRps.Numero));
  //        Sistema.SetField('clie_caractrib varchar(1)
          Sistema.Post();
          Sistema.Commit;
        end;
    end;


     procedure IncluiCliente;
    ///////////////////////
    var sql,cod:string;
        Q:TSqlquery;
        Codigo,xy:integer;

    begin

        Sql:='Select Max(Clie_Codigo) As Proximo From Clientes';
        Q:=SqlToQuery(Sql);
        if Q.FieldByName('Proximo').AsInteger>0 then begin
            Cod:=Trim(Q.FieldByName('Proximo').AsString);
            Cod:=LeftStr(Cod,Length(Cod)-1);
        end;
        Q.Close; FreeAndNil(Q);
        Codigo:=Inteiro(Cod)+1;
        Cod:=IntToStr(Codigo);
        Codigo:=Inteiro(Cod+GetDigito(Cod,'MOD'));

        with NotaFiscal.NotasFiscais.Items[0].NFse do begin

          Sistema.Insert('clientes');
          Sistema.SetField('clie_codigo',codigo);
          Sistema.SetField('clie_nome',copy(SpecialCase(Tomador.RazaoSocial),1,40));
          Sistema.SetField('clie_razaosocial',copy(SpecialCase(Tomador.RazaoSocial),1,40));
          if length(trim(Tomador.IdentificacaoTomador.CpfCnpj))=11 then
//          Sistema.SetField('clie_tipo',GetTipo(Emit.CNPJCPF));
            Sistema.SetField('clie_tipo','F')
          else
            Sistema.SetField('clie_tipo','J');
          Sistema.SetField('clie_cnpjcpf',Tomador.IdentificacaoTomador.CpfCnpj);
          Sistema.SetField('clie_rgie',Tomador.IdentificacaoTomador.InscricaoEstadual);
          Sistema.SetField('clie_sexo','M');
          Sistema.SetField('clie_uf',Tomador.Endereco.UF);
          Sistema.SetField('clie_endres',copy(SpecialCase(Tomador.Endereco.Endereco)+', '+Tomador.Endereco.numero,1,40));
  //        Sistema.SetField('clie_endrescompl',PClifor.forn_endereco);
          Sistema.SetField('clie_bairrores',SpecialCase(copy(Tomador.Endereco.Bairro,1,30)));
          Sistema.SetField('clie_cida_codigo_res',GetCodigoMunicipio(Tomador.Endereco.CodigoMunicipio));
          xy:=AnsiPOs( #39,Tomador.Endereco.xMunicipio );
          if xy > 0  then
            Sistema.SetField('clie_cidade',copy(Tomador.Endereco.xMunicipio,1,xy-1)+copy(Tomador.Endereco.xMunicipio,xy+2,20) )
          else
            Sistema.SetField('clie_cidade',( Tomador.Endereco.xMunicipio ) );

          Sistema.SetField('clie_cepres',(Tomador.Endereco.CEP));
          if length(Tomador.Contato.Telefone)>11 then
            Sistema.SetField('clie_foneres',copy(Tomador.Contato.Telefone,2,11))
          else if copy(Tomador.Contato.Telefone,1,1)='4' then
            Sistema.SetField('clie_foneres','0'+Tomador.Contato.Telefone)
          else
            Sistema.SetField('clie_foneres',Tomador.Contato.Telefone);
//          Sistema.SetField('clie_email',Emit.EnderEmit....);
          Sistema.SetField('clie_endcom',copy(SpecialCase(Tomador.Endereco.Endereco)+', '+Tomador.Endereco.Numero,1,50));
          Sistema.SetField('clie_bairrocom',SpecialCase(copy(Tomador.Endereco.Bairro,1,30)));
          Sistema.SetField('clie_cida_codigo_com',GetCodigoMunicipio(Tomador.Endereco.CodigoMunicipio));
          Sistema.SetField('clie_cepcom',(Tomador.Endereco.CEP));
          if length(Tomador.Contato.Telefone)>11 then
            Sistema.SetField('clie_fonecom',copy(Tomador.Contato.Telefone,2,11))
          else if copy(Tomador.Contato.Telefone,1,1)='4' then
            Sistema.SetField('clie_fonecom','0'+Tomador.Contato.Telefone)
          else
            Sistema.SetField('clie_fonecom',Tomador.Contato.Telefone);
//          Sistema.SetField('clie_contacontabil',PClifor.forn_contacontabil);
          Sistema.SetField('clie_situacao','N');
          Sistema.SetField('clie_dtcad',Sistema.hoje);
          Sistema.SetField('clie_repr_codigo',1);
          Sistema.SetField('clie_unid_codigo',xUnidade);
          Sistema.SetField('clie_usua_codigo',Global.Usuario.Codigo);
          Sistema.SetField('clie_contribuinte','S');
          Sistema.SetField('clie_obs','IMPXML NF '+cnumeronf);
  //        Sistema.SetField('clie_caractrib varchar(1)
          Sistema.Post();
          Sistema.Commit;
        end;
    end;

    procedure IncluiEstoque;
    /////////////////////////
    var desc,ccodigo:string;
        Qe  :TSqlquery;
        tam :integer;
    begin

      ccodigo:=codigoservico;
      if Global.Topicos[1203] then begin
        tam:=FGeral.GetConfig1AsInteger('TAMESTOQUE');
          if tam>0 then
            ccodigo:=strzero(strtoint(ccodigo),tam);
      end;

      QE:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(ccodigo));
      if QE.Eof then begin

        Sistema.Insert('estoque');
        Sistema.SetField('esto_codigo',ccodigo);
        desc:=copy(NotaFiscal.NotasFiscais.Items[0].NFse.Servico.Discriminacao ,1,50);
        desc:=FGeral.TiraBarra(desc,chr(39));
        Sistema.SetField('esto_descricao',Specialcase(desc));
        Sistema.SetField('esto_unidade','UNID');
        Sistema.SetField('esto_embalagem',1);
        Sistema.SetField('esto_peso',0);
        Sistema.SetField('esto_emlinha','S');
        Sistema.SetField('esto_usua_codigo',Global.usuario.codigo);
        Sistema.SetField('esto_sugr_codigo',1);
        Sistema.SetField('esto_fami_codigo',1);
        Sistema.SetField('esto_grup_codigo',1);

  //      Sistema.SetField('esto_cipi_codigo',FCodigosipi.NcmtoCodigo( NotaFiscal.NotasFiscais.Items[0].NFe.Det[i].Prod.NCM ));
  //      Sistema.SetField('esto_REFERENCIA',trim(Tabela.FieldByName('CODIGO').AsString));
        Sistema.Post();

      end;

      QE.Close;
      QE:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+Stringtosql(xUnidade)+
                  ' and esqt_esto_codigo='+stringtosql(ccodigo)+' and esqt_status=''N''');
      if Qe.eof then begin

            Sistema.Insert('EstoqueQtde');
            Sistema.Setfield('esqt_status','N');
            Sistema.Setfield('esqt_unid_codigo',xUnidade);
            Sistema.Setfield('esqt_esto_codigo',ccodigo);
            Sistema.Setfield('esqt_qtde',0);
            Sistema.Setfield('esqt_qtdeprev',0);
            Sistema.Setfield('esqt_vendavis',NotaFiscal.NotasFiscais.Items[0].NFse.Servico.Valores.ValorServicos );
            Sistema.Setfield('esqt_custo',0);
            Sistema.Setfield('esqt_custoger',0);
            Sistema.Setfield('esqt_customedio',0);
            Sistema.Setfield('esqt_customeger',0);
  //          Sistema.Setfield('esqt_dtultvenda',emissao);
//            Sistema.Setfield('esqt_dtultcompra',EdDtemissao.asdate);
//            Sistema.Setfield('esqt_desconto',QEstoqueQtde.fieldbyname('esqt_desconto').ascurrency);
//            Sistema.Setfield('esqt_basecomissao',QEstoqueQtde.fieldbyname('esqt_basecomissao').ascurrency);

            Sistema.Setfield('esqt_cfis_codigoest',GetSittDentro(Global.CodigoUnidade));
            Sistema.Setfield('esqt_cfis_codigoforaest',GetSittFora(Global.CodigoUnidade));
            Sistema.Setfield('esqt_sitt_codestado',GetSittDentro(Global.CodigoUnidade) );
            Sistema.Setfield('esqt_sitt_forestado',GetSittFora(Global.CodigoUnidade));
            Sistema.Setfield('esqt_usua_codigo',Global.Usuario.codigo);
            Sistema.Post('');
      end;
      FGeral.FechaQuery(Qe);
      Sistema.Commit;

    end;


begin
////////////////////////////////////////////////////////

  cnumeronf := copy(NotaFiscal.NotasFiscais.Items[0].NFSe.Numero,7,9);
  xunidade  := EdUnid_codigo.Text;
  comita    := false;

  Q:=Sqltoquery('select moes_numerodoc,moes_transacao from movesto where moes_numerodoc='+cnumeronf+
                ' and moes_dataemissao='+Datetosql(NotaFiscal.NotasFiscais.Items[0].NFse.DataEmissao)+
                ' and moes_unid_codigo='+Stringtosql(xUnidade)+
                ' and moes_status='+Stringtosql('N'));
//                ' and moes_tipocad='+Stringtosql('C') );
  if not Q.Eof then begin
//    Avisoerro('Nota j� encontrada na transa��o '+Q.fieldbyname('moes_transacao').asstring+'.  N�o importado.');
//     if aviso then
        Texto.Lines.Add('Nota j� encontrada na transa��o '+Q.fieldbyname('moes_transacao').asstring+'.  N�o importado.');
    exit;
  end;
  FGeral.FechaQuery(Q);
//  Sistema.Beginprocess('Lendo munic�pios');
//  LeMunicipios;

//  Tratacliente;

//  if NotaFiscal.NotasFiscais.Items[0].NFSe.Tomador.IdentificacaoTomador.CpfCnpj<>'' then
  if NotaFiscal.NotasFiscais.Items[0].NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj <>
     EdUNid_codigo.ResultFind.FieldByName('unid_cnpj').AsString then
     tipomov:=Global.CodPrestacaoServicosE
  else
     tipomov:=Global.CodPrestacaoServicos;

  if (tipomov = Global.CodPrestacaoServicosE)  then begin

    Q:=Sqltoquery('select * from fornecedores where forn_cnpjcpf='+Stringtosql(NotaFiscal.NotasFiscais.Items[0].NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj));
    if Q.Eof then begin
      IncluiFornec;
      Q:=Sqltoquery('select * from fornecedores where Forn_cnpjcpf='+Stringtosql(NotaFiscal.NotasFiscais.Items[0].NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj));
    end;
    moes_tipo_codigo:=Q.Fieldbyname('Forn_codigo').AsInteger;
    moes_estado:=Q.Fieldbyname('Forn_uf').AsString;
    moes_tipocad:='F';
    moes_cida_codigo:=Q.fieldbyname('Forn_cida_codigo').AsInteger;

  end else begin

      Q:=Sqltoquery('select * from clientes where Clie_cnpjcpf='+Stringtosql(NotaFiscal.NotasFiscais.Items[0].NFse.Tomador.IdentificacaoTomador.CpfCnpj));
      if Q.Eof then begin
        IncluiCliente;
        Q:=Sqltoquery('select * from clientes where Clie_cnpjcpf='+Stringtosql(NotaFiscal.NotasFiscais.Items[0].NFse.Tomador.IdentificacaoTomador.CpfCnpj));
    //    Avisoerro('Cpf/CNPJ '+NotaFiscal.NotasFiscais.Items[0].NFe.Dest.CNPJCPF+' n�o encontrado no cadastro de clientes.');
    //    exit;
      end;

    moes_tipo_codigo:=Q.Fieldbyname('Clie_codigo').AsInteger;
    moes_estado     :=Q.Fieldbyname('Clie_uf').AsString;
    moes_tipocad    :='C';
    moes_cida_codigo:=Q.fieldbyname('clie_cida_codigo_com').AsInteger;

  end;


    transacao:=FGeral.GetTransacao;
    comita    := true;

    Sistema.Insert('Movesto');
    Sistema.SetField('moes_transacao',Transacao);
    Sistema.SetField('moes_operacao',FGeral.GetOperacao);
    Sistema.SetField('moes_status','N');
    Sistema.SetField('moes_numerodoc',strtoint(cnumeronf));
    Sistema.SetField('moes_tipomov',tipomov);
    if Tipomov=Global.CodPrestacaoServicos then

      Sistema.SetField('moes_comv_codigo',FGeral.GetConfig1AsInteger('ConfMovSer') );

    Sistema.SetField('moes_unid_codigo',xUnidade);

    Sistema.SetField('moes_tipo_codigo',moes_tipo_codigo);
//    Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
//    if pos(Tipomovimento,global.coddevolucaocompra+';'+global.coddevolucaocompraSemestoque+';'+Global.CodRemessaConserto+';'
//      +Global.CodRemessaDemo+';'+Global.CodDevolucaoSaida+';'+Global.CodRemessaInd+';'+TiposFornec)>0 then begin
//      Sistema.SetField('moes_estado',Cliente.ResultFind.fieldbyname('forn_uf').AsString);
//      Sistema.SetField('moes_tipocad','F');
//      Sistema.SetField('moes_cida_codigo',Cliente.ResultFind.fieldbyname('forn_cida_codigo').AsInteger);
//    end else begin
      Sistema.SetField('moes_estado',moes_estado);
      Sistema.SetField('moes_tipocad',moes_tipocad);
      Sistema.SetField('moes_repr_codigo',1);
      Sistema.SetField('moes_cida_codigo',moes_cida_codigo);
//    end;
    Sistema.SetField('moes_datalcto',Sistema.Hoje);
    campo:=Sistema.GetDicionario('movesto','moes_datasaida');
    if Campo.Tipo<>'' then begin
      Sistema.SetField('moes_datasaida',NotaFiscal.NotasFiscais.Items[0].NFse.DataEmissao);
      Sistema.SetField('moes_datamvto',NotaFiscal.NotasFiscais.Items[0].NFse.DataEmissao);
    end else
      Sistema.SetField('moes_datamvto',NotaFiscal.NotasFiscais.Items[0].NFse.DataEmissao);

    Sistema.SetField('moes_DataCont',NotaFiscal.NotasFiscais.Items[0].NFse.DataEmissao);
    Sistema.SetField('moes_dataemissao',NotaFiscal.NotasFiscais.Items[0].NFse.DataEmissao);
    Sistema.SetField('moes_natf_codigo','5102' );
    Sistema.SetField('moes_freteciffob','1');  // 'por conta do emitente...'
    Sistema.SetField('moes_valoricms',0);
    Sistema.SetField('moes_basesubstrib',0);
    Sistema.SetField('moes_valoricmssutr',0);
    Sistema.SetField('moes_frete',0);
//    else
//      Sistema.SetField('moes_vispra','P');
    Sistema.SetField('moes_especie','NFSE');
    Sistema.SetField('moes_serie','F');

    Sistema.SetField('moes_tran_codigo','001');

    Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
    Sistema.SetField('Moes_Perdesco',0);
    Sistema.SetField('Moes_Peracres',0);
    Sistema.SetField('moes_mensagem','');
// 08.07.20 - Eticon - NFSe deixado td a visata
//    if Q.FieldByName('clie_tipo').AsString='F' then begin

      Sistema.SetField('moes_fpgt_codigo',FGeral.GetConfig1AsString('Fpgtoavista') );
      Sistema.SetField('moes_vispra','V');

//    end else begin

//      Sistema.SetField('moes_fpgt_codigo','006' );  // prazo
//      Sistema.SetField('moes_vispra','P');

//    end;

    Sistema.SetField('moes_valoripi',0);

    Sistema.SetField('moes_baseiss',NotaFiscal.NotasFiscais.Items[0].NFse.Servico.Valores.ValorServicos);
    Sistema.SetField('moes_valorpis',NotaFiscal.NotasFiscais.Items[0].NFse.Servico.Valores.ValorPis);
    Sistema.SetField('moes_valorcofins',NotaFiscal.NotasFiscais.Items[0].NFse.Servico.Valores.ValorCofins);
    Sistema.SetField('moes_valoriss',NotaFiscal.NotasFiscais.Items[0].NFse.Servico.Valores.ValorIss);
    Sistema.SetField('moes_periss',NotaFiscal.NotasFiscais.Items[0].NFse.Servico.Valores.Aliquota);
    Sistema.SetField('moes_vlrservicos',NotaFiscal.NotasFiscais.Items[0].NFse.Servico.Valores.ValorServicos);
// 03.03.2021 - para posterior exporta��o para eticon / contax
    Sistema.SetField('moes_valorir',NotaFiscal.NotasFiscais.Items[0].NFse.Servico.Valores.Valorir);

      Sistema.SetField('moes_totprod',0);
      Sistema.SetField('moes_valortotal',NotaFiscal.NotasFiscais.Items[0].NFse.Servico.Valores.ValorServicos);
      Sistema.SetField('moes_vlrtotal',NotaFiscal.NotasFiscais.Items[0].NFse.Servico.Valores.ValorServicos);
      Sistema.SetField('moes_baseicms',0);

//      xmlstring:=NotaFiscal.NotasFiscais.Items[0].XML;
//      xmlstring:=FGeral.TiraBarra(xmlstring,chr(39),'"');

      Sistema.SetField('moes_xmlnfet',NotaFiscal.NotasFiscais.Items[0].XMLNFSe)  ;
//      Sistema.SetField('moes_xmlnfet',xmlstring )  ;

      Sistema.SetField('moes_dtnfeauto',NotaFiscal.NotasFiscais.Items[0].NFse.DataEmissao);
      Sistema.SetField('moes_chavenfe',NotaFiscal.NotasFiscais.Items[0].NFse.InfID.ID );
      Sistema.SetField('moes_nfeexp','S');
      Sistema.SetField('moes_dtnfeexp',NotaFiscal.NotasFiscais.Items[0].NFse.DataEmissao);
      Sistema.SetField('moes_retornonfe','NFSe Autorizada');
      Sistema.SetField('moes_dtnfereto',NotaFiscal.NotasFiscais.Items[0].NFse.DataEmissao);
      Sistema.SetField('moes_dtnfeauto',NotaFiscal.NotasFiscais.Items[0].NFse.DataEmissao);
      Sistema.SetField('moes_obs','Importado XML NFSe');

      Sistema.Post();


/// Detalhe
      codigoservico:=NotaFiscal.NotasFiscais.Items[0].NFSe.Servico.ItemListaServico;

      TEstoque:=sqltoquery('select * from estoqueqtde inner join estoque on ( esqt_esto_codigo=esto_codigo )'+
                           ' where esqt_esto_codigo='+Stringtosql(codigoservico)+
                           ' and esqt_unid_codigo='+Stringtosql(xUnidade)+
                           ' and esqt_status='+Stringtosql('N') );

      if TEstoque.eof then IncluiEstoque;

      Sistema.Insert('Movestoque');

// 05.07.13  - puxar o codigo com tamanho certo
      if Global.Topicos[1203] then begin
          if FGeral.GetConfig1AsInteger('TAMESTOQUE')>0 then
            Sistema.SetField('move_esto_codigo',codigoservico );
      end else
        Sistema.SetField('move_esto_codigo',codigoservico);

//      Sistema.SetField('move_tama_codigo',strtointdef(Grid.Cells[Grid.getcolumn('codtamanho'),linha],0));
//      Sistema.SetField('move_core_codigo',strtointdef(Grid.Cells[Grid.getcolumn('codcor'),linha],0));
//      Sistema.SetField('move_copa_codigo',strtointdef(Grid.Cells[Grid.getcolumn('codcopa'),linha],0));
/////////////
      Sistema.SetField('move_transacao',transacao);
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
//{
      Sistema.SetField('move_numerodoc',strtoint(cnumeronf) );
      Sistema.SetField('move_status','N');
      Sistema.SetField('move_tipomov',tipomov );
      Sistema.SetField('move_unid_codigo',xUnidade);
      Sistema.SetField('move_tipo_codigo',moes_tipo_codigo);
//      if rtipocad='F' then begin
//        Sistema.SetField('move_tipocad','F');
//      end else begin
        Sistema.SetField('move_tipocad',moes_tipocad);
        Sistema.SetField('move_repr_codigo',1);
//      end;
      Sistema.SetField('move_qtde',1);
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datacont',Sistema.Hoje);
      Sistema.SetField('move_datamvto',NotaFiscal.NotasFiscais.Items[0].NFse.DataEmissao);
      Sistema.SetField('move_qtderetorno',0);
      Sistema.SetField('move_custo',TEstoque.fieldbyname('esqt_custo').ascurrency);
      Sistema.SetField('move_custoger',TEstoque.fieldbyname('esqt_custoger').ascurrency);
      Sistema.SetField('move_customedio',TEstoque.fieldbyname('esqt_customedio').ascurrency);
      Sistema.SetField('move_customeger',TEstoque.fieldbyname('esqt_customeger').ascurrency);
      Sistema.SetField('move_cst','040' ); //
      Sistema.SetField('move_aliicms',0);
      Sistema.SetField('move_venda',NotaFiscal.NotasFiscais.Items[0].NFse.Servico.Valores.ValorServicos);
      Sistema.SetField('move_grup_codigo',TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('move_sugr_codigo',TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('move_fami_codigo',TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.SetField('move_perdesco',0);
      Sistema.SetField('move_vendabru',NotaFiscal.NotasFiscais.Items[0].NFse.Servico.Valores.ValorServicos);
      Sistema.SetField('move_aliipi',0);
      Sistema.SetField('move_pecas',1);
//      Sistema.SetField('move_vendamin',texttovalor(Grid.Cells[grid.getcolumn('move_vendamin'),linha]));
//      Sistema.SetField('move_redubase',NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Imposto.ICMS.pRedBC);
//      Sistema.SetField('move_nroobra',inttostr(numero));
//      if Global.Topicos[1326] then
//        Sistema.SetField('move_certificado',Grid.Cells[grid.getcolumn('move_certificado'),linha]);
        campo:=Sistema.GetDicionario('movestoque','move_natf_codigo');
        if campo.Tipo<>'' then
          Sistema.SetField('move_natf_codigo','5102');
// }

      Sistema.Post('');

      TEstoque.close;


            Sistema.Insert('MovBase');
            Sistema.SetField('movb_transacao',Transacao);
            Sistema.SetField('movb_operacao',FGeral.GetOperacao);
            Sistema.SetField('movb_status','N');
            Sistema.SetField('movb_numerodoc',strtoint(cnumeronf));
            Sistema.SetField('Movb_cst','040');
            Sistema.SetField('Movb_TpImposto','S' );
            Sistema.SetField('Movb_BaseCalculo',AcbrNFSe1.NotasFiscais.Items[0].NFSe.Servico.Valores.BaseCalculo );
            Sistema.SetField('Movb_Aliquota',AcbrNFSe1.NotasFiscais.Items[0].NFSe.Servico.Valores.Aliquota);
            Sistema.SetField('Movb_ReducaoBc',0);
            Sistema.SetField('Movb_Imposto',AcbrNFSe1.NotasFiscais.Items[0].NFSe.Servico.Valores.ValorIss );
            Sistema.SetField('Movb_Isentas',0);
            Sistema.SetField('Movb_Outras' ,0);
            Sistema.SetField('Movb_tipomov',tipomov);
            Sistema.SetField('Movb_unid_codigo',xUnidade);
            Sistema.SetField('Movb_natf_codigo','5102');
            Sistema.Post();



{            //  Sistema.Beginprocess('Atualizando munic�pios');
    for p:=0 to ListaMunicipios.count-1 do begin

      PMunicipios:=ListaMunicipios[p];
      AdicionaMunicipio;

    end;
}

   if comita then begin

       try
         Sistema.Commit;
    //     Aviso('Xml importado');
       except
         Avisoerro('N�o importado no banco de dados.  Checar');
       end;

   end;


end;

procedure TfImportaNFSe.LeMunicipios;
///////////////////////////////////////

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




end.

unit nfedestinadas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, SqlDtg, Vcl.StdCtrls,
  Vcl.Mask, SQLEd, Vcl.Buttons, SQLBtn, alabel, Vcl.ExtCtrls, SQLGrid, ACBrBase,
  ACBrDFe, ACBrNFe, Vcl.ComCtrls, ACBrUtil, pcnconversaonfe,pcnconversao,
  ACBrMDFe;

type
  TFNfeDestinadas = class(TForm)
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    bmanifesta: TSQLBtn;
    bbaixaxmls: TSQLBtn;
    Panel1: TPanel;
    Edunidade: TSQLEd;
    EdUnid_codigo: TSQLEd;
    Edtermino: TSQLEd;
    EdInicio: TSQLEd;
    pgrid: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    Edtipoconsulta: TSQLEd;
    ACBrNFe1: TACBrNFe;
    btiramanifesto: TSQLBtn;
    EdNsu: TSQLEd;
    procedure EdIndicadoremissorExitEdit(Sender: TObject);
    procedure EdUnid_codigoValidate(Sender: TObject);
    procedure bmanifestaClick(Sender: TObject);
    procedure EdterminoValidate(Sender: TObject);
    procedure bbaixaxmlsClick(Sender: TObject);
    procedure EdUnid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure btiramanifestoClick(Sender: TObject);
    procedure EdtipoconsultaValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure GetListaArquivos(xLista:TStringList;xarquivos,xpasta:string);
  end;

var
  FNfeDestinadas: TFNfeDestinadas;

implementation

uses geral, sqlsis, sqlfun, SqlExpr,expnfetxt;

{$R *.dfm}



// 22.10.17
procedure TFNfeDestinadas.bbaixaxmlsClick(Sender: TObject);
//////////////////////////////////////////////////////////////
var i:integer;
    pastaxmlbaixados:string;

begin

  if not confirma('Confirma baixa dos XMLS das notas com manifesto no período ?') then exit;
  pastaxmlbaixados:=ExtractFilePath(Application.ExeName)+'\XmlsBaixados\';

  acbrnfe1.Configuracoes.Arquivos.PathEvento:=pastaxmlbaixados+
                                               strzero(Datetoano(EdTermino.AsDate,true),4)+
                                               strzero(Datetomes(EdTermino.AsDate),2)+'\'+
                                               EdUNid_codigo.Text;
  acbrnfe1.Configuracoes.Arquivos.PathSalvar:=pastaxmlbaixados+
                                               strzero(Datetoano(EdTermino.AsDate,true),4)+
                                               strzero(Datetomes(EdTermino.AsDate),2)+'\'+
                                               EdUNid_codigo.Text;


 if not DirectoryExists( acbrnfe1.Configuracoes.Arquivos.PathEvento ) then
      ForceDirectories( acbrnfe1.Configuracoes.Arquivos.PathEvento );


   for i:=0 to Grid.RowCount-1 do begin

       Sistema.BeginProcess('Baixando xml nota de chave '+Grid.Cells[grid.GetColumn('moes_chavenfe'),i]);
       Acbrnfe1.DistribuicaoDFePorChaveNFe( ACBrNFe1.Configuracoes.WebServices.UFcodigo,
                                            EdUnid_codigo.ResultFind.FieldByName('unid_cnpj').AsString,
                                            Grid.Cells[grid.GetColumn('moes_chavenfe'),i] )  ;

 {  - web service desativado
       with ACBrNFe1.DownloadNFe.Download.Chaves.Add do
        begin
         chNFe := Grid.Cells[grid.GetColumn('moes_chavenfe'),i];
        end;
       ACBrNFe1.Download;
}
{
       with  AcbrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento do begin

          msg:=xMotivo;
          if cStat=135 then begin

             Sistema.Edit('movesto');
             Sistema.setfield('Moes_xmlmanifesto',ACBrNFe1.WebServices.EnvEvento.RetWS);
             Sistema.setfield('Moes_datamanifesto',Sistema.hoje);
             Sistema.setfield('Moes_retornomanifesto',xmotivo);
             Sistema.setfield('Moes_nfecommanifesto','S');
             Sistema.Post('moes_transacao='+Stringtosql(Global.UltimaTransacao)+
                          ' and moes_unid_codigo = '+EdUnid_codigo.AsSql);
             Sistema.Commit;

          end;

       end;
       }

   end;


   Sistema.EndProcess('Baixa Terminada');

end;

procedure TFNfeDestinadas.bmanifestaClick(Sender: TObject);
/////////////////////////////////////////////////////////////
var i,idlote    :integer;
    xtransacao,
    xretorno   : string;
    Q          : TSqlquery;

begin

    if not confirma('Confirma manifesto das notas no período ?') then exit;


   for i:=0 to Grid.RowCount-1 do begin

//     i:=Grid.Row;

     xtransacao := trim( Grid.Cells[grid.GetColumn('moes_transacao'),i] );
     xretorno   := trim( Grid.Cells[grid.GetColumn('sitmanifesto'),i] );

     if ( xretorno='Sem Manifesto' ) and ( xtransacao<>'' ) then begin

       Sistema.BeginProcess('Enviando manifesto da nota de chave '+Grid.Cells[grid.GetColumn('moes_chavenfe'),i]);
       ACBrNFe1.EventoNFe.Evento.Clear;
       idlote:=FGeral.GetContador('LoteManifesto'+Global.CodigoUnidade,false,true);
       Q:=Sqltoquery('select Moes_datamanifesto from movesto where moes_transacao = '+stringtosql(xtransacao)+
                     ' and '+FGeral.GetIN('moes_tipomov',Global.TiposEntrada,'C')+
                     ' and moes_status = ''N''');

       with ACBrNFe1.EventoNFe.Evento.Add do
         begin
           InfEvento.cOrgao   := 91;  // ambiente nacional
           infEvento.chNFe    := Grid.Cells[grid.GetColumn('moes_chavenfe'),i];
           infEvento.CNPJ     := EdUnid_codigo.ResultFind.FieldByName('unid_cnpj').AsString;
           infEvento.dhEvento := now;
           infEvento.tpEvento := teManifDestConfirmacao;
         end;

       ACBrNFe1.EnviarEvento(IDLote);

//{
       with  AcbrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento do begin


//        Aviso( 'ctat='+inttostr(cstat));

          if (cStat=135) then begin

             Sistema.Edit('movesto');
             Sistema.setfield('Moes_xmlmanifesto',ACBrNFe1.WebServices.EnvEvento.RetWS);
             Sistema.setfield('Moes_datamanifesto',Sistema.hoje);
             Sistema.setfield('Moes_retornomanifesto',xmotivo);
             Sistema.setfield('Moes_nfecommanifesto','S');
             Sistema.Post('moes_transacao='+Stringtosql(xTransacao)+
                          ' and moes_unid_codigo = '+EdUnid_codigo.AsSql);

          end;
          if (cStat=573) and ( Datetoano(Q.fieldbyname('Moes_datamanifesto').AsDateTime,true) <= 1902 ) then begin

             Sistema.Edit('movesto');
             Sistema.setfield('Moes_xmlmanifesto',ACBrNFe1.WebServices.EnvEvento.RetWS);
             Sistema.setfield('Moes_datamanifesto',Sistema.hoje);
             Sistema.setfield('Moes_retornomanifesto',xmotivo);
             Sistema.setfield('Moes_nfecommanifesto','S');
             Sistema.Post('moes_transacao='+Stringtosql(xTransacao)+
                          ' and moes_unid_codigo = '+EdUnid_codigo.AsSql);

          end;

          Sistema.Commit;

       end;
//}
     end;

   end;  //  for do grid..

//   Sistema.BeginProcess('Enviando lote');
//   ACBrNFe1.EnviarEvento(IDLote);   // maximo 20 eventos por lote

   Sistema.EndProcess('Manifestação terminada');
   EdUnid_codigo.Next;  // para atualizar a tela com o status de manifestacao...

end;

// 13.03.18 - Novicarnes
procedure TFNfeDestinadas.btiramanifestoClick(Sender: TObject);
///////////////////////////////////////////////////////////////////
var idlote,nota:integer;
    ctransacao:string;

begin

   nota:=strtointdef( Grid.Cells[Grid.getcolumn('moes_numerodoc'),Grid.row],0 );
   ctransacao:=trim(Grid.Cells[Grid.getcolumn('moes_transacao'),Grid.row]);
   if nota = 0 then exit;

   if not confirma('Confirma manifesto de DESCONHECIMENTO da nota '+inttostr(nota)+' ?') then exit;

       Sistema.BeginProcess('Enviando desconhecimento de manifesto da nota de chave '+Grid.Cells[grid.GetColumn('moes_chavenfe'),Grid.Row]);
       ACBrNFe1.EventoNFe.Evento.Clear;
       idlote:=FGeral.GetContador('LoteManifesto'+Global.CodigoUnidade,false,true);

       with ACBrNFe1.EventoNFe.Evento.Add do
         begin
           InfEvento.cOrgao   := 91;  // ambiente nacional
           infEvento.chNFe    := Grid.Cells[grid.GetColumn('moes_chavenfe'),Grid.Row];
           infEvento.CNPJ     := EdUnid_codigo.ResultFind.FieldByName('unid_cnpj').AsString;
           infEvento.dhEvento := now;
           infEvento.tpEvento := teManifDestDesconhecimento;
         end;

       ACBrNFe1.EnviarEvento(IDLote);

//{
       with  AcbrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento do begin

          if cStat=135 then begin

             Sistema.Edit('movesto');
             Sistema.setfield('Moes_xmlmanifesto',ACBrNFe1.WebServices.EnvEvento.RetWS);
             Sistema.setfield('Moes_datamanifesto',Sistema.hoje);
             Sistema.setfield('Moes_retornomanifesto',xmotivo);
             Sistema.setfield('Moes_nfecommanifesto','S');
             Sistema.Post('moes_transacao='+Stringtosql(ctransacao)+
                          ' and moes_unid_codigo = '+EdUnid_codigo.AsSql);
             Sistema.Commit;

          end;

       end;
//       }

//   Sistema.BeginProcess('Enviando lote');
//   ACBrNFe1.EnviarEvento(IDLote);   // maximo 20 eventos por lote

   Sistema.EndProcess('Manifestação de desconhecimento terminada');

end;

procedure TFNfeDestinadas.EdIndicadoremissorExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////////////////
var ok:boolean;
    p,
    n,
    r       :integer;
    Q,
    QNotas  :TSqlquery;
    tiposnao,ultimonsu,sTemMais,pastaxmlbaixados,
    xarqxml,
    vchave,
    situacaoNF  : string;
    campo       : TDicionario;
    Lista,
    Lista1:TStringList;


    function GetSituacao(s:TsituacaoDFe):string;
    /////////////////////////////////////
    begin

      if s = snAutorizado then result:='Autorizada'
      else if s = snDenegado then result:='Denegada'
      else if s = snCancelado then result:='Cancelada'
      else if s = snEncerrado then result:='Encerrada'
      else result:='Desconhecida';

    end;


begin

   if ( ACBrNFe1.SSL.CertDataVenc > Sistema.hoje ) and  ( trunc(ACBrNFe1.SSL.CertDataVenc-Sistema.Hoje)<=30 )
      then begin
      Aviso('Certificado digital '+copy(ACBrNFe1.SSL.CertSubjectName,1,40)+' VENCE em '+Datetostr(ACBrNFe1.SSL.CertDataVenc));
   end;

   if ACBrNFe1.SSL.CertDataVenc<Sistema.hoje then begin
      Avisoerro('Certificado digital '+copy(ACBrNFe1.SSL.CertSubjectName,1,40)+' VENCIDO em '+Datetostr(ACBrNFe1.SSL.CertDataVenc));
      exit;
   end;

  pastaxmlbaixados:=ExtractFilePath(Application.ExeName)+'\XmlsBaixados\';

  acbrnfe1.Configuracoes.Arquivos.PathEvento:=pastaxmlbaixados+
                                               strzero(Datetoano(EdTermino.AsDate,true),4)+
                                               strzero(Datetomes(EdTermino.AsDate),2)+'\'+
                                               EdUNid_codigo.Text;

  acbrnfe1.Configuracoes.Arquivos.PathSalvar:=pastaxmlbaixados+
                                               strzero(Datetoano(EdTermino.AsDate,true),4)+
                                               strzero(Datetomes(EdTermino.AsDate),2)+'\'+
                                               EdUNid_codigo.Text;

{
//////////////////////////////////////////////////////////////////////////////
 if not DirectoryExists( acbrnfe1.Configuracoes.Arquivos.PathEvento ) then
      ForceDirectories( acbrnfe1.Configuracoes.Arquivos.PathEvento );

  if trim(FGeral.GetConfig1AsString('Pastaretonfexml'))<>'' then begin

    acbrnfe1.Configuracoes.Arquivos.PathEvento:=FGeral.GetConfig1AsString('Pastaretonfexml')+'\'+
                                               strzero(Datetoano(EdTermino.AsDate,true),4)+
                                               strzero(Datetomes(EdTermino.AsDate),2)+'\'+
                                               EdUNid_codigo.Text;
    acbrnfe1.Configuracoes.Arquivos.PathSalvar:=FGeral.GetConfig1AsString('Pastaretonfexml')+'\'+
                                               strzero(Datetoano(EdTermino.AsDate,true),4)+
                                               strzero(Datetomes(EdTermino.AsDate),2)+'\'+
                                               EdUNid_codigo.Text;

  end else begin

    acbrnfe1.Configuracoes.Arquivos.PathEvento:='\NFESAC\RETORNO\'+
                                               strzero(Datetoano(EdTermino.AsDate,true),4)+
                                               strzero(Datetomes(EdTermino.AsDate),2)+'\'+
                                               EdUNid_codigo.Text;
    acbrnfe1.Configuracoes.Arquivos.PathSalvar:='\NFESAC\RETORNO\'+
                                               strzero(Datetoano(EdTermino.AsDate,true),4)+
                                               strzero(Datetomes(EdTermino.AsDate),2)+'\'+
                                               EdUNid_codigo.Text;

  end;
//////////////////////////////////////////////////////////////////////////////
}

 if not DirectoryExists( acbrnfe1.Configuracoes.Arquivos.PathSalvar ) then
      ForceDirectories( acbrnfe1.Configuracoes.Arquivos.PathSalvar );

   tiposnao:=Global.CodCompraProdutor+';'+Global.CodTransfEntrada+';'+Global.CodTransfSaida+';'+
            Global.CodPrestacaoServicosE;

  if EdTipoconsulta.Text='1' then begin

    Sistema.BeginProcess('Consultando nfe destinadas na receita');
    Acbrnfe1.NotasFiscais.Clear;
    Lista:=TStringList.Create;
    Lista1:=TStringList.Create;
    campo:=Sistema.GetDicionario('movesto','Moes_retornomanifesto');

    Grid.Clear;

/////////////////////////////////////////////////////////////
{
  GetListaArquivos(Lista,'*-dist-dfe.xml',acbrnfe1.Configuracoes.Arquivos.PathSalvar);
  Lista.Sorted:=true;

  ultimonsu:='0';
  if Lista.Count>0 then begin

    xarqxml:=SelecionaItems(Lista,'Escolha último xml','',false);
    strtoLista(Lista1,xarqxml,'|',true);
    if LIsta1.Count>0 then begin
      Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.LerXMLFromFile( Lista1[0] );
    end;

  end;
}

   QNOtas:=sqltoquery('select moes_tipo_codigo,moes_numerodoc,moes_transacao,moes_chavenfe,moes_dataemissao,'+
                   ' moes_vlrtotal,forn_razaosocial,moes_datamvto,moes_retornomanifesto,moes_xmlnfet'+
                   ' from movesto inner join fornecedores on ( forn_codigo=moes_tipo_codigo )'+
                   ' where moes_status=''N'''+
                   ' and moes_unid_codigo = '+EdUnid_codigo.AsSql+
                   ' and moes_datamvto >= '+EdINicio.AsSql+
                   ' and moes_datamvto <= '+EdTermino.AsSql+
                   ' and '+FGEral.GetNOtIN('moes_tipomov',tiposnao,'C')+
                   ' and '+FGEral.GetIN('moes_tipomov',Global.TiposEntrada,'C')+
                   ' order by moes_datamvto' );
    ultimonsu:='0';
    vchave:='';

    while not QNotas.Eof do begin

        if QNotas.FieldByName('Moes_chavenfe').AsString<>'' then begin

  //         Lista1.Add('achou um xml');
           Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.XML:=QNotas.FieldByName('Moes_xmlnfet').AsString;
           vchave:=QNotas.FieldByName('Moes_chavenfe').AsString;

  //         aviso( QNotas.FieldByName('Moes_numerodoc').AsString );

           break;

        end;

      QNotas.Next;

    end;

    Lista.Clear;

//    ACBrNFe1.DistribuicaoDFePorChaveNFe(ACBrNFe1.Configuracoes.WebServices.UFcodigo,
//                                      EdUNid_codigo.ResultFind.FieldByName('unid_cnpj').AsString,
//8                                      vchave);


//    ultimonsu:=Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[0].NSU;
//    ultimonsu:=inttostr( strtoint(ultimonsu)-1000  );
    ultimonsu:=EdNsu.text;

    ACBrNFe1.DistribuicaoDFePorUltNSU(ACBrNFe1.Configuracoes.WebServices.UFcodigo,
                                      EdUNid_codigo.ResultFind.FieldByName('unid_cnpj').AsString,
                                      ultimonsu);

{
////////////////////////////////////////////////////////////////////
  while True do begin

    if Lista1.Count=0 then begin

      ACBrNFe1.DistribuicaoDFePorUltNSU(ACBrNFe1.Configuracoes.WebServices.UFcodigo,
                                    EdUNid_codigo.ResultFind.FieldByName('unid_cnpj').AsString,
                                    ultimonsu);


//      ACBrNFe1.DistribuicaoDFePorChaveNFe(ACBrNFe1.Configuracoes.WebServices.UFcodigo,
//                                    EdUNid_codigo.ResultFind.FieldByName('unid_cnpj').AsString,
//                                    '41171079964177000168550020000465391002170803');

      ultimonsu:=Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.ultNSU;

      if ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.cStat = 137
       then sTemMais := 'N'
       else sTemMais := 'S';

    end;

    for p:= 0 to Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Count-1 do begin

      if ( trim(Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.chDFe)<>'' )
//          and
//          ( Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.dhEmi>=EdInicio.AsDate )
//             and
//            ( Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.dhEmi <= EdTermino.AsDate  )
            and
            ( Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.CNPJCPF = EdUnid_codigo.ResultFind.FieldByName('unid_cnpj').AsString )

          then begin

            with Acbrnfe1.NotasFiscais.Add.NFe do begin

              Ide.nNF:=strtointdef( copy(Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.chDFe,26,9),0 );
              infNFe.ID:=Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.chDFe;
              Ide.dEmi:=Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.dhEmi;
              Total.ICMSTot.vNF:= Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.vNF;
              Ide.tpNF:=Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.tpNF;
              if Ide.tpNF=tnEntrada then
                Emit.xNome:=Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.xNome
              else
                Dest.xNome:=Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.xNome;
              Ide.xJust:=GetSituacao( SituacaoDFeToStr( Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.cSitDFe) );
              InfAdic.infCpl:=Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[p].nsu;

//              Avulsa.xOrgao:=Fexpnfetxt.GetTag('xmotivo',Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.XML);

              if Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].schema = schprocNFe then
                Avulsa.xOrgao:='Manifesto efetuado'
              else
                Avulsa.xOrgao:='Sem Manifesto';
              Dest.CNPJCPF:=Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.CNPJCPF;
              Sistema.BeginProcess('Consultando nfe destinadas '+FGeral.FormataData( Ide.dEmi )+' Ultimo NSU '+ultimonsu );

            end;


      end else

          Sistema.BeginProcess('Nfe com destino outro cnpj ou emissão fora do período '+Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.xNome );
  //        Lista.Add(Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resNFe.xNome);

    end;

    ultimonsu:=Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.ultNSU;
    n:=Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Count;

    if sTemMais='N' then break ;

    if Lista1.Count>0 then
       BREAK;


  end;
/////////////////////////////////////////
}

 // if Lista.Count>0 then Aviso( Lista.Text );
/////////////////////////////////////////////////////////////


    Sistema.BeginProcess('Exibindo '+inttostr(Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Count)+' nfe encontradas na receita');

    n:=1;

    for p:=0 to Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Count-1 do begin
  //  for p:= 0 to Acbrnfe1.NotasFiscais.Count-1 do begin

  ///    if Acbrnfe1.NotasFiscais.Items[p].NFe.Dest.CNPJCPF=EdUnid_codigo.ResultFind.FieldByName('unid_cnpj').AsString then begin

       if trim( Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.chDFe ) <> '' then begin

  //       Q:=sqltoquery('select moes_tipo_codigo,moes_numerodoc,moes_transacao,moes_datamvto from movesto where moes_status=''N'''+
  //                     ' and moes_chavenfe = '+Stringtosql( Acbrnfe1.NotasFiscais.Items[p].NFe.infNFe.Id ) );
         Q:=sqltoquery('select moes_tipo_codigo,moes_numerodoc,moes_transacao,moes_datamvto,Moes_datamanifesto from movesto where moes_status=''N'''+
                       ' and '+FGeral.GetIN('moes_tipomov',Global.TiposEntrada,'C')+
                       ' and moes_chavenfe = '+Stringtosql( Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.chDFe ) );

         situacaoNF := GetSituacao( Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.cSitDFe)  ;

         if (Q.eof) and ( situacaoNF <> 'Cancelada' ) then begin

//           Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.cSitDFe
//           GetSituacao( SituacaoDFeToStr( Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[0].resNFe.cSitNFe)

//           Grid.Cells[Grid.GetColumn('sitmanifesto'),n]:=
// GetSituacao( Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.cSitDFe)  ;
         Grid.Cells[Grid.GetColumn('sitmanifesto'),n]:='Não lançada';

           Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),n]:='';
           Grid.Cells[Grid.GetColumn('moes_transacao'),n]:='';
           Grid.Cells[Grid.GetColumn('moes_numerodoc'),n]:=copy( Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.chDFe,26,09);
           Grid.Cells[Grid.GetColumn('moes_chavenfe'),n]:= Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.chDFe;
           Grid.Cells[Grid.GetColumn('moes_dataemissao'),n]:=FGeral.FormataData( Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.dhEmi );
           Grid.Cells[Grid.GetColumn('moes_vlrtotal'),n]:=FGeral.Formatavalor(  Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.vNF, f_cr );
           Grid.Cells[Grid.GetColumn('clie_razaosocial'),n]:=Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.xNome ;
           Grid.Cells[Grid.GetColumn('nsu'),n]:= Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].NSU;
           Grid.Cells[Grid.GetColumn('cnpjemitente'),n]:=FGEral.Formatacnpjcpf( Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.CNPJCPF);
           Grid.AppendRow;
           inc(n);

         end else begin

           if DatetoAno( Q.FieldByName('Moes_datamanifesto').AsDateTime,true ) < 1902 then begin

             Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),n]:=Q.fieldbyname('moes_tipo_codigo').asstring;
             Grid.Cells[Grid.GetColumn('moes_transacao'),n]:=Q.fieldbyname('moes_transacao').asstring;
             Grid.Cells[Grid.GetColumn('moes_numerodoc'),n]:=Q.fieldbyname('moes_numerodoc').asstring;
             Grid.Cells[Grid.GetColumn('moes_datamvto'),n]:=FGeral.FormataData( Q.fieldbyname('moes_datamvto').asdatetime);
             if DatetoAno( Q.FieldByName('Moes_datamanifesto').AsDateTime,true )> 1902 then
               Grid.Cells[Grid.GetColumn('sitmanifesto'),n]:='Manifesto efetuado'
             else
               Grid.Cells[Grid.GetColumn('sitmanifesto'),n]:='Sem Manifesto';
             Grid.Cells[Grid.GetColumn('moes_numerodoc'),n]:=copy( Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.chDFe,26,09);
             Grid.Cells[Grid.GetColumn('moes_chavenfe'),n]:= Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.chDFe;
             Grid.Cells[Grid.GetColumn('moes_dataemissao'),n]:=FGeral.FormataData( Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.dhEmi );
             Grid.Cells[Grid.GetColumn('moes_vlrtotal'),n]:=FGeral.Formatavalor(  Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.vNF, f_cr );
             Grid.Cells[Grid.GetColumn('clie_razaosocial'),n]:=Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.xNome ;
             Grid.Cells[Grid.GetColumn('nsu'),n]:= Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].NSU;
             Grid.Cells[Grid.GetColumn('cnpjemitente'),n]:=FGEral.Formatacnpjcpf( Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[p].resDFe.CNPJCPF);
             Grid.AppendRow;
             inc(n);

          end;

         end;



         FGeral.FechaQuery(Q);

       end;



    end;

    Sistema.endProcess('Consulta finalizada')

  end;

//  }
////////////////////////////////////////



//////////////////////  aviso( '  ' );


  if edtipoconsulta.Text='2' then begin

    Grid.Clear;

    Sistema.BeginProcess('Consultando nfe digitadas nas entradas');

    Q:=sqltoquery('select moes_tipo_codigo,moes_numerodoc,moes_transacao,moes_chavenfe,moes_dataemissao,'+
                     ' moes_vlrtotal,forn_razaosocial,moes_datamvto,moes_retornomanifesto,Moes_datamanifesto'+
                     ' from movesto inner join fornecedores on ( forn_codigo=moes_tipo_codigo )'+
                     ' where moes_status=''N'''+
                     ' and moes_especie <> '+Stringtosql('CTE')+
                     ' and moes_unid_codigo = '+EdUnid_codigo.AsSql+
                     ' and moes_datamvto >= '+EdINicio.AsSql+
                     ' and moes_datamvto <= '+EdTermino.AsSql+
                     ' and '+FGEral.GetNOtIN('moes_tipomov',tiposnao,'C')+
                     ' and '+FGEral.GetIN('moes_tipomov',Global.TiposEntrada,'C') );

    n:=1;

    while not Q.Eof do begin

  {
       if Q.fieldbyname('moes_chavenfe').asstring<>'' then begin
         try
           ACBrNFe1.DistribuicaoDFePorChaveNFe(ACBrNFe1.Configuracoes.WebServices.UFcodigo,
                                      EdUNid_codigo.ResultFind.FieldByName('unid_cnpj').AsString,
                                      Q.fieldbyname('moes_chavenfe').asstring);
           if Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Count>0 then
             Grid.Cells[Grid.GetColumn('sitmanifesto'),p+1]:=GetSituacao( SituacaoDFeToStr( Acbrnfe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[0].resNFe.cSitNFe) );
         except
         end;
       end;
  }
// mostra somente digitadas e nao manifestadas
// 29.04.20 - aparee manifestadas para poder demanifestar
       if ( Q.fieldbyname('moes_chavenfe').asstring<>'' )
//          and
//          ( DatetoAno( Q.FieldByName('Moes_datamanifesto').AsDateTime,true ) < 1902 )

       then begin

         Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),n]:=Q.fieldbyname('moes_tipo_codigo').asstring;
         Grid.Cells[Grid.GetColumn('moes_transacao'),n]  :=Q.fieldbyname('moes_transacao').asstring;
         Grid.Cells[Grid.GetColumn('moes_numerodoc'),n]  :=Q.fieldbyname('moes_numerodoc').asstring;
         Grid.Cells[Grid.GetColumn('moes_chavenfe'),n]   :=Q.fieldbyname('moes_chavenfe').asstring;
         Grid.Cells[Grid.GetColumn('moes_dataemissao'),n]:=FGeral.FormataData( Q.fieldbyname('moes_dataemissao').asdatetime);
         Grid.Cells[Grid.GetColumn('moes_datamvto'),n]   :=FGeral.FormataData( Q.fieldbyname('moes_datamvto').asdatetime);
         Grid.Cells[Grid.GetColumn('moes_vlrtotal'),n]   :=FGeral.Formatavalor(  Q.fieldbyname('moes_vlrtotal').ascurrency, f_cr );
         Grid.Cells[Grid.GetColumn('clie_razaosocial'),n]:=Q.fieldbyname('forn_razaosocial').asstring;
//         Grid.Cells[Grid.GetColumn('sitmanifesto'),n]:=Q.fieldbyname('moes_retornomanifesto').asstring;
         if DatetoAno( Q.FieldByName('Moes_datamanifesto').AsDateTime,true )> 1902 then
           Grid.Cells[Grid.GetColumn('sitmanifesto'),n]:='Manifesto efetuado'
         else
           Grid.Cells[Grid.GetColumn('sitmanifesto'),n]:='Sem Manifesto';

         Grid.AppendRow;
         inc(n);

       end;

       Q.Next;

    end;
    FGeral.FechaQuery(Q);
  /////////////////////////////////

    Sistema.endProcess('Consulta finalizada')

  end;

end;

procedure TFNfeDestinadas.EdterminoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////
begin
  if EdTermino.AsDate<EdInicio.AsDate then Edtermino.Invalid('Data final maior que data inicial')
  else if Datetomes(EdTermino.asdate)<>Datetomes(EdInicio.asdate) then Edtermino.Invalid('Período máximo de um mes');


end;

procedure TFNfeDestinadas.EdtipoconsultaValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
begin

  if EdTipoconsulta.Text='1' then begin

     EdInicio.Enabled:=false;
     EdTermino.Enabled:=false;
     EdNsu.Enabled:=true;

  end else begin

     EdInicio.Enabled:=true;
     EdTermino.Enabled:=true;
     EdNsu.Enabled:=false;

  end;

end;

procedure TFNfeDestinadas.EdUnid_codigoKeyPress(Sender: TObject; var Key: Char);
begin
   FGeral.Limpaedit(EdUnid_codigo,key);
end;

procedure TFNfeDestinadas.EdUnid_codigoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
begin
  acbrnfe1.Configuracoes.Certificados.NumeroSerie:=FGeral.GetNroSerieCertificado(EdUnid_codigo.text);
  if trim(EdUNid_codigo.resultfind.fieldbyname('unid_uf').AsString)<>'' then
    ACBrNFe1.Configuracoes.WebServices.UF:=EdUNid_codigo.resultfind.fieldbyname('unid_uf').AsString
  else
    ACBrNFe1.Configuracoes.WebServices.UF:='PR';

end;

procedure TFNfeDestinadas.Execute;
////////////////////////////////////
begin

  if trim( FGeral.GetConfig1AsString('Pastaschemas') ) <> '' then
    Acbrnfe1.Configuracoes.Arquivos.PathSchemas:=FGeral.GetConfig1AsString('Pastaschemas')
  else
    Acbrnfe1.Configuracoes.Arquivos.PathSchemas:=ExtractFilePath( Application.ExeName )+'Schemas20';

  if FGeral.GetConfig1AsString('AmbienteNFe')='1' then
     acbrnfe1.Configuracoes.WebServices.Ambiente:=taProducao
  else
     acbrnfe1.Configuracoes.WebServices.Ambiente:=taHomologacao;

  Show;
  Grid.clear;
  FGeral.ConfiguraColorEditsNaoEnabled(Self);
  EdUnid_codigo.text:=Global.CodigoUnidade;
  if EdInicio.isempty then
    EdInicio.setdate(sistema.hoje);
  if EdTermino.isempty then
    EdTermino.setdate(sistema.hoje);
  EdInicio.SetFirstEd;

end;

// 16.11.17
procedure TFNfeDestinadas.GetListaArquivos(xLista: TStringList; xarquivos,  xpasta: string);
///////////////////////////////////////////////////////////////////////////////////////////////////
var   F: TSearchRec;
      Ret: Integer;
      TempNome: string;

begin

  xLista.clear;
  Ret := FindFirst( xpasta+'\'+xarquivos, faAnyFile, F);
  try

    while Ret = 0 do begin


        TempNome := xpasta +'\' + F.Name;

        if AnsiPos('con',tempnome)=0 then
          xLista.Add(TempNome+'|'+Datetostr(F.TimeStamp));

        Ret := FindNext(F);

    end;

  finally
    FindClose(F);
  end;


end;


end.

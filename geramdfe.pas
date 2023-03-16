// 01.10.20
// gera��o de mdfe a partir de uma nfe autorizada

unit geramdfe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, ACBrDFeReport,
  ACBrMDFeDAMDFeClass, ACBrMDFeDAMDFeRLClass, ACBrBase, ACBrDFe, ACBrMDFe, SqlExpr,
  SqlSis, SqlFun, ACBrNFe;

type
  TFGeraMdfe = class(TForm)
    Panel1: TPanel;
    ACBrMDFe1: TACBrMDFe;
    ACBrMDFeDAMDFeRL1: TACBrMDFeDAMDFeRL;
    OpenDialog1: TOpenDialog;
    ACBrNFe1: TACBrNFe;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute( t : string ; xtipomdfe:string='');

  end;

type TChavesNfe=record
     codigomuni:string;
     chavesnfe:string;
end;

var
  FGeraMdfe : TFGeraMdfe;
  Transacao,
  unidade,
  tipomdfe  : string;
  QN,
  QT,
  QU ,
  QC        : TSqlquery;
  qtdnfes   : integer;
  vlrcarga,
  pesobruto  :currency;
  ListaMuni,
  Lista      :TStringList;
  PChavesNfe :^TChavesNFe;
  ListaChavesNFe : TList;


implementation

{$R *.dfm}

uses munic, geral,Sintegra, pcnconversao,pmdfeConversaoMDFe, gerenciamdfe;

{ TFGeraMdfe }

procedure TFGeraMdfe.Execute(t: string  ; xtipomdfe:string='');
//////////////////////////////////////// /////////////////////////
var numero    : string;
    numeromdfe,
    p,
    x,
    y,
    LoteMdfe,
    NumeroCarga,
    codcidadestino : integer;
    xmlstring : WideString;
    ufdestino,
    cidadestino,
    cola_codigo : string;


    function GetTelefone(fone:string):string;
    //////////////////////////////////////////
    begin
      if trim(fone)='' then
         result:=''
      else if length(trim(fone))<=8 then
        result:='46'+fone
      else if copy(fone,1,1)='0' then
        result:=copy(fone,2,10)
      else if copy(fone,3,1)=' ' then // (46 )32259396
        result:=copy(fone,1,02)+copy(fone,4,08)
      else if copy(fone,1,1)=' ' then // ( 46)32259396
        result:=copy(fone,2,02)+copy(fone,4,08)
      else
        result:=copy(fone,1,10);
    end;


    procedure AtualizaChaveNFe( xmoes_cida_codigo:Integer ; xmoes_chavenfe:String );
    //////////////////////////////////////////////////////////////////////////////////
    var i:integer;
        achou:boolean;
        xcodmuni :string;

    begin

        achou:=false;
        xcodmuni:=FCidades.GetCodigoIbge( QN.fieldbyname('moes_cida_codigo').asinteger);
        for i := 0 to ListaChavesNFe.Count-1 do begin

            PChavesNfe:=ListaChavesNfe[i];
            if PChavesNfe.codigomuni=xcodmuni then begin
               achou:=true;
               break;
            end;

        end;

        if not achou then begin

           New(PChavesNfe);
           PChavesnfe.codigomuni:=xcodmuni;
           Pchavesnfe.chavesnfe :=xmoes_chavenfe;
           ListaChavesNfe.Add(PChavesNfe);

        end else

           Pchavesnfe.chavesnfe := Pchavesnfe.chavesnfe + ';' + xmoes_chavenfe;


    end;


begin

   transacao := t;
   unidade   := Global.codigounidade;
   tipomdfe  := 'NFE';
// NFE : a partir de nota emitida pelo Sac
// XML : a partir do xml da nfe do fornecedor...
   if trim(xtipomdfe)<>'' then tipomdfe := xtipomdfe;

    PathSchemas :=ExtractFilePath( Application.ExeName ) + 'SchemasMdfe';
    PathEnviados:=ExtractFilePath( Application.ExeName ) + 'EnviadosMdfe';
    PathRetorno :=ExtractFilePath( Application.ExeName ) + 'Retornos';
    if not DirectoryExists( PathSchemas ) then begin
       Avisoerro('Falta criar '+PathSchemas);
       exit;
    end;
    if not DirectoryExists( PathEnviados ) then
       ForceDirectories( PathEnviados );

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

   if tipomdfe='XML' then begin

      if not OpenDialog1.Execute() then Exit;
      if OpenDialog1.FileName='' then Exit;
      ACBrNFe1.NotasFiscais.Clear;
      try
         ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName)
      except on E:Exception do AvisoErro(E.message)
      end;

   end;

// 17.05.21
   if ( AnsiPos(tipomdfe,'NFE')>0 ) and ( Global.Topicos[1477] ) then begin

//     ufdestino := 'MS';
     ufdestino := '';
     if not Input('UF Destino','UF',ufdestino,2,true) then exit;
//     cidadestino := '162';
     cidadestino := '';
     if not Input('Cidade Destino','Codigo',cidadestino,5,true) then exit;

     codcidadestino := strtointdef(cidadestino,0);

     if codcidadestino=0 then begin

        Avisoerro('codigo da cidade n�o informada');
        exit;

     end;

   end else if ( AnsiPos(tipomdfe,'XML')>0 )  then begin

     codcidadestino := ACBrNFe1.NotasFiscais.Items[0].NFe.Dest.EnderDest.cMun;
     ufdestino := ACBrNFe1.NotasFiscais.Items[0].NFe.Dest.EnderDest.UF;

   end;

   Sistema.BeginProcess('Montando manifesto');

   // emitente
   if xtipomdfe = 'XML' then begin
// fixo para pode cadastrar como transportador o prorpio emitente e mantger a mesma query QT
      QT:=SqlToQuery(' select * from transportadores where tran_codigo = '+stringtosql('021') );
      if QT.Eof then begin

         Sistema.EndProcess('Falta cadastrar o transportador com o codigo 021 com os dados do emitente do MDFe');
         Exit;


      end;
      cola_codigo := '0001';

   end else begin

      QN:=sqltoquery('select moes_chavenfe,moes_xmlnfet,moes_dtnfeauto,moes_dtnfecanc,moes_cida_codigo,'+
                       ' moes_pesobru,moes_vlrtotal,moes_tran_codigo,moes_cola_codigo,moes_estado from '+
                       ' movesto where moes_unid_codigo = '+stringtosql( unidade ) +
                       ' and moes_transacao = '+stringtosql( transacao )+
                       ' and moes_unid_codigo = '+stringtosql( unidade )+
                       ' and moes_status = ''N''');

      QT:=SqlToQuery(' select * from transportadores where tran_codigo = '+stringtosql(QN.fieldbyname('moes_tran_codigo').asstring) );
      cola_codigo := QN.fieldbyname('Moes_cola_codigo').asstring;

   end;

   QU:=sqltoquery(' select * from unidades where unid_codigo = '+stringtosql(unidade));
   Acbrmdfe1.Manifestos.Clear;

   with ACBrMDFe1.Manifestos.Add.MDFe do begin


      numero:=Fsintegra.GetNumerodoEndereco(QU.fieldbyname('unid_endereco').asstring,0,'N');

      Emit.xNome     := QU.fieldbyname('Unid_razaosocial').asstring;
      Emit.xFant     := QU.fieldbyname('Unid_nome').asstring;
      Emit.CNPJCPF   := QU.fieldbyname('Unid_cnpj').asstring;
      Emit.IE        := QU.fieldbyname('Unid_inscricaoestadual').asstring;

      Emit.EnderEmit.fone       :=GetTelefone(QU.fieldbyname('unid_fone').asstring);
      Emit.EnderEmit.CEP        :=strtoint(QU.fieldbyname('unid_cep').asstring);
      if pos(',',QU.fieldbyname('unid_endereco').asstring)>0 then
          Emit.EnderEmit.xLgr      := Ups( copy(QU.fieldbyname('unid_endereco').asstring,1,pos(',',Qu.fieldbyname('unid_endereco').asstring)) )
      else
         Emit.EnderEmit.xLgr      := Ups( QU.fieldbyname('unid_endereco').asstring );

      Emit.EnderEmit.nro        :=numero;
//      Emit.EnderEmit.xCpl       := '';
      Emit.EnderEmit.xBairro    := Ups(QU.fieldbyname('unid_bairro').asstring);
      Emit.EnderEmit.cMun   := strtoint( FCidades.GetCodigoIBGE(Qu.fieldbyname('unid_cida_codigo').asinteger) );
      Emit.EnderEmit.xMun := Ups(QU.fieldbyname('unid_municipio').asstring);
      Emit.EnderEmit.UF   := QU.fieldbyname('unid_uf').asstring;
      Emit.enderEmit.email:= QU.fieldbyname('unid_email').asstring;


///////////////////////////////////////
///
   // ide

      NumeroMdfe          := FGeral.GetContador('MDFE'+Unidade,false,false)+1;
      Ide.cMDF            := NumeroMdfe;
      Ide.nMDF            := NumeroMdfe;
      Ide.cUF             := UFtoCUF(QU.fieldbyname('unid_uf').asstring);
      Ide.modelo          := '58';
      Ide.serie       := 1;
      Ide.verProc     := Global.VersaoSistema;
//      if (tipomdfe = 'NFE' ) and ( Global.Topicos[1477] ) then begin
//      if ( AnsiPos(tipomdfe,'NFE/XML')>0 ) and ( Global.Topicos[1477] ) then begin
// 29.04.2022
      if ( AnsiPos(tipomdfe,'NFE/XML')>0 )  then begin

         Ide.tpEmit      := teTranspCargaPropria;
// 17.05.2021
         Ide.UFFim   := ufdestino;

      end else begin

         Ide.tpEmit      := teTransportadora;
         Ide.UFFim   := (QN.fieldbyname('moes_estado').asstring);

      end;

      Ide.modal   := moRodoviario;
      Ide.dhEmi   := Now;
      // TpcnTipoEmissao = (teNormal, teContingencia, teSCAN, teDPEC, teFSDA);
      Ide.tpEmis  := teNormal;
      // TpcnProcessoEmissao = (peAplicativoContribuinte, peAvulsaFisco, peAvulsaContribuinte, peContribuinteAplicativoFisco);
      Ide.procEmi := peAplicativoContribuinte;
      Ide.UFIni   := (QU.fieldbyname('unid_uf').asstring);
      if xtipomdfe = 'XML' then

         Ide.UFIni   := ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.EnderEmit.UF;

//      Ide.UFFim   := (QU.fieldbyname('unid_uf').asstring);
// 10.12.20
      if ( Ide.UFini = 'PR' ) and ( Ide.UFFim='MT' ) then begin

        Ide.infPercurso.Add.UFPer:='MS';

      end else if ( Ide.UFini = 'PR' ) and ( Ide.UFFim='RS' ) then begin

        Ide.infPercurso.Add.UFPer:='SC';

// 19.07.2021
      end else if ( Ide.UFini = 'PR' ) and ( Ide.UFFim='MG' ) then begin

        Ide.infPercurso.Add.UFPer:='SP';

// 04.10.2022
      end else if ( Ide.UFini = 'PR' ) and ( Ide.UFFim='GO' ) then begin

        Ide.infPercurso.Add.UFPer:='SP';
        Ide.infPercurso.Add.UFPer:='MG';

// 27.04.2022 - Sicare vai buscar mercadoria com caminhao proprio
      end else if ( Ide.UFini = 'RS' ) and ( Ide.UFFim='PR' ) then begin

        Ide.infPercurso.Add.UFPer:='SC';

      end;

      if tipomdfe = 'CTE' then  begin

          if trim( FGeral.GetConfig1AsString('AmbienteCTe') )<>'' then  begin
            if FGeral.GetConfig1AsString('AmbienteCTe') = '1' then
              Ide.tpAmb     := taproducao
            else
              Ide.tpAmb     := taHomologacao;
          end else
            Ide.tpAmb     := taHomologacao;

      end else begin

          if trim( FGeral.GetConfig1AsString('AmbienteNFe') )<>'' then  begin
            if FGeral.GetConfig1AsString('AmbienteNFe') = '1' then
              Ide.tpAmb     := taproducao
            else
              Ide.tpAmb     := taHomologacao;
          end else
            Ide.tpAmb     := taHomologacao;

      end;

     with Ide.infMunCarrega.Add do begin

        if xtipomdfe = 'XML' then begin

          cMunCarrega := ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.EnderEmit.cMun;;
          xMunCarrega := ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.EnderEmit.xMun;

        end else begin

          cMunCarrega := strtoint( FCidades.GetCodigoIBGE(Qu.fieldbyname('unid_cida_codigo').asinteger) );
          xMunCarrega := Ups(QU.fieldbyname('unid_municipio').asstring);

        end;

     end;

// campo novo
// ver se � obrigatorio nao caso do 'XML' - sicare - vando
     rodo.RNTRC := QT.fieldbyname('tran_rntrc').asstring;

      if tipomdfe = 'CTE' then begin

          rodo.infANTT.RNTRC          := QT.fieldbyname('tran_rntrc').asstring;
          with rodo.infANTT.infContratante.Add do
              CNPJCPF := QT.fieldbyname('tran_cnpjcpf').asstring;

//      rodo.CIOT  := '123456789012';  //
      end;

      rodo.veicTracao.cInt    := QT.fieldbyname('tran_codigo').asstring;
      rodo.veicTracao.placa   := QT.fieldbyname('tran_placa').asstring;
      rodo.veicTracao.tara    := QT.fieldbyname('tran_tara').asinteger;
      rodo.veicTracao.capKG   := QT.fieldbyname('tran_pesomaximo').asinteger;
      rodo.veicTracao.UF      := QT.fieldbyname('tran_ufplaca').asstring;
// campo novo
      rodo.veicTracao.RENAVAM := QT.fieldbyname('tran_renavan').asstring;

// campos novo
      rodo.veicTracao.capM3   := QT.fieldbyname('tran_volume').asinteger;

      // TpcteTipoRodado = (trNaoAplicavel, trTruck, trToco, trCavaloMecanico, trVAN, trUtilitario, trOutros);
      // Para o MDF-e n�o utilizar o trNaoAplicavel.
      rodo.veicTracao.tpRod := trToco;

      // TpcteTipoCarroceria = (tcNaoAplicavel, tcAberta, tcFechada, tcGraneleira, tcPortaContainer, tcSider);
      rodo.veicTracao.tpCar := tcFechada;

//      rodo.veicTracao.UF := edtEmitUF.Text;

      if trim(cola_codigo) <>'' then begin

        QC := sqltoquery('select * from colaboradores where cola_codigo = '+stringtosql(cola_codigo));
        if QC.Eof then begin

           Sistema.EndProcess('Falta cadastrar o colaborador '+cola_codigo);
           Exit;

        end;

          with rodo.veicTracao.condutor.Add do
          begin
            xNome := QC.FieldByName('COLA_DESCRICAO').AsString;
// campo novo
            CPF   := QC.FieldByName('COLA_CPf').AsString;
          end;

      end;


     qtdnfes   :=0;
     vlrcarga  :=0;
     pesobruto :=0;
     ListaMuni :=TStringList.Create;
     ListaChavesNFe := TList.Create;

      if (tipomdfe = 'XML' ) then begin

             with infDoc.infMunDescarga.new do begin

                   cMunDescarga:= codcidadestino ;
                   xMunDescarga:= ACBrNFe1.NotasFiscais.Items[0].NFe.Dest.EnderDest.xMun;
                   with infNFe.add  do
                       chnfe := ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.chNFe;
             end;
             pesobruto   :=pesobruto + ACBrNFe1.NotasFiscais.Items[0].NFe.Transp.Vol.Items[0].pesoB;
             inc( qtdnfes );
             vlrcarga    := vlrcarga + ACBrNFe1.NotasFiscais.Items[0].NFe.Total.Icmstot.vNF  ;

      end else if (not QN.Eof)  then begin

// 18.05.2021
          if ( AnsiPos(tipomdfe,'NFE')>0 ) and ( Global.Topicos[1477] ) then begin

             if ListaMuni.IndexOf( FCidades.GetCodigoIbge( codcidadestino) )=-1  then begin

                with infDoc.infMunDescarga.new do begin

                   cMunDescarga:=StrtoInt( FCidades.GetCodigoIbge( codcidadestino ) );
                   xMunDescarga:=FCidades.GetNome( codcidadestino);
                   ListaMuni.Add( FCidades.GetCodigoIbge( codcidadestino ) );
                   with infNFe.add  do
                       chnfe := QN.FieldByName('moes_chavenfe').AsString;
                end;

             end;

          end else begin

             if ListaMuni.IndexOf( FCidades.GetCodigoIbge( QN.fieldbyname('moes_cida_codigo').asinteger) )=-1  then begin

                with infDoc.infMunDescarga.new do begin

                   cMunDescarga:=StrtoInt( FCidades.GetCodigoIbge( QN.fieldbyname('moes_cida_codigo').asinteger) );
                   xMunDescarga:=FCidades.GetNome( QN.fieldbyname('moes_cida_codigo').asinteger);
                   ListaMuni.Add( FCidades.GetCodigoIbge( QN.fieldbyname('moes_cida_codigo').asinteger ) );

                end;

             end;

          end;

             pesobruto   :=pesobruto + QN.fieldbyname('moes_pesobru').ascurrency;
             inc( qtdnfes );
             vlrcarga    := vlrcarga + QN.fieldbyname('moes_vlrtotal').ascurrency; ;
             AtualizaChaveNFe( QN.FieldByName('moes_cida_codigo').AsInteger, QN.FieldByName('moes_chavenfe').AsString );


      end;   // Qn.eof


      for p := 0 to infDoc.infMunDescarga.Count-1 do begin

           for x := 0 to ListaChavesNfe.count-1 do begin

              PChavesnfe :=ListaChavesNfe[x];
              if Strtoint( PChavesnfe.codigomuni ) = infDoc.infMunDescarga.Items[p].cMunDescarga then begin

                 Lista:=TStringList.create;
                 strtoLista(Lista,PChavesnfe.chavesnfe,';',true);
                 for y := 0 to Lista.count-1 do begin

                   if tipomdfe = 'CTE' then begin

                      with infDoc.infMunDescarga.Items[p].infCTe.New do
                           chCTe := Lista[y];

                   end else begin

                      with infDoc.infMunDescarga.Items[p].infNFe.Add do
                           chnfe := Lista[y];
                   end;

                 end;
                 Lista.free;

              end;

           end;

      end;

   ListaMuni.Free;

       with tot do begin

          vCarga := vlrcarga;
          cunid  := uKG;
          qcarga := pesobruto;
//          if tipomdfe = 'NFE' then
          if ( AnsiPos(tipomdfe,'NFE/XML')>0 )then

             qNFe   := qtdnfes

          else

             qCTe   := qtdnfes;

       end;

       if tipomdfe = 'CTE' then  begin

             with seg.Add do begin

    //           respSeg := rsEmitente;
               respSeg := rsTomadorServico;
               CNPJCPF := '84098910000300';
               CNPJ    := '74098910000201';
               xSeg    := 'SULAMERICA SEGUROS S/A';
               nApol   := 'A121215151512151511';
               with aver.Add do begin

                   nAver :='1234567890';

               end;

             end;

       end;


   end;  // acbrmdfe1...add...

   Sistema.endProcess('');

   if Acbrmdfe1.Manifestos.Count>0 then begin

     Sistema.BeginProcess('Enviando manifesto '+inttostr(NumeroMdfe));
     try

     LoteMdfe      := FGeral.GetContador('LOTEMDFE'+Unidade,false,true);

     ACBrMDFe1.Enviar( LoteMdfe  );
     Sistema.EndProcess('Retorno Receita :'+ACBrMDFe1.WebServices.Retorno.xMotivo+
                        ' Aviso '+ACBrMDFe1.WebServices.Retorno.Msg);

     xmlstring:=ACBrMDFe1.Manifestos.Items[0].XML;
     xmlstring:=FGeral.TiraBarra(xmlstring,chr(39),'"');

       if Ansipos('AUTORIZADO O USO',Uppercase(ACBrMDFe1.WebServices.Retorno.xMotivo) ) > 0  then begin

         NumeroCarga:=FGeral.GetContador('CARGA'+unidade,false);
         Sistema.Insert('movcargas');
         Sistema.SetField('movc_dtauto',Sistema.Hoje);
    //     Sistema.SetField('movc_xmlmdfe',ACBrMDFe1.Manifestos.Items[0].XMLAssinado);
         Sistema.SetField('movc_xmlmdfe',xmlstring);
         Sistema.SetField('movc_protocolo',ACBrMDFe1.WebServices.Retorno.Protocolo);
         Sistema.SetField('movc_recibo',ACBrMDFe1.WebServices.Retorno.Recibo);
         Sistema.SetField('movc_status','N');
         Sistema.SetField('movc_unid_codigo',unidade  );
         Sistema.SetField('movc_numero',NumeroCarga );
         Sistema.setfield('movc_data',Sistema.Hoje);
         Sistema.setfield('movc_datamvto',Sistema.Hoje);
//         Sistema.setfield('movc_cola_codigo01',QN.fieldbyname('Moes_cola_codigo').asstring);
//         Sistema.setfield('movc_tran_codigo',QN.fieldbyname('moes_Tran_codigo').asstring);
         Sistema.setfield('movc_tran_codigo',QT.fieldbyname('Tran_codigo').asstring);
// 29.04.2022
         Sistema.setfield('movc_cola_codigo01',cola_codigo);
    //     Sistema.setfield('movc_cola_codigo02',EdMoes_cola_codigo02.text);
         Sistema.setfield('movc_pesonotas',PesoBruto );
         Sistema.setfield('movc_usua_codigo',Global.Usuario.Codigo);
         Sistema.Post();

         Sistema.edit('movesto');
         Sistema.SetField('moes_carga',Numerocarga);
         Sistema.post('moes_transacao = '+stringtosql(transacao )+
                      ' and moes_unid_codigo = '+stringtosql(unidade));

         try
            Sistema.Commit;
            NumeroMdfe          := FGeral.GetContador('MDFE'+Unidade,false,true);
            FGerenciaMdf.Execute( NumeroCarga );

         except on E:exception do

           Avisoerro( E.Message );

         end;



       end else Aviso('Manifesto n�o gerado');

     except on E:exception do

           Avisoerro( E.Message );

     end;

   end;   // manifestos.count...

   Sistema.endProcess('');

   FGeral.FechaQuery(QN);

end;

end.

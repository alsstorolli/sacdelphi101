unit pesagemporcarga;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ACBrBase, ACBrBAL, Vcl.Grids, SqlDtg,
  Vcl.StdCtrls, Vcl.Mask, SQLEd, Vcl.Buttons, SQLBtn, alabel, SQLGrid,
  Vcl.ExtCtrls, SqlExpr, SqlSis, ACBrDFe, ACBrMDFe, ACBrDFeReport,
  ACBrDFeDANFeReport, ACBrNFeDANFEClass, ACBrNFeDANFeRLClass,
  ACBrMDFeDAMDFeClass, ACBrMDFeDAMDFeRLClass;

type
  TFPesagemporCarga = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    bpesapedido: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    Edtermino: TSQLEd;
    EdInicio: TSQLEd;
    EdTran_nome: TSQLEd;
    pgrid: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    EdCarga: TSQLEd;
    EdMoes_cola_codigo01: TSQLEd;
    SetEdCOLA_NOME: TSQLEd;
    EdMoes_cola_codigo02: TSQLEd;
    SQLEd1: TSQLEd;
    bgeranfes: TSQLBtn;
    EdDif: TSQLEd;
    Edkm: TSQLEd;
    EdTran_codigo: TSQLEd;
    batualizapeso: TSQLBtn;
    bincluicarga: TSQLBtn;
    EdDataCarga: TSQLEd;
    bexlcuidacarga: TSQLBtn;
    bmanifesto: TSQLBtn;
    ACBrMDFeDAMDFeRL1: TACBrMDFeDAMDFeRL;
    bimpmdfe: TSQLBtn;
    balterapedido: TSQLBtn;
    EdPesoCarga: TSQLEd;
    ACBrMDFe1: TACBrMDFe;
    procedure EdCargaValidate(Sender: TObject);
    procedure EdMoes_cola_codigo02ExitEdit(Sender: TObject);
    procedure bpesapedidoClick(Sender: TObject);
    procedure EdMoes_cola_codigo02KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bSairClick(Sender: TObject);
    procedure bgeranfesClick(Sender: TObject);
    procedure EdTran_codigoValidate(Sender: TObject);
    procedure EdkmChange(Sender: TObject);
    procedure bincluicargaClick(Sender: TObject);
    procedure EdCargaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdTran_codigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bexlcuidacargaClick(Sender: TObject);
    procedure bmanifestoClick(Sender: TObject);
    procedure bimpmdfeClick(Sender: TObject);
    procedure EdkmValidate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure balterapedidoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(tipo:string='NFE');
    procedure SetaCargas(tran_codigo:string;Ed:TSqlEd);
    procedure CargatoGrid(xQ:Tsqlquery);
    procedure ConfiguraTeclas( Key: Word );
    function ChecagemdePeso:boolean;
    function GetPesoCaminhao( xcodigo:string ):currency;
    function GetPesoPedidos:currency;
    function GetPeso( xpedido:integer ; xdata:TDatetime ):currency;
    function GetUltimaKM(xTran_codigo:string):integer;
// 16.07.20
    procedure CargaCTetoGrid(xQ:Tsqlquery);

  end;

var
  FPesagemporCarga: TFPesagemporCarga;
  Unidade,
  PathEnviados,
  PathRetorno,
  PathSchemas,
  tipomdfe         : String;
  nropedido        : integer;
  xdatapedido      : TDatetime;

implementation

uses SqlFun, Geral , cadcli, pesagemsaida, nfsaida, montagemcarga, expnfetxt,
  sintegra, munic, pcnconversao,pmdfeConversaoMDFe,gerenciamdfe, Pedvenda;

{$R *.dfm}

{ TFPesagemporCarga }

// 09.09.18
// 20.05.20
procedure TFPesagemporCarga.balterapedidoClick(Sender: TObject);
//////////////////////////////////////////////////////////////////////
begin

  nropedido       := StrtoIntdef( Grid.Cells[Grid.GetColumn('moes_numerodoc'),Grid.Row],0 );
  if nropedido > 0 then   PedidoVenda_Execute('A',nropedido);

end;

procedure TFPesagemporCarga.bexlcuidacargaClick(Sender: TObject);
////////////////////////////////////////////////////////////////////
var xpedido,
    xtrans   :string;

begin

   xpedido := Grid.Cells[Grid.GetColumn('moes_numerodoc'),Grid.Row];
   xtrans  := Grid.Cells[Grid.GetColumn('transacao'),Grid.Row];
   if trim(xtrans)='' then exit;
   if not confirma('Confirma retirar o pedido '+xpedido+' desta carga ?') then exit;

   Sistema.Edit('movped');
   Sistema.SetField('mped_nftrans',0);
   Sistema.SetField('mped_ordem',0);
   Sistema.Post('mped_transacao = '+stringtosql(xtrans));
   Sistema.commit;

   EdCarga.Valid;  // para atualizar a tela

end;

procedure TFPesagemporCarga.bgeranfesClick(Sender: TObject);
//////////////////////////////////////////////////////////////////
var p,
    n            :integer;
    QPedido,
    QNfe         :TSqlquery;
    sqlaberto,sqlwhere,sqldata:string;

begin

   EdKm.OnExitEdit(self);   // para atualizar os pesos
   if not ChecagemdePeso then exit;
   if EdDif.ascurrency=0 then begin
     Avisoerro('Falta o peso ');
     exit;
   end;
   QNfe:=sqltoquery('select moes_transacao,moes_numerodoc from movesto where moes_carga='+EdCarga.text+
                    ' and moes_status = ''N'' and moes_unid_codigo = '+Stringtosql(UNidade));
   if not QNfe.eof then begin
     Avisoerro('Carga j� faturada na transa��o '+QNfe.fieldbyname('moes_transacao').asstring+' NFe '+QNFe.fieldbyname('moes_numerodoc').asstring);
     FGeral.Fechaquery(QNFe);
     exit;
   end;
   FGeral.Fechaquery(QNFe);
   if not confirma('Confirma emiss�o das nf-e ?') then exit;
// aqui ira percorrer o grid de pedidos gerando uma nf-e para cada pedido
// 10.09.18
   n:=0;
   for p:=0 to Grid.rowcount-1 do begin

     if Strtointdef(Grid.cells[Grid.getcolumn('pesopedido'),p],0)>0 then begin

       sqlaberto:=' and '+Fgeral.getin('mped_situacao','P;A','C');
       sqlwhere:=' where '+FGEral.getin('mpdd_status','N;','C')+' and mpdd_numerodoc='+Grid.cells[Grid.getcolumn('moes_numerodoc'),p];
       sqldata:=' and mped_dataemissao >= '+EdInicio.assql;
       QPedido:=sqltoquery('select * from movpeddet inner join movped on ( mped_transacao=mpdd_transacao )'+
                           ' inner join estoque on ( esto_codigo = mpdd_esto_codigo )'+
                           sqlwhere+
                           sqlaberto+sqldata+
                           ' and mped_unid_codigo = '+Stringtosql(Unidade)+
                           ' order by mped_datamvto,mpdd_numerodoc,mpdd_seq');
  // pra prever 'pedidos de terceiros'
       if DAtetoano(QPedido.FieldByName('mped_datacont').asdatetime,true ) > 1921 then
         Sistema.BeginProcess('Gerando NFe referente pedido '+Grid.cells[Grid.getcolumn('moes_numerodoc'),p]);
         FNotaSaida.Execute('H','N',Fgeral.GetConfig1AsInteger('ConfMovAbate'),Strtoint(Grid.cells[Grid.getcolumn('moes_numerodoc'),p]),
                       Strtoint(Grid.cells[Grid.getcolumn('moes_tipo_codigo'),p]),QPedido.fieldbyname('mped_fpgt_codigo').asstring,EdTran_codigo.text,
                       QPedido.fieldbyname('mped_port_codigo').asstring,Texttovalor(Grid.cells[Grid.getcolumn('moes_vlrtotal'),p]),Edmoes_cola_codigo01.text,
                       EdCarga.asinteger);
         inc(n);
     end;

   end;

   Sistema.endprocess('Geradas '+inttostr(n)+' notas');

end;

procedure TFPesagemporCarga.bimpmdfeClick(Sender: TObject);
/////////////////////////////////////////////////////////////

begin

   FGerenciaMdf.Execute( EdCarga.AsInteger );

end;

procedure TFPesagemporCarga.bincluicargaClick(Sender: TObject);
/////////////////////////////////////////////////////////////////
begin

    FMontaCarga.Execute('X',EdCarga.AsInteger,EdTran_codigo.text);
//    EdCarga.setfocus;
//    EdCarga.next;

end;

// 23.05.19
procedure TFPesagemporCarga.bmanifestoClick(Sender: TObject);
/////////////////////////////////////////////////////////////

type TChavesNfe=record
     codigomuni:string;
     chavesnfe:string;
end;

var p,
    nronota,
    NumeroMdfe,
    LoteMdfe,
    qtdnfes,
    x,
    y ,
    codigocliente        :integer;
    QN,
    QU,
    QT         :TSqlquery;
    numero     :string;
    vlrcarga,
    pesobruto  :currency;
    ListaMuni,
    Lista      :TStringList;
    PChavesNfe :^TChavesNFe;
    ListaChavesNFe : TList;
    xmlstring:WideString;


    function NotaAutorizada( xnronota:integer ):boolean;
    /////////////////////////////////////////////////////
    begin

        QN:=sqltoquery('select moes_chavenfe,moes_xmlnfet,moes_dtnfeauto,moes_dtnfecanc from '+
                       ' movesto where moes_unid_codigo = '+stringtosql( unidade ) +
                       ' and moes_numerodoc = '+inttostr( xnronota )+
                       ' and moes_dataemissao >= '+Datetosql(Sistema.Hoje-30) +
                       ' and '+FGeral.GetIN('moes_tipomov',Global.CodVendaDireta,'C')+
                       ' and moes_status = ''N''');
        result:=true;
        if QN.Eof then result:=false else
        if DAtetoano(QN.fieldbyname('moes_dtnfeauto').asdatetime,true)<=1900 then result:=false else
        if trim(QN.fieldbyname('moes_xmlnfet').asstring)='' then result:=false else
        if AnsiPos('Autorizado',FExpNfetxt.GetTag('xmotivo',QN.fieldbyname('moes_xmlnfet').asstring))= 0 then result:=false else
        if DAtetoano(QN.fieldbyname('moes_dtnfecanc').asdatetime,true)>1900 then begin
           result:=false;
           Avisoerro('NFe foi cancelada em '+FGeral.FormataData(QN.fieldbyname('moes_dtnfecanc').asdatetime));
        end;
        QN.Close;

    end;

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
/////////////////////////////

 // primeiro verifica se todos os pedidos foram feito nota E autorizadas
   for p:=0 to Grid.rowcount-1 do begin

      nronota:=StrtoIntdef( Grid.Cells[Grid.GetColumn('numeronfe'),p],0 );
      nropedido:=StrtoIntdef( Grid.Cells[Grid.GetColumn('moes_numerodoc'),p],0 );
      if (nropedido>0) and (nronota=0) and ( tipomdfe='NFE' ) then begin

         Avisoerro('Pedido '+inttostr(nropedido)+' ainda n�o faturado');
         exit;

      end;

      if (nropedido>0) and (nronota>0) then begin

          if not NotaAutorizada( nronota ) then begin
             Avisoerro('Nota '+inttostr(nronota)+' ainda n�o autorizada');
             exit;
          end;

      end;

   end;

 // depois monta o manifesto incluindo as notas autorizadas
   Sistema.BeginProcess('Montando manifesto');

   // emitente
   QU:=sqltoquery(' select * from unidades where unid_codigo = '+stringtosql(unidade));
   QT:=SqlToQuery(' select * from transportadores where tran_codigo = '+EdTran_codigo.AsSql);
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
    // TMDFeTpEmitente = ( teTransportadora, teTranspCargaPropria );
// 16.07.20
      if tipomdfe = 'NFE' then

         Ide.tpEmit      := teTranspCargaPropria

      else

         Ide.tpEmit      := teTransportadora;

      Ide.modal   := moRodoviario;
      Ide.dhEmi   := Now;
      // TpcnTipoEmissao = (teNormal, teContingencia, teSCAN, teDPEC, teFSDA);
      Ide.tpEmis  := teNormal;
      // TpcnProcessoEmissao = (peAplicativoContribuinte, peAvulsaFisco, peAvulsaContribuinte, peContribuinteAplicativoFisco);
      Ide.procEmi := peAplicativoContribuinte;
      Ide.UFIni   := (QU.fieldbyname('unid_uf').asstring);
      Ide.UFFim   := (QU.fieldbyname('unid_uf').asstring);


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

        cMunCarrega := strtoint( FCidades.GetCodigoIBGE(Qu.fieldbyname('unid_cida_codigo').asinteger) );
        xMunCarrega := Ups(QU.fieldbyname('unid_municipio').asstring);

     end;


// campo novo
      rodo.RNTRC := QT.fieldbyname('tran_rntrc').asstring;
// 16.07.20
      if tipomdfe = 'CTE' then begin

          rodo.infANTT.RNTRC          := QT.fieldbyname('tran_rntrc').asstring;

          with rodo.infANTT.infContratante.Add do begin

              CNPJCPF := QT.fieldbyname('tran_cnpjcpf').asstring;
              xNome   := Qt.fieldbyname('tran_razaosocial').asstring;

          end;


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
// 30.01.2021
{
      rodo.veicTracao.prop.CNPJCPF := QT.fieldbyname('tran_cnpjcpf').asstring;
      rodo.veicTracao.prop.IE      := QT.fieldbyname('tran_inscricaoestadual').asstring;
      rodo.veicTracao.prop.RNTRC   := QT.fieldbyname('tran_rntrc').asstring;
      rodo.veicTracao.prop.xNome   := Qt.fieldbyname('tran_razaosocial').asstring;
      rodo.veicTracao.prop.uf      := Global.UFUnidade;

}

//      rodo.veicTracao.prop.RNTRC   := QT.fieldbyname('tran_rntrc').asstring;
//////////////

//      rodo.veicTracao.UF := edtEmitUF.Text;

      if not EdMoes_cola_codigo01.IsEmpty then begin

        with rodo.veicTracao.condutor.Add do
        begin
          xNome := EdMoes_cola_codigo01.ResultFind.FieldByName('COLA_DESCRICAO').AsString;
// campo novo
          CPF   := EdMoes_cola_codigo01.ResultFind.FieldByName('COLA_CPf').AsString;
        end;

      end;
      if not EdMoes_cola_codigo02.IsEmpty then begin

        with rodo.veicTracao.condutor.Add do
        begin
          xNome := EdMoes_cola_codigo02.ResultFind.FieldByName('COLA_DESCRICAO').AsString;
// campo novo
          CPF   := EdMoes_cola_codigo02.ResultFind.FieldByName('COLA_CPf').AsString;
        end;

      end;

   qtdnfes   :=0;
   vlrcarga  :=0;
   pesobruto :=0;
   ListaMuni :=TStringList.Create;
   ListaChavesNFe := TList.Create;
   codigocliente:=0;

   for p:=0 to Grid.rowcount-1 do begin

      if tipomdfe = 'NFE' then begin

          nronota  :=StrtoIntdef( Grid.Cells[Grid.GetColumn('numeronfe'),p],0 );
          nropedido:=StrtoIntdef( Grid.Cells[Grid.GetColumn('moes_numerodoc'),p],0 );
          QN:=sqltoquery('select moes_chavenfe,moes_xmlnfet,moes_dtnfeauto,moes_dtnfecanc,moes_cida_codigo,'+
                       ' moes_pesobru,moes_vlrtotal,moes_estado,moes_tipo_codigo from '+
                       ' movesto where moes_unid_codigo = '+stringtosql( unidade ) +
                       ' and moes_numerodoc = '+inttostr( nronota )+
                       ' and moes_dataemissao >= '+Datetosql(Sistema.Hoje-32) +
                       ' and '+FGeral.GetIN('moes_tipomov',Global.CodVendaDireta,'C')+
                       ' and moes_status = ''N''');

      end else  begin

          nronota  :=StrtoIntdef( Grid.Cells[Grid.GetColumn('numeronfe'),p],0 );
          nropedido:=StrtoIntdef( Grid.Cells[Grid.GetColumn('moes_numerodoc'),p],0 );
          QN:=sqltoquery('select moes_chavenfe,moes_xmlnfet,moes_dtnfeauto,moes_dtnfecanc,moes_cida_codigo,'+
                       ' moes_pesobru,moes_vlrtotal,moes_estado,moes_tipo_codigo from '+
                       ' movesto where moes_unid_codigo = '+stringtosql( unidade ) +
                       ' and moes_numerodoc = '+inttostr( nropedido )+
                       ' and moes_dataemissao >= '+Datetosql(Sistema.Hoje-32) +
                       ' and '+FGeral.GetIN('moes_tipomov',Global.CodConhecimentoSaida,'C')+
                       ' and moes_status = ''N''');

      end;


      if not QN.Eof then begin

             codigocliente := QN.fieldbyname('moes_tipo_codigo').asinteger;

             if ListaMuni.IndexOf( FCidades.GetCodigoIbge( QN.fieldbyname('moes_cida_codigo').asinteger) )=-1  then begin

                with infDoc.infMunDescarga.Add do begin

                   cMunDescarga:=StrtoInt( FCidades.GetCodigoIbge( QN.fieldbyname('moes_cida_codigo').asinteger) );
                   xMunDescarga:=FCidades.GetNome( QN.fieldbyname('moes_cida_codigo').asinteger);
                   ListaMuni.Add( FCidades.GetCodigoIbge( QN.fieldbyname('moes_cida_codigo').asinteger ) );
// 30.01.2021 - Sgpa - Isabel - para fora do estado
                   if Ide.UFIni<>QN.fieldbyname('moes_estado').asstring then begin

                      Ide.UFFim   := (QN.fieldbyname('moes_estado').asstring);
// por enquanto fazendo como base origem do PR

                          if AnsiPos( QN.fieldbyname('moes_estado').asstring,'PE/SE/RN' ) > 0 then begin

//                            ACBrMDFe1.Manifestos.

                             with ide.infPercurso.Add do
                                ufper := 'SP' ;
                             with ide.infPercurso.Add do
                                ufper := 'MG' ;
                             with ide.infPercurso.Add do
                                ufper := 'BA' ;
                             with ide.infPercurso.Add do
                                ufper := 'AL' ;

//                             PR SP MG BA AL PE

                         end else if AnsiPos( QN.fieldbyname('moes_estado').asstring,'MT') > 0  then begin

                             with ide.infPercurso.Add do
                                ufper := 'MS' ;

                         end;

                   end;

                end;

             end;

             pesobruto   :=pesobruto + QN.fieldbyname('moes_pesobru').ascurrency;
             inc( qtdnfes );
             vlrcarga    := vlrcarga + QN.fieldbyname('moes_vlrtotal').ascurrency; ;
             AtualizaChaveNFe( QN.FieldByName('moes_cida_codigo').AsInteger, QN.FieldByName('moes_chavenfe').AsString );


      end;   // Qn.eof

      FGeral.FechaQuery(QN);

   end;  // for do grid ( notas )

   for p := 0 to infDoc.infMunDescarga.Count-1 do begin

           for x := 0 to ListaChavesNfe.count-1 do begin

              PChavesnfe :=ListaChavesNfe[x];
              if Strtoint( PChavesnfe.codigomuni ) = infDoc.infMunDescarga.Items[p].cMunDescarga then begin

                 Lista:=TStringList.create;
                 strtoLista(Lista,PChavesnfe.chavesnfe,';',true);
                 for y := 0 to Lista.count-1 do begin

                   if tipomdfe = 'CTE' then begin

                      with infDoc.infMunDescarga.Items[p].infCTe.Add do
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
      if tipomdfe = 'NFE' then

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
//           CNPJ    := '07244930000130';
           xSeg    := 'SULAMERICA SEGUROS S/A';
           nApol   := 'A121215151512151511';
           with aver.Add do begin

               nAver :='1234567890';

           end;

        end;


// 30.01.2021 - fixo at� ver como buscar
         if Ide.UFFim <> Global.UFUnidade then begin

           prodPred.tpCarga := tcCargaGeral;
           prodPred.xProd :='Cartela de Ovos';
//    <!-- GTIN (Global Trade Item Number) do produto, antigo c�digo EAN -->
//    <cEAN>7899009080365</cEAN>
//           prodPred.cean:='7898909374741';
           prodPred.NCM := '48195000';
           prodPred.infLocalCarrega.CEP    := strtoint(QU.fieldbyname('unid_cep').asstring);
           prodPred.infLocalDesCarrega.CEP := strtoint(FCadCli.getcep(codigocliente));

        end;


   end;

   end;  // with acbrmdfe1.manifestos.....

   if Acbrmdfe1.Manifestos.Count>0 then begin

     Sistema.BeginProcess('Enviando manifesto '+inttostr(NumeroMdfe));
 // confirmar q foi autorizado o mdfe dai salvar o xml, data autorizacao,
 // chave do mdfe
     LoteMdfe      := FGeral.GetContador('LOTEMDFE'+Unidade,false,true);


     ACBrMDFe1.Enviar( LoteMdfe  );

     Sistema.EndProcess('Retorno Receita :'+ACBrMDFe1.WebServices.Retorno.xMotivo+
                        ' Aviso '+ACBrMDFe1.WebServices.Retorno.Msg);

//     xmlstring:=ACBrMDFe1.Manifestos.Items[0].XMLAssinado;
     xmlstring:=ACBrMDFe1.Manifestos.Items[0].XML;
     xmlstring:=FGeral.TiraBarra(xmlstring,chr(39),'"');
//     xmlstring:=QuotedStr(xmlstring);

     Sistema.Edit('movcargas');
     if Ansipos('AUTORIZADO O USO',Uppercase(ACBrMDFe1.WebServices.Retorno.xMotivo) ) > 0  then  // checar no xmotivo se foi autorizado

        Sistema.SetField('movc_dtauto',Sistema.Hoje);
//     Sistema.SetField('movc_xmlmdfe',ACBrMDFe1.Manifestos.Items[0].XMLAssinado);
     Sistema.SetField('movc_xmlmdfe',xmlstring);
     Sistema.SetField('movc_protocolo',ACBrMDFe1.WebServices.Retorno.Protocolo);
     Sistema.SetField('movc_recibo',ACBrMDFe1.WebServices.Retorno.Recibo);
     Sistema.Post('movc_status = ''N'' and movc_unid_codigo = '+Stringtosql( unidade )+
                  ' and movc_numero = '+EdCarga.AsSql );
     try
       Sistema.Commit;
     except on E:exception do
       Avisoerro( E.Message );
     end;

 // ver novos campos na tabela movcargas para guardar o xml do manifesto, data da autorizacao,
//   numero do protocolo, do recibo , o retorno e a msg e data do encerramento
//   e ver se xml do encerramento e ver protocolo do encerramento
// se autorizou pula um no numero do mdfe
      NumeroMdfe          := FGeral.GetContador('MDFE'+Unidade,false,true);

   end else Aviso('Manifesto n�o gerado');

end;

procedure TFPesagemporCarga.bpesapedidoClick(Sender: TObject);
//////////////////////////////////////////////////////////////
begin

  nropedido       := StrtoIntdef( Grid.Cells[Grid.GetColumn('moes_numerodoc'),Grid.Row],0 );
  xdatapedido     := TextToDate( FGeral.TiraBarra( Grid.Cells[Grid.GetColumn('moes_dataemissao'),Grid.Row] ) );

// 15.05.20
  if EdKm.AsInteger > 0 then EdKm.Valid;

  if nropedido>0 then

     FPesagemSaida.Execute('C',nropedido,Edtran_codigo.Text,EdMoes_cola_codigo01.Text);



end;

procedure TFPesagemporCarga.bSairClick(Sender: TObject);
begin
   Close;
end;

// 16.07.20
procedure TFPesagemporCarga.CargaCTetoGrid(xQ:Tsqlquery);
/////////////////////////////////////////////////////////
var p:integer;

      function GetNota( xpedido:integer ):string;
      //////////////////////////////////////////
      var Qy:TSqlquery;
      begin

         Qy:=sqltoquery('select moes_numerodoc from movesto where moes_pedido = '+inttostr(xpedido)+
                        ' and moes_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                        ' and moes_status = ''N'''+
                        ' and ( (moes_chavenfe <>'''')  or  (moes_chavenfe is not null) )'+
                        ' and moes_tipo_codigo = '+xQ.FieldByName('mped_tipo_codigo').AsString );
         if not Qy.Eof then result:=Qy.FieldByName('moes_numerodoc').AsString else result:='';
         FGeral.FechaQuery(Qy);

      end;


begin

  if not xQ.eof then begin

     Sistema.Edit('movcargas');
     Sistema.SetField('movc_cola_codigo01',EdMoes_cola_codigo01.Text);
     Sistema.SetField('movc_cola_codigo02',EdMoes_cola_codigo02.Text);
     Sistema.SetField('movc_km',EdKm.AsCurrency);
     Sistema.Post('movc_status = ''N'''+
                 ' and movc_datamvto >= '+DAtetosql(Sistema.Hoje-1)+
                 ' and movc_unid_codigo = '+Stringtosql(Unidade)+
                 ' and movc_numero = '+EdCarga.AsSql );
     Sistema.Commit;

  end;

  Grid.Clear;
  p:=1;

  while not xQ.Eof do begin

    Grid.Cells[Grid.GetColumn('moes_numerodoc'),p]:=xQ.FieldByName('moes_numerodoc').AsString;
    Grid.Cells[Grid.GetColumn('moes_dataemissao'),p]:=FGeral.FormataData( xQ.fieldbyname('moes_datamvto').asdatetime );
    Grid.Cells[Grid.GetColumn('moes_vlrtotal'),p]:=xQ.FieldByName('moes_vlrtotal').AsString;
    Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),p]:=xQ.FieldByName('moes_tipo_codigo').AsString;
    Grid.Cells[Grid.GetColumn('clie_razaosocial'),p]:=FCadCli.GetNome( xQ.FieldByName('moes_tipo_codigo').AsInteger ) ;
    Grid.Cells[Grid.GetColumn('cidade'),p]:=FCadcli.GetCidade( xQ.FieldByName('moes_tipo_codigo').AsInteger );
//    Grid.Cells[Grid.GetColumn('numeronfe'),p]:=GetNota( xQ.FieldByName('mped_numerodoc').AsInteger );
//    Grid.Cells[Grid.GetColumn('numeronfe'),p]:=xQ.FieldByName('mped_nfvenda').AsString ;
    Grid.Cells[Grid.GetColumn('transacao'),p]:=xQ.FieldByName('moes_transacao').AsString ;
    Grid.Cells[Grid.GetColumn('pesopedido'),p]:=Floattostr( xQ.FieldByName('moes_pesoliq').AsCurrency);
// 22.05.20
    EdPesocarga.SetValue( EdPesocarga.AsCurrency+Texttovalor(Grid.Cells[Grid.GetColumn('pesopedido'),p]) ) ;
    inc(p);
    Grid.AppendRow;
    xQ.Next;

  end;
  FGeral.FechaQuery(xQ);

end;

procedure TFPesagemporCarga.CargatoGrid(xQ: Tsqlquery);
//////////////////////////////////////////////////////
var p:integer;


      function GetNota( xpedido:integer ):string;
      //////////////////////////////////////////
      var Qy:TSqlquery;
      begin

         Qy:=sqltoquery('select moes_numerodoc from movesto where moes_pedido = '+inttostr(xpedido)+
                        ' and moes_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                        ' and moes_status = ''N'''+
                        ' and ( (moes_chavenfe <>'''')  or  (moes_chavenfe is not null) )'+
                        ' and moes_tipo_codigo = '+xQ.FieldByName('mped_tipo_codigo').AsString );
         if not Qy.Eof then result:=Qy.FieldByName('moes_numerodoc').AsString else result:='';
         FGeral.FechaQuery(Qy);

      end;


begin

  Grid.Clear;
  p:=1;
  if EdKM.AsCurrency>0 then begin

     Sistema.Edit('movcargas');
     Sistema.SetField('movc_cola_codigo01',EdMoes_cola_codigo01.Text);
     Sistema.SetField('movc_cola_codigo02',EdMoes_cola_codigo02.Text);
     Sistema.SetField('movc_km',EdKm.AsCurrency);
     Sistema.Post('movc_status = ''N'''+
                 ' and movc_datamvto >= '+DAtetosql(Sistema.Hoje-1)+
                 ' and movc_unid_codigo = '+Stringtosql(Unidade)+
                 ' and movc_numero = '+EdCarga.AsSql );
     Sistema.Commit;

  end;
  EdPesocarga.SetValue(0);

  while not xQ.Eof do begin

    Grid.Cells[Grid.GetColumn('moes_numerodoc'),p]:=xQ.FieldByName('mped_numerodoc').AsString;
    Grid.Cells[Grid.GetColumn('moes_dataemissao'),p]:=FGeral.FormataData( xQ.fieldbyname('mped_datamvto').asdatetime );
    Grid.Cells[Grid.GetColumn('moes_vlrtotal'),p]:=xQ.FieldByName('mped_vlrtotal').AsString;
    Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),p]:=xQ.FieldByName('mped_tipo_codigo').AsString;
    Grid.Cells[Grid.GetColumn('clie_razaosocial'),p]:=FCadCli.GetNome( xQ.FieldByName('mped_tipo_codigo').AsInteger ) ;
    Grid.Cells[Grid.GetColumn('cidade'),p]:=FCadcli.GetCidade( xQ.FieldByName('mped_tipo_codigo').AsInteger );
//    Grid.Cells[Grid.GetColumn('numeronfe'),p]:=GetNota( xQ.FieldByName('mped_numerodoc').AsInteger );
    Grid.Cells[Grid.GetColumn('numeronfe'),p]:=xQ.FieldByName('mped_nfvenda').AsString ;
    Grid.Cells[Grid.GetColumn('transacao'),p]:=xQ.FieldByName('mped_transacao').AsString ;
    Grid.Cells[Grid.GetColumn('pesopedido'),p]:=Floattostr( GetPeso( xQ.FieldByName('mped_numerodoc').AsInteger,xQ.fieldbyname('mped_datamvto').asdatetime ) );
// 22.05.20
    EdPesocarga.SetValue( EdPesocarga.AsCurrency+Texttovalor(Grid.Cells[Grid.GetColumn('pesopedido'),p]) ) ;
    inc(p);
    Grid.AppendRow;
    xQ.Next;

  end;
  FGeral.FechaQuery(xQ);

end;

function TFPesagemporCarga.ChecagemdePeso: boolean;
///////////////////////////////////////////////////
var dif,tolerancia:currency;
begin
   dif:=abs(EdDif.ascurrency-GetPesoPedidos );
   tolerancia:=0;
   if (dif > tolerancia) and (tolerancia>0) then begin
     Avisoerro('Diferen�a de Peso acima do permitido');
     result:=false;
     exit;
   end else result:=true;

end;

procedure TFPesagemporCarga.ConfiguraTeclas(Key: Word);
////////////////////////////////////////////////////////////
begin

 if key = vk_f4 then begin

     bpesapedidoClick(self)
// else if (key = vk_f5) then bgeranfesClick(self)

 end else if key = vk_f2 then bmanifestoclick(self)

 else if key = vk_f3 then bimpmdfeClick(self)

 else if key = vk_f6 then Close;

end;

procedure TFPesagemporCarga.EdCargaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   ConfiguraTeclas(key);

end;

procedure TFPesagemporCarga.EdCargaValidate(Sender: TObject);
//////////////////////////////////////////////////////////////
var Q,
    QPedidos :TSqlquery;

begin

  Q:=sqltoquery('select * from movcargas where movc_status = ''N'''+
//                ' and movc_datamvto >= '+DAtetosql(Sistema.Hoje-1)+
//                ' and movc_datamvto <= '+EdTermino.AsSql+
                ' and movc_unid_codigo = '+Stringtosql(Unidade)+
                ' and movc_numero = '+EdCarga.AsSql );
//                ' and movc_tran_codigo = '+EdTran_codigo.AsSql );

  if Q.eof then EdCarga.invalid('Carga n�o encontrada')
  else begin

    EdTran_codigo.Text    :=Q.FieldByName('movc_tran_codigo').AsString;
    EdMoes_cola_codigo01.text:=Q.FieldByName('movc_cola_codigo01').asstring;
    EdMoes_cola_codigo02.text:=Q.FieldByName('movc_cola_codigo02').asstring;
    EdKm.SetValue( Q.FieldByName('movc_km').asinteger );
    EdTran_codigo.ValidFind;
    EdMOes_cola_codigo01.ValidFind;
    EdMOes_cola_codigo02.ValidFind;
    EdDataCarga.setdate( Q.FieldByName('movc_datamvto').AsDateTime );
// 22.05.19
        QPedidos:=Sqltoquery('select * from movped where mped_unid_codigo = '+Stringtosql(Unidade)+
                      ' and mped_status = ''N'''+
//                      ' and mped_datamvto >= '+Datetosql(Sistema.Hoje)+
// 23.05.19
//                      ' and mped_datamvto >= '+Datetosql(Q.FieldByName('movc_datamvto').AsDateTime )+
// 14.08.19
                      ' and mped_datamvto >= '+Datetosql(Q.FieldByName('movc_datamvto').AsDateTime-3 )+
                      ' and mped_nftrans = '+EdCarga.assql );
        CargatoGrid(QPedidos);
        Grid.Setfocus;
        QPedidos.Close;

  end;


end;

procedure TFPesagemporCarga.EdkmChange(Sender: TObject);
begin

end;

// 28.04.20
procedure TFPesagemporCarga.EdkmValidate(Sender: TObject);
////////////////////////////////////////////////////////////
begin

//   if ( EdMoes_cola_codigo01.text <> EdMoes_cola_codigo01.oldvalue )
//      or
//      ( EdMoes_cola_codigo02.text <> EdMoes_cola_codigo01.oldvalue )
//      then begin
// sempre grava 'tudo' devido ao KM...
// 20.11.20 - pra ver se para de 'n�o gravar' o km'
      if EdKm.asinteger > 0 then begin

         Sistema.Edit('movcargas');
         Sistema.SetField('movc_cola_codigo01',EdMoes_cola_codigo01.Text);
         Sistema.SetField('movc_cola_codigo02',EdMoes_cola_codigo02.Text);
         Sistema.SetField('movc_km',EdKM.AsInteger);
         Sistema.SetField('movc_tran_codigo',EdTran_codigo.Text);
         Sistema.Post('movc_status = ''N'' and movc_unid_codigo = '+Stringtosql( unidade )+
                      ' and movc_numero = '+EdCarga.AsSql );
         Sistema.Commit;

      end;

//      end;
end;

// 24.04.18
procedure TFPesagemporCarga.EdMoes_cola_codigo02ExitEdit(Sender: TObject);
///////////////////////////////////////////////////////////////////////////
var QPedidos:TSqlquery;

begin

    if tipomdfe = 'NFE' then begin

        QPedidos:=Sqltoquery('select * from movped where mped_unid_codigo = '+Stringtosql(Unidade)+
                      ' and mped_status = ''N'''+
                      ' and mped_datamvto >= '+EdInicio.assql+
                      ' and mped_nftrans = '+EdCarga.assql );
        CargatoGrid(QPedidos);
        Grid.Setfocus;

    end else begin

        QPedidos:=Sqltoquery('select * from movesto where moes_unid_codigo = '+Stringtosql(Unidade)+
                      ' and moes_status = ''N'''+
                      ' and moes_datamvto >= '+EdInicio.assql+
                      ' and moes_carga    = '+EdCarga.assql );
        CargaCTetoGrid(QPedidos);
        Grid.Setfocus;

    end;


end;

procedure TFPesagemporCarga.EdMoes_cola_codigo02KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

      ConfiguraTeclas( key);

end;

procedure TFPesagemporCarga.EdTran_codigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   ConfiguraTeclas(key);

end;

procedure TFPesagemporCarga.EdTran_codigoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////////////
begin

{
   if EdTran_codigo.OldValue<>EdTran_codigo.Text then begin

      if confirma('Trocar o ve�culo/placa desta carga ?') then begin

         Sistema.Edit('movcargas');
         Sistema.SetField('movc_tran_codigo',EdTran_codigo.Text);
         Sistema.Post('movc_status = ''N'' and movc_unid_codigo = '+Stringtosql( unidade )+
                      ' and movc_numero = '+EdCarga.AsSql );
         Sistema.Commit;

      end;

   end;
   }
//   EdMoes_cola_codigo01.text:=EdTran_codigo.ResultFind.FieldByName('tran_cola_codigo').AsString;
   EdDif.SetValue( GetPesoCaminhao( EdTran_codigo.ResultFind.FieldByName('tran_codigo').AsString) );
// 28.04.20
   if EdKM.AsInteger=0 then

      EdKm.SetValue( GetUltimaKM(EdTran_codigo.Text) );

end;

// 17.04.18
procedure TFPesagemporCarga.Execute(tipo:string='NFE');
////////////////////////////////////////////////////////////
begin

// 16.07.20
    tipomdfe := tipo;

    EdCarga.ClearAll(Self,0);
    Grid.Clear;
    EdInicio.SetDate(Sistema.hoje-10);

    if (Global.Usuario.Codigo=100) or (Global.Usuario.Codigo=101) then
      EdInicio.SetDate(Sistema.hoje-32);

    EdTermino.setdate(sistema.hoje);
    unidade:=Global.CodigoUnidade;

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
// 30.01.2021
    AcbrMdfe1.Configuracoes.WebServices.UF := Global.UFUnidade;

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


//    FGeral.ConfiguraRespTecnicoAcbrNfe( infRespTec );
{
   xINfResptec.CNPJ    := '07244930000130';
   xInfResptec.xContato:= 'Andre Luis Storolli';
   xInfRespTec.email   := 'slstorolli@uol.com.br';
   xInfRespTec.fone    := '4632258052';
}

    if tipomdfe = 'CTE' then begin

//       EdMoes_cola_codigo01.empty := true;
       EdKM.enabled := false;
    end else begin

//       EdMoes_cola_codigo01.empty := False;
       EdKM.enabled := true;

    end;

    xdataPedido := 0;
    Show;
    FGeral.ConfiguraColorEditsNaoEnabled(Self);
    Sistema.BeginProcess('Verificando cargas');
    SetaCargas(EdTran_codigo.Text,EdCarga);
    Sistema.endProcess('');
    Edcarga.SetFocus;

end;

procedure TFPesagemporCarga.FormActivate(Sender: TObject);
/////////////////////////////////////////////////////////////////
var xpeso,
    xpesototal :currency;
    p          :integer;

begin

// 13.05.20 - Atualiza peso do pedido na carga
     if (not Fpesagemsaida.Visible) and ( not EdCarga.IsEmpty) and (nropedido>0) then begin
           xpeso := GetPeso( nropedido , xDataPedido ) ;

       if xpeso > 0  then Grid.cells[Grid.getcolumn('pesopedido'),Grid.Row]:=currtostr(xpeso);

       xpesototal := 0;
       for p:=0 to Grid.rowcount-1 do begin

         if Strtointdef(Grid.cells[Grid.getcolumn('pesopedido'),p],0)>0 then

            xpesototal := xpesototal + TextTovalor( Grid.cells[Grid.getcolumn('pesopedido'),Grid.Row] );

       end;

       if xpesototal > 0 then begin

          Sistema.Edit('movcargas');
          Sistema.SetField('movc_pesopedidos',xpesototal);
          Sistema.Post('movc_status = ''N'' and movc_unid_codigo = '+Stringtosql( unidade )+
                       ' and movc_numero = '+EdCarga.AsSql );
          Sistema.Commit;

       end;

       //        else Avisoerro('Carga com peso zerado.  N�O atualizado');

     end;

end;

procedure TFPesagemporCarga.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   ConfiguraTeclas(key);

end;

function TFPesagemporCarga.GetPeso(xpedido: integer;  xdata: TDatetime): currency;
//////////////////////////////////////////////////////////////////////////////////////
      var Qy:TSqlquery;
          xp   :currency;
      begin

         Qy:=sqltoquery('select movd_pesocarcaca from movabatedet where movd_status = ''N'''+
                         ' and movd_tipomov = '+Stringtosql('SA')+
                         ' and movd_numerodoc = '+inttostr(xpedido)+
                         ' and movd_datamvto >= '+Datetosql(xdata)+
                         ' and movd_unid_codigo = '+Stringtosql(unidade) );
         xp:=0;
         while not Qy.Eof do begin

            xp:=xp + Qy.FieldByName('movd_pesocarcaca').Ascurrency;
            QY.Next;

         end;

         FGeral.FechaQuery(Qy);
         result:=xp;

end;

function TFPesagemporCarga.GetPesoCaminhao(xcodigo: string): currency;
///////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    difpeso:currency;
begin

  Q:=sqltoquery('select movc_numero,movc_datamvto,movc_pesoi,movc_pesof from movcargas where movc_status = ''N'''+
                ' and movc_datamvto >= '+EdInicio.AsSql+
                ' and movc_datamvto <= '+EdTermino.AsSql+
                ' and movc_tran_codigo = '+EdTran_codigo.AsSql+
                ' and movc_unid_codigo = '+Stringtosql(Unidade) );
  difpeso:=0;
  if not Q.Eof then begin
     difpeso:=Abs( Q.FieldByName('movc_pesof').AsCurrency-Q.FieldByName('movc_pesoi').AsCurrency );
  end;
  Q.Close;
  result:=difpeso;

end;


// 10.09.18
function TFPesagemporCarga.GetPesoPedidos: currency;
////////////////////////////////////////////////////////
var p   :integer;
    xpeso,
    pesoitem,
    pesopedido  : currency;
    sqltipomov,
    sqldata,
    Tipomov     :string;
    QSaida      :TSqlquery;

begin

   Tipomov:='SA';
   xpeso:=0;

   for p:=0 to Grid.rowcount-1 do begin

     if Strtointdef(Grid.cells[Grid.getcolumn('moes_numerodoc'),p],0)>0 then begin

//       sqldata:=' and mova_dtabate >= '+Datetosql( Sistema.Hoje-1 );
       sqldata:=' and movd_datamvto >= '+Datetosql( Sistema.Hoje-1 );
       Sqltipomov:=' and movd_tipomov='+Stringtosql( Tipomov );
       QSaida:=sqltoquery('select movd_pesocarcaca from movabatedet inner join movabate on ( mova_transacao=movd_transacao and mova_tipomov=movd_tipomov )'+
                          ' where movd_numerodoc='+Grid.cells[Grid.getcolumn('moes_numerodoc'),p]+
                          ' and '+FGeral.Getin('movd_unid_codigo',Unidade,'C')+
                          ' and movd_status=''N'''+
                          ' and mova_tipomov='+Stringtosql( Tipomov )+
                          sqldata+sqltipomov+
                          ' order by movd_ordem' );
       pesopedido:=0;
       while not QSaida.eof do begin

         pesoitem:=QSaida.FieldByName('movd_pesocarcaca').AsCurrency;
         xpeso:=xpeso + pesoitem;
         pesopedido:=pesopedido + pesoitem;
         QSaida.Next;

       end;
//       if PesoPedido=0 then Avisoerro('Pedido '+Grid.cells[Grid.getcolumn('moes_numerodoc'),p]+' com peso zerado');
       FGeral.FechaQuery(QSaida);

     end;

   end;
   result:=xpeso;

end;

// 28.04.20
function TFPesagemporCarga.GetUltimaKM(xTran_codigo: string): integer;
////////////////////////////////////////////////////////////////////////
var Qx : TSqlquery;
begin

  Qx:=sqltoquery('select movc_km from movcargas where movc_status = ''N'''+
                ' and movc_datamvto >= '+DAtetosql(Sistema.Hoje-30)+
                ' and movc_unid_codigo = '+Stringtosql(Unidade)+
                ' and movc_tran_codigo = '+stringtosql( xtran_codigo )+
                ' and movc_numero <> '+EdCarga.AsSql+
                ' order by movc_datamvto desc' );

  if not Qx.Eof then result := Qx.FieldByName('movc_km').AsInteger
  else result :=0 ;
  FGeral.FechaQuery(Qx);

end;

procedure TFPesagemporCarga.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

    ConfiguraTeclas( key);


end;

// 17.04.18
procedure TFPesagemporCarga.SetaCargas(tran_codigo: string; Ed: TSqlEd);
/////////////////////////////////////////////////////////////////////////
var Q,Q1:TSqlquery;
    sqltran:string;

begin

  Ed.Items.Clear;
  if trim(tran_codigo)<> '' then
    sqltran:=' and movc_tran_codigo = '+EdTran_codigo.AsSql
  else
    sqltran:='';

  Q:=sqltoquery('select movc_numero,movc_datamvto from movcargas where movc_status = ''N'''+
                ' and movc_datamvto >= '+EdInicio.AsSql+
                ' and movc_datamvto <= '+EdTermino.AsSql+
                ' and movc_unid_codigo = '+Stringtosql(Unidade)+
                sqltran+
                ' order by movc_datamvto desc' );
  while not Q.eof do begin

    Q1:=sqltoquery('select mped_numerodoc from movped where mped_nftrans = '+Q.FieldByName('movc_numero').AsString+
                   ' and mped_unid_codigo = '+Stringtosql(Unidade));
    if not Q1.eof then
      Ed.items.add( strzero(Q.fieldbyname('movc_numero').asinteger,6) + '|' + FGeral.FormataData(Q.fieldbyname('movc_datamvto').asdatetime) );
    FGeral.Fechaquery(Q1);
    Q.Next;
  end;
  FGeral.Fechaquery(Q);

end;

end.

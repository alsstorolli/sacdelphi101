// 26.01.13
// Importa xmls do CTe para saidas
//

unit ImportaCte;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel,
  SQLGrid, ExtCtrls, ACBrCTe, FileCtrl, SqlExpr, SqlFun, PCNConversao,
  ACBrBase, ACBrDFe;

type
  TFImportaXmlsCte = class(TForm)
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
    OpenDialog1: TOpenDialog;
    SQLPanelGrid1: TSQLPanelGrid;
    ListaArq: TFileListBox;
    ACBrCTe1: TACBrCTe;
    procedure bExecutarClick(Sender: TObject);
    procedure EdUnid_codigoExitEdit(Sender: TObject);
    procedure OpenDialog1Close(Sender: TObject);
    procedure EdterminoValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure   ImportaCtes;
    procedure   ImportaCte( Arquivo : string );
    procedure   GravaCtes;
    procedure Execute;

  end;

var
  FImportaXmlsCte: TFImportaXmlsCte;

implementation

uses Geral,SqlSis, Estoque, pcteCTe, expnfetxt, ACBrCTeConhecimentos,
  cadcli, munic, pcteEventoCTe;

{$R *.dfm}

procedure TFImportaXmlsCte.bExecutarClick(Sender: TObject);
////////////////////////////////////////////////////////////
begin
  if EdUnid_codigo.isempty then exit;
  Texto.Lines.Clear;
  Texto.Font.Size:=10;
  Texto.Lines.Add('Verificando pasta dos arquivos Xmls...');
  if not OpenDialog1.Execute then exit;
  Texto.Lines.Add('Armazenando arquivos Xmls...');
  ListaArq.Directory:=ExtractFilePath( Opendialog1.FileName );
  ImportaCtes;
  GravaCtes
  ;
end;

procedure TFImportaXmlsCte.Execute;
////////////////////////////////////
begin
  Show;
  Edinicio.setfocus;
end;

procedure TFImportaXmlsCte.GravaCtes;
//////////////////////////////////////////
var p,codigomov:integer;
    transacao,produtofrete:string;
    Q,QT,QF,QMuni:TSqlquery;
    DataCanc:TDatetime;
    achou:boolean;

    function GetCodigoMunicipio(xcodigoibge:string):integer;
    //////////////////////////////////////////////////////////
    begin
      QMuni:=Sqltoquery('select * from cidades where cida_codigoibge='+Stringtosql(xcodigoibge));
      result:=QMuni.fieldbyname('cida_codigo').asinteger;
    end;

    procedure IncluiCidadeDestinatario(xcodigoibge:string);
    /////////////////////////////////////////////////////////
    begin
        Q:=sqltoquery('select * from cidades where cida_codigo='+Stringtosql(xcodigoibge));
        if Q.eof then begin
          with AcbrCte1.Conhecimentos.Items[p].CTe.Dest.enderDest do begin
            Sistema.Insert('cidades');
            Sistema.SetField('cida_codigo',FGeral.getsequencial(1,'cida_codigo','N','cidades'));
            Sistema.SetField('cida_nome',xMun);
            Sistema.SetField('cida_uf',UF);
            Sistema.SetField('cida_regi_codigo','001');
            Sistema.SetField('cida_cep',inttostr(CEP));
            Sistema.SetField('cida_codigoibge',xcodigoibge);
            Sistema.SetField('cida_codigopais',cPais );
            Sistema.SetField('cida_nomepais', xPais);
            Sistema.post;
            Sistema.commit;
          end;
        end;
        Q.Close;
    end;

    procedure IncluiCidadeRemetente(xcodigoibge:string);
    /////////////////////////////////////////////////////////
    begin
        Q:=sqltoquery('select * from cidades where cida_codigo='+Stringtosql(xcodigoibge));
        if Q.eof then begin
          with AcbrCte1.Conhecimentos.Items[p].CTe.Rem.enderReme do begin
            Sistema.Insert('cidades');
            Sistema.SetField('cida_codigo',FGeral.getsequencial(1,'cida_codigo','N','cidades'));
            Sistema.SetField('cida_nome',xMun);
            Sistema.SetField('cida_uf',UF);
            Sistema.SetField('cida_regi_codigo','001');
            Sistema.SetField('cida_cep',inttostr(CEP));
            Sistema.SetField('cida_codigoibge',xcodigoibge);
            Sistema.SetField('cida_codigopais',cPais );
            Sistema.SetField('cida_nomepais', xPais);
            Sistema.post;
            Sistema.commit;
          end;
        end;
        Q.Close;
    end;



    function GetIcms( xcst:TpcnCSTIcms ; s:string ):currency;
    /////////////////////////////////////////////////////////
    begin
      result:=0;
      if s='Valor' then begin
        if xcst=cst00 then result:=ACbrcte1.Conhecimentos.Items[p].CTe.Imp.ICMS.ICMS00.vICMS
        else if xcst=cst20 then result:=ACbrcte1.Conhecimentos.Items[p].CTe.Imp.ICMS.ICMS20.vICMS
//        else if xcst=cst45 then result:=ACbrcte1.Conhecimentos.Items[p].CTe.Imp.ICMS.ICMS45.vICMS;
        else if xcst=cst90 then result:=ACbrcte1.Conhecimentos.Items[p].CTe.Imp.ICMS.ICMS90.vICMS
        else if xcst=cst90 then result:=ACbrcte1.Conhecimentos.Items[p].CTe.Imp.ICMS.ICMSOutraUF.vICMSOutraUF;
      end else if s='Base' then begin
        if xcst=cst00 then result:=ACbrcte1.Conhecimentos.Items[p].CTe.Imp.ICMS.ICMS00.vBC
        else if xcst=cst20 then result:=ACbrcte1.Conhecimentos.Items[p].CTe.Imp.ICMS.ICMS20.vBC
        else if xcst=cst90 then result:=ACbrcte1.Conhecimentos.Items[p].CTe.Imp.ICMS.ICMS90.vBC
        else if xcst=cst90 then result:=ACbrcte1.Conhecimentos.Items[p].CTe.Imp.ICMS.ICMSOutraUF.vBCOutraUF;
      end else begin
        if xcst=cst00 then result:=ACbrcte1.Conhecimentos.Items[p].CTe.Imp.ICMS.ICMS00.pICMS
        else if xcst=cst20 then result:=ACbrcte1.Conhecimentos.Items[p].CTe.Imp.ICMS.ICMS20.pICMS
        else if xcst=cst90 then result:=ACbrcte1.Conhecimentos.Items[p].CTe.Imp.ICMS.ICMS90.pICMS
        else if xcst=cst90 then result:=ACbrcte1.Conhecimentos.Items[p].CTe.Imp.ICMS.ICMSOutraUF.pICMSOutraUF;
      end;
// 12.03.13 - beneficio fiscal de SC somente pra estes cfops
      if ( ( AcbrCte1.Conhecimentos.Items[p].CTe.Ide.CFOP=5932 ) or
         ( AcbrCte1.Conhecimentos.Items[p].CTe.Ide.CFOP=6932 ) ) then
//         ( EdUNid_codigo.resultfind.FieldByName('unid_uf').asstring='SC'  ) then
// 10.01.14 - SM - Leila - matriz no PR tbem tbem este beneficio
        result:=0;
    end;

    procedure GravaMovesto;
    //////////////////////
    var x:integer;
    begin
    Q:=Sqltoquery('select moes_numerodoc,moes_transacao from movesto where moes_numerodoc='+Inttostr(Acbrcte1.Conhecimentos.Items[p].CTe.Ide.nCT)+
                  ' and moes_dataemissao='+Datetosql(Acbrcte1.Conhecimentos.Items[p].CTe.Ide.dhEmi)+
                  ' and moes_unid_codigo='+EdUnid_codigo.AsSql+
                  ' and moes_status='+Stringtosql('N')+
                  ' and moes_tipocad='+Stringtosql('C') );
    if not Q.Eof then begin
      Texto.Lines.Add('Conhecimento já encontrado na transação '+Q.fieldbyname('moes_transacao').asstring+'.  Não importado.');
      exit;
    end;
    FGeral.FechaQuery(Q);
    Q:=Sqltoquery('select * from clientes where Clie_cnpjcpf='+Stringtosql(Acbrcte1.Conhecimentos.Items[p].CTe.Dest.CNPJCPF));
/// Mestre
      Sistema.Insert('Movesto');
      Sistema.SetField('moes_transacao',Transacao);
      Sistema.SetField('moes_operacao',FGeral.GetOperacao);
      Sistema.SetField('moes_status','N');
      Sistema.SetField('moes_numerodoc',Acbrcte1.Conhecimentos.Items[p].CTe.Ide.nCT);
//    Sistema.SetField('moes_romaneio',Romaneio);
      Sistema.SetField('moes_tipomov',Global.CodConhecimentoSaida);
      Sistema.SetField('moes_comv_codigo',Codigomov);
      Sistema.SetField('moes_unid_codigo',EdUnid_codigo.text);
      Sistema.SetField('moes_tipo_codigo',Q.Fieldbyname('Clie_codigo').AsInteger);
// 07.10.13
      if trim(Q.fieldbyname('clie_uf').AsString)<>'' then
        Sistema.SetField('moes_estado',Q.fieldbyname('clie_uf').AsString)
      else if trim( FCadcli.getuf(Q.Fieldbyname('Clie_codigo').AsInteger) )='' then
        Avisoerro('Cliente '+Q.Fieldbyname('Clie_codigo').Asstring+' sem UF Cliente na ABA cadastro!')
      else
        Sistema.SetField('moes_estado',FCadcli.getuf(Q.Fieldbyname('Clie_codigo').AsInteger));
      Sistema.SetField('moes_tipocad','C');
      Sistema.SetField('moes_repr_codigo',1);
      Sistema.SetField('moes_cida_codigo',Q.fieldbyname('clie_cida_codigo_com').AsInteger);
  //    end;
      Sistema.SetField('moes_datalcto',Sistema.Hoje);
      campo:=Sistema.GetDicionario('movesto','moes_datasaida');
      if Campo.Tipo<>'' then begin
        Sistema.SetField('moes_datasaida',AcbrCte1.Conhecimentos.Items[p].CTe.Ide.dhEmi);
        Sistema.SetField('moes_datamvto',AcbrCte1.Conhecimentos.Items[p].CTe.Ide.dhEmi);
      end else
        Sistema.SetField('moes_datamvto',AcbrCte1.Conhecimentos.Items[p].CTe.Ide.dhEmi);
      Sistema.SetField('moes_DataCont',AcbrCte1.Conhecimentos.Items[p].CTe.Ide.dhEmi);
      Sistema.SetField('moes_dataemissao',AcbrCte1.Conhecimentos.Items[p].CTe.Ide.dhEmi);
  //    Sistema.SetField('moes_tabp_codigo',Tabela);
  //    Sistema.SetField('moes_tabaliquota',FTabela.GetAliquota(Tabela));
      Sistema.SetField('moes_natf_codigo',AcbrCte1.Conhecimentos.Items[p].CTe.Ide.CFOP);
  //    Sistema.SetField('moes_freteciffob',NotaFiscal.NotasFiscais.Items[0].NFe.Transp.modFrete);
      Sistema.SetField('moes_valoricms', GetIcms( AcbrCte1.Conhecimentos.Items[p].CTe.Imp.Icms.SituTrib,'Valor' ) );
      Sistema.SetField('moes_basesubstrib',0);
      Sistema.SetField('moes_valoricmssutr',0);
      Sistema.SetField('moes_frete',0);
  //    if IndPagtoStr( NotaFiscal.NotasFiscais.Items[0].NFe.ide.indPag ) = '0'  then
  //      Sistema.SetField('moes_vispra','V')
  //    else
        Sistema.SetField('moes_vispra','P');
      Sistema.SetField('moes_especie','CTE');
      Sistema.SetField('moes_serie',AcbrCte1.Conhecimentos.Items[p].CTe.Ide.serie);
      if not qt.eof then
        Sistema.SetField('moes_tran_codigo',QT.fieldbyname('tran_codigo').asstring)
      else
        Sistema.SetField('moes_tran_codigo','001');
      Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
      Sistema.SetField('Moes_Perdesco',0);
      Sistema.SetField('Moes_Peracres',0);
  //    Sistema.SetField('moes_remessas',remessas);
      Sistema.SetField('moes_mensagem',' ');
  //    Sistema.SetField('moes_pedido',pedido);
       Sistema.SetField('Moes_qtdevolume',0);
       Sistema.SetField('Moes_especievolume',0);
       Sistema.SetField('moes_pesoliq',0);
      Sistema.SetField('moes_pesobru',0);
  //    if NotaFiscal.NotasFiscais.Items[0].NFe.Cobr.Dup.Count>0 then
  //      Sistema.SetField('moes_fpgt_codigo',FCondpagto.GetCodigoCfeParcelas(NotaFiscal.NotasFiscais.Items[0].NFe.Cobr.Dup.Count));
      Sistema.SetField('moes_valoripi',0);
      Sistema.SetField('moes_baseiss',0);
      Sistema.SetField('moes_valorpis',0);
      Sistema.SetField('moes_valorcofins',0);
      Sistema.SetField('moes_valoriss',0);
  //    Sistema.SetField('moes_periss',NotaFiscal.NotasFiscais.Items[0].NFe.Total.ISSQNtot.vBC);
      Sistema.SetField('moes_vlrservicos',0);
  //    campo:=Sistema.GetDicionario('movesto','moes_chavenferef');
  //    if ( Campo.Tipo<>'' ) and ( NotaFiscal.NotasFiscais.Items[0].NFe.Ide.NFref.Count>0 ) then
  //      Sistema.SetField('moes_chavenferef',NotaFiscal.NotasFiscais.Items[0].NFe.Ide.NFref.Items[0].refNFe);

      Sistema.SetField('moes_totprod',AcbrCte1.Conhecimentos.Items[p].CTe.vPrest.vTPrest);
      Sistema.SetField('moes_valortotal',AcbrCte1.Conhecimentos.Items[p].CTe.vPrest.vTPrest);
      Sistema.SetField('moes_vlrtotal',AcbrCte1.Conhecimentos.Items[p].CTe.vPrest.vTPrest);
      Sistema.SetField('moes_baseicms',GetIcms( AcbrCte1.Conhecimentos.Items[p].CTe.Imp.Icms.SituTrib,'Base' ) );
      Sistema.SetField('moes_obs','Importado XML');
      Sistema.setfield('moes_xmlnfet',ACBrCTe1.Conhecimentos.Items[p].XML) ;
      Sistema.setfield('moes_chavenfe',ACBrCTe1.Conhecimentos.Items[p].CTe.procCTe.chCTe);
      Sistema.Post();

// gerando o registro 71 ref. as notas do conhecimento - prever varias notas - aqui NF
      QF:=Sqltoquery('select * from fornecedores where Forn_cnpjcpf='+Stringtosql(Acbrcte1.Conhecimentos.Items[p].CTe.Rem.CNPJCPF));
      if QF.eof then Texto.Lines.ADD('Não encontrado nos fornecedores CNPJ '+Acbrcte1.Conhecimentos.Items[p].CTe.Rem.CNPJCPF+' Conhecimento '+inttostr(Acbrcte1.Conhecimentos.Items[p].CTe.Ide.nCT) );
//      for x:=0 to  Acbrcte1.Conhecimentos.Items[p].CTe.Rem.infNF.Count-1 do begin
      for x:=0 to  Acbrcte1.Conhecimentos.Items[p].CTe.infCTeNorm.infDoc.infNF.Count -1 do begin
        Sistema.Insert('Movesto');
        Sistema.SetField('moes_transacao',Transacao);
        Sistema.SetField('moes_operacao',FGeral.GetOperacao);
        Sistema.SetField('moes_status','M');
//        Sistema.SetField('moes_numerodoc',strtoint(Acbrcte1.Conhecimentos.Items[p].CTe.Rem.infNF.Items[x].nDoc));
        Sistema.SetField('moes_numerodoc',strtoint(Acbrcte1.Conhecimentos.Items[p].CTe.infCTeNorm.infDoc.infNF.Items[x].nDoc));
    //    Sistema.SetField('moes_romaneio',Romaneio);
        Sistema.SetField('moes_tipomov',Global.CodConhecimentoSaida);
        Sistema.SetField('moes_comv_codigo',Codigomov);
        Sistema.SetField('moes_unid_codigo',EdUnid_codigo.text);
        Sistema.SetField('moes_tipo_codigo',QF.Fieldbyname('Forn_codigo').AsInteger);
        Sistema.SetField('moes_estado',Acbrcte1.Conhecimentos.Items[p].CTe.Rem.enderReme.UF);
        Sistema.SetField('moes_tipocad','F');
        Sistema.SetField('moes_repr_codigo',1);
        Sistema.SetField('moes_cida_codigo',QF.fieldbyname('Forn_cida_codigo').AsInteger);
    //    end;
        Sistema.SetField('moes_datalcto',Sistema.Hoje);
        campo:=Sistema.GetDicionario('movesto','moes_datasaida');
        if Campo.Tipo<>'' then begin
//          Sistema.SetField('moes_datasaida',AcbrCte1.Conhecimentos.Items[p].CTe.REm.infNF.Items[x].dEmi);
          Sistema.SetField('moes_datasaida',AcbrCte1.Conhecimentos.Items[p].CTe.infCTeNorm.infDoc.infNF.Items[x].dEmi);
          Sistema.SetField('moes_datamvto',AcbrCte1.Conhecimentos.Items[p].CTe.Ide.dhEmi);
        end else
          Sistema.SetField('moes_datamvto',AcbrCte1.Conhecimentos.Items[p].CTe.Ide.dhEmi);
        Sistema.SetField('moes_DataCont',AcbrCte1.Conhecimentos.Items[p].CTe.Ide.dhEmi);
        Sistema.SetField('moes_dataemissao',AcbrCte1.Conhecimentos.Items[p].CTe.infCTeNorm.infDoc.infNF.Items[x].dEmi);
    //    Sistema.SetField('moes_tabp_codigo',Tabela);
    //    Sistema.SetField('moes_tabaliquota',FTabela.GetAliquota(Tabela));
//        Sistema.SetField('moes_natf_codigo',inttostr(AcbrCte1.Conhecimentos.Items[p].CTe.REm.infNF.Items[x].nCFOP) );
//        Sistema.SetField('moes_natf_codigo',inttostr(AcbrCte1.Conhecimentos.Items[p].CTe.REm.infNF.Items[x].nCFOP) );
        Sistema.SetField('moes_natf_codigo',inttostr(AcbrCte1.Conhecimentos.Items[p].CTe.infCTeNorm.infDoc.infNF.Items[x].nCFOP) );
    //    Sistema.SetField('moes_freteciffob',NotaFiscal.NotasFiscais.Items[0].NFe.Transp.modFrete);
//        Sistema.SetField('moes_valoricms', AcbrCte1.Conhecimentos.Items[p].CTe.Rem.infNF.Items[x].vICMS );
//        Sistema.SetField('moes_basesubstrib',AcbrCte1.Conhecimentos.Items[p].CTe.Rem.infNF.Items[x].vBCST );
//        Sistema.SetField('moes_valoricmssutr',AcbrCte1.Conhecimentos.Items[p].CTe.Rem.infNF.Items[x].vST);
        Sistema.SetField('moes_valoricms', AcbrCte1.Conhecimentos.Items[p].CTe.infCTeNorm.infDoc.infNF.Items[x].vICMS );
        Sistema.SetField('moes_basesubstrib',AcbrCte1.Conhecimentos.Items[p].CTe.infCTeNorm.infDoc.infNF.Items[x].vBCST );
        Sistema.SetField('moes_valoricmssutr',AcbrCte1.Conhecimentos.Items[p].CTe.infCTeNorm.infDoc.infNF.Items[x].vST);
        Sistema.SetField('moes_frete',0);
    //    if IndPagtoStr( NotaFiscal.NotasFiscais.Items[0].NFe.ide.indPag ) = '0'  then
    //      Sistema.SetField('moes_vispra','V')
    //    else
          Sistema.SetField('moes_vispra','P');


//        if AcbrCte1.Conhecimentos.Items[p].CTe.Rem.infNF.Items[x].modelo<>0 then
//          Sistema.SetField('moes_especie','NFE' )
//        else
          Sistema.SetField('moes_especie','NF' );
//        Sistema.SetField('moes_serie',AcbrCte1.Conhecimentos.Items[p].CTe.Rem.infNF.Items[x].serie);
        Sistema.SetField('moes_serie',AcbrCte1.Conhecimentos.Items[p].CTe.infCTeNorm.infDoc.infNF.Items[x].serie);
        if not qt.eof then
          Sistema.SetField('moes_tran_codigo',QT.fieldbyname('tran_codigo').asstring)
        else
          Sistema.SetField('moes_tran_codigo','001');
        Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
        Sistema.SetField('Moes_Perdesco',0);
        Sistema.SetField('Moes_Peracres',0);
    //    Sistema.SetField('moes_remessas',remessas);
        Sistema.SetField('moes_mensagem',' ');
    //    Sistema.SetField('moes_pedido',pedido);
         Sistema.SetField('Moes_qtdevolume',0);
         Sistema.SetField('Moes_especievolume',0);
         Sistema.SetField('moes_pesoliq',0);
        Sistema.SetField('moes_pesobru',0);
    //    if NotaFiscal.NotasFiscais.Items[0].NFe.Cobr.Dup.Count>0 then
    //      Sistema.SetField('moes_fpgt_codigo',FCondpagto.GetCodigoCfeParcelas(NotaFiscal.NotasFiscais.Items[0].NFe.Cobr.Dup.Count));
        Sistema.SetField('moes_valoripi',0);
        Sistema.SetField('moes_baseiss',0);
        Sistema.SetField('moes_valorpis',0);
        Sistema.SetField('moes_valorcofins',0);
        Sistema.SetField('moes_valoriss',0);
    //    Sistema.SetField('moes_periss',NotaFiscal.NotasFiscais.Items[0].NFe.Total.ISSQNtot.vBC);
        Sistema.SetField('moes_vlrservicos',0);
    //    campo:=Sistema.GetDicionario('movesto','moes_chavenferef');
    //    if ( Campo.Tipo<>'' ) and ( NotaFiscal.NotasFiscais.Items[0].NFe.Ide.NFref.Count>0 ) then
    //      Sistema.SetField('moes_chavenferef',NotaFiscal.NotasFiscais.Items[0].NFe.Ide.NFref.Items[0].refNFe);
        {
        Sistema.SetField('moes_totprod',AcbrCte1.Conhecimentos.Items[p].CTe.Rem.infNF.Items[x].vProd);
        Sistema.SetField('moes_valortotal',AcbrCte1.Conhecimentos.Items[p].Cte.Rem.infNF.Items[x].vNF);
        Sistema.SetField('moes_vlrtotal',AcbrCte1.Conhecimentos.Items[p].Cte.Rem.infNF.Items[x].vNF);
        Sistema.SetField('moes_baseicms',AcbrCte1.Conhecimentos.Items[p].Cte.Rem.infNF.Items[x].vBC);
        }
        Sistema.SetField('moes_totprod',AcbrCte1.Conhecimentos.Items[p].CTe.infCTeNorm.infDoc.infNF.Items[x].vProd);
        Sistema.SetField('moes_valortotal',AcbrCte1.Conhecimentos.Items[p].Cte.infCTeNorm.infDoc.infNF.Items[x].vNF);
        Sistema.SetField('moes_vlrtotal',AcbrCte1.Conhecimentos.Items[p].Cte.infCTeNorm.infDoc.infNF.Items[x].vNF);
        Sistema.SetField('moes_baseicms',AcbrCte1.Conhecimentos.Items[p].Cte.infCTeNorm.infDoc.infNF.Items[x].vBC);
        Sistema.SetField('moes_obs','Importado XML');
        Sistema.Post();
      end;  // ref. for x

      Q.close;QF.close;
    end;

  procedure IncluiDestinatario;
  //////////////////////////////
  var sql,cod:string;
      Q:TSqlquery;
      Codigo:integer;
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
//        with Acbrcte1.Conhecimentos.Items[p].CTe do begin
// 08.04.13 - estava emitente e tem que ser destinatário
        with Acbrcte1.Conhecimentos.Items[p].CTe.Dest do begin
          Sistema.Insert('clientes');
          Sistema.SetField('clie_codigo',codigo);
          Sistema.SetField('clie_nome',copy(SpecialCase(xNome),1,40));
          Sistema.SetField('clie_razaosocial',copy(SpecialCase(xNome),1,40));
          if length(trim(CNPJCPF))=11 then
//          Sistema.SetField('clie_tipo',GetTipo(Emit.CNPJCPF));
            Sistema.SetField('clie_tipo','F')
          else
            Sistema.SetField('clie_tipo','J');
          Sistema.SetField('clie_cnpjcpf',CNPJCPF);
          Sistema.SetField('clie_rgie',IE);
          Sistema.SetField('clie_sexo','M');
  ////        Sistema.SetField('clie_uf',PClifor.forn_uf);
          Sistema.SetField('clie_endres',copy(SpecialCase(enderDest.xLgr)+', '+enderDest.nro,1,40));
  //        Sistema.SetField('clie_endrescompl',PClifor.forn_endereco);
          Sistema.SetField('clie_bairrores',SpecialCase(enderDest.xBairro));
          Sistema.SetField('clie_cida_codigo_res',GetCodigoMunicipio( inttostr(enderDest.cMun) ) );
          Sistema.SetField('clie_cepres',inttostr(enderDest.CEP));
          Sistema.SetField('clie_foneres',fone);
//          Sistema.SetField('clie_email',Emit.EnderEmit....);
          Sistema.SetField('clie_endcom',copy(SpecialCase(enderDest.xLgr)+', '+enderDest.nro,1,50));
          Sistema.SetField('clie_bairrocom',SpecialCase(enderDest.xBairro));
          Sistema.SetField('clie_cida_codigo_com',GetCodigoMunicipio( inttostr(enderDest.cMun) ) );
          Sistema.SetField('clie_cepcom',inttostr(enderDest.CEP));
          Sistema.SetField('clie_fonecom',fone);
//          Sistema.SetField('clie_contacontabil',PClifor.forn_contacontabil);
          Sistema.SetField('clie_situacao','N');
          Sistema.SetField('clie_dtcad',Sistema.hoje);
          Sistema.SetField('clie_unid_codigo',Edunid_codigo.text);
          Sistema.SetField('clie_usua_codigo',Global.Usuario.Codigo);
          Sistema.SetField('clie_contribuinte','S');
          if trim(EnderDest.UF)<>'' then
            Sistema.SetField('clie_uf', FCidades.GetUF(GetCodigoMunicipio( inttostr(enderDest.cMun) ) ) )
          else
            Sistema.SetField('clie_uf',EnderDest.UF);
          Sistema.SetField('clie_cidade',SPecialCase(EnderDest.xMun));
          Sistema.SetField('clie_obs','IMPXML CTe '+inttostr(Acbrcte1.Conhecimentos.Items[p].CTe.Ide.nCT) );
  //        Sistema.SetField('clie_caractrib varchar(1)
          Sistema.Post();
          Sistema.Commit;
        end;
  end;


  procedure IncluiRemetente;
  //////////////////////////////
    var Q:TSqlquery;
        ProxCodigo:string;
        Codigo:integer;
    begin
        Codigo:=FGeral.GetProximoCodigoCadastro('Fornecedores','Forn_Codigo');
        with Acbrcte1.Conhecimentos.Items[p].CTe do begin
          Sistema.Insert('fornecedores');
          Sistema.SetField('forn_codigo',codigo);
          Sistema.SetField('forn_nome',copy(SpecialCase(Rem.xFant),1,50));
          Sistema.SetField('forn_razaosocial',copy(SpecialCase(Rem.xNome),1,50));
          Sistema.SetField('forn_cnpjcpf',Rem.CNPJCPF);
          Sistema.SetField('forn_situacao','N');   // 10.02.12 - validapr
          Sistema.SetField('forn_inscricaoestadual',trim(Rem.IE));
          Sistema.SetField('forn_endereco',copy(SpecialCase(Rem.enderReme.xLgr)+', '+Emit.EnderEmit.nro,1,40));
          Sistema.SetField('forn_bairro',SpecialCase(copy(Rem.enderReme.xBairro,1,40)));
          Sistema.SetField('forn_cep',inttostr(Rem.enderReme.CEP));
          Sistema.SetField('forn_cida_codigo',GetCodigoMunicipio( inttostr(Rem.enderReme.cMun) ));
          Sistema.SetField('forn_fone',copy(Rem.fone,1,11));
//          Sistema.SetField('forn_fax',Emit.EnderEmit.forn_fax);
//          Sistema.SetField('forn_email',Pclifor.forn_email);
          Sistema.SetField('forn_percfunrural',0);
//          Sistema.SetField('forn_contacontabil',Pclifor.forn_contacontabil);
          Sistema.SetField('forn_datacad',Sistema.hoje);
          Sistema.SetField('forn_usua_codigo',global.Usuario.Codigo);
          Sistema.SetField('forn_contribuinte','S');
          Sistema.SetField('forn_uf',Emit.EnderEmit.UF);
          Sistema.SetField('forn_obspedidos','IMPXML CTe '+inttostr(Ide.nCT));
  //        Sistema.SetField('forn_uf',Pclifor.forn_uf);
          Sistema.Post();
          Sistema.Commit;
       end;
  end;


  function GetCst(xcst:TpcnCSTIcms):string;
  /////////////////////////////////////////
  begin
      if xcst=cst00 then
       result:='00'
      else if xcst=cst10 then
        result:='10'
      else if xcst=cst20 then
        result:='20'
      else if xcst=cst30 then
        result:='30'
      else if xcst=cst40 then
        result:='40'
      else if xcst=cst41 then
        result:='41'
      else if xcst=cst50 then
        result:='50'
      else if xcst=cst51 then
        result:='51'
      else if xcst=cst60 then
        result:='60'
      else if xcst=cst70 then
        result:='70'
      else if xcst=cst80 then
        result:='80'
      else if xcst=cst81 then
        result:='81'
      else if xcst=cst90 then
        result:='90'; //80 e 81 apenas para CTe
  end;

  procedure GravaMovestoque;
  ////////////////////////////
  begin
  /////////////////////////////////////
      Q:=Sqltoquery('select clie_codigo from clientes where Clie_cnpjcpf='+Stringtosql(Acbrcte1.Conhecimentos.Items[p].CTe.Dest.CNPJCPF));
      Sistema.Insert('Movestoque');
      Sistema.SetField('move_esto_codigo',produtofrete);
      Sistema.SetField('move_tama_codigo',0);
      Sistema.SetField('move_core_codigo',0);
      Sistema.SetField('move_copa_codigo',0);
      Sistema.SetField('move_transacao',transacao);
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
      Sistema.SetField('move_numerodoc',AcbrCte1.Conhecimentos.Items[p].CTe.Ide.nCT);
      Sistema.SetField('move_status','N');
      Sistema.SetField('move_tipomov',Global.CodConhecimentoSaida);
      Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
      Sistema.SetField('move_tipo_codigo',Q.Fieldbyname('Clie_codigo').AsInteger);
      Sistema.SetField('move_tipocad','C');
      Sistema.SetField('move_repr_codigo',1);
      Sistema.SetField('move_qtde',1);
      Sistema.SetField('move_venda',AcbrCte1.Conhecimentos.Items[p].CTe.vPrest.vTPrest);
      Sistema.SetField('move_datacont',Sistema.hoje);
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datamvto',AcbrCte1.Conhecimentos.Items[p].CTe.Ide.dhEmi);
      Sistema.SetField('move_qtderetorno',0);
{
      Sistema.SetField('move_custo',Arq.TEstoqueQtde.fieldbyname('esqt_custo').ascurrency);
      Sistema.SetField('move_custoger',Arq.TEstoqueQtde.fieldbyname('esqt_custoger').ascurrency);
      Sistema.SetField('move_customedio',Arq.TEstoqueQtde.fieldbyname('esqt_customedio').ascurrency);
      Sistema.SetField('move_customeger',Arq.TEstoqueQtde.fieldbyname('esqt_customeger').ascurrency);
}
                                  //  origem da mercadoria
// beneficio de SC para estes cfops - 19.02.13
      if ( ( AcbrCte1.Conhecimentos.Items[p].CTe.Ide.CFOP=5932 ) or
         ( AcbrCte1.Conhecimentos.Items[p].CTe.Ide.CFOP=6932 ) ) then
//         ( EdUNid_codigo.resultfind.FieldByName('unid_uf').asstring='SC'  ) then
        Sistema.SetField('move_cst','090') // outras
      else
        Sistema.SetField('move_cst','0' + GetCst( AcbrCte1.Conhecimentos.Items[p].CTe.Imp.ICMS.SituTrib ) );
      Sistema.SetField('move_aliicms',GetIcms( AcbrCte1.Conhecimentos.Items[p].CTe.Imp.ICMS.SituTrib,'%') );
      Sistema.SetField('move_grup_codigo',FEstoque.GetGrupo(produtofrete));
      Sistema.SetField('move_sugr_codigo',FEstoque.GetSubGrupo(produtofrete));
      Sistema.SetField('move_fami_codigo',FEstoque.GetFamilia(produtofrete));
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.SetField('move_aliipi',0);
      Sistema.SetField('move_tipo_codigoind',0);
      Sistema.SetField('move_pecas',0);
      Sistema.SetField('move_redubase',0);
      Sistema.SetField('move_nroobra','');
      Sistema.SetField('move_natf_codigo',AcbrCte1.Conhecimentos.Items[p].CTe.Ide.CFOP);
      Sistema.Post('');
  end;

  procedure GravaMovbase;
  ///////////////////////
  begin
    Sistema.Insert('MovBase');
    Sistema.SetField('movb_transacao',Transacao);
    Sistema.SetField('movb_operacao',FGeral.GetOperacao);
    Sistema.SetField('movb_status','N');
// beneficio de SC para estes cfops - 19.02.13
    if ( ( AcbrCte1.Conhecimentos.Items[p].CTe.Ide.CFOP=5932 ) or
         ( AcbrCte1.Conhecimentos.Items[p].CTe.Ide.CFOP=6932 ) ) then
//         ( EdUNid_codigo.resultfind.FieldByName('unid_uf').asstring='SC'  ) then
        Sistema.SetField('movb_cst','090') // outras
    else
      Sistema.SetField('Movb_cst','0' + GetCst( AcbrCte1.Conhecimentos.Items[p].CTe.Imp.ICMS.SituTrib ));
    Sistema.SetField('Movb_TpImposto','I' );
    Sistema.SetField('movb_numerodoc',AcbrCte1.Conhecimentos.Items[p].CTe.Ide.nCT );
// beneficio de SC para estes cfops
    if ( ( AcbrCte1.Conhecimentos.Items[p].CTe.Ide.CFOP=5932 ) or
       ( AcbrCte1.Conhecimentos.Items[p].CTe.Ide.CFOP=6932 ) ) then begin
//       ( EdUNid_codigo.resultfind.FieldByName('unid_uf').asstring='SC'  ) then begin
      Sistema.SetField('Movb_BaseCalculo',0);
      Sistema.SetField('Movb_Aliquota',0);
      Sistema.SetField('Movb_ReducaoBc', 0);
      Sistema.SetField('Movb_Imposto',0 );
      Sistema.SetField('Movb_Outras' ,GetIcms( AcbrCte1.Conhecimentos.Items[p].CTe.Imp.Icms.SituTrib,'Base' ));
    end else begin
      Sistema.SetField('Movb_BaseCalculo',GetIcms( AcbrCte1.Conhecimentos.Items[p].CTe.Imp.Icms.SituTrib,'Base' ));
      Sistema.SetField('Movb_Aliquota',GetIcms( AcbrCte1.Conhecimentos.Items[p].CTe.Imp.Icms.SituTrib,'%' ));
      Sistema.SetField('Movb_ReducaoBc',0);
      Sistema.SetField('Movb_Imposto',GetIcms( AcbrCte1.Conhecimentos.Items[p].CTe.Imp.Icms.SituTrib,'Valor' ) );
      Sistema.SetField('Movb_Outras' ,0);
    end;
    Sistema.SetField('Movb_Isentas',0);
    Sistema.SetField('Movb_tipomov',Global.CodConhecimentoSaida);
    Sistema.SetField('Movb_unid_codigo',EdUnid_codigo.text);
    Sistema.SetField('movb_natf_codigo',AcbrCte1.Conhecimentos.Items[p].CTe.Ide.CFOP);
    Sistema.Post();
  end;

  procedure GravaCancelado;
  /////////////////////////
  var datastring:string;

     function GetNumeroNota( schave:string ):string;
     /////////////////////////////////////////////////
     begin
       result:=copy(schave,27,08);
     end;


  begin
  ////////
//      Datacanc:=Acbrcte1.Conhecimentos.Items[p].CTe.procCTe.dhRecbto;
// 08.09.16
      DataString:=FExpNfetxt.GetTag('dhEvento',Acbrcte1.Conhecimentos.Items[p].XML);
      DataString:=copy( DataString,1,pos('T',DataString) -1 );
      DataString:=copy(DataString,9,2)+copy(DataString,6,2)+copy(DataString,1,4);
      Datacanc:=Texttodate( DataString );
      Sistema.Insert('Movesto');
      Sistema.SetField('moes_transacao',Transacao);
      Sistema.SetField('moes_operacao',FGeral.GetOperacao);
      Sistema.SetField('moes_status','X');
      Sistema.SetField('moes_numerodoc',GetNumeroNota( Acbrcte1.Conhecimentos.Items[p].CTe.procCTe.chCTe) );
      Sistema.SetField('moes_tipomov',Global.CodConhecimentoSaida);
      Sistema.SetField('moes_comv_codigo',Codigomov);
      Sistema.SetField('moes_unid_codigo',EdUnid_codigo.text);
      Sistema.SetField('moes_tipo_codigo',1);
      Sistema.SetField('moes_estado',EdUNid_codigo.resultfind.fieldbyname('unid_uf').asstring );
      Sistema.SetField('moes_tipocad','C');
      Sistema.SetField('moes_repr_codigo',1);
      Sistema.SetField('moes_datalcto',Sistema.Hoje);

      campo:=Sistema.GetDicionario('movesto','moes_datasaida');
      if Campo.Tipo<>'' then begin
        Sistema.SetField('moes_datasaida',DataCanc);
        Sistema.SetField('moes_datamvto',DataCanc);
      end else
        Sistema.SetField('moes_datamvto',DataCanc);
      Sistema.SetField('moes_DataCont',Sistema.Hoje);

      Sistema.SetField('moes_dataemissao',DAtacanc);
//      if AcbrCte1.Conhecimentos.Items[0].CTe.Ide.CFOP <> 0 then
//        Sistema.SetField('moes_natf_codigo',inttostr(AcbrCte1.Conhecimentos.Items[0].CTe.Ide.CFOP))
//      else if AcbrCte1.Conhecimentos.Items[1].CTe.Ide.CFOP <> 0 then
//        Sistema.SetField('moes_natf_codigo',inttostr(AcbrCte1.Conhecimentos.Items[1].CTe.Ide.CFOP) )
//      else if AcbrCte1.Conhecimentos.Items[2].CTe.Ide.CFOP <> 0 then
        Sistema.SetField('moes_natf_codigo','5352');
  //    Sistema.SetField('moes_freteciffob',NotaFiscal.NotasFiscais.Items[0].NFe.Transp.modFrete);
      Sistema.SetField('moes_valoricms', 0 );
      Sistema.SetField('moes_basesubstrib',0);
      Sistema.SetField('moes_valoricmssutr',0);
      Sistema.SetField('moes_frete',0);
  //    if IndPagtoStr( NotaFiscal.NotasFiscais.Items[0].NFe.ide.indPag ) = '0'  then
  //      Sistema.SetField('moes_vispra','V')
  //    else
        Sistema.SetField('moes_vispra','P');
      Sistema.SetField('moes_especie','CTE');
      Sistema.SetField('moes_serie','1');
      Sistema.SetField('moes_tran_codigo','001');
      Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
      Sistema.SetField('Moes_Perdesco',0);
      Sistema.SetField('Moes_Peracres',0);
  //    Sistema.SetField('moes_remessas',remessas);
      Sistema.SetField('moes_mensagem',' ');
  //    Sistema.SetField('moes_pedido',pedido);
       Sistema.SetField('Moes_qtdevolume',0);
       Sistema.SetField('Moes_especievolume',0);
       Sistema.SetField('moes_pesoliq',0);
      Sistema.SetField('moes_pesobru',0);
  //    if NotaFiscal.NotasFiscais.Items[0].NFe.Cobr.Dup.Count>0 then
  //      Sistema.SetField('moes_fpgt_codigo',FCondpagto.GetCodigoCfeParcelas(NotaFiscal.NotasFiscais.Items[0].NFe.Cobr.Dup.Count));
      Sistema.SetField('moes_valoripi',0);
      Sistema.SetField('moes_baseiss',0);
      Sistema.SetField('moes_valorpis',0);
      Sistema.SetField('moes_valorcofins',0);
      Sistema.SetField('moes_valoriss',0);
      Sistema.SetField('moes_vlrservicos',0);
      Sistema.SetField('moes_totprod',0);
      Sistema.SetField('moes_valortotal',0);
      Sistema.SetField('moes_vlrtotal',0);
      Sistema.SetField('moes_baseicms',0 );
//      Sistema.SetField('moes_obs','XML cancelado');
      Sistema.SetField('moes_obs','Importado XML');
      Sistema.setfield('moes_xmlnfet',ACBrCTe1.Conhecimentos.Items[p].XML) ;
      Sistema.setfield('moes_chavenfe',ACBrCTe1.Conhecimentos.Items[p].CTe.procCTe.chCTe);
      Sistema.Post();

      Sistema.Insert('Movestoque');
      Sistema.SetField('move_esto_codigo',produtofrete);
      Sistema.SetField('move_tama_codigo',0);
      Sistema.SetField('move_core_codigo',0);
      Sistema.SetField('move_copa_codigo',0);
      Sistema.SetField('move_transacao',transacao);
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
      Sistema.SetField('move_numerodoc',GetNumeroNota( Acbrcte1.Conhecimentos.Items[p].CTe.procCTe.chCTe));
      Sistema.SetField('move_status','X');
      Sistema.SetField('move_tipomov',Global.CodConhecimentoSaida);
      Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
      Sistema.SetField('move_tipo_codigo',1);
      Sistema.SetField('move_tipocad','C');
      Sistema.SetField('move_repr_codigo',1);
      Sistema.SetField('move_qtde',0);
      Sistema.SetField('move_venda',0);
      Sistema.SetField('move_datacont',Datacanc);
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datamvto',Datacanc);
      Sistema.SetField('move_qtderetorno',0);
      Sistema.SetField('move_cst','090' );  // outras
      Sistema.SetField('move_aliicms',0 );
      Sistema.SetField('move_grup_codigo',FEstoque.GetGrupo(produtofrete));
      Sistema.SetField('move_sugr_codigo',FEstoque.GetSubGrupo(produtofrete));
      Sistema.SetField('move_fami_codigo',FEstoque.GetFamilia(produtofrete));
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.SetField('move_aliipi',0);
      Sistema.SetField('move_tipo_codigoind',0);
      Sistema.SetField('move_pecas',0);
      Sistema.SetField('move_redubase',0);
      Sistema.SetField('move_nroobra','');
      Sistema.SetField('move_natf_codigo','5352');
      Sistema.Post('');

      Sistema.Insert('MovBase');
      Sistema.SetField('movb_transacao',Transacao);
      Sistema.SetField('movb_operacao',FGeral.GetOperacao);
      Sistema.SetField('movb_status','X');
      Sistema.SetField('movb_numerodoc',GetNumeroNota( Acbrcte1.Conhecimentos.Items[p].CTe.procCTe.chCTe) );
      Sistema.SetField('Movb_cst','000' );
      Sistema.SetField('Movb_TpImposto','I' );
      Sistema.SetField('Movb_BaseCalculo',0);
      Sistema.SetField('Movb_Aliquota',0);
      Sistema.SetField('Movb_ReducaoBc',0);
      Sistema.SetField('Movb_Imposto',0 );
      Sistema.SetField('Movb_Isentas',0);
      Sistema.SetField('Movb_Outras' ,0);
      Sistema.SetField('Movb_tipomov',Global.CodConhecimentoSaida);
      Sistema.SetField('Movb_unid_codigo',EdUnid_codigo.text);
      Sistema.SetField('movb_natf_codigo','5352');
      Sistema.Post();


  end;

////////////
begin
////////////
  produtofrete:=FGeral.GetConfig1AsString('produtofrete');
  if trim(produtofrete)='' then begin
    Avisoerro('Falta configurar o codigo do produto usado como frete');
    exit;
  end;
  Q:=Sqltoquery('select * from estoqueqtde where esqt_status=''N'''+
                ' and esqt_unid_codigo='+EdUnid_codigo.assql+
                ' and esqt_esto_codigo='+Stringtosql(produtofrete) );
  if Q.eof then begin
    Avisoerro('O codigo '+produtofrete+' ainda não foi cadatrado/duplicado na unidade '+EdUnid_codigo.text);
    exit;
  end;

  Texto.Lines.Add('Eliminando importação anterior ');
  Q:=Sqltoquery( 'select moes_transacao from movesto where moes_unid_codigo='+EdUNid_codigo.Assql+
                 ' and moes_dataemissao >= '+EdInicio.assql+
                 ' and moes_dataemissao <= '+EdTermino.assql+
                 ' and moes_status<>''C'''+
                 ' and moes_obs = '+Stringtosql('Importado XML') );
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
  Sistema.beginprocess('Importando CTes');
  Texto.Lines.add('Verificando novos destinatários(clientes) , remetentes(fornecedores) e cidades');
  for p:=0 to Acbrcte1.Conhecimentos.Count-1 do begin
    Q:=sqltoquery('select * from cidades where cida_codigoibge='+Stringtosql( inttostr(Acbrcte1.Conhecimentos.Items[p].CTe.Dest.enderDest.cMun) ) );
    if Q.Eof then
     IncluiCidadeDestinatario(inttostr(Acbrcte1.Conhecimentos.Items[p].CTe.Dest.enderDest.cMun));
    Q.close;
    Q:=sqltoquery('select * from cidades where cida_codigoibge='+Stringtosql( inttostr(Acbrcte1.Conhecimentos.Items[p].CTe.Rem.enderReme.cMun) ) );
    if Q.Eof then
     IncluiCidadeRemetente( inttostr(Acbrcte1.Conhecimentos.Items[p].CTe.Rem.enderReme.cMun) );
    Q.close;
    Q:=Sqltoquery('select * from clientes where Clie_cnpjcpf='+Stringtosql(Acbrcte1.Conhecimentos.Items[p].CTe.Dest.CNPJCPF));
    if Q.Eof then
     IncluiDestinatario;
    Q.close;
    Q:=Sqltoquery('select * from fornecedores where Forn_cnpjcpf='+Stringtosql(Acbrcte1.Conhecimentos.Items[p].CTe.Rem.CNPJCPF));
    if Q.Eof then
     IncluiRemetente;
    Q.close;
  end;
  Q:=sqltoquery('select * from confmov where comv_tipomovto='+Stringtosql(Global.codConhecimentoSaida));
  if not q.eof then
    CodigoMov:=Q.fieldbyname('comv_codigo').asinteger
  else begin
    Sistema.endprocess('Falta criar configuração de movimento de Conhecimento de Saida com o tipo '+Global.codConhecimentoSaida);
  end;
  for p:=0 to Acbrcte1.Conhecimentos.Count-1 do begin
//    if FExpNfetxt.GetTag( 'xJust',Acbrcte1.Conhecimentos.Items[p].XML ) <> ''  then begin
    transacao:=FGeral.GetTransacao;
    if Acbrcte1.Conhecimentos.Items[p].Cte.Ide.xJust='CANCELADO'  then begin
      GravaCancelado;
    end else begin
      QT:=Sqltoquery('select * from transportadores where tran_cnpjcpf='+Stringtosql(Acbrcte1.Conhecimentos.Items[p].CTe.Emit.CNPJ));
      GravaMovesto;
      GravaMovestoque;
      Gravamovbase;
    end;
    try
      Sistema.Commit;
    except
      Avisoerro('Não gravado conhecimento '+inttostr(Acbrcte1.Conhecimentos.Items[p].CTe.Ide.nCT))
    end;
  end;
  Sistema.endprocess('Importação terminada');
end;

/////////////////////////////////////////////////////////////
procedure TFImportaXmlsCte.ImportaCte( Arquivo : string );
/////////////////////////////////////////////////////////////
var Lista:TStringList;
    ano,mes,dia:string;
begin
   if ansipos('CANCCTE',Uppercase(Arquivo) )>0 then begin
//     AssignFile(Arq,Arquivo);
     Lista:=TStringList.create;
     Lista.LoadFromFile( Arquivo );
// 08.09.16
     Acbrcte1.Conhecimentos.LoadFromFile( Arquivo );

     with Acbrcte1.Conhecimentos.Add do begin
       Xml:=Lista.Text;
       CTe.procCTe.chCTe:=FExpNfetxt.GetTag('chcte',Lista.Text);
//       ano:=copy(FExpNfetxt.GetTag('dhRecbto',Lista.Text),1,04);
//       mes:=copy(FExpNfetxt.GetTag('dhRecbto',Lista.Text),6,02);
//       dia:=copy(FExpNfetxt.GetTag('dhRecbto',Lista.Text),9,02);
 //      CTe.procCTe.dhRecbto:=Texttodate( dia+mes+ano  );
       Cte.Ide.xJust:='CANCELADO';
     end;

    Lista.free;
//   end else if ansipos('CTE',Uppercase(Arquivo) )>0 then
//     Acbrcte1.Conhecimentos.LoadFromFile( Arquivo )
   end else
     Acbrcte1.Conhecimentos.LoadFromFile( Arquivo )
//     Texto.Lines.Add( Arquivo + ' não importado.')
// xml do cte vem sem o 'CTE' no nome do arquivo

end;

procedure TFImportaXmlsCte.ImportaCtes;
////////////////////////////////////////
var i:integer;
    ListaCancelados:TStringList;
begin
  Acbrcte1.Conhecimentos.Clear;
  ListaCancelados:=TStringList.Create;
  for i:=0 to ListaArq.Count-1 do begin
    if ansipos('CANCCTE',Uppercase(ListaArq.Items.Strings[i]) )>0 then
      ListaCancelados.add( copy(ListaArq.Items.Strings[i],1,44) );
  end;
  for i:=0 to ListaArq.Count-1 do begin
////////////////////////    if pos('000130',ListaArq.Items.Strings[i])>0 then
   if ( ListaCancelados.IndexOf( copy(ListaArq.Items.Strings[i],1,44) ) <> -1 ) then begin
      if ( ansipos('CANCCTE',Uppercase(ListaArq.Items.Strings[i]) )>0  ) then
////////////////////////      (  pos(uppercase('-procCTe.xml'),ListaArq.Items.Strings[i])>0 )
        ImportaCte( ListaArq.Items.Strings[i] )
   end else
        ImportaCte( ListaArq.Items.Strings[i] );

  end;
  ListaCancelados.free;
end;

procedure TFImportaXmlsCte.EdUnid_codigoExitEdit(Sender: TObject);
begin
   bexecutarclick(self);
end;

procedure TFImportaXmlsCte.OpenDialog1Close(Sender: TObject);
begin
    Texto.Lines.add('Criando lista de arquivos xmls...');
end;

procedure TFImportaXmlsCte.EdterminoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////
begin
  if EdTermino.asdate < EdInicio.asdate then EdTermino.invalid('Data final deve ser maior que inicial');
end;

end.

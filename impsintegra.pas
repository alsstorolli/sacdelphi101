unit impsintegra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid;

type
  TFImpSintegra = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bimporta: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PAcerto: TSQLPanelGrid;
    bprocurar: TSQLBtn;
    EdArquivo: TSQLEd;
    EdTipo50: TSQLEd;
    EdEntradas: TSQLEd;
    EdTipo54: TSQLEd;
    OpenDialog1: TOpenDialog;
    EdSaidas: TSQLEd;
    Edcnpjnaoenc: TSQLEd;
    bcheca5054: TSQLBtn;
    EdBase50: TSQLEd;
    EdBase54: TSQLEd;
    Eddifbase5054: TSQLEd;
    procedure EdArquivoValidate(Sender: TObject);
    procedure bprocurarClick(Sender: TObject);
    procedure bcheca5054Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;

  end;

type TTipo50=record
     numerodoc,codigoclifor,codigocidade,numerodoc70:integer;
     estado,tipocad,natureza,freteciffob,vispra,especie,serie,es,Tipomovimento,cst,cnpj,situacao,
     registro,serie70:string;
     Datamov,Dataemissao:TDatetime;
     valortotal,baseicms,valoricms,basesubs,icmssubs,totprod,valoripi,seguro,outrasdesp,vlrfrete,aliicms,isentas,outras,
     reducaobase:currency;
end;

type TTipo54=record
     numerodoc,codigoclifor:integer;
     natureza,produto,cst,serie,cnpj:string;
     Datamov:TDatetime;
     totaitem,baseicms,desconto,basesubs,valoripi,aliicms:currency;
     qtde:extended;
end;

var
  FImpSintegra: TFImpSintegra;
    PTipo50:^TTipo50;
    PTipo54:^TTipo54;
    Lista50,Lista54:Tlist;

implementation

uses Geral, SqlExpr, Sqlfun, SqlSis ;

{$R *.dfm}

procedure TFImpSintegra.EdArquivoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////////////////
type TTipo50=record
     numerodoc,codigoclifor,codigocidade:integer;
     estado,tipocad,natureza,freteciffob,vispra,especie,serie,es,Tipomovimento,cst,cnpj,
     situacao,registro:string;
     Datamov,Dataemissao:TDatetime;
     valortotal,baseicms,valoricms,basesubs,icmssubs,totprod,valoripi,seguro,outrasdesp,vlrfrete,aliicms,isentas,outras,
     reducaobase:currency;
end;

type TTipo54=record
     numerodoc,codigoclifor:integer;
     natureza,produto,cst,serie,cnpj:string;
     Datamov:TDatetime;
     totaitem,baseicms,desconto,basesubs,valoripi,aliicms:currency;
     qtde:extended;
end;

var g_erro,es,tipomovimento,transacao,operacao,unidade,tipocad,cnpjcpf:string;
    Mat:Tstringlist;
    p,n50,x,n54,ncnpjnaoenc:integer;
    Q,Qe:TSqlquery;
    Datai,Dataf:Tdatetime;
    valore,valors,valor:currency;

    procedure GravaMestre;
    /////////////////////
    begin
      Sistema.Insert('Movesto');
      Sistema.SetField('moes_transacao',Transacao);
      Sistema.SetField('moes_operacao',Operacao);
      if PTipo50.situacao='S' then
        Sistema.SetField('moes_status','X')
// 09.01.13
      else if PTipo50.registro='71' then
        Sistema.SetField('moes_status','M')
      else
        Sistema.SetField('moes_status','N');
      Sistema.SetField('moes_numerodoc',PTipo50.numerodoc);
      Sistema.SetField('moes_tipomov',Ptipo50.TipoMovimento);
      Sistema.SetField('moes_comv_codigo',0);
      Sistema.SetField('moes_unid_codigo',Unidade);
      Sistema.SetField('moes_tipo_codigo',PTipo50.codigoclifor);
      Sistema.SetField('moes_estado',PTipo50.estado);
      Sistema.SetField('moes_cida_codigo',PTipo50.codigocidade);
      Sistema.SetField('moes_tipocad',PTipo50.tipocad);
      Sistema.SetField('moes_datalcto',Sistema.Hoje);
      Sistema.SetField('moes_datamvto',PTipo50.Datamov);

        Sistema.SetField('moes_DataCont',Sistema.Hoje);
        Sistema.SetField('moes_vlrtotal',PTipo50.valortotal);
        Sistema.SetField('moes_baseicms',PTipo50.baseicms);
        Sistema.SetField('moes_valoricms',PTipo50.valoricms);
        Sistema.SetField('moes_basesubstrib',PTipo50.basesubs);
        Sistema.SetField('moes_valoricmssutr',PTipo50.icmssubs);
        Sistema.SetField('moes_totprod',PTipo50.totprod);
        Sistema.SetField('moes_valortotal',PTipo50.valortotal);

      Sistema.SetField('moes_dataemissao',PTipo50.Dataemissao);
      Sistema.SetField('moes_natf_codigo',PTipo50.natureza);
      Sistema.SetField('moes_freteciffob',PTipo50.freteciffob);
      Sistema.SetField('moes_frete',PTipo50.vlrfrete);
      Sistema.SetField('moes_vispra',PTipo50.vispra);
      Sistema.SetField('moes_especie',PTipo50.especie);
      Sistema.SetField('moes_serie',PTipo50.Serie);
      Sistema.SetField('moes_tran_codigo',0);
      Sistema.SetField('Moes_Perdesco',0);
      Sistema.SetField('Moes_Peracres',0);
      Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
//      Sistema.SetField('moes_mensagem',mensagem);
//        Sistema.SetField('moes_vlrservicos',servicos);
//      Sistema.SetField('moes_fpgt_codigo',Fpgt_codigo);
//      Sistema.SetField('moes_pedido',Pedido);
      Sistema.SetField('moes_valoripi',PTipo50.valoripi);
      Sistema.SetField('moes_seguro',PTipo50.seguro);
      Sistema.SetField('moes_outrasdesp',PTipo50.outrasdesp);

//      Sistema.SetField('moes_notapro',xnfprodutor);
//        Sistema.SetField('moes_notapro2',xnfprodutor2);
//        Sistema.SetField('moes_notapro3',xnfprodutor3);
//        Sistema.SetField('moes_notapro4',xnfprodutor4);
//        Sistema.SetField('moes_notapro5',xnfprodutor5);
//      Sistema.SetField('moes_funrural',funrural);
//      Sistema.SetField('moes_cotacapital',cotacapital);
      Sistema.Post();

    end;

    procedure GravaDetalhe;
    //////////////////////////
    var TEstoqueQtde,TEstoque:TSqlquery;
    begin
      Sistema.Insert('Movestoque');
      Sistema.SetField('move_esto_codigo',PTipo54.produto);
      Sistema.SetField('move_tama_codigo',0);
      Sistema.SetField('move_core_codigo',0);
      Sistema.SetField('move_copa_codigo',0);
      Sistema.SetField('move_transacao',transacao);
      Sistema.SetField('move_operacao',Operacao);
      Sistema.SetField('move_numerodoc',PTipo54.numerodoc);
      if PTipo50.situacao='S' then
        Sistema.SetField('move_status','X')
      else
        Sistema.SetField('move_status','N');
      Sistema.SetField('move_tipomov',PTipo50.TipoMovimento);
      Sistema.SetField('move_unid_codigo',Unidade);
      Sistema.SetField('move_tipo_codigo',PTipo50.codigoclifor);
      Sistema.SetField('move_tipocad',Ptipo50.tipocad);

      Sistema.SetField('move_repr_codigo',0);
      Sistema.SetField('move_qtde',Ptipo54.qtde);
      if PTipo54.qtde>0 then
            Sistema.SetField('move_venda',Ptipo54.totaitem/Ptipo54.qtde);
      Sistema.SetField('move_datacont',Sistema.hoje);
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datamvto',PTipo50.Datamov);
      Sistema.SetField('move_qtderetorno',0);
      TEstoqueQtde:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+stringtosql(unidade)+
                               ' and esqt_esto_codigo='+stringtosql(PTipo54.produto)+' and esqt_status=''N''');
      if not TEstoqueQtde.eof then begin
        Sistema.SetField('move_custo',TEstoqueQtde.fieldbyname('esqt_custo').ascurrency);
        Sistema.SetField('move_custoger',TEstoqueQtde.fieldbyname('esqt_custoger').ascurrency);
        Sistema.SetField('move_customedio',TEstoqueQtde.fieldbyname('esqt_customedio').ascurrency);
        Sistema.SetField('move_customeger',TEstoqueQtde.fieldbyname('esqt_customeger').ascurrency);
      end;
      Sistema.SetField('move_cst',PTipo54.cst);
      Sistema.SetField('move_aliicms',PTipo54.aliicms);
      TEstoque:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(PTipo54.produto));
      if not TEstoque.eof then begin
        Sistema.SetField('move_grup_codigo',TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
        Sistema.SetField('move_sugr_codigo',TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
        Sistema.SetField('move_fami_codigo',TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
      end;
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.SetField('move_aliipi',0);
      Sistema.SetField('move_tipo_codigoind',0);
      Sistema.SetField('move_pecas',0);
      Sistema.SetField('move_redubase',0);
      Sistema.Post('');
      FGeral.fechaquery(TEstoqueQtde);
      FGeral.fechaquery(TEstoque);
    end;

    procedure GravaMovBase;
    //////////////////////////
    begin

      Sistema.Insert('MovBase');
      Sistema.SetField('movb_transacao',Transacao);
      Sistema.SetField('movb_operacao',Operacao);
      if PTipo50.situacao='S' then
        Sistema.SetField('movb_status','X')
      else
        Sistema.SetField('movb_status','N');
      Sistema.SetField('movb_numerodoc',PTipo50.numerodoc);
      Sistema.SetField('Movb_cst',PTipo50.Cst);  // BUSCAR NO DETALHE
      Sistema.SetField('Movb_TpImposto','I' );
      Sistema.SetField('Movb_BaseCalculo',Ptipo50.baseicms);
      Sistema.SetField('Movb_Aliquota',Ptipo50.aliicms);
      Sistema.SetField('Movb_ReducaoBc',Ptipo50.reducaobase);
      Sistema.SetField('Movb_Imposto',Ptipo50.valoricms);
      Sistema.SetField('Movb_Isentas',Ptipo50.isentas);
      Sistema.SetField('Movb_Outras' ,Ptipo50.outras);
      Sistema.SetField('Movb_tipomov',Ptipo50.TipoMovimento);
      Sistema.SetField('Movb_unid_codigo',Unidade);
      Sistema.Post();


    end;


//    procedure GravaClifor;
//    begin
//    end;

//    procedure AtualizaLista50(ces,cnumero,ccnpjcpf,ccfop,cdata:string);
///////////////////////////////////////////////////////////////////////////////////////////
    procedure AtualizaLista50(ces,cnumero,ccodigoclifor,ccfop,cdata,linha,registro:string);
    ////////////////////////////////////////////////////////////////////////////////////
    var achou:boolean;
        i:integer;
    begin
      achou:=false;
      for i:=0 to Lista50.Count-1 do begin
        PTipo50:=Lista50[i];
        if ( PTipo50.numerodoc=strtointdef(cnumero,0) ) and (Ptipo50.codigoclifor=strtointdef(ccodigoclifor,0)) and
           ( Ptipo50.natureza=ccfop ) and ( Ptipo50.Datamov=texttodate(cdata) )  and (PTipo50.es=ces)
           and ( PTipo50.registro=registro )
           then begin
           achou:=true;
           break;
        end;
      end;
      if not achou then begin
          New(PTipo50);
          PTipo50.numerodoc:=strtointdef(cnumero,0);
          PTipo50.registro:=registro;
          if tipocad='C' then begin
            PTipo50.codigoclifor:=Q.fieldbyname('clie_codigo').asinteger;
            PTipo50.codigocidade:=Q.fieldbyname('clie_cida_codigo_res').asinteger;
            PTipo50.estado:=Q.fieldbyname('clie_uf').asstring;
          end else begin
            PTipo50.codigoclifor:=Q.fieldbyname('forn_codigo').asinteger;
            PTipo50.codigocidade:=Q.fieldbyname('forn_cida_codigo').asinteger;
            PTipo50.estado:=Q.fieldbyname('forn_uf').asstring;
          end;
          Ptipo50.cnpj:=copy(linha,03,14);
          PTipo50.es:=ces;
          if ces='E' then begin
            PTipo50.Tipomovimento:=Global.CodCompra100;
            if pos(ccfop,'1201/1949/2201/2949')>0 then
              PTipo50.Tipomovimento:=Global.CodDevolucaoVenda
            else if  pos(ccfop,'1353/2353/1352/2352')>0 then
              PTipo50.Tipomovimento:=Global.CodConhecimento;
          end else begin
            PTipo50.Tipomovimento:=Global.CodVendaDireta  ;
            if pos(ccfop,'5201/')>0 then
              PTipo50.Tipomovimento:=Global.CodDevolucaoCompra
            else if  pos(ccfop,'5353/6353/5352/6352')>0 then
              PTipo50.Tipomovimento:=Global.CodConhecimentoSaida;
          end;
          PTipo50.freteciffob:='1';   // copy( Mat.Strings[p],046,06 );
          PTipo50.tipocad:=tipocad;   // copy( Mat.Strings[p],046,06 );
          PTipo50.natureza:=ccfop;   // copy( Mat.Strings[p],046,06 );
          PTipo50.vispra:='P';   // copy( Mat.Strings[p],046,06 );
          if registro='70' then
            PTipo50.especie:='CTRC'
          else if registro='71' then
            PTipo50.especie:='NF'
          else
            PTipo50.especie:='NF';  // copy( Mat.Strings[p],046,06 );
//          if copy( Mat.Strings[p],043,03 )='U  ' then
//            PTipo50.serie:='1  '
//          else
            PTipo50.serie:=copy( Mat.Strings[p],043,03 );
          PTipo50.Datamov:=FGeral.TextInvertidatodate(cdata);
          PTipo50.Dataemissao:=FGeral.TextInvertidatodate(cdata);
          Ptipo50.situacao:=copy( Mat.Strings[p],126,01 );
//          PTipo50.valortotal:=Texttovalor(copy( Mat.Strings[p],057,13 ));
          if registro='70' then begin
            PTipo50.valortotal:=Texttovalor( copy( Mat.Strings[p],056,11 )+','+copy( Mat.Strings[p],067,02 ) );
            PTipo50.baseicms:=Texttovalor( copy( Mat.Strings[p],069,12 )+','+copy( Mat.Strings[p],081,02 ) );
            PTipo50.valoricms:=Texttovalor( copy( Mat.Strings[p],083,12 )+','+copy( Mat.Strings[p],095,02 ) );
            PTipo50.isentas:=Texttovalor( copy( Mat.Strings[p],097,12 )+','+copy( Mat.Strings[p],109,02 ) );
            PTipo50.outras:=Texttovalor( copy( Mat.Strings[p],111,12 )+','+copy( Mat.Strings[p],123,02 ) );
// 09.01.2013
            if PTipo50.baseicms>0 then
              Ptipo50.aliicms:=roundvalor(PTipo50.valoricms/PTipo50.baseicms)*100
            else
              Ptipo50.aliicms:=0;
            PTipo50.totprod:=Texttovalor( copy( Mat.Strings[p],069,12 )+','+copy( Mat.Strings[p],081,02 ) );
            PTipo50.outrasdesp:=0;
// 09.01.13
          end else if registro='71' then begin
//            PTipo50.modelo:=copy( Mat.Strings[p],090,02 );
            if copy( Mat.Strings[p],090,02 )='55' then
              PTipo50.especie:='NFE'
            else
              PTipo50.especie:='NF';
            PTipo50.Dataemissao:=FGeral.TextInvertidatodate(copy( Mat.Strings[p],082,08 ));
            PTipo50.numerodoc:=Strtoint(copy( Mat.Strings[p],095,06 ));
            PTipo50.numerodoc70:=strtointdef(cnumero,0);
            PTipo50.vispra:='V';
            PTipo50.serie:=copy( Mat.Strings[p],092,03 );
            PTipo50.serie70:=copy( Mat.Strings[p],043,01 );
            PTipo50.valortotal:=Texttovalor( copy( Mat.Strings[p],101,11 )+','+copy( Mat.Strings[p],101+11,02 ) );
            PTipo50.baseicms:=0;
            PTipo50.valoricms:=0;
            PTipo50.isentas:=0;
            PTipo50.outras:=0;
            Ptipo50.aliicms:=0;
            PTipo50.totprod:=0;
            PTipo50.outrasdesp:=0;

          end else begin
            PTipo50.valortotal:=Texttovalor( copy( Mat.Strings[p],057,11 )+','+copy( Mat.Strings[p],068,02 ) );
            PTipo50.baseicms:=Texttovalor( copy( Mat.Strings[p],070,11 )+','+copy( Mat.Strings[p],081,02 ) );
            PTipo50.valoricms:=Texttovalor( copy( Mat.Strings[p],083,11 )+','+copy( Mat.Strings[p],094,02 ) );
            PTipo50.isentas:=Texttovalor( copy( Mat.Strings[p],096,11 )+','+copy( Mat.Strings[p],107,02 ) );
            PTipo50.outras:=Texttovalor( copy( Mat.Strings[p],109,11 )+','+copy( Mat.Strings[p],120,02 ) );
            Ptipo50.aliicms:=Texttovalor( copy( Mat.Strings[p],122,02 )+','+copy( Mat.Strings[p],124,02 ) );
            PTipo50.totprod:=Texttovalor( copy( Mat.Strings[p],070,11 )+','+copy( Mat.Strings[p],081,02 ) );

            PTipo50.outrasdesp:=Texttovalor( copy( Mat.Strings[p],109,11 )+','+copy( Mat.Strings[p],120,02 ) );
          end;
          PTipo50.basesubs:=0;
          PTipo50.icmssubs:=0;
          PTipo50.valoripi:=0;
          PTipo50.seguro:=0;
          PTipo50.vlrfrete:=0;
          Ptipo50.reducaobase:=0;
          Ptipo50.cst:='999';
          Lista50.add(PTipo50);
      end else begin
          if registro='70' then begin
            PTipo50.valortotal:=PTipo50.valortotal + Texttovalor( copy( Mat.Strings[p],056,11 )+','+copy( Mat.Strings[p],067,02 ) );
            PTipo50.baseicms:=PTipo50.baseicms + Texttovalor( copy( Mat.Strings[p],069,12 )+','+copy( Mat.Strings[p],081,02 ) );
            PTipo50.valoricms:=PTipo50.valoricms + Texttovalor( copy( Mat.Strings[p],083,12 )+','+copy( Mat.Strings[p],095,02 ) );
            PTipo50.isentas:=PTipo50.isentas + Texttovalor( copy( Mat.Strings[p],097,12 )+','+copy( Mat.Strings[p],109,02 ) );
            PTipo50.outras:=PTipo50.outras + Texttovalor( copy( Mat.Strings[p],111,12 )+','+copy( Mat.Strings[p],123,02 ) );
            PTipo50.totprod:=PTipo50.totprod + Texttovalor( copy( Mat.Strings[p],069,12 )+','+copy( Mat.Strings[p],081,02 ) );
//          end else begin
// 09.01.13
          end else if registro<>'71' then begin
            PTipo50.valortotal:=PTipo50.valortotal + Texttovalor( copy( Mat.Strings[p],057,11 )+','+copy( Mat.Strings[p],068,02 ) );
            PTipo50.baseicms:=PTipo50.baseicms + Texttovalor( copy( Mat.Strings[p],070,11 )+','+copy( Mat.Strings[p],081,02 ) );
            PTipo50.valoricms:=PTipo50.valoricms + Texttovalor( copy( Mat.Strings[p],083,11 )+','+copy( Mat.Strings[p],094,02 ) );
            PTipo50.totprod:=PTipo50.totprod + Texttovalor( copy( Mat.Strings[p],070,11 )+','+copy( Mat.Strings[p],081,02 ) );
            PTipo50.outrasdesp:=PTipo50.outrasdesp + Texttovalor( copy( Mat.Strings[p],109,11 )+','+copy( Mat.Strings[p],120,02 ) );
            PTipo50.isentas:=PTipo50.isentas + Texttovalor( copy( Mat.Strings[p],096,11 )+','+copy( Mat.Strings[p],107,02 ) );
            PTipo50.outras:=PTipo50.outras + Texttovalor( copy( Mat.Strings[p],109,11 )+','+copy( Mat.Strings[p],120,02 ) );
          end;
      end;

    end;

///////////////////////////////////////////////////////////////////////////////////////////
    procedure AtualizaLista54(xregistro:string='54');
    /////////////////////////////////////////////////////
    var aliicms:currency;
    begin
      if xregistro='54' then begin
          New(PTipo54);
          PTipo54.numerodoc:=strtointdef(copy( Mat.Strings[p],22,06 ),0);
          PTipo54.cnpj:=copy( Mat.Strings[p],03,14 );
          PTipo54.natureza:=copy( Mat.Strings[p],028,04 );
          PTipo54.serie:=copy( Mat.Strings[p],019,03 );
//          PTipo54.Datamov:=FGeral.TextInvertidatodate(cdata);
          PTipo54.totaitem:=Texttovalor( copy( Mat.Strings[p],063,10 )+','+copy( Mat.Strings[p],073,02 ) );
          PTipo54.baseicms:=Texttovalor( copy( Mat.Strings[p],087,10 )+','+copy( Mat.Strings[p],097,02 ) );
          PTipo54.basesubs:=0;
          PTipo54.valoripi:=Texttovalor( copy( Mat.Strings[p],11,10 )+','+copy( Mat.Strings[p],121,02 ) );
          Ptipo54.aliicms:=Texttovalor( copy( Mat.Strings[p],123,02 )+','+copy( Mat.Strings[p],125,02 ) );
          Ptipo54.produto:=copy( Mat.Strings[p],038,14 );
          Ptipo54.cst:=copy( Mat.Strings[p],032,03 );
          Ptipo54.desconto:=Texttovalor( copy( Mat.Strings[p],075,02 )+','+copy( Mat.Strings[p],085,02 ) );
          Ptipo54.qtde:=Texttovalor( copy( Mat.Strings[p],052,08 )+','+copy( Mat.Strings[p],060,03 ) );
          Lista54.add(PTipo54);
      end else if xregistro='70' then begin
// 09.01.13
          New(PTipo54);
          PTipo54.numerodoc:=strtointdef(copy( Mat.Strings[p],46,06 ),0);
          PTipo54.cnpj:=copy( Mat.Strings[p],03,14 );
          PTipo54.natureza:=copy( Mat.Strings[p],52,04 );
          PTipo54.serie:=copy( Mat.Strings[p],043,01 );
//          PTipo54.Datamov:=FGeral.TextInvertidatodate(cdata);
//          PTipo50.baseicms:=Texttovalor( copy( Mat.Strings[p],069,12 )+','+copy( Mat.Strings[p],081,02 ) );
//          PTipo54.valoricms:=Texttovalor( copy( Mat.Strings[p],083,12 )+','+copy( Mat.Strings[p],095,02 ) );

          PTipo54.totaitem:=Texttovalor( copy( Mat.Strings[p],069,12 )+','+copy( Mat.Strings[p],081,02 ) );
          PTipo54.baseicms:=Texttovalor( copy( Mat.Strings[p],069,12 )+','+copy( Mat.Strings[p],081,02 ) );
          PTipo54.basesubs:=0;
//          PTipo54.valoripi:=Texttovalor( copy( Mat.Strings[p],11,10 )+','+copy( Mat.Strings[p],121,02 ) );
          PTipo54.valoripi:=0;
// 09.01.2013
          if PTipo54.baseicms>0 then
            aliicms:=roundvalor( Texttovalor( copy( Mat.Strings[p],083,12 )+','+copy( Mat.Strings[p],095,02 ) )/PTipo54.baseicms)*100
          else
            aliicms:=0;
          Ptipo54.aliicms:=aliicms;
//          Ptipo54.produto:=copy( Mat.Strings[p],038,14 );
          Ptipo54.produto:='695';// ver como fazer....
          Ptipo54.cst:='000';
          Ptipo54.desconto:=0;
          Ptipo54.qtde:=1;
          Lista54.add(PTipo54);
      end else if xregistro='71' then begin
// 16.01.13
          New(PTipo54);
          PTipo54.numerodoc:=strtointdef(copy( Mat.Strings[p],46,06 ),0);
          PTipo54.cnpj:=copy( Mat.Strings[p],03,14 );
          PTipo54.natureza:='5102';
          PTipo54.serie:='1' ; // copy( Mat.Strings[p],043,01 );
//          PTipo54.Datamov:=FGeral.TextInvertidatodate(cdata);
//          PTipo50.baseicms:=Texttovalor( copy( Mat.Strings[p],069,12 )+','+copy( Mat.Strings[p],081,02 ) );
//          PTipo54.valoricms:=Texttovalor( copy( Mat.Strings[p],083,12 )+','+copy( Mat.Strings[p],095,02 ) );

          PTipo54.totaitem:=Texttovalor( copy( Mat.Strings[p],101,12 )+','+copy( Mat.Strings[p],112,02 ) );
          PTipo54.baseicms:=Texttovalor( copy( Mat.Strings[p],101,12 )+','+copy( Mat.Strings[p],112,02 ) );
          PTipo54.basesubs:=0;
//          PTipo54.valoripi:=Texttovalor( copy( Mat.Strings[p],11,10 )+','+copy( Mat.Strings[p],121,02 ) );
          PTipo54.valoripi:=0;
// 09.01.2013
          if PTipo54.baseicms>0 then
            aliicms:=0
            //roundvalor( Texttovalor( copy( Mat.Strings[p],083,12 )+','+copy( Mat.Strings[p],095,02 ) )/PTipo54.baseicms)*100
          else
            aliicms:=0;
          Ptipo54.aliicms:=aliicms;
//          Ptipo54.produto:=copy( Mat.Strings[p],038,14 );
          Ptipo54.produto:='695';// ver como fazer....
          Ptipo54.cst:='000';
          Ptipo54.desconto:=0;
          Ptipo54.qtde:=1;
          Lista54.add(PTipo54);

      end;
    end;

// 16.01.13
    function GetTransacao70:string;
    //////////////////////////////
    var i:integer;
    begin
      result:='';
      for i:=0 to Mat.count-1 do begin
         if copy(Mat.Strings[i],1,2)='70' then begin
            if ( PTipo50.numerodoc70=strtoint(copy(Mat.Strings[i],46,06)) ) and
               ( PTipo50.cnpj=copy(Mat.Strings[i],03,14) ) and
               ( PTipo50.serie70=copy(Mat.Strings[i],43,1) ) then
              result:=copy(PTipo50.cnpj,01,04)+strzero(strtoint(copy(Mat.Strings[i],46,06)),6)+copy(Mat.Strings[i],43,1);
//              result:=copy(PTipo50.cnpj,01,04)+strzero(strtoint(copy(Mat.Strings[i],46,06)),6)+copy(PTipo50.serie,1,1);
         end;
      end;

    end;


begin
//////////////////////////////////////////////////

   if not Fileexists( EdArquivo.text ) then begin
     EdArquivo.INvalid('Arquivo '+EdArquivo.text+' não encontrado');
     exit;
   end;
   Mat:=TStringList.Create;
   Mat.LoadFromFile(EdArquivo.text);
   unidade:=Global.CodigoUnidade;

   Try
  		g_erro := copy( Mat.Strings[0],10,1 );
   Except
      avisoerro('Arquivo de retorno inválido');
      Mat.Free;
      exit;
   End;
   Grid.clear;
   n50:=0;
   valore:=0;
   n54:=0;
   valors:=0;
   x:=0;
   ncnpjnaoenc:=0;
   Lista50:=TList.create;
   Lista54:=TList.create;
   Sistema.beginprocess('Lendo arquivo '+EdArquivo.text);
   datai:=0;dataf:=0;
   for p:=0 to Mat.count-1 do begin

      if ( copy( Mat.Strings[p],01,02 )='50' ) then begin
//        inc(n50);
        inc(x);
        if pos( copy( Mat.Strings[p],052,1 ),'123' ) > 0 then
          es:='E'
        else begin
          inc(n50);
          es:='S';
        end;
        Grid.Cells[grid.getcolumn('moes_numerodoc'),abs(x)]:=copy( Mat.Strings[p],046,06 );
        Grid.Cells[grid.getcolumn('moes_dataemissao'),abs(x)]:=FGeral.FormataData( fGeral.textinvertidatodate( copy(Mat.Strings[p],031,08) ) );
        Grid.Cells[grid.getcolumn('es'),abs(x)]:=es;
        valor:=texttovalor( copy(Mat.Strings[p],057,11)+'.'+copy(Mat.Strings[p],068,02) );
        Grid.Cells[grid.getcolumn('moes_vlrtotal'),abs(x)]:=fGeral.formatavalor( valor ,f_cr);
        Grid.Cells[grid.getcolumn('moes_datamvto'),abs(x)]:=FGeral.FormataData( fGeral.textinvertidatodate( copy(Mat.Strings[p],031,08) ) );
        Grid.Cells[grid.getcolumn('moes_natf_codigo'),abs(x)]:= copy(Mat.Strings[p],052,04)  ;
        cnpjcpf:=copy(Mat.Strings[p],03,14);
        if copy(cnpjcpf,1,3)='000' then  // devido aos cpfs...
           cnpjcpf:=copy(cnpjcpf,04,11);
        Grid.Cells[grid.getcolumn('cnpj'),abs(x)]:= cnpjcpf  ;
        if es='E' then begin
          valore:=valore+valor;
          tipocad:='F';
          Q:=sqltoquery('select * from fornecedores'+
                        ' where forn_cnpjcpf='+stringtosql(cnpjcpf) );
          if not Q.eof then
              Grid.Cells[grid.getcolumn('clie_nome'),abs(x)]:=Q.fieldbyname('forn_razaosocial').asstring
          else begin
            Q.Close;
            Q:=sqltoquery('select * from clientes'+
                        ' where clie_cnpjcpf='+stringtosql(cnpjcpf) );
            tipocad:='C';
            if not Q.eof then
               Grid.Cells[grid.getcolumn('clie_nome'),abs(x)]:=Q.fieldbyname('clie_razaosocial').asstring
          end;
        end else begin
          tipocad:='C';
          Q:=sqltoquery('select * from clientes'+
                        ' where clie_cnpjcpf='+stringtosql(cnpjcpf) );
          if not Q.eof then
              Grid.Cells[grid.getcolumn('clie_nome'),abs(x)]:=Q.fieldbyname('clie_razaosocial').asstring
          else begin
              tipocad:='F';
              Q:=sqltoquery('select * from fornecedores'+
                            ' where forn_cnpjcpf='+stringtosql(cnpjcpf) );
              if not Q.eof then
                  Grid.Cells[grid.getcolumn('clie_nome'),abs(x)]:=Q.fieldbyname('forn_razaosocial').asstring
          end;
          valors:=valors+valor;
        end;
        if Q.eof then begin
          Grid.Cells[grid.getcolumn('clie_nome'),abs(x)]:='CNPJ/CPF não enc. '+copy(Mat.Strings[p],03,14);
          inc(ncnpjnaoenc)
        end;
        Grid.AppendRow;//     documento                       // cnpj                      // cfop                   //data
        AtualizaLista50( es,  copy( Mat.Strings[p],046,06 ) , copy(Mat.Strings[p],03,14) , copy(Mat.Strings[p],52,04) , copy( Mat.Strings[p],031,08 ),Mat.Strings[p],'50');
        FGeral.Fechaquery(Q);

      end else if ( copy( Mat.Strings[p],01,02 )='54' ) then begin

        if pos( copy( Mat.Strings[p],028,1 ),'567' ) > 0 then
          inc(n54);
        AtualizaLista54;

      end else if ( copy( Mat.Strings[p],01,02 )='10' ) then begin
        datai:=FGeral.TextInvertidatodate( copy(Mat.Strings[p],108,08) );
        dataf:=FGeral.TextInvertidatodate( copy(Mat.Strings[p],116,08) );

      end else if ( copy( Mat.Strings[p],01,02 )='70' ) then begin  // conhecimento de transporte

        inc(x);
        valor:=texttovalor( copy(Mat.Strings[p],056,11)+'.'+copy(Mat.Strings[p],056+11,02) );
        if pos( copy( Mat.Strings[p],052,1 ),'123' ) > 0 then begin
          tipocad:='F';
          es:='E';
          valore:=valore+valor;
          Q:=sqltoquery('select * from fornecedores'+
                        ' where forn_cnpjcpf='+stringtosql(cnpjcpf) );
          if not Q.eof then
              Grid.Cells[grid.getcolumn('clie_nome'),abs(x)]:=Q.fieldbyname('forn_razaosocial').asstring;
        end else begin
          es:='S';
          tipocad:='C';
          valors:=valors+valor;
          Q:=sqltoquery('select * from clientes'+
                        ' where clie_cnpjcpf='+stringtosql(cnpjcpf) );
          if not Q.eof then
              Grid.Cells[grid.getcolumn('clie_nome'),abs(x)]:=Q.fieldbyname('clie_razaosocial').asstring;
        end;
        Grid.Cells[grid.getcolumn('moes_numerodoc'),abs(x)]:=copy( Mat.Strings[p],046,06 );
        Grid.Cells[grid.getcolumn('moes_dataemissao'),abs(x)]:=FGeral.FormataData( fGeral.textinvertidatodate( copy(Mat.Strings[p],031,08) ) );
        Grid.Cells[grid.getcolumn('es'),abs(x)]:=es;
        Grid.Cells[grid.getcolumn('moes_vlrtotal'),abs(x)]:=fGeral.formatavalor( valor ,f_cr);
        Grid.Cells[grid.getcolumn('moes_datamvto'),abs(x)]:=FGeral.FormataData( fGeral.textinvertidatodate( copy(Mat.Strings[p],031,08) ) );
        Grid.Cells[grid.getcolumn('moes_natf_codigo'),abs(x)]:= copy(Mat.Strings[p],052,04)  ;

        cnpjcpf:=copy(Mat.Strings[p],03,14);
        if copy(cnpjcpf,1,3)='000' then  // devido aos cpfs...
           cnpjcpf:=copy(cnpjcpf,04,11);

        Grid.AppendRow;//     documento                       // cnpj                      // cfop                   //data
        AtualizaLista50( es,  copy( Mat.Strings[p],046,06 ) , copy(Mat.Strings[p],03,14) , copy(Mat.Strings[p],52,04) , copy( Mat.Strings[p],031,08 ),Mat.Strings[p],'70');

        AtualizaLista54('70');

        FGeral.Fechaquery(Q);
// 09.01.13 - registro 71 das notas acobertadas pelos conhecimentos DE SAIDA
/////////////////////////////////////////////////////////////////////
      end else if ( copy( Mat.Strings[p],01,02 )='71' ) then begin

        inc(x);
        es:='S';
        Grid.Cells[grid.getcolumn('moes_numerodoc'),abs(x)]:=copy( Mat.Strings[p],046,06 );
        Grid.Cells[grid.getcolumn('moes_dataemissao'),abs(x)]:=FGeral.FormataData( fGeral.textinvertidatodate( copy(Mat.Strings[p],031,08) ) );
        Grid.Cells[grid.getcolumn('es'),abs(x)]:=es;
//        valor:=texttovalor( copy(Mat.Strings[p],057,11)+'.'+copy(Mat.Strings[p],068,02) );
        valor:=Texttovalor( copy( Mat.Strings[p],101,11 )+','+copy( Mat.Strings[p],101+11,02 ) );

        Grid.Cells[grid.getcolumn('moes_vlrtotal'),abs(x)]:=fGeral.formatavalor( valor ,f_cr);
        Grid.Cells[grid.getcolumn('moes_datamvto'),abs(x)]:=FGeral.FormataData( fGeral.textinvertidatodate( copy(Mat.Strings[p],082,08) ) );
        Grid.Cells[grid.getcolumn('moes_natf_codigo'),abs(x)]:='XXXX' ;

        cnpjcpf:=copy(Mat.Strings[p],54,14);
        if copy(cnpjcpf,1,3)='000' then  // devido aos cpfs...
           cnpjcpf:=copy(cnpjcpf,04,11);
        tipocad:='F';
        Q:=sqltoquery('select * from fornecedores'+
                        ' where forn_cnpjcpf='+stringtosql(cnpjcpf) );
        if not Q.eof then
              Grid.Cells[grid.getcolumn('clie_nome'),abs(x)]:=Q.fieldbyname('forn_razaosocial').asstring;
        Grid.AppendRow;//     documento                       // cnpj                      // cfop                   //data
        AtualizaLista50( es,  copy( Mat.Strings[p],046,06 ) , copy(Mat.Strings[p],54,14) , '5102' , copy( Mat.Strings[p],082,08 ),Mat.Strings[p],'71');
// 15.01.13
        AtualizaLista54('71');

        Q.Close;Freeandnil(Q);

      end;
   end;
   Sistema.endprocess('');
   Edcnpjnaoenc.setvalue(ncnpjnaoenc);
   EdTipo50.setvalue(n50);
   EdEntradas.setvalue(valore);
   EdTipo54.setvalue(n54);
   EdSaidas.setvalue(valors);

   if not confirma('Gravar no banco de dados ?') then exit;

   if (datai>0) and (dataf>0) then begin
     Sistema.beginprocess('Eliminando importação no periodo de '+FGeral.formatadata(datai)+' a '+FGeral.formatadata(dataf) );
     Qe:=sqltoquery('select moes_transacao from movesto where substr(moes_transacao,1,1)=''S'' and moes_datamvto>='+Datetosql(datai)+' and moes_datamvto<='+Datetosql(dataf)+
                  ' and moes_status in (''N'',''M'') and moes_unid_codigo='+stringtosql(unidade));
     Sistema.edit('Movesto');
     Sistema.setfield('moes_status','C');
     Sistema.post('substr(moes_transacao,1,1)=''S'' and moes_datamvto>='+Datetosql(datai)+' and moes_datamvto<='+Datetosql(dataf)+
                  ' and moes_status in (''N'',''M'') and moes_unid_codigo='+stringtosql(unidade));
     Sistema.edit('Movestoque');

     Sistema.setfield('move_status','C');
     Sistema.post('substr(move_transacao,1,1)=''S'' and move_datamvto>='+Datetosql(datai)+' and move_datamvto<='+Datetosql(dataf)+
                  ' and move_status in (''N'',''M'') and move_unid_codigo='+stringtosql(unidade));
     while not Qe.eof do begin
       Sistema.edit('Movbase');
       Sistema.setfield('movb_status','C');
       Sistema.post('movb_transacao='+stringtosql(Qe.fieldbyname('moes_transacao').asstring));
       Qe.next;
     end;
     FGeral.FechaQuery(Qe);
     sistema.commit;
   end else begin
     Avisoerro('Não foi possível identificar o período a ser importado dentro do arquivo');
     Grid.setfocus;
     exit;
   end;

   Sistema.BeginProcess('Importando lançamentos');
   for x:=0 to LIsta50.count-1 do begin
     PTipo50:=Lista50[x];
//     Transacao:='I'+copy(PTipo50.cnpj,01,04)+strzero(PTipo50.numerodoc,6)+copy(PTipo50.serie,1,1);
//     if (PTipo50.registro='70') or (PTipo50.registro='71') then
     if (PTipo50.registro='71') then begin
//       Transacao:='S'+PTipo50.registro+Formatdatetime('ddmmyyyy',PTipo50.Dataemissao)
//       Transacao:='S'+'70'+Formatdatetime('ddmmyyyy',PTipo50.Dataemissao)
       Transacao:='S'+GetTransacao70;
       if trim(transacao)='S' then begin
          Sistema.EndProcess('Não encontrado registro 70 ref. '+copy(PTipo50.cnpj,01,04)+'|'+strzero(PTipo50.numerodoc70,6)+'|'+copy(PTipo50.serie,1,1) );
          exit;
       end;
     end else
       Transacao:='S'+copy(PTipo50.cnpj,01,04)+strzero(PTipo50.numerodoc,6)+copy(PTipo50.serie,1,1);
     Operacao:=Transacao+inttostr(x);
     for p:=0 to LIsta54.count-1 do begin
        PTipo54:=LIsta54[p];
        if (PTipo54.cnpj=PTipo50.cnpj) and ( trim(PTipo54.serie)=trim(PTipo50.serie)) and (Ptipo54.numerodoc=Ptipo50.numerodoc) and
            (Ptipo54.natureza=Ptipo50.natureza) then begin
            Operacao:=Transacao+inttostr(p);
            PTipo50.cst:=PTipo54.cst;
            GravaDetalhe;
        end;
     end;
     GravaMestre;
     GravaMovbase;
     if x div 200 = 0 then
       Sistema.commit;

   end;
   if Lista50.count>=1 then
       Sistema.commit;

   Sistema.endprocess('Importação terminada');

end;

procedure TFImpSintegra.Execute;
begin
   show;
   EdArquivo.setfocus;

end;

procedure TFImpSintegra.bprocurarClick(Sender: TObject);
begin
   if opendialog1.execute then begin
     EdArquivo.text:=Opendialog1.FileName;
     EdArquivo.valid;
     Grid.setfocus;
   end;

end;

procedure TFImpSintegra.bcheca5054Click(Sender: TObject);
var numero,p:integer;
    valorcontabil,baseicms,base50,base54,difbase5054:currency;
    datamov:TDatetime;
    natureza,cnpjcpf:string;

    procedure GetValores54(var contabil,baseicms:currency);
    var i:integer;
        xcontabil,xbaseicms:currency;
    begin
      xcontabil:=0;
      xbaseicms:=0;
      for i:=0 to Lista54.Count-1 do begin
        Ptipo54:=Lista54[i];
        if (Ptipo54.numerodoc=PTipo50.numerodoc) and (PTipo54.cnpj=PTipo50.cnpj) and
           (PTipo54.natureza=PTipo50.natureza) then begin
           xcontabil:=xcontabil+PTipo54.totaitem;
           xbaseicms:=xbaseicms+PTipo54.baseicms;
        end;
      end;
      contabil:=xcontabil;
      baseicms:=xbaseicms;
    end;

    procedure PosicionaLista50(numero:integer;datamov:TDatetime;cnpjcpf,natureza:string);
    var x:integer;
        achou:boolean;
    begin
      achou:=false;
      for x:=0 to Lista50.count-1 do begin
        PTipo50:=Lista50[x];
        if (numero=PTipo50.numerodoc) and (cnpjcpf=PTipo50.cnpj) and
           (datamov=PTipo50.Datamov) and (natureza=PTipo50.natureza) then begin
           achou:=true;
           break;
        end;
      end;
      if not achou then
        Avisoerro('Não encontrado tipo 50 nota '+inttostr(numero)+'XX data '+datetostr(datamov)+'XX cfop '+natureza+'XX cnpj/cfp '+cnpjcpf+'XX');
    end;


begin
///////////////////////////////
//colocar os 'campos chave' no grid e percorrer o grid ao inves da lista50
   base50:=0;base54:=0;difbase5054:=0;
   for p:=1 to Grid.RowCount do begin
     numero:=strtointdef(Grid.cells[Grid.getcolumn('moes_numerodoc'),p],0 );
     if numero>0 then begin
       cnpjcpf:=Grid.cells[Grid.getcolumn('cnpj'),p] ;
       if length(trim(Grid.cells[Grid.getcolumn('cnpj'),p]))=11 then
         cnpjcpf:='000'+Grid.cells[Grid.getcolumn('cnpj'),p];

       natureza:=Grid.cells[Grid.getcolumn('moes_natf_codigo'),p] ;
       datamov:=TexttoDate( FGeral.TiraBarra( Grid.cells[Grid.getcolumn('moes_datamvto'),p] ) );
       PosicionaLista50(numero,datamov,cnpjcpf,natureza);
  //     PTipo50:=Lista50[p];
       valorcontabil:=0;baseicms:=0;
       GetValores54(valorcontabil,baseicms);
  //     if (Ptipo50.valortotal<>valorcontabil) or (Ptipo50.baseicms<>baseicms) then
       if Abs(Ptipo50.baseicms-baseicms)>1 then begin
         Grid.Cells[Grid.GetColumn('base50'),p]:=FGeral.Formatavalor(PTipo50.baseicms,f_cr);
         Grid.Cells[Grid.GetColumn('base54'),p]:=FGeral.Formatavalor(baseicms,f_cr);
         difbase5054:=difbase5054+Abs(Ptipo50.baseicms-baseicms);
         Grid.Cells[Grid.GetColumn('difbase5054'),p]:=FGeral.Formatavalor(Abs(Ptipo50.baseicms-baseicms),f_cr);
       end;
       base50:=base50+PTipo50.baseicms;
       base54:=base54+baseicms;
     end;
   end;
   edBase50.SetValue(base50);
   edBase54.SetValue(base54);
   eddifBase5054.SetValue(difbase5054);
end;

end.

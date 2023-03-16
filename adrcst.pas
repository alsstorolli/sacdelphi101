// 23.03.20 - inicio dos trabalhos
// Gera arquivo para o 'sped fiscal da St' do Paran� - ADRC-ST'

unit adrcst;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Mask,
  SQLEd, Vcl.Buttons, SQLBtn, alabel, SQLGrid, Vcl.ExtCtrls, SqlExpr;

type
  TFadrcst = class(TForm)
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
    EdUnidades: TSQLEd;
    Edfinalidade: TSQLEd;
    EdMesano: TSQLEd;
    procedure bExecutarClick(Sender: TObject);
    procedure EdterminoValidate(Sender: TObject);
    procedure EdfinalidadeExitEdit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;

  end;

type Reg_0000 = record

    mes_ano        : string;   //  mm/yyyy
    cnpj           : string;
    ie             : string;
    cd_fin         : string;
    n_reg_especial : string;
    cnpj_cd        : string;
    ie_cd          : string;
end;

type Reg_1000 = record

     ind_fecop     :string;   // 0 - n�o sujeito ao FCP 1 - sujeito ao FCP
     cod_item      :string;
     cod_barras    :string;
     cod_anp       :string;
     ncm           :string;
     cest          :string;
     descr_item    :string;
     unid_item     :string;
     aliq_icms_item:currency;
     aliq_fecop    :currency;
     qtd_tot_entrada : currency;
     qtd_tot_saida   : currency;

end;

type Reg_1010 = record

     cod_item      :string;
     unid_item     :string;
     qtd           :currency;
     vl_tot_item   :currency;
     txt_compl     :string;

end;

type Reg_1100 = record

     QTD_TOT_ENTRADA              :currency;
     MENOR_VL_UNIT_ITEM           :currency;
     VL_BC_ICMSST_UNIT_MED        :currency;
     VL_TOT_ICMS_SUPORT_ENTR      :currency;
     VL_UNIT_MED_ICMS_SUPORT_ENTR :currency;

end;

type Reg_1200 = record

     QTD_TOT_SAIDA                :currency;
     VL_TOT_ICMS_EFETIVO          :currency;
     VL_CONFRONTO_ICMS_ENTRADA    :currency;
     RESULT_RECUPERAR_RESSARCIR   :currency;
     RESULT_COMPLEMENTAR          :currency;
     APUR_ICMSST_RECUPERAR_RESSARCIR :currency;
     APUR_ICMSST_COMPLEMENTAR     :currency;
     APUR_FECOP_RESSARCIR         :currency;
     APUR_FECOP_COMPLEMENTAR      :currency;

end;

type Reg_1300 = record

     QTD_TOT_SAIDA                :currency;
     VL_TOT_ICMS_EFETIVO          :currency;
     VL_CONFRONTO_ICMS_ENTRADA    :currency;
     RESULT_RECUPERAR_RESSARCIR   :currency;
     APUR_ICMSST_RECUPERAR_RESSARCIR :currency;
     APUR_FECOP_RESSARCIR         :currency;

end;


type Reg_1500 = record

     QTD_TOT_SAIDA                :currency;
     VL_ICMSST_UNIT_ENTR          :currency;
     APUR_ICMSST_RECUPERAR_RESSARCIR  :currency;

end;

type Reg_9000 = record
     REG1200_ICMSST_RECUPERAR_RESSARCIR :currency;
     REG1200_ICMSST_COMPLEMENTAR        :currency;
     REG1300_ICMSST_RECUPERAR_RESSARCIR :currency;
     REG1400_ICMSST_RECUPERAR_RESSARCIR :currency;
     REG1500_ICMSST_RECUPERAR_RESSARCIR :currency;
     REG9000_FECOP_RESSARCIR            :currency;
     REG9000_FECOP_COMPLEMENTAR         :currency;
end;


type Reg_1110 = record

     dt_doc       :TDatetime;
     COD_RESP_RET :string;
     CST_CSOSN    :string;
     chave        :string;
     n_nf         :integer;
     cnpj_emit    :string;
     uf_emit      :string;
     cnpj_dest    :string;
     uf_dest      :string;
     cfop         :string;
     unid_item    :string;
     n_item       :integer;
     qtd_entrada  :currency;
     VL_UNIT_ITEM :currency;
     VL_BC_ICMS_ST:currency;
     VL_ICMS_SUPORT_ENTR :currency;

end;

type Reg_1210 = record

     dt_doc       :TDatetime;
     CST_CSOSN    :string;
     chave        :string;
     n_nf         :integer;
     cnpj_emit    :string;
     uf_emit      :string;
     cnpj_cpf_dest    :string;
     uf_dest      :string;
     cfop         :string;
     unid_item    :string;
     n_item       :integer;
     qtd_saida    :currency;
     VL_UNIT_ITEM :currency;
     VL_ICMS_EFET :currency;

end;


type Reg_1310 = record

     dt_doc       :TDatetime;
     CST_CSOSN    :string;
     chave        :string;
     n_nf         :integer;
     cnpj_emit    :string;
     uf_emit      :string;
     cnpj_cpf_dest    :string;
     uf_dest      :string;
     cfop         :string;
     unid_item    :string;
     n_item       :integer;
     qtd_saida    :currency;
     VL_UNIT_ITEM :currency;
     VL_ICMS_EFET :currency;

end;

type Reg_1510 = record

     dt_doc       :TDatetime;
     CST_CSOSN    :string;
     chave        :string;
     n_nf         :integer;
     cnpj_emit    :string;
     uf_emit      :string;
     cnpj_dest    :string;
     uf_dest      :string;
     cfop         :string;
     unid_item    :string;
     n_item       :integer;
     qtd_saida    :currency;
     VL_UNIT_ITEM :currency;

end;

type Reg_1220 = record

     dt_doc       :TDatetime;
     CST_CSOSN    :string;
     chave        :string;
     n_nf         :integer;
     cnpj_emit    :string;
     uf_emit      :string;
     cnpj_cpf_dest:string;
     uf_dest      :string;
     cfop         :string;
     unid_item    :string;
     n_item       :integer;
     qtd_devolvida:currency;
     VL_UNIT_ITEM :currency;
     VL_ICMS_EFETIVO:currency;
     chave_ref    :string;
     N_ITEM_REF   :integer;

end;

type Reg_1320 = record

     dt_doc       :TDatetime;
     CST_CSOSN    :string;
     chave        :string;
     n_nf         :integer;
     cnpj_emit    :string;
     uf_emit      :string;
     cnpj_cpf_dest:string;
     uf_dest      :string;
     cfop         :string;
     unid_item    :string;
     n_item       :integer;
     qtd_devolvida:currency;
     VL_UNIT_ITEM :currency;
     VL_ICMS_EFETIVO:currency;
     chave_ref    :string;
     N_ITEM_REF   :integer;

end;

type Reg_1520 = record

     dt_doc       :TDatetime;
     CST_CSOSN    :string;
     chave        :string;
     n_nf         :integer;
     cnpj_emit    :string;
     uf_emit      :string;
     cnpj_dest    :string;
     uf_dest      :string;
     cfop         :string;
     unid_item    :string;
     n_item       :integer;
     qtd_devolvida:currency;
     VL_UNIT_ITEM :currency;
     VL_ICMS_EFETIVO:currency;
     chave_ref    :string;
     N_ITEM_REF   :integer;

end;

var
  Fadrcst: TFadrcst;

implementation

uses Sqlsis, Sqlfun, Geral, Unidades, fornece, cadcli, Estoque, codigosipi;


{$R *.dfm}

{ TFacrcst }

procedure TFadrcst.bExecutarClick(Sender: TObject);
///////////////////////////////////////////////////////
const ModeloNfe      :string='55';
      ModeloNfce     :string='65';
      sep            :string='|'  ;

var
      TReg_0000,
      TReg_1000,
      TReg_1100,
      TReg_1200,
      TReg_1300,
      TReg_1500,
      TReg_1010,
      TReg_1110,
      TReg_1220,
      TReg_1320,
      TReg_1520,
      TReg_1210,
      TReg_1310,
      TReg_1510,
      TReg_9000     :TList;
      PReg_0000     :^Reg_0000;
      PReg_9000     :^Reg_9000;
      PReg_1000     :^Reg_1000;
      PReg_1100     :^Reg_1100;
      PReg_1200     :^Reg_1200;
      PReg_1300     :^Reg_1300;
      PReg_1500     :^Reg_1500;
      PReg_1010     :^Reg_1010;
      PReg_1110     :^Reg_1110;
      PReg_1210     :^Reg_1210;
      PReg_1310     :^Reg_1310;
      PReg_1510     :^Reg_1510;
      PReg_1220     :^Reg_1220;
      PReg_1320     :^Reg_1320;
      PReg_1520     :^Reg_1520;
      nomearq,
      tiposnao,
      SqlunidadesDet,
      linha,
      tiposdevolucao:string;
      Q             :TSqlquery;
      ListaArquivo  :TStringList;
      arquivo       :TextFile;
      I             : Integer;

      function GetCnpj( codigo:integer ; tipo:string ):string;
      ///////////////////////////////////////////////////////////
      begin

         if tipo = 'F' then result := FFornece.GetCnpjCpf(codigo)
         else result := FCadCli.GetCnpjCpf( codigo );

      end;


      function GetUF( codigo:integer ; tipo:string ):string;
      ///////////////////////////////////////////////////////////
      begin

         if tipo = 'F' then result := FFornece.GetUF(codigo)
         else result := FCadCli.GetUF( codigo );

      end;


      // calcula base unitaria da ST
      function GetBaseST:currency;
      ///////////////////////////
      var mva :currency;
          QSt :Tsqlquery;
      begin

        QSt:=sqltoquery('select cfis_percbase from codigosfis where cfis_aliquota = '+
                        ValorToSql(Q.FieldByName('move_aliicms').AsCurrency)+
                        ' and cfis_percbase > 0 ');
        if QSt.Eof then

           mva := 0
        else
           mva := QSt.FieldByName('cfis_percbase').AsCurrency;

        result := Q.FieldByName('move_venda').AsCurrency   +
                 ( Q.FieldByName('move_venda').AsCurrency * (mva/100) );
        QSt.Close;

      end;

      // calcula o tal de 'icms suportado'...
      function GetvalorIcmsSuportado:currency;
      ////////////////////////////////////////
      var pericmsestado:currency;
      begin

          pericmsestado := FEstoque.Getaliquotaicms(Q.FieldByName('move_esto_codigo').AsString,
                           Q.FieldByName('moes_unid_codigo').AsString,
                           Q.FieldByName('moes_estado').AsString );
          result := Q.FieldByName('move_venda').AsCurrency * ( pericmsestado/100 );

      end;

      // cadastro de produtos
      procedure GeraRegistro1000( xES:string );
      ////////////////////////////////////////////
      var p,
          mes,
          ano       :integer;
          achou     : boolean;
          QSaldoAnt : TSqlquery;
          mesano    : string;

      begin

         mes := strtoint( copy(Edmesano.Text,1,2 ) );
         ano := strtoint( copy(Edmesano.Text,3,4 ) );
         if mes = 01  then begin
            mes := 12 ;
            ano := ano - 1;
         end else mes := mes - 1;

         mesano:=strzero(mes,2)+strzero(ano,4);
         achou := false;
         for p := 0 to TReg_1000.Count-1 do  begin

             PReg_1000 := TReg_1000[p];
             if PReg_1000.cod_item = Q.FieldByName('move_esto_codigo').AsString then begin
                achou := true;
                break;
             end;

         end;

         for p := 0 to TReg_1010.Count-1 do  begin

             PReg_1010 := TReg_1010[p];
             if PReg_1010.cod_item = Q.FieldByName('move_esto_codigo').AsString then begin
                break;
             end;

         end;

         QSaldoAnt := sqltoquery('select saes_qtde,saes_customedio from salestoque where '+
                                    ' saes_mesano = '+Stringtosql(FGeral.Anomesinvertido(Mesano))+
                                    ' and saes_status = ''N'''+
                                    ' and saes_esto_codigo = '+Stringtosql(Q.FieldByName('move_esto_codigo').AsString)+
                                    ' and saes_unid_codigo = '+Stringtosql(Q.FieldByName('move_unid_codigo').AsString) );

         if not achou then begin

            New( PReg_1000 );
            PREg_1000.ind_fecop :=  '0';   // 0 - nao sujeito FCP   1 - sujeito FCP
            PReg_1000.cod_item  := Q.FieldByName('move_esto_codigo').AsString;
            PReg_1000.cod_barras:= Q.FieldByName('esto_codbarra').AsString;
            PReg_1000.cod_anp   := '0';   // codigo ANP
            PREg_1000.ncm       := FEstoque.GetNCMipi( Q.FieldByName('move_esto_codigo').AsString );
            PREg_1000.cest      := FEstoque.GetCESTNCM( Q.FieldByName('move_esto_codigo').AsString );
            PREg_1000.descr_item:= ( Q.FieldByName('esto_descricao').AsString );
            PREg_1000.unid_item := Q.FieldByName('esto_unidade').AsString;
            PReg_1000.aliq_icms_item := FEstoque.Getaliquotaicms(Q.FieldByName('move_esto_codigo').AsString,
                           Q.FieldByName('moes_unid_codigo').AsString,
                           Q.FieldByName('moes_estado').AsString );
            PReg_1000.aliq_fecop:= 0;   // ver se busca o cria campo no cadastro - aliquota do FCP
            if xEs = 'E' then begin

               PREg_1000.qtd_tot_entrada :=  Q.FieldByName('move_qtde').AsCurrency;
               PREg_1000.qtd_tot_saida   := 0;

            end else begin

               PREg_1000.qtd_tot_saida     :=  Q.FieldByName('move_qtde').AsCurrency;
               PREg_1000.qtd_tot_entrada   := 0;

            end;
            TREg_1000.Add( PREg_1000 );

            New( PReg_1010 );
            PReg_1010.cod_item   := Q.FieldByName('move_esto_codigo').AsString;
            PReg_1010.unid_item  := Q.FieldByName('esto_unidade').AsString;
            if QSaldoant.Eof then begin

              PReg_1010.qtd        := 0;
              PReg_1010.vl_tot_item:= 0;

            end else begin

              PReg_1010.qtd        := QSaldoAnt.fieldbyname('saes_qtde').ascurrency;
              PReg_1010.vl_tot_item:= QSaldoAnt.fieldbyname('saes_qtde').ascurrency*
                                      QSaldoAnt.fieldbyname('saes_customedio').ascurrency ;

            end;
            PReg_1010.txt_compl  :='';
            TReg_1010.Add( Preg_1010 );


         end else begin

            if xEs = 'E' then
               PREg_1000.qtd_tot_entrada :=  PREg_1000.qtd_tot_entrada + Q.FieldByName('move_qtde').AsCurrency
            else
               PREg_1000.qtd_tot_saida   :=  PREg_1000.qtd_tot_saida + Q.FieldByName('move_qtde').AsCurrency;

            if QSaldoant.Eof then begin

              PReg_1010.qtd        := 0;
              PReg_1010.vl_tot_item:= 0;

            end else begin

              PReg_1010.qtd        := PReg_1010.qtd + QSaldoAnt.fieldbyname('saes_qtde').ascurrency;
              PReg_1010.vl_tot_item:= PReg_1010.vl_tot_item + (
                                      QSaldoAnt.fieldbyname('saes_qtde').ascurrency*
                                      QSaldoAnt.fieldbyname('saes_customedio').ascurrency );

            end;


         end;

         QSaldoant.Close;

      end;

      // totalizador das entradas
      procedure GeraRegistro1100;
      //////////////////////////
      var p:integer;
      begin

         New( PREg_1100 );
         PReg_1100.QTD_TOT_ENTRADA              := 0;
         PReg_1100.MENOR_VL_UNIT_ITEM           := 0;
         PReg_1100.VL_BC_ICMSST_UNIT_MED        := 0;
         PReg_1100.VL_TOT_ICMS_SUPORT_ENTR      := 0;
         PReg_1100.VL_UNIT_MED_ICMS_SUPORT_ENTR := 0;
         PReg_1100.VL_UNIT_MED_ICMS_SUPORT_ENTR := 0;
         TReg_1100.Add( PReg_1100);

         PReg_1100 := TREg_1100[0];

         for p := 0 to TREg_1110.Count-1 do begin

             PReg_1110 := TREg_1110[p];
             PReg_1100.QTD_TOT_ENTRADA := PReg_1100.QTD_TOT_ENTRADA + PReg_1110.qtd_entrada;
             if (PREg_1100.MENOR_VL_UNIT_ITEM>0) then begin

                 if PREg_1100.MENOR_VL_UNIT_ITEM > PREg_1110.VL_UNIT_ITEM then
                    PREg_1100.MENOR_VL_UNIT_ITEM := PREg_1110.VL_UNIT_ITEM;

             end else

                PREg_1100.MENOR_VL_UNIT_ITEM := PREg_1110.VL_UNIT_ITEM;

             PReg_1100.VL_BC_ICMSST_UNIT_MED   := PReg_1110.VL_BC_ICMS_ST/PReg_1100.QTD_TOT_ENTRADA;
             PReg_1100.VL_TOT_ICMS_SUPORT_ENTR := PReg_1100.VL_TOT_ICMS_SUPORT_ENTR +
                                                  PReg_1110.VL_ICMS_SUPORT_ENTR;
             PReg_1100.VL_UNIT_MED_ICMS_SUPORT_ENTR := PReg_1100.VL_TOT_ICMS_SUPORT_ENTR/PReg_1100.QTD_TOT_ENTRADA;


         end;

      end;


      // totalizador das saidas para cons. final no estado
      procedure GeraRegistro1200;
      //////////////////////////
      var p:integer;
      begin

         New( PREg_1200 );
         PReg_1200.QTD_TOT_SAIDA              := 0;
         PReg_1200.VL_TOT_ICMS_EFETIVO        := 0;
         PReg_1200.VL_CONFRONTO_ICMS_ENTRADA  := 0;
         PReg_1200.RESULT_RECUPERAR_RESSARCIR := 0;
         PReg_1200.RESULT_COMPLEMENTAR := 0;
         PReg_1200.APUR_ICMSST_RECUPERAR_RESSARCIR := 0;
         PReg_1200.APUR_ICMSST_COMPLEMENTAR := 0;
         PReg_1200.APUR_FECOP_RESSARCIR := 0;
         PReg_1200.APUR_FECOP_COMPLEMENTAR := 0;
         TReg_1200.Add( PReg_1200);

         PReg_1200 := TREg_1200[0];
         PReg_1000 := TREg_1000[0];

         for p := 0 to TREg_1210.Count-1 do begin

             PReg_1210 := TREg_1210[p];
             PReg_1200.QTD_TOT_SAIDA := PReg_1200.QTD_TOT_SAIDA + PReg_1210.qtd_saida;

             PReg_1200.VL_TOT_ICMS_EFETIVO        := PReg_1200.VL_TOT_ICMS_EFETIVO +
                                                     PReg_1210.VL_ICMS_EFET;

         end;
// devolucoes
         for p := 0 to TREg_1320.Count-1 do begin

             PReg_1320 := TREg_1320[p];
             PReg_1200.QTD_TOT_SAIDA := PReg_1200.QTD_TOT_SAIDA - PReg_1320.qtd_devolvida;
         end;

             PReg_1200.VL_CONFRONTO_ICMS_ENTRADA  := PReg_1200.QTD_TOT_SAIDA *
                                                     PReg_1100.VL_UNIT_MED_ICMS_SUPORT_ENTR;
             PReg_1200.RESULT_RECUPERAR_RESSARCIR := PReg_1200.VL_CONFRONTO_ICMS_ENTRADA -
                                                     PReg_1200.VL_TOT_ICMS_EFETIVO;
             if PReg_1200.RESULT_RECUPERAR_RESSARCIR < 0 then
                PReg_1200.RESULT_RECUPERAR_RESSARCIR := 0;

             PReg_1200.RESULT_COMPLEMENTAR     :=   PReg_1200.VL_TOT_ICMS_EFETIVO  -
                                                    PReg_1200.VL_CONFRONTO_ICMS_ENTRADA ;
             if PReg_1200.RESULT_COMPLEMENTAR  >0 then
                PReg_1200.RESULT_COMPLEMENTAR := 0;

             PReg_1200.APUR_ICMSST_RECUPERAR_RESSARCIR := PReg_1200.RESULT_RECUPERAR_RESSARCIR *
                                                          ((PReg_1000.aliq_icms_item - PReg_1000.aliq_fecop)/PReg_1000.aliq_icms_item);

             PReg_1200.APUR_ICMSST_COMPLEMENTAR :=  PReg_1200.RESULT_COMPLEMENTAR*
                                                    ((PReg_1000.aliq_icms_item - PReg_1000.aliq_fecop)/PReg_1000.aliq_icms_item);

             PReg_1200.APUR_FECOP_RESSARCIR := PReg_1200.APUR_FECOP_RESSARCIR *
                                               ( PReg_1000.aliq_fecop / PReg_1000.aliq_icms_item );
             PReg_1200.APUR_FECOP_COMPLEMENTAR :=  PReg_1200.APUR_FECOP_COMPLEMENTAR *
                                               ( PReg_1000.aliq_fecop / PReg_1000.aliq_icms_item );


      end;

      // totalizador das saidas fora do estado
      procedure GeraRegistro1300;
      //////////////////////////
      var p:integer;
      begin

         New( PREg_1300 );
         PReg_1300.QTD_TOT_SAIDA              := 0;
         PReg_1300.VL_TOT_ICMS_EFETIVO        := 0;
         PReg_1300.VL_CONFRONTO_ICMS_ENTRADA  := 0;
         PReg_1300.RESULT_RECUPERAR_RESSARCIR := 0;
         PReg_1300.APUR_ICMSST_RECUPERAR_RESSARCIR := 0;
         PReg_1300.APUR_FECOP_RESSARCIR := 0;
         TReg_1300.Add( PReg_1300);

         PReg_1200 := TREg_1200[0];
         PReg_1000 := TREg_1000[0];
         PReg_1100 := TREg_1100[0];

         for p := 0 to TREg_1310.Count-1 do begin

             PReg_1310 := TREg_1310[p];
             PReg_1300.QTD_TOT_SAIDA := PReg_1300.QTD_TOT_SAIDA + PReg_1310.qtd_saida;
             PReg_1300.VL_TOT_ICMS_EFETIVO        := PReg_1300.VL_TOT_ICMS_EFETIVO +
                                                     PReg_1310.VL_ICMS_EFET;

         end;
// devolucoes
         for p := 0 to TREg_1320.Count-1 do begin

             PReg_1320 := TREg_1320[p];
             PReg_1300.QTD_TOT_SAIDA := PReg_1300.QTD_TOT_SAIDA - PReg_1320.qtd_devolvida;

         end;

             PReg_1300.VL_CONFRONTO_ICMS_ENTRADA  := PReg_1300.QTD_TOT_SAIDA *
                                                     PReg_1100.VL_UNIT_MED_ICMS_SUPORT_ENTR;
             PReg_1300.RESULT_RECUPERAR_RESSARCIR := PReg_1300.VL_CONFRONTO_ICMS_ENTRADA -
                                                     PReg_1300.VL_TOT_ICMS_EFETIVO;
             if PReg_1300.RESULT_RECUPERAR_RESSARCIR < 0 then
                PReg_1300.RESULT_RECUPERAR_RESSARCIR := 0;

             PReg_1300.APUR_FECOP_RESSARCIR := PReg_1300.QTD_TOT_SAIDA *
                                               PReg_1000.aliq_fecop   *
                                               PReg_1100.VL_BC_ICMSST_UNIT_MED;

             PReg_1300.APUR_ICMSST_RECUPERAR_RESSARCIR := PReg_1300.RESULT_RECUPERAR_RESSARCIR -
                                                          PReg_1300.APUR_FECOP_RESSARCIR;


      end;

      // totalizador das saidas simples nacional
      procedure GeraRegistro1500;
      //////////////////////////
      var p:integer;
          mva,
          coeficiente : currency;
          QSt         : TSqlquery;

      begin

         New( PREg_1500 );
         PReg_1500.QTD_TOT_SAIDA              := 0;
         PReg_1500.VL_ICMSST_UNIT_ENTR        := 0;
         PReg_1500.APUR_ICMSST_RECUPERAR_RESSARCIR        := 0;
         TReg_1500.Add( PReg_1500);

         PReg_1200 := TREg_1200[0];
         PReg_1000 := TREg_1000[0];
         PReg_1100 := TREg_1100[0];

         for p := 0 to TREg_1510.Count-1 do begin

             PReg_1510 := TREg_1510[p];
             PReg_1500.QTD_TOT_SAIDA := PReg_1500.QTD_TOT_SAIDA + PReg_1510.qtd_saida ;


         end;
// devolucoes
         for p := 0 to TREg_1520.Count-1 do begin

             PReg_1520 := TREg_1520[p];
             PReg_1500.QTD_TOT_SAIDA := PReg_1500.QTD_TOT_SAIDA - PReg_1520.qtd_devolvida;

         end;

        QSt:=sqltoquery('select cfis_percbase from codigosfis where cfis_aliquota = '+
                        ValorToSql(PReg_1000.aliq_icms_item)+
                        ' and cfis_percbase > 0 ');
        mva := QSt.FieldByName('cfis_percbase').AsCurrency;
        if PReg_1000.aliq_icms_item = 18  then coeficiente := 70/100
                                          else coeficiente := 50/100;

        PReg_1500.VL_ICMSST_UNIT_ENTR  :=  ( PReg_1100.VL_BC_ICMSST_UNIT_MED/( 1 + mva ) ) *
                                           ( mva/coeficiente ) *
                                           PReg_1000.aliq_icms_item;
        PReg_1500.APUR_ICMSST_RECUPERAR_RESSARCIR := PReg_1500.VL_ICMSST_UNIT_ENTR * PReg_1500.QTD_TOT_SAIDA;

      end;


      // notas de entrada
      procedure  GeraRegistro1110;
      ////////////////////////////
      begin

          New( PReg_1110 );
          PReg_1110.dt_doc        := Q.FieldByName('moes_datamvto').AsDateTime;
          PReg_1110.COD_RESP_RET  := '1' ;   // 1- remetente direto
          PReg_1110.CST_CSOSN     := Q.FieldByName('move_cst').AsString ;
          PReg_1110.Chave         := Q.FieldByName('moes_chavenfe').AsString ;
          PReg_1110.n_nf          := Q.FieldByName('moes_numerodoc').AsInteger ;
          PReg_1110.cnpj_emit     := GetCnpj( Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString ) ;
          PReg_1110.uf_emit       := GetUF( Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString );
          PReg_1110.cnpj_dest     := EdUnid_codigo.ResultFind.FieldByName('unid_cnpj').AsString  ;
          PReg_1110.uf_dest       := EdUnid_codigo.ResultFind.FieldByName('unid_uf').AsString  ;
          if Q.fieldbyname('move_natf_codigo').asstring = null then
             PReg_1110.cfop       := Q.fieldbyname('moes_natf_codigo').asstring
          else
             PReg_1110.cfop       := Q.fieldbyname('move_natf_codigo').asstring;
          PReg_1110.n_item        := 0;  // ver numerar depois OU pegar do xml ( se tiver )...
          PReg_1110.unid_item     := Q.fieldbyname('esto_unidade').asstring;
          PReg_1110.qtd_entrada   := Q.fieldbyname('move_qtde').ascurrency;
          PReg_1110.VL_UNIT_ITEM  := Q.fieldbyname('move_venda').ascurrency;
          PReg_1110.VL_BC_ICMS_ST := GetBaseST;
          PReg_1110.VL_ICMS_SUPORT_ENTR := GetvalorIcmsSuportado;
          TReg_1110.add( Preg_1110 );

      end;

      // notas de saida para consumidor final
      procedure  GeraRegistro1210;
      ////////////////////////////
      begin

          New( PReg_1210 );
          PReg_1210.dt_doc        := Q.FieldByName('moes_datamvto').AsDateTime;
          PReg_1210.CST_CSOSN     := Q.FieldByName('move_cst').AsString ;
          PReg_1210.Chave         := Q.FieldByName('moes_chavenfe').AsString ;
          PReg_1210.n_nf          := Q.FieldByName('moes_numerodoc').AsInteger ;
          PReg_1210.cnpj_emit     := GetCnpj( Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString ) ;
          PReg_1210.uf_emit       := GetUF( Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString );
          PReg_1210.cnpj_cpf_dest     := EdUnid_codigo.ResultFind.FieldByName('unid_cnpj').AsString  ;
          PReg_1210.uf_dest       := EdUnid_codigo.ResultFind.FieldByName('unid_uf').AsString  ;
          if Q.fieldbyname('move_natf_codigo').asstring = null then
             PReg_1210.cfop       := Q.fieldbyname('moes_natf_codigo').asstring
          else
             PReg_1210.cfop       := Q.fieldbyname('move_natf_codigo').asstring;
          PReg_1210.n_item        := 0;  // ver numerar depois OU pegar do xml ( se tiver )...
          PReg_1210.unid_item     := Q.fieldbyname('esto_unidade').asstring;
          PReg_1210.qtd_saida     := Q.fieldbyname('move_qtde').ascurrency;
          PReg_1210.VL_UNIT_ITEM  := Q.fieldbyname('move_venda').ascurrency;
          PReg_1210.VL_ICMS_EFET := GetvalorIcmsSuportado;
          TReg_1210.add( Preg_1210 );

      end;

      // notas de saida fora do estado
      procedure  GeraRegistro1310;
      ////////////////////////////
      begin

          New( PReg_1310 );
          PReg_1310.dt_doc        := Q.FieldByName('moes_datamvto').AsDateTime;
          PReg_1310.CST_CSOSN     := Q.FieldByName('move_cst').AsString ;
          PReg_1310.Chave         := Q.FieldByName('moes_chavenfe').AsString ;
          PReg_1310.n_nf          := Q.FieldByName('moes_numerodoc').AsInteger ;
          PReg_1310.cnpj_emit     := GetCnpj( Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString ) ;
          PReg_1310.uf_emit       := GetUF( Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString );
          PReg_1310.cnpj_cpf_dest     := EdUnid_codigo.ResultFind.FieldByName('unid_cnpj').AsString  ;
          PReg_1310.uf_dest       := EdUnid_codigo.ResultFind.FieldByName('unid_uf').AsString  ;
          if Q.fieldbyname('move_natf_codigo').asstring = null then
             PReg_1310.cfop       := Q.fieldbyname('moes_natf_codigo').asstring
          else
             PReg_1310.cfop       := Q.fieldbyname('move_natf_codigo').asstring;
          PReg_1310.n_item        := 0;  // ver numerar depois OU pegar do xml ( se tiver )...
          PReg_1310.unid_item     := Q.fieldbyname('esto_unidade').asstring;
          PReg_1310.qtd_saida     := Q.fieldbyname('move_qtde').ascurrency;
          PReg_1310.VL_UNIT_ITEM  := Q.fieldbyname('move_venda').ascurrency;
          PReg_1310.VL_ICMS_EFET := GetvalorIcmsSuportado;
          TReg_1310.add( Preg_1310 );

      end;

      // notas de saida para consumidor final
      procedure  GeraRegistro1510;
      ////////////////////////////
      begin

          New( PReg_1510 );
          PReg_1510.dt_doc        := Q.FieldByName('moes_datamvto').AsDateTime;
          PReg_1510.CST_CSOSN     := Q.FieldByName('move_cst').AsString ;
          PReg_1510.Chave         := Q.FieldByName('moes_chavenfe').AsString ;
          PReg_1510.n_nf          := Q.FieldByName('moes_numerodoc').AsInteger ;
          PReg_1510.cnpj_emit     := GetCnpj( Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString ) ;
          PReg_1510.uf_emit       := GetUF( Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString );
          PReg_1510.cnpj_dest     := EdUnid_codigo.ResultFind.FieldByName('unid_cnpj').AsString  ;
          PReg_1510.uf_dest       := EdUnid_codigo.ResultFind.FieldByName('unid_uf').AsString  ;
          if Q.fieldbyname('move_natf_codigo').asstring = null then
             PReg_1510.cfop       := Q.fieldbyname('moes_natf_codigo').asstring
          else
             PReg_1510.cfop       := Q.fieldbyname('move_natf_codigo').asstring;
          PReg_1510.n_item        := 0;  // ver numerar depois OU pegar do xml ( se tiver )...
          PReg_1510.unid_item     := Q.fieldbyname('esto_unidade').asstring;
          PReg_1510.qtd_saida     := Q.fieldbyname('move_qtde').ascurrency;
          PReg_1510.VL_UNIT_ITEM  := Q.fieldbyname('move_venda').ascurrency;
          TReg_1510.add( Preg_1510 );

      end;


      // notas de devolu��o de saida para consumidor final
      procedure  GeraRegistro1220;
      ////////////////////////////
      begin

          New( PReg_1220 );
          PReg_1220.dt_doc        := Q.FieldByName('moes_datamvto').AsDateTime;
          PReg_1220.CST_CSOSN     := Q.FieldByName('move_cst').AsString ;
          PReg_1220.Chave         := Q.FieldByName('moes_chavenfe').AsString ;
          PReg_1220.n_nf          := Q.FieldByName('moes_numerodoc').AsInteger ;
          PReg_1220.cnpj_emit     := GetCnpj( Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString ) ;
          PReg_1220.uf_emit       := GetUF( Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString );
          PReg_1220.cnpj_cpf_dest     := EdUnid_codigo.ResultFind.FieldByName('unid_cnpj').AsString  ;
          PReg_1220.uf_dest       := EdUnid_codigo.ResultFind.FieldByName('unid_uf').AsString  ;
          if Q.fieldbyname('move_natf_codigo').asstring = null then
             PReg_1220.cfop       := Q.fieldbyname('moes_natf_codigo').asstring
          else
             PReg_1220.cfop       := Q.fieldbyname('move_natf_codigo').asstring;
          PReg_1220.n_item        := 0;  // ver numerar depois OU pegar do xml ( se tiver )...
          PReg_1220.unid_item     := Q.fieldbyname('esto_unidade').asstring;
          PReg_1220.qtd_devolvida := Q.fieldbyname('move_qtde').ascurrency;
          PReg_1220.VL_UNIT_ITEM  := Q.fieldbyname('move_venda').ascurrency;
          PReg_1220.VL_ICMS_EFETIVO := GetvalorIcmsSuportado;
          PReg_1220.chave_ref     := Q.FieldByName('moes_chavenferef').AsString;
          TReg_1220.add( Preg_1220 );

      end;

      // notas de devolu��o de saida fora do estado
      procedure  GeraRegistro1320;
      ////////////////////////////
      begin

          New( PReg_1320 );
          PReg_1320.dt_doc        := Q.FieldByName('moes_datamvto').AsDateTime;
          PReg_1320.CST_CSOSN     := Q.FieldByName('move_cst').AsString ;
          PReg_1320.Chave         := Q.FieldByName('moes_chavenfe').AsString ;
          PReg_1320.n_nf          := Q.FieldByName('moes_numerodoc').AsInteger ;
          PReg_1320.cnpj_emit     := GetCnpj( Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString ) ;
          PReg_1320.uf_emit       := GetUF( Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString );
          PReg_1320.cnpj_cpf_dest     := EdUnid_codigo.ResultFind.FieldByName('unid_cnpj').AsString  ;
          PReg_1320.uf_dest       := EdUnid_codigo.ResultFind.FieldByName('unid_uf').AsString  ;
          if Q.fieldbyname('move_natf_codigo').asstring = null then
             PReg_1320.cfop       := Q.fieldbyname('moes_natf_codigo').asstring
          else
             PReg_1320.cfop       := Q.fieldbyname('move_natf_codigo').asstring;
          PReg_1320.n_item        := 0;  // ver numerar depois OU pegar do xml ( se tiver )...
          PReg_1320.unid_item     := Q.fieldbyname('esto_unidade').asstring;
          PReg_1320.qtd_devolvida := Q.fieldbyname('move_qtde').ascurrency;
          PReg_1320.VL_UNIT_ITEM  := Q.fieldbyname('move_venda').ascurrency;
//          PReg_1320.VL_ICMS_EFETIVO := GetvalorIcmsSuportado;
          PReg_1320.chave_ref     := Q.FieldByName('moes_chavenferef').AsString;
          TReg_1320.add( Preg_1320 );

      end;

      // notas de devolu��o de saida para cliente do simples nacional  dentro do estado
      procedure  GeraRegistro1520;
      ////////////////////////////
      begin

          New( PReg_1520 );
          PReg_1520.dt_doc        := Q.FieldByName('moes_datamvto').AsDateTime;
          PReg_1520.CST_CSOSN     := Q.FieldByName('move_cst').AsString ;
          PReg_1520.Chave         := Q.FieldByName('moes_chavenfe').AsString ;
          PReg_1520.n_nf          := Q.FieldByName('moes_numerodoc').AsInteger ;
          PReg_1520.cnpj_emit     := GetCnpj( Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString ) ;
          PReg_1520.uf_emit       := GetUF( Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString );
          PReg_1520.cnpj_dest     := EdUnid_codigo.ResultFind.FieldByName('unid_cnpj').AsString  ;
          PReg_1520.uf_dest       := EdUnid_codigo.ResultFind.FieldByName('unid_uf').AsString  ;
          if Q.fieldbyname('move_natf_codigo').asstring = null then
             PReg_1520.cfop       := Q.fieldbyname('moes_natf_codigo').asstring
          else
             PReg_1520.cfop       := Q.fieldbyname('move_natf_codigo').asstring;
          PReg_1520.n_item        := 0;  // ver numerar depois OU pegar do xml ( se tiver )...
          PReg_1520.unid_item     := Q.fieldbyname('esto_unidade').asstring;
          PReg_1520.qtd_devolvida := Q.fieldbyname('move_qtde').ascurrency;
          PReg_1520.VL_UNIT_ITEM  := Q.fieldbyname('move_venda').ascurrency;
//          PReg_1520.VL_ICMS_EFETIVO := GetvalorIcmsSuportado;
          PReg_1520.chave_ref     := Q.FieldByName('moes_chavenferef').AsString;
          TReg_1520.add( Preg_1520 );

      end;



      // dados da empresa
      function GetReg_0000:string;
      ////////////////////////////
      begin

          New(PReg_0000);
          PReg_0000.mes_ano := EdMesano.Text;
          PReg_0000.cnpj    := EdUnid_codigo.ResultFind.FieldByName('unid_cnpj').AsString;
          PReg_0000.ie      := EdUnid_codigo.ResultFind.FieldByName('unid_inscricaoestadual').AsString;
          PReg_0000.cd_fin  := EdFinalidade.text;
          PReg_0000.n_reg_especial := '';   // se tiver � o numero do regime especial
          PReg_0000.cnpj_cd := '';   // cnpj se for centro de distrib. ( CD )
          PReg_0000.ie_cd   := '';   // ie se for centro de distrib. ( CD )
          TREg_0000.Add(Preg_0000);
          result := '0000'+sep+
                    '100'+sep+   // versao do layout
                     PREg_0000.mes_ano+sep+
                     PReg_0000.cnpj+sep+
                     PReg_0000.ie+sep+
                     PReg_0000.cd_fin+sep+
                     PReg_0000.n_reg_especial+sep+
                     PReg_0000.cnpj_cd+sep+
                     PReg_0000.ie_cd ;
      end;


      // cadastro do estoque
      function GetReg_1000:string;
      /////////////////////////////
      begin

         result := '1000'+sep+

                   PReg_1000.ind_fecop+sep+
                   PReg_1000.cod_item+sep+
                   PReg_1000.cod_barras+sep+
                   PReg_1000.cod_anp+sep+
                   PReg_1000.ncm+sep+
                   copy(PReg_1000.cest,1,7)+sep+
                   PReg_1000.descr_item+sep+
                   PReg_1000.unid_item+sep+
                   FGeral.Formatavalor( PReg_1000.aliq_icms_item,'#0.00')+sep+
                   FGeral.Formatavalor( PReg_1000.aliq_fecop,'0.00')+sep+
                   FGeral.Formatavalor( PReg_1000.qtd_tot_entrada,'########0.000' )+sep+
                   FGeral.Formatavalor( PReg_1000.qtd_tot_saida,'########0.000' ) ;

      end;


      // totalizador das entradas
      function GetReg_1100:string;
      /////////////////////////////
      begin

         result := '1100'+sep+
                   FGeral.Formatavalor( PReg_1100.QTD_TOT_ENTRADA ,'########0.000')+sep+
                   FGeral.Formatavalor( PReg_1100.MENOR_VL_UNIT_ITEM ,'########0.00')+sep+
                   FGeral.Formatavalor( PReg_1100.VL_BC_ICMSST_UNIT_MED ,'########0.00')+sep+
                   FGeral.Formatavalor( PReg_1100.VL_TOT_ICMS_SUPORT_ENTR ,'########0.00')+sep+
                   FGeral.Formatavalor( PReg_1100.VL_UNIT_MED_ICMS_SUPORT_ENTR ,'########0.00') ;

      end;

      // totalizador das saidas para consumidor final no estado
      function GetReg_1200:string;
      /////////////////////////////
      begin

         result := '1200'+sep+
                   FGeral.Formatavalor( PReg_1200.QTD_TOT_SAIDA ,'########0.000')+sep+
                   FGeral.Formatavalor( PReg_1200.VL_TOT_ICMS_EFETIVO ,'########0.00')+sep+
                   FGeral.Formatavalor( PReg_1200.VL_CONFRONTO_ICMS_ENTRADA ,'########0.00')+sep+
                   FGeral.Formatavalor( PReg_1200.RESULT_RECUPERAR_RESSARCIR ,'########0.00')+sep+
                   FGeral.Formatavalor( PReg_1200.RESULT_COMPLEMENTAR ,'########0.00')+sep+
                   FGeral.Formatavalor( PReg_1200.APUR_ICMSST_RECUPERAR_RESSARCIR ,'########0.00')+sep+
                   FGeral.Formatavalor( PReg_1200.APUR_ICMSST_COMPLEMENTAR ,'########0.00')+sep+
                   FGeral.Formatavalor( PReg_1200.APUR_FECOP_RESSARCIR ,'########0.00')+sep+
                   FGeral.Formatavalor( PReg_1200.APUR_FECOP_COMPLEMENTAR ,'########0.00');

      end;

      // totalizador das saidas para fora do estado
      function GetReg_1300:string;
      /////////////////////////////
      begin

         result := '1300'+sep+
                   FGeral.Formatavalor( PReg_1300.QTD_TOT_SAIDA ,'########0.000')+sep+
                   FGeral.Formatavalor( PReg_1300.VL_TOT_ICMS_EFETIVO ,'########0.00')+sep+
                   FGeral.Formatavalor( PReg_1300.VL_CONFRONTO_ICMS_ENTRADA ,'########0.00')+sep+
                   FGeral.Formatavalor( PReg_1300.RESULT_RECUPERAR_RESSARCIR ,'########0.00')+sep+
                   FGeral.Formatavalor( PReg_1300.APUR_ICMSST_RECUPERAR_RESSARCIR ,'########0.00')+sep+
                   FGeral.Formatavalor( PReg_1300.APUR_FECOP_RESSARCIR ,'########0.00');

      end;

      // totalizador das saidas para simples nacional
      function GetReg_1500:string;
      /////////////////////////////
      begin

         result := '1500'+sep+
                   FGeral.Formatavalor( PReg_1500.QTD_TOT_SAIDA ,'########0.000')+sep+
                   FGeral.Formatavalor( PReg_1500.VL_ICMSST_UNIT_ENTR ,'########0.00')+sep+
                   FGeral.Formatavalor( PReg_1500.APUR_ICMSST_RECUPERAR_RESSARCIR ,'########0.00');

      end;

      // inventario mes anterior
      function GetReg_1010:string;
      /////////////////////////////
      begin

         result := '1010'+sep+
                   PReg_1010.cod_item+sep+
                   PReg_1010.unid_item+sep+
                   FGeral.Formatavalor( PReg_1010.QTD ,'########0.000')+sep+
                   FGeral.Formatavalor( PReg_1010.vl_tot_item ,'########0.00')+sep+
                   PReg_1010.txt_compl;

      end;

      // itens das notas de entrada
      function GetReg_1110:string;
      /////////////////////////////
      begin

         result := '1110'+sep+
                   FormatDatetime('ddmmyyy',PREg_1110.dt_doc)+sep+
                   PReg_1110.COD_RESP_RET+sep+
                   PReg_1110.CST_CSOSN+sep+
                   PReg_1110.chave+sep+
                   strzero(PReg_1110.n_nf,09)+sep+
                   PReg_1110.cnpj_emit+sep+
                   PReg_1110.uf_emit+sep+
                   PReg_1110.cnpj_dest+sep+
                   PReg_1110.uf_dest+sep+
                   PReg_1110.cfop+sep+
                   strzero(PReg_1110.n_item,3)+sep+
                   PReg_1110.unid_item+sep+
                   FGeral.Formatavalor( PReg_1110.qtd_entrada,'########0.000' )+sep+
                   FGeral.Formatavalor( PReg_1110.vl_unit_item,'########0.00' )+sep+
                   FGeral.Formatavalor( PReg_1110.VL_BC_ICMS_ST,'########0.00' )+sep+
                   FGeral.Formatavalor( PReg_1110.VL_ICMS_SUPORT_ENTR,'########0.00' );

      end;

      // itens das notas de saida para consumidor final
      function GetReg_1210:string;
      /////////////////////////////
      begin

         result := '1210'+sep+
                   FormatDatetime('ddmmyyy',PREg_1210.dt_doc)+sep+
                   PReg_1210.CST_CSOSN+sep+
                   PReg_1210.chave+sep+
                   strzero(PReg_1210.n_nf,09)+sep+
                   PReg_1210.cnpj_emit+sep+
                   PReg_1210.uf_emit+sep+
                   PReg_1210.cnpj_cpf_dest+sep+
                   PReg_1210.uf_dest+sep+
                   PReg_1210.cfop+sep+
                   strzero(PReg_1210.n_item,3)+sep+
                   PReg_1210.unid_item+sep+
                   FGeral.Formatavalor( PReg_1210.qtd_saida,'########0.000' )+sep+
                   FGeral.Formatavalor( PReg_1210.vl_unit_item,'########0.00' )+sep+
                   FGeral.Formatavalor( PReg_1210.VL_ICMS_EFET,'########0.00' );

      end;

      // itens das notas de saida para fora do estado
      function GetReg_1310:string;
      /////////////////////////////
      begin

         result := '1310'+sep+
                   FormatDatetime('ddmmyyy',PREg_1310.dt_doc)+sep+
                   PReg_1310.CST_CSOSN+sep+
                   PReg_1310.chave+sep+
                   strzero(PReg_1310.n_nf,09)+sep+
                   PReg_1310.cnpj_emit+sep+
                   PReg_1310.uf_emit+sep+
                   PReg_1310.cnpj_cpf_dest+sep+
                   PReg_1310.uf_dest+sep+
                   PReg_1310.cfop+sep+
                   strzero(PReg_1310.n_item,3)+sep+
                   PReg_1310.unid_item+sep+
                   FGeral.Formatavalor( PReg_1310.qtd_saida,'########0.000' )+sep+
                   FGeral.Formatavalor( PReg_1310.vl_unit_item,'########0.00' )+sep+
                   FGeral.Formatavalor( PReg_1310.VL_ICMS_EFET,'########0.00' );

      end;

      // itens das notas de saida para simples nacional
      function GetReg_1510:string;
      /////////////////////////////
      begin

         result := '1510'+sep+
                   FormatDatetime('ddmmyyy',PREg_1510.dt_doc)+sep+
                   PReg_1510.CST_CSOSN+sep+
                   PReg_1510.chave+sep+
                   strzero(PReg_1510.n_nf,09)+sep+
                   PReg_1510.cnpj_emit+sep+
                   PReg_1510.uf_emit+sep+
                   PReg_1510.cnpj_dest+sep+
                   PReg_1510.uf_dest+sep+
                   PReg_1510.cfop+sep+
                   strzero(PReg_1510.n_item,3)+sep+
                   PReg_1510.unid_item+sep+
                   FGeral.Formatavalor( PReg_1510.qtd_saida,'########0.000' )+sep+
                   FGeral.Formatavalor( PReg_1510.vl_unit_item,'########0.00' );

      end;


// itens das notas de devolucao de saida para consumidor final
      function GetReg_1220:string;
      /////////////////////////////
      begin

         result := '1220'+sep+
                   FormatDatetime('ddmmyyy',PREg_1220.dt_doc)+sep+
                   PReg_1220.CST_CSOSN+sep+
                   PReg_1220.chave+sep+
                   strzero(PReg_1220.n_nf,09)+sep+
                   PReg_1220.cnpj_emit+sep+
                   PReg_1220.uf_emit+sep+
                   PReg_1220.cnpj_cpf_dest+sep+
                   PReg_1220.uf_dest+sep+
                   PReg_1220.cfop+sep+
                   strzero(PReg_1220.n_item,3)+sep+
                   PReg_1220.unid_item+sep+
                   FGeral.Formatavalor( PReg_1220.qtd_devolvida,'########0.000' )+sep+
                   FGeral.Formatavalor( PReg_1220.vl_unit_item,'########0.00' )+sep+
                   FGeral.Formatavalor( PReg_1220.VL_ICMS_EFETIVO,'########0.00' )+sep+
                   PReg_1220.chave_ref+sep+
                   strzero(PReg_1220.N_ITEM_REF,3);

      end;

      // itens das notas de devolucao de saida fora do estado
      function GetReg_1320:string;
      /////////////////////////////
      begin

         result := '1320'+sep+
                   FormatDatetime('ddmmyyy',PREg_1320.dt_doc)+sep+
                   PReg_1320.CST_CSOSN+sep+
                   PReg_1320.chave+sep+
                   strzero(PReg_1320.n_nf,09)+sep+
                   PReg_1320.cnpj_emit+sep+
                   PReg_1320.uf_emit+sep+
                   PReg_1320.cnpj_cpf_dest+sep+
                   PReg_1320.uf_dest+sep+
                   PReg_1320.cfop+sep+
                   strzero(PReg_1320.n_item,3)+sep+
                   PReg_1320.unid_item+sep+
                   FGeral.Formatavalor( PReg_1320.qtd_devolvida,'########0.000' )+sep+
                   FGeral.Formatavalor( PReg_1320.vl_unit_item,'########0.00' )+sep+
                   FGeral.Formatavalor( PReg_1320.VL_ICMS_EFETIVO,'########0.00' )+sep+
                   PReg_1320.chave_ref+sep+
                   strzero(PReg_1320.N_ITEM_REF,3);

      end;


      // itens das notas de devolucao de saida dentro do estado para clientes do simples nacional
      function GetReg_1520:string;
      /////////////////////////////
      begin

         result := '1520'+sep+
                   FormatDatetime('ddmmyyy',PREg_1520.dt_doc)+sep+
                   PReg_1520.CST_CSOSN+sep+
                   PReg_1520.chave+sep+
                   strzero(PReg_1520.n_nf,09)+sep+
                   PReg_1520.cnpj_emit+sep+
                   PReg_1520.uf_emit+sep+
                   PReg_1520.cnpj_dest+sep+
                   PReg_1520.uf_dest+sep+
                   PReg_1520.cfop+sep+
                   strzero(PReg_1520.n_item,3)+sep+
                   PReg_1520.unid_item+sep+
                   FGeral.Formatavalor( PReg_1520.qtd_devolvida,'########0.000' )+sep+
                   FGeral.Formatavalor( PReg_1520.vl_unit_item,'########0.00' )+sep+
                   FGeral.Formatavalor( PReg_1520.VL_ICMS_EFETIVO,'########0.00' )+sep+
                   PReg_1520.chave_ref+sep+
                   strzero(PReg_1520.N_ITEM_REF,3);

      end;


      function GetReg_9000:string;
      ////////////////////////////
      begin

          PReg_1200 := TReg_1200[0];
          PReg_1300 := TReg_1300[0];
//          PReg_1400 := TReg_1400[0];
          PReg_1500 := TReg_1500[0];
          New(PReg_9000);
          PReg_9000.REG1200_ICMSST_RECUPERAR_RESSARCIR :=0;
          PReg_9000.REG1200_ICMSST_COMPLEMENTAR        :=0;
          PReg_9000.REG1300_ICMSST_RECUPERAR_RESSARCIR :=0;
          PReg_9000.REG1500_ICMSST_RECUPERAR_RESSARCIR :=0;
          PReg_9000.REG1400_ICMSST_RECUPERAR_RESSARCIR :=0;
          PReg_9000.REG1500_ICMSST_RECUPERAR_RESSARCIR :=0;
          PReg_9000.REG9000_FECOP_RESSARCIR            :=0;
          PReg_9000.REG9000_FECOP_COMPLEMENTAR         :=0;

          if PREg_1200.APUR_ICMSST_RECUPERAR_RESSARCIR >= PREg_1200.APUR_ICMSST_COMPLEMENTAR then begin

             PReg_9000.REG1200_ICMSST_RECUPERAR_RESSARCIR := PREg_1200.APUR_ICMSST_RECUPERAR_RESSARCIR -
                                                             PREg_1200.APUR_ICMSST_COMPLEMENTAR;
             PReg_9000.REG1200_ICMSST_COMPLEMENTAR        := 0;

          end else  begin

             PReg_9000.REG1200_ICMSST_RECUPERAR_RESSARCIR := 0;
             PReg_9000.REG1200_ICMSST_COMPLEMENTAR        := PREg_1200.APUR_ICMSST_RECUPERAR_RESSARCIR -
                                                             PREg_1200.APUR_ICMSST_COMPLEMENTAR;

          end;

          PReg_9000.REG1300_ICMSST_RECUPERAR_RESSARCIR :=  PReg_1300.APUR_ICMSST_RECUPERAR_RESSARCIR;
//          PReg_9000.REG1400_ICMSST_RECUPERAR_RESSARCIR :=  PReg_1400.APUR_ICMSST_RECUPERAR_RESSARCIR;
          PReg_9000.REG1500_ICMSST_RECUPERAR_RESSARCIR :=  PReg_1500.APUR_ICMSST_RECUPERAR_RESSARCIR;
          PReg_9000.REG9000_FECOP_RESSARCIR            :=  PReg_1200.APUR_FECOP_RESSARCIR +
                                                           PReg_1300.APUR_FECOP_RESSARCIR +
                                                           PREg_1200.APUR_FECOP_COMPLEMENTAR ;
          if PReg_9000.REG9000_FECOP_RESSARCIR <0 then
             PReg_9000.REG9000_FECOP_RESSARCIR :=0;

          PReg_9000.REG9000_FECOP_RESSARCIR            :=  PReg_1200.APUR_FECOP_RESSARCIR +
                                                           PReg_1300.APUR_FECOP_RESSARCIR -
                                                           PReg_1200.APUR_FECOP_COMPLEMENTAR;
          if PReg_9000.REG9000_FECOP_RESSARCIR > 0 then
             PReg_9000.REG9000_FECOP_RESSARCIR :=0;

          TREg_9000.Add(Preg_9000);
          result := '9000'+sep+
                   FGeral.Formatavalor( PReg_9000.REG1200_ICMSST_RECUPERAR_RESSARCIR,'########0.00' )+sep+
                   FGeral.Formatavalor( PReg_9000.REG1200_ICMSST_COMPLEMENTAR,'########0.00' )+sep+
                   FGeral.Formatavalor( PReg_9000.REG1300_ICMSST_RECUPERAR_RESSARCIR,'########0.00' )+sep+
                   FGeral.Formatavalor( PReg_9000.REG1400_ICMSST_RECUPERAR_RESSARCIR,'########0.00' )+sep+
                   FGeral.Formatavalor( PReg_9000.REG1500_ICMSST_RECUPERAR_RESSARCIR,'########0.00' )+sep+
                   FGeral.Formatavalor( PReg_9000.REG9000_FECOP_RESSARCIR,'########0.00' )+sep+
                   FGeral.Formatavalor( PReg_9000.REG9000_FECOP_COMPLEMENTAR,'########0.00' );

      end;


begin
//////////////////////////////////////////

  if not EdUnid_codigo.validfind then exit;
  if not EdUnid_codigo.valid then exit;
  if not EdTermino.valid then exit;

  if not confirma('Confirma gera��o do arquivo do ADRC-ST ?') then exit;

  texto.clear;

  TReg_0000 := TList.create;
  TReg_9000 := TList.create;
  TReg_1000 := TList.create;
  TReg_1010 := TList.create;
  TReg_1100 := TList.create;
  TReg_1200 := TList.create;
  TReg_1300 := TList.create;
  TReg_1500 := TList.create;
  TReg_1110 := TList.create;
  TReg_1210 := TList.create;
  TReg_1310 := TList.create;
  TReg_1510 := TList.create;
  TReg_1220 := TList.create;
  TReg_1320 := TList.create;
  TReg_1520 := TList.create;

  nomearq:='ADRC_SF'+EdUnid_codigo.text+copy(EdTermino.text,3,4)+'.TXT';

  sistema.beginprocess('Pesquisando notas de entrada');
  tiposnao:=Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai+';'+Global.CodEntradaSemItens+';'+
            Global.CodPrestacaoServicos+';'+Global.CodPrestacaoServicosE+';'+Global.CodRomaneioRemessaaOrdem+';'+
            Global.Codvendainterna+';'+Global.CodVendaSemfinan+';'+Global.CodCedulaProdutoRural;

  TiposDevolucao:=Global.CodDevolucaoCompra+';'+Global.CodDevolucaoCompraSemEstoque+';'+
                  Global.CodDevolucaoIgualVenda+';'+Global.CodDevolucaoInd+';'+
                  Global.CodDevolucaoSimbolicaConsig+';'+
                  Global.CodDevolucaodeRemessa+';'+
                  Global.CodDevolucaoRoman+';'+
                  Global.CodDevolucaoTributada+';'+
                  Global.CodDevolucaoTributadaCliente+';'+
                  Global.CodDevolucaoSaida;

  SqlunidadesDet:=' and move_unid_codigo='+EdUnid_codigo.assql;

  Q:=sqltoquery('select * from movestoque'+
                ' inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                ' inner join estoque on ( move_esto_codigo=esto_codigo )'+
                ' inner join natureza on (natf_codigo=moes_natf_codigo)'+
                ' where '+FGeral.Getin('move_status','N;X;E;D;Y;I','C')+
                ' and moes_datamvto>='+EdInicio.assql+
                ' and '+FGeral.Getin('moes_status','N;X;E;D;Y;I','C')+
                ' and move_datamvto>='+EdInicio.assql+
                ' and move_datamvto<='+EdTermino.assql+
                ' and '+FGeral.GetNOTIN('moes_serie','F;F ','C')+
                ' and '+FGeral.GetNOTIN('moes_especie','CF;CF ;','C')+
                ' and '+FGeral.GetNOTIN('moes_tipomov',tiposnao+';'+Global.CodConhecimento+';'+global.CodConhecimentoSaida,'C')+
                ' and '+FGeral.GetIN('moes_tipomov',Global.TiposEntrada,'C')+
                ' and move_datacont is not null'+
                sqlunidadesdet+
                ' and moes_natf_codigo is not null'+
                ' order by move_transacao,move_datamvto,move_numerodoc,move_aliicms' );
  if Q.eof then begin
    Avisoerro('Nada encontrado ref. ENTRADAS para exporta��o.  Ser� gerado SEM movimento');
  end;


  while not Q.eof do  begin

      GeraRegistro1000( 'E' );

      if AnsiPos( Q.FieldByName('moes_tipomov').AsString,TiposDevolucao ) > 0 then begin

         if ( FGeral.GetConsumidorFinal(Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString)='S' )
            and
            (  Q.FieldByName('moes_estado').AsString = Global.UFUnidade )
            then

            GeraRegistro1220

         else if ( FCadcli.GetSimplesNacional(Q.FieldByName('moes_tipo_codigo').AsInteger)='S' )
            and
            (  Q.FieldByName('moes_estado').AsString = Global.UFUnidade )
            then

            GeraRegistro1520

// devolucoes fora do estado...
         else if (  Q.FieldByName('moes_estado').AsString <> Global.UFUnidade )
            then

            GeraRegistro1320

      end else

         GeraRegistro1110;

      Q.Next;

  end;

  FGeral.FechaQuery( Q );

  sistema.beginprocess('Pesquisando notas de saidas');
  Q:=sqltoquery('select * from movestoque'+
                ' inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                ' inner join estoque on ( move_esto_codigo=esto_codigo )'+
                ' inner join natureza on (natf_codigo=moes_natf_codigo)'+
                ' where '+FGeral.Getin('move_status','N;X;E;D;Y;I','C')+
                ' and moes_datamvto>='+EdInicio.assql+
                ' and '+FGeral.Getin('moes_status','N;X;E;D;Y;I','C')+
                ' and move_datamvto>='+EdInicio.assql+
                ' and move_datamvto<='+EdTermino.assql+
                ' and '+FGeral.GetNOTIN('moes_serie','F;F ','C')+
                ' and '+FGeral.GetNOTIN('moes_especie','CF;CF ;','C')+
                ' and '+FGeral.GetNOTIN('moes_tipomov',tiposnao+';'+Global.CodConhecimento+';'
                                        +TiposDevolucao+';'
                                        +global.CodConhecimentoSaida,'C')+
                ' and '+FGeral.GetIN('moes_tipomov',Global.TiposSaida,'C')+
                ' and move_datacont is not null'+
                sqlunidadesdet+
                ' and moes_natf_codigo is not null'+
                ' order by move_transacao,move_datamvto,move_numerodoc,move_aliicms' );
  if Q.eof then begin
    Avisoerro('Nada encontrado ref. SAIDAS para exporta��o.  Ser� gerado SEM movimento');
  end;


  while not Q.eof do  begin

      GeraRegistro1000( 'S' );

      if ( FGeral.GetConsumidorFinal(Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString)='S' )
            and
            (  Q.FieldByName('moes_estado').AsString = Global.UFUnidade )
            then

         GeraRegistro1210

      else if (  Q.FieldByName('moes_estado').AsString <> Global.UFUnidade ) then

         GeraRegistro1310

      else if ( FCadcli.GetSimplesNacional(Q.FieldByName('moes_tipo_codigo').AsInteger)='S' )
            and
            (  Q.FieldByName('moes_estado').AsString = Global.UFUnidade )
            then

            GeraRegistro1510;


      Q.Next;

  end;


// totalizador notas de entrada
  GeraRegistro1100;

  Sistema.beginprocess('Exportando movimento de entrada');
//  ListaArquivo := TStringList.Create;
  AssignFile ( arquivo, nomearq );
  Rewrite ( arquivo );

  Linha := GetReg_0000;
  Writeln(arquivo,linha);

  for I := 0 to TReg_1000.Count-1 do begin

     PReg_1000 := TReg_1000[i];
     Linha := GetReg_1000;
     Writeln(arquivo,linha);

  end;

 // inventario mes anterior
  for I := 0 to TReg_1010.Count-1 do begin

    PReg_1010 := TReg_1010[i];
    Linha := GetReg_1010;
    Writeln(arquivo,linha);

  end;

// totalizador entradas
  PReg_1100 := TReg_1100[0];
  Linha := GetReg_1100;
  Writeln(arquivo,linha);

  for I := 0 to TReg_1110.Count-1 do begin

     PReg_1110 := TReg_1110[i];
     Linha := GetReg_1110;
     Writeln(arquivo,linha);

  end;

// saidas para consumidor final no estado
  GeraRegistro1200;
// totalizador saida para consumidor final no estado
  PReg_1200 := TReg_1200[0];
  Linha := GetReg_1200;
  Writeln(arquivo,linha);

// nf de saida para consumidor final no estado
  for I := 0 to TReg_1210.Count-1 do begin

     PReg_1210 := TReg_1210[i];
     Linha := GetReg_1210;
     Writeln(arquivo,linha);

  end;

// nf de saida para fora do estado
  for I := 0 to TReg_1310.Count-1 do begin

     PReg_1310 := TReg_1310[i];
     Linha := GetReg_1310;
     Writeln(arquivo,linha);

  end;


// devolucao de saida para consumidor final
  for I := 0 to TReg_1220.Count-1 do begin

     PReg_1220 := TReg_1220[i];
     Linha := GetReg_1220;
     Writeln(arquivo,linha);

  end;

  GeraRegistro1300;
// totalizador saida para fora do estado
  PReg_1300 := TReg_1300[0];
  Linha := GetReg_1300;
  Writeln(arquivo,linha);


// devolucao de saida fora do estado
  for I := 0 to TReg_1320.Count-1 do begin

     PReg_1320 := TReg_1320[i];
     Linha := GetReg_1320;
     Writeln(arquivo,linha);

  end;

  GeraRegistro1500;
// totalizador saida simples nacional
  PReg_1500 := TReg_1500[0];
  Linha := GetReg_1500;
  Writeln(arquivo,linha);

// saida para simples nacional
  for I := 0 to TReg_1510.Count-1 do begin

     PReg_1510 := TReg_1510[i];
     Linha := GetReg_1510;
     Writeln(arquivo,linha);

  end;

// devolucao de saida dentro do estado para cliente do simples
  for I := 0 to TReg_1520.Count-1 do begin

     PReg_1520 := TReg_1520[i];
     Linha := GetReg_1520;
     Writeln(arquivo,linha);

  end;


// encerramento bloco 1  - soma da qtde de linha de cada tipo de registro - ir colocando
//                         cfe vai criando as rotinas de gera��o...
  linha := '1999'+sep+strzero( TReg_0000.Count + TReg_1000.Count + TReg_1010.Count + TReg_1100.count+TReg_1110.Count+
            TReg_1200.Count + TReg_1210.Count + TReg_1220.Count + TReg_1320.Count + TReg_1520.Count +
            TReg_1500.Count + TReg_1510.Count + TReg_1300.Count + TReg_1310.Count
             + 1 ,9);   // ref. o proprio 1999
  Writeln(arquivo,linha);

// reg. 9000 - apuracao
  Linha := GetReg_9000;
  Writeln(arquivo,linha);

// encerramento arquivo
  linha := '9999'+sep+strzero( TReg_0000.Count + TReg_1000.Count + TReg_1010.Count +TReg_1100.count + TReg_1110.Count +
           TReg_1200.Count + TReg_1210.Count + TReg_1220.Count + TReg_1320.Count + TReg_1520.Count +
           TReg_1500.Count + TReg_1510.Count + TReg_1300.Count + TReg_1310.Count
            + 1 + 1 + 1 ,9);  // ref. o proprio registro 9999 e 1999
  Writeln(arquivo,linha);
  CloseFile( arquivo );

  TReg_0000.Free;
  TReg_9000.Free;
  TReg_1000.Free;
  TReg_1010.Free;
  TReg_1100.Free;
  TReg_1200.Free;
  TReg_1300.Free;
  TReg_1110.Free;
  TReg_1210.Free;
  TReg_1310.Free;
  TReg_1220.Free;
  TReg_1320.Free;
  TReg_1500.Free;
  TReg_1510.Free;
  TReg_1520.Free;

  Sistema.endprocess('Gerado '+nomearq);

end;

procedure TFadrcst.EdfinalidadeExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////
begin

    bExecutarClick(self);
    EdInicio.SetFocus;

end;

procedure TFadrcst.EdterminoValidate(Sender: TObject);
////////////////////////////////////////////////////////
begin

   if EdTermino.AsDate < Edinicio.AsDate then
      EdTermino.Invalid('Data final tem que ser maior que data inicial')
   else
      EdMesano.Text := strzero(Datetomes(EdTermino.AsDate),2)+strzero(Datetoano(EdTermino.AsDate,true),4);
end;

procedure TFadrcst.Execute;
/////////////////////////////
begin

  if EdInicio.isempty then begin
     Edinicio.Setdate(Sistema.Hoje);
     EdTermino.setdate(Sistema.hoje);
  end;
  EdUnidades.Enabled:=Global.Topicos[1015];
  EdUnidades.text:=Global.Usuario.UnidadesMvto;
  FUnidades.SetaItems(EdUnidades,nil,Global.Usuario.UnidadesMvto);
  EdUnid_codigo.Text := Global.CodigoUnidade;
  Show;
  EdInicio.SetFocus;

end;

end.

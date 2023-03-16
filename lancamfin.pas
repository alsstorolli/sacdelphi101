unit lancamfin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel, ExtCtrls,
  SQLGrid, Grids, SqlDtg, ACBrOFX;

type
  TFLancaMovfin = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    bextrato: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    PRemessa: TSQLPanelGrid;
    Edunid_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    EdDtemissao: TSQLEd;
    EdNumeroDoc: TSQLEd;
    EdDtMovimento: TSQLEd;
    EdValor: TSQLEd;
    EdAntecipa: TSQLEd;
    EdPlan_contaent: TSQLEd;
    EdPlan_descricao: TSQLEd;
    EdHist_codigoe: TSQLEd;
    EdHist_descricaoe: TSQLEd;
    EdHist_complementoe: TSQLEd;
    EdPlan_contasai: TSQLEd;
    SQLEd2: TSQLEd;
    EdHist_codigos: TSQLEd;
    EdHist_descricaos: TSQLEd;
    EdHist_complementos: TSQLEd;
    Bevel1: TBevel;
    Bevel2: TBevel;
    EdCheque: TSQLEd;
    Edbompara: TSQLEd;
    EdTipocad: TSQLEd;
    EdCodtipo: TSQLEd;
    SetEdFavorecido: TSQLEd;
    PInicio: TSQLPanelGrid;
    EdTipolan: TSQLEd;
    EdContaDesrec: TSQLEd;
    SQLEd3: TSQLEd;
    Edrepr_codigo: TSQLEd;
    PParcelas: TSQLPanelGrid;
    GridParcelas: TSqlDtGrid;
    EdVencimento: TSQLEd;
    EdParcela: TSQLEd;
    EdFpgt_descricao: TSQLEd;
    EdFpgt_codigo: TSQLEd;
    bcheques: TSQLBtn;
    bimprecibo: TSQLBtn;
    bimportaofx: TSQLBtn;
    ACBrOFX1: TACBrOFX;
    OpenDialog1: TOpenDialog;
    procedure FormActivate(Sender: TObject);
    procedure EdPlan_contaentValiate(Sender: TObject);
    procedure EdHist_codigoeKeyPress(Sender: TObject; var Key: Char);
    procedure EdHist_codigosKeyPress(Sender: TObject; var Key: Char);
    procedure EdPlan_contasaiValidate(Sender: TObject);
    procedure EdDtemissaoValidate(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure EdTipocadValidate(Sender: TObject);
    procedure EdCodtipoValidate(Sender: TObject);
    procedure EdAntecipaValidate(Sender: TObject);
    procedure Edunid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdbomparaExitEdit(Sender: TObject);
    procedure EdTipolanValidate(Sender: TObject);
    procedure EdContaDesrecValidate(Sender: TObject);
    procedure EdNumeroDocValidate(Sender: TObject);
    procedure EdbomparaValidate(Sender: TObject);
    procedure EdFpgt_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdFpgt_codigoValidate(Sender: TObject);
    procedure GridParcelasDblClick(Sender: TObject);
    procedure EdVencimentoExitEdit(Sender: TObject);
    procedure GridParcelasKeyPress(Sender: TObject; var Key: Char);
    procedure EdVencimentoValidate(Sender: TObject);
    procedure EdParcelaExitEdit(Sender: TObject);
    procedure EdChequeValidate(Sender: TObject);
    procedure bchequesClick(Sender: TObject);
    procedure bextratoClick(Sender: TObject);
    procedure bimpreciboClick(Sender: TObject);
    procedure bimportaofxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure Desativareceita;
    procedure Ativadespesa;
    procedure Desativadespesa;
    procedure Ativareceita;
    procedure AtivaEditsParcelas;
    procedure SetaItemsCheques(Ed:TSqled ; conta,dias:integer);
    procedure SetaItemsChequesEmitidos(Ed:TSqled );
    procedure BaixaChequeCompensado;

  end;

var
  FLancaMovfin: TFLancaMovfin;
  Unidade,Transacao,Transacaocontax:string;
  lanadianta:boolean;
  contacheacompensar:integer;

//Const TiposLan:string='C;B;M';
//Const TiposLan:string='C;B';
// 23.04.10
//Const TiposLan:string='C;B;E';
// 24.06.19
Const TiposLan:string='C;B;E;P';

implementation

uses Arquiv, Geral, SqlSis, Sqlfun, conpagto, SqlExpr , Cadcheq, plano,
  Unidades, impressao, RelCxban;

{$R *.dfm}

procedure TFLancaMovfin.Execute;
///////////////////////////////////
var LIsta:Tstringlist;
    p:integer;
begin
  contacheacompensar:=0;
  // 11.09.08
  FGeral.EstiloForm(FLancaMovfin);
  if trim( FGeral.GetConfig1AsString('ContasMovfin') )<>'' then begin
    EdContaDesrec.ShowForm:='';
    FPlano.SetaItems(EdContaDesrec,sqled3,FGeral.GetConfig1AsString('ContasMovfin')+';'+FGeral.GetConfig1AsString('ContasMovfin1'),'')
  end else begin
    EdContaDesrec.ShowForm:='FPlano';
    EdContaDesrec.Items.Clear;
  end;
// 18.02.10 - Abra - Paulo
  if Global.Topicos[1273] then begin
    EdPlan_ContaEnt.ShowForm:='';
    EdPlan_ContaSai.ShowForm:='';
//    FPlano.SetaItems(EdPlan_ContaEnt,EdPlan_descricao,'CBE','');
//    FPlano.SetaItems(EdPlan_ContaSai,Sqled2,'CBE','')
// 24.06.19
    FPlano.SetaItems(EdPlan_ContaEnt,EdPlan_descricao,'CBEP','');
    FPlano.SetaItems(EdPlan_ContaSai,Sqled2,'CBEP','')
  end else begin

    EdPlan_ContaEnt.ShowForm:='FPlano';
    EdPlan_ContaEnt.Items.Clear;
    EdPlan_ContaSai.ShowForm:='FPlano';
    EdPlan_ContaSai.Items.Clear;

  end;
///////////////////////
// 12.08.10
//  if trim(FGeral.GetConfig1AsString('Impcomlan'))<>'' then
//    bimpressao.Enabled:=true
//  else
//    bimpressao.Enabled:=false;

  Show;
  bcheques.visible:=Global.Topicos[1256];
  bcheques.enabled:=Global.Topicos[1256];
  Unidade:=Global.CodigoUnidade;
  EdDtemissao.SetDate(Sistema.hoje);
  EdDtEmissao.enabled:=Global.Usuario.OutrosAcessos[0702];
  EdUnid_codigo.enabled:=Global.Topicos[1276];  // 22.05.10 - Nacron - Denise
  FUnidades.SetaItems(EdUnid_codigo,SetEdUNid_nome,Global.Usuario.UnidadesMvto);
  FGeral.ConfiguraColorEditsNaoEnabled(FLancaMovfin,0,'');
// 26.06.18 - Novicarnes  - Rose
  EdUnid_codigo.Text:=Global.CodigoUnidade;
  EdTipolan.setfocus;
// 06.06.2022
  bimportaofx.enabled := (Global.Usuario.codigo=100);

end;

procedure TFLancaMovfin.FormActivate(Sender: TObject);
begin
//  Unidade:=Global.CodigoUnidade;
//  EdDtemissao.SetDate(Sistema.hoje);
  Global.FpgtoAntecipa:=FGeral.GetConfig1AsString('Fpgtoantecipa');
//  EdPlan_contaent.setfocus;
//  EdDtEmissao.enabled:=Global.Usuario.OutrosAcessos[0702];
//  EdTipolan.setfocus;
end;

procedure TFLancaMovfin.EdPlan_contaentValiate(Sender: TObject);
begin
  if EdPlan_contaent.AsInteger=0 then begin
      EdHist_codigoe.enabled:=false;
      EdHist_complementoe.enabled:=false;
      EdHist_codigoe.text:='';
      EdHist_complementoe.text:='';
  end else begin
    EdHist_codigoe.enabled:=true;
    EdHist_complementoe.enabled:=true;
    if pos(EdPlan_contaent.resultfind.FieldByName('plan_tipo').asstring,TiposLan)=0 then
      EdPlan_contaent.invalid('Tipo de conta inválida para lançamento');
  end;
end;

procedure TFLancaMovfin.EdHist_codigoeKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.LimpaEdit(EdHist_codigoe,key);
end;

procedure TFLancaMovfin.EdHist_codigosKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.Limpaedit(EdHist_codigos,key);
end;

procedure TFLancaMovfin.EdPlan_contasaiValidate(Sender: TObject);
begin
  if EdPlan_contasai.AsInteger=0 then begin
    if EdPlan_contaent.AsInteger=0 then
      EdPlan_contasai.INvalid('Obrigatório preencher pelo menos uma das contas')
    else begin
      EdHist_codigos.enabled:=false;
      EdHist_complementos.enabled:=false;
      EdHist_codigos.text:='';
      EdHist_complementos.text:='';
    end;
    EdCheque.enabled:=false;
    EdCheque.text:='';
  end else begin
    if EdPlan_contaent.AsInteger=EdPlan_contasai.Asinteger then
      EdPlan_contasai.INvalid('Contas não podem ser iguais')
    else begin
      EdHist_codigos.enabled:=true;
      EdHist_complementos.enabled:=true;
/// - 07.12.09
     if (EdTipolan.Text='T') and (EdHist_codigos.IsEmpty) then begin
       EdHist_codigos.text:=EdHist_codigoe.text;
     end;
     if (EdTipolan.Text='T') and (EdHist_complementos.IsEmpty) then begin
       EdHist_complementos.text:=EdHist_complementoe.text;
     end;
////
      if pos(EdPlan_contasai.resultfind.FieldByName('plan_tipo').asstring,TiposLan)=0 then
        EdPlan_contasai.invalid('Tipo de conta inválida para lançamento')
//      else if pos(EdPlan_contasai.ResultFind.fieldbyname('plan_tipo').asstring,Tiposlan)=0 then begin
// 21.02.08
//      else if EdPlan_contasai.ResultFind.fieldbyname('plan_tipo').asstring='B'then begin
// 23.03.09
      else if pos(EdPlan_contasai.ResultFind.fieldbyname('plan_tipo').asstring,'B;C')>0 then begin
        EdCheque.enabled:=true;
      end else begin
        EdCheque.enabled:=false;
        EdCheque.text:='';
      end;
    end;
//    contacheacompensar:=FGeral.GetConfig1AsInteger('Ctacheacompensar');
// 29.02.08
    contacheacompensar:=EdPlan_contasai.resultfind.FieldByName('plan_ctachequescomp').asinteger;
// 02.05.13 - Novi - isonel+elize -
// buscar os cheques a compensar OU os cadastrados que podem ser emitidos...
    if (EdTipolan.text='D') and (pos(EdPlan_contasai.ResultFind.fieldbyname('plan_tipo').asstring,'C')>0)
       and ( contacheacompensar=0 )
       then
        SetaItemsChequesEmitidos(EdCheque)
    else if contacheacompensar>0 then
      SetaItemsCheques(EdCheque,contacheacompensar,FGeral.GetConfig1Asinteger('DIASCHECOM'));

  end;


end;

procedure TFLancaMovfin.EdDtemissaoValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin

  lanadianta:=false;
  if not FGeral.ValidaMvto(EdDtemissao) then
    EdDtemissao.Invalid('')
  else
    EdRepr_codigo.setvalue(0);
{
  else begin
    if EdContadesrec.asinteger>0 then begin
      EdRepr_codigo.enabled:=EdContaDesrec.asinteger=FGeral.getconfig1asinteger('Contaacertos');
    end else begin
      EdRepr_codigo.enabled:=false;
      EdRepr_codigo.setvalue(0);
    end;
  end;
}
end;

procedure TFLancaMovfin.bGravarClick(Sender: TObject);
////////////////////////////////////////////////////////////////
var cpr,tipomov,xES,Unidadeent,UnidadeSai:string;
    codrepre,p:integer;
    lanca:boolean;
    Qb:TSqlquery;

    function TotalParcela:currency;
    ///////////////////////////////
    var p:integer;
        valor:currency;
    begin
      valor:=0;
      for p:=1 to Gridparcelas.rowcount do begin
        valor:=valor+texttovalor(Gridparcelas.cells[1,p]);
      end;
      result:=valor;
    end;


begin
////////////////////////////////////
   if (EdPlan_contaent.AsInteger=0) and (EdPlan_contasai.AsInteger=0) then begin
     Avisoerro('Obrigatório preencher pelo menos uma das duas contas');
     exit;
   end;
   if EdBompara.enabled=true then begin
//     if not EdBompara.valid then begin
// 23.05.06
     if EdBompara.isempty then begin
        Avisoerro('Obrigatório digitar o campo bom para');
        exit;
     end;
   end;
   if EdPlan_contaent.AsInteger>0 then begin
    if not EdPlan_contaent.valid then begin
      Avisoerro('Checar conta de entrada');
      exit;
    end;
   end;
   if EdPlan_contasai.AsInteger>0 then begin
    if not EdPlan_contasai.valid then begin
      Avisoerro('Checar conta de saida');
      exit;
    end;
   end;
   if EdContaDesrec.asinteger>0 then begin
    if not EdContaDesrec.valid then begin
      EdContaDesrec.invalid('Checar conta de despesa');
      exit;
    end;
   end;

// 24.05.06
//   if (EdContadesrec.asinteger>0) and (EdContaDesrec.asinteger=FGeral.getconfig1asinteger('Contaacertos')) then begin
   if (EdContadesrec.asinteger>0) and (EdFpgt_codigo.validfind) and (EdFpgt_codigo.enabled) then begin
     if not FGeral.ValidaGridVencimentos(GridParcelas) then exit;
     if FCondpagto.GetAvPz(EdFpgt_codigo.text)='P' then begin
       if EdValor.ascurrency<>Totalparcela then begin
         Avisoerro('Total da nota :'+formatfloat(f_cr,EdValor.ascurrency)+' difere do total de parcelas :'+formatfloat(f_cr,Totalparcela));
         exit;
       end;
     end;
   end;
   lanca:=true;
// 22.05.10
   if EdUnid_codigo.Enabled then  Unidade:=EdUnid_codigo.text;
   Unidadeent:=unidade;
   Unidadesai:=unidade;

   if confirma('Confirma gravação ?') then begin
     Transacao:=FGeral.Gettransacao;
// 26.09.16
     if (Global.topicos[1045]) and ( EdDtMovimento.asdate > 1 )  then begin
        transacaocontax:=FGeral.GetTransacaoContax(strzero(FUnidades.GetEmpresaContax(unidade),3),True);
        if ( EdTipoLan.text='T' ) then begin
          unidadeent:=EdPlan_contaent.ResultFind.FieldByName('plan_unid_codigo').AsString;
          unidadesai:=EdPlan_contasai.ResultFind.FieldByName('plan_unid_codigo').AsString;
// 07.12.16 - caso a conta nao tiver configurado a unidade...
          if trim(unidadeent)='' then unidadeent:=unidade;
          if trim(unidadesai)='' then unidadesai:=unidade;
        end;
     end;
     Sistema.BeginTransaction('Gravando lançamento');
//     Sistema.BeginProcess('Gravando lançamento');
     if (EdContadesrec.asinteger>0) and  ( EdFpgt_codigo.enabled ) then
         lanca:=confirma('Lançar no caixa?');

     if lanca then begin
       tipomov:=Global.CodLanCaixabancos;
       if lanadianta then
         tipomov:=Global.CodComissaoRepr;   // adiantamento de comissao
// 13.03.14 - Damama - Conta de Funcionario
       xEs:='E';
       if EdPlan_contaent.ResultFind<>nil then begin
         if (EdPlan_contaent.ResultFind.FieldByName('plan_contaabatimentos').AsInteger>0) and
            ( EdTipoLan.text='T' ) then xEs:='S';
       end;
// 26.09.16
       if (Global.topicos[1045]) and ( EdDtMovimento.asdate > 1 ) and ( EdTipoLan.text='T' )  then begin
           FGeral.GravaMovfin(Transacao,UnidadeEnt,xES,EdHist_Complementoe.text,Eddtemissao.Asdate,EdDtmovimento.asdate,
           EdDtemissao.asdate,EdNumerodoc.asinteger,EdHist_codigoe.asinteger,EdCheque.asinteger,EdPlan_contaent.asinteger,EdValor.Ascurrency,EdContadesrec.asinteger,Tipomov,
                              EdRepr_codigo.asinteger,EdCodtipo.asinteger,EdTipocad.text,'N','1',transacaocontax,EdPlan_contasai.asinteger);
////////////           transacaocontax:='';
// 05.12.16 - refazendo lançamento contabil de transferencias entre contas para
// fazer 2 Deb/Cre em cada unidade
           FGeral.GravaMovfin(Transacao,UnidadeSai,'S',EdHist_Complementos.text,Eddtemissao.Asdate,EdDtmovimento.asdate,
           EdBompara.asdate,EdNumerodoc.asinteger,EdHist_codigos.asinteger,EdCheque.asinteger,EdPlan_contasai.asinteger,EdValor.Ascurrency,EdContadesrec.asinteger,Tipomov,
                              EdRepr_codigo.asinteger,EdCodtipo.asinteger,EdTipocad.text,'N','1',transacaocontax,EdPlan_contasai.asinteger);

       end else begin

         if EdPlan_contaent.AsInteger>0 then
           FGeral.GravaMovfin(Transacao,Unidade,xES,EdHist_Complementoe.text,Eddtemissao.Asdate,EdDtmovimento.asdate,
           EdDtemissao.asdate,EdNumerodoc.asinteger,EdHist_codigoe.asinteger,EdCheque.asinteger,EdPlan_contaent.asinteger,EdValor.Ascurrency,EdContadesrec.asinteger,Tipomov,
                              EdRepr_codigo.asinteger,EdCodtipo.asinteger,EdTipocad.text,'N','1',transacaocontax);
         if EdPlan_contasai.AsInteger>0 then begin
           FGeral.GravaMovfin(Transacao,Unidade,'S',EdHist_Complementos.text,Eddtemissao.Asdate,EdDtmovimento.asdate,
           EdBompara.asdate,EdNumerodoc.asinteger,EdHist_codigos.asinteger,EdCheque.asinteger,EdPlan_contasai.asinteger,EdValor.Ascurrency,EdContadesrec.asinteger,Tipomov,
                              EdRepr_codigo.asinteger,EdCodtipo.asinteger,EdTipocad.text,'N','1',transacaocontax);
  // 02.05.13 - marca o cheque cadastrado como Emitido -- depois mudar na hora de montar o f12
  //            no setaitemschequesemitidos
            if not EdCheque.IsEmpty then begin
               Qb:=Sqltoquery('select plan_contacorrente,plan_codigobanco from plano where plan_ctachequescomp='+EdPlan_contasai.AsSql);
               if not Qb.eof then begin
                 Sistema.edit('cheques');
                 Sistema.SetField('cheq_valor',EdValor.ascurrency);
                 Sistema.Setfield('cheq_rc','E');
                 Sistema.Setfield('cheq_obs',EdHist_complementos.text);
                 Sistema.SetField('cheq_emissao',EdDtemissao.asdate);
                 Sistema.Post('cheq_status=''N'' and cheq_emirec=''E'''+
                          ' and cheq_cheque='+stringtosql(EdCheque.text)+
                          ' and Cheq_emit_conta='+inttostr(Qb.fieldbyname('Plan_contacorrente').AsInteger)+
                          ' and Cheq_emit_banco='+stringtosql(Qb.fieldbyname('Plan_codigobanco').AsString)+
                          ' and Cheq_deposito is null' );
  //                        ' and ( (cheq_rc <> ''E'') or (cheq_rc is null) )' )
               end;
               FGeral.FechaQuery(Qb);
           end;
         end;
       end;
       if EdAntecipa.text='S' then begin

         if EdPlan_contasai.AsInteger>0 then  // 18.05.04
           cpr:='P'
         else
           cpr:='R';
// 15.12.09  // antecipacao de cliente = para ir 'positivo' no relat. de pendencias
         if EdTipolan.text='T' then begin
           if EdTipocad.text='C' then
             cpr:='R'
           else
             cpr:='P';
         end;
//
// 01.09.08
//         if (EdPlan_contaent.asinteger=FGeral.GetConfig1AsInteger('Ctaadiansalario')) and
//            ( FGeral.GetConfig1AsInteger('Ctaadiansalario')>0) then
//            cpr:='R';
         if EdTipocad.text='R' then
           codrepre:=EdCodTipo.AsInteger
         else
           codrepre:=0;
         if EdCodtipo.AsInteger>0 then begin
// 01.09.08
           if (EdPlan_contaent.asinteger=FGeral.GetConfig1AsInteger('Ctaadiansalario')) and
              ( FGeral.GetConfig1AsInteger('Ctaadiansalario')>0) then
             FGeral.GravaPendencia(EdDtemissao.asdate,EdDtmovimento.asdate,EdCodtipo,EdTipocad.Text,codrepre,EdUNid_codigo.text,
                                 Global.CodPendenciaFinanceira,Transacao,Global.FpgtoAntecipa,cPR,EdNumerodoc.AsInteger,
                                 0,EdValor.Ascurrency,0,'N')
           else
//             FGeral.GravaPendencia(EdDtemissao.asdate,EdDtmovimento.asdate,EdCodtipo,EdTipocad.Text,codrepre,EdUNid_codigo.text,
//                                 Global.CodPendenciaFinanceira,Transacao,Global.FpgtoAntecipa,cPR,EdNumerodoc.AsInteger,
// 28.11.16                                 0,EdValor.Ascurrency,0,'A');

             FGeral.GravaPendencia(EdDtemissao.asdate,EdDtmovimento.asdate,EdCodtipo,EdTipocad.Text,codrepre,EdUNid_codigo.text,
                                 Global.CodPendenciaFinanceira,Transacao,Global.FpgtoAntecipa,cPR,EdNumerodoc.AsInteger,
                                 0,EdValor.Ascurrency,0,'A',EdValor.ascurrency,0,GridParcelas);
         end;
       end;
     end;
// 24.05.06
//     if (EdContadesrec.asinteger>0) and (EdContaDesrec.asinteger=FGeral.getconfig1asinteger('Contaacertos'))
// 28.11.16 - menos se for antecipacao
     if (EdContadesrec.asinteger>0) and  ( EdFpgt_codigo.enabled ) and  Global.Usuario.OutrosAcessos[0707]
         and (EdAntecipa.text<>'S')
       then begin

       for p:=0 to GridParcelas.rowcount do begin

         if trim( GridParcelas.cells[GridParcelas.getcolumn('pend_valor'),p] )<>'' then begin
           FGeral.GravaMovfin(Transacao,Unidade,'S',EdHist_Complementos.text,Eddtemissao.Asdate,EdDtmovimento.asdate,
           Texttodate( FGeral.Tirabarra(GridParcelas.cells[GridParcelas.getcolumn('pend_datavcto'),p]) ),EdNumerodoc.asinteger,
           EdHist_codigos.asinteger,EdCheque.asinteger,EdPlan_contasai.asinteger,Texttovalor(GridParcelas.cells[GridParcelas.getcolumn('pend_valor'),p]),
           EdContadesrec.asinteger,Global.CodLanCaixabancos,
           EdRepr_codigo.asinteger,EdCodtipo.asinteger,EdTipocad.text,'G');
         end;

       end;

     end;
// 21.02.08 - lançamento do esquema cheques a compensar/compensados
////////////////
//{ - retirado em 29.07.09 por nao ser necessario pelo 'metodo final' feito com elyze
//-   somente os cheques que dao saida na conta de cheques a compensar e aparecem no f12
//    para serem compensados...
// recolocado em 03.08.09 - dai nao compensava mais nada...
     if (contacheacompensar>0) and (not EdCheque.IsEmpty)  and (not EdPlan_contasai.isempty) and (EdPlan_contaent.isempty) then begin
         FGeral.GravaMovfin(Transacao,Unidade,'E',EdHist_Complementos.text,Eddtemissao.Asdate,EdDtmovimento.asdate,
         EdBompara.asdate,EdNumerodoc.asinteger,EdHist_codigos.asinteger,EdCheque.asinteger,contacheacompensar,EdValor.Ascurrency,EdContadesrec.asinteger,Tipomov,
                            EdRepr_codigo.asinteger,EdCodtipo.asinteger,EdTipocad.text,'N','1',transacaocontax);
// 02.05.13 - baixa do cheque emitido OU compensado
         BaixaChequeCompensado;
     end;
//     }
////////////////

     Sistema.EndTransaction('Lançamento gravado');
//     Sistema.commit;
//     Sistema.EndProcess('Lançamento gravado');
// 12.08.10
     if trim(FGeral.GetConfig1AsString('Impcomlan'))<>'' then
       FImpressao.ImprimeReciboCaixa(Transacao);

     EdValor.setvalue(0);
     EdNumerodoc.text:='';
// 27.11.17 - Novicarnes - Rose - para nao usar o cheque em outro lançamento caso esquecer de limpar o campo
     EdCheque.Text:='';
     EdPlan_contaent.setvalue(0);
     EdPlan_contasai.setvalue(0);
//     EdPlan_contaent.setfocus;
// 12.04.05 - idete
//     EdPlan_contaent.clearall(FLancaMovfin,99);
//     EdPlan_contasai.clearall(FLancaMovfin,99);
//     EdDtemissao.clearall(FLancaMovfin,99);
// 26.04.05 - reges pediu pra deixar  -  REVEr com idete
     EdTipolan.clear;
     EdContadesrec.clear;
     EdHist_complementoe.clear;
     EdHist_complementos.clear;
     EdHist_codigoe.clear;
     EdHist_codigos.clear;
     Edtipolan.setfocus;
   end;
end;

// 28.03.19 - Novicarnes - Sandro
// 06.06.2022
/////////////////////////////////////////////////////////////////
procedure TFLancaMovfin.bimportaofxClick(Sender: TObject);
begin
    if not OPendialog1.execute then Exit;
    if Opendialog1.filename='' then Exit;
    acbrofx1.fileofx := opendialog1.filename;
    ACBrOFX1.Import;


end;

procedure TFLancaMovfin.bimpreciboClick(Sender: TObject);
////////////////////////////////////////////////////////////
var xconta:integer;
    Q         : TSqlquery;
    xdata     : TDatetime;
    Lista,
    ListaOP   : TStringList;
    operacoes : string;
    p         : Integer;

begin

    xconta:=EdContaDesrec.AsInteger;
    if EdContaDesrec.ResultFind=nil then begin
       Avisoerro('Confirme a conta de despesa/receita');
       exit;
    end;
    if xconta=0 then begin
       Avisoerro('Informe conta de despesa/receita');
       exit;
    end;
    if EdContaDesrec.ResultFind.FieldByName('plan_contaabatimentos').AsInteger=0 then begin
       Avisoerro('Falta configurar o codigo do cliente nesta conta');
       exit;
    end;
    xdata := Sistema.Hoje - 210;
    Q:=sqltoquery('select movfin.*,plan_contaabatimentos from movfin'+
                  ' inner join plano on ( plan_conta = movf_plan_contard )'+
                  ' where movf_plan_contard = '+inttostr(xconta)+
                  ' and movf_status = ''N'''+
                  ' and movf_datamvto >= '+Datetosql(xdata)+
                  ' and movf_es = '+Stringtosql('S')+
                  ' and movf_tipomov = '+stringtosql('LC')+
                  ' and '+FGeral.GetIN('movf_unid_codigo',Global.Usuario.UnidadesRelatorios,'C') );
    if Q.Eof then begin
       Avisoerro('Nada encontrado nesta conta desde '+FGeral.FormataData(xdata));
       exit;
    end;


    Lista := TStringList.Create;

    while not Q.Eof do begin

       Lista.Add( strspace(Q.FieldByName('movf_operacao').AsString,16) + '|' +
                  Q.FieldByName('movf_datamvto').AsString + '|' +
                  Q.FieldByName('movf_complemento').AsString + '|' +
                  FgEral.Formatavalor(Q.FieldByName('movf_valorger').Ascurrency,'###,##0.00')
                  );
       Q.Next;

    end;

    Q.Close;

    operacoes:=SelecionaItems(Lista,'Escolha operações para impressão de recibo','',true,16);

    ListaOP := TStringList.Create;
    strtolista(ListaOp,operacoes,';',true);

    for p := 0 to ListaOP.Count-1 do  begin

        if trim(ListaOP[p])<>'' then
           FImpressao.ImprimeReciboCaixa(trim(ListaOP[p]),'N')
    end;

end;

procedure TFLancaMovfin.EdTipocadValidate(Sender: TObject);
///////////////////////////////////////////////////////////////
begin
  if EdTipoCad.text='U' then begin
    EdCodtipo.ShowForm:='FUnidades';
    EdCodtipo.FindTable:='unidades';
    EdCodtipo.FindField:='unid_codigo';
  end else if EdTipoCad.text='C' then begin
    EdCodtipo.ShowForm:='FCadcli';
    EdCodtipo.FindTable:='clientes';
    EdCodtipo.FindField:='clie_codigo';
  end else if EdTipoCad.text='F' then begin
    EdCodtipo.ShowForm:='FFornece';
    EdCodtipo.FindTable:='fornecedores';
    EdCodtipo.FindField:='forn_codigo';
  end else if EdTipoCad.text='T' then  begin
    EdCodtipo.ShowForm:='FTransp';
    EdCodtipo.FindTable:='transportadores';
    EdCodtipo.FindField:='tran_codigo';
  end else if EdTipoCad.text='R' then begin
    EdCodtipo.ShowForm:='FRepresentantes';
    EdCodtipo.FindTable:='representantes';
    EdCodtipo.FindField:='repr_codigo';
  end else begin
    EdCodtipo.ShowForm:='';
    EdCodtipo.FindTable:='';
    EdCodtipo.FindField:='';
  end;

end;

procedure TFLancaMovfin.EdCodtipoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////
begin

  if (EdAntecipa.text='S') and (EdCodtipo.isempty) then
    EdCodTipo.Invalid('Obrigatório preencher este campo')
  else begin
    SetEdFavorecido.Text:=FGeral.GetNomeTipoCad(EdCodtipo.asinteger,EdTipoCad.text);
    if (trim(SetEdFavorecido.Text)='') and (EdAntecipa.text='S') then
      EdCodTipo.Invalid('Não encontrado')

    else if (EdCodtipo.resultfind<>nil) and (EdAntecipa.text<>'S') then begin
     {  08.04.20 - retirado este parcelamento por não ser mais util por enquanto...
///////////////////////////
      if EdCodtipo.asinteger>0 then begin  // 01.09.06 - lu pegou erro quando dava enter...

        EdRepr_codigo.text:=EdCodtipo.resultfind.fieldbyname('clie_repr_codigo').asstring;
        lanadianta:=Confirma('Lançar parcelamento ?');
        if lanadianta then begin
          EdFpgt_codigo.enabled:=true;
          PParcelas.enabled:=true;
        end else begin
          EdFpgt_codigo.enabled:=false;
          PParcelas.enabled:=false;
        end;

      end;
///////////////////////////
     }

    end else begin
       if Global.Topicos[1256] and
       ( ( EdPlan_contasai.asinteger=FGeral.GetConfig1AsInteger('Ctacherecebido') ) or
       ( EdPlan_contaent.asinteger=FGeral.GetConfig1AsInteger('Ctacherecebido')  ) ) then
         bchequesclick(self);
    end;
  end;

end;

procedure TFLancaMovfin.EdAntecipaValidate(Sender: TObject);
///////////////////////////////////////////////////////////////
begin
  if EdUnid_codigo.isempty then
    EdUnid_codigo.text:=Global.CodigoUnidade;
  EdCodtipo.enabled:=false;
  if EdAntecipa.text='S' then begin
    if trim(Global.FpgtoAntecipa)<>'' then begin
      if EdAntecipa.text='S' then begin
        EdTipoCad.enabled:=true;
        EdCodtipo.enabled:=true;
        EdUnid_codigo.enabled:=true;
      end else begin
        EdTipoCad.enabled:=false;
        EdTipoCad.text:='';
        EdCodtipo.enabled:=false;
        EdCodtipo.text:='';
        EdUnid_codigo.enabled:=false;
      end;
    end else
      EdAntecipa.INvalid('Falta configurar a forma de pagamento padrão para antecipações na configuração');

  end else begin

    EdTipoCad.enabled:=false;
    EdTipoCad.text:='';
    EdCodtipo.enabled:=false;
    EdCodtipo.text:='';
    EdUnid_codigo.enabled:=Global.Topicos[1276];  // 22.05.10 - Nacron - Denise
    EdCodtipo.empty:=false;
//    if (EdContadesrec.asinteger>0) and (EdContaDesrec.asinteger=FGeral.getconfig1asinteger('Contaacertos')) then begin
    if Global.Usuario.OutrosAcessos[0707] then begin
      if (EdContadesrec.asinteger>0)  then begin
        EdTipoCad.text:='C';
        EdTipocad.valid;
        EdCodtipo.enabled:=true;
        EdCodtipo.empty:=true;
      end;
    end;
// 08.04.20 - Novicarnes
    if  ( FGeral.GetConfig1AsInteger('Ctasobras') > 0 ) then begin

       if  FGeral.GetConfig1AsInteger('Ctasobras') = EdContaDesrec.AsInteger then  begin

         EdTipoCad.text:='C';
         EdTipocad.valid;
         EdCodtipo.enabled:=true;
         EdCodtipo.empty:=true;

       end;

    end;

  end;

end;

procedure TFLancaMovfin.Edunid_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.Limpaedit(EdUnid_codigo,key);
end;

procedure TFLancaMovfin.EdbomparaExitEdit(Sender: TObject);
begin
//  if not Global.Topicos[1276] then
    bgravarclick(FLancaMovfin);
end;

procedure TFLancaMovfin.EdTipolanValidate(Sender: TObject);
begin
  contacheacompensar:=0;
  EdContadesrec.enabled:=true;
  if Edtipolan.text='D' then begin
    Desativareceita;
    Ativadespesa;
  end else if Edtipolan.text='R' then begin
    Desativadespesa;
    Ativareceita;
  end else begin
    Ativareceita;                                                  
    Ativadespesa;
    EdContadesrec.enabled:=false;
    EdContadesrec.setvalue(0);
    EdPlan_contaent.setfocus;
  end;

end;

procedure TFLancaMovfin.Ativadespesa;
begin
  Edplan_contasai.enabled:=true;
  Edplan_contasai.setvalue(0);
  Edcheque.enabled:=true;
  EdHist_codigos.enabled:=true;
  EdHist_complementos.enabled:=true;
  EdHist_complementos.text:='';
end;

procedure TFLancaMovfin.Desativareceita;
begin
  Edplan_contaent.enabled:=false;
  Edplan_contaent.setvalue(0);
  EdHist_codigoe.enabled:=false;
  EdHist_complementoe.enabled:=false;
end;

procedure TFLancaMovfin.Ativareceita;
begin
  Edplan_contaent.enabled:=true;
  Edplan_contaent.setvalue(0);
  EdHist_codigoe.enabled:=true;
  EdHist_complementoe.enabled:=true;
  EdHist_complementoe.text:='';

end;

procedure TFLancaMovfin.Desativadespesa;
begin
  Edplan_contasai.enabled:=false;
  Edplan_contasai.setvalue(0);
  Edcheque.enabled:=false;
  EdHist_codigos.enabled:=false;
  EdHist_complementos.enabled:=false;

end;

procedure TFLancaMovfin.EdContaDesrecValidate(Sender: TObject);
begin
   if not EdContaDesrec.isempty then begin
      if EdContaDesrec.resultfind.Eof then begin
        EdContaDesrec.invalid('Conta não encontrada');
        exit;
      end;
// 14.10.05
      if EdContaDesrec.resultfind.FieldByName('plan_tipo').asstring<>'M' then begin
// 23.04.10 - contas de emprestimo
//      if pos(EdContaDesrec.resultfind.FieldByName('plan_tipo').asstring,'M;E')=0 then begin
        EdContaDesrec.invalid('Tipo de conta invalido para receita/despesa');
        exit;
      end;
   end;
   if EdTipolan.text='R' then
     EdPlan_contaent.setfocus
   else if EdTipolan.text='T' then
     EdPlan_contaent.setfocus
   else
     EdPlan_contasai.setfocus;
end;

procedure TFLancaMovfin.EdNumeroDocValidate(Sender: TObject);
begin

// 05.11.09
   if not Global.Topicos[1007] then begin
      EdDtmovimento.text:=EdDtemissao.text;
      EdBompara.Text:=EdDtemissao.text;
   end else begin
      EdDtmovimento.text:='';
      EdBompara.Text:=EdDtEmissao.text;
   end;
{ - 20.08.08 - retirado devido carli-financeiro
    if (EdPlan_contaent.AsInteger>0) and (EdPlan_contasai.asinteger>0) then begin
      EdAntecipa.enabled:=false;
      EdAntecipa.Text:='N';
    end else
      EdAntecipa.enabled:=true;
}

end;

procedure TFLancaMovfin.EdbomparaValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin
  PParcelas.enabled:=false;
  if EdAntecipa.text='S' then begin

    if trim(Global.FpgtoAntecipa)<>'' then begin
      if EdAntecipa.text='S' then begin
        EdTipoCad.enabled:=true;
        EdCodtipo.enabled:=true;
        EdUnid_codigo.enabled:=true;
  // 28.11.16
        EdFpgt_codigo.enabled:=true;
// 12.05.20 - clessi
        if not Global.Topicos[1514] then EdFpgt_codigo.enabled:=false;

      end else begin
        EdTipoCad.enabled:=false;
        EdTipoCad.text:='';
        EdCodtipo.enabled:=false;
        EdCodtipo.text:='';
        EdUnid_codigo.enabled:=false;
      end;
    end else
      EdAntecipa.INvalid('Falta configurar a forma de pagamento padrão para antecipações na configuração');
  end else begin

      EdTipoCad.enabled:=false;
      EdTipoCad.text:='';
      EdCodtipo.enabled:=false;
      EdCodtipo.text:='';
      EdCodtipo.empty:=false;
      EdFpgt_codigo.enabled:=false;
      EdFpgt_codigo.text:='';
      PParcelas.enabled:=false;
  //    if (EdContadesrec.asinteger>0) and (EdContaDesrec.asinteger=FGeral.getconfig1asinteger('Contaacertos')) then begin
    if Global.Usuario.OutrosAcessos[0707] then begin
      if (EdContadesrec.asinteger>0) then begin
        EdTipoCad.text:='C';
        EdTipocad.valid;
        EdCodtipo.enabled:=true;
        EdCodtipo.empty:=true;
      end;
    end;
// 08.04.20 - Novicarnes
    if  ( FGeral.GetConfig1AsInteger('Ctasobras') > 0 ) then begin

       if  FGeral.GetConfig1AsInteger('Ctasobras') = EdContaDesrec.AsInteger then  begin

         EdTipoCad.text:='C';
         EdTipocad.valid;
         EdCodtipo.enabled:=true;
         EdCodtipo.empty:=true;

       end;

    end;

  end;

end;

procedure TFLancaMovfin.EdFpgt_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
   FGeral.LImpaEdit(Edfpgt_codigo,key);

end;

procedure TFLancaMovfin.EdFpgt_codigoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////
var nparcelas,n:integer;
    ListaPrazo:TStringlist;
    p:integer;
    valorparcela,valortotal,valoravista,acumulado:currency;
    Emissao:TDatetime;
begin
  if not EdFpgt_codigo.validfind then exit;
  if (EdFpgt_codigo.text<>EdFpgt_codigo.OldValue) then
    GridParcelas.Clear;
  if (FCondPagto.GetAvPz(EdFpgt_codigo.text)='P') or (EdFpgt_codigo.text<>EdFpgt_codigo.OldValue ) then begin
    ListaPrazo:=TStringlist.create;
    n:=FCondPagto.GetPrazos(EdFpgt_codigo.text,ListaPrazo);
    valoravista:=FGeral.GetValorAvista(Listaprazo);
    nparcelas:=FCondPagto.GetNumeroParcelas(EdFpgt_codigo.text);
/////////////////////////////////////////////////////////////////
// 11.03.05 - reges pegou bug quando tem parte a vista e mais de duas parcelas
    valortotal:=EdValor.AsCurrency-valoravista;
    acumulado:=0;
    Emissao:=texttodate('30'+strzero(Datetomes(EdDtemissao.asdate),2)+strzero(Datetoano(EdDtemissao.asdate,true),4));
    for p:=1 to nparcelas do begin
//      GridParcelas.cells[0,p]:=formatdatetime('dd/mm/yy',FGeral.GetProximoDiaUtil(EdDtEmissao.Asdate+Inteiro(ListaPrazo[p-1]),Inteiro(ListaPrazo[p-1]))  );
      GridParcelas.cells[0,p]:=formatdatetime('dd/mm/yy',Emissao+Inteiro(ListaPrazo[p-1])  );
      if (p=nparcelas) and (valoravista=0) then
        valorparcela:=valortotal-acumulado  // para deixar na ultima parcelas "as dízimas"
      else begin
        if (valoravista>0) then begin
          valorparcela:=FGeral.Arredonda(valortotal/(nparcelas-1),2);
          if (p=nparcelas) then
            valorparcela:=valortotal+valoravista-acumulado  // para deixar na ultima parcelas "as dízimas" - 01.06.05
        end else
          valorparcela:=FGeral.Arredonda((valortotal)/nparcelas,2);
      end;
      if (valoravista>0) and (p=1) then begin
        GridParcelas.cells[1,p]:=Transform(valoravista,f_cr);
        acumulado:=acumulado+valoravista;
      end else begin
        GridParcelas.cells[1,p]:=Transform(valorparcela,f_cr);
        acumulado:=acumulado+valorparcela;
      end;
      GridParcelas.RowCount:=GridParcelas.RowCount+1;
    end;  // for do numero de parcelas
// 28.11.16
   bGravarClick(self);    
  end;


end;

procedure TFLancaMovfin.GridParcelasDblClick(Sender: TObject);
begin
  AtivaEditsParcelas;

end;

procedure TFLancaMovfin.AtivaEditsParcelas;
begin
  if GridParcelas.Col=0 then begin
     EdVencimento.Top:=GridParcelas.TopEdit;
     EdVencimento.Left:=GridParcelas.LeftEdit+5;
     EdVencimento.Text:=StrToStrNumeros(GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]);
//     EdVencimento.Text:=GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row];
     EdVencimento.Visible:=True;
     EdVencimento.SetFocus;
  end else if GridParcelas.Col=1 then begin
     EdParcela.Top:=GridParcelas.TopEdit;
     EdParcela.Left:=GridParcelas.LeftEdit+6;
     EdParcela.SetValue(TextToValor(GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]));
     EdParcela.Visible:=True;
     EdParcela.SetFocus;
  end;

end;

procedure TFLancaMovfin.EdVencimentoExitEdit(Sender: TObject);
begin
  GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=DateToStr_(EdVencimento.AsDate);
  GridParcelas.SetFocus;
  EdVencimento.Visible:=False;

end;

procedure TFLancaMovfin.GridParcelasKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#13 then
    GridParcelasDblClick(FlancaMovfin);

end;

procedure TFLancaMovfin.EdVencimentoValidate(Sender: TObject);
begin
   if FCondpagto.GetAvPz(EdFpgt_codigo.text)='V' then begin
     if EdVencimento.AsDate>0 then begin
       if Edvencimento.asdate<Sistema.hoje then
          EdVencimento.invalid('Nota a vista somente com data atual');
     end;
   end;

end;

procedure TFLancaMovfin.EdParcelaExitEdit(Sender: TObject);
begin
  GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=Transform(EdParcela.AsFloat,f_cr);
  GridParcelas.SetFocus;
  EdParcela.Visible:=False;

end;

procedure TFLancaMovfin.SetaItemsCheques(Ed: TSqled; conta, dias: integer);
//////////////////////////////////////////////////////////////////////////////
var Q,QCh:Tsqlquery;
    Datainicio:tDatetime;
begin
   Ed.Items.Clear;
   if dias=0 then dias:=30;
   Datainicio:=Sistema.hoje-dias;
   Q:=sqltoquery('select * from movfin where movf_plan_conta='+inttostr(conta)+' and movf_status=''N'''+
                 ' and movf_datamvto>='+Datetosql(datainicio)+ ' and movf_es=''S'' and '+FGeral.GetIN('movf_tipomov',Global.CodPendenciaFinanceira+';'+Global.CodLanCaixabancos+';'+'CH','C') );
   while not Q.eof do begin
//     Ed.Items.Add( strzero(strtointdef(Q.fieldbyname('movf_numerodcto').asstring,0),7 )+' - '+FGeral.FormataData(Q.fieldbyname('movf_datamvto').asdatetime)+' '+Valortosql(Q.fieldbyname('movf_valorger').ascurrency) );
//     Ed.Items.Add( strspace(Q.fieldbyname('movf_numerodcto').asstring,7)+' - '+FGeral.FormataData(Q.fieldbyname('movf_datamvto').asdatetime)+' '+Valortosql(Q.fieldbyname('movf_valorger').ascurrency) );
// 16.04.08
//     Ed.Items.Add( strspace(Q.fieldbyname('movf_numerocheque').asstring,7)+' - '+FGeral.FormataData(Q.fieldbyname('movf_datamvto').asdatetime)+' '+Valortosql(Q.fieldbyname('movf_valorger').ascurrency) );
// 28.04.08
// 06.05.13 - Novicarnes - controle de cheques emitidos
     QCh:=sqltoquery('select cheq_transbaixa from cheques where cheq_transbaixa='+Stringtosql(Q.fieldbyname('movf_transacao').asstring));
     if  Qch.eof then begin
       if (trim(Q.fieldbyname('movf_numerocheque').asstring)<>'')  and (trim(Q.fieldbyname('movf_numerocheque').asstring)<>'0') then
         Ed.Items.Add( strspace(Q.fieldbyname('movf_numerocheque').asstring,7)+' - '+FGeral.FormataData(Q.fieldbyname('movf_datamvto').asdatetime)+' '+Valortosql(Q.fieldbyname('movf_valorger').ascurrency) )
       else
         Ed.Items.Add( strspace(Q.fieldbyname('movf_numerodcto').asstring,7)+' - '+FGeral.FormataData(Q.fieldbyname('movf_datamvto').asdatetime)+' '+Valortosql(Q.fieldbyname('movf_valorger').ascurrency) );
     end;
     FGeral.FechaQuery(Qch);
     Q.Next;
   end;
   FGeral.FechaQuery(Q);
end;

procedure TFLancaMovfin.EdChequeValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////////
var Q:Tsqlquery;
    Datainicio:tDatetime;
    valorcheque:currency;
begin
   if (contacheacompensar>0) and (not EdCheque.IsEmpty) then begin
//     Datainicio:=Sistema.hoje-30;
// 04.08.08 - elize - novicarnes - nao aparece no F12 mas pesquisa aqui
//     Datainicio:=Sistema.hoje-90;
// 01.07.10 - Elyze cheque de 22.03 compensado em 01.07
     if FGeral.GetConfig1Asinteger('DIASCHECOM')>0 then
       Datainicio:=Sistema.hoje-FGeral.GetConfig1Asinteger('DIASCHECOM')
     else
       Datainicio:=Sistema.hoje-90;
//
     valorcheque:=0;
// primeiro procura se lançou direto no caixa/bancos a emissão do cheque
// pesquisando pelo numero do documento..depois pelo numero do cheque
     Q:=sqltoquery('select movf_valorger,movf_tipomov,movf_es from movfin where movf_plan_conta = '+inttostr(contacheacompensar)+
                   ' and movf_status=''N'''+
//                   ' and movf_numerodcto='+EdCheque.AsSql+
// 04.06.12- versao do banco...
                   ' and movf_numerodcto = '+Stringtosql(EdCheque.text)+
// 16.11.10 - Novi - Damaris
                   ' and movf_numerocheque='+EdCheque.AsSql+
//                   ' and movf_numerocheque='+inttostr(EdCheque.AsInteger)+
                   ' and movf_datamvto >= '+Datetosql(datainicio) );
     if not Q.eof then begin
       EdNumerodoc.text:=Edcheque.text;
       while not Q.eof do begin
{
         if Q.fieldbyname('movf_tipomov').asstring=Global.CodPendenciaFinanceira then
           valorcheque:=valorcheque+Q.fieldbyname('movf_valorger').ascurrency
         else if Q.fieldbyname('movf_tipomov').asstring=Global.CodDescontosDados then
           valorcheque:=valorcheque-Q.fieldbyname('movf_valorger').ascurrency
         else if Q.fieldbyname('movf_tipomov').asstring=Global.CodJurosRecebidos then
           valorcheque:=valorcheque+Q.fieldbyname('movf_valorger').ascurrency
         else
           valorcheque:=valorcheque+Q.fieldbyname('movf_valorger').ascurrency;
}  // 11.06.08 -pois cheques dado 'entrada e saida' direto no caixa bancos ( sem baixar ) nao zera...
         if Q.fieldbyname('movf_Es').asstring='S' then
           valorcheque:=valorcheque+Q.fieldbyname('movf_valorger').ascurrency
         else
           valorcheque:=valorcheque-Q.fieldbyname('movf_valorger').ascurrency;
         Q.Next;
       end;
// 23.03.09
       if valorcheque<0 then
         valorcheque:=0;
       EdValor.setvalue(valorcheque);
     end else begin
       FGeral.FechaQuery(Q);
       Q:=sqltoquery('select movf_valorger,movf_tipomov,movf_es from movfin where movf_plan_conta='+inttostr(contacheacompensar)+
                   ' and movf_status=''N'''+
                   ' and movf_numerocheque='+EdCheque.AsSql+
                   ' and movf_datamvto>='+Datetosql(datainicio));
       EdNumerodoc.text:=Edcheque.text;
       if not Q.eof then begin
         while not Q.eof do begin
{
           if Q.fieldbyname('movf_tipomov').asstring=Global.CodPendenciaFinanceira then
             valorcheque:=valorcheque+Q.fieldbyname('movf_valorger').ascurrency
           else if Q.fieldbyname('movf_tipomov').asstring=Global.CodDescontosDados then
             valorcheque:=valorcheque-Q.fieldbyname('movf_valorger').ascurrency
           else if Q.fieldbyname('movf_tipomov').asstring=Global.CodJurosRecebidos then
             valorcheque:=valorcheque+Q.fieldbyname('movf_valorger').ascurrency
         else
           valorcheque:=valorcheque+Q.fieldbyname('movf_valorger').ascurrency;

}  // 11.06.08 -pois cheques dado 'entrada e saida' direto no caixa bancos ( sem baixar ) nao zera...
         if Q.fieldbyname('movf_Es').asstring='S' then
           valorcheque:=valorcheque+Q.fieldbyname('movf_valorger').ascurrency
         else
           valorcheque:=valorcheque-Q.fieldbyname('movf_valorger').ascurrency;
           Q.Next;
         end;
         EdValor.setvalue(valorcheque);
       end;
     end;
     FGeral.FechaQuery(Q);

   end;
end;

// 29.04.13
procedure TFLancaMovfin.SetaItemsChequesEmitidos(Ed: TSqled);
////////////////////////////////////////////////////////////////
var Q,QB:Tsqlquery;
begin

   if EdPlan_contasai.resultfind<> nil then begin
     Qb:=Sqltoquery('select plan_contacorrente,plan_codigobanco from plano where plan_ctachequescomp='+EdPlan_contasai.AsSql);
     if not Qb.eof then begin
//      if (Qb.fieldbyname('Plan_contacorrente').AsInteger>0) and (Qb.fieldbyname('Plan_codigobanco').AsString<>'') then begin
// 10.06.14 - Novi - elize pegou
        if (Qb.fieldbyname('Plan_contacorrente').AsString<>'') and (Qb.fieldbyname('Plan_codigobanco').AsString<>'') then begin
          Q:=Sqltoquery('select cheq_cheque from cheques where cheq_status=''N'' and cheq_emirec=''E'''+
    //                ' and Cheq_emit_agencia='+Stringtosql(EdPlan_contasai.resultfind.fieldbyname('Plan_agencia').AsString)+
                    ' and Cheq_emit_conta='+inttostr(Qb.fieldbyname('Plan_contacorrente').AsInteger)+
                    ' and Cheq_emit_banco='+stringtosql(Qb.fieldbyname('Plan_codigobanco').AsString)+
  //                  ' and Extract(year from Cheq_deposito) <= 1902'+
                    ' and Cheq_deposito is null'+
                    ' and ( (cheq_rc <> ''E'') or (cheq_rc is null) )'+
                    ' order by cheq_cheque' );
          Ed.Items.Clear;
          while not Q.eof do begin
             Ed.Items.Add(Q.fieldbyname('cheq_cheque').asstring);
             Q.Next;
          end;
          FGeral.FEchaQuery(Q);
       end;
     end;
     FGeral.FEchaQuery(Qb);
   end;
end;

procedure TFLancaMovfin.bchequesClick(Sender: TObject);
begin
  if EdCodtipo.asinteger>0 then
    FCadcheques.execute( EdNumerodoc.text,EdDtmovimento.asdate,Edbompara.asdate,EdCodtipo.asinteger,EdValor.ascurrency )
  else
    Avisoerro('Falta informar numero do documento , data e codigo do cliente');
end;

procedure TFLancaMovfin.bextratoClick(Sender: TObject);
begin
//  if trim(transacao)<>'' then
//   FImpressao.ImprimeReciboCaixa( Transacao );
   FRelCxBancos_Extrato;          // 1


end;

// 02.05.13
procedure TFLancaMovfin.BaixaChequeCompensado;
/////////////////////////////////////////////////
var Q:TSqlquery;
begin
    Q:=Sqltoquery('select cheq_cheque from cheques where cheq_status=''N'''+
                  ' and Cheq_emit_agencia='+(EdPlan_contasai.resultfind.fieldbyname('Plan_agencia').AsString)+
                  ' and Cheq_emit_conta='+(EdPlan_contasai.resultfind.fieldbyname('Plan_contacorrente').AsString)+
                  ' and Cheq_emit_banco='+Stringtosql(EdPlan_contasai.resultfind.fieldbyname('Plan_codigobanco').AsString)+
                  ' and Cheq_cheque = '+Stringtosql(EdCheque.text) );
    if not Q.eof then begin
      Sistema.edit('cheques');
//      Sistema.SetField('cheq_valor',EdValor.ascurrency);
// valor colocar na emissao do cheque
      Sistema.SetField('cheq_deposito',EdDtMovimento.asdate);
      Sistema.SetField('cheq_transbaixa',Transacao);
      Sistema.post('cheq_emirec=''E'' and cheq_status=''N'''+
                  ' and Cheq_cheque = '+Stringtosql(EdCheque.text)+
                  ' and Cheq_emit_agencia='+(EdPlan_contasai.resultfind.fieldbyname('Plan_agencia').AsString)+
                  ' and Cheq_emit_conta='+EdPlan_contasai.resultfind.fieldbyname('Plan_contacorrente').AsString+
                  ' and Cheq_emit_banco='+Stringtosql(EdPlan_contasai.resultfind.fieldbyname('Plan_codigobanco').AsString) );
      Sistema.commit;
    end;
    FGeral.fechaquery(q);
  end;

end.

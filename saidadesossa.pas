// 03.10.18f
// da saida da desossa e entrada para setor de embalagens ( em caixa )

unit saidadesossa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ACBrDFe, ACBrNFe, ACBrETQ, ACBrBase,
  ACBrBAL, Vcl.ExtCtrls, Vcl.Grids, SqlDtg, Vcl.StdCtrls, Vcl.FileCtrl,
  Vcl.Mask, SQLEd, Vcl.Buttons, SQLBtn, alabel, SQLGrid,
  AcbrDevice,  Math, ACBrDANFCeFortesFrEA,ACBrDANFCeFortesFrETQDES, pcnconversao,SqlExpr,
  AcbrDeviceSerial,ACBrDANFCeFortesFrETQFAT;

type
  TFSaidaDesossa = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    bretnropedido: TSQLBtn;
    bimpetq: TSQLBtn;
    bexcluipesagem: TSQLBtn;
    EdSeqi: TSQLEd;
    EdSeqf: TSQLEd;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PRemessa: TSQLPanelGrid;
    EdNumeroDOC: TSQLEd;
    PPedidos: TSQLPanelGrid;
    GridCortes: TSqlDtGrid;
    PTotais: TSQLPanelGrid;
    Label1: TLabel;
    Label5: TLabel;
    ppesobalanca: TLabel;
    ptara: TLabel;
    panimaispesados: TSQLPanelGrid;
    ACBrBAL1: TACBrBAL;
    ACBrETQ1: TACBrETQ;
    ACBrNFe1: TACBrNFe;
    EdEsto_codigo: TSQLEd;
    EdPecas: TSQLEd;
    impetiqueta: TSQLBtn;
    procedure EdNumeroDOCChange(Sender: TObject);
    procedure EdNumeroDOCKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdNumeroDOCValidate(Sender: TObject);
    procedure bSairClick(Sender: TObject);
    procedure EdEsto_codigoValidate(Sender: TObject);
    procedure EdEsto_codigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bexcluipesagemClick(Sender: TObject);
    procedure ACBrBAL1LePeso(Peso: Double; Resposta: AnsiString);
    procedure bimpetqClick(Sender: TObject);
    procedure bretnropedidoClick(Sender: TObject);
    procedure EdPecasValidate(Sender: TObject);
    procedure EdPecasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ConfiguraTeclas( Key: Word );
    Procedure Execute(xOP:string='');
    Procedure ZeraCampos;
    procedure ConfiguraBalancas;
    function  AbrirPorta(qbalanca:string):boolean;
    procedure AtualizaValores;
    procedure imprimeetiqueta;
    procedure GravaPesoCaixa;
    function NaoforGrupoMiudos( xcodigo:string ):boolean;

  end;

var
  FSaidaDesossa: TFSaidaDesossa;
  TipoMov,
  TipoMovDS,
  xOP,
  Unidade,
  codigoasercortado,
  codigoetiqueta,
  resfriado,
  transacaoE,
  movd_obsQp              :string;
  tara,peso               :currency;
  QC                      :TSqlquery;

implementation

uses Geral, Estoque,PcnNfe, SqlFun, SqlSis, cadcli, custos, munic,
  Unidades, cadcor, StrUtils, ShellApi;


{$R *.dfm}

{ TFSaidaDesossa }

function TFSaidaDesossa.AbrirPorta(qbalanca: string): boolean;
////////////////////////////////////////////////////////////////
begin

  if (qbalanca='BAL1') or ( trim(qbalanca)='') then begin
    try
     Acbrbal1.Ativar;
     result:=true;
    except
      Avisoerro('Problemas para abrir a porta '+AcbrBal1.Porta);
      result:=false;
    end;
  end else if qbalanca='BAL2' then begin
  {
    try
     Acbrbal2.Ativar;
     result:=true;
    except
      Avisoerro('Problemas para abrir a porta '+AcbrBal2.Porta);
      result:=false;
    end;
    }
  end;

end;


// 03.10.18
procedure TFSaidaDesossa.ACBrBAL1LePeso(Peso: Double; Resposta: AnsiString);
///////////////////////////////////////////////////////////////////////////////
var valid,
    posiD : integer;
    xResposta,outra:string;

begin


//   pPeso.Caption     := formatFloat('##0.000', Peso );

   posid := AnsiPos( 'D', Resposta)  ;
// 02.01.19 - balan�a desossa n�o fica 'enviando direto o peso'...
// 30.01.20 - 'voltou a D'...
//   posid := AnsiPos( 'E', Resposta)  ;
   if posid>0 then
     xResposta := copy( Resposta,posiD+1,6)
   else
//     xResposta := copy( Resposta,3,15)  ;
// 28.01.20
     xResposta := copy( Resposta,2,07)  ;

//   outra:=Acbrbal1.Device.LeString(200,11);
//   ptotalpesado.Caption:=outra;

   pPesobalanca.Caption := xResposta ;
//   pNomeProduto.Caption:=Resposta;
//   PMens.Caption := formatFloat('###0.000', Peso )+' xResposta = '+xResposta;

//   if FGeral.GetConfig1AsInteger('DIVBAL01')>0 then
//        peso:=Texttovalor(xresposta)/FGeral.GetConfig1AsInteger('DIVBAL01')
//   else

        peso:=Texttovalor(xresposta);


    if Peso >= 0 then begin
//      PMens.Caption := 'Leitura OK !';
      PMens.Caption := resposta+' - '+xresposta;
//      EdPeso.SetValue(peso);

      Peso := Peso - tara;
      pPesobalanca.Caption     := formatFloat('###0.00', Peso );

   end else
    begin
      valid := Trunc(AcbrBal1.UltimoPesoLido);
//      {
      case valid of
         0 : PMens.Caption := 'TimeOut !'+sLineBreak+
                                 'Coloque o produto sobre a Balan�a!' ;
        -1 : PMens.Caption := 'Peso Instavel ! ' +sLineBreak+
                                 'Tente Nova Leitura' ;
        -2 : PMens.Caption := 'Peso Negativo !' ;
       -10 : PMens.Caption := 'Sobrepeso !' ;
      end;
//      }
    end ;

end;

procedure TFSaidaDesossa.AtualizaValores;
//////////////////////////////////////////
var p,r,animais:integer;
    valortotal,pesototal:currency;
    produto:string;
begin

  valortotal:=0;pesototal:=0;animais:=0;
  for r:=1 to GridCortes.RowCount do begin

     if Texttovalor(GridCortes.cells[GridCortes.getcolumn('movd_pesocarcaca'),r])>0 then begin
       produto:=GridCortes.cells[GridCortes.getcolumn('mpdd_esto_codigo'),r];
       pesototal:=pesototal+Texttovalor(GridCortes.cells[GridCortes.getcolumn('movd_pesocarcaca'),r]);
//       valor:=qtde*unitario;
//       valortotal:=valortotal+valor;
//       GridCortes.cells[GridCortes.Getcolumn('movd_pesocarcaca'),r]:=FormatFloat(f_cr3,qtde);
//       GridCortes.cells[GridCortes.Getcolumn('total'),r]:=FormatFloat(f_cr,valor)
       inc(animais);
     end;

  end;

//  PTotalPesado.caption:=FormatFloat(f_cr3,pesototal);
  panimaispesados.caption:=inttostr(animais);

end;


procedure TFSaidaDesossa.bexcluipesagemClick(Sender: TObject);
///////////////////////////////////////////////////////////////
var xtipo,
    t      :string;
    QX     :TSqlquery;

begin

  if EdNUmerodoc.IsEmpty then exit;
  if trim(codigoetiqueta)='' then begin
     Aviso('Primeiro ler a etiqueta');
     exit;
  end;
  xtipo:='DS';

  QX:=sqltoquery('select movd_transacao,movd_operacao,movd_ordem,movd_pesocarcaca,movd_obs from movabatedet'+
                  ' inner join movabate on (mova_transacao=movd_transacao and mova_tipomov=movd_tipomov)'+
                  ' inner join estoque on ( movd_esto_codigo=esto_codigo )'+
                  ' where movd_tipomov = '+Stringtosql( xtipo )+
                  ' and movd_status = ''N'''+
                  ' and movd_oprastreamento = '+stringtosql(trim(EdNumerodoc.text))+
                  ' and movd_unid_codigo = '+Stringtosql(Global.CodigoUnidade));
 if not QX.Eof then begin

   if Qx.FieldByName('movd_obs').asstring<>'' then begin
      Avisoerro('Etiqueta j� faz parte da caixa de etiqueta '+Qx.FieldByName('movd_obs').asstring);
      exit;
   end;


     t:=Qx.FieldByName('movd_transacao').AsString;
     while not QX.Eof do begin

       Sistema.Edit('movabatedet');
       Sistema.SetField('movd_status','C');
       Sistema.Post('movd_operacao = '+Stringtosql(Qx.FieldByName('movd_operacao').AsString));
       QX.Next;

     end;

      Sistema.Edit('movabatedet');
      Sistema.SetField('movd_pesobalanca',0);
      Sistema.Post('movd_operacao = '+stringtosql(codigoetiqueta)) ;

     Sistema.Edit('movabate');
     Sistema.SetField('mova_status','C');
     Sistema.Post('mova_transacao = '+Stringtosql(t));
     try
       Sistema.Commit;
       Aviso('Excluido');
     except
       Avisoerro('N�o foi poss�vel gravar no banco de dados');
     end;
     FGeral.FechaQuery(QX);
     EdNumerodoc.setfocus;
  end else Avisoerro('Nada encontrado');

end;

procedure TFSaidaDesossa.bimpetqClick(Sender: TObject);
///////////////////////////////////////////////////////
var balanca:string;
    pesonatela   : currency;

begin

    if EdEsto_codigo.IsEmpty then begin
       Avisoerro('Informe o codigo do produto');
       exit;
    end;

    if Confirma('Resfriado ? (S/N)') then resfriado:='S' else resfriado:='N';

    if resfriado = 'S' then

       Tara:=EdEsto_codigo.ResultFind.fieldbyname('esto_taracf').ascurrency

    else

       Tara:=EdEsto_codigo.ResultFind.fieldbyname('esto_tara').ascurrency;

{
    if EdNumerodoc.IsEmpty then begin
       Avisoerro('Informe o codigo da etiqueta');
       exit;
    end;
    if QC.Eof then begin
       Avisoerro('Etiqueta n�o encontrada');
       exit;
    end;
    }

//    pesonatela:=strtocurr(ptotalpesado.Caption);

{
    if (pesonatela<=0) and (Qc.FieldByName('movd_obs').asstring='') then begin
       Avisoerro('Peso zerado');
       exit;
    end;
 }
//    if Global.Usuario.OutrosAcessos[0509] then begin
// 10.04.18

      if global.Usuario.Codigo=101 then begin

         pPesobalanca.caption:='46,123';

      end else if OP <> 'MI'  then begin

          balanca:='BAL1';
          abrirporta( balanca );
          if (balanca='BAL1') or ( trim(balanca)='') then
            AcbrBal1.LePeso( 500 );
//          else
//            AcbrBal2.LePeso( 500 );
      end;



    if (StrToCurrDef( ppesobalanca.Caption,0 ) > 0 ) or (  OP = 'MI' ) then begin

       imprimeetiqueta;

    end;



end;

procedure TFSaidaDesossa.bretnropedidoClick(Sender: TObject);
////////////////////////////////////////////////////////////////
begin

   EdNumerodoc.setfocus;

end;

procedure TFSaidaDesossa.bSairClick(Sender: TObject);
begin
   Close;
end;

procedure TFSaidaDesossa.ConfiguraBalancas;
////////////////////////////////////////////////////////////////

   function GetStopBitsAcBR(stopbit:integer;Serial:TAcbrbal):TAcbrSerialStop;
  ///////////////////////////////////////////////////////////////////
  begin
        case StopBit of
             10: result:=s1;
             15: result:=s1eMeio;
             20: result:=s2;
        end;
  end;

  function GetParidadeAcBR(paridade:string):TAcbrSerialParity;
  /////////////////////////////////////////////////
  begin
       if Paridade='N' then result:=pNone
       else if Paridade='P' then result:=pEven
       else if Paridade='M' then result:=pMark
       else if Paridade='I' then result:=pOdd
       else if Paridade='S' then result:=pSpace;
  end;


//////////////////////////
begin
//////////////////////////
  if AcbrBal1.Ativo then
    AcbrBal1.Desativar;
//  if AcbrBal2.Ativo then
//    AcbrBal2.Desativar;

  if FGeral.GetConfig1AsString('PORTASERIAL2')<>'' then
    AcbrBal1.Device.porta:=FGeral.GetConfig1AsString('PORTASERIAL2');
  if FGeral.GetConfig1AsInteger('velocidadebal2')>0 then
    AcbrBal1.Device.Baud := FGeral.GetConfig1AsInteger('velocidadebal2');
  if FGeral.GetConfig1AsInteger('databitsbal2')>0 then
    AcbrBal1.Device.Data :=FGeral.GetConfig1AsInteger('databitsbal2');
  if FGeral.GetConfig1AsInteger('stopbitsbal2')>0 then
    AcbrBal1.Device.Stop :=GetStopBitsAcBR( FGeral.GetConfig1AsInteger('stopbitsbal2'),AcbrBal1);
  if FGeral.GetConfig1AsString('paridade2')<>'' then
    AcbrBal1.Device.Parity:=GetParidadeAcbr(FGeral.GetConfig1AsString('paridade2'));

   ACBrBAL1.Modelo           := TACBrBALModelo( balFilizola );
   ACBrBAL1.Device.HandShake := TACBrHandShake( hsNenhum );

// 02.03.15
{
  if FGeral.GetConfig1AsString('PORTASERIAL2')<>'' then
    AcbrBal2.Device.porta:=FGeral.GetConfig1AsString('PORTASERIAL2');
  if FGeral.GetConfig1AsInteger('velocidadebal2')>0 then
    AcbrBal2.Device.Baud := FGeral.GetConfig1AsInteger('velocidadebal2');
  if FGeral.GetConfig1AsInteger('databitsbal2')>0 then
    AcbrBal2.Device.Data :=FGeral.GetConfig1AsInteger('databitsbal2');
  if FGeral.GetConfig1AsInteger('stopbitsbal2')>0 then
    AcbrBal2.Device.Stop :=GetStopBitsAcBR( FGeral.GetConfig1AsInteger('stopbitsbal2'),AcbrBal1);
  if FGeral.GetConfig1AsString('paridade2')<>'' then
    AcbrBal2.Device.Parity:=GetParidadeAcbr(FGeral.GetConfig1AsString('paridade2'));

   ACBrBAL2.Modelo           := TACBrBALModelo( balFilizola );
   ACBrBAL2.Device.HandShake := TACBrHandShake( hsNenhum );
}

end;

procedure TFSaidaDesossa.ConfiguraTeclas(Key: Word);
///////////////////////////////////////////////////////
begin

 if key = vk_f4 then bimpetqClick(self)
 else if key = vk_f5 then bimpetqClick(self)
 else if key = vk_f3 then bretnropedidoClick(self)
 else if key = vk_f6 then bSairClick(self)
// else if key = vk_f11 then bromaneioClick(self)
 else if key = vk_f2 then bexcluipesagemClick(self);

end;

procedure TFSaidaDesossa.EdEsto_codigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   configurateclas( key );
end;

procedure TFSaidaDesossa.EdEsto_codigoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////////
var QP,
    QC:   TSqlquery;

begin

   if EdEsto_codigo.ResultFind<>nil then begin

      if EdEsto_codigo.ResultFind.Eof then EdEsto_codigo.Invalid('Codigo n�o encontrado')
      else begin

          GridCortes.Clear;
          GridCortes.AppendRow;
          GridCortes.Cells[GridCortes.GetColumn('mpdd_esto_codigo'),GridCortes.row]:=EdEsto_codigo.Text;
          GridCortes.Cells[GridCortes.GetColumn('esto_descricao'),GridCortes.row]:=EdEsto_codigo.resultfind.fieldbyname('esto_descricao').asstring;

      end;

{
     QP:=sqltoquery('select cust_esto_codigomat from custos where cust_status = ''N'''+
                   ' and cust_esto_codigo = '+stringtosql(trim(EdEsto_codigo.text))+
                   ' and cust_tipo = ''E'' order by cust_core_codigo');

     if QP.Eof then begin
        EdEsto_codigo.Invalid('N�o encontrado a composi��o deste produto');
     end;
     QP.Close;

     Qc:=sqltoquery('select esto_descricao,movd_esto_codigo,movd_ordem,movd_pesocarcaca from movabatedet'+
                  ' inner join movabate on (mova_transacao=movd_transacao and mova_tipomov=movd_tipomov)'+
                  ' inner join estoque on ( movd_esto_codigo=esto_codigo )'+
                  ' where movd_tipomov = '+Stringtosql('DS')+
                  ' and movd_status = ''N'''+
                  ' and movd_esto_codigoven = '+stringtosql(trim(EdEsto_codigo.Text))+
                  ' and ( (movd_obs is null) or (movd_obs = '''' ) )'+
//                  ' and movd_oprastreamento = '+EdNumerodoc.assql+
                  ' and movd_unid_codigo = '+Stringtosql(Global.CodigoUnidade));

       while not Qc.eof do begin

         GridCortes.cells[GridCortes.getcolumn('mpdd_esto_codigo'),GridCortes.row]:=Qc.fieldbyname('movd_esto_codigo').asstring;
         GridCortes.cells[GridCortes.getcolumn('esto_descricao'),GridCortes.row]:=Qc.fieldbyname('esto_descricao').asstring;
         GridCortes.cells[GridCortes.getcolumn('movd_pesocarcaca'),GridCortes.row]:=FGeral.formatavalor( Qc.fieldbyname('movd_pesocarcaca').ascurrency,f_cr) ;
         GridCortes.cells[GridCortes.getcolumn('movd_seq'),GridCortes.row]:=strzero(Qc.fieldbyname('movd_ordem').asinteger,3);
//         inc(x);
         GridCortes.AppendRow;
         QC.Next;

       end;
       QC.close;

       }

   end;

end;

procedure TFSaidaDesossa.EdNumeroDOCChange(Sender: TObject);
/////////////////////////////////////////////////////////////////////////
begin
{
   if ( (copy(EdNumerodoc.Text,1,3)='001') and ( length(trim(EdNumerodoc.Text))=10 ) and
      ( copy(EdNumerodoc.Text,11,1)=' ' ) ) or
      ( length(trim(EdNumerodoc.Text))>=12 )
   then begin
     EdNumerodoc.Valid;
   end;
}

end;

procedure TFSaidaDesossa.EdNumeroDOCKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

//   ConfiguraTeclas(key);
  if key = vk_f6 then Close
  else if key = vk_f5 then bimpetqClick(Self);


end;

// 03.10.18
procedure TFSaidaDesossa.EdNumeroDOCValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////
var sqlaberto,sqlwhere,sqldata,sqlunidades,sqlwhered,ccorte,
    xtipo,
    sqltipomovd,
    sqltipomova,
    transacao:string;
    x,
    Numerodoc:integer;
    QP:Tsqlquery;
    ListaCores,ListaC:Tstringlist;



   procedure GeraeGravaPesos;
   ///////////////////////////
   var
       Q,QE:TSqlquery;
       grava:boolean;


   begin

       grava:=false;

       if NaoforGrupoMiudos( codigoasercortado )  then begin

          Numerodoc:=FGeral.GetContador('DESOSSA'+Global.CodigoUnidade,false,true);
          Transacao:=Global.CodigoUnidade+'D'+strzero(numerodoc,6);

              QE:=Sqltoquery('select * from estoqueqtde where esqt_unid_codigo = '+Stringtosql(Unidade)+
                           ' and esqt_esto_codigo = '+Stringtosql(codigoasercortado)+
                           ' and esqt_status = ''N''');
              grava:=true;
              Sistema.Insert('movabatedet');
              Sistema.SetField('movd_esto_codigo',codigoasercortado);
              Sistema.SetField('movd_transacao',transacao);
              Sistema.SetField('movd_operacao',transacao+inttostr(1));
              Sistema.SetField('movd_numerodoc',numerodoc);
              Sistema.SetField('movd_status','N');
              Sistema.SetField('movd_tipomov',TipoMovDS);
              Sistema.SetField('movd_datamvto',Sistema.Hoje);
              Sistema.SetField('movd_oprastreamento',trim(EdNumerodoc.Text));
//              Sistema.SetField('movd_esto_codigoven',trim(EdEsto_codigo.Text));

              Sistema.SetField('movd_unid_codigo',Unidade);
              Sistema.SetField('movd_tipo_codigo',strtoint(Unidade));
              Sistema.SetField('movd_pesocarcaca',peso);
      //        Sistema.SetField('movd_obs',Grid.cells[Grid.getcolumn('movd_obs'),linha]);
              Sistema.SetField('movd_ordem',1);
              Sistema.SetField('movd_pecas',1);
              Sistema.Post('');
      // 03.10.18 - entra no estoque da embalaggem
      //          - baixa do estoque da etiqueta lida da desossa entrada - DA
      ///////////////////////////////////////////////////////////////////////////////////////////////
              FGeral.MovimentaQtdeEstoque( codigoasercortado ,Unidade,'S',TipoMov,peso,Qe,0,2);

              QE.Close;

// marca a etiqueta como 'ja lida'
              Sistema.Edit('movabatedet');
              Sistema.SetField('movd_pesobalanca',1);
              Sistema.Post('movd_operacao = '+stringtosql(Qc.FieldByName('movd_operacao').AsString)) ;

       end;

         if grava then begin

            Sistema.Insert('movabate');
            Sistema.SetField('mova_transacao',transacao);
            Sistema.SetField('mova_operacao',transacao+'01');
            Sistema.SetField('mova_numerodoc',Numerodoc);
            Sistema.SetField('mova_status','N');
            Sistema.SetField('mova_tipomov',TipoMovDS);

            Sistema.SetField('mova_unid_codigo',Unidade);
            Sistema.SetField('mova_datalcto',Sistema.Hoje);
            Sistema.SetField('mova_dtcarrega',Sistema.Hoje);
            Sistema.SetField('mova_dtabate',Sistema.hoje);
            Sistema.SetField('mova_dtvenci',Sistema.hoje);
            Sistema.SetField('mova_usua_codigo',Global.Usuario.Codigo);
      //      mova_notagerada numeric(8,0),
            Sistema.SetField('mova_transacaogerada',trim(Ednumerodoc.text));
            Sistema.SetField('mova_tipo_codigo',strtoint(Unidade));
      //      mova_pesovivo numeric(12,3),
            Sistema.SetField('mova_pesocarcaca',peso);
            Sistema.SetField('mova_datacont',Sistema.Hoje);
      //      mova_perc numeric(12,5),
            Sistema.SetField('mova_situacao','P');
      //      mova_tran_codigo character varying(3),
      //      mova_fpgt_codigo character varying(3),
      //      mova_repr_codigo numeric(4,0),
      //      mova_vlrtotal numeric(12,3),
      //      mova_perccomissao numeric(8,3),
      //      mova_vlrgta numeric(12,3)
            Sistema.Post();
            try
               Sistema.commit;
//               Aviso('Pesos gravados');

 //              EdSeqf.OnExitEdit(self);
///////               Zeracampos;
            except
               Avisoerro('N�O GRAVADO');
            end;

            Ednumerodoc.clear;
            Ednumerodoc.setfocus;

         end;
////////////////////////////////////////////
     Fgeral.FechaQuery(Q);
   end;


//////////////////////////////////////////
begin
///////////////////////////////////////////


   GridCortes.clear;
   x:=1;
   xtipo:='DE';
   QC:=sqltoquery('select esto_descricao,movd_esto_codigo,movd_ordem,movd_pesocarcaca,'+
                  ' movd_operacao,movd_pesobalanca,movd_obs from movabatedet'+
                  ' inner join movabate on (mova_transacao=movd_transacao and mova_tipomov=movd_tipomov)'+
                  ' inner join estoque on ( movd_esto_codigo=esto_codigo )'+
                  ' where movd_tipomov = '+Stringtosql(xtipo )+
                  ' and movd_status = ''N'''+
                  ' and movd_operacao = '+stringtosql(trim(EdNumerodoc.text))+
                  ' and movd_unid_codigo = '+Stringtosql(Global.CodigoUnidade));
   codigoetiqueta:='';
   peso:=0;
// 05.10.18
   if not QC.Eof then begin

     codigoetiqueta:=Qc.FieldByName('movd_operacao').AsString;
     EdEsto_codigo.Text:=Qc.fieldbyname('movd_esto_codigo').asstring;
     Peso:=Qc.fieldbyname('movd_pesocarcaca').ascurrency;
     QP:=sqltoquery('select esto_descricao,movd_esto_codigo,movd_ordem,movd_pesocarcaca,movd_datamvto,movd_obs from movabatedet'+
                  ' inner join movabate on (mova_transacao=movd_transacao and mova_tipomov=movd_tipomov)'+
                  ' inner join estoque on ( movd_esto_codigo=esto_codigo )'+
                  ' where movd_tipomov = '+Stringtosql('DS')+
                  ' and movd_status = ''N'''+
                  ' and movd_esto_codigo = '+stringtosql(trim(EdEsto_codigo.Text))+
                  ' and ( (movd_obs is null) or (movd_obs = '''' ) )'+
//                  ' and movd_oprastreamento = '+EdNumerodoc.assql+
                  ' and movd_unid_codigo = '+Stringtosql(Global.CodigoUnidade));
       x:=1;
       movd_obsQp:=QP.FieldByName('movd_obs').AsString;


       while not QP.eof do begin

         GridCortes.cells[GridCortes.getcolumn('mpdd_esto_codigo'),x]:=QP.fieldbyname('movd_esto_codigo').asstring;
         GridCortes.cells[GridCortes.getcolumn('esto_descricao'),x]:=QP.fieldbyname('esto_descricao').asstring;
         GridCortes.cells[GridCortes.getcolumn('movd_pesocarcaca'),x]:=FGeral.formatavalor( QP.fieldbyname('movd_pesocarcaca').ascurrency,f_cr) ;
         GridCortes.cells[GridCortes.getcolumn('movd_data'),x]:=FGeral.FormataData( QP.fieldbyname('movd_datamvto').asdatetime );
//         GridCortes.cells[GridCortes.getcolumn('movd_seq'),x]:=strzero(QP.fieldbyname('movd_ordem').asinteger,3);
         inc(x);
         GridCortes.AppendRow;
         QP.Next;

       end;
       QP.close;


   end;

   if QC.eof then begin

     aviso('Etiqueta n�o encontrada');
     exit;

   end else if movd_obsQp<>'' then begin

            AtualizaValores;
            Avisoerro('Etiqueta j� EMBALADA');
            exit;

   end else if Qc.fieldbyname('movd_pesobalanca').ascurrency>0 then begin

            AtualizaValores;
            Avisoerro('Etiqueta j� LIDA');
            exit;
   end;

   codigoasercortado:=Qc.FieldByName('movd_esto_codigo').AsString;

// 05.10.18 - Isonel mudou para n�o criar novos codigos para as caixas para usar o mesmo codigo
   {
   QP:=sqltoquery('select cust_esto_codigomat from custos where cust_status = ''N'''+
                   ' and cust_esto_codigo = '+stringtosql(trim(EdEsto_codigo.text))+
                   ' and cust_tipo = ''E'' order by cust_core_codigo');


///   GridCortes.Clear;

//     ver se tem composicao
     if ( not QP.Eof ) and ( Qc.fieldbyname('movd_esto_codigo').asstring<>QP.fieldbyname('cust_esto_codigomat').asstring) then begin

         EdNUmerodoc.Invalid('Permitido somente codigo '+QP.fieldbyname('cust_esto_codigomat').asstring);
         exit;

     end;

     }

     GeraeGravaPesos;
     xtipo:=TipoMovDS;

     FGeral.FechaQuery(QC);
///////////////////////////////////////////////     EdNumerodoc.Valid;


     QC:=sqltoquery('select esto_descricao,movd_esto_codigo,movd_ordem,movd_pesocarcaca,movd_datamvto from movabatedet'+
                  ' inner join movabate on (mova_transacao=movd_transacao and mova_tipomov=movd_tipomov)'+
                  ' inner join estoque on ( movd_esto_codigo=esto_codigo )'+
                  ' where movd_tipomov = '+Stringtosql(xtipo)+
                  ' and movd_status = ''N'''+
                  ' and movd_esto_codigo = '+stringtosql(trim(EdEsto_codigo.Text))+
                  ' and ( (movd_obs isnull) or (movd_obs = '''' ) )'+
//                  ' and movd_oprastreamento = '+EdNumerodoc.assql+
                  ' and movd_unid_codigo = '+Stringtosql(Global.CodigoUnidade));

   x:=GridCortes.Row;
   while not Qc.eof do begin

     GridCortes.cells[GridCortes.getcolumn('mpdd_esto_codigo'),x]:=Qc.fieldbyname('movd_esto_codigo').asstring;
     GridCortes.cells[GridCortes.getcolumn('esto_descricao'),x]:=Qc.fieldbyname('esto_descricao').asstring;
     GridCortes.cells[GridCortes.getcolumn('movd_pesocarcaca'),x]:=FGeral.formatavalor( Qc.fieldbyname('movd_pesocarcaca').ascurrency,f_cr) ;
//     GridCortes.cells[GridCortes.getcolumn('movd_seq'),x]:=strzero(Qc.fieldbyname('movd_ordem').asinteger,3);
     GridCortes.cells[GridCortes.getcolumn('movd_data'),x]:=FGeral.FormataData( QC.fieldbyname('movd_datamvto').asdatetime );
     inc(x);
     GridCortes.AppendRow;
     QC.Next;

   end;

   FGeral.FechaQuery(QC);


   AtualizaValores;


end;

// 23.10.18
procedure TFSaidaDesossa.EdPecasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   ConfiguraTeclas( key );
end;

procedure TFSaidaDesossa.EdPecasValidate(Sender: TObject);
/////////////////////////////////////////////////////////////
begin

   if EdPecas.AsCurrency>0  then bimpetqClick( self );

end;

procedure TFSaidaDesossa.Execute(xOP: string);
///////////////////////////////////////////////////////
var grupodesossa:integer;

begin

   OP:=xOP;
   GrupoDesossa:=6;  // ver pra criar configuracao produtos desossa
   impetiqueta.visible := false;
   Caption := 'Entrada Embalagem';

   if OP = 'MI' then begin

      if FGeral.GetConfig1AsInteger('grupomiudos') = 0 then

         GrupoDesossa := 8

      else

         GrupoDesossa := FGeral.GetConfig1AsInteger('grupomiudos');

      impetiqueta.visible := true;
      Caption := 'Etiquetas Mi�dos';

   end;

   EdEsto_codigo.ClearAll(FSaidaDesossa,99);
   FEstoque.SetaItemsporGrupo(EdEsto_codigo,GrupoDesossa);
/////////////   GridPedido.clear;
   GridCortes.clear;
   ZeraCampos;
   ConfiguraBalancas;
   Tipomov:='ER';     // entrada embalagens
   TipoMovDS:='DS';   // saida desossa

   if not Global.Usuario.OutrosAcessos[0040] then
     abrirporta( 'BAL1' );

   Unidade:=Global.CodigoUnidade;
   FSaidaDesossa.WindowState:=wsMaximized;
   FGeral.ConfiguraColorEditsNaoEnabled(FSaidaDesossa);
   EdSeqi.Visible:=false;
   EdSeqf.Visible:=false;

   Show;
//   EdNumerodoc.setfocus;
   EdEsto_codigo.SetFocus

end;

// 08.10.18
procedure TFSaidaDesossa.GravaPesoCaixa;
///////////////////////////////////////////
var peso,
    pecaspesadas :currency;
    operacao,
    xtipo          :string;
    numerodoc      :integer;
    QE             :TSqlquery;

begin

//   ER - entrada embalagem resfriado    EC - entrada embalagem congelada
    xtipo:='ER';
    if resfriado = 'N' then xtipo:='EC';

// s� quando respoder 'sim' q formou a caixa q dai da entrada na embalagem...
              QE:=Sqltoquery('select * from estoqueqtde where esqt_unid_codigo = '+Stringtosql(Unidade)+
                           ' and esqt_esto_codigo = '+EdEsto_codigo.AsSql+
                           ' and esqt_status = ''N''');

              if OP = 'MI' then

                 peso:=0

              else

                 peso:=strtocurr(ppesobalanca.Caption);

              //              pecaspesadas:=strtocurr(panimaispesados.Caption);
              pecaspesadas:=EdPecas.AsCurrency;
              Numerodoc:=FGeral.GetContador('DESOSSA'+Global.CodigoUnidade,false,true);
              TransacaoE:='9589'+strzero(numerodoc,6);
              OPeracao:=transacaoE+'01';

              Sistema.Insert('movabatedet');
              Sistema.SetField('movd_esto_codigo',trim(EdEsto_codigo.Text));
              Sistema.SetField('movd_transacao',transacaoE);
              Sistema.SetField('movd_operacao',operacao);
              Sistema.SetField('movd_numerodoc',numerodoc);
              Sistema.SetField('movd_status','N');
              Sistema.SetField('movd_tipomov',xTipo);

              Sistema.SetField('movd_unid_codigo',Unidade);
              Sistema.SetField('movd_tipo_codigo',strtoint(Unidade));
              Sistema.SetField('movd_pesocarcaca',peso);
      //        Sistema.SetField('movd_obs',Grid.cells[Grid.getcolumn('movd_obs'),linha]);
              Sistema.SetField('movd_ordem',1);
              Sistema.SetField('movd_pecas',pecaspesadas);
              Sistema.SetField('movd_datamvto',Sistema.Hoje);
              Sistema.Post('');

// 20.09.19
          if NaoforGrupoMiudos( trim(EdEsto_codigo.Text) )  then begin

// faz a saida da desossa - DS
              OPeracao:=transacaoE+'02';

              Sistema.Insert('movabatedet');
              Sistema.SetField('movd_esto_codigo',trim(EdEsto_codigo.Text));
              Sistema.SetField('movd_transacao',transacaoE);
              Sistema.SetField('movd_operacao',operacao);
              Sistema.SetField('movd_numerodoc',numerodoc);
              Sistema.SetField('movd_status','N');
              Sistema.SetField('movd_tipomov',TipomovDS);

              Sistema.SetField('movd_unid_codigo',Unidade);
              Sistema.SetField('movd_tipo_codigo',strtoint(Unidade));
              Sistema.SetField('movd_pesocarcaca',peso);
              Sistema.SetField('movd_ordem',1);
              Sistema.SetField('movd_pecas',pecaspesadas);
              Sistema.SetField('movd_datamvto',Sistema.Hoje);
              Sistema.Post('');

          end;

      // 08.10.18 - entra no estoque de caixas  embaladas
      // 23.10.18 - saida da desossa
      ///////////////////////////////////////////////////////////////////////////////////////////////
             FGeral.MovimentaQtdeEstoque( EdEsto_codigo.text ,Unidade,'E',TipoMov,peso,Qe,0,pecaspesadas);

             if NaoforGrupoMiudos( trim(EdEsto_codigo.Text) )  then
                FGeral.MovimentaQtdeEstoque( EdEsto_codigo.text ,Unidade,'S','DS',peso,Qe,0,pecaspesadas);
             QE.close;

// mestre da entrada da embalagem

            Sistema.Insert('movabate');
            Sistema.SetField('mova_transacao',transacaoE);
            Sistema.SetField('mova_operacao',transacaoE+'01');
            Sistema.SetField('mova_numerodoc',Numerodoc);
            Sistema.SetField('mova_status','N');
            Sistema.SetField('mova_tipomov',xTipo);
            Sistema.SetField('mova_unid_codigo',Unidade);
            Sistema.SetField('mova_datalcto',Sistema.Hoje);
            Sistema.SetField('mova_dtcarrega',Sistema.Hoje);
            Sistema.SetField('mova_dtabate',Sistema.hoje);
            Sistema.SetField('mova_dtvenci',Sistema.hoje);
            Sistema.SetField('mova_usua_codigo',Global.Usuario.Codigo);
      //      mova_notagerada numeric(8,0),
//            Sistema.SetField('mova_transacaogerada',Ednumerodoc.text);
            Sistema.SetField('mova_tipo_codigo',strtoint(Unidade));
      //      mova_pesovivo numeric(12,3),
            Sistema.SetField('mova_pesocarcaca',peso);
            Sistema.SetField('mova_datacont',Sistema.Hoje);
      //      mova_perc numeric(12,5),
            Sistema.SetField('mova_situacao','P');
      //      mova_tran_codigo character varying(3),
      //      mova_fpgt_codigo character varying(3),
      //      mova_repr_codigo numeric(4,0),
      //      mova_vlrtotal numeric(12,3),
      //      mova_perccomissao numeric(8,3),
      //      mova_vlrgta numeric(12,3)
            Sistema.Post();

// mestre da saida da Desossa
          if NaoforGrupoMiudos( trim(EdEsto_codigo.Text) )  then begin

            Sistema.Insert('movabate');
            Sistema.SetField('mova_transacao',transacaoE);
            Sistema.SetField('mova_operacao',transacaoE+'02');
            Sistema.SetField('mova_numerodoc',Numerodoc);
            Sistema.SetField('mova_status','N');
            Sistema.SetField('mova_tipomov',TipoMovDS);
            Sistema.SetField('mova_unid_codigo',Unidade);
            Sistema.SetField('mova_datalcto',Sistema.Hoje);
            Sistema.SetField('mova_dtcarrega',Sistema.Hoje);
            Sistema.SetField('mova_dtabate',Sistema.hoje);
            Sistema.SetField('mova_dtvenci',Sistema.hoje);
            Sistema.SetField('mova_usua_codigo',Global.Usuario.Codigo);
      //      mova_notagerada numeric(8,0),
//            Sistema.SetField('mova_transacaogerada',Ednumerodoc.text);
            Sistema.SetField('mova_tipo_codigo',strtoint(Unidade));
      //      mova_pesovivo numeric(12,3),
            Sistema.SetField('mova_pesocarcaca',peso);
            Sistema.SetField('mova_datacont',Sistema.Hoje);
      //      mova_perc numeric(12,5),
            Sistema.SetField('mova_situacao','P');
            Sistema.Post();

          end;

// identifica as pesagens q foram para dentro da caixa
{
            Sistema.edit('movabatedet');
            Sistema.SetField('movd_obs',transacaoE);
            Sistema.Post('movd_status = ''N'' and movd_esto_codigo = '+stringtosql(EdEsto_codigo.Text)+
                         ' and ( (movd_obs is null) or (movd_obs = '''' ) )'+
                         ' and movd_tipomov = '+Stringtosql(tipomovDS)+
                         ' and movd_unid_codigo = '+Stringtosql(Global.CodigoUnidade)
                         );
}

            try
               Sistema.commit;
               if op <> 'MI' then

                  Aviso('Peso gravado');

 //              EdSeqf.OnExitEdit(self);
//               Zeracampos;
//               Ednumerodoc.clear;
//               Ednumerodoc.setfocus;
               EdEsto_codigo.SetFocus;

            except
               Avisoerro('N�O GRAVADO');
            end;

end;

procedure TFSaidaDesossa.imprimeetiqueta;
//////////////////////////////////////////
var s,
    xtipo,
    w          :string;
    Q1,
    QNutri,
    QConserva,
    QItens,
    Q2,
    QConservares         :TSqlquery;
    totalitem,
    totalpeso  : currency;
    i,
    nitens,
    p,
    maximo     : integer;

begin


    if OP = 'MI' then

      AcbrNFe1.DANFE := TACBrNFeDANFCeFortesETQFat.Create(AcbrNFe1)

    else

      AcbrNFe1.DANFE := TACBrNFeDANFCeFortesETQDES.Create(AcbrNFe1);

    AcbrNfe1.DANFE.TipoDANFE := tiNFCE;

    if Global.usuario.outrosacessos[0510] then
      acbrnfe1.danfe.MostraPreview:=true
    else
      acbrnfe1.danfe.MostraPreview:=false;

    acbrnfe1.danfe.MargemEsquerda:=01;
    acbrnfe1.danfe.MargemDireita:=05;
    acbrnfe1.danfe.MargemSuperior:=18;
    acbrnfe1.danfe.MargemInferior:=10;


//    if FileExists( ExtractFilePath( Application.ExeName ) + 'LogoBalanca.jpg' ) then
//      acbrnfe1.danfe.Logo:=ExtractFilePath( Application.ExeName ) + 'LogoBalanca.jpg';
    s:=LeArquivoINI(Global.NomeSistema,'Impressoras','IMPETQDES');
    if trim(s)<>'' then Acbrnfe1.DANFE.Impressora:=s;
    nitens:=EdPecas.AsInteger;

////////////////////////////////////////////////////////////////////////
{
      xtipo:='DE';

      Q2:=sqltoquery('select movd_obs from movabatedet'+
                     ' inner join movabate on ( movd_numerodoc=mova_numerodoc and movd_transacao=mova_transacao )'+
                     ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                     ' inner join clientes on ( clie_codigo=movd_tipo_codigo )'+
                     ' where movd_operacao = '+stringtosql( QC.FieldByName('movd_operacao').asstring )+
//                     ' and movd_tipomov='+stringtosql('EA')+
                     ' and movd_tipomov='+stringtosql( xtipo )+
                     ' and mova_tipomov='+stringtosql( xtipo )+
                     ' and movd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                     ' and '+FGeral.GetIN('movd_status','N','C')+
                     ' order by movd_ordem' );

    if Q2.Eof then begin
       Avisoerro('N�o encontrado');
       exit;
    end;

// busca as respectiva DS para depois buscar a EC/ER
    xtipo:=tipomovDS;

    w:= 'where movd_oprastreamento = '+stringtosql( trim(EdNumerodoc.text) );

    Q2:=sqltoquery('select * from movabatedet'+
                     ' inner join movabate on ( movd_numerodoc=mova_numerodoc and movd_transacao=mova_transacao )'+
                     ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                      w +
                     ' and movd_tipomov='+stringtosql( xtipo )+
                     ' and mova_tipomov='+stringtosql( xtipo )+
                     ' and movd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                     ' and '+FGeral.GetIN('movd_status','N','C')+
                     ' order by movd_ordem' );


}

    xtipo:=tipomov;
    if resfriado='N' then xtipo:='EC';

{
//    if transacaoE<>'' then
//      w:= ' where movd_transacao = '+stringtosql( transacaoE )
//    else
//      w:= ' where movd_transacao = '+stringtosql( movd_obsQp );
    w:= 'where movd_transacao = '+stringtosql( Q2.fieldbyname('movd_obs').asstring );
    Q1:=sqltoquery('select * from movabatedet'+
                     ' inner join movabate on ( movd_numerodoc=mova_numerodoc and movd_transacao=mova_transacao )'+
                     ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                      w +
                     ' and movd_tipomov='+stringtosql( xtipo )+
                     ' and mova_tipomov='+stringtosql( xtipo )+
                     ' and movd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                     ' and '+FGeral.GetIN('movd_status','N','C')+
                     ' order by movd_ordem' );
//  aqui buscar o EC/ER para imprimir ou grava-lo e imprimir..
}

//    if Q1.Eof then begin

       GravaPesoCaixa;

//       FGeral.FechaQuery(Q1);

//       if transacaoE<>'' then
         w:= ' where movd_transacao = '+stringtosql( transacaoE ) ;
//       else
//         w:= ' where movd_transacao = '+stringtosql( movd_obsQp );

       Q1:=sqltoquery('select * from movabatedet'+
                     ' inner join movabate on ( movd_tipomov=mova_tipomov and movd_transacao=mova_transacao )'+
                     ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                      w +
                     ' and movd_tipomov='+stringtosql( xtipo )+
                     ' and mova_tipomov='+stringtosql( xtipo )+
                     ' and movd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                     ' and '+FGeral.GetIN('movd_status','N','C')+
                     ' order by movd_ordem' );

//    end;

    xtipo:=tipomovds;

    if Q1.Eof then Avisoerro('N�o encontrado transacao gerada '+transacaoE)

    else begin

//       Qitens:=Sqltoquery('select count(*) as qt from movabatedet '+
//                     ' where movd_obs = '+stringtosql( Q1.FieldByName('movd_transacao').asstring )+
//                     ' and movd_tipomov='+stringtosql( xtipo )+
//                     ' and movd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
//                     ' and '+FGeral.GetIN('movd_status','N','C'));
//       nitens:=Qitens.FieldByName('qt').AsInteger;
//       FGeral.FechaQuery(QItens);

    end;

    while not Q1.eof do begin

      with  ACBrNFe1.NotasFiscais.Add.NFe do begin

//        Total.ICMSTot.vBC   := Q1.fieldbyname('movd_pesovivo').ascurrency;
//        Total.ICMSTot.vProd := Q1.fieldbyname('movd_pesovivo').ascurrency;
        Emit.xFant          := FUnidades.GetNome((unidade));
        Emit.xNome          := FUnidades.GetRazaoSocial((unidade));
        if op = 'MI' then

          Emit.CNPJCPF        := 'MIUDOS'

        else

          Emit.CNPJCPF        := 'DESOSSA';   // FCadcli.GetCnpjCpf(codigocliente);

//        Emit.EnderEmit.xLgr := Q1.fieldbyname('clie_endres').asstring;
        Emit.EnderEmit.nro  := '';
        Emit.EnderEmit.xCpl := '';
//        codmuniemitente     := FCidades.GetCodigoIBGE( FUnidades.GetCidaCodigo(Global.CodigoUnidade) );
//        Ide.cUF             := strtoint(copy(codmuniemitente,1,2));
// 21.08.17
        Ide.cNF             := Q1.FieldByName('mova_numerodoc').AsInteger;
        Ide.dEmi            := Q1.fieldbyname('mova_dtabate').asdatetime;
        Ide.modelo          := nitens;
        if resfriado = 'S' then
           Ide.dSaiEnt:=Sistema.Hoje+60
        else
           Ide.dSaiEnt:=Sistema.Hoje+180;
// 09.10.18
          with  Det.Add do
          begin

            totalitem:=FGEral.Arredonda(Q1.fieldbyname('movd_pesocarcaca').ascurrency*(Q1.fieldbyname('movd_vlrarroba').asFLOAT/15),2);
            Prod.qCom    := Q1.fieldbyname('movd_pesocarcaca').asfloat;
            if resfriado = 'S' then
               Prod.qTrib   := Q1.fieldbyname('esto_taracf').asfloat
            else
               Prod.qTrib   := Q1.fieldbyname('esto_tara').asfloat;

            Prod.uCom    := Q1.fieldbyname('esto_unidade').asstring;
            Prod.uTrib   := Q1.fieldbyname('esto_unidade').asstring;
            Prod.vProd   := totalitem;
            Prod.vUnCom  := Q1.fieldbyname('movd_vlrarroba').asfloat;
            Prod.vUnTrib := Q1.fieldbyname('movd_vlrarroba').asfloat;
            Prod.xProd   := Q1.fieldbyname('esto_descricao').asstring;

            totalpeso:=totalpeso+Q1.fieldbyname('movd_pesocarcaca').asfloat;
            Prod.cProd   := Q1.fieldbyname('movd_esto_codigo').asstring;
//            Prod.cProd   := Q1.fieldbyname('movd_ordem').asstring;
            Prod.xPed    := Q1.fieldbyname('movd_operacao').asstring;
// 08.03.19
            if Resfriado = 'S' then begin

                if Q1.FieldByName('esto_validaderes').AsInteger >0 then
                  Prod.NCM:=inttostr( Q1.FieldByName('esto_validaderes').AsInteger )
                else
                  Prod.NCM:='';

            end else begin

                if Q1.FieldByName('esto_validade').AsInteger >0 then
                  Prod.NCM:=inttostr( Q1.FieldByName('esto_validade').AsInteger )
                else
                  Prod.NCM:='';

            end;

            QNutri:=sqltoquery('select * from nutricionais where nutr_codigo='+inttostr(Q1.FieldByName('esto_nutr_codigo').AsInteger));
            if not QNutri.Eof then begin
              with Prod.arma.Add do begin
                descr:=QNutri.FieldByName('Nutr_porcaocaseira').AsString;
                nCano:=QNutri.FieldByName('Nutr_qtdeporcao').AsString;
              end;
//              Prod.vFrete:=QNutri.FieldByName('Nutr_carboidratos').AsCurrency;
//              Prod.vDesc:=QNutri.FieldByName('Nutr_proteinas').AsCurrency;
//              Prod.vOutro:=QNutri.FieldByName('Nutr_gordtotais').AsCurrency;
//              Prod.vSeg:=QNutri.FieldByName('Nutr_fibras').AsCurrency;
//              Prod.qTrib:=QNutri.FieldByName('Nutr_sodio').AsCurrency;
//              Prod.vUnTrib:=QNutri.FieldByName('Nutr_calorias').AsCurrency;
//              Prod.vUnCom:=QNutri.FieldByName('Nutr_gordsaturadas').AsCurrency;
// 19.09.17 - mudado em 08.03.19 para usar validade do proprio produto
//              if QNutri.FieldByName('nutr_validade').AsInteger >0 then
//                Prod.NCM:=inttostr( QNutri.FieldByName('nutr_validade').AsInteger )
//              else
//                Prod.NCM:='';

            end;
            QNutri.Close;

            QConserva:=sqltoquery('select * from conservacao where cons_codigo='+inttostr(Q1.FieldByName('esto_cons_codigo').AsInteger));
            QConservares:=sqltoquery('select * from conservacao where cons_codigo='+inttostr(Q1.FieldByName('esto_cons_codigores').AsInteger));
            if not Qconserva.Eof then begin
              if resfriado = 'N' then
                 Prod.uCom:=QConserva.FieldByName('cons_linha1').AsString
              else
                 Prod.uCom:=QConservares.FieldByName('cons_linha1').AsString;
            end;
            Qconserva.Close;

          end;

        Total.ICMSTot.vNF   := totalpeso;

          Q1.Next;
      end; /// with acbr

    end;  /// Q1.eof

    FGeral.FechaQuery(Q1);
    Sistema.beginprocess('Imprimindo');

    if ACBrNFe1.NotasFiscais.Count=0 then avisoerro('componente acbr ficou vazio');

      p      := 1;
      Maximo := 1;
      if op  = 'MI' then Maximo := EdPecas.asinteger;


      for p := 1 to Maximo do begin

          for i:=0 to ACBrNFe1.NotasFiscais.Count-1 do begin


            ACBrNFe1.DANFE.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[i].NFe );

             sleeP(1000);  // senao da i/o error

          end;

      end;

      Sistema.endprocess('');
      ACBrNFe1.NOtasFiscais.clear;


end;

function TFSaidaDesossa.NaoforGrupoMiudos(xcodigo: string): boolean;
///////////////////////////////////////////////////////////////////////
var grupomiudos:integer;
begin

          result:=true;
          grupomiudos:=FGeral.GetConfig1AsInteger('grupomiudos');
          if GrupoMiudos>0 then  begin

             if GrupoMiudos=FEstoque.GetGrupo(xcodigo) then result:=false;

          end;

end;

procedure TFSaidaDesossa.ZeraCampos;
//////////////////////////////////////////
begin

//   PTotalPesado.caption:='';
   PTara.caption:='';
   tara:=0;
//   Ppeso.caption:='';
//   pnomeproduto.caption:='';

end;

end.

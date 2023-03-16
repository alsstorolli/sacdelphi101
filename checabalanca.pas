// 20.02.20 - ficando lendo direto a balan�a e imprime comanda com o peso
unit checabalanca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, SQLEd, ACBrBase,
  ACBrBAL, Vcl.ExtCtrls, SQLGrid, SqlExpr, AcbrDeviceSerial, Vcl.Buttons, SQLBtn;

type
  TFChecabalanca = class(TForm)
    ACBrBAL1: TACBrBAL;
    EdPeso: TSQLEd;
    PMens: TSQLPanelGrid;
    bsair: TSQLBtn;
    EdResposta: TSQLEd;
    Timer1: TTimer;
    blepeso: TSQLBtn;
    procedure ACBrBAL1LePeso(Peso: Double; Resposta: AnsiString);
    procedure EdPesoExitEdit(Sender: TObject);
    procedure bsairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure blepesoClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(mostratela:string='N');
    procedure ConfiguraBalancas;
    procedure GravaPedido( Numero :integer );

  end;

var
  FChecabalanca: TFChecabalanca;
  xTimeout,
  xIntervalo  : integer;
  xMonitora   : string;
  UltimoPeso  : Currency;

implementation

uses sqlfun, Geral, PcnNfe, AcbrDevice, impressao, sqlsis, Menuinicial;

{$R *.dfm}

procedure TFChecabalanca.ACBrBAL1LePeso(Peso: Double; Resposta: AnsiString);
///////////////////////////////////////////////////////////////////////////
var xresposta:string;
    valid,
    pedido    :integer;

begin

//   posid := AnsiPos( 'D', Resposta)  ;

   xResposta := copy( Resposta,3,15)  ;
//   if OP = 'D' then xResposta := copy( Resposta,06,08);

//   pPesobalanca.Caption := xResposta ;

   peso:=Texttovalor(xresposta);
//   peso:=peso - TextTovalor(ptara.Caption);
   EdPeso.SetValue(0);

//   FMain.PMsg.Caption := resposta+' - '+xresposta;
//   Sistema.BeginProcess('Lendo peso balan�a');

//    if (Peso > 0) then begin
// 01.02.2022 - para ver se para de 'disparar' comandas caso deixe o prato em cima...
//              assim 'faiou'
//    if (Peso > 0) and ( AcbrBal1.UltimoPesoLido <> Peso ) then begin
    if (Peso > 0)  then begin

      if FGeral.GetConfig1AsInteger('DIVBAL01') > 0 then
         peso := peso/FGeral.GetConfig1AsInteger('DIVBAL01');

      EdPeso.SetValue(peso);
      try

         Pedido := FGeral.GetContador('PEDVENDA',false);
         Sistema.BeginProcess('Gravando peso');
         GravaPedido( Pedido );
         Sistema.BeginProcess('Imprimindo comanda');

//         Aviso( 'Imprime comanda..');

// 08.02.2022 - para ver se para de 'disparar' comandas caso deixe o prato em cima...
         if (peso <>  UltimoPeso) or (ultimoPeso=0) then begin

            FImpressao.ImprimePedidoVenda(Pedido,Sistema.hoje,Global.CodigoUnidade);
            UltimoPeso := Peso;

         end;
// 29.10.2021
//         EdPeso.text := '';
         Peso := 0;

//         Acbrbal1.

      except on E:exception do begin

          Avisoerro( e.Message );
//          AcbrBal1.MonitorarBalanca:=false;

      end;

      end;

//      pPesobalanca.Caption     := formatFloat('###0.00', Peso );

   end else

    begin
      valid := Trunc(AcbrBal1.UltimoPesoLido);
//      {
      case valid of
{
         0 : FMain.PMsg.Caption := 'TimeOut !'+sLineBreak+
                                 'Coloque o produto sobre a Balan�a!' ;
        -1 : FMain.PMsg.Caption := 'Peso Instavel ! ' +sLineBreak+
                                 'Tente Nova Leitura' ;
        -2 : FMain.PMsg.Caption := 'Peso Negativo !' ;
       -10 : FMain.PMsg.Caption := 'Sobrepeso !' ;
}
         0 : PMens.Caption := 'TimeOut !'+sLineBreak+
                                 'Coloque o produto sobre a Balan�a!' ;
        -1 : PMens.Caption := 'Peso Instavel ! ' +sLineBreak+
                                 'Tente Nova Leitura' ;
        -2 : PMens.Caption := 'Peso Negativo !' ;
       -10 : PMens.Caption := 'Sobrepeso !' ;
      end;
//      }
    end ;

    Sistema.endProcess('');




end;

procedure TFChecabalanca.bsairClick(Sender: TObject);
///////////////////////////////////////////////////////////
begin

   Timer1.enabled := false;
   AcbrBal1.Desativar;
   FChecabalanca.Tag := 1;
   AcbrBal1.MonitorarBalanca:=false;
   Close;

end;

procedure TFChecabalanca.ConfiguraBalancas;
//////////////////////////////////////////////////////

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

  if not AcbrBal1.Ativo then begin
//    AcbrBal1.Desativar;

    if FGeral.GetConfig1AsString('PORTASERIALNF')<>'' then
      AcbrBal1.Device.porta:=FGeral.GetConfig1AsString('PORTASERIALNF');
    if FGeral.GetConfig1AsInteger('saivelocbal1')>0 then
      AcbrBal1.Device.Baud := FGeral.GetConfig1AsInteger('saivelocbal1');
    if FGeral.GetConfig1AsInteger('saidatabitsbal1')>0 then
      AcbrBal1.Device.Data :=FGeral.GetConfig1AsInteger('saidatabitsbal1');
    if FGeral.GetConfig1AsInteger('saistopbitsbal1')>0 then
      AcbrBal1.Device.Stop :=GetStopBitsAcBR( FGeral.GetConfig1AsInteger('saistopbitsbal1'),AcbrBal1);
    if FGeral.GetConfig1AsString('saiparidade1')<>'' then
      AcbrBal1.Device.Parity:=GetParidadeAcbr(FGeral.GetConfig1AsString('saiparidade1'));

  //   ACBrBAL1.Modelo           := TACBrBALModelo( balFilizola );
     ACBrBAL1.Modelo           := TACBrBALModelo( balToledo );
     ACBrBAL1.Device.HandShake := TACBrHandShake( hsNenhum );
// 22.10.2021 - ajustes pra 'reinicio' pequim
    xTimeout := FGeral.GetConfig1AsInteger('baltimeout');
    if xTimeout = 0 then xTimeout := 2000;
    xIntervalo := FGeral.GetConfig1AsInteger('balintervalo');
    if xIntervalo = 0 then xIntervalo := 5000; // padrao de 10 segundos entre as leituras
    Timer1.Interval := xintervalo*1000;
//    AcbrBal1.Intervalo := xIntervalo;
    AcbrBal1.MonitorarBalanca := ( FGeral.GetConfig1AsString('balmonitora')='S' );

 end;


end;

procedure TFChecabalanca.EdPesoExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////////
var pedido:integer;
begin

      try
         Pedido := FGeral.GetContador('PEDVENDA',false);
         GravaPedido( Pedido );
         FImpressao.ImprimePedidoVenda(Pedido,Sistema.hoje,Global.CodigoUnidade);
         EdPeso.text := '';

      except on E:exception do Avisoerro( e.Message );
      end;

end;

procedure TFChecabalanca.Execute(mostratela:string='N');
/////////////////////////////////////////////////////////
var i : integer;
    xresposta      : string;

begin

   FChecabalanca.Tag := 0;
   if mostratela = 'S' then

      ShowModal;

//   aviso('Verificando balan�a');
   configurabalancas;
   FGeral.ConfiguraColorEditsNaoEnabled(FChecaBalanca);
   UltimoPeso := 0;

   if not Acbrbal1.Ativo then begin

     try
        Acbrbal1.Ativar;

     except on E:exception do begin

        Avisoerro('Erro ao conectar com a balan�a.'+E.Message);
        Global.Usuario.OutrosAcessos[0519]:=false;
        AcbrBal1.MonitorarBalanca:=false;
        Acbrbal1.Desativar;
        exit;

     end;

     end;

   end;

//   try

//       while True do begin
{
       while FChecabalanca.Tag = 0  do begin


          Acbrbal1.LePeso( xTimeOut );

          Acbrbal1.InterpretarRepostaPeso( xresposta );

          EdResposta.text := xresposta;

//          AcbrBal1.MonitorarBalanca:=false;

          if FChecabalanca.Tag = 1  then begin

             AcbrBal1.Desativar;
             FChecabalanca.Tag := 0;
             AcbrBal1.MonitorarBalanca:=false;
             break;

          end;


//          for i := 0 to Tempochecagem do
          delay( TempoChecagem );

//          if bsair.IsDown then break;

       end;
}

         Timer1.enabled := true;

///////////////////////////////////////////////////////////////
///
//          if FChecabalanca.Tag = 1  then begin
//
//             AcbrBal1.Desativar;
//             FChecabalanca.Tag := 0;
//             AcbrBal1.MonitorarBalanca:=false;
//             break;

//          end;


//   except on E:exception do begin
//
//        Avisoerro('Erro ao conectar com a balan�a.'+E.Message);
 //       AcbrBal1.MonitorarBalanca:=false;
//        Acbrbal1.Desativar;
//        Global.Usuario.OutrosAcessos[0519]:=false;
//        Sistema.endProcess('');
//        Close;
//   end;

//   end;


end;

// 16.12.2021
procedure TFChecabalanca.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
///////////////////////////////////////////////////////////////////////////////////
begin

      AcbrBal1.Desativar;
      AcbrBal1.MonitorarBalanca := false;
      FChecabalanca.Tag := 1;
      Timer1.enabled := false;

end;

procedure TFChecabalanca.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  //////////////////////////////////////////////////////////////////////////
begin

   if key =  vk_escape then begin

      AcbrBal1.Desativar;
      AcbrBal1.MonitorarBalanca := false;
      FChecabalanca.Tag := 1;
//      Close;
      Timer1.enabled := false;

   end;

end;

procedure TFChecabalanca.GravaPedido( Numero:integer );
//////////////////////////////////////////////////////////
var transacao,
    produto      :string;
    valortotal,
    valorporkilo,
    valorporkilolivre : currency;
    TEstoque     : TSqlquery;

begin

    valorporkilo := FGeral.GetConfig1AsFloat('precokg');
    if AnsiPos( DateToDiaSemana( Sistema.Hoje,0 ) ,'Dom/Sab' ) >0 then
       valorporkilo := FGeral.GetConfig1AsFloat('precokgfds');

// 27.09.2022
    valorporkilolivre := FGeral.GetConfig1AsFloat('precokglivre');
    if AnsiPos( DateToDiaSemana( Sistema.Hoje,0 ) ,'Dom/Sab' ) >0 then
       valorporkilolivre := FGeral.GetConfig1AsFloat('precokgfdslivre');
// 28.12.2022 - Restaurante Pequim
    if Global.Topicos[1430] then begin
       if AnsiPos( DateToDiaSemana( Sistema.Hoje,0 ) ,'Sex' ) >0 then begin
          valorporkilo := FGeral.GetConfig1AsFloat('precokgfds');
          valorporkilolivre := FGeral.GetConfig1AsFloat('precokgfdslivre');
       end;
    end;

    valortotal := ValorporKilo * EdPeso.AsCurrency;
//
    if valortotal >0  then  begin

        transacao  := FGeral.GetTransacao;

        Sistema.Insert('Movped');
        Sistema.SetField('mped_transacao',Transacao);
        Sistema.SetField('mped_operacao',FGeral.GetOperacao);
        Sistema.SetField('mped_status','N');
        Sistema.SetField('mped_numerodoc',Numero);
        Sistema.SetField('mped_tipomov',Global.CodPedVenda);
        Sistema.SetField('mped_unid_codigo',Global.CodigoUnidade);
        Sistema.SetField('mped_tipo_codigo',strtoInt(FGeral.GetConfig1AsString('clieconsumidor')));
        Sistema.SetField('mped_datalcto',Sistema.Hoje);
        Sistema.SetField('mped_datamvto',Sistema.Hoje);
        Sistema.SetField('mped_datacont',Sistema.Hoje);
        Sistema.SetField('mped_vlrtotal',Valortotal);
        Sistema.SetField('mped_valoravista',Valortotal);
    //    Sistema.SetField('mped_tabp_codigo',Tabela);
        Sistema.SetField('mped_fpgt_codigo',FGeral.getconfig1asstring('Fpgtoavista') );
    //    Sistema.SetField('mped_tabaliquota',FTabela.GetAliquota(Tabela));
        Sistema.SetField('mped_usua_codigo',Global.Usuario.Codigo);
    //    Sistema.SetField('mped_pedcliente',EdPedidocliente.asinteger);
        Sistema.SetField('mped_estado',Global.UfUnidade);
    //    Sistema.SetField('mped_cida_codigo',Cliente.resultfind.fieldbyname('clie_cida_codigo_res').asinteger);
    //    Sistema.SetField('mped_repr_codigo',EdRepr_codigo.asinteger);
        Sistema.SetField('mped_tipocad','C');
        Sistema.SetField('mped_dataemissao',Sistema.Hoje);
        Sistema.SetField('mped_totprod',valortotal);
        Sistema.SetField('mped_vispra','V');
    // ver se vai usar
        Sistema.SetField('mped_perdesco',0);
        Sistema.SetField('mped_peracres',0);
        Sistema.SetField('mped_situacao','P');
    //    Sistema.SetField('mped_formaped',EdFormapedido.text);
        Sistema.SetField('mped_envio','F');
    //    Sistema.SetField('Mped_fpgt_prazos',FCondpagto.GetCampoPrazos(EdFpgt_codigo.text));
    //    Sistema.SetField('mped_datapedcli',EdDatacliente.asdate);
    //    Sistema.SetField('mped_obslibcredito',obsliberacao);
    //    Sistema.SetField('mped_datalibcredito',sistema.hoje);
    //    Sistema.SetField('mped_usualibcred',usuariolib);
        Sistema.SetField('mped_obspedido','VIA BALANCA');
// 27.09.2022
        if (valortotal>valorporkilolivre) and ( valorporkilolivre>0) then

           Sistema.SetField('mped_contatopedido','PRATO LIVRE');

    //    if campoportador.Tipo<>'' then
    //      Sistema.SetField('mped_port_codigo',EdPort_codigo.text);
    {
        if campocomissao.Tipo<>'' then begin

           Sistema.SetField('mped_vlrcomissao',Edvlrcomissao.ascurrency);
           Sistema.SetField('mped_percomissao',Edpercomissao.ascurrency);

        end;
    }

        Sistema.Post();

          TEstoque := sqltoquery('select * from estoque where esto_codigo = '+Stringtosql(produto));
          Produto := '00001';
          Sistema.Insert('movpeddet');
          Sistema.SetField('mpdd_esto_codigo',Produto);
          Sistema.SetField('mpdd_transacao',transacao);
          Sistema.SetField('mpdd_operacao',FGeral.GetOperacao);
          Sistema.SetField('mpdd_numerodoc',numero);
          Sistema.SetField('mpdd_status','N');
          Sistema.SetField('mpdd_tipomov',Global.CodPedVenda);
          Sistema.SetField('mpdd_unid_codigo',Global.CodigoUnidade);
          Sistema.SetField('mpdd_tipo_codigo',strtoInt(FGeral.GetConfig1AsString('clieconsumidor')));
          Sistema.SetField('mpdd_tipocad','C');
          Sistema.SetField('mpdd_qtde',EdPeso.AsCurrency);
          Sistema.SetField('mpdd_datalcto',Sistema.Hoje);
          Sistema.SetField('mpdd_datamvto',Sistema.Hoje);
          Sistema.SetField('mpdd_venda',ValorporKilo);
          Sistema.SetField('mpdd_grup_codigo',TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
          Sistema.SetField('mpdd_sugr_codigo',TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
          Sistema.SetField('mpdd_fami_codigo',TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
          Sistema.SetField('mpdd_usua_codigo',Global.Usuario.codigo);
    //      Sistema.SetField('mpdd_repr_codigo',EdRepr_codigo.asinteger);
          Sistema.SetField('mpdd_datacont',Sistema.Hoje);
          Sistema.SetField('mpdd_qtdeenviada',0);
          Sistema.SetField('mpdd_vendabru',Valorporkilo);
    //      Sistema.SetField('mpdd_perdesco',EdPerdesconto.ascurrency);
          Sistema.SetField('mpdd_caoc_codigo',0);
          Sistema.SetField('mpdd_seq',1);
    //         Sistema.SetField('mpdd_pecas',Edpecas.ascurrency);
    // 21.02.20
    //      if ProdutoGenerico( EdProduto.Text ) then
    //           Sistema.SetField('mpdd_esto_descricao',Eddescricaoservico.Text);

          Sistema.Post('');

          Sistema.Commit;
          FGeral.FechaQuery(TEstoque);

    end;

end;

procedure TFChecabalanca.blepesoClick(Sender: TObject);
begin

    PMens.caption := 'Verificando peso';
    Acbrbal1.LePeso();
    PMens.caption := '';

end;

procedure TFChecabalanca.Timer1Timer(Sender: TObject);
begin

   blepesoclick(self);

end;

end.

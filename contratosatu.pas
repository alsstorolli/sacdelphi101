// 31.08.2021
// atualiza��o de dados de contrato

unit contratosatu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, SQLEd, SqlExpr,
  Vcl.Grids, SqlDtg, Vcl.Buttons, SQLBtn, alabel, Vcl.ExtCtrls, SQLGrid;

type
  TFContratoatu = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    binclusao: TSQLBtn;
    bCancelar: TSQLBtn;
    bexcluir: TSQLBtn;
    balterar: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PIns: TSQLPanelGrid;
    Edfisico: TSQLEd;
    EdValoroferecido: TSQLEd;
    EdValorbruto: TSQLEd;
    EdParcela: TSQLEd;
    EdNumerocontrato: TSQLEd;
    Edparcelas: TSQLEd;
    EdCont_tabp_codigo: TSQLEd;
    SetEdTABP_ALIQUOTA: TSQLEd;
    EdCont_valorliquido: TSQLEd;
    Edcont_reducao: TSQLEd;
    EdCont_margem: TSQLEd;
    Edcont_usua_codigolig: TSQLEd;
    Edpaca_quem: TSQLEd;
    Edcont_datapedsaldo: TSQLEd;
    Edcont_datarecsaldo: TSQLEd;
    Edcont_situacao: TSQLEd;
    EdCont_dataatual: TSQLEd;
    Edcont_refiport: TSQLEd;
    Edcont_usua_codigoate: TSQLEd;
    SQLEd2: TSQLEd;
    EdBanco_port: TSQLEd;
    EdCont_inf12pagas: TSQLEd;
    EdCont_situacaoprop: TSQLEd;
    EdCont_comsaldo: TSQLEd;
    procedure binclusaoClick(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure EdCont_comsaldoExitEdit(Sender: TObject);
    procedure GridNewLine(Sender: TObject);
    procedure balterarClick(Sender: TObject);
    procedure bexcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(xtransacao:string;xcodcli:integer);
    procedure SetaTipos( Ed:TSqlEd );
    procedure SetaSituacao( Ed:TSqlEd );
    procedure SetaSituacaoProp( Ed:TSqlEd );
    procedure EditstoGrid( linha:integer=-1 );
    procedure atualizaedits(xtrans:string);

  end;

var
  FContratoatu: TFContratoatu;
  xdata      : TDatetime;
  transacao  : string;
  Q          : TSqlquery;
  Operacao,
  OP         : string;
  codigocli  : integer;

implementation

uses SqlSis, Geral, SqlFun , Usuarios, Emitentes, cadcli;

{$R *.dfm}

{ TFContratosatu }

procedure TFContratoatu.atualizaedits(xtrans: string);
/////////////////////////////////////////////////////////
var Qa    : TSqlquery;

begin

   Qa := sqltoquery('select *,clie_nome,clie_cnpjcpf from contratosatu '+
                ' inner join clientes on ( clie_codigo = cona_tipo_codigo )'+
                ' where cona_status=''N'''+
                ' and cona_operacao = '+stringtosql(xtrans)+
                ' and cona_unid_codigo = '+stringtosql(Global.CodigoUnidade)+
                ' and cona_dataent >= '+Datetosql(xdata)+
                ' order by cona_dataent');

   EdCont_tabp_codigo.text := Qa.fieldbyname('cona_tabp_codigo').asstring;
   EdCont_tabp_codigo.validfind;
   EdCont_valorliquido.setvalue( Qa.fieldbyname('cona_valorliquido').ascurrency );
   EdValoroferecido.setvalue( Qa.fieldbyname('cona_Valoroferecido').ascurrency );
   EdValorbruto.setvalue( Qa.fieldbyname('cona_Valorbruto').ascurrency );
   EdCont_margem.setvalue( Qa.fieldbyname('cona_margem').ascurrency );
   EdParcela.setvalue( Qa.fieldbyname('cona_parcela').ascurrency );
   Edcont_reducao.text := Qa.fieldbyname('cona_reducao').asstring;
//   Edcont_usua_codigolig.text := Qa.fieldbyname('cona_usua_codigolig').asstring;
//   Edcont_usua_codigolig.validfind;
   Edcont_datapedsaldo.setdate(Qa.fieldbyname('cona_datapedsaldo').asdatetime);
   Edcont_datarecsaldo.setdate(Qa.fieldbyname('cona_datarecsaldo').asdatetime);
   EdCont_dataatual.setdate(Qa.fieldbyname('cona_dataatual').asdatetime);
   EdFisico.text             := Qa.fieldbyname('cona_fisico').asstring;
   EdNumerocontrato.text     := Qa.fieldbyname('cona_numerodoc').asstring;
   EdParcelas.setvalue( Qa.fieldbyname('cona_parcelas').asinteger );

   EdCont_comsaldo.setvalue( Qa.fieldbyname('cona_comsaldo').ascurrency );
   EdCont_refiport.text       := Qa.fieldbyname('cona_refiport').asstring;
   EdCont_reducao.text        := Qa.fieldbyname('cona_reducao').asstring;
//   Edcont_usua_codigoate.text := Qa.fieldbyname('cona_usua_codigoate').asstring;
//   Edcont_usua_codigoate.validfind;
   EdBanco_port.text          := Qa.fieldbyname('cona_bancoport').asstring;
   EdCont_inf12pagas.text     := Qa.fieldbyname('cona_inf12pagas').asstring;
   EdCont_situacaoprop.text   := Qa.fieldbyname('cona_situacaoprop').asstring;
   EdCont_situacao.text       := Qa.fieldbyname('cona_situacao').asstring;

   Qa.close;

end;

procedure TFContratoatu.balterarClick(Sender: TObject);
///////////////////////////////////////////////////////////////////
var trans : string;

begin

   trans := Grid.Cells[Grid.GetColumn('CONT_operacao'),Grid.Row];
   if trim(trans) = '' then exit;
   PIns.Enabled:=true;
   Edcont_tabp_codigo.SetFocus;
   Grid.Enabled:=false;
   OP:='A';
   atualizaedits(trans);

end;

procedure TFContratoatu.bCancelarClick(Sender: TObject);
////////////////////////////////////////////////////////////
begin

   PIns.Enabled:=false;
//   PIns.Visible:=false;
   Grid.Enabled:=true;
   Grid.SetFocus;

end;

procedure TFContratoatu.bexcluirClick(Sender: TObject);
//////////////////////////////////////////////////////////////
var xop:string;
begin

  xop:=Grid.Cells[Grid.GetColumn('cont_OPERACAO'),Grid.Row];
  if trim(xOP)='' then begin
     Avisoerro('Escolher um lan�amento para exclus�o');
     exit;
  end;
  if not confirma('Confirma exclus�o ?') then exit;
  try

    Sistema.Edit('contratosatu');
    Sistema.SetField('cona_status','C');
    Sistema.post('cona_operacao = '+stringtosql(xop)+' and cona_status=''N''');
    Sistema.Commit;

    Grid.DeleteRow(Grid.Row);

  except on E:exception do

     Avisoerro('N�o foi poss�vel gravar no banco de dados.  '+E.Message);

  end;

end;

procedure TFContratoatu.binclusaoClick(Sender: TObject);
/////////////////////////////////////////////////////////
begin

   PIns.Enabled:=true;
   PIns.Visible:=true;
   EdCont_tabp_codigo.enabled := true;
   EdCont_tabp_codigo.SetFocus;
   Grid.Enabled:=false;
   OP:='I';
   EdCont_tabp_codigo.clearall(FContratoAtu,99);
   if EdCont_dataatual.IsEmpty then EdCont_dataatual.SetDate( sistema.Hoje);


end;

procedure TFContratoatu.EdCont_comsaldoExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////////////
///
       function GetProximaOP:string;
       ////////////////////////////////
       var QOp  : TSqlquery;
       begin

           QOp := sqltoquery('select count(*) as ultimo from contratosatu where cona_transacao = '+stringtosql(transacao));
           result := inttostr( QOp.Fieldbyname('ultimo').asinteger + 1 );
           FGeral.FechaQuery( QOp );

       end;


begin

    if not confirma('Confirma grava��o ?') then begin

       EdCont_tabp_codigo.SetFocus;
       exit;

    end;

    if OP='I' then

        Operacao := Transacao + GetProximaOP

    else

        Operacao := Grid.Cells[Grid.GetColumn('CONt_operacao'),Grid.Row];

    if OP='I' then begin

       Sistema.Insert('contratosatu');
       Sistema.SetField('cona_status','N');
       Sistema.SetField('cona_dataent',EdCont_dataatual.asdate);
       Sistema.SetField('cona_datacon',EdCont_dataatual.asdate);
       Sistema.SetField('cona_dtlcto',Sistema.Hoje);
       Sistema.SetField('cona_unid_codigo',Global.CodigoUnidade);
//       Sistema.SetField('cont_situacao','P');
       Sistema.SetField('cona_usua_codigo',Global.Usuario.codigo);
//       Sistema.SetField('cont_obs',Edmovt_obs.Text);
       Sistema.SetField('cona_tipo_codigo',codigocli);
//       Sistema.SetField('cont_tipocad','C');
       Sistema.SetField('cona_valoroferecido',EdValoroferecido.Ascurrency);
       Sistema.SetField('cona_valorbruto',EdValorbruto.Ascurrency);
       Sistema.SetField('cona_parcela',EdParcela.Ascurrency);
       Sistema.SetField('cona_parcelas',EdParcelas.Ascurrency);
       Sistema.SetField('cona_numerodoc',EdNUmerocontrato.asinteger);
//       Sistema.SetField('cona_banco',EdBanco.Text);
       Sistema.SetField('cona_fisico',EdFisico.Text);
       Sistema.SetField('cona_transacao',Transacao);
       Sistema.SetField('cona_operacao',Operacao);
//       Sistema.SetField('cont_tipo',EdCont_tipo.Text);
//       Sistema.SetField('cont_corretora',EdCont_corretora.Text);
       Sistema.SetField('cona_tabp_codigo',EdCont_tabp_codigo.Asinteger);
       Sistema.SetField('cona_tabaliquota',SetEdTABP_ALIQUOTA.Asinteger);
       Sistema.SetField('cona_valorliquido',Edcont_Valorliquido.Ascurrency);
       Sistema.SetField('cona_reducao',EdCont_reducao.Text);
       Sistema.SetField('cona_margem',Edcont_margem.Ascurrency);
//       Sistema.SetField('cona_usua_codigolig',Edcont_usua_codigolig.AsInteger);
//       Sistema.SetField('cona_usua_codigoate',Edcont_usua_codigoate.AsInteger);
       Sistema.SetField('cona_datapedsaldo',Edcont_datapedsaldo.asdate);
       Sistema.SetField('cona_datarecsaldo',Edcont_datarecsaldo.asdate);
       Sistema.SetField('cona_situacao',EdCont_situacao.Text);
       Sistema.SetField('cona_dataatual',EdCont_dataatual.asdate);
       Sistema.SetField('cona_comsaldo', EdCont_comsaldo.ascurrency);
       Sistema.SetField('cona_refiport',Edcont_refiport.text);
       Sistema.SetField('cona_bancoport',Edbanco_port.text);
       Sistema.SetField('cona_inf12pagas',Edcont_inf12pagas.text);
       Sistema.SetField('cona_situacaoprop',Edcont_situacaoprop.text);
       Sistema.Post();

    end else begin

       Sistema.edit('contratosatu');
//       Sistema.SetField('movt_obs',Edmovt_obs.Text);
       Sistema.SetField('cona_valoroferecido',EdValoroferecido.Ascurrency);
       Sistema.SetField('cona_valorbruto',EdValorbruto.Ascurrency);
       Sistema.SetField('cona_parcela',EdParcela.Ascurrency);
       Sistema.SetField('cona_parcelas',EdParcelas.Ascurrency);
       Sistema.SetField('cona_numerodoc',EdNUmerocontrato.asinteger);
//       Sistema.SetField('cona_banco',EdBanco.Text);
       Sistema.SetField('cona_fisico',EdFisico.Text);
//       Sistema.SetField('cona_tipo',EdCont_tipo.Text);
//       Sistema.SetField('cont_corretora',EdCont_corretora.Text);
       Sistema.SetField('cona_tabp_codigo',EdCont_tabp_codigo.Asinteger);
       Sistema.SetField('cona_tabaliquota',SetEdTABP_ALIQUOTA.Asinteger);
       Sistema.SetField('cona_valorliquido',EdCont_Valorliquido.Ascurrency);
       Sistema.SetField('cona_reducao',EdCont_reducao.Text);
       Sistema.SetField('cona_margem',Edcont_margem.Ascurrency);
//       Sistema.SetField('cona_usua_codigolig',Edcont_usua_codigolig.AsInteger);
//       Sistema.SetField('cona_usua_codigoate',Edcont_usua_codigoate.AsInteger);
       Sistema.SetField('cona_datapedsaldo',Edcont_datapedsaldo.asdate);
       Sistema.SetField('cona_datarecsaldo',Edcont_datarecsaldo.asdate);
       Sistema.SetField('cona_situacao',EdCont_situacao.Text);
       Sistema.SetField('cona_dataatual',EdCont_dataatual.asdate);
       Sistema.SetField('cona_comsaldo', EdCont_comsaldo.ascurrency);
       Sistema.SetField('cona_refiport',Edcont_refiport.text);
       Sistema.SetField('cona_bancoport',Edbanco_port.text);
       Sistema.SetField('cona_inf12pagas',Edcont_inf12pagas.text);
       Sistema.SetField('cona_situacaoprop',Edcont_situacaoprop.text);

       Sistema.Post( 'cona_operacao = '+Stringtosql(Operacao) );

    end;

// atualiza o contrato
       Sistema.edit('contratos');
//       Sistema.SetField('movt_obs',Edmovt_obs.Text);
       Sistema.SetField('cont_valoroferecido',EdValoroferecido.Ascurrency);
       Sistema.SetField('cont_valorbruto',EdValorbruto.Ascurrency);
       Sistema.SetField('cont_parcela',EdParcela.Ascurrency);
       Sistema.SetField('cont_parcelas',EdParcelas.Ascurrency);
       Sistema.SetField('cont_numerodoc',EdNUmerocontrato.asinteger);
//       Sistema.SetField('cona_banco',EdBanco.Text);
       Sistema.SetField('cont_fisico',EdFisico.Text);
//       Sistema.SetField('cona_tipo',EdCont_tipo.Text);
//       Sistema.SetField('cont_corretora',EdCont_corretora.Text);
       Sistema.SetField('cont_tabp_codigo',EdCont_tabp_codigo.Asinteger);
       Sistema.SetField('cont_tabaliquota',SetEdTABP_ALIQUOTA.Asinteger);
       Sistema.SetField('cont_valorliquido',EdCont_Valorliquido.Ascurrency);
       Sistema.SetField('cont_reducao',EdCont_reducao.Text);
       Sistema.SetField('cont_margem',Edcont_margem.Ascurrency);
//       Sistema.SetField('cona_usua_codigolig',Edcont_usua_codigolig.AsInteger);
//       Sistema.SetField('cona_usua_codigoate',Edcont_usua_codigoate.AsInteger);
       Sistema.SetField('cont_datapedsaldo',Edcont_datapedsaldo.asdate);
       Sistema.SetField('cont_datarecsaldo',Edcont_datarecsaldo.asdate);
       Sistema.SetField('cont_situacao',EdCont_situacao.Text);
       Sistema.SetField('cont_dataatual',EdCont_dataatual.asdate);
       Sistema.SetField('cont_comsaldo', EdCont_comsaldo.ascurrency);
       Sistema.SetField('cont_refiport',Edcont_refiport.text);
       Sistema.SetField('cont_bancoport',Edbanco_port.text);
       Sistema.SetField('cont_inf12pagas',Edcont_inf12pagas.text);
       Sistema.SetField('cont_situacaoprop',Edcont_situacaoprop.text);

       Sistema.Post( 'cont_transacao = '+Stringtosql(Transacao) );


    try
       Sistema.commit;
       if OP='I' then
          EditstoGrid
       else
          EditstoGrid(Grid.Row);

    except on E:exception do

       Avisoerro('N�o foi poss�vel gravar no banco de dados.  '+E.Message);

    end;

    EdCont_Tabp_codigo.ClearAll(Self,0);
    PIns.Enabled:=false;
//    PIns.Visible:=false;
    Grid.Enabled:=true;
    Grid.SetFocus;



end;

procedure TFContratoatu.EditstoGrid(linha: integer);
//////////////////////////////////////////////////////
var lin     : integer;
begin

   if linha>=0 then

      lin:=linha

   else

      lin:=Grid.rowcount-1;

   Grid.AppendRow;
//   Grid.Cells[Grid.GetColumn('cont_dataent'),lin]:=Datetostr(Edmovt_datamvto.asdate);
//   Grid.Cells[Grid.getcolumn('mesano'),lin]      :=FormatDatetime('mmmm/yyyy',Edmovt_datamvto.asdate);
//   Grid.Cells[Grid.GetColumn('clie_nome'),lin]:=SetEdclie_nome.text;
//   Grid.Cells[Grid.GetColumn('cont_parcela'),lin]     := FGeral.Formatavalor(EdParcela.ascurrency,f_cr);
   Grid.Cells[Grid.GetColumn('cont_operacao'),lin]    := Operacao;
//   Grid.Cells[Grid.GetColumn('cont_tipo_codigo'),lin]:=EdTipo_codigo.Text;
   Grid.Cells[Grid.getcolumn('cont_valoroferecido'),lin]:=EdValoroferecido.Text;
   Grid.Cells[Grid.getcolumn('cont_valorbruto'),lin]:=EdValorbruto.text;
//   Grid.Cells[Grid.getcolumn('cont_banco'),lin]      :=FEmitentes.BuscaBanco(EdBanco.text,EdBanco);
//   Grid.Cells[Grid.getcolumn('clie_cnpjcpf'),lin]    :=EdTipo_codigo.resultfind.fieldbyname('clie_cnpjcpf').AsString ;
   Grid.Cells[Grid.getcolumn('cont_situacao'),lin]      :=Edcont_situacao.text;
   Grid.Cells[Grid.getcolumn('cont_situacaoprop'),lin]   :=EdCont_situacaoprop.text ;
   Grid.Cells[Grid.GetColumn('cont_dataatual'),lin]:=Datetostr(Edcont_dataatual.asdate);

end;

procedure TFContratoatu.Execute(xtransacao:string ; xcodcli:integer);
/////////////////////////////////////////////////////////////////////////////

    procedure QuerytoGrid(Q:Tsqlquery);
    ////////////////////////////////////
    var i,diasatraso:integer;

        function GetSituacao( xsit:string):string;
        ///////////////////////////////////////////
        begin

//           if xsit='P' then result:='Pendente'
//           else result:=xsit;
           result:=xsit;   // ate definir como tratar

        end;



    begin
      Grid.clear;i:=1;
//      ListaT.clear;

      while not Q.Eof do begin

//         Grid.Cells[Grid.getcolumn('movt_situacao'),i]:=GetSituacao( Q.fieldbyname('movt_situacao').AsString );
// ver se vai criar situacao do contrato
//         Grid.Cells[Grid.getcolumn('cont_dataent'),i]:=FGeral.formatadata(Q.fieldbyname('cont_dataent').asdatetime);
//         Grid.Cells[Grid.getcolumn('mesano'),i]      :=FormatDatetime('mmmm/yyyy',Q.fieldbyname('cont_dataent').asdatetime);
//         Grid.Cells[Grid.getcolumn('clie_nome'),i]:=Q.fieldbyname('clie_nome').AsString;
//         Grid.Cells[Grid.getcolumn('cont_parcela'),i]        :=FGeral.Formatavalor( Q.fieldbyname('cont_parcela').Ascurrency,F_cr);
         Grid.Cells[Grid.getcolumn('cont_operacao'),i]   :=Q.fieldbyname('cona_operacao').AsString;
//         Grid.Cells[Grid.getcolumn('cont_tipo_codigo'),i]:=Q.fieldbyname('cont_tipo_codigo').AsString;
         Grid.Cells[Grid.getcolumn('cont_valoroferecido'),i]:=FGeral.Formatavalor(Q.fieldbyname('cona_valoroferecido').Ascurrency,f_cr);
         Grid.Cells[Grid.getcolumn('cont_valorbruto'),i]  :=FGeral.Formatavalor(Q.fieldbyname('cona_valorbruto').Ascurrency,f_cr) ;
//         Grid.Cells[Grid.getcolumn('cont_banco'),i]      :=Q.fieldbyname('cont_banco').AsString ;
//         Grid.Cells[Grid.getcolumn('cont_banco'),i]      :=FEmitentes.BuscaBanco(Q.fieldbyname('cona_banco').AsString,EdBanco);
//         Grid.Cells[Grid.getcolumn('clie_cnpjcpf'),i]    :=Q.fieldbyname('clie_cnpjcpf').AsString ;

         Grid.Cells[Grid.getcolumn('cont_situacao'),i]     :=Q.fieldbyname('cona_situacao').AsString;
         Grid.Cells[Grid.getcolumn('cont_situacaoprop'),i] :=Q.fieldbyname('cona_situacaoprop').AsString ;
         Grid.Cells[Grid.GetColumn('cont_dataatual'),i]    :=FGeral.FormataData(Q.fieldbyname('cona_dataatual').asdatetime);

         Grid.AppendRow;
         inc(i);

         Q.Next;


      end;

    end;

    procedure QuerytoGridColuna(Q:Tsqlquery);
    ///////////////////////////////////////////
    var i,diasatraso:integer;
    begin
      i:=1;
//      Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Style:=[fsBold];
      while not Q.Eof do begin
            diasatraso:=trunc( Sistema.hoje - Q.fieldbyname('paca_quando').asdatetime );
            if diasatraso>0 then begin
//              Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Color:=clRed;
              Grid.Cells[Grid.getcolumn('situacao'),i]:='ATRASADO';
//               Grid.Columns.Items[Grid.GetColumn('paca_quem')].Font.Color:=clRed;
//               Grid.Columns.Items[Grid.GetColumn('paca_quando')].Font.Color:=clRed;
//               Grid.Canvas.Font.Color:=clRed;
            end else if (diasatraso>=-7) and (diasatraso<=0) then begin
//              Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Color:=clYellow;
              Grid.Cells[Grid.getcolumn('situacao'),i]:='NA SEMANA';
//              Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Color:=clBlue;
//               Grid.Canvas.Font.Color:=clBlue;
//               Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Style:=[];
            end else begin
//              Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Color:=clGreen;
              Grid.Cells[Grid.getcolumn('situacao'),i]:='EM EXECU��O';
//              Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Color:=clYellow;
//              Grid.Canvas.Font.Color:=clYellow;
//              Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Style:=[fsItalic];
            end;
//         end;

         inc(i);
         Q.Next;
      end;

    end;


begin

  FGeral.EstiloForm(self);
  FGeral.ConfiguraColorEditsNaoEnabled(FContratoAtu);
  FEmitentes.Setabancos(EdBanco_port);
  transacao := xtransacao;
  codigocli := xcodcli;
  Caption := 'Atualiza��o de Contrato do Cliente '+FCadCli.GetNOme(codigocli)+' - '+inttostr(codigocli)+
             ' referente transa��o '+transacao;
  xdata := Sistema.Hoje-(5*360);  // at� 5 anos 'pra tr�s'
//  SetaTipos( EdCont_tipo );
  SetaSituacao( EdCont_situacao );
  SetaSituacaoProp( EdCont_situacaoprop );


  Sistema.beginprocess('pesquisando atualiza��o do Contrato');
  Q:=sqltoquery('select *,clie_nome,clie_cnpjcpf from contratosatu '+
                ' inner join clientes on ( clie_codigo = cona_tipo_codigo )'+
                ' where cona_status=''N'''+
                ' and cona_unid_codigo = '+stringtosql(Global.CodigoUnidade)+
                ' and cona_transacao= '+stringtosql(transacao)+
                ' order by cona_dataent');
  Grid.clear;
  if not Q.eof then begin

    QuerytoGrid(Q);

  end;
  Sistema.endprocess('');

  Grid.Refresh;

  ShowModal;

end;

procedure TFContratoatu.GridNewLine(Sender: TObject);
//////////////////////////////////////////////////////////
var ctrans:string;

begin

   ctrans := Grid.Cells[Grid.GetColumn('CONT_operacao'),Grid.Row];
   if trim(ctrans) = '' then exit;

   Atualizaedits(ctrans);

end;

procedure TFContratoatu.SetaSituacao(Ed: TSqlEd);
//////////////////////////////////////////////////////////
begin

    Ed.Items.clear;
    Ed.Items.Add('INSS AGUARDANDO');
    Ed.Items.Add('SALDO AGUARDANDO');
    Ed.Items.Add('CANCELADO');
    Ed.Items.Add('AGUARDANDO PAGAMENTO');
    Ed.Items.Add('PAGO');

end;

procedure TFContratoatu.SetaSituacaoProp(Ed: TSqlEd);
////////////////////////////////////////////////////////////
begin

    Ed.Items.clear;
    Ed.Items.Add('PRIMEIRO RETORNO');
    Ed.Items.Add('SEGUNDO RETORNO');
    Ed.Items.Add('BAIXA(DATA)');
    Ed.Items.Add('AGUARDA FORMALIZA��O');
    Ed.Items.Add('AGUARDA CONSULTA');
    Ed.Items.Add('AGUARDA PAGAMENTO');
    Ed.Items.Add('FILA DE AN�LISE');
    Ed.Items.Add('SALDO(DATA)');
    Ed.Items.Add('ANALISE PROMOTORA');
    Ed.Items.Add('LIBERAR CORRESPONDENTE');
    Ed.Items.Add('PEN ASS DIGITAL');
    Ed.Items.Add('ANEXAR DOCS');
    Ed.Items.Add('PENDENTE CONTATO');
    Ed.Items.Add('REDIGITAR');
    Ed.Items.Add('AGUARDAR DOCS');

end;

procedure TFContratoatu.SetaTipos(Ed: TSqlEd);
/////////////////////////////////////////////////////
begin

    Ed.Items.clear;
    Ed.Items.Add('NOVO');
    Ed.Items.Add('REFI');
    Ed.Items.Add('PORTABILIDADE');
    Ed.Items.Add('COMPRA');
    Ed.Items.Add('D�BITO CC');
    Ed.Items.Add('CARTAO');
    Ed.Items.Add('AUMENTO SALARIAL');
    Ed.Items.Add('TESOURO');

end;

end.

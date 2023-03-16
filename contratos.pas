// 01.02.2021
// cadastramento de contratos de empr�stimos

unit contratos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, SQLEd,
  Vcl.Grids, SqlDtg, Vcl.Buttons, SQLBtn, alabel, Vcl.ExtCtrls, SQLGrid,
  SqlExpr;

type
  TFContratos = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    binclusao: TSQLBtn;
    bretirafiltro: TSQLBtn;
    bCancelar: TSQLBtn;
    bfiltragrid: TSQLBtn;
    bexcluir: TSQLBtn;
    batualizavalores: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    Edencerramento: TSQLEd;
    PIns: TSQLPanelGrid;
    Edmovt_datamvto: TSQLEd;
    Edfisico: TSQLEd;
    EdValoroferecido: TSQLEd;
    EdTipo_codigo: TSQLEd;
    SetEdCLIE_NOME: TSQLEd;
    EdBanco: TSQLEd;
    EdValorbruto: TSQLEd;
    EdParcela: TSQLEd;
    EdNumerocontrato: TSQLEd;
    Edparcelas: TSQLEd;
    EdCont_tipo: TSQLEd;
    EdCont_corretora: TSQLEd;
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
    balterar: TSQLBtn;
    Edcont_refiport: TSQLEd;
    Edcont_usua_codigoate: TSQLEd;
    SQLEd2: TSQLEd;
    EdBanco_port: TSQLEd;
    EdCont_inf12pagas: TSQLEd;
    EdCont_situacaoprop: TSQLEd;
    EdCont_comsaldo: TSQLEd;
    ptotais: TSQLPanelGrid;
    GridTotais: TSqlDtGrid;
    procedure binclusaoClick(Sender: TObject);
    procedure EdBancoExitEdit(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure bexcluirClick(Sender: TObject);
    procedure bfiltragridClick(Sender: TObject);
    procedure bretirafiltroClick(Sender: TObject);
    procedure EdparcelasExitEdit(Sender: TObject);
    procedure balterarClick(Sender: TObject);
    procedure GridNewLine(Sender: TObject);
    procedure GridTotaisDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure batualizavaloresClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure EditstoGrid( linha:integer=-1 );
    procedure FiltraGrid( campo , conteudo , tipocampo :string );
    procedure SetaTipos( Ed:TSqlEd );
    procedure SetaCorretoras( Ed:TSqlEd );
    procedure SetaSituacao( Ed:TSqlEd );
    procedure atualizaedits(xtrans:string);
    procedure AtualizaLista(Qt:TSqlquery);
    procedure MostraLista;
    procedure SetaSituacaoProp( Ed:TSqlEd );

  end;

type Ttotais = record

     item : string;
     bruto,combruto,comliquido,comsaldo,total : currency;

end;


var
  FContratos: TFContratos;
  Q:TSqlquery;
  Operacao,
  OP         :string;
  xdata      : TDatetime;
  ListaT     : Tlist;
  PTTotais   : ^TTotais;


const colbruto     :integer=1;
      colcombruto  :integer=2;
      colcomliquido:integer=3;
      colcomsaldo  :integer=4;
      colcomtotal  :integer=5;
      colitem      :integer=0;



implementation

uses SqlSis, Geral, SqlFun , Usuarios, Emitentes, contratosatu;

{$R *.dfm}

{ TFContratos }

procedure TFContratos.atualizaedits(xtrans:string);
//////////////////////////////////////////////////
var Qa    : TSqlquery;

begin

   Qa := sqltoquery('select *,clie_nome,clie_cnpjcpf from contratos '+
                ' inner join clientes on ( clie_codigo = cont_tipo_codigo )'+
                ' where cont_status=''N'''+
                ' and cont_transacao = '+stringtosql(xtrans)+
                ' and cont_unid_codigo = '+stringtosql(Global.CodigoUnidade)+
                ' and cont_dataent >= '+Datetosql(xdata)+
//                ' and cont_situacao=''P'''+
                ' order by cont_dataent');

   EdTipo_codigo.text := Qa.fieldbyname('cont_tipo_codigo').asstring;
   EdTipo_codigo.validfind;
   Edmovt_datamvto.setdate(Qa.fieldbyname('cont_dataent').asdatetime);
   EdBanco.text            := Qa.fieldbyname('cont_banco').asstring;
   EdCont_tipo.text        := Qa.fieldbyname('cont_tipo').asstring;
   EdCont_corretora.text   := Qa.fieldbyname('cont_corretora').asstring;
   EdCont_tabp_codigo.text := Qa.fieldbyname('cont_tabp_codigo').asstring;
   EdCont_tabp_codigo.validfind;
   EdCont_valorliquido.setvalue( Qa.fieldbyname('cont_valorliquido').ascurrency );
   EdValoroferecido.setvalue( Qa.fieldbyname('cont_Valoroferecido').ascurrency );
   EdValorbruto.setvalue( Qa.fieldbyname('cont_Valorbruto').ascurrency );
   EdCont_margem.setvalue( Qa.fieldbyname('cont_margem').ascurrency );
   EdParcela.setvalue( Qa.fieldbyname('cont_parcela').ascurrency );
   Edcont_reducao.text := Qa.fieldbyname('cont_reducao').asstring;
   Edcont_usua_codigolig.text := Qa.fieldbyname('cont_usua_codigolig').asstring;
   Edcont_usua_codigolig.validfind;
   Edcont_datapedsaldo.setdate(Qa.fieldbyname('cont_datapedsaldo').asdatetime);
   Edcont_datarecsaldo.setdate(Qa.fieldbyname('cont_datarecsaldo').asdatetime);
   EdCont_dataatual.setdate(Qa.fieldbyname('cont_dataatual').asdatetime);
   EdFisico.text             := Qa.fieldbyname('cont_fisico').asstring;
   EdNumerocontrato.text     := Qa.fieldbyname('cont_numerodoc').asstring;
   EdParcelas.setvalue( Qa.fieldbyname('cont_parcelas').asinteger );

   EdCont_comsaldo.setvalue( Qa.fieldbyname('cont_comsaldo').ascurrency );
   EdCont_refiport.text       := Qa.fieldbyname('cont_refiport').asstring;
   EdCont_reducao.text        := Qa.fieldbyname('cont_reducao').asstring;
   Edcont_usua_codigoate.text := Qa.fieldbyname('cont_usua_codigoate').asstring;
   Edcont_usua_codigoate.validfind;
   EdBanco_port.text          := Qa.fieldbyname('cont_bancoport').asstring;
   EdCont_inf12pagas.text     := Qa.fieldbyname('cont_inf12pagas').asstring;
   EdCont_situacaoprop.text   := Qa.fieldbyname('cont_situacaoprop').asstring;
   EdCont_situacao.text       := Qa.fieldbyname('cont_situacao').asstring;


   Qa.close;

end;

procedure TFContratos.AtualizaLista(Qt: TSqlquery);
/////////////////////////////////////////////////
var p    :integer;
    achou:boolean;

begin

   achou := false;
   for p := 0 to ListaT.count-1 do begin

       PTTotais := ListaT[p];
       if PTTotais.item = Qt.fieldbyname('cont_situacao').asstring then begin

          achou := true;
          break;

       end;


   end;
   if not achou then begin

      New(PTTotais);
      PTTotais.item       := Qt.fieldbyname('cont_situacao').asstring;
      PTTotais.bruto      := Qt.fieldbyname('cont_valorbruto').ascurrency;
      PTTotais.combruto   := Qt.fieldbyname('cont_combruto').ascurrency;
      PTTotais.comliquido := Qt.fieldbyname('cont_comliquido').ascurrency;
      PTTotais.comsaldo   := Qt.fieldbyname('cont_comsaldo').ascurrency;
      PTTotais.total      := Qt.fieldbyname('cont_comsaldo').ascurrency+
                             Qt.fieldbyname('cont_comliquido').ascurrency+
                             Qt.fieldbyname('cont_combruto').ascurrency;
      ListaT.add( PTTotais );

   end else begin

      PTTotais.bruto      := PTTotais.bruto + Qt.fieldbyname('cont_valorbruto').ascurrency;
      PTTotais.combruto   := PTTotais.combruto + Qt.fieldbyname('cont_combruto').ascurrency;
      PTTotais.comliquido := PTTotais.comliquido + Qt.fieldbyname('cont_comliquido').ascurrency;
      PTTotais.comsaldo   := PTTotais.comsaldo+  Qt.fieldbyname('cont_comsaldo').ascurrency;
      PTTotais.total      := PTTotais.total + Qt.fieldbyname('cont_comsaldo').ascurrency+
                             Qt.fieldbyname('cont_comliquido').ascurrency+
                             Qt.fieldbyname('cont_combruto').ascurrency;

   end;


end;

procedure TFContratos.balterarClick(Sender: TObject);
///////////////////////////////////////////////////////////////
var trans : string;

begin

   trans := Grid.Cells[Grid.GetColumn('CONT_transacao'),Grid.Row];
   if trim(trans) = '' then exit;

   PIns.Enabled:=true;
//   PIns.Visible:=true;
   EdTipo_codigo.enabled := false;
   EdBanco.SetFocus;
   Grid.Enabled:=false;
   OP:='A';
   if EdMovt_datamvto.IsEmpty then EdMovt_datamvto.SetDate( sistema.Hoje);

   atualizaedits(trans);


end;

procedure TFContratos.batualizavaloresClick(Sender: TObject);
/////////////////////////////////////////////////////////////
var xop     :string;
    xcodcli : integer;
begin

  xop     := Grid.Cells[Grid.GetColumn('cont_transacao'),Grid.Row];
  xcodcli := strtointdef(Grid.Cells[Grid.GetColumn('cont_tipo_codigo'),Grid.Row],0);
  if trim(xOP)='' then begin

     Avisoerro('Escolher um contrato para atualizar');
     exit;

  end;
  FContratoAtu.Execute( xop,xcodcli );

end;

procedure TFContratos.bCancelarClick(Sender: TObject);
//////////////////////////////////////////////////////////////
begin

   PIns.Enabled:=false;
//   PIns.Visible:=false;
   Grid.Enabled:=true;
   Grid.SetFocus;

end;

procedure TFContratos.bexcluirClick(Sender: TObject);
//////////////////////////////////////////////////////////////
var xop:string;
begin

  xop:=Grid.Cells[Grid.GetColumn('cont_transacao'),Grid.Row];
  if trim(xOP)='' then begin
     Avisoerro('Escolher um lan�amento para exclus�o');
     exit;
  end;
  if not confirma('Confirma exclus�o ?') then exit;
  try

    Sistema.Edit('contratos');
    Sistema.SetField('cont_status','C');
    Sistema.post('cont_transacao = '+stringtosql(xop)+' and cont_status=''N''');
    Sistema.Commit;

    Grid.DeleteRow(Grid.Row);

  except on E:exception do

     Avisoerro('N�o foi poss�vel gravar no banco de dados.  '+E.Message);

  end;


end;

procedure TFContratos.binclusaoClick(Sender: TObject);
//////////////////////////////////////////////////////////
begin

   PIns.Enabled:=true;
   PIns.Visible:=true;
   EdTipo_codigo.enabled := true;
   EdTipo_codigo.SetFocus;
   Grid.Enabled:=false;
   OP:='I';
   EdTipo_codigo.clearall(FContratos,99);
   if EdMovt_datamvto.IsEmpty then EdMovt_datamvto.SetDate( sistema.Hoje);

end;

procedure TFContratos.bretirafiltroClick(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin

    Execute;

end;

procedure TFContratos.bfiltragridClick(Sender: TObject);
////////////////////////////////////////////////////////////
begin

   if Grid.getcolumn('clie_nome') = Grid.col then begin

      FiltraGrid('clie_nome',Grid.cells[grid.col,grid.row],'C');

   end else if ( Grid.getcolumn('cont_parcela') = Grid.col )
            or
               ( Grid.getcolumn('cont_valoroferecido') = Grid.col )
            or
               ( Grid.getcolumn('cont_valorbruto') = Grid.col )

      then begin

      FiltraGrid( Grid.columns.Items[Grid.col].fieldname , Grid.cells[grid.col,grid.row],'N');

   end else

      FiltraGrid( Grid.columns.Items[Grid.col].fieldname , Grid.cells[grid.col,grid.row],'C');

end;

procedure TFContratos.EdBancoExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////
begin

{
    if not confirma('Confirma grava��o ?') then begin
       Edtipo_codigo.SetFocus;
       exit;
    end;

    if OP='I' then

        Operacao:=Global.codigounidade +  inttostr( FGeral.GetContador('CONTRATOS'+Global.CodigoUnidade,false) )

    else

        Operacao:=Grid.Cells[Grid.GetColumn('CONT_transacao'),Grid.Row];

    if OP='I' then begin

       Sistema.Insert('contratos');
       Sistema.SetField('cont_status','N');
       Sistema.SetField('cont_dataent',Edmovt_datamvto.asdate);
       Sistema.SetField('cont_datacon',EdMovt_datamvto.asdate);
       Sistema.SetField('cont_dtlcto',Sistema.Hoje);
       Sistema.SetField('cont_unid_codigo',Global.CodigoUnidade);
//       Sistema.SetField('cont_situacao','P');
       Sistema.SetField('cont_usua_codigo',Global.Usuario.codigo);
//       Sistema.SetField('cont_obs',Edmovt_obs.Text);
       Sistema.SetField('cont_tipo_codigo',Edtipo_codigo.Asinteger);
//       Sistema.SetField('cont_tipocad','C');
       Sistema.SetField('cont_valoroferecido',EdValoroferecido.Ascurrency);
       Sistema.SetField('cont_valorbruto',EdValorbruto.Ascurrency);
       Sistema.SetField('cont_parcela',EdParcela.Ascurrency);
       Sistema.SetField('cont_parcelas',EdParcelas.Ascurrency);
       Sistema.SetField('cont_numerodoc',EdNUmerocontrato.asinteger);
       Sistema.SetField('cont_banco',EdBanco.Text);

       Sistema.SetField('cont_fisico',EdFisico.Text);
       Sistema.SetField('cont_transacao',Operacao);
       Sistema.Post();

    {
       if not EdMovt_datamvtopro.IsEmpty then begin

         Operacao:=inttostr( FGeral.GetContador('TELEVENDAS'+Global.CodigoUnidade,false) );

          Sistema.Insert('movtelevendas');
          Sistema.SetField('movt_status','N');
          Sistema.SetField('movt_datamvto',EdMovt_datamvtopro.asdate);
          Sistema.SetField('movt_datarepro',EdMovt_datamvto.asdate);
          Sistema.SetField('movt_dtlcto',Sistema.Hoje);
          Sistema.SetField('movt_unid_codigo',Global.CodigoUnidade);
          Sistema.SetField('movt_situacao','P');
          Sistema.SetField('movt_usua_codigo',Global.Usuario.codigo);
          Sistema.SetField('movt_obs',Edmovt_obspro.Text);
          Sistema.SetField('movt_tipo_codigo',Edtipo_codigo.Asinteger);
          Sistema.SetField('movt_tipocad','C');
          Sistema.SetField('movt_caoc_codigo',0);
          Sistema.SetField('movt_contato',EdMovt_contato.Text);
          Sistema.SetField('movt_operacao',Operacao);
          Sistema.Post();

       end;

    end else begin

       Sistema.edit('contratos');
//       Sistema.SetField('movt_obs',Edmovt_obs.Text);
       Sistema.SetField('cont_valoroferecido',EdValoroferecido.Ascurrency);
       Sistema.SetField('cont_valorbruto',EdValorbruto.Ascurrency);
       Sistema.SetField('cont_parcela',EdParcela.Ascurrency);
       Sistema.SetField('cont_parcelas',EdParcelas.Ascurrency);
       Sistema.SetField('cont_numerodoc',EdNUmerocontrato.asinteger);
       Sistema.SetField('cont_banco',EdBanco.Text);
       Sistema.SetField('cont_fisico',EdFisico.Text);

       Sistema.Post( 'cont_transacao = '+Stringtosql(Operacao) );

    end;

    try
       Sistema.commit;
       if OP='I' then
          EditstoGrid
       else
          EditstoGrid(Grid.Row);

    except on E:exception do

       Avisoerro('N�o foi poss�vel gravar no banco de dados.  '+E.Message);

    end;

    EdTipo_codigo.ClearAll(Self,0);
    PIns.Enabled:=false;
    PIns.Visible:=false;
    Grid.Enabled:=true;
    Grid.SetFocus;

}

end;

procedure TFContratos.EditstoGrid(linha: integer);
//////////////////////////////////////////////////////
var lin     : integer;
begin

   if linha>=0 then

      lin:=linha

   else

      lin:=Grid.rowcount-1;

   Grid.AppendRow;
//   Grid.Cells[Grid.GetColumn('movt_situacao'),lin]:='P';
   Grid.Cells[Grid.GetColumn('cont_dataent'),lin]:=Datetostr(Edmovt_datamvto.asdate);
   Grid.Cells[Grid.getcolumn('mesano'),lin]      :=FormatDatetime('mmmm/yyyy',Edmovt_datamvto.asdate);
   Grid.Cells[Grid.GetColumn('clie_nome'),lin]:=SetEdclie_nome.text;
   Grid.Cells[Grid.GetColumn('cont_parcela'),lin]     := FGeral.Formatavalor(EdParcela.ascurrency,f_cr);
   Grid.Cells[Grid.GetColumn('cont_transacao'),lin]    := Operacao;
   Grid.Cells[Grid.GetColumn('cont_tipo_codigo'),lin]:=EdTipo_codigo.Text;
   Grid.Cells[Grid.getcolumn('cont_valoroferecido'),lin]:=EdValoroferecido.Text;
   Grid.Cells[Grid.getcolumn('cont_valorbruto'),lin]:=EdValorbruto.text;
//   Grid.Cells[Grid.getcolumn('cont_banco'),lin]     :=EdBanco.text;
   Grid.Cells[Grid.getcolumn('cont_banco'),lin]      :=FEmitentes.BuscaBanco(EdBanco.text,EdBanco);
   Grid.Cells[Grid.getcolumn('clie_cnpjcpf'),lin]    :=EdTipo_codigo.resultfind.fieldbyname('clie_cnpjcpf').AsString ;
   Grid.Cells[Grid.getcolumn('cont_situacao'),lin]      :=Edcont_situacao.text;
   Grid.Cells[Grid.getcolumn('cont_situacaoprop'),lin]   :=EdCont_situacaoprop.text ;
   Grid.Cells[Grid.GetColumn('cont_dataatual'),lin]:=Datetostr(Edcont_dataatual.asdate);

end;

procedure TFContratos.EdparcelasExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////
begin


    if not confirma('Confirma grava��o ?') then begin

       Edtipo_codigo.SetFocus;
       exit;

    end;

    if OP='I' then

        Operacao:=Global.codigounidade +  inttostr( FGeral.GetContador('CONTRATOS'+Global.CodigoUnidade,false) )

    else

        Operacao:=Grid.Cells[Grid.GetColumn('CONT_transacao'),Grid.Row];

    if OP='I' then begin

       Sistema.Insert('contratos');
       Sistema.SetField('cont_status','N');
       Sistema.SetField('cont_dataent',Edmovt_datamvto.asdate);
       Sistema.SetField('cont_datacon',EdMovt_datamvto.asdate);
       Sistema.SetField('cont_dtlcto',Sistema.Hoje);
       Sistema.SetField('cont_unid_codigo',Global.CodigoUnidade);
//       Sistema.SetField('cont_situacao','P');
       Sistema.SetField('cont_usua_codigo',Global.Usuario.codigo);
//       Sistema.SetField('cont_obs',Edmovt_obs.Text);
       Sistema.SetField('cont_tipo_codigo',Edtipo_codigo.Asinteger);
//       Sistema.SetField('cont_tipocad','C');
       Sistema.SetField('cont_valoroferecido',EdValoroferecido.Ascurrency);
       Sistema.SetField('cont_valorbruto',EdValorbruto.Ascurrency);
       Sistema.SetField('cont_parcela',EdParcela.Ascurrency);
       Sistema.SetField('cont_parcelas',EdParcelas.Ascurrency);
       Sistema.SetField('cont_numerodoc',EdNUmerocontrato.asinteger);
       Sistema.SetField('cont_banco',EdBanco.Text);
       Sistema.SetField('cont_fisico',EdFisico.Text);
       Sistema.SetField('cont_transacao',Operacao);
// 16.07.2021
       Sistema.SetField('cont_tipo',EdCont_tipo.Text);
       Sistema.SetField('cont_corretora',EdCont_corretora.Text);
       Sistema.SetField('cont_tabp_codigo',EdCont_tabp_codigo.Asinteger);
       Sistema.SetField('cont_tabaliquota',SetEdTABP_ALIQUOTA.Asinteger);
       Sistema.SetField('cont_valorliquido',Edcont_Valorliquido.Ascurrency);
       Sistema.SetField('cont_reducao',EdCont_reducao.Text);
       Sistema.SetField('cont_margem',Edcont_margem.Ascurrency);
       Sistema.SetField('cont_usua_codigolig',Edcont_usua_codigolig.AsInteger);
       Sistema.SetField('cont_usua_codigoate',Edcont_usua_codigoate.AsInteger);
       Sistema.SetField('cont_datapedsaldo',Edcont_datapedsaldo.asdate);
       Sistema.SetField('cont_datarecsaldo',Edcont_datarecsaldo.asdate);
       Sistema.SetField('cont_situacao',EdCont_situacao.Text);
       Sistema.SetField('cont_dataatual',EdCont_dataatual.asdate);
       Sistema.SetField('cont_comsaldo', EdCont_comsaldo.ascurrency);
       Sistema.SetField('cont_refiport',Edcont_refiport.text);
       Sistema.SetField('cont_bancoport',Edbanco_port.text);
       Sistema.SetField('cont_inf12pagas',Edcont_inf12pagas.text);
       Sistema.SetField('cont_situacaoprop',Edcont_situacaoprop.text);
//     Sistema.SetField('cont_comliquido',EdCont_comliquido.ascurrency);
//     Sistema.SetField('cont_combruto',EdCont_combruto.ascurrency);
       Sistema.Post();

    {
       if not EdMovt_datamvtopro.IsEmpty then begin

         Operacao:=inttostr( FGeral.GetContador('TELEVENDAS'+Global.CodigoUnidade,false) );


       end;
}

    end else begin

       Sistema.edit('contratos');
//       Sistema.SetField('movt_obs',Edmovt_obs.Text);
       Sistema.SetField('cont_valoroferecido',EdValoroferecido.Ascurrency);
       Sistema.SetField('cont_valorbruto',EdValorbruto.Ascurrency);
       Sistema.SetField('cont_parcela',EdParcela.Ascurrency);
       Sistema.SetField('cont_parcelas',EdParcelas.Ascurrency);
       Sistema.SetField('cont_numerodoc',EdNUmerocontrato.asinteger);
       Sistema.SetField('cont_banco',EdBanco.Text);
       Sistema.SetField('cont_fisico',EdFisico.Text);
// 16.07.2021
       Sistema.SetField('cont_tipo',EdCont_tipo.Text);
       Sistema.SetField('cont_corretora',EdCont_corretora.Text);
       Sistema.SetField('cont_tabp_codigo',EdCont_tabp_codigo.Asinteger);
       Sistema.SetField('cont_tabaliquota',SetEdTABP_ALIQUOTA.Asinteger);
       Sistema.SetField('cont_valorliquido',EdCont_Valorliquido.Ascurrency);
       Sistema.SetField('cont_reducao',EdCont_reducao.Text);
       Sistema.SetField('cont_margem',Edcont_margem.Ascurrency);
       Sistema.SetField('cont_usua_codigolig',Edcont_usua_codigolig.AsInteger);
       Sistema.SetField('cont_usua_codigoate',Edcont_usua_codigoate.AsInteger);
       Sistema.SetField('cont_datapedsaldo',Edcont_datapedsaldo.asdate);
       Sistema.SetField('cont_datarecsaldo',Edcont_datarecsaldo.asdate);
       Sistema.SetField('cont_situacao',EdCont_situacao.Text);
       Sistema.SetField('cont_dataatual',EdCont_dataatual.asdate);

       Sistema.SetField('cont_comsaldo', EdCont_comsaldo.ascurrency);
       Sistema.SetField('cont_refiport',Edcont_refiport.text);
       Sistema.SetField('cont_bancoport',Edbanco_port.text);
       Sistema.SetField('cont_inf12pagas',Edcont_inf12pagas.text);
       Sistema.SetField('cont_situacaoprop',Edcont_situacaoprop.text);
//     Sistema.SetField('cont_comliquido',EdCont_comliquido.ascurrency);
//     Sistema.SetField('cont_combruto',EdCont_combruto.ascurrency);


       Sistema.Post( 'cont_transacao = '+Stringtosql(Operacao) );

    end;

    try
       Sistema.commit;
       if OP='I' then
          EditstoGrid
       else
          EditstoGrid(Grid.Row);

    except on E:exception do

       Avisoerro('N�o foi poss�vel gravar no banco de dados.  '+E.Message);

    end;

    EdTipo_codigo.ClearAll(Self,0);
    PIns.Enabled:=false;
//    PIns.Visible:=false;
    Grid.Enabled:=true;
    Grid.SetFocus;


end;

procedure TFContratos.Execute;
//////////////////////////////////////


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
      ListaT.clear;

      while not Q.Eof do begin

//         Grid.Cells[Grid.getcolumn('movt_situacao'),i]:=GetSituacao( Q.fieldbyname('movt_situacao').AsString );
// ver se vai criar situacao do contrato
         Grid.Cells[Grid.getcolumn('cont_dataent'),i]:=FGeral.formatadata(Q.fieldbyname('cont_dataent').asdatetime);
         Grid.Cells[Grid.getcolumn('mesano'),i]      :=FormatDatetime('mmmm/yyyy',Q.fieldbyname('cont_dataent').asdatetime);
         Grid.Cells[Grid.getcolumn('clie_nome'),i]:=Q.fieldbyname('clie_nome').AsString;
         Grid.Cells[Grid.getcolumn('cont_parcela'),i]        :=FGeral.Formatavalor( Q.fieldbyname('cont_parcela').Ascurrency,F_cr);
         Grid.Cells[Grid.getcolumn('cont_transacao'),i]   :=Q.fieldbyname('cont_transacao').AsString;
         Grid.Cells[Grid.getcolumn('cont_tipo_codigo'),i]:=Q.fieldbyname('cont_tipo_codigo').AsString;
         Grid.Cells[Grid.getcolumn('cont_valoroferecido'),i]:=FGeral.Formatavalor(Q.fieldbyname('cont_valoroferecido').Ascurrency,f_cr);
         Grid.Cells[Grid.getcolumn('cont_valorbruto'),i]  :=FGeral.Formatavalor(Q.fieldbyname('cont_valorbruto').Ascurrency,f_cr) ;
//         Grid.Cells[Grid.getcolumn('cont_banco'),i]      :=Q.fieldbyname('cont_banco').AsString ;
         Grid.Cells[Grid.getcolumn('cont_banco'),i]      :=FEmitentes.BuscaBanco(Q.fieldbyname('cont_banco').AsString,EdBanco);
         Grid.Cells[Grid.getcolumn('clie_cnpjcpf'),i]    :=Q.fieldbyname('clie_cnpjcpf').AsString ;

         Grid.Cells[Grid.getcolumn('cont_situacao'),i]     :=Q.fieldbyname('cont_situacao').AsString;
         Grid.Cells[Grid.getcolumn('cont_situacaoprop'),i] :=Q.fieldbyname('cont_situacaoprop').AsString ;
         Grid.Cells[Grid.GetColumn('cont_dataatual'),i]    :=FGeral.FormataData(Q.fieldbyname('cont_dataatual').asdatetime);

         Grid.AppendRow;
         inc(i);

         AtualizaLista( Q );

         Q.Next;


      end;
      MostraLista;

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
  FGeral.ConfiguraColorEditsNaoEnabled(FContratos);
  FEmitentes.Setabancos(EdBanco);
  FEmitentes.Setabancos(EdBanco_port);
  GridTotais.clear;

  Show;
  xdata := Sistema.Hoje-(5*360);  // at� 5 anos 'pra tr�s'
  SetaTipos( EdCont_tipo );
  SetaCorretoras( Edcont_corretora );
  SetaSituacao( EdCont_situacao );
  ListaT := TList.create;
  SetaSituacaoProp( EdCont_situacaoprop );

  Sistema.beginprocess('pesquisando Contratos');
  Q:=sqltoquery('select *,clie_nome,clie_cnpjcpf from contratos '+
                ' inner join clientes on ( clie_codigo = cont_tipo_codigo )'+
                ' where cont_status=''N'''+
                ' and cont_unid_codigo = '+stringtosql(Global.CodigoUnidade)+
                ' and cont_dataent >= '+Datetosql(xdata)+
//                ' and cont_situacao=''P'''+
                ' order by cont_dataent');
  if not Q.eof then begin

    QuerytoGrid(Q);

  end;
  Sistema.endprocess('');

  Grid.Refresh;

end;

procedure TFContratos.FiltraGrid(campo, conteudo,tipocampo:string);
/////////////////////////////////////////////////////
var sqlfiltro : string;

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
      ListaT.clear;

      while not Q.Eof do begin

//         Grid.Cells[Grid.getcolumn('movt_situacao'),i]:=GetSituacao( Q.fieldbyname('movt_situacao').AsString );
// ver se vai criar situacao do contrato
         Grid.Cells[Grid.getcolumn('cont_dataent'),i]    :=FGeral.formatadata(Q.fieldbyname('cont_dataent').asdatetime);
         Grid.Cells[Grid.getcolumn('mesano'),i]          :=FormatDatetime('mmmm/yyyy',Q.fieldbyname('cont_dataent').asdatetime);
         Grid.Cells[Grid.getcolumn('clie_nome'),i]       :=Q.fieldbyname('clie_nome').AsString;
         Grid.Cells[Grid.getcolumn('cont_parcela'),i]    :=FGeral.Formatavalor( Q.fieldbyname('cont_parcela').Ascurrency,F_cr);
         Grid.Cells[Grid.getcolumn('cont_transacao'),i]   :=Q.fieldbyname('cont_transacao').AsString;
         Grid.Cells[Grid.getcolumn('cont_tipo_codigo'),i]:=Q.fieldbyname('cont_tipo_codigo').AsString;
         Grid.Cells[Grid.getcolumn('cont_valoroferecido'),i]:=FGeral.Formatavalor(Q.fieldbyname('cont_valoroferecido').Ascurrency,f_cr);
         Grid.Cells[Grid.getcolumn('cont_valorbruto'),i]  :=FGeral.Formatavalor(Q.fieldbyname('cont_valorbruto').Ascurrency,f_cr) ;
//         Grid.Cells[Grid.getcolumn('cont_banco'),i]      :=Q.fieldbyname('cont_banco').AsString ;
         Grid.Cells[Grid.getcolumn('cont_banco'),i]      :=FEmitentes.BuscaBanco(Q.fieldbyname('cont_banco').AsString,EdBanco);
         Grid.Cells[Grid.getcolumn('clie_cnpjcpf'),i]    :=Q.fieldbyname('clie_cnpjcpf').AsString ;

         Grid.Cells[Grid.getcolumn('cont_situacao'),i]      :=Q.fieldbyname('cont_situacao').AsString;
         Grid.Cells[Grid.getcolumn('cont_situacaoprop'),i]   :=Q.fieldbyname('cont_situacaoprop').AsString ;
         Grid.Cells[Grid.GetColumn('cont_dataatual'),i]    :=FGeral.FormataData(Q.fieldbyname('cont_dataatual').asdatetime);

         Grid.AppendRow;
         inc(i);
         AtualizaLista(Q);
         Q.Next;

      end;
      MostraLista;

    end;

    function GetMes( s:string ):string;
    //////////////////////////////////
    var mesx : string;

    begin

        mesx := Uppercase(s);
        if mesx = 'JANEIRO' then result := '01'
        else if mesx = 'FEVEREIRO' then result := '02'
        else if mesx = 'MAR�O' then result := '03'
        else if mesx = 'ABRIL' then result := '04'
        else if mesx = 'MAIO' then result := '05'
        else if mesx = 'JUNHO' then result := '06'
        else if mesx = 'JULHO' then result := '07'
        else if mesx = 'AGOSTO' then result := '08'
        else if mesx = 'SETEMBRO' then result := '09'
        else if mesx = 'OUTUBRO' then result := '10'
        else if mesx = 'NOVEMBRO' then result := '11'
        else if mesx = 'DEZEMBRO' then result := '12'
        else result := '??' ;

    end;



begin

  Sistema.beginprocess('filtrando Contratos');
  sqlfiltro :=' and '+campo+' = '+stringtosql(conteudo);
  if tipocampo = 'N' then

     sqlfiltro := 'and '+campo+' = '+Valortosql( TextToValor(conteudo))

  else if campo = 'cont_banco' then

     sqlfiltro :=' and '+campo+' = '+stringtosql( FEmitentes.BuscaBancopelaDescricao(conteudo,EdBanco) )

  else if campo = 'mesano' then

     sqlfiltro :=' and extract( year from cont_dataent ) = '+copy(conteudo,AnsiPos('/',conteudo)+1,4)+
                 ' and extract( month from cont_dataent ) = '+GetMes(copy(conteudo,1,AnsiPos('/',conteudo)-1 )) ;

  Q:=sqltoquery('select *,clie_nome,clie_cnpjcpf from contratos '+
                ' inner join clientes on ( clie_codigo = cont_tipo_codigo )'+
                ' where cont_status=''N'''+
                ' and cont_unid_codigo = '+stringtosql(Global.CodigoUnidade)+
                sqlfiltro+
                ' and cont_dataent >= '+Datetosql(xdata)+
//                ' and cont_situacao=''P'''+
//                ' order by cont_dataent');
                ' order by cont_situacao');


  if not Q.eof then begin

    QuerytoGrid(Q);

  end;
  Sistema.endprocess('');

  Grid.Refresh;

end;

procedure TFContratos.GridNewLine(Sender: TObject);
////////////////////////////////////////////////////////
var ctrans:string;

begin

   ctrans := Grid.Cells[Grid.GetColumn('CONT_transacao'),Grid.Row];
   if trim(ctrans) = '' then exit;

   Atualizaedits(ctrans);

end;

procedure TFContratos.GridTotaisDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
  //////////////////////////////////////////////
var s : string;
    t : integer;

begin

   if (Acol = 0 ) and ( arow>0 ) then begin

       if arow = 1 then

          GridTotais.Canvas.Brush.Color := clteal

       else if arow = 2 then

          GridTotais.Canvas.Brush.Color := clsilver

       else if arow = 3 then

          GridTotais.Canvas.Brush.Color := clblue

       else

          GridTotais.Canvas.Brush.Color := clyellow;

       s:=GridTotais.Cells[ACol,ARow];
       GridTotais.Canvas.FillRect(Rect);
           t:=GridTotais.Canvas.TextWidth(s)+2;
           if GridTotais.Columns[ACol].Alignment=taRightJustify then
              GridTotais.Canvas.TextRect(Rect,Rect.Right-t,Rect.Top+2,s)
           else GridTotais.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);

   end else if (Acol = GridTotais.getcolumn('total') ) and ( arow>0 ) then begin

       GridTotais.Canvas.Brush.Color := clyellow;
       s:=GridTotais.Cells[ACol,ARow];
       GridTotais.Canvas.FillRect(Rect);
           t:=GridTotais.Canvas.TextWidth(s)+2;
           if GridTotais.Columns[ACol].Alignment=taRightJustify then
              GridTotais.Canvas.TextRect(Rect,Rect.Right-t,Rect.Top+2,s)
           else GridTotais.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);

   end;

end;

procedure TFContratos.MostraLista;
/////////////////////////////////////
var linha,
    i:integer;
begin

    GridTotais.clear;
    linha:= 1;
    for i := 0 to ListaT.count-1 do begin

      PTtotais := ListaT[i];
      GridTotais.cells[colitem,linha]       := PTTotais.item;
      GridTotais.cells[colbruto,linha]      := FGeral.FormataValor( PTTotais.bruto,f_cr );
      GridTotais.cells[colcombruto,linha]   := FGeral.FormataValor( PTTotais.combruto,f_cr );
      GridTotais.cells[colcomliquido,linha] := FGeral.FormataValor( PTTotais.comliquido,f_cr );
      GridTotais.cells[colcomsaldo,linha]   := FGeral.FormataValor( PTTotais.comsaldo,f_cr );
      GridTotais.cells[colcomtotal,linha]      := FGeral.FormataValor( PTTotais.total,f_cr );
      inc(linha);
      if linha > GridTotais.rowcount then begin

         GridTotais.AppendRow;

      end;

   end;

end;

procedure TFContratos.SetaCorretoras(Ed: TSqlEd);
//////////////////////////////////////////////////
begin

    Ed.Items.clear;
    Ed.Items.Add('FACTA');
    Ed.Items.Add('AGIPLAN');
    Ed.Items.Add('ATUAL');
    Ed.Items.Add('LHASA');
    Ed.Items.Add('BEVICRED');
    Ed.Items.Add('GPCRED');
    Ed.Items.Add('POTENCIAL');
    Ed.Items.Add('BAHIACRED');
    Ed.Items.Add('DAYCOVAL');
    Ed.Items.Add('FONTES');
    Ed.Items.Add('GOLDIEN');
    Ed.Items.Add('VIA CERTA');
    Ed.Items.Add('SUPERCRED');
    Ed.Items.Add('SOLIDA');
    Ed.Items.Add('FIDELIZE');
    Ed.Items.Add('SIBRAS');
    Ed.Items.Add('BV');
    Ed.Items.Add('LEWE');
    Ed.Items.Add('VERDECARD');
    Ed.Items.Add('GFT MAIS');
    Ed.Items.Add('PR BANCO');
    Ed.Items.Add('CREFISA');
    Ed.Items.Add('AMF');
    Ed.Items.Add('NOVA');

end;

procedure TFContratos.SetaSituacao(Ed: TSqlEd);
////////////////////////////////////////////////
begin

    Ed.Items.clear;
    Ed.Items.Add('INSS AGUARDANDO');
    Ed.Items.Add('SALDO AGUARDANDO');
    Ed.Items.Add('CANCELADO');
    Ed.Items.Add('AGUARDANDO PAGAMENTO');
    Ed.Items.Add('PAGO');

end;

procedure TFContratos.SetaSituacaoProp(Ed: TSqlEd);
//////////////////////////////////////////////////////////
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

procedure TFContratos.SetaTipos(Ed: TSqlEd);
//////////////////////////////////////////////
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

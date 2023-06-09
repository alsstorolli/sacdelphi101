unit consulta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SQLGrid, StdCtrls, Mask, SQLEd, ExtCtrls,
  Buttons, SQLBtn, alabel, DB, DBClient, SimpleDS, SqlSis, SqlExpr, SqlDtg, ComObj  ;

type
  TFConsulta = class(TForm)
    PCadastro: TPanel;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    Grid: TSQLGrid;
    DsConsulta: TDataSource;
    TConsulta: TSQLDs;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bPesquisar: TSQLBtn;
    bExpColumn: TSQLBtn;
    Bevel1: TBevel;
    bRedColumn: TSQLBtn;
    bMoveLeft: TSQLBtn;
    bMoveRight: TSQLBtn;
    bDelColumn: TSQLBtn;
    bRestColumn: TSQLBtn;
    bLoadGrid: TSQLBtn;
    bSaveGrid: TSQLBtn;
    bdigitargrade: TSQLBtn;
    bterminargrade: TSQLBtn;
    Edcamponome: TSQLEd;
    DtGrid: TSqlDtGrid;
    EdCampo1: TSQLEd;
    bgeralitros: TSQLBtn;
    Od2: TOpenDialog;
    EdNroclientes: TSQLEd;
    Edtotqtde: TSQLEd;
    bgeraromaneios: TSQLBtn;
    EdNumeroinicial: TSQLEd;
    EdClie_tran_codigo: TSQLEd;
    SetEdtran_nome: TSQLEd;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure bPesquisarClick(Sender: TObject);
    procedure EdcamponomeExitEdit(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure EdcamponomeKeyPress(Sender: TObject; var Key: Char);
    procedure EdCampo1ExitEdit(Sender: TObject);
    procedure DtGridKeyPress(Sender: TObject; var Key: Char);
    procedure DtGridDblClick(Sender: TObject);
    procedure bgeralitrosClick(Sender: TObject);
    procedure APHeadLabel1DblClick(Sender: TObject);
    procedure bgeraromaneiosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(tabela,campos,campocodigo,condicao,ordem,titulo:string;select:string='';tipo:string='');
    function GetPosListaCli( xcodigo:integer ):integer;
    procedure Contagrid;
    procedure GravaRomaneio( xqtde,xcodigocli,codigomov,numero : integer );

  end;

Const ColunasGrid:integer=4;

type TListaCli=record

     codigo,
     seg,
     ter,
     qua,
     qui,
     sex  :integer

end;

var
  FConsulta: TFConsulta;
  campo1,
  xcampocodigo,
  campo2,
  campo3,
  campo4,
  campo5,
  campo6,
  fezcalculo,
  xproduto     :string;
  ListaCli     :TList;
  PListaCli    : ^TListaCli;
  TEstoque,
  TEstoqueQtde : TSqlquery;



implementation


uses Sqlfun, Geral, cadcli;


{$R *.dfm}


{ TFConsulta }

procedure TFConsulta.Execute(tabela,campos,campocodigo,condicao,ordem,titulo:string; select:string='';tipo:string='');
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var Lista:TStringlist;
    p:integer;
    campo:TDicionario;
    Qx:TSqlquery;

begin

   FGEral.ConfiguraColorEditsNaoEnabled(FConsulta);
   if TConsulta.Active then TConsulta.Close;;
   EdCampo1.TableName:=tabela;
   xcampocodigo:=campocodigo;
   bgeralitros.Enabled:=(tipo='L');
   bgeralitros.Visible:=(tipo='L');
   bgeraromaneios.Enabled:=(tipo='L');
   bgeraromaneios.Visible:=(tipo='L');
   EdNumeroinicial.Visible:=(tipo='L');
   EdNumeroinicial.Enabled:=(tipo='L');
   EdClie_tran_codigo.Visible:=(tipo='L');
   EdClie_tran_codigo.Enabled:=(tipo='L');
   EdNroclientes.Enabled:=(tipo='L');
   EdNroclientes.Visible:=(tipo='L');
   Edtotqtde.Enabled:=(tipo='L');
   Edtotqtde.Visible:=(tipo='L');
   SetEdtran_nome.Enabled:=(tipo='L');
   SetEdtran_nome.Visible:=(tipo='L');
   ListaCli := TList.Create;
   fezcalculo:='N';

   if select='' then begin

     Grid.Visible:=true;
     DtGrid.Visible:=false;
     Grid.Align:=alclient;
     TConsulta.TableName:=tabela;
     TConsulta.TableFields:=campos;
     TConsulta.CommandText:='select '+campos+' from '+tabela+' '+condicao+' '+ordem;

   end else begin

     Grid.Visible:=false;
     DtGrid.Visible:=true;
     DtGrid.Align:=alclient;
     Qx:=Sqltoquery( select );

   end;

   campo1:='clie_qtdediaria';
   campo2:='clie_vezessegunda';
   campo3:='clie_vezesterca';
   campo4:='clie_vezesquarta';
   campo5:='clie_vezesquinta';
   campo6:='clie_vezessexta';

// limpa as colunas do dtgrid
   for p:=0 to DtGrid.ColCount-1 do begin

       DtGrid.Columns.Items[p].FieldName:='';
       DtGrid.Columns.Items[p].Title.Caption:='';

   end;

   Lista:=TStringlist.create;
   strtolista(Lista,campos,',',true);
   Grid.FieldTransport:=campocodigo;
// fazer um for de uma string to lista com os campos
   for p:=0 to LIsta.count-1 do begin

     Grid.Columns.Items[p].FieldName:=Lista[p];
//     Grid.Columns.Items[p].Title.Caption:=ListaTitulos[p];
     campo:=Sistema.GetDicionario(tabela,lista[p]);
     if campo.Titulo<>'' then

        Grid.Columns.Items[p].Title.Caption:=campo.Titulo

     else

        Grid.Columns.Items[p].Title.Caption:='Descri��o';

     if p=ColunasGrid-1 then break;

   end;

   for p:=0 to LIsta.count-1 do begin

     DtGrid.Columns.Items[p].FieldName:=Lista[p];
//     Grid.Columns.Items[p].Title.Caption:=ListaTitulos[p];
     campo:=Sistema.GetDicionario(tabela,lista[p]);
     if campo.Titulo='' then begin
       DtGrid.Columns.Items[p].WidthColumn:=200;
       DtGrid.Columns.Items[p].Title.Caption:='Descri��o'
     end else
       DtGrid.Columns.Items[p].Title.Caption:=campo.Titulo;
     DtGrid.Columns.Items[p].FieldName:=campo.Campo;
     if campo.Tipo = 'N' then begin

       DtGrid.Columns.Items[p].Alignment:=tarightjustify;
       DtGrid.Columns.Items[p].WidthColumn:=Campo.Tamanho*8

// 10.09.19
     end else if campo.Tamanho > 0 then begin

       DtGrid.Columns.Items[p].Alignment:=taleftjustify;
       DtGrid.Columns.Items[p].WidthColumn:=Campo.Tamanho*3;

     end else begin  // tentar fazer o campo 'descri��o' de produtos ou outros

       DtGrid.Columns.Items[p].Alignment:=taleftjustify;
       DtGrid.Columns.Items[p].WidthColumn:=300;

     end;
//     if p=ColunasGrid-1 then break;

   end;

   FConsulta.Caption:=Titulo;

   if select=''  then begin

     TConsulta.Open;
     if uppercase(tabela)='ESTOQUE' then begin
       EdCamponome.TableField:='esto_descricao';
     end;

   end else begin

       if Tipo = 'L' then  begin

         while not Qx.Eof do begin

            New(PListaCli);
            PListaCli.codigo:=Qx.FieldByName( campocodigo ).AsInteger;
            PListaCli.seg   :=Qx.FieldByName( campo2 ).AsInteger;
            PListaCli.ter   :=Qx.FieldByName( campo3 ).AsInteger;
            PListaCli.qua   :=Qx.FieldByName( campo4 ).AsInteger;
            PListaCli.qui   :=Qx.FieldByName( campo5 ).AsInteger;
            PListaCli.sex   :=Qx.FieldByName( campo6 ).AsInteger;
            LIstaCli.Add( PListacli);

            Qx.Next;

         end;

         Qx.First;

       end;

       DtGrid.QuerytoGrid(Qx);

       if Tipo = 'L' then  ContaGrid;

   end;
//   EdCamponome.TableName:=tabela;
   if Tipo = 'L' then
      EdNumeroinicial.setvalue( FGeral.GetContador('ROMA'+Global.CodRomaneioRemessaaOrdem+Global.CodigoUnidade,false,false)+1);

   if not Visible then ShowModal;

end;

procedure TFConsulta.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin

   if TConsulta.Active then TConsulta.close;

end;

procedure TFConsulta.FormActivate(Sender: TObject);
var sqlgrupos:string;
begin
   if EdTransp<>nil then begin
     if Lowercase(EdTransp.TagStr)='estoque' then begin
      if FGeral.getconfig1asstring('GRUPOSPRECO')<>'' then
        sqlgrupos:=' where '+FGeral.GetIN('esto_grup_codigo',FGeral.getconfig1asstring('GRUPOSPRECO'),'N')
      else
        sqlgrupos:='';
        Execute('estoque','esto_codigo,esto_descricao','esto_codigo',sqlgrupos,'order by esto_descricao','Tipos de Carnes' );
     end;
   end;
end;

// 11.04.19
procedure TFConsulta.APHeadLabel1DblClick(Sender: TObject);
////////////////////////////////////////////////////////////////
var Excel,
    valor,
    Password,
    Readonly,
    FileName,
    celula                    : Variant;
    arqu,
    xcodigo                   : string;
    valorc,
    valorc1                   : currency;
    p                         : integer;
    Q                         : TSqlquery;

begin

  if Global.Usuario.Codigo<>100 then exit;
  if not Od2.Execute then exit;
  arqu:=Od2.FileName;
  if not FileExists( arqu ) then begin
    Avisoerro('Arquivo '+arqu+' n�o enconttrado');
    exit;
  end;
  try
    Excel := CreateOleObject('Excel.Application');
  except on E:exception do
    Avisoerro('N�o foi poss�vel executar o Excel.'+E.Message);
  end;
  Excel.Visible := false;
//  Excel.WorkBooks.Open( arqu );
  Excel.WorkBooks.Open(FileName := arqu, Password := '', ReadOnly := True);
  ExecuteSql('update clientes set '+campo1+' = 0 ');

  for p := 2 to 460 do begin


     valor:=Excel.Cells.Item[ p,1 ].Value2;
     valorc:=-1;
     if  VarIsNumeric( valor ) then valorc:=valor
     else if VarIsFloat( valor ) then valorc:=valor
     else if VarIsStr( valor ) then valorc:=Texttovalor( valor );
//     else Aviso('C�lula ref. NCM com tipo n�o tratado');

     if Valorc>0 then begin

        Sistema.BeginProcess('Atualizando codigo '+xcodigo);
        celula:=Excel.Cells.Item[ p, 1  ].Value2;
        valorc:=-1;
        if  VarIsNumeric( celula ) then valorc:=celula
        else if VarIsFloat( celula ) then valorc:=celula;
//        else Aviso('C�lula com tipo n�o tratado');
        if valorc >0 then begin

          celula:=Excel.Cells.Item[ p,1 ].Value2;
          xcodigo:=trim(celula);
          celula:=Excel.Cells.Item[ p,4 ].Value2;
          valorc1:=celula;
          Q:=sqltoquery('select clie_codigo from clientes where clie_codigo = '+trim(xcodigo));
          if not Q.eof then begin

             Sistema.edit('clientes');
             Sistema.setfield('clie_qtdediaria',valorc1);
             Sistema.setfield('clie_vezessegunda',2);
             Sistema.setfield('clie_vezesquarta',3);
             Sistema.setfield('clie_vezessexta',3);
             Sistema.post('clie_codigo = '+xcodigo );
             try

               Sistema.commit;

             except on E:exception do Avisoerro( E.message );

             end;

          end else Aviso('Codigo '+xcodigo+' n�o encontrado em clientes');

          FGeral.FechaQuery(Q);

        end;

     end;

  end;

  DtGrid.Refresh;
  Sistema.EndProcess('Terminado');

end;

procedure TFConsulta.bgeralitrosClick(Sender: TObject);
/////////////////////////////////////////////////////////////////////
var p,
    codigocli,
    posicao     : integer;
    ListaApagar : TStringList;

begin

    ListaApagar := TStringList.Create;
    fezcalculo:='S';

    for p := 0 to DtGrid.RowCount-1 do begin

        codigocli:=strtointdef( DtGrid.Cells[ Dtgrid.GetColumn(xcampocodigo),p ] ,0 );
        if codigocli > 0 then begin

           Posicao:=GetPosListaCli( codigocli );
           PListaCli := Listacli[ posicao ] ;
           if Strtointdef( DtGrid.Cells[Dtgrid.GetColumn( campo1 ),p] ,0) >0 then begin

               DtGrid.Cells[Dtgrid.GetColumn( campo2 ),p] := inttostr (
                     Strtointdef(Dtgrid.Cells[ Dtgrid.GetColumn(campo1) ,p] ,0) * PListacli.seg );
               DtGrid.Cells[Dtgrid.GetColumn( campo3 ),p] := inttostr (
                     Strtointdef(Dtgrid.Cells[ Dtgrid.GetColumn(campo1) ,p] ,0) * PListacli.ter );
               DtGrid.Cells[Dtgrid.GetColumn( campo4 ),p] := inttostr (
                     Strtointdef(Dtgrid.Cells[ Dtgrid.GetColumn(campo1) ,p] ,0) * PListacli.qua );
               DtGrid.Cells[Dtgrid.GetColumn( campo5 ),p] := inttostr (
                     Strtointdef(Dtgrid.Cells[ Dtgrid.GetColumn(campo1) ,p] ,0) * PListacli.qui );
               DtGrid.Cells[Dtgrid.GetColumn( campo6 ),p] := inttostr (
                     Strtointdef(Dtgrid.Cells[ Dtgrid.GetColumn(campo1) ,p] ,0) * PListacli.sex );

           end else ListaApagar.Add( inttostr(p) );

        end;

    end;

    for p := 0 to DtGrid.rowCount do begin
        if Strtointdef( DtGrid.Cells[Dtgrid.GetColumn( campo1 ),p] ,0) = 0 then
           DtGrid.Cells[ DtGrid.GetColumn( campo1 ),p ] := 'X';
    end;

    DtGrid.Seek( DtGrid.GetColumn( campo1 ),'X' );

//    for p := 0 to DtGrid.rowCount do begin
    DtGrid.Seek( DtGrid.GetColumn( campo1 ),'X' );
    p:=DtGrid.Row;

    while DtGrid.Cells[ DtGrid.GetColumn( campo1 ),p ] = 'X'  do begin

//        if  DtGrid.Cells[ DtGrid.GetColumn( campo1 ),p ] = 'X' then
           DtGrid.DeleteRow( p );
           if P>DtGrid.RowCount then  break;

           inc(p)

    end;

    Dtgrid.Refresh;
{
    for p := 0 to DtGrid.rowCount do begin
        if trim(DtGrid.Cells[Dtgrid.GetColumn( campo1 ),p]) = 'X' then
           DtGrid.DeleteRow( p );
    end;

    Dtgrid.Refresh;
    for p := 0 to DtGrid.rowCount do begin
        if trim(DtGrid.Cells[Dtgrid.GetColumn( campo1 ),p]) = 'X' then
           DtGrid.DeleteRow( p );
    end;
    Dtgrid.Refresh;
}

//    for p := 0 to ListaApagar.Count-1 do DtGrid.DeleteRow( strtoint(ListaApagar[p]) );
    ListaApagar.Free;
    contagrid;

end;

// 12.04.19
procedure TFConsulta.bgeraromaneiosClick(Sender: TObject);
/////////////////////////////////////////////////////////////
var QTM,
    Qr          :TSqlquery;
    p,
    codigocli,
    qtde,
    xroma,
    numromaneio :integer;
    xcampo,
    codigomoto  :string;

begin

   if fezcalculo = 'N' then begin
      Avisoerro('Efetuar o calculo ao menos uma vez') ;
      exit;
   end;

   if EdNumeroinicial.AsInteger=0 then begin
      Avisoerro('Informar o numero do primeiro romaneio' );
      exit;
   end;

   QTm:=sqltoquery('select * from confmov where comv_tipomovto = '+stringtosql( Global.CodRomaneioRemessaaOrdem ));
   if QTm.eof then begin
      Avisoerro('N�o encontrado configura��o de movimento ref. romaneio de remessa a ordem '+Global.CodRomaneioRemessaaOrdem);
      exit;
   end;
   if not Sistema.GetDataMvto('Data emiss�o' ) then exit;
   if not confirma('Confirma gera��o ? ') then  exit;
   xcampo:='clie_vezessegunda';
   if DateToDiaSemana( Sistema.DataMvto,0 ) = 'Seg' then
      xcampo:='clie_vezessegunda'
   else if DateToDiaSemana( Sistema.DataMvto,0 ) = 'Ter' then
      xcampo:='clie_vezesterca'
   else if DateToDiaSemana( Sistema.DataMvto,0 ) = 'Qua' then
      xcampo:='clie_vezesquarta'
   else if DateToDiaSemana( Sistema.DataMvto,0 ) = 'Qui' then
      xcampo:='clie_vezesquinta'
   else if DateToDiaSemana( Sistema.DataMvto,0 ) = 'Sex' then
      xcampo:='clie_vezessexta';

// primeiro checa se todos tem codigo de motorista/transportador no cadastro
   for p := 0 to DtGrid.RowCount-1 do begin

        codigocli:=strtointdef( DtGrid.Cells[ Dtgrid.GetColumn(xcampocodigo),p ] ,0 );
        if codigocli > 0 then begin

           codigomoto:=FCadCli.GetCodigoMoto( codigocli );
           if trim(codigomoto)='' then begin
              Avisoerro('Cliente codigo '+inttostr(codigocli)+' sem codigo do motorista');
              exit;
           end;

        end;

   end;

// primeiro elimina romaneios com o mesmo numero e mes ano
   Sistema.BeginProcess('Eliminando romaneios eventualmente j� gerados');
   Qr:=sqltoquery('select moes_transacao from movesto where moes_tipomov = '+stringtosql(Global.CodRomaneioRemessaaOrdem)+
                  ' and moes_status = ''N'' and moes_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                  ' and extract( year from moes_dataemissao ) = '+inttostr(Datetoano(Sistema.DataMvto,true))+
                  ' and extract( month from moes_dataemissao ) = '+inttostr(Datetomes(Sistema.DataMvto))+
                  ' and moes_numerodoc >= '+EdNumeroinicial.AsSql );

   while not Qr.eof do begin

     Sistema.Edit('movesto') ;
     Sistema.SetField('moes_status','C');
     Sistema.Post('moes_transacao = '+stringtosql(QR.fieldbyname('moes_transacao').asstring) );
     Sistema.Edit('movestoque');
     Sistema.SetField('move_status','C');
     Sistema.Post('move_transacao = '+stringtosql(QR.fieldbyname('moes_transacao').asstring) );
     Sistema.Edit('movbase');
     Sistema.SetField('movb_status','C');
     Sistema.Post('movb_transacao = '+stringtosql(QR.fieldbyname('moes_transacao').asstring) );

     Qr.Next;

   end;
   FGeral.FechaQuery(Qr);

   try
      Sistema.commit ;
   except on E:exception do
      Avisoerro( E.message );
   end;

   xroma:=0;

   Sistema.BeginProcess('Gerando romaneios');
   numromaneio:=EdNUmeroinicial.AsInteger;
   xProduto:='0047015';

   TEstoque:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(xproduto) );

   TEstoqueqtde:=sqltoquery('select * from estoqueqtde where esqt_status=''N'' and esqt_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                               ' and esqt_esto_codigo='+stringtosql(xproduto) );

   for p := 0 to DtGrid.RowCount-1 do begin

        codigocli:=strtointdef( DtGrid.Cells[ Dtgrid.GetColumn(xcampocodigo),p ] ,0 );
        if codigocli > 0 then begin

           if Strtointdef( DtGrid.Cells[Dtgrid.GetColumn( xcampo ),p] ,0) >0 then begin

              qtde:=Strtointdef( DtGrid.Cells[Dtgrid.GetColumn( xcampo ),p] ,0);
              if not Edclie_tran_codigo.IsEmpty then begin

                 codigomoto:=FCadCli.GetCodigoMoto( codigocli );
                 if codigomoto = Edclie_tran_codigo.Text then begin
                    GravaRomaneio( qtde,codigocli,Qtm.FieldByName('comv_codigo').AsInteger,numromaneio );
                    inc(xroma);
                    inc(numromaneio);
                 end;

              end else begin

                 GravaRomaneio( qtde,codigocli,Qtm.FieldByName('comv_codigo').AsInteger,numromaneio );
                 inc(xroma);
                 inc(numromaneio);

              end;

           end;

        end;

   end;

   fGeral.FechaQuery(TEstoque);
   fGeral.FechaQuery(TEstoqueQtde);
   Sistema.EndProcess('Gerados '+inttostr(xroma)+' romaneios');

end;

procedure TFConsulta.bPesquisarClick(Sender: TObject);
begin
//   Grid.Find;
//   Grid.DoEnterFind
//   aviso( TConsulta.CommandText );
     EdCampoNome.Visible:=true;
     EdCampoNOme.Enabled:=true;
     EdCampoNome.clear;
     EdCampoNome.SetFocus;
end;

procedure TFConsulta.Contagrid;
////////////////////////////////
var x,
    codigocli,
    totcli,
    totqtde  :integer;

begin

   totcli  :=0;
   totqtde :=0;
   for x:= 0 to DtGrid.RowCount do begin

        codigocli:=strtointdef( DtGrid.Cells[ Dtgrid.GetColumn(xcampocodigo),x ] ,0 );
        if ( codigocli > 0 ) and ( strtointdef( DtGrid.Cells[ Dtgrid.GetColumn( campo1 ),x ] ,0 )>0 ) then begin
           inc(totcli);
           totqtde:=totqtde +strtointdef( DtGrid.Cells[ Dtgrid.GetColumn( campo1 ),x ] ,0 )
        end;

   end;
   Edtotqtde.SetValue( totqtde );
   EdNroclientes.SetValue( totcli );

end;

// 10.04.19
procedure TFConsulta.DtGridDblClick(Sender: TObject);
//////////////////////////////////////////////////////////////////////
var xcampo:string;
begin

   xcampo := DtGrid.Columns[ DtGrid.Col ].FieldName;
   EdCampo1.TableField:=xcampo;
//   if ( DtGrid.GetColumn( campo1 ) = DtGrid.col )
   if AnsiPos( xcampo,campo1+';'+campo2+';'+campo3+';'+campo4+';'+campo5+';'+campo6 ) >0
     then begin

     EdCampo1.Top:=DTGrid.TopEdit;
     EdCampo1.Left:=dtGrid.LeftEdit;
     EdCampo1.Enabled:=true;
     EdCampo1.Visible:=true;
     EdCampo1.text:=dtGrid.cells[dtgrid.getcolumn( xcampo ),dtgrid.row];
     EdCampo1.setfocus;

   end;

end;

procedure TFConsulta.DtGridKeyPress(Sender: TObject; var Key: Char);
//////////////////////////////////////////////////////////////////////////////
begin

  if key=#13 then
     dtGrid.OnDblClick(self)


end;

// 10.04.19
procedure TFConsulta.EdCampo1ExitEdit(Sender: TObject);
/////////////////////////////////////////////////////////
var ycampo:string;
    y     :integer;

begin

  if ( EdCampo1.AsInteger <= 4 ) or ( EdCampo1.TableField=campo1 )  then begin

    dtGrid.cells[dtgrid.getcolumn( Edcampo1.TableField ),dtgrid.row]:=EdCampo1.assql;

    Sistema.Edit( EdCampo1.TableName );
    Sistema.SetField( Edcampo1.TableField,EdCampo1.Text );
    Sistema.Post( xcampocodigo+' = '+DtGrid.Cells[dtgrid.GetColumn( xcampocodigo ),dtGrid.row] );
    Sistema.Commit;
    if EdCampo1.TableField <> campo1 then begin

       y:=GetPosListaCli( strtoint(DtGrid.Cells[dtgrid.GetColumn( xcampocodigo ),dtGrid.row]) );
       PListaCli:=ListaCli[y];
       if EdCampo1.TableField=campo2 then
          PListaCli.seg := EdCampo1.Asinteger
       else if EdCampo1.TableField=campo3 then
          PListaCli.ter:= EdCampo1.Asinteger
       else if EdCampo1.TableField=campo4 then
          PListaCli.qua:= EdCampo1.Asinteger
       else if EdCampo1.TableField=campo5 then
          PListaCli.qui:= EdCampo1.Asinteger
       else if EdCampo1.TableField=campo6 then
          PListaCli.sex:= EdCampo1.Asinteger;

    end;

    EdCampo1.Enabled:=false;
    EdCampo1.Visible:=false;
    DtGrid.setfocus;

  end else begin

     Aviso('N�o ser� gravado valores maiores que 4');
     EdCampo1.Enabled:=false;
     EdCampo1.Visible:=false;
     DtGrid.setfocus;

  end;

end;

procedure TFConsulta.EdcamponomeExitEdit(Sender: TObject);
begin
     EdCampoNome.Visible:=false;
     EdCampoNOme.Enabled:=false;
     if not TConsulta.Locate(EdCamponome.TableField,EdCamponome.Text,[loPartialKey,loCaseInsensitive]) then
       aviso('N�o encontrado '+EdCamponome.Text)
     else
       Grid.SetFocus;
//     TConsulta.Refresh;
//     Grid.Refresh;
//     Grid.Find;
//     Grid.Find;

end;

function TFConsulta.GetPosListaCli(xcodigo: integer): integer;
///////////////////////////////////////////////////
var i:integer;
begin
       result:=-1;
       for i := 0 to ListaCli.Count-1 do begin
           PListacli:=ListaCli[i];
           if PListacli.codigo=xcodigo then begin
              result:=i;
              break;
           end;

       end;

end;

procedure TFConsulta.GravaRomaneio( xqtde,xcodigocli,codigomov,numero : integer );
/////////////////////////////////////////////////////////////////////////////////
var Q,
    Cliente       : TSqlquery;
    especie,
    serie,
    transacao,
    unidade,
    tipocad,
    condicao,
    csticms,
    xcfop          : string;

begin

    Q:=sqltoquery('select * from confmov where comv_codigo='+inttostr(codigomov));
    especie:=Q.fieldbyname('comv_especie').asstring;
    serie  :=Q.fieldbyname('comv_serie').asstring;

    Cliente:=sqltoquery('select clie_tran_codigo,clie_repr_codigo,clie_cida_codigo_com,'+
                        'clie_uf from clientes where clie_codigo='+inttostr(xcodigocli) );

    unidade:=global.CodigoUnidade;
    Transacao:=FGeral.GetTransacao;
    condicao:='001';
    CSTicms :='040';
    xcfop   := '5923';

    Sistema.Insert('Movesto');
    Sistema.SetField('moes_transacao',Transacao);
    Sistema.SetField('moes_operacao',FGeral.GetOperacao);
    Sistema.SetField('moes_status','N');
    Sistema.SetField('moes_numerodoc',Numero);
    Sistema.SetField('moes_romaneio',Numero);
    Sistema.SetField('moes_tipomov',Global.CodRomaneioRemessaaOrdem);
    Sistema.SetField('moes_comv_codigo',codigomov);
    Sistema.SetField('moes_unid_codigo',Unidade);
    Sistema.SetField('moes_tipo_codigo',xcodigocli);
      tipocad:='C';
      Sistema.SetField('moes_estado',Cliente.fieldbyname('clie_uf').AsString);
      Sistema.SetField('moes_tipocad','C');
      Sistema.SetField('moes_repr_codigo',Cliente.fieldbyname('clie_repr_codigo').AsString);
      Sistema.SetField('moes_cida_codigo',Cliente.fieldbyname('clie_cida_codigo_com').AsInteger);

    Sistema.SetField('moes_datalcto',Sistema.Hoje);
    campo:=Sistema.GetDicionario('movesto','moes_datasaida');
    if Campo.Tipo<>'' then begin
      Sistema.SetField('moes_datasaida',Sistema.DataMvto);
      Sistema.SetField('moes_datamvto',Sistema.DataMvto);
    end else
      Sistema.SetField('moes_datamvto',Sistema.DataMvto);

    Sistema.SetField('moes_DataCont',Sistema.DataMvto);
    Sistema.SetField('moes_dataemissao',Sistema.DataMvto);
//    Sistema.SetField('moes_tabp_codigo',Tabela);
//    Sistema.SetField('moes_tabaliquota',FTabela.GetAliquota(Tabela));
    Sistema.SetField('moes_natf_codigo',Q.fieldbyname('comv_natf_estado').asstring);
    Sistema.SetField('moes_freteciffob','1');
    Sistema.SetField('moes_valoricms',0);
    Sistema.SetField('moes_basesubstrib',0);
    Sistema.SetField('moes_valoricmssutr',0);
    Sistema.SetField('moes_frete',0);
    Sistema.SetField('moes_vispra','V');
    Sistema.SetField('moes_especie',especie);
    Sistema.SetField('moes_serie',serie);
    Sistema.SetField('moes_tran_codigo',Cliente.FieldByName('clie_tran_codigo').AsString);
    Sistema.SetField('Moes_qtdevolume',0);
    Sistema.SetField('Moes_especievolume','');
    Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
    Sistema.SetField('Moes_Perdesco',0);
    Sistema.SetField('Moes_Peracres',0);
    Sistema.SetField('moes_remessas','');
    Sistema.SetField('moes_mensagem',' ');
    Sistema.SetField('moes_pedido',0);
// 15.11.05
    Sistema.SetField('moes_pesoliq',0);
    Sistema.SetField('moes_pesobru',0);
    Sistema.SetField('moes_clie_codigo',0);
    Sistema.SetField('moes_fpgt_codigo',Condicao);

    Sistema.SetField('moes_valoripi',0);
    Sistema.SetField('moes_freteuni',0);
    Sistema.SetField('moes_baseiss',0);
    Sistema.SetField('moes_valorpis',0);
    Sistema.SetField('moes_valorcofins',0);

    Sistema.SetField('moes_valorir',0);
    Sistema.SetField('moes_valorcsl',0);
    Sistema.SetField('moes_valoriss',0);
    Sistema.SetField('moes_periss',0);
    Sistema.SetField('moes_vlrservicos',0);
    Sistema.SetField('moes_valoravista',0);
    Sistema.SetField('moes_totprod',xqtde);
    Sistema.SetField('moes_valortotal',xqtde);
    Sistema.SetField('moes_vlrtotal',xqtde);
    Sistema.SetField('moes_baseicms',0);
{
    if (Global.topicos[1043]) and ( Movimento > 1 )  then begin
       transacaocontax:=GetTransacaoContax(strzero(FUnidades.GetEmpresaContax(Unidade),3),True);
       Sistema.SetField('moes_transacerto',transacaocontax);
    end;
}
    Sistema.Post();


      Sistema.Insert('Movestoque');
      Sistema.SetField('move_esto_codigo',xproduto);
/////////////
      Sistema.SetField('move_transacao',transacao);
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
      Sistema.SetField('move_numerodoc',numero);
      Sistema.SetField('move_status','N');
      Sistema.SetField('move_tipomov',Global.CodRomaneioRemessaaOrdem);
      Sistema.SetField('move_unid_codigo',Unidade);
      Sistema.SetField('move_tipo_codigo',xcodigocli);
      if tipocad='F' then begin
        Sistema.SetField('move_tipocad','F');
      end else begin
        Sistema.SetField('move_tipocad','C');
        Sistema.SetField('move_repr_codigo',Cliente.fieldbyname('clie_repr_codigo').AsString);
      end;
      Sistema.SetField('move_qtde',xqtde);
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datacont',Sistema.DataMvto);
      Sistema.SetField('move_datamvto',Sistema.DataMvto);
      Sistema.SetField('move_qtderetorno',0);
      Sistema.SetField('move_custo',TEstoqueQtde.fieldbyname('esqt_custo').ascurrency);
      Sistema.SetField('move_custoger',TEstoqueQtde.fieldbyname('esqt_custoger').ascurrency);
      Sistema.SetField('move_customedio',TEstoqueQtde.fieldbyname('esqt_customedio').ascurrency);
      Sistema.SetField('move_customeger',TEstoqueQtde.fieldbyname('esqt_customeger').ascurrency);
      Sistema.SetField('move_cst',csticms);
      Sistema.SetField('move_aliicms',0);
      Sistema.SetField('move_venda',1);
      Sistema.SetField('move_grup_codigo',TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('move_sugr_codigo',TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('move_fami_codigo',TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.SetField('move_perdesco',0);
      Sistema.SetField('move_vendabru',1);
      Sistema.SetField('move_aliipi',0);
      Sistema.SetField('move_pecas',0);
      Sistema.SetField('move_vendamin',0);
      Sistema.SetField('move_redubase',0);
    Sistema.Post();

    Sistema.Insert('MovBase');
    Sistema.SetField('movb_transacao',Transacao);
    Sistema.SetField('movb_operacao',FGeral.GetOperacao);
    Sistema.SetField('movb_status','N');
    Sistema.SetField('movb_numerodoc',Numero);
    Sistema.SetField('Movb_cst',Csticms);
    Sistema.SetField('Movb_TpImposto','C' );
    Sistema.SetField('Movb_BaseCalculo',0);
    Sistema.SetField('Movb_Aliquota',0);
    Sistema.SetField('Movb_ReducaoBc',0);
    Sistema.SetField('Movb_Imposto',0);
    Sistema.SetField('Movb_Isentas',0);
    Sistema.SetField('Movb_Outras' ,0);
    Sistema.SetField('Movb_tipomov',Global.CodRomaneioRemessaaOrdem);
    Sistema.SetField('Movb_unid_codigo',Unidade);
    Sistema.SetField('Movb_natf_codigo',xcfop);

    Sistema.Post();

    FGeral.Fechaquery(Q);
    FGeral.Fechaquery(Cliente);

    try
       Sistema.Commit;
       EdNumeroinicial.setvalue( Numero );
       FGeral.AlteraContador('ROMA'+Global.CodRomaneioRemessaaOrdem+Global.CodigoUnidade,Numero );
    except on E:exception do
       Avisoerro( E.Message );
    end;

end;

procedure TFConsulta.GridKeyPress(Sender: TObject; var Key: Char);
begin
  if isCaracterBras( key ) then begin
     EdCampoNome.Visible:=true;
     EdCampoNOme.Enabled:=true;
//     EdCampoNome.clear;
     EdCampoNome.text:=key;
     EdCampoNome.SetPosCursor(2);
     EdCampoNome.SetFocus;
  end;
//  bpesquisarclick(self);  pois limpa o campo
end;

procedure TFConsulta.EdcamponomeKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#27 then begin
     EdCampoNome.Visible:=false;
     EdCampoNOme.Enabled:=false;
  end;

end;

end.

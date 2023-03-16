unit concbanc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid;

type
  TFConcbancaria = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bconcilia: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PAcerto: TSQLPanelGrid;
    bprocurar: TSQLBtn;
    EdArquivo: TSQLEd;
    OpenDialog1: TOpenDialog;
    PConfere: TSQLPanelGrid;
    GridConfere: TSqlDtGrid;
    Edbanco: TSQLEd;
    EdBanco_descricao: TSQLEd;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    EdDatai: TSQLEd;
    EdDataf: TSQLEd;
    procedure EdArquivoValidate(Sender: TObject);
    procedure GridConfereClick(Sender: TObject);
    procedure bprocurarClick(Sender: TObject);
    procedure EdbancoValidate(Sender: TObject);
    procedure GridClick(Sender: TObject);
    procedure bconciliaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
  end;

var
  FConcbancaria: TFConcbancaria;
  Datai,Dataf:TDatetime;
  tipoarquivo:string;

implementation

uses Geral,SqlExpr,Sqlfun,Sqlsis , plano, Emitentes, Cadcheq;

{$R *.dfm}

procedure TFConcbancaria.EdArquivoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////
var g_erro,banco:string;
    Mat:Tstringlist;
    p,x,i:integer;
    Q:TSqlquery;
    data:Tdatetime;
    valor,valortotalpago:currency;
    LinhaDados:TStringlist;

begin

// 11.10.16
   if not EdArquivo.IsEmpty then begin
     if not Fileexists( EdArquivo.text ) then begin
       EdArquivo.INvalid('Arquivo '+EdArquivo.text+' não encontrado');
       exit;
     end;
     Mat:=TStringList.Create;
     Mat.LoadFromFile(EdArquivo.text);

     Try
        g_erro := copy( Mat.Strings[0],10,1 );
     Except
        avisoerro('Arquivo de retorno inválido');
        Mat.Free;
        exit;
     End;
     Grid.clear;
     GridConfere.clear;
     if ( copy( Mat.Strings[3],014,1 )='E' )  then begin
       banco:=copy( Mat.Strings[3],01,03 );
       tipoarquivo:='CNAB';
//       EdBanco.text:=banco;
     end else
       banco:=EdBanco.resultfind.fieldbyname('planPlan_codigobanco').AsString;

//     datai:=Sistema.hoje;dataf:=Sistema.hoje;
  //   if pos(EdBanco.text,'001')=0 then begin
  //     EdArquivo.invalid('Banco não configurado para conciliação bancária');
  //     exit;
  //   end;

     x:=0;
     for p:=0 to Mat.count-1 do begin

        if tipoarquivo='CNAB'  then begin
          if copy( Mat.Strings[p],014,01 )='E' then begin
            if p=0 then
              x:=1
            else
              inc(x);
            data:=texttodate(copy( Mat.Strings[p],135,08 ) );
            if data<datai then
              datai:=data
            else if data>dataf then
              dataf:=data;
            Grid.Cells[grid.getcolumn('data'),abs(x)]:=FGeral.Formatadata( texttodate(copy( Mat.Strings[p],135,08 )) );
  //          Grid.Cells[grid.getcolumn('valor'),abs(x)]:=fGeral.formatavalor( texttovalor( copy(Mat.Strings[p],151,13)+'.'+copy(Mat.Strings[p],166,02) ) ,f_cr);
            Grid.Cells[grid.getcolumn('valor'),abs(x)]:=fGeral.formatavalor( texttovalor( copy(Mat.Strings[p],151,16)+'.'+copy(Mat.Strings[p],169,02) ) ,f_cr);
            if copy( Mat.Strings[p],169,01 )='C' then
              Grid.Cells[grid.getcolumn('categoria'),abs(x)]:='E'
            else
              Grid.Cells[grid.getcolumn('categoria'),abs(x)]:='S';
            Grid.Cells[grid.getcolumn('historico'),abs(x)]:=copy(Mat.Strings[p],177,025);
            Grid.Cells[grid.getcolumn('documento'),abs(x)]:=copy(Mat.Strings[p],202,015);
            Grid.AppendRow;

          end;

        end else if Banco='001' then begin   // banco do brasil

            LinhaDados:=TStringlist.create;
            strtolista(LinhaDados,Mat.Strings[p],';',true);
            if (pos('SALDO',LinhaDados[9])=0) and (pos('S A L D O',LinhaDados[9])=0) and (linhadados[3]<>'') then begin
              if p=0 then
                x:=1
              else
                inc(x);
              data:=texttodate(LInhadados[3] );
              if data<datai then
                datai:=data
              else if data>dataf then
                dataf:=data;
              Grid.Cells[grid.getcolumn('data'),abs(x)]:=FGeral.formatadata( texttodate(Linhadados[3]) );
  //            Grid.Cells[grid.getcolumn('valor'),abs(x)]:=fGeral.formatavalor( texttovalor(LInhadados[10])/100 ,f_cr);
              Grid.Cells[grid.getcolumn('valor'),abs(x)]:=floattostr( texttovalor(LInhadados[10])/100);
              if Linhadados[11]='C' then
                Grid.Cells[grid.getcolumn('es'),abs(x)]:='E'
              else
                Grid.Cells[grid.getcolumn('es'),abs(x)]:='S';
              Grid.Cells[grid.getcolumn('categoria'),abs(x)]:='Agengia '+LinhaDados[5];
              Grid.Cells[grid.getcolumn('historico'),abs(x)]:=LinhaDados[9];
              Grid.Cells[grid.getcolumn('documento'),abs(x)]:=LinhaDados[7];
              Grid.AppendRow;
            end;
        end;

     end;
   end;

   Sistema.beginprocess('Lendo movimento bancário da conta '+Edbanco.text);
   Datai:=EdDatai.asdate;
   Dataf:=EdDataf.asdate;
{
    if (Edtiporel.text='9') then
      sqlacesso:=''
    else if (Edtiporel.text='2') then
      sqlacesso:=' and movf_datacont is null'
    else
      sqlacesso:=' and movf_datacont is not null';
}
//   datai:=Datetoprimeirodiames(datai);
//   dataf:=Datetoultimodiames(datai);
   Q:=sqltoquery('select * from movfin'+
//                 ' left join historicos on (hist_codigo=movf_hist_codigo)'+
                 ' where '+FGeral.Getin('movf_status','N','C')+
//                 ' and '+FGeral.getnotin('movf_unid_codigo',global.UnidadesTestes,'C',)+
                 ' and '+FGeral.getin('movf_unid_codigo',global.usuario.UnidadesRelatorios,'C')+
                 ' and movf_datamvto>='+DatetoSql(Datai)+' and movf_datamvto<='+Datetosql(Dataf)+
                 ' and ( (movf_dataextrato is null) )'+
/////                 or (movf_dataextrato=0) )'+
//                 ' and movf_plan_conta='+inttostr( FPlano.Getcontaviabanco(banco) )+
                 ' and movf_plan_conta='+EdBanco.assql+
                 ' order by movf_datamvto' );
   if Q.eof then  begin
     Sistema.EndProcess('Não encontrado movimento nesta conta neste período');
     EdDatai.setfocus;
     exit;
   end;
   x:=1;
   while not Q.eof do begin
     GridConfere.Cells[gridConfere.getcolumn('movf_datamvto'),abs(x)]:= FGeral.Formatadata(Q.fieldbyname('movf_datamvto').asdatetime );
//     GridConfere.Cells[gridConfere.getcolumn('movf_valorger'),abs(x)]:=fGeral.formatavalor( Q.fieldbyname('movf_valorger').ascurrency ,f_cr);
     GridConfere.Cells[gridConfere.getcolumn('movf_valorger'),abs(x)]:=floattostr( Q.fieldbyname('movf_valorger').ascurrency );
     GridConfere.Cells[gridConfere.getcolumn('movf_es'),abs(x)]:=Q.fieldbyname('movf_es').asstring;
     GridConfere.Cells[gridConfere.getcolumn('movf_complemento'),abs(x)]:=Q.fieldbyname('movf_complemento').asstring;
     GridConfere.Cells[gridConfere.getcolumn('movf_numerodcto'),abs(x)]:=Q.fieldbyname('movf_numerodcto').asstring;
     GridConfere.Cells[gridConfere.getcolumn('movf_operacao'),abs(x)]:=Q.fieldbyname('movf_operacao').asstring;
     inc(x);
     GridConfere.AppendRow;
     Q.Next;
   end;
   FGeral.Fechaquery(Q);
   Sistema.endprocess('');
   Grid.setfocus;
end;

procedure TFConcbancaria.Execute;
//////////////////////////////////////
begin
////   FEmitentes.Setabancos(Edbanco);
   show;
   FGeral.ConfiguraColorEditsNaoEnabled(FConcbancaria);
   Grid.clear;
   Gridconfere.clear;
   tipoarquivo:='XXX';
   if EdDatai.IsEmpty then EdDatai.SetDate(Sistema.hoje);
   if EdDataf.IsEmpty then EdDataf.SetDate(Sistema.hoje);
   EdBanco.setfocus;

end;

procedure TFConcbancaria.GridConfereClick(Sender: TObject);
/////////////////////////////////////////////////////////////////
begin
   if Gridconfere.col=Gridconfere.getcolumn('conferido') then begin
     if Gridconfere.cells[Gridconfere.getcolumn('conferido'),Gridconfere.row]='Ok' then
       Gridconfere.cells[Gridconfere.getcolumn('conferido'),Gridconfere.row]:=''
     else
       Gridconfere.cells[Gridconfere.getcolumn('conferido'),Gridconfere.row]:='Ok';
   end;
end;

procedure TFConcbancaria.bprocurarClick(Sender: TObject);
begin
   if opendialog1.execute then begin
     EdArquivo.text:=Opendialog1.FileName;
     EdArquivo.valid;
     Grid.setfocus;
   end;

end;

procedure TFConcbancaria.EdbancoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////
begin
//   EdCheq_bcoemitente.text:=FCadCheques.GetNomeBanco(Edbanco.text,Edbanco);
//   EdCheq_bcoemitente.text:=FCadCheques.GetNomeBanco(Edbanco.text,Edbanco);
    if EdBanco.ResultFind<>nil then begin
      if EdBanco.ResultFind.FieldByName('plan_tipo').AsString<>'B' then EdBanco.Invalid('Escolher conta de banco');
    end;
end;

procedure TFConcbancaria.GridClick(Sender: TObject);
begin

   if Grid.col=Grid.getcolumn('conferido') then begin
     if Grid.cells[Grid.getcolumn('conferido'),Grid.row]='Ok' then
       Grid.cells[Grid.getcolumn('conferido'),Grid.row]:=''
     else
       Grid.cells[Grid.getcolumn('conferido'),Grid.row]:='Ok';
   end;

end;

procedure TFConcbancaria.bconciliaClick(Sender: TObject);
/////////////////////////////////////////////////////////////////
var ListaBanco,Listaconta:TStringlist;
    x,linha:integer;
    dataextrato:TDatetime;
    gravar:boolean;

   function Checavalores:boolean;
   ///////////////////////////////
   var i:integer;
       valorbanco,valorconta,valor:currency;
   begin
     valorbanco:=0;
     for i:=1 to Grid.rowcount do begin
       valor:=texttovalor(Grid.cells[Grid.getcolumn('valor'),i]);
       if (valor>0) and (Grid.cells[Grid.getcolumn('conferido'),i]='Ok') then begin
         valorbanco:=valorbanco+valor;
         ListaBanco.add(inttostr(i));
       end;
     end;
     valorconta:=0;
     for i:=1 to GridConfere.rowcount do begin
       valor:=texttovalor(GridConfere.cells[Gridconfere.getcolumn('movf_valorger'),i]);
       if (valor>0) and (Gridconfere.cells[Gridconfere.getcolumn('conferido'),i]='Ok') then begin
         valorconta:=valorconta+valor;
         ListaConta.add(inttostr(i));
       end;
     end;
     if (valorconta<>valorbanco) and ( not EdARquivo.IsEmpty ) then
       result:=false
     else
       result:=true;
   end;


begin

   ListaBanco:=TStringlist.create;
   Listaconta:=TStringlist.create;
//   if not EdArquivo.IsEmpty then begin
     if not Checavalores then begin
       Avisoerro('Valores não conferem');
       exit;
     end;
//   end;
   if not confirma('Confirma conciliação ?') then exit;
   dataextrato:=sistema.hoje;
   gravar:=false;

     Sistema.beginprocess('Gravando conciliação');
     for x:=0 to ListaBanco.count-1 do begin
       linha:=strtointdef(ListaBanco[x],0);
       if linha>0 then begin
         Dataextrato:=texttodate( FGeral.tirabarra(Grid.cells[Grid.getcolumn('data'),linha]) );
         Grid.DeleteRow(linha);
       end;
     end;
     if ListaBanco.Count=0 then DataExtrato:=Sistema.Hoje;
     for x:=0 to ListaConta.count-1 do begin
       linha:=strtointdef(ListaConta[x],0);
       if linha>0 then begin
         gravar:=true;
         Sistema.Edit('Movfin');
         Sistema.Setfield('movf_dataextrato',dataextrato);
         Sistema.post('movf_operacao='+stringtosql(Gridconfere.cells[Gridconfere.getcolumn('movf_operacao'),linha]));
         GridConfere.DeleteRow(linha);
       end;
     end;
     if gravar then Sistema.commit;
     Sistema.endprocess('');
end;

end.

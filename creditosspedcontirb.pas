// 18.05.19
// Controle de cr�ditos de pis e cofins para exportar para sped contribuicoes
// registros 1100 e 1500

unit creditosspedcontirb;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, SQLEd,
  Vcl.Grids, SqlDtg, Vcl.Buttons, SQLBtn, alabel, Vcl.ExtCtrls, SQLGrid,
  SqlExpr, SqlRel;

type
  TFCreditosSped = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    bCancelar: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PRemessa: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    Edsped_mesano: TSQLEd;
    Edsped_orig_cred: TSQLEd;
    Edsped_registro: TSQLEd;
    Edsped_cod_cre: TSQLEd;
    Edsped_vl_cred_apu: TSQLEd;
    Edsped_vl_tot_cred_apu: TSQLEd;
    Edsped_vl_cred_desc_pa_ant: TSQLEd;
    Edsped_sd_cred_disp_efd: TSQLEd;
    Edsped_sld_cred_fim: TSQLEd;
    EDsped_vl_cred_ext_apu: TSQLEd;
    Edsped_vl_cred_per_pa_ant: TSQLEd;
    Edsped_cnpj_suc: TSQLEd;
    Edsped_vl_cred_dcomp_pa_ant: TSQLEd;
    Edsped_vl_cred_desc_efd: TSQLEd;
    Edsped_vl_cred_per_efd: TSQLEd;
    Edsped_vl_cred_dcomp_efd: TSQLEd;
    Edsped_vl_cred_trans: TSQLEd;
    Edsped_vl_cred_out: TSQLEd;
    Edsped_per_apu_cred: TSQLEd;
    brelatorio: TSQLBtn;
    procedure Edsped_registroValidate(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure Edsped_mesanoValidate(Sender: TObject);
    procedure Edsped_sld_cred_fimExitEdit(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure brelatorioClick(Sender: TObject);
    procedure Edsped_cod_creValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure Zeracampos;

  end;

var
  FCreditosSped: TFCreditosSped;
  Q,
  Qa            : TSqlquery;
  mes,
  mesant,
  ano,
  anoant       : integer;

implementation

uses Sqlsis,SqlFun, Geral;

{$R *.dfm}

{ TFCreditosSped }

procedure TFCreditosSped.bCancelarClick(Sender: TObject);
/////////////////////////////////////////////////////////////
begin

   if EdSped_mesano.IsEmpty then begin
      Avisoerro('Preencher o mes/ano');
      exit;
   end;
   if EdSped_registro.IsEmpty then begin
      Avisoerro('Preencher o registro do Sped');
      exit;
   end;
   if Q=nil then begin
      Avisoerro('Preencher o registro do Sped e o mes/ano');
      exit;
   end;
   if Q.Eof then begin
      Avisoerro('Nada encontrado com este registro do Sped e o mes/ano');
      exit;
   end;

   if confirma('Confirma exclus�o ? ') then begin

      ExecuteSql('delete from sped where sped_tiposped = '+stringtosql( 'CONTRIBUICOES' )+
                 ' and sped_registro = '+EdSped_registro.AsSql+
                 ' and sped_mesano   = '+EdSped_mesano.AsSql );
      Zeracampos;
      Edsped_mesano.SetFocus;

   end;

end;

procedure TFCreditosSped.bGravarClick(Sender: TObject);
/////////////////////////////////////////////////////////
begin

   if EdSped_mesano.IsEmpty then begin
      Avisoerro('Preencher o mes/ano');
      exit;
   end;
   if EdSped_registro.IsEmpty then begin
      Avisoerro('Preencher o registro do Sped');
      exit;
   end;
   if Q=nil then begin
      Avisoerro('Preencher o registro do Sped e o mes/ano');
      exit;
   end;

   if confirma('Confirma grava��o ? ') then begin

      if Q.Eof then begin

         Sistema.Insert('sped');
         Sistema.SetField('sped_mesano',Edsped_mesano.Text);
         Sistema.SetField('sped_tiposped','CONTRIBUICOES');
         Sistema.SetField('sped_registro',EdSped_registro.Text);

      end else begin

         Sistema.Edit('sped');

      end;

         Sistema.SetField('sped_per_apu_cred',Edsped_per_apu_cred.Text);
         Sistema.SetField('sped_orig_cred',Edsped_orig_cred.AsInteger);
         Sistema.SetField('sped_cod_cre',Edsped_cod_cre.Asinteger);
         Sistema.SetField('sped_cnpj_suc',Edsped_cnpj_suc.Text);
         Sistema.SetField('sped_vl_cred_apu',Edsped_vl_cred_apu.ascurrency );
         Sistema.SetField('sped_vl_cred_ext_apu',Edsped_vl_cred_ext_apu.ascurrency );
         Sistema.SetField('sped_vl_tot_cred_apu',Edsped_vl_tot_cred_apu.ascurrency );
         Sistema.SetField('sped_vl_cred_desc_pa_ant',Edsped_vl_cred_desc_pa_ant.ascurrency );
         Sistema.SetField('sped_vl_cred_per_pa_ant',Edsped_vl_cred_per_pa_ant.ascurrency );
         Sistema.SetField('sped_vl_cred_dcomp_pa_ant',Edsped_vl_cred_dcomp_pa_ant.ascurrency );
         Sistema.SetField('sped_sd_cred_disp_efd',Edsped_sd_cred_disp_efd.ascurrency );
         Sistema.SetField('sped_vl_cred_desc_efd',Edsped_vl_cred_desc_efd.ascurrency );
         Sistema.SetField('sped_vl_cred_per_efd',Edsped_vl_cred_per_efd.AsCurrency );
         Sistema.SetField('sped_vl_cred_dcomp_efd',Edsped_vl_cred_dcomp_efd.ascurrency );
         Sistema.SetField('sped_vl_cred_trans',Edsped_vl_cred_trans.ascurrency );
         Sistema.SetField('sped_vl_cred_out',Edsped_vl_cred_out.ascurrency );
         Sistema.SetField('sped_sld_cred_fim',Edsped_sld_cred_fim.ascurrency );

      if Q.Eof then  Sistema.Post()  else Sistema.Post('sped_tiposped = '+stringtosql( 'CONTRIBUICOES' )+
                                          ' and sped_registro = '+EdSped_registro.AsSql+
                                          ' and sped_mesano   = '+EdSped_mesano.AsSql );

      try

          Sistema.Commit;
          Aviso('Informa��es gravadas');
          EdSped_mesano.SetFocus;

      except on E:exception do begin

          Avisoerro( E.message )

      end;

      end;

   end;

end;

procedure TFCreditosSped.brelatorioClick(Sender: TObject);
///////////////////////////////////////////////////////////
var Q          :TSqlquery;
    sqlperiodo,
    sqlunidade : string;

begin

   Q:=sqltoquery('select * from sped where sped_tiposped = '+stringtosql( 'CONTRIBUICOES' )+
                 ' order by sped_mesano' );
   if Q.eof then begin
      Avisoerro('Nada encontrado para impress�o');
      Q.close;
      Freeandnil(Q);
      Sistema.EndProcess('');
      exit;
   end;

    FRel.Init('RelCreditosPisCofins');
    FRel.AddTit('Relat�rio de Cr�ditos de Pis/Cofins');
    FRel.AddTit(FGeral.GetTituloUnidades(Global.codigounidade) );
    FRel.AddCol( 70,1,'C','' ,''              ,'Mes/ano'           ,''         ,'',false);
    FRel.AddCol( 90,1,'C','' ,''              ,'Registro Sped'           ,''         ,'',false);
    FRel.AddCol(090,1,'C','' ,''              ,'Per.Ap.Cr�dito'            ,''         ,'',false);
    FRel.AddCol(070,1,'C','' ,''              ,'Orig.Cr�d.'            ,''         ,'',false);
    FRel.AddCol(070,1,'C','' ,''              ,'Tipo Cr�d.'            ,''         ,'',false);
    FRel.AddCol(120,1,'C','' ,''              ,'Cnpj Cr�d.'            ,''         ,'',false);

    FRel.AddCol(090,3,'N','' ,''              ,'Vlr Cr�d.Ap.'            ,''         ,'',false);
    FRel.AddCol(090,3,'N','' ,''              ,'Vlr Cr�d.Ext.Ap.'            ,''         ,'',false);
    FRel.AddCol(090,3,'N','' ,''              ,'Vlr Tot Cr�d.Ap.'            ,''         ,'',false);
    FRel.AddCol(090,3,'N','' ,''              ,'Vlr Cr�d.Ut.Des.'            ,''         ,'',false);
    FRel.AddCol(090,3,'N','' ,''              ,'Cr�d.Ut.Ressarc.'            ,''         ,'',false);
    FRel.AddCol(090,3,'N','' ,''              ,'Cr�d.Ut.Compens.'            ,''         ,'',false);
    FRel.AddCol(090,3,'N','' ,''              ,'Saldo Cr�d.Disp.'            ,''         ,'',false);
    FRel.AddCol(090,3,'N','' ,''              ,'Cr�d.Desc.Per.'            ,''         ,'',false);
    FRel.AddCol(090,3,'N','' ,''              ,'Cr�d.Obj.Ped.'            ,''         ,'',false);
    FRel.AddCol(090,3,'N','' ,''              ,'Cr�d.Ut.Comp.Per'            ,''         ,'',false);
    FRel.AddCol(090,3,'N','' ,''              ,'Cr�d.Transferido'            ,''         ,'',false);
    FRel.AddCol(090,3,'N','' ,''              ,'Cr�d.Ut.Outras F.'            ,''         ,'',false);
    FRel.AddCol(090,3,'N','' ,''              ,'Saldo Cr�d. a Ut.'            ,''         ,'',false);

    while not Q.eof do begin

        FRel.AddCel(Q.FieldByName('sped_mesano').AsString);
        FRel.AddCel(Q.FieldByName('sped_registro').AsString);
        FRel.AddCel(Q.FieldByName('sped_per_apu_cred').AsString);
        FRel.AddCel(strzero(Q.FieldByName('sped_orig_cred').AsInteger,2));
        FRel.AddCel(Q.FieldByName('sped_cod_cre').AsString);
        FRel.AddCel(Q.FieldByName('sped_cnpj_suc').AsString);

        FRel.AddCel(FGeral.Formatavalor( Q.FieldByName('sped_vl_cred_apu').AsCurrency,f_cr) );
        FRel.AddCel(FGeral.Formatavalor( Q.FieldByName('sped_vl_cred_ext_apu').AsCurrency,f_cr) );
        FRel.AddCel(FGeral.Formatavalor( Q.FieldByName('sped_vl_tot_cred_apu').AsCurrency,f_cr) );
        FRel.AddCel(FGeral.Formatavalor( Q.FieldByName('sped_vl_cred_desc_pa_ant').AsCurrency,f_cr) );

        FRel.AddCel(FGeral.Formatavalor( Q.FieldByName('sped_vl_cred_per_pa_ant').AsCurrency,f_cr) );

        FRel.AddCel(FGeral.Formatavalor( Q.FieldByName('sped_vl_cred_dcomp_pa_ant').AsCurrency,f_cr) );
        FRel.AddCel(FGeral.Formatavalor( Q.FieldByName('sped_sd_cred_disp_efd').AsCurrency,f_cr) );
        FRel.AddCel(FGeral.Formatavalor( Q.FieldByName('sped_vl_cred_desc_efd').AsCurrency,f_cr) );
        FRel.AddCel(FGeral.Formatavalor( Q.FieldByName('sped_vl_cred_per_efd').AsCurrency,f_cr) );
        FRel.AddCel(FGeral.Formatavalor( Q.FieldByName('sped_vl_cred_dcomp_efd').AsCurrency,f_cr) );
        FRel.AddCel(FGeral.Formatavalor( Q.FieldByName('sped_vl_cred_trans').AsCurrency,f_cr) );
        FRel.AddCel(FGeral.Formatavalor( Q.FieldByName('sped_vl_cred_out').AsCurrency,f_cr) );
        FRel.AddCel(FGeral.Formatavalor( Q.FieldByName('sped_sld_cred_fim').AsCurrency,f_cr) );

        Q.Next;

    end;

    FRel.Video;

    Sistema.EndProcess('');
    Q.Close;Freeandnil(Q);


end;


procedure TFCreditosSped.Edsped_cod_creValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
begin

    Q:=sqltoquery('select * from sped where sped_tiposped = '+stringtosql( 'CONTRIBUICOES' )+
                 ' and sped_registro = '+EdSped_registro.AsSql+
                 ' and sped_cod_cre  = '+EdSped_cod_cre.AsSql+
                 ' and sped_mesano   = '+EdSped_mesano.AsSql );
    if not Q.eof then begin

      Edsped_per_apu_cred.Text := Q.fieldbyname('sped_per_apu_cred').asstring;
      Edsped_orig_cred.Text    := strzero( Q.fieldbyname('sped_orig_cred').asinteger,2);
//      Edsped_cod_cre.Text      := strzero( Q.fieldbyname('sped_cod_cre').asinteger,3 );
      Edsped_cnpj_suc.Text     := Q.fieldbyname('sped_cnpj_suc').asstring;
      Edsped_vl_cred_apu.SetValue( Q.fieldbyname('sped_vl_cred_apu').ascurrency );
      EDsped_vl_cred_ext_apu.SetValue( Q.fieldbyname('sped_vl_cred_ext_apu').ascurrency );
      Edsped_vl_tot_cred_apu.SetValue( Q.fieldbyname('sped_vl_tot_cred_apu').ascurrency );
      Edsped_vl_cred_desc_pa_ant.SetValue( Q.fieldbyname('sped_vl_cred_desc_pa_ant').ascurrency );
      Edsped_vl_cred_per_pa_ant.SetValue( Q.fieldbyname('sped_vl_cred_per_pa_ant').ascurrency );
      Edsped_vl_cred_dcomp_pa_ant.SetValue( Q.fieldbyname('sped_vl_cred_dcomp_pa_ant').ascurrency );
      Edsped_sd_cred_disp_efd.SetValue( Q.fieldbyname('sped_sd_cred_disp_efd').ascurrency );
      Edsped_vl_cred_desc_efd.SetValue( Q.fieldbyname('sped_vl_cred_desc_efd').ascurrency );
      Edsped_vl_cred_per_efd.SetValue (Q.fieldbyname('sped_vl_cred_per_efd').ascurrency );
      Edsped_vl_cred_dcomp_efd.SetValue( Q.fieldbyname('sped_vl_cred_dcomp_efd').ascurrency );
      Edsped_vl_cred_trans.SetValue( Q.fieldbyname('sped_vl_cred_trans').ascurrency );
      Edsped_vl_cred_out.SetValue( Q.fieldbyname('sped_vl_cred_out').ascurrency );
      Edsped_sld_cred_fim.SetValue( Q.fieldbyname('sped_sld_cred_fim').ascurrency );

   end else if Confirma('Trazer do mes/anterior ?') then begin

      QA:=sqltoquery('select * from sped where sped_tiposped = '+stringtosql( 'CONTRIBUICOES' )+
                 ' and sped_registro = '+EdSped_registro.AsSql+
                 ' and sped_cod_cre  = '+EdSped_cod_cre.AsSql+
                 ' and sped_mesano   = '+stringtosql(strzero(mesant,2)+strzero(anoant,4)) );

      if not Qa.eof then begin

          Edsped_per_apu_cred.Text := Qa.fieldbyname('sped_per_apu_cred').asstring;
          Edsped_orig_cred.Text    := strzero( Qa.fieldbyname('sped_orig_cred').asinteger,2);
//          Edsped_cod_cre.Text      := strzero( Qa.fieldbyname('sped_cod_cre').asinteger,3 );
          Edsped_cnpj_suc.Text     := Qa.fieldbyname('sped_cnpj_suc').asstring;
          Edsped_vl_cred_apu.SetValue( Qa.fieldbyname('sped_vl_cred_apu').ascurrency );
          EDsped_vl_cred_ext_apu.SetValue( Qa.fieldbyname('sped_vl_cred_ext_apu').ascurrency );
          Edsped_vl_tot_cred_apu.SetValue( Qa.fieldbyname('sped_vl_tot_cred_apu').ascurrency );
          Edsped_vl_cred_desc_pa_ant.SetValue( Qa.fieldbyname('sped_vl_cred_desc_pa_ant').ascurrency );
          Edsped_vl_cred_per_pa_ant.SetValue( Qa.fieldbyname('sped_vl_cred_per_pa_ant').ascurrency );
          Edsped_vl_cred_dcomp_pa_ant.SetValue( Qa.fieldbyname('sped_vl_cred_dcomp_pa_ant').ascurrency );
          Edsped_sd_cred_disp_efd.SetValue( Qa.fieldbyname('sped_sd_cred_disp_efd').ascurrency );
          Edsped_vl_cred_desc_efd.SetValue( Qa.fieldbyname('sped_vl_cred_desc_efd').ascurrency );
          Edsped_vl_cred_dcomp_efd.SetValue( Qa.fieldbyname('sped_vl_cred_dcomp_efd').ascurrency );
          Edsped_vl_cred_per_efd.SetValue (Qa.fieldbyname('sped_vl_cred_per_efd').ascurrency );
          Edsped_vl_cred_trans.SetValue( Qa.fieldbyname('sped_vl_cred_trans').ascurrency );
          Edsped_vl_cred_out.SetValue( Qa.fieldbyname('sped_vl_cred_out').ascurrency );
          Edsped_sld_cred_fim.SetValue( Qa.fieldbyname('sped_sld_cred_fim').ascurrency );
          Qa.close;

       end;

   end else begin

      Aviso(EdSped_mesano.Text+' Registro '+EdSped_registro.Text+' n�o encontrado. Preencha os campos e grave.');
      ZeraCampos;

   end;

end;

procedure TFCreditosSped.Edsped_mesanoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////
begin

   mes:=strtoint(copy(Edsped_mesano.Text,1,2));
   ano:=strtoint(copy(Edsped_mesano.Text,3,4));
   if ( mes=0 ) or ( mes>12 ) then begin

       EdSped_mesano.Invalid('Mes inv�lido');

   end else if mes=1 then begin
     mesant:=12;
     anoant:=ano-1;
   end else begin
      mesant:=mes-1;
      anoant:=ano;
   end;

end;

procedure TFCreditosSped.Edsped_registroValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
begin

//////////////////////////////////
{
    Q:=sqltoquery('select * from sped where sped_tiposped = '+stringtosql( 'CONTRIBUICOES' )+
                 ' and sped_registro = '+EdSped_registro.AsSql+
                 ' and sped_mesano   = '+EdSped_mesano.AsSql );
    if not Q.eof then begin

      Edsped_per_apu_cred.Text := Q.fieldbyname('sped_per_apu_cred').asstring;
      Edsped_orig_cred.Text    := strzero( Q.fieldbyname('sped_orig_cred').asinteger,2);
      Edsped_cod_cre.Text      := strzero( Q.fieldbyname('sped_cod_cre').asinteger,3 );
      Edsped_cnpj_suc.Text     := Q.fieldbyname('sped_cnpj_suc').asstring;
      Edsped_vl_cred_apu.SetValue( Q.fieldbyname('sped_vl_cred_apu').ascurrency );
      EDsped_vl_cred_ext_apu.SetValue( Q.fieldbyname('sped_vl_cred_ext_apu').ascurrency );
      Edsped_vl_tot_cred_apu.SetValue( Q.fieldbyname('sped_vl_tot_cred_apu').ascurrency );
      Edsped_vl_cred_desc_pa_ant.SetValue( Q.fieldbyname('sped_vl_cred_desc_pa_ant').ascurrency );
      Edsped_vl_cred_per_pa_ant.SetValue( Q.fieldbyname('sped_vl_cred_per_pa_ant').ascurrency );
      Edsped_vl_cred_dcomp_pa_ant.SetValue( Q.fieldbyname('sped_vl_cred_dcomp_pa_ant').ascurrency );
      Edsped_sd_cred_disp_efd.SetValue( Q.fieldbyname('sped_sd_cred_disp_efd').ascurrency );
      Edsped_vl_cred_desc_efd.SetValue( Q.fieldbyname('sped_vl_cred_desc_efd').ascurrency );
      Edsped_vl_cred_dcomp_efd.SetValue( Q.fieldbyname('sped_vl_cred_dcomp_efd').ascurrency );
      Edsped_vl_cred_trans.SetValue( Q.fieldbyname('sped_vl_cred_trans').ascurrency );
      Edsped_vl_cred_out.SetValue( Q.fieldbyname('sped_vl_cred_out').ascurrency );
      Edsped_sld_cred_fim.SetValue( Q.fieldbyname('sped_sld_cred_fim').ascurrency );

   end else if Confirma('Trazer do mes/anterior ?') then begin

      QA:=sqltoquery('select * from sped where sped_tiposped = '+stringtosql( 'CONTRIBUICOES' )+
                 ' and sped_registro = '+EdSped_registro.AsSql+
                 ' and sped_mesano   = '+stringtosql(strzero(mesant,2)+strzero(anoant,4)) );
      if not Qa.eof then begin

          Edsped_per_apu_cred.Text := Qa.fieldbyname('sped_per_apu_cred').asstring;
          Edsped_orig_cred.Text    := strzero( Qa.fieldbyname('sped_orig_cred').asinteger,2);
          Edsped_cod_cre.Text      := strzero( Qa.fieldbyname('sped_cod_cre').asinteger,3 );
          Edsped_cnpj_suc.Text     := Qa.fieldbyname('sped_cnpj_suc').asstring;
          Edsped_vl_cred_apu.SetValue( Qa.fieldbyname('sped_vl_cred_apu').ascurrency );
          EDsped_vl_cred_ext_apu.SetValue( Qa.fieldbyname('sped_vl_cred_ext_apu').ascurrency );
          Edsped_vl_tot_cred_apu.SetValue( Qa.fieldbyname('sped_vl_tot_cred_apu').ascurrency );
          Edsped_vl_cred_desc_pa_ant.SetValue( Qa.fieldbyname('sped_vl_cred_desc_pa_ant').ascurrency );
          Edsped_vl_cred_per_pa_ant.SetValue( Qa.fieldbyname('sped_vl_cred_per_pa_ant').ascurrency );
          Edsped_vl_cred_dcomp_pa_ant.SetValue( Qa.fieldbyname('sped_vl_cred_dcomp_pa_ant').ascurrency );
          Edsped_sd_cred_disp_efd.SetValue( Qa.fieldbyname('sped_sd_cred_disp_efd').ascurrency );
          Edsped_vl_cred_desc_efd.SetValue( Qa.fieldbyname('sped_vl_cred_desc_efd').ascurrency );
          Edsped_vl_cred_dcomp_efd.SetValue( Qa.fieldbyname('sped_vl_cred_dcomp_efd').ascurrency );
          Edsped_vl_cred_trans.SetValue( Qa.fieldbyname('sped_vl_cred_trans').ascurrency );
          Edsped_vl_cred_out.SetValue( Qa.fieldbyname('sped_vl_cred_out').ascurrency );
          Edsped_sld_cred_fim.SetValue( Qa.fieldbyname('sped_sld_cred_fim').ascurrency );
          Qa.close;

       end;

   end else begin

      Aviso(EdSped_mesano.Text+' Registro '+EdSped_registro.Text+' n�o encontrado. Preencha os campos e grave.');
      ZeraCampos;

   end;
   }
//////////////////////////////////

end;

procedure TFCreditosSped.Edsped_sld_cred_fimExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////////////
begin

   bGravarClick(self);

end;

procedure TFCreditosSped.Execute;
/////////////////////////////////
begin

   Show;
   Edsped_mesano.ClearAll(FCreditosSped,0);
   Edsped_mesano.SetFocus;

end;

procedure TFCreditosSped.Zeracampos;
//////////////////////////////////////
begin

    Edsped_per_apu_cred.Text := '';
    Edsped_orig_cred.Text    := '';
//    Edsped_cod_cre.Text      := '' ;
    Edsped_cnpj_suc.Text     := '';
    Edsped_vl_cred_apu.SetValue( 0 );
    EDsped_vl_cred_ext_apu.SetValue( 0 );
    Edsped_vl_tot_cred_apu.SetValue( 0 );
    Edsped_vl_cred_desc_pa_ant.SetValue( 0 );
    Edsped_vl_cred_per_pa_ant.SetValue( 0 );
    Edsped_vl_cred_dcomp_pa_ant.SetValue( 0 );
    Edsped_sd_cred_disp_efd.SetValue( 0 );
    Edsped_vl_cred_desc_efd.SetValue( 0 );
    Edsped_vl_cred_dcomp_efd.SetValue( 0 );
    Edsped_vl_cred_per_efd.SetValue( 0 );
    Edsped_vl_cred_trans.SetValue( 0 );
    Edsped_vl_cred_out.SetValue( 0 );
    Edsped_sld_cred_fim.SetValue( 0 );

end;

end.

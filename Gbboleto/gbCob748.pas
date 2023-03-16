{******************************************************************************}
{ Projeto: gbBoleto                                                            }
{ Biblioteca multi plataforma de componentes Delphi para intera��o com bancos  }
{ na impress�o de Boletos e Controle de Cobran�as                              }
{                                                                              }
{ Direitos Autorais Reservados (c) 2005 Projeto Delphi Boleto                  }
{                                       Genilton Barbosa                       }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Hist�rico
|*
|* 19/12/2005: Alexandre Oliveira e Alexandre Rocha Lima e Marcondes
|*  - Primeira Versao gbBoleto no ACBr
******************************************************************************}

unit gbCob748;

interface

uses
   classes, SysUtils, gbCobranca
   {$IFDEF VER150}
      , Variants, MaskUtils, contnrs, DateUtils
   {$ELSEIF VER140}
      , Variants, MaskUtils, contnrs, DateUtils
   {$ELSE}
      {$IFDEF VER130}
         , Mask, contnrs
      {$ELSE}
         , Mask
      {$ENDIF}
   {$IFEND}
   ;

const
   CodigoBanco = '748';
   NomeBanco = 'BANSICREDI';

type

   TgbBanco748 = class(TPersistent)
   private
{$IFNDEF VER120}
      function VerificaOcorrenciaOriginal(sOcorrenciaOriginal: String): String;
      function VerificaMotivoRejeicaoComando(sMotivoRejeicaoComando: String): String;
      function GerarRemessaCNAB240(var ACobranca: TgbCobranca; var Remessa: TStringList) : boolean;
      function GerarRemessaCNAB400(var ACobranca: TgbCobranca; var Remessa: TStringList) : boolean;
      function LerRetornoCNAB240(var ACobranca: TgbCobranca; Retorno: TStringList) : boolean;
      function LerRetornoCNAB400(var ACobranca: TgbCobranca; Retorno: TStringList) : boolean;
{$ENDIF}
   published
      function  GetNomeBanco   : string; {Retorna o nome do banco}
      function  GetCampoLivreCodigoBarra(ATitulo: TgbTitulo) : string; {Retorna o conte�do da parte vari�vel do c�digo de barras}
      function  CalcularDigitoNossoNumero(ATitulo: TgbTitulo) : string; {Calcula o d�gito do NossoNumero, conforme crit�rios definidos por cada banco}
      procedure FormatarBoleto(ATitulo: TgbTitulo; var AAgenciaCodigoCedente, ANossoNumero, ACarteira, AEspecieDocumento: string); {Define o formato como alguns valores ser�o apresentados no boleto }
{$IFNDEF VER120}
      function  LerRetorno(var ACobranca: TgbCobranca; Retorno: TStringList) : boolean; {L� o arquivo retorno recebido do banco}
      function  GerarRemessa(var ACobranca: TgbCobranca; var Remessa: TStringList) : boolean; {Gerar arquivo remessa para enviar ao banco}
{$ENDIF}

  end;


implementation

uses Funcoes, Menu;


function TgbBanco748.GetNomeBanco : string;
begin
   Result := NomeBanco;
end;

function TgbBanco748.CalcularDigitoNossoNumero(ATitulo: TgbTitulo) : string;
var
   NNAgencia,
   NNPosto,
   NNAnoAtual,
   NNCedente,
   NNByteNossoNumero,
   ACarteira,
   ANossoNumero,
   ADigitoNossoNumero, xxx : string;
begin
   Result := '0';

  { with ATitulo do
   begin
      ACarteira := Formatar(Carteira, 2, False, '0');
      ANossoNumero := Formatar(NNAgencia + NNPosto + NNCedente + NNAnoAtual + NNByteNossoNumero + NossoNumero, 20, False, '0');
      ADigitoNossoNumero := Modulo11(ANossoNumero, 9, True);
   end;
   if StrToInt(ADigitoNossoNumero) = 10 then
      ADigitoNossoNumero := 'X'
   else
      ADigitoNossoNumero := (ADigitoNossoNumero);}

   xxx    := NNPosto;
   Result := ADigitoNossoNumero;
end;

function TgbBanco748.GetCampoLivreCodigoBarra(ATitulo: TgbTitulo) : string;
var
   ACarteira,
   ANossoNumero,
   ACodigoAgencia,
   ADigitoNossoNumero,
   ACodigoCedente: string;
   nn, teste : string;
begin

   {
    A primeira parte do c�digo de barras ser� calculada automaticamente.
    Ela � composta por:
    C�digo do banco (3 posi��es)
    C�digo da moeda = 9 (1 posi��o)
    D�gito do c�digo de barras (1 posi��o) - Ser� calculado e inclu�do pelo componente
    Fator de vencimento (4 posi��es) - Obrigat�rio a partir de 03/07/2000
    Valor do documento (10 posi��es) - Sem v�rgula decimal e com ZEROS � esquerda

    A segunda parte do c�digo de barras � um campo livre, que varia de acordo
    com o banco. Esse campo livre ser� calculado por esta fun��o (que voc� dever�
    alterar de acordo com as informa��es fornecidas pelo banco).
   }

   {Segunda parte do c�digo de barras - Campo livre - Varia de acordo com o banco}

   with ATitulo do
   begin
      ANossoNumero       := Formatar(NossoNumero,9,false,'0');
      ADigitoNossoNumero := Formatar(DigitoNossoNumero,1,false,'0');
      ACodigoAgencia     := Formatar(Cedente.ContaBancaria.CodigoAgencia,4,false,'0');
      ACodigoCedente     := Formatar(Cedente.CodigoCedente,5,false,'0');
      ACarteira          := Formatar(Carteira,1);                               // Sicredi nao usa carteira, usamos para pegar 1=COM Registro 3=SEM
   end;

  //  Result := ANossoNumero + ACodigoAgencia + ACodigoCedente + ACarteira;
                                                  
   // de acordo com o manual Sicred (Momento Imoveis e Criativa)                // pb_retdev vem com o posto
   //        3=(1 CR), 3(SR) - 1 (carteira simples)                             // 1=Se tem valor no campo + 0 fixo

            // 1=COM REGISTRO 3=SEM REGISTRO
   //teste  := '31' + ANossoNumero + ACodigoAgencia + FrmMenu.pb_retdev + ACodigoCedente + '10';  // MOMENTO

   teste  := ACarteira + '1' + ANossoNumero + ACodigoAgencia + FrmMenu.pb_retdev + ACodigoCedente + '10';  

   Result := teste + FrmFuncoes.Modulo11(teste,9,false);  // tem q ser o false

end;

procedure TgbBanco748.FormatarBoleto(ATitulo: TgbTitulo; var AAgenciaCodigoCedente, ANossoNumero, ACarteira, AEspecieDocumento: string);
begin
   with ATitulo do
   begin                                                                                            //posto
      AAgenciaCodigoCedente := Formatar(Cedente.ContaBancaria.CodigoAgencia,4,false,'0') + '.' + FrmMenu.pb_retdev + '.' + Formatar(Cedente.CodigoCedente,5,false,'0');
      //ANossoNumero := Formatar(NossoNumero,9,false,'0');
      ANossoNumero := Copy(NossoNumero, 1, 2) + '/' + Copy(NossoNumero, 3, 6) + '-' + NossoNumero[9];
      ACarteira := Formatar(Carteira,2);
      AEspecieDocumento := '';
   end;

end;

{$IFNDEF VER120}


function TgbBanco748.GerarRemessaCNAB240(var ACobranca: TgbCobranca; var Remessa: TStringList) : boolean;
var
   ACedenteTipoInscricao, ASacadoTipoInscricao,
   Registro : string;
   NumeroRegistro, NumeroLote : integer;
begin
   NumeroRegistro := 0;
   NumeroLote := 1;
   Registro := '';
   Remessa.Clear;

   if ACobranca.Titulos.Count < 1 then
      Exception.Create('N�o h� t�tulos para gerar remessa');

   with ACobranca do
   begin

      if LayoutArquivo <> laCNAB240 then
        Raise Exception.Create('CNAB240 � o �nico layout dispon�vel para o banco ' + CodigoBanco + ' - ' + NomeBanco);

      { GERAR REGISTRO-HEADER DO ARQUIVO }

      case Titulos[NumeroRegistro].Cedente.TipoInscricao of
         tiPessoaFisica  : ACedenteTipoInscricao := '1';
         tiPessoaJuridica: ACedenteTipoInscricao := '2';
         tiOutro         : ACedenteTipoInscricao := '3';
      end;

      if Formatar(CodigoBanco,3,false,'0') <> Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.Banco.Codigo,3,false,'0') then
         Raise Exception.CreateFmt('O t�tulo (Nosso N�mero: %s) n�o pertence ao banco %s (%s)',[Titulos[NumeroRegistro].NossoNumero,CodigoBanco,NomeBanco]);

      Registro := Formatar(CodigoBanco,3,false,'0'); //1 a 3 -C�digo do banco
      Registro := Registro + '0000'; //4 a 7 -Lote de servi�o
      Registro := Registro + '0'; //8 -Tipo de registro - Registro header de arquivo
      Registro := Registro + Formatar('',9); //9 a 17 Uso exclusivo FEBRABAN/CNAB
      Registro := Registro + ACedenteTipoInscricao; //18 - Tipo de inscri��o do cedente
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.NumeroCPFCGC,14,false,'0'); //19 a 32 -N�mero de inscri��o do cedente
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.CodigoCedente,20,false,'0'); //33 a 52 - C�digo do conv�nio no banco
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.CodigoAgencia,5,false,'0'); //53 a 57 - C�digo da ag�ncia do cedente
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.DigitoAgencia,1,false,'0'); //58 - D�gito da ag�ncia do cedente
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.NumeroConta,12,false,'0'); //59 a 70 - N�mero da conta do cedente
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.DigitoConta,1,false,'0'); //71 - D�gito da conta do cedente
      Registro := Registro + ' ';//72 - D�gito verificador da ag�ncia / conta
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.Nome,30,true,' '); //73 a 102 - Nome do cedente
      Registro := Registro + Formatar('BANSICREDI',30,true,' '); //103 a 132 - Nome do banco
      Registro := Registro + Formatar('',10); //133 a 142 - Uso exclusivo FEBRABAN/CNAB
      Registro := Registro + '1'; //143 - C�digo de Remessa (1) / Retorno (2)
      Registro := Registro + FormatDateTime('ddmmyyyy',DataArquivo); //144 a 151 - Data do de gera��o do arquivo
      Registro := Registro + FormatDateTime('hhmmss',DataArquivo);  //152 a 157 - Hora de gera��o do arquivo
      Registro := Registro + Formatar(IntToStr(NumeroArquivo),6,false,'0'); //158 a 163 - N�mero seq�encial do arquivo
      Registro := Registro + '030'; //164 a 166 - N�mero da vers�o do layout do arquivo
      Registro := Registro + Formatar('',5,false,'0'); //167 a 171 - Densidade de grava��o do arquivo (BPI)
      Registro := Registro + Formatar('',20); // 172 a 191 - Uso reservado do banco
      Registro := Registro + Formatar('',20); // 192 a 211 - Uso reservado da empresa
      Registro := Registro + Formatar('',11); // 212 a 222 - 11 brancos
      Registro := Registro + 'CSP'; // 223 a 225 - 'CSP'
      Registro := Registro + Formatar('0',3); // 226 a 228 - Uso exclusivo de Vans
      Registro := Registro + Formatar('',2); // 229 a 230 - Tipo de servico
      Registro := Registro + Formatar('',10); //231 a 240 - titulo em carteira de cobranca
      Remessa.Add(Registro);
      Registro := '';

      //GERAR REGISTRO HEADER DO LOTE

      Registro := Formatar(CodigoBanco,3,false,'0'); //1 a 3 -C�digo do banco
      Registro := Registro + Formatar(IntToStr(NumeroLote),4,false,'0'); //4 a 7 - N�mero do lote de servi�o
      Registro := Registro + '1'; //8 - Tipo do registro - Registro header de lote
      Registro := Registro + 'R'; //9 - Tipo de opera��o: R (Remessa) ou T (Retorno)
      Registro := Registro + '01'; //10 a 11 - Tipo de servi�o: 01 (Cobran�a)
      Registro := Registro + '00'; //12 a 13 - Forma de lan�amento: preencher com ZEROS no caso de cobran�a
      Registro := Registro + '020'; //14 a 16 - N�mero da vers�o do layout do lote
      Registro := Registro + ' '; //17 - Uso exclusivo FEBRABAN/CNAB
      Registro := Registro + ACedenteTipoInscricao; //18 - Tipo de inscri��o do cedente
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.NumeroCPFCGC,15,false,'0'); //19 a 33 - N�mero de inscri��o do cedente
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.CodigoCedente,20,false,'0'); //34 a 53 - C�digo do conv�nio no banco
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.CodigoAgencia,5,false,'0'); //54 a 58 - C�digo da ag�ncia do cedente
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.DigitoAgencia,1,false,'0'); //59 - D�gito da ag�ncia do cedente
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.NumeroConta,12,false,'0'); //60 a 71 - N�mero da conta do cedente
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.DigitoConta,1,false,'0'); //72 - D�gito da conta do cedente
      Registro := Registro + ' '; //73 - D�gito verificador da ag�ncia / conta
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.Nome,30,true,' '); //74 a 103 - Nome do cedente
      Registro := Registro + Formatar('',40); //104 a 143 - Mensagem 1 para todos os boletos do lote
      Registro := Registro + Formatar('',40); //144 a 183 - Mensagem 2 para todos os boletos do lote
      Registro := Registro + Formatar(IntToStr(NumeroArquivo),8,false,'0'); //184 a 191 - N�mero do arquivo
      Registro := Registro + FormatDateTime('ddmmyyyy',DataArquivo); //192 a 199 - Data de gera��o do arquivo
      Registro := Registro + Formatar('0',8); //200 a 207 - Data do cr�dito - S� para arquivo retorno
      Registro := Registro + Formatar('',33); //208 a 240 - Uso exclusivo FEBRABAN/CNAB


      Remessa.Add(Registro);
      Registro := '';

      { GERAR TODOS OS REGISTROS DETALHE DA REMESSA }
       //*********************** SEGMENTO P ****************************
      while NumeroRegistro <= (Titulos.Count - 1) do
      begin

         if Formatar(CodigoBanco,3,false,'0') <> Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.Banco.Codigo,3,false,'0') then
            Raise Exception.CreateFmt('O t�tulo (Nosso N�mero: %s) n�o pertence ao banco %s (%s)',[Titulos[NumeroRegistro].NossoNumero,CodigoBanco,NomeBanco]);

         {SEGMENTO P}
         if Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.Banco.Codigo,3,false,'0') <> Formatar(CodigoBanco,3,false,'0') then
            Raise Exception.CreateFmt('Titulo n�o pertence ao banco %s - %s',[CodigoBanco,NomeBanco]);

         case Titulos[NumeroRegistro].Cedente.TipoInscricao of
            tiPessoaFisica  : ACedenteTipoInscricao := '1';
            tiPessoaJuridica: ACedenteTipoInscricao := '2';
            tiOutro         : ACedenteTipoInscricao := '9';
         end;

         Registro := Formatar(CodigoBanco,3,false,'0'); //1 a 3 - C�digo do banco
         Registro := Registro + Formatar(IntToStr(NumeroLote),4,false,'0'); //4 a 7 - N�mero do lote
         Registro := Registro + '3'; //8 - Tipo do registro: Registro detalhe
         Registro := Registro + Formatar(IntToStr(2*NumeroRegistro+1),5,false,'0'); //9 a 13 - N�mero seq�encial do registro no lote - Cada t�tulo tem 2 registros (P e Q)
         Registro := Registro + 'P'; //14 - C�digo do segmento do registro detalhe
         Registro := Registro + ' '; //15 - Uso exclusivo FEBRABAN/CNAB: Branco
         case Titulos[NumeroRegistro].TipoOcorrencia of //16 a 17 - C�digo de movimento
            toRemessaRegistrar                 : Registro := Registro + '01';
            toRemessaBaixar                    : Registro := Registro + '02';
            toRemessaConcederAbatimento        : Registro := Registro + '04';
            toRemessaCancelarAbatimento        : Registro := Registro + '05';
            toRemessaConcederDesconto          : Registro := Registro + '07';
            toRemessaCancelarDesconto          : Registro := Registro + '08';
            toRemessaAlterarVencimento         : Registro := Registro + '06';
            toRemessaProtestar                 : Registro := Registro + '09';
            toRemessaCancelarInstrucaoProtesto : Registro := Registro + '10';
            toRemessaDispensarJuros            : Registro := Registro + '31';
            toRemessaAlterarNomeEnderecoSacado : Registro := Registro + '31';
         else
            Raise Exception.CreateFmt('Ocorr�ncia inv�lida em remessa - Nosso n�mero: %s / Seu n�mero: %s',[Titulos[NumeroRegistro].NossoNumero,Titulos[NumeroRegistro].SeuNumero]);
         end; //case Titulos[NumeroRegistro].TipoOcorrencia
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.CodigoAgencia,5,false,'0'); //18 a 22 - Ag�ncia mantenedora da conta
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.DigitoAgencia,1,false,'0'); //23 -D�gito verificador da ag�ncia
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.NumeroConta,12,false,'0'); //24 a 35 - N�mero da conta corrente
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.DigitoConta,1,false,'0'); //36 - D�gito verificador da conta
         Registro := Registro + ' '; //37 - D�gito verificador da ag�ncia / conta
         Registro := Registro + Formatar(Titulos[NumeroRegistro].NossoNumero,20,True,'0'); //37 a 57 - Nosso n�mero - identifica��o do t�tulo no banco
         Registro := Registro + '1'; //58 - Cobran�a Simples
         Registro := Registro + '1'; //59 - Forma de cadastramento do t�tulo no banco: com cadastramento
         Registro := Registro + '1'; //60- Tipo de documento: Tradicional
         //*********** Emiss�o Boleto *****************************************
         case Titulos[NumeroRegistro].EmissaoBoleto of //61 a 62 - Quem emite e quem distribui o boleto?
            ebBancoEmite      : Registro := Registro + '1' + '1';
            ebClienteEmite    : Registro := Registro + '2' + '2';
            ebBancoReemite    : Registro := Registro + '4' + '1';
            ebBancoNaoReemite : Registro := Registro + '5' + '2';
         else
            Raise Exception.CreateFmt('Identifica��o inv�lida de emiss�o de boleto em remessa - Nosso n�mero: %s / Seu n�mero: %s',[Titulos[NumeroRegistro].NossoNumero,Titulos[NumeroRegistro].SeuNumero]);
         end; //case Titulos[NumeroRegistro].EmissaoBoleto
         //*********************************************************************

         Registro := Registro + Formatar(Titulos[NumeroRegistro].SeuNumero,15,false,'0'); //63 a 77 - N�mero que identifica o t�tulo na empresa
         Registro := Registro + FormatDateTime('ddmmyyyy',Titulos[NumeroRegistro].DataVencimento); //78 a 85 - Data de vencimento do t�tulo
         Registro := Registro + FormatCurr('000000000000000',Titulos[NumeroRegistro].ValorDocumento * 100); //86 a 100 - Valor nominal do t�tulo
         Registro := Registro + Formatar('',5,false,'0'); //101 a 105 - Ag�ncia cobradora. Se ficar em branco, a caixa determina automaticamente pelo CEP do sacado
         Registro := Registro + ' '; //106 - D�gito da ag�ncia cobradora

         //*************** Especie do documento  *******************************
         case Titulos[NumeroRegistro].EspecieDocumento of {//107 a 108 - Esp�cie do documento
            edApoliceSeguro                : Registro := Registro + '20'; {AP  AP�LICE DE SEGURO}
            edCheque                       : Registro := Registro + '01'; {CH  CHEQUE}
            edDuplicataMercantil           : Registro := Registro + '02'; {DM  DUPLICATA MERCANTIL}
            edDuplicataMercantialIndicacao : Registro := Registro + '03'; {DMI DUPLICATA MERCANTIL P/ INDICA��O}
            edDuplicataRural               : Registro := Registro + '06'; {DR  DUPLICATA RURAL}
            edDuplicataServico             : Registro := Registro + '04'; {DS  DUPLICATA DE SERVI�O}
            edDuplicataServicoIndicacao    : Registro := Registro + '05'; {DSI DUPLICATA DE SERVI�O P/ INDICA��O}
            edFatura                       : Registro := Registro + '18'; {FAT FATURA}
            edLetraCambio                  : Registro := Registro + '07'; {LC  LETRA DE C�MBIO}
            edMensalidadeEscolar           : Registro := Registro + '21'; {ME  MENSALIDADE ESCOLAR}
            edNotaCreditoComercial         : Registro := Registro + '08'; {NCC NOTA DE CR�DITO COMERCIAL}
            edNotaCreditoExportacao        : Registro := Registro + '09'; {NCE NOTA DE CR�DITO A EXPORTA��O}
            edNotaCreditoIndustrial        : Registro := Registro + '10'; {NCI NOTA DE CR�DITO INDUSTRIAL}
            edNotaCreditoRural             : Registro := Registro + '11'; {NCR NOTA DE CR�DITO RURAL}
            edNotaDebito                   : Registro := Registro + '19'; {ND  NOTA DE D�BITO}
            edNotaPromissoria              : Registro := Registro + '12'; {NP  NOTA PROMISS�RIA}
            edNotaPromissoriaRural         : Registro := Registro + '13'; {NPR NOTA PROMISS�RIA RURAL}
            edNotaSeguro                   : Registro := Registro + '16'; {NS  NOTA DE SEGURO}
            edParcelaConsorcio             : Registro := Registro + '22'; {PC  PARCELA DE CONSORCIO}
            edRecibo                       : Registro := Registro + '17'; {RC  RECIBO}
            edTriplicataMercantil          : Registro := Registro + '14'; {TM  TRIPLICATA MERCANTIL}
            edTriplicataServico            : Registro := Registro + '15' {TS  TRIPLICATA DE SERVI�O}
         else
            Registro := Registro + '99'; {OUTROS}
         end; //case Titulos[NumeroRegistro].EspecieDocumento
         //*********************************************************************

         //**************Aceite Documento **************************************
         case Titulos[NumeroRegistro].AceiteDocumento of //109 - Identifica��o de t�tulo Aceito / N�o aceito
            adSim : Registro := Registro + 'A';
            adNao : Registro := Registro + 'N';
         end; //case Titulos[NumeroRegistro].AceiteDocumento
         //*********************************************************************

         Registro := Registro + FormatDateTime('ddmmyyyy',Titulos[NumeroRegistro].DataDocumento); //110 a 117 - Data da emiss�o do documento

         //*************************  Mora Juros  ******************************
         if Titulos[NumeroRegistro].ValorMoraJuros > 0 then
         begin
            Registro := Registro + '1'; //118 - C�digo de juros de mora: Valor por dia
            if Titulos[NumeroRegistro].DataMoraJuros <> NULL then
               Registro := Registro + FormatDateTime('ddmmyyyy',Titulos[NumeroRegistro].DataMoraJuros) //119 a 126 - Data a partir da qual ser�o cobrados juros
            else
               Registro := Registro + Formatar('',8,false,'0'); //119 a 126 - Data a partir da qual ser�o cobrados juros
            Registro := Registro + FormatCurr('000000000000000',Titulos[NumeroRegistro].ValorMoraJuros * 100); //127 a 141 - Valor de juros de mora por dia
         end
         else
         begin
            Registro := Registro + '0'; //118 - C�digo de juros de mora  (n�o h� juros)
            Registro := Registro + Formatar('',8,false,'0'); //119 a 126 - Data a partir da qual ser�o cobrados juros
            Registro := Registro + Formatar('',15,false,'0');//127 a 141 - Valor de juros de mora por dia
         end;
         //*******************  Descontos  *********************
         if Titulos[NumeroRegistro].ValorDesconto > 0 then
         begin
            Registro := Registro + '1'; //142 - C�digo de desconto: Valor fixo at� a data informada
            if Titulos[NumeroRegistro].DataDesconto <> NULL then
               Registro := Registro + FormatDateTime('ddmmyyyy',Titulos[NumeroRegistro].DataDesconto) //143 a 150 - Data do desconto
            else
               Registro := Registro + Formatar('',8,false,'0'); //143 a 150 - Data at� a qual ser� concedido desconto
            Registro := Registro + FormatCurr('000000000000000',Titulos[NumeroRegistro].ValorDesconto * 100); //151 a 165 - Valor do desconto por dia
         end
         else
         begin
            Registro := Registro + '0'; //142 - C�digo de desconto: Sem desconto
            Registro := Registro + Formatar('',8,false,'0'); //143 a 150 - Data at� a qual ser� concedido desconto
            Registro := Registro + Formatar('',15,false,'0'); //151 a 165 - Valor do desconto por dia
         end;
         //*********************************************************************
         Registro := Registro + FormatCurr('000000000000000',Titulos[NumeroRegistro].ValorIOF * 100); //166 a 180 - Valor do IOF a ser recolhido
         Registro := Registro + FormatCurr('000000000000000',Titulos[NumeroRegistro].ValorAbatimento * 100); //181 a 195 - Valor do abatimento
         Registro := Registro + Formatar(Titulos[NumeroRegistro].SeuNumero,25); //196 a 220 - Identifica��o do t�tulo na empresa
         //**********************  Protesto  ***********************************
         if (Titulos[NumeroRegistro].DataProtesto <> null) and (Titulos[NumeroRegistro].DataProtesto > Titulos[NumeroRegistro].DataVencimento) then
         begin
            Registro := Registro + '1'; //221 - C�digo de protesto: Protestar em XX dias corridos
            Registro := Registro + Formatar(IntToStr(DaysBetween(Titulos[NumeroRegistro].DataProtesto, Titulos[NumeroRegistro].DataVencimento)),2,false,'0'); //221 - Prazo para protesto (em dias corridos)
         end
         else
         begin
            Registro := Registro + '3'; //221 - C�digo de protesto: N�o protestar
            Registro := Registro + Formatar('',2,false,'0'); //222 a 223 - Prazo para protesto (em dias corridos)
         end;
         //**********************  Codigo p/ Baixa/Devolucao  ******************
         if (Titulos[NumeroRegistro].DataBaixa <> null) and (Titulos[NumeroRegistro].DataBaixa > Titulos[NumeroRegistro].DataVencimento) then
         begin
            Registro := Registro + '1'; //224 - C�digo para baixa/devolu��o: Baixar/devolver}
            Registro := Registro + Formatar(IntToStr(DaysBetween(Titulos[NumeroRegistro].DataBaixa,Titulos[NumeroRegistro].DataVencimento)),3,false,'0'); //225 a 227 - Prazo para baixa/devolu��o (em dias corridos)
         end
         else
         begin
            Registro := Registro + '2'; //224 - C�digo para baixa/devolu��o: N�o baixar/n�o devolver
            Registro := Registro + Formatar('',3,false,'0'); //225 a 227 - Prazo para baixa/devolu��o (em dias corridos)
         end;
          //********************************************************************
         Registro := Registro + '09'; //228 a 229 - C�digo da moeda: Real
         Registro := Registro + Formatar('',10); //230 a 239 - Uso exclusivo FEBRABAN/CNAB
         Registro := Registro + Formatar('',1); //240 - Uso exclusivo FEBRABAN/CNAB

         Remessa.Add(Registro);
         Registro := '';

         {SEGMENTO Q}
         case Titulos[NumeroRegistro].Sacado.TipoInscricao of
            tiPessoaFisica  : ASacadoTipoInscricao := '1';
            tiPessoaJuridica: ASacadoTipoInscricao := '2';
            tiOutro         : ASacadoTipoInscricao := '9';
         end;

         Registro := Formatar(CodigoBanco,3,false,'0'); {C�digo do banco}
         Registro := Registro + Formatar(IntToStr(NumeroLote),4,false,'0'); {N�mero do lote}
         Registro := Registro + '3'; {Tipo do registro: Registro detalhe}
         Registro := Registro + Formatar(IntToStr(2*NumeroRegistro+2),5,false,'0'); {N�mero seq�encial do registro no lote - Cada t�tulo tem 2 registros (P e Q)}
         Registro := Registro + 'Q'; {C�digo do segmento do registro detalhe}
         Registro := Registro + ' '; {Uso exclusivo FEBRABAN/CNAB: Branco}
         case Titulos[NumeroRegistro].TipoOcorrencia of {C�digo de movimento}
            toRemessaRegistrar                 : Registro := Registro + '01';
            toRemessaBaixar                    : Registro := Registro + '02';
            toRemessaConcederAbatimento        : Registro := Registro + '04';
            toRemessaCancelarAbatimento        : Registro := Registro + '05';
            toRemessaConcederDesconto          : Registro := Registro + '07';
            toRemessaCancelarDesconto          : Registro := Registro + '08';
            toRemessaAlterarVencimento         : Registro := Registro + '06';
            toRemessaProtestar                 : Registro := Registro + '09';
            toRemessaCancelarInstrucaoProtesto : Registro := Registro + '10';
            toRemessaDispensarJuros            : Registro := Registro + '31';
            toRemessaAlterarNomeEnderecoSacado : Registro := Registro + '31';
         else
            Raise Exception.CreateFmt('Ocorr�ncia inv�lida em remessa - Nosso n�mero: %s / Seu n�mero: %s',[Titulos[NumeroRegistro].NossoNumero,Titulos[NumeroRegistro].SeuNumero]);
         end; {case Titulos[NumeroRegistro].TipoOcorrencia}
         {Dados do sacado}
         Registro := Registro + Formatar(ASacadoTipoInscricao,1,false,'0');
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.NumeroCPFCGC,15,false,'0');
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.Nome,40);
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.Endereco.Rua+' '+Titulos[NumeroRegistro].Sacado.Endereco.Numero+' '+Titulos[NumeroRegistro].Sacado.Endereco.Complemento,40);
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.Endereco.Bairro,15);
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.Endereco.CEP,8,true,'0');
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.Endereco.Cidade,15,true);
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.Endereco.Estado,2,false);
         {Dados do sacador/avalista}
         Registro := Registro + '0'; {Tipo de inscri��o: N�o informado}
         Registro := Registro + Formatar('',15,false,'0'); {N�mero de inscri��o}
         Registro := Registro + Formatar('',40); {Nome do sacador/avalista}

         Registro := Registro + Formatar('',3); {Uso exclusivo FEBRABAN/CNAB}
         Registro := Registro + Formatar('',20); {Uso exclusivo FEBRABAN/CNAB}
         Registro := Registro + Formatar('',8); {Uso exclusivo FEBRABAN/CNAB}

         Remessa.Add(Registro);
         NumeroRegistro := NumeroRegistro + 1;
      end; {GERAR TODOS OS REGISTROS DETALHE DA REMESSA}

      {REGISTRO TRAILER DO LOTE}
      Registro := Formatar(CodigoBanco,3,false,'0'); {C�digo do banco}
      Registro := Registro + Formatar(IntToStr(NumeroLote),4,false,'0'); {N�mero do lote}
      Registro := Registro + '5'; {Tipo do registro: Registro trailer do lote}
      Registro := Registro + Formatar('',9); {Uso exclusivo FEBRABAN/CNAB}
      {Quantidade de registros do lote, incluindo header e trailer do lote.
       At� este momento Remessa cont�m:
       1 registro header de arquivo - � preciso exclu�-lo desta contagem
       1 registro header de lote
       Diversos registros detalhe
       Falta incluir 1 registro trailer de lote
       Ou seja Quantidade = Remessa.Count - 1 header de arquivo + 1 trailer de lote = Remessa.Count}
      Registro := Registro + Formatar(IntToStr(Remessa.Count),6,false,'0');
      {Totaliza��o da cobran�a simples - S� � usado no arquivo retorno}
      Registro := Registro + Formatar('',6,false,'0'); {Quantidade t�tulos em cobran�a}
      Registro := Registro + Formatar('',17,false,'0'); {Valor dos t�tulos em carteiras}
      {Uso exclusivo FEBRABAN/CNAB}
      Registro := Registro + Formatar('',23); {Uso exclusivo FEBRABAN/CNAB}
      {Totaliza��o da cobran�a caucionada - S� � usado no arquivo retorno}
      Registro := Registro + Formatar('',6,false,'0'); {Quantidade t�tulos em cobran�a}
      Registro := Registro + Formatar('',17,false,'0'); {Valor dos t�tulos em carteiras}
      {Uso exclusivo FEBRABAN/CNAB}
      Registro := Registro + Formatar('',31); {Uso exclusivo FEBRABAN/CNAB}
      Registro := Registro + Formatar('',117); {Uso exclusivo FEBRABAN/CNAB}

      Remessa.Add(Registro);
      Registro := '';

      {GERAR REGISTRO TRAILER DO ARQUIVO}
      Registro := Formatar(CodigoBanco,3,false,'0'); {C�digo do banco}
      Registro := Registro + '9999'; {Lote de servi�o}
      Registro := Registro + '9'; {Tipo do registro: Registro trailer do arquivo}
      Registro := Registro + Formatar('',9); {Uso exclusivo FEBRABAN/CNAB}
      Registro := Registro + Formatar(IntToStr(NumeroLote),6,false,'0'); {Quantidade de lotes do arquivo}
      Registro := Registro + Formatar(IntToStr(Remessa.Count + 1),6,false,'0'); {Quantidade de registros do arquivo, inclusive este registro que est� sendo criado agora}
      Registro := Registro + Formatar('',6); {Uso exclusivo FEBRABAN/CNAB}
      Registro := Registro + Formatar('',205); {Uso exclusivo FEBRABAN/CNAB}

      Remessa.Add(Registro);
   end;

   Result := TRUE;
end;

function TgbBanco748.GerarRemessaCNAB400(var ACobranca: TgbCobranca; var Remessa: TStringList) : boolean;
var
   ACedenteTipoInscricao, ASacadoTipoInscricao, aTitulosTipoOcorrencia,
   aTitulosEspecieDocumento,aTitulosAceite, Registro, Instrucoes, MesRegistro, CodigoCedente, NossoNumero: string;
   aTipoMoeda, aTipoDesconto, aTipoJuros, aPostagem: String;
   NumeroRegistro, Linha : integer;
begin
   NumeroRegistro := 0;
   Linha := 1;
   Remessa.Clear;

   with ACobranca do
   begin

      { GERAR REGISTRO-HEADER DA REMESSA }
      CodigoCedente := Formatar(Titulos[NumeroRegistro].Cedente.CodigoCedente, 5, True, ' '); // IDENT.DO CEDENTE NO BANCO
      Remessa.Add('0'+ // IDENT.DO REGISTRO
                  '1'+ // IDENT.DO ARQUIVO DE REMESSA
                  'REMESSA'+ // IDENT. POR EXTENSO REMESSA
                  '01'+ // IDENT. DO TIPO DE SERVI�O
                  Formatar('COBRANCA',15)+ // IDENT.POR EXTENSO TIPO SERVI�O
                  Formatar(Titulos[NumeroRegistro].Cedente.CodigoCedente, 5, True, ' ')+ // IDENT.DO CEDENTE NO BANCO
                  Formatar(Titulos[NumeroRegistro].Cedente.NumeroCPFCGC, 14, False, '0') + // CNPJ_CPF CEDENTE
                  Formatar('', 31)+ // USO DO BANCO
                  Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.Banco.Codigo, 3, False, '0')+ // NUMERO DO BANCO DA COMPENSA��O
                  Formatar('BANSICREDI', 15, True, ' ')+ // NOME DO BANCO POR EXTENSO
                  FormatDateTime('yyyymmdd',Titulos[NumeroRegistro].DataProcessamento)+ // DATA DA GRAVA��O DO ARQUIVO
                  Formatar('', 8)+ // USO DO BANCO
                  Formatar(IntToStr(NumeroArquivo), 7, False, '0')+ //NUMERO DE GERACAO DO ARQUIVO
                  Formatar('', 273)+ // USO DO BANCO
                  Formatar('2.00', 4)+ // USO DO BANCO
                  Formatar(IntToStr(Linha), 6, False, '0')); // NUMERO SEQUENCIAL REGISTRO

                  //Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.CodigoAgencia,4,false,' ')+ //AG ONDE O CLIENTE MANT�M C/C
                  //Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.DigitoAgencia,1,false,' ')+ //DIGITO AG
                  //Formatar(Titulos[NumeroRegistro].Cedente.Nome,30,true,' ')+ // NOME DA EMPRESA POR EXTENSO
                  //Formatar('',3)+ // USO DO BANCO


      { GERAR TODOS OS REGISTROS DETALHE DA REMESSA}
      while NumeroRegistro <= (Titulos.Count - 1) do
      begin
         if Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.Banco.Codigo,3,false,'0') <> Formatar(CodigoBanco,3,false,'0') then
            Raise Exception.CreateFmt('Titulo n�o pertence ao banco %s - %s',[CodigoBanco,NomeBanco]);
         case Titulos[NumeroRegistro].Cedente.TipoInscricao of
            tiPessoaFisica  : ACedenteTipoInscricao := '01';
            tiPessoaJuridica: ACedenteTipoInscricao := '02';
            tiOutro         : ACedenteTipoInscricao := '03';
         end;
         case Titulos[NumeroRegistro].Sacado.TipoInscricao of
            tiPessoaFisica  : ASacadoTipoInscricao := '1';
            tiPessoaJuridica: ASacadoTipoInscricao := '2';
            tiOutro         : ASacadoTipoInscricao := '3';
         end;

         case Titulos[NumeroRegistro].TipoOcorrencia of
            toRemessaRegistrar                 : ATitulosTipoOcorrencia := '01';
            toRemessaBaixar                    : ATitulosTipoOcorrencia := '02';
            toRemessaDebitarEmConta            : ATitulosTipoOcorrencia := '03';
            toRemessaConcederAbatimento        : ATitulosTipoOcorrencia := '04';
            toRemessaCancelarAbatimento        : ATitulosTipoOcorrencia := '05';
            toRemessaAlterarVencimento         : ATitulosTipoOcorrencia := '06';
            toRemessaAlterarNumeroControle     : ATitulosTipoOcorrencia := '07';
            //toRemessaAlterarSeuNumero          : ATitulosTipoOcorrencia := '08';
            toRemessaProtestar                 : ATitulosTipoOcorrencia := '09';
            toRemessaCancelarInstrucaoProtesto : ATitulosTipoOcorrencia := '10';
            toRemessaDispensarJuros            : ATitulosTipoOcorrencia := '11';
            toRemessaAlterarNomeEnderecoSacado : ATitulosTipoOcorrencia := '12';
         end;

         case Titulos[NumeroRegistro].EspecieDocumento of
              edDuplicataMercantil   : aTitulosEspecieDocumento := 'A';
              edNotaPromissoria      : aTitulosEspecieDocumento := 'C';
              edNotaSeguro           : aTitulosEspecieDocumento := 'E';
              edRecibo               : aTitulosEspecieDocumento := 'G';
              edLetraCambio          : aTitulosEspecieDocumento := 'H';
              edWarrant              : aTitulosEspecieDocumento := '09';
              edCheque               : aTitulosEspecieDocumento := '10';
              edDuplicataServico     : aTitulosEspecieDocumento := 'J';
              edNotaDebito           : aTitulosEspecieDocumento := 'I';
              edApoliceSeguro        : aTitulosEspecieDocumento := '15';
              edDividaAtivaUniao     : aTitulosEspecieDocumento := '25';
              edDividaAtivaEstado    : aTitulosEspecieDocumento := '26';
              edDividaAtivaMunicipio : aTitulosEspecieDocumento := '27';
              edOutros               : aTitulosEspecieDocumento := 'K';
        end;

        case Titulos[NumeroRegistro].AceiteDocumento of
             adNao: aTitulosAceite := 'N';
             adSim: aTitulosAceite := 'A';
        end;
{
        case Titulos[NumeroRegistro].TipoMoeda of
             tiReal  : aTipoMoeda := 'A';
             tiDolar : aTipoMoeda := 'B';
             tiOutra : aTipoMoeda := 'C';
        end;

        case Titulos[NumeroRegistro].TipoDesconto of
             tiValorDes      : aTipoDesconto := 'A';
             tiPercentualDes : aTipoDesconto := 'B';
        end;

        case Titulos[NumeroRegistro].TipoJuros of
             tiValorJuros      : aTipoJuros := 'A';
             tiPercentualJuros : aTipoJuros := 'B';
        end;

        case Titulos[NumeroRegistro].Postagem of
             pgSim  : aPostagem := 'S';
             pgNao  : aPostagem := 'N';
        end;
}
         Registro := '1'; //  IDENT. DO REGISTRO
         Registro := Registro + 'C'; // TIPO DE COBRAN�A - SEM REGISTRO
         Registro := Registro + Formatar('', 14); // ESPA�OS EM BRANCO
         Registro := Registro + Formatar(aTipoMoeda, 1, True, '0'); // TIPO DE MOEDA - REAL
         Registro := Registro + Formatar(aTipoDesconto, 1, True, '0'); // TIPO DE DESCONT - PERCENTUAL
         Registro := Registro + Formatar(aTipoJuros, 1, True, '0'); // TIPO DE JUROS - PERCENTUAL
         Registro := Registro + Formatar('', 28); // ESPA�OS EM BRANCO
         // Adtapta��o
         NossoNumero := Formatar(Titulos[NumeroRegistro].NossoNumero, 9, True, '0'); // IDENT. DO TITULO NO BANCO COM DIG VERIFICADOR
{
         Instrucoes := Formatar(Titulos[NumeroRegistro].InstLinha1, 80, True, ' ');
         Instrucoes := Instrucoes + Formatar(Titulos[NumeroRegistro].InstLinha2, 80, True, ' ');
         Instrucoes := Instrucoes + Formatar(Titulos[NumeroRegistro].InstLinha3, 80, True, ' ');
         Instrucoes := Instrucoes + Formatar(Titulos[NumeroRegistro].InstLinha4, 80, True, ' ');
}
         // do SICREDI
         Registro := Registro + Formatar(Titulos[NumeroRegistro].NossoNumero, 9, True, '0'); // IDENT. DO TITULO NO BANCO COM DIG VERIFICADOR
         Registro := Registro + Formatar('', 1); // ESPA�OS EM BRANCO
         Registro := Registro + 'B'; // TIPO DE IMPRESS�O - COMPLETA
         Registro := Registro + Formatar('', 13); // ESPA�OS EM BRANCO
         Registro := Registro + Formatar(aPostagem, 1, True, '0'); // POSTAGEM - SIM
         Registro := Registro + Formatar('', 2); // ESPA�OS EM BRANCO
         Registro := Registro + '00'; // NUMERO DA PARCELA NO CARN�
         Registro := Registro + '00'; // N�MERO DE PARCELAS NO CARN�
         Registro := Registro + Formatar('', 4); // ESPA�OS EM BRANCO
//         Registro := Registro + FormatCurr('0000000000', Titulos[NumeroRegistro].DescPorDiaAntecipa * 100); // DESCONTO POR DIA DE ANTECIPA��O
//         Registro := Registro + formatCurr('0000', Titulos[NumeroRegistro].MultaPagAtraso * 100); // MULTA POR PAGAMENTO EM ATRASO
         Registro := Registro + Formatar('', 12); // ESPA�OS EM BRANCO
         Registro := Registro + Formatar(ATitulosTipoOcorrencia, 2, True, '0'); // INSTRU��O
         Registro := Registro + Formatar(Titulos[NumeroRegistro].SeuNumero, 10, False, '0'); // SEU N�MERO DIFERENTE DE BRANCO
         Registro := Registro + FormatDateTime('ddmmyy',Titulos[NumeroRegistro].DataVencimento); // DATA DE VENCIMENTO DO TITULO
         Registro := Registro + FormatCurr('0000000000000', Titulos[NumeroRegistro].ValorDocumento * 100); // VALOR NOMINAL DO TITULO
         Registro := Registro + Formatar('', 9); // ESPA�OS EM BRANCO
         Registro := Registro + Formatar(aTitulosEspecieDocumento, 1, False, '0'); // ESP�CIE DO TITULO
         Registro := Registro + Formatar('', 1); // ESPA�OS EM BRANCO
         Registro := Registro + FormatDateTime('ddmmyy', Titulos[NumeroRegistro].DataDocumento); // DATA DE EMISSAO DO TITULO
         Registro := Registro + Formatar('', 4); // ESPA�OS EM BRANCO
         Registro := Registro + FormatCurr('0000000000000', Titulos[NumeroRegistro].ValorMoraJuros * 100); // VALOR DE JUROS A SER COBRADO POR DIA DE ATRASO
         if Titulos[NumeroRegistro].DataDesconto=0 then begin
            Registro := Registro + Formatar('0', 6, False, '0'); // DATA LIMITE P/ CONCESS�O DESC.
         end else begin
            Registro := Registro + FormatDateTime('ddmmyy', Titulos[NumeroRegistro].DataDesconto); // DATA LIMITE P/ CONCESS�O DESC.
         end;
         Registro := Registro + FormatCurr('0000000000000', Titulos[NumeroRegistro].ValorDesconto * 100); // VALOR DESCONTO A SER CONCEDIDO
         Registro := Registro + Formatar('', 26); // ESPA�OS EM BRANCO
         Registro := Registro + Formatar(ASacadoTipoInscricao, 1, False, '0'); // IDENT. TIPO INSCRI��O DO SACADO
         Registro := Registro + Formatar('', 1); // ESPA�OS EM BRANCO
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.NumeroCPFCGC, 14, False, '0'); // CGC/CPF DO SACADO
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.Nome, 40, True, ' '); // NOME DO SACADO
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.Endereco.Rua+
                                ' '+Titulos[NumeroRegistro].Sacado.Endereco.Numero+
                                ' '+Titulos[NumeroRegistro].Sacado.Endereco.Complemento, 40); // ENDERE�O DO SACADO
//         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.CodSacAgCed, 5, True, '0'); // C�DIGO DO SACADO NA AG�NCIA CEDENTE
//         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.CodPraca, 6, True, '0'); // C�DIGO DA PRA�A DO SACADO
         Registro := Registro + Formatar('', 1); // ESPA�OS EM BRANCO
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.Endereco.CEP, 8, True, '0'); // CEP DO SACADO
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.Endereco.Cidade, 25, True, ' '); // CIDADE DO SACADO
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.Endereco.Estado, 2, False); // ENDERE�O DO SACADO
//         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.CodSacCli, 5, True, '0'); //C�IDO DO SACADO JUNTO AO CLIENTE
         Registro := Registro + Formatar('', 28); // ESPA�OS EM BRANCO
         {
         Registro := Registro + Formatar(ACedenteTipoInscricao,2,false,'0'); // IDENT.TIPO INSCR.EMPRESA
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.NumeroCPFCGC,14,false,'0'); // NUMERO DO CGC DA EMPRESA
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.CodigoAgencia,4,false,'0'); // AGENCIA ONDE O CLIENTE MANTEM C/C
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.DigitoAgencia,1,false,'0'); // DIGITO DA AGENCIA
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.CodigoCedente,15,true,' '); // IDENT.DO CEDENTE NO BANCO
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.DigitoCodigoCedente,25,true,' '); // IDENT.DO CEDENTE NO BANCO
         Registro := Registro + '    '; // BRANCOS
         Registro := Registro + 'AI '; // PREFIXO DO TITULO
         Registro := Registro + '019'; // VARIA��O DA CARTEIRA
         Registro := Registro + '0'; // CONTA CAUCAO
         Registro := Registro + '00000'; // CODIGO DE RESPONSABILIDADE
         Registro := Registro + '0'; // DIGITO VERIFICADOR DO COD.RESPONSABILIDADE
         Registro := Registro + '000000'; // NUMERO DO BORDERO
         Registro := Registro + '     '; // BRANCOS
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Carteira,2); // CODIGO DA CARTEIRA
         Registro := Registro + Formatar(aTitulosTipoOcorrencia,2,false,'0'); // IDENT. DA TRANSACAO(OCORRENCIA)
         Registro := Registro + Formatar(Titulos[NumeroRegistro].NumeroDocumento,10); // NUMERO DA DUPLICATA, ETC...
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.Banco.Codigo,3,false,'0'); // BANCO ENCARREGADO DA COBRAN�A
         Registro := Registro + '0000'; // PREFIXO DA AGENCIA COBRADORA
         Registro := Registro + '0'; // DIGITO DA AGENCIA COBRADORA
         Registro := Registro + Formatar(aTitulosAceite,1); // IDENT. DE ACEITE DO TITULO
         Registro := Registro + '00';
         Registro := Registro + '00';
         Registro := Registro + FormatCurr('0000000000000',Titulos[NumeroRegistro].ValorIOF * 100); // VALOR DE IOF
         Registro := Registro + FormatCurr('0000000000000',Titulos[NumeroRegistro].ValorAbatimento * 100); // VALOR DO ABATIMENTO
         Registro := Registro + Formatar('',3); // USO DO BANCO
         Registro := Registro + Formatar('',15); // USO DO BANCO
         Registro := Registro + Formatar('',40,true,' ');
         Registro := Registro + '  '; // DIAS PARA PROTESTO
         Registro := Registro + ' '; // BRANCOS
         }
         Linha := Linha + 1;
         NumeroRegistro := NumeroRegistro + 1;
         Registro := Registro + Formatar(IntToStr(Linha), 6, False, '0'); // NUMERO SEQUENCIAL DO REGISTRO
         Remessa.Add(Registro);
         //         NumeroRegistro := NumeroRegistro + 1;
         Linha := Linha + 1;
         MesRegistro := '2';
         MesRegistro := MesRegistro + Formatar('', 11);
         MesRegistro := MesRegistro + NossoNumero;
         MesRegistro := MesRegistro + Instrucoes;
         MesRegistro := MesRegistro + Formatar('', 53);
         MesRegistro := MesRegistro + Formatar(IntToStr(Linha), 6, False, '0'); // NUMERO SEQUENCIAL DO REGISTRO
         Remessa.Add(MesRegistro);
         //         NumeroRegistro := NumeroRegistro + 1;

      end;
      { GERAR REGISTRO TRAILER DA REMESSA }
      Linha := Linha + 1;
      Remessa.Add('9'+'1'+'748'+ // IDENT. DO REGISTRO
                  Formatar(CodigoCedente, 5, True, '0') + // C�DIGO DO CEDENTE.
                  Formatar(' ', 384, False, ' ')+ // USO DO BANCO
                  Formatar(IntToStr(Linha),6,false,'0')); // QUANTIDADE TOTAL DE REGISTROS
   end;

   Result := TRUE;
end;


function  TgbBanco748.GerarRemessa(var ACobranca: TgbCobranca; var Remessa: TStringList) : boolean;
begin
  Result := false;
   case ACobranca.LayoutArquivo of
      laCNAB240 : Result := GerarRemessaCNAB240(ACobranca, Remessa);
      laCNAB400 : Result := GerarRemessaCNAB400(ACobranca, Remessa);
   end;
end;

function TgbBanco748.LerRetornoCNAB240(var ACobranca: TgbCobranca; Retorno: TStringList) : boolean;
var
   ACodigoBanco,
   ANomeCedente,
   ATipoInscricao,
   ANumeroCPFCGC,
   ACodigoCedente,
   ACodigoAgencia,
   ADigitoCodigoAgencia,
   ANumeroConta,
   ADigitoNumeroConta,
   ATipoOcorrencia : string;
   NumeroRegistro : integer;
   ATitulo : TgbTitulo;
begin
   NumeroRegistro := 0;
   ATitulo := TgbTitulo.Create(nil);

   TRY

      with ACobranca do
      begin
         Titulos.Clear; {Zera o conjunto de t�tulos, antes de incluir os t�tulos do arquivo retorno}

         if Retorno.Count <= 0 then
            Raise Exception.Create('O retorno est� vazio. N�o h� dados para processar');

         if length(Retorno[0]) <> 240 then
         begin
            LayoutArquivo := laOutro;
            Raise Exception.CreateFmt('Tamanho de registro diferente de 240 bytes. Tamanho = %d bytes',[length(Retorno[0])]);
         end;

         LayoutArquivo := laCNAB240;

         {Ver se o arquivo � mesmo RETORNO DE COBRAN�A}
         if Copy(Retorno.Strings[NumeroRegistro],143,1) <> '2' then
            Raise Exception.Create(NomeArquivo+' n�o � um arquivo de retorno de cobran�a com layout CNAB240');

         { L� registro HEADER}
         ACodigoBanco := Copy(Retorno.Strings[NumeroRegistro],1,3);
         if ACodigoBanco <> CodigoBanco then
            Raise Exception.CreateFmt('Este n�o � um retorno de cobran�a do banco %s - %s',[CodigoBanco,NomeBanco]);

         if Copy(Retorno.Strings[NumeroRegistro],8,1) <> '0' then
            Raise Exception.Create('Este n�o � um registro HEADER v�lido para arquivo de retorno de cobran�a com layout CNAB240');

         {Dados do cedente do t�tulo}
         ATipoInscricao := Copy(Retorno.Strings[NumeroRegistro],18,1);
         ANumeroCPFCGC := Copy(Retorno.Strings[NumeroRegistro],19,14);
         ACodigoCedente := Copy(Retorno.Strings[NumeroRegistro],33,16);
         ACodigoAgencia := Copy(Retorno.Strings[NumeroRegistro],53,5);
         ADigitoCodigoAgencia := Copy(Retorno.Strings[NumeroRegistro],58,1);
         ANumeroConta := Copy(Retorno.Strings[NumeroRegistro],59,12);
         ADigitoNumeroConta := Copy(Retorno.Strings[NumeroRegistro],71,1);
         ANomeCedente := Trim(Copy(Retorno.Strings[NumeroRegistro],73,30));

         NumeroRegistro := 1;

         {L� registro HEADER DE LOTE}
         {Verifica se � um lote de retorno de cobran�a}
         if Copy(Retorno.Strings[NumeroRegistro],9,3) <> 'T01' then
            Raise Exception.Create('Este n�o � um lote de retorno de cobran�a');

         DataArquivo := EncodeDate(StrToInt(Copy(Retorno.Strings[NumeroRegistro],196,4)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],194,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],192,2)));
         NumeroArquivo := StrToInt(Trim(Copy(Retorno.Strings[NumeroRegistro],184,8)));

         {L� os registros DETALHE}
         NumeroRegistro := NumeroRegistro + 1;
         {L� at� o antepen�ltimo registro porque o pen�ltimo cont�m apenas o TRAILER DO LOTE e o �ltimo cont�m apenas o TRAILER DO ARQUIVO}
         while (NumeroRegistro < Retorno.Count - 2) do
         begin
            {Registro detalhe com tipo de segmento = T}
            if Copy(Retorno.Strings[NumeroRegistro],14,1) = 'T' then
            begin
               {Dados do titulo}
               with ATitulo do
               begin
                  {Tipo de ocorr�ncia}
                  ATipoOcorrencia := Copy(Retorno.Strings[NumeroRegistro],16,2);
                  case StrToInt(ATipoOcorrencia) of
                     2 : TipoOcorrencia := toRetornoRegistroConfirmado;
                     3 : TipoOcorrencia := toRetornoRegistroRecusado;
                     6 : TipoOcorrencia := toRetornoLiquidado;
                     9 : TipoOcorrencia := toRetornoBaixado;
                     12: TipoOcorrencia := toRetornoRecebimentoInstrucaoConcederAbatimento;
                     13: TipoOcorrencia := toRetornoRecebimentoInstrucaoCancelarAbatimento;
                     14: TipoOcorrencia := toRetornoRecebimentoInstrucaoAlterarVencimento;
                     17: TipoOcorrencia := toRetornoLiquidado;
                     19: TipoOcorrencia := toRetornoRecebimentoInstrucaoProtestar;
                     20: TipoOcorrencia := toRetornoRecebimentoInstrucaoSustarProtesto;
                     23: TipoOcorrencia := toRetornoEncaminhadoACartorio;
                     24: TipoOcorrencia := toRetornoRetiradoDeCartorio;
                     25: TipoOcorrencia := toRetornoProtestado;
                     26: TipoOcorrencia := toRetornoComandoRecusado;
                     27: TipoOcorrencia := toRetornoRecebimentoInstrucaoAlterarDados;
                     28: TipoOcorrencia := toRetornoDebitoTarifas;
                     30: TipoOcorrencia := toRetornoRegistroRecusado;
                     36: TipoOcorrencia := toRetornoRecebimentoInstrucaoConcederDesconto;
                     37: TipoOcorrencia := toRetornoRecebimentoInstrucaoCancelarDesconto;
                     43: TipoOcorrencia := toRetornoProtestoOuSustacaoEstornado;
                     44: TipoOcorrencia := toRetornoBaixaOuLiquidacaoEstornada;
                     45: TipoOcorrencia := toRetornoDadosAlterados;
                  else
                     TipoOcorrencia := toRetornoOutrasOcorrencias;
                  end; {case StrToInt(ATipoOcorrencia)}
                  
                  {Nosso n�mero SEM D�GITO}
                  NossoNumero := Copy(Retorno.Strings[NumeroRegistro],38,11);
                  SeuNumero := Copy(Retorno.Strings[NumeroRegistro],106,25);
                  //DataVencimento := EncodeDate(StrToInt(Copy(Retorno.Strings[NumeroRegistro],78,4)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],76,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],74,2)));
                  ValorDocumento := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],82,15))/100;

                  {Dados do cedente do t�tulo}
                  with Cedente do
                  begin
                     if ATipoInscricao = '1' then
                        TipoInscricao := tiPessoaFisica
                     else if ATipoInscricao = '2' then
                        TipoInscricao := tiPessoaJuridica
                     else
                        TipoInscricao := tiOutro;
                     NumeroCPFCGC := ANumeroCPFCGC;
                     CodigoCedente := ACodigoCedente;
                     with ContaBancaria do
                     begin
                        Banco.Codigo := ACodigoBanco;
                        CodigoAgencia := ACodigoAgencia;
                        DigitoAgencia := ADigitoCodigoAgencia;
                        NumeroConta := ANumeroConta;
                        DigitoConta := ADigitoNumeroConta;
                     end;
                     Nome := ANomeCedente;
                  end; {with ACedente}

                  {Dados do sacado do t�tulo}
                  with Sacado do
                  begin
                     if Copy(Retorno.Strings[NumeroRegistro],18,1) = '1' then
                        TipoInscricao := tiPessoaFisica
                     else if Copy(Retorno.Strings[NumeroRegistro],18,1) = '2' then
                        TipoInscricao := tiPessoaJuridica
                     else
                        TipoInscricao := tiOutro;
                     NumeroCPFCGC := Copy(Retorno.Strings[NumeroRegistro],19,15);
                     Nome := Trim(Copy(Retorno.Strings[NumeroRegistro],74,30));
                  end; {with ACedente}

                  ValorDespesaCobranca := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],199,15))/100;
                  MotivoRejeicaoComando := Copy(Retorno.Strings[NumeroRegistro],214,10);
               end; {with ATitulo}

               NumeroRegistro := NumeroRegistro + 1;
            end; {if Copy(Retorno.Strings[NumeroRegistro],14,1) = 'T'}

            {Registro detalhe com tipo de segmento = U}
            if Copy(Retorno.Strings[NumeroRegistro],14,1) = 'U' then
            begin
               with ATitulo do
               begin
                  ValorMoraJuros := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],18,15))/100;
                  ValorDesconto := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],33,15))/100;
                  ValorAbatimento := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],48,15))/100;
                  ValorIOF := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],63,15))/100;
                  ValorOutrasDespesas := StrToFloat(Trim(Copy(Retorno.Strings[NumeroRegistro],108,15)))/100;
                  ValorOutrosCreditos := StrToFloat(Trim(Copy(Retorno.Strings[NumeroRegistro],123,15)))/100;
                  DataOcorrencia:= EncodeDate(StrToInt(Copy(Retorno.Strings[NumeroRegistro],142,4)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],140,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],138,2)));
                  DataCredito := EncodeDate(StrToInt(Copy(Retorno.Strings[NumeroRegistro],150,4)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],148,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],146,2)))

               end; {with ATitulo}

               NumeroRegistro := NumeroRegistro + 1;
            end; {if Copy(Retorno.Strings[NumeroRegistro],14,1) = 'U'}


            {Insere o t�tulo}
            Titulos.Add(ATitulo);
         end;
      end;

      ATitulo.Free;
      Result := TRUE
   EXCEPT
      ATitulo.Free;
      Raise; {Propaga o erro}
   END;
end;

function TgbBanco748.LerRetornoCNAB400(var ACobranca: TgbCobranca; Retorno: TStringList) : boolean;
var
   ACodigoBanco,
   ANomeCedente,
   ATipoInscricao,
   ATipoOcorrencia : string;
   NumeroRegistro : integer;
   ATitulo : TgbTitulo;
begin
   NumeroRegistro := 0;
   ATitulo := TgbTitulo.Create(nil);

   TRY

      with ACobranca do
      begin
         Titulos.Clear; {Zera o conjunto de t�tulos, antes de incluir os t�tulos do arquivo retorno}

         if Retorno.Count <= 0 then
            Raise Exception.Create('O retorno est� vazio. N�o h� dados para processar');

         if length(Retorno[0]) <> 400 then
         begin
            LayoutArquivo := laOutro;
            Raise Exception.CreateFmt('Tamanho de registro diferente de 400 bytes. Tamanho = %d bytes',[length(Retorno[0])]);
         end;

         LayoutArquivo := laCNAB400;

         {Ver se o arquivo � mesmo RETORNO DE COBRAN�A}
         if Copy(Retorno.Strings[NumeroRegistro],1,19) <> '02RETORNO01COBRANCA' then
            Raise Exception.Create(NomeArquivo+' n�o � um arquivo de retorno de cobran�a com layout CNAB400');

         { L� registro HEADER}
         ACodigoBanco := Copy(Retorno.Strings[NumeroRegistro],77,3);
         if ACodigoBanco <> CodigoBanco then
            Raise Exception.CreateFmt('Este n�o � um retorno de cobran�a do banco %s - %s',[CodigoBanco,NomeBanco]);

         ANomeCedente := Trim(Copy(Retorno.Strings[NumeroRegistro],47,30));

         if StrToInt(Copy(Retorno.Strings[NumeroRegistro],99,2)) <= 69 then
            DataArquivo := EncodeDate(StrToInt('20'+Copy(Retorno.Strings[NumeroRegistro],99,2)),
                           StrToInt(Copy(Retorno.Strings[NumeroRegistro],97,2)),
                           StrToInt(Copy(Retorno.Strings[NumeroRegistro],95,2)))
         else
            DataArquivo := EncodeDate(StrToInt('19'+Copy(Retorno.Strings[NumeroRegistro],99,2)),
                           StrToInt(Copy(Retorno.Strings[NumeroRegistro],97,2)),
                           StrToInt(Copy(Retorno.Strings[NumeroRegistro],95,2)));


         NumeroArquivo := StrToInt(Trim(Copy(Retorno.Strings[NumeroRegistro],101,7)));

         {L� os registros DETALHE}
         {Processa at� o pen�ltimo registro porque o �ltimo cont�m apenas o TRAILLER}
         for NumeroRegistro := 1 to (Retorno.Count - 2) do
         begin
            {Confirmar se o tipo do registro � 1}
            if Copy(Retorno.Strings[NumeroRegistro],1,1) <> '1' then
               Continue; {N�o processa o registro atual}

            { Ler t�tulos do arquivo retorno}
            {Dados do titulo}
            with ATitulo do
            begin
               {Dados do cedente do t�tulo}
               with Cedente do
               begin
                  ATipoInscricao := Copy(Retorno.Strings[NumeroRegistro],2,2);
                  if ATipoInscricao = '01' then
                     TipoInscricao := tiPessoaFisica
                  else if ATipoInscricao = '02' then
                     TipoInscricao := tiPessoaJuridica
                  else
                     TipoInscricao := tiOutro;
                  NumeroCPFCGC := Copy(Retorno.Strings[NumeroRegistro],4,14);
                  ContaBancaria.Banco.Codigo := ACodigoBanco;
                  Nome := ANomeCedente;
               end; {with ACedente}

               SeuNumero := Copy(Retorno.Strings[NumeroRegistro],38,25);
               NumeroDocumento := Copy(Retorno.Strings[NumeroRegistro],117,10);

               if StrToInt(Copy(Retorno.Strings[NumeroRegistro],115,2)) <= 69 then
                  DataOcorrencia := EncodeDate(StrToInt('20'+Copy(Retorno.Strings[NumeroRegistro],115,2)),
                                     StrToInt(Copy(Retorno.Strings[NumeroRegistro],113,2)),
                                     StrToInt(Copy(Retorno.Strings[NumeroRegistro],111,2)))
               else
                  DataOcorrencia := EncodeDate(StrToInt('19'+Copy(Retorno.Strings[NumeroRegistro],115,2)),
                                     StrToInt(Copy(Retorno.Strings[NumeroRegistro],113,2)),
                                     StrToInt(Copy(Retorno.Strings[NumeroRegistro],111,2)));

               ValorDocumento := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],153,13))/100;
               ValorIOF := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],215,13))/100;
               ValorAbatimento := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],228,13))/100;
               ValorDesconto := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],241,13))/100;
               ValorMoraJuros := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],267,13))/100;
               ValorOutrosCreditos := StrToFloat(Trim(Copy(Retorno.Strings[NumeroRegistro],280,13)))/100;

               {Dados que variam de acordo com o banco}

               {Nosso n�mero SEM D�GITO}
               NossoNumero := Copy(Retorno.Strings[NumeroRegistro],63,11);
               Cedente.ContaBancaria.CodigoAgencia := Copy(Retorno.Strings[NumeroRegistro],18,4);
               Cedente.ContaBancaria.DigitoConta := Copy(Retorno.Strings[NumeroRegistro],22,1);

               {Tipo de ocorr�ncia}
               ATipoOcorrencia := Copy(Retorno.Strings[NumeroRegistro],109,2);
               OcorrenciaOriginal := Copy(Retorno.Strings[NumeroRegistro],109,2); //@w
               DescricaoOcorrenciaOriginal := VerificaOcorrenciaOriginal(OcorrenciaOriginal); //@w
               case StrToInt(ATipoOcorrencia) of
                  01: TipoOcorrencia := toRetornoRegistroConfirmado;
                  02: TipoOcorrencia := toRetornoBaixado;
                  03: TipoOcorrencia := toRetornoAbatimentoConcedido;
                  04: TipoOcorrencia := toRetornoAbatimentoCancelado;
                  05: TipoOcorrencia := toRetornoVencimentoAlterado;
                  06: TipoOcorrencia := toRetornoDadosAlterados;
                  07: TipoOcorrencia := toRetornoDadosAlterados;
                  08: TipoOcorrencia := toRetornoDadosAlterados;
                  09: TipoOcorrencia := toRetornoDadosAlterados;
                  10: TipoOcorrencia := toRetornoDadosAlterados;
                  11: TipoOcorrencia := toRetornoDadosAlterados;
                  12: TipoOcorrencia := toRetornoDadosAlterados;
                  20: TipoOcorrencia := toRetornoTituloEmSer;
                  21: TipoOcorrencia := toRetornoLiquidado;
                  22: TipoOcorrencia := toRetornoLiquidado;
                  23: TipoOcorrencia := toRetornoBaixado;
                  24: TipoOcorrencia := toRetornoBaixado;
                  25: TipoOcorrencia := toRetornoProtestado;
                  26: TipoOcorrencia := toRetornoEncaminhadoACartorio;
                  27: TipoOcorrencia := toRetornoProtestoSustado;
                  28: TipoOcorrencia := toRetornoProtestoOuSustacaoEstornado;
                  29: TipoOcorrencia := toRetornoProtestoOuSustacaoEstornado;
                  30: TipoOcorrencia := toRetornoDadosAlterados;
                  31: TipoOcorrencia := toRetornoDebitoTarifas;
                  32: TipoOcorrencia := toRetornoDebitoTarifas;
                  33: TipoOcorrencia := toRetornoBaixaOuLiquidacaoEstornada;
                  99: TipoOcorrencia := toRetornoRegistroRecusado;
               else
                  TipoOcorrencia := toRetornoOutrasOcorrencias;
               end; {case StrToInt(ATipoOcorrencia)}

               MotivoRejeicaoComando := Copy(Retorno.Strings[NumeroRegistro],81,2);
               DescricaoMotivoRejeicaoComando := VerificaMotivoRejeicaoComando(MotivoRejeicaoComando);

               Carteira := Copy(Retorno.Strings[NumeroRegistro],107,2);
               ValorDespesaCobranca := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],189,13))/100;
               if StrToInt(Copy(Retorno.Strings[NumeroRegistro],115,2)) <= 69 then
                  DataCredito := EncodeDate(StrToInt('20'+Copy(Retorno.Strings[NumeroRegistro],115,2)),
                                 StrToInt(Copy(Retorno.Strings[NumeroRegistro],113,2)),
                                 StrToInt(Copy(Retorno.Strings[NumeroRegistro],111,2)))
               else
                  DataCredito := EncodeDate(StrToInt('19'+Copy(Retorno.Strings[NumeroRegistro],115,2)),
                                 StrToInt(Copy(Retorno.Strings[NumeroRegistro],113,2)),
                                 StrToInt(Copy(Retorno.Strings[NumeroRegistro],111,2)));
               Sacado.Nome := Copy(Retorno.Strings[NumeroRegistro],347,30);

            end; {with ATitulo}

            {Insere o t�tulo}
            Titulos.Add(ATitulo);
         end;
      end;

      ATitulo.Free;
      Result := TRUE
   EXCEPT
      ATitulo.Free;
      Raise; {Propaga o erro}
   END;
end;



function TgbBanco748.LerRetorno(var ACobranca: TgbCobranca; Retorno: TStringList) : boolean;
var
   ATitulo : TgbTitulo;
begin
   ATitulo := TgbTitulo.Create(nil);

   TRY

      with ACobranca do
      begin
         Titulos.Clear; {Zera o conjunto de t�tulos, antes de incluir os t�tulos do arquivo retorno}

         if Retorno.Count <= 0 then
            Raise Exception.Create('O retorno est� vazio. N�o h� dados para processar');

         case length(Retorno[0]) of
            240 :
               begin
                  LayoutArquivo := laCNAB240;
//                Result := LerRetornoCNAB240(ACobranca, Retorno);
               end;
            400 :
               begin
                  LayoutArquivo := laCNAB400;
                  LerRetornoCNAB400(ACobranca, Retorno);
               end
         else
            begin
               LayoutArquivo := laOutro;
               Raise Exception.CreateFmt('Tamanho de registro inv�lido: %d',[length(Retorno[0])]);
            end;
         end;
      end;

      ATitulo.Free;
      Result := TRUE
   EXCEPT
      ATitulo.Free;
      Raise; //Propaga o erro
   END;
end;


function TgbBanco748.VerificaOcorrenciaOriginal(sOcorrenciaOriginal: String): String;
begin
  if sOcorrenciaOriginal='  ' then begin
     Result:='';
     Exit;
  end;
 case StrToInt(sOcorrenciaOriginal) of
   02: Result:='02-Confirma��o de Entrada de T�tulo' ;
   03: Result:='03-Comando recusado' ;
   05: Result:='05-Liquidado sem registro' ;
   06: Result:='06-Liquida��o Normal' ;
   07: Result:='07-Liquida��o por Conta' ;
   08: Result:='08-Liquida��o por Saldo' ;
   09: Result:='09-Baixa de T�tulo' ;
   10: Result:='10-Baixa Solicitada' ;
   11: Result:='11-Titulos em Ser' ;
   12: Result:='12-Abatimento Concedido' ;
   13: Result:='13-Abatimento Cancelado' ;
   14: Result:='14-Altera��o de Vencimento do Titulo' ;
   15: Result:='15-Liquida��o em Cart�rio' ;
   19: Result:='19-Confirma��o de recebimento de instru��es para protesto' ;
   20: Result:='20-D�bito em Conta' ;
   21: Result:='21-Altera��o do Nome do Sacado' ;
   22: Result:='22-Altera��o do Endere�o do Sacado' ;
   23: Result:='23-Indica��o de encaminhamento a cart�rio' ;
   24: Result:='24-Sustar Protesto' ;
   25: Result:='25-Dispensar Juros' ;
   28: Result:='28-Manuten��o de titulo vencido' ;
   72: Result:='72-Altera��o de tipo de cobran�a' ;
   96: Result:='96-Despesas de Protesto' ;
   97: Result:='97-Despesas de Susta��o de Protesto' ;
   98: Result:='98-D�bito de Custas Antecipadas' ;
 end;
end;

function TgbBanco748.VerificaMotivoRejeicaoComando(sMotivoRejeicaoComando: String): String;
begin
 if sMotivoRejeicaoComando = '  ' then begin
    Result:='';
    Exit;
 end;
   
 case StrToInt(sMotivoRejeicaoComando) of
   01: Result:='01-Identifica��o inv�lida' ;
   02: Result:='02-Varia��o da carteira inv�lida' ;
   03: Result:='03-Valor dos juros por um dia inv�lido' ;
   04: Result:='04-Valor do desconto inv�lido' ;
   05: Result:='05-Esp�cie de t�tulo inv�lida para carteira' ;
   06: Result:='06-Esp�cie de valor vari�vel inv�lido' ;
   07: Result:='07-Prefixo da ag�ncia usu�ria inv�lido' ;
   08: Result:='08-Valor do t�tulo/ap�lice inv�lido' ;
   09: Result:='09-Data de vencimento inv�lida' ;
   10: Result:='10-Fora do prazo' ;
   11: Result:='11-Inexist�ncia de margem para desconto' ;
   12: Result:='12-O Banco n�o tem ag�ncia na pra�a do sacado' ;
   13: Result:='13-Raz�es cadastrais' ;
   14: Result:='14-Sacado interligado com o sacador' ;
   15: Result:='15-T�tulo sacado contra org�o do Poder P�blico' ;
   16: Result:='16-T�tulo preenchido de forma irregular' ;
   17: Result:='17-T�tulo rasurado' ;
   18: Result:='18-Endere�o do sacado n�o localizado ou incompleto' ;
   19: Result:='19-C�digo do cedente inv�lido' ;
   20: Result:='20-Nome/endereco do cliente n�o informado /ECT/' ;
   21: Result:='21-Carteira inv�lida' ;
   22: Result:='22Quantidade de valor vari�vel inv�lida' ;
   23: Result:='23-Faixa nosso n�mero excedida' ;
   24: Result:='24-Valor do abatimento inv�lido' ;
   25: Result:='25-Novo n�mero do t�tulo dado pelo cedente inv�lido' ;
   26: Result:='26-Valor do IOF de seguro inv�lido' ;
   27: Result:='27-Nome do sacado/cedente inv�lido ou n�o informado' ;
   28: Result:='28-Data do novo vencimento inv�lida' ;
   29: Result:='29-Endereco n�o informado' ;
   30: Result:='30-Registro de t�tulo j� liquidado' ;
   31: Result:='31-Numero do bordero inv�lido' ;
   32: Result:='32-Nome da pessoa autorizada inv�lido' ;
   33: Result:='33-Nosso n�mero j� existente' ;
   34: Result:='34-Numero da presta��o do contrato inv�lido' ;
   35: Result:='35-Percentual de desconto inv�lido' ;
   36: Result:='36-Dias para fichamento de protesto inv�lido' ;
   37: Result:='37-Data de emiss�o do t�tulo inv�lida' ;
   38: Result:='38-Data do vencimento anterior a data da emiss�o do t�tulo' ;
   39: Result:='39-Comando de altera��o indevido para a carteira' ;
   40: Result:='40-Tipo de moeda inv�lido' ;
   41: Result:='41-Abatimento n�o permitido' ;
   42: Result:='42-CEP do sacado inv�lido /ECT/' ;
   43: Result:='43-Codigo de unidade variavel incompativel com a data emiss�o do t�tulo' ;
   44: Result:='44-Dados para debito ao sacado inv�lidos' ;
   45: Result:='45-Carteira' ;
   46: Result:='46-Convenio encerrado' ;
   47: Result:='47-T�tulo tem valor diverso do informado' ;
   48: Result:='48-Motivo de baixa inv�lido para a carteira' ;
   49: Result:='49-Abatimento a cancelar n�o consta do t�tulo' ;
   50: Result:='50-Comando incompativel com a carteira' ;
   51: Result:='51-Codigo do convenente inv�lido' ;
   52: Result:='52-Abatimento igual ou maior que o valor do t�tulo' ;
   53: Result:='53-T�tulo j� se encontra situa��o pretendida' ;
   54: Result:='54-T�tulo fora do prazo admitido para a conta 1' ;
   55: Result:='55-Novo vencimento fora dos limites da carteira' ;
   56: Result:='56-T�tulo n�o pertence ao convenente' ;
   57: Result:='57-Varia��o incompativel com a carteira' ;
   58: Result:='58-Impossivel a transferencia para a carteira indicada' ;
   59: Result:='59-T�tulo vencido em transferencia para a carteira 51' ;
   60: Result:='60-T�tulo com prazo superior a 179 dias em transferencia para carteira 51' ;
   61: Result:='61-T�tulo j� foi fichado para protesto' ;
   62: Result:='62-Altera��o da situa��o de debito inv�lida para o codigo de responsabilidade' ;
   63: Result:='63-DV do nosso n�mero inv�lido' ;
   64: Result:='64-T�tulo n�o passivel de debito/baixa - situa��o anormal' ;
   65: Result:='65-T�tulo com ordem de n�o protestar-n�o pode ser encaminhado a cartorio' ;
   67: Result:='66-T�tulo/carne rejeitado' ;
   80: Result:='80-Nosso n�mero inv�lido' ;
   81: Result:='81-Data para concess�o do desconto inv�lida' ;
   82: Result:='82-CEP do sacado inv�lido' ;
   83: Result:='83-Carteira/varia��o n�o localizada no cedente' ;
   84: Result:='84-T�tulo n�o localizado na existencia' ;
   99: Result:='99-Outros motivos' ;
 end;
end;




{$ENDIF}

initialization
RegisterClass(TgbBanco748);

end.

{
  Autor........: Daniel Pereira Guimarães
  E-Mail.......: tecnobyte@ulbrajp.com.br
  Web..........: www.ulbrajp.com.br/usuarios/tecnobyte
  Modificado em: 12 - Maio - 1999.

  Pode distribuir. Apenas deixe as informações acima.
}


unit tbPrn;

{ Como usar?

  - Adicione esta unit ao seu projeto;
  - Coloque no uses da unit onde for usá-la: tbPrn;
  - Siga o exemplo abaixo para contruir seus relatórios.

procedure TForm1.Button1Click(Sender: TObject);
var
  Papel: TtbPrnPaper;
begin
  Papel.Size := 256; // 256 é o tam. personalizado
  Papel.Width := 2100; // 21 cm
  Papel.Height := 1000; // 10 cm
  Papel := tbPrnSetPaperSize(Papel);
  try
    Printer.BeginDoc;
    try
      // coloque aqui os comandos para impressão
    finally
      Printer.EndDoc;
    end;
  finally
    tbPrnSetPaperSize(Papel); // Restaura o tamanho
  end;
end;

 Paper.Size refere-se ao tamanho do papel. Veja alguns:
    0 - Default
    1 - Letter
    5 - Legal
    8 - A3
    9 - A4
   11 - A5
  256 - Custom (personalizado)


Só será necessário informar Papel.Height e Papel.Width
quando Papel.Size for 256.

}

interface
  uses Windows, Printers, SysUtils;

type
  TtbPrnPaper = record
    Size: SmallInt;
    Width: SmallInt;
    Height: SmallInt;
  end;

function tbPrnSetPaperSize(const Paper: TtbPrnPaper): TtbPrnPaper;

implementation

function tbPrnSetPaperSize(const Paper: TtbPrnPaper): TtbPrnPaper;
var
  S: string;
  HDevMode: THandle;
  DevMode: PDeviceMode;
  Device, Driver, Port: PChar;
begin
  { Bug VCL - A Impressora selecionada às vezes falha. Com
    esta instrução funciona adequadamente. }
  S := Printer.Printers[Printer.PrinterIndex];

  { Aloca memória para as variáveis PChar }
  GetMem(Device, 255);
  GetMem(Driver, 255);
  GetMem(Port, 255);
  try
    { Obtém dados da impressora atual }
    Printer.GetPrinter(Device, Driver, Port, HDevMode);

    { Aloca ponteiro }
    DevMode := GlobalLock(HDevMode);
    try
      if DevMode <> nil then begin
        with DevMode^ do begin

          { Salva tamanho atual }
          Result.Size := dmPaperSize;
          Result.Width := dmPaperWidth;
          Result.Height := dmPaperLength;

          { Define o novo tamanho }
          dmPaperSize := Paper.Size;
          dmFields := dmFields or DM_PAPERSIZE;

          { Se for tamanho personalizado... }
          if Paper.Size = DMPAPER_USER then begin

            { Define altura }
            dmPaperLength := Paper.Height;
            dmFields := dmFields or DM_PAPERLENGTH;

            { Define largura }
            dmPaperWidth := Paper.Width;
            dmFields := dmFields or DM_PAPERWIDTH;
          end;
        end;

        { Aplica as modificações }
        Printer.SetPrinter(Device, Driver, Port, HDevMode);
      end else
        raise Exception.Create('Erro ao definir tamanho de papel.');
    finally
      { Desaloca ponteiro }
      GlobalUnlock(HDevMode)
    end;
  finally
    { Desaloca a memória das variáveis PChar }
    FreeMem(Device, 255);
    FreeMem(Driver, 255);
    FreeMem(Port, 255);
  end;
end;

end.

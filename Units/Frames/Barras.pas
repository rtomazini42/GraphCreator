unit Barras;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts;

type
  TFrameBarras = class(TFrame)
    Rectangle1: TRectangle;
    Conteudo: TLayout;
    Regua: TLayout;
    Line1: TLine;
    RectBar: TRectangle;
    barraLay: TLayout;
    EtiquetaLbl: TLabel;
    procedure CriarBarra(etiqueta: String; valor: Double; cor : TAlphaColor);
    procedure LimparBarras;
  private
    { Private declarations }
    CoresPadrao: array of TAlphaColor;
    function IsColorLight(Color: TAlphaColor): Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

{ TFrameBarras }


procedure TFrameBarras.CriarBarra(etiqueta: String; valor: Double; cor : TAlphaColor);
var
  NovaBarraLay: TLayout;
  NovaEtiquetaLbl: TLabel;
  NovaRectBar: TRectangle;
  PercntLbl: TLabel;
  NumeroAleatorio: Integer;
    CorAleatoria: TAlphaColor;
begin



  if cor = TAlphaColorRec.White then
    begin
      SetLength(CoresPadrao, 3); // Defina o tamanho do array de acordo com a quantidade desejada de cores
      CoresPadrao[0] := TAlphaColors.Coral;
      CoresPadrao[1] := TAlphaColors.Lightblue;
      CoresPadrao[2] := TAlphaColors.Lightgreen;
      // Gere um n�mero aleat�rio entre 0 e o n�mero de cores dispon�veis
      NumeroAleatorio := Random(Length(CoresPadrao));
      // Selecione a cor aleat�ria com base no n�mero gerado
      cor := CoresPadrao[NumeroAleatorio];
    end
    else
    cor := cor;
  // Crie uma nova inst�ncia do barraLay
  NovaBarraLay := TLayout.Create(Self);
  NovaBarraLay.Parent := Conteudo;
  NovaBarraLay.Align := TAlignLayout.Right;
  NovaBarraLay.Align := TAlignLayout.Left;
  NovaBarraLay.Margins.Right := 10;

  // Crie uma nova etiqueta para a barra
  NovaEtiquetaLbl := TLabel.Create(NovaBarraLay);
  NovaEtiquetaLbl.TextSettings.Font.Size := 22;
  NovaEtiquetaLbl.Parent := NovaBarraLay;
  NovaEtiquetaLbl.Text := etiqueta;
  NovaEtiquetaLbl.Align := TAlignLayout.Top;

  // Crie uma nova perct para a barra
  PercntLbl := TLabel.Create(NovaBarraLay);
  PercntLbl.Parent := NovaBarraLay;
  PercntLbl.Text := valor.ToString + '%';
  PercntLbl.TextSettings.Font.Size := 16;
  PercntLbl.Align := TAlignLayout.Top;

  {if IsColorLight(Rectangle1.Fill.Color) then
  begin
     PercntLbl.TextSettings.FontColor := TAlphaColors.Black;
     NovaEtiquetaLbl.TextSettings.FontColor := TAlphaColors.Black;
     Line1.Stroke.Color :=  TAlphaColors.Black;
  end
  else
  begin
      PercntLbl.TextSettings.FontColor := TAlphaColors.White;
     NovaEtiquetaLbl.TextSettings.FontColor := TAlphaColors.White;
     Line1.Stroke.Color :=  TAlphaColors.White;
  end;  }




  // Crie uma nova barra retangular
  NovaRectBar := TRectangle.Create(NovaBarraLay);
  NovaRectBar.Align := TAlignLayout.Bottom;
  NovaRectBar.Parent := NovaBarraLay;
  NovaRectBar.Height := Round(valor) * 2; // Defina a altura da barra conforme necess�rio
  NovaRectBar.Fill.Color := cor; // Defina a cor da barra conforme necess�rio
  NovaRectBar.Width :=  30; // Defina a largura da barra com base no valor
  
end;



function TFrameBarras.IsColorLight(Color: TAlphaColor): Boolean;
var
  R, G, B: Byte;
  Luminance: Double;
begin
  R := TAlphaColorRec(Color).R;
  G := TAlphaColorRec(Color).G;
  B := TAlphaColorRec(Color).B;

  // F�rmula para calcular a lumin�ncia de acordo com a percep��o humana
  Luminance := 0.299 * R + 0.587 * G + 0.114 * B;

  // Defina um limite (por exemplo, 128) para decidir se a cor � clara ou escura
  Result := Luminance > 128;
end;

procedure TFrameBarras.LimparBarras;
var
  i: Integer;
begin
  // Percorra todos os componentes em Conteudo e remova as barras
  for i := Conteudo.ControlsCount - 1 downto 0 do
  begin
    if Conteudo.Controls[i] is TLayout then
    begin
      Conteudo.Controls[i].Free;
    end;
  end;
end;



end.

unit Exibidor;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, Barras, System.Generics.Collections,
  FMX.Colors;

type
  TFormExibicao = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Rectangle1: TRectangle;
    FrameBarras1: TFrameBarras;
    inputValor: TEdit;
    inputEtiqueta: TEdit;
    Layout3: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    Valor: TLabel;
    Label1: TLabel;
    BtnAdd: TRectangle;
    Path1: TPath;
    ComboColorBox1: TComboColorBox;
    ComboColorBox2: TComboColorBox;
    Label2: TLabel;
    Label3: TLabel;
    procedure BtnAddClick(Sender: TObject);
    procedure PercorrerItens;
    procedure ComboColorBox2Change(Sender: TObject);


    type
      TItem = record
      Etiqueta: string;
      Valor: Double;
      Cor: TAlphaColor;
    end;

  private
    { Private declarations }
     Items: TArray<TItem>; // Array para armazenar os pares etiqueta-valor
  public
    { Public declarations }

  end;

var
  FormExibicao: TFormExibicao;

implementation

{$R *.fmx}

procedure TFormExibicao.BtnAddClick(Sender: TObject);
var
  NovoItem: TItem;
begin
  if inputValor.Text.ToInteger > 200 then
  begin
    ShowMessage('N�o pode ser maior que 200%');
  end
  else
  begin
     // Verifique se o campo de etiqueta n�o est� vazio
  if not inputEtiqueta.Text.IsEmpty then
  begin
    // Tente converter o campo de valor para um valor Double
    if TryStrToFloat(inputValor.Text, NovoItem.Valor) then
    begin
      // Atribua a etiqueta do campo de entrada
      NovoItem.Etiqueta := inputEtiqueta.Text;

      NovoItem.Cor := ComboColorBox1.Color;

      // Adicione o novo item ao array de Items
      SetLength(Items, Length(Items) + 1);
      Items[High(Items)] := NovoItem;

      // Limpe os campos de entrada ap�s adicionar
      inputEtiqueta.Text := '';
      inputValor.Text := '';
    end
    else
    begin
      ShowMessage('O valor inserido n�o � um n�mero v�lido.');
    end;
  end
  else
  begin
    ShowMessage('A etiqueta n�o pode estar em branco.');
  end;

  PercorrerItens
  end;


end;


procedure TFormExibicao.ComboColorBox2Change(Sender: TObject);
begin
 FrameBarras1.Rectangle1.Fill.Color := ComboColorBox2.Color;

end;

procedure TFormExibicao.PercorrerItens;
var
  I: Integer;
begin

  FrameBarras1.LimparBarras;
  for I := Low(Items) to High(Items) do
  begin
    // Acesso aos valores individuais do item
    //ShowMessage('Etiqueta: ' + Items[I].Etiqueta + ', Valor: ' + FloatToStr(Items[I].Valor));
    FrameBarras1.CriarBarra(Items[I].Etiqueta, Items[I].Valor, Items[I].Cor);
    // Voc� pode realizar outras a��es com os itens aqui
  end;
end;


end.

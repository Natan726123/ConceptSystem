unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Unit2, uFormCadastroTecido, Vcl.Menus,
  VCLTee.TeCanvas, uFormDBPath;

type
  TForm4 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    btnCadastrarTecido: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    MainMenu1: TMainMenu;
    Cadastrar1: TMenuItem;
    CadastrarProduto1: TMenuItem;
    CadastrarTecido1: TMenuItem;
    CadastrarCortador1: TMenuItem;
    CadastrarFaccionista1: TMenuItem;
    Editar1: TMenuItem;
    Basededados1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCadastrarTecidoClick(Sender: TObject);
    procedure CadastrarTecido1Click(Sender: TObject);
    procedure Basededados1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
var
  formCorte : TFormGerarOrdemCorte;
begin
  if not Assigned(FormGerarOrdemCorte) then
    Application.CreateForm(TFormGerarOrdemCorte, FormGerarOrdemCorte);

  formCorte.Show;
end;

procedure TForm4.Basededados1Click(Sender: TObject);
var
  formPathDB : TFormPathDB;
begin
  formPathDB := TFormPathDB.Create(Self);
  try
    //if not Assigned(formPathDB) then
    //Application.CreateForm(TFormPathDB, formPathDB);
    formPathDB.Show;
  finally

  end;
end;

procedure TForm4.btnCadastrarTecidoClick(Sender: TObject);
var
  formCadastrarTecido : TFormCadastroTecido;
begin
  formCadastrarTecido := TFormCadastroTecido.Create(Self);
  try
    if not Assigned(FormCadastroTecido) then
    Application.CreateForm(TFormCadastroTecido, FormCadastroTecido);
    formCadastrarTecido.Show;
  finally
    formCadastrarTecido.Free;
  end;
end;

procedure TForm4.CadastrarTecido1Click(Sender: TObject);
var
  formCadastrarTecido : TFormCadastroTecido;
begin
  formCadastrarTecido := TFormCadastroTecido.Create(Self);
  try
    if not Assigned(FormCadastroTecido) then
    Application.CreateForm(TFormCadastroTecido, FormCadastroTecido);
    formCadastrarTecido.Show;
  finally
    formCadastrarTecido.Free;
  end;
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;

end.

unit uFormDashboard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Unit2, uFormCadastroTecido, Vcl.Menus,
  VCLTee.TeCanvas, uFormDBPath, uFormCadastroProduto;

type
  TFormDashboard = class(TForm)
    btnGerarOrdemCorte: TButton;
    Button2: TButton;
    btnCadastrarTecido: TButton;
    btnCadastrarProdutos: TButton;
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
    procedure btnGerarOrdemCorteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCadastrarTecidoClick(Sender: TObject);
    procedure CadastrarTecido1Click(Sender: TObject);
    procedure Basededados1Click(Sender: TObject);
    procedure btnCadastrarProdutosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDashboard: TFormDashboard;

implementation

{$R *.dfm}

procedure TFormDashboard.btnGerarOrdemCorteClick(Sender: TObject);
var
  formCorte : TForm2;
begin
  formCorte := TForm2.Create(Self);
  try
    if not Assigned(formCorte) then
    Application.CreateForm(TForm2, Form2);

    formCorte.Show;
  finally
    //formCorte.Free;
  end;

end;

procedure TFormDashboard.btnCadastrarProdutosClick(Sender: TObject);
begin
  var
  formCadastrarProduto: TFormCadastrarProdutos;
begin
  formCadastrarProduto := TFormCadastrarProdutos.Create(Self);
  try
    formCadastrarProduto.ShowModal;
  finally
    formCadastrarProduto.Free;
  end;
end;
end;

procedure TFormDashboard.Basededados1Click(Sender: TObject);
var
  formPathDB : TFormPathDB;
begin
  formPathDB := TFormPathDB.Create(Self);
  try
    //if not Assigned(formPathDB) then
    //Application.CreateForm(TFormPathDB, formPathDB);
    formPathDB.ShowModal;
  finally

  end;
end;

procedure TFormDashboard.btnCadastrarTecidoClick(Sender: TObject);
var
  formCadastrarTecido: TFormCadastroTecido;
begin
  formCadastrarTecido := TFormCadastroTecido.Create(Self);
  try
    formCadastrarTecido.ShowModal; // Exibe o formulário como modal, mantendo-o aberto até ser fechado
  finally
    formCadastrarTecido.Free; // Libera o formulário da memória somente após ele ser fechado
  end;
end;

procedure TFormDashboard.CadastrarTecido1Click(Sender: TObject);
var
  formCadastrarTecido: TFormCadastroTecido;
begin
  formCadastrarTecido := TFormCadastroTecido.Create(Self);
  try
    formCadastrarTecido.ShowModal; // Exibe o formulário como modal, mantendo-o aberto até ser fechado
  finally
    formCadastrarTecido.Free; // Libera o formulário da memória somente após ele ser fechado
  end;
end;


procedure TFormDashboard.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;

end.

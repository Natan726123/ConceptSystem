unit uFormDashboard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Unit2, uFormCadastroTecido, Vcl.Menus,
  VCLTee.TeCanvas, uFormDBPath, uFormCadastroProduto, uFormCortador, Vcl.Styles, Vcl.Themes,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, uFormCadastroFaccao, uFormFichaFaccao, uFormEstoqueProdutos;

type
  TFormDashboard = class(TForm)
    btnGerarOrdemCorte: TButton;
    btnCadastrarCortador: TButton;
    btnCadastrarTecido: TButton;
    btnCadastrarProdutos: TButton;
    btnCadastrarFaccao: TButton;
    btnCriarFichaFaccao: TButton;
    MainMenu1: TMainMenu;
    Cadastrar1: TMenuItem;
    CadastrarProduto1: TMenuItem;
    CadastrarTecido1: TMenuItem;
    CadastrarCortador1: TMenuItem;
    CadastrarFaccionista1: TMenuItem;
    Editar1: TMenuItem;
    Basededados1: TMenuItem;
    Label1: TLabel;
    Image1: TImage;
    Visualizar1: TMenuItem;
    Aparncia1: TMenuItem;
    Dark1: TMenuItem;
    Light1: TMenuItem;
    Blue1: TMenuItem;
    Default1: TMenuItem;
    Default2: TMenuItem;
    Image2: TImage;
    pnlCadastros: TPanel;
    Label2: TLabel;
    pnlOperacoes: TPanel;
    Label3: TLabel;
    btnGerenciarEstoque: TButton;
    procedure btnGerarOrdemCorteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCadastrarTecidoClick(Sender: TObject);
    procedure CadastrarTecido1Click(Sender: TObject);
    procedure Basededados1Click(Sender: TObject);
    procedure btnCadastrarProdutosClick(Sender: TObject);
    procedure CadastrarProduto1Click(Sender: TObject);
    procedure btnCadastrarCortadorClick(Sender: TObject);
    procedure btnStyleGlossyClick(Sender: TObject);
    procedure btnOnyxBlueClick(Sender: TObject);
    procedure Dark1Click(Sender: TObject);
    procedure Light1Click(Sender: TObject);
    procedure Blue1Click(Sender: TObject);
    procedure Default1Click(Sender: TObject);
    procedure Default2Click(Sender: TObject);
    procedure btnCadastrarFaccaoClick(Sender: TObject);
    procedure btnCriarFichaFaccaoClick(Sender: TObject);
    procedure btnGerenciarEstoqueClick(Sender: TObject);
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
  formCorte : TFormGerarOrdemCorte;
begin
  formCorte := TFormGerarOrdemCorte.Create(Self);
  try
    if not Assigned(formCorte) then
    Application.CreateForm(TFormGerarOrdemCorte, FormGerarOrdemCorte);

    formCorte.Show;
  finally
    //formCorte.Free;
  end;

end;

procedure TFormDashboard.btnGerenciarEstoqueClick(Sender: TObject);
var
  formEstoqueProdutos: TFormEstoqueProdutos;
begin
  formEstoqueProdutos := TFormEstoqueProdutos.Create(Self);
  try
    formEstoqueProdutos.ShowModal;
  finally
    formEstoqueProdutos.Free;
  end;
end;

procedure TFormDashboard.btnOnyxBlueClick(Sender: TObject);
begin
  TStyleManager.TrySetStyle('Onyx Blue');
end;

procedure TFormDashboard.btnStyleGlossyClick(Sender: TObject);
begin
  TStyleManager.TrySetStyle('Glossy');
end;

procedure TFormDashboard.btnCadastrarFaccaoClick(Sender: TObject);
var
  formCadastrarFaccao: TFormCadastroFaccao;
begin
  formCadastrarFaccao := TFormCadastroFaccao.Create(Self);
  try
    formCadastrarFaccao.ShowModal;
  finally
    formCadastrarFaccao.Free;
  end;
end;

procedure TFormDashboard.Blue1Click(Sender: TObject);
begin
  TStyleManager.TrySetStyle('Onyx Blue');
end;

procedure TFormDashboard.btnCadastrarCortadorClick(Sender: TObject);
begin
  var
  formCadastrarCortador: TFormCadastroCortador;
begin
  formCadastrarCortador := TFormCadastroCortador.Create(Self);
  try
    formCadastrarCortador.ShowModal;
  finally
    formCadastrarCortador.Free;
  end;
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
    formCadastrarTecido.ShowModal; // Exibe o formul�rio como modal, mantendo-o aberto at� ser fechado
  finally
    formCadastrarTecido.Free; // Libera o formul�rio da mem�ria somente ap�s ele ser fechado
  end;
end;

procedure TFormDashboard.btnCriarFichaFaccaoClick(Sender: TObject);
var
  formFichaFaccao: TFormFichaFaccao;
begin
  formFichaFaccao := TFormFichaFaccao.Create(Self);
  try
    formFichaFaccao.ShowModal; // Exibe o formul�rio como modal, mantendo-o aberto at� ser fechado
  finally
    formFichaFaccao.Free; // Libera o formul�rio da mem�ria somente ap�s ele ser fechado
  end;
end;

procedure TFormDashboard.CadastrarProduto1Click(Sender: TObject);
var
  formCadastrarProduto: TFormCadastrarProdutos;
begin
  formCadastrarProduto := TFormCadastrarProdutos.Create(Self);
  try
    formCadastrarProduto.ShowModal; // Exibe o formul�rio como modal, mantendo-o aberto at� ser fechado
  finally
    formCadastrarProduto.Free; // Libera o formul�rio da mem�ria somente ap�s ele ser fechado
  end;
end;

procedure TFormDashboard.CadastrarTecido1Click(Sender: TObject);
var
  formCadastrarTecido: TFormCadastroTecido;
begin
  formCadastrarTecido := TFormCadastroTecido.Create(Self);
  try
    formCadastrarTecido.ShowModal; // Exibe o formul�rio como modal, mantendo-o aberto at� ser fechado
  finally
    formCadastrarTecido.Free; // Libera o formul�rio da mem�ria somente ap�s ele ser fechado
  end;
end;


procedure TFormDashboard.Dark1Click(Sender: TObject);
begin
  TStyleManager.TrySetStyle('Glossy');
end;

procedure TFormDashboard.Default1Click(Sender: TObject);
begin
  TStyleManager.TrySetStyle('Glow');
end;

procedure TFormDashboard.Default2Click(Sender: TObject);
begin
  TStyleManager.TrySetStyle('Windows');
end;

procedure TFormDashboard.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;

procedure TFormDashboard.Light1Click(Sender: TObject);
begin
  TStyleManager.TrySetStyle('Light');
end;

end.

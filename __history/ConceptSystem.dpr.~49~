program ConceptSystem;

uses
  Vcl.Forms,
  Unit2 in 'Unit2.pas' {FormGerarOrdemCorte},
  uFormCadastroTecido in 'uFormCadastroTecido.pas' {FormCadastroTecido},
  uMainModulo in 'uMainModulo.pas' {Form6},
  uFormDBPath in 'uFormDBPath.pas' {FormPathDB},
  Vcl.Themes,
  Vcl.Styles,
  uFormDashboard in 'uFormDashboard.pas' {Form4},
  uFormCadastroProduto in 'uFormCadastroProduto.pas' {FormCadastrarProdutos},
  uFormCortador in 'uFormCortador.pas' {FormCadastroCortador},
  uFormCadastroFaccao in 'uFormCadastroFaccao.pas' {FormCadastroFaccao},
  uFormRelOrdemCorte in 'uFormRelOrdemCorte.pas' {FormRelOrdemCorte},
  uFormFichaFaccao in 'uFormFichaFaccao.pas' {FormFichaFaccao},
  uFormConsultaFichaFaccao in 'uFormConsultaFichaFaccao.pas' {FormConsultaFichaFaccao};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  TStyleManager.TrySetStyle('Glossy');
  Application.CreateForm(TFormDashboard, FormDashboard);
  //Application.CreateForm(TFormConsultaFichaFaccao, FormConsultaFichaFaccao);
  //Application.CreateForm(TFormFichaFaccao, FormFichaFaccao);
  //Application.CreateForm(TFormRelOrdemCorte, FormRelOrdemCorte);
  //Application.CreateForm(TFormCadastroFaccao, FormCadastroFaccao);
  //Application.CreateForm(TFormCadastroCortador, FormCadastroCortador);
  //Application.CreateForm(TForm1, Form1);
  //Application.CreateForm(TFormPathDB, FormPathDB);
  //Application.CreateForm(TForm4, Form4);
  //Application.CreateForm(TFormCadastroTecido, FormCadastroTecido);
  //Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm6, Form6);
  Application.Run;
end.

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
  uFormConsultaFichaFaccao in 'uFormConsultaFichaFaccao.pas' {FormConsultaFichaFaccao},
  uFormRelFichaFaccao1via in 'uFormRelFichaFaccao1via.pas' {FormRelFichaFaccao1via},
  uFormRelFichaFaccao2via in 'uFormRelFichaFaccao2via.pas' {FormRelFichaFaccao2via},
  uFormEstoqueProdutos in 'uFormEstoqueProdutos.pas' {FormEstoqueProdutos},
  uDataModulo in 'uDataModulo.pas' {DataModule1: TDataModule},
  uFormRelEstoque in 'uFormRelEstoque.pas' {FormRelEstoque},
  uFormConsultaOrdemCorte in 'uFormConsultaOrdemCorte.pas' {FormConsultaOrdemCorte};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  TStyleManager.TrySetStyle('Light');
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFormDashboard, FormDashboard);
  Application.CreateForm(TForm6, Form6);
  Application.Run;
end.

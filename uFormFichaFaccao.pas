unit uFormFichaFaccao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.Samples.Calendar, Vcl.WinXCalendars, Data.DB, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.Components, Data.Bind.DBScope, uMainModulo, Math;

type
  TFormFichaFaccao = class(TForm)
    Label1: TLabel;
    pnlModelos: TPanel;
    lblTamanhos: TLabel;
    lblSelecionarModelo: TLabel;
    lblQuantidade: TLabel;
    lblCodRef: TLabel;
    lblRaddioButtonBusca: TLabel;
    ComboBoxProdutos: TComboBox;
    PanelTamanhos: TPanel;
    edtQuantidade: TEdit;
    btnGerarFicha: TButton;
    btnAdicionarItens: TButton;
    edtCodRef: TEdit;
    rbBuscaCodigo: TRadioButton;
    rbBuscaReferencia: TRadioButton;
    CalendarDataDeCorte: TCalendarPicker;
    lblDataCorte: TLabel;
    lblFaccao: TLabel;
    ComboBoxFaccao: TComboBox;
    lblNumCorte: TLabel;
    edtNumCorte: TEdit;
    lblNumOrdemCorte: TLabel;
    edtNumOrdemCorte: TEdit;
    CalendarDataDeEnvio: TCalendarPicker;
    lblDataEnvio: TLabel;
    lblCores: TLabel;
    ComboBoxCores: TComboBox;
    CalendarDataPrevista: TCalendarPicker;
    lblDataPrevista: TLabel;
    lblCortador: TLabel;
    ComboBoxCortador: TComboBox;
    lblCodItem: TLabel;
    lblNomeTecido: TLabel;
    lblCodTecido: TLabel;
    lblAviamento: TLabel;
    lblLocalizacao: TLabel;
    lblCusto: TLabel;
    edtCodProduto: TEdit;
    edtTecido: TEdit;
    edtCodTecido: TEdit;
    edtAviamento: TEdit;
    edtLocalizacao: TEdit;
    edtCusto: TEdit;
    lblNumTotalPecas: TLabel;
    DBGridFichaDeFaccao: TDBGrid;
    btnCriarFicha: TButton;
    btnConsultarFicha: TButton;
    lblDataEntrega: TLabel;
    CalendarDataDeEntrega: TCalendarPicker;
    btnSalvar: TButton;
    DSDadosProdutos: TDataSource;
    FDQueryProdutos: TFDQuery;
    lblNumFaccao: TLabel;
    lblStatusFaccao: TLabel;
    ComboBoxStatus: TComboBox;
    btnNovaFicha: TButton;
    DSDadosCortadores: TDataSource;
    FDQueryCortadores: TFDQuery;
    lblCodCortador: TLabel;
    edtCodCortador: TEdit;
    lblCodFaccao: TLabel;
    edtCodFaccao: TEdit;
    DSDadosFaccao: TDataSource;
    FDQueryFaccao: TFDQuery;
    btnRemover: TButton;
    DSDadosFichaDeFaccao: TDataSource;
    FDQueryFichaDeFaccao: TFDQuery;
    FDQueryFichaDeFaccaoNumCorte: TIntegerField;
    FDQueryFichaDeFaccaoDatadeCorte: TDateField;
    FDQueryFichaDeFaccaoNumOrdem: TIntegerField;
    FDQueryFichaDeFaccaoCodCort: TIntegerField;
    FDQueryFichaDeFaccaoCortador: TStringField;
    FDQueryFichaDeFaccaoCodFac: TIntegerField;
    FDQueryFichaDeFaccaoFac��o: TStringField;
    FDQueryFichaDeFaccaoDatadeEnvio: TDateField;
    FDQueryFichaDeFaccaoDatadePrevis�o: TDateField;
    FDQueryFichaDeFaccaodatadeEntrega: TDateField;
    FDQueryFichaDeFaccaoCodProd: TIntegerField;
    FDQueryFichaDeFaccaoProduto: TStringField;
    FDQueryFichaDeFaccaoCor: TStringField;
    FDQueryFichaDeFaccaoTamanho: TStringField;
    FDQueryFichaDeFaccaoQuantidade: TIntegerField;
    FDQueryFichaDeFaccaoStatus: TStringField;
    FDQueryFichaDeFaccaoidFaccao: TIntegerField;
    FDQueryFichaDeFaccaoidItemLista: TIntegerField;
    item: TEdit;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    Label2: TLabel;
    procedure edtCodRefChange(Sender: TObject);
    procedure edtCodRefKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxProdutosChange(Sender: TObject);
    procedure RadioButtonTamanhoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PreencherComboBoxCores;
    procedure PreencherComboboxStatus;
    procedure PreencherComboBoxCortador;
    procedure PreencherComboBoxProdutos;
    procedure PreencherComboBoxFaccao;
    procedure ComboBoxCortadorChange(Sender: TObject);
    procedure ComboBoxFaccaoChange(Sender: TObject);
    procedure btnCriarFichaClick(Sender: TObject);
    procedure HabilitarEdits;
    procedure DesabilitarEdits;
    procedure btnNovaFichaClick(Sender: TObject);
    procedure btnAdicionarItensClick(Sender: TObject);

    function GetNextNumFaccao: Integer;
    function GetNextIdItemLista(numFaccao: Integer): Integer;
    function GetTamanhoSelecionado: String;
    procedure btnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LimparCampos;
    procedure btnRemoverClick(Sender: TObject);
    procedure AjustarLarguraColunas(DBGrid: TDBGrid);
  private
    defaultDataEntrega, defaultDataEnvio, defaultDataPrevista, defaultDataCorte : TDateTime;
  public
    numFaccaoAtivo: Integer;
  end;

var
  FormFichaFaccao: TFormFichaFaccao;

implementation

{$R *.dfm}


procedure TFormFichaFaccao.AjustarLarguraColunas(DBGrid: TDBGrid);
var
  i, largura: Integer;
begin
  DBGrid.Columns.BeginUpdate;
  try
    for i := 0 to DBGrid.Columns.Count - 1 do
    begin
      largura := DBGrid.Canvas.TextWidth(DBGrid.Columns[i].Title.Caption) + 20; // T�tulo com padding
      DBGrid.Columns[i].Width := largura;

      DBGrid.DataSource.DataSet.First;
      while not DBGrid.DataSource.DataSet.Eof do
      begin
        largura := Max(largura, DBGrid.Canvas.TextWidth(DBGrid.DataSource.DataSet.Fields[i].AsString) + 20);
        DBGrid.DataSource.DataSet.Next;
      end;
      DBGrid.Columns[i].Width := largura;
    end;
  finally
    DBGrid.Columns.EndUpdate;
  end;
end;

function TFormFichaFaccao.GetTamanhoSelecionado: String;
var
  i: Integer;
  Control: TControl;
begin
  // Percorre todos os controles no PanelTamanhos
  for i := 0 to PanelTamanhos.ControlCount - 1 do
  begin
    Control := PanelTamanhos.Controls[i]; // Obt�m o controle pelo �ndice
    if Control is TRadioButton then
    begin
      // Verifica se o RadioButton est� selecionado
      if TRadioButton(Control).Checked then
      begin
        // Retorna o texto associado ao tamanho
        Result := TRadioButton(Control).Caption;
        Exit; // Sai da fun��o ap�s encontrar o selecionado
      end;
    end;
  end;

  // Caso nenhum RadioButton tenha sido selecionado, retorna uma string vazia
  Result := '';
end;

function TFormFichaFaccao.GetNextNumFaccao: Integer;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Form6.FDConnection1;
    Query.SQL.Text := 'SELECT COALESCE(MAX(idFaccao), 499999) + 1 AS ProximoNum FROM TBFichaDeFaccao';
    Query.Open;
    Result := Query.FieldByName('ProximoNum').AsInteger;
  finally
    Query.Free;
  end;
end;

function TFormFichaFaccao.GetNextIdItemLista(numFaccao: Integer): Integer;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Form6.FDConnection1;
    Query.SQL.Text :=
      'SELECT COALESCE(MAX(idItemLista), 0) + 1 AS ProximoItem ' +
      'FROM TBFichaDeFaccao ' +
      'WHERE idFaccao = :numFaccao';
    Query.ParamByName('numFaccao').AsInteger := numFaccao;
    Query.Open;
    Result := Query.FieldByName('ProximoItem').AsInteger;
  finally
    Query.Free;
  end;
end;

procedure TFormFichaFaccao.PreencherComboBoxCores;
var
  CaminhoArquivo: string;
begin
  // Caminho do arquivo
  CaminhoArquivo := ExtractFilePath(ParamStr(0)) + 'lista-cores.txt';

  // Verifica se o arquivo existe
  if not FileExists(CaminhoArquivo) then
  begin
    ShowMessage('Arquivo lista-cores.txt n�o encontrado!');
    Exit;
  end;

  // Limpa os itens do ComboBox e carrega do arquivo
  ComboBoxCores.Items.Clear;
  ComboBoxCores.Items.LoadFromFile(CaminhoArquivo);
end;

procedure TFormFichaFaccao.ComboBoxFaccaoChange(Sender: TObject);
begin
  if ComboBoxFaccao.ItemIndex <> -1 then
    edtCodFaccao.Text := IntToStr(Integer(ComboBoxFaccao.Items.Objects[ComboBoxFaccao.ItemIndex]));
end;

procedure TFormFichaFaccao.PreencherComboBoxCortador;
begin
  FDQueryCortadores.Open;

  ComboBoxCortador.Items.Clear;

  while not FDQueryCortadores.Eof do
  begin
    ComboBoxCortador.Items.AddObject(
      FDQueryCortadores.FieldByName('nomeCortador').AsString,
      TObject(FDQueryCortadores.FieldByName('codCortador').AsInteger)
    );
    FDQueryCortadores.Next;
  end;
end;

procedure TFormFichaFaccao.PreencherComboBoxFaccao;
begin
  FDQueryFaccao.Open;
//
  ComboBoxFaccao.Items.Clear;
//
  while not FDQueryFaccao.Eof do
  begin
    ComboBoxFaccao.Items.AddObject(
      FDQueryFaccao.FieldByName('nomeFaccao').AsString,
      TObject(FDQueryFaccao.FieldByName('codFaccao').AsInteger)
    );
    FDQueryFaccao.Next;
  end;
end;

procedure TFormFichaFaccao.PreencherComboBoxProdutos;
begin
  FDQueryProdutos.Active := true;

  ComboBoxProdutos.Items.Clear;

  while not FDQueryProdutos.Eof do
    begin
      ComboBoxProdutos.Items.Add(FDQueryProdutos.FieldByName('Produto').AsString); // Adiciona os nomes dos produtos ao ComboBox
      FDQueryProdutos.Next;
    end;

  FDQueryProdutos.Close; // Fecha a consulta ap�s carregar os dados
end;

procedure TFormFichaFaccao.PreencherComboboxStatus;
var
  CaminhoArquivo: string;
begin
  // Caminho do arquivo
  CaminhoArquivo := ExtractFilePath(ParamStr(0)) + 'lista-status-ficha.txt';

  // Verifica se o arquivo existe
  if not FileExists(CaminhoArquivo) then
  begin
    ShowMessage('Arquivo lista-cores.txt n�o encontrado!');
    Exit;
  end;

  // Limpa os itens do ComboBox e carrega do arquivo
  ComboBoxStatus.Items.Clear;
  ComboBoxStatus.Items.LoadFromFile(CaminhoArquivo);
end;

procedure TFormFichaFaccao.RadioButtonTamanhoClick(Sender: TObject);
var
  NomeProduto, TamanhoSelecionado: string;
begin

  if ComboBoxProdutos.ItemIndex < 0 then
  begin
    ShowMessage('Por favor, selecione um produto no ComboBox.');
    Exit;
  end;

  NomeProduto := ComboBoxProdutos.Text;

  // Obtem o tamanho selecionado no RadioButton
  if Sender is TRadioButton then
    TamanhoSelecionado := TRadioButton(Sender).Caption
  else
  begin
    ShowMessage('Erro ao identificar o tamanho selecionado.');
    Exit;
  end;

  try
    // Prepara a consulta para buscar as informa��es do produto e tamanho
    FDQueryProdutos.SQL.Text :=
      'SELECT codProduto, nomeTecido, codTecido, aviamentoProduto, localizacaoProduto, precoCusto ' +
      'FROM TBprodutos ' +
      'WHERE nomeProduto = :nomeProduto AND tamanhoProduto = :tamanhoProduto';
    FDQueryProdutos.ParamByName('nomeProduto').AsString := NomeProduto;
    FDQueryProdutos.ParamByName('tamanhoProduto').AsString := TamanhoSelecionado;
    FDQueryProdutos.Open;

    // Verifica se a consulta retornou resultados
    if not FDQueryProdutos.IsEmpty then
    begin
      edtCodProduto.Text := FDQueryProdutos.FieldByName('codProduto').AsString;
      edtTecido.Text := FDQueryProdutos.FieldByName('nomeTecido').AsString;
      edtCodTecido.Text := FDQueryProdutos.FieldByName('codTecido').AsString;
      edtAviamento.Text := FDQueryProdutos.FieldByName('aviamentoProduto').AsString;
      edtLocalizacao.Text := FDQueryProdutos.FieldByName('localizacaoProduto').AsString;
      edtCusto.Text := FormatFloat('0.00', FDQueryProdutos.FieldByName('precoCusto').AsFloat);
    end
    else
    begin
      ShowMessage('Nenhum registro encontrado para o produto e tamanho selecionados.');
    end;

    FDQueryProdutos.Close;
  except
    on E: Exception do
      ShowMessage('Erro ao buscar informa��es do produto: ' + E.Message);
  end;
end;


procedure TFormFichaFaccao.btnAdicionarItensClick(Sender: TObject);
var
  i : integer;
  Control: TControl;
  TamanhoSelecionado: Boolean;
  nextItemLista : integer;

  idItemLista : integer;

  TotalPecas: Integer;

  DataEntrega : TDateTime;
begin
  AjustarLarguraColunas(DBGridFichaDeFaccao);

  nextItemLista := GetNextIdItemLista(numFaccaoAtivo);

  TamanhoSelecionado := False;

  // Percorre todos os controles no PanelTamanhos
  for i := 0 to PanelTamanhos.ControlCount - 1 do
  begin
    Control := PanelTamanhos.Controls[i]; // Obt�m o controle pelo �ndice
    if Control is TRadioButton then
    begin
      // Verifica se o RadioButton est� selecionado
      if TRadioButton(Control).Checked then
      begin
        TamanhoSelecionado := True;
        Break; // J� encontrou um selecionado, pode parar o loop
      end;
    end;
  end;

     if Trim(ComboBoxProdutos.Text) = '' then
  begin
    ShowMessage('O campo "Modelo" n�o pode estar vazio. Por favor, insira um valor.');
    edtCodRef.SetFocus;
    Exit;
  end;


  // Valida se algum tamanho foi selecionado
  if not TamanhoSelecionado then
  begin
    ShowMessage('O campo "Tamanho" n�o pode estar vazio. Por favor, selecione um tamanho.');
    Exit; // Sai da fun��o para evitar a continua��o do processo
  end;


  // Valida se o campo edtQuantidade est� preenchido
  if Trim(edtQuantidade.Text) = '' then
  begin
    ShowMessage('O campo "Quantidade" n�o pode estar vazio. Por favor, insira um valor.');
    edtQuantidade.SetFocus;
    Exit;
  end;

  if Trim(ComboBoxCores.Text) = '' then
  begin
    ShowMessage('O campo "Cor" n�o pode estar vazio. Por favor, insira um valor.');
    ComboBoxCores.SetFocus;
    Exit;
  end;

  if Trim(edtNumCorte.Text) = '' then
  begin
    ShowMessage('O campo "N�mero de Corte" n�o pode estar vazio. Por favor, insira um valor.');
    edtNumCorte.SetFocus;
    Exit;
  end;

  if Trim(edtNumOrdemCorte.Text) = '' then
  begin
    ShowMessage('O campo "N�mero da Ordem de Corte" n�o pode estar vazio. Por favor, insira um valor.');
    edtNumOrdemCorte.SetFocus;
    Exit;
  end;

  if Trim(ComboBoxCortador.Text) = '' then
  begin
    ShowMessage('O campo "Cortador" n�o pode estar vazio. Por favor, insira um valor.');
    ComboBoxCortador.SetFocus;
    Exit;
  end;

  if Trim(ComboBoxFaccao.Text) = '' then
  begin
    ShowMessage('O campo "Fac��o" n�o pode estar vazio. Por favor, insira um valor.');
    ComboBoxFaccao.SetFocus;
    Exit;
  end;

  if (CalendarDataDeCorte.Date = defaultDataCorte) then
  begin
    ShowMessage('O campo "Data de Corte" n�o pode estar vazio. Por favor, insira um valor.');
    CalendarDataDeCorte.SetFocus;
    Exit;
  end;

    if Trim(ComboBoxStatus.Text) = '' then
  begin
    ShowMessage('O campo "Status" n�o pode estar vazio. Por favor, insira um valor.');
    ComboBoxStatus.SetFocus;
    Exit;
  end;

  //ShowMessage('Data Selecionada: ' + DateToStr(CalendarDataDeEntrega.Date));


  DSDadosFichaDeFaccao.DataSet.Insert;

  // Campos obrigat�rios com valores corretos

  DSDadosFichaDeFaccao.DataSet.FieldByName('idFaccao').AsInteger := numFaccaoAtivo;
  DSDadosFichaDeFaccao.DataSet.FieldByName('idItemLista').AsInteger := GetNextIdItemLista(numFaccaoAtivo);

  DSDadosFichaDeFaccao.DataSet.FieldByName('Num Corte').AsInteger := StrToIntDef(edtNumCorte.Text, 0);


  if (CalendarDataDeCorte.Date <> defaultDataCorte) then
    DSDadosFichaDeFaccao.DataSet.FieldByName('Data de Corte').AsDateTime := CalendarDataDeCorte.Date
  else
    DSDadosFichaDeFaccao.DataSet.FieldByName('Data de Corte').Clear;

  DSDadosFichaDeFaccao.DataSet.FieldByName('Num Ordem').AsInteger := StrToIntDef(edtNumOrdemCorte.Text, 0);
  DSDadosFichaDeFaccao.DataSet.FieldByName('Cod. Cort').AsInteger := StrToIntDef(edtCodCortador.Text, 0);
  DSDadosFichaDeFaccao.DataSet.FieldByName('Cortador').AsString := ComboBoxCortador.Text;
  DSDadosFichaDeFaccao.DataSet.FieldByName('Cod. Fac').AsInteger := StrToIntDef(edtCodFaccao.Text, 0);
  DSDadosFichaDeFaccao.DataSet.FieldByName('Fac��o').AsString := ComboBoxFaccao.Text;

  if (CalendarDataDeEnvio.Date <> defaultDataEnvio) then
  DSDadosFichaDeFaccao.DataSet.FieldByName('Data de Envio').AsDateTime := CalendarDataDeEnvio.Date
  else
    DSDadosFichaDeFaccao.DataSet.FieldByName('Data de Envio').Clear;

  if (CalendarDataPrevista.Date <> defaultDataPrevista) then
    DSDadosFichaDeFaccao.DataSet.FieldByName('Data de Previs�o').AsDateTime := CalendarDataPrevista.Date
  else
    DSDadosFichaDeFaccao.DataSet.FieldByName('Data de Previs�o').Clear;

  if (CalendarDataDeEntrega.Date <> defaultDataEntrega) then
    DSDadosFichaDeFaccao.DataSet.FieldByName('Data de Entrega').AsDateTime := CalendarDataDeEntrega.Date
  else
    DSDadosFichaDeFaccao.DataSet.FieldByName('Data de Entrega').Clear;

  DSDadosFichaDeFaccao.DataSet.FieldByName('Cod. Prod').AsInteger := StrToIntDef(edtCodProduto.Text, 0);
  DSDadosFichaDeFaccao.DataSet.FieldByName('Produto').AsString := ComboBoxProdutos.Text;

  DSDadosFichaDeFaccao.DataSet.FieldByName('Cor').AsString := ComboBoxCores.Text;
  DSDadosFichaDeFaccao.DataSet.FieldByName('Tamanho').AsString := GetTamanhoSelecionado;
  DSDadosFichaDeFaccao.DataSet.FieldByName('Quantidade').AsInteger := StrToIntDef(edtQuantidade.Text, 0);
  DSDadosFichaDeFaccao.DataSet.FieldByName('Status').AsString := ComboBoxStatus.Text;

  TotalPecas := 0; // Inicializa o contador
  DSDadosFichaDeFaccao.DataSet.First; // Vai para o primeiro registro

  // Somar as quantidades de pe�as dos itens na tabela
  while not DSDadosFichaDeFaccao.DataSet.Eof do
  begin
    TotalPecas := TotalPecas + DSDadosFichaDeFaccao.DataSet.FieldByName('Quantidade').AsInteger;
    DSDadosFichaDeFaccao.DataSet.Next; // Vai para o pr�ximo registro
  end;

  // Atualiza o label com a quantidade total de pe�as
  lblNumTotalPecas.Caption := 'N� de pe�as: ' + IntToStr(TotalPecas);

  // Postar os dados ap�s a inser��o
  //DSDadosFichaDeFaccao.DataSet.Post;

  //DSDadosFichaDeFaccao.DataSet.Post;

  FDQueryFichaDeFaccao.Append;
  FDQueryFichaDeFaccao.Last;

  ComboBoxProdutos.Enabled := false;
  edtCodRef.Enabled := false;

  edtQuantidade.Clear;
end;

procedure TFormFichaFaccao.btnNovaFichaClick(Sender: TObject);
begin
  Self.Close; // Fecha o formul�rio atual
  Application.CreateForm(TFormFichaFaccao, FormFichaFaccao); // Cria uma nova inst�ncia do formul�rio
  FormFichaFaccao.Show; // Mostra o formul�rio recriado

//  DesabilitarEdits;
//  LimparCampos;
//
//  lblNumFaccao.Caption := 'N� Fac��o: ';
//
//  FDQueryFichaDeFaccao.Active := false;
//
//  btnConsultarFicha.Enabled := true;
//  btnCriarFicha.Enabled := true;
//  btnAdicionarItens.Enabled := false;
//  btnRemover.Enabled := false;
//  btnNovaFicha.Enabled := false;
//  btnSalvar.Enabled := false;
//  btnGerarFicha.Enabled := false;
end;

procedure TFormFichaFaccao.btnCriarFichaClick(Sender: TObject);
var
  NovoNumFaccao: Integer;
begin
  FDQueryFichaDeFaccao.Active := true;

  FDQueryFichaDeFaccao.Close;

  FDQueryFichaDeFaccao.SQL.Text :=
  'SELECT idFaccao, ' +
  '       numCorte as ''Num Corte'', ' +
  '       dataCorte as ''Data de Corte'', ' +
  '       numOrdem as ''Num Ordem'', ' +
  '       codCortador as ''Cod. Cort'', ' +
  '       nomeCortador as ''Cortador'', ' +
  '       codFaccao as ''Cod. Fac'', ' +
  '       nomeFaccao as ''Fac��o'', ' +
  '       dataEnvio as ''Data de Envio'', ' +
  '       dataPrevisao as ''Data de Previs�o'', ' +
  '       dataEntrega as ''data de Entrega'', ' +
  '       codProduto as ''Cod. Prod'', ' +
  '       nomeProduto as ''Produto'', ' +
  '       idItemLista, ' +
  '       corTecido as ''Cor'', ' +
  '       tamanhoPecas as ''Tamanho'', ' +
  '       quantidadePecas as ''Quantidade'', ' +
  '       statusOrdem as ''Status'' ' +
  'FROM TBFichaDeFaccao ' +
  'WHERE idFaccao = :idFaccao';

  FDQueryFichaDeFaccao.ParamByName('idFaccao').AsInteger := numFaccaoAtivo;


  FDQueryFichaDeFaccao.Open;

  defaultDataCorte := CalendarDataDeCorte.Date;
  defaultDataEntrega := CalendarDataDeEntrega.Date;
  defaultDataEnvio := CalendarDataDeEnvio.Date;
  defaultDataPrevista := CalendarDataPrevista.Date;

  NovoNumFaccao := GetNextNumFaccao;
  numFaccaoAtivo := NovoNumFaccao;


  lblNumFaccao.Caption := lblNumFaccao.Caption + ' ' + IntToStr(NovoNumFaccao);

  HabilitarEdits;

  lblNumFaccao.Enabled := true;
  lblNumTotalPecas.Enabled := true;

  btnAdicionarItens.Enabled := true;
  btnRemover.Enabled := true;
  btnNovaFicha.Enabled := true;
  btnSalvar.Enabled := true;
  btnGerarFicha.Enabled := true;

  btnConsultarFicha.Enabled := false;
  btnNovaFicha.Enabled := true;
  btnCriarFicha.Enabled := false;

//  btnCriarFicha.Caption := 'Criar Nova Ficha';
//
//  if Application.MessageBox(PChar(Format('%s' + #13 + '[%s]',
//    ['Deseja criar uma nova ficha de fac��o?',
//    'Os campos ser�o limpos para a nova ficha.'])),
//    'Aten��o',
//    MB_ICONQUESTION + MB_YESNO) = IDYES then
//    btnNovaFichaClick(btnNovaFicha);

  btnCriarFicha.Visible := false;
  btnNovaFicha.Visible := true;

end;

procedure TFormFichaFaccao.btnRemoverClick(Sender: TObject);
var
  idItem, TotalPecas: Integer;
begin
  if Application.MessageBox(PChar(Format('%s' + #13 + '[%s]',
    ['Deseja realmente excluir este Item?',
    'Modelo: ' + DSDadosFichaDeFaccao.DataSet.FieldByName('Produto').AsString +
    ' - Tamanho: ' + DSDadosFichaDeFaccao.DataSet.FieldByName('Tamanho').AsString +
    ' - Cor: ' + DSDadosFichaDeFaccao.DataSet.FieldByName('Cor').AsString])),
    'Aten��o',
    MB_ICONQUESTION + MB_YESNO) = IDYES then
    begin

      idItem := StrToIntDef(item.Text, -1); // -1 como valor padr�o para indicar erro
      if idItem = -1 then
      begin
        ShowMessage('ID do item inv�lido.');
        Exit;
      end;

      try
        // Exclui o item espec�fico
        FDQueryFichaDeFaccao.Close;
        FDQueryFichaDeFaccao.SQL.Text :=
          'DELETE FROM TBFichaDeFaccao WHERE idFaccao = :idFaccao AND idItemLista = :idItemLista';
        FDQueryFichaDeFaccao.ParamByName('idFaccao').AsInteger := numFaccaoAtivo;
        FDQueryFichaDeFaccao.ParamByName('idItemLista').AsInteger := idItem;
        FDQueryFichaDeFaccao.ExecSQL;

        // Atualiza o grid ap�s a exclus�o
        FDQueryFichaDeFaccao.Close;
        FDQueryFichaDeFaccao.SQL.Text :=
        'SELECT idFaccao, ' +
        '       numCorte as ''Num Corte'', ' +
        '       dataCorte as ''Data de Corte'', ' +
        '       numOrdem as ''Num Ordem'', ' +
        '       codCortador as ''Cod. Cort'', ' +
        '       nomeCortador as ''Cortador'', ' +
        '       codFaccao as ''Cod. Fac'', ' +
        '       nomeFaccao as ''Fac��o'', ' +
        '       dataEnvio as ''Data de Envio'', ' +
        '       dataPrevisao as ''Data de Previs�o'', ' +
        '       dataEntrega as ''data de Entrega'', ' +
        '       codProduto as ''Cod. Prod'', ' +
        '       nomeProduto as ''Produto'', ' +
        '       idItemLista, ' +
        '       corTecido as ''Cor'', ' +
        '       tamanhoPecas as ''Tamanho'', ' +
        '       quantidadePecas as ''Quantidade'', ' +
        '       statusOrdem as ''Status'' ' +
        'FROM TBFichaDeFaccao ' +
        'WHERE idFaccao = :idFaccao';

        FDQueryFichaDeFaccao.ParamByName('idFaccao').AsInteger := numFaccaoAtivo;
        FDQueryFichaDeFaccao.Open;

        //ShowMessage('Item removido com sucesso!');
      except
        on E: Exception do
          ShowMessage('Erro ao remover o item: ' + E.Message);
      end;
    end;


  TotalPecas := 0; // Inicializa o contador
  DSDadosFichaDeFaccao.DataSet.First; // Vai para o primeiro registro

  // Somar as quantidades de pe�as dos itens na tabela
  while not DSDadosFichaDeFaccao.DataSet.Eof do
  begin
    TotalPecas := TotalPecas + DSDadosFichaDeFaccao.DataSet.FieldByName('Quantidade').AsInteger;
    DSDadosFichaDeFaccao.DataSet.Next; // Vai para o pr�ximo registro
  end;

  // Atualiza o label com a quantidade total de pe�as
  lblNumTotalPecas.Caption := 'N� de pe�as: ' + IntToStr(TotalPecas);


end;




procedure TFormFichaFaccao.btnSalvarClick(Sender: TObject);
begin
  DSDadosFichaDeFaccao.DataSet.Post;
end;

procedure TFormFichaFaccao.ComboBoxCortadorChange(Sender: TObject);
begin
if ComboBoxCortador.ItemIndex <> -1 then
    edtCodCortador.Text := IntToStr(Integer(ComboBoxCortador.Items.Objects[ComboBoxCortador.ItemIndex]));
end;

procedure TFormFichaFaccao.ComboBoxProdutosChange(Sender: TObject);
var
  Tamanho: string;
  PosicaoX: Integer;
  PosicaoY: Integer;
  NovoRadioButton: TRadioButton;
  RadioButtonExiste: Boolean;
  i: Integer;
  Ctrl: TControl;
begin
  // Remove manualmente todos os controles no PanelTamanhos
  for i := PanelTamanhos.ControlCount - 1 downto 0 do
  begin
    Ctrl := PanelTamanhos.Controls[i];
    if Ctrl is TRadioButton then
      Ctrl.Free; // Libera a mem�ria do RadioButton
  end;

  // Verifica se o ComboBoxProduto n�o est� vazio
  if ComboBoxProdutos.ItemIndex > -1 then
  begin
    try
      // Modifica a consulta do FDQueryProdutos para buscar os tamanhos distintos do produto selecionado
      FDQueryProdutos.SQL.Text :=
        'SELECT DISTINCT tamanhoProduto FROM TBprodutos ' +
        'WHERE nomeProduto = :nomeProduto ' +
        'ORDER BY ' +
        '  CASE ' +
        '    WHEN tamanhoProduto = ''P'' THEN 1 ' +
        '    WHEN tamanhoProduto = ''M'' THEN 2 ' +
        '    WHEN tamanhoProduto = ''G'' THEN 3 ' +
        '    WHEN tamanhoProduto = ''GG'' THEN 4 ' +
        '    WHEN tamanhoProduto = ''48'' THEN 5 ' +
        '    WHEN tamanhoProduto = ''50'' THEN 6 ' +
        '    WHEN tamanhoProduto = ''52'' THEN 7 ' +
        '    WHEN tamanhoProduto = ''54'' THEN 8 ' +
        '    WHEN tamanhoProduto = ''56'' THEN 9 ' +
        '    WHEN tamanhoProduto = ''58'' THEN 10 ' +
        '    ELSE 11 ' +
        '  END';
      FDQueryProdutos.ParamByName('nomeProduto').AsString := ComboBoxProdutos.Text;
      FDQueryProdutos.Open;

      // Verifica se a consulta retornou dados
      if not FDQueryProdutos.IsEmpty then
      begin
        // Posi��es iniciais para os RadioButtons
        PosicaoX := 10;  // Come�a na posi��o horizontal 10
        PosicaoY := 10;  // Come�a na posi��o vertical 10

        // Cria os RadioButtons com base nos tamanhos dispon�veis
        while not FDQueryProdutos.Eof do
        begin
          Tamanho := FDQueryProdutos.FieldByName('tamanhoProduto').AsString;

          // Verifica se j� existe um RadioButton com o nome baseado no tamanho
          RadioButtonExiste := False;

          // Itera sobre os controles do PanelTamanhos usando um �ndice
          for i := 0 to PanelTamanhos.ControlCount - 1 do
          begin
            if (PanelTamanhos.Controls[i] is TRadioButton) and
               (TRadioButton(PanelTamanhos.Controls[i]).Caption = Tamanho) then
            begin
              RadioButtonExiste := True;
              Break; // Sai do loop se encontrar um j� existente
            end;
          end;

          // Se n�o encontrar um RadioButton com o mesmo nome, cria um novo
          if not RadioButtonExiste then
          begin
            // Cria um novo RadioButton para cada tamanho dispon�vel
            NovoRadioButton := TRadioButton.Create(Self);
            NovoRadioButton.Parent := PanelTamanhos;
            NovoRadioButton.Caption := Tamanho;
            NovoRadioButton.Left := PosicaoX;
            NovoRadioButton.Top := PosicaoY;
            NovoRadioButton.Name := 'rb' + Tamanho; // Nome �nico para cada RadioButton
            NovoRadioButton.Width := 40;  // Largura do RadioButton
            NovoRadioButton.Height := 25;  // Altura do RadioButton 25
            NovoRadioButton.Tag := Integer(Tamanho); // Armazena o tamanho como tag

            NovoRadioButton.OnClick := RadioButtonTamanhoClick;
          end;

          // Atualiza a posi��o horizontal (Left) com um pequeno espa�amento
          PosicaoX := PosicaoX + NovoRadioButton.Width + 10;  // Largura do RadioButton + 10 pixels de espa�o

          // Se a posi��o X ultrapassar a largura do painel, move para a pr�xima linha
          if PosicaoX + NovoRadioButton.Width > PanelTamanhos.Width then
          begin
            PosicaoX := 10;  // Reseta a posi��o horizontal para 10
            PosicaoY := PosicaoY + 15;  // Move para a pr�xima linha (Ajuste a altura conforme necess�rio)    35
          end;

          FDQueryProdutos.Next;
        end;
      end
      else
      begin
        // Caso n�o encontre nenhum tamanho para o produto, adicione uma mensagem ou a��o alternativa
        ShowMessage('Nenhum tamanho dispon�vel para o produto selecionado.');
      end;

      FDQueryProdutos.Close;  // Fechar a consulta ap�s us�-la
    except
      on E: Exception do
      begin
        ShowMessage('Erro ao carregar os tamanhos: ' + E.Message);
      end;
    end;
  end;
end;

procedure TFormFichaFaccao.DesabilitarEdits;
begin
  lblRaddioButtonBusca.Enabled := false;
  rbBuscaCodigo.Enabled := false;
  rbBuscaReferencia.Enabled := false;

  lblCodRef.Enabled := false;
  edtCodRef.Enabled := false;

  lblSelecionarModelo.Enabled := false;
  ComboBoxProdutos.Enabled := false;

  lblTamanhos.Enabled := false;
  PanelTamanhos.Enabled := false;

  lblQuantidade.Enabled := false;
  edtQuantidade.Enabled := false;

  lblCores.Enabled := false;
  ComboBoxCores.Enabled := false;

  lblNumCorte.Enabled := false;
  edtNumCorte.Enabled := false;

  lblNumOrdemCorte.Enabled := false;
  edtNumOrdemCorte.Enabled := false;

  lblFaccao.Enabled := false;
  lblCodFaccao.Enabled := false;
  ComboBoxFaccao.Enabled := false;

  lblCortador.Enabled := false;
  lblCodCortador.Enabled := false;
  ComboBoxCortador.Enabled := false;

  lblStatusFaccao.Enabled := false;
  ComboBoxStatus.Enabled := false;

  lblDataCorte.Enabled := false;
  CalendarDataDeCorte.Enabled := false;

  lblDataEnvio.Enabled := false;
  CalendarDataDeEnvio.Enabled := false;

  CalendarDataPrevista.Enabled := false;
  CalendarDataPrevista.Enabled := false;

  lblDataEntrega.Enabled := false;
  CalendarDataDeEntrega.Enabled := false;

  lblCodItem.Enabled := false;
  lblCusto.Enabled := false;
  lblLocalizacao.Enabled := false;
  lblCodTecido.Enabled := false;
  lblNomeTecido.Enabled := false;
  lblAviamento.Enabled := false;
end;

procedure TFormFichaFaccao.edtCodRefChange(Sender: TObject);
var
  CodigoProduto: String;
  RefProduto: String;
begin
  if rbBuscaCodigo.Checked then
  begin
    CodigoProduto := Trim(edtCodRef.Text); // Captura e limpa o texto digitado no TEdit

  // Busca o nome do produto correspondente ao c�digo digitado
  FDQueryProdutos.Close;
  FDQueryProdutos.SQL.Text := 'SELECT nomeProduto as Produto FROM TBProdutos WHERE codProduto = :codProduto';
  FDQueryProdutos.ParamByName('codProduto').AsString := CodigoProduto;
  FDQueryProdutos.Open;

  if not FDQueryProdutos.IsEmpty then
  begin
    // Atualiza o ComboBox com o produto encontrado
    ComboBoxProdutos.Text := FDQueryProdutos.FieldByName('Produto').AsString;

    // Dispara manualmente o evento OnChange do ComboBox
    if Assigned(ComboBoxProdutos.OnChange) then
      ComboBoxProdutos.OnChange(ComboBoxProdutos);
  end
  else
  begin
    // Caso n�o encontre, limpa o ComboBox
    ComboBoxProdutos.Text := '';
  end;

  FDQueryProdutos.Close; // Fecha a consulta ap�s uso
  end;


  if rbBuscaReferencia.Checked then
  begin
    RefProduto := Trim(edtCodRef.Text); // Captura e limpa o texto digitado no TEdit

  // Busca o nome do produto correspondente � refer�ncia digitada
    FDQueryProdutos.Close;
    FDQueryProdutos.SQL.Text := 'SELECT nomeProduto as Produto FROM TBProdutos WHERE refProduto = :refProduto';
    FDQueryProdutos.ParamByName('refProduto').AsString := RefProduto;
    FDQueryProdutos.Open;

    if not FDQueryProdutos.IsEmpty then
    begin
      // Atualiza o ComboBox com o produto encontrado
      ComboBoxProdutos.Text := FDQueryProdutos.FieldByName('Produto').AsString;

      // Dispara manualmente o evento OnChange do ComboBox
      if Assigned(ComboBoxProdutos.OnChange) then
        ComboBoxProdutos.OnChange(ComboBoxProdutos);
    end
    else
    begin
      // Caso n�o encontre, limpa o ComboBox
      ComboBoxProdutos.Text := '';
    end;

    FDQueryProdutos.Close; // Fecha a consulta ap�s uso
  end;

end;


procedure TFormFichaFaccao.edtCodRefKeyPress(Sender: TObject; var Key: Char);
begin
  Key := UpCase(Key);

  if Key = #13 then // Verifica se a tecla pressionada � Enter
  begin
    Key := #0; // Cancela o som do Enter
    ComboBoxProdutos.OnChange(ComboBoxProdutos);
  end;
end;

procedure TFormFichaFaccao.FormCreate(Sender: TObject);
begin
  AjustarLarguraColunas(DBGridFichaDeFaccao);

  FormatSettings.DecimalSeparator := ',';
  FormatSettings.ThousandSeparator := '.';

  PreencherComboboxCores;
  PreencherComboBoxCortador;
  PreencherComboBoxFaccao;
  PreencherComboBoxStatus;
  PreencherComboBoxProdutos;



end;

procedure TFormFichaFaccao.FormShow(Sender: TObject);
begin
  FDQueryFichaDeFaccao.IndexFieldNames := 'idItemLista';

//  CalendarDataDeCorte.Date := null;
//  CalendarDataDeEnvio.Date := null;
//  CalendarDataPrevista.Date := null;
//  CalendarDataDeEntrega.Date := null;
end;

procedure TFormFichaFaccao.HabilitarEdits;
begin
  lblRaddioButtonBusca.Enabled := true;
  rbBuscaCodigo.Enabled := true;
  rbBuscaReferencia.Enabled := true;

  lblCodRef.Enabled := true;
  edtCodRef.Enabled := true;

  lblSelecionarModelo.Enabled := true;
  ComboBoxProdutos.Enabled := true;

  lblTamanhos.Enabled := true;
  PanelTamanhos.Enabled := true;

  lblQuantidade.Enabled := true;
  edtQuantidade.Enabled := true;

  lblCores.Enabled := true;
  ComboBoxCores.Enabled := true;

  lblNumCorte.Enabled := true;
  edtNumCorte.Enabled := true;

  lblNumOrdemCorte.Enabled := true;
  edtNumOrdemCorte.Enabled := true;

  lblFaccao.Enabled := true;
  lblCodFaccao.Enabled := true;
  ComboBoxFaccao.Enabled := true;

  lblCortador.Enabled := true;
  lblCodCortador.Enabled := true;
  ComboBoxCortador.Enabled := true;

  lblStatusFaccao.Enabled := true;
  ComboBoxStatus.Enabled := true;

  lblDataCorte.Enabled := true;
  CalendarDataDeCorte.Enabled := true;

  lblDataEnvio.Enabled := true;
  CalendarDataDeEnvio.Enabled := true;

  lblDataPrevista.Enabled := true;
  CalendarDataPrevista.Enabled := true;

  lblDataEntrega.Enabled := true;
  CalendarDataDeEntrega.Enabled := true;

  lblCodItem.Enabled := true;
  lblCusto.Enabled := true;
  lblLocalizacao.Enabled := true;
  lblCodTecido.Enabled := true;
  lblNomeTecido.Enabled := true;
  lblAviamento.Enabled := true;
end;

procedure TFormFichaFaccao.LimparCampos;
begin
  edtCodRef.Clear;
  edtQuantidade.Clear;
  edtNumCorte.Clear;
  edtNumOrdemCorte.Clear;

  ComboBoxFaccao.Text := '';
  ComboBoxCortador.Text := '';
  ComboBoxStatus.Text := '';
  ComboBoxCores.Text := '';

  CalendarDataDeCorte.Date := defaultDataCorte;
  CalendarDataDeEnvio.Date := defaultDataEnvio;
  CalendarDataPrevista.Date := defaultDataPrevista;
  CalendarDataDeEntrega.Date := defaultDataEntrega;
end;


end.
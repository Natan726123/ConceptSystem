unit uFormConsultaFichaFaccao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.WinXCalendars, Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uMainModulo, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, Math, DateUtils,
  Vcl.Imaging.pngimage, uFormRelFichaFaccao1via, uFormRelFichaFaccao2via;

type
  TFormConsultaFichaFaccao = class(TForm)
    pnlModelos: TPanel;
    lblSelecionarModelo: TLabel;
    lblCodRef: TLabel;
    lblRaddioButtonBusca: TLabel;
    lblDataCorte: TLabel;
    lblFaccao: TLabel;
    lblNumCorte: TLabel;
    lblNumOrdemCorte: TLabel;
    lblDataEnvio: TLabel;
    lblDataPrevista: TLabel;
    lblCortador: TLabel;
    lblDataEntrega: TLabel;
    lblStatusFaccao: TLabel;
    lblCodCortador: TLabel;
    lblCodFaccao: TLabel;
    ComboBoxProdutos: TComboBox;
    btnGerarFicha: TButton;
    edtCodRef: TEdit;
    rbBuscaCodigo: TRadioButton;
    rbBuscaReferencia: TRadioButton;
    CalendarDataDeCorte: TCalendarPicker;
    ComboBoxFaccao: TComboBox;
    edtNumCorte: TEdit;
    edtNumOrdemCorte: TEdit;
    CalendarDataDeEnvio: TCalendarPicker;
    CalendarDataPrevista: TCalendarPicker;
    ComboBoxCortador: TComboBox;
    btnConsultarFicha: TButton;
    CalendarDataDeEntrega: TCalendarPicker;
    btnSalvar: TButton;
    ComboBoxStatus: TComboBox;
    edtCodCortador: TEdit;
    edtCodFaccao: TEdit;
    DBGridFichaDeFaccao: TDBGrid;
    Label1: TLabel;
    DSDadosProdutos: TDataSource;
    FDQueryProdutos: TFDQuery;
    DSDadosFaccao: TDataSource;
    FDQueryFaccao: TFDQuery;
    FDQueryConsultaFichaFaccao: TFDQuery;
    DSDadosConsultaFichaFaccao: TDataSource;
    Label2: TLabel;
    dtpDataInicial: TCalendarPicker;
    Label3: TLabel;
    dtpDataFinal: TCalendarPicker;
    btnAlterar: TButton;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField2: TLinkFillControlToField;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkPropertyToFieldDateFormat: TLinkPropertyToField;
    UpdateSQLConsultaFicha: TFDUpdateSQL;
    LinkPropertyToFieldDate: TLinkPropertyToField;
    LinkPropertyToFieldDate2: TLinkPropertyToField;
    LinkPropertyToFieldDate3: TLinkPropertyToField;
    btnAttData: TButton;
    Image1: TImage;
    DSDadosFichaDeFaccao: TDataSource;
    FDQueryFichaDeFaccao: TFDQuery;
    FDQueryFichaDeFaccaoItem: TIntegerField;
    FDQueryFichaDeFaccaoCor: TStringField;
    FDQueryFichaDeFaccaoTamanho: TStringField;
    FDQueryFichaDeFaccaoQuantidade: TIntegerField;
    FDQueryFichaDeFaccaoCodProd: TIntegerField;
    FDQueryFichaDeFaccaoProduto: TStringField;
    FDQueryFichaDeFaccaoidFaccao: TIntegerField;
    FDQueryFichaDeFaccaoNumCorte: TIntegerField;
    FDQueryFichaDeFaccaoCodCort: TIntegerField;
    FDQueryFichaDeFaccaoCortador: TStringField;
    FDQueryFichaDeFaccaoCodFac: TIntegerField;
    FDQueryFichaDeFaccaoFac��o: TStringField;
    FDQueryFichaDeFaccaoDatadeCorte: TDateField;
    FDQueryFichaDeFaccaoNumOrdem: TIntegerField;
    FDQueryFichaDeFaccaoDatadeEnvio: TDateField;
    FDQueryFichaDeFaccaoDatadePrevis�o: TDateField;
    FDQueryFichaDeFaccaodatadeEntrega: TDateField;
    FDQueryFichaDeFaccaoStatus: TStringField;
    FDQueryRelFichaFaccao: TFDQuery;
    DSDadosRelFichaFaccao: TDataSource;
    edtNumFaccao: TEdit;
    Label4: TLabel;
    LinkControlToField4: TLinkControlToField;
    procedure FormCreate(Sender: TObject);
    procedure PreencherComboBoxFaccao;
    procedure PreencherComboBoxProdutos;
    procedure PreencherComboboxStatus;
    procedure edtCodRefChange(Sender: TObject);
    procedure ComboBoxFaccaoChange(Sender: TObject);
    procedure btnConsultarFichaClick(Sender: TObject);
    procedure AjustarLarguraColunas(DBGrid: TDBGrid);
    procedure DSDadosConsultaFichaFaccaoDataChange(Sender: TObject;
      Field: TField);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnGerarFichaClick(Sender: TObject);
    procedure imprimirFicha1via;
    procedure imprimirFicha2via;
  private
    FAtualizandoCalendarios: Boolean; // Vari�vel de controle
    idFaccaoAtivo: Integer;
    attDataEnvio, attDataPrevista, attDataEntrega : TDateTime;
  public
    { Public declarations }
  end;

var
  FormConsultaFichaFaccao: TFormConsultaFichaFaccao;

implementation

{$R *.dfm}

procedure TFormConsultaFichaFaccao.AjustarLarguraColunas(DBGrid: TDBGrid);
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

procedure TFormConsultaFichaFaccao.PreencherComboBoxFaccao;
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

procedure TFormConsultaFichaFaccao.PreencherComboBoxProdutos;
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

procedure TFormConsultaFichaFaccao.PreencherComboboxStatus;
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

procedure TFormConsultaFichaFaccao.btnConsultarFichaClick(Sender: TObject);
begin
  // Valida��o dos filtros
  if Trim(ComboboxProdutos.Text) = '' then
  begin
    ShowMessage('Informe o nome do produto.');
    Exit;
  end;

//  if Trim(edtCodFaccao.Text) = '' then
//  begin
//    ShowMessage('Informe o c�digo da fac��o.');
//    Exit;
//  end;

  if dtpDataInicial.Date > dtpDataFinal.Date then
  begin
    ShowMessage('A data inicial n�o pode ser maior que a data final.');
    Exit;
  end;

  // Prepara a consulta
  FDQueryConsultaFichaFaccao.Close;
  FDQueryConsultaFichaFaccao.SQL.Text :=
    'SELECT idFaccao, dataCriacao, ' +
    '       nomeProduto AS Modelo, ' +
    '       corTecido AS Cor, ' +
    '       SUM(CASE WHEN tamanhoPecas = ''P'' THEN quantidadePecas ELSE 0 END) AS Tam_P, ' +
    '       SUM(CASE WHEN tamanhoPecas = ''M'' THEN quantidadePecas ELSE 0 END) AS Tam_M, ' +
    '       SUM(CASE WHEN tamanhoPecas = ''G'' THEN quantidadePecas ELSE 0 END) AS Tam_G, ' +
    '       SUM(CASE WHEN tamanhoPecas = ''GG'' THEN quantidadePecas ELSE 0 END) AS Tam_GG, ' +
    '       SUM(CASE WHEN tamanhoPecas = ''48'' THEN quantidadePecas ELSE 0 END) AS Tam_48, ' +
    '       SUM(CASE WHEN tamanhoPecas = ''50'' THEN quantidadePecas ELSE 0 END) AS Tam_50, ' +
    '       SUM(CASE WHEN tamanhoPecas = ''52'' THEN quantidadePecas ELSE 0 END) AS Tam_52, ' +
    '       statusOrdem AS Status, ' +
    '       STRFTIME(''%d/%m/%Y'', dataCorte) AS DataCorte, ' +
    '       STRFTIME(''%d/%m/%Y'', DataEnvio)  AS DataEnvio, ' +
    '       STRFTIME(''%d/%m/%Y'', DataPrevisao) AS DataPrevisao, ' +
    '       STRFTIME(''%d/%m/%Y'', DataEntrega) AS DataEntrega, ' +
    '       numCorte, numOrdem, codCortador, nomeCortador ' +
    'FROM TBFichaDeFaccao ' +
    'WHERE nomeProduto = :nomeProduto AND ' +
    '      codFaccao = :codFaccao AND ' +
    '      dataCriacao BETWEEN :dataInicial AND :dataFinal ' +
    'GROUP BY nomeProduto, corTecido, statusOrdem ' +
    'ORDER BY idFaccao, dataCriacao, nomeProduto, corTecido';

  // Atribui os par�metros
  FDQueryConsultaFichaFaccao.ParamByName('nomeProduto').AsString := ComboBoxProdutos.Text;
  FDQueryConsultaFichaFaccao.ParamByName('codFaccao').AsInteger := StrToIntDef(edtCodFaccao.Text, 0);
  FDQueryConsultaFichaFaccao.ParamByName('dataInicial').AsDate := dtpDataInicial.Date;
  FDQueryConsultaFichaFaccao.ParamByName('dataFinal').AsDate := dtpDataFinal.Date;

  // Executa a consulta
  try
    FDQueryConsultaFichaFaccao.Open;
  except
    on E: Exception do
      ShowMessage('Erro ao executar a consulta: ' + E.Message);
  end;

  AjustarLarguraColunas(DBGridFichaDeFaccao);
  //DSDadosConsultaFichaFaccao.DataSet.Edit;
end;

procedure TFormConsultaFichaFaccao.btnGerarFichaClick(Sender: TObject);
var
  Dialog: TForm;
  BtnPrimeiraVia, BtnSegundaVia, BtnCancelar: TButton;
  FormWidth, FormHeight, ButtonSpacing, ButtonTop: Integer;
begin
  if FDQueryConsultaFichaFaccao.IsEmpty then
  begin
    ShowMessage('Nenhum dado encontrado para o relat�rio.');
    Exit;
  end;

  // Configura��es gerais
  FormWidth := 400;       // Largura do formul�rio
  FormHeight := 100;      // Altura do formul�rio
  ButtonSpacing := 20;    // Espa�amento entre os bot�es
  ButtonTop := 50;       // Dist�ncia dos bot�es ao topo do formul�rio

  // Cria o formul�rio do di�logo
  Dialog := CreateMessageDialog('Deseja imprimir a 1� ou 2� via?', mtConfirmation, []);
  try
    Dialog.Caption := 'Escolha a via';
    Dialog.ClientWidth := FormWidth;  // Ajusta a largura do formul�rio
    Dialog.ClientHeight := FormHeight; // Ajusta a altura do formul�rio
    Dialog.Position := poScreenCenter; // Centraliza na tela

    // Cria o bot�o para a 1� via
    BtnPrimeiraVia := TButton.Create(Dialog);
    BtnPrimeiraVia.Parent := Dialog;
    BtnPrimeiraVia.Caption := '1� via';
    BtnPrimeiraVia.ModalResult := mrYes; // Define o resultado como mrYes
    BtnPrimeiraVia.Width := 70; // Largura do bot�o
    BtnPrimeiraVia.Top := ButtonTop;

    // Cria o bot�o para a 2� via
    BtnSegundaVia := TButton.Create(Dialog);
    BtnSegundaVia.Parent := Dialog;
    BtnSegundaVia.Caption := '2� via';
    BtnSegundaVia.ModalResult := mrNo; // Define o resultado como mrNo
    BtnSegundaVia.Width := 70;
    BtnSegundaVia.Top := ButtonTop;

    // Cria o bot�o de Cancelar
    BtnCancelar := TButton.Create(Dialog);
    BtnCancelar.Parent := Dialog;
    BtnCancelar.Caption := 'Cancelar';
    BtnCancelar.ModalResult := mrCancel; // Define o resultado como mrCancel
    BtnCancelar.Width := 70;
    BtnCancelar.Top := ButtonTop;

    // Calcula posi��es centralizadas
    BtnPrimeiraVia.Left := (FormWidth div 2) - BtnPrimeiraVia.Width - (ButtonSpacing div 2);
    BtnSegundaVia.Left := BtnPrimeiraVia.Left + BtnPrimeiraVia.Width + ButtonSpacing;
    BtnCancelar.Left := BtnSegundaVia.Left + BtnSegundaVia.Width + ButtonSpacing;

    // Exibe o di�logo
    case Dialog.ShowModal of
      mrYes:
        begin
          //ShowMessage('1� via selecionada');
          imprimirFicha1via;
        end;
      mrNo:
        begin
          //ShowMessage('2� via selecionada');
          imprimirFicha2via;
        end;
      mrCancel:
        ShowMessage('Opera��o cancelada.');
    end;
  finally
    Dialog.Free;
  end;

end;

procedure TFormConsultaFichaFaccao.btnSalvarClick(Sender: TObject);
begin
  attDataEnvio := CalendarDataDeEnvio.Date;
  attDataPrevista := CalendarDataPrevista.Date;
  attDataEntrega := CalendarDataDeEntrega.Date;

  // Valida��o se os campos necess�rios est�o preenchidos
  if ComboBoxStatus.Text = '' then
  begin
    ShowMessage('Informe o status.');
    Exit;
  end;

  // Prepare o comando UPDATE para alterar os dados no banco
  FDQueryConsultaFichaFaccao.SQL.Text :=
    'UPDATE TBFichaDeFaccao ' +
    'SET dataCorte = :dataCorte, ' +
    '    dataEnvio = :dataEnvio, ' +
    '    dataPrevisao = :dataPrevisao, ' +
    '    dataEntrega = :dataEntrega, ' +
    '    statusOrdem = :statusOrdem, ' +
    '    codFaccao = :codFaccao, ' +
    '    nomeFaccao = :nomeFaccao ' +
    'WHERE idFaccao = :idFaccao';  // Certifique-se de passar o ID correto para o WHERE

  // Atribuindo os par�metros com os valores dos campos e Calendars

  FDQueryConsultaFichaFaccao.ParamByName('dataCorte').AsDate := CalendarDataDeCorte.Date;
  FDQueryConsultaFichaFaccao.ParamByName('dataEnvio').AsDate := attDataEnvio; // CalendarDataDeEnvio.Date;
  FDQueryConsultaFichaFaccao.ParamByName('dataPrevisao').AsDate := attDataPrevista; //CalendarDataPrevista.Date;
  FDQueryConsultaFichaFaccao.ParamByName('dataEntrega').AsDate := attDataEntrega; //CalendarDataDeEntrega.Date;
  FDQueryConsultaFichaFaccao.ParamByName('statusOrdem').AsString := ComboBoxStatus.Text;
  FDQueryConsultaFichaFaccao.ParamByName('idFaccao').AsInteger := idFaccaoAtivo;
  FDQueryConsultaFichaFaccao.ParamByName('codFaccao').AsString := edtCodFaccao.Text;
  FDQueryConsultaFichaFaccao.ParamByName('nomeFaccao').AsString := ComboBoxFaccao.Text;

  // Executa o comando SQL para atualizar os dados no banco
  try
    FDQueryConsultaFichaFaccao.ExecSQL; // Executa o comando UPDATE
    ShowMessage('Dados atualizados com sucesso!');
  except
    on E: Exception do
      ShowMessage('Erro ao salvar os dados: ' + E.Message);
  end;

  PreencherComboBoxStatus;
end;



procedure TFormConsultaFichaFaccao.ComboBoxFaccaoChange(Sender: TObject);
begin
if ComboBoxFaccao.ItemIndex <> -1 then
    edtCodFaccao.Text := IntToStr(Integer(ComboBoxFaccao.Items.Objects[ComboBoxFaccao.ItemIndex]));
end;

procedure TFormConsultaFichaFaccao.DSDadosConsultaFichaFaccaoDataChange(
  Sender: TObject; Field: TField);
var
  dataCorte, dataEnvio, dataPrevisao, dataEntrega: TDateTime;
begin
  FAtualizandoCalendarios := True;
  try
    // Converte as datas do banco para o formato do calend�rio (dd/mm/yyyy)
    if TryStrToDate(FDQueryConsultaFichaFaccao.FieldByName('dataCorte').AsString, dataCorte) then
      CalendarDataDeCorte.Date := dataCorte
    else
      CalendarDataDeCorte.Date := now;

    if TryStrToDate(FDQueryConsultaFichaFaccao.FieldByName('dataEnvio').AsString, dataEnvio) then
      CalendarDataDeEnvio.Date := dataEnvio ;
//    else
//      CalendarDataDeEnvio.Date := now;

    if TryStrToDate(FDQueryConsultaFichaFaccao.FieldByName('dataPrevisao').AsString, dataPrevisao) then
      CalendarDataPrevista.Date := dataPrevisao   ;
//    else
//      CalendarDataPrevista.Date := now;

    if TryStrToDate(FDQueryConsultaFichaFaccao.FieldByName('dataEntrega').AsString, dataEntrega) then
      CalendarDataDeEntrega.Date := dataEntrega ;
//    else
//      CalendarDataDeEntrega.Date := now;

    idFaccaoAtivo := FDQueryConsultaFichaFaccao.FieldByName('idFaccao').AsInteger;

  finally
    FAtualizandoCalendarios := False;
  end;

end;


procedure TFormConsultaFichaFaccao.edtCodRefChange(Sender: TObject);
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

procedure TFormConsultaFichaFaccao.FormCreate(Sender: TObject);
begin
  FAtualizandoCalendarios := false;
  PreencherComboBoxFaccao;
  PreencherComboBoxStatus;
  PreencherComboBoxProdutos;
end;

procedure TFormConsultaFichaFaccao.imprimirFicha1via;
begin
  if not Assigned(FormRelFichaFaccao1via) then
    FormRelFichaFaccao1via := TFormRelFichaFaccao1via.Create(Self);

  FormRelFichaFaccao1via.QRLabelNumFaccao.Caption := 'FICHA N�: ';
  FormRelFichaFaccao1via.QRLabelNumFaccao.Caption := FormRelFichaFaccao1via.QRLabelNumFaccao.Caption + edtNumFaccao.Text;

  FormRelFichaFaccao1via.QRLabelModelo.Caption := 'MODELO: ';
  FormRelFichaFaccao1via.QRLabelModelo.Caption := FormRelFichaFaccao1via.QRLabelModelo.Caption + ComboBoxProdutos.Text;

  FormRelFichaFaccao1via.QRLabelNomeFaccao.Caption := 'FAC��O: ';
  FormRelFichaFaccao1via.QRLabelNomeFaccao.Caption := FormRelFichaFaccao1via.QRLabelNomeFaccao.Caption + ComboBoxFaccao.Text;

  FormRelFichaFaccao1via.QRLabelNumCorte.Caption := 'N� CORTE: ';
  FormRelFichaFaccao1via.QRLabelNumCorte.Caption := FormRelFichaFaccao1via.QRLabelNumCorte.Caption + edtNumCorte.Text;

  FormRelFichaFaccao1via.QRLabelNumOrdemCorte.Caption := 'N� ORDEM DE CORTE: ';
  FormRelFichaFaccao1via.QRLabelNumOrdemCorte.Caption := FormRelFichaFaccao1via.QRLabelNumOrdemCorte.Caption + edtNumOrdemCorte.Text;

  FormRelFichaFaccao1via.QRLabelNomeCortador.Caption := 'CORTADOR: ';
  FormRelFichaFaccao1via.QRLabelNomeCortador.Caption := FormRelFichaFaccao1via.QRLabelNomeCortador.Caption + ComboBoxCortador.Text;

  FormRelFichaFaccao1via.QRLabelDataCorte.Caption := 'DATA DE CORTE: ';
  FormRelFichaFaccao1via.QRLabelDataCorte.Caption := FormRelFichaFaccao1via.QRLabelDataCorte.Caption + DateToStr(CalendarDataDeCorte.Date);

//  FormRelFichaFaccao1via.QRLabelNumTotalPecas.Caption := 'N� DE PE�AS: ';
//  FormRelFichaFaccao1via.QRLabelNumTotalPecas.Caption := lblNumTotalPecas.Caption;

  FormRelFichaFaccao1via.QRLabelModeloHeader.Caption := 'MODELO';
  FormRelFichaFaccao1via.QRLabelModeloHeader.Caption := ComboBoxProdutos.Text;
  //QRLabelModeloHeader

  FormRelFichaFaccao1via.FDQueryRelFichaFaccao.Close;

  FormRelFichaFaccao1via.FDQueryRelFichaFaccao.SQL.Text :=
  'SELECT ' +
  '    f.idFaccao AS Num_Faccao, ' +
  '    f.corTecido AS Cor, ' +
  '    p.nomeTecido AS Tecido, ' +
  '    p.fichaTecnica AS Ficha_Tecnica, ' +
  '    SUM(CASE WHEN f.tamanhoPecas = ''P'' THEN f.quantidadePecas ELSE 0 END) AS Tam_P, ' +
  '    SUM(CASE WHEN f.tamanhoPecas = ''M'' THEN f.quantidadePecas ELSE 0 END) AS Tam_M, ' +
  '    SUM(CASE WHEN f.tamanhoPecas = ''G'' THEN f.quantidadePecas ELSE 0 END) AS Tam_G, ' +
  '    SUM(CASE WHEN f.tamanhoPecas = ''GG'' THEN f.quantidadePecas ELSE 0 END) AS Tam_GG, ' +
  '    SUM(CASE WHEN f.tamanhoPecas = ''48'' THEN f.quantidadePecas ELSE 0 END) AS Tam_48, ' +
  '    SUM(CASE WHEN f.tamanhoPecas = ''50'' THEN f.quantidadePecas ELSE 0 END) AS Tam_50, ' +
  '    SUM(CASE WHEN f.tamanhoPecas = ''52'' THEN f.quantidadePecas ELSE 0 END) AS Tam_52, ' +
  '    SUM(f.quantidadePecas) AS Total_Pecas_Cor, ' +
  '    SUM(f.quantidadePecas * p.aviamentoProduto) AS Total_Aviamento, ' +
  '    (SELECT SUM(f2.quantidadePecas) FROM TBFichaDeFaccao f2 WHERE f2.idFaccao = f.idFaccao AND f2.tamanhoPecas = ''P'') AS Total_Tam_P, ' +
  '    (SELECT SUM(f2.quantidadePecas) FROM TBFichaDeFaccao f2 WHERE f2.idFaccao = f.idFaccao AND f2.tamanhoPecas = ''M'') AS Total_Tam_M, ' +
  '    (SELECT SUM(f2.quantidadePecas) FROM TBFichaDeFaccao f2 WHERE f2.idFaccao = f.idFaccao AND f2.tamanhoPecas = ''G'') AS Total_Tam_G, ' +
  '    (SELECT SUM(f2.quantidadePecas) FROM TBFichaDeFaccao f2 WHERE f2.idFaccao = f.idFaccao AND f2.tamanhoPecas = ''GG'') AS Total_Tam_GG, ' +
  '    (SELECT SUM(f2.quantidadePecas) FROM TBFichaDeFaccao f2 WHERE f2.idFaccao = f.idFaccao AND f2.tamanhoPecas = ''48'') AS Total_Tam_48, ' +
  '    (SELECT SUM(f2.quantidadePecas) FROM TBFichaDeFaccao f2 WHERE f2.idFaccao = f.idFaccao AND f2.tamanhoPecas = ''50'') AS Total_Tam_50, ' +
  '    (SELECT SUM(f2.quantidadePecas) FROM TBFichaDeFaccao f2 WHERE f2.idFaccao = f.idFaccao AND f2.tamanhoPecas = ''52'') AS Total_Tam_52, ' +
  '    (SELECT SUM(f2.quantidadePecas) FROM TBFichaDeFaccao f2 WHERE f2.idFaccao = f.idFaccao) AS Total_Pecas   ' +
  'FROM ' +
  '    TBFichaDeFaccao f ' +
  'JOIN ' +
  '    TBprodutos p ON f.codProduto = p.codProduto ' +
  'WHERE ' +
  '    f.idFaccao = :idFaccao ' +
  'GROUP BY ' +
  '    f.idFaccao, f.corTecido, p.fichaTecnica, p.nomeTecido ' +
  'ORDER BY ' +
  '    f.corTecido;';

  // Atribuir o valor do par�metro
  FormRelFichaFaccao1via.FDQueryRelFichaFaccao.ParamByName('idFaccao').AsInteger := StrToInt(edtNumFaccao.text);

  try
    FormRelFichaFaccao1via.FDQueryRelFichaFaccao.Open; // Executa a consulta
  except
    on E: Exception do
      ShowMessage('Erro ao gerar o relat�rio: ' + E.Message);
  end;


  FormRelFichaFaccao1via.QuickRepFichaFaccao.Preview;
end;

procedure TFormConsultaFichaFaccao.imprimirFicha2via;
begin
  if not Assigned(FormRelFichaFaccao2via) then
    FormRelFichaFaccao2via := TFormRelFichaFaccao2via.Create(Self);

  FormRelFichaFaccao2via.QRLabelNumFaccao.Caption := 'FICHA N�: ';
  FormRelFichaFaccao2via.QRLabelNumFaccao.Caption := FormRelFichaFaccao2via.QRLabelNumFaccao.Caption + edtNumFaccao.Text;

  FormRelFichaFaccao2via.QRLabelModelo.Caption := 'MODELO: ';
  FormRelFichaFaccao2via.QRLabelModelo.Caption := FormRelFichaFaccao2via.QRLabelModelo.Caption + ComboBoxProdutos.Text;

  FormRelFichaFaccao2via.QRLabelNomeFaccao.Caption := 'FAC��O: ';
  FormRelFichaFaccao2via.QRLabelNomeFaccao.Caption := FormRelFichaFaccao2via.QRLabelNomeFaccao.Caption + ComboBoxFaccao.Text;

  FormRelFichaFaccao2via.QRLabelNumCorte.Caption := 'N� CORTE: ';
  FormRelFichaFaccao2via.QRLabelNumCorte.Caption := FormRelFichaFaccao2via.QRLabelNumCorte.Caption + edtNumCorte.Text;

  FormRelFichaFaccao2via.QRLabelNumOrdemCorte.Caption := 'N� ORDEM DE CORTE: ';
  FormRelFichaFaccao2via.QRLabelNumOrdemCorte.Caption := FormRelFichaFaccao2via.QRLabelNumOrdemCorte.Caption + edtNumOrdemCorte.Text;

  FormRelFichaFaccao2via.QRLabelNomeCortador.Caption := 'CORTADOR: ';
  FormRelFichaFaccao2via.QRLabelNomeCortador.Caption := FormRelFichaFaccao2via.QRLabelNomeCortador.Caption + ComboBoxCortador.Text;

  FormRelFichaFaccao2via.QRLabelDataCorte.Caption := 'DATA DE CORTE: ';
  FormRelFichaFaccao2via.QRLabelDataCorte.Caption := FormRelFichaFaccao2via.QRLabelDataCorte.Caption + DateToStr(CalendarDataDeCorte.Date);

//  FormRelFichaFaccao2via.QRLabelNumTotalPecas.Caption := 'N� DE PE�AS: ';
//  FormRelFichaFaccao2via.QRLabelNumTotalPecas.Caption := lblNumTotalPecas.Caption;

  FormRelFichaFaccao2via.QRLabelModeloHeader.Caption := 'MODELO';
  FormRelFichaFaccao2via.QRLabelModeloHeader.Caption := ComboBoxProdutos.Text;
  //QRLabelModeloHeader

  FormRelFichaFaccao2via.FDQueryRelFichaFaccao.Close;
  FormRelFichaFaccao2via.FDQueryRelFichaFaccao.SQL.Text :=
    'SELECT ' +
    '    f.idFaccao AS Num_Faccao, ' +
    '    f.corTecido AS Cor, ' +
    '    p.nomeTecido AS Tecido, ' +
    '    p.fichaTecnica AS Ficha_Tecnica, ' +
    '    SUM(CASE WHEN f.tamanhoPecas = ''P'' THEN f.quantidadePecas ELSE 0 END) AS Tam_P, ' +
    '    SUM(CASE WHEN f.tamanhoPecas = ''M'' THEN f.quantidadePecas ELSE 0 END) AS Tam_M, ' +
    '    SUM(CASE WHEN f.tamanhoPecas = ''G'' THEN f.quantidadePecas ELSE 0 END) AS Tam_G, ' +
    '    SUM(CASE WHEN f.tamanhoPecas = ''GG'' THEN f.quantidadePecas ELSE 0 END) AS Tam_GG, ' +
    '    SUM(CASE WHEN f.tamanhoPecas = ''48'' THEN f.quantidadePecas ELSE 0 END) AS Tam_48, ' +
    '    SUM(CASE WHEN f.tamanhoPecas = ''50'' THEN f.quantidadePecas ELSE 0 END) AS Tam_50, ' +
    '    SUM(CASE WHEN f.tamanhoPecas = ''52'' THEN f.quantidadePecas ELSE 0 END) AS Tam_52, ' +
    '    SUM(f.quantidadePecas) AS Total_Pecas_Cor, ' +
    '    SUM(f.quantidadePecas * p.aviamentoProduto) AS Total_Aviamento, ' +
    '    (SELECT SUM(f2.quantidadePecas) FROM TBFichaDeFaccao f2 WHERE f2.idFaccao = f.idFaccao AND f2.tamanhoPecas = ''P'') AS Total_Tam_P, ' +
    '    (SELECT SUM(f2.quantidadePecas) FROM TBFichaDeFaccao f2 WHERE f2.idFaccao = f.idFaccao AND f2.tamanhoPecas = ''M'') AS Total_Tam_M, ' +
    '    (SELECT SUM(f2.quantidadePecas) FROM TBFichaDeFaccao f2 WHERE f2.idFaccao = f.idFaccao AND f2.tamanhoPecas = ''G'') AS Total_Tam_G, ' +
    '    (SELECT SUM(f2.quantidadePecas) FROM TBFichaDeFaccao f2 WHERE f2.idFaccao = f.idFaccao AND f2.tamanhoPecas = ''GG'') AS Total_Tam_GG, ' +
    '    (SELECT SUM(f2.quantidadePecas) FROM TBFichaDeFaccao f2 WHERE f2.idFaccao = f.idFaccao AND f2.tamanhoPecas = ''48'') AS Total_Tam_48, ' +
    '    (SELECT SUM(f2.quantidadePecas) FROM TBFichaDeFaccao f2 WHERE f2.idFaccao = f.idFaccao AND f2.tamanhoPecas = ''50'') AS Total_Tam_50, ' +
    '    (SELECT SUM(f2.quantidadePecas) FROM TBFichaDeFaccao f2 WHERE f2.idFaccao = f.idFaccao AND f2.tamanhoPecas = ''52'') AS Total_Tam_52, ' +
    '    (SELECT SUM(f2.quantidadePecas) FROM TBFichaDeFaccao f2 WHERE f2.idFaccao = f.idFaccao) AS Total_Pecas ' +
    'FROM ' +
    '    TBFichaDeFaccao f ' +
    'JOIN ' +
    '    TBprodutos p ON f.codProduto = p.codProduto ' +
    'WHERE ' +
    '    f.idFaccao = :idFaccao ' +
    'GROUP BY ' +
    '    f.idFaccao, f.corTecido, p.fichaTecnica, p.nomeTecido ' +
    'ORDER BY ' +
    '    f.corTecido;';

  FormRelFichaFaccao2via.FDQueryRelFichaFaccao.ParamByName('idFaccao').AsInteger := StrToInt(edtNumFaccao.Text);
  FormRelFichaFaccao2via.FDQueryRelFichaFaccao.Open;

  // Verificar se h� registros antes de acessar os campos
  if not FormRelFichaFaccao2via.FDQueryRelFichaFaccao.IsEmpty then
  begin
    // Atualizar o texto do label com o valor de Total_Pecas
    FormRelFichaFaccao2via.QRLabelNumTotalPecas.Caption :=
      'N� DE PE�AS: ' + FormRelFichaFaccao2via.FDQueryRelFichaFaccao.FieldByName('Total_Pecas').AsString;
  end
  else
  begin
    FormRelFichaFaccao2via.QRLabelNumTotalPecas.Caption := 'Nenhum dado encontrado.';
  end;
  try
    FormRelFichaFaccao2via.FDQueryRelFichaFaccao.Open; // Executa a consulta
  except
    on E: Exception do
      ShowMessage('Erro ao gerar o relat�rio: ' + E.Message);
  end;


  FormRelFichaFaccao2via.QuickRepFichaFaccao.Preview;
end;

end.
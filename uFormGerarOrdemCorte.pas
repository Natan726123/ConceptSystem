unit uFormGerarOrdemCorte;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Actions,
  Vcl.ActnList, Vcl.Menus, Vcl.ExtCtrls, Vcl.WinXCalendars, Vcl.Grids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, uMainModulo,
  FireDAC.Comp.Client, Vcl.DBGrids, Vcl.Imaging.pngimage, Math, QuickRpt, QRCtrls;

type
  TFormGerarOrdemCorte = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    ComboBoxProdutos: TComboBox;
    pnlModelos: TPanel;
    DSDadosProdutos: TDataSource;
    FDQueryProdutos: TFDQuery;
    DBGridOrdemDeCorte: TDBGrid;
    DBGridCalcTecidos: TDBGrid;
    PanelTamanhos: TPanel;
    edtCodProduto: TEdit;
    Label2: TLabel;
    edtTecido: TEdit;
    Label3: TLabel;
    edtCodTecido: TEdit;
    Label4: TLabel;
    edtRendimento: TEdit;
    Label5: TLabel;
    edtLocalizacao: TEdit;
    Label6: TLabel;
    edtCusto: TEdit;
    Label7: TLabel;
    edtQuantidade: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    btnAdicionarItens: TButton;
    Button3: TButton;
    MemoObsOrdem: TMemo;
    Label11: TLabel;
    Image1: TImage;
    FDQueryItensLista: TFDQuery;
    DSDadosItensLista: TDataSource;
    lblNumOrdem: TLabel;
    FDQueryItensListaOrdem: TIntegerField;
    FDQueryItensListaItem: TIntegerField;
    FDQueryItensListacodProd: TIntegerField;
    FDQueryItensListaProduto: TStringField;
    FDQueryItensListaTamanho: TStringField;
    FDQueryItensListaQuantidade: TIntegerField;
    FDQueryItensListacodTecido: TIntegerField;
    FDQueryItensListaTecido: TStringField;
    FDQueryItensListaData: TDateField;
    FDQueryItensListaObserva��o: TStringField;
    FDQueryItensListaTecidoKg: TBCDField;
    DSCalcTecidos: TDataSource;
    FDQueryCalcTecidos: TFDQuery;
    Label12: TLabel;
    edtPedidos: TEdit;
    FDQueryItensListaPedidos: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBoxProdutosChange(Sender: TObject);
    procedure RadioButtonTamanhoClick(Sender: TObject);
    function GetNextIdItemLista(numOrdem: Integer): Integer;
    function GetNextNumOrdem: Integer;
//    procedure InserirItemPedido(
//                numOrdem: Integer;
//                codProduto: Integer;
//                tamanho: String;
//                quantidade: Integer;
//                codTecido: Integer;
//                qtdTecidoKg: Double;
//                obs: String);
    procedure btnAdicionarItensClick(Sender: TObject);
    function GetTamanhoSelecionado: String;
    procedure InserirItemPedido(numOrdem: Integer; codProduto: Integer; tamanho: String;
  quantidade: Integer; codTecido: Integer; quantidadeTecidoKg: Double; obs: String);
    procedure FormShow(Sender: TObject);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);


  private
    { Private declarations }
  public
    var
    numOrdemAtivo: Integer;  // Vari�vel global no formul�rio para armazenar o n�mero da ordem ativa.


  end;

var
  FormGerarOrdemCorte: TFormGerarOrdemCorte;
  IdItemLista: Integer;

implementation

{$R *.dfm}

procedure AjustarLarguraColunas(DBGrid: TDBGrid);
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

procedure TFormGerarOrdemCorte.InserirItemPedido(numOrdem: Integer; codProduto: Integer; tamanho: String;
  quantidade: Integer; codTecido: Integer; quantidadeTecidoKg: Double; obs: String);
var
  idItemLista: Integer;
begin
  // Busca o pr�ximo idItemLista (voc� pode usar a l�gica para pegar o maior id ou gerar um valor �nico)
  FDQueryItensLista.SQL.Text := 'SELECT MAX(idItemLista) FROM TBordemdecorte';
  FDQueryItensLista.Open;
  idItemLista := FDQueryItensLista.Fields[0].AsInteger + 1;  // Incrementa o maior idItemLista encontrado

  // Insere o item na tabela
  DSDadosItensLista.DataSet.Append;
  DSDadosItensLista.DataSet.FieldByName('idItemLista').AsInteger := idItemLista;  // Atribui o idItemLista gerado
  DSDadosItensLista.DataSet.FieldByName('numOrdem').AsInteger := numOrdem;
  DSDadosItensLista.DataSet.FieldByName('codProduto').AsInteger := codProduto;
  DSDadosItensLista.DataSet.FieldByName('nomeProduto').AsString := ComboBoxProdutos.Text;
  DSDadosItensLista.DataSet.FieldByName('tamanhoPecas').AsString := tamanho;
  DSDadosItensLista.DataSet.FieldByName('quantidadePecas').AsInteger := quantidade;
  DSDadosItensLista.DataSet.FieldByName('codTecido').AsInteger := codTecido;
  DSDadosItensLista.DataSet.FieldByName('nomeTecido').AsString := edtTecido.Text;
  DSDadosItensLista.DataSet.FieldByName('quantidadeTecidoKg').AsFloat := quantidadeTecidoKg;
  DSDadosItensLista.DataSet.FieldByName('obsOrdem').AsString := obs;
  DSDadosItensLista.DataSet.Post;
end;


function TFormGerarOrdemCorte.GetTamanhoSelecionado: String;
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



//procedure InserirItemPedido(numOrdem: Integer; codProduto: Integer; tamanho: String;
//  quantidade: Integer; codTecido: Integer; qtdTecidoKg: Double; obs: String);
//var
//  idItemLista: Integer;
//begin
//  try
//    // Determina o pr�ximo idItemLista com base no numOrdem
//    FDQueryItensLista.Close;
//    FDQueryItensLista.SQL.Text := 'SELECT COALESCE(MAX(idItemLista), 0) + 1 AS ProximoID ' +
//                                  'FROM TBordemdecorte ' +
//                                  'WHERE numOrdem = :numOrdem';
//    FDQueryItensLista.ParamByName('numOrdem').AsInteger := numOrdem;
//    FDQueryItensLista.Open; // Usa Open para SELECT
//    idItemLista := FDQueryItensLista.FieldByName('ProximoID').AsInteger;
//    FDQueryItensLista.Close;
//
//    // Agora insere o novo item no pedido na pr�pria FDQueryItensLista
//    FDQueryItensLista.SQL.Text :=
//      'INSERT INTO TBordemdecorte (numOrdem, idItemLista, codProduto, quantidadePecas, ' +
//      'tamanhoPecas, codTecido, quantidadeTecidoKg, dataOrdem, obsOrdem) ' +
//      'VALUES (:numOrdem, :idItemLista, :codProduto, :quantidadePecas, ' +
//      ':tamanhoPecas, :codTecido, :quantidadeTecidoKg, :dataOrdem, :obsOrdem)';
//
//    FDQueryItensLista.ParamByName('numOrdem').AsInteger := numOrdem;
//    FDQueryItensLista.ParamByName('idItemLista').AsInteger := idItemLista;
//    FDQueryItensLista.ParamByName('codProduto').AsInteger := codProduto;
//    FDQueryItensLista.ParamByName('quantidadePecas').AsInteger := quantidade;
//    FDQueryItensLista.ParamByName('tamanhoPecas').AsString := tamanho;
//    FDQueryItensLista.ParamByName('codTecido').AsInteger := codTecido;
//    FDQueryItensLista.ParamByName('quantidadeTecidoKg').AsFloat := qtdTecidoKg;
//    FDQueryItensLista.ParamByName('dataOrdem').AsDateTime := Now;
//    FDQueryItensLista.ParamByName('obsOrdem').AsString := obs;
//
//    FDQueryItensLista.ExecSQL; // Usa ExecSQL para inserir o item
//  except
//    on E: Exception do
//      raise Exception.Create('Erro ao inserir item no pedido: ' + E.Message);
//  end;
//end;




function TFormGerarOrdemCorte.GetNextNumOrdem: Integer;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Form6.FDConnection1;
    Query.SQL.Text := 'SELECT COALESCE(MAX(numOrdem), 99999) + 1 AS ProximoNum FROM TBordemdecorte';
    Query.Open;
    Result := Query.FieldByName('ProximoNum').AsInteger;
  finally
    Query.Free;
  end;
end;

function TFormGerarOrdemCorte.GetNextIdItemLista(numOrdem: Integer): Integer;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Form6.FDConnection1;
    Query.SQL.Text :=
      'SELECT COALESCE(MAX(idItemLista), 0) + 1 AS ProximoItem ' +
      'FROM TBordemdecorte ' +
      'WHERE numOrdem = :numOrdem';
    Query.ParamByName('numOrdem').AsInteger := numOrdem;
    Query.Open;
    Result := Query.FieldByName('ProximoItem').AsInteger;
  finally
    Query.Free;
  end;
end;


procedure TFormGerarOrdemCorte.RadioButtonTamanhoClick(Sender: TObject);
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
      'SELECT codProduto, nomeTecido, codTecido, rendimentoKg, localizacaoProduto, precoCusto ' +
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
      edtRendimento.Text := FDQueryProdutos.FieldByName('rendimentoKg').AsString;
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


procedure TFormGerarOrdemCorte.btnAdicionarItensClick(Sender: TObject);
var
  quantidadeTecidoKg: Double;
  i: Integer;
  Control: TControl;
  TamanhoSelecionado: Boolean;
begin
  // Inicializa a vari�vel como falsa
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

  try
    // Calcula a quantidade de tecido em kg
    quantidadeTecidoKg := StrToFloat(edtQuantidade.Text) / StrToFloat(edtRendimento.Text);

    // Coloca o DataSet em modo de inser��o
    DSDadosItensLista.DataSet.Insert;

    // Obt�m o pr�ximo idItemLista para este pedido
    DSDadosItensLista.DataSet.FieldByName('Ordem').AsInteger := numOrdemAtivo; // N�mero da ordem ativa
    DSDadosItensLista.DataSet.FieldByName('Item').AsInteger := DSDadosItensLista.DataSet.RecordCount + 1; // Pr�ximo ID da lista
    DSDadosItensLista.DataSet.FieldByName('codProd').AsInteger := StrToInt(edtCodProduto.Text); // C�digo do produto
    DSDadosItensLista.DataSet.FieldByName('Produto').AsString := ComboBoxProdutos.Text; // Nome do produto

    DSDadosItensLista.DataSet.FieldByName('Quantidade').AsInteger := StrToInt(edtQuantidade.Text); // Quantidade
    DSDadosItensLista.DataSet.FieldByName('Tamanho').AsString := GetTamanhoSelecionado; // Tamanho selecionado (via RadioButton)
    DSDadosItensLista.DataSet.FieldByName('codTecido').AsInteger := StrToInt(edtCodTecido.Text); // C�digo do tecido
    DSDadosItensLista.DataSet.FieldByName('Tecido').AsString := edtTecido.Text; // Nome do tecido

    DSDadosItensLista.DataSet.FieldByName('Tecido Kg').AsFloat := quantidadeTecidoKg; // Quantidade de tecido em kg
    DSDadosItensLista.DataSet.FieldByName('Data').AsDateTime := Now; // Data atual
    DSDadosItensLista.DataSet.FieldByName('Observa��o').AsString := MemoObsOrdem.Text; // Observa��es
    DSDadosItensLista.DataSet.FieldByName('Pedidos').AsString := edtPedidos.Text; // Observa��es

    // Caso necess�rio, utilize Append e mova o cursor para o final
    FDQueryItensLista.Append;
    FDQueryItensLista.Last; // Adiciona o item no final da lista

    AjustarLarguraColunas(DBGridOrdemDeCorte);


    FDQueryCalcTecidos.SQL.Text := 'SELECT DISTINCT ' +
                          'codTecido as "Cod", ' +
                          'nomeTecido as "Tecido", ' +
                          'sum(quantidadeTecidoKg) as "Tecido Kg" ' +
                          'FROM TBordemdecorte ' +
                          'WHERE numOrdem = :numOrdem ' +
                          'GROUP BY Cod, Tecido ' +
                          'ORDER BY Tecido ASC';
    // Definir o par�metro numOrdem na consulta
    FDQueryCalcTecidos.ParamByName('numOrdem').AsInteger := numOrdemAtivo;

    // Executar a consulta SQL para obter os dados atualizados
    try
      FDQueryCalcTecidos.Open; // Abre a consulta para buscar os dados

      // Verifica se retornou dados
      if FDQueryCalcTecidos.RecordCount = 0 then
        ShowMessage('Nenhum dado encontrado para a ordem ' + IntToStr(numOrdemAtivo));

    except
      on E: Exception do
        ShowMessage('Erro ao executar consulta: ' + E.Message);
    end;

    AjustarLarguraColunas(DBGridCalcTecidos);

  except
    on E: Exception do
      ShowMessage('Erro ao adicionar item: ' + E.Message);
  end;
end;







procedure TFormGerarOrdemCorte.Button1Click(Sender: TObject);
var
  QuickRep: TQuickRep;
  DetailBand: TQRBand;
  QRDBText: TQRDBText;
begin
  QuickRep := TQuickRep.Create(nil);
  try
    // Configura o DataSet para o relat�rio
    QuickRep.DataSet := FDQueryItensLista; // Use o DataSet que cont�m os dados

    // Adiciona a banda de detalhes
    DetailBand := TQRBand.Create(QuickRep);
    //DetailBand.BandType := rbDetail; // Defina o tipo de banda como Detalhe
    DetailBand.Parent := QuickRep;

    // Adiciona um componente para exibir dados
    QRDBText := TQRDBText.Create(DetailBand);
    QRDBText.Parent := DetailBand; // Define a banda de detalhes como parent
    QRDBText.DataSet := FDQueryItensLista;
    QRDBText.DataField := 'nomeProduto'; // Campo do DataSet que ser� exibido
    QRDBText.Left := 10; // Posi��o horizontal
    QRDBText.Top := 10; // Posi��o vertical

    // Exibe o relat�rio em modo de pr�-visualiza��o
    QuickRep.Preview;
  finally
    QuickRep.Free; // Libera a mem�ria ap�s o uso
  end;
end;

procedure TFormGerarOrdemCorte.Button3Click(Sender: TObject);
begin
  if Application.MessageBox(PChar(Format('%s' + #13 + '[%s]',
    ['Deseja realmente excluir este tecido?',
    DSDadosItensLista.DataSet.FieldByName('Produto').AsString + ' - ' + DSDadosItensLista.DataSet.FieldByName('Tamanho').AsString])), 'Aten��o',
    MB_ICONQUESTION + MB_YESNO) = IDYES then
    DSDadosItensLista.DataSet.Delete;
    //DSDadosItensLista.DataSet.Refresh;
end;

procedure TFormGerarOrdemCorte.ComboBoxProdutosChange(Sender: TObject);
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
            NovoRadioButton.Height := 25;  // Altura do RadioButton
            NovoRadioButton.Tag := Integer(Tamanho); // Armazena o tamanho como tag

            NovoRadioButton.OnClick := RadioButtonTamanhoClick;
          end;

          // Atualiza a posi��o horizontal (Left) com um pequeno espa�amento
          PosicaoX := PosicaoX + NovoRadioButton.Width + 10;  // Largura do RadioButton + 10 pixels de espa�o

          // Se a posi��o X ultrapassar a largura do painel, move para a pr�xima linha
          if PosicaoX + NovoRadioButton.Width > PanelTamanhos.Width then
          begin
            PosicaoX := 10;  // Reseta a posi��o horizontal para 10
            PosicaoY := PosicaoY + 35;  // Move para a pr�xima linha (Ajuste a altura conforme necess�rio)
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

procedure TFormGerarOrdemCorte.edtQuantidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then // Verifica se a tecla pressionada � Enter
  begin
    Key := #0; // Cancela o som do Enter
    btnAdicionarItensClick(btnAdicionarItens); // Chama a procedure do bot�o
  end;
end;

procedure TFormGerarOrdemCorte.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FormGerarOrdemCorte := nil;
end;

procedure TFormGerarOrdemCorte.FormCreate(Sender: TObject);
var
  NovoNumOrdem: Integer;
begin
  NovoNumOrdem := GetNextNumOrdem;
  numOrdemAtivo := NovoNumOrdem;

  lblNumOrdem.Caption := lblNumOrdem.Caption + ' ' + IntToStr(NovoNumOrdem);
  //edtNumOrdem.Text := IntToStr(NovoNumOrdem);
  ComboBoxProdutos.Items.Clear;

  while not FDQueryProdutos.Eof do
    begin
      ComboBoxProdutos.Items.Add(FDQueryProdutos.FieldByName('Produto').AsString); // Adiciona os nomes dos produtos ao ComboBox
      FDQueryProdutos.Next;
    end;

  FDQueryProdutos.Close; // Fecha a consulta ap�s carregar os dados

end;

procedure TFormGerarOrdemCorte.FormShow(Sender: TObject);
begin
  FDQueryItensLista.IndexFieldNames := 'Item';

  AjustarLarguraColunas(DBGridOrdemDeCorte);
end;

end.
unit uFormEstoqueProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Imaging.pngimage, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors,
  Data.Bind.Components, Data.Bind.DBScope, Math;

type
  TFormEstoqueProdutos = class(TForm)
    Label1: TLabel;
    DBGridEstoqueProdutos: TDBGrid;
    pnlModelos: TPanel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    ComboBoxProdutos: TComboBox;
    PanelTamanhos: TPanel;
    edtCodProduto: TEdit;
    edtModelo: TEdit;
    edtTamanho: TEdit;
    edtLocalizacao: TEdit;
    edtCusto: TEdit;
    edtQuantidade: TEdit;
    btnAdicionar: TButton;
    btnRemover: TButton;
    edtCodRef: TEdit;
    rbBuscaCodigo: TRadioButton;
    rbBuscaReferencia: TRadioButton;
    Image1: TImage;
    btnBalanco: TButton;
    Label11: TLabel;
    edtEstoque: TEdit;
    edtFiltro: TEdit;
    Label12: TLabel;
    DSDadosProdutos: TDataSource;
    FDQueryProdutos: TFDQuery;
    DSDadosEstoque: TDataSource;
    FDQueryEstoque: TFDQuery;
    DSDadosEstoqueEdt: TDataSource;
    FDQueryEstoqueEdt: TFDQuery;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    LinkControlToField6: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    btnLimparFiltros: TButton;
    procedure edtCodRefChange(Sender: TObject);
    procedure edtCodRefKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure PreencherComboBoxProdutos;
    procedure ComboBoxProdutosChange(Sender: TObject);
    procedure RadioButtonTamanhoClick(Sender: TObject);
    procedure AjustarLarguraColunas(DBGrid: TDBGrid);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure btnBalancoClick(Sender: TObject);
    procedure edtFiltroChange(Sender: TObject);
    procedure FDQueryEstoqueFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure DBGridEstoqueProdutosTitleClick(Column: TColumn);
    procedure btnLimparFiltrosClick(Sender: TObject);
    procedure LimparFiltros;
  private
    ColWidths: array of Integer; // Array din�mico para armazenar larguras das colunas

  public
   procedure SaveColumnWidths(Grid: TDBGrid);
   procedure RestoreColumnWidths(Grid: TDBGrid);
  end;

var
  FormEstoqueProdutos: TFormEstoqueProdutos;

implementation

{$R *.dfm}

function RemoverAcentos(const S: String): String;
const
  Acentos: array[0..7] of Char = ('�', '�', '�', '�', '�', '�', '�', '�');
  SemAcento: array[0..7] of Char = ('a', 'a', 'a', 'a', 'e', 'e', 'e', 'i');
var
  i: Integer;
  ResultStr: String;
begin
  ResultStr := S;
  for i := 0 to Length(Acentos) - 1 do
    ResultStr := StringReplace(ResultStr, Acentos[i], SemAcento[i], [rfReplaceAll, rfIgnoreCase]);
  Result := ResultStr;
end;


procedure TFormEstoqueProdutos.SaveColumnWidths(Grid: TDBGrid);
var
  I: Integer;
begin
  SetLength(ColWidths, Grid.Columns.Count);
  for I := 0 to Grid.Columns.Count - 1 do
    ColWidths[I] := Grid.Columns[I].Width;
end;

procedure TFormEstoqueProdutos.RestoreColumnWidths(Grid: TDBGrid);
var
  I: Integer;
begin
  if Length(ColWidths) = Grid.Columns.Count then
    for I := 0 to Grid.Columns.Count - 1 do
      Grid.Columns[I].Width := ColWidths[I];
end;

procedure TFormEstoqueProdutos.AjustarLarguraColunas(DBGrid: TDBGrid);
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


procedure TFormEstoqueProdutos.RadioButtonTamanhoClick(Sender: TObject);
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
      'SELECT codProduto, nomeProduto, tamanhoProduto, localizacaoProduto, precoCusto ' +
      'FROM TBprodutos ' +
      'WHERE nomeProduto = :nomeProduto AND tamanhoProduto = :tamanhoProduto';
    FDQueryProdutos.ParamByName('nomeProduto').AsString := NomeProduto;
    FDQueryProdutos.ParamByName('tamanhoProduto').AsString := TamanhoSelecionado;
    FDQueryProdutos.Open;

    // Verifica se a consulta retornou resultados
    if not FDQueryProdutos.IsEmpty then
    begin
      edtCodProduto.Text := FDQueryProdutos.FieldByName('codProduto').AsString;
      edtModelo.Text := FDQueryProdutos.FieldByName('nomeProduto').AsString;
      edtTamanho.Text := FDQueryProdutos.FieldByName('tamanhoProduto').AsString;
      //edtRendimento.Text := FDQueryProdutos.FieldByName('rendimentoKg').AsString;
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

  //edtEstoque
  try
    // Prepara a consulta para buscar as informa��es do produto e tamanho
    FDQueryEstoqueEdt.SQL.Text :=
      'SELECT codProduto, quantidadeEstoque ' +
      'FROM TBestoqueprodutos ' +
      'WHERE codProduto = :codProduto';
    FDQueryEstoqueEdt.ParamByName('codProduto').AsInteger := StrToInt(edtCodProduto.Text);
    FDQueryEstoqueEdt.Open;

    // Verifica se a consulta retornou resultados
    if not FDQueryEstoqueEdt.IsEmpty then
    begin
      edtEstoque.Text := FDQueryEstoqueEdt.FieldByName('quantidadeEstoque').AsString;
    end
    else
    begin
      ShowMessage('Nenhum registro de quantidade encontrado.');
    end;

    FDQueryEstoqueEdt.Close;
  except
    on E: Exception do
      ShowMessage('Erro ao buscar informa��es do produto: ' + E.Message);
  end;
end;


procedure TFormEstoqueProdutos.btnAdicionarClick(Sender: TObject);
var
  QuantidadeAdicionar, EstoqueAtual, EstoqueAtualizado, CodProduto: Integer;
begin
  try
    // Valida��o dos campos
    if (edtQuantidade.Text = '') or not TryStrToInt(edtQuantidade.Text, QuantidadeAdicionar) then
    begin
      ShowMessage('Por favor, insira uma quantidade v�lida.');
      Exit;
    end;

    if (edtEstoque.Text = '') or not TryStrToInt(edtEstoque.Text, EstoqueAtual) then
    begin
      ShowMessage('Estoque atual inv�lido. Verifique o valor.');
      Exit;
    end;

    if (edtCodProduto.Text = '') or not TryStrToInt(edtCodProduto.Text, CodProduto) then
    begin
      ShowMessage('C�digo do produto inv�lido. Verifique o campo.');
      Exit;
    end;

    // Soma os valores
    EstoqueAtualizado := EstoqueAtual + QuantidadeAdicionar;

    // Atualiza o campo edtEstoque com o novo valor
    edtEstoque.Text := IntToStr(EstoqueAtualizado);

    // Atualiza o banco de dados
    FDQueryEstoque.SQL.Text :=
      'UPDATE TBestoqueprodutos ' +
      'SET quantidadeEstoque = :quantidadeEstoque ' +
      'WHERE codProduto = :codProduto';
    FDQueryEstoque.ParamByName('quantidadeEstoque').AsInteger := EstoqueAtualizado;
    FDQueryEstoque.ParamByName('codProduto').AsInteger := CodProduto;

    // Usa ExecSQL para executar o comando
    FDQueryEstoque.ExecSQL;



    FDQueryEstoque.SQL.Text :=
  'SELECT ' +
  '  e.codProduto as Codigo, ' +
  '  e.nomeProduto as Modelo, ' +
  '  p.tamanhoProduto as Tamanho, ' +
  '  e.refProduto as Referencia, ' +
  '  e.quantidadeEstoque as Quantidade, ' +
  '  p.codTecido, ' +
  '  p.nomeTecido as Tecido, ' +
  '  p.rendimentoKg, ' +
  '  p.localizacaoProduto as Localizacao, ' +
  '  p.precoCusto as Custo ' +
  'FROM ' +
  '  TBestoqueprodutos e ' +
  'JOIN ' +
  '  TBprodutos p ON e.codProduto = p.codProduto';

FDQueryEstoque.Open;

    
    //DSDadosEstoque.DataSet.Refresh;
    // Atualiza o Grid sem fech�-lo
//    FDQueryEstoque.Close; // O Query associado ao Grid
//    FDQueryEstoque.Open; // Reabre para atualizar os dados exibidos

    ShowMessage('Estoque atualizado com sucesso!');
  except
    on E: Exception do
      ShowMessage('Erro ao atualizar o estoque: ' + E.Message);
  end;

  RestoreColumnWidths(DBGridEstoqueProdutos);
  edtQuantidade.Clear;
end;


procedure TFormEstoqueProdutos.btnBalancoClick(Sender: TObject);
var
  NovoEstoque, CodProduto: Integer;
begin
  try
    // Valida��o dos campos
    if (edtQuantidade.Text = '') or not TryStrToInt(edtQuantidade.Text, NovoEstoque) then
    begin
      ShowMessage('Por favor, insira um valor v�lido para o estoque.');
      Exit;
    end;

    if (edtCodProduto.Text = '') or not TryStrToInt(edtCodProduto.Text, CodProduto) then
    begin
      ShowMessage('C�digo do produto inv�lido. Verifique o campo.');
      Exit;
    end;

    // Atualiza o estoque no campo edtEstoque
    edtEstoque.Text := IntToStr(NovoEstoque);

    // Atualiza o banco de dados
    FDQueryEstoque.SQL.Text :=
      'UPDATE TBestoqueprodutos ' +
      'SET quantidadeEstoque = :quantidadeEstoque ' +
      'WHERE codProduto = :codProduto';
    FDQueryEstoque.ParamByName('quantidadeEstoque').AsInteger := NovoEstoque;
    FDQueryEstoque.ParamByName('codProduto').AsInteger := CodProduto;

    // Executa a atualiza��o
    FDQueryEstoque.ExecSQL;

    // Atualiza o Grid
    FDQueryEstoque.SQL.Text :=
      'SELECT ' +
      '  e.codProduto as Codigo, ' +
      '  e.nomeProduto as Modelo, ' +
      '  p.tamanhoProduto as Tamanho, ' +
      '  e.refProduto as Referencia, ' +
      '  e.quantidadeEstoque as Quantidade, ' +
      '  p.codTecido, ' +
      '  p.nomeTecido as Tecido, ' +
      '  p.rendimentoKg, ' +
      '  p.localizacaoProduto as Localizacao, ' +
      '  p.precoCusto as Custo ' +
      'FROM ' +
      '  TBestoqueprodutos e ' +
      'JOIN ' +
      '  TBprodutos p ON e.codProduto = p.codProduto';
    FDQueryEstoque.Open;

    // Confirma��o da opera��o
    ShowMessage('Balan�o de estoque realizado com sucesso!');
  except
    on E: Exception do
      ShowMessage('Erro ao realizar o balan�o de estoque: ' + E.Message);
  end;

  // Restaura as larguras das colunas
  RestoreColumnWidths(DBGridEstoqueProdutos);
end;


procedure TFormEstoqueProdutos.btnLimparFiltrosClick(Sender: TObject);
begin
  LimparFiltros;
end;

procedure TFormEstoqueProdutos.btnRemoverClick(Sender: TObject);
var
  QuantidadeRemover, EstoqueAtual, EstoqueAtualizado, CodProduto: Integer;
begin
  try
    // Valida��o dos campos
    if (edtQuantidade.Text = '') or not TryStrToInt(edtQuantidade.Text, QuantidadeRemover) then
    begin
      ShowMessage('Por favor, insira uma quantidade v�lida.');
      Exit;
    end;

    if (edtEstoque.Text = '') or not TryStrToInt(edtEstoque.Text, EstoqueAtual) then
    begin
      ShowMessage('Estoque atual inv�lido. Verifique o valor.');
      Exit;
    end;

    if (edtCodProduto.Text = '') or not TryStrToInt(edtCodProduto.Text, CodProduto) then
    begin
      ShowMessage('C�digo do produto inv�lido. Verifique o campo.');
      Exit;
    end;

    // Verifica se h� estoque suficiente para remo��o
    if QuantidadeRemover > EstoqueAtual then
    begin
      ShowMessage('Quantidade a remover maior que o estoque atual. Opera��o n�o realizada.');
      Exit;
    end;

    // Subtrai os valores
    EstoqueAtualizado := EstoqueAtual - QuantidadeRemover;

    // Atualiza o campo edtEstoque com o novo valor
    edtEstoque.Text := IntToStr(EstoqueAtualizado);

    // Atualiza o banco de dados
    FDQueryEstoque.SQL.Text :=
      'UPDATE TBestoqueprodutos ' +
      'SET quantidadeEstoque = :quantidadeEstoque ' +
      'WHERE codProduto = :codProduto';
    FDQueryEstoque.ParamByName('quantidadeEstoque').AsInteger := EstoqueAtualizado;
    FDQueryEstoque.ParamByName('codProduto').AsInteger := CodProduto;

    // Usa ExecSQL para executar o comando
    FDQueryEstoque.ExecSQL;

    // Atualiza o Grid
    FDQueryEstoque.SQL.Text :=
      'SELECT ' +
      '  e.codProduto as Codigo, ' +
      '  e.nomeProduto as Modelo, ' +
      '  p.tamanhoProduto as Tamanho, ' +
      '  e.refProduto as Referencia, ' +
      '  e.quantidadeEstoque as Quantidade, ' +
      '  p.codTecido, ' +
      '  p.nomeTecido as Tecido, ' +
      '  p.rendimentoKg, ' +
      '  p.localizacaoProduto as Localizacao, ' +
      '  p.precoCusto as Custo ' +
      'FROM ' +
      '  TBestoqueprodutos e ' +
      'JOIN ' +
      '  TBprodutos p ON e.codProduto = p.codProduto';
    FDQueryEstoque.Open;

    // Alerta se o estoque foi zerado
    if EstoqueAtualizado = 0 then
      ShowMessage('Aten��o: o estoque deste produto foi zerado.');

    ShowMessage('Itens removidos do estoque com sucesso!');
  except
    on E: Exception do
      ShowMessage('Erro ao remover itens do estoque: ' + E.Message);
  end;

  // Restaura as larguras das colunas
  RestoreColumnWidths(DBGridEstoqueProdutos);
end;

procedure TFormEstoqueProdutos.ComboBoxProdutosChange(Sender: TObject);
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

procedure TFormEstoqueProdutos.DBGridEstoqueProdutosTitleClick(Column: TColumn);
var
  Coluna: string;
begin
  Coluna := Column.FieldName; // Obt�m o nome do campo da coluna clicada

  if FDQueryEstoque.Active then
  begin
    FDQueryEstoque.IndexFieldNames := Coluna; // Define a ordena��o pelo campo
  end;

  DBGridEstoqueProdutos.DataSource.DataSet.First;
end;

procedure TFormEstoqueProdutos.edtCodRefChange(Sender: TObject);
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


  FDQueryEstoque.Filtered := False; // Desabilita o filtro para aplicar novamente
  FDQueryEstoque.Filtered := edtCodRef.Text <> ''; // S� habilita se houver texto
end;


procedure TFormEstoqueProdutos.edtCodRefKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := UpCase(Key);

  if Key = #13 then // Verifica se a tecla pressionada � Enter
  begin
    Key := #0; // Cancela o som do Enter
    ComboBoxProdutos.OnChange(ComboBoxProdutos);
  end;
end;


procedure TFormEstoqueProdutos.edtFiltroChange(Sender: TObject);
begin
  FDQueryEstoque.Filtered := False; // Desabilita o filtro para aplicar novamente
  FDQueryEstoque.Filtered := edtFiltro.Text <> ''; // S� habilita se houver texto
end;

procedure TFormEstoqueProdutos.FDQueryEstoqueFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var
  Filtro, Produto, Referencia, Localizacao, Tecido, Id: String;
begin
  if not (edtFiltro.Text = '') then
  begin

    Filtro := UpperCase(RemoverAcentos(edtFiltro.Text)); // Remove acentos do filtro

    // Obt�m os valores dos campos e remove os acentos tamb�m
    Produto := UpperCase(RemoverAcentos(DataSet.FieldByName('Modelo').AsString));
    Referencia := UpperCase(RemoverAcentos(DataSet.FieldByName('Referencia').AsString));
    Localizacao := UpperCase(RemoverAcentos(DataSet.FieldByName('Localizacao').AsString));
    Tecido := UpperCase(RemoverAcentos(DataSet.FieldByName('Tecido').AsString));
    Id := UpperCase(RemoverAcentos(DataSet.FieldByName('Codigo').AsString));

    // Verifica se o filtro est� presente em algum dos campos
    Accept := (Pos(Filtro, Produto) > 0) or
              (Pos(Filtro, Referencia) > 0) or
              (Pos(Filtro, Localizacao) > 0) or
              (Pos(Filtro, Tecido) > 0) or
              (Pos(Filtro, Id) > 0);
  end
  else
  begin
    Filtro := UpperCase(RemoverAcentos(edtCodRef.Text)); // Remove acentos do filtro

  // Obt�m os valores dos campos e remove os acentos tamb�m

    if rbBuscaReferencia.Checked then
      Referencia := UpperCase(RemoverAcentos(DataSet.FieldByName('Referencia').AsString))
    else
      Id := UpperCase(RemoverAcentos(DataSet.FieldByName('Codigo').AsString));

    // Verifica se o filtro est� presente em algum dos campos
    Accept := (Pos(Filtro, Referencia) > 0) or
              (Pos(Filtro, Id) > 0);
  end;

end;

procedure TFormEstoqueProdutos.FormCreate(Sender: TObject);
begin
  FDQueryEstoque.Active := true;
  PreencherComboBoxProdutos;
  AjustarLarguraColunas(DBGridEstoqueProdutos);
  SaveColumnWidths(DBGridEstoqueProdutos);
end;

procedure TFormEstoqueProdutos.LimparFiltros;
begin
  edtCodRef.Clear;
  ComboBoxProdutos.Text := '';
  edtFiltro.Clear;
end;

procedure TFormEstoqueProdutos.PreencherComboBoxProdutos;
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

end.
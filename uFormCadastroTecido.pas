unit uFormCadastroTecido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, Math,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, uMainModulo;

type
  TFormCadastroTecido = class(TForm)
    Label1: TLabel;
    EdtNome: TEdit;
    Label2: TLabel;
    EdtReferencia: TEdit;
    MemoObservacoes: TMemo;
    Label3: TLabel;
    btnCadastrarNovoTecido: TButton;
    btnCancelar: TButton;
    btnSalvar: TButton;
    btnAlterar: TButton;
    btnDelete: TButton;
    DSDados: TDataSource;
    DBGridTecidos: TDBGrid;
    Label4: TLabel;
    FDQuery1: TFDQuery;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    Image1: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCadastrarNovoTecidoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Habilitar;
    procedure Desabilitar;
    procedure Limpar;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure DBGridTecidosTitleClick(Column: TColumn);
    procedure AtualizarNomeTecidos;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadastroTecido: TFormCadastroTecido;

implementation

{$R *.dfm}

uses Unit2;

procedure TFormCadastroTecido.AtualizarNomeTecidos;
var
  DBconnect : TForm6;
begin
  DBconnect := TForm6.Create(nil);
  try
    DBconnect.FDConnection1.ExecSQL(
      'UPDATE TBprodutos ' +
      'SET nomeTecido = (' +
      '  SELECT T.nomeTecido ' +
      '  FROM TBtecidos T ' +
      '  WHERE T.codTecido = TBprodutos.codTecido' +
      ') ' +
      'WHERE EXISTS (' +
      '  SELECT 1 ' +
      '  FROM TBtecidos T ' +
      '  WHERE T.codTecido = TBprodutos.codTecido' +
      ');'
    );
    ShowMessage('Sincroniza��o de nomes de tecidos conclu�da com sucesso!');
  except
    on E: Exception do
      ShowMessage('Erro ao atualizar nomes de tecidos: ' + E.Message);
  end;
  DBconnect.Free;
end;


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

procedure TFormCadastroTecido.btnAlterarClick(Sender: TObject);
begin
  Habilitar;
  Limpar;
  EdtNome.SetFocus;
  btnCancelar.Enabled := true;
  btnDelete.Enabled := false;
  btnSalvar.Enabled := true;
  btnAlterar.Enabled := false;
  DSDados.DataSet.Edit;
end;

procedure TFormCadastroTecido.btnCadastrarNovoTecidoClick(Sender: TObject);
begin
  Habilitar;
  Limpar;
  EdtNome.SetFocus;
  DSDados.DataSet.Insert;
  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnDelete.Enabled := false;
  btnCadastrarNovoTecido.Enabled := false;
  btnAlterar.Enabled := false;
end;

procedure TFormCadastroTecido.btnCancelarClick(Sender: TObject);
begin
  Desabilitar;
  Limpar;
  btnCancelar.Enabled := false;
  btnDelete.Enabled := true;
  btnAlterar.Enabled := true;
  btnSalvar.Enabled := false;
  DSDados.DataSet.Cancel;
  DSDados.DataSet.Refresh;
end;

procedure TFormCadastroTecido.btnDeleteClick(Sender: TObject);
begin
  if Application.MessageBox(PChar(Format('%s' + #13 + '[%s]',
    ['Deseja realmente excluir este tecido?',
    DSDados.DataSet.FieldByName('nomeTecido').AsString])), 'Aten��o',
    MB_ICONQUESTION + MB_YESNO) = IDYES then
    DSDados.DataSet.Delete;
    DSDados.DataSet.Refresh;
end;

procedure TFormCadastroTecido.btnSalvarClick(Sender: TObject);
begin
  if ((EdtNome.Text = '') or (EdtReferencia.Text = '')) then
  begin
    Application.MessageBox('� necess�rio preencher os campos informados.', 'Aten��o');
    exit;
  end else
    begin

      DSDados.DataSet.FieldByName('nomeTecido').AsString := EdtNome.Text;
      DSDados.DataSet.FieldByName('refTecido').AsString := EdtReferencia.Text;
      DSDados.DataSet.FieldByName('obsTecido').AsString := MemoObservacoes.Text;
      DSDados.DataSet.Post;
      DSDados.DataSet.Refresh;
      ShowMessage('Salvo com sucesso');
      Limpar;
      Desabilitar;
    end;
    btnAlterar.Enabled := true;
    btnDelete.Enabled := true;
    btnCancelar.Enabled := false;
    btnSalvar.Enabled := false;
    btnCadastrarNovoTecido.Enabled := true;

    AtualizarNomeTecidos; //atualiza o nome dos tecidos na tabela de produtos
end;

procedure TFormCadastroTecido.DBGridTecidosTitleClick(Column: TColumn);
var
  Coluna: string;
begin
  Coluna := Column.FieldName; // Obt�m o nome do campo da coluna clicada

  if FDQuery1.Active then
  begin
    FDQuery1.IndexFieldNames := Coluna; // Define a ordena��o pelo campo
  end;
end;

procedure TFormCadastroTecido.Desabilitar;
begin
  EdtNome.Enabled := false;
  EdtReferencia.Enabled := false;
  MemoObservacoes.Enabled := false;
end;

procedure TFormCadastroTecido.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  FormCadastroTecido := nil;
end;


procedure TFormCadastroTecido.FormCreate(Sender: TObject);
begin
  AjustarLarguraColunas(DBGridTecidos)
end;

procedure TFormCadastroTecido.Habilitar;
begin
  EdtNome.Enabled := true;
  EdtReferencia.Enabled := true;
  MemoObservacoes.Enabled := true;
end;

procedure TFormCadastroTecido.Limpar;
begin
  EdtNome.Clear;
  EdtReferencia.Clear;
  MemoObservacoes.Clear;
end;

end.

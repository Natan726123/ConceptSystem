unit uFormCortador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uMainModulo,
  System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, Math,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TFormCadastroCortador = class(TForm)
    Label1: TLabel;
    edtNome: TEdit;
    Label2: TLabel;
    edtTelefone: TEdit;
    Label3: TLabel;
    edtEndereco: TEdit;
    Label4: TLabel;
    edtBairro: TEdit;
    Label5: TLabel;
    edtCidade: TEdit;
    Label6: TLabel;
    edtCodCortador: TEdit;
    Label7: TLabel;
    btnAlterar: TButton;
    btnDelete: TButton;
    btnCancelar: TButton;
    btnSalvar: TButton;
    DBGridCortador: TDBGrid;
    btnCadastrarCortador: TButton;
    DSDadosCortadores: TDataSource;
    FDQueryCortadores: TFDQuery;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    LinkControlToField6: TLinkControlToField;
    Image1: TImage;
    edtChavePix: TEdit;
    Label9: TLabel;
    LinkControlToField7: TLinkControlToField;
    procedure btnCadastrarCortadorClick(Sender: TObject);
    procedure HabilitarEdits;
    procedure DesabilitarEdits;
    procedure btnCancelarClick(Sender: TObject);
    procedure LimparEdits;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGridCortadorMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure DBGridCortadorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGridCortadorColEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridCortadorTitleClick(Column: TColumn);

  private
    ScrollBloqueado: Boolean;

  public
    { Public declarations }
  end;

var
  FormCadastroCortador: TFormCadastroCortador;

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
      largura := DBGrid.Canvas.TextWidth(DBGrid.Columns[i].Title.Caption) + 20; // Título com padding
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



procedure TFormCadastroCortador.btnAlterarClick(Sender: TObject);
begin
  HabilitarEdits;
  btnCadastrarCortador.Enabled := false;
  btnCancelar.Enabled := true;
  btnSalvar.Enabled := true;
  btnAlterar.Enabled := false;
  btnDelete.Enabled := false;
  DSDadosCortadores.DataSet.Edit;
  edtNome.SetFocus;

  ScrollBloqueado := True; // Bloqueia interações com o DBGrid
  DBGridCortador.Options := DBGridCortador.Options - [dgRowSelect]; // Evita navegação entre linhas
end;

procedure TFormCadastroCortador.btnCadastrarCortadorClick(Sender: TObject);
begin
  HabilitarEdits;
  btnCadastrarCortador.Enabled := false;
  btnCancelar.Enabled := true;
  btnSalvar.Enabled := true;
  btnAlterar.Enabled := false;
  btnDelete.Enabled := false;
  DSDadosCortadores.DataSet.Insert;
  edtNome.SetFocus;

  ScrollBloqueado := True; // Bloqueia interações com o DBGrid
  DBGridCortador.Options := DBGridCortador.Options - [dgRowSelect]; // Evita navegação entre linhas
end;

procedure TFormCadastroCortador.btnCancelarClick(Sender: TObject);
begin
  LimparEdits;
  DesabilitarEdits;
  btnCancelar.Enabled := false;
  btnSalvar.Enabled := false;
  btnAlterar.Enabled := true;
  btnDelete.Enabled := true;
  btnCadastrarCortador.Enabled := true;
  DSDadosCortadores.DataSet.Cancel;
end;

procedure TFormCadastroCortador.btnDeleteClick(Sender: TObject);
begin
  if Application.MessageBox(PChar(Format('%s' + #13 + '[%s]',
    ['Deseja realmente excluir este cortador?',
    DSDadosCortadores.DataSet.FieldByName('Nome').AsString])), 'Atenção',
    MB_ICONQUESTION + MB_YESNO) = IDYES then
      DSDadosCortadores.DataSet.Delete;
      DSDadosCortadores.DataSet.Refresh;
end;

procedure TFormCadastroCortador.btnSalvarClick(Sender: TObject);
begin
  if (edtNome.Text = '') then
  begin
    Application.MessageBox('É necessário preencher os campos informados.', 'Atenção');
    Exit;
  end
  else
  begin
    DSDadosCortadores.DataSet.FieldByName('Nome').AsString := edtNome.Text;
    DSDadosCortadores.DataSet.FieldByName('Telefone').AsString := edtTelefone.Text;
    DSDadosCortadores.DataSet.FieldByName('Endereço').AsString := edtEndereco.Text;
    DSDadosCortadores.DataSet.FieldByName('Bairro').AsString := edtBairro.Text;
    DSDadosCortadores.DataSet.FieldByName('Cidade').AsString := edtCidade.Text;
    DSDadosCortadores.DataSet.FieldByName('Pix').AsString := edtChavePix.Text;
    DSDadosCortadores.DataSet.Post;
    DSDadosCortadores.DataSet.Refresh;
    ShowMessage('Salvo com sucesso');
    LimparEdits;
    DesabilitarEdits;
  end;

  btnAlterar.Enabled := true;
  btnDelete.Enabled := true;
  btnCancelar.Enabled := false;
  btnSalvar.Enabled := false;
  btnCadastrarCortador.Enabled := true;

  ScrollBloqueado := False; // Libera interações
  DBGridCortador.Options := DBGridCortador.Options + [dgRowSelect];
end;

procedure TFormCadastroCortador.DBGridCortadorColEnter(Sender: TObject);
begin
  if ScrollBloqueado then
    Abort; // Cancela a navegação para outras células
end;

procedure TFormCadastroCortador.DBGridCortadorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ScrollBloqueado and (DBGridCortador.DataSource.DataSet.RecNo <> DBGridCortador.DataSource.DataSet.RecNo) then
    Abort; // Cancela o clique se tentar mudar a linha
end;

procedure TFormCadastroCortador.DBGridCortadorMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
    if ScrollBloqueado then
    Handled := True; // Bloqueia rolagem do mouse
end;

procedure TFormCadastroCortador.DBGridCortadorTitleClick(Column: TColumn);
var
  Coluna: string;
begin
  Coluna := Column.FieldName; // Obtém o nome do campo da coluna clicada

  if FDQueryCortadores.Active then
  begin
    FDQueryCortadores.IndexFieldNames := Coluna; // Define a ordenação pelo campo
  end;
end;

procedure TFormCadastroCortador.DesabilitarEdits;
begin
  edtNome.Enabled := false;
  edtTelefone.Enabled := false;
  edtEndereco.Enabled := false;
  edtBairro.Enabled := false;
  edtCidade.Enabled := false;
  edtChavePix.Enabled := false;
end;

procedure TFormCadastroCortador.FormCreate(Sender: TObject);
begin
 AjustarLarguraColunas(DBGridCortador);

end;

procedure TFormCadastroCortador.FormShow(Sender: TObject);
begin
  btnCadastrarCortador.SetFocus;
end;

procedure TFormCadastroCortador.HabilitarEdits;
begin
  edtNome.Enabled := true;
  edtTelefone.Enabled := true;
  edtEndereco.Enabled := true;
  edtBairro.Enabled := true;
  edtCidade.Enabled := true;
  edtChavePix.Enabled := true;
end;

procedure TFormCadastroCortador.LimparEdits;
begin
  edtNome.Clear;
  edtTelefone.Clear;
  edtEndereco.Clear;
  edtBairro.Clear;
  edtCidade.Clear;
  edtChavePix.Clear;
end;

end.

unit uFormDBPath;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uMainModulo;

type
  TFormPathDB = class(TForm)
    edtNamePathDB: TEdit;
    btnSalvarPathDB: TButton;
    Label1: TLabel;
    procedure btnSalvarPathDBClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPathDB: TFormPathDB;
  DBPath : TForm6;

implementation

{$R *.dfm}

procedure TFormPathDB.btnSalvarPathDBClick(Sender: TObject);
begin

  if Application.MessageBox(PChar(
    'Deseja realmente alterar o caminho da base de dados?'), 'Atenção',
    MB_ICONQUESTION + MB_YESNO) = IDYES then
    Form6.FDConnection1.Params.Database := edtNamePathDB.Text;


end;

end.

unit uFormRelEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, qrFramelines, qrpctrls, QuickRpt,
  QRCtrls, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TFormRelEstoque = class(TForm)
    QuickRepEstoque: TQuickRep;
    TitleBand1: TQRBand;
    QRLabelTitulo: TQRLabel;
    QRImage1: TQRImage;
    QRPBand1: TQRPBand;
    QRDBText11: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    QRDBText16: TQRDBText;
    QRDBText17: TQRDBText;
    QRDBText26: TQRDBText;
    QRFrameline9: TQRFrameline;
    QRFrameline11: TQRFrameline;
    QRFrameline12: TQRFrameline;
    QRFrameline13: TQRFrameline;
    QRFrameline14: TQRFrameline;
    QRFrameline15: TQRFrameline;
    QRFrameline16: TQRFrameline;
    QRFrameline17: TQRFrameline;
    QRDBText28: TQRDBText;
    QRGroup1: TQRGroup;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRShape38: TQRShape;
    QRShape39: TQRShape;
    QRShape40: TQRShape;
    QRShape41: TQRShape;
    QRShape42: TQRShape;
    QRShape43: TQRShape;
    QRShape44: TQRShape;
    QRShape45: TQRShape;
    FDQueryRelEstoque: TFDQuery;
    DSDadosRelEstoque: TDataSource;
    QRDBModelo: TQRDBText;
    QRDBTotalGeral: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRExpr1: TQRExpr;
    QRLabelValorEstoque: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRelEstoque: TFormRelEstoque;

implementation

{$R *.dfm}

end.

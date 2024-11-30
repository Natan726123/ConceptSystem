unit uFormRelOrdemCorte;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, QRCtrls, QuickRpt,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, qrFramelines, qrpctrls, Data.DB, uMainModulo,
  Data.Win.ADODB;

type
  TFormRelOrdemCorte = class(TForm)
    QuickRepOrdemCorte: TQuickRep;
    TitleBand1: TQRBand;
    QRLabelTitulo: TQRLabel;
    QRLabelNumOrdem: TQRLabel;
    QRLabelPedidos: TQRLabel;
    QRSysData2: TQRSysData;
    QRLabel5: TQRLabel;
    QRImage1: TQRImage;
    QRSubDetail1: TQRSubDetail;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRGroup1: TQRGroup;
    QRDBText3: TQRDBText;
    QRPBand1: TQRPBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRFrameline1: TQRFrameline;
    QRFrameline2: TQRFrameline;
    QRFrameline3: TQRFrameline;
    QRFrameline4: TQRFrameline;
    QRFrameline5: TQRFrameline;
    QRFrameline6: TQRFrameline;
    QRFrameline7: TQRFrameline;
    QRFrameline8: TQRFrameline;
    QRFrameline9: TQRFrameline;
    QRGroup2: TQRGroup;
    QRDBText12: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    GroupFooterTotalKg: TQRBand;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRBand1: TQRBand;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRDBText15: TQRDBText;
    QRDBText16: TQRDBText;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRLabelObs: TQRLabel;
    QRShape13: TQRShape;
    QRLabel26: TQRLabel;
    procedure QRDBText14Print(sender: TObject; var Value: string);
    procedure QRDBText16Print(sender: TObject; var Value: string);
    procedure QRDBText11Print(sender: TObject; var Value: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRelOrdemCorte: TFormRelOrdemCorte;

implementation

uses
 Unit2;

{$R *.dfm}


procedure TFormRelOrdemCorte.QRDBText11Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('0.00', StrToFloatDef(Value, 0));
end;

procedure TFormRelOrdemCorte.QRDBText14Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('0.00', StrToFloatDef(Value, 0));
end;


procedure TFormRelOrdemCorte.QRDBText16Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('0.00', StrToFloatDef(Value, 0));
end;

end.

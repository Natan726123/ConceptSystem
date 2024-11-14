object FormCadastrarProdutos: TFormCadastrarProdutos
  Left = 0
  Top = 0
  Hint = 'fgdfg'
  Caption = 'Cadastrar Produtos'
  ClientHeight = 638
  ClientWidth = 673
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 192
    Top = 8
    Width = 257
    Height = 37
    Caption = 'Cadastro de Produtos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 80
    Width = 36
    Height = 15
    Caption = 'Nome:'
  end
  object Label3: TLabel
    Left = 16
    Top = 128
    Width = 58
    Height = 15
    Caption = 'Refer'#234'ncia:'
  end
  object Label4: TLabel
    Left = 312
    Top = 80
    Width = 73
    Height = 15
    Caption = 'Ficha T'#233'cnica:'
  end
  object Label5: TLabel
    Left = 16
    Top = 173
    Width = 37
    Height = 15
    Caption = 'Tecido:'
  end
  object Label6: TLabel
    Left = 215
    Top = 173
    Width = 42
    Height = 15
    Caption = 'C'#243'digo:'
  end
  object Label7: TLabel
    Left = 312
    Top = 173
    Width = 86
    Height = 15
    Caption = 'Rendimento/kg:'
  end
  object Label8: TLabel
    Left = 528
    Top = 173
    Width = 64
    Height = 15
    Caption = 'Localiza'#231#227'o:'
  end
  object Edit1: TEdit
    Left = 16
    Top = 96
    Width = 257
    Height = 23
    TabOrder = 0
    TextHint = 'Digite o nome do produto'
  end
  object Edit2: TEdit
    Left = 16
    Top = 144
    Width = 257
    Height = 23
    TabOrder = 1
    TextHint = 'Digite uma refer'#234'ncia do produto'
  end
  object Memo1: TMemo
    Left = 312
    Top = 96
    Width = 345
    Height = 71
    TabOrder = 2
  end
  object ComboBoxTecidos: TComboBox
    Left = 16
    Top = 188
    Width = 193
    Height = 23
    TabOrder = 3
    Text = 'ComboBoxTecidos'
    OnChange = ComboBoxTecidosChange
  end
  object edtCodTecido: TEdit
    Left = 215
    Top = 188
    Width = 58
    Height = 23
    Enabled = False
    ReadOnly = True
    TabOrder = 4
  end
  object Edit3: TEdit
    Left = 312
    Top = 188
    Width = 201
    Height = 23
    NumbersOnly = True
    TabOrder = 5
    TextHint = 'Digite o rendimento de pe'#231'as por kg'
  end
  object Edit4: TEdit
    Left = 528
    Top = 188
    Width = 129
    Height = 23
    TabOrder = 6
  end
  object DSDadosCadastroProdutos: TDataSource
    DataSet = Form6.FDQuery1
    Left = 504
    Top = 32
  end
  object FDQueryTecidos: TFDQuery
    Connection = Form6.FDConnection1
    SQL.Strings = (
      'SELECT codTecido, nomeTecido FROM TBtecidos')
    Left = 592
    Top = 32
  end
end

object FormDashboard: TFormDashboard
  Left = 0
  Top = 0
  Caption = 'Dashboard'
  ClientHeight = 547
  ClientWidth = 835
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  Position = poScreenCenter
  OnClose = FormClose
  TextHeight = 15
  object btnGerarOrdemCorte: TButton
    Left = 8
    Top = 208
    Width = 257
    Height = 25
    Caption = 'Gerar Ordem de Corte'
    TabOrder = 0
    OnClick = btnGerarOrdemCorteClick
  end
  object Button2: TButton
    Left = 8
    Top = 97
    Width = 257
    Height = 25
    Caption = 'Cadastrar Cortador'
    TabOrder = 1
  end
  object btnCadastrarTecido: TButton
    Left = 8
    Top = 66
    Width = 257
    Height = 25
    Caption = 'Cadastrar Tecido'
    TabOrder = 2
    OnClick = btnCadastrarTecidoClick
  end
  object btnCadastrarProdutos: TButton
    Left = 8
    Top = 35
    Width = 257
    Height = 25
    Caption = 'Cadastrar Produto'
    TabOrder = 3
    OnClick = btnCadastrarProdutosClick
  end
  object Button5: TButton
    Left = 8
    Top = 128
    Width = 257
    Height = 25
    Caption = 'Cadastrar Faccionista'
    TabOrder = 4
  end
  object Button6: TButton
    Left = 8
    Top = 239
    Width = 257
    Height = 25
    Caption = 'Criar Ficha de Fac'#231#227'o'
    TabOrder = 5
  end
  object MainMenu1: TMainMenu
    Left = 536
    object Cadastrar1: TMenuItem
      Caption = 'Cadastrar'
      object CadastrarProduto1: TMenuItem
        Caption = 'Cadastrar Produto'
        OnClick = CadastrarProduto1Click
      end
      object CadastrarTecido1: TMenuItem
        Caption = 'Cadastrar Tecido'
        OnClick = CadastrarTecido1Click
      end
      object CadastrarCortador1: TMenuItem
        Caption = 'Cadastrar Cortador'
      end
      object CadastrarFaccionista1: TMenuItem
        Caption = 'Cadastrar Faccionista'
      end
    end
    object Editar1: TMenuItem
      Caption = 'Editar'
      object Basededados1: TMenuItem
        Caption = 'Base de dados'
        OnClick = Basededados1Click
      end
    end
  end
end

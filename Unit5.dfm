object FormCadastroTecido: TFormCadastroTecido
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastrar Tecido'
  ClientHeight = 550
  ClientWidth = 557
  Color = clSnow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 95
    Width = 36
    Height = 15
    Caption = 'Nome:'
  end
  object Label2: TLabel
    Left = 16
    Top = 139
    Width = 58
    Height = 15
    Caption = 'Refer'#234'ncia:'
  end
  object Label3: TLabel
    Left = 270
    Top = 95
    Width = 70
    Height = 15
    Caption = 'Observa'#231#245'es:'
  end
  object Label4: TLabel
    Left = 152
    Top = 8
    Width = 237
    Height = 37
    Caption = 'Cadastro de Tecidos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object EdtNome: TEdit
    Left = 16
    Top = 110
    Width = 217
    Height = 23
    Enabled = False
    TabOrder = 0
    TextHint = 'digite o nome do tecido'
  end
  object EdtReferencia: TEdit
    Left = 16
    Top = 156
    Width = 217
    Height = 23
    Enabled = False
    TabOrder = 1
    TextHint = 'digite uma refer'#234'ncia'
  end
  object MemoObservacoes: TMemo
    Left = 270
    Top = 110
    Width = 267
    Height = 69
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object btnCadastrarNovoTecido: TButton
    Left = 16
    Top = 56
    Width = 137
    Height = 25
    Caption = 'Cadastrar Novo Tecido'
    TabOrder = 3
    OnClick = btnCadastrarNovoTecidoClick
  end
  object btnCancelar: TButton
    Left = 368
    Top = 210
    Width = 81
    Height = 33
    Caption = 'Cancelar'
    Enabled = False
    TabOrder = 4
    OnClick = btnCancelarClick
  end
  object btnSalvar: TButton
    Left = 455
    Top = 210
    Width = 82
    Height = 33
    Caption = 'Salvar'
    Enabled = False
    TabOrder = 5
    OnClick = btnSalvarClick
  end
  object btnAlterar: TButton
    Left = 16
    Top = 210
    Width = 97
    Height = 33
    Caption = 'Alterar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    StyleElements = [seFont, seClient]
    OnClick = btnAlterarClick
  end
  object btnDelete: TButton
    Left = 119
    Top = 210
    Width = 97
    Height = 33
    Caption = 'Delete'
    TabOrder = 7
    OnClick = btnDeleteClick
  end
  object DBGrid1: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 264
    Width = 551
    Height = 283
    Align = alBottom
    BorderStyle = bsNone
    DataSource = DSDados
    DragCursor = crDefault
    DrawingStyle = gdsGradient
    ReadOnly = True
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object DSDados: TDataSource
    DataSet = Form6.FDQuery1
    Left = 504
    Top = 42
  end
  object BindSourceDB1: TBindSourceDB
    DataSet = Form6.FDQuery1
    ScopeMappings = <>
    Left = 440
    Top = 34
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 364
    Top = 39
    object LinkControlToField1: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDB1
      FieldName = 'nomeTecido'
      Control = EdtNome
      Track = True
    end
    object LinkControlToField2: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDB1
      FieldName = 'obsTecido'
      Control = MemoObservacoes
      Track = False
    end
    object LinkControlToField3: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDB1
      FieldName = 'refTecido'
      Control = EdtReferencia
      Track = True
    end
  end
end

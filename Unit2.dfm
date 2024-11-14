object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 747
  ClientWidth = 1183
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 40
    Top = 24
    Width = 305
    Height = 37
    Caption = 'Ordem de Corte: 12345'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = '@Malgun Gothic'
    Font.Style = [fsBold]
    Font.Quality = fqClearType
    ParentFont = False
  end
  object Button1: TButton
    Left = 1078
    Top = 696
    Width = 75
    Height = 25
    Caption = 'Gerar Ordem'
    TabOrder = 0
  end
  object Panel: TPanel
    Left = 24
    Top = 93
    Width = 385
    Height = 214
    Caption = 'Panel'
    ShowCaption = False
    TabOrder = 1
    object Label2: TLabel
      Left = 14
      Top = 152
      Width = 65
      Height = 15
      Caption = 'Quantidade:'
    end
    object ComboBoxTecidos: TComboBox
      Left = 14
      Top = 32
      Width = 329
      Height = 23
      TabOrder = 0
      Text = 'Tecido'
      Items.Strings = (
        'Cotton Liso'
        'Microfibra'
        'Frezze'
        'Cotton Liso Preto/Branco/Chocolate'
        'Cotton Mescla'
        'Micro Canelada'
        'Cotton Confete'
        'Renda'
        'Micro Pto/Cho'
        'Romantic'
        'Cotton Lolita'
        'Cotton Dry'
        'Suplex Preto/Chocolate')
    end
    object ComboBoxModelos: TComboBox
      Left = 14
      Top = 69
      Width = 329
      Height = 23
      TabOrder = 1
      Text = 'Modelo'
      Items.Strings = (
        'Carinho'
        'Conforto'
        'Discreta'
        'Docinho'
        'Eleg'#226'ncia'
        'Levada'
        'Light'
        'Pompom'
        'Sonho'
        'Sonho Plus')
    end
    object RBTamP: TRadioButton
      Left = 14
      Top = 114
      Width = 33
      Height = 17
      Caption = 'P'
      TabOrder = 2
    end
    object RBTamM: TRadioButton
      Left = 53
      Top = 114
      Width = 33
      Height = 17
      Caption = 'M'
      TabOrder = 3
    end
    object RBTamG: TRadioButton
      Left = 102
      Top = 114
      Width = 33
      Height = 17
      Caption = 'G'
      TabOrder = 4
    end
    object RBTamGG: TRadioButton
      Left = 149
      Top = 114
      Width = 44
      Height = 17
      Caption = 'GG'
      TabOrder = 5
    end
    object RBTam48: TRadioButton
      Left = 199
      Top = 114
      Width = 44
      Height = 17
      Caption = '48'
      TabOrder = 6
    end
    object RBTam50: TRadioButton
      Left = 249
      Top = 114
      Width = 44
      Height = 17
      Caption = '50'
      TabOrder = 7
    end
    object RBTam52: TRadioButton
      Left = 299
      Top = 114
      Width = 44
      Height = 17
      Caption = '52'
      TabOrder = 8
    end
    object btnAdicionarItem: TButton
      Left = 268
      Top = 178
      Width = 75
      Height = 25
      Caption = 'Adicionar'
      TabOrder = 9
      OnClick = btnAdicionarItemClick
    end
    object EditQuantidade: TEdit
      Left = 85
      Top = 149
      Width = 258
      Height = 23
      NumbersOnly = True
      OEMConvert = True
      TabOrder = 10
    end
  end
  object Panel2: TPanel
    Left = 24
    Top = 313
    Width = 385
    Height = 160
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 2
    object Label3: TLabel
      Left = 13
      Top = 72
      Width = 100
      Height = 15
      Caption = 'Data de expedi'#231#227'o:'
    end
    object Label4: TLabel
      Left = 13
      Top = 112
      Width = 86
      Height = 15
      Caption = 'Data de entrega:'
    end
    object ComboBox1: TComboBox
      Left = 14
      Top = 16
      Width = 179
      Height = 23
      TabOrder = 0
      Text = 'Cortador'
      Items.Strings = (
        'Italo'
        'Atila'
        'Thiago')
    end
    object CalendarPicker1: TCalendarPicker
      Left = 119
      Top = 65
      Height = 32
      CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
      CalendarHeaderInfo.DaysOfWeekFont.Height = -13
      CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
      CalendarHeaderInfo.DaysOfWeekFont.Style = []
      CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.Font.Color = clWindowText
      CalendarHeaderInfo.Font.Height = -20
      CalendarHeaderInfo.Font.Name = 'Segoe UI'
      CalendarHeaderInfo.Font.Style = []
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TextHint = 'select a date'
    end
    object CalendarPicker2: TCalendarPicker
      Left = 119
      Top = 103
      Height = 32
      CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
      CalendarHeaderInfo.DaysOfWeekFont.Height = -13
      CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
      CalendarHeaderInfo.DaysOfWeekFont.Style = []
      CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.Font.Color = clWindowText
      CalendarHeaderInfo.Font.Height = -20
      CalendarHeaderInfo.Font.Name = 'Segoe UI'
      CalendarHeaderInfo.Font.Style = []
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      TextHint = 'select a date'
    end
  end
  object StringGrid1: TStringGrid
    Left = 541
    Top = 93
    Width = 612
    Height = 380
    DefaultColWidth = 120
    RowCount = 1
    FixedRows = 0
    TabOrder = 3
  end
end

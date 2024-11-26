object FormGerarOrdemCorte: TFormGerarOrdemCorte
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'FormGerarOrdemCorte'
  ClientHeight = 724
  ClientWidth = 1183
  Color = clBtnFace
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
    Left = 24
    Top = 24
    Width = 313
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
    Left = 1049
    Top = 672
    Width = 113
    Height = 33
    Caption = 'Gerar Ordem'
    TabOrder = 0
  end
  object Panel: TPanel
    Left = 24
    Top = 101
    Width = 409
    Height = 276
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
    object ComboBoxProdutos: TComboBox
      Left = 14
      Top = 32
      Width = 355
      Height = 29
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'Modelo'
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
    object btnAdicionarItem: TButton
      Left = 268
      Top = 178
      Width = 75
      Height = 25
      Caption = 'Adicionar'
      TabOrder = 1
    end
    object EditQuantidade: TEdit
      Left = 85
      Top = 149
      Width = 258
      Height = 23
      NumbersOnly = True
      OEMConvert = True
      TabOrder = 2
    end
  end
  object DBGridOrdemDeCorte: TDBGrid
    Left = 483
    Top = 101
    Width = 679
    Height = 548
    Align = alCustom
    BorderStyle = bsNone
    Color = clSnow
    DragCursor = crDefault
    DrawingStyle = gdsGradient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    ShowHint = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object DBGrid1: TDBGrid
    Left = 24
    Top = 414
    Width = 409
    Height = 235
    Align = alCustom
    BorderStyle = bsNone
    Color = clSnow
    DragCursor = crDefault
    DrawingStyle = gdsGradient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    ShowHint = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object DSDadosProdutos: TDataSource
    DataSet = FDQueryProdutos
    Left = 432
  end
  object FDQueryProdutos: TFDQuery
    Active = True
    Connection = Form6.FDConnection1
    SQL.Strings = (
      'select P.codProduto as '#39'cod Produto'#39','
      'P.nomeProduto as '#39'Produto'#39','
      'P.refProduto as '#39'Refer'#234'ncia'#39','
      'P.tamanhoProduto as '#39'Tamanho'#39','
      'P.rendimentoKg as '#39'Rendimento'#39','
      'P.codTecido as '#39'Cod Tecido'#39','
      'T.nomeTecido as '#39'Tecido'#39','
      'P.fichaTecnica as '#39'Ficha T'#233'cnica'#39
      ''
      ''
      'from TBprodutos P, TBtecidos T'
      #9'where P.codTecido = T.codTecido;')
    Left = 544
  end
end

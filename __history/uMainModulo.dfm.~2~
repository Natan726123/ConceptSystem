object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'Form6'
  ClientHeight = 393
  ClientWidth = 555
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\sqlite\ConceptDB.db'
      'OpenMode=CreateUTF16'
      'DriverID=SQLite'
      'LockingMode=Normal')
    FormatOptions.AssignedValues = [fvDefaultParamDataType]
    FormatOptions.DefaultParamDataType = ftString
    UpdateOptions.AssignedValues = [uvLockPoint, uvCheckReadOnly, uvUpdateNonBaseFields]
    UpdateOptions.UpdateNonBaseFields = True
    UpdateOptions.CheckReadOnly = False
    Connected = True
    LoginPrompt = False
    Left = 136
    Top = 96
  end
  object FDQuery1: TFDQuery
    AggregatesActive = True
    Connection = FDConnection1
    FormatOptions.AssignedValues = [fvDefaultParamDataType]
    FormatOptions.DefaultParamDataType = ftString
    ResourceOptions.AssignedValues = [rvEscapeExpand, rvDirectExecute, rvDefaultParamType, rvStoreMergeData]
    ResourceOptions.DirectExecute = True
    ResourceOptions.DefaultParamType = ptResult
    ResourceOptions.StoreMergeData = dmDataSet
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.UpdateTableName = 'TBtecidos'
    SQL.Strings = (
      'select * from TBtecidos;')
    Left = 376
    Top = 96
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 136
    Top = 248
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 384
    Top = 248
  end
end

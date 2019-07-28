object DM: TDM
  OldCreateOrder = False
  Height = 255
  Width = 216
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=D:\wigny\DelphiProjects\CurriculumGenerator\DB_CURRICUL' +
        'UMGENERATOR.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 32
    Top = 144
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection1
    Left = 32
    Top = 80
  end
  object FDQueryTemp: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT count(ID_FORMACAO_ACADEMICA) FROM GERAR_FORMACAO_ACADEMIC' +
        'A where ID_CURRICULO = 12;'
      '    ')
    Left = 32
    Top = 24
  end
end

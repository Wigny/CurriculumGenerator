object FormCadPessoa: TFormCadPessoa
  Left = 439
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cadastrar Usu'#225'rio'
  ClientHeight = 571
  ClientWidth = 887
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 528
    Width = 887
    Height = 43
    Align = alBottom
    TabOrder = 0
    object btOk: TButton
      AlignWithMargins = True
      Left = 744
      Top = 6
      Width = 137
      Height = 31
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alRight
      Caption = 'Pronto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btOkClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 887
    Height = 528
    Align = alClient
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 16
      Top = 8
      Width = 513
      Height = 321
      Caption = 'Informa'#231#245'es pessoais'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 23
        Top = 35
        Width = 52
        Height = 18
        Caption = 'Nome *'
      end
      object CPF: TLabel
        Left = 161
        Top = 112
        Width = 38
        Height = 18
        Caption = 'CPF *'
      end
      object Label2: TLabel
        Left = 304
        Top = 112
        Width = 32
        Height = 18
        Caption = 'RG *'
      end
      object Sexo: TLabel
        Left = 161
        Top = 185
        Width = 45
        Height = 18
        Caption = 'Sexo *'
      end
      object Label3: TLabel
        Left = 347
        Top = 185
        Width = 144
        Height = 18
        Caption = 'Data de nascimento *'
      end
      object Label4: TLabel
        Left = 23
        Top = 257
        Width = 87
        Height = 18
        Caption = 'Nacionalidade'
      end
      object imageUserProfile: TImage
        Left = 22
        Top = 103
        Width = 100
        Height = 100
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000640000
          00640804000000DAEB5DDF0000000467414D410000B18F0BFC61050000000262
          4B474400FF878FCCBF0000000774494D4507E3060B14251373272BB80000090E
          4944415478DAED9B077014551CC6BF841C415A281194D095AAA28C9A8888A080
          28D295AA4340A40982232A0A22D244060145C542075114A50A2A1A458A0E4545
          5001094D129420A1249000297E97B0EFDEDEED95DDDBDB5B9C7CCC90FBEFDDEE
          ED6FDF7BFFF2DEBB08FC4F1411EE1B28022902B1B98A40ECA62210BB29542025
          702D6AA316AAA002AEA29D85741CC3211CC4DFC8BE32404AE026B4C2DD68804A
          0508B2B290863DD8886FB0DB6C1C734162703F1E4153B6826FA5630B96E04B9C
          B1234871B4C53042140FF0F317B11933F105FFDA0AA40E9E470F94D479D6397C
          8CC948B60F483BDECE8D06CFDD8D17B0D60E20511880F1A8A8F14E063D542A4E
          F0B903A57035E2E8C9CA687CEE24C6603672C20B12851178C9A34B65601BBEC2
          8F74B6A77101B93C520CD1284787DC046D10EF81739E8F625A7028C181446238
          26B939D9B3588DF9D85AD00E5A2A8504F4450794551DCDC228BC81FC7081F4C4
          BB6E37B409AF200997FC9CE760A47901CD54C7CE6010968607E4362C434DC9CE
          26D6AB381EE0D995893290E1D3A543E88A9FAC0729C790D656B23330166FF96D
          0B59C53104E354E3652DC3A9C120691C641866708C283AC738F2B6EE3E1E81A1
          6C4397ABC8C5D30C9296825C8775A82BAC3C4CA4DFC935709D626CC7D1D203D9
          C7563E6825C8CBBC019796D30F9D3578A5B25880CEAA2B8FB30EA41AD6A3BEB0
          8EA2237E3188E15463ACE21515ED61A4396A15483FBC2F7587B1EC56C1692CDB
          41511EFA639E3520C599EA751256329FA0A15E2DA936F380EB85B582E9A7EE9C
          D808481D7C8BAAC29ACE2425784DA3BF5274142DB1DF0A9087F11173AC426532
          D9F8CE04907BB086C94BA172D8229F590132012F8AD73BD11AFF9A0012CBF2F7
          66614D643E1C7290626C8FAEC25A8C3E1C9EC12B120BF1A8B03E412FBD51493F
          48690ECC3B85359A49A2391ACD7650B485B57F66A8412A71A8DF70F9753EDB63
          914920894CFE95BBF91DF7222DD42055F13DDD65A17238F0579904D2119F0A17
          7210CD91126A90EAD8881A975F5F623C596712C8838C1F8ECBAF8FE06EFC156A
          9038B6C875975FE7A01BBFDE1C756198555AE4005B2435D420B1AC001B09AB3F
          E69804D29F698FA25D0C893A9DBA7E90922C7F5A08CB80C7F7A289F45B8A36B0
          A39D0F354804D3EEDEC25A81EEBAAA426F72B063B992F945F4863A8B342391FD
          794C16AFF7D351EAF42F9AAAC60E5B47FA86297A2F6004A40D568A49838BCC8B
          CC18EE5D982F28B3C659F485EBAD0089E3D3AB27ACC5AC0E8D14B9B2A2180C5D
          09CA5E0EF56356804462361E13561A07E68E20416EA303A924AC3918A07FAACE
          5885D89143335A58B3F14450D39D5178078F0B2B9B29E9E7FA2F620CA43CBFCA
          95389EC52346BE5AA83D3E90E62B37B1C2396D1508D8F8B398D02BDAC1A778D8
          E0956A61196E15560EAF3CDFC8658C8254A4E7BA4BB29762B091E78872789791
          C8A50DF45FA7AC04015DE462D6268AF2F11E46EA9EDB2ACB783150BA87B32CA8
          0C2EFA18077160068648761E6BBC51F847C715AE6160ED2D4D2B81577CCEA8DB
          086636BE2A3B5453D59124E64B5B033CFB0E4C625620EB3BB6879E07611A0890
          802522A52F542A9DC002BFE12C8EB9D413A8A23A76180FE167E3B712ECD25B5B
          26DF716EC77E25DE1AD6145AC9A483E0EDE9AE6FF678278DA36CB1FEF92CB340
          9C51E02D568DEE4A6117DBCCBA228503F802ED68C410B8113D5D8234B9E7AE64
          06D785012F15990C025673AFE316CD77B2E892CF146CD6284190721E5B3A3C95
          CF0730859E4B776960CE3A7B5D4CA0FF8F0AFE4205CA64AB4CD13B236FD6CE87
          D248C453D2447460DAC37F091E63CCA96D74E549A10289444D7690149CF0F27E
          3DD6DDDD7D8C00B58EE043CCE5FFF5F0306B9AFA1EEF1FC778E6C101CFCA070E
          1283675933C4D01B4DF03A9715810674A21DD0D0E7AE9473F88D57588E7DE248
          0DFAB17E62B64C513666B292CF3017E46A4C65142EFCF46156207FF8F86C4534
          4633DCCE8E164B204741ECCEE3F03DCFB64CC6766CC44EA47B9C551F4FF241A9
          57EDF318934606369F12184825BC896E923D509ABAF1A6686254E699E5E9B122
          0AFCD771C6ED9305CE585B51780063F800D4FA08C3BD76669D201519297AA88E
          0CA0BF0F8DAA1125D16DCFD7876CAB747F27FA07298DE91CC4B2921904F78608
          C41971061246BDDBE83D8CF0BAB7254010E73AF828A984727A9BA141D58381A8
          0B1F5E0DC9CEE5A09FE07B8AC31F4822DE164B624EFD8941A62CB5F9D3BD2CB8
          EA48F63926993E17307C8324E013551E954C27B9D1020CA79A338AC801F608DD
          CD366320B1F418AD243B157DF1B545184EDD8779AAA8FF357AD2EB19009197F1
          9D65E8208259AB5E784715597C6C4DF00ED294B1D73569964BA849C1EC7033A4
          483A9A972557934637B0451F482916471D257B19474780C982A92AC37CACAB64
          AF6232A3E988BD81F4C47C692E713F3AF94C4A42A9865829F9AF0B1CA79A1D5C
          1BA402C95DB3561731C4B4752923EA875952ACDFCC9EA211E7B541FA30057195
          495E9BD322A9BB790EF38C058181C4B0315B08EB1407D886306238D51C2B987C
          2AFA9E581E3B1FB540DA330CBA767FCE63EE13E42EE9A015C538DF4F58D92CDF
          56FB07512FBAA413EB87306338D5046BA44472093BBFDBC3F50469C008EA8AA7
          4B594E99B1D819AC1C58484FAA2815AD59EDFB0119C2EA439166238649EA0E3F
          94C9AC4F90687EBC83B0B6B3663B097BA802BE94AAC7D54C2155B5A63B485D24
          49F320E66D073043E3A5BB49414B96143E40BA732029B94D26DAD1D5D947CD59
          D0292B32B98C6D1FFB029137499AB5CDCF2CC5623D1A0BCB6D53A81AE42A3AB9
          96C29ACB186A75BEEB4B11785F5AFD4DE2F0CFF206529D31BC96B006330CD94B
          83589F283A887BE43D5D6A903BE919949F4164E241CBCADA40D50CEBC428C940
          1BFCE80DA40787BAB2A67784C487C27DE76EAAC91EA3CCAEB80D7735C833982A
          5E6F63CD6CE22F374D510C877BBC74B7D3BC814CE59B8A56A1B3AD867AE1DDAE
          9012FAD7F0AC364804CB27D766995D3C29DF563F1377DE4D67691BE23C292356
          DDA87A8FB5FDB58C69A4987D94411C58CE587EE5680D4B3E91CCAB4156AA7EC7
          6677AD65471325867A0CCC6210BC72344BDE42A20689E728A9ADF372E1D201F4
          92E782DDBD523C121976ECE4ABB4948FC3AC185553DA5AB7EC08F072E19447F9
          6DF7671FB08A40ECA62210BBE93F6D070F8304A4EE2300000025744558746461
          74653A63726561746500323031392D30362D31315432303A33373A30362B3030
          3A30309980C0210000002574455874646174653A6D6F6469667900323031392D
          30362D31315432303A33373A30362B30303A3030E8DD789D0000000049454E44
          AE426082}
        Proportional = True
      end
      object Label6: TLabel
        Left = 304
        Top = 257
        Width = 70
        Height = 18
        Caption = 'Estado civil'
      end
      object edNome: TEdit
        Left = 23
        Top = 59
        Width = 468
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object edCPF: TMaskEdit
        Left = 161
        Top = 136
        Width = 114
        Height = 24
        EditMask = '000.000.000-00;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 14
        ParentFont = False
        TabOrder = 1
        Text = '   .   .   -  '
      end
      object edRG: TEdit
        Left = 304
        Top = 136
        Width = 187
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object boxSexo: TComboBox
        Left = 161
        Top = 209
        Width = 170
        Height = 22
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Items.Strings = (
          'Masculino'
          'Feminino')
      end
      object edNascimento: TMaskEdit
        Left = 360
        Top = 209
        Width = 131
        Height = 24
        EditMask = '!99/99/0000;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 4
        Text = '  /  /    '
      end
      object edNacionalidade: TEdit
        Left = 23
        Top = 281
        Width = 252
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object btSelecionarImagem: TButton
        Left = 23
        Top = 209
        Width = 100
        Height = 25
        Caption = 'Selecionar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 0
        ParentFont = False
        TabOrder = 7
        OnClick = btSelecionarImagemClick
      end
      object boxEstadoCivil: TComboBox
        Left = 304
        Top = 281
        Width = 187
        Height = 22
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        Items.Strings = (
          'Solteiro(a)'
          'Casado(a)'
          'Divorciado(a)'
          'Vi'#250'vo(a)'
          'Separado(a)')
      end
    end
    object GroupBox2: TGroupBox
      Left = 535
      Top = 8
      Width = 323
      Height = 321
      Caption = 'Contato'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object Label5: TLabel
        Left = 23
        Top = 35
        Width = 38
        Height = 18
        Caption = 'E-mail'
      end
      object Telefone: TLabel
        Left = 23
        Top = 112
        Width = 57
        Height = 18
        Caption = 'Telefone'
      end
      object Celular: TLabel
        Left = 23
        Top = 185
        Width = 42
        Height = 18
        Caption = 'Celular'
      end
      object edCelular: TEdit
        Left = 23
        Top = 209
        Width = 172
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object edEmail: TEdit
        Left = 23
        Top = 59
        Width = 275
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object edTelefone: TEdit
        Left = 23
        Top = 136
        Width = 170
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
    object GroupBox3: TGroupBox
      Left = 16
      Top = 335
      Width = 842
      Height = 177
      Caption = 'Endere'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object Label7: TLabel
        Left = 23
        Top = 35
        Width = 44
        Height = 18
        Caption = 'Estado'
      end
      object Label9: TLabel
        Left = 24
        Top = 101
        Width = 37
        Height = 18
        Caption = 'Bairro'
      end
      object Label10: TLabel
        Left = 416
        Top = 101
        Width = 73
        Height = 18
        Caption = 'Logradouro'
      end
      object Número: TLabel
        Left = 704
        Top = 101
        Width = 52
        Height = 18
        Caption = 'N'#250'mero'
      end
      object Label8: TLabel
        Left = 360
        Top = 35
        Width = 43
        Height = 18
        Caption = 'Cidade'
      end
      object boxEstado: TComboBox
        Left = 24
        Top = 59
        Width = 307
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = boxEstadoChange
      end
      object boxCidade: TComboBox
        Left = 359
        Top = 59
        Width = 458
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = boxCidadeChange
      end
      object edBairro: TEdit
        Left = 23
        Top = 125
        Width = 362
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object edRua: TEdit
        Left = 416
        Top = 125
        Width = 257
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object edNumero: TEdit
        Left = 704
        Top = 125
        Width = 113
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 80
    Top = 136
  end
end

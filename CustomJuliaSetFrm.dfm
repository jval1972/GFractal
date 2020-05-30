object CustomJuliaSetForm: TCustomJuliaSetForm
  Left = 335
  Top = 253
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Custom Julia set'
  ClientHeight = 264
  ClientWidth = 352
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000044444440000000000000
    0000000000444444444444000000000000000000444444444444444000000000
    0000000444444444444444444000000000000044444444444444444444000000
    0000044444442F224444444444000000000044444442F1222222F24444400000
    0004444444422F1E22EEF224444000000044444444422EFEEEF11FF444400000
    0044444444222EFFFFEE222444400000044444444422EF11EF22224444400000
    44444444422F1FEEE22244444440000044444444422EF1E22224444444400004
    44444444222FFEE2224444444400000444444444222EFE222444444444000004
    4444444222EEFF2224444444440000444444442222E1FE224444444440000044
    44444222EEEF1F2244444444400000444442222FE11FE2244444444400000044
    44222EEFFFFE2224444444400000004444FF11FEEEFE22444444444000000044
    4422FEE22E1F224444444400000000444442F2222221F2444444400000000004
    44444444422F2444444400000000000444444444444444444440000000000000
    4444444444444444440000000000000000444444444444444000000000000000
    0004444444444440000000000000000000000044444440000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFFF01FFFFFC003FFFF0001FFFE00007FFC00003FF800003FF000001FE00
    0001FC000001FC000001F8000001F0000001F0000001E0000003E0000003E000
    0003C0000007C0000007C000000FC000001FC000001FC000003FC000007FE000
    00FFE00001FFF00003FFFC0007FFFE001FFFFFC07FFFFFFFFFFFFFFFFFFF}
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 221
    Width = 352
    Height = 2
    Align = alBottom
    Shape = bsBottomLine
  end
  object Panel1: TPanel
    Left = 0
    Top = 223
    Width = 352
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    object Panel2: TPanel
      Left = 99
      Top = 0
      Width = 253
      Height = 41
      Align = alRight
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      object OKBtn: TButton
        Left = 72
        Top = 8
        Width = 75
        Height = 25
        Caption = 'OK'
        Default = True
        ModalResult = 1
        TabOrder = 0
      end
      object Button1: TButton
        Left = 160
        Top = 8
        Width = 75
        Height = 25
        Cancel = True
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 1
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 352
    Height = 221
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 8
    Caption = ' '
    TabOrder = 1
    object Memo1: TMemo
      Left = 8
      Top = 8
      Width = 336
      Height = 113
      Align = alTop
      Color = 8454143
      Lines.Strings = (
        'Calculate a custom Julia set:'
        ' f(z) = z^2 + x + y*i'
        ''
        'For example:'
        'x = -0.39054'
        'y = -0.58679'
        '<siegel>')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object Panel4: TPanel
      Left = 8
      Top = 121
      Width = 336
      Height = 92
      Align = alClient
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 1
      object Label1: TLabel
        Left = 16
        Top = 16
        Width = 11
        Height = 13
        Caption = 'x: '
        FocusControl = Edit1
      end
      object Label2: TLabel
        Left = 16
        Top = 48
        Width = 11
        Height = 13
        Caption = 'y: '
        FocusControl = Edit2
      end
      object Edit1: TEdit
        Left = 40
        Top = 16
        Width = 121
        Height = 21
        TabOrder = 0
        Text = '-0,39054'
      end
      object Edit2: TEdit
        Left = 40
        Top = 48
        Width = 121
        Height = 21
        TabOrder = 1
        Text = '-0,58679'
      end
    end
  end
end

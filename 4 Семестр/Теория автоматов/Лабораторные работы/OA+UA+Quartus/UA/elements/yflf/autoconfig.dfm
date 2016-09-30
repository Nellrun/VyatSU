object Form2: TForm2
  Left = 299
  Top = 213
  Width = 290
  Height = 176
  Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080#1081' '#1088#1077#1078#1080#1084
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 210
    Height = 16
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1090#1072#1082#1090#1086#1074
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 195
    Height = 16
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1074#1093#1086#1076#1085#1099#1077' '#1089#1080#1075#1085#1072#1083#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 48
    Width = 245
    Height = 26
    Caption = 
      #1043#1088#1091#1087#1087#1099' '#1089#1080#1075#1085#1072#1083#1086#1074', '#1087#1086#1076#1072#1102#1097#1080#1093#1089#1103' '#1074' '#1088#1072#1079#1085#1099#1093' '#1090#1072#1082#1090#1072#1093', '#1088#1072#1079#1076#1077#1083#1103#1081#1090#1077' '#1089#1080#1084#1074#1086#1083#1086#1084 +
      ' " ; "'
    WordWrap = True
  end
  object Edit1: TEdit
    Left = 224
    Top = 8
    Width = 33
    Height = 21
    TabOrder = 0
    Text = '0'
    OnKeyPress = Edit1KeyPress
  end
  object UpDown1: TUpDown
    Left = 257
    Top = 8
    Width = 16
    Height = 21
    Associate = Edit1
    TabOrder = 1
  end
  object Edit2: TEdit
    Left = 8
    Top = 88
    Width = 265
    Height = 21
    TabOrder = 2
    OnKeyPress = Edit2KeyPress
  end
  object BitBtn1: TBitBtn
    Left = 112
    Top = 112
    Width = 75
    Height = 25
    Caption = #1054#1050
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 192
    Top = 112
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = BitBtn2Click
  end
end

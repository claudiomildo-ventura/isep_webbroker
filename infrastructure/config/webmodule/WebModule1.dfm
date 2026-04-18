object WebModule1: TWebModule1
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'DefaultAction'
      PathInfo = '/'
      OnAction = WebModuleDefaultAction
    end>
  Height = 144
  Width = 176
  object DSHTTPWebDispatcher1: TDSHTTPWebDispatcher
    Filters = <>
    WebDispatch.PathInfo = 'datasnap*'
    Left = 80
    Top = 51
  end
end

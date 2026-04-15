program isep_webbroker;
{$APPTYPE GUI}



uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Startup in 'Startup.pas' {Form1},
  ServerController in 'ServerController.pas',
  ServerContainer in 'ServerContainer.pas' {ServerContainer1: TDataModule},
  WebModule in 'WebModule.pas' {WebModule1: TWebModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

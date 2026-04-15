program isep_webbroker;
{$APPTYPE GUI}



uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Startup in 'Startup.pas' {Form1},
  ArchetypeController in 'adapters\in\datasnap\ArchetypeController.pas',
  AppInfo in 'domain\entities\AppInfo.pas',
  GetAppName in 'domain\usecases\GetAppName.pas',
  GetAppNameService in 'application\services\GetAppNameService.pas',
  WebModule in 'WebModule.pas' {WebModule1: TWebModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

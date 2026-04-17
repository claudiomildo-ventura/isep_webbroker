program isep_webbroker;
{$APPTYPE GUI}



uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Startup in 'common\Startup.pas' {Startup1: TStartup},
  ServerContainer in 'common\ServerContainer.pas' {ServerContainer1: TServerContainer1},
  AppRouter in 'adapters\in\web\Router\AppRouter.pas',
  ArchetypeController in 'adapters\in\web\Controllers\ArchetypeController.pas',
  GenerateSolutionUseCase in 'domain\usecases\GenerateSolutionUseCase.pas',
  GenerateSolutionService in 'application\services\GenerateSolutionService.pas' {$R *.res},
  WebModule1 in 'adapters\in\web\WebModule\WebModule1.pas' {WebModule1: TWebModule1},
  IArchetypeController in 'adapters\in\web\Controllers\IArchetypeController.pas';

{ Main web module for HTTP requests }

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TStartup, Startup1);
  Application.Run;
end.

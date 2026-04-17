program isep_webbroker;
{$APPTYPE GUI}



uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Startup in 'infrastructure\config\startup\Startup.pas' {Startup1: TStartup},
  ServerContainer in 'infrastructure\config\server\ServerContainer.pas' {ServerContainer1: TServerContainer1},
  AppRouter in 'infrastructure\config\router\AppRouter.pas',
  ArchetypeController in 'adapter\in\archetype\Controllers\ArchetypeController.pas',
  Archetype in 'domain\entities\Archetype.pas',
  GenerateSolutionUseCase in 'domain\service\GenerateSolutionUseCase.pas',
  GenerateSolutionService in 'application\services\GenerateSolutionService.pas' {$R *.res},
  WebModule1 in 'infrastructure\config\webmodule\WebModule1.pas' {WebModule1: TWebModule1},
  IArchetypeController in 'port\output\IArchetypeController.pas',
  IArchetypeService in 'port\input\IArchetypeService.pas',
  IGenerateSolutionUseCase in 'port\input\IGenerateSolutionUseCase.pas';

{ Main web module for HTTP requests }

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TStartup, Startup1);
  Application.Run;
end.

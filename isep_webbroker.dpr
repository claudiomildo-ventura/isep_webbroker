program isep_webbroker;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Startup in 'infrastructure\config\startup\Startup.pas' {Startup1: TStartup},
  ServerContainer in 'infrastructure\config\server\ServerContainer.pas' {ServerContainer1: TServerContainer1},
  AppRouter in 'infrastructure\config\router\AppRouter.pas',
  ArchetypeController in 'adapter\in\archetype\controller\ArchetypeController.pas',
  ArchetypeSolutionTableDto in 'adapter\in\archetype\dto\ArchetypeSolutionTableDto.pas',
  Archetype in 'domain\entities\Archetype.pas',
  ArchetypeService in 'domain\service\ArchetypeService.pas',
  WebModule1 in 'infrastructure\config\webmodule\WebModule1.pas' {WebModule1: TWebModule1},
  ArchetypeControllerPort in 'port\output\ArchetypeControllerPort.pas',
  ArchetypeServicePort in 'port\input\ArchetypeServicePort.pas',
  HttpResponse in 'infrastructure\config\httputils\HttpResponse.pas';

{ Main web module for HTTP requests }

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TStartup, Startup1);
  Application.Run;
end.

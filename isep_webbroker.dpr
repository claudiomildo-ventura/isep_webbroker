program isep_webbroker;
{$APPTYPE GUI}



uses
  Vcl.Forms, { Delphi VCL forms framework }
  Web.WebReq, { WebBroker request handler }
  IdHTTPWebBrokerBridge, { Indy HTTP bridge for WebBroker }
  Startup in 'common\Startup.pas' {Startup1: TStartup}, { Main application form }
  ServerContainer in 'common\ServerContainer.pas' {ServerContainer1: TServerContainer1},
  AppRouter in 'adapters\in\web\Router\AppRouter.pas',
  ArchetypeController in 'adapters\in\web\Controllers\ArchetypeController.pas', { Main controller for archetype logic }
  GenerateSolutionUseCase in 'domain\usecases\GenerateSolutionUseCase.pas',
  GenerateSolutionService in 'application\services\GenerateSolutionService.pas',
  WebModule1 in 'adapters\in\web\WebModule\WebModule1.pas' {WebModule1: TWebModule1}; { Main web module for HTTP requests }

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TStartup, Startup1);
  Application.Run;
end.

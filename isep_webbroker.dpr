program isep_webbroker;
{$APPTYPE GUI}



uses
  Vcl.Forms, { Delphi VCL forms framework }
  Web.WebReq, { WebBroker request handler }
  IdHTTPWebBrokerBridge, { Indy HTTP bridge for WebBroker }
  Startup in 'config\\Startup.pas' {Startup1: TStartup}, { Main application form }
  ArchetypeController in 'adapters\in\archetype\ArchetypeController.pas', { Main controller for archetype logic }
  Archetype in 'domain\entities\Archetype.pas', { Domain entity for archetype }
  IArchetypeService in 'domain\interfaces\IArchetypeService.pas', { Interface for archetype service }
  ArchetypeService in 'application\services\ArchetypeService.pas', { Implementation of archetype service }
  WebModule1 in 'config\\WebModule1.pas' {WebModule1: TWebModule1}; { Main web module for HTTP requests }

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TStartup, Startup1);
  Application.Run;
end.

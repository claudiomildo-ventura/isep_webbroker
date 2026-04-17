# ISEP | Integrated Software Engineering Platform - WebBroker

## Project Overview

This project is a Delphi WebBroker application organized with a clean-architecture-inspired structure. HTTP requests enter through the WebBroker module, are dispatched by a router, handled by controllers in the adapter layer, and delegated to application use cases and services.

The previous legacy Archetype entity/service chain has been removed from the active project structure. The current implementation is centered on the `/generate` use case.

## Architecture Flow

The current request flow is:

HTTP Request
-> WebModule
-> Router
-> Controller
-> Use Case
-> Application Service

Main example:

- `GET /generate` is handled by the WebModule.
- The WebModule delegates routing to `TAppRouter`.
- `TAppRouter` dispatches `/generate` to `TArchetypeController`.
- `TArchetypeController` delegates to `IGenerateSolutionUseCase`.
- `TGenerateSolutionService` returns the JSON response.

## Project Structure

- `isep_webbroker.dpr` / `isep_webbroker.dproj`: project entry and Delphi build configuration.
- `common/`: startup and shared infrastructure modules.
- `infrastructure/config/`: WebBroker entry module and route dispatching.
- `adapter/in/archetype/Controllers/`: inbound web controllers.
- `application/services/`: application service implementations.
- `domain/service/`: use case contracts.

Only actively used units are kept in the project tree.

## Key Units

- `infrastructure/config/startup/Startup.pas`: GUI bootstrap used to start and stop the local HTTP server.
- `infrastructure/config/server/ServerContainer.pas`: shared DataSnap server container module.
- `infrastructure/config/webmodule/WebModule1.pas`: WebBroker module that handles incoming requests.
- `infrastructure/config/router/AppRouter.pas`: router responsible for route matching and HTTP status handling.
- `adapter/in/archetype/Controllers/ArchetypeController.pas`: controller for the `/generate` endpoint.
- `domain/service/GenerateSolutionUseCase.pas`: use case interface definition.
- `application/services/GenerateSolutionService.pas`: use case implementation returning JSON.

## Endpoint

- `GET /generate`
  Returns:
  `{"message":"solution generated"}`

For unsupported methods on `/generate`, the router returns `405 Method Not Allowed`.
For unknown routes, the router returns `404` with a JSON error payload.

## Getting Started

1. Requirements:
   - Delphi XE10 or a compatible Delphi IDE
   - Windows

2. Run locally:
   - Open `isep_webbroker.dpr` in Delphi.
   - Build and run the project.
   - Use the startup form to choose a port and start the server.
   - Call `http://localhost:3003/generate` or use the configured port.

3. Development notes:
   - Keep WebModule focused on HTTP input/output concerns.
   - Put route selection in the router layer.
   - Keep controllers thin and delegate business logic to use cases and services.

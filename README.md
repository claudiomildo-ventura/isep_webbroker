# ISEP | Integrated Software Engineering Platform - WebBroker

## Project Overview

This project is a Delphi WebBroker application organized with a clean-architecture-inspired structure. HTTP requests enter through the WebBroker module, are dispatched by a router, handled by controllers in the adapter layer, and delegated to application use cases and services.

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
- `adapters/in/web/WebModule/`: WebBroker entry module.
- `adapters/in/web/Router/`: HTTP route dispatching.
- `adapters/in/web/Controllers/`: inbound web controllers.
- `application/services/`: application service implementations.
- `domain/usecases/`: use case contracts.
- `domain/interfaces/`: legacy interfaces kept during migration.
- `domain/entities/`: legacy entities kept during migration.

## Key Units

- `common/Startup.pas`: GUI bootstrap used to start and stop the local HTTP server.
- `common/ServerContainer.pas`: shared DataSnap server container module.
- `adapters/in/web/WebModule/WebModule1.pas`: WebBroker module that handles incoming requests.
- `adapters/in/web/Router/AppRouter.pas`: router responsible for route matching and HTTP status handling.
- `adapters/in/web/Controllers/ArchetypeController.pas`: controller for the `/generate` endpoint.
- `domain/usecases/GenerateSolutionUseCase.pas`: use case interface definition.
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

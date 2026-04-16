# ISEP | Integrated Software Engineering Platform - WebBroker

---

## 🧩 Project Overview

This application is a modernization of a legacy system originally developed in Object Pascal (Delphi XE10), now structured as a WebBroker-based API service. The project aims to provide a robust, maintainable, and scalable backend solution, leveraging the strengths of Delphi for web server development.

## 📁 Project Structure

- `isep_webbroker.dpr` / `.dproj`: Delphi project files.
- `ServerContainer.pas` / `.dfm`: Server container logic and design.
- `ServerController.pas`: Implementation of the main API endpoint.
- `WebModule.pas` / `.dfm`: Web module configuration and routing.
- `Startup.pas` / `.dfm`: Application startup logic.
- `isep_webbroker.stat`: File for tracking editor and compile times.

## 🚀 Getting Started

1. **Requirements**:
   - Delphi XE10 or compatible IDE
   - Windows OS

2. **Build & Run**:
   - Open the `.dpr` project in Delphi.
   - Build and run the application.
   - Access the API via the configured port. The root endpoint (`/`) returns the application name.

3. **Development**:
   - Modify `.pas` and `.dfm` files for business logic and configuration changes.

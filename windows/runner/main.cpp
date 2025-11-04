#include "my_application.h"

#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>

#include "flutter/generated_plugin_registrant.h"

int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t *command_line, _In_ int show_command) {
  // Attach to console when present (e.g., 'flutter run') or create a
  // new console when running with a debugger.
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    CreateAndAttachConsole();
  }

  // Initialize COM, so that it is available for use in the library and/or
  // plugins.
  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  flutter::DartProject project(L"data");

  std::vector<std::string> command_line_arguments =
      GetCommandLineArguments();

  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

  FlutterViewController::ViewMode view_mode = FlutterViewController::ViewMode::kNormalMode;
  MyApplication app(project);
  Win32Window::Point origin(10, 10);
  Win32Window::Size size(1024, 768);
  if (!app.CreateAndShow(L"IBlock - Bloc de Notas", origin, size, view_mode)) {
    return EXIT_FAILURE;
  }
  app.Run();

  ::CoUninitialize();
  return EXIT_SUCCESS;
}
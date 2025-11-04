#ifndef RUNNER_MY_APPLICATION_H_
#define RUNNER_MY_APPLICATION_H_

#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <memory>

#include "win32_window.h"

class MyApplication : public Win32Window {
 public:
  MyApplication();
  virtual ~MyApplication();

 protected:
  bool OnCreate() override;
  void OnDestroy() override;

 private:
  std::unique_ptr<flutter::FlutterViewController> flutter_controller_;
  flutter::DartProject dart_project_;
};

#endif  // RUNNER_MY_APPLICATION_H_
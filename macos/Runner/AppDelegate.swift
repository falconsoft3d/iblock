import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
  
  override func applicationDidFinishLaunching(_ notification: Notification) {
    super.applicationDidFinishLaunching(notification)
    
    if let window = NSApplication.shared.windows.first {
      window.title = "IBlock - Bloc de Notas"
      window.setContentSize(NSSize(width: 1024, height: 768))
      window.center()
    }
  }
}
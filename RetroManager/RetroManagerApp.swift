import SwiftUI

@main
struct RetroManagerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var playlistManager: PlaylistManager;
    
    init(){
        let configuration: Configuration = Configuration()
        Path.PLAYLIST_PATH = configuration.playlistPath()
        Path.THUMBNAIL_PATH = configuration.thumbnailPath()
        Path.SCREENSHOT_PATH = configuration.screenshotPath()
        _playlistManager = StateObject(wrappedValue: PlaylistManager())
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(playlistManager)
        }.commands{
            CommandGroup(replacing: .saveItem) {
                Button("Save Playlist") {
                    do {
                        try playlistManager.selectedPlaylist.save()
                        playlistManager.refresh()
                    } catch {
                        print("Save Failed.")
                    }
                }
                .keyboardShortcut("s", modifiers: [.command])
                .disabled(playlistManager.selectedPlaylist.items.isEmpty)
            }
        }
        Settings{
            SettingsView().frame(width: 300, height: 300)
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

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
            CommandMenu("Playlist") {
                Button("Backup Roms") {
                   // backupRoms()
                    playlistManager.selectedPlaylist.backupRoms()
                }
            }
        }
        Settings{
            SettingsView().frame(width: 300, height: 300)
        }
    }
    
    func backupRoms() {
        let panel = NSOpenPanel()
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false
        panel.prompt = "Select Folder"

        if panel.runModal() == .OK, let destinationURL = panel.url {
            let fileManager = FileManager.default
            
            // 2. 원본 ROM 경로 예시 (원하는 경로로 수정)
            let sourceFolder = URL(fileURLWithPath: "/Users/yourname/Documents/roms")
            
//            do {
//                let romFiles = try fileManager.contentsOfDirectory(at: sourceFolder, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
//                
//                for file in romFiles {
//                    let destFile = destinationURL.appendingPathComponent(file.lastPathComponent)
//                    try fileManager.copyItem(at: file, to: destFile)
//                }
//                
//                print("ROMs copied to \(destinationURL.path)")
//            } catch {
//                print("Error during backup: \(error)")
//            }
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

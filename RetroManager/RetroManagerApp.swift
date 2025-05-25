import SwiftUI

@main
struct RetroManagerApp: App {
    @StateObject var playlistManager: PlaylistManager = PlaylistManager()
    
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

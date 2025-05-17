import SwiftUI

@main
struct RetroManagerApp: App {
    @StateObject var playlistManager: PlaylistManager = PlaylistManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(playlists: $playlistManager.playlists)
        }.commands{
            CommandMenu("Task"){
                Button("Task Command"){
                    print("Task Command")
                }
            }
            CommandGroup(after: .appInfo){
                Button("Custom Command"){
                    print("Custom Command")
                }
            }
        }
        Settings{
            SettingsView().frame(width: 300, height: 300)
        }
    }
}

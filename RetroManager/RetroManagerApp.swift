import SwiftUI

@main
struct RetroManagerApp: App {
    
    @State var playlist: Playlist
    
    init(){
       playlist = Playlist(name:"MAME")!
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(playlistData: $playlist.playlistData)
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

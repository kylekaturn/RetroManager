import SwiftUI

@main
struct RetroManagerApp: App {
    
    init(){
        //Playlist
        let mamePlaylistPath = "/Volumes/Depot/RetroArch/playlists/MAME.lpl"

        if FileManager.default.fileExists(atPath: mamePlaylistPath) {
            print("Mame file exists.")
        } else {
            print("Mame file doesnt exists.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.commands{
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

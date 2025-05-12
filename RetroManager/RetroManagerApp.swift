import SwiftUI

@main
struct RetroManagerApp: App {
    
    init(){
        let playlist: Playlist = Playlist(name:"MAME")!
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

import SwiftUI
import Foundation

struct GameView: View {
    @EnvironmentObject var playlistManager: PlaylistManager;
    @State var isExpanded = false
    let google : String = "http://www.google.com/search?tbm=isch&q="
    let launchbox : String = "https://gamesdb.launchbox-app.com/games/results/"
    
    var body: some View {
        VStack(alignment:.leading, spacing: 5){
            Text(playlistManager.selectedGame.label)
            Text(playlistManager.selectedGame.core_name)
            Text(playlistManager.selectedGame.path)
            
            Spacer().frame(height:10)
            
            HStack{
                ThumbnailItem(thumbnailType:.boxart , thumbnailLabel: playlistManager.selectedGame.label)
                ThumbnailItem(thumbnailType:.title , thumbnailLabel: playlistManager.selectedGame.label)
                ThumbnailItem(thumbnailType:.snap , thumbnailLabel: playlistManager.selectedGame.label)
            }
            
            Spacer().frame(height:10)
            
            Text("JSON").font(.headline)
            Text(playlistManager.selectedGame.toJson())
            
            Spacer()
            
            HStack{
                Button("Search Label"){
                    if let query = playlistManager.selectedGame.label.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                       let url = URL(string: "\(google)\(query)") {
                        NSWorkspace.shared.open(url)
                    }
                }
                Button("Serach File"){
                    if let label = URL(string: playlistManager.selectedGame.path)?.deletingPathExtension().lastPathComponent,
                       let query = label.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                       let url = URL(string: "\(google)\(query)") {
                        NSWorkspace.shared.open(url)
                    }
                }
                Button("Serach LaunchBox"){
                    if let query = playlistManager.selectedGame.label.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                       let url = URL(string: "\(launchbox)\(query)") {
                        NSWorkspace.shared.open(url)
                    }
                }
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(15)
    }
}

#Preview {
    GameView().environmentObject(PlaylistManager())
}

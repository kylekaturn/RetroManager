import SwiftUI
import Foundation

struct GameView: View {
    @EnvironmentObject var playlistManager: PlaylistManager;
    @State var isExpanded = false
    let google : String = "http://www.google.com/search?tbm=isch&q="
    
    var body: some View {
        VStack(alignment:.leading, spacing: 5){
            Text(playlistManager.selectedGame.label)
            Text(playlistManager.selectedGame.core_name)
            Text(playlistManager.selectedGame.path)
            
            Spacer().frame(height:10)
            
            HStack{
                ThumbnailItem(thumbnailType:.boxart , thumbnailPath: playlistManager.selectedGame.label)
                ThumbnailItem(thumbnailType:.snap , thumbnailPath: playlistManager.selectedGame.label)
                ThumbnailItem(thumbnailType:.title , thumbnailPath: playlistManager.selectedGame.label)
            }
            
            Spacer().frame(height:10)
            
            VStack(alignment: .leading) {
                Text(playlistManager.selectedGame.toJson())
                    .padding(.top, 5)
                
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .frame(width:1000)
            
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
                
                Spacer()
                
                Button("Bottom"){
                    
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(15)
    }
}

#Preview {
    GameView().environmentObject(PlaylistManager())
}

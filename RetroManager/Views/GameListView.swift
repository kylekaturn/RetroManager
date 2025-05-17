import SwiftUI

struct GameListView: View {
    
    @ObservedObject var playlistManager: PlaylistManager
    @Binding var selectedPlaylist: Playlist?
    @Binding var selectedPlaylistItem: PlaylistItem?
    @State var searchText: String = ""
   
    var body: some View {
        HStack{
            List(selection: $selectedPlaylist){
                ForEach(playlistManager.playlists, id : \.self){ item in
                    Text("\(item.default_core_name)")
                }
            }
            .listStyle(.sidebar)
            .frame(width:100)
            
            List(selection: $selectedPlaylistItem){
                ForEach(playlistManager.playlists[0].items, id : \.self) {item in
                    Text("\(item.label)")
                }
            }
            .listStyle(.sidebar)
            .frame(minWidth:300)
            .searchable(text: $searchText, placement:.sidebar, prompt: "Search")
        }
    }
}

#Preview {
    GameListView(
        playlistManager: PlaylistManager(loadFiles: false),
        selectedPlaylist: .constant(nil),
        selectedPlaylistItem:.constant(nil)
    )
}

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var playlistManager: PlaylistManager;
    @State var selectedPlaylist: Playlist? = nil
    @State var selectedPlaylistItem: PlaylistItem? = nil
    
    var body: some View {
        NavigationSplitView{
            GameListView(
                playlistManager: playlistManager,
                selectedPlaylist: $selectedPlaylist,
                selectedPlaylistItem: $selectedPlaylistItem
            )
        }detail:{
            GameView(playlistItem: $selectedPlaylistItem)
                .navigationTitle("Game")
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button(action: {
                            print("Setting Clicked")
                        }) {
                            Image(systemName: "gearshape")
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView(playlistManager: PlaylistManager(loadFiles: false))
}

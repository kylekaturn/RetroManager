import SwiftUI

struct ContentView: View {
    
    @Binding var playlists: [Playlist]
    @State var selectedItem: PlaylistItem? = nil
    
    var body: some View {
        NavigationSplitView{
            GameListView(playlists: $playlists, selectedItem:$selectedItem)
        }detail:{
            GameView(playlistItem: $selectedItem)
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
    ContentView(playlists: .constant([Playlist(), Playlist()]))
}

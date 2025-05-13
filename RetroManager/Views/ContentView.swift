import SwiftUI

struct ContentView: View {
    
    @Binding var playlistData: PlaylistData
    @State var searchText: String = ""
    
    var body: some View {
        NavigationSplitView{
            GameListView(playlistData: $playlistData)
        }detail:{
            GameView(playlistItem: .constant(PlaylistItem()))
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
    ContentView(playlistData: .constant(PlaylistData()))
}

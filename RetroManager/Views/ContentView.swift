import SwiftUI

struct ContentView: View {
    
    @Binding var playlistData: PlaylistData
    @State var selectedItem: PlaylistItem? = nil
    
    var body: some View {
        NavigationSplitView{
            GameListView(playlistData: $playlistData, selectedItem:$selectedItem)
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
    ContentView(playlistData: .constant(PlaylistData()))
}

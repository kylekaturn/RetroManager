import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var playlistManager: PlaylistManager;
    
    var body: some View {
        NavigationSplitView{
            GameListView()
        }detail:{
            GameView()
                .navigationTitle(playlistManager.selectedPlaylistItem.label)
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
    ContentView().environmentObject(PlaylistManager())
}

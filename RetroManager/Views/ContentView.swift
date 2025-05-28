import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var playlistManager: PlaylistManager;
    
    var body: some View {
        NavigationSplitView{
            GameListView()
        }detail:{
            GameView()
                .navigationTitle(playlistManager.selectedGame.label)
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button(action: {
                            Utils.launchRetroArch(
                                romPath: playlistManager.selectedGame.path,
                                corePath: playlistManager.selectedPlaylist.default_core_path)
                        }) {
                            Image(systemName: "play.fill")
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView().environmentObject(PlaylistManager())
}

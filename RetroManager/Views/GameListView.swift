import SwiftUI

struct GameListView: View {
    
    @EnvironmentObject var playlistManager: PlaylistManager;
    @State var selectedPlaylist: Playlist? = nil
    @State var selectedPlaylistItem: PlaylistItem? = nil
    @State var searchText: String = ""
   
    var body: some View {
        HStack{
            List(selection: $selectedPlaylist){
                ForEach(playlistManager.playlists, id : \.self){ item in
                    Text("\(item.file)")
                }
            }
            .listStyle(.sidebar)
            .frame(width:150)
            .onAppear(){
                selectedPlaylist = playlistManager.selectedPlaylist
            }
            .onChange(of: selectedPlaylist){
                print("OnChange")
                playlistManager.selectedPlaylist = selectedPlaylist!
            }
            
            List(selection: $selectedPlaylistItem){
                ForEach(playlistManager.selectedPlaylist.items, id : \.self) {item in
                    Text("\(item.label)")
                }
            }
            .listStyle(.sidebar)
            .frame(minWidth:300)
            .searchable(text: $searchText, placement:.sidebar, prompt: "Search")
            .onAppear(){
                selectedPlaylistItem = playlistManager.selectedPlaylistItem
            }
            .onChange(of: selectedPlaylistItem){
                print("OnChange")
                playlistManager.selectedPlaylistItem = selectedPlaylistItem!
            }
        }
    }
}

#Preview {
    GameListView().environmentObject(PlaylistManager())
}

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
                playlistManager.selectedPlaylist = selectedPlaylist!
            }
            
            VStack{
                List(selection: $selectedPlaylistItem){
                    ForEach(playlistManager.selectedPlaylist.items, id : \.self) {item in
                        Text("\(item.label)")
                            .contextMenu{
                                Button("Copy Item"){
                                    //let pasteboard = NSPasteboard.general
                                    //pasteboard.clearContents()
                                   // pasteboard.setString(item.id, forType: .string)
                                    print(item.id)
                                }
                            }
                    }
                }
                .listStyle(.sidebar)
                .frame(minWidth:300)
                .searchable(text: $searchText, placement:.sidebar, prompt: "Search")
                .onAppear(){
                    selectedPlaylistItem = playlistManager.selectedPlaylistItem
                }
                .onChange(of: selectedPlaylistItem){
                    playlistManager.selectedPlaylistItem = selectedPlaylistItem!
                }
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        print("Document icon clicked")
                    }) {
                        Image(systemName: "arrow.right.page.on.clipboard")
                            .imageScale(.large)
                    }
                    .buttonStyle(.automatic) // 필요 시 스타일 조절
                    .help("복사")
                    .padding(5)
                }
                
            }
        }
    }
}

#Preview {
    GameListView().environmentObject(PlaylistManager())
}

import SwiftUI

struct GameListView: View {
    
    @EnvironmentObject var playlistManager: PlaylistManager;
    @State var selectedPlaylist: Playlist? = nil
    @State var selectedGame: Game? = nil
    @State var searchText: String = ""
    var filteredGames: [Game] {
        if searchText.isEmpty {
            return playlistManager.selectedPlaylist.items
        } else {
            return playlistManager.selectedPlaylist.items.filter { $0.label.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        HStack{
            List(selection: $selectedPlaylist){
                ForEach(playlistManager.playlists, id : \.self){ item in
                    Text("\(item.label)")
                }
            }
            .listStyle(.sidebar)
            .frame(width:150)
            .onAppear(){
                selectedPlaylist = playlistManager.selectedPlaylist
                Path.SYSTEM_PATH = selectedPlaylist!.label
            }
            .onChange(of: selectedPlaylist){
                playlistManager.selectedPlaylist = selectedPlaylist!
                Path.SYSTEM_PATH = selectedPlaylist!.label
            }
            
            VStack{
                List{
                }
                .listStyle(.sidebar)
                .frame(height:30)
                .searchable(text: $searchText, placement:.sidebar, prompt: "Search")
                
                List(selection: $selectedGame){
                    ForEach(filteredGames, id : \.self) {game in
                        GameItem(game:game)
                    }
                }
                .listStyle(.sidebar)
                .frame(minWidth:300)
                .onAppear(){
                    selectedGame = playlistManager.selectedGame
                }
                .onChange(of: selectedGame){
                    playlistManager.selectedGame = selectedGame!
                }
                .onKeyPress(action: { keyPress in
                    if(keyPress.key.character == "\u{7F}"){
                        let index = playlistManager.selectedPlaylist.items.firstIndex(of : playlistManager.selectedGame)
                        playlistManager.selectedPlaylist.deleteGame(playlistManager.selectedGame)
                        selectedGame = playlistManager.selectedPlaylist.items[index!]
                        return .handled
                    }
                    if(keyPress.key.character == "\r"){
                        print("return")
                        return .handled
                    }
                    return .ignored
                })
                
                Spacer()
                HStack{
                    Spacer()
                    
                    Button(action: {
                        do{
                            try playlistManager.selectedPlaylist.save()
                        }catch{
                            print("Save Failed.")
                        }
                    }) {
                        Image(systemName: "square.and.arrow.down")
                            .imageScale(.large)
                    }
                    .buttonStyle(.automatic)
                    .padding(5)
                    
                    Button(action: {
                        print("Paste")
                    }) {
                        Image(systemName: "arrow.right.page.on.clipboard")
                            .imageScale(.large)
                    }
                    .buttonStyle(.automatic)
                    .padding(5)
                    
                }
            }
        }
    }
}

//Preview
#Preview {
    GameListView().environmentObject(PlaylistManager())
}

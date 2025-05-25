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
                    Text("\(item.isDirty ? "*" : "")\(item.label)")
                }
            }
            .listStyle(.sidebar)
            .frame(width:150)
            .id(playlistManager.refreshID)
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
                        GameItem(game:game, onCopy:copyGame, onPaste: pasteGame, onDelete:deleteGame)
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
                        deleteGame(playlistManager.selectedGame)
                        return .handled
                    }
                    if(keyPress.key.character == "\r"){
                        print("return")
                        return .handled
                    }
                    return .ignored
                })
            }
            .contextMenu{
                Button("Paste Game") {
                    //onCopy(game)
                }
            }
        }
    }
    
    //선택된 게임 복제
    private func copyGame(_ game: Game){
        let jsonString = game.toJson()
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(jsonString, forType: .string)
        print(jsonString)
    }
    
    //게임 붙여넣기
    private func pasteGame(_ game: Game){
        let jsonString = NSPasteboard.general.string(forType: .string)
        playlistManager.selectedPlaylist.addGame(jsonString!)
        playlistManager.refresh()
    }
    
    //선택된 게임 삭제
    private func deleteGame(_ game: Game){
        let index = playlistManager.selectedPlaylist.items.firstIndex(of : playlistManager.selectedGame)
        playlistManager.selectedPlaylist.deleteGame(playlistManager.selectedGame)
        selectedGame = playlistManager.selectedPlaylist.items[index!]
        playlistManager.refresh()
    }
}

//Preview
#Preview {
    GameListView().environmentObject(PlaylistManager())
}

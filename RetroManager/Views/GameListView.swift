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
                        GameItem(game:game, onDelete:deleteGame)
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
        }
    }
    
    //선택된 게임 삭제
    private func deleteGame(_ game: Game){
        let index = playlistManager.selectedPlaylist.items.firstIndex(of : playlistManager.selectedGame)
        playlistManager.selectedPlaylist.deleteGame(playlistManager.selectedGame)
        selectedGame = playlistManager.selectedPlaylist.items[index!]
        playlistManager.refresh()
    }
    
    //선택된 게임 복제
    private func copyGame(_ game: Game){
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes]
        if let data = try? encoder.encode(game),
           let jsonString = String(data: data, encoding: .utf8) {
            let pasteboard = NSPasteboard.general
            pasteboard.clearContents()
            pasteboard.setString(jsonString, forType: .string)
            print(jsonString)
        }
    }
    
    //게임 붙여넣기
    private func pasteGame(){
        let pasteboard = NSPasteboard.general
        if let jsonString = pasteboard.string(forType: .string) {
            let decoder = JSONDecoder()
            if let jsonData = jsonString.data(using: .utf8),
               let game = try? decoder.decode(Game.self, from: jsonData) {
                playlistManager.selectedPlaylist.addGame(game)
                
            } else {
                print("PasteGame Failed.")
            }
        } else {
            print("PasteGame Failed.")
        }
        print("PasteGame Succeed.")
    }
}

//Preview
#Preview {
    GameListView().environmentObject(PlaylistManager())
}

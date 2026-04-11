import SwiftUI

struct GameListView: View {

    @EnvironmentObject var playlistManager: PlaylistManager
    @State var selectedPlaylist: Playlist? = nil
    @State var selectedGame: Game? = nil
    @State var searchText: String = ""
    @State private var showRenamePopup = false
    @State private var showEditPopup = false
    @State private var renameLabel = ""
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
                    PlaylistItem(
                        playlist: item,
                        onAdd: addGame)
                }
            }
            .listStyle(.sidebar)
            .frame(width:200)
            .onAppear(){
                selectedPlaylist = playlistManager.selectedPlaylist
            }
            .onChange(of: selectedPlaylist){
                guard let playlist = selectedPlaylist else { return }
                playlistManager.selectPlaylist(playlist)
                if let firstGame = playlistManager.selectedPlaylist.items.first {
                    selectedGame = firstGame
                }
            }

            VStack{
                List(selection: $selectedGame){
                    ForEach(filteredGames, id : \.self) {game in
                        GameItem(
                            game:game,
                            onCopy:copyGame,
                            onPaste: pasteGame,
                            onRename: renameGame,
                            onEdit: editGame,
                            onDelete: deleteGame)
                    }
                }
                .searchable(text: $searchText, placement:.sidebar, prompt: "Search")
                .listStyle(.sidebar)
                .frame(minWidth:300)
                .onAppear(){
                    selectedGame = playlistManager.selectedGame
                }
                .onChange(of: selectedGame){
                    guard let game = selectedGame else { return }
                    playlistManager.selectGame(game)
                }
                .onKeyPress(action: { keyPress in
                    if keyPress.key.character == "\u{7F}", let game = selectedGame {
                        deleteGame(game)
                    }
                    return .ignored
                })
                .sheet(isPresented: $showRenamePopup) {
                    RenamePopup(onClose: {showRenamePopup = false})
                }
                .sheet(isPresented: $showEditPopup){
                    EditPopup(onClose: {showEditPopup = false})
                }
                Spacer()
                Text("\(playlistManager.selectedPlaylist.items.count) Games").padding(.bottom , 10)
            }
        }
    }

    //게임 추가시
    private func addGame(_ game: Game){
        selectedGame = game
    }

    //선택된 게임 복제
    private func copyGame(_ game: Game){
        let jsonString = game.toJson()
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(jsonString, forType: .string)
    }

    //게임 붙여넣기
    private func pasteGame(_ game: Game){
        guard let jsonString = NSPasteboard.general.string(forType: .string) else { return }
        playlistManager.selectedPlaylist.addGame(jsonString)
    }

    //선택된 게임 삭제
    private func deleteGame(_ game: Game){
        guard let index = playlistManager.selectedPlaylist.items.firstIndex(of: game) else {
            return
        }
        playlistManager.selectedPlaylist.deleteGame(game)
        let items = playlistManager.selectedPlaylist.items
        if items.isEmpty {
            selectedGame = nil
        } else if index >= items.count {
            selectedGame = items[items.count - 1]
        } else {
            selectedGame = items[index]
        }
    }

    //게임 이름 변경
    private func renameGame(_ game: Game){
        selectedGame = game
        renameLabel = game.label
        showRenamePopup = true
    }

    private func editGame(_ game: Game){
        selectedGame = game
        showEditPopup = true
    }
}

//Preview
#Preview {
    GameListView().environmentObject(PlaylistManager())
}

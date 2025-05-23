import SwiftUI

struct GameListView: View {
    
    @EnvironmentObject var playlistManager: PlaylistManager;
    @State var selectedPlaylist: Playlist? = nil
    @State var selectedGame: Game? = nil
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
                
                List(selection: $selectedGame){
                    ForEach(playlistManager.selectedPlaylist.items, id : \.self) {game in
                        GameItem(game:game)
                    }
                }
                .listStyle(.sidebar)
                .frame(minWidth:300)
                .searchable(text: $searchText, placement:.sidebar, prompt: "Search")
                .onAppear(){
                    selectedGame = playlistManager.selectedGame
                }
                .onChange(of: selectedGame){
                    playlistManager.selectedGame = selectedGame!
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
                    .buttonStyle(.automatic)
                    .padding(5)
                }
            }
        }
    }
}

//CopyItem context menu
@ViewBuilder
private func copyContextMenu(for game: Game) -> some View {
    Button("Copy Item") {
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
}

//Preview
#Preview {
    GameListView().environmentObject(PlaylistManager())
}

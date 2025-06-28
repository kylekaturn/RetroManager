import SwiftUI
import AppKit

struct GameItem: View {
    @EnvironmentObject var playlistManager: PlaylistManager;
    var game: Game
    var onCopy: (Game) -> Void = {_ in}
    var onPaste: (Game) -> Void = {_ in}
    var onRename: (Game) -> Void = {_ in}
    var onEdit: (Game) -> Void = {_ in}
    var onDelete: (Game) -> Void = {_ in}
    
    var body: some View {
        Text("\(game.label)")
            .contextMenu{
                Button("Show in Finder") {
                    Utils.openFinder(atPath: game.path)
                }
                Divider()
                Button("Open"){
                    Utils.launchRetroArch(romPath: game.path, corePath: game.core_path)
                }
                Divider()
                Button("Copy") {
                    onCopy(game)
                }
                Button("Paste"){
                    onPaste(game)
                }
                Button("Duplicate"){
                    playlistManager.selectedPlaylist.addGame(game.clone())
                    playlistManager.refresh()
                }
                Divider()
                Button("Rename"){
                    onRename(game)
                }
                Button("Edit"){
                    onEdit(game)
                }
                Divider()
                Button("Delete"){
                    onDelete(game)
                }
            }
    }
}

#Preview {
    GameItem(game: Game())
}

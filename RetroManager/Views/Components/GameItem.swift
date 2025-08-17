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
                Button("Copy to Mame"){
                    playlistManager.playlists.first(where: {$0.label == "MAME"})?.addGame(game.clone())
                    playlistManager.refresh()
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
                Button("Relocate"){
                    let panel = NSOpenPanel()
                    panel.canChooseFiles = true
                    panel.canChooseDirectories = false
                    panel.allowsMultipleSelection = false
                    panel.prompt = "Select File"

                    if panel.runModal() == .OK, let destinationURL = panel.url {
                       print(destinationURL)
                        game.path = destinationURL.path
                        playlistManager.selectedPlaylist.isDirty = true
                        playlistManager.refresh()
                    }
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

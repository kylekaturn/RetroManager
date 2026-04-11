import SwiftUI
import UniformTypeIdentifiers
import AppKit

struct GameItem: View {
    @EnvironmentObject var playlistManager: PlaylistManager
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
                    if let mameID = playlistManager.playlists.first(where: { $0.label == "MAME" })?.id {
                        playlistManager.modifyPlaylist(withID: mameID) { $0.addGame(game.clone()) }
                    }
                }
                Button("Paste"){
                    onPaste(game)
                }
                Button("Duplicate"){
                    playlistManager.selectedPlaylist.addGame(game.clone())
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
                    panel.allowedContentTypes = [
                        UTType(filenameExtension: "bat")!,
                        UTType(filenameExtension: "exe")!,
                        UTType(filenameExtension: "com")!
                    ]
                    panel.prompt = "Select File"

                    if panel.runModal() == .OK, let destinationURL = panel.url {
                        if let index = playlistManager.selectedPlaylist.items.firstIndex(where: { $0.id == game.id }) {
                            playlistManager.selectedPlaylist.items[index].path = destinationURL.path
                            playlistManager.selectedPlaylist.isDirty = true
                        }
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

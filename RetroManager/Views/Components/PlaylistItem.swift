import SwiftUI
import UniformTypeIdentifiers
import AppKit

struct PlaylistItem: View {
    @EnvironmentObject var playlistManager: PlaylistManager
    var playlist: Playlist
    var onAdd: (Game) -> Void = {_ in}

    var body: some View {
        Text("\(playlist.isDirty ? "*" : "")\(playlist.label)")
            .contextMenu{
                Button("Show in Finder") {
                    Utils.openFinder(atPath: playlist.file)
                }
                Divider()
                Button("Add Game"){
                    let panel = NSOpenPanel()
                    panel.canChooseFiles = true
                    panel.canChooseDirectories = false
                    panel.allowsMultipleSelection = false
                    panel.prompt = "Select File"
                    panel.allowedContentTypes = [
                        UTType(filenameExtension: "bat")!,
                        UTType(filenameExtension: "exe")!,
                        UTType(filenameExtension: "com")!
                    ]

                    if panel.runModal() == .OK, let destinationURL = panel.url {
                        guard var game = playlist.items.first?.clone() else { return }
                        game.path = destinationURL.path
                        game.label = destinationURL.deletingLastPathComponent().lastPathComponent
                        playlistManager.modifyPlaylist(withID: playlist.id) { $0.addGame(game) }
                        onAdd(game)
                    }
                }
                Divider()
                Button("Paste"){
                    guard let jsonString = NSPasteboard.general.string(forType: .string) else { return }
                    playlistManager.modifyPlaylist(withID: playlist.id) { $0.addGame(jsonString) }
                }
                Divider()
                Button("Backup Roms"){
                    playlistManager.selectedPlaylist.backupRoms()
                }
            }
    }
}

#Preview {
    PlaylistItem(playlist: Playlist())
}

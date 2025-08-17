
import SwiftUI
import AppKit

struct PlaylistItem: View {
    @EnvironmentObject var playlistManager: PlaylistManager;
    var playlist: Playlist
    var onPaste: (Game) -> Void = {_ in}
    
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

                    if panel.runModal() == .OK, let destinationURL = panel.url {
                       print(destinationURL)
                        let game = playlist.items.first?.clone()
                        game?.path = destinationURL.path
                        game?.label = destinationURL.lastPathComponent
                        playlist.addGame(game!)
                        playlistManager.refresh()
                    }
                }
                Divider()
                Button("Paste"){
                    let jsonString = NSPasteboard.general.string(forType: .string)
                    playlist.addGame(jsonString!)
                    playlistManager.refresh()
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

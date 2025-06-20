
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

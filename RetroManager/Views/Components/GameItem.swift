import SwiftUI
import AppKit

struct GameItem: View {
    var game: Game
    var onCopy: (Game) -> Void = {_ in}
    var onPaste: (Game) -> Void = {_ in}
    var onRename: (Game) -> Void = {_ in}
    var onDelete: (Game) -> Void = {_ in}
    
    var body: some View {
        Text("\(game.label)")
            .contextMenu{
                Button("Show in Finder") {
                    let url = URL(fileURLWithPath: game.path)
                    NSWorkspace.shared.activateFileViewerSelecting([url])
                }
                Divider()
                Button("Open"){
                    
                }
                Divider()
                Button("Copy") {
                    onCopy(game)
                }
                Button("Paste"){
                    onPaste(game)
                }
                Divider()
                Button("Rename"){
                    onRename(game)
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

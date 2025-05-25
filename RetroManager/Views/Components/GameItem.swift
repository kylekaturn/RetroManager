import SwiftUI

struct GameItem: View {
    
    var game: Game
    var onCopy: (Game) -> Void = {_ in}
    var onPaste: (Game) -> Void = {_ in}
    var onDelete: (Game) -> Void = {_ in}
    
    var body: some View {
        Text("\(game.label)")
            .contextMenu{
                
                Button("Copy Game") {
                    onCopy(game)
                }
                
                Button("Paste Game"){
                    onPaste(game)
                }
                
                Button("Delete Game"){
                    onDelete(game)
                }
            }
    }
}

#Preview {
    GameItem(game: Game())
}

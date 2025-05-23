import SwiftUI

struct GameItem: View {
    
    var game: Game
    
    var body: some View {
        Text("\(game.label)")
            .contextMenu{
                //copyContextMenu(for: game)
            }
    }
}

#Preview {
    GameItem(game: Game())
}

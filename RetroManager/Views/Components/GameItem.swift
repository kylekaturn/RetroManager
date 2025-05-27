import SwiftUI

struct GameItem: View {
    var game: Game
    var isRenaming: Bool = false
    var onCopy: (Game) -> Void = {_ in}
    var onPaste: (Game) -> Void = {_ in}
    var onRename: (Game) -> Void = {_ in}
    var onRenameSubmit: (Game) -> Void = {_ in}
    var onRenameExit: (Game) -> Void = {_ in}
    var onDelete: (Game) -> Void = {_ in}
    
    @State var gameLabel: String = "Game Label"
    @FocusState private var isFocused: Bool
    
    var body: some View {
        if(isRenaming){
            TextField("Game Label", text: $gameLabel)
                .onAppear{
                    gameLabel = game.label
                    isFocused = true
                }
                .focused($isFocused)
                .onSubmit {
                    game.label = gameLabel
                    onRenameSubmit(game)
                    isFocused = false
                }
                .onExitCommand{
                    onRenameExit(game)
                    isFocused = false
                }
        }else{
            Text("\(game.label)")
                .contextMenu{
                    
                    Button("Copy Game") {
                        onCopy(game)
                    }
                    
                    Button("Paste Game"){
                        onPaste(game)
                    }
                    
                    Button("Rename Game"){
                        onRename(game)
                    }
                    
                    Button("Delete Game"){
                        onDelete(game)
                    }
                }
        }
    }
}

#Preview {
    GameItem(game: Game())
}

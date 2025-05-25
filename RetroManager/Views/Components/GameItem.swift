import SwiftUI

struct GameItem: View {
    
    var game: Game
    var onDelete: (Game) -> Void = {_ in}
    
    var body: some View {
        Text("\(game.label)")
            .contextMenu{
                
                Button("Copy Game") {
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes]
                    if let data = try? encoder.encode(game),
                       let jsonString = String(data: data, encoding: .utf8) {
                        let pasteboard = NSPasteboard.general
                        pasteboard.clearContents()
                        pasteboard.setString(jsonString, forType: .string)
                        print(jsonString)
                    }
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

import SwiftUI

struct GameItem: View {
    
    var game: Game
    
    var body: some View {
        Text("\(game.label)")
            .contextMenu{
                copyContextMenu(for: game)
            }
            .onKeyPress(.return) {
                print("Return key pressed!")
                return .handled
            }
    }
}

@ViewBuilder
private func copyContextMenu(for game: Game) -> some View {
    Button("Copy Item") {
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
}

#Preview {
    GameItem(game: Game())
}

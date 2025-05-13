import SwiftUI

struct GameView: View {
    
    @Binding var playlistItem: PlaylistItem
    
    var body: some View {
        VStack(alignment: .leading){
            Text(playlistItem.label)
            Text(playlistItem.core_name)
            Text(playlistItem.core_path)
        }
    }
}

#Preview {
    GameView(playlistItem: .constant(PlaylistItem())).frame(width:300, height:300)
}

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var playlistManager: PlaylistManager;
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true){
            VStack(alignment: .leading){
                Text("Label : \(playlistManager.selectedPlaylistItem.label)")
                Text("Core : \(playlistManager.selectedPlaylistItem.core_name)")
                Text("Path : \(playlistManager.selectedPlaylistItem.path)")
                
                Thumbnail(thumbnailType:.boxart , thumbnailPath: playlistManager.selectedPlaylistItem.label)
                Thumbnail(thumbnailType:.snap , thumbnailPath: playlistManager.selectedPlaylistItem.label)
                Thumbnail(thumbnailType:.title , thumbnailPath: playlistManager.selectedPlaylistItem.label)
            }
        }
        .background(Color.gray.opacity(0.05))
        .cornerRadius(10)
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    GameView().environmentObject(PlaylistManager())
}

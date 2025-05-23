import SwiftUI

struct GameView: View {
    @EnvironmentObject var playlistManager: PlaylistManager;
    
    var body: some View {
        VStack(alignment:.leading, spacing: 5){
            Text(playlistManager.selectedPlaylistItem.label)
            Text(playlistManager.selectedPlaylistItem.core_name)
            Text(playlistManager.selectedPlaylistItem.path)
            
            Spacer().frame(height:10)
            
            HStack{
                Thumbnail(thumbnailType:.boxart , thumbnailPath: playlistManager.selectedPlaylistItem.label)
                Thumbnail(thumbnailType:.snap , thumbnailPath: playlistManager.selectedPlaylistItem.label)
                Thumbnail(thumbnailType:.title , thumbnailPath: playlistManager.selectedPlaylistItem.label)
            }
            Spacer()
            HStack{
                Spacer()
                Button("Bottom"){
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(15)
    }
}

#Preview {
    GameView().environmentObject(PlaylistManager())
}

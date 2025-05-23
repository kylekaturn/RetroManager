import SwiftUI

struct GameView: View {
    @EnvironmentObject var playlistManager: PlaylistManager;
    
    var body: some View {
        VStack(alignment:.leading, spacing: 5){
            Text(playlistManager.selectedGame.label)
            Text(playlistManager.selectedGame.core_name)
            Text(playlistManager.selectedGame.path)
            
            Spacer().frame(height:10)
            
            HStack{
                ThumbnailItem(thumbnailType:.boxart , thumbnailPath: playlistManager.selectedGame.label)
                ThumbnailItem(thumbnailType:.snap , thumbnailPath: playlistManager.selectedGame.label)
                ThumbnailItem(thumbnailType:.title , thumbnailPath: playlistManager.selectedGame.label)
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

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var playlistManager: PlaylistManager;
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true){
            VStack(alignment: .leading){
                Text("DashBoard")
                    .font(.title)
                    .fontWeight(.bold)
                
                HStack{
                    Text("HStack")
                    Spacer()
                }
                Text("Label : \(playlistManager.selectedPlaylistItem.label)")
                Text("Core : \(playlistManager.selectedPlaylistItem.core_name)")
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

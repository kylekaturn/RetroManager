import SwiftUI

struct GameView: View {
    
    @Binding var playlistItem: PlaylistItem?
    
    var body: some View {
        if let item = playlistItem{
            ScrollView(.vertical, showsIndicators: true){
                VStack(alignment: .leading){
                    Text("DashBoard")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack{
                        Text("HStack")
                        Spacer()
                    }
                    Text("Label : \(item.label)")
                    Text("Core : \(item.core_name)")
                }
            }
            .background(Color.gray.opacity(0.05))
            .cornerRadius(10)
            .padding(10)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    GameView(playlistItem: .constant(PlaylistItem()))
}

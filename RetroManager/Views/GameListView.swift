import SwiftUI

struct GameListView: View {
    
    @Binding var playlistData: PlaylistData
    @State var searchText: String = ""
    
    var body: some View {
        HStack{
            List{
                ForEach(0...30, id: \.self){ i in
                    Text("List \(i)")
                }
            }
            .listStyle(.sidebar)
            
            List{
                ForEach(0...30, id: \.self){ i in
                    Text("List \(i)")
                }
            }
            .listStyle(.sidebar)
            .searchable(text: $searchText, placement:.sidebar, prompt: "Search")
        }
    }
}

#Preview {
    GameListView(playlistData:.constant(PlaylistData()))
}

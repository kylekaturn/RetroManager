import SwiftUI

struct GameListView: View {
    
    @Binding var playlists: [Playlist]
    @Binding var selectedItem: PlaylistItem?
    @State var searchText: String = ""
   
    var body: some View {
        HStack{
            List{
                ForEach(0...30, id: \.self){ i in
                    Text("List \(i)")
                }
            }
            .listStyle(.sidebar)
            .frame(width:100)
            
            List(selection: $selectedItem){
                ForEach(playlists[0].playlistData.items, id : \.self) {item in
                    Text("\(item.label)")
                }
            }
            .listStyle(.sidebar)
            .frame(minWidth:300)
            .searchable(text: $searchText, placement:.sidebar, prompt: "Search")
            .onAppear{
                if(selectedItem == nil) {
                    selectedItem = playlists[0].playlistData.items.first
                }
            }
        }
    }
}

#Preview {
    GameListView(playlists:.constant([Playlist(), Playlist()]), selectedItem:.constant(nil))
}

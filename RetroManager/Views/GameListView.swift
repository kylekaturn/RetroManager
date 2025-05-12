import SwiftUI

struct GameListView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        List{
            ForEach(0...30, id: \.self){ i in
                Text("List1")
            }
        }.listStyle(.sidebar)
    }
}

#Preview {
    GameListView(searchText: .constant(""))
}

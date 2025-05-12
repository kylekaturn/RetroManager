import SwiftUI

struct ContentView: View {
    
    @State var searchText: String = ""
    
    var body: some View {
        NavigationSplitView {
            GameListView(searchText: $searchText)
        } detail: {
            GameView()
                .navigationTitle("Game")
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button(action: {
                            print("Setting Clicked")
                        }) {
                            Image(systemName: "gearshape")
                        }
                    }
                }
        }
        .searchable(text: $searchText, placement: .sidebar)
    }
}

#Preview {
    ContentView()
}


import SwiftUI

struct EditPopup: View {
    @EnvironmentObject var playlistManager: PlaylistManager;
    @State private var label:String = ""
    @State private var path:String = ""
    
    var onClose: () -> Void
    
    var body: some View {
        
        VStack{
            Text("Edit Game")
                .font(.headline)
            Grid(alignment: .leadingFirstTextBaseline, verticalSpacing: 10) {
                GridRow{
                    Text("Label")
                    TextField("Label", text: $label)
                }
                GridRow{
                    Text("Path")
                    TextField("Path", text: $path)
                }
            }
            HStack {
                Button("Cancel") { onClose() }
                Button("OK") {
                    if(playlistManager.selectedGame.label != label){
                        playlistManager.selectedGame.rename(label)
                        playlistManager.selectedPlaylist.sort()
                        playlistManager.selectedPlaylist.isDirty = true
                        playlistManager.refresh()
                    }
                    if(playlistManager.selectedGame.path != path){
                        playlistManager.selectedGame.path = path
                        playlistManager.selectedPlaylist.isDirty = true
                    }
                    onClose()
                }
                .keyboardShortcut(.defaultAction)
            }
        }
        .padding()
        .frame(width: 450)
        .onAppear(){
            label = playlistManager.selectedGame.label
            path = playlistManager.selectedGame.path
        }
    }
}

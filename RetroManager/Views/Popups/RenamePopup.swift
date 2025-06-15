import SwiftUI

struct RenamePopup: View {
    @EnvironmentObject var playlistManager: PlaylistManager;
    @State private var label: String = ""
    @FocusState private var isFocused: Bool
    
    var onClose: () -> Void

    var body: some View {
        VStack {
            Text("Rename Game")
                .font(.headline)
            TextField("New name", text: $label)
                .frame(width: 400)
                .focused($isFocused)
                .onAppear { isFocused = true }
                .onSubmit { onClose() }
                .onExitCommand { onClose() }
            HStack {
                Button("Cancel") { onClose() }
                Button("OK") {
                    if(playlistManager.selectedGame.label != label){
                        playlistManager.selectedGame.rename(label)
                        playlistManager.selectedPlaylist.sort()
                        playlistManager.selectedPlaylist.isDirty = true
                        playlistManager.refresh()
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
        }
    }
}

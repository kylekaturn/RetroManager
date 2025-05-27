import SwiftUI

struct RenamePopup: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var onCommit: () -> Void
    var onCancel: () -> Void

    var body: some View {
        VStack {
            Text("Rename Game")
                .font(.headline)
            TextField("New name", text: $text)
                .frame(width: 400)
                .focused($isFocused)
                .onAppear { isFocused = true }
                .onSubmit { onCommit() }
                .onExitCommand { onCancel() }
            HStack {
                Button("Cancel") { onCancel() }
                Button("OK") { onCommit() }
                    .keyboardShortcut(.defaultAction)
            }
        }
        .padding()
        .frame(width: 450)
    }
}

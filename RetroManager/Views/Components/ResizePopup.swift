
import SwiftUI

struct ResizePopup: View {
    @Binding var width: Int
    @Binding var height: Int
    @State var id:UUID = UUID()
    
    var onCommit: () -> Void
    var onCancel: () -> Void

    var body: some View {
        VStack {
            Text("Resize Game").font(.headline)
            
            Spacer().frame(height:20)
            
            HStack{
                Button("512x512"){
                    width = 512
                    height = 512
                    id = UUID()
                }
                Button("640x480"){
                    width = 640
                    height = 480
                    id = UUID()
                }
                Button("480x640"){
                    width = 480
                    height = 640
                    id = UUID()
                }
            }
            HStack{
                Button("25%"){
                    width = Int(Double(width) * 0.25)
                    height = Int(Double(height) * 0.25)
                    id = UUID()
                }
                Button("50%"){
                    width = Int(Double(width) * 0.5)
                    height = Int(Double(height) * 0.5)
                    id = UUID()
                }
                Button("75%"){
                    width = Int(Double(width) * 0.75)
                    height = Int(Double(height) * 0.75)
                    id = UUID()
                }
            }
            Spacer().frame(height:20)
            HStack{
                Text("Width")
                TextField("", value: $width, format: .number)
                Text("Height")
                TextField("", value: $height, format: .number)
            }
            Spacer().frame(height:20)
            HStack {
                Button("Cancel") { onCancel() }
                Button("OK") { onCommit() }
            }
        }
        .padding()
        .frame(width: 300)
        .id(id)
    }
}

#Preview {
    ResizePopup(width:.constant(640), height:.constant(480), onCommit: {}, onCancel: {})
}


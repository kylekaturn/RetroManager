import SwiftUI

struct ThumbnailItem: View {
    var thumbnailType: ThumbnailType
    var thumbnailLabel: String
    var thumbnailPath: String {Path.getThumbnailPath(thumbnailType: thumbnailType, label: thumbnailLabel)}
    @State var width: Int = 0
    @State var height: Int = 0
    @State private var showResizeSheet = false
    @State var id: UUID = UUID()
    
    var body: some View {
        VStack(alignment:.center, spacing: 10){
            Text(thumbnailType.toString()).fontWeight(.bold)
            
            if let image = NSImage(contentsOfFile: thumbnailPath),
               let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil){
                Text("\(String(cgImage.width)) x \(String(cgImage.height))")
                Image(nsImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .onAppear(){
                        width = Int(image.size.width)
                        height = Int(image.size.height)
                    }
            } else {
                Text("")
                Image(systemName: "exclamationmark.octagon.fill")
                    .font(.system(size: 100))
                    .frame(width: 300, height: 300)
            }
            
            Spacer().frame(height: 10)
        }
        .id(id)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.trailing, 5)
        .contextMenu{
            Button("Show in Finder") {
                let url = URL(fileURLWithPath: thumbnailPath)
                NSWorkspace.shared.activateFileViewerSelecting([url])
            }
            Divider()
            Button("Copy") {
                if let image = NSImage(contentsOfFile: thumbnailPath) {
                    Utils.copyImageToClipboard(image)
                }
            }
            Button("Paste"){
                Utils.saveImageFromClipboard(thumbnailPath)
                id = UUID()
            }
            Divider()
            Button("Resize"){
                showResizeSheet = true
            }
        }
        .sheet(isPresented: $showResizeSheet) {
            ResizePopup(
                width : $width,
                height : $height,
                onCommit: {
                    showResizeSheet = false
                    if let image = NSImage(contentsOfFile: thumbnailPath) {
                        Utils.saveImage(image: image, path:thumbnailPath, width:width, height:height)
                    }
                    id = UUID()
                },
                onCancel: { showResizeSheet = false }
            )
        }
    }
}

#Preview {
    ThumbnailItem(thumbnailType:.snap , thumbnailLabel: "ThumbnailLabel")
}

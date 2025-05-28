import SwiftUI

struct ThumbnailItem: View {
    var thumbnailType: ThumbnailType
    var thumbnailLabel: String
    var thumbnailPath: String {Path.getThumbnailPath(thumbnailType: thumbnailType, label: thumbnailLabel)}
    
    var body: some View {
        VStack(alignment:.center, spacing: 10){
            Text(thumbnailType.toString()).fontWeight(.bold)
            
            if let image = NSImage(contentsOfFile: thumbnailPath) {
                Text("\(Int(image.size.width)) x \(Int(image.size.height))")
                Image(nsImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
            } else {
                Text("")
                Image(systemName: "exclamationmark.octagon.fill")
                    .font(.system(size: 100))
                    .frame(width: 300, height: 300)
            }
            
            Spacer().frame(height: 10)
        }
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
                //onCopy(game)
            }
            Button("Paste"){
               // onPaste(game)
            }
            Divider()
        }
    }
}

#Preview {
    ThumbnailItem(thumbnailType:.snap , thumbnailLabel: "ThumbnailLabel")
}

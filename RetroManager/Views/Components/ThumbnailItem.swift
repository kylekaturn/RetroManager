import SwiftUI

struct ThumbnailItem: View {
    var thumbnailType: ThumbnailType
    var thumbnailLabel: String
    var thumbnailPath: String {Path.getThumbnailPath(thumbnailType: thumbnailType, label: thumbnailLabel)}
    @State var refreshID: UUID = UUID()
    
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
        .id(refreshID)
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
                    copyImageToClipboard(image)
                }
            }
            Button("Paste"){
                pasteImageFromClipboard(thumbnailPath)
            }
            Divider()
        }
    }
    
    func copyImageToClipboard(_ image: NSImage) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.writeObjects([image])
    }
    
    func pasteImageFromClipboard(_ path: String) {
        let pasteboard = NSPasteboard.general
        let classes = [NSImage.self]
        if let items = pasteboard.readObjects(forClasses: classes, options: nil) as? [NSImage],
           let image = items.first {
            if let tiffData = image.tiffRepresentation,
               let bitmap = NSBitmapImageRep(data: tiffData),
               let pngData = bitmap.representation(using: .png, properties: [:]) {
                do {
                    try pngData.write(to: URL(fileURLWithPath: path))
                    print("이미지 저장 완료: \(path)")
                    refreshID = UUID()
                } catch {
                    print("이미지 저장 실패: \(error)")
                }
            }
        } else {
            print("클립보드에 이미지 없음")
        }
    }
}

#Preview {
    ThumbnailItem(thumbnailType:.snap , thumbnailLabel: "ThumbnailLabel")
}

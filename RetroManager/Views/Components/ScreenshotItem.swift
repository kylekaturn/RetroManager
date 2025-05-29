import SwiftUI

struct ScreenshotItem: View {
    var screenshotPath: String = ""
    @State var id: UUID = UUID()
    
    var body: some View {
        VStack(alignment:.center, spacing: 10){
            if let image = NSImage(contentsOfFile: screenshotPath){
                Image(nsImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    
            }
        }
        .id(id)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.trailing, 5)
        .contextMenu{
            Button("Show in Finder") {
                let url = URL(fileURLWithPath: screenshotPath)
                NSWorkspace.shared.activateFileViewerSelecting([url])
            }
            Divider()
            Button("Copy") {
                if let image = NSImage(contentsOfFile: screenshotPath) {
                    Utils.copyImageToClipboard(image)
                }
            }
            Divider()
            Button("Delete"){
                try? FileManager.default.removeItem(atPath: screenshotPath)
                id = UUID()
            }
        }
    }
}

#Preview {
    ScreenshotItem(screenshotPath: "ThumbnailLabel")
}

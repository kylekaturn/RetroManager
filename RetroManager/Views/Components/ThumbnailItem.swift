import SwiftUI

struct ThumbnailItem: View {
    var thumbnailType: ThumbnailType
    var thumbnailPath: String
    
    var body: some View {
        VStack(alignment:.center, spacing: 10){
            Text(thumbnailType.toString())
                .fontWeight(.bold)
            
            let fullPath = processFilename(thumbnailType: thumbnailType, filename: thumbnailPath)
            if let image = NSImage(contentsOfFile: fullPath) {
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
            Button("RESIZE"){
                
            }
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.trailing, 5)
    }
}

func processFilename(thumbnailType: ThumbnailType, filename: String) -> String {
    let invalidCharacters: [Character] = ["&", "*", "/", ":", "<", ">", "?", "\\", "|"]
    var sanitized = filename
    for ch in invalidCharacters {
        sanitized = sanitized.replacingOccurrences(of: String(ch), with: "_")
    }
    let fullPath = Path.THUMBNAIL_PATH + thumbnailType.toFolderName() + "/" + sanitized + ".png"
    return fullPath
}

#Preview {
    ThumbnailItem(thumbnailType:.snap , thumbnailPath: "ThumbnailPath")
}

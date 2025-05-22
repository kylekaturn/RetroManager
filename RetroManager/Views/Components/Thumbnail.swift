import SwiftUI

struct Thumbnail: View {
    var thumbnailType: ThumbnailType
    var thumbnailPath: String
    
    var body: some View {
        VStack{
            Form{
                Text(thumbnailType.toString())
                    .fontWeight(.bold)
                
                let fullPath = processFilename(thumbnailType: thumbnailType, filename: thumbnailPath)
                if let image = NSImage(contentsOfFile: fullPath) {
                    Image(nsImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                } else {
                    Image(systemName: "exclamationmark.octagon.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                }
            }.formStyle(.grouped)
        }
    }
}

func processFilename(thumbnailType: ThumbnailType, filename: String) -> String {
    let invalidCharacters: [Character] = ["&", "*", "/", ":", "<", ">", "?", "\\", "|"]
    var sanitized = filename
    for ch in invalidCharacters {
        sanitized = sanitized.replacingOccurrences(of: String(ch), with: "_")
    }
    let fullPath = Path.THUMBNAIL_PATH + "/" + "MAME" + "/" + thumbnailType.toFolderName() + "/" + sanitized + ".png"
    return fullPath
}

#Preview {
    Thumbnail(thumbnailType:.snap , thumbnailPath: "ThumbnailPath")
}

import SwiftUI

struct Thumbnail: View {
    var thumbnailType: ThumbnailType
    var thumbnailPath: String
    
    var body: some View {
        Text(processFilename(thumbnailType: thumbnailType, filename: thumbnailPath))
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

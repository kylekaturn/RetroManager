class Path {
    static var SYSTEM_PATH = "MAME"
    static var PLAYLIST_PATH: String = ""
    static var THUMBNAIL_PATH: String = ""
    static var SCREENSHOT_PATH: String = ""
    
    static func getThumbnailPath(thumbnailType: ThumbnailType, label: String) -> String {
        let invalidCharacters: [Character] = ["&", "*", "/", ":", "<", ">", "?", "\\", "|"]
        var sanitized = label
        for ch in invalidCharacters {
            sanitized = sanitized.replacingOccurrences(of: String(ch), with: "_")
        }
        let fullPath = Path.THUMBNAIL_PATH + "/"
            + (SYSTEM_PATH == "MAME Full" ? "MAME" : SYSTEM_PATH) + "/"
            + thumbnailType.toFolderName() + "/"
            + sanitized + ".png"
        return fullPath
    }
}

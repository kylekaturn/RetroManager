class Path {
    static let RETROARCH_PATH = "/Volumes/Depot/RetroArch/"
    static var SYSTEM_PATH = "MAME"
    static var THUMBNAIL_PATH: String {RETROARCH_PATH + "thumbnail/" + (SYSTEM_PATH == "MAME Full" ? "MAME" : SYSTEM_PATH) + "/"}
    static var SCREENSHOT_PATH: String {RETROARCH_PATH + "screenshots/"}
    
    static func getThumbnailPath(thumbnailType: ThumbnailType, label: String) -> String {
        let invalidCharacters: [Character] = ["&", "*", "/", ":", "<", ">", "?", "\\", "|"]
        var sanitized = label
        for ch in invalidCharacters {
            sanitized = sanitized.replacingOccurrences(of: String(ch), with: "_")
        }
        let fullPath = Path.THUMBNAIL_PATH + thumbnailType.toFolderName() + "/" + sanitized + ".png"
        return fullPath
    }
}

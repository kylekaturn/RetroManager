import Foundation

class Path {
    static var SYSTEM_PATH = "MAME"
    static let DEFAULT_CONFIGURATION_PATH = "~/Library/Application Support/RetroArch/config/retroarch.cfg"
    static var CONFIGURATION_PATH: String {
        let stored = UserDefaults.standard.string(forKey: "retroarchConfigPath")
        return stored ?? DEFAULT_CONFIGURATION_PATH
    }
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

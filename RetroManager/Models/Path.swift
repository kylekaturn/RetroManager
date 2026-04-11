import Foundation

enum Path {
    static let DEFAULT_CONFIGURATION_PATH = "~/Library/Application Support/RetroArch/config/retroarch.cfg"

    static var CONFIGURATION_PATH: String {
        UserDefaults.standard.string(forKey: "retroarchConfigPath") ?? DEFAULT_CONFIGURATION_PATH
    }

    private(set) static var PLAYLIST_PATH: String = ""
    private(set) static var THUMBNAIL_PATH: String = ""
    private(set) static var SCREENSHOT_PATH: String = ""

    static func configure(playlistPath: String, thumbnailPath: String, screenshotPath: String) {
        PLAYLIST_PATH = playlistPath
        THUMBNAIL_PATH = thumbnailPath
        SCREENSHOT_PATH = screenshotPath
    }

    static func getThumbnailPath(thumbnailType: ThumbnailType, label: String, systemPath: String) -> String {
        let invalidCharacters: [Character] = ["&", "*", "/", ":", "<", ">", "?", "\\", "|"]
        var sanitized = label
        for ch in invalidCharacters {
            sanitized = sanitized.replacingOccurrences(of: String(ch), with: "_")
        }
        let system = systemPath == "MAME Full" ? "MAME" : systemPath
        return THUMBNAIL_PATH + "/" + system + "/" + thumbnailType.toFolderName() + "/" + sanitized + ".png"
    }
}

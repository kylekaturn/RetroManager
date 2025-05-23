class Path {
    static let RETROARCH_PATH = "/Volumes/Depot/RetroArch/"
    static var SYSTEM_PATH = "MAME"
    static var THUMBNAIL_PATH: String {RETROARCH_PATH + "thumbnail/" + (SYSTEM_PATH == "MAME Full" ? "MAME" : SYSTEM_PATH) + "/"}
    static var SCREENSHOT_PATH: String {RETROARCH_PATH + "screenshots/"}
}

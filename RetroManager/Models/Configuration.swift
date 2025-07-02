import Foundation

class Configuration{
    
    let filePath = "~/Library/Application Support/RetroArch/config/retroarch.cfg"
    var config : [String: String] = [:]
    
    func thumbnailPath() -> String{
        return config["thumbnails_directory"] ?? ""
    }
    
    func logPath() -> String{
        return config["runtime_log_directory"] ?? ""
    }
    
    func browserPath() -> String{
        return config["rgui_browser_directory"] ?? ""
    }
    
    func playlistPath() -> String{
        return config["playlist_directory"] ?? ""
    }
    
    func screenshotPath() -> String{
        return config["screenshot_directory"] ?? ""
    }
    
    func configPath() -> String{
        return config["rgui_config_directory"] ?? ""
    }
    
    init(){
        let filePath = ("~/Library/Application Support/RetroArch/config/retroarch.cfg" as NSString).expandingTildeInPath
        print(FileManager.default.fileExists(atPath: filePath))
       
        do {
            let contents = try String(contentsOf: URL(fileURLWithPath: filePath), encoding: .utf8)
            config = parseRetroArchConfig(at: contents)
        } catch {
            print("\(error)")
        }
        Utils.copyFile(from: filePath, to: configPath() + "/retroarch.cfg")
    }
    
    func parseRetroArchConfig(at content: String) -> [String: String] {
        var result: [String: String] = [:]
        let lines = content.components(separatedBy: .newlines)
        
        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            guard !trimmed.isEmpty, !trimmed.hasPrefix("#") else { continue } // 빈 줄/주석 무시
            
            let parts = trimmed.components(separatedBy: "=")
            if parts.count >= 2 {
                let key = parts[0].trimmingCharacters(in: .whitespaces)
                let value = parts[1...].joined(separator: "=").trimmingCharacters(in: .whitespacesAndNewlines)
                    .trimmingCharacters(in: CharacterSet(charactersIn: "\"")) // 양쪽 따옴표 제거
                
                result[key] = value
            }
        }
        return result
    }
}

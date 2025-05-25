import Foundation
import AppKit

class Playlist: Codable, Identifiable, Hashable{
    var id: UUID = UUID()
    var label: String = ""
    var file: String = ""
    var isDirty: Bool = false
    var version: String
    var default_core_path: String
    var default_core_name: String
    var label_display_mode: Int
    var right_thumbnail_mode: Int
    var left_thumbnail_mode: Int
    var thumbnail_match_mode: Int
    var sort_mode: Int
    var scan_content_dir: String
    var scan_file_exts: String
    var scan_dat_file_path: String
    var scan_search_recursively: Bool
    var scan_search_archives: Bool
    var scan_filter_dat_content: Bool
    var scan_overwrite_playlist: Bool
    var items: [Game]
    
    enum CodingKeys: String, CodingKey {
        case version
        case default_core_path
        case default_core_name
        case label_display_mode
        case right_thumbnail_mode
        case left_thumbnail_mode
        case thumbnail_match_mode
        case sort_mode
        case scan_content_dir
        case scan_file_exts
        case scan_dat_file_path
        case scan_search_recursively
        case scan_search_archives
        case scan_filter_dat_content
        case scan_overwrite_playlist
        case items
    }
    
    init(){
        version = "Version"
        default_core_path = "DefaultCorePath"
        default_core_name = "DefaultCoreName"
        label_display_mode = 0
        right_thumbnail_mode = 0
        left_thumbnail_mode = 0
        thumbnail_match_mode = 0
        sort_mode = 0
        scan_content_dir = "ScanContentDir"
        scan_file_exts = "ScanFileExts"
        scan_dat_file_path = "ScanDatFilePath"
        scan_search_recursively = false
        scan_search_archives = false
        scan_filter_dat_content = false
        scan_overwrite_playlist = false
        items = [Game(), Game(), Game(), Game(), Game(), Game(), Game(), Game(), Game(), Game(), Game(), Game(), Game(), Game()]
    }
    
    static func == (lhs: Playlist, rhs: Playlist) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    //게임 추가
    func addGame(_ game: Game){
        items.append(game)
        sort()
        isDirty = true
    }
    
    //게임 추가(json)
    func addGame(_ jsonString: String){
        if let jsonData = jsonString.data(using: .utf8), let game = try? JSONDecoder().decode(Game.self, from: jsonData) {
            addGame(game)
        } else {
            print("PasteGame Failed.")
        }
    }
    
    //게임 제거
    func deleteGame(_ game: Game){
        if let index = items.firstIndex(of: game) {
            items.remove(at: index)
        }
        isDirty = true
    }
    
    //소팅
    func sort(){
        items.sort { $0.label.lowercased() < $1.label.lowercased() }
    }
    
    //Json 파일 저장
    func save() throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes]
        let data = try encoder.encode(self)
        let url = URL(fileURLWithPath: file)
        try data.write(to: url)
        print("Save Complete")
        isDirty = false
    }
}

struct Game: Codable, Identifiable, Hashable{
    var id : UUID = UUID()
    var path: String
    var label: String
    var core_path: String
    var core_name: String
    var crc32: String
    var db_name: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case label
        case core_path
        case core_name
        case crc32
        case db_name
    }
    
    init(){
        path = "Path"
        label = "Label"
        core_path = "CorePath"
        core_name = "CoreName"
        crc32 = "CRC32"
        db_name = "DBName"
    }
    
    func toJson() -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes]
        if let data = try? encoder.encode(self),
           let jsonString = String(data: data, encoding: .utf8) {
           return jsonString
        }else{
            return ""
        }
    }
}

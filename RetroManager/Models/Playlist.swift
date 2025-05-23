import Foundation

struct Playlist: Codable, Identifiable, Hashable{
    let id: UUID = UUID()
    var label: String = ""
    var file: String = ""
    let version: String
    let default_core_path: String
    let default_core_name: String
    let label_display_mode: Int
    let right_thumbnail_mode: Int
    let left_thumbnail_mode: Int
    let thumbnail_match_mode: Int
    let sort_mode: Int
    let scan_content_dir: String
    let scan_file_exts: String
    let scan_dat_file_path: String
    let scan_search_recursively: Bool
    let scan_search_archives: Bool
    let scan_filter_dat_content: Bool
    let scan_overwrite_playlist: Bool
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
    
    //아이템 추가
    mutating func addGame(_ game: Game){
        items.append(game)
        sort()
    }
    
    //게임 제거
    mutating func deleteGame(_ game: Game){
        if let index = items.firstIndex(of: game) {
            items.remove(at: index)
        }
    }
    
    //소팅
    mutating func sort(){
        items.sort { $0.label < $1.label }
    }
    
    //Json 파일 저장
    func save() throws {
//        guard !file.isEmpty else {
//            throw NSError(domain: "PlaylistSaveError", code: 1, userInfo: [NSLocalizedDescriptionKey: "file 경로가 비어 있습니다."])
//        }
        print(file)
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes]
        let data = try encoder.encode(self)
        let url = URL(fileURLWithPath: file)
        try data.write(to: url)
        print("Save Complete")
    }
}

struct Game: Codable, Identifiable, Hashable{
    let id : UUID = UUID()
    let path: String
    let label: String
    let core_path: String
    let core_name: String
    let crc32: String
    let db_name: String
    
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
}

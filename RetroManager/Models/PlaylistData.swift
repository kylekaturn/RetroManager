import Foundation

struct PlaylistData: Codable, Hashable{
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
    var items: [PlaylistItem] = [PlaylistItem(), PlaylistItem(), PlaylistItem()]
    
    init(){
        version = ""
        default_core_path = ""
        default_core_name = ""
        label_display_mode = 0
        right_thumbnail_mode = 0
        left_thumbnail_mode = 0
        thumbnail_match_mode = 0
        sort_mode = 0
        scan_content_dir = ""
        scan_file_exts = ""
        scan_dat_file_path = ""
        scan_search_recursively = false
        scan_search_archives = false
        scan_filter_dat_content = false
        scan_overwrite_playlist = false
        items = []
    }
}

struct PlaylistItem: Codable, Hashable{
    let path: String
    let label: String
    let core_path: String
    let core_name: String
    let crc32: String
    let db_name: String
    
    init(){
        path = "Path"
        label = "Label"
        core_path = "CorePath"
        core_name = "CoreName"
        crc32 = "CRC32"
        db_name = "DBName"
    }
}

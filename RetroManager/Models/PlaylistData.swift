struct PlaylistData: Codable{
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
    let items: [PlaylistItem]
}

struct PlaylistItem: Codable{
    let path: String
    let label: String
    let core_path: String
    let core_name: String
    let crc32: String
    let db_name: String
}

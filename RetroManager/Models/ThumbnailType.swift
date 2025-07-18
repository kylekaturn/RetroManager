enum ThumbnailType {
    case title
    case snap
    case boxart
    
    func toFolderName() -> String {
        switch self {
        case .title: return "Named_Titles"
        case .snap: return "Named_Snaps"
        case .boxart: return "Named_Boxarts"
        }
    }
    
    func toString() -> String{
        switch self{
        case .title: return "Title"
        case .snap: return "Snap"
        case .boxart: return "Boxart"
        }
    }
}

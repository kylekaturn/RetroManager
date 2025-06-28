import Foundation
import AppKit

class Game: Codable, Identifiable, Hashable{
    var id : UUID = UUID()
    var path: String
    var label: String
    var core_path: String
    var core_name: String
    var crc32: String
    var db_name: String
    var romName: String {URL(fileURLWithPath: path).deletingPathExtension().lastPathComponent}
    
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
    
    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func rename(_ newLabel:String){
        Utils.renameFile(
            from: Path.getThumbnailPath(thumbnailType: ThumbnailType.boxart, label: label),
            to: Path.getThumbnailPath(thumbnailType: ThumbnailType.boxart, label: newLabel))
        Utils.renameFile(
            from: Path.getThumbnailPath(thumbnailType: ThumbnailType.snap, label: label),
            to: Path.getThumbnailPath(thumbnailType: ThumbnailType.snap, label: newLabel))
        Utils.renameFile(
            from: Path.getThumbnailPath(thumbnailType: ThumbnailType.title, label: label),
            to: Path.getThumbnailPath(thumbnailType: ThumbnailType.title, label: newLabel))
        label = newLabel
    }
    
    func clone() -> Game {
        let newGame = Game()
        newGame.path = self.path
        newGame.label = self.label
        newGame.core_path = self.core_path
        newGame.core_name = self.core_name
        newGame.crc32 = self.crc32
        newGame.db_name = self.db_name
        // id는 새 UUID로 남겨둠 (복제지만 새로운 개체로 취급)
        return newGame
    }
    
    //json 스트링을 변환
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

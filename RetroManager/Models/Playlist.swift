import Foundation

class Playlist{
    let fileURL: String
    var playlistData: PlaylistData
    
    init(fileURL: String){
        self.fileURL = fileURL
        self.playlistData = PlaylistData()
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: fileURL))
            self.playlistData = try JSONDecoder().decode(PlaylistData.self, from: data)
        } catch {
            print("Couldn't decode playlist file : \(error)")
        }
    }
    
    init(){
        self.fileURL = ""
        playlistData = PlaylistData()
    }
    
    func save(){
        print("Playlist Saved.")
    }
}

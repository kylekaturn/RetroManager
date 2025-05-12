import Foundation

class Playlist{
    let name: String
    var playlistData: PlaylistData
    
    init?(name: String){
        self.name = name
        
        let playlistPath = "/Volumes/Depot/RetroArch/playlists/\(name).lpl"
        
        guard FileManager.default.fileExists(atPath: playlistPath) else {
            print("Coudn't find playlist file : \(playlistPath)")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: playlistPath))
            self.playlistData = try JSONDecoder().decode(PlaylistData.self, from: data)
        } catch {
            print("Couldn't decode playlist file : \(error)")
            return nil
        }
        
        print(playlistData.version)
        print(playlistData.default_core_name)
        print(playlistData.label_display_mode)
    }
    
    func Save(){
        print("Playlist Saved.")
    }
}

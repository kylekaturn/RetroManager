import Foundation

class PlaylistManager: ObservableObject {
    
    @Published var playlists: [Playlist] = []
    let folderPath = "/Volumes/Depot/RetroArch/playlists"
    
    init(loadFiles: Bool = true) {
        if(loadFiles){
            do {
                let fileURLs = try FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: folderPath), includingPropertiesForKeys: nil)
                    .filter {$0.pathExtension == "lpl"}
                for fileURL in fileURLs {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: fileURL.path))
                        var playlist = try JSONDecoder().decode(Playlist.self, from: data)
                        playlist.file = fileURL.deletingPathExtension().lastPathComponent
                        playlists.append(playlist)
                        print("Playlists Loaded : \(fileURL.path)")
                    } catch {
                        print("Couldn't decode playlist file : \(error)")
                    }
                }
            } catch {
                print("Error reading playlists: \(error)")
            }
        }else{
            playlists.append(Playlist())
            playlists.append(Playlist())
        }
    }
}

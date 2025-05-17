import Foundation

class PlaylistManager: ObservableObject {
    
    @Published var playlists: [Playlist] = []
    
    init() {
        let folderPath = "/Volumes/Depot/RetroArch/playlists"
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: folderPath), includingPropertiesForKeys: nil)
                .filter {$0.pathExtension == "lpl"}
            for fileURL in fileURLs {
                playlists.append(Playlist(fileURL: fileURL.path))
                print("Playlists Loaded : \(fileURL.path)")
            }
        } catch {
            print("Error reading playlists: \(error)")
        }
    }
}

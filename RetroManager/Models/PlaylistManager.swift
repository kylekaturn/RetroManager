import Foundation

class PlaylistManager: ObservableObject {
    
    @Published var playlists: [Playlist] = []
    @Published var selectedPlaylist: Playlist = Playlist()
    @Published var selectedGame: Game = Game()
    let folderPath = "/Volumes/Depot/RetroArch/playlists"
    
    init() {
        if(ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1"){
            do {
                let fileURLs = try FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: folderPath), includingPropertiesForKeys: nil)
                    .filter {$0.pathExtension == "lpl"}
                for fileURL in fileURLs {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: fileURL.path))
                        var playlist = try JSONDecoder().decode(Playlist.self, from: data)
                        playlist.file = fileURL.deletingPathExtension().lastPathComponent
                        playlists.append(playlist)
                        selectedPlaylist = playlists.first!
                        selectedGame = selectedPlaylist.items.first!
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
           // selectedPlaylist = playlists.first!
           // selectedPlaylistItem = selectedPlaylist.items.first!
        }
    }
}

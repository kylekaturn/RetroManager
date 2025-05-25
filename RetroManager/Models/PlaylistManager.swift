import Foundation

class PlaylistManager: ObservableObject {
    
    @Published var playlists: [Playlist] = []
    @Published var selectedPlaylist: Playlist = Playlist()
    @Published var selectedGame: Game = Game()
    @Published var refreshID: UUID = UUID()
    let folderPath = "/Volumes/Depot/RetroArch/playlists"
    
    init() {
        if(ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1"){
            do {
                let fileURLs = try FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: folderPath), includingPropertiesForKeys: nil)
                    .filter {$0.pathExtension == "lpl"}
                for fileURL in fileURLs {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: fileURL.path))
                        let playlist = try JSONDecoder().decode(Playlist.self, from: data)
                        playlist.label = fileURL.deletingPathExtension().lastPathComponent
                        playlist.file = fileURL.path
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
            playlists.append(Playlist())
            playlists.append(Playlist())
            playlists.append(Playlist())
            playlists.append(Playlist())
            playlists.append(Playlist())
            playlists.append(Playlist())
            playlists.append(Playlist())
            playlists.append(Playlist())
        }
    }
    
    func refresh(){
        refreshID = UUID()
    }
}

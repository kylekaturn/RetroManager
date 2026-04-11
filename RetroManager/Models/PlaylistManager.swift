import Foundation

class PlaylistManager: ObservableObject {

    @Published var playlists: [Playlist] = []
    @Published var selectedPlaylistIndex: Int = 0
    @Published var selectedGameIndex: Int = 0
    @Published var systemPath: String = "MAME"

    var selectedPlaylist: Playlist {
        get {
            guard playlists.indices.contains(selectedPlaylistIndex) else { return Playlist() }
            return playlists[selectedPlaylistIndex]
        }
        set {
            guard playlists.indices.contains(selectedPlaylistIndex) else { return }
            playlists[selectedPlaylistIndex] = newValue
        }
    }

    var selectedGame: Game {
        get {
            let items = selectedPlaylist.items
            guard items.indices.contains(selectedGameIndex) else { return Game() }
            return items[selectedGameIndex]
        }
        set {
            guard playlists.indices.contains(selectedPlaylistIndex),
                  playlists[selectedPlaylistIndex].items.indices.contains(selectedGameIndex) else { return }
            playlists[selectedPlaylistIndex].items[selectedGameIndex] = newValue
        }
    }

    init() {
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1" {
            do {
                let fileURLs = try FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: Path.PLAYLIST_PATH), includingPropertiesForKeys: nil)
                    .filter { $0.pathExtension == "lpl" }
                for fileURL in fileURLs {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: fileURL.path))
                        var playlist = try JSONDecoder().decode(Playlist.self, from: data)
                        playlist.label = fileURL.deletingPathExtension().lastPathComponent
                        playlist.file = fileURL.path
                        playlists.append(playlist)
                        print("Playlists Loaded : \(fileURL.path)")
                    } catch {
                        print("Couldn't decode playlist file : \(error)")
                    }
                }
                playlists.sort(by: { $0.label < $1.label })
            } catch {
                print("Error reading playlists: \(error)")
            }
        } else {
            playlists = (0..<10).map { _ in Playlist() }
        }
    }

    func selectPlaylist(_ playlist: Playlist) {
        if let index = playlists.firstIndex(where: { $0.id == playlist.id }) {
            selectedPlaylistIndex = index
            selectedGameIndex = 0
            systemPath = playlists[index].label
        }
    }

    func selectGame(_ game: Game) {
        if let index = selectedPlaylist.items.firstIndex(where: { $0.id == game.id }) {
            selectedGameIndex = index
        }
    }

    /// 특정 플레이리스트를 ID로 찾아 변경
    func modifyPlaylist(withID id: UUID, _ mutation: (inout Playlist) -> Void) {
        guard let index = playlists.firstIndex(where: { $0.id == id }) else { return }
        mutation(&playlists[index])
    }
}

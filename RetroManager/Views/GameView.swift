import SwiftUI
import Foundation

struct GameView: View {
    @EnvironmentObject var playlistManager: PlaylistManager;
    let google : String = "http://www.google.com/search?tbm=isch&q="
    let launchbox : String = "https://gamesdb.launchbox-app.com/games/results/"
    @State var screenshots: [String] = []
    
    var body: some View {
        VStack(alignment:.leading, spacing: 5){
            Text(playlistManager.selectedGame.label)
            Text(playlistManager.selectedGame.core_name)
            Text(playlistManager.selectedGame.path)
            
            Spacer().frame(height:10)
            
            HStack{
                ThumbnailItem(thumbnailType:.boxart , thumbnailLabel: playlistManager.selectedGame.label)
                ThumbnailItem(thumbnailType:.title , thumbnailLabel: playlistManager.selectedGame.label)
                ThumbnailItem(thumbnailType:.snap , thumbnailLabel: playlistManager.selectedGame.label)
            }
            
            Spacer().frame(height:10)
            
            Text("SCREENSHOTS").font(.headline)
            HStack{
                ForEach(screenshots, id: \.self) { fileName in
                    ScreenshotItem(screenshotPath: Path.SCREENSHOT_PATH + "/" + fileName)
                }
            }
            
            Spacer().frame(height:10)
            
            Text("JSON").font(.headline)
            Text(playlistManager.selectedGame.toJson())
            
            Spacer()
            
            HStack{
                Button("Search Label"){
                    if let query = playlistManager.selectedGame.label.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                       let url = URL(string: "\(google)\(query)") {
                        NSWorkspace.shared.open(url)
                    }
                }
                Button("Serach File"){
                    if let label = URL(string: playlistManager.selectedGame.path)?.deletingPathExtension().lastPathComponent,
                       let query = label.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                       let url = URL(string: "\(google)\(query)") {
                        NSWorkspace.shared.open(url)
                    }
                }
                Button("Serach LaunchBox"){
                    if let query = playlistManager.selectedGame.label.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                       let url = URL(string: "\(launchbox)\(query)") {
                        NSWorkspace.shared.open(url)
                    }
                }
                
                Spacer()
            }
        }
        .onAppear(){
            let files = Utils.getPNGFilesFromFolder(Path.SCREENSHOT_PATH)
            screenshots = files.filter { $0.contains(playlistManager.selectedGame.romName) }
        }
        .onChange(of:playlistManager.selectedGame){
            let files = Utils.getPNGFilesFromFolder(Path.SCREENSHOT_PATH)
            screenshots = files.filter { $0.contains(playlistManager.selectedGame.romName) }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(15)
    }
}

#Preview {
    GameView().environmentObject(PlaylistManager())
}

import Foundation
import SwiftUI

final class Utils {

    //Rename file with overwrite
    static func renameFile(from oldPath: String, to newPath: String) {
        let fileManager = FileManager.default
        
        //기존파일이 없으면 리턴
        if(!fileManager.fileExists(atPath: oldPath)) {return}

        //새 파일이 이미 있으면 삭제(Overwrite)
        if fileManager.fileExists(atPath: newPath) {
            try! fileManager.removeItem(atPath: newPath)
        }
        print(oldPath)
        print(newPath)

        //파일 이름 변경(이동)
        try! fileManager.moveItem(atPath: oldPath, toPath: newPath)
    }
    

    //Get files from folder
    static func getFilesFromFolder(_ folderPath: String) -> [String] {
        let fileManager = FileManager.default
        do {
            let files = try fileManager.contentsOfDirectory(atPath: folderPath)
            return files
        } catch {
            print("폴더 읽기 실패: \(error)")
            return []
        }
    }
    
    //Get PNG files from folder.
    static func getPNGFilesFromFolder(_ folderPath: String) -> [String] {
        let fileManager = FileManager.default
        do {
            let files = try fileManager.contentsOfDirectory(atPath: folderPath)
            // 확장자가 png인 파일만 필터링 (대소문자 구분 없이)
            let pngFiles = files.filter { $0.lowercased().hasSuffix(".png") }
            return pngFiles
        } catch {
            print("폴더 읽기 실패: \(error)")
            return []
        }
    }
    
    //Copy image to a clipboard
    static func copyImageToClipboard(_ image: NSImage) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.writeObjects([image])
    }
    
    //Get image from clipboard and save to a file
    static func saveImageFromClipboard(_ path: String){
        let pasteboard = NSPasteboard.general
        let classes = [NSImage.self]
        if let items = pasteboard.readObjects(forClasses: classes, options: nil) as? [NSImage],
           let image = items.first {
            if let tiffData = image.tiffRepresentation,
               let bitmap = NSBitmapImageRep(data: tiffData),
               let pngData = bitmap.representation(using: .png, properties: [:]) {
                do {
                    try pngData.write(to: URL(fileURLWithPath: path))
                    print("Image save succeed : \(path)")
                } catch {
                    print("Image save failed : \(error)")
                }
            }
        } else {
            print("No image in clipboard")
        }
    }
    
    //Save image to a file
    static func saveImage(image: NSImage, path: String, width: Int, height: Int) {
        // 1. NSImage → CGImage 변환
        guard let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
            print("NSImage to CGImage 변환 실패")
            return
        }
        
        // 2. 새 픽셀 버퍼(CGBitmapContext) 생성
        guard let colorSpace = cgImage.colorSpace ?? CGColorSpace(name: CGColorSpace.sRGB) else {
            print("ColorSpace 문제")
            return
        }
        guard let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: width * 4,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else {
            print("CGContext 생성 실패")
            return
        }
        
        // 3. CGImage 그리기 (정확히 width x height 픽셀)
        context.interpolationQuality = .high
        context.draw(cgImage, in: CGRect(origin: .zero, size: CGSize(width: width, height: height)))
        
        // 4. 새 CGImage → NSBitmapImageRep → PNG Data
        guard let scaledCGImage = context.makeImage() else {
            print("CGContext 이미지 변환 실패")
            return
        }
        let bitmap = NSBitmapImageRep(cgImage: scaledCGImage)
        guard let pngData = bitmap.representation(using: .png, properties: [:]) else {
            print("PNG 변환 실패")
            return
        }
        
        do {
            try pngData.write(to: URL(fileURLWithPath: path))
            print("Resize image succeed: \(path)")
            print("bitsPerPixel:", bitmap.bitsPerPixel, "bitmapFormat:", bitmap.bitmapFormat.rawValue)
        } catch {
            print("Resize image failed: \(error)")
        }
    }
    
    static func launchRetroArch(romPath: String, corePath: String) {
        let task = Process()
        // RetroArch 실행 파일 경로 (macOS 기본 설치 경로)
        task.launchPath = "/Applications/RetroArch.app/Contents/MacOS/RetroArch"
        // 명령줄 인자
        task.arguments = [
            "-L", corePath,
            romPath
        ]
        // 원하는 옵션 추가 가능
        // 예: 전체화면으로 실행하려면 task.arguments?.append("--fullscreen")
        // 비동기로 실행 (동기로 하고 싶으면 task.waitUntilExit())
        do {
            try task.run()
            print("RetroArch 실행됨")
        } catch {
            print("RetroArch 실행 실패: \(error)")
        }
    }

    /// 현재 날짜를 문자열로 반환 (예: "2025-05-06")
    static func currentDateString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: Date())
    }

    /// 문자열이 비어있는지 검사
    static func isEmptyOrWhitespace(_ text: String?) -> Bool {
        guard let text = text else { return true }
        return text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    /// 랜덤한 정수 생성
    static func randomInt(min: Int, max: Int) -> Int {
        return Int.random(in: min...max)
    }
}

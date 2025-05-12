import Foundation
import SwiftUI

final class Utils {
    
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

    /// 애니메이션 적용된 딜레이 실행
    static func runAfter(_ delay: Double, onMain: Bool = true, _ action: @escaping () -> Void) {
        let queue = onMain ? DispatchQueue.main : DispatchQueue.global()
        queue.asyncAfter(deadline: .now() + delay) {
            withAnimation {
                action()
            }
        }
    }
}

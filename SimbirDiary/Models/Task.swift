import Foundation

struct Task: Codable {
    let id: UUID
    let dateStart, name, description: String
}

// MARK: - Comparable extension:
extension Task: Comparable {
    static func < (lhs: Task, rhs: Task) -> Bool {
        lhs.dateStart < rhs.dateStart
    }
}

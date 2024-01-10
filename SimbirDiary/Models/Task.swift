import Foundation

struct Task: Codable {
    let id: UUID
    let dateStart, dateFinish, name, description: String

    enum CodingKeys: String, CodingKey {
        case id
        case dateStart = "date_start"
        case dateFinish = "date_finish"
        case name, description
    }
}

// MARK: - Comparable extension:
extension Task: Comparable {
    static func < (lhs: Task, rhs: Task) -> Bool {
        lhs.dateStart < rhs.dateStart
    }
}

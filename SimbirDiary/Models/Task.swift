import Foundation

struct Task: Codable {
    let id: Int
    let dateStart, dateFinish, name, description: String

    enum CodingKeys: String, CodingKey {
        case id
        case dateStart = "date_start"
        case dateFinish = "date_finish"
        case name, description
    }
}

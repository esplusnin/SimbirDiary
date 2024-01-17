import Foundation

struct Task: Codable {
    let id: UUID
    let startDate, name, description: String
}

// MARK: - Comparable extension:
extension Task: Comparable {
    static func < (lhs: Task, rhs: Task) -> Bool {
        lhs.startDate < rhs.startDate
    }
}

// MARK: - Transfering Model:
extension Task {
    init(object: TaskObject, with dateFormatter: DateFormatterProtocol) {
        let decoder = JSONDecoder()
        let task = try? decoder.decode(Task.self, from: object.data)

        id = object.id
        startDate = task?.startDate ?? ""
        name = task?.name ?? ""
        description = task?.description ?? ""
    }
}

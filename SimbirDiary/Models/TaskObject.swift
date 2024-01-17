import Foundation
import RealmSwift

class TaskObject: Object {
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var startDate: String
    @Persisted var data: Data
    
    convenience init(ownID: UUID, date: String, data: Data) {
        self.init()
        self.id = ownID
        self.startDate = date
        self.data = data
    }
}

// MARK: - Transfering Model:
extension TaskObject {
    convenience init(from task: Task) {
        self.init()
        let dateFormatter = DateFormatter()
        let encoder = JSONEncoder()
        let data = try? encoder.encode(task)
        
        self.id = task.id
        self.startDate = task.startDate
        self.data = data ?? Data()
    }
}

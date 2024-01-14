import Foundation
import RealmSwift

class RealmTask: Object {
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

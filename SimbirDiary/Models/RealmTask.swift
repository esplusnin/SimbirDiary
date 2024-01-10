import Foundation
import RealmSwift

class RealmTask: Object {
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var data: Data
    
    convenience init(ownID: UUID, data: Data) {
        self.init()
        self.id = ownID
        self.data = data
    }
}

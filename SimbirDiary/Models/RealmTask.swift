import Foundation
import RealmSwift

class RealmTask: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var ownID: Int
    @Persisted var data: Data
    
    init(ownID: Int, data: Data) {
        self.ownID = ownID
        self.data = data
    }
}

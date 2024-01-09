import Foundation
import RealmSwift

final class RealmManager: DatabaseManagerProtocol {
    
    // MARK: - Dependencies:
    private var realmManager: Realm?
    
    // MARK: - Lifecycle:
    init() {
        realmManager = try? Realm()
    }
    
    // MARK: - Public Methods:
    func saveData(from data: Data) {
        guard let realmManager else { return }
        
        do {
            try realmManager.write {
                realmManager.create(RealmTask.self, value: data)
            }
        } catch {
            print("Database didn't save the object")
        }
    }
    
    func fetchData() -> Results<RealmTask>? {
        guard let realmManager else { return nil }
        return realmManager.objects(RealmTask.self)
    }
}

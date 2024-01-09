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
    func saveData(from task: Task) {
        guard let realmManager else { return }
        
        do {
            try realmManager.write {
                let encoder = JSONEncoder()
                let data = try encoder.encode(task)
                let realmTask = RealmTask(ownID: task.id, data: data)
                realmManager.add(realmTask)
            }
        } catch {
            print("Database didn't save the object")
        }
    }
    
    func fetchData(completion: @escaping (Result<[Task], Error>) -> Void) {
        var tasks = [Task]()

        if let objects = fetchRealmData() {
            let decoder = JSONDecoder()
            
            objects.forEach {
                do {
                    let task = try decoder.decode(Task.self, from: $0.data)
                    tasks.append(task)
                } catch {
                    print("Parsing error")
                }
            }
        }        
    }
    
    // MARK: - Private Methods:
    private func fetchRealmData() -> Results<RealmTask>? {
        guard let realmManager else { return nil }
        return realmManager.objects(RealmTask.self)
    }
}

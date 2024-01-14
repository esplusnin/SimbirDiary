import Foundation
import RealmSwift

final class RealmManager: DatabaseManagerProtocol {
    
    // MARK: - Dependencies:
    weak var dataProvider: DataProviderProtocol?
    
    private var realmManager: Realm?
    
    // MARK: - Constants and Variables:
    private var notificationToken: NotificationToken?
    private var deletedTask: Task?
    private var isInitiated = false

    private var tasks: Results<RealmTask>? {
        didSet {
            if isInitiated == false {
                addObserver()
                isInitiated.toggle()
            }
        }
    }
    
    // MARK: - Lifecycle:
    init() {
        realmManager = try? Realm()
    }
    
    deinit {
        notificationToken?.invalidate()
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
        } catch let error {
            print(error.localizedDescription)
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
                    completion(.failure(error))
                }
            }
            
            completion(.success(tasks))
        }
    }
    
    func delete(_ task: Task) {
        do {
            try realmManager?.write {
                if let object = realmManager?.object(ofType: RealmTask.self, forPrimaryKey: task.id) {
                    deletedTask = task
                    realmManager?.delete(object)
                }
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func setupDataProvider(_ provider: DataProviderProtocol) {
        dataProvider = provider
    }
    
    // MARK: - Private Methods:
    private func addObserver() {
        notificationToken = tasks?.observe { [weak self] changes in
            guard let self else { return }
            switch changes {
            case .update(let tasks, let deletions, let insertions, _):
                if !deletions.isEmpty {
                    guard let deletedTask else { return }
                    dataProvider?.setupUpdated(deletedTask)
                    self.deletedTask = nil
                }
                
                if !insertions.isEmpty {
                    let index = insertions.first ?? 0
                    let newTask = tasks[index]
                    sentUpdation(from: newTask)
                }
            case .error(let error):
                print(error.localizedDescription)
            default:
                break
            }
        }
    }
    
    private func fetchRealmData() -> Results<RealmTask>? {
        guard let realmManager else { return nil }
        tasks = realmManager.objects(RealmTask.self)
        return realmManager.objects(RealmTask.self)
    }
    
    private func sentUpdation(from object: RealmTask) {
        let decoder = JSONDecoder()
        
        do {
            let task = try decoder.decode(Task.self, from: object.data)
            dataProvider?.setupUpdated(task)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

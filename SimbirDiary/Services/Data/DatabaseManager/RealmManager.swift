import Foundation
import RealmSwift

final class RealmManager: DatabaseManagerProtocol {
    
    // MARK: - Dependencies:
    weak var dataProvider: DataProviderProtocol?
    
    private var dateFormatter: DateFormatterProtocol?
    
    // MARK: - Constants and Variables:
    private let realm: Realm?
    private var notificationToken: NotificationToken?
    
    private var deletedTask: Task?
    private var isInitiated = false
    
    private var tasks: Results<TaskObject>? {
        didSet {
            if isInitiated == false {
                addObserver()
                isInitiated.toggle()
            }
        }
    }
    
    // MARK: - Lifecycle:
    init() {
        realm = try? Realm(configuration: .defaultConfiguration)
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    // MARK: - Public Methods:
    func saveData(from task: Task) throws {
        dateFormatter = DateFormatterService()
        
        guard let realm,
              let dateFormatter else { return }
        
        realm.writeAsync {
            let realmTask = TaskObject(from: task, with: dateFormatter)
            realm.add(realmTask)
        }
    }
    
    func fetchData(with date: Date, completion: @escaping (Result<[Task], Error>) -> Void) {
        dateFormatter = DateFormatterService()
        
        let realmDate = dateFormatter?.getRealmDateFormat(from: date) ?? ""
        var tasks = [Task]()

        if let objects = self.fetchRealmData(with: realmDate) {
            objects.forEach {
                let task = Task(object: $0, with: self.dateFormatter ?? DateFormatterService())
                tasks.append(task)
            }
            
            completion(.success(tasks))
        }
        
        dateFormatter = nil
    }
    
    func delete(_ task: Task) {
        guard let realm else { return }
        
        do {
            try realm.write {
                if let object = realm.object(ofType: TaskObject.self, forPrimaryKey: task.id) {
                    deletedTask = task
                    realm.delete(object)
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
    
    private func fetchRealmData(with date: String) -> Results<TaskObject>? {
        guard let realm else { return nil}
        let generalTasks = realm.objects(TaskObject.self)
        let currentTasks = generalTasks.where { $0.startDate == date }
        tasks = generalTasks
        return currentTasks
    }
    
    private func sentUpdation(from object: TaskObject) {
        guard let dateFormatter else { return }
        let task = Task(object: object, with: dateFormatter)
        
        dataProvider?.setupUpdated(task)
        self.dateFormatter = nil
    }
}

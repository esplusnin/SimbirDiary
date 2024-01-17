import Foundation
import RealmSwift

final class RealmManager: DatabaseManagerProtocol {
    
    // MARK: - Dependencies:
    weak var dataProvider: DataProviderProtocol?
    
    private var dateFormatter: DateFormatterProtocol?
    
    // MARK: - Constants and Variables:
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
    deinit {
        notificationToken?.invalidate()
    }
    
    // MARK: - Public Methods:
    func saveData(from task: Task) {
        let realmManager = try! Realm()
                
        do {
            try realmManager.write {
                let realmTask = TaskObject(from: task)
                realmManager.add(realmTask)
            }
        } catch let error {
            print(error.localizedDescription)
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
    }
    
    func delete(_ task: Task) {
        let realmManager = try! Realm()
        
        do {
            try realmManager.write {
                if let object = realmManager.object(ofType: TaskObject.self, forPrimaryKey: task.id) {
                    deletedTask = task
                    realmManager.delete(object)
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
        let realmManager = try! Realm()
        
        let generalTasks = realmManager.objects(TaskObject.self)
        let currentTasks = generalTasks.where { $0.startDate == date }
        tasks = generalTasks
        return currentTasks
    }
    
    private func sentUpdation(from object: TaskObject) {
        let decoder = JSONDecoder()
        
        do {
            let task = try decoder.decode(Task.self, from: object.data)
            dataProvider?.setupUpdated(task)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

import Foundation
import RealmSwift

final class RealmManager: DatabaseManagerProtocol {
    
    // MARK: - Dependencies:
    weak var dataProvider: DataProviderProtocol?
    
    private var dateFormatterService: DateFormatterProtocol?
    
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
        dateFormatterService = DateFormatterService()
        
        guard let realm,
              let dateFormatterService else { return }
        
        realm.writeAsync {
            let realmTask = TaskObject(from: task, with: dateFormatterService)
            realm.add(realmTask)
        }
    }
    
    func fetchData(with date: Date, completion: @escaping (Result<[Task], Error>) -> Void) {
        dateFormatterService = DateFormatterService()
        
        let realmDate = dateFormatterService?.getRealmDateFormat(from: date) ?? ""
        var tasks = [Task]()

        if let objects = self.fetchRealmData(with: realmDate) {
            objects.forEach {
                let task = Task(object: $0, with: self.dateFormatterService ?? DateFormatterService())
                tasks.append(task)
            }
            
            completion(.success(tasks))
        }
        
        dateFormatterService = nil
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
        guard let dateFormatterService else { return }
        let task = Task(object: object, with: dateFormatterService)
        
        dataProvider?.setupUpdated(task)
        self.dateFormatterService = nil
    }
}

// MARK: - Demonstration setup:
extension RealmManager {
    func setupDemonstrationTask() {
        guard let realm else { return }
        dateFormatterService = DateFormatterService()

        func addStart(_ tasks: [TaskObject]) {
            try? realm.write {
                realm.add(tasks)
            }
        }
        
        guard let dateFormatterService else { return }
        var realmTasksArray: [TaskObject] = []
        
        let firstTaskStartDate = dateFormatterService.getDemonstrationUnixValue(with: 9)
        let firstTask = Task(id: UUID(), startDate: firstTaskStartDate, calendarDate: nil, name: L10n.Demonstration.FirstTask.title,
                             description: L10n.Demonstration.FirstTask.message)
        
        let secondTaskStartDate = dateFormatterService.getDemonstrationUnixValue(with: 9)
        let secondTask = Task(id: UUID(), startDate: secondTaskStartDate, calendarDate: nil, name: L10n.Demonstration.SecondTask.title,
                              description: L10n.Demonstration.SecondTask.message)
        
        let thirdTaskStartDate = dateFormatterService.getDemonstrationUnixValue(with: 11)
        let thirdTask = Task(id: UUID(), startDate: thirdTaskStartDate, calendarDate: nil, name: L10n.Demonstration.ThirdTask.title,
                             description: L10n.Demonstration.ThirdTask.message)
        
        let fourthTaskStartDate = dateFormatterService.getDemonstrationUnixValue(with: 15)
        let fourthTask = Task(id: UUID(), startDate: fourthTaskStartDate, calendarDate: nil, name: L10n.Demonstration.FourthTask.title,
                              description: L10n.Demonstration.FourthTask.message)
        
        let fifthTaskStartDate = dateFormatterService.getDemonstrationUnixValue(with: 19)
        let fifthTask = Task(id: UUID(), startDate: fifthTaskStartDate, calendarDate: nil, name: L10n.Demonstration.FifthTask.title,
                             description: L10n.Demonstration.FifthTask.message)
        
        let sixTaskStartDate = dateFormatterService.getDemonstrationUnixValue(with: 21)
        let sixTask = Task(id: UUID(), startDate: sixTaskStartDate, calendarDate: nil, name: L10n.Demonstration.SixTask.title,
                           description: L10n.Demonstration.SixTask.message)
        
        [firstTask, secondTask, thirdTask, fourthTask, fifthTask, sixTask].forEach {
            realmTasksArray.append(TaskObject(from: $0, with: dateFormatterService))
        }
        
        addStart(realmTasksArray)
        self.dateFormatterService = nil
    }
}

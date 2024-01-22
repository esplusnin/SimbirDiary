import Foundation

final class DataProvider: DataProviderProtocol {
    
    // MARK: - Dependencies:
    private let databaseManager: DatabaseManagerProtocol
    
    // MARK: - Constants and Variables:
    private(set) var isTaskDeleted = false
    
    // MARK: - Observable Values:
    var updatedTasksObservable: Observable<[Task]?> {
        $updatedTasks
    }
    
    @Observable private var updatedTasks: [Task]?
    
    // MARK: - Lifecycle:
    init(databaseManager: DatabaseManagerProtocol) {
        self.databaseManager = databaseManager
        self.databaseManager.setupDataProvider(self)
    }
    
    // MARK: - Publc Methods:
    func addNew(task: Task) {
        isTaskDeleted = false
        try? databaseManager.saveData(from: task)
    }
    
    func fetchData(with date: Date, completion: @escaping (Result<[Task], Error>) -> Void) {
        databaseManager.fetchData(with: date) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let tasks):
                self.isTaskDeleted = false
                completion(.success(tasks))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func setupUpdated(_ tasks: [Task]) {
        updatedTasks = tasks
    }
    
    func delete(_ task: Task) {
        isTaskDeleted = true
        databaseManager.delete(task)
    }
}

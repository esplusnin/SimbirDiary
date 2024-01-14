import Foundation

final class DataProvider: DataProviderProtocol {
    
    // MARK: - Dependencies:
    private let databaseManager: DatabaseManagerProtocol
    
    // MARK: - Constants and Variables:
    private(set) var isTaskDeleted = false
    
    // MARK: - Observable Values:
    var updatedTaskObservable: Observable<Task?> {
        $updatedTask
    }
    
    @Observable private var updatedTask: Task?
    
    // MARK: - Lifecycle:
    init(databaseManager: DatabaseManagerProtocol) {
        self.databaseManager = databaseManager
        self.databaseManager.setupDataProvider(self)
    }
    
    // MARK: - Publc Methods:
    func addNew(task: Task) {
        isTaskDeleted = false
        databaseManager.saveData(from: task)
    }
    
    func fetchData(completion: @escaping (Result<[Task], Error>) -> Void) {
        databaseManager.fetchData { result in
            switch result {
            case .success(let tasks):
                completion(.success(tasks))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func setupUpdated(_ task: Task) {
        updatedTask = task
    }
    
    func delete(_ task: Task) {
        isTaskDeleted = true
        databaseManager.delete(task)
    }
}

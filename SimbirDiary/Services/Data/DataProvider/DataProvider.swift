import Foundation

final class DataProvider: DataProviderProtocol {
    
    // MARK: - Dependencies:
    private let databaseManager: DatabaseManagerProtocol
    
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
    
    func addNew(task: Task) {
        databaseManager.saveData(from: task)
    }
    
    func setupUpdated(_ task: Task) {
        updatedTask = task
    }
}

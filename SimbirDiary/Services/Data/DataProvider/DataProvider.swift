import Foundation

final class DataProvider: DataProviderProtocol {
        
    // MARK: - Dependencies:
    private let databaseManager: DatabaseManagerProtocol
    
    // MARK: - Constants and Variables:
    private var tasks = [Task]() {
        didSet {
            
        }
    }
    
    // MARK: - Lifecycle:
    init(databaseManager: DatabaseManagerProtocol) {
        self.databaseManager = databaseManager
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
}

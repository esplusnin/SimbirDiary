import Foundation
@testable import SimbirDiary

final class DatabaseManagerStumb: DatabaseManagerProtocol {
    
    // MARK: - Dependencies:
    weak var dataProvider: DataProviderProtocol?
    
    // MARK: - Constants and Variables:
    private(set) var isTaskAdded = false
    
    // MARK: - Public Methods:
    func saveData(from task: Task) throws {
        isTaskAdded.toggle()
    }
    
    func fetchData(with date: Date, completion: @escaping (Result<[Task], Error>) -> Void) {
        completion(.success([Task(id: UUID(), startDate: "", calendarDate: "", name: "", description: "")]))
    }
    
    func delete(_ task: Task) {
        
    }
    
    func setupDataProvider(_ provider: DataProviderProtocol) {
        dataProvider = provider
        sentUpdation()
    }
    
    func setupDemonstrationTask() {
        
    }
    
    // MARK: - Private Methods:
    private func sentUpdation() {
        let task = Task(id: UUID(), startDate: "", calendarDate: "", name: "testName", description: "")
        dataProvider?.setupUpdated([task])
    }
}

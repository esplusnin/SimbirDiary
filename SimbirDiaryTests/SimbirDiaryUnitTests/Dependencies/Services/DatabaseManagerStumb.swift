import Foundation
@testable import SimbirDiary

final class DatabaseManagerStumb: DatabaseManagerProtocol {
    func saveData(from task: SimbirDiary.Task) throws {
        
    }
    
    func fetchData(with date: Date, completion: @escaping (Result<[SimbirDiary.Task], Error>) -> Void) {
        
    }
    
    func delete(_ task: SimbirDiary.Task) {
        
    }
    
    func setupDataProvider(_ provider: SimbirDiary.DataProviderProtocol) {
        
    }
    
    func setupDemonstrationTask() {
        
    }
}

import Foundation
@testable import SimbirDiary

final class DataProviderStumb: DataProviderProtocol {
    
    // MARK: - Constants and Variables:
    var isTaskDeleted = false
    
    // MARK: - Observable Values:
    var updatedTaskObservable: Observable<SimbirDiary.Task?> {
        $updatedTask
    }
    
    @SimbirDiary.Observable
    private var updatedTask: Task?
    
    // MARK: - Public Methods:
    func addNew(task: SimbirDiary.Task) {
        
    }
    
    func fetchData(with date: Date, completion: @escaping (Result<[SimbirDiary.Task], Error>) -> Void) {
        
    }
    
    func setupUpdated(_ task: SimbirDiary.Task) {
        
    }
    
    func delete(_ task: SimbirDiary.Task) {
        
    }
}

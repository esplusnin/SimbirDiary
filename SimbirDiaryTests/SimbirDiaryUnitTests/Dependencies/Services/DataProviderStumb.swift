import Foundation
@testable import SimbirDiary

final class DataProviderStumb: DataProviderProtocol {
    
    // MARK: - Constants and Variables:
    var isTaskDeleted = false
    
    private var testTask: Task
    
    // MARK: - Observable Values:
    var updatedTaskObservable: Observable<SimbirDiary.Task?> {
        $updatedTask
    }
    
    @SimbirDiary.Observable
    private var updatedTask: Task?
    
    // MARK: - Lifecycle:
    init() {
        let unixDate = DateFormatterService().getUnixValueString(from: Date(), and: Date())
        
        testTask = Task(id: UUID(uuidString: "TEST") ?? UUID(),
                    startDate: unixDate,
                    calendarDate: "testCalendarDate",
                    name: "testName",
                    description: "testDescription")
    }
    
    // MARK: - Public Methods:
    func addNew(task: SimbirDiary.Task) {
        
    }
    
    func fetchData(with date: Date, completion: @escaping (Result<[SimbirDiary.Task], Error>) -> Void) {
        completion(.success([testTask]))
    }
    
    func setupUpdated(_ task: SimbirDiary.Task) {
        updatedTask = testTask
    }
    
    func delete(_ task: SimbirDiary.Task) {
        
    }
}

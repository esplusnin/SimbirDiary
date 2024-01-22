import Foundation
@testable import SimbirDiary

final class DataProviderStumb: DataProviderProtocol {
    
    // MARK: - Constants and Variables:
    var isTaskDeleted = false
    var addedTask: Task?
    
    private var testTask: [Task]
    
    // MARK: - Observable Values:
    var updatedTasksObservable: Observable<[Task]?> {
        $updatedTask
    }
    
    @SimbirDiary.Observable
    private var updatedTask: [Task]?
    
    // MARK: - Lifecycle:
    init() {
        let unixDate = DateFormatterService().getUnixValueString(from: Date(), and: Date())
        
        testTask = [Task(id: UUID(uuidString: "TEST") ?? UUID(),
                    startDate: unixDate,
                    calendarDate: "testCalendarDate",
                    name: "testName",
                    description: "testDescription")]
    }
    
    // MARK: - Public Methods:
    func addNew(task: Task) {
        addedTask = task
    }
    
    func fetchData(with date: Date, completion: @escaping (Result<[Task], Error>) -> Void) {
        completion(.success(testTask))
    }
    
    func setupUpdated(_ tasks: [Task]) {
        updatedTask = testTask
    }
    
    func delete(_ task: Task) {
        isTaskDeleted.toggle()
    }
}

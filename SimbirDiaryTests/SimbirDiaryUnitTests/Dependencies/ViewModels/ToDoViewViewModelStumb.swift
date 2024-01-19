import Foundation
@testable import SimbirDiary

final class ToDoViewViewModelStumb: ToDoViewViewModelProtocol {
    
    // MARK: - Dependencies:
    var dataProvider: DataProviderProtocol
    
    // MARK: - Constants and Variables:
    var currentDateDidChange = false
    
    var currentDate: Date?
    private(set) var baseTasksList: [TimeBlock] = []
    
    // MARK: - Observable VAlues:
    var tasksListObservable: Observable<[TimeBlock]> {
        $tasksList
    }
    
    @SimbirDiary.Observable
    private(set) var tasksList: [TimeBlock] = []
    
    // MARK: - Lifecycle:
    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    // MARK: - Public Methods:
    func setupDate(from date: Date) {
        currentDate = Date()
    }
    
    func setupNewElementInTaskList() {
        tasksList.append(TimeBlock(name: "TestName", tasks: [Task(id: UUID(),
                                                                  startDate: "testStartDate",
                                                                  calendarDate: "testCalendarDate",
                                                                  name: "testName",
                                                                  description: "testDescription")]))
    }
}
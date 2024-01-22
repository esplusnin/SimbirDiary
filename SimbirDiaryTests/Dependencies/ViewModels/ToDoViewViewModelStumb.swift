import Foundation
@testable import SimbirDiary

final class ToDoViewViewModelStumb: ToDoViewViewModelProtocol {
    
    // MARK: - Dependencies:
    var dataProvider: DataProviderProtocol
    
    // MARK: - Constants and Variables:
    var currentDateDidChange = false
    
    var currentDate: Date?
    private(set) var baseTasksList: [TimeBlock] = [
        TimeBlock(name: Resources.TimeBlocks.zero, tasks: []), TimeBlock(name: Resources.TimeBlocks.one, tasks: []),
        TimeBlock(name: Resources.TimeBlocks.two, tasks: []), TimeBlock(name: Resources.TimeBlocks.three, tasks: []),
        TimeBlock(name: Resources.TimeBlocks.four, tasks: []), TimeBlock(name: Resources.TimeBlocks.five, tasks: []),
        TimeBlock(name: Resources.TimeBlocks.six, tasks: []), TimeBlock(name: Resources.TimeBlocks.seven, tasks: []),
        TimeBlock(name: Resources.TimeBlocks.eight, tasks: []), TimeBlock(name: Resources.TimeBlocks.nine, tasks: []),
        TimeBlock(name: Resources.TimeBlocks.ten, tasks: []), TimeBlock(name: Resources.TimeBlocks.eleven, tasks: []),
        TimeBlock(name: Resources.TimeBlocks.twelve, tasks: []), TimeBlock(name: Resources.TimeBlocks.thirteen, tasks: []),
        TimeBlock(name: Resources.TimeBlocks.fourteen, tasks: []), TimeBlock(name: Resources.TimeBlocks.fifteen, tasks: []),
        TimeBlock(name: Resources.TimeBlocks.sixteen, tasks: []), TimeBlock(name: Resources.TimeBlocks.seventeen, tasks: []),
        TimeBlock(name: Resources.TimeBlocks.eighteen, tasks: []), TimeBlock(name: Resources.TimeBlocks.nineteen, tasks: []),
        TimeBlock(name: Resources.TimeBlocks.twenty, tasks: []), TimeBlock(name: Resources.TimeBlocks.twentyOne, tasks: []),
        TimeBlock(name: Resources.TimeBlocks.twentyTwo, tasks: []),TimeBlock(name: Resources.TimeBlocks.twentyThree, tasks: [])
    ]
    
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

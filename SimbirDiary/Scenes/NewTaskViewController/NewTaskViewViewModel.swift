import Foundation

final class NewTaskViewViewModel: NewTaskViewViewModelProtocol {
    
    // MARK: - Dependencies:
    private let dataProvider: DataProviderProtocol
    
    // MARK: - Constants and Variables:
    private var name: String? {
        didSet {
            checkIsReadyToAddNewTask()
        }
    }
    
    private var description: String? {
        didSet {
            checkIsReadyToAddNewTask()
        }
    }
    
    private var date: Date?
    private var time: Date?
    private(set) var defaultDate: Date

    // MARK: - Observable Values:
    var isReadyToAddNewTaskObservable: Observable<Bool> {
        $isReadyToAddNewTask
    }
    
    @Observable private var isReadyToAddNewTask = false
    
    // MARK: - Lifecycle:
    init(dataProvider: DataProviderProtocol, defaultDate: Date) {
        self.defaultDate = defaultDate
        self.dataProvider = dataProvider
    }
    
    // MARK: - Public Methods:
    func setupTaskDate(from type: NewTaskCellType, with value: Date) {
        if type == .date {
            date = value
        } else {
            time = value
        }
    }
    
    func setupTaskInfo(isName: Bool, value: String) {
        if isName {
            name = value == "" ? nil : value
        } else {
            description = value == "" ? nil : value
        }
    }
    
    func addNewTask() {
        guard let name = name,
              let description = description else { return }

        let datesUnixString = DateFormatterService().getUnixValueString(from: date ?? defaultDate, and: time ?? defaultDate)
        dataProvider.addNew(task: Task(id: UUID(),
                                       startDate: datesUnixString,
                                       calendarDate: nil,
                                       name: name,
                                       description: description))
    }
    
    // MARK: - Private Methods:
    private func checkIsReadyToAddNewTask() {
        if name != nil &&  name != "",
           description != nil && description != "" {
            isReadyToAddNewTask = true
        } else {
            isReadyToAddNewTask = false
        }
    }
}

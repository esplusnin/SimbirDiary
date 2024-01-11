import Foundation

final class NewTaskViewViewModel: NewTaskViewViewModelProtocol {
    
    // MARK: - Dependencies:
    private let dataProvider: DataProviderProtocol
    private var dateFormatterService: DateFormatterService?
    
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
    
    private var date: Date? {
        didSet {
            // TODO: баг с датой
            checkIsReadyToAddNewTask()
        }
    }
    
    private var time: Date? {
        didSet {
            checkIsReadyToAddNewTask()
        }
    }
    // MARK: - Observable Values:
    var isReadyToAddNewTaskObservable: Observable<Bool> {
        $isReadyToAddNewTask
    }
    
    @Observable private var isReadyToAddNewTask = false
    
    // MARK: - Lifecycle:
    init(dataProvider: DataProviderProtocol) {
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
        dateFormatterService = DateFormatterService()
        
        guard let dateFormatterService,
              let name = name,
              let description = description else { return }
         
        let datesUnixString = dateFormatterService.getUnixValueString(from: date ?? Date(), and: time ?? Date())
        dataProvider.addNew(task: Task(id: UUID(),
                                       dateStart: datesUnixString,
                                       name: name,
                                       description: description))
    }
    
    // MARK: - Private Methods:
    private func checkIsReadyToAddNewTask() {
        if name != nil,
           description != nil {
            isReadyToAddNewTask = true
        } else {
            isReadyToAddNewTask = false
        }
    }
}

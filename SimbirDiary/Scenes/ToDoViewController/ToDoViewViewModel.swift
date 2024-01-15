import Foundation

final class ToDoViewViewModel: ToDoViewViewModelProtocol {
    
    // MARK: - Dependencies:
    private(set) var dataProvider: DataProviderProtocol
    private var dateFormatterService: DateFormatterProtocol?
    
    // MARK: - Constants and Variables:
    private(set) var isUpdateEntireTableView = true
    private(set) var currentDateDidChange = false
    private(set) var indexPathToUpdate: IndexPath?
    
    private let baseTasksList =  [
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
    
    private var currentDate: Date? {
        didSet {
            setupBaseTaskList()
            currentDateDidChange = true
            fetchData()
        }
    }
    
    // MARK: - Observable Values:
    var tasksListObservable: Observable<[TimeBlock]> {
        $tasksList
    }
    
    @Observable
    private(set) var tasksList = [TimeBlock]()
    
    // MARK: - Lifecycle
    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
        self.bind()
    }
    
    // MARK: - Public Methods:
    func bind() {
        dataProvider.updatedTaskObservable.bind { [weak self] task in
            guard let self,
                  let task else { return }
            self.distribute([task])
        }
    }
    
    func setupDate(from date: Date) {
        currentDate = date
    }
    
    func fetchData() {
        guard let currentDate else { return }
        
        dataProvider.fetchData(with: currentDate) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let tasks):
                self.distribute(tasks)
                self.isUpdateEntireTableView = false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Private Methods:
    private func setupBaseTaskList() {
        tasksList = baseTasksList
    }
    
    private func distribute(_ tasks: [Task]) {
        var newTaskList = tasksList
        
        dateFormatterService = DateFormatterService()

        if dataProvider.isTaskDeleted {
            guard let task = tasks.first else { return }
            deleteRows(with: task , from: &newTaskList)
        } else {
            tasks.forEach { task in
                insertNew(task, to: &newTaskList)
            }
        }
        
        dateFormatterService = nil
        tasksList = newTaskList
        currentDateDidChange = false
    }
    
    private func insertNew(_ task: Task, to list: inout [TimeBlock]) {
        let fullHourCode = getFullHourCode(from: task)
        
        for (index, timezone) in list.enumerated() where timezone.name == fullHourCode {
            var newTasks = timezone.tasks
            newTasks.append(task)
            newTasks.sort()
            list[index].tasks = newTasks
        }
        
        if isUpdateEntireTableView == false {
            guard let indexPath = defineIndexPath(for: task, with: fullHourCode, from: list) else { return }
            indexPathToUpdate = indexPath
        }
    }
    
    private func deleteRows(with task: Task, from list: inout [TimeBlock]) {
        let fullHourCode = getFullHourCode(from: task)
        if let indexPath = defineIndexPath(for: task, with: fullHourCode, from: tasksList) {
            indexPathToUpdate = indexPath
            list[indexPath.section].tasks.remove(at: indexPath.row)
        }
    }
    
    private func defineIndexPath(for task: Task, with code: String, from list: [TimeBlock]) -> IndexPath? {
        guard let section = list.firstIndex(where: { $0.name == code }),
              let row = list[section].tasks.firstIndex(where: { $0.id == task.id })  else { return nil }
        return IndexPath(row: row, section: section)
    }

    private func getFullHourCode(from task: Task) -> String {
        let hourValue = dateFormatterService?.getTimeValue(from: task.dateStart, isOnlyHours: true) ?? ""
        let hourFullCode = hourValue + Resources.TimeBlocks.hourCode
        return hourFullCode
    }
}

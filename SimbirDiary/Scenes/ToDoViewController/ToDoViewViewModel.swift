import Foundation

final class ToDoViewViewModel: ToDoViewViewModelProtocol {
    
    // MARK: - Dependencies:
    private(set) var dataProvider: DataProviderProtocol
    private var dateFormatterService: DateFormatterProtocol?
    
    // MARK: - Constants and Variables:
    private(set) var currentDateDidChange = false
    
    private(set) var baseTasksList =  [
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
            tasksList = []
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
    func setupDate(from date: Date) {
        currentDate = date
    }
    
    // MARK: - Private Methods:
    func bind() {
        dataProvider.updatedTaskObservable.bind { [weak self] task in
            guard let self,
                  let task else { return }
            self.distribute([task])
        }
    }
    
    private func fetchData() {
        guard let currentDate else { return }
        
        dataProvider.fetchData(with: currentDate) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let tasks):
                self.distribute(tasks)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
        
        newTaskList.sort()
        tasksList = newTaskList

        dateFormatterService = nil
        currentDateDidChange = false
    }
    
    private func insertNew(_ task: Task, to list: inout [TimeBlock]) {
        guard let currentDate,
        let dateFormatterService else { return }
        let fullHourCode = getFullHourCode(from: task)
        let isTheSameDate = dateFormatterService.isTheSamedDay(currentDate: currentDate, taskDate: task.startDate)
        
        if isTheSameDate {
            if let index = list.firstIndex(where: { $0.name == fullHourCode }) {
                var newTasks = list[index].tasks
                newTasks.append(task)
                newTasks.sort()
                list[index].tasks = newTasks
            } else {
                guard var newTasks = baseTasksList.first(where: { $0.name == fullHourCode }) else { return }
                newTasks.tasks.append(task)
                list.append(newTasks)
            }
        }
    }
    
    private func deleteRows(with task: Task, from list: inout [TimeBlock]) {
        let fullHourCode = getFullHourCode(from: task)
        if let indexPath = defineIndexPath(for: task, with: fullHourCode, from: tasksList) {
            list[indexPath.section].tasks.remove(at: indexPath.row)
            
            if list[indexPath.section].tasks.isEmpty {
                list.remove(at: indexPath.section)
            }
        }
    }
    
    // MARK: - Helpers:
    private func defineIndexPath(for task: Task, with code: String, from list: [TimeBlock]) -> IndexPath? {
        guard let section = list.firstIndex(where: { $0.name == code }),
              let row = list[section].tasks.firstIndex(where: { $0.id == task.id })  else { return nil }
        return IndexPath(row: row, section: section)
    }
    
    private func getFullHourCode(from task: Task) -> String {
        let hourValue = dateFormatterService?.getTimeValue(from: task.startDate, isOnlyHours: true) ?? ""
        let hourFullCode = hourValue + Resources.TimeBlocks.hourCode
        return hourFullCode
    }
}

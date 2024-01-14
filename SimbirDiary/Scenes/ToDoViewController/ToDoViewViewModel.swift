import Foundation

final class ToDoViewViewModel: ToDoViewViewModelProtocol {    
    
    // MARK: - Dependencies:
    private(set) var dataProvider: DataProviderProtocol
    private var dateFormatterService: DateFormatterProtocol?
    
    // MARK: - Constants and Variables:
    private var currentDate: Date? {
        didSet {
            fetchData()
        }
    }
    
    // MARK: - Observable Values:
    var tasksListObservable: Observable<[TimeBlock]> {
        $tasksList
    }
    
    var isUpdateEntireTableViewObservable: Observable<Bool> {
        $isUpdateEntireTableView
    }
    
    @Observable
    private(set) var tasksList = [
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
    
    @Observable private var isUpdateEntireTableView = true
    
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
        dataProvider.fetchData { [weak self] result in
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
    private func distribute(_ tasks: [Task]) {
        var newTaskList = tasksList
        dateFormatterService = DateFormatterService()

        tasks.forEach { task in
            let fullHourCode = getFullHourCode(from: task)
            for (index, timezone) in newTaskList.enumerated() where timezone.name == fullHourCode {
                var newTasks = timezone.tasks
                newTasks.append(task)
                newTasks.sort()
                newTaskList[index].tasks = newTasks
            }
        }
        
        dateFormatterService = nil
        tasksList = newTaskList
    }
    
    private func getFullHourCode(from task: Task) -> String {
        let hourValue = dateFormatterService?.getTimeValue(from: task.dateStart, isOnlyHours: true) ?? ""
        let hourFullCode = hourValue + Resources.TimeBlocks.hourCode
        return hourFullCode
    }
}

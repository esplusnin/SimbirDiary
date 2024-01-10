import Foundation

final class ToDoViewViewModel: ToDoViewViewModelProtocol {
    
    // MARK: - Dependencies:
    private let dataProvider: DataProviderProtocol
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
    
    @Observable
    private var tasksList = [
        TimeBlock(name: Resources.TimeBlocks.zero, tasks: []), TimeBlock(name: Resources.TimeBlocks.one, tasks: []),
        TimeBlock(name: Resources.TimeBlocks.two, tasks: []), TimeBlock(name: Resources.TimeBlocks.three, tasks: []), TimeBlock(name: Resources.TimeBlocks.four, tasks: []),
        TimeBlock(name: Resources.TimeBlocks.five, tasks: []), TimeBlock(name: Resources.TimeBlocks.six, tasks: []),
        TimeBlock(name: Resources.TimeBlocks.seven, tasks: []), TimeBlock(name: Resources.TimeBlocks.eight, tasks: []),
        TimeBlock(name: Resources.TimeBlocks.nine, tasks: []), TimeBlock(name: Resources.TimeBlocks.ten, tasks: []),
        TimeBlock(name: Resources.TimeBlocks.eleven, tasks: []), TimeBlock(name: Resources.TimeBlocks.twelve, tasks: []),
        TimeBlock(name: Resources.TimeBlocks.thirteen, tasks: []), TimeBlock(name: Resources.TimeBlocks.fourteen, tasks: []),
        TimeBlock(name: Resources.TimeBlocks.fifteen, tasks: []), TimeBlock(name: Resources.TimeBlocks.sixteen, tasks: []),
        TimeBlock(name: Resources.TimeBlocks.seventeen, tasks: []), TimeBlock(name: Resources.TimeBlocks.eighteen, tasks: []),
        TimeBlock(name: Resources.TimeBlocks.nineteen, tasks: []), TimeBlock(name: Resources.TimeBlocks.twenty, tasks: []),
        TimeBlock(name: Resources.TimeBlocks.twentyOne, tasks: []), TimeBlock(name: Resources.TimeBlocks.twentyTwo, tasks: []),
        TimeBlock(name: Resources.TimeBlocks.twentyThree, tasks: [])
    ]
    
    // MARK: - Lifecycle
    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    // MARK: - Public Methods:
    func setupDate(from date: Date) {
        currentDate = date
    }
    
    func fetchData() {
        dataProvider.fetchData { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let tasks):
                self.distribute(tasks)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Private Methods:
    private func distribute(_ tasks: [Task]) {
        dateFormatterService = DateFormatterService()
        var newTaskList = tasksList
        
        tasks.forEach { task in
            let hourValue = dateFormatterService?.getHourValue(from: task.dateStart) ?? ""
            let hourFullCode = hourValue + Resources.TimeBlocks.hourCode
            
            for (index, timezone) in newTaskList.enumerated() where timezone.name == hourFullCode {
                var newTasks = timezone.tasks
                newTasks.append(task)
                newTasks.sort()
                newTaskList[index].tasks = newTasks
            }
        }
        
        tasksList = newTaskList
    }
}

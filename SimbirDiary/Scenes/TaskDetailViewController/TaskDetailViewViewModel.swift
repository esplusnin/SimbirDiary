import Foundation

final class TaskDetailViewViewModel: TaskDetailViewViewModelProtocol {
    
    // MARK: - Dependencies:
    private let dataProvider: DataProviderProtocol
    
    // MARK: - Constants and Variables:
    private(set) var task: Task
    
    // MARK: - Lifecycle:
    init(dataProvider: DataProviderProtocol, task: Task) {
        self.dataProvider = dataProvider
        self.task = task
    }
    
    // MARK: - Public Methods:
    func deleteTask() {
        dataProvider.delete(task)
    }
}

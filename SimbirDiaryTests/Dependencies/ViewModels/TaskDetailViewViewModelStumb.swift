import Foundation
@testable import SimbirDiary

final class TaskDetailViewViewModelStumb: TaskDetailViewViewModelProtocol {
    
    // MARK: - Dependencies:
    private let dataProvider: DataProviderProtocol
    
    // MARK: - Constants and Variables:
    var task: Task
    var isTaskDeleted = false
    
    // MARK: - Lifecycle:
    init(dataProvider: DataProviderProtocol, task: Task) {
        self.dataProvider = dataProvider
        self.task = task
    }
    
    // MARK: - Public Methods:
    func deleteTask() {
        isTaskDeleted.toggle()
    }
}

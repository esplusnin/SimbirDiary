import Foundation
@testable import SimbirDiary

final class NewTaskViewViewModelStumb: NewTaskViewViewModelProtocol {
    
    // MARK: - Dependencies:
    private var dataProvider: DataProviderProtocol
    
    // MARK: - COonstants and Variables:
    var defaultDate: Date

    // MARK: - Observable Values:
    var isNewTaskAdded = false
    
    var isReadyToAddNewTaskObservable: Observable<Bool> {
        $isReadyToAddNewTask
    }
    
    @SimbirDiary.Observable
    private(set) var isReadyToAddNewTask = false
    
    // MARK: - Lifecycle:
    init(dataProvider: DataProviderProtocol, defaultDate: Date) {
        self.dataProvider = dataProvider
        self.defaultDate = defaultDate
    }
    
    // MARK: - Public Methods:
    func setupTaskDate(from type: NewTaskCellType, with value: Date) {
        
    }
    
    func setupTaskInfo(isName: Bool, value: String) {
        
    }
    
    func addNewTask() {
        isNewTaskAdded.toggle()
    }
}

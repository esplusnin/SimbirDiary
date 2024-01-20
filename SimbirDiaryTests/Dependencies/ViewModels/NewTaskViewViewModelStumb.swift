import Foundation
@testable import SimbirDiary

final class NewTaskViewViewModelStumb: NewTaskViewViewModelProtocol {
    
    // MARK: - Dependencies:
    private var dataProvider: DataProviderProtocol
    
    // MARK: - Observable Values:
    var isNewTaskAdded = false
    
    var isReadyToAddNewTaskObservable: SimbirDiary.Observable<Bool> {
        $isReadyToAddNewTask
    }
    
    @SimbirDiary.Observable
    private(set) var isReadyToAddNewTask = false
    
    // MARK: - Lifecycle:
    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    // MARK: - Public Methods:
    func setupTaskDate(from type: SimbirDiary.NewTaskCellType, with value: Date) {
        
    }
    
    func setupTaskInfo(isName: Bool, value: String) {
        
    }
    
    func addNewTask() {
        isNewTaskAdded.toggle()
    }
}

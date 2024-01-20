import Foundation

protocol NewTaskViewViewModelProtocol: AnyObject {
    var defaultDate: Date { get }
    var isReadyToAddNewTaskObservable: Observable<Bool> { get }
    func setupTaskDate(from type: NewTaskCellType, with value: Date)
    func setupTaskInfo(isName: Bool, value: String)
    func addNewTask()
}

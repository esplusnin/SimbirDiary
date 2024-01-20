import Foundation

protocol ToDoViewViewModelProtocol: AnyObject {
    var dataProvider: DataProviderProtocol { get }
    var currentDateDidChange: Bool { get }
    var currentDate: Date? { get }
    var baseTasksList: [TimeBlock] { get }
    var tasksListObservable: Observable<[TimeBlock]> { get }
    var tasksList: [TimeBlock] { get }
    func setupDate(from date: Date)
}

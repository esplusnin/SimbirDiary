import Foundation

protocol ToDoViewViewModelProtocol: AnyObject {
    var dataProvider: DataProviderProtocol { get }
    var isUpdateEntireTableView: Bool { get }
    var indexPathToUpdate: IndexPath? { get }
    var tasksListObservable: Observable<[TimeBlock]> { get }
    var tasksList: [TimeBlock] { get }
    func setupDate(from date: Date)
}

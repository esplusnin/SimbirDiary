import Foundation

protocol ToDoViewViewModelProtocol: AnyObject {
    var dataProvider: DataProviderProtocol { get }
    var tasksListObservable: Observable<[TimeBlock]> { get }
    var tasksList: [TimeBlock] { get }
    var isUpdateEntireTableViewObservable: Observable<Bool> { get }
    var numberOfCellToUpdateObservable: Observable<Int?> { get }
    func setupDate(from date: Date)
}

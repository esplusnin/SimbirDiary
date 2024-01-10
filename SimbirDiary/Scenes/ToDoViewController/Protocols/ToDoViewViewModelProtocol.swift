import Foundation

protocol ToDoViewViewModelProtocol: AnyObject {
    var tasksListObservable: Observable<[TimeBlock]> { get }
    func setupDate(from date: Date)
}

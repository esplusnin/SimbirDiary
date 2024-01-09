import Foundation

protocol ToDoViewViewModelProtocol: AnyObject {
    var tasksObservable: Observable<[TimeBlock]> { get }
    func setupDate(from date: Date)
}

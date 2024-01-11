import Foundation

protocol DataProviderProtocol: AnyObject {
    var updatedTaskObservable: Observable<Task?> { get }
    func fetchData(completion: @escaping (Result<[Task], Error>) -> Void)
    func addNew(task: Task)
    func setupUpdated(_ task: Task)
}

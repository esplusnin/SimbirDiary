import Foundation

protocol DataProviderProtocol: AnyObject {
    var isTaskDeleted: Bool { get }
    var updatedTaskObservable: Observable<Task?> { get }
    func addNew(task: Task)
    func fetchData(with date: Date, completion: @escaping (Result<[Task], Error>) -> Void)
    func setupUpdated(_ task: Task)
    func delete(_ task: Task)
}

import Foundation

protocol DatabaseManagerProtocol: AnyObject {
    func saveData(from task: Task)
    func fetchData(completion: @escaping (Result<[Task], Error>) -> Void)
    func delete(_ task: Task)
    func setupDataProvider(_ provider: DataProviderProtocol)
}

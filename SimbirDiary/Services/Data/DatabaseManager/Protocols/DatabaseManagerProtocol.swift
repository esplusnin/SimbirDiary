import Foundation

protocol DatabaseManagerProtocol: AnyObject {
    func saveData(from task: Task)
    func fetchData(completion: @escaping (Result<[Task], Error>) -> Void)
    func setupDataProvider(_ provider: DataProviderProtocol)
}

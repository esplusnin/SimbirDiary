import Foundation

protocol DataProviderProtocol: AnyObject {
    func fetchData(completion: @escaping (Result<[Task], Error>) -> Void)
}

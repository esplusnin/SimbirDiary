import Foundation

protocol TaskDetailViewViewModelProtocol: AnyObject {
    var task: Task { get }
    func deleteTask()
}

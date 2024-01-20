import UIKit

protocol CoordinatorProtocol: AnyObject {
    var navigator: UINavigationController { get set }
    func start()
    func presentNewTaskController(from controller: UIViewController, with date: Date)
    func seeDetailOf(_ task: Task)
    func pop()
    func pop(from controller: UIViewController)
}

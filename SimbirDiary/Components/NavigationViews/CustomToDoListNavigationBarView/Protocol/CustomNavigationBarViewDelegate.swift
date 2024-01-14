import Foundation

protocol CustomToDoListNavigationBarViewDelegate: AnyObject {
    func setupDate(from date: Date)
    func presentNewTaskController()
}

import Foundation

protocol CustomNewTaskInputInfoViewDelegate: AnyObject {
    func setupTaskInfo(isName: Bool, value: String)
    func controlSuperviewHeight(with value: CGFloat)
}

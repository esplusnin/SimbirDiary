import Foundation

protocol CustomNavigationBarViewDelegate: AnyObject {
    func setupDate(from date: Date)
    func goToNewTaskViewController()
}

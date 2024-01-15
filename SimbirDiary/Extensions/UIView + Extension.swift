import UIKit

// MARK: - Adding new subview:
extension UIView {
    func addNewSubview(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}

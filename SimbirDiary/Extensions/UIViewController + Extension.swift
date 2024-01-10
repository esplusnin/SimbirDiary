import UIKit

extension UIViewController {
    // MARK: - Public Methods:
    func addEndEditingGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gesture)
    }
    
    // MARK: - Objc Methods:
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

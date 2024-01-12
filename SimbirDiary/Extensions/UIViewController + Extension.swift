import UIKit

// MARK: - Hiding keyboard:
extension UIViewController {
    // Public Methods:
    func addEndEditingGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gesture)
    }
    
    // Objc Methods:
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Showing Alert:
extension UIViewController {
    // Public Methods:
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        present(alert, animated: true)
    }
}

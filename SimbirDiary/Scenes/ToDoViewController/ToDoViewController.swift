import UIKit

class ToDoViewController: UIViewController {

    // MARK: - Constants and Variables:
    private enum UIConstants {
        static let navigationBarHeight: CGFloat = 120
    }
    
    // MARK: - UI:
    private lazy var customNavigationBarView = CustomNavigationBarView()
    
    // MARK: - Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
}

// MARK: - Setup Views:
extension ToDoViewController {
    private func setupViews() {
        view.add(subview: customNavigationBarView)
    }
}

// MARK: - Setup Constraints:
private extension ToDoViewController {
    func setupConstraints() {
        setupCustomNavigationBarViewConstraints()
    }
    
    func setupCustomNavigationBarViewConstraints() {
        NSLayoutConstraint.activate([
            customNavigationBarView.heightAnchor.constraint(equalToConstant: UIConstants.navigationBarHeight),
            customNavigationBarView.topAnchor.constraint(equalTo: view.topAnchor),
            customNavigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavigationBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        customNavigationBarView.setup()
    }
}

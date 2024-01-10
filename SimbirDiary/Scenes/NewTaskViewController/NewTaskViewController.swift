import UIKit
import SwiftUI

final class NewTaskViewController: UIViewController {
    
    // MARK: - UI:
    private lazy var customNewTaskNavigationView = CustomNewTaskNavigationView()
    
    // MARK: - Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

// MARK: - CustomNewTaskNavigationViewDelegate:
extension NewTaskViewController: CustomNewTaskNavigationViewDelegate {
    func dismiss() {
        dismiss(animated: true)
    }
    
    func addNewTask() {
        
    }
}

// MARK: - Setup Views:
private extension NewTaskViewController {
    func setupViews() {
        view.backgroundColor = .white
        [customNewTaskNavigationView].forEach(view.addNewSubview)
    }
}

// MARK: - Setup Constraints:
private extension NewTaskViewController {
    func setupConstraints() {
        setupCustomNewTaskNavigationViewConstraints()
    }
    
    func setupCustomNewTaskNavigationViewConstraints() {
        NSLayoutConstraint.activate([
            customNewTaskNavigationView.heightAnchor.constraint(equalToConstant: 100),
            customNewTaskNavigationView.topAnchor.constraint(equalTo: view.topAnchor),
            customNewTaskNavigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNewTaskNavigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - Setup Targets:
private extension NewTaskViewController {
    
}

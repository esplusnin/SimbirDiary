import UIKit

class ToDoViewController: UIViewController {

    // MARK: - Constants and Variables:
    private enum UILocalConstants {
        static let navigationBarHeight: CGFloat = 120
    }
    
    // MARK: - UI:
    private lazy var toDoTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Resources.Identifiers.toDoTableViewCell)
        return tableView
    }()
    
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
        [customNavigationBarView, toDoTableView].forEach(view.addNewSubview)
    }
}

// MARK: - Setup Constraints:
private extension ToDoViewController {
    func setupConstraints() {
        setupCustomNavigationBarViewConstraints()
    }
    
    func setupCustomNavigationBarViewConstraints() {
        NSLayoutConstraint.activate([
            customNavigationBarView.heightAnchor.constraint(equalToConstant: UILocalConstants.navigationBarHeight),
            customNavigationBarView.topAnchor.constraint(equalTo: view.topAnchor),
            customNavigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavigationBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        customNavigationBarView.setup()
    }
    
    func setupToDoTableViewConstraints() {
        NSLayoutConstraint.activate([
            toDoTableView.topAnchor.constraint(equalTo: customNavigationBarView.bottomAnchor, constant: UIConstants.baseInset)
        ])
    }
}

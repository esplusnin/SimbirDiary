import UIKit

class ToDoViewController: UIViewController {

    // MARK: - Dependencies:
    private let viewModel: ToDoViewViewModelProtocol
    
    // MARK: - Classes:
    private let tableViewProvider: ToDoViewControllerTableViewProvider
    
    // MARK: - Constants and Variables:
    private enum UILocalConstants {
        static let navigationBarHeight: CGFloat = 120
    }
    
    // MARK: - UI:
    private lazy var toDoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: Resources.Identifiers.toDoTableViewCell)
        tableView.register(ToDoTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: Resources.Identifiers.toDoTableViewHeaderView)
        tableView.dataSource = tableViewProvider
        tableView.delegate = tableViewProvider
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = .init(top: .zero, left: .zero, bottom: .zero, right: .zero)
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var customNavigationBarView = CustomNavigationBarView()
    
    // MARK: - Lifecycle:
    init(viewModel: ToDoViewViewModelProtocol) {
        self.viewModel = viewModel
        self.tableViewProvider = ToDoViewControllerTableViewProvider(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        bind()
    }
    
    // MARK: - Private Methods:
    private func bind() {
        viewModel.tasksListObservable.bind { [weak self] _ in
            guard let self else { return }
            toDoTableView.reloadData()
        }
    }
}

// MARK: - CustomNavigationBarViewDelegate:
extension ToDoViewController: CustomNavigationBarViewDelegate {
    func goToNewTaskViewController() {
        let dataProvider = viewModel.dataProvider
        let newTaskViewModel = NewTaskViewViewModel(dataProvider: dataProvider)
        let viewController = NewTaskViewController(viewModel: newTaskViewModel)
        present(viewController, animated: true)
    }
    
    func setupDate(from date: Date) {
        viewModel.setupDate(from: date)
        dismiss(animated: true)
    }
}

// MARK: - Setup Views:
private extension ToDoViewController {
    func setupViews() {
        addEndEditingGesture()
        customNavigationBarView.delegate = self
        
        [customNavigationBarView, toDoTableView].forEach(view.addNewSubview)
    }
}

// MARK: - Setup Constraints:
private extension ToDoViewController {
    func setupConstraints() {
        setupCustomNavigationBarViewConstraints()
        setupToDoTableViewConstraints()
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
            toDoTableView.topAnchor.constraint(equalTo: customNavigationBarView.bottomAnchor, constant: UIConstants.baseInset),
            toDoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.baseInset),
            toDoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            toDoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.baseInset)
        ])
    }
}

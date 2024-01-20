import UIKit

class ToDoViewController: UIViewController {
    
    // MARK: - Dependencies:
    weak var coordinator: CoordinatorProtocol?
    
    private let viewModel: ToDoViewViewModelProtocol
    
    // MARK: - Classes:
    private let tableViewProvider: ToDoViewControllerTableViewProvider
    
    // MARK: - UI:
    private lazy var toDoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: Resources.Identifiers.toDoTableViewCell)
        tableView.register(ToDoTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: Resources.Identifiers.toDoTableViewHeaderView)
        tableView.dataSource = tableViewProvider
        tableView.delegate = tableViewProvider
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var customNavigationBarView = CustomToDoListNavigationBarView()
    private var toDoListStumbView: ToDoListStumbView?
    
    // MARK: - Lifecycle:
    init(coordinator: CoordinatorProtocol, viewModel: ToDoViewViewModelProtocol) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        self.tableViewProvider = ToDoViewControllerTableViewProvider(coordinator: coordinator, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        tableViewProvider.cellDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        bind()
        controlStumbView()
    }
    
    // MARK: - Private Methods:
    private func bind() {
        viewModel.tasksListObservable.bind { [weak self] _ in
            guard let self else { return }
            DispatchQueue.main.async {
                self.toDoTableView.reloadData()
                self.controlStumbView()
            }
        }
    }
    
    private func controlStumbView() {
        if viewModel.tasksListObservable.wrappedValue.isEmpty && toDoListStumbView == nil {
            toDoListStumbView = ToDoListStumbView { [weak self] in
                guard let self else { return }
                let selectedDate = viewModel.currentDate ?? Date()
                self.coordinator?.presentNewTaskController(from: self, with: selectedDate)
            }
            
            setupToDoListStumbView()
        } else if !viewModel.tasksListObservable.wrappedValue.isEmpty {
            toDoTableView.isHidden = false
            toDoListStumbView?.removeFromSuperview()
            toDoListStumbView = nil
        }
    }
}

// MARK: - CustomNavigationBarViewDelegate:
extension ToDoViewController: CustomToDoListNavigationBarViewDelegate {
    func presentNewTaskController() {
        let selectedDate = viewModel.currentDate ?? Date()
        coordinator?.presentNewTaskController(from: self, with: selectedDate)
    }
    
    func setupDate(from date: Date) {
        viewModel.setupDate(from: date)
        dismiss(animated: true)
    }
}

// MARK: - Setup Views:
private extension ToDoViewController {
    func setupViews() {
        view.backgroundColor = .regularBackgroundLightGray
        navigationController?.setNavigationBarHidden(true, animated: false)
        
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
            customNavigationBarView.heightAnchor.constraint(equalToConstant: UIConstants.navigationBarHeight),
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
    
    func setupToDoListStumbView() {
        guard let toDoListStumbView else { return }
        
        toDoTableView.isHidden = true
        view.addNewSubview(toDoListStumbView)
        
        NSLayoutConstraint.activate([
            toDoListStumbView.topAnchor.constraint(equalTo: customNavigationBarView.bottomAnchor),
            toDoListStumbView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toDoListStumbView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            toDoListStumbView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

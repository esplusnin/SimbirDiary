import UIKit

final class NewTaskViewController: UIViewController {
    
    // MARK: - Dependencies:
    weak var coordinator: AppCoordinator?

    private let viewModel: NewTaskViewViewModelProtocol
    
    // MARK: - Classes:
    private let tableViewDataProvider: NewTaskTableViewDataProvider
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let navigationViewHeight: CGFloat = 60
        static let inputInfoViewHeight: CGFloat = 120
        static let tableViewHeight: CGFloat = 120
        static let separatorInset: CGFloat = 20
    }
    
    // MARK: - UI:
    private lazy var newTaskTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewTaskTableViewDateCell.self, forCellReuseIdentifier: Resources.Identifiers.newTaskTableViewDateCell)
        tableView.dataSource = tableViewDataProvider
        tableView.delegate = tableViewDataProvider
        tableView.layer.cornerRadius = UIConstants.baseCornerRadius
        tableView.separatorInset = .init(top: 0, left: LocalUIConstants.separatorInset, bottom: 0, right: LocalUIConstants.separatorInset)
        return tableView
    }()
    
    private lazy var customNewTaskNavigationView = CustomNewTaskNavigationView()
    private lazy var customNewTaskInputInfoView = CustomNewTaskInputInfoView()
    
    // MARK: - Lifecycle:
    init(viewModel: NewTaskViewViewModelProtocol) {
        self.viewModel = viewModel
        self.tableViewDataProvider = NewTaskTableViewDataProvider()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        bind()
    }
    
    // MARK: - Public Methods:
    func bind() {
        viewModel.isReadyToAddNewTaskObservable.bind { [weak self] result in
            guard let self else { return }
            if result == true {
                DispatchQueue.main.async {
                    self.customNewTaskNavigationView.controlDoneButtonState(isAvailable: true)
                }
            }
        }
    }
}

// MARK: - CustomNewTaskNavigationViewDelegate:
extension NewTaskViewController: CustomNewTaskNavigationViewDelegate {
    func dismiss() {
        coordinator?.pop(from: self)
    }
    
    func addNewTask() {
        viewModel.addNewTask()
        dismiss()
    }
}

// MARK: - CustomNewTaskInputInfoViewDelegate:
extension NewTaskViewController: CustomNewTaskInputInfoViewDelegate {
    func setupTaskInfo(isName: Bool, value: String) {
        viewModel.setupTaskInfo(isName: isName, value: value)
    }
}

// MARK: - NewTaskTableViewDateCellDelegate:
extension NewTaskViewController: NewTaskTableViewDateCellDelegate {
    func setupDate(from type: NewTaskCellType, with value: Date) {
        viewModel.setupTaskDate(from: type, with: value)
        if type == .date {
            dismiss()
        }
    }
}

// MARK: - Setup Views:
private extension NewTaskViewController {
    func setupViews() {
        addEndEditingGesture()
        customNewTaskNavigationView.delegate = self
        customNewTaskInputInfoView.delegate = self
        tableViewDataProvider.cellDelegate = self
        
        view.backgroundColor = .white
        [customNewTaskNavigationView, customNewTaskInputInfoView, newTaskTableView].forEach(view.addNewSubview)
    }
}

// MARK: - Setup Constraints:
private extension NewTaskViewController {
    func setupConstraints() {
        setupCustomNewTaskNavigationViewConstraints()
        setupCustomNewTaskInputInfoViewConstraints()
        setupNewTaskTableViewConstraints()
    }
    
    func setupCustomNewTaskNavigationViewConstraints() {
        NSLayoutConstraint.activate([
            customNewTaskNavigationView.heightAnchor.constraint(equalToConstant: LocalUIConstants.navigationViewHeight),
            customNewTaskNavigationView.topAnchor.constraint(equalTo: view.topAnchor),
            customNewTaskNavigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNewTaskNavigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupCustomNewTaskInputInfoViewConstraints() {
        NSLayoutConstraint.activate([
            customNewTaskInputInfoView.heightAnchor.constraint(equalToConstant: LocalUIConstants.inputInfoViewHeight),
            customNewTaskInputInfoView.topAnchor.constraint(equalTo: customNewTaskNavigationView.bottomAnchor, constant: UIConstants.baseInset),
            customNewTaskInputInfoView.leadingAnchor.constraint(equalTo: customNewTaskNavigationView.leadingAnchor, constant: UIConstants.baseInset),
            customNewTaskInputInfoView.trailingAnchor.constraint(equalTo: customNewTaskNavigationView.trailingAnchor, constant: -UIConstants.baseInset)
        ])
    }
    
    func setupNewTaskTableViewConstraints() {
        NSLayoutConstraint.activate([
            newTaskTableView.heightAnchor.constraint(equalToConstant: LocalUIConstants.tableViewHeight),
            newTaskTableView.topAnchor.constraint(equalTo: customNewTaskInputInfoView.bottomAnchor, constant: UIConstants.baseInset),
            newTaskTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.baseInset),
            newTaskTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.baseInset)
        ])
    }
}

// MARK: - Setup Targets:
private extension NewTaskViewController {
    
}

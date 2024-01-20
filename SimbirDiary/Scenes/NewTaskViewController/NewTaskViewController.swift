import UIKit

final class NewTaskViewController: UIViewController {
    
    // MARK: - Dependencies:
    weak var coordinator: CoordinatorProtocol?
    
    private let viewModel: NewTaskViewViewModelProtocol
    
    // MARK: - Classes:
    private let tableViewDataProvider: NewTaskTableViewDataProvider
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let inputInfoViewHeight: CGFloat = 151
        static let tableViewHeight: CGFloat = 120
        static let separatorInset: CGFloat = 20
    }
    
    private var customNewTaskInputInfoViewHeightAnchor: NSLayoutConstraint?
    
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
    
    private lazy var customNewTaskNavigationView = CustomTaskNavigationView(isDetail: false)
    private lazy var customNewTaskInputInfoView = CustomNewTaskInputInfoView()
    
    // MARK: - Lifecycle:
    init(coordinator: CoordinatorProtocol, viewModel: NewTaskViewViewModelProtocol) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        self.tableViewDataProvider = NewTaskTableViewDataProvider(viewModel: viewModel)
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
    
    // MARK: - Private Methods:
    private func bind() {
        viewModel.isReadyToAddNewTaskObservable.bind { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                self.customNewTaskNavigationView.controlDoneButtonState(isAvailable: result)
            }
        }
    }
}

// MARK: - CustomNewTaskNavigationViewDelegate:
extension NewTaskViewController: CustomTaskNavigationViewDelegate {
    func dismiss() {
        coordinator?.pop(from: self)
    }
    
    func performTask(isDelete: Bool) {
        if isDelete == false {
            viewModel.addNewTask()
            dismiss()
        }
    }
}

// MARK: - CustomNewTaskInputInfoViewDelegate:
extension NewTaskViewController: CustomNewTaskInputInfoViewDelegate {
    func setupTaskInfo(isName: Bool, value: String) {
        viewModel.setupTaskInfo(isName: isName, value: value)
    }
    
    func controlSuperviewHeight(with value: CGFloat) {
        customNewTaskInputInfoViewHeightAnchor?.constant += value
        
        UIView.animate(withDuration: UIConstants.baseAnimationDuration) {
            self.view.layoutIfNeeded()
        }
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
        
        view.backgroundColor = .regularBackgroundLightGray
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
            customNewTaskNavigationView.heightAnchor.constraint(equalToConstant: UIConstants.navigationViewHeight),
            customNewTaskNavigationView.topAnchor.constraint(equalTo: view.topAnchor),
            customNewTaskNavigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNewTaskNavigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupCustomNewTaskInputInfoViewConstraints() {
        customNewTaskInputInfoViewHeightAnchor = customNewTaskInputInfoView.heightAnchor.constraint(equalToConstant: LocalUIConstants.inputInfoViewHeight)
        customNewTaskInputInfoViewHeightAnchor?.isActive = true
    
        NSLayoutConstraint.activate([
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

import UIKit

final class TaskDetailViewController: UIViewController {
    
    // MARK: - Dependencies:
    weak var coordinator: AppCoordinator?
    
    private let viewModel: TaskDetailViewViewModelProtocol
    
    // MARK: - Constants and Variables:
    private let topStackViewHeight: CGFloat = 40
        
    // MARK: - UI:
    private lazy var screenScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var customNavigationBarView = CustomTaskNavigationView(isDetail: true)
    private lazy var taskDetailView = TaskDetailView()
    
    // MARK: - Lifecycle:
    init(coordinator: AppCoordinator, viewModel: TaskDetailViewViewModelProtocol) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupConstraints()
        
        let task = viewModel.task
        taskDetailView.setupDetailOf(task)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CustomTaskNavigationViewDelegate:
extension TaskDetailViewController: CustomTaskNavigationViewDelegate {
    func performTask(isDelete: Bool) {
        if isDelete {
            viewModel.deleteTask()
            dismiss()
        }
    }
    
    func dismiss() {
        coordinator?.pop()
    }
}

// MARK: - Setup Views:
private extension TaskDetailViewController {
    func setupViews() {
        customNavigationBarView.delegate = self
        
        view.backgroundColor = .regularBackgroundLightGray
        
        [customNavigationBarView, screenScrollView].forEach(view.addNewSubview)
        screenScrollView.addNewSubview(taskDetailView)
    }
}

// MARK: - Setup Constraints:
private extension TaskDetailViewController {
    func setupConstraints() {
        setupCustomNavigationBarViewConstraints()
        setupScreenScrollViewConstraints()
        setupTaskDetailViewConstraints()
    }

    func setupCustomNavigationBarViewConstraints() {
        NSLayoutConstraint.activate([
            customNavigationBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavigationBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupScreenScrollViewConstraints() {
        NSLayoutConstraint.activate([
            screenScrollView.topAnchor.constraint(equalTo: customNavigationBarView.bottomAnchor),
            screenScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            screenScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            screenScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupTaskDetailViewConstraints() {
        let anchor = taskDetailView.bottomAnchor.constraint(equalTo: screenScrollView.bottomAnchor, constant: -20)
        anchor.priority = .defaultLow
        anchor.isActive = true
         
        NSLayoutConstraint.activate([
            taskDetailView.topAnchor.constraint(equalTo: screenScrollView.topAnchor, constant: UIConstants.baseInset),
            taskDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.baseInset),
            taskDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.baseInset)
        ])
    }
}

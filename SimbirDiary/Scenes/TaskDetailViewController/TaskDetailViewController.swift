import UIKit

final class TaskDetailViewController: UIViewController {
    
    // MARK: - Dependencies:
    weak var coordinator: AppCoordinator?
    
    // MARK: - Constants and Variables:
    private let task: Task
    
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
    init(coordinator: AppCoordinator, task: Task) {
        self.coordinator = coordinator
        self.task = task
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupConstraints()
        setupTargets()
        taskDetailView.setupDetailOf(task)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CustomTaskNavigationViewDelegate:
extension TaskDetailViewController: CustomTaskNavigationViewDelegate {
    func performTask(isDelete: Bool) {
        
    }
    
    func dismiss() {
        coordinator?.pop()
    }
}

// MARK: - Setup Views:
private extension TaskDetailViewController {
    func setupViews() {
        customNavigationBarView.delegate = self
        view.backgroundColor = .white
        
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
            customNavigationBarView.heightAnchor.constraint(equalToConstant: UIConstants.navigationViewHeight),
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
        NSLayoutConstraint.activate([
            taskDetailView.heightAnchor.constraint(equalToConstant: 120),
            taskDetailView.topAnchor.constraint(equalTo: customNavigationBarView.bottomAnchor, constant: UIConstants.baseInset),
            taskDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.baseInset),
            taskDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.baseInset),
        ])
    }
}

// MARK: - Setup Targets:
private extension TaskDetailViewController {
    func setupTargets() {
        
    }
}

import UIKit

final class TaskDetailViewController: UIViewController {
    
    // MARK: - Dependencies:
    weak var coordinator: AppCoordinator?
    
    // MARK: - UI:
    private lazy var backgroundBlurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let visualEffect = UIVisualEffectView(effect: blurEffect)
        return visualEffect
    }()
    
    private lazy var screenScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: - Lifecycle:
    init(coordinator: AppCoordinator? = nil) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupConstraints()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Views:
private extension TaskDetailViewController {
    func setupViews() {
        [backgroundBlurEffectView, screenScrollView].forEach(view.addNewSubview)
    }
}

// MARK: - Setup Constraints:
private extension TaskDetailViewController {
    func setupConstraints() {
        setupbackgroundBlurEffectViewConstraints()
    }
    
    func setupbackgroundBlurEffectViewConstraints() {
        NSLayoutConstraint.activate([
            backgroundBlurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundBlurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundBlurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundBlurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - Setup Targets:
private extension TaskDetailViewController {
    func setupTargets() {
        
    }
}

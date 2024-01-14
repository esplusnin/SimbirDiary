import UIKit

final class TaskDetailView: UIView {
    
    // MARK: - Constants and Variables:
    private let separatorViewWidth: CGFloat = 1
    
    // MARK: - UI:
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var nameLabel = UILabel()
    private lazy var timeLabel = UILabel()
    private lazy var descriptionLabel = UILabel()
    
    // MARK: - Lifecycle:
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func setupDetailOf(_ task: Task) {
        nameLabel.text = task.name
        timeLabel.text = "14.32"
        descriptionLabel.text = task.description
    }
}

// MARK: - Setup Views:
private extension TaskDetailView {
    func setupViews() {
        backgroundColor = .lightGray.withAlphaComponent(UIConstants.baseAlphaComponent)
        layer.cornerRadius = UIConstants.baseCornerRadius
        
        addNewSubview(mainStackView)
        mainStackView.addArrangedSubview(topStackView)
        [nameLabel, timeLabel].forEach(topStackView.addArrangedSubview)
        [topStackView, separatorView, descriptionLabel].forEach(mainStackView.addArrangedSubview)
    }
}

// MARK: - Setup Constraints:
private extension TaskDetailView {
    func setupConstraints() {
        setupStackViewConstraints()
        setupSeparatorLineConstraints()
    }
    
    func setupStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.baseInset),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.baseInset)
        ])
    }
    
    func setupSeparatorLineConstraints() {
        separatorView.heightAnchor.constraint(equalToConstant: separatorViewWidth).isActive = true
    }
}

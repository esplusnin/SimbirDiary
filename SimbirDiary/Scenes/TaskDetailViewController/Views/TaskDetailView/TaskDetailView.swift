import UIKit

final class TaskDetailView: UIView {
    
    // MARK: - Constants and Variables:
    private let stackViewSpacing: CGFloat = 10
    private let numberOfLineLimitation = 0
    
    // MARK: - UI:
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = stackViewSpacing
        return stackView
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = numberOfLineLimitation
        label.font = .largeTitleFont
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .regularMediumFont
        label.numberOfLines = numberOfLineLimitation
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .regularMediumBoldFont
        label.text = L10n.TaskDetail.startDate
        return label
    }()
    
    private lazy var timeValueLabel: UILabel = {
        let label = UILabel()
        label.font = .regularMediumFont
        return label
    }()
   
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
        timeValueLabel.text = DateFormatterService().getTimeValue(from: task.dateStart, isOnlyHours: false)
        descriptionLabel.text = task.description
        
        nameLabel.sizeToFit()
        descriptionLabel.sizeToFit()
    }
}

// MARK: - Setup Views:
private extension TaskDetailView {
    func setupViews() {
        backgroundColor = .lightGray.withAlphaComponent(UIConstants.baseAlphaComponent)
        layer.cornerRadius = UIConstants.baseCornerRadius
        
        addNewSubview(mainStackView)
        mainStackView.addArrangedSubview(topStackView)
        [timeLabel, timeValueLabel].forEach(topStackView.addArrangedSubview)
        [nameLabel, topStackView, separatorView, descriptionLabel].forEach(mainStackView.addArrangedSubview)
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
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: UIConstants.baseInset),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.baseInset),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIConstants.baseInset),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.baseInset)
        ])
    }
    
    func setupSeparatorLineConstraints() {
        separatorView.heightAnchor.constraint(equalToConstant: UIConstants.separatorViewHeight).isActive = true
    }
}

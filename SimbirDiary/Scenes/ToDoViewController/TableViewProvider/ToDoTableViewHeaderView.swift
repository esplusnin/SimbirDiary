import UIKit

final class ToDoTableViewHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let cornerRadius: CGFloat = 15
    }
    // MARK: - UI
    private lazy var headerNameLabel: UILabel = {
        let label = UILabel()
        label.font = .largeTitleFont
        return label
    }()
    
    private lazy var tasksAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .regularMediumFont
        return label
    }()
    
    // MARK: - Lifecycle:
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func setupHeaderLabel(text: String, tasksAmount: Int) {
        headerNameLabel.text = text
        tasksAmountLabel.text = String(tasksAmount)
    }
}

// MARK: - Setup Views:
extension ToDoTableViewHeaderView {
    private func setupViews() {
        contentView.layer.cornerRadius = LocalUIConstants.cornerRadius
        contentView.backgroundColor = .regularBackgroundWhite
        
        [headerNameLabel, tasksAmountLabel].forEach(addNewSubview)
    }
}

// MARK: - Setup Constraints:
private extension ToDoTableViewHeaderView {
    func setupConstraints() {
        setupHeaderNameLabelConstraints()
        setupTasksAmountLabelConstraints()
    }
    
    func setupHeaderNameLabelConstraints() {
        NSLayoutConstraint.activate([
            headerNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.baseInset)
        ])
    }
    
    func setupTasksAmountLabelConstraints() {
        tasksAmountLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        tasksAmountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.baseInset).isActive = true
    }
}

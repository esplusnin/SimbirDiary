import UIKit

final class ToDoTableViewCell: UITableViewCell {

    // MARK: - Constants and Variables:
    private var task: Task? {
        didSet {
            guard let task else { return }
            nameLabel.text = task.name
            timeValueLabel.text = task.calendarDate
        }
    }
    
    private let timeValueLabelWidth: CGFloat = 50
    
    // MARK: - UI:
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .regularMediumFont
        return label
    }()
    
    private lazy var timeValueLabel: UILabel = {
       let label = UILabel()
        label.font = .regularMediumFont
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = UIConstants.baseCornerRadius
        view.backgroundColor = .regularGray
        return view
    }()
    
    // MARK: - Lifecycle:
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func setupCell(_ task: Task) {
        self.task = task
    }
}

// MARK: - Setup Views:
extension ToDoTableViewCell {
    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        [nameLabel, separatorView, timeValueLabel].forEach(contentView.addNewSubview)
    }
}

// MARK: - Setup Constraints:
private extension ToDoTableViewCell {
    func setupConstraints() {
        setupNameLabelConstraints()
        setupSeparatorViewConstraints()
        setupTimeValueLabelConstraints()
    }
    
    func setupNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.baseInset)
        ])
        
        let trailingNameLabelConstraints = nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: timeValueLabel.leadingAnchor, constant: -UIConstants.baseInset)
        trailingNameLabelConstraints.priority = .defaultHigh
        trailingNameLabelConstraints.isActive = true
    }
    
    func setupSeparatorViewConstraints() {
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: UIConstants.separatorViewHeight),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setupTimeValueLabelConstraints() {
        timeValueLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        timeValueLabel.widthAnchor.constraint(equalToConstant: timeValueLabelWidth).isActive = true
        
        let trailingConstraints = timeValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.baseInset)
        trailingConstraints.priority = .defaultHigh
        trailingConstraints.isActive = true
    }
}

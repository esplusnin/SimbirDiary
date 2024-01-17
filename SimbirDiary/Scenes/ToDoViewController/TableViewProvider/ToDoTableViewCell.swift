import UIKit

final class ToDoTableViewCell: UITableViewCell {

    // MARK: - Constants and Variables:
    private var task: Task? {
        didSet {
            guard let task else { return }
            nameLabel.text = task.name
        }
    }
    
    // MARK: - UI:
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .regularMediumFont
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = UIConstants.baseCornerRadius
        view.backgroundColor = .lightGray.withAlphaComponent(UIConstants.baseAlphaComponent)
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
        [nameLabel, separatorView].forEach(contentView.addNewSubview)
    }
}

// MARK: - Setup Constraints:
private extension ToDoTableViewCell {
    func setupConstraints() {
        setupNameLabelConstraints()
        setupSeparatorViewConstraints()
    }
    
    func setupNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.baseInset),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.baseInset)
        ])
    }
    
    func setupSeparatorViewConstraints() {
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: UIConstants.separatorViewHeight),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

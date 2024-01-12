import UIKit

final class ToDoTableViewCell: UITableViewCell {

    // MARK: - Constants and Variables:
    private enum UILocalConstants {
        static let toggleButtonSide: CGFloat = 20
        static let toggleButtonBorderWidth: CGFloat = 1
    }
    
    private var task: Task? {
        didSet {
            guard let task else { return }
            nameLabel.text = task.name
        }
    }
    
    // MARK: - UI:
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
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
        [nameLabel].forEach(contentView.addNewSubview)
    }
}
// MARK: - Setup Constraints:
private extension ToDoTableViewCell {
    func setupConstraints() {
        setupNameLabelConstraints()
    }
    
    func setupNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.baseInset),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.baseInset)
        ])
    }
}

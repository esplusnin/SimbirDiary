import UIKit

final class ToDoTableViewCell: UITableViewCell {
    
    // MARK: - Constants and Variables:
    private enum UILocalConstants {
        static let toggleButtonSide: CGFloat = 20
        static let toggleButtonBorderWidth: CGFloat = 1
        static let toggleButtonCornerRadius: CGFloat = 10
    }
    
    // MARK: - UI:
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "проверка"
        return label
    }()
    
    private lazy var toggleButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = UILocalConstants.toggleButtonCornerRadius
        button.layer.borderWidth = UILocalConstants.toggleButtonBorderWidth
        button.layer.borderColor = UIColor.gray.cgColor
        return button
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
}

// MARK: - Setup Views:
extension ToDoTableViewCell {
    private func setupViews() {
        [nameLabel, toggleButton].forEach(addNewSubview)
    }
}
// MARK: - Setup Constraints:
private extension ToDoTableViewCell {
    func setupConstraints() {
        setupNameLabelConstraints()
        setupToggleButtonConstraints()
    }
    
    func setupNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.baseInset),
            nameLabel.trailingAnchor.constraint(equalTo: toggleButton.leadingAnchor, constant: -UIConstants.baseInset)
        ])
    }
    
    func setupToggleButtonConstraints() {
        NSLayoutConstraint.activate([
            toggleButton.heightAnchor.constraint(equalToConstant: UILocalConstants.toggleButtonSide),
            toggleButton.widthAnchor.constraint(equalToConstant: UILocalConstants.toggleButtonSide),
            toggleButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            toggleButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.baseInset)
        ])
    }
}

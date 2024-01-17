import UIKit

final class ToDoListStumbView: UIView {
    
    // MARK: - Constants and Variables:
    private var buttonAction: (() -> Void)?
    
    // MARK: - UI:
    private lazy var stumbStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var stumbTitleLabel: UILabel = {
       let label = UILabel()
        label.text = L10n.ToDoList.Stumb.title
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stumbMessageLabel: UILabel = {
       let label = UILabel()
        label.text = L10n.ToDoList.Stumb.message
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stumbButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L10n.ToDoList.Stumb.buttonTitle, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle:
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(action: @escaping (() -> Void)) {
        self.init()
        self.buttonAction = action
        setupViews()
        setupConstraints()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Objc Methods:
    @objc private func addNewTask() {
        guard let buttonAction else { return }
        buttonAction()
    }
}

// MARK: - Setup Views:
private extension ToDoListStumbView {
    func setupViews() {
        addNewSubview(stumbStackView)
        [stumbTitleLabel, stumbMessageLabel, stumbButton].forEach(stumbStackView.addArrangedSubview)
    }
}

// MARK: - Setup Constraints:
private extension ToDoListStumbView {
    func setupConstraints() {
        setupStumbStackViewConstraints()
    }
    
    func setupStumbStackViewConstraints() {
        NSLayoutConstraint.activate([
            stumbStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stumbStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -UIConstants.baseInset)
        ])
    }
}

// MARK: - Setup Targets:
private extension ToDoListStumbView {
    func setupTargets() {
        stumbButton.addTarget(self, action: #selector(addNewTask), for: .touchUpInside)
    }
}

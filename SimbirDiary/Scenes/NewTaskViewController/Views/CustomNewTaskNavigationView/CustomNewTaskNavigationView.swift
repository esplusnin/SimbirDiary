import UIKit

final class CustomNewTaskNavigationView: UIStackView {
    
    // MARK: - Dependencies:
    weak var delegate: CustomNewTaskNavigationViewDelegate?
    
    // MARK: - UI
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L10n.General.cancel, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        return button
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = L10n.NewTask.title
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L10n.General.done, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    // MARK: - Lifecycle:
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        controlDoneButtonState(isAvailable: false)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods:
    func controlDoneButtonState(isAvailable: Bool) {
        doneButton.isEnabled = isAvailable
        doneButton.titleLabel?.textColor = isAvailable ? .blue : .gray
    }
    
    // MARK: - Objc Methods:
    @objc private func cancel() {
        delegate?.dismiss()
    }
    
    @objc private func addNewTask() {
        delegate?.addNewTask()
    }
}

// MARK: - Setup Views:
private extension CustomNewTaskNavigationView {
    func setupViews() {
        axis = .horizontal
        distribution = .fillProportionally
        [cancelButton, title, doneButton].forEach(addArrangedSubview)
    }
}

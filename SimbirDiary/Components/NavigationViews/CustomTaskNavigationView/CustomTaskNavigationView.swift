import UIKit

final class CustomTaskNavigationView: UIStackView {
    
    // MARK: - Dependencies:
    weak var delegate: CustomTaskNavigationViewDelegate?
    
    // MARK: - Constants and Variables:
    private var isDetail: Bool?
    
    // MARK: - UI
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L10n.General.cancel, for: .normal)
        button.titleLabel?.font = .regularMediumFont
        return button
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .mediumTitleFont
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .regularMediumBoldFont
        return button
    }()
    
    // MARK: - Lifecycle:
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupTargets()
    }
    
    convenience init(isDetail: Bool) {
        self.init()
        self.isDetail = isDetail
        self.setupNavigationBarAppearance()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func controlDoneButtonState(isAvailable: Bool) {
        actionButton.isEnabled = isAvailable
        actionButton.titleLabel?.textColor = isAvailable ? .blue : .gray
    }
    
    // MARK: - Private Methods:
    private func setupNavigationBarAppearance() {
        guard let isDetail else { return }
        
        switch isDetail {
        case true :
            title.text = L10n.TaskDetail.title
            actionButton.addTarget(self, action: #selector(deleteTask), for: .touchUpInside)
            actionButton.setTitleColor(.red, for: .normal)
            actionButton.setTitle(L10n.General.delete, for: .normal)
            
        case false:
            title.text = L10n.NewTask.title
            actionButton.addTarget(self, action: #selector(addNewTask), for: .touchUpInside)
            controlDoneButtonState(isAvailable: false)
            actionButton.setTitle(L10n.General.done, for: .normal)
        }
    }
    
    // MARK: - Objc Methods:
    @objc private func cancel() {
        delegate?.dismiss()
    }
    
    @objc private func addNewTask() {
        delegate?.performTask(isDelete: false)
    }
    
    @objc private func deleteTask() {
        delegate?.performTask(isDelete: true)
    }
}

// MARK: - Setup Views:
private extension CustomTaskNavigationView {
    func setupViews() {
        axis = .horizontal
        distribution = .fillProportionally
        [cancelButton, title, actionButton].forEach(addArrangedSubview)
    }
}

// MARK: - Setup Targets:
private extension CustomTaskNavigationView {
    func setupTargets() {
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
    }
}

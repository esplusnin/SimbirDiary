import UIKit

final class CustomNewTaskInputInfoView: UIView {
    
    // MARK: - Dependencies:
    weak var delegate: CustomNewTaskInputInfoViewDelegate?
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let textFieldLeftViewWidth: CGFloat = 20
        static let separatorViewCornerRadius: CGFloat = 20
        static let separatorViewWidth: CGFloat = 1
    }
        
    // MARK: - UI:
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var enterNameTextField: UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: LocalUIConstants.textFieldLeftViewWidth, height: 0))
        textField.leftViewMode = .always
        textField.placeholder = L10n.NewTask.name
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        return textField
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = LocalUIConstants.separatorViewCornerRadius
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var enterDescriptionTextField: UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: LocalUIConstants.textFieldLeftViewWidth, height: 0))
        textField.leftViewMode = .always
        textField.placeholder = L10n.NewTask.description
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        return textField
    }()
    
    // MARK: - Lifecycle:
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupTargets()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITextFieldDelegate:
extension CustomNewTaskInputInfoView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let superview else { return true}
        superview.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isName = textField == enterNameTextField
        let text = isName ? enterNameTextField.text : enterDescriptionTextField.text
        delegate?.setupTaskInfo(isName: isName, value: text ?? "")
    }
}

// MARK: - Setup Views:
private extension CustomNewTaskInputInfoView {
    func setupViews() {
        backgroundColor = .lightGray.withAlphaComponent(UIConstants.baseAlphaComponent)
        layer.cornerRadius = UIConstants.baseCornerRadius

        addNewSubview(stackView)
        [enterNameTextField, separatorView, enterDescriptionTextField].forEach(stackView.addArrangedSubview)
    }
}

// MARK: - Setup Constraints:
private extension CustomNewTaskInputInfoView {
    func setupConstraints() {
        setupStackViewConstraints()
        setupSeparatorLineConstraints()
    }
    
    func setupStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.baseInset)
        ])
    }
    
    func setupSeparatorLineConstraints() {
        separatorView.heightAnchor.constraint(equalToConstant: LocalUIConstants.separatorViewWidth).isActive = true
    }
}

// MARK: - Setup Targets:
private extension CustomNewTaskInputInfoView {
    func setupTargets() {
        
    }
}

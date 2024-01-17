import UIKit

final class CustomNewTaskInputInfoView: UIView {
    
    // MARK: - Dependencies:
    weak var delegate: CustomNewTaskInputInfoViewDelegate?
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let baseTextViewHeight: CGFloat = 35
        static let separatorViewCornerRadius: CGFloat = 20
        static let separatorViewWidth: CGFloat = 1
    }
    
    private var enterNameHeightConstraints: NSLayoutConstraint?
    private var enterDescriptionHeightConstraints: NSLayoutConstraint?
        
    // MARK: - UI:
    private lazy var enterNameTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = UIConstants.baseCornerRadius
        textView.backgroundColor = .lightGray.withAlphaComponent(UIConstants.baseAlphaComponent)
        textView.delegate = self
        textView.isScrollEnabled = false
        textView.font = .regularMediumFont
        textView.text = L10n.NewTask.name
        textView.textColor = .lightGray
        return textView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = LocalUIConstants.separatorViewCornerRadius
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var enterDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = UIConstants.baseCornerRadius
        textView.backgroundColor = .lightGray.withAlphaComponent(UIConstants.baseAlphaComponent)
        textView.delegate = self
        textView.isScrollEnabled = false
        textView.font = .regularMediumFont
        textView.text = L10n.NewTask.description
        textView.textColor = UIColor.lightGray
        return textView
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
    
    // MARK: - Private Methods:
    private func controlHeightOf(_ textView: UITextView) {
        let oldheight = textView.bounds.height
        let newHeight = textView.sizeThatFits(CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)).height
        
        let value = newHeight - oldheight
        delegate?.controlSuperviewHeight(with: value)
        
        if textView == enterNameTextView {
            enterNameHeightConstraints?.constant += value
        } else {
            enterDescriptionHeightConstraints?.constant += value
        }
        
        UIView.animate(withDuration: UIConstants.baseAnimationDuration) {
            self.layoutIfNeeded()
        }
    }
    
    private func controlInputTextOf(_ textView: UITextView) {
        let isName = textView == enterNameTextView
        let text = isName ? enterNameTextView.text : enterDescriptionTextView.text
        delegate?.setupTaskInfo(isName: isName, value: text ?? "")
    }
}

extension CustomNewTaskInputInfoView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == L10n.NewTask.name || textView.text == L10n.NewTask.description {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        controlHeightOf(textView)
        controlInputTextOf(textView)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if !textView.hasText {
            textView.textColor = .lightGray
            textView.text = textView == enterNameTextView ? L10n.NewTask.name : L10n.NewTask.description
        }
    }
}

// MARK: - Setup Views:
private extension CustomNewTaskInputInfoView {
    func setupViews() {
        backgroundColor = .lightGray.withAlphaComponent(UIConstants.baseAlphaComponent)
        layer.cornerRadius = UIConstants.baseCornerRadius

        [enterNameTextView, separatorView, enterDescriptionTextView].forEach(addNewSubview)
    }
}

// MARK: - Setup Constraints:
private extension CustomNewTaskInputInfoView {
    func setupConstraints() {
        setupEnterNameTextViewConstraints()
        setupSeparatorLineConstraints()
        setupEnterDescriptionTextViewConstraints()
    }
    
    func setupEnterNameTextViewConstraints() {
        enterNameHeightConstraints = enterNameTextView.heightAnchor.constraint(equalToConstant: LocalUIConstants.baseTextViewHeight)
        enterNameHeightConstraints?.isActive = true
        
        NSLayoutConstraint.activate([
            enterNameTextView.topAnchor.constraint(equalTo: topAnchor, constant: UIConstants.baseInset),
            enterNameTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.baseInset),
            enterNameTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.baseInset)
        ])
    }
    
    func setupSeparatorLineConstraints() {
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: LocalUIConstants.separatorViewWidth),
            separatorView.topAnchor.constraint(equalTo: enterNameTextView.bottomAnchor, constant: UIConstants.baseInset),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.baseInset),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.baseInset)
        ])
    }
    
    func setupEnterDescriptionTextViewConstraints() {
        enterDescriptionHeightConstraints = enterDescriptionTextView.heightAnchor.constraint(equalToConstant: LocalUIConstants.baseTextViewHeight)
        enterDescriptionHeightConstraints?.isActive = true
        
        NSLayoutConstraint.activate([
            enterDescriptionTextView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: UIConstants.baseInset),
            enterDescriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.baseInset),
            enterDescriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.baseInset)
        ])
    }
}

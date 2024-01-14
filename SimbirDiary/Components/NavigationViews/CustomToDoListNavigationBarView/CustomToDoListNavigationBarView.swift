import UIKit

final class CustomToDoListNavigationBarView: UIView {
    
    // MARK: - Dependencies:
    weak var delegate: CustomToDoListNavigationBarViewDelegate?
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let buttonSide: CGFloat = 40
        static let pickerHeigth: CGFloat = 40
        static let pickerWidth: CGFloat = 100
        static let separatorWidth: CGFloat = 2
        
        static let plusButtonFont: CGFloat = 40
        
        static let navBarShadowOpacity: Float = 1
        static let navBarShadowRadius: CGFloat = 10
    }
    
    // MARK: - UI:
    private var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        datePicker.layer.cornerRadius = UIConstants.baseCornerRadius
        return datePicker
    }()
    
    private var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Resources.Symbols.plus, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: LocalUIConstants.plusButtonFont)
        return button
    }()
    
    // MARK: - Lifecycle:
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadow()
        setupDate()
    }
    
    // MARK: - Public Methods:
    func setup() {
        setupViews()
        setupConstraints()
        setupTargets()
    }
    
    // MARK: - Private Methods:
    private func setupShadow() {
        layer.shadowOpacity = LocalUIConstants.navBarShadowOpacity
        layer.shadowRadius = LocalUIConstants.navBarShadowRadius
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
    
    // MARK: - Objc Methods:
    @objc private func setupDate() {
        let date = datePicker.date
        delegate?.setupDate(from: date)
    }
    
    @objc private func presentNewTaskController() {
        delegate?.presentNewTaskController()
    }
}

// MARK: - Setup Views:
private extension CustomToDoListNavigationBarView {
     func setupViews() {
        backgroundColor = .white
        [datePicker, plusButton].forEach(addNewSubview)
    }
}

// MARK: - Setup Constraints:
private extension CustomToDoListNavigationBarView {
    func setupConstraints() {
        setupDatePickerConstraints()
        setupPlusButtonConstraints()
    }
    
    func setupDatePickerConstraints() {
        NSLayoutConstraint.activate([
            datePicker.heightAnchor.constraint(equalToConstant: LocalUIConstants.pickerHeigth),
            datePicker.widthAnchor.constraint(equalToConstant: LocalUIConstants.pickerWidth),
            datePicker.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.baseInset)
        ])
    }
    
    func setupPlusButtonConstraints() {
        NSLayoutConstraint.activate([
            plusButton.centerYAnchor.constraint(equalTo: datePicker.centerYAnchor),
            plusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.baseInset)
        ])
    }
}

// MARK: - Setup Targets:
private extension CustomToDoListNavigationBarView {
    func setupTargets() {
        datePicker.addTarget(self, action: #selector(setupDate), for: .valueChanged)
        plusButton.addTarget(self, action: #selector(presentNewTaskController), for: .touchUpInside)
    }
}

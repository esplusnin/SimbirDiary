import UIKit

final class CustomNavigationBarView: UIView {
    
    // MARK: - Constants and Variables:
    private enum UIConstants {
        static let sideInset: CGFloat = 20
        static let buttonSide: CGFloat = 40
        static let pickerHeigth: CGFloat = 40
        static let pickerWidth: CGFloat = 100
        static let separatorWidth: CGFloat = 2
    }
    
    // MARK: - UI:
    private var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    private var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 40)
        return button
    }()
    
    // MARK: - Public Methods:
    func setup() {
        setupViews()
        setupConstraints()
        layer.shadowOpacity = 1
        layer.shadowRadius = 10
        layer.shadowColor = UIColor.lightGray.cgColor
    }
}

// MARK: - Setup Views:
extension CustomNavigationBarView {
    private func setupViews() {
        backgroundColor = .white
        [datePicker, plusButton].forEach(add)
    }
}

// MARK: - Setup Constraints:
private extension CustomNavigationBarView {
    func setupConstraints() {
        setupDatePickerConstraints()
        setupPlusButtonConstraints()
    }
    
    func setupDatePickerConstraints() {
        NSLayoutConstraint.activate([
            datePicker.heightAnchor.constraint(equalToConstant: UIConstants.pickerHeigth),
            datePicker.widthAnchor.constraint(equalToConstant: UIConstants.pickerWidth),
            datePicker.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.sideInset)
        ])
    }
    
    func setupPlusButtonConstraints() {
        NSLayoutConstraint.activate([
            plusButton.centerYAnchor.constraint(equalTo: datePicker.centerYAnchor),
            plusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.sideInset)
        ])
    }
}

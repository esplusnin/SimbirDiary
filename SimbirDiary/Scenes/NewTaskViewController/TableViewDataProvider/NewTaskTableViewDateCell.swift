import UIKit

enum NewTaskCellType {
    case date
    case time
}

final class NewTaskTableViewDateCell: UITableViewCell {
    
    // MARK: - Dependencies:
    weak var delegate: NewTaskTableViewDateCellDelegate?
    
    // MARK: - Constants and Variables:
    private var cellType: NewTaskCellType?
    
    // MARK: - UI
    private lazy var titleLabeL: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var datePicker = UIDatePicker()
    
    // MARK: - Lifecycle:
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func setupCell(type: NewTaskCellType) {
        switch type {
        case .date:
            cellType = .date
            titleLabeL.text = L10n.NewTask.selectDate
            datePicker.datePickerMode = .date
        case .time:
            cellType = .time
            titleLabeL.text = L10n.NewTask.selectTime
            datePicker.datePickerMode = .time
        }
    }
    
    // MARK: - Objc Methods:
    @objc private func setupTaskDate() {
        guard let cellType else { return }
        delegate?.setupDate(from: cellType, with: datePicker.date)
    }
}

// MARK: - Setup Views:
private extension NewTaskTableViewDateCell {
    func setupViews() {
        backgroundColor = .lightGray.withAlphaComponent(UIConstants.baseAlphaComponent)

        [titleLabeL, datePicker].forEach(contentView.addNewSubview)
    }
}

// MARK: - Setup Constraints:
private extension NewTaskTableViewDateCell {
    func setupConstraints() {
        setupTitleLabelConstraints()
        setupDatePickerConstraints()
    }
    
    func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabeL.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabeL.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.baseInset),
            titleLabeL.trailingAnchor.constraint(equalTo: datePicker.leadingAnchor, constant: -UIConstants.baseInset)
        ])
    }
    
    func setupDatePickerConstraints() {
        NSLayoutConstraint.activate([
            datePicker.centerYAnchor.constraint(equalTo: centerYAnchor),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.baseInset)
        ])
    }
}

// MARK: - Setup Targets:
private extension NewTaskTableViewDateCell {
    func setupTargets() {
        datePicker.addTarget(self, action: #selector(setupTaskDate), for: .valueChanged)
    }
}

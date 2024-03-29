import UIKit

final class NewTaskTableViewDataProvider: NSObject {
    
    // MARK: - Dependencies:
    weak var cellDelegate: NewTaskTableViewDateCellDelegate?
    
    private let viewModel: NewTaskViewViewModelProtocol
    
    // MARK: - Constants and Variables:
    private let countOfCells = 2
    private let cellHeight: CGFloat = 60
    
    // MARK: - Lifecycle:
    init(viewModel: NewTaskViewViewModelProtocol) {
        self.viewModel = viewModel
    }
}

// MARK: - UITableViewDataSource:
extension NewTaskTableViewDataProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Resources.Identifiers.newTaskTableViewDateCell,
            for: indexPath) as? NewTaskTableViewDateCell else { return UITableViewCell() }
        
        cell.delegate = cellDelegate
        cell.setupCell(type: indexPath.row == 0 ? .date : .time)
        
        if cell.cellType == .date {
            let date = viewModel.defaultDate
            cell.setupDefault(date)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellHeight
    }
}

// MARK: - UITableViewDelegate:
extension NewTaskTableViewDataProvider: UITableViewDelegate {}

import UIKit

final class NewTaskTableViewDataProvider: NSObject {
    
    // MARK: - Dependencies:
    weak var cellDelegate: NewTaskTableViewDateCellDelegate?
    
    // MARK: - Constants and Variables:
    private let countOfCells = 2
    private let cellHeight: CGFloat = 60
    
}

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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellHeight
    }
}

extension NewTaskTableViewDataProvider: UITableViewDelegate {}

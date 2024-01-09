import UIKit

final class ToDoViewControllerTableViewProvider: NSObject {
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let headerHeight: CGFloat = 40
        static let emptyCellHeight: CGFloat = 0
        static let cellHeight: CGFloat = 40
    }
    
    var times = [
    "0.00", "1.00", "2.00", "3.00", "4.00", "5.00", "6.00", "7.00", "8.00", "9.00", "10.00",
    "11.00", "12.00", "13.00", "14.00", "15.00", "16.00", "17.00", "18.00", "19.00", "20.00",
    "21.00", "22.00", "23.00", "24.00"
    ]
}

// MARK: - UITableViewDataSource:
extension ToDoViewControllerTableViewProvider: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        times.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Resources.Identifiers.toDoTableViewCell,
            for: indexPath) as? ToDoTableViewCell else { return UITableViewCell() }

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: Resources.Identifiers.toDoTableViewHeaderView) as? ToDoTableViewHeaderView else { return UIView() }
        // TODO:
        let secondPartText = section == times.count - 1 ? times[0] : times[section + 1]
        let headerText = times[section] + " - " + secondPartText
        headerView.setupHeaderLabel(text: headerText)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        LocalUIConstants.headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        LocalUIConstants.cellHeight
    }
}

// MARK: - UITableViewDelegate:
extension ToDoViewControllerTableViewProvider: UITableViewDelegate {
}

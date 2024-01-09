import UIKit

final class ToDoViewControllerTableViewProvider: NSObject {
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
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Resources.Identifiers.toDoTableViewCell,
            for: indexPath) as? ToDoTableViewCell else { return UITableViewCell() }
        cell.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: Resources.Identifiers.toDoTableViewHeaderView) as? ToDoTableViewHeaderView else { return UIView() }
        
        let secondPartText = section == times.count - 1 ? times[0] : times[section + 1]
        let headerText = times[section] + " - " + secondPartText
        headerView.setupHeaderLabel(text: headerText)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        0
    }
}

// MARK: - UITableViewDelegate:
extension ToDoViewControllerTableViewProvider: UITableViewDelegate {
}

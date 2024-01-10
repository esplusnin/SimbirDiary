import UIKit

final class NewTaskTableViewDataProvider: NSObject {
    
}

extension NewTaskTableViewDataProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Resources.Identifiers.newTaskTableViewDateCell,
            for: indexPath) as? NewTaskTableViewDateCell else { return UITableViewCell() }
        
        cell.setupCell(type: indexPath.row == 0 ? .date : .time)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}

extension NewTaskTableViewDataProvider: UITableViewDelegate {
    
}

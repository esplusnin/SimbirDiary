import UIKit

final class ToDoViewControllerTableViewProvider: NSObject {
    
    // MARK: - Dependencies:
    private let viewModel: ToDoViewViewModelProtocol
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let headerHeight: CGFloat = 40
        static let emptyCellHeight: CGFloat = 0
        static let cellHeight: CGFloat = 40
    }
    
    // MARK: - Lifecycle:
    init(viewModel: ToDoViewViewModelProtocol) {
        self.viewModel = viewModel
    }
}

// MARK: - UITableViewDataSource:
extension ToDoViewControllerTableViewProvider: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.timeBlocks.count
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
        let times = viewModel.timeBlocks
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

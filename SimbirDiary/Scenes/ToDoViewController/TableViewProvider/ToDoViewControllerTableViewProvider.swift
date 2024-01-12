import UIKit

final class ToDoViewControllerTableViewProvider: NSObject {
    
    // MARK: - Dependencies:
    weak var coordinator: AppCoordinator?
    weak var cellDelegate: ToDoViewController?
    
    private let viewModel: ToDoViewViewModelProtocol
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let headerHeight: CGFloat = 40
        static let emptyCellHeight: CGFloat = 0
        static let cellHeight: CGFloat = 40
    }
    
    // MARK: - Lifecycle:
    init(coordinator: AppCoordinator, viewModel: ToDoViewViewModelProtocol) {
        self.coordinator = coordinator
        self.viewModel = viewModel
    }
}

// MARK: - UITableViewDataSource:
extension ToDoViewControllerTableViewProvider: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.tasksListObservable.wrappedValue.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tasksListObservable.wrappedValue[section].tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Resources.Identifiers.toDoTableViewCell,
            for: indexPath) as? ToDoTableViewCell else { return UITableViewCell() }
        
        let tasks = viewModel.tasksListObservable.wrappedValue[indexPath.section].tasks
        let task = tasks[indexPath.row]
    
        cell.setupCell(task)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: Resources.Identifiers.toDoTableViewHeaderView) as? ToDoTableViewHeaderView else { return UIView() }
       
        let timeBlocks = viewModel.tasksListObservable.wrappedValue
        let tasksAmount = timeBlocks[section].tasks.count
        let firstPartText = timeBlocks[section].name
        let secondPartText = section == timeBlocks.count - 1 ? timeBlocks[0].name : timeBlocks[section + 1].name
        let headerText = firstPartText + " - " + secondPartText
        headerView.setupHeaderLabel(text: headerText, tasksAmount: tasksAmount)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        LocalUIConstants.headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tasks = viewModel.tasksListObservable.wrappedValue[indexPath.section].tasks
        return tasks.isEmpty ? LocalUIConstants.emptyCellHeight : LocalUIConstants.cellHeight
    }
}

// MARK: - UITableViewDelegate:
extension ToDoViewControllerTableViewProvider: UITableViewDelegate {}

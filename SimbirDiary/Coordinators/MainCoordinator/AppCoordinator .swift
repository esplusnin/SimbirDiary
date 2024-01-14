import UIKit

final class AppCoordinator: CoordinatorProtocol {
    
    // MARK: - Dependencies:
    private var databaseManager: DatabaseManagerProtocol
    private var dataProvider: DataProvider
    
    // MARK: - UI:
    var navigator: UINavigationController
    
    // MARK: - Lifecycle:
    init(databaseManager: DatabaseManagerProtocol, dataProvider: DataProvider, navigator: UINavigationController) {
        self.databaseManager = databaseManager
        self.dataProvider = dataProvider
        self.navigator = navigator
    }
    
    // MARK: - Public Methods:
    func start() {
        let toDoViewModel = ToDoViewViewModel(dataProvider: dataProvider)
        let toDoViewController = ToDoViewController(coordinator: self, viewModel: toDoViewModel)
        navigator.pushViewController(toDoViewController, animated: true)
    }
    
    func presentNewTaskController(from controller: UIViewController) {
        let newTaskViewModel = NewTaskViewViewModel(dataProvider: dataProvider)
        let newTaskViewController = NewTaskViewController(coordinator: self, viewModel: newTaskViewModel)
        controller.present(newTaskViewController, animated: true)
    }
    
    func seeDetailOf(_ task: Task) {
        let taskDetailViewController = TaskDetailViewController(coordinator: self, task: task)
        navigator.pushViewController(taskDetailViewController, animated: true)
    }
    
    func pop() {
        navigator.popViewController(animated: true)
    }
    
    func pop(from controller: UIViewController) {
        controller.dismiss(animated: true)
    }
}

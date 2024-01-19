import XCTest
@testable import SimbirDiary

final class SimbirDiaryTests: XCTestCase {
    
    // MARK: - Classes:
    let coordinator = MainCoordinatorStumb()
    let dataProvider = DataProviderStumb()
    
    // MARK: - ToDoViewController:
    func testToDoViewControllerView() {
        // Given:
        let viewModel = ToDoViewViewModelStumb(dataProvider: dataProvider)
        let viewController = ToDoViewController(coordinator: coordinator, viewModel: viewModel)
        
        // When:
        _ = viewController.view
        
        // Then:
        XCTAssertTrue(viewController.isViewLoaded)
    }
    
    func testToDoViewControllerFuncBind() {
        // Given:
        let viewModel = ToDoViewViewModelStumb(dataProvider: dataProvider)
        let viewController = ToDoViewController(coordinator: coordinator, viewModel: viewModel)
        
        // When:
        _ = viewController.view
        viewModel.setupNewElementInTaskList()
        
        // Then:
        let stumbView = viewController.view.subviews.filter { $0 is ToDoListStumbView }
        XCTAssertTrue(!stumbView.isEmpty)
    }
    
    // MARK: - ToDoViewViewModel:
    func testToDoViewViewModelFuncSetupDate() {
        // Given:
        let viewModel = ToDoViewViewModelStumb(dataProvider: dataProvider)
        let viewController = ToDoViewController(coordinator: coordinator, viewModel: viewModel)
        
        // When:
        viewController.setupDate(from: Date())
        // Then:
        XCTAssertNotNil(viewModel.currentDate)
    }
    
    func testToDoViewViewModelFuncFetchData() {
        // Given:
        let viewModel = ToDoViewViewModel(dataProvider: dataProvider)
        let viewController = ToDoViewController(coordinator: coordinator, viewModel: viewModel)

        // When:
        viewController.setupDate(from: Date())
        
        // Then:
        XCTAssertEqual(viewModel.tasksList.count, 1)
    }
    
    func testToDoViewViewModelFuncDeleteRows() {
        let viewModel = ToDoViewViewModel(dataProvider: dataProvider)
        let viewController = ToDoViewController(coordinator: coordinator, viewModel: viewModel)

        // When:
        viewController.setupDate(from: Date())
        dataProvider.isTaskDeleted = true
        dataProvider.setupUpdated(Task(id: UUID(), startDate: "", calendarDate: "", name: "", description: ""))
        
        // Then:
        XCTAssertEqual(viewModel.tasksList.count, 0)
    }
    
    // MARK: - NewTaskViewController:
    func testNewTaskViewController() {
        // Given:
        let viewModel = NewTaskViewViewModelStumb(dataProvider: dataProvider)
        let viewController = NewTaskViewController(coordinator: coordinator, viewModel: viewModel)
        
        // When:
        _ = viewController.view
        
        // Then:
        XCTAssertTrue(viewController.isViewLoaded)
    }
    
    func testNewTaskViewControllerFuncPerformTask() {
        // Given:
        let viewModel = NewTaskViewViewModelStumb(dataProvider: dataProvider)
        let viewController = NewTaskViewController(coordinator: coordinator, viewModel: viewModel)
        
        // When:
        viewController.performTask(isDelete: false)
        
        // Then:
        XCTAssertTrue(viewModel.isNewTaskAdded)
    }
    
    // MARK: - NewTaskViewViewModel:
    func testNewTaskViewViewModelisReadyToAddNewTask() {
        // Given:
        let viewModel = NewTaskViewViewModel(dataProvider: dataProvider)
        let viewController = NewTaskViewController(coordinator: coordinator, viewModel: viewModel)
        
        // When:
        viewModel.setupTaskDate(from: .date, with: Date())
        viewModel.setupTaskDate(from: .time, with: Date())
        viewModel.setupTaskInfo(isName: true, value: "testName")
        viewModel.setupTaskInfo(isName: false, value: "testDescription")
        
        // Then:
        XCTAssertTrue(viewModel.isReadyToAddNewTaskObservable.wrappedValue)
    }
    
    func testNewAskViewViewModelFuncAddNewTask() {
        // Given:
        let viewModel = NewTaskViewViewModel(dataProvider: dataProvider)

        // When:
        viewModel.setupTaskDate(from: .date, with: Date())
        viewModel.setupTaskDate(from: .time, with: Date())
        viewModel.setupTaskInfo(isName: true, value: "testName")
        viewModel.setupTaskInfo(isName: false, value: "testDescription")
        viewModel.addNewTask()
        
        // Then:
        XCTAssertNotNil(dataProvider.addedTask)
    }
    
    // MARK: - TaskDetailViewController:
    func testTaskDetailViewControllerView() {
        // Given:
        let viewModel = TaskDetailViewViewModelStumb(dataProvider: dataProvider, task: Task(id: UUID(), startDate: "", calendarDate: "", name: "", description: ""))
        let viewController = TaskDetailViewController(coordinator: coordinator, viewModel: viewModel)
        
        // When:
        _ = viewController.view
        
        // Then:
        XCTAssertTrue(viewController.isViewLoaded)
    }
    
    func testTaskTaskDetailViewControllerFuncPerformTask() {
        // Given:
        let viewModel = TaskDetailViewViewModelStumb(dataProvider: dataProvider, task: Task(id: UUID(), startDate: "", calendarDate: "", name: "", description: ""))
        let viewController = TaskDetailViewController(coordinator: coordinator, viewModel: viewModel)
        
        // When:
        viewController.performTask(isDelete: true)
        
        // Then:
        XCTAssertTrue(viewModel.isTaskDeleted)
    }
    
    // MARK: - TaskDetailViewViewModel:
    func testTaskDetailViewViewModelFuncDelete() {
        // Given:
        let viewModel = TaskDetailViewViewModel(dataProvider: dataProvider, task: Task(id: UUID(), startDate: "", calendarDate: "", name: "", description: ""))
        
        // When:
        dataProvider.addNew(task: Task(id: UUID(), startDate: "", calendarDate: "", name: "", description: ""))
        viewModel.deleteTask()
        
        // Then:
        XCTAssertTrue(dataProvider.isTaskDeleted)
    }
}

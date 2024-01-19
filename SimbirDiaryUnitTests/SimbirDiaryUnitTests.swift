import XCTest
@testable import SimbirDiary

final class SimbirDiaryUnitTests: XCTestCase {
    // MARK: - Classes:
    let coordinator = MainCoordinatorStumb()
    let dataProvider = DataProviderStumb()
    
    // MARK: - ToDo ViewController:
    func testTextToDoViewControllerView() {
        // Given:
        let viewModel = ToDoViewViewModelStumb(dataProvider: dataProvider)
        let viewController = ToDoViewController(coordinator: coordinator, viewModel: viewModel)
        
        // When:
        _ = viewController.view
        
        // Then:
        XCTAssertTrue(viewController.isViewLoaded)
    }
}

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let databaseManager = RealmManager()
        let dataProvider = DataProvider(databaseManager: databaseManager)
        let viewModel = ToDoViewViewModel(dataProvider: dataProvider)
        let rootViewController = ToDoViewController(viewModel: viewModel)
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

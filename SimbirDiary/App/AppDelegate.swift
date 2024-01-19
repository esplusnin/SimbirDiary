import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        let databaseManager = RealmManager()
        startSetting(databaseManager)
        
        let dataProvider = DataProvider(databaseManager: databaseManager)
        coordinator = AppCoordinator(databaseManager: databaseManager,
                                     dataProvider: dataProvider,
                                     navigator: navigationController)
        coordinator?.start()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    // MARK: - Starts database settings:
    func startSetting(_ database: DatabaseManagerProtocol) {
        let userDefaultsService = UserDefaultsService()
        if !userDefaultsService.wasEnteredBefore {
            database.setupDemonstrationTask()
            userDefaultsService.entry()
        }
    }
}

import Foundation

final class UserDefaultsService {
    
    // MARK: - Classes:
    let userDefaults = UserDefaults.standard
    
    // MARK: - Constants and Variables:
    private(set) var isFirstEntry: Bool {
        get {
            userDefaults.bool(forKey: Resources.UserDefaults.isFirstEntry)
        }
        set {
            userDefaults.setValue(newValue, forKey: Resources.UserDefaults.isFirstEntry)
        }
    }
    
    // MARK: - Public Methods:
    func entry() {
        isFirstEntry.toggle()
    }
}

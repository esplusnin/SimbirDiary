import Foundation

final class UserDefaultsService {
    
    // MARK: - Classes:
    let userDefaults = UserDefaults.standard
    
    // MARK: - Constants and Variables:
    private(set) var wasEnteredBefore: Bool {
        get {
            userDefaults.bool(forKey: Resources.UserDefaults.wasEnteredBefore)
        }
        set {
            userDefaults.setValue(newValue, forKey: Resources.UserDefaults.wasEnteredBefore)
        }
    }
    
    // MARK: - Public Methods:
    func entry() {
        wasEnteredBefore.toggle()
    }
}

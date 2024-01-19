import Foundation

@propertyWrapper
final class Observable<Value> {
    
    // MARK: - Constants and Variables:
    var wrappedValue: Value {
        didSet {
            onChange?(wrappedValue)
        }
    }
    
    var projectedValue: Observable<Value> {
        self
    }
    
    private var onChange: ((Value) -> Void)?
    
    // MARK: - Lifecycle:
    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
    
    // MARK: - Public Methods:
    func bind(action: @escaping (Value) -> Void) {
        self.onChange = action
    }
}

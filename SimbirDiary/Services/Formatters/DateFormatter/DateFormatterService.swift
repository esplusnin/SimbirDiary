import Foundation

final class DateFormatterService: DateFormatterProtocol {
    
    // MARK: - Classes:
    private let dateFormatter = DateFormatter()
    
    // MARK: - Public Methods:
    func getHourValue(from unixValue: String) -> String {
        guard let unixValue = Double(unixValue) else { return "" }
        let date = Date(timeIntervalSince1970: unixValue)
        dateFormatter.dateFormat = "HH"
        let hourValue = dateFormatter.string(from: date)
        
        return hourValue
    }
}

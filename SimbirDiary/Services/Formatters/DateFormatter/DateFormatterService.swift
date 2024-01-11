import Foundation

final class DateFormatterService: DateFormatterProtocol {
    
    // MARK: - Classes:
    private let dateFormatter = DateFormatter()
    
    // MARK: - Public Methods:
    func getHourValue(from unixValue: String) -> String {
        guard let unixValue = Double(unixValue) else { return "" }
        let date = Date(timeIntervalSince1970: Double(Int(unixValue)))
        dateFormatter.dateFormat = "HH"
        let hourValue = dateFormatter.string(from: date)
        
        return hourValue
    }
    
    func getUnixValueString(from date: Date, and hours: Date) -> String {
        let datesUnixValue = convertDateToUnixValue(from: date)
        let timesUnixValue = convertTimeToUnixValue(from: hours)
        let totalUnixValue = datesUnixValue + timesUnixValue
        let datesUnixString = String(totalUnixValue)
        return datesUnixString
    }
    
    // MARK: - Private Methods:
    private func convertDateToUnixValue(from date: Date) -> Double {
        date.timeIntervalSince1970
    }
    
    private func convertTimeToUnixValue(from date: Date) -> Double {
        let hours = Calendar.current.component(.hour, from: date)
        let minutes = Calendar.current.component(.minute, from: date)
        let totalUnixValue = Double(((hours * 60) * 60) + (minutes * 60))
        return totalUnixValue
    }
}

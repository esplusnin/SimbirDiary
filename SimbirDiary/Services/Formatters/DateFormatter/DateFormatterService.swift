import Foundation

final class DateFormatterService: DateFormatterProtocol {
    
    // MARK: - Classes:
    private let dateFormatter = DateFormatter()
    private let hoursDateFormat = "H"
    
    // MARK: - Public Methods:
    func getHourValue(from unixValue: String) -> String {
        guard let unixValue = Double(unixValue) else { return "" }
        let date = Date(timeIntervalSince1970: Double(Int(unixValue)))
        dateFormatter.dateFormat = hoursDateFormat
        let hourValue = dateFormatter.string(from: date)
        
        return hourValue
    }
    
    func getUnixValueString(from date: Date, and hours: Date) -> String {
        let datesUnixValue = convertDateToUnixValue(from: date)
        let timesUnixValue = convertTimeToUnixValue(from: hours)
        let totalUnixValue = datesUnixValue + timesUnixValue
        let dateUnixString = String(totalUnixValue)
        return dateUnixString
    }
    
    // MARK: - Private Methods:
    private func convertDateToUnixValue(from date: Date) -> Double {
        let hoursValue = convertTimeToUnixValue(from: date)
        let dateUnixValue = date.timeIntervalSince1970 - hoursValue
        return dateUnixValue
    }
    
    private func convertTimeToUnixValue(from date: Date) -> Double {
        let hours = Calendar.current.component(.hour, from: date)
        let minutes = Calendar.current.component(.minute, from: date)
        let totalUnixValue = Double(((hours * 60) * 60) + (minutes * 60))
        return totalUnixValue
    }
}

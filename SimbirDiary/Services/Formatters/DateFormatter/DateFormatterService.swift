import Foundation

final class DateFormatterService: DateFormatterProtocol {
    
    // MARK: - Classes:
    private let dateFormatter = DateFormatter()
    
    // MARK: - Constants and Variables:
    private let minutesPerHour: Double = 60
    private let secondsPerMinute: Double = 60
    
    // MARK: - Public Methods:
    func getTimeValue(from unixValue: String, isOnlyHours: Bool) -> String {
        guard let unixValue = Double(unixValue) else { return "" }
        let date = Date(timeIntervalSince1970: Double(Int(unixValue)))
        dateFormatter.dateFormat = isOnlyHours ? Resources.DateFormatter.hoursDateFormat : Resources.DateFormatter.fullTimeFormat
        let hourValue = dateFormatter.string(from: date)
        
        return hourValue
    }
    
    func getDateValue(from unixValue: String) -> String {
        guard let unixValue = Double(unixValue) else { return "" }
        let date = Date(timeIntervalSince1970: Double(Int(unixValue)))
        let realmDate = getRealmDateFormat(from: date)
        return realmDate
    }
    
    func getUnixValueString(from date: Date, and hours: Date) -> String {
        let datesUnixValue = convertDateToUnixValue(from: date)
        let timesUnixValue = convertTimeToUnixValue(from: hours)
        let totalUnixValue = datesUnixValue + timesUnixValue
        let dateUnixString = String(totalUnixValue)
        return dateUnixString
    }
    
    func getRealmDateFormat(from date: Date) -> String {
        dateFormatter.dateFormat = Resources.DateFormatter.realmDateFormat
        let realmDate = dateFormatter.string(from: date)
        return realmDate
    }
    
    func isTheSamedDay(currentDate: Date, taskDate: String) -> Bool {
        let currentDateString = getRealmDateFormat(from: currentDate)
        let taskDateString = getDateValue(from: taskDate)
        return currentDateString == taskDateString
    }
    
    func getDemonstrationUnixValue(with hour: Double) -> String {
        let dateUnixValue = convertDateToUnixValue(from: Date())
        let hoursUnixValue = minutesPerHour * secondsPerMinute * hour
        return String(dateUnixValue + hoursUnixValue)
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
        let totalUnixValue = ((Double(hours) * minutesPerHour) * secondsPerMinute) + (Double(minutes) * secondsPerMinute)
        return totalUnixValue
    }
}

import Foundation

protocol DateFormatterProtocol: AnyObject {
    func getTimeValue(from unixValue: String, isOnlyHours: Bool) -> String
    func getUnixValueString(from date: Date, and hours: Date) -> String
}

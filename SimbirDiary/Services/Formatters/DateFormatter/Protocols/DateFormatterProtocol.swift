import Foundation

protocol DateFormatterProtocol: AnyObject {
    func getTimeValue(from unixValue: String, isOnlyHours: Bool) -> String
    func getDateValue(from unixValue: String) -> String
    func getUnixValueString(from date: Date, and hours: Date) -> String
    func getRealmDateFormat(from date: Date) -> String
}

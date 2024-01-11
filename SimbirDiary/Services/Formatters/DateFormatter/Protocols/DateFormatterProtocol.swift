import Foundation

protocol DateFormatterProtocol: AnyObject {
    func getHourValue(from unixValue: String) -> String
    func getUnixValueString(from date: Date, and hours: Date) -> String
}

import Foundation

protocol DateFormatterProtocol: AnyObject {
    func getHourValue(from unixValue: String) -> String
}

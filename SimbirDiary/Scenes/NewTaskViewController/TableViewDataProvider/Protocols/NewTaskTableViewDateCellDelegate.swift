import Foundation

protocol NewTaskTableViewDateCellDelegate: AnyObject {
    func setupDate(from type: NewTaskCellType, with value: Date)
}

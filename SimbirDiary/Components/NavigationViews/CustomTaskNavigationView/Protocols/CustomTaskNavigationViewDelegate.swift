import Foundation

protocol CustomTaskNavigationViewDelegate: AnyObject {
    func dismiss()
    func performTask(isDelete: Bool) 
}

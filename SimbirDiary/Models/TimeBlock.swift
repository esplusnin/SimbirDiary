import Foundation

struct TimeBlock: Comparable {
    let name: String
    var tasks: [Task]
    
    static func < (lhs: TimeBlock, rhs: TimeBlock) -> Bool {
        guard let firstELement = lhs.name.first,
              let secondElement = rhs.name.first else { return false }
        
        guard let firstIntElement = Int(String(firstELement)),
              let secondIntElement = Int(String(secondElement)) else { return false }

        return firstIntElement < secondIntElement
    }
}

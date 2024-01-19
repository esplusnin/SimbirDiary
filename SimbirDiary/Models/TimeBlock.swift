import Foundation

struct TimeBlock: Comparable {
    let name: String
    var tasks: [Task]
}

// MARK: - Comparable Extension:
extension TimeBlock {
    static func < (lhs: TimeBlock, rhs: TimeBlock) -> Bool {
        let shortNameDigits = 4
        let lhsName = lhs.name
        let rhsName = rhs.name
        
        if lhsName.count != rhsName.count {
            return lhsName.count < rhsName.count
        }
        
        if lhsName.count == shortNameDigits {
            guard let lhsFirstCharacter = lhsName.first,
                  let rhsFirstCharacter = rhsName.first,
                  let lhsFirstDigit = Int(String(lhsFirstCharacter)),
                  let rhsFirstDigit = Int(String(rhsFirstCharacter)) else { return false }
            
            return lhsFirstDigit < rhsFirstDigit
        }
        
        guard let lhsFirstCharacter = lhsName.first,
              let lhsSecondCHaracter = lhsName.dropFirst().first,
              let rhsFirstCharacter = rhsName.first,
              let rhsSecondCharacter = rhsName.dropFirst().first,
              let lhsSum = Int(String(lhsFirstCharacter) + String(lhsSecondCHaracter)),
              let rhsSum = Int(String(rhsFirstCharacter) + String(rhsSecondCharacter))  else { return false }
        
        return lhsSum < rhsSum
    }
}

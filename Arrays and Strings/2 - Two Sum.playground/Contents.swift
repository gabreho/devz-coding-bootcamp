import Foundation

class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        // value: index
        var complements: [Int: Int] = [:]
        
        for (i, n) in nums.enumerated() {
            let diff = target - n
            if let diffIndex = complements[diff] {
                return [i, diffIndex]
            }
            
            complements[n] = i
        }
        
        return []
    }
}

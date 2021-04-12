import Foundation

class Solution {
    
    // Pascal's Triangle - returns the numRows-th index of a row of a pascal triangle
    func generate(_ numRows: Int) -> [Int] {
        
        var rows: [[Int]] = []
        
        for n in 0...numRows {
            var row = [Int](repeating: 0, count: n + 1)
            
            // the first and last element of each row is always 1
            row[0] = 1
            row[row.count - 1] = 1
            
            if row.count > 1 {
                for i in 1..<row.count - 1 {
                    row[i] = rows[n - 1][i - 1] + rows[n - 1][i]
                }
            }
            
            rows.append(row)
        }
        
        return rows.last ?? []
    }
}

let sol = Solution()
print(sol.generate(4))

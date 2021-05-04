import Foundation

// Represents a Node
class Employee: Hashable {
    
    typealias OneOnOneTime = (cost: Int, employee: Employee)
    
    var employeeId: String
    var subordinates: [OneOnOneTime]
    
    init(employeeId: String) {
        self.employeeId = employeeId
        subordinates = []
    }
    
    // Equatable
    static func == (lhs: Employee, rhs: Employee) -> Bool {
        lhs.employeeId == rhs.employeeId
    }
    
    // Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(employeeId)
    }
}


final class HRTree {
    
    var ceo: Employee
    
    init(ceo: Employee) {
        self.ceo = ceo
    }
    
    func addEmployee(_ employee: Employee, managerId: String, cost: Int) {
        guard let manager = findEmployee(id: managerId) else { return }
        addEmployee(employee, manager: manager, cost: cost)
    }
    
    func addEmployee(_ employee: Employee, manager: Employee?, cost: Int) {
        let manager = manager ?? ceo
        manager.subordinates.append((cost: cost, employee: employee))
    }
    
    func findEmployee(id: String) -> Employee? {
        if ceo.employeeId == id {
            return ceo
        }
        return findEmployee(id: id, node: ceo)
    }

    private func findEmployee(id: String, node: Employee?) -> Employee? {
        guard let node = node else {
            return nil
        }
        
        if node.employeeId == id {
            return node
        }
        
        for (_, subordinate) in node.subordinates {
            let found = findEmployee(id: id, node: subordinate)
            if let found = found {
                return found
            }
        }

        return nil
    }

    func calculatePropagationTime() -> Int {
        return height(node: self.ceo)
    }
    
    private func height(node: Employee?) -> Int {
        guard
            let node = node,
            let longestOneOnOne: Employee.OneOnOneTime = node.subordinates.sorted(by: { $0.cost > $1.cost }).first
        else {
            return 0
        }
        return longestOneOnOne.cost + height(node: longestOneOnOne.employee)
    }
}


let pitt = Employee(employeeId: "pitt")
let ivan = Employee(employeeId: "ivan")
let gabriel = Employee(employeeId: "gabriel")
let alberto = Employee(employeeId: "alberto")
let yesi = Employee(employeeId: "yesi")
let eduardo = Employee(employeeId: "eduardo")

let devz = HRTree(ceo: eduardo)


devz.addEmployee(ivan, manager: eduardo, cost: 5)
devz.addEmployee(pitt, manager: eduardo, cost: 4)
devz.addEmployee(gabriel, manager: ivan, cost: 10)
devz.addEmployee(yesi, manager: ivan, cost: 2)
devz.addEmployee(alberto, manager: gabriel, cost: 6)

/*
 
              eduardo
              /5    \4
            ivan     pitt
           10/ \2
       gabriel  yesi
           /6
    alberto
  
 */

let totalTime = devz.calculatePropagationTime() // 21

import Foundation

// Represents a Node
class Employee: Hashable {
    var employeeId: String
    var subordinates: Set<Employee>
    
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
    
    func addEmployee(_ employee: Employee, managerId: String) {
        guard let manager = findEmployee(id: managerId) else { return }
        addEmployee(employee, manager: manager)
    }
    
    func addEmployee(_ employee: Employee, manager: Employee?) {
        let manager = manager ?? ceo
        manager.subordinates.insert(employee)
    }
    
    func findEmployee(id: String) -> Employee? {
        if ceo.employeeId == id {
            return ceo
        }
        return findEmployee(id: id, node: ceo)
    }
    
    func isManager(_ employeeId: String, subEmployeeId: String) -> Bool {
        guard let manager = findEmployee(id: employeeId) else { return false }
        for employee in manager.subordinates {
            if employee.employeeId == subEmployeeId {
                return true
            }
        }
        return false
    }
    
    func isInManagementChain(_ employeeId: String, subEmployeeId: String) -> Bool {
        guard let manager = findEmployee(id: employeeId) else { return false }
        return findEmployee(id: subEmployeeId, node: manager) != nil
    }
    
    func getSubemployees(_ employeeId: String) -> [Employee] {
        guard let employee = findEmployee(id: employeeId) else { return [] }
        var employees: [Employee] = []
        getSubemployees(employee, employees: &employees)
        return employees
    }
    
    private func getSubemployees(_ employee: Employee, employees: inout [Employee]) {
        employees.append(contentsOf: employee.subordinates)
        for e in employee.subordinates {
            getSubemployees(e, employees: &employees)
        }
    }
    
    private func findEmployee(id: String, node: Employee?) -> Employee? {
        guard let node = node else {
            return nil
        }
        
        if node.employeeId == id {
            return node
        }
        
        for subordinate in node.subordinates {
            let found = findEmployee(id: id, node: subordinate)
            if let found = found {
                return found
            }
        }

        return nil
    }
}


let pitt = Employee(employeeId: "pitt")
let ivan = Employee(employeeId: "ivan")
let gabriel = Employee(employeeId: "gabriel")
let alberto = Employee(employeeId: "alberto")
let yesi = Employee(employeeId: "yesi")
let eduardo = Employee(employeeId: "eduardo")

let devz = HRTree(ceo: eduardo)


devz.addEmployee(ivan, manager: eduardo)
devz.addEmployee(pitt, manager: eduardo)
devz.addEmployee(gabriel, manager: ivan)
devz.addEmployee(yesi, manager: ivan)
devz.addEmployee(alberto, manager: gabriel)

/*
 
              eduardo
               /    \
            ivan     pitt
             / \
       gabriel  yesi
           /
    alberto
 
 
 */

let isIvanManagerOfYesi = devz.isManager("ivan", subEmployeeId: "yesi") // true
let isAlbertoManagerOfPitt = devz.isManager("alberto", subEmployeeId: "pitt") // false


let isAlbertoManagerOfEduardo = devz.isInManagementChain("eduardo", subEmployeeId: "alberto") // true
let isYesiManagerOfPitt = devz.isInManagementChain("yesi", subEmployeeId: "pitt") // false

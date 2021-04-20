import Foundation


final class Node<T: Hashable> {
    var value: T
    var next: Node<T>?

    init(value: T) {
        self.value = value
    }
}

final class LinkedList<T: Hashable> {
    fileprivate var head: Node<T>?

    var isEmpty: Bool {
        return head == nil
    }

    var first: Node<T>? {
        return head
    }
    
    var formatted: String {
        var node = head
        var description = ""
        while node != nil {
            description = "\(description)\(node!.value)"
            
            if node?.next != nil {
                description = "\(description) → "
            }
            
            node = node?.next
        }
        return description
    }
}

extension LinkedList {
    convenience init(array: Array<T>) {
        self.init()
        head = nil
        
        var node: Node<T>? = nil
        for el in array {
            if head == nil {
                head = Node(value: el)
                node = head
                continue
            }
            node?.next = Node(value: el)
            node = node?.next
        }
    }
}

// Escribe un programa borre elementos duplicados de un Linked List
extension LinkedList {
    func removeDuplicates() {
        guard let head = head else {
            return
        }
        var prev = head
        var node: Node! = head.next
        var values: Set<T> = [head.value]
        while node != nil {
            let val = node!.value
            if values.contains(val) {
                prev.next = node.next
            } else {
                values.insert(val)
                prev = node
            }
            
            node = node.next
        }
    }
}

do {
    let vals = [4, 5, 9, 0, 5, 1, 2]
    let linkedList = LinkedList(array: vals)
    linkedList.removeDuplicates()
    assert(linkedList.formatted == "4 → 5 → 9 → 0 → 1 → 2")
}

do {
    let vals = [1, 2, 3, 3, 2, 1]
    let linkedList = LinkedList(array: vals)
    linkedList.removeDuplicates()
    assert(linkedList.formatted == "1 → 2 → 3")
}


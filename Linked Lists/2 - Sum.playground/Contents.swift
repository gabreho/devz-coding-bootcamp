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

/*
 Problema #2Tienes dos números representados por dos linked lists donde el valor de cada nodo representa un dígito. Los dígitos están guardados de manera inversa, de manera que las unidades está en el primer nodo (head), las decenas en el segundo nodo, etc.Escribe un programa que dado dos linked lists, sume los dos números que representan y regrese esa suma representada también en un linked list
 */
extension LinkedList {
}

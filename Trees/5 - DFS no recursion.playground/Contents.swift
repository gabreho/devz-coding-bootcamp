import Foundation

class Node<T: Comparable> {
    var value: T
    var left: Node? = nil
    var right: Node? = nil
    
    init(value: T) {
        self.value = value
    }
}

class BST<T: Comparable> {
    
    var root: Node<T>?
    
    init() {
        self.root = nil
    }
    
    convenience init(array: [T]) {
        precondition(array.count > 0)
        self.init()
        for value in array {
            insert(value: value)
        }
    }
    
    func insert(value: T) {
        self.root = insert(node: root, value: value)
    }
    
    private func insert(node: Node<T>?, value: T) -> Node<T> {
        guard let node = node else {
            return Node(value: value)
        }
        
        if value < node.value {
            node.left = insert(node: node.left, value: value)
        } else if value > node.value {
            node.right = insert(node: node.right, value: value)
        }
        
        return node
    }
    
    // non recursive DFS traversal
    func inOrder() -> [T] {
        guard let root = root else {
            return []
        }
        var output: [T] = []
        
        var stack: [Node<T>] = [root]
        
        while !stack.isEmpty {
            let node = stack.last! // peek()
            if let left = node.left {
                stack.append(left)
                continue
            }
            
            output.append(node.value)
            stack.removeLast() // pop()
            
            if let right = node.right {
                stack.append(right)
                continue
            }
        }
        
        
        return output
    }
}

let orderedValues = [1, 2, 3, 4, 6, 7, 8, 9]
let bst = BST(array: orderedValues)

let inOrderedValues = bst.inOrder()

assert(orderedValues == inOrderedValues)

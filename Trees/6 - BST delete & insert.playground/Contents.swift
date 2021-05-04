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
    
    func inOrder() -> [T] {
        var output: [T] = []
        inOrder(root, output: &output)
        return output
    }
    
    private func inOrder(_ node: Node<T>?, output: inout [T]) {
        guard let node = node else {
            return
        }
        
        inOrder(node.left, output: &output)
        output.append(node.value)
        inOrder(node.right, output: &output)
    }
}

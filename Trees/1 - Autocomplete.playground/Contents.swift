import Foundation


class Node {
    var children: [Character: Node]
    let isTerminal: Bool
    
    init(isTerminal: Bool = false) {
        self.children = [:]
        self.isTerminal = isTerminal
    }
    
    
}

class Autocomplete {
    private let root: Node
    
    private init() {
        self.root = Node()
    }
    
    static func build(words: [String]) -> Autocomplete {
        let autocomplete = Autocomplete()
        for word in words {
            autocomplete.addWord(word)
        }
        return autocomplete
    }

    func addWord(_ word: String) {
        var node = root
        for i in 0..<word.count {
            let index = word.index(word.startIndex, offsetBy: i)
            let character = word[index]
            let endOfWord = i == word.count - 1
            if let nextNode = node.children[character] {
                node = nextNode
            } else {
                let newNode = Node(isTerminal: endOfWord)
                node.children[character] = newNode
                node = newNode
            }
        }
    }
    
    /// Returns all valid next characters for a given word.
    /// - Parameter word: Prefix
    /// - Returns: List of all possible next characters after the given word.
    func next(word: String) -> [Character] {
        guard let node = findLastNode(word) else {
            return []
        }
        return Array(node.children.keys)
    }

    
    /// Returns all valid autocomplete options for a given word
    /// - Parameter prefix: word to autocomplete
    /// - Returns: List of autocomplete options
    func availableWords(_ prefix: String) -> [String] {
        var words: [String] = []
        
        // Find node where it ends
        if let node = findLastNode(prefix) {
            availableWords(node: node, currentWord: prefix, words: &words)
        }
        
        return words
    }

    private func availableWords(
        node: Node,
        currentWord: String,
        words: inout [String]
    ) {
        if node.isTerminal {
            words.append(currentWord)
        }
        
        if node.children.isEmpty {
            return
        }

        for (char, childNode) in node.children {
            availableWords(node: childNode, currentWord: currentWord + String(char), words: &words)
        }

    }
    
    private func findLastNode(_ prefix: String) -> Node? {
        var node = root
        for i in 0..<prefix.count {
            let index = prefix.index(prefix.startIndex, offsetBy: i)
            if let nextNode = node.children[prefix[index]] {
                if i == prefix.count - 1 {
                    return nextNode
                }
                node = nextNode
            } else {
                return nil
            }
        }
        return nil
    }
}



let words = ["i", "in", "inn", "a", "tea", "ted", "ten", "to"]
let autocomplete = Autocomplete.build(words: words)
let nextChars = autocomplete.next(word: "te")
let wordOptions = autocomplete.availableWords("t")

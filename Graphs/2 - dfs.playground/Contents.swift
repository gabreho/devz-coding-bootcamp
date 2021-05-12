import Foundation

let pokemonGraph = [
    "A": ["B", "C"],
    "B": ["D", "E"],
    "C": ["F"],
    "D": ["G"],
    "E": ["F", "G"],
    "F": ["G", "H"],
]


func dfs(graph: [String: [String]], start: String, end: String) -> [String]? {
    var stack: [(String, [String])] = [(start, [start])]
    var visited = Set<String>()
    
    while !stack.isEmpty {
        let (node, path) = stack.removeLast()

        if visited.contains(node) {
            continue
        }
        
        if node == end {
            return path
        }

        visited.insert(node)
        for neighbour in graph[node, default: []] {
            stack.append((neighbour, path + [neighbour]))
        }
    }

    return nil
}

let path = dfs(graph: pokemonGraph, start: "A", end: "G")

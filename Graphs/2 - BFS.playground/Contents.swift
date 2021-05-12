import Foundation

let pokemonGraph = [
    "A": ["B", "C"],
    "B": ["D", "E"],
    "C": ["F"],
    "D": ["G"],
    "E": ["F", "G"],
    "F": ["G", "H"],
]

func bfs(graph: [String: [String]], start: String, end: String) -> [String]? {
    var queue = [[start]]
    var visited = Set<String>()
    
    while !queue.isEmpty {
        let path = queue.removeLast()

        guard let node = path.last else {
            continue
        }

        if node == end {
            return path
        }

        if visited.contains(node) {
            continue
        }

        for neighbour in graph[node, default: []] {
            let newPath = path + [neighbour]
            queue.append(newPath)
        }
        visited.insert(node)
    }

    return nil
}

let path = bfs(graph: pokemonGraph, start: "A", end: "G")

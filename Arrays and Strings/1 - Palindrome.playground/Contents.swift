import Foundation


func isPalindrome(_ word: String) -> Bool {
    let allowedCharacters = CharacterSet.punctuationCharacters.union(CharacterSet.whitespacesAndNewlines)
    
    let chars = word
        .folding(options: .diacriticInsensitive, locale: nil)
        .filter { $0.unicodeScalars.contains(where: { !allowedCharacters.contains($0)}) }
        .map { String($0) }
    
    var i = 0
    var j = chars.count - 1
    
    while i < j {
        if chars[i].lowercased() != chars[j].lowercased() {
            return false
        }
        i += 1
        j -= 1
    }
    
    return true
}

// Does not support special characters.
func isPalindrome2(_ word: String) -> Bool {
    
    let chars = Array(word)

    var i = 0
    var j = chars.count - 1
    
    while i < j {
        if !chars[i].isLetter && !chars[i].isNumber {
            i += 1
        } else if !chars[j].isLetter && !chars[j].isNumber {
            j -= 1
        } else if String(chars[i]).lowercased() == String(chars[j]).lowercased() {
            i += 1; j -= 1;
        } else {
            return false
        }
    }
    
    return true
}

assert(isPalindrome("La ruta nos aportó otro paso natural") == true)
assert(isPalindrome("Claramente, esto no es un palíndromo") == false)
assert(isPalindrome("Anita lava la tina") == true)

// No special characters
assert(isPalindrome2("La ruta nos aporto otro paso natural") == true)
assert(isPalindrome2("Claramente, esto no es un palindromo") == false)
assert(isPalindrome2("Anita lava la tina") == true)

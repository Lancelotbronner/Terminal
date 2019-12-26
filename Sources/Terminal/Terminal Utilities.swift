extension Terminal {
    
    //MARK: - Predicates
    
    internal static func isLetter(_ key: Int) -> Bool {
        65...90 ~= key
    }
    
    internal static func isNumber(_ key: Int) -> Bool {
        48...57 ~= key
    }
    
    internal static func isLetter(_ str: String) -> Bool {
        "A"..."Z" ~= str
    }
    
    internal static func isNumber(_ str: String) -> Bool {
        "0"..."9" ~= str
    }
    
    //MARK: - Conversion
    
    @inlinable
    internal static func unicode(_ code: Int) -> Unicode.Scalar {
        Unicode.Scalar(code) ?? "\0"
    }
    
    @inlinable
    internal static func char(_ code: UInt8) -> Character {
        Character(UnicodeScalar(code))
    }
    
}

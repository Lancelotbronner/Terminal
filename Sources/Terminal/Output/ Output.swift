//
//  File.swift
//  
//
//  Created by Christophe Bronner on 15/06/2020.
//

public struct Output {
    private init() { }
    
    //MARK: Properties
    
    public static var isIndentationEnabled = true
    public private(set) static var indentationLevel = 0
    
    //MARK: Indentation
    
    public static var indent: String { String(repeating: " ", count: 4 * indentationLevel) }
    
    public static func left() {
        indentationLevel = max(0, indentationLevel - 1)
    }
    
    public static func right() {
        indentationLevel += 1
    }
    
    public static func leftmost() {
        indentationLevel = 0
    }
    
    public static func withIndent(_ f: () -> Void) {
        isIndentationEnabled = true
        f()
        isIndentationEnabled = false
    }
    
    public static func withoutIndent(_ f: () -> Void) {
        isIndentationEnabled = false
        f()
        isIndentationEnabled = true
    }
    
    //MARK: Write
    
    public static func write(_ str: String) {
        print(isIndentationEnabled ? indent + str : str, terminator: "")
    }
	
    public static func writeln(_ str: String) {
        print(isIndentationEnabled ? indent + str : str)
    }
    
    //MARK: Clear
    
    /// Clears the screen
    public static func clear() {
        (Sequence.make(.csi, "2J", .none)
            + Sequence.make(.csi, "H", .none)
            + Sequence.make(.csi, "3J", .none))
            .print()
    }
    
}

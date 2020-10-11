//
//  File.swift
//  
//
//  Created by Christophe Bronner on 17/04/2020.
//

//MARK: - Sequence

struct Sequence {
    private init() { }
    
    //MARK: Methods
    
    static func make(_ escape: Escape, _ components: [String], _ end: End) -> String {
        escape.rawValue + components.joined(separator: ";") + end.rawValue
    }
    
    static func make(_ escape: Escape, _ body: String, _ end: End) -> String {
        escape.rawValue + body + end.rawValue
    }
    
    static func make(_ escape: Escape, _ end: End, _ components: String...) -> String {
        escape.rawValue + components.joined(separator: ";") + end.rawValue
    }
    
}

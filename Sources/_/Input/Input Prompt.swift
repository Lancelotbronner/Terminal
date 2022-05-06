//
//  File.swift
//  
//
//  Created by Christophe Bronner on 15/06/2020.
//

extension Input {
    
    //MARK: Value
    
    public static func read<T: LosslessStringConvertible>() -> T {
        read(map: T.init)
    }
    
    public static func read(from choices: [String]) -> String {
        read(until: { choices.contains($0) })
    }
	
	public static func read(from choices: String...) -> String {
		read(from: choices)
	}
    
    //MARK: Conditionals
    
    public static func read(until condition: (String) -> Bool) -> String {
        while true {
            let str = readln()
            if condition(str) { return str }
        }
    }
    
    public static func read<T>(map function: (String) -> T?) -> T {
        var tmp: T?
        while tmp == nil { tmp = function(readln()) }
        return tmp!
    }
    
}

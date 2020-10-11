//
//  File.swift
//  
//
//  Created by Christophe Bronner on 15/06/2020.
//

extension Input {
    
    //MARK: Value
    
    public static func prompt<T: LosslessStringConvertible>() -> T {
        prompt(map: T.init)
    }
    
    public static func prompt(_ choices: [String]) -> String {
        prompt(until: { choices.contains($0) })
    }
    
    //MARK: Conditionals
    
    public static func prompt(until condition: (String) -> Bool) -> String {
        while true {
            let str = prompt()
            if condition(str) { return str }
        }
    }
    
    public static func prompt<T>(map function: (String) -> T?) -> T {
        var tmp: T?
        while tmp == nil { tmp = function(prompt()) }
        return tmp!
    }
    
}

//
//  File.swift
//  
//
//  Created by Christophe Bronner on 11/06/2020.
//

import Cocoa
import Darwin

//MARK: - Terminal Input

public struct Input {
    private init() { }
    
    //MARK: Properties
    
    private static let inputGroup = DispatchGroup()
    
    //MARK: Current Input
    
    public static var isShift: Bool { NSEvent.modifierFlags.contains(.shift) }
    public static var isCommand: Bool { NSEvent.modifierFlags.contains(.command) }
    public static var isControl: Bool { NSEvent.modifierFlags.contains(.control) }
    public static var isOption: Bool { NSEvent.modifierFlags.contains(.option) }
    public static var isFunction: Bool { NSEvent.modifierFlags.contains(.function) }
    public static var isCapsLock: Bool { NSEvent.modifierFlags.contains(.capsLock) }
    
    //MARK: Wait for Input
    
    public static func read() -> Key {
        .init(code())
    }
    
    public static func readln() -> String {
        Terminal.withEcho { readLine() ?? "" }
    }
    
    //MARK: Utilities
    
    /// Waits for the next character to be pressed
    private static func code() -> Data {
        inputGroup.enter()
        
        var data: Data?
        FileHandle.standardInput.readabilityHandler = { file in
            data = file.availableData
            inputGroup.leave()
        }
        
        inputGroup.wait()
        return data!
    }
    
}

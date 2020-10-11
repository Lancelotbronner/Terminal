//
//  File.swift
//  
//
//  Created by Christophe Bronner on 14/06/2020.
//

import Cocoa

//MARK: - Keypress

extension Input {
    public struct Keypress {
        
        //MARK: Properties
        
        public let key: Key
        
        public let shift: Bool
        public let command: Bool
        public let control: Bool
        public let option: Bool
        public let function: Bool
        public let capsLock: Bool
        
        //MARK: Computed Properties
        
        public var character: Character? {
            guard var char = key.character else { return nil }
            if shift || capsLock { char = char.uppercased().first! }
            return char
        }
        
    }
}

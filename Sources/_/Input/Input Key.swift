//
//  File.swift
//  
//
//  Created by Christophe Bronner on 11/06/2020.
//

import Foundation

//MARK: - Key

public struct Key: Equatable {
    
    //MARK: Constants
    
    public static let a = Key(0x61)
    public static let b = Key(0x62)
    public static let c = Key(0x63)
    public static let d = Key(0x64)
    public static let e = Key(0x65)
    public static let f = Key(0x66)
    public static let g = Key(0x67)
    public static let h = Key(0x68)
    public static let i = Key(0x69)
    public static let j = Key(0x6a)
    public static let k = Key(0x6b)
    public static let l = Key(0x6c)
    public static let m = Key(0x6d)
    public static let n = Key(0x6e)
    public static let o = Key(0x6f)
    public static let p = Key(0x70)
    public static let q = Key(0x71)
    public static let r = Key(0x72)
    public static let s = Key(0x73)
    public static let t = Key(0x74)
    public static let u = Key(0x75)
    public static let v = Key(0x76)
    public static let w = Key(0x77)
    public static let x = Key(0x78)
    public static let y = Key(0x79)
    public static let z = Key(0x7a)
    
    public static let n0 = Key(0x30)
    public static let n1 = Key(0x31)
    public static let n2 = Key(0x32)
    public static let n3 = Key(0x33)
    public static let n4 = Key(0x34)
    public static let n5 = Key(0x35)
    public static let n6 = Key(0x36)
    public static let n7 = Key(0x37)
    public static let n8 = Key(0x38)
    public static let n9 = Key(0x39)
    
    public static let tilde = Key(0x60)
    public static let backtick = Key(0x60)
    
    public static let minus = Key(0x2d)
    public static let underscore = Key(0x2d)
    public static let plus = Key(0x3d)
    public static let equal = Key(0x3d)
    
    public static let leftBracket = Key(0x5b)
    public static let rightBracket = Key(0x5c)
    public static let pipe = Key(0x3b)
    public static let backslash = Key(0x3b)
    
    public static let colon = Key(0x27)
    public static let semicolon = Key(0x27)
    public static let quote = Key(0x2c)
    public static let doubleQuote = Key(0x2c)
    
    public static let lowerThan = Key(0x2c)
    public static let comma = Key(0x2c)
    public static let higherThan = Key(0x2e)
    public static let dot = Key(0x2e)
    public static let interogation = Key(0x2f)
    public static let slash = Key(0x2f)
    
    public static let leftArrow = Key(0xd)
    public static let upArrow = Key(0xd)
    public static let downArrow = Key(0xd)
    public static let rightArrow = Key(0xd)
    
    public static let esc = Key(0xd)
    public static let `return` = Key(0xd)
    public static let delete = Key(0xd)
    
    //MARK: Properties
    
    public let code: Int
    
    //MARK: Computed Properties
    
    public var character: Character? {
        let scalar = Unicode.Scalar(code)
        return scalar == nil ? nil : Character(scalar!)
    }
    
    public var hex: String { String(code, radix: 16) }
    
    public var data: Data { withUnsafeBytes(of: code) { Data($0) } }
    public var nsdata: NSData { data as NSData }
    
    //MARK: Initialization
    
    init(_ code: Int) {
        self.code = code
    }
    
    init(_ data: Data) {
        var dest = 0
        _ = withUnsafeMutableBytes(of: &dest) { data.copyBytes(to: $0) }
        code = dest
    }
    
}

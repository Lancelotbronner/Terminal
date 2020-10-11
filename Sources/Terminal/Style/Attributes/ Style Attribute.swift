//
//  File.swift
//  
//
//  Created by Christophe Bronner on 11/06/2020.
//

//MARK: - Style Attribute

public protocol StyleAttribute: Hashable {
    
    /// Applies the modifier immediatly
    func apply()
    
    /// Resets the modifier to its default value immediatly
    static func reset()
    
}

extension StyleAttribute {
    
    internal static func sequence(_ i: Int) {
        Sequence.make(.csi, i.description, .textStyle).print()
    }
    
}

//MARK: - Multi-Value Attribute

public protocol MultiValueStyleAttribute: StyleAttribute {
    
    /// The modifier's default value
    static var `default`: Self { get }
    
}

protocol _MultiStyleAttribute: MultiValueStyleAttribute {
    
    var rawValue: Int { get }
    
}

extension _MultiStyleAttribute {
    
    //MARK: Properties
    
    static var resetSequence: String { Self.default.sequence }
    
    var sequence: String { Sequence.make(.csi, rawValue.description, .textStyle) }
    
    //MARK: Methods
    
    @inline(__always)
    public static func reset() {
        Self.default.apply()
    }
    
    public func apply() {
        guard Terminal.isStyleEnabled else { return }
        sequence.print()
    }
    
}

//MARK: - Binary-Value Attribute

public protocol BinaryValueStyleAttribute {
    
    /// Wether the modifier is currently in effect
    static var isActive: Bool { get }
    
    /// Makes it the correct value to be active or not
    init(active: Bool)
    
}

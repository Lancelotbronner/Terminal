//
//  File.swift
//  
//
//  Created by Christophe Bronner on 10/06/2020.
//

//MARK: - Style

public struct Style {
    
    //MARK: Static Properties
    
    public static var `default`: Style { .init() }
    
    public internal(set) static var current = Style()
    
    //MARK: Properties
    
    // Font
    
    public var weight: Weight?
    public var italic = false
    public var underline = false
    public var blink = false
    public var reverse = false
    public var hidden = false
    
    // Colors
    
    public var foreground = Color.normal
    public var background = Color.normal
    
    //MARK: Initialization
    
    private init() { }
    
    //MARK: Static Methods
    
    public static func reset() {
        attribute(Constants.RESET_ALL)
    }
    
    public static func bold(_ active: Bool) {
        if active { attribute(Constants.BOLD) }
        else { attribute(Constants.RESET_BOLD) }
    }
    
    public static func dim(_ active: Bool) {
        if active { attribute(Constants.DIM) }
        else { attribute(Constants.RESET_DIM) }
    }
    
    public static func italic(_ active: Bool) {
        if active { attribute(Constants.ITALIC) }
        else { attribute(Constants.RESET_ITALIC) }
    }
    
    public static func underline(_ active: Bool) {
        if active { attribute(Constants.UNDERLINE) }
        else { attribute(Constants.RESET_UNDERLINE) }
    }
    
    public static func blink(_ active: Bool) {
        if active { attribute(Constants.BLINK) }
        else { attribute(Constants.RESET_BLINK) }
    }
    
    public static func reverse(_ active: Bool) {
        if active { attribute(Constants.REVERSE) }
        else { attribute(Constants.RESET_REVERSE) }
    }
    
    public static func hidden(_ active: Bool) {
        if active { attribute(Constants.HIDDEN) }
        else { attribute(Constants.RESET_HIDDEN) }
    }
    
    public static func foreground(_ color: Color) {
        switch color {
        case .normal: attribute(Constants.RESET_FOREGROUND)
        case .black: attribute(Constants.FOREGROUND_BLACK)
        case .red: attribute(Constants.FOREGROUND_RED)
        case .green: attribute(Constants.FOREGROUND_GREEN)
        case .yellow: attribute(Constants.FOREGROUND_YELLOW)
        case .blue: attribute(Constants.FOREGROUND_BLUE)
        case .magenta: attribute(Constants.FOREGROUND_MAGENTA)
        case .cyan: attribute(Constants.FOREGROUND_CYAN)
        case .white: attribute(Constants.FOREGROUND_WHITE)
        case .lightBlack: attribute(Constants.FOREGROUND_LIGHT_BLACK)
        case .lightRed: attribute(Constants.FOREGROUND_LIGHT_RED)
        case .lightGreen: attribute(Constants.FOREGROUND_LIGHT_GREEN)
        case .lightYellow: attribute(Constants.FOREGROUND_LIGHT_YELLOW)
        case .lightBlue: attribute(Constants.FOREGROUND_LIGHT_BLUE)
        case .lightMagenta: attribute(Constants.FOREGROUND_LIGHT_MAGENTA)
        case .lightCyan: attribute(Constants.FOREGROUND_LIGHT_CYAN)
        case .lightWhite: attribute(Constants.FOREGROUND_LIGHT_WHITE)
        }
    }
    
    public static func background(_ color: Color) {
        switch color {
        case .normal: attribute(Constants.RESET_BACKGROUND)
        case .black: attribute(Constants.BACKGROUND_BLACK)
        case .red: attribute(Constants.BACKGROUND_RED)
        case .green: attribute(Constants.BACKGROUND_GREEN)
        case .yellow: attribute(Constants.BACKGROUND_YELLOW)
        case .blue: attribute(Constants.BACKGROUND_BLUE)
        case .magenta: attribute(Constants.BACKGROUND_MAGENTA)
        case .cyan: attribute(Constants.BACKGROUND_CYAN)
        case .white: attribute(Constants.BACKGROUND_WHITE)
        case .lightBlack: attribute(Constants.BACKGROUND_LIGHT_BLACK)
        case .lightRed: attribute(Constants.BACKGROUND_LIGHT_RED)
        case .lightGreen: attribute(Constants.BACKGROUND_LIGHT_GREEN)
        case .lightYellow: attribute(Constants.BACKGROUND_LIGHT_YELLOW)
        case .lightBlue: attribute(Constants.BACKGROUND_LIGHT_BLUE)
        case .lightMagenta: attribute(Constants.BACKGROUND_LIGHT_MAGENTA)
        case .lightCyan: attribute(Constants.BACKGROUND_LIGHT_CYAN)
        case .lightWhite: attribute(Constants.BACKGROUND_LIGHT_WHITE)
        }
    }
    
    //MARK: Methods
    
    public func apply() {
        if let weight = weight {
            switch weight {
            case .bold: Style.bold(true)
            case .dim: Style.dim(true)
            }
        }
        
        Style.italic(italic)
        Style.underline(underline)
        Style.blink(blink)
        Style.reverse(reverse)
        Style.hidden(hidden)
        Style.foreground(foreground)
        Style.background(background)
    }
    
    //MARK: Utilities
    
    internal static func attribute(_ i: Int) {
        guard Terminal.isStyleEnabled else { return }
        Sequence.make(.csi, i.description, .textStyle).print()
    }
    
}


//MARK: - Attribute Protocol

protocol TerminalStyle: CustomStringConvertible {
    var rawValue: UInt8 { get }
}

extension TerminalStyle {
    var code: UInt8 { rawValue }
    public var description: String { code.description }
}

extension Terminal {
    
    //MARK: - Colors
    
    public enum Background: UInt8, TerminalStyle {
        case black = 40
        case red
        case green
        case yellow
        case blue
        case magenta
        case cyan
        case white
        case `default` = 49
    }
    
    public enum Foreground: UInt8, TerminalStyle {
        case black = 30
        case red
        case green
        case yellow
        case blue
        case magenta
        case cyan
        case white
        case `default` = 39
        case lightBlack = 90
        case lightRed
        case lightGreen
        case lightYellow
        case lightBlue
        case lightMagenta
        case lightCyan
        case lightWhite
    }
    
    //MARK: - Styles
    
    public enum Style: UInt8, TerminalStyle {
        case `default` = 0
        case bold = 1
        case dim = 2
        case italic = 3
        case underline = 4
        case blink = 5
        case swap = 7
    }

    //MARK: - Cursor
    
    public enum Cursor: UInt8, TerminalStyle {
        case block = 1
        case line = 3
        case bar = 5
        
        func code(blinking: Bool) -> UInt8 {
            blinking ? code + 1 : code
        }
        
    }
    
    //MARK: - Set Attributes
    
    public static func set(foreground: Foreground? = nil, background: Background? = nil, style: Style? = nil) {
        if let v = foreground { set(foreground: v) }
        if let v = background { set(background: v) }
        if let v = style { set(style: v) }
    }
    
    public static func set(foreground: Foreground) {
        csi("\(foreground)m")
    }
    
    public static func set(background: Background) {
        csi("\(background)m")
    }
    
    public static func set(style: Style) {
        csi("\(style)m")
    }
    
    //MARK: - Reset Attributes
    
    public static func plain() {
        plainForeground()
        plainBackground()
        plainStyle()
    }
    
    public static func plainForeground() {
        set(foreground: .default)
    }
    
    public static func plainBackground() {
        set(background: .default)
    }
    
    public static func plainStyle() {
        set(style: .default)
    }
    
}


//MARK: - Protocol

protocol TerminalStyle {
    var rawValue: UInt8 { get }
}

extension TerminalStyle {
    
    /// The raw code associated with this style
    public var code: UInt8 { rawValue }
    
}

//MARK: - Attributes

/// All the colors the background can be
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

/// All the colors the foreground can be
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

/// All the styles the text can be
public enum Style: UInt8, TerminalStyle {
    case `default` = 0
    case bold = 1
    case dim = 2
    case italic = 3
    case underline = 4
    case blink = 5
    case swap = 7
}

/// All the styles the cursor can be
public enum Cursor: TerminalStyle {
    /// A cursor that does not blink
    case stable(StaticCursor)
    
    /// A cursor that blinks
    case blinking(BlinkingCursor)
    
    internal var rawValue: UInt8 {
        switch self {
        case .stable(let c): return c.rawValue
        case .blinking(let c): return c.rawValue
        }
    }
    
    /// A cursor shaped like a block (█)
    ///
    /// - Parameter blink: Wether or not the cursor is blinking
    public static func block(blinking blink: Bool) -> Cursor {
        blink ? .blinking(.block) : .stable(.block)
    }
    
    /// A cursor shaped like a line (▁)
    ///
    /// - Parameter blink: Wether or not the cursor is blinking
    public static func line(blinking blink: Bool) -> Cursor {
        blink ? .blinking(.line) : .stable(.line)
    }
    
    /// A cursor shaped like a bar (▎)
    ///
    /// - Parameter blink: Wether or not the cursor is blinking
    public static func bar(blinking blink: Bool) -> Cursor {
        blink ? .blinking(.bar) : .stable(.bar)
    }
    
}

/// A cursor that does not blink
public enum StaticCursor: UInt8, TerminalStyle {
    case block = 1
    case line = 3
    case bar = 5
    
    /// The blinking version of this cursor
    public var blinking: BlinkingCursor { BlinkingCursor(rawValue: code + 1)! }
    
}

/// A cursor that blinks
public enum BlinkingCursor: UInt8, TerminalStyle {
    case block = 2
    case line = 4
    case bar = 6
    
    /// The non-blinking version of this cursor
    public var stable: StaticCursor { StaticCursor(rawValue: code - 1)! }
    
}

//MARK: - Methods

extension Terminal {
    
    //MARK: - Set Attributes
    
    /// Sets the attributes to be used if none are specified in `write()` methods
    ///
    /// - Parameters:
    ///   - foreground: The text's color
    ///   - background: The text's background color
    ///   - style: The text's style
    ///   - cursor: The cursor's style
    public static func set(foreground: Foreground? = nil, background: Background? = nil, style: Style? = nil, cursor: Cursor? = nil) {
        if let v = foreground { set(foreground: v) }
        if let v = background { set(background: v) }
        if let v = style { set(style: v) }
        if let v = cursor { set(cursor: v) }
    }
    
    /// Sets the text color
    ///
    /// - Parameter foreground: The color to set
    public static func set(foreground: Foreground) {
        csi("\(foreground.code)m")
    }
    
    /// Sets the text background color
    ///
    /// - Parameter background: The background color to set
    public static func set(background: Background) {
        csi("\(background.code)m")
    }
    
    /// Sets the text style
    ///
    /// - Parameter style: The style to set
    public static func set(style: Style) {
        csi("\(style.code)m")
    }
    
    /// Sets the cursor style
    ///
    /// - Parameter cursor: The style to set
    public static func set(cursor: Cursor) {
        csi("\(cursor.code)q")
    }
    
    //MARK: - Reset Attributes
    
    /// Resets attributes to their `default` values
    ///
    /// - Parameters:
    ///   - foreground: Wether or not to reset the text color
    ///   - background: Wether or not to reset the text background color
    ///   - style: Wether or not to reset the text style
    public static func reset(foreground: Bool = false, background: Bool = false, style: Bool = false) {
        if foreground { resetForeground() }
        if background { resetBackground() }
        if style { resetStyle() }
    }
    
    /// Resets the text color to its `default` value
    public static func resetForeground() {
        set(foreground: .default)
    }
    
    /// Resets the text background color to its `default` value
    public static func resetBackground() {
        set(background: .default)
    }
    
    /// Resets the text style to its `default` value
    public static func resetStyle() {
        set(style: .default)
    }
    
    //MARK: - Store Attributes
    
    /// Stores the attributes to be restored later
    ///
    /// - Parameters:
    ///   - foreground: The text's color
    ///   - background: The text's background color
    ///   - style: The text's style
    ///   - cursor: The cursor's style
    public static func store(foreground: Foreground? = nil, background: Background? = nil, style: Style? = nil, cursor: Cursor? = nil) {
        if let v = foreground { storeForeground(v) }
        if let v = background { storeBackground(v) }
        if let v = style { storeStyle(v) }
        if let v = cursor { storeCursor(v) }
    }
    
    /// Stores the text color to be restored later
    ///
    /// - Parameter foreground: The color to be stored, or the current one if none are specified
    public static func storeForeground(_ foreground: Foreground = foreground) {
        storedForeground = foreground
    }
    
    /// Stores the text background color to be restored later
    ///
    /// - Parameter background: The background color to be stored, or the current one if none are specified
    public static func storeBackground(_ background: Background = background) {
        storedBackground = background
    }
    
    /// Stores the text style to be restored later
    ///
    /// - Parameter style: The style to be stored, or the current one if none are specified
    public static func storeStyle(_ style: Style = style) {
        storedStyle = style
    }
    
    /// Stores the cursor style to be restored later
    ///
    /// - Parameter style: The cursor style to be stored, or the current one if none are specified
    public static func storeCursor(_ cursor: Cursor = cursor) {
        storedCursor = cursor
    }
    
    //MARK: - Restore Attributes
    
    /// Restores the attributes
    ///
    /// - Parameters:
    ///   - foreground: Wether or not to restore the text color
    ///   - background: Wether or not to restore the text background color
    ///   - style: Wether or not to restore the text style
    ///   - cursor: Wether or not to restore the cursor style
    public static func restore(foreground: Bool = false, background: Bool = false, style: Bool = false, cursor: Bool = false) {
        if foreground { restoreForeground() }
        if background { restoreBackground() }
        if style { restoreStyle() }
        if cursor { restoreCursor() }
    }
    
    /// Restores the stored text color
    public static func restoreForeground() {
        set(foreground: storedForeground)
    }
    
    /// Restores the stored text background
    public static func restoreBackground() {
        set(background: storedBackground)
    }
    
    /// Restores the stored text style
    public static func restoreStyle() {
        set(style: storedStyle)
    }
    
    /// Restores the stored cursor style
    public static func restoreCursor() {
        set(cursor: storedCursor)
    }
    
    //MARK: - Shortcuts
    
    /// Uses the specified attributes for the duration of the closure
    /// - Parameters:
    ///   - f: The text color
    ///   - b: The text background color
    ///   - s: The text style
    ///   - c: The cursor style
    ///   - closure: The closure to execute with those attributes
    public static func attributed(foreground f: Foreground? = nil, background b: Background? = nil, style s: Style? = nil, cursor c: Cursor? = nil, _ closure: () -> Void = {}) {
        store(foreground: foreground, background: background, style: style, cursor: cursor)
        set(foreground: f, background: b, style: s, cursor: c)
        closure()
        restore(foreground: f != nil, background: b != nil, style: s != nil, cursor: c != nil)
    }
    
}

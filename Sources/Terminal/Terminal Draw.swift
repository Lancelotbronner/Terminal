extension Terminal {
    
    //MARK: - Writing
    
    /// Writes the attributed text
    ///
    /// - Parameters:
    ///   - str: The attributed string to write
    public static func write(design str: String, color f: Foreground? = nil, background b: Background? = nil, style s: Style? = nil) {
        attributed(foreground: f, background: b, style: s) {
            write(str)
        }
    }
    
    /// Writes the attributed text and a new line
    ///
    /// - Parameters:
    ///   - str: The attributed string to write
    public static func writeln(design str: String = "", color f: Foreground? = nil, background b: Background? = nil, style s: Style? = nil) {
        attributed(foreground: f, background: b, style: s) {
            writeln(str)
        }
    }
    
    //MARK: - Filling
    
    /// Draws a horizontal line across the screen
    ///
    /// - Parameters:
    ///   - with: The character to use for the line
    ///   - row: The line to fill
    public static func fill(hline with: String, at row: Int) {
        goto(row, 1)
        write(String(repeating: with, count: size.width))
    }
    
    /// Draws a vertical line across the screen
    ///
    /// - Parameters:
    ///   - with: The character to use for the line
    ///   - col: The column to fill
    public static func fill(vline with: String, at col: Int) {
        for y in 1 ... size.height {
            std(at: y, col, with)
        }
    }
    
    /// Draws a rectangle across the screen
    ///
    /// - Parameters:
    ///   - with: The character to use for the line
    ///   - pos: The column to fill
    ///   - size: The size of the rectangle
    public static func fill(rect with: String, at pos: Position, size: Size) {
        for y in pos.row ... pos.row + size.height {
            goto(y, pos.column)
            write(String(repeating: with, count: size.width))
        }
    }
    
}

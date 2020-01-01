extension Terminal {
    
    //MARK: - Cursor
    
    /// Sets the cursor's visibility
    ///
    /// - Parameter visible: Wether the cursor is shown or not
    public static func set(cursorVisibility visible: Bool) {
        if visible { cursorOn() }
        else { cursorOff() }
    }
    
    /// Makes the cursor invisible
    public static func cursorOff() {
        csi("?25l")
        isCursorVisible = false
    }
    
    /// Makes the cursor visible
    public static func cursorOn() {
        csi("?25h")
        isCursorVisible = true
    }
    
    //MARK: - Position
    
    /// The cursor's position
    ///
    /// This property is simply a shortcut to `getPosition()`
    public static var position: Position { getPosition() }
    
    /// Gets the cursor's position
    public static func getPosition() -> Position {
        let str = request(CSI, "6n", "R")  // returns ^[row;colR
        if str.isEmpty { return (-1, -1) }
        
        let esc = str.firstIndex(of: "[")!
        let del = str.firstIndex(of: ";")!
        let end = str.firstIndex(of: "R")!
        let row = String(str[str.index(after: esc) ... str.index(before: del)])
        let col = String(str[str.index(after: del) ... str.index(before: end)])
        
        return (Int(row)!, Int(col)!)
    }
    
    /// Stores the cursor position to be restored later
    public static func storePosition() {
        esc("7")
    }
    
    /// Restores the cursor position to what was stored
    public static func restorePosition() {
        esc("8")
    }
    
    /// Move the cursor up
    ///
    /// - Parameter n: The number of lines
    public static func up(_ n: Int = 1) {
        csi("\(n)A")
    }
    
    /// Move the cursor down
    ///
    /// - Parameter n: The number of lines
    public static func down(_ n: Int = 1) {
        csi("\(n)B")
    }
    
    /// Move the cursor right
    ///
    /// - Parameter n: The number of columns
    public static func right(_ n: Int = 1) {
        csi("\(n)C")
    }
    
    /// Move the cursor left
    ///
    /// - Parameter n: The number of columns
    public static func left(_ n: Int = 1) {
        csi("\(n)D")
    }
    
    /// Moves down to the beginning of a line
    ///
    /// - Parameter line: The number of lines
    public static func down(line: Int = 1) {
        csi("\(line)E")
    }
    
    /// Moves up to the beginning of a line
    ///
    /// - Parameter line: The number of lines
    public static func up(line: Int = 1) {
        csi("\(line)F")
    }
    
    /// Moves the cursor along its line
    ///
    /// - Parameter col: The column to move to
    public static func goto(_ col: Int) {
        csi("\(col)G")
    }
    
    /// Moves the cursor to a position
    ///
    /// - Parameters:
    ///   - row: The line to move to
    ///   - col: The column to move to
    public static func goto(_ row: Int, _ col: Int) {
        csi(row, "\(col)H")
    }
    
    //MARK: - Text Editing
    
    /// Inserts a newline
    ///
    /// - Parameter line: The location at which to insert the line
    public static func insert(line: Int = 1) {
        csi("\(line)L")
    }
    
    /// Inserts a newline
    ///
    /// - Parameter line: The location at which to insert the line
    public static func delete(line: Int = 1) {
        csi("\(line)M")
    }
    
    /// Deletes a character on the current line
    ///
    /// - Parameter char: The location at which to delete the char
    public static func delete(char: Int = 1) {
        csi("\(char)P")
    }
    
    /// Allows the user to replace characters while they type
    public static func enableReplaceMode() {
        csi("4l")
        isReplacing = true
    }
    
    /// Keeps the user from replacing characters while they type
    public static func disableReplaceMode() {
        csi("4h")
        isReplacing = false
    }
    
    //MARK: - Clear
    
    /// Clears the screen from the cursor to the end of the screen
    public static func clearBelow() {
        csi("0J")
    }
    
    /// Clears the screen from its start to the cursor
    public static func clearAbove() {
        csi("1J")
    }
    
    /// Clears the entire screen and scrollback buffer
    public static func clearScreen() {
        scrollToClear()
        clearScrollbackBuffer()
    }
    
    /// Clears from the cursor to its line's end
    public static func clearToEndOfLine() {
        csi("0K")
    }
    
    /// Clears from the beginning of the current line to the cursor
    public static func clearToStartOfLine() {
        csi("1K")
    }
    
    /// Clears the entire line
    public static func clearLine() {
        csi("2K")
    }
    
    //MARK: - Scroll
    
    /// Clears the screen by scrolling down
    public static func scrollToClear() {
        csi("2J")
        csi("H")
    }
    
    /// Clears the scrollback buffer
    public static func clearScrollbackBuffer() {
        csi("3J")
    }
    
    /// Scrolls the screen by moving the lines down
    ///
    /// - Parameter n: The number of lines to scroll
    public static func scrollDown(_ n: Int = 1) {
        csi("\(n)S")
    }
    
    /// Scrolls the screen by moving the lines up
    ///
    /// - Parameter n: The number of lines to scroll
    public static func scrollUp(_ n: Int = 1) {
        csi("\(n)T")
    }
    
    //MARK: - Size
    
    /// The screen size
    ///
    /// This property is simply a shortcut to `getSize()`
    public static var size: Size { getSize() }
    
    /// Gets the screen's size in characters
    public static func getSize() -> Size {
//        return (32, 100) // to prevent crashing in xcode
        
        // TODO: If debugging through XCode terminal, this will never complete
        
        // If in xcode, will hang
        var str = request(CSI, "18t", "t")  // returns ^[8;row;colt
        if str.isEmpty { return (-1, -1) }
        
        str = String(str.dropFirst(4))  // remove ^[8;
        let del = str.firstIndex(of: ";")!
        let end = str.firstIndex(of: "t")!
        let row = String(str[...str.index(before: del)])
        let col = String(str[str.index(after: del)...str.index(before: end)])
        
        return (Int(row)!, Int(col)!)
    }
    
}

extension Terminal {
    
    //MARK: - Cursor Style
    
    public static func set(cursor: Cursor, blinking: Bool = true) {
        csi(cursor.code(blinking: blinking), "q")
    }
    
    public static func cursorOff() {
        csi("?25l")
        isCursorVisible = false
    }
    
    public static func cursorOn() {
        csi("?25h")
        isCursorVisible = true
    }
    
    //MARK: - Cursor Position
    
    public static func cursor() -> (row: Int, col: Int) {
        let str = request(CSI, "6n", "R")  // returns ^[row;colR
        if str.isEmpty { return (-1, -1) }
        
        let esc = str.firstIndex(of: "[")!
        let del = str.firstIndex(of: ";")!
        let end = str.firstIndex(of: "R")!
        let row = String(str[str.index(after: esc)...str.index(before: del)])
        let col = String(str[str.index(after: del)...str.index(before: end)])
        
        return (Int(row)!, Int(col)!)
    }
    
    public static func storeCursor() {
        write(ESC, "7")
    }
    
    public static func restoreCursor() {
        write(ESC, "8")
    }
    
    public static func moveUp(_ n: Int = 1) {
        csi("\(n)A")
    }
    
    public static func moveDown(_ n: Int = 1) {
        csi("\(n)B")
    }
    
    public static func moveRight(_ n: Int = 1) {
        csi("\(n)C")
    }
    
    public static func moveLeft(_ n: Int = 1) {
        csi("\(n)D")
    }
    
    public static func moveLineDown(_ n: Int = 1) {
        csi("\(n)E")
    }
    
    public static func moveLineUp(_ n: Int = 1) {
        csi("\(n)F")
    }
    
    public static func moveToColumn(_ col: Int) {
        csi("\(col)G")
    }
    
    public static func moveTo(_ row: Int, _ col: Int) {
        csi(row, "\(col)H")
    }
    
    //MARK: - Text Editing
    
    public static func insertLine(_ row: Int = 1) {
        csi("\(row)L")
    }
    
    public static func deleteLine(_ row: Int = 1) {
        csi("\(row)M")
    }
    
    public static func delete(char: Int = 1) {
        csi("\(char)P")
    }
    
    public static func enableReplaceMode() {
        csi("4l")
        isReplacing = true
    }
    
    public static func disableReplaceMode() {
        csi("4h")
        isReplacing = false
    }
    
    //MARK: - Clear
    
    public static func clearBelow() {
        csi("0J")
    }
    
    public static func clearAbove() {
        csi("1J")
    }
    
    public static func clearScreen() {
        csi("2J")
        csi("3J")
        csi("H")
    }
    
    public static func clearToEndOfLine() {
        csi("0K")
    }
    
    public static func clearToStartOfLine() {
        csi("1K")
    }
    
    public static func clearLine() {
        csi("2K")
    }
    
    //MARK: - Screen
    
    public static func scrollRegion(top: Int, bottom: Int) {
        csi(top, "\(bottom)r")
    }
    
    public static func readScreenSize() -> (row: Int, col: Int) {
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

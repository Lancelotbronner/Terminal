import Darwin

extension Terminal {
    
    //MARK: - Flush
    
    @inlinable
    public static func flush(in a: Bool = true, out b: Bool = true) {
        if a { flushInput() }
        if b { flushOutput() }
    }
    
    @inlinable
    public static func flushInput() {
        fflush(stdin)
    }
    
    @inlinable
    public static func flushOutput() {
        fflush(stdout)
    }
    
    //MARK: - Write
    
    public static func write(_ str: String..., color: Foreground? = nil, background: Background? = nil, style: Style? = nil) {
        if let v = color { set(foreground: v) }
        if let v = background { set(background: v) }
        if let v = style { set(style: v) }
        print(str.joined(), terminator: "")
        if color != nil { plainForeground() }
        if background != nil { plainBackground() }
        if style != nil { plainStyle() }
    }
    
    public static func writeln(_ str: String..., color: Foreground? = nil, background: Background? = nil, style: Style? = nil) {
        write(str.joined(separator: "\n") + "\n", color: color, background: background, style: style)
    }
    
    //MARK: - Read
    
    // check key from input poll
    public static func isAnyKeyPressed() -> Bool {
        nonBlocking {
            var fds = [pollfd(fd: STDIN_FILENO, events: Int16(POLLIN), revents: 0)]
            return poll(&fds, 1, 0) > 0
        }
    }
    
    // read key as character
    public static func read() -> Character {
        var key: UInt8 = 0
        let res = Darwin.read(STDIN_FILENO, &key, 1)
        return res < 0 ? "\0" : Character(UnicodeScalar(key))
    }
    
    // read key as ascii code
    public static func readCode() -> Int {
        var key: UInt8 = 0
        let res = Darwin.read(STDIN_FILENO, &key, 1)
        return res < 0 ? 0 : Int(key)
    }
    
    public static func readln() -> String {
        var str: String? = nil
        while str == nil {
            str = readLine()
        }
        return str!
    }
    
    public static func ask(_ q: String, cleanup: Bool = false) -> String {
        write(q)
        if cleanup { flush() }
        return readln()
    }
    
    //MARK: - Write to std
    
    // direct write to standard output
    public static func std(_ text: String..., suspend: Int = 0) {
        text.forEach { Darwin.write(STDOUT_FILENO, $0, $0.utf8.count) }
        if suspend > 0 { delay(suspend) }
        if suspend < 0 { flush() }
    }
    
    // direct write to standard output with new line
    public static func stdln(_ text: String..., suspend: Int = 0) {
        text.forEach { Darwin.write(STDOUT_FILENO, $0, $0.utf8.count) }
        Darwin.write(STDOUT_FILENO, "\n", 1)
        if suspend > 0 { delay(suspend) }
        if suspend < 0 { flush() }
    }
    
    // direct write to standard output only new line
    public static func stdln(suspend: Int = 0) {
        Darwin.write(STDOUT_FILENO, "\n", 1)
        if suspend > 0 { delay(suspend) }
        if suspend < 0 { flush() }
    }
    
    // shortcut to write text at a given position
    public static func stdat(_ row: Int, _ col: Int, _ text: String..., suspend: Int = 0) {
        moveTo(row, col)
        for txt in text { Darwin.write(STDOUT_FILENO, txt, txt.utf8.count) }
        if suspend > 0 { delay(suspend) }
        if suspend < 0 { flush() }
    }
    
}

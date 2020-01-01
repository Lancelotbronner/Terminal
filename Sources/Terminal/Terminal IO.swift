import Darwin

extension Terminal {
    
    //MARK: - Flush
    
    /// Flushes the specified streams
    ///
    /// - Parameters:
    ///   - in: Wether to flush stdin
    ///   - out: Wether to flush stdout
    @inlinable
    public static func flush(in a: Bool = true, out b: Bool = true) {
        if a { flushInput() }
        if b { flushOutput() }
    }
    
    /// Flushes stdin
    @inlinable
    public static func flushInput() {
        fflush(stdin)
    }
    
    /// Flushes stdout
    @inlinable
    public static func flushOutput() {
        fflush(stdout)
    }
    
    //MARK: - Read
    
    /// Read currently pressed key as a character
    public static func read() -> Character {
        var key: UInt8 = 0
        let res = Darwin.read(STDIN_FILENO, &key, 1)
        return res < 0 ? "\0" : Character(UnicodeScalar(key))
    }
    
    /// Read currently pressed key as an ASCII code
    public static func readCode() -> Int {
        var key: UInt8 = 0
        let res = Darwin.read(STDIN_FILENO, &key, 1)
        return res < 0 ? 0 : Int(key)
    }
    
    /// Waits for the user to input some text
    public static func readln() -> String {
        var str: String? = nil
        while str == nil {
            str = readLine()
        }
        return str!
    }
    
    //MARK: - Ask
    
    /// Prints a question and waits for an answer
    ///
    /// - Parameters:
    ///   - question: The question to first write
    ///   - cleanup: If stdin should be flushed first
    public static func ask(_ question: String, cleanup: Bool = false) -> String {
        write(question)
        if cleanup { flush() }
        return readln()
    }
    
    /// Prints a question with a newline and waits for an answer
    ///
    /// - Parameters:
    ///   - question: The question to first write
    ///   - cleanup: If stdin should be flushed first
    public static func askln(_ question: String, cleanup: Bool = false) -> String {
        writeln(question)
        if cleanup { flush() }
        return readln()
    }
    
    //MARK: - Direct Write
    
    /// Direct write to standard output
    ///
    /// - Parameters:
    ///   - text: Any number of strings to write
    ///   - suspend: An optional delay, negative flushes instead
    public static func std(_ text: String..., suspend: Int = 0) {
        text.forEach { Darwin.write(STDOUT_FILENO, $0, $0.utf8.count) }
        if suspend > 0 { delay(suspend) }
        if suspend < 0 { flush() }
    }
    
    /// Direct write to standard output with new line
    ///
    /// - Parameters:
    ///   - text: Any number of strings to write
    ///   - suspend: An optional delay, negative flushes instead
    public static func stdln(_ text: String..., suspend: Int = 0) {
        text.forEach { Darwin.write(STDOUT_FILENO, $0, $0.utf8.count) }
        stdln(suspend: suspend)
    }
    
    /// Direct write a new line to standard output
    ///
    /// - Parameters:
    ///   - suspend: An optional delay, negative flushes instead
    public static func stdln(suspend: Int = 0) {
        Darwin.write(STDOUT_FILENO, "\n", 1)
        if suspend > 0 { delay(suspend) }
        if suspend < 0 { flush() }
    }
    
    /// Shortcut to write text at a given position
    ///
    /// - Parameters:
    ///   - row: The row at which to start writing
    ///   - col: The column at which to start writing
    ///   - text: Any number of strings to write
    ///   - suspend: An optional delay, negative flushes instead
    public static func std(at row: Int, _ col: Int, _ text: String..., suspend: Int = 0) {
        goto(row, col)
        for txt in text { Darwin.write(STDOUT_FILENO, txt, txt.utf8.count) }
        if suspend > 0 { delay(suspend) }
        if suspend < 0 { flush() }
    }
    
}

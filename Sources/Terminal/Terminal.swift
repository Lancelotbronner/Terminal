import Darwin

public final class Terminal {
    private init() { }
    
    //MARK: - Constants
    
    /// ESC (27 or 1B)
    public static let ESC = "\u{1B}"
    /// Single Shift Select of G2 charset
    public static let SS2 = ESC + "N"
    /// Single Shift Select of G3 charset
    public static let SS3 = ESC + "O"
    /// Device Control String
    public static let DCS = ESC + "P"
    /// Control Sequence Introducer
    public static let CSI = ESC + "["
    /// Operating System Command
    public static let OSC = ESC + "]"
    
    //MARK: - Typealiases
    
    /// A position in the screen in characters
    public typealias Position = (row: Int, column: Int)
    
    /// A width in columns and height in lines
    public typealias Size = (height: Int, width: Int)
    
    //MARK: - Private Proeprties
    
    private(set) static var term = termios()
    
    internal static var storedForeground = foreground
    internal static var storedBackground = background
    internal static var storedStyle = style
    internal static var storedCursor = cursor
    
    //MARK: - Public Properties
    
    /// Is the terminal blocking user input
    public internal(set) static var isNonBlocking = false
    
    /// Is the cursor currently visible
    public internal(set) static var isCursorVisible = true
    public internal(set) static var isReplacing = false
    
    // TODO: Only works during the session, not initialized correctly at the start
    
    /// The current text foreground color
    public private(set) static var foreground = Foreground.default
    
    /// The current text background color
    public private(set) static var background = Background.default
    
    /// The current text style
    public private(set) static var style = Style.default
    
    /// The current cursor style
    public private(set) static var cursor = Cursor.block(blinking: true)
    
    //MARK: - Non-Blocking Mode
    
    /// Inside the closure, user is allowed to input
    ///
    /// - Parameter f: The closure to execute while in Non-Blocking mode
    @discardableResult
    public static func nonBlocking<T>(_ f: () -> T) -> T {
        let needsSetup = !isNonBlocking
        if needsSetup { enableNonBlocking() }
        let tmp = f()
        if needsSetup { disableNonBlocking() }
        return tmp
    }
    
    /// Disable non-blocking mode
    public static func disableNonBlocking() {
        // restore default terminal mode
        tcsetattr(STDIN_FILENO, TCSANOW, &term)
        isNonBlocking = false
    }
    
    /// Enable non-blocking mode
    ///
    /// - Parameter rawMode: Should the terminal be put in raw mode
    public static func enableNonBlocking(rawMode: Bool = false) {
        // store current terminal mode
        tcgetattr(STDIN_FILENO, &term)
        atexit { Terminal.disableNonBlocking() }
        isNonBlocking = true
        
        // configure non-blocking and non-echoing terminal mode
        var nonBlockTerm = term
        if rawMode {
            //! full raw mode without any input processing at all
            cfmakeraw(&nonBlockTerm)
        } else {
            // disable CANONical mode and ECHO-ing input
            nonBlockTerm.c_lflag &= ~tcflag_t(ICANON | ECHO)
            // acknowledge CRNL line ending and UTF8 input
            nonBlockTerm.c_iflag &= ~tcflag_t(ICRNL | IUTF8)
        }
        
        // enable new terminal mode
        tcsetattr(STDIN_FILENO, TCSANOW, &nonBlockTerm)
    }
    
    //MARK: - Clock
    
    /// Halts the process while not taking all CPU
    public static func halt() {
        while true { _ = readln() }
    }
    
    /// Delay sync execution
    ///
    /// - Parameter ms: The time in milliseconds
    @inlinable
    public static func delay(_ ms: Int) {
        usleep(UInt32(ms * 1000))  // convert to seconds
    }
    
    //MARK: - Requests & Commands
    
    /// Make a `CSI` request to the terminal
    ///
    /// - Parameter codes: Semicolon (`;`) separated arguments
    static func csi(_ codes: CustomStringConvertible...) {
        let str = codes.map { $0.description }.joined(separator: ";")
        std(CSI, str)
    }
    
    /// Makes an ANSI request and returns the response
    ///
    /// - Parameters:
    ///   - cmd: The command to use
    ///   - arg: The command's argument
    ///   - until: The response's last character
    static func request(_ cmd: String, _ arg: String, _ until: Character) -> String {
        let full = cmd + arg
        return nonBlocking {
            // send request
            Darwin.write(STDOUT_FILENO, full, full.count)
            
            // read response
            var response = ""
            var key: UInt8  = 0
            repeat {
                // If in xcode, will hang
                Darwin.read(STDIN_FILENO, &key, 1)
                response.append(key < 32 ? "^" : char(key))
            } while key != until.asciiValue
            
            return response
        }
    }
    
    //MARK: - Private Utilities
    
    @inlinable
    static func unicode(_ code: Int) -> Unicode.Scalar {
        Unicode.Scalar(code) ?? "\0"
    }
    
    @inlinable
    static func char(_ code: UInt8) -> Character {
        Character(UnicodeScalar(code))
    }
    
}

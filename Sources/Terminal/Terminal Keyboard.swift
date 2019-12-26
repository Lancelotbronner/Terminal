import Darwin

extension Terminal {
    
    //MARK: - Key Codes
    
    /// Text flow keys, controls whitespace, deleting and others
    public enum FlowKey: Character {
        /// \0 NUL
        case none = "\u{00}"
        /// \a BELL
        case bell = "\u{07}"
        /// BS
        case erase = "\u{08}"
        /// \t TAB
        case tab = "\u{09}"
        /// \n LF
        case linefeed = "\u{0A}"
        /// \v VT
        case vtab = "\u{0B}"
        /// \f FF
        case formfeed = "\u{0C}"
        /// \r CR
        case enter = "\u{0D}"
        /// SUB or EOL
        case eol = "\u{1A}"
        /// \e ESC
        case esc = "\u{1B}"
        /// SPACE
        case space = "\u{20}"
        /// DEL
        case del = "\u{7F}"
        
        /// The key's character value
        public var char: Character { rawValue }
        
        /// The key's ASCII code
        var code: UInt8 { rawValue.asciiValue! }
    }
    
    /// Complementary keys such as the f`x` or arrow keys
    public enum ComplementaryKey: UInt8 {
        /// null
        case none = 0
        
        /// ESC [ A
        case up = 65
        /// ESC [ B
        case down = 66
        /// ESC [ C
        case right = 67
        /// ESC [ D
        case left = 68
        
        /// ESC [ F or ESC [ 4~
        case end = 70
        /// ESC [ H or ESC [ 1~
        case home = 72
        /// ESC [ 2~
        case insert = 2
        /// ESC [ 3~
        case delete = 3
        /// ESC [ 5~
        case pageUp = 5
        /// ESC [ 6~
        case pageDown = 6
        
        /// ESC O P or ESC [ 11~
        case f1 = 80
        /// ESC O Q or ESC [ 12~
        case f2 = 81
        /// ESC O R or ESC [ 13~
        case f3 = 82
        /// ESC O S or ESC [ 14~
        case f4 = 83
        /// ESC [ 15~
        case f5 = 15
        /// ESC [ 17~
        case f6 = 17
        /// ESC [ 18~
        case f7 = 18
        /// ESC [ 19~
        case f8 = 19
        /// ESC [ 20~
        case f9 = 20
        /// ESC [ 21~
        case f10 = 21
        /// ESC [ 23~
        case f11 = 23
        /// ESC [ 24~
        case f12 = 24
        
        init(CSINumber key: UInt8) {
            switch key {
            case 1: self = .home
            case 2: self = .insert
            case 3: self = .delete
            case 4: self = .end
            case 5: self = .pageUp
            case 6: self = .pageDown
            case 11: self = .f1
            case 12: self = .f2
            case 13: self = .f3
            case 14: self = .f4
            case 15: self = .f5
            case 17: self = .f6
            case 18: self = .f7
            case 19: self = .f8
            case 20: self = .f9
            case 21: self = .f10
            case 23: self = .f11
            case 24: self = .f12
            default: self = .none
            }
        }
        
        init(CSILetter key: UInt8) {
            switch key {
            case 65: self = .up
            case 66: self = .down
            case 67: self = .left
            case 68: self = .right
            case 72: self = .home
            case 70: self = .end
            case 80: self = .f1
            case 81: self = .f2
            case 82: self = .f3
            case 83: self = .f4
            default: self = .none
            }
        }
        
        init(SS3Letter key: UInt8) {
            switch key {
              case 80: self = .f1
              case 81: self = .f2
              case 82: self = .f3
              case 83: self = .f4
              default: self = .none
            }
        }
    }
    
    /// Control keys
    public enum MetaKey: UInt8 {
        /// ESC [ x ; 5~ or ESC [ x ; 6~ or ESC [ x ; 7~ or ESC [ x ; 8~
        case control = 1
        /// ESC [ x ; 2~ or ESC [ x ; 4~ or ESC [ x ; 6~ or ESC [ x ; 8~
        case shift = 2
        /// ESC [ x ; 3~ or ESC [ x ; 4~ or ESC [ x ; 7~ or ESC [ x ; 8~
        case alt = 3
        
        static func CSIMeta(_ key: UInt8) -> [MetaKey] {
            switch key {
            case  2: return [.shift]
            case  3: return [.alt]
            case  4: return [.shift, .alt]
            case  5: return [.control]
            case  6: return [.shift, .control]
            case  7: return [.alt, .control]
            case  8: return [.shift, .alt, .control]
            default: return []
            }
        }
    }
    
    //MARK: - Methods
    
    /// Wether any keys are currently being pressed
    static var isAnyKeyPressed: Bool {
        if !isNonBlocking { enableNonBlocking() }
        var fds = [pollfd(fd: STDIN_FILENO, events: Int16(POLLIN), revents: 0)]
        return poll(&fds, 1, 0) > 0
    }
    
    /// Reads a complementary key and all meta keys
    public static func readKey() -> (code: ComplementaryKey, meta: [MetaKey]) {
        nonBlocking {
            var code = ComplementaryKey.none
            var meta: [MetaKey] = []
            
            // make sure there is data in stdin
            guard isAnyKeyPressed else { return (code, meta) }
            
            var val: Int = 0
            var key: Int = 0
            var cmd: String = ESC
            var chr: Character
            
            loop: while true {
                cmd.append(read())  // check for ESC combination
                switch cmd {
                case CSI:
                    key = readCode()
                    
                    switch true {
                    case isLetter(key):
                        code = ComplementaryKey(CSILetter: UInt8(key))
                        break loop
                        
                    case isNumber(key):
                        cmd = String(unicode(key)) // collect numbers
                        
                        chr = read()
                        while chr.isNumber {
                            cmd.append(chr)
                            chr = read()  // char after number has been read
                        }
                        
                        val = Int(cmd)!  // guaranted valid number
                        
                        guard chr == ";" else {
                            code = ComplementaryKey(CSINumber: UInt8(val))
                            break loop
                        }
                        
                        cmd = String(read()) // CSI + numbers + ; + meta
                        if isNumber(cmd) { meta = MetaKey.CSIMeta(UInt8(cmd)!) }
                        
                        if val == 1 {  // CSI + 1 + ; + meta
                            key = readCode() // CSI + 1 + ; + meta + letter
                            if isLetter(key) { code = ComplementaryKey(CSILetter: UInt8(key)) }
                            break loop
                        }
                        else {// CSI + numbers + ; + meta + ~
                            code = ComplementaryKey(CSINumber: UInt8(val))
                            _ = readCode()  // dismiss the tilde (guaranted)
                            break loop
                        }
                        
                    default:
                        break loop
                    }
                    
                case SS3:
                    key = readCode()
                    if isLetter(key) {
                        code = ComplementaryKey(SS3Letter: UInt8(key))
                    }
                    break loop
                    
                default:
                    break loop
                }
            }
            
            return (code, meta)
        }
    }
    
}

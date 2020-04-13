import Terminal

//MARK: - Interpreter

public final class Interpreter {
    private init() { }
    
    //MARK: Settings
    
    public static var _usingRichText = true
    
    public static var _prompt = ">"
    
    public static var _message_noCommandsInGroup = "There are no commands"
    
    public static var _error_announceError = "Error:"
    public static var _error_noCommandsAvailable = "There are no commands available"
    public static var _error_unknownCommand = "Unknown command"
    
    //MARK: Properties
    
    static private var groups: [CommandGroup] = []
    
    //MARK: Methods
    
    public static func prompt() {
        let cmd = ask()
        do { try process(raw: cmd) }
        catch { write(error: "\(_error_announceError) " + String(describing: error)) }
    }
    
    public static func load(commands: [CommandGroup]) {
        self.groups = commands
    }
    
    @inlinable
    public static func load(commands: CommandGroup...) { load(commands: commands) }
    @inlinable
    public static func load(commands: [Command]) { load(commands: [.init("", commands)]) }
    @inlinable
    public static func load(commands: Command...) { load(commands: commands) }
    
    public static func help() {
        print()
        for group in groups {
            group.displayHelp()
            print()
        }
    }
    
    //MARK: Private Methods
    
    private static func ask() -> String {
        write("\(_prompt) ") {
            Terminal.write(design: "\(_prompt) ", color: .magenta, style: .bold)
        }
        
        if _usingRichText {
            Terminal.set(foreground: .white)
            Terminal.set(style: .bold)
        }
        
        var str: String?
        while str == nil, str?.isEmpty ?? true {
            str = readLine()
        }
        
        if _usingRichText {
            Terminal.resetForeground()
            Terminal.resetStyle()
        }
        
        return str!
    }
    
    private static func process(raw: String) throws {
        guard !groups.isEmpty else { return write(error: _error_noCommandsAvailable) }
        
        var args = raw.split(separator: " ")
        guard !args.isEmpty else { return }
        let key = String(args.removeFirst())
        let call = Command.Call(args)
        
        for group in groups {
            if try group.attempt(execution: key, with: call) { return }
        }
        
        write(error: _error_unknownCommand)
    }
    
    //MARK: Utilities
    
    static func write(_ str: String, _ rich: () -> Void) {
        guard _usingRichText else { return print(str, terminator: "") }
        rich()
    }
    
    static func writeln(_ str: String, _ rich: () -> Void) {
        guard _usingRichText else { return print(str) }
        rich()
        print()
    }
    
    static func write(error str: String) {
        writeln(str) {
            Terminal.writeln(design: str, color: .lightRed, style: .bold)
        }
    }
    
}

import Terminal

//MARK: - Group

public final class CommandGroup {
    
    //MARK: Properties
    
    public let title: String
    
    private let commands: [String : Command]
    private let maxDisplayWidth: Int
    
    //MARK: Computed Properties
    
    public var isEmpty: Bool { commands.isEmpty }
    
    //MARK: Initialization
    
    public init(_ title: String, _ commands: [Command]) {
        self.title = title
        self.commands = .init(uniqueKeysWithValues: commands.map { ($0.keyword, $0) })
        maxDisplayWidth = commands.map { $0.width }.max() ?? 0
    }
    
    public convenience init(_ title: String, _ commands: Command...) {
        self.init(title, commands)
    }
    
    //MARK: Methods
    
    func attempt(execution of: String, with call: Command.Call) throws -> Bool {
        guard let cmd = commands[of] else { return false }
        try cmd.execute(with: call)
        return true
    }
    
    //MARK: Display
    
    func displayTitle() {
        Interpreter.writeln("\n[ \(title) ]\n") {
            Terminal.write(design: "\n[", color: .cyan)
            Terminal.write(design: " \(title) ", color: .lightCyan, style: .bold)
            Terminal.writeln(design: "]\n", color: .cyan)
        }
    }
    
    func displayHelp() {
        displayTitle()
        guard !isEmpty else {
            return Interpreter.writeln(Interpreter._message_noCommandsInGroup) {
                Terminal.writeln(design: Interpreter._message_noCommandsInGroup, color: .lightBlue)
            }
        }
        for k in commands.keys.sorted() {
            commands[k]!.displayHelp(width: maxDisplayWidth)
        }
    }
    
}

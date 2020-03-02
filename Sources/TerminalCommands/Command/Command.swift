import Terminal

//MARK: - Command

public final class Command {
    
    //MARK: Typealiases
    
    public typealias Action = (Call) throws -> Void
    public typealias QuickAction = () throws -> Void
    
    //MARK: Properties
    
    public let keyword: String
    public let usage: String?
    public let desc: String
    
    private let action: Action
    
    //MARK: Computed Properties
    
    public var specifiesUsage: Bool { usage != nil }
    
    var display: String {
        var d = keyword
        if specifiesUsage { d += " \(usage!)" }
        return d
    }
    
    var width: Int { display.count }
    
    //MARK: Initialization
    
    public init(_ command: String, _ description: String, usage: String? = nil, _ action: @escaping Action) {
        keyword = command
        desc = description
        self.usage = usage
        self.action = action
    }
    
    public convenience init(_ command: String, _ description: String, usage: String? = nil, _ action: @escaping QuickAction) {
        self.init(command, description, usage: usage) {
            try $0.assertEmpty()
            action()
        }
    }
    
    //MARK: Methods
    
    func execute(with call: Call) throws {
        try action(call)
    }
    
    //MARK: Display
    
    func displayHelp(width totalWidth: Int) {
        let disp = display
        let padding = String(repeating: " ", count: totalWidth - disp.count)
        Interpreter.writeln("\(disp)\(padding)   \(desc)") {
            Terminal.write(design: "\(disp)\(padding)   ", color: .blue, style: .bold)
            Terminal.writeln(design: desc, color: .lightBlue)
        }
    }
    
}

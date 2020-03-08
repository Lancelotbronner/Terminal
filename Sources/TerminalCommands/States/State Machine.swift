//MARK: - State Machine

public final class StateMachine {
    private init() { }
    
    //MARK: Settings
    
    public static var _syncCommandsWithInterpreter = true
    
    public static var _emptyStateName = "Empty"
    
    //MARK: Typealiases
    
    public typealias OnStateMachinePopsRoot = () -> Void
    
    //MARK: Properties
    
    private static var stack: [State] = []
    
    public static var onPopsRoot: OnStateMachinePopsRoot?
    
    //MARK: Computed Properties
    
    public static var depth: Int { stack.count }
    public static var isEmpty: Bool { stack.isEmpty }
    public static var root: State { stack.first ?? EmptyState() }
    public static var current: State { stack.last ?? EmptyState() }
    
    public static var last: State {
        guard stack.count > 1 else { return EmptyState() }
        return stack[stack.count - 2]
    }
    
    //MARK: Accessors
    
    public static func push(_ s: State) {
        stack.append(s)
        s.onEnter()
        sync()
    }
    
    public static func pop() {
        remove()
        sync()
        if isEmpty { onPopsRoot?() }
    }
    
    public static func popToRoot() {
        while depth > 1 { remove() }
        sync()
    }
    
    public static func popAll() {
        clear()
        sync()
        onPopsRoot?()
    }
    
    public static func set(_ s: State) {
        remove()
        push(s)
    }
    
    public static func set(root s: State) {
        clear()
        push(s)
    }
    
    //MARK: - Methods
    
    public static func run(starting with: State) {
        push(with)
        while true {
            Interpreter.prompt()
        }
    }
    
    public static func run(starting with: State, while go: @autoclosure () -> Bool) {
        push(with)
        while go() {
            Interpreter.prompt()
        }
    }
    
    public static func reloadCommands() {
        Interpreter.load(commands: current.controls)
    }
    
    //MARK: - Utilities
    
    private static func remove() {
        current.onExit()
        stack.removeLast()
    }
    
    private static func clear() {
        while !isEmpty { remove() }
    }
    
    private static func sync() {
        guard _syncCommandsWithInterpreter else { return }
        Interpreter.load(commands: current.controls)
    }
    
}

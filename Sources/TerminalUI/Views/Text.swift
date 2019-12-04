import Terminal

public final class Text: View {
    
    //MARK: - Properties
    
    var string: String
    
    //MARK: - Initialization
    
    public init(_ str: String) {
        string = str
    }
    
    public convenience init<S: StringProtocol>(_ anyStr: S) {
        self.init(String(anyStr))
    }
    
    public convenience init(_ anyDesc: CustomStringConvertible) {
        self.init(anyDesc.description)
    }
    
    //MARK: - View
    
    public var queryHeight: Length { 1 }
    public var queryWidth: Length { .init(string.count) }
    
    public func draw(in rect: Rect) {
        Terminal.moveTo(rect.y, rect.x)
        Terminal.write(string)
    }
    
}

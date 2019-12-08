import Terminal

@available(OSX 10.15.0, *)
public struct Text: Presentable, View {
    
    //MARK: - Properties
    
    let string: String
    let color: Foreground?
    let style: Style?
    let background: Background?
    
    //MARK: - Initialization
    
    public init(_ str: String, color c: Foreground? = nil, background b: Background? = nil, style s: Style? = nil) {
        string = str
        color = c
        background = b
        style = s
    }
    
    public init<S: StringProtocol>(_ anyStr: S, color c: Foreground? = nil, background b: Background? = nil, style s: Style? = nil) {
        self.init(String(anyStr), color: c, background: b, style: s)
    }
    
    public init(_ anyDesc: CustomStringConvertible, color c: Foreground? = nil, background b: Background? = nil, style s: Style? = nil) {
        self.init(anyDesc.description, color: c, background: b, style: s)
    }
    
    //MARK: - View
    
    public var queryHeight: Length { 1 }
    public var queryWidth: Length { .init(string.count) }
    
    public func draw(in rect: Rect) {
        Terminal.moveTo(rect.y, rect.x)
        Terminal.write(string, color: color, background: background, style: style)
    }
    
}

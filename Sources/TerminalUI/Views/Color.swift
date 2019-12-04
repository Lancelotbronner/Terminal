import Terminal

public struct Color: View {
    
    //MARK: - Properties
    
    var color: Terminal.Background
    
    //MARK: - Initialization
    
    public init(_ c: Terminal.Background) {
        color = c
    }
    
    //MARK: - View
    
    public var queryWidth: Length { .infinity }
    public var queryHeight: Length { .infinity }
    
    public func draw(in rect: Rect) {
        Terminal.moveTo(rect.y, rect.x)
        Terminal.set(background: color)
        for _ in rect.rangeY {
            for _ in rect.rangeX {
                Terminal.write(" ")
            }
        }
        Terminal.plainBackground()
    }
    
}

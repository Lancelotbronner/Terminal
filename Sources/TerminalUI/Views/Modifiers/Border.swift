import Terminal

@available(OSX 10.15.0, *)
struct Border: Presentable, View {
    
    //MARK: - Properties
    
    let content: Presentable
    let width: Int
    let char: Character?
    let foreground: Foreground?
    let background: Background?
    let style: Style?
    
    var border: String { String(repeating: char ?? " ", count: width) }
    var axisWidth: Int { width * 2 }
    
    //MARK: - Initialization
    
    init(_ v: Presentable, _ w: Int, _ c: Character?, _ fg: Foreground?, _ bg: Background?, _ s: Style?) {
        content = v
        width = w
        char = c
        foreground = fg
        background = bg
        style = s
    }
    
    //MARK: - View
    
    var queryWidth: Length { content.queryWidth + axisWidth.toLength }
    var queryHeight: Length { content.queryHeight + axisWidth.toLength }
    
    func draw(in rect: Rect) {
        if let v = foreground { Terminal.set(foreground: v) }
        if let v = background { Terminal.set(background: v) }
        if let v = style { Terminal.set(style: v) }
        
        var ln = 1
        for y in rect.rangeY {
            Terminal.moveTo(y, rect.x)
            Terminal.write(border)
            if ln > width && ln <= (rect.height - width) {
                Terminal.moveToColumn(rect.rangeX.upperBound - width + 1)
            } else {
                Terminal.write(String(repeating: char ?? " ", count: rect.width - axisWidth))
            }
            Terminal.write(border)
            ln += 1
        }
        
        content.draw(in: Rect(rect.x + width, rect.y + width, rect.width - width, rect.height - width))
        Terminal.plain()
    }
    
}

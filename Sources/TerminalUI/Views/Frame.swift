public final class Frame: View {
    
    //MARK: - Properties
    
    var view: View
    var width: Length?
    var height: Length?
    
    //MARK: - Initialization
    
    init(_ v: View, _ w: Length?, _ h: Length?) {
        view = v
        width = w
        height = h
    }
    
    //MARK: - View
    
    public var queryWidth: Length { width ?? view.queryWidth }
    public var queryHeight: Length { height ?? view.queryHeight }
    
    public func draw(in rect: Rect) {
        view.draw(in: Rect(rect.x, rect.y, width?.value ?? rect.width, height?.value ?? rect.height))
    }
    
}

@available(OSX 10.15.0, *)
struct Frame: Presentable, View {
    
    //MARK: - Properties
    
    let view: Presentable
    let width: Length?
    let height: Length?
    
    //MARK: - Initialization
    
    init(_ v: Presentable, _ w: Length?, _ h: Length?) {
        view = v
        width = w
        height = h
    }
    
    //MARK: - View
    
    public var queryWidth: Length { width ?? view.queryWidth }
    public var queryHeight: Length { height ?? view.queryHeight }
    
    public func draw(in rect: Rect) {
        view.draw(in: Rect(rect.x, rect.y, width?.tryValue ?? rect.width, height?.tryValue ?? rect.height))
    }
    
}

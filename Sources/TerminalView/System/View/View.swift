
//MARK: - View

open class View {
    
    //MARK: Properties
    
    public private(set) var frame: Rect
    public private(set) var subviews: [View] = []
    
    //MARK: Initialization
    
    public init(frame rect: Rect) {
        frame = rect
    }
    
    public init(at: Point, size: Point) {
        frame = Rect(at, size)
    }
    
    //MARK: Methods
    
    public func draw(with pen: Pen) {
        
    }
    
}

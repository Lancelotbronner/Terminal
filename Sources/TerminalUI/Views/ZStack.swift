public final class ZStack: View {
    
    //MARK: - Properties
    
    var alignment: Alignment
    var items: [View] = []
    
    //MARK: - Initialization
    
    public init(alignment a: Alignment = .center, _ contents: View...) {
        items = contents
        alignment = a
    }
    
    //MARK: - View
    
    public var queryHeight: Length { .infinity }
    public var queryWidth: Length { .infinity }
    
    public func draw(in rect: Rect) {
        for i in 0 ..< items.count {
            items[i].draw(in: rect)
        }
    }
    
}

public final class VStack: View {
    
    //MARK: - Properties
    
    var alignment: VerticalAlignment
    var spacing: Int
    var items: [View] = []
    
    //MARK: - Initialization
    
    public init(alignment a: VerticalAlignment = .center, spacing s: Int = 0, _ contents: View...) {
        items = contents
        alignment = a
        spacing = s
    }
    
    //MARK: - View
    
    public var queryHeight: Length { .infinity }
    public var queryWidth: Length { HostingView.getMaximumWidth(in: items) }
    
    public func draw(in rect: Rect) {
        let availableSpace = rect.height - spacing * (items.count - 1)
        let lengths = items.map { $0.queryHeight }
        let absoluteItems = lengths.filter { !$0.isInfinity }
        let flexibleItems = lengths.filter { $0.isInfinity }
        let absoluteSpace = absoluteItems.reduce(0, +).toInt
        let flexibleSpace = availableSpace - absoluteSpace
        let flexibleDistribution = flexibleItems.count == 0 ? 0 : flexibleSpace / flexibleItems.count
        
        var y = rect.y
        for i in 0 ..< items.count {
            let length = lengths[i]
            let height = length.isInfinity ? flexibleDistribution : length.toInt
            items[i].draw(in: Rect(rect.x, y, rect.width, height))
            y += height + spacing
        }
    }
    
}

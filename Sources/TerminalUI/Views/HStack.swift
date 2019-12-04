public final class HStack: View {
    
    //MARK: - Properties
    
    var alignment: VerticalAlignment
    var spacing: Int
    var items: [View] = []
    
    //MARK: - Initialization
    
    public init(alignment a: VerticalAlignment = .center, spacing s: Int = 1, _ contents: View...) {
        items = contents
        alignment = a
        spacing = s
    }
    
    //MARK: - View
    
    public var queryHeight: Length { HostingView.getMaximumHeight(in: items) }
    public var queryWidth: Length { .infinity }
    
    public func draw(in rect: Rect) {
        let availableSpace = rect.width - spacing * (items.count - 1)
        let lengths = items.map { $0.queryWidth }
        let absoluteItems = lengths.filter { !$0.isInfinity }
        let flexibleItems = lengths.filter { $0.isInfinity }
        let absoluteSpace = absoluteItems.reduce(0, +).toInt
        let flexibleSpace = availableSpace - absoluteSpace
        let flexibleDistribution = flexibleItems.count == 0 ? 0 : flexibleSpace / flexibleItems.count
        
        var x = rect.x
        for i in 0 ..< items.count {
            let length = lengths[i]
            let width = length.isInfinity ? flexibleDistribution : length.toInt
            items[i].draw(in: Rect(x, rect.y, width, rect.height))
            x += width + spacing
        }
    }
    
}

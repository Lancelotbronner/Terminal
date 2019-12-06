@available(OSX 10.15.0, *)
struct Align: Presentable {
    
    //MARK: - Properties
    
    let content: Presentable
    let alignment: Alignment
    
    //MARK: - Initialization
    
    init(_ v: Presentable, _ a: Alignment) {
        content = v
        alignment = a
    }
    
    //MARK: - View
    
    var queryWidth: Length { content.queryWidth }
    var queryHeight: Length { content.queryHeight }
    
    func draw(in rect: Rect) {
        let xlen = content.queryWidth.tryValue ?? rect.width
        let ylen = content.queryHeight.tryValue ?? rect.height
        
        var xalign = rect.x
        switch alignment.horizontal {
        case HorizontalAlignment.ordered[0]: xalign += 0
        case HorizontalAlignment.ordered[1]: xalign += (rect.width - xlen) / 2
        case HorizontalAlignment.ordered[2]: xalign += rect.width - xlen
        default: xalign = -1
        }
        
        var yalign = rect.y
        switch alignment.vertical {
        case VerticalAlignment.ordered[0]: yalign += 0
        case VerticalAlignment.ordered[1]: yalign += rect.height / 2 - ylen
        case VerticalAlignment.ordered[2]: yalign += rect.height - ylen
        default: yalign = -1
        }
        
        content.draw(in: Rect(xalign, yalign, xlen, ylen))
    }
    
}

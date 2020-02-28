import Terminal

//MARK: Pen

struct Pen {
    
    //MARK: Properties
    
    static let screen = Pen(in: Rect(Terminal.size.width, Terminal.size.height))
    
    let canvas: Rect
    
    //MARK: Initialization
    
    init(in canvas: Rect) {
        self.canvas = canvas
    }
    
}

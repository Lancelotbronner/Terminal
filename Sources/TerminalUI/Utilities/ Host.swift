//MARK: - Interface

public final class HostingView {
    
    //MARK: - Properties
    
    var view: View
    
    //MARK: - Initialization
    
    init(_ contents: View) {
        view = contents
    }
    
    init(title: String, _ contents: View) {
        view = NavigationView(contents)
    }
    
}

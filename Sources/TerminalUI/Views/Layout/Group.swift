@available(OSX 10.15.0, *)
public struct Group: Views, View {
    
    //MARK: - Properties
    
    let presentables: [Presentable]
    
    //MARK: - Initialization
    
    public init<V: View>(@ViewBuilder _ contents: Built<V>) {
        presentables = contents().asPresentables
    }
    
}

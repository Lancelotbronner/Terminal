@available(OSX 10.15.0, *)
protocol AnyTuppleView {
    var presentables: [Presentable] { get }
}

@available(OSX 10.15.0, *)
public struct Tupple2<V1, V2>: AnyTuppleView where V1: View, V2: View {
    
    let presentables: [Presentable]
    
    init(_ v1: V1, _ v2: V2) {
        presentables = [v1.asPresentable,
                        v2.asPresentable]
    }
    
}

@available(OSX 10.15.0, *)
public struct Tupple3<V1, V2, V3>: AnyTuppleView where V1: View, V2: View, V3: View {
    
    let presentables: [Presentable]
    
    init(_ v1: V1, _ v2: V2, _ v3: V3) {
        presentables = [v1.asPresentable,
                        v2.asPresentable,
                        v3.asPresentable]
    }
    
}

@available(OSX 10.15.0, *)
public struct Tupple4<V1, V2, V3, V4>: AnyTuppleView where V1: View, V2: View, V3: View, V4: View {
    
    let presentables: [Presentable]
    
    init(_ v1: V1, _ v2: V2, _ v3: V3, _ v4: V4) {
        presentables = [v1.asPresentable,
                        v2.asPresentable,
                        v3.asPresentable,
                        v4.asPresentable]
    }
    
}

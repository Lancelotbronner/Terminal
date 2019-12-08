import SwiftUI

@available(OSX 10.15.0, *)
public typealias Built<V: View> = () -> V

@available(OSX 10.15.0, *)
@_functionBuilder
public final class ViewBuilder {

    public static func buildBlock() -> Empty {
        Empty()
    }
    
    public static func buildBlock<V: View>(_ c: V) -> V {
        c
    }
    
    public static func buildBlock<C1: View, C2: View>(_ c1: C1, _ c2: C2) -> some View {
        Tupple2(c1, c2)
    }
    
    public static func buildBlock<C1: View, C2: View, C3: View>(_ c1: C1, _ c2: C2, _ c3: C3) -> some View {
        Tupple3(c1, c2, c3)
    }
    
    public static func buildBlock<C1: View, C2: View, C3: View, C4: View>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> some View {
        Tupple4(c1, c2, c3, c4)
    }
    
}

//
//  SakuraView.swift
//  
//
//  Created by Corey Roberts on 10/10/20.
//

import SwiftUI

struct SakuraPetal {
    var title: String
    var message: String
    var duration: Double = 3.0
    var type: SakuraType = .info
}

enum SakuraType: Hashable, CustomStringConvertible {
    
    case info
    case success
    case warning
    case error
    case other(String, Color, Color)
    
    var foregroundColor: Color {
        switch self {
        case .info, .success, .warning, .error:
            return .white
        case .other(_, _, let color):
            return color
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .info:
            return .blue
        case .success:
            return .green
        case .warning:
            return .orange
        case .error:
            return .red
        case .other(_, let color, _):
            return color
        }
    }
    
    var description: String {
        switch self {
        case .info: return "Info"
        case .success: return "Success"
        case .warning: return "Warning"
        case .error: return "Error"
        case .other(let description, _, _): return description
        }
    }
    
}

extension Animation {

    static func gentleDrop() -> Animation {
        Animation.spring(dampingFraction: 1.0)
            .speed(0.75)
    }

}

struct SakuraModifier: ViewModifier {

    @Binding var petal: SakuraPetal
    @Binding var bloom: Bool
    
    @State private var moveAmount: CGFloat = 1.0
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if bloom {
                VStack {
                    SakuraView(petal: $petal)
                    Spacer()
                }
                .animation(.gentleDrop())
                .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                // TODO: Still have to figure out transitions when views disappear.
                .onTapGesture {
                    withAnimation {
                        self.bloom = false
                    }
                }
//                .gesture(
//                    DragGesture()
//                        .onChanged(<#T##action: (DragGesture.Value) -> Void##(DragGesture.Value) -> Void#>)
//                )
                // FIXME: Small bug exists if the view stays on screen and we try to
                // add another one before it gets removed.
                .onAppear() {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + petal.duration) {
                        withAnimation {
                            self.bloom = false
                        }
                    }
                }
            }
        }
    }
    
}

extension View {
    func sakura(petal: Binding<SakuraPetal>, bloom: Binding<Bool>) -> some View {
        self.modifier(SakuraModifier(petal: petal, bloom: bloom))
    }
}




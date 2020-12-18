//
//  SakuraView.swift
//
//
//  Created by Corey Roberts on 10/10/20.
//

import SwiftUI

struct SakuraPetal: Equatable {
    var title: String
    var message: String
    var duration: Double = 3.0
    var type: SakuraType = .info
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.title == rhs.title &&
            lhs.message == rhs.message &&
            lhs.type == rhs.type
    }
}

enum SakuraType: Hashable, CustomStringConvertible {
    
    case info
    case success
    case warning
    case error
    case other(String, Color, Color, String)
    
    var foregroundColor: Color {
        switch self {
        case .info, .success, .warning, .error:
            return .white
        case .other(_, _, let color, _):
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
        case .other(_, let color, _, _):
            return color
        }
    }
    
    var description: String {
        switch self {
        case .info: return "Info"
        case .success: return "Success"
        case .warning: return "Warning"
        case .error: return "Error"
        case .other(let description, _, _, _): return description
        }
    }
    
    var emoji: String {
        switch self {
        case .info: return "ℹ️"
        case .success: return "🌸"
        case .warning: return "⚠️"
        case .error: return "🚫"
        case .other(_, _, _, let emoji): return emoji
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
    
    private enum Constants {
        static let startOffset: CGSize = CGSize(width: 0.0,
                                                 height: -320.0)
        static let endOffset: CGSize = CGSize(width: 0.0,
                                              height: 0.0)
    }

    @Binding var petal: SakuraPetal
    @State private var dragAmount: CGSize = Constants.startOffset
    var timer: Timer.TimerPublisher = Timer.publish(every: 3.0, on: .main, in: .common)
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if #available(iOS 14.0, *) {
                VStack {
                    SakuraView(petal: $petal)
                        .offset(dragAmount)
                    Spacer()
                }
                .gesture(
                    DragGesture()
                        .onChanged {
                            self.dragAmount = $0.translation
                        }
                        .onEnded { _ in
                            withAnimation(.easeIn(duration: 0.3)) {
                                self.dragAmount = Constants.startOffset
                            }
                        }
                )
                .onChange(of: petal) { newValue in
                    print("Changing to: \(newValue)")
                    
                    withAnimation(Animation.gentleDrop()) {
                        self.dragAmount = Constants.endOffset
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + petal.duration) {
                        withAnimation {
                            self.dragAmount = Constants.startOffset
                        }
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
}

extension View {
    func bloom(petal: Binding<SakuraPetal>) -> some View {
        self.modifier(SakuraModifier(petal: petal))
    }
}


struct SakuraModifier_Previews: PreviewProvider {
    
    @State static var petal = SakuraPetal(title: "Sakura 🌸",
                            message: "It's been said cherry blossom petals fall at a rate of 5 cm per second.")
 
    static var previews: some View {
        HStack {
            Text("hi")
        }
        .bloom(petal: $petal)
    }
    
}

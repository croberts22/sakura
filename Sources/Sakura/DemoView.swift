//
//  DemoView.swift
//  
//
//  Created by Corey Roberts on 12/15/20.
//

import SwiftUI

struct DemoView: View {
    
    @State var petal: SakuraPetal = SakuraPetal(title: "Sakura 🌸",
                                                message: "It's been said cherry blossom petals fall at 5 cm per second.",
                                                type: .info)
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text(petal.title)
                .bold()
            Spacer()
                .frame(height: 10)
            Text(petal.message)
            Spacer()
                .frame(height: 20)
            VStack {
                let cases: [SakuraType] = [.info,
                                           .success,
                                           .warning,
                                           .error,
                                           .other("Custom", .purple, .white, "🍫")]
                
                ForEach(cases, id: \.self) { type in
                    Button(action: {
                        self.petal = SakuraPetal(title: "Sakura",
                                                 message: "[\(type.description.uppercased())] It's been said cherry blossom petals fall at 5 cm per second.",
                                                 type: type)
                    }, label: {
                        Text("\(type.emoji) \(type.description)")
                            .foregroundColor(type.foregroundColor)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                    })
                    .background(type.backgroundColor)
                    .cornerRadius(10)
                }
            }
        }
        .padding(20)
        .bloom(petal: $petal)
    }
}

struct DemoView_Previews: PreviewProvider {
    
    static var previews: some View {
        DemoView()
    }
    
}

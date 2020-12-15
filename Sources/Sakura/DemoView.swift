//
//  DemoView.swift
//  
//
//  Created by Corey Roberts on 12/15/20.
//

import SwiftUI

struct DemoView: View {
    
    @State var bloom: Bool = false
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
            VStack(alignment: .center) {
                
                let cases: [SakuraType] = [.info,
                                           .success,
                                           .warning,
                                           .error,
                                           .other("Custom", .purple, .white)]
                
                ForEach(cases, id: \.self) { type in
                    Button(action: {
                        self.petal.type = type
                        self.bloom = true
                    }, label: {
                        Text(type.description)
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
        .sakura(petal: $petal, bloom: $bloom)
    }
}

struct DemoView_Previews: PreviewProvider {
    
    static var previews: some View {
        DemoView()
    }
    
}

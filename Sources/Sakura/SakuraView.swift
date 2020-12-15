//
//  SakuraView.swift
//  
//
//  Created by Corey Roberts on 11/8/20.
//

import SwiftUI

struct SakuraView: View {
    
    @Binding var petal: SakuraPetal
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10.0) {
                    Text(petal.title)
                        .fontWeight(.bold)
                    Text(petal.message)
                }
                Spacer()
            }
            .foregroundColor(.white)
            .padding(12)
            .background(petal.type.backgroundColor)
            .cornerRadius(12)
        }
        .padding()
    }
    
}

struct SakuraView_Previews: PreviewProvider {
    
    @State static var petal = SakuraPetal(title: "Sakura 🌸",
                            message: "It's been said cherry blossom petals fall at a rate of 5 cm per second.")
    
    static var previews: some View {
        SakuraView(petal: $petal)
            .previewLayout(.sizeThatFits)
    }
    
}

//
//  BannerView.swift
//  
//
//  Created by Corey Roberts on 11/8/20.
//

import SwiftUI

struct BannerView: View {
    
    @Binding var petal: Petal
    
    var body: some View {
        
        switch petal {
        case .message(let string):
            Button(string) {
                print("Button tapped")
            }
            .padding(10)
            .font(.footnote)
            .background(Color.pink)
            .foregroundColor(.black)
            .cornerRadius(10.0)
        }
        

    }
}

struct BannerView_Previews: PreviewProvider {
    
    @State static var petal: Petal = .message("Message received!")
    
    static var previews: some View {
        BannerView(petal: $petal)
    }
}

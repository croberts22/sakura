//
//  SakuraView.swift
//  
//
//  Created by Corey Roberts on 10/10/20.
//

import SwiftUI

enum Petal {
    case message(String)
}

struct SakuraView: View {
    
    @State private var message = "Your list has been updated.\nLast updated: 11/10/20 at 3:40pm."
    @State private var animationAmount: CGFloat = 1
    @State private var petal: Petal = .message("")
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                
                Button(message) {
                    print("Button tapped")
                }
                .frame(width: geometry.size.width * 0.90, height: 60)
                .font(.footnote)
                .background(Color.pink)
                .foregroundColor(.black)
                .cornerRadius(10.0)
                //        .animation(.interpolatingSpring(stiffness: 50, damping: 1))
                
                TextField("Message", text: $message)
                    .padding(10)
                
            }
        }
        
    }
}

struct SakuraView_Previews: PreviewProvider {
    static var previews: some View {
        SakuraView()
    }
}

//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Pribelszki Levente on 2020. 10. 13..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .background(Color.red)
                .edgesIgnoringSafeArea(.all)

            Button("Push me") {
                print(type(of: self.body))
            }
            .background(Color.red)
            .frame(width: 200, height: 200)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

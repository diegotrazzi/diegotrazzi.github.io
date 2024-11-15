//
//  ContentView.swift
//  MetalPipeline
//
//  Created by mac_sys1 on 11/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
          MetalView()
            .border(Color.black, width: 4)
          Text("Hello Metal!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

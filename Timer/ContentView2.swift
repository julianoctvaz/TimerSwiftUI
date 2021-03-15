//
//  ContentView2.swift
//  Timer
//
//  Created by Juliano Vaz on 15/03/21.
//

import Foundation
import SwiftUI

struct ContentView2: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    var body: some View {
        Text("Hello, World!")
            .onReceive(timer) { time in
                if self.counter == 5 {
                    self.timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }
                
                self.counter += 1
            }
    }
}

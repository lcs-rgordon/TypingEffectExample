//
//  ContentView.swift
//  TypingEffectExample
//
//  Created by Russell Gordon on 2022-05-20.
//

import SwiftUI

// Typing effect adapted from:
// https://medium.com/@cboynton/achieving-a-type-on-text-effect-in-swift-6934b683d1e9
struct ContentView: View {
    
    // MARK: Stored properties
    let messageToType = "Come with me###, and see what has been foretold#.#.#."
    
    // MARK: Computed properties
    var body: some View {
        Text("")
            .typeOn(message: messageToType)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portraitUpsideDown)
        
    }
}

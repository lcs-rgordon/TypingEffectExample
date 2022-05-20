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
            // To learn how to add custom fonts, see:
            // https://betterprogramming.pub/swiftui-basics-importing-custom-fonts-b6396d17424d
            // NOTE: Be sure to remove license.txt files from the list of files that are copied into the app bundle.
            //       Multiple files with the same name will create a compile time error.
            .font(Font.custom("kongtext", size: 24))
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portraitUpsideDown)
        
    }
}

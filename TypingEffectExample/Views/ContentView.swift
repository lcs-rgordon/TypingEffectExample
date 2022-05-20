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
    let message = "Come with me, and see what has been foretold..."
    
    // MARK: Computed properties
    var body: some View {
        Text(message)
            // To learn how to add custom fonts, see:
            // https://betterprogramming.pub/swiftui-basics-importing-custom-fonts-b6396d17424d
            // NOTE: Be sure to remove license.txt files from the list of files that are copied into the app bundle.
            //       Multiple files with the same name will create a compile time error.
            .typeOn(message: "Bananas")
            .font(Font.custom("kongtext", size: 24))
            .padding()
    }
}

// How to make a custom view modifier described here:
// https://useyourloaf.com/blog/swiftui-custom-view-modifiers/
struct TypeOnViewModifier: ViewModifier {
    
    let message: String
    var characterArray = Array("")
    @State var count = 0
    
    // Controls speed of typing effecct
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    // Runs once when view modifier is applied
    init(message: String) {
        self.message = message
        
        // Set the array of characters
        characterArray = Array(message)
    }
    
    func body(content: Content) -> some View {
        Text("\(count)")
            .onReceive(timer) { input in
                print("Hello world!")
                count += 1
                if count == 10 {
                    print("All done.")
                    timer.upstream.connect().cancel()
                }
            }
    }
}

extension View {
    func typeOn(message: String) -> some View {
        self.modifier(TypeOnViewModifier(message: message))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}

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
    let messageToType = "Come with me, and see what has been foretold..."
    
    // MARK: Computed properties
    var body: some View {
        Text("")
        // To learn how to add custom fonts, see:
        // https://betterprogramming.pub/swiftui-basics-importing-custom-fonts-b6396d17424d
        // NOTE: Be sure to remove license.txt files from the list of files that are copied into the app bundle.
        //       Multiple files with the same name will create a compile time error.
            .typeOn(message: messageToType)
            .font(Font.custom("kongtext", size: 24))
            .padding()
    }
}

// How to make a custom view modifier described here:
// https://useyourloaf.com/blog/swiftui-custom-view-modifiers/
struct TypeOnViewModifier: ViewModifier {
    
    let message: String
    var characterArray = Array("")
    @State var characterIndex = 0
    @State var textToShow = ""
    
    // Controls speed of typing effecct
    let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    
    // Runs once when view modifier is applied
    init(message: String) {
        self.message = message
        
        // Set the array of characters
        characterArray = Array(message)
    }
    
    func body(content: Content) -> some View {
        Text(textToShow)
            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, alignment: .leading)
            .border(.red)
            .multilineTextAlignment(.leading)
            .onReceive(timer) { input in
                
                // Skip spaces
                while characterArray[characterIndex] == " " {
                    textToShow.append(" ")
                    characterIndex += 1
                    
                    // Stop the timer if at the end of the message
                    if characterIndex == characterArray.count {
                        timer.upstream.connect().cancel()
                        return
                    }
                    
                }
                
                // Add one more letter to the text view
                textToShow.append(characterArray[characterIndex])
                
                // Advance to next letter
                characterIndex += 1
                
                // Stop the timer if at the end of the message
                if characterIndex == characterArray.count {
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

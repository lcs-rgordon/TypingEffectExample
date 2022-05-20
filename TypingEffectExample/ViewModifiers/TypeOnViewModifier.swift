//
//  TypeOnViewModifier.swift
//  TypingEffectExample
//
//  Created by Russell Gordon on 2022-05-20.
//

import Foundation
import SwiftUI

// Control typing speed
enum TypingSpeed: Int {
    case fast = 1
    case normal = 2
    case slow = 3
}

// How to make a custom view modifier described here:
// https://useyourloaf.com/blog/swiftui-custom-view-modifiers/
struct TypeOnViewModifier: ViewModifier {
    
    // MARK: Stored
    
    // The message to be "typed" on to the screen
    let message: String
    
    // How fast to type the text
    let speed: TypingSpeed

    // Whether to show a bounding box around the view that contains the typed text
    let debug: Bool
    
    // An array of characters that form the message to be shown
    var characterArray = Array("")
    
    // Counter to control timing
    @State var timingCounter = 0
    
    // What character we are currently showing
    @State var characterIndex = 0
    
    // Extra spaces added to force text view to be as wide
    // as possible to avoid wrapping issues when text is revealed
    // TODO: Fix this hack; the number of spaces is a guess and won't work for all device sizes
    @State var textToShow = "                                                                "
    
    // Drives the reveal of each character
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    // Runs once when view modifier is applied
    init(message: String, speed: TypingSpeed, debug: Bool) {
        self.message = message
        
        // Set the array of characters
        characterArray = Array(message)
        
        // Whether to show the frame of the text view
        self.debug = debug
        
        // The speed at which text should be typed
        self.speed = speed
    }
    
    func body(content: Content) -> some View {
        HStack {
            Text(textToShow)
                .border(.red, width: debug ? 1.0 : 0.0)
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
                    
                    // Increment timing counter
                    timingCounter += 1

                    // Only animate when the timing counter is a multiple of the speed
                    if timingCounter.isMultiple(of: speed.rawValue) {

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

            Spacer()
        }
        
        
    }
}

extension View {
    func typeOn(message: String, speed: TypingSpeed = .normal, debugLayout: Bool = false) -> some View {
        self.modifier(TypeOnViewModifier(message: message, speed: speed, debug: debugLayout))
    }
}

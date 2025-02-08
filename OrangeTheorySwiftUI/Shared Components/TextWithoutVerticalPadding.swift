//
//  TextWithoutVerticalPadding.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/8/25.
//

import Foundation
import SwiftUI

/// By default, the built-in fonts provide a vertical padding for special characters.
/// This view removes that vertical padding to allow a top vertical alignment with the top of most characters
/// Note that as a result, special characters will be outside of the frame of the view
/// Solution is from https://stackoverflow.com/a/75571276
struct TextWithoutVerticalPadding: View {
    let text: String
    let fontStyle: UIFont.TextStyle
    
    init(_ text: String, fontStyle: UIFont.TextStyle) {
        self.text = text
        self.fontStyle = fontStyle
    }
    
    private var font: UIFont {
        UIFont.preferredFont(forTextStyle: fontStyle)
    }
    
    var body: some View {
        Text(text)
            .font(Font(font))
            .padding(.bottom, font.descender)
            .padding(.top, font.capHeight - font.lineHeight - font.descender)
    }
}

#Preview("No special characters") {
    TextWithoutVerticalPadding("This is a text without padding", fontStyle: .largeTitle)
        .border(.red)
}

#Preview("Special characters") {
    TextWithoutVerticalPadding("Ög?q", fontStyle: .largeTitle)
        .border(.red)
}


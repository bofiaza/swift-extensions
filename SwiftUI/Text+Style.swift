import SwiftUI

public struct StyledText {
    public var text: String
    public var attribute: SimpleTextAttribute
    
    public init(text: String, attribute: SimpleTextAttribute) {
        self.text = text
        self.attribute = attribute
    }
}

public struct SimpleTextAttribute {
    public var font: Font
    public var foregroundColor: Color
    
    public init(font: Font, foregroundColor: Color) {
        self.font = font
        self.foregroundColor = foregroundColor
    }
}

extension Text {
    public init(_ styledText: StyledText) {
        self = Text(styledText.text)
            .font(styledText.attribute.font)
            .foregroundColor(styledText.attribute.foregroundColor)
    }
    
    public func withTextAttribute(_ attribute: SimpleTextAttribute) -> some View {
        self
            .font(attribute.font)
            .foregroundColor(attribute.foregroundColor)
    }
}

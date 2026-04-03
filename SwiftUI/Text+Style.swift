import SwiftUI

// MARK: - StyledText

/// A structure that represents a string with an associated text style.
///
/// Use `StyledText` when you want to encapsulate both the text and its styling
/// in a single reusable object.
public struct StyledText {
    
    /// The string content.
    public var text: String
    
    /// The styling attributes applied to the text.
    public var attribute: SimpleTextAttribute
    
    /// Creates a new `StyledText` instance with the given text and attributes.
    ///
    /// - Parameters:
    ///   - text: The string content.
    ///   - attribute: The styling attributes to apply.
    ///
    /// ### Example
    /// ```swift
    /// let attr = SimpleTextAttribute(font: .title.bold(), foregroundColor: .blue)
    /// let styled = StyledText(text: "Hello World", attribute: attr)
    /// ```
    public init(text: String, attribute: SimpleTextAttribute) {
        self.text = text
        self.attribute = attribute
    }
}

// MARK: - SimpleTextAttribute

/// A structure that defines simple styling attributes for text in SwiftUI.
public struct SimpleTextAttribute {
    
    /// The font to apply to the text.
    public var font: Font
    
    /// The foreground color of the text.
    public var foregroundColor: Color
    
    /// Creates a new `SimpleTextAttribute`.
    ///
    /// - Parameters:
    ///   - font: The font to apply.
    ///   - foregroundColor: The foreground color to apply.
    ///
    /// ### Example
    /// ```swift
    /// let attr = SimpleTextAttribute(font: .headline, foregroundColor: .red)
    /// ```
    public init(font: Font, foregroundColor: Color) {
        self.font = font
        self.foregroundColor = foregroundColor
    }
}

// MARK: - Text Extensions

extension Text {
    
    /// Initializes a SwiftUI `Text` view from a `StyledText`.
    ///
    /// This allows you to create a `Text` view with a predefined string and style in one step.
    ///
    /// - Parameter styledText: The `StyledText` containing the text and its styling.
    ///
    /// ### Example
    /// ```swift
    /// let attr = SimpleTextAttribute(font: .title, foregroundColor: .green)
    /// let styled = StyledText(text: "Hello SwiftUI", attribute: attr)
    /// Text(styled)
    /// ```
    public init(_ styledText: StyledText) {
        self = Text(styledText.text)
            .font(styledText.attribute.font)
            .foregroundColor(styledText.attribute.foregroundColor)
    }
    
    /// Applies a `SimpleTextAttribute` style to an existing `Text` view.
    ///
    /// - Parameter attribute: The `SimpleTextAttribute` to apply.
    /// - Returns: A view with the font and foreground color updated.
    ///
    /// ### Example
    /// ```swift
    /// let attr = SimpleTextAttribute(font: .headline, foregroundColor: .orange)
    /// Text("Hello").withTextAttribute(attr)
    /// ```
    public func withTextAttribute(_ attribute: SimpleTextAttribute) -> some View {
        self
            .font(attribute.font)
            .foregroundColor(attribute.foregroundColor)
    }
}

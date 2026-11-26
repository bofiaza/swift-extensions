import SwiftUI

/// A view modifier that wraps content in an accessibility container
/// and optionally applies accessibility metadata.
///
/// This modifier creates an invisible container element that:
/// - Can provide an accessibility label, hint, and identifier
/// - Preserves the accessibility of child views
/// - Expands the hit area to cover the container bounds
///
/// Use this when multiple child views should be grouped as a single
/// accessibility element, while remaining fully discoverable.
struct ViewAccessibilityModifier: ViewModifier {
    
    private let label: String?
    private let hint: String?
    private let identifier: String?
    
    /// Initializes the modifier with optional accessibility information.
    ///
    /// - Parameters:
    ///   - label: An optional accessibility label describing the container.
    ///   - hint: An optional accessibility hint providing extra context.
    ///   - identifier: An optional accessibility identifier for UI testing.
    init(
        label: String?,
        hint: String?,
        identifier: String?
    ) {
        self.label = label
        self.hint = hint
        self.identifier = identifier
    }
    
    func body(content: Content) -> some View {
        ZStack {
            // Invisible container to apply accessibility metadata
            Color.clear
                .contentShape(Rectangle())
                .applyIf(label) { view, label in
                    view.accessibilityLabel(label)
                }
                .applyIf(hint) { view, hint in
                    view.accessibilityHint(hint)
                }
                .applyIf(identifier) { view, identifier in
                    view.accessibilityIdentifier(identifier)
                }
            
            VStack {
                content
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .accessibilityElement(children: .contain)
    }
}

extension View {
    /// Wraps the view in an accessibility container with optional metadata.
    ///
    /// If at least one of `label`, `hint`, or `identifier` is provided, the view is
    /// wrapped in a container that exposes this information to assistive technologies.
    /// If all parameters are `nil`, the view is returned unchanged.
    ///
    /// - Parameters:
    ///   - label: Optional accessibility label for the container.
    ///   - hint: Optional accessibility hint for the container.
    ///   - identifier: Optional accessibility identifier for UI testing.
    /// - Returns: Either the view wrapped in an accessibility container or the original view.
    ///
    /// ### Example
    /// ```swift
    /// VStack {
    ///     Text("Title")
    ///     Text("Subtitle")
    /// }
    /// .applyAccessibilityInfo(
    ///     label: "Profile Information",
    ///     hint: "Displays the user’s profile details",
    ///     identifier: "profile_container"
    /// )
    /// ```
    @ViewBuilder
    public func applyAccessibilityInfo(
        label: String? = nil,
        hint: String? = nil,
        identifier: String? = nil
    ) -> some View {
        if label == nil && hint == nil && identifier == nil {
            self
        } else {
            modifier(
                ViewAccessibilityModifier(
                    label: label,
                    hint: hint,
                    identifier: identifier
                )
            )
        }
    }
}

import Foundation

extension URL {
    
    /// Returns a "blank" URL, equivalent to `about:blank`.
    ///
    /// ### Example
    /// ```swift
    /// let blankURL = URL.blank
    /// print(blankURL) // Prints "about:blank"
    /// ```
    public static var blank: URL {
        URL(string: "about:blank")!
    }
    
    /// Indicates whether this URL is the "blank" URL (`about:blank`).
    ///
    /// - Returns: `true` if the URL is `about:blank`; otherwise, `false`.
    ///
    /// ### Example
    /// ```swift
    /// let url = URL.blank
    /// print(url.isBlank) // true
    ///
    /// let website = URL(string: "https://example.com")!
    /// print(website.isBlank) // false
    /// ```
    public var isBlank: Bool {
        self == .blank
    }
    
    /// Indicates whether this URL is not the "blank" URL.
    ///
    /// - Returns: `true` if the URL is not `about:blank`; otherwise, `false`.
    ///
    /// ### Example
    /// ```swift
    /// let url = URL(string: "https://example.com")!
    /// print(url.isNotBlank) // true
    ///
    /// let blankURL = URL.blank
    /// print(blankURL.isNotBlank) // false
    /// ```
    public var isNotBlank: Bool {
        self != .blank
    }
}

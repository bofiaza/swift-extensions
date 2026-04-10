import Foundation

// MARK: - Core Intents

/// A simple action that performs work without input or output.
///
/// ### Example
/// ```swift
/// let log: Action = {
///     print("Something happened")
/// }
/// ```
public typealias Action = () -> Void

/// A function that handles a single input value.
///
/// Useful for callbacks, event handlers, and pipelines.
///
/// ### Example
/// ```swift
/// struct Credentials {
///     let username: String
///     let password: String
/// }
///
/// let handler: Handler<Credentials> = { credentials in
///     print(credentials.username)
/// }
/// ```
///
/// ### Tuple example
/// ```swift
/// typealias NameAgeHandler = Handler<(name: String, age: Int)>
///
/// let handler: NameAgeHandler = { data in
///     print(data.name, data.age)
/// }
/// ```
public typealias Handler<Input> = (Input) -> Void

/// An asynchronous version of `Handler`.
///
/// ### Example
/// ```swift
/// let handler: AsyncHandler<Int> = { value in
///     print("Start \\(value)")
///     try? await Task.sleep(nanoseconds: 1_000_000_000)
///     print("End \\(value)")
/// }
///
/// Task {
///     await handler(42)
/// }
/// ```
public typealias AsyncHandler<Input> = (Input) async -> Void

/// A throwing handler that can fail during execution.
///
/// ### Example
/// ```swift
/// let handler: ThrowingHandler<String> = { input in
///     if input.isEmpty {
///         throw NSError(domain: "EmptyInput", code: 0)
///     }
///     print(input)
/// }
/// ```
public typealias ThrowingHandler<Input> = (Input) throws -> Void

/// An asynchronous throwing handler.
///
/// ### Example
/// ```swift
/// let handler: AsyncThrowingHandler<Int> = { value in
///     try await Task.sleep(nanoseconds: 500_000_000)
///     if value < 0 {
///         throw NSError(domain: "NegativeValue", code: 0)
///     }
/// }
///
/// Task {
///     try await handler(10)
/// }
/// ```
public typealias AsyncThrowingHandler<Input> = (Input) async throws -> Void

/// A provider that returns a value when called.
///
/// ### Example
/// ```swift
/// let provider: Provider<String> = {
///     return "Hello"
/// }
///
/// print(provider())
/// ```
public typealias Provider<Output> = () -> Output

/// An asynchronous provider that returns a value.
///
/// ### Example
/// ```swift
/// let provider: AsyncProvider<String> = {
///     try? await Task.sleep(nanoseconds: 500_000_000)
///     return "Hello async"
/// }
///
/// Task {
///     let value = await provider()
/// }
/// ```
public typealias AsyncProvider<Output> = () async -> Output

/// A function that transforms an input into an output.
///
/// ### Example
/// ```swift
/// let mapper: Mapper<Int, String> = { value in
///     return "\\(value)"
/// }
/// ```
public typealias Mapper<Input, Output> = (Input) -> Output

/// A function that evaluates a condition on an input.
///
/// ### Example
/// ```swift
/// let isEven: Predicate<Int> = { value in
///     value % 2 == 0
/// }
/// ```
public typealias Predicate<Input> = (Input) -> Bool

// MARK: - Common

public typealias Completion = Action
public typealias ErrorHandler = Handler<Error>
public typealias BoolHandler = Handler<Bool>

public typealias BoolProvider = Provider<Bool>

// MARK: - Stub defaults

/// A collection of prebuilt stub implementations for testing,
/// previews, and default behaviors.
///
/// These are useful when you need no-op or predictable closures
/// instead of real implementations.
///
/// ### Example
/// ```swift
/// let handler: Handler<Int> = StubDefaults.handler()
/// let value: Provider<String> = StubDefaults.value("Hello")
/// let check: Predicate<Int> = StubDefaults.predicate(true)
/// ```
public enum StubDefaults {
    
    // MARK: - Actions
    
    /// A no-op action that does nothing.
    ///
    /// ### Example
    /// ```swift
    /// let completion: Completion = StubDefaults.action
    /// completion()
    /// ```
    public static let action: Action = {}
    
    /// Returns a no-op handler that ignores its input.
    ///
    /// ### Example
    /// ```swift
    /// let handler: Handler<String> = StubDefaults.handler()
    /// handler("ignored")
    /// ```
    public static func handler<T>() -> Handler<T> {
        { _ in }
    }
    
    // MARK: - Providers
    
    /// Returns a provider that always returns the given value.
    ///
    /// ### Example
    /// ```swift
    /// let provider = StubDefaults.value(42)
    /// print(provider()) // 42
    /// ```
    public static func value<T>(_ value: T) -> Provider<T> {
        { value }
    }
    
    /// A provider that always returns `true`.
    public static let trueProvider: BoolProvider = { true }
    
    /// A provider that always returns `false`.
    public static let falseProvider: BoolProvider = { false }
    
    // MARK: - Predicates
    
    /// Returns a predicate that always returns the given boolean value,
    /// regardless of input.
    ///
    /// ### Example
    /// ```swift
    /// let alwaysTrue: Predicate<String> = StubDefaults.predicate(true)
    /// let result = alwaysTrue("anything") // true
    /// ```
    public static func predicate<T>(_ value: Bool = false) -> Predicate<T> {
        { _ in value }
    }
}

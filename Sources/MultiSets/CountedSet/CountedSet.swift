//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift Collections open source project
//
// Copyright (c) 2021 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

/// An unordered, counted multiset.
@frozen
public struct CountedSet<Element: Hashable>: RawRepresentable {
  // Allows internal setter to be referenced from inlined code
  @usableFromInline
  internal var _storage = RawValue()

  @inlinable @inline(__always)
  public var rawValue: [Element: Int] { _storage }

  /// Creates an empty counted set with preallocated space for at least the
  /// specified number of unique elements.
  ///
  /// - Parameter minimumCapacity: The minimum number of elements that the
  ///   newly created counted set should be able to store without reallocating
  ///   its storage buffer.
  @inlinable
  public init(minimumCapacity: Int) {
    self._storage = .init(minimumCapacity: minimumCapacity)
  }

  @inlinable
  public init?(rawValue: [Element: Int]) {
    guard rawValue.values.allSatisfy({ $0.signum() == 1 }) else { return nil }
    _storage = rawValue
  }
}

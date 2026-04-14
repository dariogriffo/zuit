const std = @import("std");
const testing = std.testing;

pub fn add(a: i32, b: i32) i32 {
    return a + b;
}

pub fn sub(a: i32, b: i32) i32 {
    return a - b;
}

pub fn mul(a: i32, b: i32) i32 {
    return a * b;
}

pub fn div(a: i32, b: i32) !i32 {
    if (b == 0) return error.DivisionByZero;
    return @divTrunc(a, b);
}

pub fn factorial(n: u32) u64 {
    if (n == 0) return 1;
    return n * factorial(n - 1);
}

// -----------------------------------------------------------------------
// Per-file hooks
// -----------------------------------------------------------------------

test "beforeAll" {
    std.debug.print("\n[math] setting up\n", .{});
}

test "afterAll" {
    std.debug.print("[math] tearing down\n", .{});
}

// -----------------------------------------------------------------------
// Tests
// -----------------------------------------------------------------------

test "add: two positives" {
    try testing.expectEqual(@as(i32, 5), add(2, 3));
}

test "add: negative" {
    try testing.expectEqual(@as(i32, -1), add(2, -3));
}

test "sub" {
    try testing.expectEqual(@as(i32, 1), sub(4, 3));
}

test "mul" {
    try testing.expectEqual(@as(i32, 12), mul(3, 4));
}

test "div: normal" {
    try testing.expectEqual(@as(i32, 3), try div(9, 3));
}

test "div: by zero" {
    try testing.expectError(error.DivisionByZero, div(5, 0));
}

test "factorial: base case" {
    try testing.expectEqual(@as(u64, 1), factorial(0));
}

test "factorial: small" {
    try testing.expectEqual(@as(u64, 120), factorial(5));
}

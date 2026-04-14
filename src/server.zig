/// src/server.zig - Example showing per-file and global hooks side by side.
const std = @import("std");
const testing = std.testing;

// -----------------------------------------------------------------------
// Your actual source code
// -----------------------------------------------------------------------

pub fn add(a: i32, b: i32) i32 {
    return a + b;
}

pub fn divide(a: i32, b: i32) !i32 {
    if (b == 0) return error.DivisionByZero;
    return @divTrunc(a, b);
}

// -----------------------------------------------------------------------
// Per-file hooks — scoped only to tests in THIS file
// -----------------------------------------------------------------------

test "beforeAll" {
    // Runs once before all tests in this file.
    // e.g. spin up a test database connection, open a file, etc.
    std.debug.print("\n[server] beforeAll: setting up\n", .{});
}

test "afterAll" {
    // Runs once after all tests in this file.
    std.debug.print("[server] afterAll: tearing down\n", .{});
}

test "beforeEach" {
    // Runs before EACH test in this file.
    std.debug.print("[server] beforeEach\n", .{});
}

test "afterEach" {
    // Runs after EACH test in this file.
    std.debug.print("[server] afterEach\n", .{});
}

// -----------------------------------------------------------------------
// Actual tests
// -----------------------------------------------------------------------

test "add: positive numbers" {
    try testing.expectEqual(@as(i32, 5), add(2, 3));
}

test "add: negative numbers" {
    try testing.expectEqual(@as(i32, -1), add(2, -3));
}

test "divide: normal" {
    try testing.expectEqual(@as(i32, 2), try divide(6, 3));
}

test "divide: by zero returns error" {
    try testing.expectError(error.DivisionByZero, divide(1, 0));
}

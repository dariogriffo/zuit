/// src/main.zig - Root file. Global hooks live here with the "zuit:" prefix.
const std = @import("std");
const server = @import("server.zig");

// -----------------------------------------------------------------------
// Global hooks — run for the ENTIRE suite, regardless of file
// -----------------------------------------------------------------------

test "zuit:beforeAll" {
    // Runs once before any test in any file.
    std.debug.print("\n[global] beforeAll: suite starting\n", .{});
}

test "zuit:afterAll" {
    // Runs once after every test in every file.
    std.debug.print("[global] afterAll: suite complete\n", .{});
}

test "zuit:beforeEach" {
    // Runs before every individual test across all files.
    std.debug.print("[global] beforeEach\n", .{});
}

test "zuit:afterEach" {
    // Runs after every individual test across all files.
    std.debug.print("[global] afterEach\n", .{});
}

// Pull in tests from other files
test {
    std.testing.refAllDecls(server);
}

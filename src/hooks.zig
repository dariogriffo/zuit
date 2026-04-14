const std = @import("std");

/// hooks.zig - Naming convention definitions for zuit lifecycle hooks.
///
/// By convention, lifecycle hooks are test blocks named with special suffixes:
///
///   Global hooks (apply to the entire test suite):
///     test "zuit:beforeAll" { ... }   - runs once before all tests
///     test "zuit:afterAll"  { ... }   - runs once after all tests
///     test "zuit:beforeEach" { ... }  - runs before every test
///     test "zuit:afterEach" { ... }   - runs after every test
///
///   Per-file hooks (apply only to tests in the same file):
///     test "beforeAll" { ... }    - runs once before all tests in this file
///     test "afterAll"  { ... }    - runs once after all tests in this file
///     test "beforeEach" { ... }   - runs before each test in this file
///     test "afterEach" { ... }    - runs after each test in this file
///
/// Per-file hooks are scoped by matching the file path prefix of the test name.
/// Global hooks (prefixed with "zuit:") run regardless of file.

// Global hook names (must match exactly, after the module path prefix)
pub const global_before_all = "zuit:beforeAll";
pub const global_after_all = "zuit:afterAll";
pub const global_before_each = "zuit:beforeEach";
pub const global_after_each = "zuit:afterEach";

// Per-file hook suffixes (matched by test name after the last ".test.")
pub const file_before_all = "beforeAll";
pub const file_after_all = "afterAll";
pub const file_before_each = "beforeEach";
pub const file_after_each = "afterEach";

pub const HookKind = enum {
    global_before_all,
    global_after_all,
    global_before_each,
    global_after_each,
    file_before_all,
    file_after_all,
    file_before_each,
    file_after_each,
    normal,
};

/// Extract the short test name after the last ".test." marker.
pub fn extractTestName(full_name: []const u8) []const u8 {
    const marker = std.mem.lastIndexOf(u8, full_name, ".test.") orelse return full_name;
    return full_name[marker + 6 ..];
}

/// Extract the file path prefix before ".test." (e.g. "src.server.handshake")
pub fn extractFilePath(full_name: []const u8) []const u8 {
    const marker = std.mem.lastIndexOf(u8, full_name, ".test.") orelse return "";
    return full_name[0..marker];
}

/// Classify a test function by its name.
pub fn classify(full_name: []const u8) HookKind {
    const name = extractTestName(full_name);

    if (std.mem.eql(u8, name, global_before_all)) return .global_before_all;
    if (std.mem.eql(u8, name, global_after_all)) return .global_after_all;
    if (std.mem.eql(u8, name, global_before_each)) return .global_before_each;
    if (std.mem.eql(u8, name, global_after_each)) return .global_after_each;
    if (std.mem.eql(u8, name, file_before_all)) return .file_before_all;
    if (std.mem.eql(u8, name, file_after_all)) return .file_after_all;
    if (std.mem.eql(u8, name, file_before_each)) return .file_before_each;
    if (std.mem.eql(u8, name, file_after_each)) return .file_after_each;

    return .normal;
}

/// Returns true if this test is any kind of hook (should not be counted as a real test).
pub fn isHook(full_name: []const u8) bool {
    return classify(full_name) != .normal;
}

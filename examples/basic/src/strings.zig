const std = @import("std");
const testing = std.testing;

pub fn isPalindrome(s: []const u8) bool {
    if (s.len == 0) return true;
    var i: usize = 0;
    var j: usize = s.len - 1;
    while (i < j) {
        if (s[i] != s[j]) return false;
        i += 1;
        j -= 1;
    }
    return true;
}

pub fn countChar(s: []const u8, c: u8) usize {
    var count: usize = 0;
    for (s) |ch| {
        if (ch == c) count += 1;
    }
    return count;
}

pub fn startsWith(s: []const u8, prefix: []const u8) bool {
    return std.mem.startsWith(u8, s, prefix);
}

// -----------------------------------------------------------------------
// Per-file hooks
// -----------------------------------------------------------------------

test "beforeAll" {
    std.debug.print("\n[strings] setting up\n", .{});
}

test "afterAll" {
    std.debug.print("[strings] tearing down\n", .{});
}

// -----------------------------------------------------------------------
// Tests
// -----------------------------------------------------------------------

test "isPalindrome: racecar" {
    try testing.expect(isPalindrome("racecar"));
}

test "isPalindrome: not a palindrome" {
    try testing.expect(!isPalindrome("hello"));
}

test "isPalindrome: empty string" {
    try testing.expect(isPalindrome(""));
}

test "isPalindrome: single char" {
    try testing.expect(isPalindrome("a"));
}

test "countChar: multiple hits" {
    try testing.expectEqual(@as(usize, 3), countChar("banana", 'a'));
}

test "countChar: no hits" {
    try testing.expectEqual(@as(usize, 0), countChar("hello", 'z'));
}

test "startsWith: match" {
    try testing.expect(startsWith("foobar", "foo"));
}

test "startsWith: no match" {
    try testing.expect(!startsWith("foobar", "bar"));
}

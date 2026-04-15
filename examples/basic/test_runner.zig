const std = @import("std");
const zunit = @import("zunit");

pub fn main() !void {
    try zunit.run(.{
        .output = .verbose_timing,
        .output_file = try zunit.outputFileArg(std.heap.page_allocator),
    });
}

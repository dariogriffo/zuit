const std = @import("std");
const zuit = @import("zuit");

pub fn main() !void {
    try zuit.run(.{
        .output = .verbose_timing,
        .output_file = try zuit.outputFileArg(std.heap.page_allocator),
    });
}

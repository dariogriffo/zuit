const std = @import("std");
const zunit = @import("zunit");

pub fn main(init: std.process.Init) !void {
    try zunit.run(init.io, .{
        .output = .verbose_timing,
        // Use init.arena: the parsed path lives until process exit, and
        // 0.16's process arena is freed automatically when main returns.
        .output_file = try zunit.outputFileArg(init.arena.allocator(), init.minimal.args),
    });
}

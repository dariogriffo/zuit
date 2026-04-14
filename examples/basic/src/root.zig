// Pull in all modules so their test blocks are included in the test binary.
test {
    _ = @import("math.zig");
    _ = @import("strings.zig");
}

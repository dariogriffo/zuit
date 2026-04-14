/// test_runner.zig
/// Drop this file into your project root and point build.zig at it.
/// This is the only file you need to write — zuit handles everything else.
const zuit = @import("zuit");

pub fn main() !void {
    try zuit.run(.{
        // Optional: programmatic global hooks (in addition to named ones)
        // .before_all = myGlobalSetup,
        // .after_all  = myGlobalTeardown,
        // .before_each = myGlobalBeforeEach,
        // .after_each  = myGlobalAfterEach,

        // What to do if a global hook errors
        .on_global_hook_failure = .abort,

        // What to do if a per-file hook errors
        .on_file_hook_failure = .skip_remaining,

        // Output style: .minimal | .verbose | .verbose_timing
        .output = .verbose_timing,
    });
}

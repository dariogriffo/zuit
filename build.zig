const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // The zunit module — this is what consumers import
    const zunit_mod = b.addModule("zunit", .{
        .root_source_file = b.path("src/zunit.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Internal tests for zunit itself
    const lib_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/zunit.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    const run_lib_tests = b.addRunArtifact(lib_tests);
    const test_step = b.step("test", "Run zunit's own tests");
    test_step.dependOn(&run_lib_tests.step);

    // -------------------------------------------------------------------------
    // Example: basic
    // Run with:  zig build example
    //            zig build example -- --output-file results.xml
    // -------------------------------------------------------------------------
    const example_mod = b.createModule(.{
        .root_source_file = b.path("examples/basic/src/root.zig"),
        .target = target,
        .optimize = optimize,
    });
    example_mod.addImport("zunit", zunit_mod);

    const example_tests = b.addTest(.{
        .root_module = example_mod,
        .test_runner = .{
            .path = b.path("examples/basic/test_runner.zig"),
            .mode = .simple,
        },
    });

    const run_example = b.addRunArtifact(example_tests);
    if (b.args) |args| run_example.addArgs(args);
    const example_step = b.step("example", "Run the basic example tests");
    example_step.dependOn(&run_example.step);
}

/// zunit - A test lifecycle library for Zig
/// Provides beforeAll, afterAll, beforeEach, afterEach hooks
/// at both global and per-file scope, with configurable output and error handling.
const std = @import("std");
const builtin = @import("builtin");

pub const runner = @import("runner.zig");
pub const hooks = @import("hooks.zig");

pub const OnHookFailure = runner.OnHookFailure;
pub const OutputStyle = runner.OutputStyle;
pub const Config = runner.Config;
pub const run = runner.run;
pub const outputFileArg = runner.outputFileArg;

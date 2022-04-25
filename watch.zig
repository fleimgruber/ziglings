// this works
const std = @import("std");
const ChildProcess = std.ChildProcess;
pub fn main() !void {
    const allocator = std.testing.allocator;

    const file_path = try std.fs.path.join(allocator, &[_][]const u8{ "./", "README.md" });
    defer allocator.free(file_path);

    var watch = try std.fs.Watch(void).init(allocator, 0);
    defer watch.deinit();

    var ev = async watch.channel.get();
    var ev_consumed = false;
    defer if (!ev_consumed) {
        _ = await ev;
    };

    const build_ziglings = [_][]const u8{ "zig-dev", "build" };

    const child_process = try ChildProcess.init(&build_ziglings, allocator);
    var term = try child_process.spawnAndWait();
    term;
}

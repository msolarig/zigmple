const std = @import("std");
const zeit = @import("zeit");

pub fn main() !void {
  while (true) {
    std.debug.print("\x1B[2J\x1B[H", .{});
    const now = try zeit.instant(.{});
    std.debug.print("{d}/{s}/{d} @ {s} {:0>2}:{:0>2}:{:0>2}", .{
      now.time().day,
      now.time().month.shortName(),
      now.time().year,
      now.timezone.fixed.name,
      now.time().hour, 
      now.time().minute, 
      now.time().second,
    });
    std.Thread.sleep(1_000_000_000);
  }
}

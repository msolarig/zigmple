const std = @import("std");
const ac = @import("arithmetic_calculator.zig");
const td = @import("time_display.zig");

const interfaceErrors = error{
  invalidInput,
  programDoesNotExist,
};

pub fn main() !void {
    
  std.debug.print("\x1B[2J\x1B[H", .{});

  const menu =
  \\Collection of Zigmple Projects!
  \\----------------------------------
  \\Execute:
  \\1: arithmetic_calculator
  \\2: time_display
  \\----------------------------------
  \\Input:  
  ;

  std.debug.print("{s}", .{ menu });

  var buffer: [64]u8 = undefined;
  const input = try getInput(&buffer);
  const program: u8 = if (input.len == 1) input[0] else {
    return interfaceErrors.invalidInput;
  };

  try switch (program) {
    '1' => ac.main(),
    '2' => td.main(),
    else => return interfaceErrors.programDoesNotExist,
  };
}

fn getInput(buffer: []u8) ![]u8 {
    var stdin_reader = std.fs.File.stdin().reader(buffer);
    const stdin = &stdin_reader.interface;
    const slice = try stdin.takeDelimiterExclusive('\n');
    return slice;
}

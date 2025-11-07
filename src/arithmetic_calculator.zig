const std = @import("std");

const calcErrors = error{
  InvalidOperation,
  AttemptedDivisionByZero,
};

pub fn main() !void {
    
  std.debug.print("\x1B[2J\x1B[H", .{});

  const menu =
  \\Zig Arithmetic Calculator
  \\----------------------------------
  \\Options
  \\1: Sum
  \\2: Subtract
  \\3: Multiply
  \\4: Divide
  \\----------------------------------
  \\Operation: 
  ;

  std.debug.print("{s}", .{ menu });

  // single reusable input buffer
  var buffer: [64]u8 = undefined;

  const input_operation = try getInput(&buffer);
  const operation: u8 = if (input_operation.len == 1) input_operation[0] else {
  return calcErrors.InvalidOperation;
  };

  std.debug.print("\nEnter the 1st number: ", .{});
  const num1 = try std.fmt.parseFloat(f64, try getInput(&buffer));

  std.debug.print("Enter the 2nd number: ", .{});
  const num2 = try std.fmt.parseFloat(f64, try getInput(&buffer));

  const result = switch (operation) {
    '1' => add(num1, num2),
    '2' => subtract(num1, num2),
    '3' => multiply(num1, num2),
    '4' => divide(num1, num2),
    else => return calcErrors.InvalidOperation,
  };

  std.debug.print("\nResult: {any}\n", .{result});
}

fn getInput(buffer: []u8) ![]u8 {
    var stdin_reader = std.fs.File.stdin().reader(buffer);
    const stdin = &stdin_reader.interface;
    const slice = try stdin.takeDelimiterExclusive('\n');
    return slice;
}

fn add(num1: f64, num2: f64) f64 {
  return num1 + num2;
}

fn subtract(num1: f64, num2: f64) f64 {
  return num1 - num2;
}

fn multiply(num1: f64, num2: f64) f64 {
  return num1 * num2;
}

fn divide(num1: f64, num2: f64) !f64 {
  if (num2 == 0) return calcErrors.AttemptedDivisionByZero;
  return num1 / num2;
}

const std = @import("std");
const testing = std.testing;
const zbson = @import("zbson");
const ObjectId = zbson.ObjectId;
const MsgHeader = @import("MessageHeader.zig");
const OpMessage = @import("OpMessage.zig");
const OpCompressed = @import("OpCompressed.zig");

pub const OpCode = enum(u16) {
    //Legacy Opcodes deprecated in favor of OP_MSG
    OP_REPLY = 1,
    OP_UPDATE = 2001,
    OP_INSERT = 2002,
    RESERVED = 2003,
    OP_QUERY = 2004,
    OP_GET_MORE = 2005,
    OP_DELETE = 2006,
    OP_KILL_CURSORS = 2007,

    OP_COMPRESSED = 2012,
    OP_MSG = 2013,
};

pub const Message = union(OpCode) {
    OP_MSG: OpMessage,
    OP_COMPRESSED: OpCompressed,
    _: undefined,
};

pub const Section = union(enum) {
    x: bool,
};

test "test oid" {
    const oid = ObjectId.new();
    std.debug.print("{any}\n", .{oid});
    try testing.expect(oid.counter != 0);
}

pub fn main() !void {
    std.debug.print("hello world!\n", .{});
    const oid = ObjectId.new();
    std.debug.print("{any}\n", .{oid});
}

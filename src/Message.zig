const OpCode = @import("root").OpCode;
const MsgHeader = @import("MessageHeader.zig");

const Message = @This();

message: union(OpCode) {
    OP_MSG = struct {
        header: MsgHeader,
    },
},

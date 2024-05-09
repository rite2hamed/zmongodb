const std = @import("std");
const Allocator = std.mem.Allocator;
const net = std.net;
const OpMessage = @import("OpMessage.zig");
const Header = @import("MessageHeader.zig");
const OpCode = @import("root").OpCode;
const BsonDocument = @import("zbson").BsonDocument;
const BsonVariant = @import("zbson").BsonVariant;

const Client = @This();

pub fn init(ally: Allocator) Client {
    const address = try net.Address.resolveIp("127.0.0.1", 27017);
    const stream = try net.tcpConnectToAddress(address);
    defer stream.close();

    var doc = BsonDocument.init(ally);
    doc.map.put("ping", BsonVariant.fromInt32(1));

    var msg = OpMessage{
        .header = Header{
            .opCode = .OP_MSG,
            .requestID = 1,
        },
        .sections = [_]OpMessage.Section{OpMessage.Payload.fromBody(doc)},
    };
    msg.header.messageLength = msg.sections[0].payload.Body.len();

    const data = "hellozig";
    var writer = stream.writer();
    const size = try writer.write(data);
    _ = size;
    //writer.writeAll(data);
    net.Address.parseIp("127.0.0.1", 27017);
}

pub fn deinit(self: *Client) void {
    self.* = undefined;
}

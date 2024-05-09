const MsgHeader = @import("MessageHeader.zig");
const BsonDocument = @import("zbson").BsonDocument;
const OpMessage = @This();

//https://github.com/mongodb/mongo/blob/master/src/mongo/rpc/op_msg.cpp

const CHECKSUM_PRESENT: u32 = 1 << 0;
const MORE_TO_COME: u32 = 1 << 1;
const EXHAUST_SUPPORTED: u32 = 1 << 16;

header: MsgHeader,
flagBits: u32,
sections: []Section,
checksum: ?u32,

const Kind = enum(u8) {
    Body,
    Sequence,
    Internnal,
};

pub const Payload = union(Kind) {
    Body: BsonDocument,
    Sequence: DocumentSequence,
    Internal: void,

    pub fn fromBody(body: BsonDocument) Section {
        return .{
            .kind = .Body,
            .Body = body,
        };
    }
};

const DocumentSequence = struct {
    size: i32,
    identifier: []const u8,
    docs: []BsonDocument,
};
const Section = struct {
    kind: Kind,
    payload: Payload,
};

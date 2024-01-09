const MsgHeader = @import("MessageHeader.zig");
const BsonDocument = @import("zbson").BsonDocument;
const OpMessage = @This();

header: MsgHeader,
flagBits: u32,
sections: []Section,
checksum: ?u32,

const Kind = enum(u8) {
    Body,
    Sequence,
    Internnal,
};

const Payload = union(Kind) {
    Body: BsonDocument,
    Sequence: DocumentSequence,
    Internal: void,
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

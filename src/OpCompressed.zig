const MsgHeader = @import("MessageHeader.zig");

const OpCompressed = @This();

header: MsgHeader,
originalOpcode: i32,
uncompressedSize: i32,
compressorId: Compressor,
compressedMessage: []const u8,

const Compressor = enum(u8) {
    noop,
    snappy,
    zlib,
    ztd,
    reserved,
};

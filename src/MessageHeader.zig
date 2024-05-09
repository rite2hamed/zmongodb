const MessageHeader = @This();

const MessageHeaderLength = @sizeOf(MessageHeader); //should be always 16 bytes

messageLength: i32,
requestID: i32,
responseTo: i32,
opCode: i32,

const std = @import("std");
const net = std.net;
const zbon = @import("zbson");

pub fn main() !void {
    const oid = zbon.ObjectId.new();
    std.debug.print("{any}\n", .{oid});
}

pub fn main2() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();
    _ = allocator;

    const peer = try net.Address.resolveIp("172.18.160.1", 27017);
    const stream = try net.tcpConnectToAddress(peer);
    defer stream.close();
    errdefer stream.close();
    std.debug.print("Connecting to {}\n", .{peer});

    const writer = stream.writer();
    try writer.writeAll("Hello world!");

    var buf: [1024]u8 = undefined;
    var resp_size = try stream.read(buf[0..]);
    std.debug.print("Got response: {any}\n", .{buf[0..resp_size]});
}

pub fn main1() !void {}

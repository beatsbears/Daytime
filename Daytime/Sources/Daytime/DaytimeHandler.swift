//
//  DaytimeHandler.swift
//  Daytime
//  Based on the Daytime protocol - https://tools.ietf.org/html/rfc867
//
//  Created by Andrew Scott on 9/10/18.
//

import Foundation
import NIO

// Daytime channel connection handler
public final class DaytimeHandler : ChannelInboundHandler {
    
    // This is the type of data the `channelRead` method receives from NIO.
    public typealias InboundIn = ByteBuffer
    
    // Thi is the returned type of data for NIO.
    public typealias OutboundOut = ByteBuffer
    
    // This method handles new connections
    public func channelActive(ctx: ChannelHandlerContext) {
        print("[+] New Channel, client address: ", ctx.channel.remoteAddress?.description ?? "-")
        let channel = ctx.channel
        var buffer = channel.allocator.buffer(capacity: 64)
        buffer.write(string: getTimestamp())
        ctx.writeAndFlush(NIOAny.init(buffer), promise: nil)
        ctx.close(promise: nil)
    }
    
    // This method is called if the socket is closed in a clean way.
    public func channelInactive(ctx: ChannelHandlerContext) {
        print("[+] Channel closed.")
    }
    
    // Called if an error happens. Log and close the socket.
    public func errorCaught(ctx: ChannelHandlerContext, error: Error) {
        print("[!] ERROR:", error)
        ctx.close(promise: nil)
    }
    
    // This method will get the current GMT time and return it as a formatted string.
    func getTimestamp() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "EEEE, MMMM d, yyyy H:mm:ss-zzz"
        return formatter.string(from: now) + "\n"
    }
}

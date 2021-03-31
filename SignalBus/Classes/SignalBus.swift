//
//  SignalBus.swift
//  SignalBus
//
//  Created by YanYi on 2021/3/31.
//

import UIKit


// 消息传输协议
@objc public protocol SignalTransmissionProtocol {
    @objc var body: [String: Any]? {get set}
    @objc var isSingle: Bool { get set}
    @objc var signalId: String! {get set}
}

// 消息体为遵守消息传输协议的对象
public typealias SignalReceiver = (SignalTransmissionProtocol) -> Void

open class SignalBus: NSObject {

    static public let shard = SignalBus()
    
    // 信号注册缓存缓存
    private var receiverCache : [String: SignalReceiver] = [:]
    
    /// 注册信号接受者到缓存池
    /// - Parameters:
    ///   - uniqueIdentifier: 任务唯一标识符 （务必保证id的唯一性，否则会覆盖掉原有的任务回调功能）
    ///   - signalReceiver: 信号接收体
    public func regist(_ uniqueIdentifier: String, _ signalReceiver: @escaping SignalReceiver) {
        receiverCache[uniqueIdentifier] = signalReceiver
    }
    
    public func send(_ uniqueIdentifier: String, signal: SignalTransmissionProtocol) {
        if let task = receiverCache[uniqueIdentifier] {
            task(signal)
            
        }
    }
    
    /// 根据注册ID移除缓存池接受者
    /// - Parameter uniqueIdentifier: 任务唯一标识符
    public func cancellation(_ uniqueIdentifier: String) {
        receiverCache.removeValue(forKey: uniqueIdentifier)
    }

}

open class SignalBody: NSObject,SignalTransmissionProtocol {
    
    // 信号体
    open var body: [String : Any]?
    // 是否为单次使用信号
    open var isSingle: Bool = true
    // 信号ID
    open var signalId: String!
    
    public init(with signalId: String, _ isSingle: Bool) {
        self.signalId = signalId
        self.isSingle = isSingle
    }
}

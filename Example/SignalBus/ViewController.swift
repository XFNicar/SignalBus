//
//  ViewController.swift
//  SignalBus
//
//  Created by XFNicar on 03/31/2021.
//  Copyright (c) 2021 XFNicar. All rights reserved.
//
import SignalBus
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        SignalBus.shard.regist("一个普通的发送事件") { (signalBody) in
            print(signalBody.body)
            print(signalBody.signalId)
        }
        
        let signal = SignalBody.init(with: "一个普通的发送事件", true)
        signal.body = ["消息内容": "我是一条测试消息"]
        SignalBus.shard.send("一个普通的发送事件", signal: signal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


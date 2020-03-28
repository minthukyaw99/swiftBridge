//
//  CalendarManager.swift
//  SwiftBridge
//
//  Created by Michael Schwartz on 12/11/15.
//  Copyright © 2015 Facebook. All rights reserved.
//

import Foundation

// CalendarManager.swift

@objc(GNearByManager)
class CalendarManager: RCTEventEmitter {
  private override init(){}
  private var publication:GNSPublication?
  private var subscription:GNSSubscription?
  private var manager = GNSMessageManager(apiKey: "AIzaSyCJgchjOLqRx4lersj_16H7YvBDvqOTZF8");
  
  override static  func requiresMainQueueSetup() -> Bool {
      return true
  }
  
  @objc override func supportedEvents() -> [String]! {
    return ["NearByEvent"]
  }
  
  @objc func addEvent(name: String, location: String, date: NSNumber) -> Void {
    // Date is ready to use!
    print(".....ad event")
  }
  
  @objc(debugMode:)
  func debugMode(isOn: Bool) {
    GNSMessageManager.setDebugLoggingEnabled(isOn)
  }
  
  @objc(startScanning:)
  func startScanning(name: String) -> Void {
    // GNSMessageManager.setDebugLoggingEnabled(true)
    
    let serialQueue = DispatchQueue(label: "calling")
//    var manager: GNSMessageManager?;
//    serialQueue.sync {
//        // code
//      manager = GNSMessageManager(apiKey: "AIzaSyCJgchjOLqRx4lersj_16H7YvBDvqOTZF8");
//    }
    let names = ["Ford", "Zaphod", "Trillian", "Arthur", "Marvin"]

    var randomName = names.randomElement()
    print(randomName);
    randomName = name;
    self.sendEvent(withName: "NearByEvent", body: ["name": randomName])
    let message = GNSMessage(content: randomName?.data(using: .utf8));
    self.publication = nil;
    self.publication = self.manager?.publication(with: message,
    paramsBlock: { (params: GNSPublicationParams?) in
      guard let params = params else { return }
      params.strategy = GNSStrategy(paramsBlock: { (params: GNSStrategyParams?) in
        guard let params = params else { return }
        // params.discoveryMediums = .audio
        // params.discoveryMode = .default
        params.allowInBackground = true
      })
    })
    
    
    
    print("after print")
    
    self.subscription = nil;
    self.subscription =
      self.manager?.subscription(messageFoundHandler: { (message: GNSMessage?) in
      var m = String(data: (message?.content)!, encoding: .utf8)
        print("message found ---- " + m!);
        print(message)
        self.sendEvent(withName: "NearByEvent", body: message)
    },
    messageLostHandler: { (message: GNSMessage?) in
      // Remove the name from the list
      print("message remove --- ")
      self.sendEvent(withName: "NearByEvent", body: message)
    },
    paramsBlock:{ (params: GNSSubscriptionParams?) in
      guard let params = params else { return }
      params.strategy = GNSStrategy(paramsBlock: { (params: GNSStrategyParams?) in
        guard let params = params else { return }
        params.allowInBackground = true
        //params.discoveryMediums = .audio
      })
    });
    
    
    print("after sub")
    
  }
}

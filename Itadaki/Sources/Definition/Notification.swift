// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

extension Notification.Name {
    
    static let CommandForward = Notification.Name("CommandForward")
    static let CommandTransfer = Notification.Name("CommandTransfer")
    static let CommandListSelect = Notification.Name("CommandListSelect")
    static let CommandListUp = Notification.Name("CommandListUp")
    static let CommandListDown = Notification.Name("CommandListDown")
    
    static let WillStationMove = Notification.Name("WillStationMove")
    static let DidStationMove = Notification.Name("DidStationMove")
}

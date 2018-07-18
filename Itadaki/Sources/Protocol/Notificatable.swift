// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

extension Notification {
    
    enum Key: String {
        case station
        case railway
        case transferring
    }
}

extension Dictionary where Key == Notification.Key, Value == Any {
    
    var station: Station? {
        return self[.station] as? Station
    }
    
    var railway: Railway? {
        return self[.railway] as? Railway
    }
    
    var transferring: Transferring? {
        return self[.transferring] as? Transferring
    }
}

extension Notification {
    
    var info: [Notification.Key : Any]? {
        return userInfo as? [Notification.Key : Any]
    }
}

protocol Notificatable {}
    
extension Notificatable where Self: NSObject {
    
    /// 通知の監視を開始する
    ///
    /// - Parameters:
    ///   - name: 監視する通知名
    ///   - selector: 通知された時に呼ばれるセレクタ
    func observeNotification(_ name: Notification.Name, when selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
}

extension Notificatable {
    
    /// 通知を送信する
    /// - Parameter name: 送信する通知名
    /// - Parameter userInfo: 追加情報
    func postNotification(_ name: Notification.Name, userInfo: [Notification.Key : Any]? = nil) {
        NotificationCenter.default.post(name: name, object: nil, userInfo: userInfo)
    }
}

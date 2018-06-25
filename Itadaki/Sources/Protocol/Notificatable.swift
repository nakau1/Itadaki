// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

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
    ///
    /// - Parameter name: 送信する通知名
    func postNotification(_ name: Notification.Name, userInfo: [AnyHashable : Any]? = nil) {
        NotificationCenter.default.post(name: name, object: nil, userInfo: userInfo)
    }
}

// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

extension UIImage {
    
    /// ファイルパス文字列から初期化
    ///
    /// - Parameter path: ファイルパス文字列
    convenience init?(path: String) {
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return nil
        }
        self.init(data: data)
    }
    
    /// 指定したファイルパスに画像を保存する
    ///
    /// - Parameter path: ファイルパス文字列
    func write(to path: String) {
        let data = UIImagePNGRepresentation(self)
        try? data?.write(to: URL(fileURLWithPath: path), options: [.atomic])
    }
}

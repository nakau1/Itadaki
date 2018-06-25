// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

extension String {
    
    /// 文字列の部分切り取り
    ///
    /// - Parameters:
    ///   - start: 開始インデックス
    ///   - end: 終了インデックス
    /// - Returns: 切り取られた文字列
    func substring(start: Int, end: Int) -> String {
        let max = count - 1
        var s = start, e = end
        if max < 0 || e < s || max < s || e < 0 {
            return ""
        }
        s = s >= 0 ? s : 0
        e = max >= e ? e : max
        
        let substring = self[index(startIndex, offsetBy: s)...index(startIndex, offsetBy: e)]
        return String(substring)
    }
    
    /// パスコンポーネントの追加
    /// NSStringのappendingPathComponentのラッパメソッド
    ///
    /// - Parameter component: 追加するコンポーネント
    /// - Returns: 追加された結果文字列
    func path(_ component: String) -> String {
        return (self as NSString).appendingPathComponent(component)
    }
    
    /// 自身から指定の文字列を削除した文字列を返す
    ///
    /// - Parameter string: 削除したい文字列
    /// - Returns: 削除された文字列
    func removed(_ string: String) -> String {
        return replacingOccurrences(of: string, with: "")
    }
    
    /// 指定した文字数分だけ後ろから削除したものを返す
    ///
    /// - Parameter length: 削除する文字数
    /// - Returns: 指定した文字数分だけ後ろから削除した文字数
    func removedBackward(_ length: Int = 1) -> String {
        return substring(start: 0, end: count - 1 - length)
    }
    
    /// 拡張子を取り除いた文字列を返す
    ///
    /// - Returns: 拡張子を取り除いた文字列
    var withoutExtension: String {
        return (self as NSString).deletingPathExtension
    }
    
    /// 拡張子を返す
    ///
    /// - Returns: 拡張子
    var `extension`: String {
        let ext = (self as NSString).pathExtension
        return ext.isEmpty ? "" : ".\(ext)"
    }
    
    /// ドットなしの拡張子を返す
    ///
    /// - Returns: ドットなしの拡張子
    var extensionWithoutDot: String {
        let ext = (self as NSString).pathExtension
        return ext.isEmpty ? "" : "\(ext)"
    }
    
    /// 日付から作成された識別子文字列を返す
    ///
    /// - Returns: 識別子文字列
    static func generateIdentifier() -> String {
        let date = Date()
        let comps: [Calendar.Component] = [.year, .month, .day, .hour, .minute, .second, .nanosecond]
        return comps.reduce(into: "") { res, comp in
            res += "\(Calendar.current.component(comp, from: date))"
        }
    }
    
    /// ファイルURL
    var fileURL: URL {
        return URL(fileURLWithPath: self)
    }
    
    /// ファイルから取得した画像
    var fileImage: UIImage? {
        guard let data = try? Data(contentsOf: fileURL) else {
            return nil
        }
        return UIImage(data: data)
    }
}

extension Int {
    
    // 文字列表現
    var string: String {
        return "\(self)"
    }
}

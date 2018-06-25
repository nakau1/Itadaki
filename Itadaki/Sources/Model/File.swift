// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class File {
    
    /// 指定したディレクトリパス内のファイル名をすべて取得する
    ///
    /// - Parameter path: ディレクトリパス文字列
    /// - Returns: ファイル名の配列
    class func fileNames(in path: String) -> [String] {
        do {
            return try FileManager.default.contentsOfDirectory(atPath: path).sorted()
        } catch(let error) {
            print("File Error: failed get file names: \(error.localizedDescription)")
        }
        return []
    }
    
    /// 指定したファイルを削除する
    ///
    /// - Parameter path: パス文字列
    class func delete(at path: String) {
        if FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch(let error) {
                print("File Error: failed delete: \(error.localizedDescription)")
            }
        }
    }
        
    /// 指定したパスにファイルが存在しない場合に空のテキストファイルを作成する
    ///
    /// - Parameter path: パス文字列
    /// - Returns: 作成を完了した場合のみ true を返す
    class func makeTextFileIfNeeded(to path: String) -> Bool {
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try "".write(to: URL(fileURLWithPath: path), atomically: true, encoding: .utf8)
                return true
            } catch(let error) {
                print("File Error: failed make text file: \(error.localizedDescription)")
            }
        }
        return false
    }
    
    /// 指定したパスにディレクトリが存在しない場合にディレクトリを作成する
    ///
    /// - Parameter path: パス文字列
    /// - Returns: 作成を完了した場合のみ true を返す
    class func makeDirectoryIfNeeded(to path: String) -> Bool {
        if !FileManager.default.fileExists(atPath: path) {
            do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                return true
            } catch(let error) {
                print("File Error: failed make directory: \(error.localizedDescription)")
            }
        }
        return false
    }
}

extension String {
    
    /// パスコンポーネントの追加
    ///
    /// - Parameters:
    ///   - component: 追加するコンポーネント
    ///   - makeDirectory: ディレクトリがなければ作成するかどうか
    /// - Returns: 追加された結果文字列
    func path(_ component: String, makeDirectory: Bool) -> String {
        let ret = path(component)
        if makeDirectory {
            _ = File.makeDirectoryIfNeeded(to: ret)
        }
        return ret
    }
    
    /// 共通したサムネイル画像ファイルの名前
    /// e.g) (名前).thumb.png
    var thumbName: String {
        return "\(withoutExtension).thumb.\(extensionWithoutDot)"
    }
}

// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit
/*
class StationManager {
    
    private var jsonCoder = JsonCoder()
    
    func load(_ stationNumber: String) -> Station? {
        let railways = jsonCoder.load(path: Path.Railway.railways, to: [Railway].self, default: [])
        for railway in railways {
            if let station = railway.stations.of(number: stationNumber) {
                return station
            }
        }
        return nil
    }
}
*/



/*
/// 似顔絵マネージャ
class PortraitManager {
    
    private var storedList: [Portrait]!
    private var jsonCoder = JsonCoder()
    
    // MARK: - list -
    
    /// 一覧をファイルに保存する
    ///
    /// - Parameter list: 似顔絵オブジェクトの配列
    private func saveList(_ list: [Portrait]) {
        jsonCoder.saveJson(list, to: Path.Portrait.json)
    }
    
    /// ファイルに保存された一覧を読み込む
    ///
    /// - Returns: 似顔絵オブジェクトの配列
    func loadList() -> [Portrait] {
        if let list = storedList { return list }
        
        if File.makeTextFileIfNeeded(to: Path.Portrait.json) {
            makeDefaultList()
        }
        storedList = jsonCoder.loadJson(path: Path.Portrait.json, to: [Portrait].self, default: [])
        return storedList
    }
    
    /// IDから似顔絵を検索して返す
    ///
    /// - Parameter id: ID
    /// - Returns: 似顔絵オブジェクト
    func search(id: String) -> Portrait? {
        if id.isEmpty { return nil }
        for portrait in loadList() {
            if portrait.id == id {
                return portrait
            }
        }
        return nil
    }
    
    private func makeDefaultList() {
        let portraits = (0..<Const.Portrait.minimumNumber).map { _ -> Portrait in
            let portrait = jsonCoder.instantiate(decodableType: Portrait.self)
            writeImages(of: portrait)
            return portrait
        }
        saveList(portraits)
    }
    
    private func index(of portrait: Portrait) -> Int? {
        let list = loadList()
        for (i, element) in list.enumerated() {
            if element == portrait {
                return i
            }
        }
        return nil
    }
    
    // MARK: - add -
    
    /// 新たな似顔絵オブジェクトを追加保存する
    ///
    /// - Parameter portrait: 似顔絵オブジェクト
    func add(_ portrait: Portrait) {
        var list = loadList()
        list.append(portrait)
        saveList(list)
        writeImages(of: portrait)
    }
    
    // MARK: - update -
    
    /// 似顔絵オブジェクトを更新して保存する
    ///
    /// - Parameter portrait: 似顔絵オブジェクト
    func update(_ portrait: Portrait) {
        var list = loadList()
        if let i = index(of: portrait) {
            list[i] = portrait
            saveList(list)
            writeImages(of: portrait)
        }
    }
    
    // MARK: - copy -
    
    /// 似顔絵オブジェクトをコピーして追加保存する
    ///
    /// - Parameter portrait: 似顔絵オブジェクト
    func copy(_ portrait: Portrait) {
        let cloned = jsonCoder.clone(portrait, type: Portrait.self)
        cloned.id = String.generateIdentifier()
        add(portrait)
    }
    
    // MARK: - delete -
    
    /// 似顔絵オブジェクトを削除する
    ///
    /// - Parameter portrait: 似顔絵オブジェクト
    func delete(_ portrait: Portrait) {
        let filteredList = loadList().filter { $0 != portrait }
        saveList(filteredList)
        deleteImages(of: portrait)
    }
    
    /// すべての似顔絵オブジェクトを削除する
    func deleteAll() {
        loadList().forEach {
            deleteImages(of: $0)
        }
        saveList([])
    }
    
    // MARK: - manage resource -
    
    /// 指定した似顔絵オブジェクトのパーツのリソースを変更する(保存はしない)
    ///
    /// - Parameters:
    ///   - resource: リソース名
    ///   - portrait: 似顔絵オブジェクト
    ///   - category: カテゴリ
    func setResource(_ resource: String, to portrait: Portrait, for category: Category) {
        //category.parts(of: portrait).resource = resource
    }
    
    // MARK: - generate image -
    
    /// 画像を生成する
    ///
    /// - Parameter portrait: 似顔絵オブジェクト
    /// - Returns: 似顔絵画像
    func generateImage(of portrait: Portrait) -> UIImage {
        return UIImage() // TODO: 未実装
//        return PortraitImageGenerator().generateImage(of: self)
    }
    
    /// サムネイル画像を生成する
    ///
    /// - Parameter portrait: 似顔絵オブジェクト
    /// - Returns: 似顔絵サムネイル画像
    func generateThumbImage(of portrait: Portrait) -> UIImage {
        return UIImage() // TODO: 未実装
//        return generateImage().scaled(to: .portraitThumb)
    }
    
    /// サムネイル画像の一覧を取得する
    ///
    /// - Returns: サムネイル画像の一覧
    func loadThumbList() -> [UIImage?] {
        return loadList().map { portrait -> UIImage? in
            return UIImage(path: Path.Portrait.thumb(of: portrait))
        }
    }
    
    // MARK: - write image -
    
    private func writeImages(of portrait: Portrait) {
        writeImage(of: portrait)
        writeThumbImage(of: portrait)
    }
    
    private func writeImage(of portrait: Portrait) {
        _ = File.makeDirectoryIfNeeded(to: Path.Portrait.directory)
        // TODO: 未実装
    }
    
    private func writeThumbImage(of portrait: Portrait) {
        _ = File.makeDirectoryIfNeeded(to: Path.Portrait.directory)
        // TODO: 未実装
        // generateImage().write(to: Path.portraitImage(self))
    }
    
    // MARK: - delete image -
    
    private func deleteImages(of portrait: Portrait) {
        deleteImage(of: portrait)
        deleteThumbImage(of: portrait)
    }
    
    private func deleteImage(of portrait: Portrait) {
        File.delete(at: Path.Portrait.image(of: portrait))
    }
    
    private func deleteThumbImage(of portrait: Portrait) {
        File.delete(at: Path.Portrait.thumb(of: portrait))
    }
}
*/

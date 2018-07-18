// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class Migration {
    
    /// データ移行の必要性
    var needsMigration: Bool {
        guard let stored = storedVersion else { return true }
        return compareVersion(stored, currentVersion) == .orderedAscending
    }
    
    /// データ移行を実行
    /// - Parameter completed: データ移行完了時の処理
    func migrate(completed: @escaping () -> Void) {
        self.executeMigrate()
        self.storedVersion = self.currentVersion
        completed()
//        DispatchQueue.global(qos: .default).async { [unowned self] in
//            self.executeMigrate()
//            self.storedVersion = self.currentVersion
//            DispatchQueue.main.async {
//                completed()
//            }
//        }
    }
    
    /// データ移行を必須に変更する
    func reset() {
        storedVersion = nil
    }
    
    private func executeMigrate() {
        let decodedRailways = self.load(path: Path.railwaysJson, to: [DecodedRailway].self, default: [])
        
        let railways = createRailways(from: decodedRailways)
        Realm.insert(railways)
        
        let transferrings = createTransferrings(from: decodedRailways)
        Realm.insert(transferrings)
    }
    
    private func createRailways(from decodedRailways: [DecodedRailway]) -> [Railway] {
        return decodedRailways.map { decodedRailway -> Railway in
            return Railway.create(from: decodedRailway)
        }
    }
    
    private func createTransferrings(from decodedRailways: [DecodedRailway]) -> [Transferring] {
        var ret = [Transferring]()
        for decodedRailway in decodedRailways {
            for decodedStation in decodedRailway.stations {
                let locationKey = locationKeyOf(decodedStation)
                if exists(locationKey: locationKey, inTransferrings: ret) {
                    continue
                }
                let transferrings = createTransferrings(ofDecodedStation: decodedStation, inDecodedRailways: decodedRailways)
                ret.append(contentsOf: transferrings)
            }
        }
        return ret
    }
    
    private func createTransferrings(ofDecodedStation decodedStation: DecodedStation, inDecodedRailways decodedRailways: [DecodedRailway]) -> [Transferring] {
        var ret = [Transferring]()
        for decodedRailway in decodedRailways {
            let locationKey = locationKeyOf(decodedStation)
            guard let sameLocationKeyedDecodedStation = fetchSameLocationKeyedDecodedStation(locationKey, in: decodedRailway) else {
                continue
            }
            if let ascendingTransferring = Transferring.create(locationKey, station: sameLocationKeyedDecodedStation, railway: decodedRailway, direction: .ascending) {
                ret.append(ascendingTransferring)
            }
            if let descendingTransferring = Transferring.create(locationKey, station: sameLocationKeyedDecodedStation, railway: decodedRailway, direction: .descending) {
                ret.append(descendingTransferring)
            }
        }
        return ret
    }
    
    private func locationKeyOf(_ decodedStation: DecodedStation) -> String {
        return decodedStation.alias ?? decodedStation.roman
    }
    
    private func fetchSameLocationKeyedDecodedStation(_ locationKey: String, in decodedRailway: DecodedRailway) -> DecodedStation? {
        for decodedStation in decodedRailway.stations {
            if locationKey == locationKeyOf(decodedStation) {
                return decodedStation
            }
        }
        return nil
    }
    
    private func fetchStationSameLocationKeyed(_ locationKey: String, in decodedRailway: DecodedRailway) -> Station? {
        for decodedStation in decodedRailway.stations {
            if locationKey == locationKeyOf(decodedStation) {
                return Station.create(from: decodedStation)
            }
        }
        return nil
    }
    
    private func exists(locationKey: String, inTransferrings transferrings: [Transferring]) -> Bool {
        for transferring in transferrings {
            if transferring.locationKey == locationKey {
                return true
            }
        }
        return false
    }
    
    private var currentVersion: String {
        let dic = Bundle.main.infoDictionary!
        return dic["CFBundleShortVersionString"]! as! String
    }
    
    private var storedVersion: String? {
        get {
            return UserDefaults.standard.string(forKey: "Migration.storedVersion")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Migration.storedVersion")
            UserDefaults.standard.synchronize()
        }
    }
    
    private func compareVersion(_ a: String, _ b: String) -> ComparisonResult {
        // 比較結果(aよりbの方が大きい場合に.orderedAscendingを返す)
        return a.compare(b, options: .numeric, range: nil, locale: nil)
    }
    
    private func load<T>(path: String, to type: T.Type, default defaultValue: T) -> T where T : Decodable {
        guard
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
            let decoded = try? JSONDecoder().decode(type, from: data)
            else {
                return defaultValue
        }
        return decoded
    }
}

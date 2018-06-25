// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit
/*
class RailwayManager {
    
    private var jsonCoder = JsonCoder()
    
    func load(_ code: String) -> Railway? {
        let railways = jsonCoder.load(path: Path.Railway.railways, to: [Railway].self, default: [])
        return railways[code]
    }
    
    func load(_ code: String, stationNumber: String) -> (railway: Railway, station: Station?)? {
        guard let railway = load(code) else { return nil }
        let station = railway.stations.of(number: stationNumber)
        return (railway: railway, station: station)
    }
}
*/

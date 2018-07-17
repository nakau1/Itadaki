// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class GameMainRailwayView: UIView {
    
    @IBOutlet private weak var companyLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var destinationLabel: UILabel!
    @IBOutlet private weak var symbolImageView: UIImageView!
    
    func update(station: Station, direction: DestinationDirection) {
        let railway = station.railway
        companyLabel.text = railway.company.name
        nameLabel.text = railway.name
        destinationLabel.text = station.destination(direction: direction)
        symbolImageView.image = railway.numberingImage
    }
    
    func update(transferring: Transferring) {
        let railway = transferring.railway!
        companyLabel.text = railway.company.name
        nameLabel.text = railway.name
        destinationLabel.text = transferring.destination
        symbolImageView.image = railway.numberingImage
    }
    
//    /// 行先方向
//    var direction = DestinationDirection.ascending
//
//    var station: Station! {
//        didSet {
//            nameLabel.text = station.name
//            romanLabel.text = station.roman
//
//            transferringLine.isHidden = !station.hasTransferrings
//
//            topLine.isHidden = station.isFinalStation(direction)
//            bottomLine.isHidden = station.isFirstStation(direction)
//
//            [topLine, bottomLine, stationNumberImageView].forEach { (view: UIView) in
//                view.backgroundColor = station.railway.color
//            }
//        }
//    }
}

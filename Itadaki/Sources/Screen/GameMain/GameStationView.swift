// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class GameStationView: UICustomView {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var romanLabel: UILabel!
    @IBOutlet private weak var stationNumberImageView: UIImageView!
    @IBOutlet private weak var topLine: UIView!
    @IBOutlet private weak var bottomLine: UIView!
    @IBOutlet private weak var transferringLine: UIView!
    
    /// 行先方向
    var direction = DestinationDirection.ascending
    
    var station: Station! {
        didSet {
            nameLabel.text = station.name
            romanLabel.text = station.roman
            
            transferringLine.isHidden = !station.hasTransferrings
            
            topLine.isHidden = station.isFinalStation(direction)
            bottomLine.isHidden = station.isFirstStation(direction)
            
            stationNumberImageView.image = station.numberingImage
            
            [topLine, bottomLine].forEach { (view: UIView) in
                view.backgroundColor = station.railway.color
            }
        }
    }
}

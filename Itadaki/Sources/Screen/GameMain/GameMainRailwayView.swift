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
    
    func update(transferring: Transferring) {
        let railway = transferring.railway!
        companyLabel.text = railway.company.name
        nameLabel.text = railway.name
        destinationLabel.text = transferring.destination
        symbolImageView.image = railway.numberingImage
    }
}

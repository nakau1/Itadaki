// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class GameTrainControlViewController: UIViewController, Notificatable {
    
    @IBOutlet private weak var forwardButton: UIButton!
    
    class func create() -> UIViewController {
        let vc = instantiate(self)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeNotification(.WillStationMove, when: #selector(willStationMove))
        observeNotification(.DidStationMove, when: #selector(didStationMove))
    }
    
    @IBAction private func didTapForwardButton() {
        postNotification(.CommandForward)
    }
    
    @objc private func willStationMove() {
        forwardButton.isEnabled = false
    }
    
    @objc private func didStationMove() {
        forwardButton.isEnabled = true
    }
}

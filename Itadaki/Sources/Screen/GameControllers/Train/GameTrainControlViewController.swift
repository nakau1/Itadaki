// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class GameTrainControlViewController: MainControlViewController, Notificatable {
    
    @IBOutlet private weak var forwardButton: UIButton!
    @IBOutlet private weak var transferButton: UIButton!
    
    class func create() -> MainControlViewController {
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
    
    @IBAction private func didTapTransferButton() {
        postNotification(.CommandTransfer)
    }
    
    @objc private func willStationMove() {
        forwardButton.isEnabled = false
    }
    
    @objc private func didStationMove() {
        forwardButton.isEnabled = true
    }
}

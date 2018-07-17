// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class GameListSelectControlViewController: MainControlViewController, Notificatable {
    
    @IBOutlet private weak var selectButton: UIButton!
    @IBOutlet private weak var upButton: UIButton!
    @IBOutlet private weak var downButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    
    class func create() -> MainControlViewController {
        let vc = instantiate(self)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeNotification(.WillStationMove, when: #selector(willStationMove))
        observeNotification(.DidStationMove, when: #selector(didStationMove))
    }
    
    @IBAction private func didTapSelectButton() {
        postNotification(.CommandListSelect, userInfo: ["": ""])
        main.popControl()
        main.popContents()
    }
    
    @IBAction private func didTapUpButton() {
        postNotification(.CommandListUp)
    }
    
    @IBAction private func didTapDownButton() {
        postNotification(.CommandListDown)
    }
    
    @IBAction private func didTapCancelButton() {
        main.popControl()
        main.popContents()
    }
    
    @objc private func willStationMove() {
        
    }
    
    @objc private func didStationMove() {
        
    }
}

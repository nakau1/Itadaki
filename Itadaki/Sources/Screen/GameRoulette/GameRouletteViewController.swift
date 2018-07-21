// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class GameRouletteViewController: MainContentsViewController, Notificatable {
    
    private var presenter: GameRoulettePresentable!

    @IBOutlet private weak var stopButton: UIButton!
    
    class func create() -> MainContentsViewController {
        let vc = instantiate(self)
        vc.presenter = GameRoulettePresenter(view: vc)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func didTapStopButton() {
        
    }
}

extension GameRouletteViewController: GameRouletteViewable {
    
}

// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class GameTransferSelectViewController: UIViewController {
    
    private var presenter: GameTransferSelectPresentable!
    private var adapter: GameTransferSelectAdapter!
    
    class func create() -> UIViewController {
        let vc = instantiate(self)
        vc.presenter = GameTransferSelectPresenter(view: vc)
        vc.adapter = GameTransferSelectAdapter(delegate: vc)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension GameTransferSelectViewController: GameTransferSelectViewable {
    
}

extension GameTransferSelectViewController: GameTransferSelectAdapterDelegate {
    
}

// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class GameTransferSelectViewController: MainContentsViewController {
    
    private var presenter: GameTransferSelectPresentable!

    @IBOutlet private weak var adapter: GameTransferSelectAdapter!
    
    class func create() -> MainContentsViewController {
        let vc = instantiate(self)
        vc.presenter = GameTransferSelectPresenter(view: vc)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.delegate = self
    }
}

extension GameTransferSelectViewController: GameTransferSelectViewable {
    
}

extension GameTransferSelectViewController: GameTransferSelectAdapterDelegate {
    
}

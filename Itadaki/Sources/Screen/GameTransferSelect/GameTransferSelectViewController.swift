// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class GameTransferSelectViewController: MainContentsViewController {
    
    private var presenter: GameTransferSelectPresentable!
    private var station: Station!

    @IBOutlet private weak var adapter: GameTransferSelectAdapter!
    
    class func create(station: Station) -> MainContentsViewController {
        let vc = instantiate(self)
        vc.presenter = GameTransferSelectPresenter(view: vc)
        vc.station = station
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.delegate = self
    }
}

extension GameTransferSelectViewController: GameTransferSelectViewable {
    
    func showTransferrings(_ transferrings: [Transferring]) {
        
    }
}

extension GameTransferSelectViewController: GameTransferSelectAdapterDelegate {
    
}

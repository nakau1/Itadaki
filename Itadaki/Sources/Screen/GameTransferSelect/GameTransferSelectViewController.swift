// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class GameTransferSelectViewController: MainContentsViewController, Notificatable {
    
    private var presenter: GameTransferSelectPresentable!
    private var station: Station!

    @IBOutlet private weak var adapter: GameTransferSelectAdapter!
    
    class func push(to main: MainViewController, station: Station) {
        main.push(contents: GameTransferSelectViewController.create(station: station))
    }
    
    class func create(station: Station) -> MainContentsViewController {
        let vc = instantiate(self)
        vc.presenter = GameTransferSelectPresenter(view: vc)
        vc.station = station
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.delegate = self
        presenter.loadTransferrings(of: station)
        
        observeNotification(.CommandListSelect, when: #selector(didCommandListSelect(_:)))
        observeNotification(.CommandListUp, when: #selector(didCommandListUp(_:)))
        observeNotification(.CommandListDown, when: #selector(didCommandListDown(_:)))
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
    }
    
    @objc private func didCommandListSelect(_ notify: Notification) {
        let transferring = presenter.transferrings[adapter.currentIndex]
        postNotification(.DidSelectTransferredStation, info: [.transferring : transferring])
    }
    
    @objc private func didCommandListUp(_ notify: Notification) {
        adapter.selectUp()
    }
    
    @objc private func didCommandListDown(_ notify: Notification) {
        adapter.selectDown()
    }
}

extension GameTransferSelectViewController: GameTransferSelectViewable {
    
    func showTransferrings() {
        adapter.reload()
    }
}

extension GameTransferSelectViewController: GameTransferSelectAdapterDelegate {
    
    func numberOfItems(transferSelectAdapter: GameTransferSelectAdapter) -> Int {
        return presenter.transferrings.count
    }
    
    func transferSelectAdapter(_ transferSelectAdapter: GameTransferSelectAdapter, transferringAt index: Int) -> Transferring! {
        return presenter.transferrings[index]
    }
}

// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class GameTransferSelectViewController: MainContentsViewController, Notificatable {
    
    private var presenter: GameTransferSelectPresentable!
    private var station: Station!

    @IBOutlet private weak var adapter: GameTransferSelectAdapter!
    @IBOutlet private weak var selectButton: UIButton!
    @IBOutlet private weak var upButton: UIButton!
    @IBOutlet private weak var downButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    
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
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
    }
    
    
    @IBAction private func didTapSelectButton() {
        let transferring = presenter.transferrings[adapter.currentIndex]
        postNotification(.DidSelectTransferredStation, info: [.transferring : transferring])
        main.popContents()
    }
    
    @IBAction private func didTapUpButton() {
        adapter.selectUp()
    }
    
    @IBAction private func didTapDownButton() {
        adapter.selectDown()
    }
    
    @IBAction private func didTapCancelButton() {
        main.popContents()
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

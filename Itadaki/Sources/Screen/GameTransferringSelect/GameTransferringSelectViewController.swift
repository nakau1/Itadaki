// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class GameTransferringSelectViewController: MainContentsViewController, Notificatable {
    
    private var presenter: GameTransferringSelectPresentable!
    private var station: Station!

    @IBOutlet private weak var adapter: GameTransferringSelectAdapter!
    @IBOutlet private weak var selectButton: UIButton!
    @IBOutlet private weak var upButton: UIButton!
    @IBOutlet private weak var downButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    
    class func push(to main: MainViewController, station: Station) {
        main.push(contents: GameTransferringSelectViewController.create(station: station))
    }
    
    class func create(station: Station) -> MainContentsViewController {
        let vc = instantiate(self)
        vc.presenter = GameTransferringSelectPresenter(view: vc)
        vc.station = station
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.delegate = self
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        presenter.loadTransferrings(of: station)
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

extension GameTransferringSelectViewController: GameTransferringSelectViewable {
    
    func showTransferrings() {
        adapter.reload()
    }
}

extension GameTransferringSelectViewController: GameTransferringSelectAdapterDelegate {
    
    func numberOfItems(transferSelectAdapter: GameTransferringSelectAdapter) -> Int {
        return presenter.transferrings.count
    }
    
    func transferSelectAdapter(_ transferSelectAdapter: GameTransferringSelectAdapter, transferringAt index: Int) -> Transferring! {
        return presenter.transferrings[index]
    }
}

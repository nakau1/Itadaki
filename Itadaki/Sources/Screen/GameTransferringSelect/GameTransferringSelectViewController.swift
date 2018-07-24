// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class GameTransferringSelectViewController: MainContentsViewController, Notificatable {
    
    private var presenter: GameTransferringSelectPresentable!
    private var station: Station!

    @IBOutlet private weak var listView: ListView!
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
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        presenter.loadTransferrings(of: station)
    }
    
    @IBAction private func didTapSelectButton() {
        let transferring = presenter.transferrings[listView.currentIndex]
        postNotification(.DidSelectTransferredStation, info: [.transferring : transferring])
        main.popContents()
    }
    
    @IBAction private func didTapUpButton() {
        listView.selectUp()
    }
    
    @IBAction private func didTapDownButton() {
        listView.selectDown()
    }
    
    @IBAction private func didTapCancelButton() {
        main.popContents()
    }
    
    private var buttonsEnabled = true {
        didSet {
            [upButton, downButton, cancelButton, selectButton].forEach { button in
                button!.isEnabled = buttonsEnabled
            }
        }
    }
}

extension GameTransferringSelectViewController: GameTransferringSelectViewable {
    
    func showTransferrings() {
        listView.reloadData()
    }
}

extension GameTransferringSelectViewController: ListViewDelegate, ListViewDatasource {
    
    func numberOfRows(in listView: ListView) -> Int {
        return presenter.transferrings.count
    }
    
    func listView(_ listView: ListView, viewForRowAt index: Int) -> UIView {
        var cell = listView.dequeueReusableView(for: index) as? GameTransferringSelectAdapterCell
        if cell == nil {
            cell = GameTransferringSelectAdapterCell()
        }
        cell!.transferring = presenter.transferrings[index]
        return cell!
    }
    
    func listView(_ listView: ListView, updateSelectionView view: UIView, selected: Bool) {
        if let cell = view as? GameTransferringSelectAdapterCell {
            cell.current = selected
        }
    }
    
    func listView(_ listView: ListView, didStartMoveTo index: Int, animate: Bool) {
        if animate {
            buttonsEnabled = false
        }
    }
    
    func listView(_ listView: ListView, didEndMoveAt index: Int, animate: Bool) {
        if animate {
            buttonsEnabled = true
        }
    }
}

class GameTransferringSelectAdapterCell: UICustomView {
    
    @IBOutlet private weak var borderedView: UIView!
    @IBOutlet private weak var railwayCompanyLabel: UILabel!
    @IBOutlet private weak var railwayNameLabel: UILabel!
    @IBOutlet private weak var railwayImageView: UIImageView!
    @IBOutlet private weak var destinationLabel: UILabel!
    
    var transferring: Transferring! {
        didSet {
            let railway = transferring.railway!
            railwayCompanyLabel.text = railway.company.name
            railwayNameLabel.text = railway.name
            destinationLabel.text = transferring.destination
            railwayImageView.image = railway.numberingImage
        }
    }
    
    var current = false {
        didSet {
            borderedView.borderColor = current ? .red : .gray
        }
    }
}

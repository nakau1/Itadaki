// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class GameMainViewController: MainContentsViewController, Notificatable {
    
    private var presenter: GameMainPresentable!
    
    @IBOutlet private weak var stationsView: GameStationsView!
    @IBOutlet private weak var railwayCompanyLabel: UILabel!
    @IBOutlet private weak var railwayNameLabel: UILabel!
    @IBOutlet private weak var railwayImageView: UIImageView!
    @IBOutlet private weak var destinationLabel: UILabel!
    @IBOutlet private weak var forwardButton: UIButton!
    @IBOutlet private weak var transferButton: UIButton!
    
    private weak var currentStation: Station!
    
    class func create() -> MainContentsViewController {
        let vc = instantiate(self)
        vc.presenter = GameMainPresenter(view: vc)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stationsView.direction = presenter.direction
        stationsView.delegate = self
        
        observeNotification(.DidSelectTransferredStation, when: #selector(didSelectTransferredStation(_:)))
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        if let st = StationRepository.numbered("JK26") {
            currentStation = st
            update(station: st, direction: presenter.direction)
            stationsView.changeStation(st)
        }
    }
    
    @IBAction private func didTapForwardButton() {
        stationsView.move()
    }
    
    @IBAction private func didTapTransferButton() {
        GameTransferSelectViewController.push(to: main, station: currentStation)
    }
    
    @objc private func didSelectTransferredStation(_ notify: Notification) {
        guard
            let transferring = notify.userInfo?.transferring,
            let station = transferring.station
            else {
                return
        }
        currentStation = station
        presenter.direction = transferring.direction
        stationsView.direction = presenter.direction
        stationsView.changeStation(station)
    }
    
    private func update(station: Station, direction: DestinationDirection) {
        let railway = station.railway
        railwayCompanyLabel.text = railway.company.name
        railwayNameLabel.text = railway.name
        destinationLabel.text = station.destination(direction: direction)
        railwayImageView.image = railway.numberingImage
    }
}

extension GameMainViewController: GameMainViewable {
    
}

extension GameMainViewController: GameStationsViewDelegate {
    
    func gameStationsView(_ gameStationsView: GameStationsView, willMoveFrom station: Station) {
        forwardButton.isEnabled = false
    }
    
    func gameStationsView(_ gameStationsView: GameStationsView, didMoveTo station: Station, isFinalStation: Bool) {
        forwardButton.isEnabled = true
        
        currentStation = station
        update(station: station, direction: presenter.direction)
        
        if isFinalStation {
            presenter.direction = presenter.direction.reversed
            stationsView.direction = presenter.direction
            stationsView.changeStation(station)
        }
    }
}

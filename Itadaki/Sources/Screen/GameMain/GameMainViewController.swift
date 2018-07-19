// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class GameMainViewController: MainContentsViewController, Notificatable {
    
    private var presenter: GameMainPresentable!
    
    @IBOutlet private weak var stationsView: GameStationsView!
    @IBOutlet private weak var railwayView: GameMainRailwayView!
    @IBOutlet private weak var forwardButton: UIButton!
    @IBOutlet private weak var transferButton: UIButton!
    
    private var direction = DestinationDirection.ascending
    private weak var currentStation: Station!
    
    class func create() -> MainContentsViewController {
        let vc = instantiate(self)
        vc.presenter = GameMainPresenter(view: vc)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stationsView.direction = direction
        stationsView.delegate = self
        
        observeNotification(.DidSelectTransferredStation, when: #selector(didSelectTransferredStation(_:)))
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        if let st = StationRepository.numbered("JK26") {
            currentStation = st
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
        direction = transferring.direction
        stationsView.direction = direction
        stationsView.changeStation(station)
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
        railwayView.update(station: station, direction: direction)
        
        if isFinalStation {
            direction = direction.reversed
            stationsView.direction = direction
            stationsView.changeStation(station)
        }
    }
}

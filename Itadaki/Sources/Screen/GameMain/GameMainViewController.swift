// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class GameMainViewController: MainContentsViewController, Notificatable {
    
    private var presenter: GameMainPresentable!
    
    @IBOutlet private weak var stationsView: GameStationsView!
    @IBOutlet private weak var railwayView: GameMainRailwayView!
    
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
        
        observeNotification(.CommandForward, when: #selector(didCommandForward))
        observeNotification(.CommandTransfer, when: #selector(didCommandTransfer))
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        if let st = StationRepository.numbered("JK17") {
            currentStation = st
            stationsView.changeStation(st)
        }
    }
    
    @objc private func didCommandForward() {
        stationsView.move()
    }
    
    @objc private func didCommandTransfer() {
        GameTransferSelectViewController.push(to: main, station: currentStation)
    }
}

extension GameMainViewController: GameMainViewable {
    
}

extension GameMainViewController: GameStationsViewDelegate {
    
    func gameStationsView(_ gameStationsView: GameStationsView, willMoveFrom station: Station) {
        postNotification(.WillStationMove)
    }
    
    func gameStationsView(_ gameStationsView: GameStationsView, didMoveTo station: Station, isFinalStation: Bool) {
        postNotification(.DidStationMove)
        
        currentStation = station
        railwayView.update(station: station, direction: direction)
        
        if isFinalStation {
            direction = direction.reversed
            stationsView.direction = direction
            stationsView.changeStation(station)
        }
    }
}

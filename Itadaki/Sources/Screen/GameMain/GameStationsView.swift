// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

protocol GameStationsViewDelegate: class {
    
    func gameStationsView(_ gameStationsView: GameStationsView, willMoveFrom station: Station)
    func gameStationsView(_ gameStationsView: GameStationsView, didMoveTo station: Station, isFinalStation: Bool)
}

class GameStationsView: UIView {
    
    private let padding: CGFloat = 6
    
    enum Position: Int {
        case overTop, top, center, bottom, overBottom
        static let items: [Position] = [.overTop, .top, .center, .bottom, .overBottom]
    }
    
    /// デリゲートオブジェクト
    weak var delegate: GameStationsViewDelegate?
    
    /// 行先方向
    var direction = DestinationDirection.ascending
    
    private var frames = Position.items.map { _ -> CGRect in CGRect.zero }
    private var views = Position.items.map { _ -> GameStationView? in nil }
    
    func changeStation(_ station: Station) {
        reset()
        addUnderView()
        setStationView(to: .top,    station: station.nextStation(direction))
        setStationView(to: .center, station: station)
        setStationView(to: .bottom, station: station.prevStation(direction))
    }
    
    func move() {
        guard let nextStationView = view(at: .top) else {
            return
        }
        willMoveStation()
        setStationView(to: .overTop, station: nextStationView.station.nextStation(direction))

        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear], animations: { [unowned self] in
            self.changeFramesForAnimating()
        }, completion: { [unowned self] _ in
            self.queueView()
            self.didMoveStation()
        })
    }
    
    private func willMoveStation() {
        let station = view(at: .center)!.station!
        delegate?.gameStationsView(self, willMoveFrom: station)
    }
    
    private func didMoveStation() {
        let station = view(at: .center)!.station!
        let final = station.isFinalStation(direction)
        delegate?.gameStationsView(self, didMoveTo: station, isFinalStation: final)
    }
    
    private func changeFramesForAnimating() {
        view(at: .overTop)?.frame = frame(at: .top)
        view(at: .top)?    .frame = frame(at: .center)
        view(at: .center)? .frame = frame(at: .bottom)
        view(at: .bottom)? .frame = frame(at: .overBottom)
    }
    
    private func queueView() {
        view(at: .bottom)?.parent = nil
        setView(view(at: .center), to: .bottom)
        setView(view(at: .top), to: .center)
        setView(view(at: .overTop), to: .top)
        setView(nil, to: .overTop)
    }
    
    private func calculateFrames() {
        var baseFrame = bounds
        baseFrame.size.height = (bounds.height - padding * 2) / 2
        baseFrame.origin.y = padding - (baseFrame.size.height / 2 * 3)
        
        Position.items.forEach {
            var frame = baseFrame
            frame.origin.y = baseFrame.origin.y + (baseFrame.height * $0.rawValue.f)
            frames[$0.rawValue] = frame
        }
    }
    
    private func setStationView(to position: Position, station stationOrNil: Station?) {
        let stationView = generateStationView(stationOrNil, frame: frame(at: position))
        stationView?.parent = self
        setView(stationView, to: position)
    }
    
    private func generateStationView(_ stationOrNil: Station?, frame: CGRect) -> GameStationView? {
        guard let station = stationOrNil else {
            return nil
        }
        let view = GameStationView(frame: frame)
        view.direction = direction
        view.station = station
        return view
    }
    
    private func frame(at position: Position) -> CGRect {
        return frames[position.rawValue]
    }
    
    private func view(at position: Position) -> GameStationView? {
        return views[position.rawValue]
    }
    
    private func setView(_ view: GameStationView?, to position: Position) {
        views[position.rawValue] = view
    }
    
    private func reset() {
        resetFrames()
        resetViews()
    }
    
    private func resetFrames() {
        frames = Position.items.map { _ -> CGRect in CGRect.zero }
        calculateFrames()
    }
    
    private func resetViews() {
        removeAllSubviews()
        views = Position.items.map { _ -> GameStationView? in nil }
    }
    
    private func addUnderView() {
        let underViewFrame = frame(at: .center).insetBy(dx: 4, dy: 0)
        let underView = UIView(frame: underViewFrame)
        underView.backgroundColor = .white
        underView.parent = self
    }
}

// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

protocol GameTransferringSelectAdapterDelegate: class {
    
    func numberOfItems(transferSelectAdapter: GameTransferringSelectAdapter) -> Int
    func transferSelectAdapter(_ transferSelectAdapter: GameTransferringSelectAdapter, transferringAt index: Int) -> Transferring!
}

class GameTransferringSelectAdapter: NSObject {
    
    weak var delegate: GameTransferringSelectAdapterDelegate!
    
    @IBOutlet private weak var tableView: UITableView!
    
    private(set) var currentIndex = -1
    
    func reload() {
        tableView.isScrollEnabled = false
        tableView.reloadData()
        if delegate.numberOfItems(transferSelectAdapter: self) > 0 {
            currentIndex = 0
            tableView.selectRow(at: IndexPath(currentIndex), animated: false, scrollPosition: .top)
        }
    }
    
    func selectUp() {
        if delegate.numberOfItems(transferSelectAdapter: self) <= 0 || currentIndex <= 0 { return }
        currentIndex -= 1
        
        let indexPath = IndexPath(currentIndex)
        if !isVisibleRows(at: indexPath) {
            tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        }
        tableView.reloadData()
    }
    
    func selectDown() {
        if currentIndex >= delegate.numberOfItems(transferSelectAdapter: self) - 1 { return }
        currentIndex += 1
        
        let indexPath = IndexPath(currentIndex)
        if !isVisibleRows(at: indexPath) {
            tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        }
        tableView.reloadData()
    }
    
    private func isVisibleRows(at indexPath: IndexPath) -> Bool {
        let indexPaths = tableView.indexPathsForVisibleRows ?? []
        return indexPaths.dropFirst(2).dropLast(2).contains(indexPath)
    }
}

extension GameTransferringSelectAdapter: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate.numberOfItems(transferSelectAdapter: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameTransferringSelectAdapterCell
        cell.transferring = delegate.transferSelectAdapter(self, transferringAt: indexPath.row)
        cell.current = currentIndex == indexPath.row
        return cell
    }
}

class GameTransferringSelectAdapterCell: UITableViewCell {
    
    @IBOutlet private weak var railwayView: GameMainRailwayView!
    
    var transferring: Transferring! {
        didSet {
            railwayView.update(transferring: transferring)
        }
    }
    
    var current = false {
        didSet {
            railwayView.border = current ? 4 : 1
            railwayView.borderColor = current ? .red : .gray
        }
    }
}

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
    
    @IBOutlet private weak var listView: ListView!
    
    private(set) var currentIndex = -1
    
    func reload() {
//        tableView.isScrollEnabled = false
//        tableView.reloadData()
//        if delegate.numberOfItems(transferSelectAdapter: self) > 0 {
//            currentIndex = 0
//            tableView.selectRow(at: IndexPath(currentIndex), animated: false, scrollPosition: .top)
//        }
        listView.reloadData()
    }
    
    func selectUp() {
        listView.selectUp()
//        if delegate.numberOfItems(transferSelectAdapter: self) <= 0 || currentIndex <= 0 { return }
//        currentIndex -= 1
//
//        let indexPath = IndexPath(currentIndex)
//        if !isVisibleRows(at: indexPath) {
//            tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
//        }
//        tableView.reloadData()
    }
    
    func selectDown() {
        listView.selectDown()
//        if currentIndex >= delegate.numberOfItems(transferSelectAdapter: self) - 1 { return }
//        currentIndex += 1
//
//        let indexPath = IndexPath(currentIndex)
//        if !isVisibleRows(at: indexPath) {
//            tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
//        }
//        tableView.reloadData()
    }
    
    private func isVisibleRows(at indexPath: IndexPath) -> Bool {
        return false
//        let indexPaths = tableView.indexPathsForVisibleRows ?? []
//        return indexPaths.dropFirst(2).dropLast(2).contains(indexPath)
    }
}

extension GameTransferringSelectAdapter: ListViewDelegate, ListViewDatasource {
    
    func numberOfRows(in listView: ListView) -> Int {
        return delegate.numberOfItems(transferSelectAdapter: self) * 2
    }
    
    func listView(_ listView: ListView, viewForRowAt index: Int) -> UIView {
        var cell = listView.dequeueReusableView(for: index) as? GameTransferringSelectAdapterCell
        if cell == nil {
            cell = GameTransferringSelectAdapterCell()
        } else {
            print("deque!")
        }
        cell!.transferring = delegate.transferSelectAdapter(self, transferringAt: index / 2)
//        cell!.current = currentIndex == index
        return cell!
    }
    
    func listView(_ listView: ListView, updateSelectionView view: UIView, selected: Bool) {
        if let cell = view as? GameTransferringSelectAdapterCell {
            cell.current = selected
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
    
    deinit {
        print("GameTransferringSelectAdapterCell deinit!")
    }
}

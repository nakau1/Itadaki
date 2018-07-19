// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

@objc protocol ListViewDatasource: NSObjectProtocol {
    
    func numberOfRows(in listView: ListView) -> Int
    
    func listView(_ listView: ListView, viewForRowAt index: Int) -> UIView
}

@objc protocol ListViewDelegate: NSObjectProtocol {
    
}

class ListView: UIView {
    
    @IBOutlet weak var dataSource: UITableViewDataSource?
    @IBOutlet weak var delegate: UITableViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        reloadData()
    }
    
    func reloadData() {
        
    }
    
    func dequeueReusableView(for: Int) -> UIView? {
        return nil
    }
}

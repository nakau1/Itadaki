// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

protocol GameTransferSelectAdapterDelegate: class {
    
}

class GameTransferSelectAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {

    weak var delegate: GameTransferSelectAdapterDelegate!
    
    @IBOutlet private weak var tableView: UITableView!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameTransferSelectAdapterCell
        
        return cell
    }
}

class GameTransferSelectAdapterCell: UITableViewCell {
    
}

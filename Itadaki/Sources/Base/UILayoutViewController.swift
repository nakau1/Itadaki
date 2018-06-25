// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class UILayoutViewController: UIViewController {
    
    private var didLayout = false
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !didLayout {
            viewDidLayout()
            didLayout = true
        }
    }
    
    func viewDidLayout() {}
}

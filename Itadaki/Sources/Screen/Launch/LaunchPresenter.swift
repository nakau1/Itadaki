// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

protocol LaunchPresentable: class {
    
    func executeLaunching()
}

protocol LaunchViewable: class {
    
    func showResultExecuteLaunching()
}

class LaunchPresenter: LaunchPresentable {
    
    weak var view: LaunchViewable!
    
    init(view: LaunchViewable) {
        self.view = view
    }
    
    func executeLaunching() {
        
    }
}

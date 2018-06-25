// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

protocol MainPresentable: class {
    
}

protocol MainViewable: class {
    
}

class MainPresenter: MainPresentable {
    
    weak var view: MainViewable!
    
    init(view: MainViewable) {
        self.view = view
    }
}

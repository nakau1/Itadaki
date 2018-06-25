// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

protocol TopPresentable: class {
    
}

protocol TopViewable: class {
    
}

class TopPresenter: TopPresentable {
    
    weak var view: TopViewable!
    
    init(view: TopViewable) {
        self.view = view
    }
}

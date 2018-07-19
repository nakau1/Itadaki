// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

protocol MainPresentable: class {
    
    func push(contents controller: MainContentsViewController)
    func popContents()
}

protocol MainViewable: class {
    
}

class MainPresenter: MainPresentable {
    
    weak var view: MainViewable!
    
    private var contentsControllers = [MainContentsViewController]()
    
    init(view: MainViewable) {
        self.view = view
    }
    
    func push(contents controller: MainContentsViewController) {
        // TODO:
    }
    
    func popContents() {
        // TODO:
    }
}

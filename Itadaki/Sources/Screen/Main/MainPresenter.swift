// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

protocol MainPresentable: class {
    
    func push(contents controller: MainContentsViewController)
    func push(control controller: MainControlViewController)
    func popContents()
    func popControl()
}

protocol MainViewable: class {
    
}

class MainPresenter: MainPresentable {
    
    weak var view: MainViewable!
    
    private var contentsControllers = [MainContentsViewController]()
    private var controlControllers = [MainControlViewController]()
    
    init(view: MainViewable) {
        self.view = view
    }
    
    func push(contents controller: MainContentsViewController) {
        // TODO:
    }
    
    func push(control controller: MainControlViewController) {
        // TODO:
    }
    
    func popContents() {
        // TODO:
    }
    
    func popControl() {
        // TODO:
    }
}

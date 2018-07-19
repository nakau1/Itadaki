// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

protocol MainPresentable: class {
    
    func push(contents controller: MainContentsViewController)
    func popContents()
    func fetchContentsViews() -> [UIView]
}

protocol MainViewable: class {
    
    func showPushedContentsView(_ contentsView: UIView)
    func hidePoppedContents(_ contentsView: UIView)
}

class MainPresenter: MainPresentable {
    
    weak var view: MainViewable!
    
    private var contentsControllers = [MainContentsViewController]()
    
    init(view: MainViewable) {
        self.view = view
    }
    
    func push(contents controller: MainContentsViewController) {
        contentsControllers.append(controller)
        view.showPushedContentsView(controller.view)
    }
    
    func popContents() {
        if let poppedContents = contentsControllers.popLast() {
            view.hidePoppedContents(poppedContents.view)
        }
    }
    
    func fetchContentsViews() -> [UIView] {
        return contentsControllers.map { $0.view }
    }
}

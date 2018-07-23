// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class GameMessageViewController: MainContentsViewController {
    
    private var presenter: GameMessagePresentable!

    class func create() -> MainContentsViewController {
        let vc = instantiate(self)
        vc.presenter = GameMessagePresenter(view: vc)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
    }
}

extension GameMessageViewController: GameMessageViewable {
    
}

// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class LaunchViewController: UIViewController {
    
    private var presenter: LaunchPresentable!
    
    class func create() -> UIViewController {
        let vc = instantiate(self)
        vc.presenter = LaunchPresenter(view: vc)
        return vc
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.executeLaunching()
    }
}

extension LaunchViewController: LaunchViewable {
    
    func showResultExecuteLaunching() {
        present(crossDissolve: TopViewController.create())
    }
}

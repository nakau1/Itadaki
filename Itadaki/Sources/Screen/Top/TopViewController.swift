// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class TopViewController: UIViewController {
    
    private var presenter: TopPresentable!
    private var adapter: TopAdapter!
    
    class func create() -> UIViewController {
        let vc = instantiate(self)
        vc.presenter = TopPresenter(view: vc)
        vc.adapter = TopAdapter(delegate: vc)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TopViewController: TopViewable {
    
}

extension TopViewController: TopAdapterDelegate {
    
}

// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class WallpaperViewController: UIViewController {
    
    private var presenter: WallpaperPresentable!
    private var adapter: WallpaperAdapter!
    
    class func create() -> UIViewController {
        let vc = instantiate(self)
        vc.presenter = WallpaperPresenter(view: vc)
        vc.adapter = WallpaperAdapter(delegate: vc)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension WallpaperViewController: WallpaperViewable {
    
}

extension WallpaperViewController: WallpaperAdapterDelegate {
    
}

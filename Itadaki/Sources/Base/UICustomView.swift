// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class UICustomView: UIView {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        let className = String(describing: type(of: self))
        let view = Bundle.main.loadNibNamed(className, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        viewDidLoad()
    }
    
    func viewDidLoad() {}
}

// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class MainViewController: UILayoutViewController {
    
    private let animationDuration: TimeInterval = 0.1
    
    private var presenter: MainPresentable!
    private var animate = true
    
    @IBOutlet private weak var areaContents: UIView!
    
    private var contentsFrame: CGRect!
    
    class func create(initialContents contents: MainContentsViewController) -> UIViewController {
        let vc = instantiate(self)
        vc.presenter = MainPresenter(view: vc)
        vc.push(contents: contents, animate: false)
        return vc
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        contentsFrame = areaContents.bounds
        showAllPushedContentsViews()
    }
    
    func push(contents controller: MainContentsViewController, animate: Bool = true) {
        self.animate = animate
        controller.main = self
        presenter.push(contents: controller)
    }
    
    func popContents(animate: Bool = true) {
        self.animate = animate
        presenter.popContents()
    }
    
    private func showAllPushedContentsViews() {
        presenter.fetchContentsViews().forEach { contentsView in
            if contentsView.parent == nil {
                contentsView.frame = contentsFrame
                contentsView.parent = areaContents
            }
        }
    }
}

extension MainViewController: MainViewable {
    
    func showPushedContentsView(_ contentsView: UIView) {
        if !isViewLoaded || contentsFrame == nil { return }
        
        contentsView.frame = contentsFrame
        if animate {
            contentsView.alpha = 0
        }
        
        contentsView.parent = areaContents
        if animate {
            UIView.animate(withDuration: animationDuration) {
                contentsView.alpha = 1
            }
        }
    }
    
    func hidePoppedContents(_ contentsView: UIView) {
        if animate {
            UIView.animate(withDuration: animationDuration, animations: {
                contentsView.alpha = 0
            }, completion: { _ in
                contentsView.parent = nil
            })
        } else {
            contentsView.parent = nil
        }
    }
}

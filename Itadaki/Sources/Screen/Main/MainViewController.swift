// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class MainViewController: UILayoutViewController {
    
    private let animationDuration: TimeInterval = 0.1
    
    private var presenter: MainPresentable!
    
    @IBOutlet private weak var areaContents: UIView!
    
    private var contentsControllers = [MainContentsViewController]()
    
    private var contentsFrame: CGRect!
    
    class func create(initialContents contents: MainContentsViewController) -> UIViewController {
        let vc = instantiate(self)
        vc.presenter = MainPresenter(view: vc)
        vc.push(contents: contents)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        contentsFrame = areaContents.bounds
        presentPushedControllers()
    }
    
    func push(contents controller: MainContentsViewController, animate: Bool = true) {
        controller.main = self
        contentsControllers.append(controller)
        
        if contentsFrame == nil { return }
        
        controller.view.frame = contentsFrame
        if animate {
            controller.view.alpha = 0
        }
        
        controller.view.parent = areaContents
        if animate {
            UIView.animate(withDuration: animationDuration) {
                controller.view.alpha = 1
            }
        }
    }
    
    func popContents(animate: Bool = true) {
        guard let poped = contentsControllers.popLast() else { return }
        
        if animate {
            UIView.animate(withDuration: animationDuration, animations: {
                poped.view.alpha = 0
            }, completion: { _ in
                poped.view.removeFromSuperview()
            })
        } else {
            poped.view.removeFromSuperview()
        }
    }
    
    private func presentPushedControllers() {
        contentsControllers.forEach { controller in
            if controller.view.parent == nil {
                controller.view.frame = contentsFrame
                controller.view.parent = areaContents
            }
        }
    }
}

extension MainViewController: MainViewable {
    
}

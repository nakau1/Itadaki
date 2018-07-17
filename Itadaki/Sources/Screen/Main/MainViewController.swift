// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class MainViewController: UILayoutViewController {
    
    private let animationDuration: TimeInterval = 0.1
    
    private var presenter: MainPresentable!
    
    @IBOutlet private weak var areaContents: UIView!
    @IBOutlet private weak var areaControl: UIView!
    
    private var contentsControllers = [MainContentsViewController]()
    private var controlControllers = [MainControlViewController]()
    
    private var contentsFrame: CGRect!
    private var controlFrame: CGRect!
    
    class func create() -> UIViewController {
        let vc = instantiate(self)
        vc.presenter = MainPresenter(view: vc)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        push(contents: GameMainViewController.create(), animate: false)
        push(control: GameTrainControlViewController.create(), animate: false)
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        contentsFrame = areaContents.bounds
        controlFrame = areaControl.bounds
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
    
    func push(control controller: MainControlViewController, animate: Bool = true) {
        controller.main = self
        controlControllers.append(controller)
        
        if controlFrame == nil { return }
        
        controller.view.frame = controlFrame
        if animate {
            controller.view.alpha = 0
        }
        
        controller.view.parent = areaControl
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
    
    func popControl(animate: Bool = true) {
        guard let poped = controlControllers.popLast() else { return }
        
        if animate {
            UIView.animate(withDuration: animationDuration) {
                poped.view.removeFromSuperview()
            }
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
        controlControllers.forEach { controller in
            if controller.view.parent == nil {
                controller.view.frame = controlFrame
                controller.view.parent = areaControl
            }
        }
    }
}

extension MainViewController: MainViewable {
    
}

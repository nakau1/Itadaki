// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class MainViewController: UIViewController {
    
    private var presenter: MainPresentable!
    
    @IBOutlet private weak var areaContents: UIView!
    @IBOutlet private weak var areaControl: UIView!
    
    private var contentsController: UIViewController!
    private var controlController: UIViewController!
    
    private var contentsFrame: CGRect!
    private var controlFrame: CGRect!
    
    class func create() -> UIViewController {
        let vc = instantiate(self)
        vc.presenter = MainPresenter(view: vc)
        return vc
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if contentsFrame == nil {
            contentsFrame = areaContents.bounds
            changeContents(GameMainViewController.create())
        }
        if controlFrame == nil {
            controlFrame = areaControl.bounds
            changeControl(GameTrainControlViewController.create())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func changeContents(_ contentsController: UIViewController) {
        self.contentsController = contentsController
        areaContents.addSubview(contentsController.view)
        contentsController.view.frame = contentsFrame
    }
    
    func changeControl(_ controlController: UIViewController) {
        self.controlController = controlController
        areaControl.addSubview(controlController.view)
        controlController.view.frame = controlFrame
    }
}

extension MainViewController: MainViewable {
    
}

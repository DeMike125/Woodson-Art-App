import Foundation
import UIKit
import QuartzCore

class CustomNavController: UINavigationController
{
    static let defaultTransition:CATransition = CATransition()
    static let defaultTransitionDuration = 0.15
   
    override init(rootViewController: UIViewController)
    {
        super.init(rootViewController: rootViewController)
        CustomNavController.defaultTransition.duration = CustomNavController.defaultTransitionDuration
        CustomNavController.defaultTransition.type = kCATransitionFade
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        CustomNavController.defaultTransition.duration = CustomNavController.defaultTransitionDuration
        CustomNavController.defaultTransition.type = kCATransitionFade
    }
    
    override func popViewController(animated: Bool) -> UIViewController?
    {
        self.view.layer.add(CustomNavController.defaultTransition, forKey: "kCATransition")
        return super.popViewController(animated: false)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool)
    {
        self.view.layer.add(CustomNavController.defaultTransition, forKey: "kCATransition")
        return super.pushViewController(viewController, animated: false)
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask
    {
        return topViewController!.supportedInterfaceOrientations
    }
    
    override var shouldAutorotate : Bool
    {
       return true
    }
}

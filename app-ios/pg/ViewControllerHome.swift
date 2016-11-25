import UIKit

class ViewControllerHome : UIViewController
{
    override func prepare(for segue: UIStoryboardSegue, sender: Any!)
    {
        super.prepare(for: segue, sender: sender)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override var prefersStatusBarHidden : Bool
    {
        return true
    }
    
    override var shouldAutorotate : Bool
    {
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask
    {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
        {
            return UIInterfaceOrientationMask.allButUpsideDown
        }
        else
        {
            return [UIInterfaceOrientationMask.portrait, UIInterfaceOrientationMask.portraitUpsideDown]
        }
    }
}
